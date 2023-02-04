Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F168AC51
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Feb 2023 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBDUux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Feb 2023 15:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDUux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Feb 2023 15:50:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77213DE3
        for <linux-nfs@vger.kernel.org>; Sat,  4 Feb 2023 12:50:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3144FdPM006120;
        Sat, 4 Feb 2023 20:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Cyvsv8/Ua2sxJgufl2KSbylaBjnWC33huOksyEEs6nU=;
 b=rGOxFNFzxNJqJVF7dJwiLQwMK98EsM5LhncIq0B2SDgtN9e1GSC0tK/zwGF8EaHIkPLR
 hhK1FVVYwS40I23rUG2ICILiGFOyZGxCk2thzrnz84iThawNlXtnvdct3DSGNGMborHH
 5VhbAzdJf1ZLNTL5AQPpuzKm2ftIsX+hSmdecJIC0lychzEW/NXv1dJwv8YfifwS+9x7
 kpIc7e2oGXI+wpvmWilb1ya7Tt5kR4h5A0oA3N7NCDRWrYA2ZIFHd00zn/SbRKQOyO4D
 DyeQj9ixg9WpTFWBKWkP4dNho1978OXcL24EQAEIbqus6p/UPikSuUIsTwXa62xu4fb/ Eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdgs5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Feb 2023 20:50:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 314HWOuH028546;
        Sat, 4 Feb 2023 20:50:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt2k8ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Feb 2023 20:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/D+0NtwoBBZnz6LmjEgi1WN8bbNqzoCCjTsgKoJ7AVSIzN8m2ZoKIh7V3LLBn6Mne6Ib8DZBmOPbeZyWd/+hZdJUtqa6MoJrTaHxLSdciIUcagz5fI2KmhI1ixE0igcLs/JCxpxfLV/FpsfVVRGDw5xLHXHjBU/dSkLz7rFvxMfPHqNr/zcvQP/Zxg2AoCtDe7Od/8cRpjHBdKv/LiZhgjIBhv6Fw/ou4enKlK0ZRRpakmBfXMpBH5Nop7Qr+HAQsbX7vG+OmBvSY2tReFUiAXQjFkH0XMlB3lrwEGe+bfuuaYGRHhDo50DTks5swVhoyPkhvPFKon4Z2xGu1SVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cyvsv8/Ua2sxJgufl2KSbylaBjnWC33huOksyEEs6nU=;
 b=KFMN+6aze5OzllCFIlREA1V8xE7I0YLR+9rvKxVQBbzVMCH8AZtFLOhnnIYT6eBtWD0y4VUKm3OHlYDcj4FNqnnT72XzO48W68zfc8cCC48qfqYvMonbsVAQvA6uWDjOAvROADBnM3Zrv55FQ93sqkuEmNzYpqQGFSPtyekYnMoiS7pD7ghv12RsjLiS7cZpPNFsCLa7TSdc2p2MifJOik0tzgtq0l3zpxMB5x2/EbzFM4n1yOD1D0GpGVoajCbvfVumvM2CgwwZgxSKGDyisXNGk+e0u80rzgIrOQyUTs31k7q2XXcmJNoVODcXyHvbzcJh8ta8SElhsheypL5dCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyvsv8/Ua2sxJgufl2KSbylaBjnWC33huOksyEEs6nU=;
 b=PEEpJx1BpvPTD7Zryi0kitnyzZFJWCWi1XUqRiM+aMP9cnL2giRU1nWvzoXZOhC8Ek2XYxuGEiLu/BAxhVUoHwgZx5oK3nNv2yEg8aUrDWN/BCQbaZK2NZJFAMM7rt5JkM9WAgF6b38/En1iYtRXRicWp1AgbCF/2ey4kTHnEdM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW4PR10MB6372.namprd10.prod.outlook.com (2603:10b6:303:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.12; Sat, 4 Feb
 2023 20:50:38 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2280:b9da:9056:c68b%4]) with mapi id 15.20.6086.009; Sat, 4 Feb 2023
 20:50:37 +0000
Message-ID: <458a70c7-f5ba-4aea-158e-19f5a44d7a62@oracle.com>
Date:   Sat, 4 Feb 2023 12:50:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] nfsd: fix courtesy client with deny mode handling in
 nfs4_upgrade_open
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org,
        =?UTF-8?B?5by15pm66Ku6?= <cc85nod@gmail.com>
