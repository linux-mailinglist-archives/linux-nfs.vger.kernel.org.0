Return-Path: <linux-nfs+bounces-938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7A824505
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70E8B21D29
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13258249E5;
	Thu,  4 Jan 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kzf043rQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vShxMMxf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D78249E0
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404FAwXl012794;
	Thu, 4 Jan 2024 15:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=+UmxarKcXmmng0EvaftetnS0unGyO7GV6nMX6D/ohxk=;
 b=kzf043rQplHJRtdgeirh5cCeKQkwr21Yf6o9o/3z+W0auUeXH6sN6o1dBXD/lg4nXuWv
 ubDI+qIu/kRtFpeohzQ8qT/uGjZFJffJOP77RbXi6E1q3xJ3Jj641tKaEYfcE9Gfuiso
 CZsPhQ23XwSD2iTLv48UEg9nTIpb15Och5NLoqmOObFi+IQcxmz3Jf5lzE6fcMkbhl8U
 vCF/4t/iwoOarc5KSWMHE46m0xiWUtN5iktS01VSVfvbpCbAzAE4VXx13r5qeQ+PeTBg
 HeWpGHpllwfPO3kvaaAVcpg8tyO917TXWIsMaAOXls3WKnk16dSHda8ETgtpgN7lK6dB GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vdy33r1mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 15:33:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404ENCxg040587;
	Thu, 4 Jan 2024 15:33:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdx48dwj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 15:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnUA96OGdvqS+BBQEWhFtl7i2ZbJSRRfI5apfkI3jgPNCwPXLf/DeevLZ8iWfUU7aH2rF90rI/l2OV6RLtKYpW78kTUdawrM6jDiWDS/E6r7rZNTsRc7pt7qkOrMDFiAeDjbVSF23XIvlzD9hMazN+vj46l5dFJTdU7JwufV6072OwcdbW1dKt1mIDoQhPVPQPwbdanbeAcnfF9AmzLscaEZUIeHpWb6s2nSh4BK1mAE8Kw/YwTxVSLMRbQSqHO5rhVoYfShqznjG8G0H01vQPloAaoqw9+g+qnskKuIR0xenKB7wSeQJ12Xa3DZB/tYqLb/neHSLbew2c6vWqxn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UmxarKcXmmng0EvaftetnS0unGyO7GV6nMX6D/ohxk=;
 b=Eh5kWDIg0UMXQ173tHeVjUC92zFjWQCyJGSqWtqtDnxSsaBjG8zQKr6F85V0sLw2A6MVr9hokfPs2ayO/5H5zd6h71fUZqDz/4MAg2oUyIoi4zzbNOreLfIwf0bh3YHgRzPLAwOeqWR/5zqG32ZKu3Z0dC47aCi89eZpB7aOR+C7+nQvrbnXICax4Ivv3QlMJu4ilHYIAHjD3W4xpKcmCdO+FsJ//mAGWU++mUpXYR8EMwWIQKcgpGJzlJs9tgwldj/mBAfa3PllBdOPgJpAlJj6hAvWAhE8ZozK63BQfQAI7LNw+auj1P9s8sT/nGIjc8N/CaAbJeUPGuriZ39SvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UmxarKcXmmng0EvaftetnS0unGyO7GV6nMX6D/ohxk=;
 b=vShxMMxfjykcIeufi88TRWHMyE0cXBXO2fb3N9FoOA3aHKvSLiHzxV0kFt2AQcvRwFt9KkC29F2MB8r+0LrTHUpNMM2wjxGaZSBD0Kf9a+0n7Z/mG3ZsKBvYrmKrIBsq54IVNXZJ/1ziQy3409KvTAAn4Ny6dTj2XcuMsVYB4uA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4961.namprd10.prod.outlook.com (2603:10b6:208:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 15:33:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 15:33:19 +0000
Date: Thu, 4 Jan 2024 10:33:16 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] SUNRPC: Fixup v4.1 backchannel request timeouts
Message-ID: <ZZbPvP2NN3mvUtvp@tissot.1015granger.net>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
 <ZZbKRp3oe1lptDvf@tissot.1015granger.net>
 <FBF6D528-DD7C-40C3-85DC-8D48B98990A8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FBF6D528-DD7C-40C3-85DC-8D48B98990A8@redhat.com>
