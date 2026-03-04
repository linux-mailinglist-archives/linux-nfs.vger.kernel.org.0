Return-Path: <linux-nfs+bounces-19775-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGNLJ9JVqGlutQAAu9opvQ
	(envelope-from <linux-nfs+bounces-19775-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:54:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A6203647
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09F933C73AE
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC35345CBD;
	Wed,  4 Mar 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OQNX22bU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022132.outbound.protection.outlook.com [52.101.48.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013335B122
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638859; cv=fail; b=ItRrf5Oflj7uTXpw3H6EC8GI7mWmxhcKdIUxchU91gcnw9gXY5IexoIASNQ7Z9akO6mpbyc+dXleRRsFVbS9eTckluGrueaxGmn4il9MH8uFGbSWRSyJYilmBNGunR239F+N7VJhBHJinjslJ5YkDot/yUGYz//bdAkFwu02OAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638859; c=relaxed/simple;
	bh=7X9kzZjdITqDyghOZ0zjXz9e3cgGyDzaA1NG4gLsklI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INiyNXaPAlcZ1o9ujm8rcopIhLRUzxZ1G/KNYNky2QaZuUURB7obBFii9q5Qnr8j5OB1Dl6WaaNlYO5E1a4y4/RWvfPtzCMGi+VSjnoSGqQslZZC3+FzV+crKQfft32heNDWK+ZseevIpOxwRD3QjKvMF4DDY4Z1AsqXna+KYxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OQNX22bU; arc=fail smtp.client-ip=52.101.48.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3ckIK8ZQcNOO86ddYJhEgsxw4QSX3ZdpO81xtvuZdEy61TgXtqdiBI1Rxe0QiTMBk/MHc+uZz2P8nM2Px7DJAhTKpdb0OCzjtKeGXOSGV7ASmQJ1IG8XnkGG7iL2ioeQwudvVNa0eXhTwyIySuo+5xa+ihkumhB6YMjpDOEJCwk1xr/QGxm+Tnvmw1xQBPQdacpWBSH/0wmo4KjQHlammQPQfegEBc4f4PBYPAA9ugLtemGqfwlNQvfc8g/T2eiVhMnwa5VKky/xkyqrAiRuIuexxE5GMMQh5bfK9rd4GYb4VMh87TfMIxT87vzV8VjD9fdj0clxb+QX+2xYnVx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDQUzo704RKV5q0EEDO4Sre8yehpzsBpq9WWUTCCtaY=;
 b=QaMbrbN9awd8j+aye5ZRHYWDdpVEzfaCupjisr2+EeCZwAvTiY/vD1iOVzOvhqWc/peku0n6JkDd8+W+YZXZqlkSzG2t3V1zNgVKGBaoXkAfOYGeyFBqJbV/cU4ZKfhsKVh/XLWaIIy1QxlvYY2V6kv/BEyx1wEEB4GjcE3zz+5ykCf7BbgBJCWaykVHRniHuG/yJnGWe53RmsqIB91OUkINzLAQXyOyffsHJ3Z/+aAM6ryJKsJiuAMPzFAMg8/rR2JQYCkZ/9j9K7AYBRLmdpoOit3TRV/IfNqUQvuXQvcuKCUt6NmT20ZeGFhFEx7NwrNKPgwPwyjYTgzdK8VV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDQUzo704RKV5q0EEDO4Sre8yehpzsBpq9WWUTCCtaY=;
 b=OQNX22bUelzBu0BVPmlVM0pHhC3L7bYGUClA5Wh9FUEzwtkgLbIRMDHLBmnxNI9dMF82fclYNkeF5YK6KL+jYSSvbtXX3rNN6Ka/vEI0Gse5OJetp22xhYWkG+qU4SfT3W6A1stG5SZ5VQze+XTtPI4il+E4ejPsOLmA95SoBig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM6PR13MB3771.namprd13.prod.outlook.com (2603:10b6:5:229::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Wed, 4 Mar 2026 15:40:52 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:40:52 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 1/2] exportfs: Add support for export option sign_fh
Date: Wed,  4 Mar 2026 10:40:45 -0500
Message-ID: <43c0f9351e150892ea8cf1dca360ad41b72eb6ca.1772638460.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772638460.git.bcodding@hammerspace.com>
References: <cover.1772638460.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM6PR13MB3771:EE_
X-MS-Office365-Filtering-Correlation-Id: 885c763d-e4a1-4efa-60ec-08de7a046a9f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	DO9GZc6rZsGjpMXaRfelTs9Oalx3rlDbsLfdLUrdIdRtf692JJGLuv5uaLHQy4usFjDxIs0LL+FIigNYiVqzPiWyH8a7zLKRVXQEVu3TLHrVOl06gxYEeaA3czZYRndajHqlBt4XtkkYq93IXssm/ey1cM1YwLYllU/oL2KtkMajTNnFl0FHdWqPHKcnCIM3wgCq5IStA926V2VUzkOaEOBI4IlNLNnQWHESgdVuKiAWnFODqtCHNOK0xUZiD1cblpWUi2hQeeMR+r6gUmPcpjOT2iGwk8GsgUY8y/1REH+IvphSglTKVXbKlhuHuh9jdg69+qC/VG569mJeVdpNXwsxYLkt0bq3b25mn7GTmRfNVDbGJ9aPq+mR9X21jZPnC7X48X8bP/Y+vw25OijXI8pidY8f+Bg69pEFwb7S0xyd2jokOSVzkS2VwUTUVnSJ2D+T7HcqrSjfiVkrfpzvJt+MvaHsAE+Uy74ZsjUvpkMUkUQTOH3vRJqVC7pxoCJ7KBlSA9qiiOF4P6gfeHRTmm8fTtv72kYOqQDfL8HwFFHmkKz9GVtQJEcmQrCp8FbWzXvxn5VIJw5ca/dYBBOQlbpzMw1+//Pyq9iH+TkC/CCb76atrbAEVQPjJPuCGf4R9beYkIBkfQKboEPEXlKQh4XdX8ftp2Q1Kn5mDDhD8BJKhTvZ5ImAxSJ0S/N69ohejXaoAnhJssYfw7qcVtqh1ut++m7EDlsSKDMl8BoJzSk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGvXqA4wdQEwqazCriGuH44pN6R5Vi09/LFBsOEV4nn7qQVzqgJY7/r2Wmyc?=
 =?us-ascii?Q?JUmpYgMSJilaMyb/EiN0ZM5H+u9gOyCqgiP3b24vXoIxAzU+TD3K5n7dy0E1?=
 =?us-ascii?Q?sVFyriUQSLqK3wrPSkUyvKCLsLcyXRI3K2liEdpsm1YZn8Xd+qndgupOpZRm?=
 =?us-ascii?Q?qluHhby/rzx2zjwxKWq+xCQ875DhZXEg92aqgh9YUbDZTnvjvbLq7nbuK50e?=
 =?us-ascii?Q?+0P0CbZKs1LvD4s7XeAjwLHT7QGLCqWEKBaCWcBQo+YuftuhVbaN5h1ecjfQ?=
 =?us-ascii?Q?Qj2cnXVD4Dy1OUNnJAkqqKvjeJRpsjpTr9SDXTnGoBBMiTUITWemRI8RMp/C?=
 =?us-ascii?Q?E8wAFZxBHpLX/vWF481gMcKDOwqr5zTF+IkvcBXYmviZMUd40P4TY3Q1U4kf?=
 =?us-ascii?Q?/iUiHXKc4/XpubTR6jIr/I8S6S1V0i/EZemx1Afw7RQqW5jB7oYwjol7uv1z?=
 =?us-ascii?Q?AbKcyYat+hO6h4ZgPR4eXS8DEkJw2glkU+iHB1E7EjeyDgytNlncdP5u3n7H?=
 =?us-ascii?Q?c/nls9ZgebgK3nN8HFQG3oDqaXVJS9MDm7erXV1DzCM+XN+PtFpcwB/vH2U1?=
 =?us-ascii?Q?UQI8jeZhA6xl7Sq/Q1RVWMGB3gflPjHpzHzEdIErPJAdkbHSh1KDYvJYWu2S?=
 =?us-ascii?Q?OdWwi3lGOYIQphUnHFD3lgywIXvuHHa+yWxPamWJJuzuDa3+pvwgAcKEMN4L?=
 =?us-ascii?Q?iE6w8fK63ZYLd0smcsAIRmuc99OO2rhAUiwHInhJa3+n1WzoF65bvbXHfbNW?=
 =?us-ascii?Q?Ad+kq8W4FjE1ltKWI0SXpajUKk3DhMdACzUVk6xPUzBraMVeE22UOiEqPpXx?=
 =?us-ascii?Q?e9SB0C7zTht0PRm1WjtSXr2tSHtt7VEUPXnWsyb3RXNsGnYsw1na1qetcCQn?=
 =?us-ascii?Q?Abhjt0J0GZTAwObRRCFkEIiJ/jTmYnHhIFSGiyzWsw+OlRim1584xoYS6im3?=
 =?us-ascii?Q?PDGk8ogQKvimSLEaiyn27SDBrXJvuC1dd2PdsDE6Jd5l/hNtt4VmU3KRdCwn?=
 =?us-ascii?Q?2RVP6CFnlFZpGRonGkSLcP0k/+UW6urcmW69WoFIi2myX1dYANu1CXTrusYb?=
 =?us-ascii?Q?VAXH8+Al4GVmSHd2vOtdEhG5OQA7T05bQkQpoOEjuPZ87QmC1G9gosF6Xk84?=
 =?us-ascii?Q?gjdA9830aNFI0Kn+InU7jUhPfYzmBSpQMKqbQbSioW930+Pi+oMdmc6VKEBZ?=
 =?us-ascii?Q?ejwqdWoPNbV5W7XLpgGfgOUQ6+5oQyEPqfyVIP+QPbF0J6QpkB1sOqA5j5dw?=
 =?us-ascii?Q?BvHFt0vhkUZQ9BmyeqZcZp3QxJ6YI4HtPwr6Qv/Bd6OEi1lsigCrQ8gRy60Z?=
 =?us-ascii?Q?waUxbv97jNBx12OJCWMGgt4/BJbyZdPp06pPB2bHx5AhJnnm/D/oFomG7pij?=
 =?us-ascii?Q?C2uMQcGNxgb8ZEj8DHdNDSRFc71cxRNNJEGb6pm9wnmG0zcDSmSb4KJcPJW1?=
 =?us-ascii?Q?S0OoLpcZfLudWDVMaMoqbN61bA4/1+0lE/YHxOZnmFwA2b808SoI6Ayj6ufU?=
 =?us-ascii?Q?HmU6V4KgfJsbNbxnnSVKIMDjIh0p52LY1lTISHpgUBfJb+vtO7MeUIQKVSeQ?=
 =?us-ascii?Q?c0s2SSDoELqm5UJ5Wbvp7Wp0KI0OGdFvfGREepEmkOgnQ8PkK6KpoepATyAn?=
 =?us-ascii?Q?yEJYOoxGx5YfXeyNtZWDFcRxv97sT+29gxEx4yEhleTYZ4MmR/zTW+JtJDer?=
 =?us-ascii?Q?qKTI+2rXsAgU28NwolZPjPwWGCfIB0NnQvr/n6HjofrHEQ6uOY56CJUCSkG8?=
 =?us-ascii?Q?xNxoxF+HUNafcTZLBLbMBEx2iJ2rKs8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885c763d-e4a1-4efa-60ec-08de7a046a9f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:40:52.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJSsCDzQ36ZDgpaAt3gwAiQIQraqv4sGihzKnV4LdkFK8ReQ5fStv6d1ND/jx99Q/tGclrNIgVFfAXcIbGknVBC9j4YyQrX4nsQJiowWmSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3771
X-Rspamd-Queue-Id: 955A6203647
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19775-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

If configured with "sign_fh", exports will be flagged to signal that
filehandles should be signed with a Message Authentication Code (MAC).

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 support/include/nfs/export.h | 2 +-
 support/nfs/exports.c        | 4 ++++
 utils/exportfs/exportfs.c    | 2 ++
 utils/exportfs/exports.man   | 9 +++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index be5867cffc3c..ef3f3e7ea684 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -19,7 +19,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS	0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define NFSEXP_NOAUTHNLM	0x0800
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486ba3d..6b4ca87ee957 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
 		fprintf(fp, "nordirplus,");
 	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 		fprintf(fp, "security_label,");
+	if (ep->e_flags & NFSEXP_SIGN_FH)
+		fprintf(fp, "sign_fh,");
 	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
 	if (ep->e_flags & NFSEXP_FSID) {
 		fprintf(fp, "fsid=%d,", ep->e_fsid);
@@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
 			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
 		else if (!strcmp(opt, "security_label"))
 			setflags(NFSEXP_SECURITY_LABEL, active, ep);
+		else if (!strcmp(opt, "sign_fh"))
+			setflags(NFSEXP_SIGN_FH, active, ep);
 		else if (!strcmp(opt, "nohide"))
 			setflags(NFSEXP_NOHIDE, active, ep);
 		else if (!strcmp(opt, "hide"))
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966..54ce62c5ce9a 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -718,6 +718,8 @@ dump(int verbose, int export_format)
 				c = dumpopt(c, "nordirplus");
 			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 				c = dumpopt(c, "security_label");
+			if (ep->e_flags & NFSEXP_SIGN_FH)
+				c = dumpopt(c, "sign_fh");
 			if (ep->e_flags & NFSEXP_NOACL)
 				c = dumpopt(c, "no_acl");
 			if (ep->e_flags & NFSEXP_PNFS)
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index efbc6ef65c5f..7f0278fb8d33 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -351,6 +351,15 @@ file.  If you put neither option,
 .B exportfs
 will warn you that the change has occurred.
 
+.TP
+.IR sign_fh
+This option enforces signing filehandles on the export.  If the server has
+been configured with a secret key for such purpose, filehandles will include
+a hash to verify the filehandle was created by the server in order to guard
+against filehandle guessing attacks which can bypass path-name based access
+restrictions.  Note that for NFSv3 some exported filesystems may exceed the
+maximum filehandle size when the signing hash is added.
+
 .TP
 .IR insecure_locks
 .TP
-- 
2.53.0


