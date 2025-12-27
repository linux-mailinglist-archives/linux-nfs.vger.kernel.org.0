Return-Path: <linux-nfs+bounces-17321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5009CDFFDF
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 751FB3002861
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD28834;
	Sat, 27 Dec 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PMCaBY9w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021113.outbound.protection.outlook.com [52.101.52.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531E3126C8
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855045; cv=fail; b=oSt6YEV1gFM1rwp3z8VPreviM11Q2/SSqL50L91HSjT3O9CeTuh0Gwo0o9CAKRjBaJcWFYRwAtdaoW4PKHKQpQB4DCjlXY6lTz1quJxp0wYzCtocFdmN0hkj9f5c2gX2F150ITzZ8ilpB4E5QV+3sUdcJ054cNT4sXxAbpOqI8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855045; c=relaxed/simple;
	bh=YVCxyrnVr9HdRAvem6Ty/YmxTS8jlPsaLOZHahiF75o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxxMnSLtHD2P2GU4CVADh5TglEv9q4xjLQWTP28WjDHtDlVLYwryZQJpGL93PzeOfgXg5kXB2s1scopssaMBqUSwB6dth1bTnM1lGDxXD2NgtKzN59u2XwgY/Nf8FhxTZ6WF3pgqahpYEHQkymZkL2yAPORhpQIwoa2ldpfW/OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PMCaBY9w; arc=fail smtp.client-ip=52.101.52.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJcIvOPm9XKkzk4pNcnXbIZ5vUorQ/EkG8/i1qrul1dRrlTajJPSZHPkGE86iO7SWClutNoGGZguuomcDKyn0wWpWK2dWTSSHLLTXzJtTQwvFxT2396GKb6ltXcwiHAoiVYcYo5+F80G8TQayR0cXHRGl+7LGEuOuGGVCnNQESTsXuXTe1mYBDaUGUE/EozJT/UZMqDp2nQe09BluFRrG7xDd9RHZENhGsFaGxLy80qtZA+AarUWtfpXpIKivL4qVeJe21YNEF1vty8K9xFuPtrrO8AT61xVAghscE53bjX6vhiIq55zJeCBN2rL4ZKpj9BFh/SpTvrQIbsoH78LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FkKlcxyVGNvB6A29Pb5pfu8BoLuOiW2uLHpGwfURRg=;
 b=Yxv7UBdJthT2oV7m7qSS29lPcXia6KJ4mAKEV/5ULORKAUZdtOiaulSqsOCz9i/BHXMHcWRy7M3+obQc3ZExhtGlRTi2cLeqNBSuMV6u3BGEawtg0E0/MiFD3Misfm0F7Mmi+AsfLNC/n5OKFyeCkIrRjFU4Ud/p/8bORll/4we/j7G3+6bIFtsY2pRFqra8nKUJi4+QkE+0u6B54sO137Req7epCyt4gJzoXZ0TuLmGE38Eh0/RtUCl5ouIX0TctGA6R+EoE0JwfdCohK6V7npDSAMidM/0cgSMw5vVl1qr0NHgoRl44zRIzEr/WnGhwobkUbBKaxM1nT6Xw4uxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FkKlcxyVGNvB6A29Pb5pfu8BoLuOiW2uLHpGwfURRg=;
 b=PMCaBY9wPNJnwe0jrDjZO8QzzZgx/7q4utUp+NIcJGtgnOddpQkoCKhzOoBgEMxpc6ot8pqVexXm+cMt96nfiIKlcHnj1dHL2e8cf2U1UwKEaUM9+52q0P+wsjTuxL6sOsodzEBQMbZYqdcbcKSgGiNvDmG6Pt8+kTQ7SZAKhcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:03:56 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:03:56 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 2/2] exportfs: Add support for export option encrypt_fh