X-ClientProxiedBy: CH2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:610:51::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 636e381a-d02c-4a83-0f6a-08dc0d3a7a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z8yVKqGRA7wkshDs+6O8Fx/zhN4M8f1KV4EBLKl9eclgDHPtCmzxEGfeCQCIGIx3WcJ0PjC3yH0vRIUE7sqK+8G3TNIsYn+hEAJOfRnIkoJUa0aR9ougtWmuhhSd02mPgt7ZAuvt/oj5Op7wyXugyU0okvNjy+bQZeww91nfSmKHuliqgPX/At9d4S07cSAGWMFydxhohNax3KXJcRknik51FSZGUIc8wwrRWo5YJrFPLlqD+tMT5Kb51sxr7k+4OVCcqKbtABCKFyTBrc8xASuIAtV7CD7tzKVxwhPvW75Bj2U6yRuNWrHgJmda8dcPqd6MB8HWZQAjPU8/5HPoSxMtUvg1XHKBeYN0KNyyZ4uRKxTlMYjpX5yUHN3qIp7DH0WOjeEfearsrR2Mf5YwJR2JXCPtdELNlvvNdXCpVS/7ELlBASIrwOFAlv+qTYwN+7UWyzXgAVtqV613cOfSoBzIbkJSxDm0o11VbSvXUUTOvDej+ERHnnaYRle3gpB8G5oebDUbS1VgMh8KJMvO6Ig8X0Zh1W/kUnenPrXszySugvLlIFDYr0dOUeCk3HYd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(6486002)(53546011)(6666004)(6512007)(6506007)(9686003)(478600001)(83380400001)(4326008)(316002)(54906003)(8936002)(44832011)(8676002)(66946007)(66476007)(6916009)(66556008)(86362001)(38100700002)(2906002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vXggERX0WU/FFkRi2tPI/7zTpGNel8SN9WS/ebN3/G23FTf2Ty+uS3k7YS+Y?=
 =?us-ascii?Q?vLwdmHklkfT/VfZgEWV0juNKj01M0tFyHf2dPdJf/030wjtkytcV/EtaQ4O/?=
 =?us-ascii?Q?z4y80I0XQgaK8Pa0io8xcrq7156RTWM05O6z5M907U+LPQI5E3gdGyKJ+ZqT?=
 =?us-ascii?Q?8g2JHnaUDIr66CqfO7+3TpRQYkaJv3hZIVHwRlnG3+pbOZB4Wph6CSJ4+H9/?=
 =?us-ascii?Q?whkQpChbZvtavLVHkedSyUwlfPT0QLTsjXWxcWxLae5/K31q79NmRNzzfT0Z?=
 =?us-ascii?Q?WMA4FzqRbMI+Jiou/LSlH7/SBms2NiEfcCPkZ3hYCh1j1Pm3nHNaHTgyz8Va?=
 =?us-ascii?Q?38j5GxeKUI3c1k9a7Wqomx0pFyfFb0RTzoB6i4wnvOhWo1DJfH+6ZaqEYIOF?=
 =?us-ascii?Q?ukjh6AOOK++hFpA4JMLDZWnM6INZuVhL9yA6Y+AA+cebMbrfR2JtqJWUnMsY?=
 =?us-ascii?Q?5S1I+ogqyo11pcsBNYB28Z2HMr/uxKnYDKNlLSMhRTw98/BV1G6/uJbPQm5p?=
 =?us-ascii?Q?JoQOvzpSRNYhXCYk/xZja+ScSpK6wNrGgGkBV52FMCpa0lPu77mnLhS+xAKJ?=
 =?us-ascii?Q?loRlecNGJiFJpyjb90PIldzuu1iFmuXHICpR5P5fTteESM+34DFyfCR0URun?=
 =?us-ascii?Q?+MzLQxzidQh5LCs9+miDhh+cs747x55/lCEBgP8whvFI7tzXnBLOrWmDb0Al?=
 =?us-ascii?Q?NHYMchOzRQTdCYQdEj/csktc/JwJf7hw+FhrnQjB42P1FL/KqxZwTnwfXFBy?=
 =?us-ascii?Q?CxR2/vDuxviy/dzItDPJ997NlQ4hWa8F5Ribko282GxH+EDEE2Mg5NkS7GJ4?=
 =?us-ascii?Q?wHmrpnOjtNAUHLLKuWNPix22nreTwPxqRJ2t6jUn7XfOiuMPbbvvJAiYEpHP?=
 =?us-ascii?Q?gBYdd2fDbDkYdWETD0CXJ7eIPSXMf6jdfmy/UrNttdczvF5IAqPZYToLCt9Z?=
 =?us-ascii?Q?sATEXDKda9kGxZQxLQ60VrArX1dq4LgWCFqdJi8Sogqkn/2WUF1GnuWgoXJN?=
 =?us-ascii?Q?C+ab4CL7mHN5G7slgRXGLtP8Fo3Bkvw/brFPi9dABGojzRtSBjSlYOIFFCY4?=
 =?us-ascii?Q?fuhyIvHPNaXFeIqGe6E8cjdMN1pxq/O2AoxqWFVnbvQekt0s6uYoc4CZzh9f?=
 =?us-ascii?Q?CahcF3mz2QMNgevM3LUYJEaY1soTcnwkAnjIkuMbzuncRwUwQnswHfUAIRo+?=
 =?us-ascii?Q?m/e8JVRek/hHewLK8+vGAqxdFUlW9/pGetWcxWJK8+qMxR+yl3pbiN1v/MQU?=
 =?us-ascii?Q?neH3ZOuKiN/Vw/489mtBJxlzWO+3FHJVaRYMHd0vHhx9fFofGmgasQ0sqsfR?=
 =?us-ascii?Q?qNdiEI8rrl5owSa9TinxD2sl4/PBRwCN0ZqSJ1Nm/xWdHwM4bX0jR8CnIqoY?=
 =?us-ascii?Q?kZGVzcJmXnA6pPWnDktvcp95v71Klp+oQoS7oYSKKiHjsb12Ep6V1vmlZd3u?=
 =?us-ascii?Q?xSoAPm3Y/lBMWIADMIaqj0BYeoTG725m7YUaSsQ0JyXJdR8NCCPoz9MY+/F4?=
 =?us-ascii?Q?7trruT2ArS0MVvDMaDa+rLyV/4hKgtPjAkanuiYLHukMGUQ6EDG5l9bHirbB?=
 =?us-ascii?Q?duG7EcVT+FjxdJLZGoHw1a9oj6sQvNudr1FvhAzd6YU85pQMvuy2gFUvUrBL?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BlGRQSD6xWFOZ7ydocAGPprpxn5NuOEWpaN9hrL9Vrg4sjxIPvKxCLc/JYh1mjOq6UAGdToXktp6xm3cJzRaN6yPPhz3/EW0/Ht5v7iDS7V3VF83262Ni8QDN/vkq23ib1pDRRmRyxponGTXcK+OH//VhSrZ7kRry2qlzkOmKG9FiYk7VDYzTdhckqVDls/2TprF0EUt0s92sVAyMtgQr8yR86znZ7rcTJm+MBhytLIi/F7oq/wiz6XzIEHFyPVNX6/OwUjyOFFn77jCruPgew+2t2QPdonjhh1hSqw3rhEi2OarK7qx50yIWfg5WjiXFAzLJb1XIwYTLeXlWXUEr4OmKBRrw0EokaNWtiT1109iihJbIpbfGlADOHywR4ZpKA1UZbufEZUQMRhndCoUnVw0NXVoe0FmhWU7QCHXMwpdEpwz1Zoc9xPLYHROh9jTWs9N0y/WAkypgZ7womU29IKS/sL/cHJIuDEdiGdCkl2fhYeW70GfyOT828MKFuymOrCFL+igxtCu0LYC4DMUUbLt3tgWY2y+9KMmlNSCvmpC59L/XLSjRl+CBwyGa9jsnkbkjDxcoD0H2fynw2RaxOh/bGEaBuNmfQPdFBpVX34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636e381a-d02c-4a83-0f6a-08dc0d3a7a73
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:33:19.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gF8gSEHBwBb8jynR8KDXxAGltCtzt+S+l7iQdIxzY3PyQpcHu1vpfzHqap+Nq1ESEixSpDK0WflaHAtrKGt/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_09,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040122
X-Proofpoint-ORIG-GUID: iBtKUhZrP7UCQ-ROl-xiqTAdhKC5t0rW
X-Proofpoint-GUID: iBtKUhZrP7UCQ-ROl-xiqTAdhKC5t0rW

On Thu, Jan 04, 2024 at 10:20:55AM -0500, Benjamin Coddington wrote:
> On 4 Jan 2024, at 10:09, Chuck Lever wrote:
> 
> > On Thu, Jan 04, 2024 at 09:58:45AM -0500, Benjamin Coddington wrote:
> >> After commit 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on
> >> the sending list"), any 4.1 backchannel tasks placed on the sending queue
> >                       ^^^
> >
> > "any" ? I found that this problem occurs only when the transport
> > write lock is held (ie, when the forechannel is sending a Call).
> > If the transport is idle, things work as expected. But OK, maybe
> > your reproducer is different than mine.
> 
> Any that are _placed on the sending queue_.

Ah, I misremembered: I thought all to-be-sent tasks were placed on
the sending queue. But no, only the ones that are put to sleep are.


> > One more comment below.
> >
> >
> >> would immediately return with -ETIMEDOUT since their req timers are zero.
> >>
> >> Initialize the backchannel's rpc_rqst timeout parameters from the xprt's
> >> default timeout settings.
> >>
> >> Fixes: 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on the sending list")
> >> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >> ---
> >>  net/sunrpc/xprt.c | 23 ++++++++++++++---------
> >>  1 file changed, 14 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> >> index 2364c485540c..6cc9ffac962d 100644
> >> --- a/net/sunrpc/xprt.c
> >> +++ b/net/sunrpc/xprt.c
> >> @@ -651,9 +651,9 @@ static unsigned long xprt_abs_ktime_to_jiffies(ktime_t abstime)
> >>  		jiffies + nsecs_to_jiffies(-delta);
> >>  }
> >>
> >> -static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
> >> +static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req,
> >> +		const struct rpc_timeout *to)
> >>  {
> >> -	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
> >>  	unsigned long majortimeo = req->rq_timeout;
> >>
> >>  	if (to->to_exponential)
> >> @@ -665,9 +665,10 @@ static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
> >>  	return majortimeo;
> >>  }
> >>
> >> -static void xprt_reset_majortimeo(struct rpc_rqst *req)
> >> +static void xprt_reset_majortimeo(struct rpc_rqst *req,
> >> +		const struct rpc_timeout *to)
> >>  {
> >> -	req->rq_majortimeo += xprt_calc_majortimeo(req);
> >> +	req->rq_majortimeo += xprt_calc_majortimeo(req, to);
> >>  }
> >>
> >>  static void xprt_reset_minortimeo(struct rpc_rqst *req)
> >> @@ -675,7 +676,8 @@ static void xprt_reset_minortimeo(struct rpc_rqst *req)
> >>  	req->rq_minortimeo += req->rq_timeout;
> >>  }
> >>
> >> -static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
> >> +static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req,
> >> +		const struct rpc_timeout *to)
> >>  {
> >>  	unsigned long time_init;
> >>  	struct rpc_xprt *xprt = req->rq_xprt;
> >> @@ -684,8 +686,9 @@ static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
> >>  		time_init = jiffies;
> >>  	else
> >>  		time_init = xprt_abs_ktime_to_jiffies(task->tk_start);
> >> -	req->rq_timeout = task->tk_client->cl_timeout->to_initval;
> >> -	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
> >> +
> >> +	req->rq_timeout = to->to_initval;
> >> +	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req, to);
> >>  	req->rq_minortimeo = time_init + req->rq_timeout;
> >>  }
> >>
> >> @@ -713,7 +716,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
> >>  	} else {
> >>  		req->rq_timeout = to->to_initval;
> >>  		req->rq_retries = 0;
> >> -		xprt_reset_majortimeo(req);
> >> +		xprt_reset_majortimeo(req, to);
> >>  		/* Reset the RTT counters == "slow start" */
> >>  		spin_lock(&xprt->transport_lock);
> >>  		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, to->to_initval);
> >> @@ -1886,7 +1889,7 @@ xprt_request_init(struct rpc_task *task)
> >>  	req->rq_snd_buf.bvec = NULL;
> >>  	req->rq_rcv_buf.bvec = NULL;
> >>  	req->rq_release_snd_buf = NULL;
> >> -	xprt_init_majortimeo(task, req);
> >> +	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
> >>
> >>  	trace_xprt_reserve(req);
> >>  }
> >> @@ -1996,6 +1999,8 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
> >>  	 */
> >>  	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
> >>  		xbufp->tail[0].iov_len;
> >> +
> >
> > +	/*
> > +	 * Backchannel Replies are sent with !RPC_TASK_SOFT and
> > +	 * RPC_TASK_NO_RETRANS_TIMEOUT. The major timeout setting
> > +	 * affects only how long each Reply waits to be sent when
> > +	 * a transport connection cannot be established.
> > +	 */
> 
> I put this on 2/2 like I said in my earlier response.  I've been trying not
> to make a delta on 1/2 (yes, even though its just a comment) because there's
> a nonzero chance a maintainer is currently testing it to fix 6.7.  I
> probably should not have made these two into a series, except that the 2nd
> depends on the 1st.
> 
> If you definitely want it here instead, I will send a v5.

Got it, I didn't realize 1/2 was immutable at this point.


> I think we're probably going to be stuck with a broken 6.7 at this
> point.

Well, 6.7.0 might have the bug, but unless I've missed something,
1/2 will get backported to 6.7.y pretty quickly, even if it goes
in during the 6.8 merge window.


-- 
Chuck Lever

