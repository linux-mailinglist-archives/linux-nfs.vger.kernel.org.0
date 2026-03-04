Return-Path: <linux-nfs+bounces-19774-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBNnO8tZqGlxtgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19774-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 17:11:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E8C203E67
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 17:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C953B3211FAA
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC5359A97;
	Wed,  4 Mar 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="H/RnGUpv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022101.outbound.protection.outlook.com [52.101.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472235AC01
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638858; cv=fail; b=nCHxEt/FqlKps6UvjMm/7hYj5Q3uHmNYJveM7+MxeblzJPR2/tOKqZz1YIW94FffbuG/4HwPaCl+e9DA0Hz6ykbKTijfb3l1OhI3dtTcrh0eSLRdROS1JuHYHVU2QF0xJXJpCUK7yWns1H2qJkJCZHodouN4T1T6a7gpY8SfVKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638858; c=relaxed/simple;
	bh=9FDpQmLNNhrvOx39E8ffjVZZZxhUtOOF5fd6aCo4Wx4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dRLpXzAA8jgAT54/m8SerLdLH5umpSaL8RZy+ZrmnF8hYezvR9M9DqX+Ck540N3MSnEB1xm8A68WpEwqBqSMV45KnjFwwH7Bv0+ljrtDhe++/V/qehTo6NLOuOgvfLq/ZvDG6VdZclDjJImsgIUh+iOanybjNJC9gfMKyr+CctE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=H/RnGUpv; arc=fail smtp.client-ip=52.101.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVk5sELnHVsf5OcJ6aqqrNshrNr42bH7yam0umNZStZA3dFQlXKsW7aKIlvQQpgXe4lOFkHXKSKgEjYrscy2wprxTv+CYkk6A9HnddDvY6PvTA7Tz1fOESIrZD4+SLMgqxJUn0xYBNfqAoq3ycNxd6V5DcL8bx5yYjf+yVDmgSGfh92KT4KV+yeEz2uTN6QCd+8cqt/zatVxijOA1ElUZKg/2LeRAfxQdfOUi/EEhKfGCZ5leqnp2zZ9cAOvnRcjlkmLvyCqOIz/jj7wt0ojAqSETll5hppfKSLq19T8fl6dt+WzswM+OgMangcT3CX3BPUrLGK6Lw0MoLsvZvRsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbzZtc+sDZJLCzPKUO03BXdJ8VWZaD6f9dHhkfx8UKc=;
 b=FHbZTC1GhJLWEe7HSLWxsSJ1sxSo7uh7lYeEfKtjW+gQ7HsagzsI9XKPJySJ6MpdqHaSQxHY1Y5REVnZsnw6fEe7Db+gQ6X4ANlkeY46yJQ8Q3A/CgMyjh8myal59IzM0umamM4ez343ctLYV8Sb7e1BZcr13r7bgtbp3qwyqTJavjsioL6WSPKh5mZh8mS/WKuwHJ8/21Y2OLM9VBZbSeZa4Dyu8I23HYbH9MCQ6Xa3lufpcTvUKd2u6uF716vR0m1CSqtrdOtEdMFlHBUu7qynyh4u5ctVWKl1N4NfAGDlygXnEC3GlU6rbe+JklgHH7COvNLmzWvhQ7wC5mPcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbzZtc+sDZJLCzPKUO03BXdJ8VWZaD6f9dHhkfx8UKc=;
 b=H/RnGUpvIixf1yYZeEuH18H5iz1Gh7rsq6FgFy6x/LOiUReI5xI2feO71mQ+kAnn5VqoDMfcaoJKhsZ0FplCfoZov/pBxu5D39WuISiAp/eLsB/8jLR8qNk7BhT5UCy8ub0UlwZSHv+F6vjmGQ/LtuFJg+EmDxCMQPlRH3BFztQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DS2PR13MB7603.namprd13.prod.outlook.com (2603:10b6:8:32f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.17; Wed, 4 Mar 2026 15:40:50 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:40:50 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>,
	Benjamin Coddington <bcodding@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 0/2] nfs-utils: signed filehandle support
