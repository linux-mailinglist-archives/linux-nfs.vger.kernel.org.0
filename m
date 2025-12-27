Return-Path: <linux-nfs+bounces-17327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB2CDFFFD
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86E6300F72A
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4622A4E8;
	Sat, 27 Dec 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QS5jpizi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020092.outbound.protection.outlook.com [52.101.193.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FC3254BE
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855112; cv=fail; b=JBq7oli4NTrCeS2ARc+rg1OtOBDjJGHFHl1UgdukQ0fHB0ABTUlJWHydHz5uoGSEFwD+q7nS0Xd1Z0pfG84i1To2vxRkkghohRXT2U6omlxfuin/5PCOFztppmFnpTZq7pgEcpgWOM5w1s8kTBIoHQ5SMoTPc8Nzc9KbJbX8hBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855112; c=relaxed/simple;
	bh=P+V7ltZpSfR4JYNiMjqLAr6utx7NCGvVFx4Xratu7Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjWAO2Nxh8JJtg4a0Jr+bX4B8gTeBieg73g4aDF7FkHoCLO6soxXnVtx4QHBG+PfeqHIulo9qFOlC2+xTeuQXCInVTFr0KBuKGuuxOCoMnnI7GpG6zczCLeVAMpfercL7HGRgRJ7WyeFCJvtKPP+BP9YvBUYdMSBkwLk8Kq1D5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QS5jpizi; arc=fail smtp.client-ip=52.101.193.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZCJPsuZRCe/bRbkX9ngv/fWi5u7xhL57Y+KVuBZ2KFv1bO2vL4aYpdj1AAPwe5bCGs3qDY4G/hj0xNm9qyO1E/wp8FuwXakLbK607IEY2KKLuRfsgUcnsMg71KE9mEjrkJ3SIwMyjvt2Ft8Vs380pzdn2ffONav2d9lnydR5M3Oa66cUtRHhuwWk7ucCQUVJhWENRYXzSGCqhjBGY42vlHOYa0QOPJLVeXVt2APL2tS+lwSDcgM7lbqoqllNxF3vK9mFpCy/jnJlpPlaZRHY3lwjHO0O9A+2waOKT6xQdWR0Y6cwvOMYsEGwirEkWf3q+yswAikJw2boRCls3QAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sm5sKoiv93n+9R9NI5/clGUeIr8kthXWlF1uWmbxXik=;
 b=Dunk6C/g4PlamP9PDsw/aQVHM2Ntg1t1vUGNcjOHU4nkJVGncAl0gDqG+ug7EEP2cMokDB6i+We0fjz0Jo6Fs2iyE/VLBjmf7LW2aZEM/ZfWouFs63JYbPDMqx+UL7c4Qw09R2r8ZVsmvr35rIzIiE5TwKRSpcpixKUq3iKNvKCHr+OuUv/W7lrUgN8Ji5Pi8giVm0YnXaUIOWCDYmN3Qu77n7bWHasju82XFkn3RAdaA/7nXnm1idmKjwE9EG7zFgBXWAgKT3ke/e5RynsTwtV8QkXB25I8yvDyYnXtgt0eG+zmvXsB6UokYfxogWE7CV2SGJx/9UxS0QqjqHo4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm5sKoiv93n+9R9NI5/clGUeIr8kthXWlF1uWmbxXik=;
 b=QS5jpizi8wGoXALinSMse1Ufg0WEbK0FLTOJB7nyBDNr1iw7rScLcLvtW/WrxriFFDbnVjjOB6byBKk1HibxrkcWiWrT6pfJtASRSeLbQDcLafTIKB2od0o7mbXvl0kzxDGFAhXlvwdsL8FlgHqMx2RxIM7AZ5kQP5k0ka8ZJls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:05:03 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:05:03 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 5/7] NFSD/export: Add encrypt_fh export option
