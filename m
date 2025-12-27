Return-Path: <linux-nfs+bounces-17323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C5CDFFE2
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 828B03004E3D
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C01C1DF73A;
	Sat, 27 Dec 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Q3s4HW8l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022078.outbound.protection.outlook.com [40.107.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538021A459
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855105; cv=fail; b=lVKKQQcHZIqGI9dji4/IGignVfvmWSZ+a41uEuUzwS0oTojjD/1QPqXSCq9vXe+E74AV+LqT8y6NO7ZXAwh8P44h3TZKtLkxVwPiNln3p70Ffgu4LBXrSvy8+w4nRHr9bW1vm9Y4srqsfWe++9xHR5PTR6jpRV7BOrlNvswFxOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855105; c=relaxed/simple;
	bh=i1yEC9JydTAE9UvXhhE5G+WR3qnF3Ai8UG5BeJkuHfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2rAkTbbECYCXgiOmAdf2/1ew9wrfgRL1yxARNnPXQeILCcOF1MiUfOHtXYhybf5IRJ/8m9NgxGgUJz39wsc0IO4mLjaUFwtbKJsFaXjIkYBNGkmkK5sRqKOz1H/1XU7F93bABNa6mdaGPOInSzwJr0LJxNIwoh1TuiYkVgIvsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Q3s4HW8l; arc=fail smtp.client-ip=40.107.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys5Bp8W95wQYbw+eoe9TD231JOPwqOAsWFU5WNsLesGNG2gSY7C+W+TnGfm3c0Jgn7HOhd0seNiMau7K00vGKO1WCUx5ySJWrUP73Xgqy3TkaM0Zjera9dnNZAYhvic9GPkVOmCb7ME0/2IbOfO15ojS0PJi7IJCA+yfcHDdwRt+Fsmw54V0RvjShmmy2EIXUOGsBYDRRrL/04X8CdMBRt98z9O7g0LgelrK0xUZZReAaRxm0kPLyguTqvhokc4PPNwJaqPZDzTP7tZxYnxpkLvf3gpFHJ2/Z9rXpfw+4aLaFSw1Ij7YEgUeEP2x6mm/0jLs2WPkfws6PyNJTBzaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qjh4eOxD3qTc5827w6bnWJmb26l/SAthTOt1VObNjyk=;
 b=irrkI4BM12gFq4kn4yWJxy+zt9AOerFM2YLJvSOOYfzs9FfhZtt4oXcDSNvUq6L9l6OzxvnTWIev0NJ2RKczySwEhK15RN5Be75yrqfaoENGX+HqSFhYCm9FIu4cqlJdtcLneN7NtJEJpwsEmPzsi9pC7cv1E7pbpsdV3Hl+GODszCADfCxG40VCYIw6Fkwy9jNvqwV6nf4S8kbGi70PskpBaZ8MYiE7GuOlkjR3dM2JWhX6WLaZaNqUk0OMWzvyQIhqggW7IwvKkM7JF82MS4xIelOHroAakEsNGID9BVMO85vz87zGYkmxG6bkRSqIGDDHzlJq5BO5EqC7HnEmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qjh4eOxD3qTc5827w6bnWJmb26l/SAthTOt1VObNjyk=;
 b=Q3s4HW8lLT9PNASjynqGTleII1p7QiXz1S3HACET2iFXiMV57GGxOIEDZb+J0OATejWUN8REqixtfvJf286mz3SniicMybLMbEPS73HhCMJ/Jxg4I7Dj03dHd+Cz9SnIFR+1lV9ZE2Vj/sCZgmwP8gLSwLC7dR3K+8EHhwGvPNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:04:59 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:04:59 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 1/7] nfsd: Convert export flags to use BIT() macro
