Return-Path: <linux-nfs+bounces-2272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E216879523
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 14:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10C9283FD8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D97A146;
	Tue, 12 Mar 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITdGV+Kb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JqBc8+oY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334B79B91;
	Tue, 12 Mar 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250378; cv=fail; b=X03mO/KHqvnqkf3jHt465SnvUZw4WMHci4eMYllrWQJONZedRaQXDU8WRWDeXBrVzppcWHjDb43ez3BvMQzz0LMvqlFSlzP7TG8tJr1bq5Hh2cTDxBc3BZyqiVBxjlrPjFjZih1JvAYbnBKi/eTMbuQcr9QF7lcc+tvTtTkGNq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250378; c=relaxed/simple;
	bh=tGl14cVx1nMO6g8HnViuF5SEoUfEkjcGlArOecNXW5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=I/gC43BFwrs4mWMpqeWdXvvtVgbH5gkmWnV9n8/wbN0iwowtRmRLiPXU8Z52Ye0hVyOFFDx3rAnvIqnkezz2ub73leKqH90yx7avq5AULDZkFBttWXM2lwNHihppa0ZTraQh2YCNM5FKfmL4QwIkI0UVICqtuxuwnqWrU0QB594=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ITdGV+Kb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JqBc8+oY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CCYw1Y024581;
	Tue, 12 Mar 2024 13:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=9PZzp6j7owwR9wlZv/m5A48jT0tibOpnp2jjGsPR1gw=;
 b=ITdGV+KbvBy8L3MPOE2/QhBvTOOUQ5LFM3EXJHGcD2HziW7I/qh+5AlqeX3SD/XMhO3b
 C5qrIytQESAmt9xfyxFbB9zYfDS8GrsR310WGJdeTq7WSbZno5x/v5UmQ8loaDDyBVA5
 +7NFFAAjur/p1tkP9x3FLRPSoZpApY1n0DpcCJj89QP4U56WmVXDIs3AB6lYWTdk5wHo
 Ss3bqwsjmWf1b7xgC7WOs6kigWA8vGH23t9phMFf+ardMn2mA0RdVgG355i43RQAmodx
 uTNYJPifojouKUwQEoYLlIU3WAVcm2wZun3/1wq/wGr3rO3dBlSp/I0lvFhZsgrxtg80 6A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftde2dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 13:32:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CDEiQ5004779;
	Tue, 12 Mar 2024 13:32:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre77dcet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 13:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie6YQpLqCaeoUNsJXiw9XDMfFq6gAQV+SKLftoboMKd7IH6zoT/ezYiy24qyqrGWMA74JhbdwPXWWxkKcioDaxpHo2KXTGn/xLlv+YNA/aep9atMUYYnbBGM1MpiClWO2MBLa1X/rjZt1SfI8nn8MAW/FupQHd2wy0lJnJUkho8M1bOTsgu1XtUblQzXu3fETkt5f05qqKPCl4dYpcZ0hLycKPDe0WhfWuPyCtpYeFZ9RVv7iogx/cXlmwF0slQshnhnOAk6qDuEZ32Sf1gkweU6iWxhoyAxUCMQ0n9LpkUyz3ay3xHRsgibuvldAUfcP2JQQ8BrFyBy+80EmX+xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PZzp6j7owwR9wlZv/m5A48jT0tibOpnp2jjGsPR1gw=;
 b=UQMgmNiLt/aDaJ+wqOfqGEx3AXdJdX9wkjJcmrZSWOsNgpzns4cDcVX7ioWDfGfW+a2moebVvNQeGPMX0pHjSkrPCeKvPDxJD00gX4K7H2roRP+iOCFnEZu/bEqpDDWE2nFOvOJ+u4w2Q5DrMaeLA19xSPWipHTq6AJxvd4xPxddGR+GrRykk6Zhzn5+wtIXU+iApTWstHyh1u7gUFHC0XOFZK7WrTiIG2hW6J5W/5vHDt6znplAo2iIIMhsmEPhCGi08xg4TvpMwr1LZ8lNuwQemh084c5A+6jl4ZK32zFjtuWAOKUG4IcsHSjY4JXCvjDDc9KtznF7OFFr/85atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PZzp6j7owwR9wlZv/m5A48jT0tibOpnp2jjGsPR1gw=;
 b=JqBc8+oY+VuZRwOjdlOCavfIEhuYSBJFB9fHucZxrF/qB7uCBJHcX2UEc24GFpdPTbD/NlFaH0wIGTq/KsLjIJ+D2fhAaJis7FjeEQjETOu6LcIeaPty6ekSAmrfLVe2eaW3gfoO4hUYU3vCnCLhBTYE9M//uZf9FOBXp14xr2M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6315.namprd10.prod.outlook.com (2603:10b6:510:1ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 13:32:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:32:45 +0000