Date: Sat, 27 Dec 2025 12:04:53 -0500
Message-ID: <4bf97691738827e83b69f1ae6e941c98c16ee0ea.1766848778.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: d65f2e40-ec67-4cc3-93e3-08de456a13ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JS9rGdK3JRDecSmUpv6alSJtaleakH7UAI/t9opfDsFgjlwgyO2ZGA58Ss9?=
 =?us-ascii?Q?bZVDP7iXRT3QkWfiW1TdQsECAUIjJov7N7wNqGXzmxyDYYEVs91acl3VOJxi?=
 =?us-ascii?Q?sSyemk90JeMcDdHyWVsAM4ip+WJz2BmLElOoBxtUMN+ORedetgjDTgncIFGx?=
 =?us-ascii?Q?fZPZ84OBZMrZOJdEtyc6orLk7qR8s6Ffc6HcS9Iuhu0ae5eEiGbPBJYZZ/lX?=
 =?us-ascii?Q?njz149fWh+WhdWweY81v9Dzi+Fxo9NUWZGifOqyoy1d/Ag12MqIQasllqA1T?=
 =?us-ascii?Q?guo/rWxAdbB+ODpsuyyxgpoSBs4oghE7udBZs6wgFOtzFWrkl5k8Hsik8eyj?=
 =?us-ascii?Q?xN0xFdUIN3UZXtwbAo0+Z1f0ghGt47xWuENPYHVwLQwT/TolEwmzTpAA3pZx?=
 =?us-ascii?Q?+eWqudhJj/7ZUAk50Z+zYsy1DiqAppjX7iK/EWwrpEyx58kW9/yt3wIoDEyK?=
 =?us-ascii?Q?UJM44K5lUcjD8whTU4Wd+u0kp4NNr64HgTHwjJ0j9TKRWCOAVP7eBHEC1pKw?=
 =?us-ascii?Q?TGPo/PD6Z4e2ikdC/2boae0SPSw3HJNwKUm4Nvgk2qtC2eevWgtzrNmz3w2a?=
 =?us-ascii?Q?UhlUUhd8ttH3LzEOUUCj1rCtJzkZYNE24VPlKMWFa91eQXvobGx+ugpHjy//?=
 =?us-ascii?Q?yFZ4Re/OphVLWzQC+V4u0VN/kZSKtvGXQbsPIDvDYo250FwNkhU2oR1VnKRf?=
 =?us-ascii?Q?9mMtc8OEgsA6Cc2O+uXeI+oxPato6qzWzsTlxkSCtHfk4zq8r+3Y8YCR+lBT?=
 =?us-ascii?Q?Str8UuJxyHDYwYp/7CjFDirZikBNIkEypvKLXch1vON1Lx0Hf3M4KguChLTq?=
 =?us-ascii?Q?Gko5hDaUrNOmaB91mpAemt9FwOpwWAfxw44/YrPhJFD4hRMVB0cxfqoZ0X2C?=
 =?us-ascii?Q?P21LTlbWCJjHl536HTR/zjHF59bgCYq1WHMZGupUmkd1cXi1RmhOzaiQuBi4?=
 =?us-ascii?Q?VkcHk8l4BR4ehsmvgrRu5olh34qMJFDJl+w9UgxE9ks0ppZKCbP1XqOGx6Kw?=
 =?us-ascii?Q?ELWHSiAZlA6LTxpHvVE3kHg836YVDYntcZ2ONTs6QPAAXm7BjE2Lr0afbW9q?=
 =?us-ascii?Q?ax6UnuLXeJsVRjIAThSDTQ3mykEHstLT2gix3rMfNGRLlHcLdAMDtGWuF2Oy?=
 =?us-ascii?Q?W01x4ih4vKb0s/LxWDrFg7Yiy6MsrXof1pH34T+N5RpRANI+CpEsRUKPVFmF?=
 =?us-ascii?Q?FbhZqJtAwcQnquSnrCXDVjO7cfSdIkr5+9DgvmcSWQTtNieob6I+BbPLXXAt?=
 =?us-ascii?Q?AH+1e2fr+b6Bcg1BqpZ+rpoR2Ypm+LsiKMib1ewBm85lQtFhfveMyuajs6wT?=
 =?us-ascii?Q?2KmSAAuvv4Cnu1gS61oTfsaZxZfX4h6muNpFUnfsocejbPykzImq/h1JwU+Y?=
 =?us-ascii?Q?+WNP3oU5C2xcMmixhXFC7dSiujmSPvMnfQQ8t9iyn++Y6ZxBL9C77kWHffzj?=
 =?us-ascii?Q?rfraQ3TJ27Pd/ChuOf0qiSKwDlT6dZ2t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IE3KsVSttdgNmadELh75xM5yRYnnf/zHoIn7T30XwUaAUYZyW9liQ685jMRk?=
 =?us-ascii?Q?OrS0htvEOcva68mwZhXNV5qQVrZkHnrFtKwucVVsl+7mzToRYLq3xXgvnggx?=
 =?us-ascii?Q?x0G72KDTGz7NsIQaXmyNijE61U0Zhx3E8fmOAsmFn1Ey1uZ0qAD/XWWtgKuN?=
 =?us-ascii?Q?zWNIci+zqm7D2M2lxuvJh4VmMNjcC8yi63XqZSEATy2PAVoe9Z0tX0Eo8Djc?=
 =?us-ascii?Q?s+qFTLPhJNmf55YGKNJ7hTKe9yE9oHPgXaCsAdprWpkjDw3uBmSU4fPxAMBI?=
 =?us-ascii?Q?s071XDnRXJqswxZUScFFHI5G4tNu7FFrBg94EOfU6JQURHkmG8vpMtB0Qg8n?=
 =?us-ascii?Q?Jnr7cmXAsJ3U8P7AF8UM20Judu2dHbzTkJUZzNIUQS0eyCJK0M3ZR6RuAr0O?=
 =?us-ascii?Q?+8F0KVSYp05JUvCNOIAWJSHObXDzPDAIfpeZRjPeKpldhWxP0hT2ffT+6Ewr?=
 =?us-ascii?Q?5UIZBxmtLpb/SdmuUetkZozkK1jYhbZcEiB39paeQtOddG9UM3M1xT0hEeg+?=
 =?us-ascii?Q?W9oFOuCSwlFuvAUjLRVasMkuwE+n9onKkmUr5KGbxdo//yvT8WYB8+5MA8xO?=
 =?us-ascii?Q?8yzGAEzWdc5xkCtMTg1XVT8Rz+sydWy0SzQm4saXtGP9U80kjq3w6bhTWfLq?=
 =?us-ascii?Q?dOBzewjLgkL3fx5k+/3lKR/pZfeC5jXXDcd238YflHisDKYDbn1Z+gX6FrSQ?=
 =?us-ascii?Q?/y7ihyjA2eBrgy01oiStyWi10DeZFY7aN6KdgZT249GxO5bD5U5nbH0xM1rJ?=
 =?us-ascii?Q?9qrLovH2eU9u/YJdPLk30iM7wGQM+UgRmxoDOTgHnstuIX60MrRbJvb7U0YX?=
 =?us-ascii?Q?8IhP5qurJv9ItdSt3ykLgY9uvWBiqtoiuHl1BSgZYSJbi1j7PTJHc1XriV1U?=
 =?us-ascii?Q?MtPacN3VkFImfEYvuCVrnnNG4VWnvLeoIjqYJx8I3aJkv/ax197tbbAcXeei?=
 =?us-ascii?Q?w02sXAXSMmf1zvlEAPaVcJmx9zqFFDmn51JwmGJoSCHxtCGnZQ1Um82jVNR6?=
 =?us-ascii?Q?AvqmQhaqg4B3uYEilwRXRUhbjO5ks03um/GksW6dwaNqQT/YYwqtSAEha088?=
 =?us-ascii?Q?l5/lkqfrHb8dd4vS4pG0R3xY7tn6Ck0K1e8mmk3vx80ADQEnetwGI0PnWXq+?=
 =?us-ascii?Q?5ooQTNLLQjV1qjS2kD8fRE5ncakXcx4RAkVoMV/08LjzgdVQ5TkqN9Y23sBT?=
 =?us-ascii?Q?6K3P2US6QI5r7KnfW8vWibNJxEWaETuRskGyOlZUbtzexC7EWvZ9fMlz34jn?=
 =?us-ascii?Q?yCuO2i0PTWoIiC4Q++evNf8nQ01YVHrrvaXYJX2ARhPcHQgkiX5LTbBUIgRl?=
 =?us-ascii?Q?EhqPTUvg7uMyZNW0ilmsXBxe23s3D96amhey3ZUXPwBp4ehxZXI0VAp80c5X?=
 =?us-ascii?Q?CmU2weXeDqwzgFTfC0J/DplZKmJUkk+nrU+F+EbK5czvFvwJBGVm1XK8BDQe?=
 =?us-ascii?Q?jRn0cPXG7I9fNyjLbtqUzTy3xjfLd9mUnlH92bOADBXEOHPT3K430HJnDpMy?=
 =?us-ascii?Q?h5GBTslT2kNTRmQBGkjKYpYGKWPmZ4hYK34lxKBORjajmWGAyPgSUudkJ/MC?=
 =?us-ascii?Q?dlM8C1B9oXFDZUJX5MGYiXXBvaI8ll1R1BwvurpNFNXhBs1JakbagyFOZviQ?=
 =?us-ascii?Q?FSHA6T6RsGIjnqNfE6UVgej6lFORKZ5IHJfKcif/1AtPC09h08mknl3au6o9?=
 =?us-ascii?Q?CPJ1X0HEoCqJ/lk3EpOpMBNEdZixmtCdLe9nfg/SiAF580P15RZj+JH1Jr+l?=
 =?us-ascii?Q?f/YgYKqvu+jj7VfAQ7ONlg/rSeQkZPU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65f2e40-ec67-4cc3-93e3-08de456a13ce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:05:03.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnYgvV7BcQErD4HjK0+ecqIzK0ck17r3a/SPOJb4Xd+XeBtlzUEXjzdv+KBEEX6TxTttNoUSCQ/vriSLtZWNGzKji+8pvcumEb0aDLG2dSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

Setting the "encrypt_fh" export option sets NFSEXP_ENCRYPT_FH.  In a future
patch NFSD uses this signal to encrypt filehandles for that export.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 5a53e1af88d2..acc20d389376 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_ENCRYPT_FH, {"encrypt_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index aac57180c5c4..8bb971f68558 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	BIT(5)
 #define NFSEXP_NOREADDIRPLUS    BIT(6)
 #define NFSEXP_SECURITY_LABEL	BIT(7)
-/* BIT(8) currently unused */
+#define NFSEXP_ENCRYPT_FH		BIT(8)
 #define NFSEXP_NOHIDE			BIT(9)
 #define NFSEXP_NOSUBTREECHECK	BIT(10)
 #define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests - just trust */
-- 
2.50.1


