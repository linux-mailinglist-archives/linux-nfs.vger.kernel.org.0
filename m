Return-Path: <linux-nfs+bounces-991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CE828A02
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jan 2024 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F2C281F2B
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jan 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D793A1CD;
	Tue,  9 Jan 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QEMhj7ly";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EOqPrfs5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5843A8C6;
	Tue,  9 Jan 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409GPEer025936;
	Tue, 9 Jan 2024 16:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=xr8huy3gazP2a0Ey5nQDAkGMDBioWZL4ZKAnE3vLA50=;
 b=QEMhj7ly/9ptTo9GSxiPQWQNuCxwulbdMBQyW8Srptkq6VAmjeeJ6u/tFYZC2ngt85sR
 K4oBfqlZhYtlK3GMRlKQ47i4FrrySMBgezEIQiRI1lj6MGh4ueNtmIcxqCXXJ9enkCP8
 s3Q36mFSCKFdNPk6l7CEtf//BFSm+OYp7uiyFYPVrLhZt6d+9xV4j43D9W/YO8u7tnVK
 ZVUP0Y1u50pVuERGgt7FViCVGqBoxOyWoURp+4pqZF1HO2PvwaRJ78T7s02ciijSbzOI
 7DllgriTc/fGBtiSFlGMpyWHW7HdsJpzy1YxJdSD7+MT6QiwHH9Ky2H4jMlcz5ov3xhM Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh8d1074m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 16:29:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409G3rNG008614;
	Tue, 9 Jan 2024 16:29:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuuj7xx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 16:29:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtFfk960Dey5IX6zGsyfsriCnndKZKeIYBKzwpKkURL0mftj2vYLVbpLjy6BA6O/tfZ2O0SOfLVWqP4UHV9jB/Mox/bCXrUb/3Rj+uSftU8KvB0BoneWOelHUaiC8OIdzvH/xKj9J34TKPZjF8WjRKsRdQTYCixz+DikmtAJQllhOkCNV38L8RHBvhCszKf0kc2un9V2wR2dHd9MGklFpik6avibWt4d6vWEdhp9HWI+nWA5H3Tp4f6+DJXPkzMggkL2Dvs4d86H10g1PURU4z7a31B2B990uPH+aT/uMM4cRh7/Pl9KJ1eGYub66h6SBSPvOTFHjVAeEor46HrJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr8huy3gazP2a0Ey5nQDAkGMDBioWZL4ZKAnE3vLA50=;
 b=HyeobuqHxxYZVNDDgnCFv7uzhiC3l/0ema1mYgYvrgVo+la8Il0askkD+shrYsQwStQDtWgYNOBGINbDtuFSsWCw0gQcNLr6M/6mrp4eNCxF9Ox6JJm3Hs7wEiJXI2N3XXOjby8T6cA63Bh8LHJXTyBDuZrqlFnL3inhFsv7Xjm02NOEY4Vx1HMYwRdtXTQPXqljZFT8mQXKTaNix1+yNMdK442QpiDAi/uPRcZ6P05aPLYM6sShvW7HJI5KjhRc3iuWanWD8UrO5/ZkUpUIz702JUx/UQtF3IzgTu30+spYkM1JujLbmTQ5kTwD/VWYTvReRroVVkHZO6DeoYL8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr8huy3gazP2a0Ey5nQDAkGMDBioWZL4ZKAnE3vLA50=;
 b=EOqPrfs5iheg6/QMwnYsUrCDyOJY2DOG0P4SRa850TLad3/pC2WVL5IWpRvxPRH3zNj6cOREER1tTC0MMGltlZGo/2i1/igtvAyHazImwnFNyuMz5HrPUov0fKzoJjZxoj18vWA98lbA+l38JHNNl01+Y4ZiAFUZuHI9Drwoq5E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5917.namprd10.prod.outlook.com (2603:10b6:8:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 16:29:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 16:29:42 +0000
Date: Tue, 9 Jan 2024 11:29:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] NFSD changes for v6.8
Message-ID: <ZZ10c3vzhM/CVjQs@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:52::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 507cc58b-d297-4932-37b7-08dc11302f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v7ujZpDHcrSX3pjZAaLk47JQ0CHFxEotXptCGjxu5d9eGiugwsxzdBtRGcMu/VQddXFBKzc9ZorU6iInJg47rNVDKdLWVf3MT3CvrBHhutrS38Hbx3zDTZGqOxPfuC54adv+4Zf9ONv/+U2Hv+1lU0qMczQgpIAH1Y2IjxVxRQclIpqfRGmgRVNT0ZzJngV8VgetjB/R3zJocoJRupahkjRuF1BI6xxQG61U8hZ5A3hL2QmsSxQeg4WckBD0jSIjBpEsFOK7gGcfW0EccVJ8HbM2SmKO4+OFgZz/1/4XlMexei4QUNqxsT5kDXoO2PlV1I56h9rUU+fTulnHn451y+RGIDF65fU+obpLKgrK3P8lPbvITqKBudQdPkcfl4e21ltgp+saQXQu+/32k+2aGZ5ByyqmY53osHHIKWRDOjmuLMzdNTuxvzRN55NcRGLbEe0tItdYQFN1M8o/eaHUH3volYs/EaUxWKpHsi8XAgW5Mriph92l21H1nMI6r9O4Oxcp58PV//Ddukp8cnb0PImT5BXdcBkuD+FlRrmGCYmzIRbkO56KW7hhxlAFHJEGnylqi6qP20/N6ofM4xrvhFEpD306yvmgjKcwbQs9hb65NVobls+5T1CrFT/foMzf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(6666004)(6512007)(9686003)(6486002)(966005)(478600001)(6506007)(83380400001)(2906002)(41300700001)(66476007)(316002)(8676002)(66556008)(8936002)(44832011)(6916009)(4326008)(66946007)(38100700002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kfyeEwVlrkuIGSTlgAWNLjjqX+md7GzV6m7gE91dEpL1wTmzd8jSnwzQTJur?=
 =?us-ascii?Q?Fom0NKb+fZflbkUfJtCI42ryvsQk9/J5iTvtyO/E8inrrk0a33zr74gqZ4Cg?=
 =?us-ascii?Q?UJEO+vZgp8IYUCn/4dR+NJrerC30jW6DBCCLmiW2L+VWFjyIQht8Cck9AMqv?=
 =?us-ascii?Q?PLHW/V8R3rAXD40WAyNA7A2qlzilBbkFjN6Xq2GYMYvO5FrDSsd37EDfptzl?=
 =?us-ascii?Q?irWggrLNdjtahYHJSamoXf8BOemDCXa2sCJzepJZF5U1snDsRLVgfd6ANO7y?=
 =?us-ascii?Q?wQG24nmPPoSTKl20C1UWFcP80rqyOLlJ+3JdtBfqihiIOAymRkWPU/pbxTDl?=
 =?us-ascii?Q?PFj0WV/6LT5qWDxBALgYmb1yepnkW+XQsmp9HuRvg7C4HsXdGMnH3L6phfRP?=
 =?us-ascii?Q?e4zmpJDBQD07ADJpVfeGfMbbFlimeTeBZMN1TSd+Xz41g5mNc4L3YKu7IYGz?=
 =?us-ascii?Q?LrdXXUbE0D5B0N8ofXqFZWrjagiW+DdIZK91GGCLC+yQI+ics7rpUavac5gs?=
 =?us-ascii?Q?9I5Ut8ONwE7peRwoR32c9gsx+pbxr26HXX0de87HmDj8pb2ahTiykcT/BTlc?=
 =?us-ascii?Q?oZ6RZp/nkD0gq8uhldM+ItXe94ISiiwg2Ow894q+B8eP/cgVsDgDyupenFk9?=
 =?us-ascii?Q?mUWZNYSVYq6EPHi5UMvYuY4PidVuiGfN4dcvq/qlXDD3zTuawa91sW0ibH7i?=
 =?us-ascii?Q?C/oGB/EbzpqAmhJy9D8mdWjOwe9FyXei2uRD4wlqxauKdlqqkNPLHmEq5UBb?=
 =?us-ascii?Q?3popN9Fw1sn12Ks5gSHQNuokGkW9mSrw+3XG2U71FVJPhg8/GBEvqg3/8KJ1?=
 =?us-ascii?Q?ZuK6IaByeQ92w7I9nB6GIBcDWE5s72DWKn5tai6eIXc7YjUr80FzqSn4Fn1K?=
 =?us-ascii?Q?iSJ9NOYHRh2h34fan55qHEWYcg3kk/sFOMJ521Yt9CSUn4fIDhTBJUX9FsIh?=
 =?us-ascii?Q?XmGhyJzanCvblH8seNKRxwQ4esbRb0pGniOd5LKSToAXmlKG+hVZ4/nRiF2r?=
 =?us-ascii?Q?h0g6LpluFiQ9FJfB0ryfL4JPU+fhwSz2x3JbEyIQMvQ1w4cKokCpO6Y4omKA?=
 =?us-ascii?Q?Pity8rxJMWeabIUcy/rkFxHdcUJboQKWUzJvbDCiBzA0lJxFOalX3He8zBFs?=
 =?us-ascii?Q?rmmRC7hZ1PlHicfiPW5KBTs4nAqkG/pwxGdaptVps6JVJQLJwAU+OjZP6Z50?=
 =?us-ascii?Q?aGJts9vGApZ0Sw1zs1CT3pDkpt4o6xy6nZVqSFWrT02ZxHuVcsyHD0vr0jAZ?=
 =?us-ascii?Q?JUxaAf5vIgZCXsWYnqn4tMs5y7a4T5N+J1G7H/8lGVV6fzZqB6rBPxMQT3ls?=
 =?us-ascii?Q?IwjBdWjlOyhoLixmkGGvE9IA2zcj648r4vItkY+v45EuJuMLWQDrkBKjhNbn?=
 =?us-ascii?Q?Nxr2LtGBCofCsQ7ltQpRzATZMnR43NIyTpwpQpWUac01Zqng7vzkgqa9UVlu?=
 =?us-ascii?Q?GVr4Xc2LNkmBloFb4vMJn6pNxUD/32OdQQKCDlxYCOPFYVgAJn1vCjiAphI3?=
 =?us-ascii?Q?Av0wcIEkMvem2lvvMq0opFH0VskLQuq8fUNZLkDy0MlKjtEFayku/L3FtPS8?=
 =?us-ascii?Q?VFRssI862Uo6AteoAJQlW+u6t8Lm/i+qrIp0sKEPpmY7z4c7VWZsrTQ0M5oP?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hs1JK+NxEAIpZboYhpp94d/cuHmXUXn8dGvFqDHz+SuNzVx1sXWHaxDaQcJGElkgH1dagvrIScmIzYZTjIj4JXpRELOVIgZgPx1lTf4PrgFbiXJm0oyEYZVqI7gQYPwED2h5d9UVwabdF8DUN/KZzExr1fOFt3w0pvQeiORDplwD2DBoazUfuZrew2JsxSzx7JwVDwU8vJJO2YKGzqHF78wEXzCTvUkLyTqiS7+ZlCpeDcxkdMkKAstVN+NQ0EAJeGq0TswhyzTFoyElpyOuvA0SwDMeSqCPZPQo2Iy5V5LRbHSNrZKOU9JIwmnh7UA5p5sGYJcsqkXCNzBAiECOK2Gjz67va5QB+CIFVrdndd1c2v+lZ+sHLB6AUP7FN1IHrKqPyD+bL3jfMrwGTWD2q38m8bA0UVsPOt2P9jGtpE2IKOjtSivwhufb7oC4P8G6xOEOFBAdsuVXNxvnZyqMCrMXdApZTRYAKd9lT2m1+JyZwjzB5WfUHSUM8EIELAdIm1H13cQf8wKFJZw/ZUcZ3aXmPc/AhVcJtgty1TkGfCbUMRHdRb7HAfGHChc/IhxemlAi1EgOKFMSBCfBRDXMDEPza8aOTim9pSiMIFoBA18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507cc58b-d297-4932-37b7-08dc11302f2f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 16:29:42.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISfWPamdfPNEVm+Okk0U73Eey5YwRrrJg+JjvAaykPg0lf3++D/JIQ09IiivHOe8X9oWJ001hUs3W2fPiKwDYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_08,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090134
