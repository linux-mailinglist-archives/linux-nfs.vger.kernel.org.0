Return-Path: <linux-nfs+bounces-658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F96815333
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 23:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2050B24D87
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16A30110;
	Fri, 15 Dec 2023 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSRc0gn7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qqOT8GVg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88418EC9
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK7t1F020310;
	Fri, 15 Dec 2023 21:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LztH4fZJC9AzNWIZUvVGMvzxvQtB9SlZLhc+jfG8TSY=;
 b=JSRc0gn7Ee52P9bJW4AD/epSjW9KcbDro91i+pgWHqtQZVcVaKaCr/Ml9SVsw0uRmsZ1
 wcVP5l2U1jxNcRun313PnxH9hE8XFrkuO2R5Rvd4oJpANOzB/x7+tSa8ZFxTQ7tbfu/3
 +yolblXRUIMtZN9o6YpfeznOOSxfI64moq9BOqnQ2X8lY+it/3weXMuVoQ7+G+tqXRIB
 KjUfDy5ZMlQJ75KTj5SiYBDIKMGNpziS+qqBhqkh5KoGRMIhUaffob/3qO7ZtGGS3BVV
 2NDAR3Ge8BnAnFAf3I1yuoa08jRTpmDwmRUNeJFUSCQdWUysBxmQelwJ8MQSo3t7LN1Z UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu2ebf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:55:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK5mWu016682;
	Fri, 15 Dec 2023 21:55:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcp7hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:55:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1Ip5PWyeYWWJxnKaguUgWH+EDW387uKeYuDBWRbvLv957w96cMDQevl9JWwXCwSDrjmArBHX9ps/1vFbAmNOQtVXVCJW4KWCjjDEvG3/rpdv4ilB40ivCqb8xETKgTq5Pohg5nWqYblw2Fr7oJHD9ordHooS3546Xp9g7rxSLV/DaXPu9oDX2tNtNAtjdEhNjayL3V2TphJiiWoGimI/FFoeXk6r/+zWX1ymPnlLnlfMN4IW4FlY55cSu36WStul8pYJRzt+5n33bEkRdVSCf7drmKB2XYrVK7vdlG/552UIxFcAY6jOorO6XVXHUX7UbwlShhp08X4wz76evAGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LztH4fZJC9AzNWIZUvVGMvzxvQtB9SlZLhc+jfG8TSY=;
 b=PhfI8RkoIiD2vraApvdzo9VMk7p0gjwitpZUpXlJqRJaSxrAwkMTkDz6gEQjA89V806FugSa4YB9y//m3vYtXmXSiZFeEmYOlxG6ULN+e+Rq3ZY4hmpwkuVTzEOtc/X7U4icwv55ps49J4OqE2RsuX6LGC3eIKyJcy+T1qaQ7DxHC+0tzXbUhd1o87hj7MguU2RD2ixJjL8IhmTxFkHV8l6OGBw7DA+LQ0u32/TCxnitfvoSH6qmtzL7Oipp4GPfrMmkpMtVYqASfhYadkSFdxOQNLfIXByw1qyWy+6QywJm2tuYnD5yxRBikEKkKm/SZ/KsvfypounfRT+GuLivLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LztH4fZJC9AzNWIZUvVGMvzxvQtB9SlZLhc+jfG8TSY=;
 b=qqOT8GVgeaEfOuaKTo00slKFFXgU2in4UCoIhvMXv4gKpw84fZKvwz/RlQ0YJb7i2elxYtBU6FREiAqahEzvOgKzn4Fbif9Fkc4AXMc0s7NzqdWNEEv+rBTLwEVVcGbryf5OtQe0PQ+Bo83fAAW/nMPS0DH8Xg79f3sJ/q3Xat0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Fri, 15 Dec 2023 21:55:24 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 21:55:24 +0000
