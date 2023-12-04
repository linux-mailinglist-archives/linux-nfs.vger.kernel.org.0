Return-Path: <linux-nfs+bounces-298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E480388F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 16:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5601F2119B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E02C1A0;
	Mon,  4 Dec 2023 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NMPFt0LU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cOKSaxLK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1F127;
	Mon,  4 Dec 2023 07:19:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4FCemN026172;
	Mon, 4 Dec 2023 15:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7NGrsRTS4ftuaA/q1WKt7/JGxR+bWcAzLaNNvldnFi4=;
 b=NMPFt0LUyBjvguokHuYOg/dxY1QpCJI9SRqGpwS5REJdvOVmKalPMRxLeotmjoQwz5Eq
 XiBxtUOfE4S31S7+piT9yyUQhGwXxYbPBYRksQl2HyjxezM1XO778FCiKCS1xP2d68tt
 292r/ip8/1Vvcrkw+/oPNNpOXcAbJsTHyDuaKEzmiJsa+lL7IFHfTby9U0Gxsg4k2qm5
 GSviKC+82nrEtgRSnkvYT3YnAzojAB1BERl6VCvEF/HJDdfD/AuHvIkG7LATUQTzii7V
 USkIUTVtg0Z+f42cxOtkKTrjJrvkjLie9ycz5EbXuddzq3yNWGZc78QfRAA4aaVrprhU aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usfher9v2-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 15:19:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4EE0fj003977;
	Mon, 4 Dec 2023 15:00:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15xs7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 15:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyNdBhLQhWRkaed7JfyHiTpIYiQHPhL/9YHi8yw/prOEFqYfmSsGnkoetdVLKFAgNOpQCeQ+8rhmW5xuAl4s+Ch5C2zMnkCxy6ccl4tWSSri1+ZWis6RPH1jruA0bG+k1YdATDFB6xGrFkbVOgP5E+9cy4OPt/q73kHY4Kcb3Hc2mOexr2yZ9M9wY6emMsn2UzkDk6kycu+vlNefxquP094T8z24GU8H0RBKQkkIf/IcMjJfJSjydUCoExP5VEf7m2isE6bKItTYeUBCTdkRdtS8tj9UD7oiRiwpp/yQcG2cAf+SC4MObGeS8SSLX+CDFsW0JQO+FnLi7NEkitx+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NGrsRTS4ftuaA/q1WKt7/JGxR+bWcAzLaNNvldnFi4=;
 b=ZyJJQ+pHidj7h1L0Fy/AoBPvE+2SWaTYnmlWjUXaiXvC4d4Vsae88J21bXXw7iqllOJnmBG8VdJP3JOM8vqTXhtbbASshIKMH6RxpHxyRCsc+6fUbhbQebzRvxPhcEjPDQonfKFohaCHSiBqzCfyD3iy2TzBflt8ja42BVYXfsYN2msW/ODg71wJXJRyCznUFqqtvqrcmxPDUEuGupG0RMfxrRoMfKOgt0Gus6E6M/LOgVs76Knkb6gtCnxNniaGrvAjOYMgs/GRdUCJwlRNmYCHgLAN+19y6KWNDmV5najYx8VS9XGFhH68iCh6jyfj62KhnUNHPQME5UnDDG5Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NGrsRTS4ftuaA/q1WKt7/JGxR+bWcAzLaNNvldnFi4=;
 b=cOKSaxLKVvEtvQcfhNMI2WUedDhf9JzThh1FybbGvRghha79FawbEULdjtCADYnMu50T9TWoSFlBZqpyKCiR0cMxod0Ne3/OVtkfoA1zXXRgo2V9SOZcaherx63Q7WiDgY0bbaeBqhMU8scXsIwTLsX/48yKQhrBeIh0Yv/M54s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 15:00:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 15:00:42 +0000