Date: Sat, 27 Dec 2025 12:04:49 -0500
Message-ID: <55ef75dd1010f20a449117405b281c0e9318fd43.1766848778.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1766848778.git.bcodding@hammerspace.com>
References: <cover.1766848778.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 94db6402-3754-4c94-92c3-08de456a1124
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpsZUbJx6mQoV9gJleQmNcjvDmfHsoX2WkX4dAV+C50+LLhDqYoYPdasF2I6?=
 =?us-ascii?Q?Sbdr+FjgBgUKiLDGA1ZPLeoLGNpbNaeZsFUgm1t1yETniTKxa3D2lPmXAAs6?=
 =?us-ascii?Q?x9sK4dH3Zmx5Qnr17+wh/97b4oSLJNwofYHKaokIfytRJrMcDlUDS7b5TGYc?=
 =?us-ascii?Q?8PdksvD2V0XMotcae+IGvoXcJkJVyXqnAjScuGoA9LFViugWoS7IKNZrGJeq?=
 =?us-ascii?Q?um502pdoir1GeqK/nGA4eZeHvWJZciAcNhLBBc2BVtB9r28bkfEgnn5rqoZQ?=
 =?us-ascii?Q?X9qB/e5WX0XxL94AZCSd+pAGz/KFwDCZwgqOsLjxuG7KbQjGoFgHdbNB0JNr?=
 =?us-ascii?Q?GITW312x4cWVVr9KRoP8eG1aL/AvItPtPqew+auE9zSVNnsZj1yRd0xbSt7i?=
 =?us-ascii?Q?ODAjInlqjRExeZkRIwB4HHH0U4hkY1aHXvLI3zTuB4gEyiFsWC0PZBo1/mRF?=
 =?us-ascii?Q?8jsal+6CZQf6RkCoYBJ9Xx4im1kXtXRV+78Z7oXSEWvLGFzvp5zO3chzjOeF?=
 =?us-ascii?Q?FaR11oGs8tmYWmU0op40xC68Fqde0Odc+FmMlx7h3HeWMTnR62GexeLkG+Qr?=
 =?us-ascii?Q?gYgwmT/K/pnrdCl8npIm2RRwgBBZlC3bQPPL4iXekICJW+af8YsknNONN+3k?=
 =?us-ascii?Q?2rIuCKMgSOyglUZqL51+sOqiKoqH1jmS7f6iJDstkihbU9qfz/dxpNFTpYMJ?=
 =?us-ascii?Q?jWY3iTZa1EHFdNFfuegGXuQhs4lP9wiCRo0G1ZvXqKWUgFsXK+UIA3HhOOXM?=
 =?us-ascii?Q?/609PVY2cursh7OCaTE2utjWrFyq8hRiXoXVs6WfZ3WYJ4OP9Av3tQhshnTb?=
 =?us-ascii?Q?+mzhD0fmW4tX09+rvjGlvcatt0+FwP1SaI6/w+xW0DFfzVwIYbTEIAl3hJyR?=
 =?us-ascii?Q?AERBguljzdR7ritIHsnN+VRvoMVC1rBAzfE5KJG1U7pVFBVqw/tn5qRZ2eTG?=
 =?us-ascii?Q?oaOa6Qb1xcbFQcnfi8O3IEs+Z3QfhTbKzZk4OwOGFfZjutDpY3wIqdMf/ufj?=
 =?us-ascii?Q?LMf2o++kTA0B47NqwpbjmTZxkTbGOQz2mYllreDd0nH301G0J2JO8K7ReLTd?=
 =?us-ascii?Q?9JAmvoFXe2E/xak1SQDjzki8nqubqeKUsiUKYL5YqotNtVrBI4qwdJE8gp55?=
 =?us-ascii?Q?bVwnN/QkLeRPr5H7fVmA/4vGKRJJ42CQoN38580k0aDQKgnK1of9Vnh9Q/Kt?=
 =?us-ascii?Q?FwtaC/cu6hVy6BajLEY/ZyB1W+McwY3+Fc9+R7i9GCxjD7nImcN4cCJuoJ55?=
 =?us-ascii?Q?C/rLqyGs8a240GeyS4guAzZ5lcaYahsnhJt8EFAF0C+6AjN9vmWpSeWf9Nu4?=
 =?us-ascii?Q?mDZIOB4Gyz3Cv+PNFFEHW9wL8BknQeLkYKDtUpXKInA3OX/lkiTfsLbRMKrz?=
 =?us-ascii?Q?+dVZjlYRRHZKywHyQ8H89MZxYrE7enimQqCusyYOoSLdgMzRESwHjLD5q2q0?=
 =?us-ascii?Q?5fb/hQsSmS5fi+rL1GXbL6qckB62wQrD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2RM64Bs+recVD0PhgP7B2l4kICEwJGSiI5eBL/hrrqXSswh02fYUl36Fta3?=
 =?us-ascii?Q?/3lOmzfbxPbgcGGNCbJlEWhtKwUwT6Gxv/bdaYGwZvehIJnkJuUh8m3p8H5L?=
 =?us-ascii?Q?giWQ8awAaEEgezZVEDPdDtOIdVcsqjBZXRXtDCcr4rA1toZ9v7OV+ueZmBhI?=
 =?us-ascii?Q?z4HDeCw/lZqK7k+a+pgsWGvnKJaVXjafeGhkJ0O8KPJNFdVib7jD8T0RhqVO?=
 =?us-ascii?Q?CWL0mqTFC4WutjPN+f1HuLwumk3FyN09XH+OsI4uOxG6ydMRlSieZNqK9aVg?=
 =?us-ascii?Q?6COiLx0sABleWD5FcupHLPGEaPUzdE9LN1tGHOk2shEgFTdLZTAeEKtxRM7+?=
 =?us-ascii?Q?8mxYeggOpzLQekl0FRUyVhLf2Ts/DoIwWiONmadknM43Bk5VYw3VhyXjeu2V?=
 =?us-ascii?Q?9sphmYeF33ENSPObW9Lo80+0U01uBzTJtVBCQHN+VuAtrdCRqcGbVF2CJx3j?=
 =?us-ascii?Q?wbaX+HrjGtLu59JWX0qLjx8uOIGm7zBfZRh/6sYkmBtbMphRvpJQI+ooZZla?=
 =?us-ascii?Q?/lWD3eQzyrgKWBUo3kOOG4p0nv6d150smYPO5LF3dikHylbRVvuh2yPmrVYy?=
 =?us-ascii?Q?9M6bV6pDCIUSWTutXRdJ88u7PjYbE6Qoan2R8uj4617HBkb1/xkHkQVAeSwY?=
 =?us-ascii?Q?76XcDR/8zA5sFG/dUM07q5wT4YGnEZyPRQUE+GnGGq79zYSmdRWGv8BY7kjr?=
 =?us-ascii?Q?Cu3B5MYpUHAVUm00+LlGRIFxVj0staZ2WWAxTsrBYc0hcb9wJuwY6/BQZJqN?=
 =?us-ascii?Q?l1FOIXkoXwTJnxqng11JT66WbvwqbloLnyKC6z7XFe+kN0Od6iyunsnYcQrL?=
 =?us-ascii?Q?grr+LtYdBgma7Ui+BVTl7AYukKywXmu6p4xMBFewk/WjPE80VKzlbkPPQvoZ?=
 =?us-ascii?Q?tqIFBk4cRKFaFvaUWGm0rUAIC7rRcm7uRfjsjTZJVxrUdVspgeuHt1bqaZDp?=
 =?us-ascii?Q?5fhc+9oHPW8FWVqRoTKR8CiRQkFyF4ZBFdOg9GsY1orLnqpGxvK27Isi09GO?=
 =?us-ascii?Q?mMRNM61r/UNfF+BXzYdcgWVqKak9V9AfuSDPz9mnhP/pq2W0SVw13LUcedvu?=
 =?us-ascii?Q?AUqp7kLwlc6RjVCAn9FjfwMBtqwmoQVSy4fxNMEnhVH+1eGX8f9pLIBzu8eN?=
 =?us-ascii?Q?EmNim+f88L7WfTEydsrNc+7wRkY0MaBMWU9v3vdXYwJfHushTkxFIB3GBBv9?=
 =?us-ascii?Q?4OBipqpX9MHh9Q0RN2fGq4w8hE/TBwT1WbODqd8ErIdG52V6NiK7eQf2SRch?=
 =?us-ascii?Q?zujc7ojT73IqCVphLE6vOyxVVAXRctRXkcTX/hnyAFU7mD85ARa5Ijb1H7t9?=
 =?us-ascii?Q?l6u0e+yyO605Leum3Mk0eHcQPdlYgUnKvjg0P/pvFHdy6ASbwfF3Bph9TnRs?=
 =?us-ascii?Q?YxGxfIyhVJwX5URMh2odNs9cUzqkRJEI/U2+7U85YjUWqBjp7xYLe3TdYTil?=
 =?us-ascii?Q?g+BmcozEsj9YIOy6oOHa/0UlfNTfM//D1X4bPCCc+EkVIM1fXvSICQ2Eq8o+?=
 =?us-ascii?Q?HSXTKgV5yDXsZDRwjVbcnUOm216SgwIrkxn/m3M7aBAExiQbCWUn02KC7aLR?=
 =?us-ascii?Q?xTZzSpO5ceV3sScDmsdmEG3fNJf+BWvUfel1I5FVCZtWCfCPDvzRdffNda7B?=
 =?us-ascii?Q?56jLT1t1wxWBxBB/kF3l0RrHj68kMkDKIFU9R+nc5lRVp+VxJNhDT6t0nC46?=
 =?us-ascii?Q?K+MQfStnk/ScCnMShRP6rspGdDiw5NaGj/nbX+8gvKTJ46tuZe1UKrmTz89u?=
 =?us-ascii?Q?H9BupjdOrI3EhcFOwailwODxxfR+bcc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94db6402-3754-4c94-92c3-08de456a1124
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:04:59.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maLW50qSWYUvU/j8ONMjD8ryDZ993lXBg1tmR1coju9h9FHXGL0aPbzDEqJ95hC9I6SxWt1M7rV+74BfNAuacICHXz96dtc92PkovzTRbe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

