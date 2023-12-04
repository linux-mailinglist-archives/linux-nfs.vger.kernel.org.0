Return-Path: <linux-nfs+bounces-306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA3803E30
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 20:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5991F20F49
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 19:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6C3158B;
	Mon,  4 Dec 2023 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bexbMkfj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FfXrLJLU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE7D7
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 11:15:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Ix7OQ020204;
	Mon, 4 Dec 2023 19:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Fv/i2cZqLzbkGfjS0jo6L3Pt7eUoDa1wVhGFwP3sunE=;
 b=bexbMkfj4yA3e3E6S/GYoII3+rHUiHo4Re/u+qD0TCR/2y0CLZfeHkap2U9kPNx/cKGj
 TeKRKY7LyewVeUbff5hNuQSwFQDt/otZRfhb1gJ7ieve/JKN1hY1aZ6TKgsa9AyyJ3fo
 gK9sknTbffsutk7Zha172hXt65dWoJYlKiLToxzjEHNXIJzUd0ahF6un0nw4PAYhxfe+
 1Yz3Zm1Tl5Wmj0V5mfbVQQVS/1Gcbc7tKyeE4JFAZFU5e1aovRcH6Vf8FJwXWkQiCWnM
 Pjof11WFgB6JFLNZFNK9eOGBJfOa/N+cd/r4p8qcqhUua/r65/Mnb4xp8/oH3o9pppCO Gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usmfv02sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 19:13:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Hh8NE034466;
	Mon, 4 Dec 2023 19:13:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1698yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 19:13:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhOMYGgmsKkhnxbIcX3f+S0k4PfUN+xB9D2Q4+5RueK8M4l/YDSM4FNI/UoIdvWaIQi6g7ZxygHA4JnBfCLHO0F9/OCQk/rdGoBcyRdWVSKoCSCec/cxsir+SqI2ES6YikM8f5yTo0BWbN4XVvvyiVMTiTpi6rRR4v57gzME68GNIB84R1R/5rTaZOHjNABcmy2QvBavkTWv9UJ6uiir9icLIag76f2gD4g0D1WFBR/BalGNKW7XbstuTp6qr9E/uOVXZAKboQtqh0TxgLga6+GH+X0Cp1OsZXIfoBLv20ywyQKTj0BacP84hQsQ/6ljqThMWcmqIZJ6D1Z8jz894w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv/i2cZqLzbkGfjS0jo6L3Pt7eUoDa1wVhGFwP3sunE=;
 b=asm3NObCvY682OBPXJ9NuOHlnE8+Qo/Ksq1NIVga0vYNULs2nemWdp0djvQ0uGrlf8asmptnDvq1p5+/eogqaBaAUzkdNQxhyGJkcn+wz9EBG403jzd5m5FZDw6e9t2lQ1suN/MNzSq7YHQhu7qJI7xt3hp4dpvRG/z6v3ixYp1umQbV6ptHkV1nhANA8d8PUvU5wgU7DvxV4bZ4UoMTqenSyz7A6nE41TwnvLVrTf7rRzu0qeqNLUhM/pwMc1PV8riMeoS451M/u41TIQ5FnO6wP/PV8+cdCrfFRsC01gNhs/eN5AAGxKVJD6MKJ0HF0z8XEGxjVRgpCnYeKKUkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv/i2cZqLzbkGfjS0jo6L3Pt7eUoDa1wVhGFwP3sunE=;
 b=FfXrLJLUN4c6B1IrPyo/FUSnvYquDLGemyhMcE++FLI1YxW85yUB5/ghHGsnmfyK4De7RvorfREznyaNdE5pfC5hcllS/TgwwQ26ZavlhGofM0Ex6j2hi0IkZlRvT5PKw/CZXCYpL5IW0iKTPOi76VeVGGJz0YB73Y49pZsEy/Y=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB6866.namprd10.prod.outlook.com (2603:10b6:208:434::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 19:12:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 19:12:54 +0000
Message-ID: <537b96d3-1d8a-4eaa-b271-e103f73e980d@oracle.com>
Date: Mon, 4 Dec 2023 11:12:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: kernel v6.6.3: nfsd hangs in nfsd_break_deleg_cb
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>, Wolfgang Walter <linux-nfs@stwm.de>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
References: <e3d43ecdad554fbdcaa7181833834f78@stwm.de>
 <ZW37M7DOavddVpFd@tissot.1015granger.net>
From: dai.ngo@oracle.com
In-Reply-To: <ZW37M7DOavddVpFd@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:510:f::8) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9e9424-e3ae-4a7a-a517-08dbf4fd04b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JmGUA3CMo2vv+BHvQY4PYzdwrmRIX59jDvMrIwEC8eD7yM1C27SkWJLV+N9EPrGRHqjtOdKzg3QjccI8OnoRIo4qTf3NFD5ZIFarIQHFXnBiADZyKtlb5bsln1A8Sf1lM23gzPSMEmx9cBuMCjhsDR+wb1wvqVl5wNBItLyzbcOWLFO1avmA5kZX6XwUKsXfuyJ7LaXJNnlZ94XAUFjlxkUcd7nBM9TIBmxm6fWwqbRZRNdPFcvwKVDr1/mVUaO4JI9b2NtQpZgcpKal0WqnzXBtIoqJ2ka0q7tGduP0Ky9r1ymdPQc2aXfwl0wzyn+nZCA5TVaAFB8y9eZXblHQsPlZ6W2ouqI51CItII8SLewBAjFRNpnl/AdtUzkgKO7UbTlrZXeAmy4C1r+L+09a8Cwh/ZWMUMtjK6fz7abxseYtn14rqmRbE8OQS5ofgEntol/6cuMCVYkqnt036FIlwbPmJT9Md4wHyb9TvNXrQWd1ZTkEw0kgMmFC0DObwTk6q+XCVjSjnPrKjFjN67x1bLSVz0eUTfQdU/fsjxXiJDglYnxvaWG3IBPDznNKljfr3VoHYJnUGsrkhGkYngoGcDR+Y7mb6KyddoE1qDQnAPsDMGVn3FUWlpIndu+tpT1XzkScZDjg3SBXEFxmBlYFF7Hm3sPixCC5ovd12jIYjsM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(6506007)(6512007)(2616005)(9686003)(53546011)(110136005)(316002)(66556008)(66946007)(66476007)(31686004)(83380400001)(45080400002)(26005)(8676002)(4326008)(38100700002)(6486002)(478600001)(8936002)(2906002)(41300700001)(5660300002)(36756003)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTgxaVJ1TVYzaStsckwzc2NIeEhKN1A1aUZDcmJOdllienRzZncwNWJVRFBs?=
 =?utf-8?B?eVlsNUdKU1YxTlg4QklBVDVlRWlPZmxEdDNnTndtQm1DNzdnUGFHdERzVlN4?=
 =?utf-8?B?c1hSc2g2dmN3akdoTTNyb0hwQXVEOTA1NFJFUjRrakpVSVRxTldhejRFakh2?=
 =?utf-8?B?TC9XUWpmVGlJS2F6MWY2SnZLcmNVZFVzZHhOSy9VNFMxZHI4cG8rNDVqUHRO?=
 =?utf-8?B?K3Vic0dXQ0paUnp1dU5nWnRlODB6M3lwdEcwekxaM0VTcno1OVhWSzRIQnd0?=
 =?utf-8?B?alRIN1o0V25lOGVJZFNNQUdFaTlYeU14aTU4cEs2TUw3NG4vZWNCcDJHaUxS?=
 =?utf-8?B?dThjamJJQmtWM1RaWldEL1d4WlFOUUVQYVFFNkl6Y0M3K3NidXRybVRKeGFk?=
 =?utf-8?B?SXprbit2SXF5RmtJQ29SNXB6azB4aTJMZDZuaXBCc0NlemFyZ3NxbWxpV0dx?=
 =?utf-8?B?TGp0ekdaYWNsa2xyOVExTGU1eExxajRocmxoaUxjWWVlZks5azY1amJzb1Nw?=
 =?utf-8?B?Sk51WGh4Nklsb0Rka0Vjcmd5R2N6MkZ0a1VGQ0Yydmw3VlJHZ3ZrTlIrN05E?=
 =?utf-8?B?T054RUw2eG9vNm9PdVhpTUIwL0xDZVFnalpyalJxYnJsTG92UVBON1dNcWx6?=
 =?utf-8?B?ZG9kamNkYWg0cXBRTnBDakpCQXlrSTIzNWlSRUR3bUpsQTdpWHo0aGF4dGxO?=
 =?utf-8?B?UUEzdFJ1Q1J4WkRxTTZkclUzTkw5cmRQOVFGSXFMZVdJWHRRMXFQUCszWkI2?=
 =?utf-8?B?T1JUQlQyMjhaWkl6RnZpWk44cmRJVVFIT1dRd1UxMSs0akpJTHlBODB4eWVP?=
 =?utf-8?B?bEl5Kytta1VjWnBUZHovRjNYekV6d3ArcVBBRklYZ1dqek5sVldJRnpFeGl2?=
 =?utf-8?B?ZEx4UE05MEs1ak9ubk5RelhwZ0Y2Ujh0ck1UNzVtdFZKTFBkSG5YWmhKSVNj?=
 =?utf-8?B?MHg5SGRVK3VpVllYQXU5U2pKM1lpMlpjQmtlMkF4S2ZGYzg5Ym4rdlRkcEZq?=
 =?utf-8?B?c1BWZ3lMQjFwa3hHQlBTeFhiT1E1Rlg4N3FOL1VvUnJwODU1M01VNGNsdFJI?=
 =?utf-8?B?RUhVRTB3enVVMHFXekc4WUpJZUl0TEFjdkhnUnBHT3VWZ0JjZ2lTNDZtUXlB?=
 =?utf-8?B?ZjBHT3F3eEtBRzA3UHpEanlsZDdQWHM1Mk5FVllIQ0JZYjB5ZGVGV2ZCeXFz?=
 =?utf-8?B?UlRPeHB4VTFHWVRNc1NrRGdhbFZPcEtGSStlV1hEMkdlRlN5QlBCdXRXRWFU?=
 =?utf-8?B?OFIrRCtGckxQWG45V3FLbThOQUsyZXBQbytCazQyeExtbHozMEVLVTNYRVBC?=
 =?utf-8?B?MzdiT3VnRjFZR2lsTzQ5TG5VRjRCcnZFUmlzUElQc0w4VzFTUldac2s5OE1V?=
 =?utf-8?B?UVhFZkRZYVhRTitEKzk3eHlwdFdKUGQrazhwTTB4T01YS284L3pFVUNZV254?=
 =?utf-8?B?YkxTa1JHNkN2cGlrMTl1UXJvbnl5S1ljNFVLTEJtK1I4dXhwVTRYZXJGekV4?=
 =?utf-8?B?TjE2RklVcll1bmg2Z2pOYmJHZThXd2pIRXhPcGZndWJraDFyaFJpWE1rSTRp?=
 =?utf-8?B?b3lTNGpmRjNMUDhnTzkzRlhLS3JnNTBML0YyTXdzUVhoWHQydkZFRURiVW1C?=
 =?utf-8?B?dkk1c3ZQb2wrMXMxV3RDMVRBZHZydUF0eEZuOVpDeWJtTStOYnFVOU43TEtW?=
 =?utf-8?B?QWMwOEx1RFJsb0VYSWgxdnFjYWthRTNTTkdMclpPUENyMWtTQWoySzNxYWhI?=
 =?utf-8?B?SlYxaldwNHZ5Uk9DaTY4QlpSNjIrM3hwbTBCVzEwcnB0d0tRenovbnFCb016?=
 =?utf-8?B?dVdXK1kwS0JGR2JxUGNmZ29DWlMrRm9JMmVzOU53by9YM29OaEF3TTNkbXpK?=
 =?utf-8?B?eGRXS0dvclNUejFJVDlybDdqdVBrSFFFTHpUZ0t2NWdYTkV2bGJLSVN0SWc4?=
 =?utf-8?B?bTdlVlhMWVZFZksrSjczZWhMcHVzS1NWTkJuTkJUc2pFdDZQeHoyZGtlNlRH?=
 =?utf-8?B?dWs3cjIvd1FhektqaHl4MVlJcmJ4TEplMnlwMUxPdndwYlg4MUJmY0xJYlBW?=
 =?utf-8?B?cmwrNlE4b21DQ2tIVDdob3RGMWdUTW5qUFQ3UmxSVERvbFhqZFMvMWhaMmZW?=
 =?utf-8?Q?gaohoOAv0+IVrDyWfQwuFsmMb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	73gW4M1h4w87mO+//0E8IjGU709p3a137YZtnQ0UQrYsH9XxZE/j0rn21KFAKoRz93Gk8r40vIfRspNHFeiHriyZ18Fvb5RPzKkVpTmBhYpkfhJ+h5tfyvxtrjzPlHPZ0J2Lv3rIbiS/4ef0aPY5uwDSkM8MH/8/IOnWibACZVWeYUMzvaTF430jUejt2wqoCwL/VvBHwrFa0sXf+O1Z9BdCb4O9L1dlmpKWt56ciZJKAPgWchvfQIHT1L5oou3GYDRrKvS4FP/BkozU804E2PV6z55DcVABm2bqon+13ITkae+M6/yVUGvmOWKEAn5shO71zBp9aPScBaGV9ohPXHDT339BW658zeKxAbZj/aY6JEoa3Lniwbfuk9mkxHke9gS0HETML50S/7MXKuH7uuhJvPZl+RhCjWsHUwhvSZmhlUzSp6s0bC0UJCuzjXUdI8tHy+bqJVZnQADzmfHd4a9evSVof3v4JWeaenEcr0BfcOmzfToH1+U/EjW1M9DfhXrHJ+KQobf4gDlWYERs4EA9gAare29DmT9reB+mC/28qW30LU8wz2H9I7r29SJOqJgUb5HI/xFPA/7cBEPZl+wb7iYJ7hDb4tDQaPrshfjeedf+nhek5i8UJEn5mHYT4L4JORBGBgQdIqu2NqUtkZ26ztGacCxxSG43jKRtzXQQwVbIJ7pFZDRoa79sGydB8qZlV9yXNJ7o/KtlrOtgQM2NLJnXPQk06wnpuFeGKGP7aeiSlja761opyixjyEg9NO8FJU6GF2AVPRe9pyMOr9zOhGmY0ihWOYMkEDe+N20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9e9424-e3ae-4a7a-a517-08dbf4fd04b8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 19:12:54.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ouo0ptVPIb4XJnrCqje5OL/kFnnPtce0i6O+ItMATrVqoDfeJU2kw3pTPz0OqKNdGjlcXDTCTrD2zGnbb/WeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312040149
