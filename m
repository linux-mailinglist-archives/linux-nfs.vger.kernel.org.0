Return-Path: <linux-nfs+bounces-17320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB878CDFFDC
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 18:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48B45300A332
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5A8834;
	Sat, 27 Dec 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="AVVFaVqA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021113.outbound.protection.outlook.com [52.101.52.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC922A4E8
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855043; cv=fail; b=mpz28C7PLhgqt8PiQMA7WlziEjf1q8j9/yAs486QqO5AuKLqpq3Ga4OW+ll3roqFExNty1VGebGeiknHywKN5U1EfiI1FOycsOcrbeuMxaZXLr61s31tRE96lgRPqHWHHcZU/kul8pkRQEpuXGLIumCtOUUxRqk4ZMn0oiK1hcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855043; c=relaxed/simple;
	bh=1RihQweFH5rYzor+j3M85p0h/Ztof0RGiy5b1p20+KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s9Xbo9jwNELrI9JHRvr7/Jlayb/epOAxXYKWDPkUvrjUWoolXGXdQiaDzKddXCIPrJmh4OVIpP0ns2fSqAvGDEpWjBenlBd71hqEU/Lb7HatnyTndf0t12ic5HR1joHuhUKhxYtJpCcQwKYfTcUUZNUKG8G0mT9Q35483WNqTlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=AVVFaVqA; arc=fail smtp.client-ip=52.101.52.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOGypWAGVOVBVe7Sg5zF4MP19BSoAWjsPYeMnTT6YVrt61yQRdwBbH+afYsyKJ0hXWom3O1TFtBCyqBXJvhErQje93sKGA/I+seUVXjuHra86eWtnQpK2KAcweYMOPaOJpgpTGilKCCnUApn6QVeKnjYazWd3HYdhM3YnVtFmXIiUXEiyrmqGZ+UbPEu1wmRYEVeSBGwqk7mqaJNI1lkW8V1I9J8yodGHINNhfqH2mpJau1Z21P2L+xqoz4WdHBvHJIsH9Wqf8hIL9NxCpeRnAQ0s0qCF0A0vhG4ABLkm6FeJlWG03Z3QYRN1sUtbHVKwJD8iqp6c9C96v8AOZDeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7n0dGiWMGy1Brslqts7NxH+D/ZA1zpJ9PE1l9KzCT0=;
 b=YGfgDAX4kiTyr2Qd3N9BUv7kLRfcVFl3GFayTo+NdVquR82T0FOArWLDckoCR3TAMMdYA4Oi3dH6vvbNzzR/a+CRO2kSWmmRaVU5gbHIqL1s9crz9W2dJwGygEbjY+HR0WPl8mdDAS8BTxkN/moaedCnykTeyGOCzajAfLRPPu4o2RjMvckxo47frQsEpTO8RxTLM5yI7uJq/uHQ3mNSD1H4GxXGL3fVXfCNA9SI85Nb7NyMPBrZZk7up68mlCPzYfUTRs98veikwh3iMuCr6Jzd2l+0bbrzAKkjDmF/9xIlh1uDb3tASadXfhhs/KlCP3Alf6GRwui85pRsIqak2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7n0dGiWMGy1Brslqts7NxH+D/ZA1zpJ9PE1l9KzCT0=;
 b=AVVFaVqAtr6ZNXa+vhfciQnDvzN4QqYOjc+ZGha/UHeD74gvrEWYH7mIICrpPSmvQtI76qoAlPwSQqgsB1ifQld0FOHPpFi742/PT509N6byvITVBIEnDEBo8PtEtYQF90PAPA8gD82yWVE29OPscTnx+HUDRe5Q3/zI91jnN3E=
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
Subject: [PATCH v1 1/2] nfsdctl: Add support for passing encrypted filehandle key
Date: Sat, 27 Dec 2025 12:03:51 -0500
Message-ID: <7b3064a462215b8c1f99aeda8c32acdfa5d4f85d.1766853122.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2860cfc-7fce-4e03-cf77-08de4569eb85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JCFlws2DNjL26B/MgBioYcBaQ64RpkDEamysH0x05j9Bsda1PkM9fJqUpiZX?=
 =?us-ascii?Q?j7IvRaTRc36T497mXEyC6ha5PW7zu3mOz9DMur/sZ6zxkRvXzySEXszGAENP?=
 =?us-ascii?Q?slqbji27fOClRE20lVAwh3hAuwT7+UXUTAbzdDVxrjNQzcI3muxNH2W3bK5d?=
 =?us-ascii?Q?81hXVZAS1RpHFjBdvmSsqq9f7QDtrRSDJia/k1dc/djgGLYoiuRDGp0CZRXK?=
 =?us-ascii?Q?DewcDDP+4CCW7i5nVwvIyAU/Shin/L4zm6r5Tn2GS5DamqJYS/7XdZoura5Y?=
 =?us-ascii?Q?WftOTDTdMyCGRVVzetj/knR8UBpIq0YL/QGOBT3odZAUVwlSzrm/b4YqGlxf?=
 =?us-ascii?Q?gtqUtrn6VF/bsdwrXlQCrdekGfnDSgNZrrJ0mAAGuMoc2RStMwXU9DPKOUvN?=
 =?us-ascii?Q?kkyl6/dZtY6KuD15eGplS3glsxC2u5guzGkFyB5p3z9eDbU0vDXhhFBuUg0j?=
 =?us-ascii?Q?tc7IZYG55GkSHA837yG4aK6ZY68WpaScLY2y2hRxyenuwhDUDLdJ87erDWq9?=
 =?us-ascii?Q?/QNDUaJryNYKOrsyExYAZgPvXoL5We7lo8JPPzVxNoR+xbx4ErwmQUIFP/iU?=
 =?us-ascii?Q?5ENYztIzbqV209lh7Yu8O2NASgWtm/WrhyCPFGx/qBI0tjArTg0SZhp3P3s1?=
 =?us-ascii?Q?7sweO8eCORwePGhcSqNUHMki6Jnjw19TT84XUyu9zF35XnsLKu+eQqoZHf5+?=
 =?us-ascii?Q?VUMsI+adMNA5Hyr7Lq3/dhhF/HmfIUKj05REYxjD3AC0S2PCQDF/l7BNMJmH?=
 =?us-ascii?Q?DMumn9QY+oBuRGzd2kRVdGB63Qvg9jtmczViIXriE7rOFwQgLUHC+l+sSNcZ?=
 =?us-ascii?Q?qMZTcKWBmzh4W/gjVY4al6eVRjQ9+X0x+s/iFlDcaSKScihMsLulbQzrzLdZ?=
 =?us-ascii?Q?D1Tas3jzHBFI9rizxn1JFF0AdQ3aaLLC2N6bRqa222QL+Vdf7F4zHr0cLXk5?=
 =?us-ascii?Q?GeZYiVEQIsbC4klcx6HL7X14pmM60cvJd8HjlonFC5JUvydX97Sr9OFvg3Ve?=
 =?us-ascii?Q?M4SglK0ps41E5Yg4CBT7iQsavOgFTBm1crKS/1EOLMrAnDO+wMP47x9Zkefb?=
 =?us-ascii?Q?j1Fpr5iUHPNpuu9S5mP/b8boctRPwzmxgkMWY9l0VxqM7Gi+w7uzG8PCiQ1C?=
 =?us-ascii?Q?6dPi59e0WA1R2vf6qIllkljmPhuPfqM9+s7KtM5zgcgk1A067a7uE6Z8ZvKW?=
 =?us-ascii?Q?lW3069nknYv86WeNLDKPEjI8fM1bsuWicj1yhNUBTj2j2RaZc8x1i6pqLhfS?=
 =?us-ascii?Q?Ckzir+zumtZCtlf+bdkpCWTAhk+FrxnZIns2B5sApbrxsET3NrdAtxiDRcPT?=
 =?us-ascii?Q?cclDLyiKxFBjU1eVTuFPeoQDTwaSpPTGwVD3OizPX5SdnG11TP4nCgr3jFWP?=
 =?us-ascii?Q?RVw2GROQvXuE5+geKUzMvg0uu6Du0ly8qyot7Owko3x3TOAoO9Zwg8c5p7Sn?=
 =?us-ascii?Q?HJcxEG5zyE6DlXgu/EbU80tGX68YXP9T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWe/eORAN4E1nAm0W4uH9Noob113cyjCR5SmR65rJqHME+HCbwDfnpoJZu8e?=
 =?us-ascii?Q?zU6ZcgxfVdY3LWYmwIMk7+usiRxvDzr0w7f25UNoyxNdFq80khJVThuzq15/?=
 =?us-ascii?Q?cHplf0yTY5y54UHwmLSPAPu5/WWUcdWYBSHJWxkgx81DtUiUmCka2D8J/nnH?=
 =?us-ascii?Q?XC34lOJxGSLMRxxVpriOwgcNalFXZCeKAZqU/+jKlIBthwtoFKjkHQO12P86?=
 =?us-ascii?Q?OBlazmv/u/YO2Z/pQNjMP2ovk7k5iTot43gYhqdbEjBSPyPlXw1DpVZojwKg?=
 =?us-ascii?Q?fXPdu7/wFhYcRBQpyddHU4UdAlZG9+JZkfRuS15viSH18rWpTHZ4FuOh3fJd?=
 =?us-ascii?Q?hZgEQ9kpOc+/cTlhyQJtXyxgtkBNvUMfXxRUcdzFmI2qQL6Ocj4ZdQxvWMEH?=
 =?us-ascii?Q?m0xjQb2DlzfceRmkZ73ABrU31K+y/eohYfeiN9wZ2XfGnGFhr4DJGLKbK+QQ?=
 =?us-ascii?Q?cxpV6u5C4+0jKoodw42ntEatJBxGlpUE9hHqW8AYJZOM5ryrJW2bWVV/fNEU?=
 =?us-ascii?Q?qaadbuDRX2t1qZuoeplBeEqAGRBu4cYJ+d60URiPgYWqvqljBB6aTacekIKx?=
 =?us-ascii?Q?+j7DyO4Dup6acdsKPoSQB7uiDva9gITslj7KwuhxvjcD7fqRJTzoLcLJzvXs?=
 =?us-ascii?Q?DcbGjP2ybtjHG3AYj5khOcZXbhqnpM6d/4xOfpm/hK6PO5MAmSGsyR07QStK?=
 =?us-ascii?Q?3iBZf5IkOpZHdLRkjd4eFz0KNsDsOm0fTAiGSCRDU9uXAm5XCkWZ5B6bVlUu?=
 =?us-ascii?Q?uVvzfxA1iYH8L7YqiOpuI9RjTVUQbNykhzmPS3HCLv6odeSw0zZt5KHUjR2R?=
 =?us-ascii?Q?TbgJFRZ8s6GfYXAgsXk75JMf/OYxVkKEeHzMJuN4rlwP5xuxlRGtpKNLqaQh?=
 =?us-ascii?Q?+MofV2ODEjGTskVnLvce94gng0LoyVht2+3LDVtl2U3tOQLLHj1z2uQK9hkz?=
 =?us-ascii?Q?ZUTuWB24g+5M2ZMowPT2B1nkFMJG8zomRnon0L7HrTBUMIxPQWCV35rrbuWI?=
 =?us-ascii?Q?962jKnQXa1REGO3V5S0roXQTCOTCA2uMtG88mb6mX+TmuYS+gxAd8h3r0Xh1?=
 =?us-ascii?Q?9YR3sepXqwKhetuV+o+x+G1XbkWpWtukif6XPWEpTGejvFoSpQl2j4GS40xO?=
 =?us-ascii?Q?59tSBf2soZN/b+4o5xs5r/7RCQzG15go2xG8zt5yrwkMpPqSKhaSh/sip96S?=
 =?us-ascii?Q?oc8/qpLm2k3IxRnvr9iCpYVpgV+J8F6j9RzmQKNSpKMjj99hZRL/9JZ0TjaV?=
 =?us-ascii?Q?Es1JMOn8qXxmrmx7I5epY8UmbJryggNTNq20cKxEOgJUMwscMwD0cobaKLP8?=
 =?us-ascii?Q?VyPTrLGsGlbLxu0DKDDZFVfpXQmozYlOJAjgJo+j1Tg3I8ZQJ8snl7r3ZHAz?=
 =?us-ascii?Q?rsJ4tmcOt9HXniO+sMu98DhJg5n05BtqeSsQ/enNTr3cHYwKJuwJJxGgNeR/?=
 =?us-ascii?Q?o/uPEhWgeKXc2JArwIZ2PT9NkEezGreBQrMo4byA0NmynfRdse0yyGH8utmn?=
 =?us-ascii?Q?0KBchqeVn3dihnuSRJiHtMqvMu+DajcT+lkxghLf3TgDKI5ELY5ohG5cZ1HM?=
 =?us-ascii?Q?O8mPM9xfEe3Pn07aTDnBBgGhnPT+kIBXQKVYJa/KJaV7P3FIvIvzXiF2qw+V?=
 =?us-ascii?Q?jyn4NSnaZhI/a+RlGKf/amjRKBjEmTGMmh+JNUF//Hk8UesOCvROtqT6zw5I?=
 =?us-ascii?Q?98hWB34nX5GWzOsI/1cfetRl5zSM6GpQBm/tcZr/N2Qo9y+C6B971zgvkafj?=
 =?us-ascii?Q?aP/WfLFlARdNjonTLJccraH2YFFLaaM=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2860cfc-7fce-4e03-cf77-08de4569eb85
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2025 17:03:55.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzzT3/W9X0dhLbJvfuNEze/ZiJ+r0B17SrnbueN2d4u80WL51Ro15MJWUF1LEpKfyg4W4wZ22DxapD5lpZ8dTLogUs07t82EN/nE5Z6SLS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4061

