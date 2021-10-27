package com.nijigen.server.pojo.VO;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * @author zhaolimin
 * @date 2021/10/27
 * @apiNote 离职员工报表vo
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LeaveEmployeeFormVO implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "员工编号")
    @Excel(name = "员工编号")
    private Integer id;

    @ApiModelProperty(value = "员工姓名")
    @Excel(name = "员工姓名")
    private String name;

    @ApiModelProperty(value = "性别")
    @Excel(name = "员工性别")
    private String gender;

    @ApiModelProperty(value = "入职日期")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @Excel(name = "离职日期", width = 20, format = "yyyy-MM-dd")
    private LocalDate leaveDate;

    @ApiModelProperty(value = "备注")
    private String remark;

    @ApiModelProperty(value = "部门名称")
    @Excel(name = "部门名称")
    private String deptName;

    @ApiModelProperty(value = "职位")
    @Excel(name = "职位")
    private String positionName;

}
