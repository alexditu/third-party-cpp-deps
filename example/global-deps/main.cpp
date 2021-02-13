#include <spdlog/spdlog.h>

int main()
{
	spdlog::set_level(spdlog::level::trace);
	spdlog::debug("hello world");

	return 0;
}