Date: Mon, 4 Dec 2023 10:00:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, tom@talpey.com
Subject: Re: [PATCH v1 00/21] svc_rdma_read_info clean ups
Message-ID: <ZW3plwcQjBYowR0d@tissot.1015granger.net>
References: <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
X-ClientProxiedBy: CH0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:610:cd::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9e1164-4d87-4cc2-f716-08dbf4d9c904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wWSR45XaZH9mJsqTXSfvvskkrBJ8MozLivXCur3styNUlqDoOEE80QB5cTj6XAzSScc/E7YBJ7a/wO4QtyYC9ESayuj4aQH4XTWCflZLqIcOY1gIgVFyWE4J19kONfSSCTgbsk3+R7TVXkRmHRSMruJFTBAwvT0Bs74LEzymv4gwqmuediFcpJvNwFDbpqKrE/G4qZW7+xzXoJvTjuLJqoxVnMRMIOMSd9N5q3aYh+bTIcRjHbNDDYJRrVuRbDdQ1E2N86iIchSlMcUSNwtL06DIOl3EdH7WGnG8SJA8gcaSiM5cYvDbvf4m1hsnzCkNVcOHm++j1pEGWLlW/nXg1mmWGQ4fV2jzvqN+xOO7ur4eigKPlODn79qmsJkbB0DkEiPDFmVrjEQkeghHm+kFRspTXQXePrl3EEW1kA1omMDkACAzn82ALQq/oowQU9kK0ldATpEVm1NtkC5yQvK6QqPn6Zr8G6XueJD2y5MSceGP7JOePVbpzIsWFBVyh29npL/6nLS9cbFhZfq5C5S0qCT8iVljbtanIN5gae7y95hNmXPtegX9p3UpaPEdv5PaNCIJIB8foL5PJ7Dh8ocr0Ef9q5U/EED5lLN17nELiEU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(8676002)(4326008)(8936002)(9686003)(6512007)(6506007)(83380400001)(26005)(6486002)(966005)(478600001)(6666004)(66476007)(66946007)(66556008)(316002)(6916009)(2906002)(41300700001)(38100700002)(44832011)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eE/qIqA7HMeflE3uQgYvKnabs3mAXrn46oiWvVA01+2U6lM70T4ESk6Zbxmb?=
 =?us-ascii?Q?TWd3p/1zK2EPXve0aLvYqDLAKSfytQFfM0do/VzCURPWA8Oz6VLr/2PymHb6?=
 =?us-ascii?Q?5U1LK7RypBk8SfwlZXeNMzeDFHBcZfQyU28JXOZBZhd7h1NXP/r+9V5nF2KD?=
 =?us-ascii?Q?fTyDcYN9UlFT1qCf9u8erqxAXT8zywMLpTA/PHw++AwA4n8gH03Vf+QsobzC?=
 =?us-ascii?Q?JZ+gbtlLgccNVfrfMIFWDfIUsVDqj603z0JC9yIhhGYNKuCc6SPnRFEaj6gc?=
 =?us-ascii?Q?0aTSM7b+cKBwNsE2/E7avJ3+ZGkrK4fn8TxOhnbAGKUNZPrmAT65NRXNn1d8?=
 =?us-ascii?Q?whiFYgqeZBHms+5DTL/DxQOJAAQhQG5sHZBE5w8u6tKN27SFIrswMzrbaL61?=
 =?us-ascii?Q?NiTS8LDqdgscFupO5DDuEz5jBl/jLAujwjtKHBJTQuLtH4DMorucOuzJ7ipO?=
 =?us-ascii?Q?kS6URKz9zOYeC02yPMj/BsY9FpEYyJxrgWPOpv5ND7Bgi81TSd7wW2rNoyX0?=
 =?us-ascii?Q?IUjm5JX9vgCNxMDKZYlIOw0dZgueDPvKbsEplzracJpYaUG2+oXQ/QVnzm/Z?=
 =?us-ascii?Q?ewq+jMiISiMUPRUBlmWH3ubfKmr7ik6mxWO1L2EIZe3DDGx/IJ2lyiXolbZp?=
 =?us-ascii?Q?8oK/T1BUEkjMygc6dHPoteSA1XSB9EEhXnXI8z6sUUZsfHgLGuv8Cjbbt7Df?=
 =?us-ascii?Q?pY+974bs+7zmLzsaAeAkt4IwrW+Cd5g224t8LquC7vSjcItSZHLkEVQxcFmh?=
 =?us-ascii?Q?tzrUbtMsKKeG3CJnSFVdaQ0QyyfxxCYVH6UvoFTYGsvTJnF9eLMfehZo6RWW?=
 =?us-ascii?Q?FG8sTB5mq3wN8WWwhOY4xFcdkVSI9zY1/UFrnKEyN4cBaKzLWrPrEw/Gjrg1?=
 =?us-ascii?Q?hb+XlkcDqT7WhEG0fFotfJAro+Nn4JW+dmns5NVQVTH457m7t3X3UuZTg+iH?=
 =?us-ascii?Q?7dUHLQDXOURPTkLjkw2AOJEJUWwQgSSLzIc28X9N3hI+IuAFsY+yLC0kd2ir?=
 =?us-ascii?Q?oKrskaJ8ZLTM+iZ8YlWIXj4E3uMCSvhkFDz5Bgtj7ATgD8hhTQGCJEbmlFOs?=
 =?us-ascii?Q?fBTYdqa/NO8WlZI1bddGobZtANKkTkHHOhSYlbdnJiYBMwQpH8gNCpXcKYzM?=
 =?us-ascii?Q?PjBbOjBNBJCfCb8XY2gFKHlyeHEksCgEsg3juYAUusXYuVk5p2FZi9B7Ct3W?=
 =?us-ascii?Q?w03LfEYWLB53nBiPlz0el+RU5bUPwDEJqNNhmClJw42ZpOwUXaeXROIZ0lYY?=
 =?us-ascii?Q?vIceVITA3H4b8voL723DwXC04lcsfrw3/Bt6R3m9kf3WAbNnpdqW1f3/9KsW?=
 =?us-ascii?Q?C2Tx0SjYveBORqyslBPG9szkSBGw35vPToKWFY8HAxEN76YKXO/ErMO9B+5p?=
 =?us-ascii?Q?SBcIIe6oriCmTIZ52cakBUj9FM7T1e9PM55a+ApOBf+0dzEcqsY4RuJgHiJI?=
 =?us-ascii?Q?yJkRQ+529ALy22pymG4Xj6K1XGIl+Z51xOpMM3pQm2V3sKRk+DgpupZi2UjO?=
 =?us-ascii?Q?HKSarIRXLpLdDC1RVi+q5uHXnL3byR9RJb51dDG2K7Y+H6p1uEmxthvru7Am?=
 =?us-ascii?Q?WaixbnqrFBe5QvOmfsMNjQa+1P7WkfwgtPa/wkp5Pjk4gdBPTyhfwHDzcXKm?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8S1P7bjXFCk/WDSsrAfUc73JyNqsabhKVillcMSthiaDOUFWQzaax/BZzoF4yA0PinKgC5MaEvTFJwTU1VedR5jRfIHhpvL2RWyBE8iMqAuLGUJPv2/GyDlrxJfrwa/3V+6M4L9nqMYQstfTy4BbgB+8b7YO7shwZlH3VaNQ3DJTqKiclHEteZglYnYGOgL3yXv8kRYuTzm2Bfu+aNhnLlIYfcjrTOVhb9gkkJq634HtUMtiBm4bCnXZtSL5VSHVL3Wktapj0yiqBqNcUBp1/3TMyqPXk/oi0Q+0OHUK75Cycp3wH/W+cnDdJnDPsM7Zlcxt6tcpCGIkmCiUdMFB6fbyIOSRJeXEWVtHFIRethF0Nuu4lkZhBLUoysEuSraBA6gDGDUru+GZfrHCrwjV1CJQteoT7sRkPV4F6A1DO+xyTcMMBuvhHggmQKz3qhy7nqWBrZpbbXXGcYJa+t6J2DgwG9cyZ5xEVTnqs+aC8fq39zO5lkTUAATMCLl785/tlSDkkvmhhy0kbr2ZrLzyExe85wbBzYNQUbkEPfSBQjbBhvHLkmwqMWtWE8mBU5L3NXq5LBGOlXNIFaIcSLL3hIIkCbdQc0JcE0TDCO88WdzwuRBzCJK2OMhstRLR6CfoTLo6YqfkILOxAD2E5jwagpOxJU3ArwPVZ/VdbWcAyaRyCghnPgoOzw3YiAHMJlAywEaSR68f2sjP4PmVqtTemuzL7RcPPnM36LYKCl9LJPS746QYWHV5Vt8NFgskAP70PIRYUoZUcfAq6Gl/C4Q1fMaCAbuA2Kqjncx3UAakFdgpAIuUElccaQ8kqr5KFQKg
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9e1164-4d87-4cc2-f716-08dbf4d9c904
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 15:00:42.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfrvGSkl7qO4B4csNUcpiq105kF2JR6WQlr/ioXoz1rPnxtzdIMNX67Jo9YZCqHqJFwcElo4rkncPq7tqVAPPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=655
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040113
X-Proofpoint-ORIG-GUID: 1s6FYiEscnc2tKAyHoyyxhqoQ3oc3co0
X-Proofpoint-GUID: 1s6FYiEscnc2tKAyHoyyxhqoQ3oc3co0