Date: Tue, 12 Mar 2024 09:32:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] NFSD changes for v6.9
Message-ID: <ZfBZekuzxPL1zBVz@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH5PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: aa566751-b741-45b5-2280-08dc4298e6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aHU3cKIFVMVl+U1t1ZX8djF+kMigUBfc76hxrgYgSDU3rISgX5hpg20oQggOG2gSfo5X7yOrWy+MpJ0cUQe69VQYMHk4KTE8Gxa4J9qk1P/b+PKQCrwl/1Ko+mSvuD/hylPwEIBDwT/9gDLpM6VlUDFUY/OWWUL/EfCZ+4DbLw1mCyhO1JrDYO21YU4wA1CqqHFCBXbBaj+kkLo84Wdmfqq4lKTBVX4yCLCkd2qNca2n6bhfeQ73OzhNdj9fNx1hvY5/7VdWUViGBtWqIHsVphf5N43Ucexwp+ct3JQ8UbdrZopG9c4Qy89UrgLYUNK2VmJA0fUMHMz9/R7fDHmifu+PXEroEcvUMXd/U/9soAxRonQUYJONrcXeDmjVa7Ozl/lP3l0v8S4Dz3AAvT1qwsraJzeegqpjIB/ZvVqFoEPZqjendVWITmTB84L37d9moQDhPKJiwWDybcwaght2pdjigKDgDZSF7N51p9xplQP6CxMePyIILotf76eJT+WchHs6uTk6MryZSPXvi/HwnAsTAwbH0C/mj5GtZFp+NLL6xFP4IirG2YSYYQr9jMgSgb0JwvgosqCpY+vjdHfvm4WkqsHxKKdjpzd/JdQ0U5E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x/CI0Ho0LprsYgUU8vsce6cZEph9xA1gbRDWB0EBmYBe8LBSpCNFnYjlpEG4?=
 =?us-ascii?Q?lZdtw8rV7Qi4AObAg9AEjZONlrd+laTa2ZnNGcXC6KOEl3Gjj8AgK2HDIg0S?=
 =?us-ascii?Q?JO2RDBRN/QxveCuoTUJ92cUYCsPX/rM/J57r0VsXKFDLoZu5PnENi3uytP5p?=
 =?us-ascii?Q?2Gdd38+eHT1GXPMYOXNUKZ5IvbGNa8wNmvEY7tQZrMsLXO1qnZwYSM6lmyIJ?=
 =?us-ascii?Q?4E2/Uw5H7fkVU0EjcQOi9EkrdrgMlF4Mumi8VpbvAvjBA9fWHncLo4iT1+QW?=
 =?us-ascii?Q?ZeEkFDWgEtqDUl5BGBz5JGSgibu+HLTsKpZgAR1JMBb8c5PtzT7VqJK/De51?=
 =?us-ascii?Q?Tn8aoIAesrskXACv+xUeAsvlvzxEPXjV63Xq0bUxxBYP7zSSAloyPbZ2hYyH?=
 =?us-ascii?Q?oPU62heA3Q2QozlzR5BBjP4Py/1JPQDLQGVYsrOnCQJ+fKI+BDZQQl/xmtUK?=
 =?us-ascii?Q?GdWTMrmfIRYf6Sp33uvA+zS4T4x0XZda5vWuvm1pSo7BnV8+/m876CNr+Fwo?=
 =?us-ascii?Q?sNHOrvC/Q7H80jx+gkRwcbnG63TztoKUJqX331oepWulL+CO6Pv9bdkgTuIf?=
 =?us-ascii?Q?jqzekcxd5mXAqgR6psif53TraktHuZuN4CasGqozIMoivOKpP7qa/BZh8emK?=
 =?us-ascii?Q?9Ae7DgU27KWAb50OeecJFZYjL3DaVkDN05aw2WmjuZ57YrdXW4CbqUvsNiBT?=
 =?us-ascii?Q?4lQpMCM562twllsx01pdhWn/iIAxBqDu0SnelVxR1iY/tXACKBq/GCD5USRm?=
 =?us-ascii?Q?PEpLudOHtRLWcYu0Xif3fR0br0og0WhgmFyoLWZiVSmyFuCLdmvUhNFuMpKU?=
 =?us-ascii?Q?ArePwBzQBm63kNL7n8HPXNQ9CyUFlHTBWF9MaZuUz0OL2xaEN8TrueHnwIhK?=
 =?us-ascii?Q?Hts3e6Bsxs6ULpZ0Nv7epSsVSNAA4GtwveoAfMmp17r9vgyV1en5v77jUkQe?=
 =?us-ascii?Q?Bv0TUwCFbAqIcEbjAh3VtPIppnG0cSBXbTVJUOgEMGs5Vx0B4yIz2VIcz129?=
 =?us-ascii?Q?fyIN+yNRoV2UncxEotM+mKsoWuwBUZb71kHPzky4wGvAXuwGiTZtSiASuZEs?=
 =?us-ascii?Q?AmTve3dONbxArWbcwxAYhiR47kBBpqCkK7cUjJR892Hw6K2DhyOp4bR46CIn?=
 =?us-ascii?Q?bv3sfdByAIyf1aMlXZN+/SW/4PSdQZq6O/uHArKjiD2iG4mRxBY8Me25NCpT?=
 =?us-ascii?Q?gyX3mbIAtzN2jr/RPV8dwR+mXOh+wAyT3VUYCPpbacs5dsOeIvKnNw4fyyH+?=
 =?us-ascii?Q?6Gv8mpk9bnSu6GaX/f+z6pIzbZIYocr9UEZbI24M/Y0bwjcjLelbIcrncLu5?=
 =?us-ascii?Q?OmcHSaCqXUIH0MjZpIHxmd3Hz+Jw5SC+2iHde/mOgh9BWIqpd8xah8kQ9SUY?=
 =?us-ascii?Q?u+gAD/qxUAqZlnSqwRSIoW6R/jOhb06xfOyCfzXH3h/5J1s0ntwh7D8q4Ul+?=
 =?us-ascii?Q?ITgCus+kRtqwrRdPzFSPtQlQqizhp+1U3Ut4Mpb6xsrl5meRMxBxjoDWbBXJ?=
 =?us-ascii?Q?r9BYOrJXHUBoG8emwvWLnlwr7+RskGT/OQ4Kw7+5SuiYSQ5Hhf4qoXN7mScZ?=
 =?us-ascii?Q?RkU9nrfkZStxk0Zs47dy1K1DTeIsEPy+dM6lIBe2AoBQTDF63gFZ29iBnW0T?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+w4uurMXex6U5HK7AnqucSpaoRPrdlZIDRHw8dOuYfcEcAXpKx7PaPltE6x6FsG5ZVLIaAhlHrBrxzgOJVV8iftGWsTP1dB6NxGhvtsewDiDH2cdfwbuNZDshbmUpiqVFGX0onlVxPSsZ1qxyE+TTMF+/N4azuF+0AmvMcNfQetCy4GMeVyGT9VjsM5xCGipv6/WOtIKRHHvG512rgIDCmdHI5Ejo9AryJbbqF3O5TyPuoTY+xI2KacmHKILenNowyxMBBqRxLnYZWNh/P43ACcWKFCcvgMrfHuVLJz3pyKoWszpOOyaxo5vUR4JqAdwGy5jd4zhK+k7aN63NtPfOCkdFZfIN0cWhkKE5wyLwDU6N3oqUpZr2sjVEiC0YT/TtYIxGrgX3XazJJQa5VGIe0EP69P9y4ned2DzlLcmI0jk6a0kFGqGmiaXjAN9ck1fTINwxJTO5uU4JMyzmTibqJvfap25Lmb8zc4dd3F+CpA4uRerrBiS1I2QKK7ttxhIg1pX5A86I5mcDk+AFsEty2plhGQkAVHVwiPhSJsiwJ8kmtkL8sAPjwYqibqVkEJ4+3yOtHfK8Uyrrl09lV9t4O52z9fDh0/s+xtjjvvj6p4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa566751-b741-45b5-2280-08dc4298e6c9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:32:45.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfPFrQwUg6xolVtNScuokiPyykX7qiybnSuKvh+zFDjgJe+abVOxzZfD/N7Ku+lCHC9NJGYCW95BXCWFmEX08Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120103