Date: Sat, 27 Dec 2025 12:03:52 -0500
Message-ID: <38e27dfc9dcc57b1d18aa112f4cf5a062bea28a1.1766853122.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1766853122.git.bcodding@hammerspace.com>
References: <cover.1766853122.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:510:2da::26) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|SA0PR13MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 009453ef-ac79-4b6b-44b8-08de4569ebfa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lzOmlv9470lxICcyuUoJfPv0n0VvA5TOQSOZbO9H+qfJ428SobbYzYlAD2sU?=
 =?us-ascii?Q?35kMvu0h6sN9ab3wTpr8T/6mSXezIKKfsTr9xjzLAvYQAV+zRbXfeVZ3FXNu?=
 =?us-ascii?Q?jESRy+6KYXi297beZmdv/Gb4dOFavMl+W+/F6pxGEnAPSCw75xSZQpYrQPJL?=
 =?us-ascii?Q?z6J6eP7dZbTHwUntBbmLo7J99yNoBK303kt34OxYHT1p4i9Ml2+TnhZws+bp?=
 =?us-ascii?Q?KHSCz9c+4Eybct1MuQNuyhWw4dTtz9ogkDslIIjsh17lMla0yhXzneQQh86q?=
 =?us-ascii?Q?0o79p3dunBuPhQ2n01WmEOcP38HHlhNB5NudOp47chFFw4NE/vQf01Hx+e9T?=
 =?us-ascii?Q?vlw7xyd5O+7aYGaN9vI0tn2qqo6xsPqvd1mtqKpg/WvL40jvIfpSTy/ZUOyF?=
 =?us-ascii?Q?ANtLC7l5TujEDQxu7Dmn1Aj/M/Nkft+4LRqNzRQDHUwhZkEU5DDo8MI3sugp?=
 =?us-ascii?Q?pYkm0p1Ovz2LRXT5PiP6rm8oRjpDjULymclRk7kmzMTG2amjjvVu/fuwnMdn?=
 =?us-ascii?Q?A+GRUnoZMeUVRjhj0WpaL3NwxylCYdOnNA09nNv867WjzhiqbqmLPOlYijDG?=
 =?us-ascii?Q?ke6oTrTkXAbNxImJdPUaD9ZtkGvC3QxRrcMSyaZpzYTTO84TU0gC8h6hCAbL?=
 =?us-ascii?Q?rwXk2fsSyS3HdIrEZR0ZTMt7n9EWnf1kTKJ5XCLFR2J1uOIJGqC8Lnmvxaar?=
 =?us-ascii?Q?JqcXCFjOPeSePc+Cf42GtBR1nawIjHVRWt5f/sqfTsrVzQ40VvbQDhusfywS?=
 =?us-ascii?Q?1oWqN032aMuizgEL0Mvng55pO/bBYXWjSecOOC1BK+mBkUQpPV2vm0hw2qYD?=
 =?us-ascii?Q?hOWx+LVPUBbzyvHZperh67xadYnbXTs1yoKcrvhULwIjrzy7s4x9fNJHiDaB?=
 =?us-ascii?Q?Rq7+zryqsRhmTMhonEetUiaPDfmvxT5mtHvRz5/D1IxeRtJ8XIs2+H/FS3ki?=
 =?us-ascii?Q?U9D/JKa6S5OP2RyNORAKOVrifhd3ncXuH4IpTctHkMIqV+bJ6wm12mUtdmsE?=
 =?us-ascii?Q?kV4sen/8vPQ3HkXzWoMqOdTZvELZ37YVn6CdrNDIUxTHocKshO3DFM1i+1mJ?=
 =?us-ascii?Q?VBGDUtfyLpqpPKIur8M0BshG5xZwDK/mFPzUbVkYj6WTGXPjYuMyM/kvLDSt?=
 =?us-ascii?Q?4mCOtqeMAer1ureVVbbPKKWSOvOBY3RH1FaA6nWCWeSDgTW9qQ8zxSgl2mKq?=
 =?us-ascii?Q?9AZhhJ1QhqWmSeUgH7yKihZ+7ywweyhDeR8rB2iH6LamjS5qIZ4qwjIk3a0b?=
 =?us-ascii?Q?TeF3uu/HdovKKnz6B8ZX/HEZcpnrx1lotWNS/691NUXevls8YQjgW0ihXkzM?=
 =?us-ascii?Q?SVUAFCv/53uqcpOgdmN0u/tXrDWfD76N48st0B9fE+OcVu+46u+aPiqyByAm?=
 =?us-ascii?Q?D/w/axFD/PSrN6SsZhIlA11QytrWvlY+lV+GE2eKiZGBnUCCPdwjozZS30Wx?=
 =?us-ascii?Q?Psq8YkWDAXH+6ZxJgyeETWVGFVM/HEIR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gT9tO7IVcZyNsLkixuWcq6iSgdOOnNH/vMbAXgDIiNSnTPOiqh479hPeDDvd?=
 =?us-ascii?Q?Grabf6HWpNJJJjFcrLWnNFsRcYR75QLsVaJzDRwuuBkxLOU0128HYpE2O8Jt?=
 =?us-ascii?Q?6W01kH7ZLMJPUzZa1HPM0ZhyRacvHr+YkD5/R52+vxOF5duEcFmvMU9+FUSF?=
 =?us-ascii?Q?wZwR453jeVzXq5MdezmnEJHo+2eeN0Tgg4cjy18VWf/yetOydhkv8ptgPFy8?=
 =?us-ascii?Q?6Xuduq+ZhzMtJufrCPwxgnD8VVJxcybU+OZ//5k9ekao+7/M8JUSo13YsM4z?=
 =?us-ascii?Q?rGaC+9lsE5SQjVI98QjT31kZmau8z9MU+4KtMraZwiyGt3esW56lnsG1Cjhk?=
 =?us-ascii?Q?wdRIuUyynLtf+Hqn5hvEXdsLwESwT67tnz+EmJt7y5JviPWgeGBuMSwIjYsX?=
 =?us-ascii?Q?LrlVtUtyzdvxuIZAI9kUFpwd6WpBMinxp24y+oCBcl4hl8c/RP4xCYcXyjVo?=
 =?us-ascii?Q?9YQRwZyATrGQdchIXbJYU9/JlHVOYHhscU+SXdwsjKNmaV9ZqUk3JYRgJ5yv?=
 =?us-ascii?Q?I+uAJmpE9gCcYVNtmDxVxzctFcZtjB3TSFTx19BCsbmN+pmmUVAsuN77LS78?=
 =?us-ascii?Q?INuptiSoE7TcRZjXTw8Ya3c29i5T0pepv1BkK9KhmBqT3VbkvttsAcJU4XN/?=
 =?us-ascii?Q?actqN7a7GLMb3lwh7aioRhbCu2hKYjejZDiURwAwKT2y6Ha8XobxeuCALntV?=
 =?us-ascii?Q?3X1gNrdh2m1QXWiEGgxc+eI6uOTIJxvfPVYe3ZLzDkHRXe7m0m/4P3yFfGgM?=
 =?us-ascii?Q?80SZP6QnH/STOXGXita4TTOpNMR7zC0Chz2Nukf1WPI1IGkEwHgHFtWggd5u?=
 =?us-ascii?Q?5OSFEnkI9ZeqdrlBxcfSQpMw0b+zTjJzQFh+KTAzrWnrCnTO3QvDDZQlMVCQ?=
 =?us-ascii?Q?rcSPckESg0S38f2Go/5d8CCrZaaceOlvOzOHeI+wS//lu2CmNtU5mDw7SkOA?=
 =?us-ascii?Q?M7JYr8xw9BYcom49B4JOl+3etQuydgaOXHVV89KNHTffemrkj75R5TzVm3sQ?=
 =?us-ascii?Q?iJl6zQ9pIJXR9zX976WeS12IHyCg8srXrCNiNMzBx0l6nxg8dxrydUjlrxFs?=
 =?us-ascii?Q?rSI0Nq6IETMBYjlxJsQMzfRwDUGFIUk3v6mnUhYnFicfDSZ5gx6ZNiXCbU1e?=
 =?us-ascii?Q?018KM7iI1fiSvQQuitWRiIkc6oa2lvvtzyCUZo8njOHosEie0e2W7hpUEzIM?=
 =?us-ascii?Q?jZu4Uqw+BKGESOhwQhgMxdkNy5W6Dt049srXcm9h5b48fZ8bup7DgfnV1UTO?=
 =?us-ascii?Q?/6KH7nve3wcQv2o00/lfMWekgc2zMPcO9A14Y8ooLTccWbIRhBz7abFFRVPI?=
 =?us-ascii?Q?RmKE3SOBtu3MOydZ5UVkLwILWvJeZpTey4PCWH2uVYZredJTKXIDLCxKEhgf?=
 =?us-ascii?Q?vKdHixPsuRTqUD31PHeXp1QNefn1jrvJaPc8KSE7MeXfEqi33BH7aFzBGd+e?=
 =?us-ascii?Q?ND/CFXAjW1+2yXhnBzkI5HxLXrTErYgQetoa25EHwzNx2uos1o78ph1M7pwn?=
 =?us-ascii?Q?T7lD+6a+PeRXUnfdyJDZFj1bChyhhQD5ru+0zAd6IEPv/iys6PRUv+EZ7eTu?=
 =?us-ascii?Q?wsttNkOUKBMNQqCagqAhFPl41bdvPmQkz0F/tL6f9DUn2RwwwT+/QjVO0ezh?=
 =?us-ascii?Q?1ARX8jTazuHtfSv771L9gPLzv2AmmpWVl1WLTsoO4+3cljSdhhrd2rQN5D++?=
 =?us-ascii?Q?h3d0thq6CIgfxq5S40oPXRH9W0tBcoddwUvZ9rZ+1xMyykX/5qmOHNBzJ1ab?=
 =?us-ascii?Q?jIDFUZWHWeVpYLlip2HP97W7+nbqn4E=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009453ef-ac79-4b6b-44b8-08de4569ebfa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:03:56.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yUYvgBwBx7DS7Ng/VjZwq4HCUTKhzxk1bHrnJKX5865RvXtTbvih2BbWmE0GYtZf87u9/rx1HisZyAKob9HuBHquBuVvH1RKz3jLjjj364=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