X-Proofpoint-GUID: _ZRVX3sx71ON17ye5GtAVlbECVc-twLf
X-Proofpoint-ORIG-GUID: _ZRVX3sx71ON17ye5GtAVlbECVc-twLf

Hello Linus -

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.8

for you to fetch changes up to 17419aefcbfd9891863e8b8132f0bca9a6b2984e:

  nfsd: rename nfsd_last_thread() to nfsd_destroy_serv() (2024-01-07 17:54:33 -0500)

----------------------------------------------------------------
NFSD 6.8 Release Notes

The bulk of the patches for this release are clean-ups and minor bug
fixes.

There is one significant revert to mention: support for RDMA Read
operations in the server's RPC-over-RDMA transport implementation
has been fixed so it waits for Read completion in a way that avoids
tying up an nfsd thread. This prevents a possible DoS vector if an
RPC-over-RDMA client should become unresponsive during RDMA Read
operations.

As always I am grateful to NFSD contributors, reviewers, and
testers.

----------------------------------------------------------------
ChenXiaoSong (1):
      NFSv4, NFSD: move enum nfs_cb_opnum4 to include/linux/nfs4.h

Chuck Lever (48):
      NFSD: Make the file_delayed_close workqueue UNBOUND
      NFSD: Remove nfsd_drc_gc() tracepoint
      NFSD: Document lack of f_pos_lock in nfsd_readdir()
      SUNRPC: Add a server-side API for retrieving an RPC's pseudoflavor
      NFSD: Replace RQ_SPLICE_OK in nfsd_read()
      NFSD: Modify NFSv4 to use nfsd_read_splice_ok()
      SUNRPC: Remove RQ_SPLICE_OK
      svcrdma: Eliminate allocation of recv_ctxt objects in backchannel
      svcrdma: Pre-allocate svc_rdma_recv_ctxt objects
      svcrdma: Add a utility workqueue to svcrdma
      svcrdma: Add an async version of svc_rdma_send_ctxt_put()
      svcrdma: Add an async version of svc_rdma_write_info_free()
      svcrdma: Clean up locking
      svcrdma: Add lockdep class keys for transport locks
      rpcrdma: Introduce a simple cid tracepoint class
      svcrdma: SQ error tracepoints should report completion IDs
      svcrdma: DMA error tracepoints should report completion IDs
      svcrdma: Update some svcrdma DMA-related tracepoints
      svcrdma: Reduce size of struct svc_rdma_rw_ctxt
      svcrdma: Acquire the svcxprt_rdma pointer from the CQ context
      svcrdma: Explicitly pass the transport into Write chunk I/O paths
      svcrdma: Explicitly pass the transport into Read chunk I/O paths
      svcrdma: Explicitly pass the transport to svc_rdma_post_chunk_ctxt()
      svcrdma: Pass a pointer to the transport to svc_rdma_cc_release()
      svcrdma: Remove the svc_rdma_chunk_ctxt::cc_rdma field
      svcrdma: Move struct svc_rdma_chunk_ctxt to svc_rdma.h
      svcrdma: Start moving fields out of struct svc_rdma_read_info
      svcrdma: Move svc_rdma_read_info::ri_pageno to struct svc_rdma_recv_ctxt
      svcrdma: Move read_info::ri_pageoff into struct svc_rdma_recv_ctxt
      svcrdma: Update synopsis of svc_rdma_build_read_segment()
      svcrdma: Update synopsis of svc_rdma_build_read_chunk()
      svcrdma: Update synopsis of svc_rdma_read_chunk_range()
      svcrdma: Update the synopsis of svc_rdma_read_data_item()
      svcrdma: Update synopsis of svc_rdma_copy_inline_range()
      svcrdma: Update synopsis of svc_rdma_read_multiple_chunks()
      svcrdma: Update the synopsis of svc_rdma_read_call_chunk()
      svcrdma: Update the synopsis of svc_rdma_read_special()
      svcrdma: Remove struct svc_rdma_read_info
      svcrdma: Move the svc_rdma_cc_init() call
      svcrdma: De-duplicate completion ID initialization helpers
      svcrdma: Optimize svc_rdma_cc_init()
      svcrdma: Remove pointer addresses shown in dprintk()
      svcrdma: Remove queue-shortening warnings
      svcrdma: Clean up comment in svc_rdma_accept()
      svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
      svcrdma: Add back svcxprt_rdma::sc_read_complete_q
      svcrdma: Copy construction of svc_rqst::rq_arg to rdma_read_complete()
      svcrdma: Implement multi-stage Read completion again