Date: Wed,  4 Mar 2026 10:40:44 -0500
Message-ID: <cover.1772638460.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DS2PR13MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5b34db-a459-4d09-bbc8-08de7a046996
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	GVp0uojQvOQW9+PpyStp1RVTOA8uZToBtC4b6PDpljme2n2522jYlSt1P7uCiI3b1cuhZz4KUS+KOVB2FQ6R6TRXwtou7/imEPRC/a/O0enWxvy9cVxx3TPAa8Gnw2P7caezFXhG3Bzt/GWF4Jnt1tsqj1D2eoq3KR95SXXQhcJICv+ysBfPeapeIXANsFN9engomG6bolmrZEXrMtRIY2Nuic4YXivErvGjK2JOVnmQ8itJ8ihXBxWpZb4AXPi6P0zPvC35jd7WlfrVyEU3f1EK//cnnCntLK2steYcbpo9fK/YcNMtWKvjRGPlbRYnj70s9R/7xlmb1AATNQpvOc7u0mT4EbJcPkUF3zLy8GGh1slaRq5l8kutmuUaCjOaBQZN5p2zIs4nkdGHPs8Ue9nwkmWkglZk5c+jnfFIPhgUE/6CZyOAuNth7Q70XAIyBL+f//7IlErEpFLw7cWr7x/Hg2SjVXSbeTHGUi5MUhzw5mnOk7PxVc6JdmMFKVPc8S86B/7GaIsy0+DWtHGhE/Ro6b9unAucMPs7ClDBLAK1AUEWKhEsU1X0hZfN1UwZV6FYKGE6aWOETwnzdDOgJ6AxJkFjwDIFpu0RhfGEj0xXW977XEKazj1EzSNFDLPMDixi5HHM+qctXTdxkrO73hFOP4f04KeyHc2kv/0KlwgrjYWxYP6hAT6T5tackErjgvjfE0oRGae4laYusFBeGMRq5v3AboUjswL0hWDxET8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?biqVzjBCUe+SZ94fjSOoqPFvGaYyicyP2e1VoXaP/pRgHtQXKGuECuNAUvfT?=
 =?us-ascii?Q?axAzfg4s4VxABBaW6UsgCa6zsCUqkOAHuKFUU6jPLAgA15npWWx0m57Q9Ukp?=
 =?us-ascii?Q?Ew99rx4u3k4VN7kjfTPZk03xYs3sWm5NESGeMTlCdTd9QeQ5YECln+rhxiL6?=
 =?us-ascii?Q?W+u5JkPnO/q5AvAXNmBzzSSRUQzo/oZDz2pSX08+zXTXCgv1x5G6LhXKt3+D?=
 =?us-ascii?Q?N2YRPRYFMmtWTn29J/iSUmtLmscWd8+bmerDd2TkNWE3J6wqkplDBGyeOtR3?=
 =?us-ascii?Q?8C/8ADs4dihlJV6w5jT+PpdVjoQjgxkqx3dIwurlMovkSRnHI55cST8ZBWJH?=
 =?us-ascii?Q?6an4HM0GmlULi8r2QUPCbuwsXPCKDEwzDfGEcppe+PWry6mQM7LvRYGVi/vg?=
 =?us-ascii?Q?hZCurM3X7+98HePItbI+dnGFWViZam2q5+xXp0IDloDlz5s91Tqg46C6RcGc?=
 =?us-ascii?Q?UwbfjDilHa55sw0x7HtlTmlq+rsEEmKUeWpNia99YBAFHdxIKRfhOSEl6HR4?=
 =?us-ascii?Q?hqiRVAhxflAGtZ4OLL9N3wxLaa48fS5ajwWI35nYuNd2S3Qhb/VNA3sSE4+T?=
 =?us-ascii?Q?9Y2mqYPCqTXS61Jriajwfj7nbszMFSiqfu6xZ7c5hwouLD0sHKqO52fPGGX1?=
 =?us-ascii?Q?dZ0FFNLRCBYq5g8x4Dqf0uiJoUHtymnvpQulhUU9j4epsiUdM4160xddh3Zk?=
 =?us-ascii?Q?bSEFicOUejPkchlsw0vqWeDbgKLxN7vgN55E/unBwJdEgr61/tu/ZuAkmkkv?=
 =?us-ascii?Q?WcrioRChHy7M55dQ0SoIJfcGoujt2sPzJAUktCiQrz9OmXkK48CxQjQTNfG4?=
 =?us-ascii?Q?bqQiDdgKmfYXvGqE0tAC8n6xR9CHFCCOAQ4u+7Dh+LrlxRhBCa9rLBIpAi73?=
 =?us-ascii?Q?EarCCLsJ9r+rvOW0oa4vaaNJ03162wOxfScBHuj6PmOavzcBX3ogbAOm64ln?=
 =?us-ascii?Q?fqKsOxy1ZzgJ7a5Nl70kFXLftV7FAmqk8//CmWyDqcLkbGNoM8pubta2oP3S?=
 =?us-ascii?Q?6gc+hsHBUOByBRPjRaQiJSV4Kdl/L69Zq+6qHO7VnulaUidfuz7bNvDLA+uN?=
 =?us-ascii?Q?bnZJBMiTWxQWiaP/YcULmAeX0YOV5KhWgYhUE+yrE/gvZI6cclJOPSPSet6y?=
 =?us-ascii?Q?udKnHRuI13PXzeWKfIzv8igkrfFH+D4B+ZLM0aZptm+qeH3wB8ivYSoa06Uf?=
 =?us-ascii?Q?T4Jk47cKNBkOSLrkZ2gEp6cR4OJVnNEERYJSeEwzfKNJCAMm/P/VgA6XcGnr?=
 =?us-ascii?Q?Md4lE/Zo2h9Uee1GjGlG+rBSrJN6uD8rHKrmGjfPKOCfeQG9jNVhlfyc3Lbr?=
 =?us-ascii?Q?mVuJoC2mvRa+NuFUNTziB839pxGAEXXvymsJwNP4r+drAXEQSiQ6CByY5Wu3?=
 =?us-ascii?Q?+fUqcxiqInATigAuX+COA76XdYDA32Rscp/3VcX942AgU//bhPmoLsCEBhX3?=
 =?us-ascii?Q?OytWvsU7xx12gdAsahOXtDTNGskcva9yfABX5wfV3leZPAArPoULvjWwxyT3?=
 =?us-ascii?Q?nMB+3/RcuXF9uvNHemZX/7Jfa/eFZE2Vtr138NMYEHeGuW8Sv6VG8IKrftNx?=
 =?us-ascii?Q?YogDZK7fN/zwLKxQ+eMkFKuBMpPaa+bd67a0Jyy9uemZUkI629CSNtOs3rfh?=
 =?us-ascii?Q?I5BOj2hUr1iRH3eGUkUr15+yeuC/yuMf00Vae0Na6jyW1IROMeU3GFaEvmsy?=
 =?us-ascii?Q?pirkKQxn1i8hN8tswE2Uessss8vrIcMB3ozJt0Y6iD1Hc3F5rhpXrDF+6h4d?=
 =?us-ascii?Q?rEUP2gZnQgGqO4RH83y3gSWJ+y3VUNw=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5b34db-a459-4d09-bbc8-08de7a046996
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:40:50.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpqMNi73q8X4XR11Z6E3hYQz97lk46WLp6hqfQVmc5T9r+ExM7Gq32R2qwW7GJedK0C9HJYVMSslobi/WxyEu/LcLFeNGQydXhOX+XRFHAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR13MB7603
X-Rspamd-Queue-Id: 30E8C203E67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19774-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Action: no action

