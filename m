Return-Path: <linux-nfs+bounces-19887-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJVRBrPermm/JQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19887-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:52:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46523AEF5
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7032A3053B8F
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149CF258EDA;
	Mon,  9 Mar 2026 14:50:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020094.outbound.protection.outlook.com [52.101.196.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BB3D5220
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067839; cv=fail; b=F7g6WD//GEM9+FL8svYudb1hPwMzSydT7tljBg4mV44i614rcbDjD1ORIUpsml2t6QXM/G+L9/GDR1pNnZn5OFvUjmeKDL3RzjhrGP0YWEfeEaOhw6O6NbNAgxoxCiFMYiPSW845KJs9bbga+M6tFeQL/6RFsM8eawn01cbAnKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067839; c=relaxed/simple;
	bh=2bjz6rQL7G+9oArnATVY1iWBhFRdioV6hueHO5Ij0UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3Q2mxVw+1XVdDPoLT6JA75B6wOLzr9GlOkEC/WRDkQ75ue6T9IdAcQRKpM+wr5TwE9QeS96I6QkUMTLH9+1H+ZQ8kRVWomm4npw2aY+f76akkXaf8m4CG0naCLfNXHWZeINzk1oBPU8kowf0Bvt3meZh82wFk9llxgYrdYAEvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH/vZem6FkAprft8M6l6XiWnBtcyXmG0yQvxXSz4A5Um2EpmMDo6VQesG8oir8KE/IC1oQjb9NllT3STIPBiAOQ2y2mvvKISQuN3yctf4k6zIElvDM1uYSGgwSvmfmPLqWkkIUhpXMnxdr1V4+gWaaocIy0mExW50NZoJ5IabJpfMnp5dVwCOwEn/Vsjp+tO9FfqG8uw0V1Mfw1Ibh51twlKpxlTe0ARnrTI+I1uCIOe22jWAKAACYqGsfpbREiAVb9SqYM9N1yAZiIKQuL7WXfWy2tOzErkvbd5+WIn+58cqv8RCZctu/e+X6BweRX9+q58N8rW0XZQ3QNJDPKs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WphFRgW6vQpj0o6ZHQspggabXsR4gCYorrLJQTKz/T4=;
 b=yhKM2nFYNpVOWZe9ZjHRAy734rsX0dvp3e3gkw/jGiR3PE8YXzBmzCJGC4B7bnrvmFURjK8wO2nbfHhijIC0cCGkBvovtXwAKoT5SzrmCeB5yC8L7Yq21SNL2HiJVQRVlDixlhWQ+7ufd5vzeARX+Dw0KcgSS3utLFZoSUVh9GxOwVXoMo46O18hDVDhpW5+RWty898Ziqb9FJLR2a7/7n42PakH3VloXQbO9bEff9pJw9oDzPgWpCSDWhbRYt7g1wK7vT98qhWEx5KfWLZUr5IFGbSj9CZtHTOUT+tG8dYe55NM6Anja1w8TiDvIEY4zevn/73dPbbEqRT1lf27ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6620.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:50:36 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 14:50:36 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: steved@redhat.com,
	tbecker@redhat.com
Cc: yi.zhang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsrahead: zero-initialise device_info struct
Date: Mon,  9 Mar 2026 10:50:24 -0400
Message-ID: <20260309145025.107623-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309145025.107623-1-atomlin@atomlin.com>
References: <20260309145025.107623-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 9963c45e-d15c-4a7e-be89-08de7deb391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	JEPdcAqGJtUvRfMPQX0F3aZEEdjUmQMkkcGgMJa7pkX0PpkOUFREF48bVQudZut8JU8yr6PeybTRB1MNCIY/i60CdoWBzjM03vqe+r6caJ98Czs3176bE45Xrq0HvaXer0VPtbb1kgQnZroxxhW7hWOqAkcb33CCXLY2syTZ0MoF0rbARDtnkKi3dyL9pb/ZU6glZCcN7PuitPRDMtTnGp1Bf2FWQ2NW8FU7GYF99+64+rOoHO95lECz/YTA0ZbzhRA3cfT0MOGfh4SjVi5zF507tUrjMNJGAKDoO0QyPI1WPB7lAQB7GweZDFuGUykP4eZyjl3XWkD/KJIDSYKPV/yXp79r96dSfGAW+PBwD6rdz6Dk0MiITEoBne88pznrORg9ta8o2MVgaYXlROSKRtRJuh8pGJCIkzL6Y/hWI78O2HA/Cgx1lIeUSB7gvxmafU0Zz0oB6UaCNNVL6HZztdT0xgBBGPgZjifjh9MnI9hmpZeI/pT2TLSCzkBANs8F88o+GBcRCkPjgXcCLIeUdf+rYeAwbfHYIC4mLcLoE1J0QORjJRL8wccqirb4IQ1ALnDh14zKsaIYAbJXfSfsCD3AhDQGmhW+EkErwXC40r6a2ve4C9wrtSTn05ydt7t2o0fUMKspfmjvd23ioEn6NbEhI0bYkIMwcdmIpI08GdigIoUQlSFGkpyB6EYa0GK5DIREkBDHdXXkC52YHaI30WZQzp9uesUMyHoWcft1Zx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgpCSN6vrl51rhVwmXx77cqL5wcKDX0IpAS/ktbn2MozFQqPL0CMpaqyeW+n?=
 =?us-ascii?Q?xuai1nBhmb66Mzs8cdBHRlrVW4LJEZmnWMKRBU3P5Tu7JSvnR1iNPBVeBmWz?=
 =?us-ascii?Q?TRDLYhP0bSA3X+I0Rq79oq8gI1mgNEkbayDdvAHLNzv0HEAZlurMZoDAwuGU?=
 =?us-ascii?Q?a9VZ4cbnyNSVt+cLfeK5zk0RZMw1O8/H27YXh0bGuYc1JX5Tn9IBLQAK6Afo?=
 =?us-ascii?Q?BhbWl87Q8EjmSC4e1/NR2IDDhr0hkZSF+507H8YCYzWpqZY7SrWs7L7ITwvT?=
 =?us-ascii?Q?ls63sf4kuI3TxBhOMMzRmnjHtyn1h2Bs1hieLENZBoDiZ27dhDoJAeJd5zUb?=
 =?us-ascii?Q?Zi2+6WfYKVsMXVXFJhQ+P8TPyhNgbKZmRojZ2JGhL2luXRUapeziVJYzOb5N?=
 =?us-ascii?Q?XfElo4bpNLOnSjQ0vr4kViwZ5sLy7S6CUPx0YR4rqDM8rv0zLIvhB8FJyJfZ?=
 =?us-ascii?Q?5w0o9/OtHnVQ4z2J/rvhERSGzreUqv11E2KtjjOmz4ou3JZWB+K3so5mK20g?=
 =?us-ascii?Q?ZMe7C34XYByAi5RuqDCKvn9IEycYOundzDaLY0eF0fP91YS6ApgzQVzBIGq3?=
 =?us-ascii?Q?qctgcHVnQZXeeXSHwJNEk1+GuVXoTPzaj7w6EKhnCA2OePEZG4pxzaCeYpsv?=
 =?us-ascii?Q?XTYjv36lcg4wTZis6+AHx/7hbhfHf6AfVubuH3BMr+GYGR+C5ht9GH9VBNR7?=
 =?us-ascii?Q?NYW75YvrynnkUYUdh9dPRViQTR1aoACnoJ8+9RXXf6eYXb+rUJ7wy0WP3ZVE?=
 =?us-ascii?Q?fwWvgLsoHYpXtXuvsN1IUVZ0M4zYNeFuKzlZVkhYoCoEVlveuBw1EIiVqBnv?=
 =?us-ascii?Q?tY/8+2BItLbeQKeiM3J7Bzfove+yvBzwM7VfJ3LenoiQLpy03Kgs9aIeO9rO?=
 =?us-ascii?Q?mLn8d1w8jL2UngytCegxcO86HMCXoRZL0JclwPj+1wdpq3uVvRoexbg764Kn?=
 =?us-ascii?Q?HyzA2NlehSAxjOLXy1aPzompDxLHYApLnb3u33SdBUSD+BqeJP6cSOjDiwy0?=
 =?us-ascii?Q?X2jEDQL0ciC+IqRp7l8Y5Ni2zPlR6sJOYRZGrsAZI6nFCSTqcYybv7vThnqq?=
 =?us-ascii?Q?XTo2cmoLtG+SDzBPoSXRR2/LhVSaCc1ol2KoVe5EMWn4DA24+3Hm4A9xClV0?=
 =?us-ascii?Q?dujTRHxGRt9Eo8/w+FhvxDDaVmMDVfc50vSgrxhxODRYwLRfxpqrKnn//ZL7?=
 =?us-ascii?Q?zG1E42ogQOIz0f8bjtanyT5enxpISoe7HoVzZH52rruNgjJtPDsS7lT/Cx2/?=
 =?us-ascii?Q?Gl/aWIOTv75XkW0OxpvJIELW/e/VeF9xnoW6+unsrxtW74Qw4VYYSBYq3Epp?=
 =?us-ascii?Q?OuJIpvYgVMVCqYiFmiWX56NEEzXiwIxF1DMbVSVC9nLkdPNcGusnLV4RbccF?=
 =?us-ascii?Q?ERw6dG28lTtkPpj7ggPqKRONwcmOi1mWvHECLIWsNeRirQGE5umbkSBismUO?=
 =?us-ascii?Q?boGLzBnIUSwPich/3iZhYVzvVgEnCHe5HWhREe4SuevkiEpOgADEbbKF2Hvg?=
 =?us-ascii?Q?d9PePdO712B1+uu/a6FEImIoHQu10uUeqWDuzTKvD/NZuy5+5oVjvk1cArI4?=
 =?us-ascii?Q?rRReocaxmhrzS2hdzrAxyKg8ubqqtKTaPN8nZKALCBXK575js1j6M7aNgTuY?=
 =?us-ascii?Q?/p0B1u8frXjp3bAwrVYl56D7JBBMaU9u5hN4RhvV4ZfbSLQiTZMniNOdNbd5?=
 =?us-ascii?Q?UqsrgqRSSwBoh3zSLqbJ9ZCuhLP0PhzgChF/fHZd0F3V32e7yY36vvBDK3+0?=
 =?us-ascii?Q?rtfY/OLyng=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9963c45e-d15c-4a7e-be89-08de7deb391a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:50:36.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgoY4I5dTz4VqvCxLuGvtpLDrSaBTQp7vZe6ZSpLgHDwogITUI5oLWTk892ZhL4WeTmhJXFcqqTIH9JHelJ+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6620
X-Rspamd-Queue-Id: 9A46523AEF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19887-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[atomlin.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.532];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

A recent commit introduced a fast-path rejection mechanism to prevent
udev worker thread exhaustion. However, this optimisation exposed a bug
in the initialisation of the device_info struct in main().

When the fast-path is triggered (e.g., for a physical block device like
8:16), get_device_info() instantly returns -ENODEV. Because this early
exit occurs before get_mountinfo() is invoked, init_device_info() is
never called.

Consequently, the device_info struct remains populated with
uninitialised stack memory. When main() catches the error and jumps to
the cleanup path, free_device_info() attempts to call free() on garbage
pointers, resulting in a glibc abort(3).

Fix this by explicitly zero-initialising the device_info struct at
declaration, preventing the cleanup path from freeing uninitialised
memory during an early exit.

Fixes: 0f5fe65d ("nfsrahead: fix udev worker exhaustion by skipping non-NFS devices")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/nfsrahead/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 78cd2581..33487f37 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -191,7 +191,7 @@ static int conf_get_readahead(const char *kind) {
 int main(int argc, char **argv)
 {
 	int ret = 0, opt;
-	struct device_info device;
+	struct device_info device = { 0 };
 	unsigned int readahead = 128, log_level, log_stderr = 0;
 
 
-- 
2.51.0