Message-ID: <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
Date: Fri, 15 Dec 2023 13:55:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b377ab6-1ae9-40df-1fc0-08dbfdb88a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F5YAq3w2DAekVj+UnN45OXmqGBsR3Xe2ugfxGJoBAaFOsACvbHgobR3ajInMaeVOCnNytv2ar3rGT7bPuObnjGhbmIrCrEY2Pci851zXAtqlQVQyC15JHI4wRWUv8wk8veY+HVjqPoWCR4G+wcI9wLYkoc5rzoFuaE9cqMCa5MueOrhHtSf0fYREvmI6RjnonQVMEJrBZotrAO9rIpTCXMUB0rmugOys+Xrz7o26Nj5JKSP9mXNtRjTpJ4NlsuJYlEY9AuirBqGJjv5qctVuwgSmndbEUvftaqqGa1HewXoiZC5WFB4vPINlaxqdLKLMVec1MgpbG00dADwX9M0d7MN95TAp/2PpTEy4xrZUMgvd6Dfvw6COam4wvs+/poe5sEBNaY2zYJF0gIJw46LsJNZ1lKQZ86nyJLCgrA82HBDgKrglzzbmIg/dUizpRylYAPdX+KPSh3MZIY6qa6MpNCup22cKFZtx9BKYCMZ82IBf0HGlXT+9hykXd6vpz9hM951u3M1kytBdjDsnZzUlo2DRbQ8er9G9rpE4xEa/EjFRRRIvkCOZGS8rR4ZicH0trwZUf9lfz745nPT8fhSRXx31QtYLXzOYWQeC9dgbPrTaOTzoUB+GvfsKUlZBJ8a/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2616005)(26005)(9686003)(6666004)(6512007)(6506007)(86362001)(36756003)(31696002)(38100700002)(5660300002)(8936002)(8676002)(6862004)(4326008)(66476007)(83380400001)(53546011)(37006003)(66946007)(66556008)(41300700001)(2906002)(316002)(478600001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjNnZG45WnYrQXc2M0JuUm5LY3R1Vy9qWjFYK05TUWQwWnJZWjc0c0RJV1dt?=
 =?utf-8?B?dllXb25ISk5XcVoxWE5sNmNyTXpGRnV5clZwL0JaM0dEN3U4SEV1TE5wRXQ3?=
 =?utf-8?B?d1Q0cVgvcE9TMG5FMDkwYlRRUTVhS2dYZTJCVHpwQW4wL1hpTU0wR0NsWHky?=
 =?utf-8?B?dEZFU0hVeGY4M3hMWExKTGtXQzNPTUFtclNIMEJqdmlhSHJtVHdlUXJLRDZO?=
 =?utf-8?B?ZVNoNzJNUFBVdk9rVkFPNys3eHkyek5xL0NGMjBNNU9xM1pZZCttMFRMMUxx?=
 =?utf-8?B?cVNZZkZ6WTRXSDJNdERWQWdleEpCWE1WNUYvdGxNL243cGV2NEY3UzhRSzJm?=
 =?utf-8?B?TzQ5bWdLNDRURWN0VmxRSlNPdFJSSG0yb3lQYjVEbnNCRStXdmhTdEF0Mzht?=
 =?utf-8?B?cDRYMkJLNmRoR3RYMnZSbU5oZHZ5c2tudnRVOGlDaWhHWnZwc3BIQ3FpNmt6?=
 =?utf-8?B?ODc2YzNpczh6d3I5OTRneVFNaDJ0cmtkeGdSNnZaWFRzZnEvK2wyRm5DOWtr?=
 =?utf-8?B?MHllcmtHaUFVdHE5b0tpbFZPSUQ0VVE5R0NCbThPRjE0Lzd6ZHo1T09MR2VX?=
 =?utf-8?B?VVg0S3NZcXJHS0Y2Yjl5Zy8yZGl3c0Y5RmpRcHhpa2Q3c0FPTWR0NzNWbHN0?=
 =?utf-8?B?anNHMXVKTzU2TnFCeFpaaXBOSHdEWE9vZ3ZIZmJMajBVS0s4KytxNFFPbm9K?=
 =?utf-8?B?ZWxUVVYwRUFSWXlHN2FtTTJwNzBHNGd5K2ptWE13K3hVYzlVTSt2VWVsTzF2?=
 =?utf-8?B?OE1DVCs1NG5FNUNBYzljeXhabmJLMkVpcnM2K2owVDlKRklhdnNHVkFRZ1ND?=
 =?utf-8?B?NUtnMEF2aEVvbG9Td1UvVVJOYnRFYnJwZEh1NTI5dWZUUm50UVFKVlpSdHFI?=
 =?utf-8?B?VHBvdW90REFGTkhUUlpaclc4L0tCODlFRjREZEJUU1JVREpiUDlSNmVKSzNS?=
 =?utf-8?B?TkFXeTZicUFZZXRZYitRSGxRblYzZTU1MktVekRoYzlSTnVxZVhXUE5uemFP?=
 =?utf-8?B?UklTbDVlRmFDNG03T0tkZVkrdXZtZ3IvQWQyRHN3K01sQlRtZDdEOEd6MTlv?=
 =?utf-8?B?M2ZJQlRoc2dEbklhbnZPY01wTk45UzROVk9lbWlFWjk2UEtDcmtaZkNkM1c1?=
 =?utf-8?B?TW1vYkF0eko4Q3JqMXVCUEt4Q1BGSW0rWTMvaGh6YlJidkRlMWthcXFja3Yx?=
 =?utf-8?B?NFlaR2VBRnd1ZVB0dGpYZkN2eHdxU1J3L0hEeENKWng0Vm1aZGN5TjRBL2ZB?=
 =?utf-8?B?WTZNbExRdllxbGJpS2dDN24zbzJTcDcvRUx1eDVrWlNMR2xzNHBqMzQvQ1g3?=
 =?utf-8?B?VXNCWlRPVWpEd1dhQWV1UXF5SUJRdDVBOXFoOXZ4ck9jTmJaWkhaVU1WZzAw?=
 =?utf-8?B?eU9JYVlHakdCamFDRXdmN3U0cTlPTWgzOURmNTVFTjFnUlF4OTYycW5kWVpz?=
 =?utf-8?B?SHQ2VmVZaEpZMTE2MmlxNVFLZHdHenNOdFJYaSswbHNvNzhGbTROQURWdWRR?=
 =?utf-8?B?TkQwK3dNcGdScS81UmNWTTZFaXBRV1YxZXBqMUFIcWNoaDlzUE1DZU10UW45?=
 =?utf-8?B?ekNIVEZmMFNFUHRCZEt1U3pVWEx6eTMzS2JWbjNwN0V1WDkwdEo5SXppZEVZ?=
 =?utf-8?B?TlVrUFI3TEpVNm16U1A4WmZaQlkxcWFLN2hlNzlhZHNhaVNtbEVsSHpHZGF2?=
 =?utf-8?B?U1M1NjFUVCs1Y2NSZ2VrTlAzMTZSZTVGTWxkUW4zSGlkckdsU1VTcFFoZGNM?=
 =?utf-8?B?QkpFV1J1NDlkSHJ2b2hDL1YyanlONCtUV0lQSVRieDhVWEJINVdyYjg1Mncw?=
 =?utf-8?B?aGJCcnIvZDhQVFA3cXVxQXZPV2E1K25icTNRR1ZOeUpjNzJRTm0rNVJxd0lU?=
 =?utf-8?B?U01ncTJubGhRWEN6WFRrRG1mY3M3aVdlbWxQbjQwZXVnbFFvVytsZStDcGg1?=
 =?utf-8?B?YjRNZE80eUd3R2Y5VG9FNytTdFV3VkF4MkdGQnVDQ0VKUzBPNFM0UzFQdXlQ?=
 =?utf-8?B?dGkyL2lqN3M4NG05cDU0ZFovbzFsQVQ3dEhNTVU0WTRIRUsrU3B3dDZkZzgr?=
 =?utf-8?B?MDhUd1FuL2NYbWlpeDJ6MUpka1lEVStYb3o4SjRBSTAxZm5kR0hXeWRRMzBL?=
 =?utf-8?Q?ZbxD2E+US+OBTiVZRrWZ9nu0a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wVzZua34mssQIHztQ9dxB3OUPM4LgJHzmm/CZ6wp/3sIkCsiVqw5Cq1u8+gLeX1IHHhiB+pLsQ8M2DEjH7jPE/1Tn6+4d+k4dOD7SfwJqZqNmcJT5ZRakkKnf37xrszGkyyfUis8YTqXjjockeFp0qjvvR3zjTtjz4c0mI49J9rGQGkD3E9zdUVleihOEAGtTI+VqVxluytSR86KfsiBmlMbun+LvwhwbF+eC8JXSCULOfCSS4wkcB0LgjIYCotf4S/GHj0A/teHkpqZiSCVcMKGhsI0euPLVAx9GSCSFzs3qsZtxwNMayJrXVh4fCXHvb72YezICq0dsh4D9yekBSa1/XArDkmwt1pYbxny6PWUB3g6bP9HRHdK3rHp4Bj0My/HMYjEHP5jeCj9rFFEU+F2jxPlEctGgE56vS0xTTpozcHCxxADyHybl35fktmyKxvcAgpFZ1WVxykBoZBA+K0N9LuZPAtxhXOKSVuimjGzjdG4wLKe1pbRinHboARYUBBMrXX++WhCCfdmkpPUgfpzz1Wrm5CE8ScMRqVEeiYULztOLEf16V0C1IKhXLn+JMjTzabeB+Jo28IA8nWVDRep3c7dbCDxPtmD5Ots5Lc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b377ab6-1ae9-40df-1fc0-08dbfdb88a61
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 21:55:24.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0Ti5kBlgKE4HKCeel4GSXc8MXKNUQMdymWwUC1BCtD8IpStNYB79RGg8H8AtskcvwCACE8zIlaqa/0hPytFBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150153
X-Proofpoint-ORIG-GUID: bEOnVJHOmiHEkNkTcjJ8aIr9vpKzWE9p
X-Proofpoint-GUID: bEOnVJHOmiHEkNkTcjJ8aIr9vpKzWE9p

Sorry Chuck, I didn't see this before sending v2.

On 12/15/23 1:41 PM, Chuck Lever wrote:
> On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
>> On 12/15/23 11:54 AM, Chuck Lever wrote:
>>> On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
>>>> If the callback workqueue is stuck, nfsd4_deleg_getattr_conflict will
>>>> also stuck waiting for the callback request to be executed. This causes
>>>> the client to hang waiting for the reply of the GETATTR and also causes
>>>> the reboot of the NFS server to hang due to the pending NFS request.
>>>>
>>>> Fix by replacing wait_on_bit with wait_on_bit_timeout with 20 seconds
>>>> time out.
>>>>
>>>> Reported-by: Wolfgang Walter <linux-nfs@stwm.de>
>>>> Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    fs/nfsd/nfs4state.c | 6 +++++-
>>>>    fs/nfsd/state.h     | 2 ++
>>>>    2 files changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 175f3e9f5822..0cc7d4953807 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -2948,6 +2948,9 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>>>>    	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>>>>    		return;
>>>> +	/* set to proper status when nfsd4_cb_getattr_done runs */
>>>> +	ncf->ncf_cb_status = NFS4ERR_IO;
>>>> +
>>>>    	refcount_inc(&dp->dl_stid.sc_count);
>>>>    	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
>>>>    		refcount_dec(&dp->dl_stid.sc_count);
>>>> @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
>>>>    			nfs4_cb_getattr(&dp->dl_cb_fattr);
>>>>    			spin_unlock(&ctx->flc_lock);
>>>> -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>>>> +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
>>>> +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
>>> I'm still thinking the timeout here should be the same (or slightly
>>> longer than) the RPC retransmit timeout, rather than adding a new
>>> NFSD_CB_GETATTR_TIMEOUT macro.
>> The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
>> work item to the workqueue so RPC is not involved here.
> In the "RPC was sent successfully" case, there is an implicit
> assumption here that wait_on_bit_timeout() won't time out before the
> actual RPC CB_GETATTR timeout.
>
> You've chosen timeout values that happen to work, but there's
> nothing in this patch that ties the two timeout values together or
> in any other way documents this implicit assumption.

