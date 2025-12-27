Return-Path: <linux-nfs+bounces-17324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA9CDFFF7
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4B72301CEAB
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4032572A;
	Sat, 27 Dec 2025 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OHMWPZ+x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022078.outbound.protection.outlook.com [40.107.200.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2424466D
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855107; cv=fail; b=cSRPp7ASEQESoV94c/u2QF44Otikf3GrEDmDd6MiFUuiiRKcAqI9R5z6n+T2RqWBgJBuHPBFQ6g1gSnpeqPo0OppfBoZqefLGevdSdnbnjWcM7/zeCsHOzO6/FtNMaFK9Si+ad4PN7/Fzx8v7ub4AwnxroKB8ZOhrkORG2bRltk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855107; c=relaxed/simple;
	bh=mbcogtFHWjoaiqWFdMeMDnVMHTCuk2OzZBpjl91B/8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orTa6iomGXv27h50fx9A3MlQclakQY1irGzp0N/cTo9I7W6gZcQF4f4MPsRH2P+ult2YE9xReMg1Zmiy0tTOzdCrcvu/x+6890BAbSc56R3woxN2mHEvjdTvoIjQZe0+DWHDB8wriR9+goBx2B8oyeocvfR4dbWwrPEJpdFj5y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OHMWPZ+x; arc=fail smtp.client-ip=40.107.200.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A62itTlbNHlWOUSm+UxMDf0WVIMreWL5yhY5TtsCArpZF1s+HxYkDSvMWxZvV5KhZqZudFJzseuMANO7q5AinrdFSbHr/p7EydBQ5stj15d4qiKBjakh1M09i6ivPxs1y16qaZ5QVwzcCgX2cdSQQtE0EemaTbSdCjj4V+vr5CRYMu7QOZRmFLSMNlxMKsBXi4JiKTPCKyvBNVJxpexrzOSsBJyT9W9F/8LILX1NDTU1UfMU20gkhU6C6XG3CBjki5SH78oxYTJFdGs71zdw03qIeXuPEpzMqxlj57CjifRHZWbQPzh0Kg/R6EbE5zMn227zmFuqTclBCjY4XALr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIfauq9Bo/C5H1NtFFij/VQsZerMHtewBOM7zanYdkc=;
 b=utZ22zXUKcIpZseQwwK0slPxc4d68oAZoK69SX7Kcy7Tn7F3Bsk47TA7dvbyVpmilaaMlY8BoIgQUme7ba/8NmHQ4J9bkk1x1YWbItKJL/zkPkdlsURCsnC8pPp1ZZAYpvHBqYHWU1j0uBDdZVZcWKWI9zCZEvc5C9r+OaB9Pcf/aQkYsR/7AfzxfXYG6PXyNHV1i+Frpzwz8yD9/bVaO/2D/RItBBk2SqBq4/LGBjcVGn0MWAc82b1+XfdJn0FvFnnOm/NSh/vmU1eTOoOzT2RAQBPwiA4BA9ACCKe4B+HxL5cXsg19Fgq2tof/tZZxtSrlg3VWUee0U4AYBg3Uag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIfauq9Bo/C5H1NtFFij/VQsZerMHtewBOM7zanYdkc=;
 b=OHMWPZ+xnAICi+cwUekmy8RMa8rqTCIehMPTOGqb/Zi4WqNGgduKnrXjzNqFT65UCiXsmLCEjqjlGczesgR5cu4HdL9vDh2lXI/fLW3IZag4DN2SAJPFMMEqk2JcC0xqNzINO05p8N7bW+HHMq8JPSI1IpfVNcCmCtT+xTKcYQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by SA0PR13MB4061.namprd13.prod.outlook.com (2603:10b6:806:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sat, 27 Dec
 2025 17:05:00 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Sat, 27 Dec 2025
 17:05:00 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v1 2/7] nfsd: Add a symmetric-key cipher for encrypted filehandles
Date: Sat, 27 Dec 2025 12:04:50 -0500
Message-ID: <0c32e4ebc10c607db6ea50b83274301e45c044c7.1766848778.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67c6a576-e640-47ae-6b32-08de456a11ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4f3QIW/mKkiH02femYPDz7d54lWiW5nB2h9JLTmkiyY0zJMSqAoztfMqOsm6?=
 =?us-ascii?Q?3QTBUZ3It+wva1bS5EBE6CwtxLt4RuzvNNnBMDQ2vEARapu+Mr2KLBY4cWMz?=
 =?us-ascii?Q?e6zz/R4T+IILqVF3X2HKrKbQCDjlyCX8aLfZ/LVNd9ZBeOU50KQgkgZQy02N?=
 =?us-ascii?Q?15diL6ZQNe/MA7quG2ZLU7ZKyne5xKGUrBpdwhOsQlu06ZAhJTkjxUpLEdaC?=
 =?us-ascii?Q?0ywQerfl4eRUnfpSjv0ZIY0XXQvZ0iLAyLWv7K2bTySBLujmaq2lLgmtnVtY?=
 =?us-ascii?Q?OjwD8OApCyZjQ3NeGGbZnwOr3sxeMZ91NJfdMaF4Lq0noHSGBMov/81EfAwC?=
 =?us-ascii?Q?XwvNiXjp2GdOQ3+vszYjt+L7H2+hDNKC4++O0nx0nqD/Mm22kvectkt0b2Ny?=
 =?us-ascii?Q?bW47FRSsYEGzCWlfdsN2ELWgyxspeEraCI8oqDuueafMQbnHe7fCFhNNSPNU?=
 =?us-ascii?Q?Ck40gG4hRTLwQHQaFyMo9BBzxUEbPNw63DwopkJRRC2H3xHjI/+FIFGMOGAW?=
 =?us-ascii?Q?8nu9gGpZJQkEK/ekrkl6+2DnRce6+IkNMAwlWBmeJ0Tbo/cv8LQZbWa7kVJV?=
 =?us-ascii?Q?ta194mS7+SCkvOmGDM+enRuryHmmGTeJjADBDv3ZHRNgqHH9CVTZGH6vuFlb?=
 =?us-ascii?Q?ZENeiPDkhegXOY5l7ZqV3qZOzyLz+pn9VPjBHLIBdiZbaQ6uLRTh9eQTPEvC?=
 =?us-ascii?Q?frVfUBEMwvL6m62qpVkDUeTUwANxizURFvspSZQRkDPM6ZA+ydiUtjLE7CSG?=
 =?us-ascii?Q?ZDeIw3C4onx8Ax7lxI7fpfFqOkMY229jSGshO2VwKD4ZpSAUB/8RVJXcQSwF?=
 =?us-ascii?Q?xSl/U7v/hq9Z26lYxacpWRpxd4ejEoe48wRmnhQ2yKkmpX9biGpRVfMKUXAd?=
 =?us-ascii?Q?kiv9AsLfLQqbANjbdlUReEHugvujGGwjEcdvdDMlusa1AqihvBSh5Aw9fLfZ?=
 =?us-ascii?Q?VdyMr3cEnVAj7XOPsPMoQ5LCRJgH0oiv/IY7UYYH+e7ctMdNyAEexSvz3hQs?=
 =?us-ascii?Q?imeY+rqVtsOMwUuiUhyb8qqAXpCZavN6BLkBk3AAqb6gTA5qeeXWRGu1o/v3?=
 =?us-ascii?Q?TfdPzQaQheeGoNOMBLLyICSWMGy/bTJ5hhR6A0amMRLYS2wJpElDGw1Esm9G?=
 =?us-ascii?Q?P1aYykaomfIo6DwOd+aMwaHOCflzP8eOtMpuFx4GhVEHdgcL04RwX415rBUD?=
 =?us-ascii?Q?lVj+AsX51NsuP0EuwtMzMAdbPAxyOAKChZI6cKVwTn2aF2kqZRtj5SBkqd6J?=
 =?us-ascii?Q?IFn1H8pFamPIW+tz2duabct8EQZMOopzP6pklLbXLg0fABdmRrlrECrprSH4?=
 =?us-ascii?Q?vWIcgKSek4Ovfd5Nw1IqD2JZKb67h7YDrXJV4w4u/+F/ciqggh7kJT0eV6s7?=
 =?us-ascii?Q?EqAaezjJumY2SxtlfLhb/PyOEDLtR10rd5f7xkozRNIKBMQO/968HGV6oFJ+?=
 =?us-ascii?Q?nhEMMUMiPW0keE5Qgc+Ty2GyzLy6Yi1U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SPdEKkWR5Fu9HAqCerBVjExlpC17nd4/nwkZe0A8ffZNuu/cwmcrpCrxl05R?=
 =?us-ascii?Q?1C9mRuHfyq08Rr491INWJfphTJiSm1EvoUFpWafQwTxHwOAdD+BxJxcu2ZCx?=
 =?us-ascii?Q?ntXYXqMpIpGtNrExrQKamYtLgtzZxWIFIz4F1+YmZ8YmxnOH8F+5gZSp7D0C?=
 =?us-ascii?Q?1SPyPSg3Ly26MYdD/A+87OQXLIulj5+AO0TRfJ4YTLzSJf0sGKsF/UXfZx8p?=
 =?us-ascii?Q?InA8vnZNdD6pUhXuFeNx+VQ+xfXKDTM3of5utiQ2baow4wzxlI494saNqH4x?=
 =?us-ascii?Q?asRzDtqwOQRhSeB57rC8HE0k6RuzA9Id82t6UIoA4iNqM5/alWyreC1GG06Q?=
 =?us-ascii?Q?l6zyto8/IYPUO7lapdUZLhWwvrBL64iVcf6RhWdH3Jh7GWgLcZhMQUQwJ5qR?=
 =?us-ascii?Q?w1f7PNjcfjwdJvh5LJdSCiPak5I9zvZHWRHMUt7JjxWzoiUXzQg1I/GAof+L?=
 =?us-ascii?Q?0Mn4rxJuk3O1MohInLEzxU0oCJ+iCpr0QCbObI40af2/GdQrVR0Qwz7lM7gH?=
 =?us-ascii?Q?qL/+PM9qyBMU5wV5IB9nZQ8drTQXtHU1VTnL3YT9PoLEsaFQhoPmduqWzR6a?=
 =?us-ascii?Q?6gUj1J3u0stAYtwVJueXVpneVV4nb3Os9ycjHiJ+3xn7qbrMvvSXB8Gdet9h?=
 =?us-ascii?Q?ztYmrZz2oK/faN4HFDmhArirsVUy7PDzebMF1R5uw20hX8unbRlLNZM+U1Jr?=
 =?us-ascii?Q?AuPfUksSxw1lhnVSNRqRB5DG+ExQWSUiiKVG3yQpfw6Z/fae+XuQFZUDkn+u?=
 =?us-ascii?Q?SCIhPaXWS8HWXJe5DoJQYqdHM8WIdXZxnZXVp1ST/GldMOmdP3UidC8Usajj?=
 =?us-ascii?Q?v4tlj7zY+f0RFDQ43PUZ1fMIChXtOA+TELPArxvMM3xmavcIOE20Q/2ckRC7?=
 =?us-ascii?Q?j4OeCEU3CgtWQfd0p+WyqYcxN4FfQXY0OG3cUPFu4BG8R22H/I0xQRMuz9dC?=
 =?us-ascii?Q?u5Si9aYKoPE0hr0eztd+3n1tV6Qg25KoyRkFJFcDL/cbZLpFpX+ee2h0Kk3e?=
 =?us-ascii?Q?0XN/hqSZ9BqFFgzg/w8uh1Xssp4r/FlLMv4DFGZbTURw+7YHjpYdKl8nVM06?=
 =?us-ascii?Q?+W09sG2jdFDunV6dj0/BsRZm8uo++o2Yt9nUPImonuUYN86yEEgOnpwVtD3N?=
 =?us-ascii?Q?Gr17qGX8hoXCIFdlwTHNNwbK9ZYG86LWWu6NlUJ5nrrLNb+ArqGVGz8ZNq6a?=
 =?us-ascii?Q?5Fep0lVwqep/FPUWWFH8iqsRqYHSeKIaZEBm8aSWoguco7cif07gvSBbX9zc?=
 =?us-ascii?Q?LQbTKgogm1bf+sRa22PHQJyVRiA7tqJVlvSU7ZBF86W6KGVj6HVS4cP56y75?=
 =?us-ascii?Q?+1Z3xjVzVJy8n/ULh4FcF20xNg43cQ1jANm4Q2kOf0A0TdNZX7SlVC9iyotC?=
 =?us-ascii?Q?8J7Ek2cYfnX5YHhImXdHQfssMg6kv/MXBdog974mGAtWguBA7bI6DR4IeTWK?=
 =?us-ascii?Q?xR9vpInTUfqEV7vmFrl4Ahm5v1AcqnTkeksvPrS8pNIbYsNK5m0xxZ3GzRa8?=
 =?us-ascii?Q?o3kKdJs0eMxl+T8hMdzLGbeSwRHXm8kiWDliQtgSH/z/x/Z9JVV42EtDsMWP?=
 =?us-ascii?Q?ZclPMpLbrrh7E8vkC8WKIuI1jnGqD2lqhSbPtPntLkgCXrODxSF6HS43MvIR?=
 =?us-ascii?Q?I87fcbW1BzREdWvKT89njJ7ixwuhOCZpm5aCr4nYfn9asc/zjcZ9M0Q/4/zg?=
 =?us-ascii?Q?vUy6N87Zg2ZAU9KWO/S6LqTmkQ9su1YAYtJ6NYQbGLYs2Skh7tBNZbTafbOJ?=
 =?us-ascii?Q?pD4XNBaVI4S4SHiitdeWt27Oj1qwP8Y=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c6a576-e640-47ae-6b32-08de456a11ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:05:00.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWV0si7PzeW+EblJbHHnPspIWI7TY6nM+aAWI4+GNp9y9Kg36fbIbA7nQp/+7ZgcvLyyIEygCJPRJjdXzHYhQt+o2SIZKZX8Fyv2XBYs2vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

Expand the nfsd_net to hold a reference to a crypto_sync_skcipher.

Expand the netlink server interface to allow the setting of 128-bit
fh_key value to be used as an encryption key for filehandles.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 Documentation/netlink/specs/nfsd.yaml | 12 +++++++++
 fs/nfsd/netlink.c                     | 15 +++++++++++
 fs/nfsd/netlink.h                     |  1 +
 fs/nfsd/netns.h                       |  1 +
 fs/nfsd/nfsctl.c                      | 38 +++++++++++++++++++++++++++
 fs/nfsd/trace.h                       | 19 ++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  2 ++
 7 files changed, 88 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 100363029e82..1e4b2d1a61e8 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -78,6 +78,9 @@ attribute-sets:
       -
         name: scope
         type: string
+      -
+        name: fh-key
+        type: u64
   -
     name: version
     attributes:
@@ -222,3 +225,12 @@ operations:
           attributes:
             - mode
             - npools
+    -
+      name: fh-key-set
+      doc: set encryption key for filehandles
+      attribute-set: server
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - fh-key
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index ac51a44e1065..f932d9b16e0c 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -46,6 +46,14 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
 	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
 };
 
