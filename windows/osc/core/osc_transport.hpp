#pragma once
#include <string>
#include <vector>

namespace osc_ubct::osc::core {

struct SenderSettings; // forward

struct OscArg {
  enum class Type { Float, Int, Bool, String } type;
  float       f{};
  int32_t     i{};
  bool        b{};
  std::string s;

  static OscArg FromFloat(float v)          { OscArg a; a.type = Type::Float;  a.f = v; return a; }
  static OscArg FromInt(int32_t v)          { OscArg a; a.type = Type::Int;    a.i = v; return a; }
  static OscArg FromBool(bool v)            { OscArg a; a.type = Type::Bool;   a.b = v; return a; }
  static OscArg FromString(std::string v)   { OscArg a; a.type = Type::String; a.s = std::move(v); return a; }
};

bool SendSimple(const SenderSettings& s, const std::string& address);
bool SendWithArgs(const SenderSettings& s, const std::string& address,
                  const std::vector<OscArg>& args);

} // namespace osc_ubct::osc::core
