Return-Path: <linux-nfs+bounces-664-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2178155F0
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 02:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808371F2549D
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 01:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BCF10EE;
	Sat, 16 Dec 2023 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mK0qvAe6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uSjtOgir"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070C10F1
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK80g0020368;
	Sat, 16 Dec 2023 01:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=de229NYHvrz+x4LZlVoI9aFXPGvJZ541IqfR72x0uQI=;
 b=mK0qvAe6Z0N50lh4h6VwqvixLHVTyFQcd3hGi39SH1Inonm9d02mj29QRE5lvYja7NTT
 2uYfow3/EYQSBRHlyWPzTTDkwbQ3Co0nsK/Tc0s5+E7LKl/DOZZCmkqRBRM5iINbQK71
 oWvnvYKzs3b0gRiPKskcA8386RqXo8HDLj5F7L/D2VWNLsembd5newSxw9mx+IIL4IGs
 T3hzWjlmRtjG3J0Zo0rBqqfvAcs586/hi3Eww1XRDBoj/B9NEFORNRS/uWoqxagehlK3
 G4lk4GZd2R8nCVc3iuvKqAFpdlA40xOVbviba7+R5eA1F/57hZia2GmwMEgQ+sg7l7vM Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuuemdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 01:21:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BG0x4UQ039673;
	Sat, 16 Dec 2023 01:21:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepcmdgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 01:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5YdS6Fy+21SZafugrezq0Ov+sZNAvWDdzhsNXWCqJK1Dxgn658Xa8w28AX9qr+ToDECZ2rvMQCtoE1JqbFyu6HQhm03LEgliDGlI3sAAB4AVRI8IkVO+lSLvdgV8QQErCxU6kP7Z8YB0HLcKUcfZ0tCpPrh6f+QEopJQ7eXxAZ+BoP0iqSIW8OYpFVICYhVI9EJuCr6ym1kMtOdgvQFBz0tm1GXzVHUUBgbLT8zX25Z0QqtAlvYaCrBQwFDkSRrrP38qZrd2o6/LDxAzHBL/sn7kfrn1h+A1kp8DiF2f5Tn9SlI3fzRr1XJDEIi4Nbht19l+YBEwDMhKIADUeVMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de229NYHvrz+x4LZlVoI9aFXPGvJZ541IqfR72x0uQI=;
 b=npbLa9JcbqZTGd5QBCI7Rdeg0/rm7TpPQvRKS3iOfV7Y4sl0SY3tmdJaR3xRDVm++e3otOzHfUdHoHdMKeRX9RWaKp8WsKlVFhgcJfAyHmExhCbnD3FAGSdJu5qAdKHy5jBjmkSqeUEWHHKkcs011PPs//eDY6P4DC3POItO5ycEtruAqtNngB4rqVhoXnbnwq1Vt9v9MJM/DoVTWA5ufC55DrWehYwxW695G1uUyZdQwkEi3TfELv5lsfotMMZObrvfH3XTD67I0vqhLb8LKYfa1Ts1BkIgMZ9BF7FHYMtnPatKXzqp08GbPmF1s/dW9WlDWBPPrxlYA/dBHiPm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de229NYHvrz+x4LZlVoI9aFXPGvJZ541IqfR72x0uQI=;
 b=uSjtOgire0xuBnjj3c/hK3aCfqRzl1lif3TJhRxJvuYMd12qQjraqlJk/K9Y1sufW8gERuw7yom8FHkzCOG+GHpQ5skUTuqhxBodYcWLd0JcxEcLOePYTNUh6hnmF9sgnfhqPf7fbwT1qq4/A2rrwhTw+hXGXv8390Cgk1BBpNg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5806.namprd10.prod.outlook.com (2603:10b6:303:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Sat, 16 Dec
 2023 01:21:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Sat, 16 Dec 2023
 01:21:37 +0000
Date: Fri, 15 Dec 2023 20:21:35 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Message-ID: <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
 <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
X-ClientProxiedBy: CH5P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: f01526da-a423-47aa-f881-08dbfdd559aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	502UMpXZdQ6aq4VuIyXLZj1lTVNRzEsp2Hr+wSJXjci3X3nf1abTSCBnfXcihUI+aQi2d3V3rvNAvmbpcg+wXVi8IRo6catNvOR6DYPpUkkGT6GKX3Vgd4MwyQzgppm+cGfvC8a8PPZOZsmTJ2bN+W/P9BxqP744uXIV5c6jTULL6/AeDYh7Z663jt2CJo6Cp4B9Jl3b5Q43zKRJ9nHuReFBxXeP2EqIf59P8JtqtuHrTp+jnuuF6r03BAqcuYSRUeqgvILULqDxu88sgo/tW1TQcvbfWf6h/zS4ch8cHqG/v0A2lYf8gX1vadxnZ3bdaqWv4QC5yub4VCirO9Fkd/MxqhspvGHDHFVg3zpDTW4MKPcjBq7KpG6V3rAcfLai9Co0UEwetC0noDt7RRxBS+YFe+dgcW2xTSzqmDPuZJ8n1arWFxm6erv/nKefpaY1eXKGd7X00Kwy+d9ssc8lJi+48suR0Orb4MN3A65XncdsXDQ1Ait2zlOUSzdjcpArwB1Es5BY68ReC5CnX9Eo972h/7IBNzzDVHJtzWQdgRtcUZrOh8NrexuFDIiZGaDGA0ZswsDVWioXtOOLK0xy4uS18cR1d1nv24agupqgl7g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6486002)(66556008)(66946007)(6636002)(316002)(6506007)(8676002)(478600001)(44832011)(4326008)(66476007)(2906002)(26005)(53546011)(83380400001)(5660300002)(6512007)(9686003)(38100700002)(8936002)(34206002)(41300700001)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ixr+q2tzcJe5DxJT7mdbMN0y8UafTIjGvoN46zDi4m5lj3/wiRkJx15qbPA3?=
 =?us-ascii?Q?xuU2lyRqiPCmfzxIKsOKVEipv5fXF86wnsp25ePQtAa7fpm+x5iClqmo6JF3?=
 =?us-ascii?Q?+gL7LQUTYlqvgsKdaCVpPckpNtqm3Sg4cNQ2fspUVnwoT/rawU9XUU2b4E9A?=
 =?us-ascii?Q?02yr43ujA0e86DZQmJwA8aDARisd6MgEUxDcGjGPNmExzo010/a7BaWBbhQX?=
 =?us-ascii?Q?vGqHFTTX2khWsWlEFxL4sFlDBqBM4RvVm5EdWBQlHPPhZ2CWr5jotBMJADhx?=
 =?us-ascii?Q?D4VBrYfR8mJhBmzVL3uhpkJMha82cfIbvJb+9D+REyrTqaoSrVjquDCbcyad?=
 =?us-ascii?Q?4PHwV/X+u2++BXfOX3zk7z4v+e4exJjXHO9witIfc9Q1abgjbpFxGYvh6ttX?=
 =?us-ascii?Q?FAPZm4SXpNDpS1/URVVCfAVJjUL4LT1W5ZCq0EPfOviogWjcGzpqvY27RyWR?=
 =?us-ascii?Q?Mejv2uQxOe9Z7WAsbnDKu/qb9SMqAB8iVhE333tfdTOtbV8hEmoZJNzwq41S?=
 =?us-ascii?Q?3893NqfZbSnIDereXIC7SstydgmigzAHXkVIOaXOmlOj7TDFlwesdV47Y14W?=
 =?us-ascii?Q?GwBJC7r3iYZCiH+WkSz6E7bQXs3fjxpRDYsajqdbJhONv38lkj4ZhiGzjwU3?=
 =?us-ascii?Q?W6atlKbkch1K2YCS/bPETsonOJ1NYEItQfZSPwmpQ529Bipd482PvquqnLuG?=
 =?us-ascii?Q?XsMgWQS4vrtwszQSyrxsoZsES+U12UVzxrLxzKTVahIFkdE7lmEXpx9jOQH6?=
 =?us-ascii?Q?d1tLMK+sY8532o2jid8Kwj/UsaXweSC9AQ3svRmUUjAJcqFZzWOKidgKhATd?=
 =?us-ascii?Q?DvppnqcYZ/JWV9r9js1rS9DcDBRd+2NwT3SCrFZSmI5GZgJWn+hJnovG6jKu?=
 =?us-ascii?Q?xog8leHnk3W2yIeiU3FNKwzNTySWvQeXjMem473DzDZgrQjO5yldhyZQuIha?=
 =?us-ascii?Q?fEMnKxRkn1UbjXM6Ry1xCPhKBlXi2+ErKA7bxD9pJQZ5ZzVh4rV+wRToy15A?=
 =?us-ascii?Q?rYUhyaZ2S24SFAnaXXg33XjXobg6/xXiKq5c1b4dpQFky7ApkTOZ0OmJFy+0?=
 =?us-ascii?Q?l90Ys/nzmT5RxYRq0ISrBbnVdTtgocfwzE14joAhG5JPPc47WaYfFQfvumr3?=
 =?us-ascii?Q?IMdLoIsxV22qHAXbuOUqrh0wioauM+mPfBaB1Lxg026yvPkVXBYamCPbpoc3?=
 =?us-ascii?Q?n5EmnRFi+MiKEehHbBnQpxHPdiaj1v9q4lbOdSOCCsX/EdYGoGXxvtRosOvo?=
 =?us-ascii?Q?DCqx4NHaIl47f63HxL9HIywAlEZl4TYc1gWIlyfYtTAElR6YDNQliT51kxM9?=
 =?us-ascii?Q?HdNfp0pFlcXL7q6whKGCd7ztJVZ/LtHC1GcMKC+KDYpOGnJhpltRjoUGvkxP?=
 =?us-ascii?Q?HiT+diTGJHATKZ5uYJWx9pVA/pil3ewVlaSpRdFiOBQTF68vEYKt6j0HWT6M?=
 =?us-ascii?Q?C7+RJY3jH560L0jKzBI4cEp6dxzThXVdqDKDzPP6Fz+gaLSMRhc8uRsshSTl?=
 =?us-ascii?Q?P3V/emwnyh+NEpzrDDDyvkhfajRY59YVceOLUWcMlU0LAAc84/6ehpse/kyn?=
 =?us-ascii?Q?Qsj306ydalGyQjf2fmKBI9Yo2ZHygRRiJGBqsnkDzfH8kZA9tk0uAQyzWNl/?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	699wSvqam8ha6KhaMmE4NBnM/tV61zcSuGkDQ5oUMNRPQDLYoav0SXwtUdirCl8mMYw6c1RFBZ8XCrDziM5GF5FbApPboOinvJiUSVwXPZqFRcrN6j7EuOdPGr4GAjO670x3g8nZj/zGJRlI7M8hIeKMVDGkQyJr6FDr2d25/XOPjmYOLucQorVyCudDT6CBZf/atBXV2qHO46WgTQVaNnDwqHHO98k9iTFQR5jP0v90F3ajC0f88f1knaxS1iux5UPpUcrPCOn0YFQkTRHydzAjmSFeNZl9E9RCyK6Do0yqzrsW6vGmbSPh72dbN08RTDdqtIczgf5uterL5KVkd/0JnJ/FX5IorI1WmxaVqe7CiFC2TKJ4AbKyTl8WCGAr+YMkavDanT7IQWxx4AMnOQwzZpd2B7J9hI+YB/AtDSfGUZ+UQb8zI092mtc9Etp1eM4vJSUDURQmFE6jx+iN3+54QA0LXO0sWtO7ffWCaJuT0q5OxzpKO6wDOh4kp8luNTfRO7pDJKNYrqQGhaZA0596COyi6uNrX0nvBg1bArxSWygTtxib44jzhrJpHXq5YtnZHKrS4HbiuCLxlkPFZavpwDzuYBxXdjKjkKvyAnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01526da-a423-47aa-f881-08dbfdd559aa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 01:21:37.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cnm2KoR7mrxydlp12iDP33CIAP7bdq2A4rOImSxh7e7e1fKB6k3eq/FQlj1rTE7QPWELdR6HVjthk4ntARsOXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_01,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312160008