On Mon, Dec 04, 2023 at 09:56:18AM -0500, Chuck Lever wrote:
> These patches are in preparation for more substantial changes to how
> Read chunks are managed by svcrdma. There are a lot of patches in
> this series, but each change is narrow and no external behavior
> changes are expected.
> 
> The main benefit of this series is that svc_rdma_read_info is no
> longer dynamically allocated.

Note that the full series is available in the svcrdma-next branch
in this repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> 
> Chuck Lever (21):
>       svcrdma: Reduce size of struct svc_rdma_rw_ctxt
>       svcrdma: Acquire the svcxprt_rdma pointer from the CQ context
>       svcrdma: Explicitly pass the transport into Write chunk I/O paths
>       svcrdma: Explicitly pass the transport into Read chunk I/O paths
>       svcrdma: Explicitly pass the transport to svc_rdma_post_chunk_ctxt()
>       svcrdma: Pass a pointer to the transport to svc_rdma_cc_release()
>       svcrdma: Remove the svc_rdma_chunk_ctxt::cc_rdma field
>       svcrdma: Move struct svc_rdma_chunk_ctxt to svc_rdma.h
>       svcrdma: Start moving fields out of struct svc_rdma_read_info
>       svcrdma: Move svc_rdma_read_info::ri_pageno to struct svc_rdma_recv_ctxt
>       svcrdma: Move read_info::ri_pageoff into struct svc_rdma_recv_ctxt
>       svcrdma: Update synopsis of svc_rdma_build_read_segment()
>       svcrdma: Update synopsis of svc_rdma_build_read_chunk()
>       svcrdma: Update synopsis of svc_rdma_read_chunk_range()
>       svcrdma: Update the synopsis of svc_rdma_read_data_item()
>       svcrdma: Update synopsis of svc_rdma_copy_inline_range()
>       svcrdma: Update synopsis of svc_rdma_read_multiple_chunks()
>       svcrdma: Update the synopsis of svc_rdma_read_call_chunk()
>       svcrdma: Update the synopsis of svc_rdma_read_special()
>       svcrdma: Remove struct svc_rdma_read_info
>       svcrdma: Move the svc_rdma_cc_init() call
> 
> 
>  include/linux/sunrpc/svc_rdma.h         |  30 +++
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   1 +
>  net/sunrpc/xprtrdma/svc_rdma_rw.c       | 310 +++++++++++-------------
>  3 files changed, 169 insertions(+), 172 deletions(-)
> 
> --
> Chuck Lever
> 
> 

-- 
Chuck Lever