The timeout value was chosen to be greater then RPC callback receive
timeout. I can add this to the commit message.

>
>
>> We need to
>> time out here to prevent the client (that causes the conflict) to
>> hang waiting for the reply of the GETATTR and to prevent the server
>> reboot to hang due to a pending NFS request.
> Perhaps a better approach would be to not rely on a timeout, but
> instead have nfs4_cb_getattr() wake up the bit wait before
> returning, when it can't queue the work. That way, wait_on_bit()
> will return immediately in that case.

We can detect the condition where the work item can't be queue.
But I think we still need to use wait_on_bit_timeout since there
is no guarantee that the work will be executed even if it was
queued.

-Dai

>
>
>>>>    			if (ncf->ncf_cb_status) {
>>>>    				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>>>    				if (status != nfserr_jukebox ||
>>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>>> index f96eaa8e9413..94563a6813a6 100644
>>>> --- a/fs/nfsd/state.h
>>>> +++ b/fs/nfsd/state.h
>>>> @@ -135,6 +135,8 @@ struct nfs4_cb_fattr {
>>>>    /* bits for ncf_cb_flags */
>>>>    #define	CB_GETATTR_BUSY		0
>>>> +#define	NFSD_CB_GETATTR_TIMEOUT	msecs_to_jiffies(20000) /* 20 secs */
>>>> +
>>>>    /*
>>>>     * Represents a delegation stateid. The nfs4_client holds references to these
>>>>     * and they are put when it is being destroyed or when the delegation is
>>>> -- 
>>>> 2.39.3
>>>>