+/* NFSD_CMD_FH_KEY_SET - do */
+static const struct nla_policy nfsd_fh_key_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
+	[NFSD_A_SERVER_FH_KEY] = {
+		.type = NLA_BINARY,
+		.len = 16
+	},
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -101,6 +109,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.doit	= nfsd_nl_pool_mode_get_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NFSD_CMD_FH_KEY_SET,
+		.doit		= nfsd_nl_fh_key_set_doit,
+		.policy		= nfsd_fh_key_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_FH_KEY,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 478117ff6b8c..84d578d628e8 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -26,6 +26,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info *info);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3e2d0fde80a7..b914b34ac0f7 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -217,6 +217,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	struct crypto_sync_skcipher *encfh_tfm;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ad1f3af8d682..ed08ca63f139 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/fsnotify.h>
 #include <linux/nfslocalio.h>
+#include <crypto/skcipher.h>
 
 #include "idmap.h"
 #include "nfsd.h"
@@ -2129,6 +2130,33 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct crypto_sync_skcipher *encfh_tfm;
+	struct nfsd_net *nn;
+	int fh_key_len;
+	u8 fh_key[16];
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_FH_KEY))
+		return -EINVAL;
+
+	fh_key_len = nla_len(info->attrs[NFSD_A_SERVER_FH_KEY]);
+
+	if (fh_key_len != 16)
+		return -EINVAL;
+
+	memcpy(fh_key, nla_data(info->attrs[NFSD_A_SERVER_FH_KEY]), 16);
+	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	encfh_tfm = nn->encfh_tfm;
+	ret = crypto_sync_skcipher_setkey(encfh_tfm, fh_key, 16);
+
+	trace_nfsd_ctl_fh_key_set(fh_key, ret);
+	return ret;
+}
+
+
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
@@ -2171,6 +2199,13 @@ static __net_init int nfsd_net_init(struct net *net)
 	nn->nfsd_serv = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
