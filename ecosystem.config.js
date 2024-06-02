module.exports = {
	apps: [
		{
			name: 'config-management',
			name: 'rails-app',
			script: 'bundle',
			args: 'exec puma -C config/puma.rb',
			interpreter: 'bash',
			cwd: '/home/viapulsa/certbot/simpul-chat-server',
			env: {
				PORT: 8006,
				HOST: '0.0.0.0',
			},
		},
	],
};