X-Proofpoint-GUID: PqJMWM0-hcxunHKAd6KvD8G4r4u1rkZa
X-Proofpoint-ORIG-GUID: PqJMWM0-hcxunHKAd6KvD8G4r4u1rkZa

On Fri, Dec 15, 2023 at 01:55:20PM -0800, dai.ngo@oracle.com wrote:
> Sorry Chuck, I didn't see this before sending v2.
> 
> On 12/15/23 1:41 PM, Chuck Lever wrote:
> > On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
> > > On 12/15/23 11:54 AM, Chuck Lever wrote:
> > > > On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
> > > > > If the callback workqueue is stuck, nfsd4_deleg_getattr_conflict will
> > > > > also stuck waiting for the callback request to be executed. This causes
> > > > > the client to hang waiting for the reply of the GETATTR and also causes
> > > > > the reboot of the NFS server to hang due to the pending NFS request.
> > > > > 
> > > > > Fix by replacing wait_on_bit with wait_on_bit_timeout with 20 seconds
> > > > > time out.
> > > > > 
> > > > > Reported-by: Wolfgang Walter <linux-nfs@stwm.de>
> > > > > Fixes: 6c41d9a9bd02 ("NFSD: handle GETATTR conflict with write delegation")
> > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > ---
> > > > >    fs/nfsd/nfs4state.c | 6 +++++-
> > > > >    fs/nfsd/state.h     | 2 ++
> > > > >    2 files changed, 7 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index 175f3e9f5822..0cc7d4953807 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -2948,6 +2948,9 @@ void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
> > > > >    	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
> > > > >    		return;
> > > > > +	/* set to proper status when nfsd4_cb_getattr_done runs */
> > > > > +	ncf->ncf_cb_status = NFS4ERR_IO;
> > > > > +
> > > > >    	refcount_inc(&dp->dl_stid.sc_count);
> > > > >    	if (!nfsd4_run_cb(&ncf->ncf_getattr)) {
> > > > >    		refcount_dec(&dp->dl_stid.sc_count);
> > > > > @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
> > > > >    			nfs4_cb_getattr(&dp->dl_cb_fattr);
> > > > >    			spin_unlock(&ctx->flc_lock);
> > > > > -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
> > > > > +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> > > > > +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> > > > I'm still thinking the timeout here should be the same (or slightly
> > > > longer than) the RPC retransmit timeout, rather than adding a new
> > > > NFSD_CB_GETATTR_TIMEOUT macro.
> > > The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
> > > work item to the workqueue so RPC is not involved here.
> > In the "RPC was sent successfully" case, there is an implicit
> > assumption here that wait_on_bit_timeout() won't time out before the
> > actual RPC CB_GETATTR timeout.
> > 
> > You've chosen timeout values that happen to work, but there's
> > nothing in this patch that ties the two timeout values together or
> > in any other way documents this implicit assumption.
> 
> The timeout value was chosen to be greater then RPC callback receive
> timeout. I can add this to the commit message.

