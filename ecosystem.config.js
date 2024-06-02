module.exports = {
	apps: [
		{
			name: 'config-management',
			script: './start.sh',
			interpreter: 'bash',
			instances: 1,
			autorestart: true,
			watch: false,
			max_memory_restart: '1G',
			env: {
				PORT: 8006,
				HOST: '0.0.0.0',
			},
		},
	],
};