References: <20230203181834.58634-1-jlayton@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20230203181834.58634-1-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW4PR10MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4c7ea2-2943-4940-609c-08db06f17801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muek7zJiBvZR9JZ3rjevOYg4oKjpTK/0u6ZlMtQpYivv7joP5yNguyKFUU9ZM8Ls5GIR7czW9zy1X3DQYReADp4l018dumQLiWkZ5iW+tXwyx7X4wUUgDlyQrGfPImzBPE+79v/UfwwMbkqHjcm5fillo4iQo6E4XtkQjMdVMiblZMTqvPXtGEYumquxLdpEAS88Sewh50lZBhM/yMRLpu/wXkoW++if7KHsi/5aRirALRl3snbzPV6OSVUz2PfxCSAO1azzvESXU4xbmrL09JeNKOJaXM7Pijqyb8Iq4r1qNO7zZHuCbUcX7KLdFGcGa2hYn43wD/V4F9t3TwdSgwgxMHV6WiSpkVEgGe2CK4l/dnN3uQboanHAlAihWJ8tPjixpYpzuU89cISjcPun0jqW77UOS5HeJkerFXtbRlnDNeuoMZW+FwFnbyYxunipJuX/UTKTORwcuauUhw8c79NY6eJV2DoGz9cHmFcQn/OihSkUOGE+DY+dAe6tBeXj9CrWiZfgSPxuZwx9qI48xSrH6uJ3WarE2YjMRchwtr0SB5Z4f4pxa1jE115sykWDNGiB0/trVoPgYZWcAHf1m/jlFeNgeqw4Yft+3MU71KKiFh7vULMGCbOD/LfoSoxFHy/xzK1OpdBUnsqmhE3xAIIR9oxCib9T83RWVkUqttc3g5PmSYvDly2IoWbsLegkcTl20zPRhVtRGRZe5yYKuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(6486002)(6506007)(6666004)(478600001)(9686003)(2616005)(31686004)(53546011)(6512007)(186003)(26005)(38100700002)(86362001)(8676002)(4326008)(83380400001)(31696002)(316002)(2906002)(66946007)(66556008)(66476007)(5660300002)(36756003)(8936002)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEFKTHlJQndhUXF2TjlGSVFRZHlvcERWbTZEVGtPWFFKVU9ZclFCYkJ1bEZ4?=
 =?utf-8?B?WjUxZGJXejZpYkR4TkFIOGtNeDNDUEV3TjY4QmhMUDBxUUpQRnhaN2NmN2Nq?=
 =?utf-8?B?RTBHR1pJOXFVN1V3RUdlUUp0cU5HWk5ZQUFmUisxV29vVmJJb3NSTmVCOXlz?=
 =?utf-8?B?Z2JTSWdTQ3lRR1dNSExLcU9jbXRhd01ObFBxS2dyRU5LSjRPdG1qa3hUVkZ2?=
 =?utf-8?B?bFpiR0ZWU3VIeC9ORG4vZWlwZ0owazlkN0JJUm5NdVhFSDNRQm02Z2pDWFBB?=
 =?utf-8?B?NnVHdkJiRUtOdmdSN29Ea2RHeWpMeHNmWnA4UjVGcEpuVUxMTHRjZUp6V2tU?=
 =?utf-8?B?TzNxZEpITmwzbXl2VEdhTnNvY0pHeXh2RmVaR0RDMm9pbWpIUUJUanJjck5B?=
 =?utf-8?B?V1krLzlHbUZuTTJiSlRsZFRZSEhiaFV2TDJ6VG1JaGdMVWgvTkI5SndWOGVZ?=
 =?utf-8?B?RFRjMFpsSDBvV2dsYUNobXArc1RlZVhMNUVwV1h4TzVqQi9TbkV1SUVGVy8x?=
 =?utf-8?B?RFgxaWIwVzlXL3BaOWpYZkJHQ21DL3M4dUNZbTVKZTFPaURoQzY0MmFscDFl?=
 =?utf-8?B?M1E5a2F2MjBZNnZ0c1hKeXNCODMycXVxN3VmTTJrZzgrRmZFVVNoaWowU3Nh?=
 =?utf-8?B?QTRSQlJpQTdvam9YTWJ5aDIvTi8xVGxVdWxoVlVsdnY0UTUweUNMb0JCN3ly?=
 =?utf-8?B?SzJHQzJRUVdIb2s0SHB3dDRmam1aeGxDcU5nczQzdnpCeXExeTJQVFpUTUsz?=
 =?utf-8?B?U3dvdkQ0NUhGL0MrQ0VQWmtGL1Q1R3FKcXpINzcxekhYS0hiVkRMUHArWURK?=
 =?utf-8?B?SHNrRk9jRGYzZ2ZpMWVXQzg4M2N5ZnBIdjlyRm04aENCSnJMYWZRTW53SWZx?=
 =?utf-8?B?eW1pcEwyUjFQejJuSXl0dCtIR0xFbkZVYjFlM1Jqa01aNFA0Mm80YnhmK1V3?=
 =?utf-8?B?aE1mTTIvNVl2cTR5Y1RGWDFJTFdZVXYzTExYVTR3ci91WWRrNlZBemxCQTRj?=
 =?utf-8?B?SksrbVhoczJ0OFZ3WVc5c0J6djNuL25DV1F1ZjBoUldxbERUTkk5bE40THdt?=
 =?utf-8?B?cjNMdjhZU05vQTFGQUsxNnVZUkR6dDZOK09XSnVjYzNlbXVNYWphY0NBZkUz?=
 =?utf-8?B?UkxFU21xcXNQNUdIaDlrMWcwakhESDJDOHY3M28weEEreWxKS2JlSW4yVUpw?=
 =?utf-8?B?MmJQaUlDb2ZlN3dkTlJ6OW5oWSsxTHRMemx2clFWV2JnSlJua0RUd01SVlRM?=
 =?utf-8?B?d040L3FPRGZwQThSZVZ2LzEvS1dPbGlXeXdZM2Z6aVErdUxhUWNzK01mQlRp?=
 =?utf-8?B?K3gwN1BOMmZWZnR2Z3h3TTl6NzRuYUhsTDkwOXlVU3BWVjBWNVBtWGlFVDh4?=
 =?utf-8?B?U1FoK1k2ZFJWTmhSTFFMMDhTSDl2UElISWdMdU8zR0s2QXczcFhyVmJIcWk5?=
 =?utf-8?B?M3JOMmdVVTRHdm5BYzFuMXdkekF1U1crQ2hpWWkvUXJPdFB5VWZlT0s4VHRS?=
 =?utf-8?B?aEJIOUV3RkFiKzI4QTBIL2NVcFhmN3c1RHpqL1czc3dSb0VoS1lneUw3M1Q0?=
 =?utf-8?B?RHZCMmpsTWU5M21sNDBLKzdKUXhYVnN4MU9ia2tuZW5YdVFDeCtUODVJVEtz?=
 =?utf-8?B?WUFWRTVsb1R5ZlVzbGVndlhRNUhWMENUajBhQnBiOElwQmFVTFJVSjBYM0Uy?=
 =?utf-8?B?dFM2L09lUUcxNjZJMVJsN0FSajc3Nm5UTzIxYis5WjZCYm9EcHpoeUFuSnhw?=
 =?utf-8?B?K3NpNGJ0a0V4MjRFd0F0cHVWMEJhQmZCVGxJU2ZpL3N5MVkva1Rmd3pSZXlj?=
 =?utf-8?B?cW5vRHdZK0g1NjRzc1JGZCsxQkVRYkRaS0J2Y3FPUjdzSGlZeGNsMlowVStJ?=
 =?utf-8?B?UGwzNDkvemREUWV2VlhOSmRJVGtheFpSOWpZY1pVTGtCVnNxaGxwalFNTDEz?=
 =?utf-8?B?bll3MGVGTmZmTDZTNEpCOVpIMjJaWjhtcEJKM2ZrN1daRVdhOUIwMkJ1Z0hF?=
 =?utf-8?B?NW9YMTZGVk5BbkdlOWNLQWtFT2FBNWZSdlBrZkNjMU5qYXdFcmxRUXJBY2pp?=
 =?utf-8?B?amdCbGhIZ01OL3F5d1VUR0phZnNETWFod0JHWjRIczBzN1V1WWJTQXJoWkdT?=
 =?utf-8?Q?G88chrl1d9DvCn0PSrJECnG4/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nTJcP0pj57H+ytcn9Yr2xxM9rtcWuitzK1E/4Gvy6f1nzekV9Qbb5UewmJJ+X+mxhOI3pP2pqUB00ERGo4FpiOodO+qxCP41zr9GOX5ahlYNk+E4yeYjF3wIYEO3UeSy02I2zzFz+x65fH1sIwY+bHsXLKWU17HuISb3SAnPwcAY7otMhVvQS6U0kEl4PrPbZkzxvo5Ap+6NlfTwW8J9amvw6S0bo0YGwbRxeQAsklH+zSfUKwX1h20COc53Q8vQuDN6VONNcUggIMaluWp8lfpvr7ZoJ9baEhCQ18ZIa7C6ljvRuA+EB73JhNLUY26sAdAlKe+7R8OWOkeiHW025CXtaw5/uEd5Mr+27mRmMjbp8AJj05JFcxHvft+k3t77BXDDJho1EhQlu6b+If2nmZAAnNhqTgW4Bh+/ATPJKs2u0ldgETap+w74i2Tu4bhOvcsDparMDQM70DQM8yUpNLuUGaHhleqoPLpq8P8H71Ad0lT/oVZioiTOu0LJwsXb/pLl3RTT+ERDdNMuhKlO1PdAlEt6GaVZbrj9Z8+ptlIrsOx00dXf14tV0SWl7vAtUdTOthA+quxP2n1sGk+fLnByUjQ1wIJ1bUEVhtU/9oAZNRUiS7/LmJt/nM2lpt0QLp3X7RsxLNYMdBodO5ZFpC8b5e0bCobOg1Af3/PeQF7Vayhgdk3sXxa4kC0vkcbQ98b1rwBdlkDMRSH4KkHO9NsY+KoEbNCQ+gH3BzCE2a79nsc4sxtk+xMCUB3Z9sc3+3NiLoo4XC7aSemoAo1dAxTHzjUXdCMuRkmvREadKHjYSMgiT5Isolb77Al7jkDh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4c7ea2-2943-4940-609c-08db06f17801
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 20:50:37.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9BZ3rSzEmE8gNZrjWXTmSMgf+HE5VkQZ+DWexOaknYQCKPYs2T3Qt/TKmEWL6++NenY1H+JUCIsr4mxQIZ6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-04_11,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302040188
X-Proofpoint-ORIG-GUID: qydoobdxjyavcERP5Bvx32lzRdo3u8Li
X-Proofpoint-GUID: qydoobdxjyavcERP5Bvx32lzRdo3u8Li
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 2/3/23 10:18 AM, Jeff Layton wrote:
> The nested if statements here make no sense, as you can never reach
> "else" branch in the nested statement. Fix the error handling for
> when there is a courtesy client that holds a conflicting deny mode.
>
> Fixes: 3d69427151806 (NFSD: add support for share reservation conflict to courteous server)
> Reported-by: 張智諺 <cc85nod@gmail.com>
> Cc: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/nfs4state.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c39e43742dd6..af22dfdc6fcc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
>   	/* test and set deny mode */
>   	spin_lock(&fp->fi_lock);
>   	status = nfs4_file_check_deny(fp, open->op_share_deny);
> -	if (status == nfs_ok) {
> -		if (status != nfserr_share_denied) {
> -			set_deny(open->op_share_deny, stp);
> -			fp->fi_share_deny |=
> -				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> -		} else {
> -			if (nfs4_resolve_deny_conflicts_locked(fp, false,
> -					stp, open->op_share_deny, false))
> -				status = nfserr_jukebox;
> -		}
> +	switch (status) {
> +	case nfs_ok:
> +		set_deny(open->op_share_deny, stp);
> +		fp->fi_share_deny |=
> +			(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> +		break;
> +	case nfserr_share_denied:
> +		if (nfs4_resolve_deny_conflicts_locked(fp, false,
> +				stp, open->op_share_deny, false))
> +			status = nfserr_jukebox;
> +		break;
>   	}
>   	spin_unlock(&fp->fi_lock);

Reviewed-by: Dai Ngo <dai.ngo@oracle.com>

>   
