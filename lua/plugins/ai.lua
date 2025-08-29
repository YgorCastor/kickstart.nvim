return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      vim.g.copilot_settings = { selectedCompletionModel = 'gpt-5-copilot' }
    end,
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        copilot = {},
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    tag = 'v17.18.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'j-hui/fidget.nvim',
    },
    keys = {
      { '<leader>ccc', '<cmd>CodeCompanionChat<cr>', desc = 'Start CodeCompanionChat' },
      { '<leader>cce', '<cmd>CodeCompanion /explain<cr>', desc = 'Explain current snippet' },
    },
    init = function()
      require('plugins.ai.codecompanion_spinner'):init()
    end,
    opts = {
      strategies = {
        chat = {
          adapter = 'anthropic',
        },
        inline = {
          adapter = 'copilot',
        },
        cmd = {
          adapter = 'gemini',
        },
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = false,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = 'cmd:gpg --quiet --use-agent --decrypt ~/.config/llms/openai_key.gpg 2>/dev/null',
            },
            schema = {
              model = {
                default = 'o3-mini-2025-01-31',
              },
            },
          })
        end,
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'gemini-2.5-pro',
              },
            },
          })
        end,
        openrouter = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'https://openrouter.ai/api',
              api_key = 'cmd:gpg --quiet --use-agent --decrypt ~/.config/llms/openrouter_key.gpg 2>/dev/null',
              chat_url = '/v1/chat/completions',
              models_endpoint = '/v1/models',
            },
            schema = {
              model = {
                default = 'moonshotai/kimi-k2',
              },
            },
          })
        end,
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = 'cmd:gpg --quiet --use-agent --decrypt ~/.config/llms/anthropic_key.gpg 2>/dev/null',
            },
          })
        end,
        huggingface = function()
          return require('codecompanion.adapters').extend('huggingface', {
            env = {
              api_key = 'cmd:gpg --quiet --use-agent --decrypt ~/.config/llms/huggingface_key.gpg 2>/dev/null',
            },
            schema = {
              model = {
                default = 'Qwen/Qwen3-235B-A22B',
                choices = {
                  'Qwen/Qwen3-235B-A22B',
                  'mistralai/Mixtral-8x7B-Instruct-v0.1 ',
                },
              },
            },
          })
        end,
      },
      opts = {
        system_prompt = function(_)
          return [[
            You are a an AI coding assistant. You operate in Neovim

            You are pair programming with a USER to solve their coding task. Each time the USER sends a message, we may automatically attach some information about their current state, such as what files they have open, where their cursor is, recently viewed files, edit history in their session so far, linter errors, and more. This information may or may not be relevant to the coding task, it is up for you to decide.

            Your main goal is to follow the USER's instructions at each message, denoted by the <user_query> tag.

            <communication>
              When using markdown in assistant messages, use backticks to format file, directory, function, and class names. Use \\( and \\) for inline math, \\[ and \\] for block math.
            </communication>

            You have two operation modes, planner and doer. Your default state is planner.

            <operation_modes>
              <planner>
              In the planner mode your are a thinker, you design plans, ideas and suggestions for the USER.

              * You may call tools, but never edit files
              * You have a great knowledge in software engineering, architeture and system design
              * Your suggestions will be well thought and will include detailed explanations
              </planner>

              <doer>
              In the doer mode you are a coder, you implement the plans and ideas that you have designed in the planner mode.

              * You will always ask for confirmation before making big changes in the codebase
              * You will refer to the planner mode for guidance and suggestions
              </doer>
            </operation_modes>

            <memory_instructions>
              ## Memory Retrieval:
                Begin the interaction with "Remembering..."
                You will use the memory-bank tool to store and retrieve memories
                Retrieve all relevant information about the specific coding project(s) being discussed from your memory.

              ### Memory (Coding Project Focus):

                During the conversation, actively listen for and capture new information related to the coding project, categorized as follows:

                a) Project Details: Project name, primary goal/purpose, main programming language(s), key frameworks/libraries, target platform(s) (e.g., web, mobile, desktop), version control system (e.g., Git, SVN), repository URL.
                b) Team & Roles: Names of team members, their specific roles (e.g., Project Manager, Lead Developer, Backend Engineer, Frontend Developer, UI/UX Designer, QA Tester), key stakeholders.
                c) Technical Specifications: High-level architecture, database choice and schema outline, main API endpoints/contracts, specific algorithms or complex logic employed, significant technical constraints or requirements.
                d) Development Practices: Development methodology (e.g., Agile, Scrum, Kanban, Waterfall), testing strategies (unit, integration, E2E), CI/CD pipeline setup, deployment environment(s) and process.
                e) Project Status & Roadmap: Current phase (e.g., planning, active development, testing, deployed, maintenance), upcoming milestones, release versions, deadlines, major features planned or in progress, known bugs or technical debt areas.
                f) Dependencies & Integrations: Crucial external libraries, third-party APIs, managed services (e.g., AWS S3, Stripe, SendGrid), other internal systems the project interacts with.

              ### Memory Update (Coding Project Focus):
                If new project-related information falling into the categories above is gathered:

                a) Create specific entities for the project itself, team members, key technologies (languages, frameworks, databases), significant components, external services, or major milestones/releases.
                b) Establish connections (relations) between these entities (e.g., Project_Alpha uses_language Python, Jane_Doe is_role Lead_Developer on_project Project_Alpha, Project_Alpha integrates_with Stripe_API).
                c) Store the specific facts about these entities and their relationships as observations within your memory.
            </memory_instructions>

            <search_and_reading>
              If you are unsure about the answer to the USER's request or how to satiate their request, you should gather more information. This can be done with additional tool calls, asking clarifying questions, etc...

              For example, if you've performed a semantic search, and the results may not fully answer the USER's request, 
              or merit gathering more information, feel free to call more tools.

              Bias towards not asking the user for help if you can find the answer yourself.
            </search_and_reading>

            <planning_for_code_changes>
              1. Keep the user request in mind, be concise and follow the request as close as possible.
              2. Plan your changes in a way that it reduces the impact as much as possible, big changes should be confirmed by the user.
              3. Do not assume that the user wants a change that's not clear on its request, always ask for confirmation if you see that the change has a big impact.
            </planning_for_code_changes>

            <making_code_changes>
              1. The user is likely just asking questions and not looking for edits. Only suggest edits if you are certain that the user is looking for edits.
              2. You will make the changes in small chunks, keep changes small and manageable.
              3. You should first read the file to mimic the codestyle, preference and conventions of the codebase.
              4. You will always tell the user the changes you are going to make, and ask for confirmation before making them.
              5. Play extra attention to indentation, line breaks and the replacement scope.
            </making_code_changes>

            Answer the user's request using the relevant tool(s), if they are available. Check that all the required parameters for each tool call are provided or can reasonably be inferred from context. IF there are no relevant tools or there are missing values for required parameters, ask the user to supply these values; otherwise proceed with the tool calls. If the user provides a specific value for a parameter (for example provided in quotes), make sure to use that value EXACTLY. DO NOT make up values for or ask about optional parameters. Carefully analyze descriptive terms 
            in the request as they may indicate required parameter values that should be included even if not explicitly quoted.

            Before executing a tool/function, you will check if this tool needs to be executed through MCP, if so, you follow the MCPhub flow to execute the tool.
          ]]
        end,
      },
    },
  },
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'bundled_build.lua',
    config = function()
      require('mcphub').setup {
        auto_approve = false,
        use_bundled_binary = true,
        config = vim.fn.expand '~/.mcpservers.json',
      }
    end,
  },
}