If fh-key-file=<path> is set in nfs.conf, the "nfsdctl autostart" command
will hash the contents of the file with libuuid's uuid_generate_sha1 and
send the first 16 bytes into the kernel via NFSD_CMD_FH_KEY_SET.

A compatible kernel can use this key to encrypt filehandles.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 configure.ac                 |   4 +-
 nfs.conf                     |   1 +
 systemd/nfs.conf.man         |   1 +
 utils/nfsdctl/Makefile.am    |   2 +-
 utils/nfsdctl/nfsd_netlink.h |   2 +
 utils/nfsdctl/nfsdctl.c      | 132 ++++++++++++++++++++++++++++++++++-
 utils/nfsdctl/nfsdctl.h      |  10 ++-
 7 files changed, 145 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6da23915836d..91122d09c4ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -263,9 +263,9 @@ AC_ARG_ENABLE(nfsdctl,
 		PKG_CHECK_MODULES(LIBREADLINE, readline)
 		AC_CHECK_HEADERS(linux/nfsd_netlink.h)
 
-		# ensure we have the pool-mode commands
+		# ensure we have the fh-key commands
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
-				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
+				                   [[int foo = NFSD_CMD_FH_KEY_SET;]])],
 				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
 					      ["Use system's linux/nfsd_netlink.h"])])
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
diff --git a/nfs.conf b/nfs.conf
index 3cca68c3530d..39068c19d7df 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -76,6 +76,7 @@
 # vers4.2=y
 rdma=y
 rdma-port=20049