X-Proofpoint-ORIG-GUID: -NvV430LZVYbxZkRv_25hvC_TEbmurGy
X-Proofpoint-GUID: -NvV430LZVYbxZkRv_25hvC_TEbmurGy


On 12/4/23 8:15 AM, Chuck Lever wrote:
> On Mon, Dec 04, 2023 at 04:34:00PM +0100, Wolfgang Walter wrote:
>> Hello,
>>
>> after upgrading from stable 6.1.63 to stable 6.6.3 our nfs-server logged a
>> WARNING and then more and more clients hanged:
>>
>>
>> Dec 04 14:59:25 engel kernel: ------------[ cut here ]------------
>> Dec 04 14:59:25 engel kernel: WARNING: CPU: 17 PID: 8431 at
>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x174/0x190 [nfsd]
>> Dec 04 14:59:25 engel kernel: Modules linked in: cts rpcsec_gss_krb5 msr
>> 8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common sb_edac
>> x86_pkg_temp_thermal intel_powerclamp coretemp kv>
>> Dec 04 14:59:25 engel kernel:  enclosure sd_mod usbhid t10_pi hid
>> crc64_rocksoft crc64 crc_t10dif crct10dif_generic ixgbe ahci xfrm_algo
>> xhci_pci libahci dca mdio_devres mpt3sas ehci_pci crct10dif_p>
>> Dec 04 14:59:25 engel kernel: CPU: 17 PID: 8431 Comm: nfsd Not tainted
>> 6.6.3-debian64.all+1.2 #1
>> Dec 04 14:59:25 engel kernel: Hardware name: Supermicro X10DRi/X10DRI-T,
>> BIOS 1.1a 10/16/2015
>> Dec 04 14:59:25 engel kernel: RIP: 0010:nfsd_break_deleg_cb+0x174/0x190
>> [nfsd]
>> Dec 04 14:59:25 engel kernel: Code: 02 8c a4 c2 e9 ff fe ff ff 48 89 df be
>> 01 00 00 00 e8 70 7c ed c2 48 8d bb 98 00 00 00 e8 b4 0e 01 00 84 c0 0f 85
>> 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 0>
>> Dec 04 14:59:25 engel kernel: RSP: 0018:ffffbd57227c7a98 EFLAGS: 00010246
>> Dec 04 14:59:25 engel kernel: RAX: 0000000000000000 RBX: ffff94a77356e200
>> RCX: 0000000000000000
>> Dec 04 14:59:25 engel kernel: RDX: ffff94a77356e2c8 RSI: ffff94b78cf58000
>> RDI: 0000000000002000
>> Dec 04 14:59:25 engel kernel: RBP: ffff94a0392b3a34 R08: ffffbd57227c7a80
>> R09: 0000000000000000
>> Dec 04 14:59:25 engel kernel: R10: ffff94a05f4a9440 R11: 0000000000000000
>> R12: ffff94b8e3995b00
>> Dec 04 14:59:25 engel kernel: R13: ffff94a0392b3a20 R14: ffff94b8e3995b00
>> R15: 000000010eb733cd
>> Dec 04 14:59:25 engel kernel: FS:  0000000000000000(0000)
>> GS:ffff94b71fcc0000(0000) knlGS:0000000000000000
>> Dec 04 14:59:25 engel kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Dec 04 14:59:25 engel kernel: CR2: 00007f9ef8554000 CR3: 000000295e020003
>> CR4: 00000000001706e0
>> Dec 04 14:59:25 engel kernel: Call Trace:
>> Dec 04 14:59:25 engel kernel:  <TASK>
>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? __warn+0x81/0x130
>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? report_bug+0x171/0x1a0
>> Dec 04 14:59:25 engel kernel:  ? handle_bug+0x3c/0x80
>> Dec 04 14:59:25 engel kernel:  ? exc_invalid_op+0x17/0x70
>> Dec 04 14:59:25 engel kernel:  ? asm_exc_invalid_op+0x1a/0x20
>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x9a/0x190 [nfsd]
>> Dec 04 14:59:25 engel kernel:  __break_lease+0x25c/0x720
>> Dec 04 14:59:25 engel kernel:  __nfsd_open.isra.0+0xa9/0x1a0 [nfsd]
>> Dec 04 14:59:25 engel kernel:  nfsd_file_do_acquire+0x4ca/0xc50 [nfsd]
>> Dec 04 14:59:25 engel kernel:  nfs4_get_vfs_file+0x34c/0x3b0 [nfsd]
>> Dec 04 14:59:25 engel kernel:  nfsd4_process_open2+0x42c/0x15d0 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? nfsd_permission+0x63/0x100 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? fh_verify+0x42e/0x720 [nfsd]
>> Dec 04 14:59:25 engel kernel:  nfsd4_open+0x64a/0xc40 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? nfsd4_encode_operation+0xa7/0x2b0 [nfsd]
>> Dec 04 14:59:25 engel kernel:  nfsd4_proc_compound+0x351/0x670 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> Dec 04 14:59:25 engel kernel:  nfsd_dispatch+0x7c/0x1b0 [nfsd]
>> Dec 04 14:59:25 engel kernel:  svc_process_common+0x431/0x6e0 [sunrpc]
>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> Dec 04 14:59:25 engel kernel:  svc_process+0x131/0x180 [sunrpc]
>> Dec 04 14:59:25 engel kernel:  nfsd+0x84/0xd0 [nfsd]
>> Dec 04 14:59:25 engel kernel:  kthread+0xe5/0x120
>> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
>> Dec 04 14:59:25 engel kernel:  ret_from_fork+0x31/0x50
>> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
>> Dec 04 14:59:25 engel kernel:  ret_from_fork_asm+0x1b/0x30
>> Dec 04 14:59:25 engel kernel:  </TASK>
>> Dec 04 14:59:25 engel kernel: ---[ end trace 0000000000000000 ]---
>>
>>
>> 6.1. did not show such a problem.
>>
>> Both are vanilla stable kernels (self-built).
> Thank you for your report.
>
> If you are able to bisect your server between v6.1 and v6.6, that
> would help us narrow down the cause.
>
> Dai, can you have a look at this?

The warning message indicates the callback work was not queued since
it was already queued. In this case we'll have taken an extra reference
to the stid that will never be put (see b95239ca4954a0), we should fix
this but I don't think this extra reference causing the client to hang.

It's hard to say what the root cause is without a core dump and/or some
network trace or a way to reproduce the problem. As Chuck mentioned, it's
best to bisect the server to help us narrow down the cause.

Wolfgang, could you provide some additional info such as how often this
problem happens, under load?, problem reproducible?, number of clients
involved, type of NFS activities, etc.

Thanks,
-Dai

>

