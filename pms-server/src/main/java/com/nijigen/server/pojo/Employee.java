package com.nijigen.server.pojo;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * <p>
 *
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-25
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@ApiModel(value="Employee对象", description="")
public class Employee implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "员工编号")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty(value = "员工姓名")
    @Excel(name = "员工姓名")
    private String name;

    @ApiModelProperty(value = "性别")
    @Excel(name = "员工性别")
    private String gender;

    @ApiModelProperty(value = "出生日期")
    @Excel(name = "出生日期", width = 20, format = "yyyy-MM-dd")
    private LocalDate birthday;

    @ApiModelProperty(value = "身份证号")
    @TableField("id_card")
    @Excel(name = "身份证号", width = 30)
    private String idCard;

    @ApiModelProperty(value = "婚姻状况")
    private String wedlock;

    @ApiModelProperty(value = "民族")
    @TableField("nation_id")
    @Excel(name = "民族", width = 40)
    private Integer nationId;

    @ApiModelProperty(value = "籍贯")
    @TableField("native_place")
    @Excel(name = "籍贯")
    private String nativePlace;

    @ApiModelProperty(value = "政治面貌")
    @TableField("politic_id")
    @Excel(name = "现居地址", width = 40)
    private Integer politicId;

    @ApiModelProperty(value = "邮箱")
    @Excel(name = "邮箱", width = 30)
    private String email;

    @ApiModelProperty(value = "电话号码")
    @Excel(name = "电话号码", width = 15)
    private String phone;

    @ApiModelProperty(value = "现居地址")
    @Excel(name = "现居地址", width = 40)
    private String address;

    @ApiModelProperty(value = "所属部门ID")
    @TableField("department_id")
    @Excel(name = "所属部门号", width = 40)
    private Integer departmentId;

    @ApiModelProperty(value = "职称ID")
    @TableField("job_level_id")
    @Excel(name = "职称号", width = 40)
    private Integer jobLevelId;

    @ApiModelProperty(value = "职位ID")
    @TableField("position_id")
    @Excel(name = "职位号", width = 40)
    private Integer positionId;

    @ApiModelProperty(value = "聘用形式")
    @Excel(name = "聘用形式")
    @TableField("engage_form")
    private String engageForm;

    @ApiModelProperty(value = "最高学历")
    @TableField("tiptop_degree")
    @Excel(name = "最高学历")
    private String tiptopDegree;

    @ApiModelProperty(value = "所属专业")
    @Excel(name = "所属专业")
    private String specialty;

    @ApiModelProperty(value = "毕业院校")
    @Excel(name = "毕业院校", width = 20)
    private String university;

    @ApiModelProperty(value = "入职日期")
    @TableField("begin_date")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @Excel(name = "入职日期", width = 20, format = "yyyy-MM-dd")
    private LocalDate beginDate;

    @ApiModelProperty(value = "在职状态")
    @TableField("work_state")
    @Excel(name = "在职状态")
    private String workState;

    @ApiModelProperty(value = "转正日期")
    @TableField("conversion_date")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @Excel(name = "转正日期", width = 20, format = "yyyy-MM-dd")
    private LocalDate conversionDate;

    @ApiModelProperty(value = "离职日期")
    @TableField("leave_date")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Shanghai")
    @Excel(name = "离职日期", width = 20, format = "yyyy-MM-dd")
    private LocalDate leaveDate;

    @ApiModelProperty(value = "民族名称")
    @TableField(exist = false)
    private Nation nation;

    @ApiModelProperty(value = "政治面貌名称")
    @TableField(exist = false)
    private PoliticsStatus politicsStatus;

    @ApiModelProperty(value = "部门名称")
    @TableField(exist = false)
    private Department department;

    @ApiModelProperty(value = "职位名称")
    @TableField(exist = false)
    private Position position;

    @ApiModelProperty(value = "职称名称")
    @TableField(exist = false)
    private JobLevel jobLevel;

}
