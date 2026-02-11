Return-Path: <linux-nfs+bounces-18895-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id P96eGA/SjGmEtgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18895-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 20:01:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E53126FCC
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068E630125C5
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 19:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E603EBF35;
	Wed, 11 Feb 2026 19:01:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020076.outbound.protection.outlook.com [52.101.195.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070621FF1AE
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836492; cv=fail; b=asb1Z5jJZO6OGJe/OZLN09q/dl9CmWMMOApG0z3bG/qUKAAjY0P1rIM18U3UYUt1UyD8y6qcL7Cn0yiSMtEeZVH8IHdz68JakWeiaRiuFcMYqMcAWKq6CPdLkq5QYlY6UGz+S1AB6kc98VIE+2lrMKhWCRVDOLl/cWhePlDtn+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836492; c=relaxed/simple;
	bh=mLppDytjvb9hIge6I2XvdXccRyAwM9WfoKhuSI3LbP8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yj/DFmNLA7Sj7DhJQCLAxpokjxxjSRxz7lGZnh1McX/io4i+j7ySBcejr4Cet6EtJ04g2LwYUBUp+LsGV/ixTG24w0+KRYTL0nhehgsQEMbZiiuGbneLJpBhcUE1/WSo/C5nL/3zL2gEQ4uxuiGoWSvW3mhFtUAem59iJH0SQis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuOWJC/W7N8cNg0GXYhRj90QkGaUCThnGKxP7q4KYcv03cjw+SHo/4mLQIldfi2aePPgKlakhCmEGaNds35SAjI3Bt/cB+13qImh9pAxKQdyieGsceAsi2tATV+JwtAU5MeUd1FRJGcGKITY9nlvKA7VQed81LhhyPBojtzFiJq9HzcdobfDX6XSwNayqvA30v9m0lbs/TKibFlNB8hqn8ZrLRrivMRA+GXBjhcxGJlrTCPgwdKHugDg6iFyioDa/MAPEonEkEBWMa9TQglmiIBqzjs4DbuNzbeIulEm9NE1RZG7EcisMZs9untPdERZ3+2mvX6Hgp4Sv+ourQhKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOrPuj+gxBvnX9ZIEhVon4jdkaMYFvvFLg2mG2CxEhc=;
 b=C39YmmIoGRV/oI2boLDevGHPspi/CsiIt/FkHPrGVlnHOuYAfgKLt9X5Qxt72aoUYG613NRwkXdzqaW5DJ2x6E/WHuFcxqOJujD0VSnBXqmbTrEUQlnQVneyt1oZ24CEFVNk3lSFslm/YWkfrx7tKUFyf98wGXYljqsog5z7n3xGyBF+TMgmbTyzPzKlOMMpxhWo/a3IsKl+9TCNP+2rtBMMBttAkKiELF3fDwfwVEXsxq79wyPQUfbsTLKr6h6T/ig9zTp2HWWTe0bm2BAar6QPirN8cfEzxp7TUbngEEkQamu1ZXRGC3YZZ89Z6Nt0OEBiYTh2OyGS5peld89cgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB8234.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:25c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 19:01:26 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9587.020; Wed, 11 Feb 2026
 19:01:26 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: steved@redhat.com,
	tbecker@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsrahead: enable event-driven mountinfo monitoring
Date: Wed, 11 Feb 2026 14:01:22 -0500
Message-ID: <20260211190122.3878196-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::10) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 51817b01-bf34-4c56-dec2-08de699ff477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zHND3PXAd4+LcpjT2r/mZVsNV0OaMq8wR2GdNw3wYC9ShSIFyzN5sgEHHq/F?=
 =?us-ascii?Q?5P5G6WOdyaPSghkUfDMvujDiwzwdZW7aYY06HuuVsOIajiauU5jOA9IMXf53?=
 =?us-ascii?Q?7fQuaQpDG3D/SSvaMjeRKutgDw8hcuDAndZlHc9q/nOba8EfwvDGxcqrOIMf?=
 =?us-ascii?Q?EIc8dP96rSsNKLSaEw3rFsjnU/Zu8NVYNFQL8SIWebx1qfl3YtMcNa9Ves+P?=
 =?us-ascii?Q?BK0qO622o9SLs2lx6AFG2HXgWi+RdUKOXT0xYctvgiD0tnqurUWQCocAWYKL?=
 =?us-ascii?Q?kQc2qlnr9JgslGbtBU5SlHNggLXNytKNV7AYTsHGOL2EA4X+JlaODKmdM4Pg?=
 =?us-ascii?Q?8wVpLQ2Ny7xcc4gykDjtyOueMrxYC0Q+yK8bOCwbZJROAEsGZ4pSITkdY0vk?=
 =?us-ascii?Q?xE9StGAntBZ5EIKvMRaZ9FF9sLgVJqIcOW2z3Bc7Tm0XqFUVXOxOUJzqO931?=
 =?us-ascii?Q?2lChBp/LZ6XWp3MXJgh9zMdTp0x67pYI4SJ+f5MBnWO6eB2jhljzvExvOqZg?=
 =?us-ascii?Q?FUUB/U/4eWPfUuwy1NTKyUVVMB4EM5ZIw3/5DuUyw6GkKyzfbVcPU2A1oW5C?=
 =?us-ascii?Q?2nlqwlPW8QW7Kjg+JpmUv3HOdALsXOcdfvm9ZwOySK6PYJommCGXO1Lx7s8q?=
 =?us-ascii?Q?VTvl3C98DZXsuufPWBu9yxTwq9d/Fsfy0Z/9XpuoqWttxXVjfBp3grBCBrwQ?=
 =?us-ascii?Q?w5pAIRvxEmZ/2QIeKbZJtHnjW965oiwNnT9voIAU61Yxo4xL6JIntz5MT8nq?=
 =?us-ascii?Q?DYN0pcZjzjmwHOAEq60PdlGQbjZnep+3bltlRfiothzM+0+UIDOiJNAZg0NJ?=
 =?us-ascii?Q?fzmSwlIIPSgIOLr4d1fBboWoq4gVFJkbIDYXjOZ3eXzBabB/nMxhQsTuHEhg?=
 =?us-ascii?Q?ufZIOz1UYVnLWI4Upq04jX+AhZEwQYUae0E/yZjG42CpReXNrajF1ViMg8Zg?=
 =?us-ascii?Q?Bnt2LU7FZF4X9fZ/35stHQgPGCXU8MWERqglkarIgjZCcLgHzRki5sX65tdW?=
 =?us-ascii?Q?xbDRz8VDFKgUZP/9eRgz4A7jMF5ZlbcFI9VlAtrA1l8mARZ5o4dvHE+8f6+R?=
 =?us-ascii?Q?DMWJnAqjIwFpt6fMPPMYMJV04MxJsMyvuLNKajMmHslZuJwr1J3ePGraqY9U?=
 =?us-ascii?Q?f594ilasoiIIqzfjr49XxhUCPIis/zI3DwXgA3XfmEaw/25/0YP5X2pv+Y9Y?=
 =?us-ascii?Q?/42X2G3UFIlkZo9NfnKkLnt8BOnPt2QnLOxS4KOX9QnWLN1ZlJuiLyvaKvd0?=
 =?us-ascii?Q?IXOc3EFpGaOckeIJ11FtBq7m6jmJOHsMOd9DhXCdBIjOGyCVzAMzLbTk0P0A?=
 =?us-ascii?Q?NdqEumelOUF2mbKNjANI8TXVOV16/uTcY+lhqz2AmXNwREyOWeY35kGhi14a?=
 =?us-ascii?Q?AAgsPTFLJdhssmz6m8jJhEG/73MjyeuaV0UOAapubOs7HC9cocfMCTq5Zgfw?=
 =?us-ascii?Q?THyjYm0uB9RR429EmfAvlR+pgWugwV6EQWP1ss+gamz69bbTpYnA/7pl6mq8?=
 =?us-ascii?Q?0/StqbvwHtZi1b/up4ze2sT/WSss1BhZR8D5ph4mpIRrmTxuyP1nG24/XFB0?=
 =?us-ascii?Q?WDLYyyz4lfkVp7s+Zbo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W36HQrm3Suc38qwsz+5nFdX043quW6M6K3VGtI0C1Z1QCSaraFa2I0vHgHvu?=
 =?us-ascii?Q?fw3/6WYAL7xw+09oXYTQMyVRsfbvLj0dkf8MCFrXVD+2iO2AzJwd+eidvGAP?=
 =?us-ascii?Q?b4taDFtMNq2SRVIs77ouACxF+8udWy4RiuAb8/XAiJ9977Fme55kOXtGJ/SU?=
 =?us-ascii?Q?OsoNW6GZkeR8/KlyXmJkRV4Xgojdcl9ufpv6O4ssQSdOKvmo+hpIi8hoc+v1?=
 =?us-ascii?Q?xF81ML7IT3o8AUUHdp75NY/fLnf4b2RorheUyY6UGOCnbr2TCBUsYP89P8VU?=
 =?us-ascii?Q?SbZwa4BN3zXq7eXIJgHneRjjdIKivz0azVbwKbBW8X6+lktTbsNSIUrsklgh?=
 =?us-ascii?Q?Gd1dlL7O2MnizAb6QNr4DInzfvMe7MbNKWZSj1GyVMUqOZM9bP6dpgDvz2mA?=
 =?us-ascii?Q?bGY8smcmt7Rp7uIE88epap0ocPIuDQEAo2OtPLap0/xNA9WGtN4xQHTBmS/d?=
 =?us-ascii?Q?sJPksyhUx2RzM2Q/ay2Bh68pH+xRhhXIR36d+/efDF1+JttPyu6uPOrwp7WT?=
 =?us-ascii?Q?DmLCT1OLoR3l9WuEyg568GznW/Olp68911eMUkOz6FZS0raS65ZTocnyBKeK?=
 =?us-ascii?Q?Xv01AoENZ5h/WZ+RQGwtLCpY1q6wee93g3FeUnrM4RanxYxRj5wz2X5TWBEx?=
 =?us-ascii?Q?43mTBSMtK7YWlTzVoKtadbycMmBS8wVsyMaubgFMIlmjNN3vHDMv2uHd5MNp?=
 =?us-ascii?Q?svXCfc/y3QSL5qoTlILIcUeH9wXxdl1IdkFSv6/d2xUkxvQogWHkL229u3Ti?=
 =?us-ascii?Q?z7s4sPO+MTERwVcK+bMqf8Fhy4czinJNeENB21orGRoSdFKP5vDHJ8t6U02/?=
 =?us-ascii?Q?w2YyQAYA3dkOXNYRxyC9IeGCNPeVvYeywYSHymrFiuGaFpY18I6g+JAgszqs?=
 =?us-ascii?Q?DPZ6wSNEUJD2Xjo+Ln8AA/qByd5+tLWViA4IPt6Qd9kQ9RSKt+0VutW/FyQV?=
 =?us-ascii?Q?AI2xK3edAISQPaRzKVngGnv3qp+9Z/TM4T5jb/oDfQk9jI9QamcWnchLNv5z?=
 =?us-ascii?Q?edEYX/24HunUgUWzhf67ecjVNR3rnpPHsH0aU2l1JU0AztpSdCyRlrqHZTq7?=
 =?us-ascii?Q?21LAs/6g5sw9J5p3U8/yyuVKPbcHGixb6ozCAOzdEVmC7N2z5WMm+bSsk6hg?=
 =?us-ascii?Q?wMk/xTToDARYiCQ2VANdjvTes+3vp/IjTlnloi2Y16m1B8ie5WooOjAyOuKe?=
 =?us-ascii?Q?JrNXP0eoicKuSeuY042k6V/dE4C+b2v+isMckWbS6XhxhisbieHTTXsqgGda?=
 =?us-ascii?Q?lL2TRjTvDf7QuzeXNxes57qQDz3SnAyJYWfywO37kVu3+Q8gZFacpDwGQmPZ?=
 =?us-ascii?Q?TKt799+Y6+iOApZc7lhxUD/OlTqWAoGI8VuvLyqqLWjJPmWanGN795/p3vRz?=
 =?us-ascii?Q?u9oXQ2cUAT3HfkknfubwYLb8tNPWIeog/miLIP0/CMALbnzEkzxXWee3wnVb?=
 =?us-ascii?Q?LB1CfWVzV4ehLzMYv8w0yJ9p6zYbBk8hpD8n6dnH5KTQGHPKI55t50fENfqR?=
 =?us-ascii?Q?MwLAg9hM1bQAJZMH9UNMb4BNBh5va+ZFxjG28RWZ0HPcluzFSWI+No61KbhR?=
 =?us-ascii?Q?bLOlCy+D2iNdew5yMUch29A8ldkSOjDZ01aQ1+yKHlScGZ+uWQiKugPyEU6L?=
 =?us-ascii?Q?p9CkklIuZpYp7DsTgLowENb2AYBZP8J8aCjM6gZgtvr8cO/RUlW4LNhRP7Z+?=
 =?us-ascii?Q?ceo8yKfDS+47yG0rlZNmo06zmGZmg7Bh2MkNazlMRNCiS25br2E39poLidT8?=
 =?us-ascii?Q?YEJZ5x5slQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51817b01-bf34-4c56-dec2-08de699ff477
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 19:01:26.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cn3GwrAE3X/Nr5k+dIvKhocfrBSU+/kF3CVU7s6yz55bZnfuklgQkfxMcNCDkFtryXSJ7bDEcpnVtaRehzfVBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8234
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	TAGGED_FROM(0.00)[bounces-18895-lists,linux-nfs=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6E53126FCC
X-Rspamd-Action: no action

The nfsrahead utility relies on parsing "/proc/self/mountinfo" to
correlate a device number with a specific NFS mount point. However, due
to the asynchronous nature of system initialisation, the relevant entry
in mountinfo may not be immediately available when the tool is executed.

Currently, the utility employs a naive polling mechanism, retrying the
search five times with a fixed 50ms delay (totalling 250ms). This
approach proves brittle on systems under high load or during
distinctively slow boot sequences, where the population of the mount
table may exceed this brief window. Consequently, nfsrahead fails to
configure the readahead value.

To mitigate this race condition and improve robustness, update
get_device_info() to utilise the libmount monitoring API.

The new implementation:

    1.	Initialises a monitor on /proc/self/mountinfo using
	mnt_new_monitor().

    2.	Replaces the fixed polling loop with mnt_monitor_wait(),
	allowing the process to sleep until the Linux kernel notifies
	userspace of a change to the mount table.

    3.	Increases the maximum wait time to 10 seconds (MNT_NM_TIMEOUT),
	significantly reducing the likelihood of a timeout failure
	whilst ensuring the tool returns immediately once the mount
	appears.

    4.	Retains the original polling logic as a fallback mechanism
	should the monitor fail to initialise.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/nfsrahead/main.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index b7b889ff..64953346 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -16,6 +16,7 @@
 
 #define CONF_NAME "nfsrahead"
 #define NFS_DEFAULT_READAHEAD 128
+#define MNT_NM_TIMEOUT 10000
 
 /* Device information from the system */
 struct device_info {
@@ -117,7 +118,39 @@ out_free_device_info:
 
 static int get_device_info(const char *device_number, struct device_info *device_info)
 {
-	int ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	int ret;
+	struct libmnt_monitor *mn = NULL;
+	int timeout_ms = MNT_NM_TIMEOUT;
+
+	ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+	if (ret == 0)
+		return 0;
+
+	mn = mnt_new_monitor();
+	if (!mn)
+		goto fallback;
+
+	if (mnt_monitor_enable_kernel(mn, 1) < 0) {
+		mnt_unref_monitor(mn);
+		goto fallback;
+	}
+
+	while (timeout_ms > 0) {
+		int rc = mnt_monitor_wait(mn, timeout_ms);
+		if (rc > 0) {
+			ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
+			if (ret == 0) {
+				mnt_unref_monitor(mn);
+				return 0;
+			}
+		} else {
+			break;
+		}
+	}
+	mnt_unref_monitor(mn);
+	return ret;
+
+fallback:
 	for (int retry_count = 0; retry_count < 5 && ret != 0; retry_count++) {
 		usleep(50000);
 		ret = get_mountinfo(device_number, device_info, MOUNTINFO_PATH);
-- 
2.51.0