X-Proofpoint-ORIG-GUID: 1bvBPiAy5HbNpjTktDBVSJNmoVVTCGdQ
X-Proofpoint-GUID: 1bvBPiAy5HbNpjTktDBVSJNmoVVTCGdQ

Hello Linus-

Stephen Rothwell notes one or two minor merge conflicts with the VFS
tree, which I believe you've already merged. He's been carrying
fix-ups in linux-next for several weeks with no reported issues.


---- PR follows ----

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9

for you to fetch changes up to 9b350d3e349f2c4ba4e046001446d533471844a7:

  NFSD: Clean up nfsd4_encode_replay() (2024-03-09 13:57:50 -0500)

----------------------------------------------------------------
NFSD 6.9 Release Notes

The bulk of the patches for this release are optimizations, code
clean-ups, and minor bug fixes.

One new feature to mention is that NFSD administrators now have the
ability to revoke NFSv4 open and lock state. NFSD's NFSv3 support
has had this capability for some time.

As always I am grateful to NFSD contributors, reviewers, and
testers.

----------------------------------------------------------------
Chen Hanxiao (1):
      nfsd: clean up comments over nfs4_client definition

Chuck Lever (31):
      SUNRPC: Use a static buffer for the checksum initialization vector
      NFSD: Reset cb_seq_status after NFS4ERR_DELAY
      NFSD: Convert the callback workqueue to use delayed_work
      NFSD: Reschedule CB operations when backchannel rpc_clnt is shut down
      NFSD: Retransmit callbacks after client reconnects
      NFSD: Add nfsd_seq4_status trace event
      NFSD: Replace dprintks in nfsd4_cb_sequence_done()
      NFSD: Rename nfsd_cb_state trace point
      NFSD: Add callback operation lifetime trace points
      SUNRPC: Remove EXPORT_SYMBOL_GPL for svc_process_bc()
      NFSD: Remove unused @reason argument
      NFSD: Replace comment with lockdep assertion
      NFSD: Remove BUG_ON in nfsd4_process_cb_update()
      SUNRPC: Remove stale comments
      NFSD: Remove redundant cb_seq_status initialization
      svcrdma: Reserve an extra WQE for ib_drain_rq()
      svcrdma: Report CQ depths in debugging output
      svcrdma: Update max_send_sges after QP is created
      svcrdma: Increase the per-transport rw_ctx count
      svcrdma: Fix SQ wake-ups
      svcrdma: Prevent a UAF in svc_rdma_send()
      svcrdma: Fix retry loop in svc_rdma_send()
      svcrdma: Post Send WR chain
      svcrdma: Move write_info for Reply chunks into struct svc_rdma_send_ctxt
      svcrdma: Post the Reply chunk and Send WR together
      svcrdma: Post WRs for Write chunks in svc_rdma_sendto()
      svcrdma: Add Write chunk WRs to the RPC's Send WR chain
      NFSD: Fix the NFSv4.1 CREATE_SESSION operation
      NFSD: Document the phases of CREATE_SESSION
      NFSD: Document nfsd_setattr() fill-attributes behavior
      NFSD: Clean up nfsd4_encode_replay()