nfsd needs to handle this case properly. A commit message will not
be sufficient.

The rpc_timeout setting that is used for callbacks is not always
9 seconds. It is adjusted based on the NFSv4 lease expiry up to a
maximum of 360 seconds, if I'm reading the code correctly (see
max_cb_time).

It would be simple enough for a server admin to set a long lease
expiry while individual CB_GETATTRs are still terminating with
EIO after just 20 seconds because of this new timeout.

Actually, a bit wait in an nfsd thread should be a no-no. Even a
wait of tens of milliseconds is bad. Enough nfsd threads go into a
wait like this and that's a denial-of-service. That's why NFSv4
callbacks are handled on a work queue and not in an nfsd thread.

Is there some way the operation that triggered the CB_GETATTR can be
deferred properly and picked up by another nfsd thread when the
CB_GETATTR completes?


> > > We need to
> > > time out here to prevent the client (that causes the conflict) to
> > > hang waiting for the reply of the GETATTR and to prevent the server
> > > reboot to hang due to a pending NFS request.
> > Perhaps a better approach would be to not rely on a timeout, but
> > instead have nfs4_cb_getattr() wake up the bit wait before
> > returning, when it can't queue the work. That way, wait_on_bit()
> > will return immediately in that case.
> 
> We can detect the condition where the work item can't be queue.
> But I think we still need to use wait_on_bit_timeout since there
> is no guarantee that the work will be executed even if it was
> queued.

This is a basic guarantee provided by the RPC layer. Can you
enumerate what other ways this path will fail without waking the bit
wait? Are those issues going to impact other callback operations?


> > > > >    			if (ncf->ncf_cb_status) {
> > > > >    				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
> > > > >    				if (status != nfserr_jukebox ||
> > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > index f96eaa8e9413..94563a6813a6 100644
> > > > > --- a/fs/nfsd/state.h
> > > > > +++ b/fs/nfsd/state.h
> > > > > @@ -135,6 +135,8 @@ struct nfs4_cb_fattr {
> > > > >    /* bits for ncf_cb_flags */
> > > > >    #define	CB_GETATTR_BUSY		0
> > > > > +#define	NFSD_CB_GETATTR_TIMEOUT	msecs_to_jiffies(20000) /* 20 secs */
> > > > > +
> > > > >    /*
> > > > >     * Represents a delegation stateid. The nfs4_client holds references to these
> > > > >     * and they are put when it is being destroyed or when the delegation is
> > > > > -- 
> > > > > 2.39.3
> > > > > 

-- 
Chuck Lever