Simplify these defines for consistency, readability, and clarity.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/nfsctl.c                 |  2 +-
 include/uapi/linux/nfsd/export.h | 36 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 5ce9a49e76ba..ad1f3af8d682 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -166,7 +166,7 @@ static const struct file_operations exports_nfsd_operations = {
 
 static int export_features_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "0x%x 0x%x\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
+	seq_printf(m, "0x%x 0x%lx\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
 	return 0;
 }
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..aac57180c5c4 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -26,22 +26,22 @@
  * Please update the expflags[] array in fs/nfsd/export.c when adding
  * a new flag.
  */
-#define NFSEXP_READONLY		0x0001
-#define NFSEXP_INSECURE_PORT	0x0002
-#define NFSEXP_ROOTSQUASH	0x0004
-#define NFSEXP_ALLSQUASH	0x0008
-#define NFSEXP_ASYNC		0x0010
-#define NFSEXP_GATHERED_WRITES	0x0020
-#define NFSEXP_NOREADDIRPLUS    0x0040
-#define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
-#define NFSEXP_NOHIDE		0x0200
-#define NFSEXP_NOSUBTREECHECK	0x0400
-#define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
-#define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients expect; no longer supported */
-#define NFSEXP_FSID		0x2000
-#define	NFSEXP_CROSSMOUNT	0x4000
-#define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use */
+#define NFSEXP_READONLY			BIT(0)
+#define NFSEXP_INSECURE_PORT	BIT(1)
+#define NFSEXP_ROOTSQUASH		BIT(2)
+#define NFSEXP_ALLSQUASH		BIT(3)
+#define NFSEXP_ASYNC			BIT(4)
+#define NFSEXP_GATHERED_WRITES	BIT(5)
+#define NFSEXP_NOREADDIRPLUS    BIT(6)
+#define NFSEXP_SECURITY_LABEL	BIT(7)
+/* BIT(8) currently unused */
+#define NFSEXP_NOHIDE			BIT(9)
+#define NFSEXP_NOSUBTREECHECK	BIT(10)
+#define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests - just trust */
+#define NFSEXP_MSNFS			BIT(12)	/* do silly things that MS clients expect; no longer supported */
+#define NFSEXP_FSID				BIT(13)
+#define NFSEXP_CROSSMOUNT		BIT(14)
+#define NFSEXP_NOACL			BIT(15)	/* reserved for possible ACL related use */
 /*
  * The NFSEXP_V4ROOT flag causes the kernel to give access only to NFSv4
  * clients, and only to the single directory that is the root of the
@@ -51,8 +51,8 @@
  * pseudofilesystem, which provides access only to paths leading to each
  * exported filesystem.
  */
-#define	NFSEXP_V4ROOT		0x10000
-#define NFSEXP_PNFS		0x20000
+#define NFSEXP_V4ROOT			BIT(16)
+#define NFSEXP_PNFS				BIT(17)
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
 #define NFSEXP_ALLFLAGS		0x3FEFF
-- 
2.50.1