+
+	nn->encfh_tfm = crypto_alloc_sync_skcipher("cbc(aes)", 0, 0);
+	if (IS_ERR(nn->encfh_tfm)) {
+		retval = PTR_ERR(nn->encfh_tfm);
+		goto out_encfh_error;
+	}
+
 	seqlock_init(&nn->writeverf_lock);
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	spin_lock_init(&nn->local_clients_lock);
@@ -2178,6 +2213,8 @@ static __net_init int nfsd_net_init(struct net *net)
 #endif
 	return 0;
 
+out_encfh_error:
+	nfsd_proc_stat_shutdown(net);
 out_proc_error:
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
@@ -2214,6 +2251,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	crypto_free_sync_skcipher(nn->encfh_tfm);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5ae2a611e57f..8b1330bf8c36 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2186,6 +2186,25 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__array(unsigned char, key, 16)
+		__field(unsigned long, result)
+	),
+	TP_fast_assign(
+		memcpy(__entry->key, key, 16);
+		__entry->result = result;
+	),
+	TP_printk("key=%s result=%ld", __print_hex(__entry->key, 16),
+		__entry->result
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e157e2009ea8..952c98fca3f8 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -35,6 +35,7 @@ enum {
 	NFSD_A_SERVER_GRACETIME,
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
@@ -89,6 +90,7 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_FH_KEY_SET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
-- 
2.50.1