Dai Ngo (4):
      NFSD: add support for CB_GETATTR callback
      NFSD: handle GETATTR conflict with write delegation
      NFSD: OP_CB_RECALL_ANY should recall both read and write delegations
      NFSD: send OP_CB_RECALL_ANY to clients when number of delegations reaches its limit

Jeff Layton (1):
      MAINTAINERS: add Alex Aring as Reviewer for file locking code

Jorge Mora (4):
      NFSD: fix nfsd4_listxattr_validate_cookie
      NFSD: change LISTXATTRS cookie encoding to big-endian
      NFSD: fix LISTXATTRS returning a short list with eof=TRUE
      NFSD: fix LISTXATTRS returning more bytes than maxcount

Josef Bacik (10):
      sunrpc: don't change ->sv_stats if it doesn't exist
      nfsd: stop setting ->pg_stats for unused stats
      sunrpc: pass in the sv_stats struct through svc_create_pooled
      sunrpc: remove ->pg_stats from svc_program
      sunrpc: use the struct net as the svc proc private
      nfsd: rename NFSD_NET_* to NFSD_STATS_*
      nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
      nfsd: make all of the nfsd stats per-network namespace
      nfsd: remove nfsd_stats, make th_cnt a global counter
      nfsd: make svc_stat per-network namespace instead of global

