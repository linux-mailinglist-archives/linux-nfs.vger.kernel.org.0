Return-Path: <linux-nfs+bounces-19888-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKbZKrfermm/JQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19888-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:52:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4023AEFE
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC3030579FD
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A663D5241;
	Mon,  9 Mar 2026 14:50:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021076.outbound.protection.outlook.com [52.101.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22933D525A
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067846; cv=fail; b=n+vZaSgMMzt0C/LzdLdzcCLQvaGmrgp69nqVh/s+ieU1ORpfuXKaON/BmD7OqHLlgva21D9YtDLZhUDJGuN3DOcwY/l7WyUgyqRpFfGNXtIfM97YwK/21cmVjex3PexhaaeVtg02OQqmZDIxGCmQigl5dG2cYXOEvVn0KPWRbj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067846; c=relaxed/simple;
	bh=MXuaukwlRQObWob8+AGt4YxKIXbV8HuBaH2aAvJYq5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EhzJic+T22g8ZurN4DV3E0VCGC55/kbLvbthRJvodYoC60FcV18WoQ7HVCne8ZuldWL78d5L7bsnYy2QcqlPBhPmRAx+7tL6o2X+Jld7EMsj69vvWNBgChCzJlmOs50EzhQuDY4QLmCYh0yGsa8vxbtP8fkj6JDhzKRc4SOktHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjP6pX3Zp6CAN4a43bzhE/Hivj2g4Gz6nSgeiEDaFUyqC9ZciunxaVxo9Gvd1byG/D5Z5zuB3ES+/UNdESiAMN999FpTuQdAvEJcrXnDh6BSbEYMAZ2V+V19OYfdzfNsGcOYugVE4T9VNl/P26zuSEhTd25dyjpwu78fotZUgHoIXF3hYtOiwjoU5HUS2ePlbJ9eGpNK4g9SVVWlf6yZlTTXny3nR/dCJPDt12Ybt44pmVCZZRsTwbtn9LQufaELYXaZWLbw24kYkjL1b6KgLSSSEwec3nmNxCE9SQefDNkpXpoT03Tf9fvusWYFEwzUYZAH2Xf9cAV7xF/HgEna7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlAtkALqCz55eBetgVWIWLSPEiVPz1fYxutaFXJED/E=;
 b=pmnQ6p7cGpZbU5Kcpf24aTyO2Q+j+dQd5Vje8vETB+yW4sIf0LDRCTubffvgItu69difY81v+s+dp/kdYFdf5vZao/esRggc72sKWGiJpVIER1AiHmWQneH7jeA+tkVRPAzQys2Qj/CQrNuB+a/2QXBBWB/Z1UFK9GNUIslSX/e0xyxkhMcb+O/YMB9YS+ZFKrmsxDvEt+OvcE9MUEwZr/RH4vlcksnX2jI2IRYFsesloVQwUgxOP4acg5wpUI5BsUiZv4FSkFQQ//ZWu1md5alaq/mPsrj+fvqeoddo2jQcaaoGj0FudXWZgFj4uewyXgcPjP4OXoVwURw6F/3irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6620.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:50:42 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 14:50:42 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: steved@redhat.com,
	tbecker@redhat.com
Cc: yi.zhang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsrahead: quieten misleading error for non-NFS block devices
Date: Mon,  9 Mar 2026 10:50:25 -0400
Message-ID: <20260309145025.107623-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309145025.107623-1-atomlin@atomlin.com>
References: <20260309145025.107623-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 5733217e-1781-44ab-1d54-08de7deb3c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	KbKHjVfT6MAWOY78Esr3hKqWTh62f9gbVZs2ei21QLvvnwW7Tju3hKBlD6kBIZ8wrfRsdr/HvD09JxvpiR/ALP9HzJMcd0YsrlZhb1m3Xckq2DUKs6uL1kr9e6U2D/7uxhJihlp8OMLyKuaT148TNyHIaWHoSUQPsggdCwI1LGNliSkIjQ9/sqLdZU9040rBNHJMSnZflwp+E5Kemrey/+RiDpAD/lMCRXSlHzs/cRRIHlAav1SGttVns7IKC0uTkTt0P8beZap+wDFZsbl1Cl5SPCf/ZtH4WS2KOo8x780nwwOdAFQ+W1Qj93HyjAblCSM5efOpRUUMh8LR6agBK3idnD+Q8ru5QtBCfuzdhO/c54XfrtHvw8VuLvX9fWj6TR2URwoLikudDbdyjoeOdbzdkytU6EkWBdOext6twbgZ8wEVMoq/dFFVc3ClBurWg34SPj51nx9lQTDnqEniuNxkTfD15mkKgqIPoz2cTJWh5/RN19WTSHLGqyK9ycM25flUFCTq1cOd5wpmre2lRnxAb4LDvkF9PKoXBv8UCpPL4qskWdPUAHypWjqqsXKtrJEy7vC3R4fUFcTBfVQO2CgRegNHb0P7eQDTmZd9f/HeKhhP+GJ8nyuRcvTO9fddVUnVSpqPDg1REvUQg1X576SxxExFfyIcSX/nZW16jATFO3A3/WQJDhwMPd/ojm23VGu2mNKdQZIkY3ko22XVDluZKqTOIYq1DHbNjqybbhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XHBaog+wrcT1+pQ+pdtkhU9D+hLzOCCMoMTy3qmLQbHDnMNgCMgm5rSdVUWq?=
 =?us-ascii?Q?7EYysmCEq1qlJ0Pisl9OoF0JhjhAtjTp5HFOJmdrfBH22AQJgqnVsSY/cApj?=
 =?us-ascii?Q?sT33DZfgRQlMRgXwcWRDmeBKJ7BONjQCpe7XEJrfbnDzFmEVjmezBS1q4FNR?=
 =?us-ascii?Q?dBR49PEUUrgA1orofTnqjzcMhJKPs6Cx96NhW3IAy+vJVH/xXpP7uHtlFaJ0?=
 =?us-ascii?Q?5g1UHZZ+iSFlfu9s0RU8R9nu0Lg0jj3NMXUwqT5sdVnkJ9kFBpLWt5zzJWOO?=
 =?us-ascii?Q?Xbpal0q5KcpHFsjgus9zfMBwQlqCKbZu8aYz5aM1jjOK9Jc4vzpTrPcTB2od?=
 =?us-ascii?Q?4SzqY2OuxAKwnilc2yKwgsYbhcf6up3N15NWF8wEJMgxOlhWw+Xh8fJgsmPl?=
 =?us-ascii?Q?36ATkRgzvGf73eAzlJ5vX6hwkkHfmLEVVdD5ZjxlfHc02AOuAseiu3pBQKkn?=
 =?us-ascii?Q?sJWmCyQR2UV92d3qMqH0t7Lmm2hT43RJj2qzyJRyqpA3KH+sDP5PwuVVY4U8?=
 =?us-ascii?Q?Bb/kHGoOPV3JfG/R3pxOEXQrrwO5BINHpte058Tk1jDg9BZAiUS8L4PTthZx?=
 =?us-ascii?Q?Navuq6Rr/I7X0B0KJrmOYCPIJtzROC7vVzQ32/9MI5LCqVuRh4asV0W4Zs8+?=
 =?us-ascii?Q?A5SkEOcaH1TByHKT/BsL4it/LsSau8/lj8E5sQ2MaeLkhz/m7bjWd0by7NSH?=
 =?us-ascii?Q?hmXkcIw7+UVA+PxLbvxE234Nv6otM2DQ4UnmJCuw7ohajWQd0vXZ1i2cZgM7?=
 =?us-ascii?Q?DvDvF3N9aHXTCkYtNpW98h9asY+LWJoN5XT+u2XV8SL+eiQiA081B/Jj8dSr?=
 =?us-ascii?Q?Ji6bViYk+P9uACvh0OgJAKOj4yUzckv09cSGb5+LpKe6JNjS6OivDMxiQOxF?=
 =?us-ascii?Q?a3Rk8dJWwoc1iT0veg2D4hhcD5feH2/amsmvurAoLnHIXmrRjcIw10q1xZXs?=
 =?us-ascii?Q?eizCztNfnZzwC8HsEEqazgI+VSYjwmghHhWQWUae3ufNml6K98GKQVxVGglB?=
 =?us-ascii?Q?IM5iZNEPb20eLJmpvV8VKFKkFnGPZSHK/5kFRZmd/nt7pB8XODb0aIYuxwuV?=
 =?us-ascii?Q?dDf3OdP8Uucu8WKR52+0hRBVpgmEPG3cbDeiYv3VnXK2o5EFtD2wVo8ovHAW?=
 =?us-ascii?Q?PIWfPIt+HW/9PrxFgYtv+lgFo6Q4xbDxJB4hWEzxgae+adSRqryjvEpI+U/E?=
 =?us-ascii?Q?lOBG/oesTmSgjVVaBou32ZHH3AO/OOhlYZD+H4BYINmC+cQpPiYz71ZY5ihV?=
 =?us-ascii?Q?ADv4GssLyQZLm+RlDwUlIpAX9ZCjWeEW4EcB9lBPth8cVY74bZYnbwJKweK4?=
 =?us-ascii?Q?lZBShmsFW+DJhjxuLzIaP0NqiD6TnndrT6snFNgOhde/aPwJzlUU5VOg0YmG?=
 =?us-ascii?Q?aI3xqOkJnJFb5Vehh1qY0aOXlhJR2Hj8nKO44YGm8SPBf4EVMu4XlfzTP1AJ?=
 =?us-ascii?Q?aSTPJLyhFQq8+DSpCpQonCHrVzfYn70m3Z9Yo4VImleMqlTANRQ7ugkDDbHr?=
 =?us-ascii?Q?wQp+6kRmV6RLas7+gJQzWWpqATAXKpyMsJ3XkvMv2hh0Fzr0sZIP063t+Lu6?=
 =?us-ascii?Q?jPf6n+FonkYAFtUHsHB9rtgQ9DOsN2XokWE9ukGe3cSNDb45t78DanZLCRlT?=
 =?us-ascii?Q?wkPRz/AEUkH6eIHwD/TJrRDXRZGe0z2JUBXApH3ciu5P4oliSx5o6+gNITE/?=
 =?us-ascii?Q?oX/NcAcnHYX7kkLtb5vNoyqxXIn1O4QCl/cEWeIyX2jh3YXcyAxfzCq+wbvL?=
 =?us-ascii?Q?WVB8GFE6QQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5733217e-1781-44ab-1d54-08de7deb3c95
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:50:42.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpPkrvwGB1ycfRz47+b1VuX9d0Y3ftveVeqzo7Ks7FKRhSeHETr8FTyFUFyQIhaV+qYeg9/AMrbuR/DZqnFfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6620
X-Rspamd-Queue-Id: 17C4023AEFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19888-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[atomlin.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.529];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When get_device_info() evaluates a physical block device via the
fast-path rejection logic, it deliberately returns -ENODEV.

Previously, main() handled this by logging a D_GENERAL error ("unable to
find device"). Because udev invokes nfsrahead for all block devices
across the system, this results in misleading journal spam for devices
that were intentionally skipped, rather than genuinely missing.

Update the error handling logic in main() to explicitly catch the
-ENODEV return code. When encountered, log a more accurate "skipping
non-NFS device" message at the D_ALL debugging level. This prevents
unnecessary journal noise whilst maintaining the existing behaviour of
returning the errno exit status.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/nfsrahead/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 33487f37..86c7fcc6 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -218,7 +218,11 @@ int main(int argc, char **argv)
 	if ((argc - optind) != 1)
 		xlog_err("expected the device number of a BDI; is udev ok?");
 
-	if ((ret = get_device_info(argv[optind], &device)) != 0 || device.fstype == NULL) {
+	ret = get_device_info(argv[optind], &device);
+	if (ret == -ENODEV) {
+		xlog(D_ALL, "skipping non-NFS device %s\n", argv[optind]);
+		goto out;
+	} else if (ret != 0 || device.fstype == NULL) {
 		xlog(D_GENERAL, "unable to find device %s\n", argv[optind]);
 		goto out;
 	}
-- 
2.51.0