Here are two patches allowing userspace to set a secret key for kNFSD to
sign filehandles, and also set the option to sign filehandles for an
export.

The secret key passed to the server is the first 128 bits of a sha1 hash of
the contents of a file configured via the nfs.conf server section
"fh_key_file".  Exports that have the option "sign_fh" set will cause the
server to use this key to append an 8-byte siphash of the filehandle onto
each filehandle.

This version of the userspace patches correspond with the v7 of the kernel
changes which have been posted here:
https://lore.kernel.org/linux-nfs/cover.1772022373.git.bcodding@hammerspace.com
and are currently queued up for potentical inclusion to linux kernel v7.1.

Changes on v5:
	- add -k,--fh-key_file= argument to "nfsdctl threads" command (Jeff Layton)
	- fail if "nfsdctl threads -k" unsuported by kernel (Jeff Layton)

Changes on v6:
	- fix a premature exit from fh-key-file hashing routine

Changes on v7:
	- fix another corner-case for hasing fh-key-file, simplify.

Benjamin Coddington (2):
  exportfs: Add support for export option sign_fh
  nfsdctl/rpc.nfsd: Add support for passing encrypted filehandle key

 nfs.conf                     |  1 +
 support/include/nfs/export.h |  2 +-
 support/include/nfslib.h     |  2 ++
 support/nfs/Makefile.am      |  4 +--
 support/nfs/exports.c        |  4 +++
 support/nfs/fh_key_file.c    | 63 ++++++++++++++++++++++++++++++++++++
 systemd/nfs.conf.man         |  1 +
 utils/exportfs/exportfs.c    |  2 ++
 utils/exportfs/exports.man   |  9 ++++++
 utils/nfsd/nfssvc.h          |  1 +
 utils/nfsdctl/nfsd_netlink.h |  1 +
 utils/nfsdctl/nfsdctl.8      |  8 ++++-
 utils/nfsdctl/nfsdctl.c      | 57 ++++++++++++++++++++++++++++----
 13 files changed, 145 insertions(+), 10 deletions(-)
 create mode 100644 support/nfs/fh_key_file.c


base-commit: 4706bac0345f67c50b73fd8da1c2629ed15ff79d
-- 
2.53.0