If configured with "encrypt_fh", exports will be flagged to signal that
filehandles should be encrypted.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 support/include/nfs/export.h | 2 +-
 support/nfs/exports.c        | 4 ++++
 utils/exportfs/exportfs.c    | 2 ++
 utils/exportfs/exports.man   | 6 ++++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index be5867cffc3c..d893f49dd696 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -19,7 +19,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS	0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 unused */
+#define NFSEXP_ENCRYPT_FH	0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define NFSEXP_NOAUTHNLM	0x0800
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 21ec6486ba3d..52467a99e7fb 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -310,6 +310,8 @@ putexportent(struct exportent *ep)
 		fprintf(fp, "nordirplus,");
 	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 		fprintf(fp, "security_label,");
+	if (ep->e_flags & NFSEXP_ENCRYPT_FH)
+		fprintf(fp, "encrypt_fh,");
 	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
 	if (ep->e_flags & NFSEXP_FSID) {
 		fprintf(fp, "fsid=%d,", ep->e_fsid);
@@ -676,6 +678,8 @@ parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
 			setflags(NFSEXP_NOREADDIRPLUS, active, ep);
 		else if (!strcmp(opt, "security_label"))
 			setflags(NFSEXP_SECURITY_LABEL, active, ep);
+		else if (!strcmp(opt, "encrypt_fh"))
+			setflags(NFSEXP_ENCRYPT_FH, active, ep);
 		else if (!strcmp(opt, "nohide"))
 			setflags(NFSEXP_NOHIDE, active, ep);
 		else if (!strcmp(opt, "hide"))
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 748c38e3e966..908a99f48516 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -718,6 +718,8 @@ dump(int verbose, int export_format)
 				c = dumpopt(c, "nordirplus");
 			if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 				c = dumpopt(c, "security_label");
+			if (ep->e_flags & NFSEXP_ENCRYPT_FH)
+				c = dumpopt(c, "encrypt_fh");
 			if (ep->e_flags & NFSEXP_NOACL)
 				c = dumpopt(c, "no_acl");
 			if (ep->e_flags & NFSEXP_PNFS)
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 39dc30fb8290..610b603aa859 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -351,6 +351,12 @@ file.  If you put neither option,
 .B exportfs
 will warn you that the change has occurred.
 
+.TP
+.IR encrypt_fh
+This option enforces the encryption of filehandles on the export.  If the
+server has been configured with a secret key for such purpose, filehandles
+will be reversibly hashed to impede filehandle reverse-engineering attacks.
+
 .TP
 .IR insecure_locks
 .TP
-- 
2.50.1