Kunwu Chan (4):
      nfsd: Simplify the allocation of slab caches in nfsd4_init_pnfs
      nfsd: Simplify the allocation of slab caches in nfsd_file_cache_init
      nfsd: Simplify the allocation of slab caches in nfsd_drc_slab_create
      nfsd: Simplify the allocation of slab caches in nfsd4_init_slabs

NeilBrown (16):
      nfsd: Don't leave work of closing files to a work queue
      nfsd: use __fput_sync() to avoid delayed closing of files.
      nfsd: remove stale comment in nfs4_show_deleg()
      nfsd: hold ->cl_lock for hash_delegation_locked()
      nfsd: don't call functions with side-effecting inside WARN_ON()
      nfsd: avoid race after unhash_delegation_locked()
      nfsd: split sc_status out of sc_type
      nfsd: prepare for supporting admin-revocation of state
      nfsd: allow state with no file to appear in /proc/fs/nfsd/clients/*/states
      nfsd: report in /proc/fs/nfsd/clients/*/states when state is admin-revoke
      nfsd: allow admin-revoked NFSv4.0 state to be freed.
      nfsd: allow lock state ids to be revoked and then freed
      nfsd: allow open state ids to be revoked and then freed
      nfsd: allow delegation state ids to be revoked and then freed
      nfsd: allow layout state to be admin-revoked.
      nfsd: don't call locks_release_private() twice concurrently

Trond Myklebust (2):
      nfsd: Fix a regression in nfsd_setattr()
      nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()

Zhipeng Lu (2):
      SUNRPC: fix a memleak in gss_import_v2_context
      SUNRPC: fix some memleaks in gssx_dec_option_array

 MAINTAINERS                                |   1 +
 fs/lockd/svc.c                             |   3 -
 fs/nfs/callback.c                          |   3 -
 fs/nfsd/blocklayout.c                      |   4 +-
 fs/nfsd/cache.h                            |   2 -
 fs/nfsd/filecache.c                        |  76 ++++-----
 fs/nfsd/filecache.h                        |   1 +
 fs/nfsd/netns.h                            |  29 +++-
 fs/nfsd/nfs3proc.c                         |   6 +-
 fs/nfsd/nfs3xdr.c                          |   5 +-
 fs/nfsd/nfs4callback.c                     | 193 ++++++++++++++++++----
 fs/nfsd/nfs4layouts.c                      |  63 +++++---
 fs/nfsd/nfs4proc.c                         |  13 +-
 fs/nfsd/nfs4state.c                        | 828 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 fs/nfsd/nfs4xdr.c                          |  58 +++----
 fs/nfsd/nfscache.c                         |  43 ++---
 fs/nfsd/nfsctl.c                           |  17 +-
 fs/nfsd/nfsd.h                             |   3 +
 fs/nfsd/nfsfh.c                            |   3 +-
 fs/nfsd/nfsproc.c                          |   6 +-
 fs/nfsd/nfssvc.c                           |  16 +-
 fs/nfsd/pnfs.h                             |   8 +-
 fs/nfsd/state.h                            |  83 ++++++++--
 fs/nfsd/stats.c                            |  52 +++---
 fs/nfsd/stats.h                            |  70 +++-----
 fs/nfsd/trace.h                            | 212 +++++++++++++++++++++---
 fs/nfsd/vfs.c                              |  84 ++++++++--
 fs/nfsd/vfs.h                              |   4 +-
 fs/nfsd/xdr3.h                             |   2 +-
 fs/nfsd/xdr4cb.h                           |  18 +++
 include/linux/sunrpc/svc.h                 |   5 +-
 include/linux/sunrpc/svc_rdma.h            |  55 ++++++-
 include/trace/events/rpcrdma.h             |   4 +
 include/trace/misc/nfs.h                   |  34 ++++
 net/sunrpc/auth_gss/gss_krb5_crypto.c      |  14 +-
 net/sunrpc/auth_gss/gss_krb5_mech.c        |  11 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c          |  27 +++-
 net/sunrpc/stats.c                         |   2 +-
 net/sunrpc/svc.c                           |  40 +++--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c          | 245 +++++++++++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 151 ++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  15 +-
 net/sunrpc/xprtsock.c                      |   9 --
 44 files changed, 1765 insertions(+), 755 deletions(-)

-- 
Chuck Lever