+# fh-key-file=/etc/nfs_fh.key
 
 [statd]
 # debug=0
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index e6a84a9725da..cc4894d2b00e 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -175,6 +175,7 @@ Recognized values:
 .BR vers4.1 ,
 .BR vers4.2 ,
 .BR rdma ,
+.BR fh-key-file ,
 
 Version and protocol values are Boolean values as described above,
 and are also used by
diff --git a/utils/nfsdctl/Makefile.am b/utils/nfsdctl/Makefile.am
index 89c7ecd6f30b..25af60b438cc 100644
--- a/utils/nfsdctl/Makefile.am
+++ b/utils/nfsdctl/Makefile.am
@@ -8,6 +8,6 @@ sbin_PROGRAMS	= nfsdctl
 noinst_HEADERS = nfsdctl.h
 nfsdctl_SOURCES = nfsdctl.c
 nfsdctl_CFLAGS = $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS) $(LIBREADLINE_CFLAGS)
-nfsdctl_LDADD = ../../support/nfs/libnfs.la $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS) $(LIBREADLINE_LIBS)
+nfsdctl_LDADD = ../../support/nfs/libnfs.la $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS) $(LIBREADLINE_LIBS) -luuid
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
index 887cbd12b695..f7e7f5576774 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -34,6 +34,7 @@ enum {
 	NFSD_A_SERVER_GRACETIME,
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
@@ -88,6 +89,7 @@ enum {
 	NFSD_CMD_LISTENER_GET,
 	NFSD_CMD_POOL_MODE_SET,
 	NFSD_CMD_POOL_MODE_GET,
+	NFSD_CMD_FH_KEY_SET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 7d2d4fd93211..0039a07bb003 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -28,6 +28,7 @@
 
 #include <readline/readline.h>
 #include <readline/history.h>
+#include <uuid/uuid.h>
 
 #ifdef USE_SYSTEM_NFSD_NETLINK_H
 #include <linux/nfsd_netlink.h>
@@ -1567,6 +1568,128 @@ static int configure_listeners(void)
 	return ret;
 }
 
+#define HASH_BLOCKSIZE  256
+static int hash_fh_key_file(const char *fh_key_file, uuid_t uuid)
+{
+	const char seed_s[] = "8fc57f1b-1a6f-482f-af92-d2e007c1ae58";
+	FILE *sfile;
+	char *buf = malloc(HASH_BLOCKSIZE);
+	size_t pos;
+	int ret;
+
+	if (!buf)
+		goto out;
+
+	sfile = fopen(fh_key_file, "r");
+	if (!sfile) {
+		ret = errno;
+		xlog(L_ERROR, "Unable to read fh-key-file %s: %s", fh_key_file, strerror(errno));
+		goto out;
+	}
+
+	uuid_parse(seed_s, uuid);
+	while (1) {
+		size_t sread;
+		pos = 0;
+
+		while (1) {
+			if (feof(sfile))
+				goto finish_block;
+
+			sread = fread(buf + pos, 1, HASH_BLOCKSIZE - pos, sfile);
+			pos += sread;
+
+			if (pos == HASH_BLOCKSIZE)
+				break;
+
+			if (sread == 0) {
+				if (ferror(sfile))
+					goto out;
+				goto finish_block;
+			}
+		}
+		uuid_generate_sha1(uuid, uuid, buf, HASH_BLOCKSIZE);
+	}
+finish_block:
+	if (pos)
+		uuid_generate_sha1(uuid, uuid, buf, pos);
+out:
+	if (sfile)
+		fclose(sfile);
+	free(buf);
+	return ret;
+}
+
+static int fh_key_file_doit(struct nl_sock *sock, const char *fh_key_file)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_data *data;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+	uuid_t hash;
+
+	ret = hash_fh_key_file(fh_key_file, hash);
+	if (ret)
+		return ret;
+
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!msg) {
+		xlog(L_ERROR, "failed to allocate netlink msg");
+		return 1;
+	}
+
+	data = nl_data_alloc(hash, sizeof(hash));
+	if (!data) {
+		xlog(L_ERROR, "failed to allocate netlink data");
+		ret = 1;
+		goto out;
+	}
+
+	nla_put_data(msg, NFSD_A_SERVER_FH_KEY, data);
+	nlh = nlmsg_hdr(msg);
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = NFSD_CMD_FH_KEY_SET;
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
+		ret = 1;
+		goto out_data;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		xlog(L_ERROR, "send failed (%d)!", ret);
+		goto out_cb;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		if (ret == -EOPNOTSUPP)
+			xlog(L_ERROR, "Kernel does not support encrypted filehandles: %s",
+						strerror(-ret));
+		else
+			xlog(L_ERROR, "Error setting encrypted filehandle key: %s",
+						strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out_data:
+	nl_data_free(data);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
 static void autostart_usage(void)
 {
 	printf("Usage: %s autostart\n", taskname);
@@ -1581,7 +1704,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt, pools;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	char *scope, *pool_mode, *fh_key_file;
 	bool failed_listeners = false;
 
 	optind = 1;
@@ -1653,6 +1776,13 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
+	fh_key_file = conf_get_str("nfsd", "fh-key-file");
+	if (fh_key_file) {
+		ret = fh_key_file_doit(sock, fh_key_file);
+		if (ret)
+			return ret;
+	}
+
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
 
diff --git a/utils/nfsdctl/nfsdctl.h b/utils/nfsdctl/nfsdctl.h
index f0aa3ab862c2..12491b833f56 100644
--- a/utils/nfsdctl/nfsdctl.h
+++ b/utils/nfsdctl/nfsdctl.h
@@ -1,11 +1,15 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-/* Do not edit directly, auto-generated from: */
-/*	Documentation/netlink/specs/nfsd.yaml */
-/* YNL-GEN uapi header */
+/*
+ * Copyright (c) 2023 Lorenzo Bianconi <lorenzo@kernel.org>
+ * Copyright (c) 2025 Benjamin Coddington <bcodding@hammerspace.com>
+ */
 
 #ifndef _UTILS_NFSDCTL_NFSDCTL_H
 #define _UTILS_NFSDCTL_NFSDCTL_H
 
+#include <stdint.h>
+#include <stddef.h> /* For size_t */
+
 enum nfs_opnum4 {
 	OP_ACCESS = 3,
 	OP_CLOSE = 4,
-- 
2.50.1