Dai Ngo (1):
      SUNRPC: remove printk when back channel request not found

Dan Carpenter (1):
      nfsd: remove unnecessary NULL check

Jeff Layton (1):
      nfsd: new Kconfig option for legacy client tracking

NeilBrown (3):
      svc: don't hold reference for poolstats, only mutex.
      SUNRPC: discard sv_refcnt, and svc_get/svc_put
      nfsd: rename nfsd_last_thread() to nfsd_destroy_serv()

Oleg Nesterov (1):
      NFSD: use read_seqbegin() rather than read_seqbegin_or_lock()

 fs/lockd/svc.c                             |  10 +--
 fs/nfs/callback.c                          |  13 ++-
 fs/nfs/callback.h                          |  19 ----
 fs/nfsd/Kconfig                            |  16 ++++
 fs/nfsd/filecache.c                        |   2 +-
 fs/nfsd/netns.h                            |  11 +--
 fs/nfsd/nfs4callback.c                     |  26 +-----
 fs/nfsd/nfs4proc.c                         |   7 +-
 fs/nfsd/nfs4recover.c                      |  97 +++++++++++++-------
 fs/nfsd/nfs4state.c                        |   2 +-
 fs/nfsd/nfs4xdr.c                          |  13 +--
 fs/nfsd/nfscache.c                         |   6 +-
 fs/nfsd/nfsctl.c                           |  24 +++--
 fs/nfsd/nfsd.h                             |   2 +-
 fs/nfsd/nfssvc.c                           |  69 ++++-----------
 fs/nfsd/trace.h                            |  22 -----
 fs/nfsd/vfs.c                              |  46 +++++++++-
 fs/nfsd/vfs.h                              |   1 +
 fs/nfsd/xdr4.h                             |   1 +
 include/linux/nfs4.h                       |  22 +++++
 include/linux/sunrpc/svc.h                 |  35 ++------
 include/linux/sunrpc/svc_rdma.h            |  67 +++++++++++++-
 include/linux/sunrpc/svcauth.h             |   7 +-
 include/trace/events/rpcrdma.h             | 254 +++++++++++++++++++++++-----------------------------
 include/trace/events/sunrpc.h              |   1 -
 net/sunrpc/auth_gss/svcauth_gss.c          |  16 ++--
 net/sunrpc/svc.c                           |  15 +---
 net/sunrpc/svc_xprt.c                      |  32 +++++--
 net/sunrpc/svcauth.c                       |  16 ++++
 net/sunrpc/svcsock.c                       |  14 +--
 net/sunrpc/xprtrdma/svc_rdma.c             |  32 +++++--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  11 +--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 211 +++++++++++++++++++++++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_rw.c          | 450 +++++++++++++++++++++++++++++++++++++++------------------------------------------------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 112 ++++++++++++-----------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  36 ++++----
 net/sunrpc/xprtrdma/verbs.c                |   2 +-
 37 files changed, 923 insertions(+), 797 deletions(-)

-- 
Chuck Lever

