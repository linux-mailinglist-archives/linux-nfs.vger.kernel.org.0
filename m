Return-Path: <linux-nfs+bounces-19886-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHq5J67ermm/JQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19886-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:52:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B623AEE7
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 15:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC62E304A5BF
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539A3AE704;
	Mon,  9 Mar 2026 14:50:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020094.outbound.protection.outlook.com [52.101.196.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E653D5220
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067837; cv=fail; b=IrIAT0TZgyfo4oORrmfAdkKSkR+T2hngN9Zmlqk2hOaOkzpjTYdUz/Rr1DkT7vTYVTuMEg3a4JxuMQgM/UrHGJ8PIV+p91mnsm/FKZ/zybk8Z1sm+7GmspuGWf+Vtj9JrJvYhT5U83fc9V5N5A7G5nBNzjLEJP50WUrTTudlGU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067837; c=relaxed/simple;
	bh=ARrx6q0cMN0TGai35LMfLT2obG1s/FtxUfj+QEcdN6c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c6DDDUD5u1FONdgdsd38honfXYGnceCetBGCtnaJh5zMdPKsny+5hFyaaPAalQy/fk4/lnOJbKGjqFmVBykj//sxh/GPXBLBnv1y5cPPRTWtFoXc7Vkt6rz15Co2ZXvUO4giZ4T9qt3r2NLgbNfWHK7SBcyD0LGZJzyQaPzTmgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snRUuk3b+vnPVqQaBIzGOBSgcdreEuvbKtJnoaAfUJh7k1m+euQ3g2Cif+KoSj9L7fYqvwyLr5hWr1uzjUL10Iqg6s9K97CFnUvMoc+hSRF7h4/6D0lg7jEkusvIGjyWzVrYtepEkmQ5zpSuFrLbNqCJLa6v/vINI4e79cDFW022tqizOAADSX4/4gD9xVdYs9VW5gvUc85UX5eEm1kZwn3UsmGkEcmV6toKxOPhuUZ2/1r9/edzdXsiWraChUx8ICtiY2zFBrFAHWxqLrY70BFLF/8+aSqVzQORbyXNEyo1BPkV1CYSeUqjjE5GX38MQRIHb4JgeCvHvte9SbbymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJRQHL3dy6c0VTuuZ2xi/OtBiJqAAMwDUTL3ldnb9cc=;
 b=Aru+Purmuc6l8pX3aCm/ZTElQN/1zdnTdGZnoX3vRreO4F0dXqUU2xssTB09YgvB4GzsJThrUX/2tZT8D5+CQ3nENqWB8ItElYVUDZYfukO7ENfkbyKd8CudzlR4t2YUSYA9A9RV3i5rzsUuOp0v696oAmc0FY+8/CG/0Emy7NaMaWdwezRBU+ze9VIbIA4biy5/PX4lGbP39yn0aMRaUYWR/EReoLLnirJ5fqpO//FtoAAgzbgcJjTip0D+z3KwL7+3uQMyW70Di3FROVw53Ae194FbJgqN2rDENbPaU45IbxAvN4c+UKh3qbxZYC0f3pEmrvS+amQHJv3gnt2lbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6620.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:50:31 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 14:50:31 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: steved@redhat.com,
	tbecker@redhat.com
Cc: yi.zhang@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] nfsrahead: fix uninitialised memory crash and refine fast-path logging
Date: Mon,  9 Mar 2026 10:50:23 -0400
Message-ID: <20260309145025.107623-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:510:33d::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d9010a-279b-4a19-0cfa-08de7deb35de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	Cl5Sgb+o+teL+B9T4IMxAMM6l+u1St26ap7XrHxTCdwg1PtM0Ld7ci2WyF7gOtkd5H85DrClXdD4iNBEtaQds+0xVruMlryWqyyv405HjoBKKD4od6ZVJjn2/PSCkO7iBaIZI6dF9PtforDpwG9R0qNiE4ham7H38jPs4q0Aw+zia5d2/K1kvgbHJBHL7yGe1LudJDNe41C/w2Jtd6Er4KwPGY6BJqhAJFG1Gz4pOwKqoK4D74thZIRM1MvzA2PJQe3Zyxi0eyTWS6tq0Aqdc7zbAjVPCE9xK3cxI36HBdX2J51kfGlO0KR+YXRGiDNo2OzEOBw6eW1DyerlkcweIOV3pInHyD3PfN8/Uwjb0mn/tQTTgKMIgrEkZ73sM1Li2lR+qRcZ2xrR4lAGiHZW5NCkPb/FW1w2Lws26R/D8wPgu7agfNwCEDtvASiRZqY2LmbtTUn6tI/94w7PnLxm8L3tMX3jGqetTdCCVZiaEpK7+VcTncFWbwpkGZybwqIHADuMtWxla6iI3LNOMy+VP0oylyZOT61WN7heQmT/1QYs40kPo+6uNmK8zDqiGJplcmcmbj9Iq4G7x221YB3xV3414CyXxf9mNvU6VORV+JnbN5vaXhzodmVmt2vmP/XtI5LxnHHDnxEmscKgCchP83aCQkOiAySdwG2ZptPBGwhe0Wh2VVnKQSLY7ox5XfOPnV3+g4/A+Ar5hBvUsEDGmATYJdcDaXbGEmNrau4rP1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ReC5ZCU1jS9q6Mtc5wLQ9/Ai7Pqmjrl/YIys8xK+KNknmKnVmsMJYz5zEd4t?=
 =?us-ascii?Q?zN/7OLnmzu8bnR/R5nZGsP/0zKfi+M7Z29+KR6zHQuY3ySf8++d+N0vW+NJh?=
 =?us-ascii?Q?V3yzdnlOAkBci3+IibXKOFKXLMLqJLw2TKz6PEj6mfPcJqYIMOgauPAWTM+E?=
 =?us-ascii?Q?Ut9AQCsk/HboESiSR74xzeYBnxGOTGNNwvJuV/1klvyzsHDDG5wb+u7AaDjy?=
 =?us-ascii?Q?+80Zw+gfe6TZppZZUhmIULxnqdeBPZPYDRqXB+G1rQFL+1HFFqy+JbaN7pGQ?=
 =?us-ascii?Q?9e4ebwYRgINc4LboF6spMvP1T9o2R2UTdMptZMEK5pPg0mJ092rq9NkWtk6V?=
 =?us-ascii?Q?k0GvPapolAs5jYGe1qL7bTZ0rZ+zgTB35Y6/1op8V0yj6HcB3Kxcc7wmpVi9?=
 =?us-ascii?Q?PdLOtEMBw+ZUTqlKokCgN7U5FtcSxlAs9BQIAQ6GHqkzJ3vLX2TrR/rnElN4?=
 =?us-ascii?Q?loWOwOr6mPSFm1TKxiBNzbXq3gIdFDaEZST71mu3Dj13J5bJMEoHC+y7au+r?=
 =?us-ascii?Q?NcenfxW1Ao/LXFQ/qVVBWU5zhA4oJ+W5LToH8bSnJs89fYiY0eqnHVXAnT/h?=
 =?us-ascii?Q?pCFiY8r/Fqnnuw7mhuvxvsGE9DnAq7oLpZeOoCv8OmPJf6TsrRE2bQDiId/p?=
 =?us-ascii?Q?+wI4ZDfuz6TFwv7dXUeG9ldhk849YSLKlVtw0/AdPy9BvPUgggtw7IiqEaLc?=
 =?us-ascii?Q?huwP5jfz2a2ESXd+EhKWKdRo4LVEiRnDliubth+sjNqEchpkhF0Rzm6FN0Y/?=
 =?us-ascii?Q?WJstwfeL/ZstyrG+9UC+E1gBJHuYzIHnOP/y0GnLP0tD2iXgvsL67OCJb+eX?=
 =?us-ascii?Q?aT/z1fM4YfOFNL9hIHebeYDlLspf57UL47nvMUr3QcwWvr8u2ihyI5s0siAf?=
 =?us-ascii?Q?yCwHT39HNP7W7fNqZooA4UwiKk/r4r8TDyPn42F7zThBdSn6HAJOaqeD/7G8?=
 =?us-ascii?Q?NmkiN7L8o0110H4cwrWcTSJlv8oCBPw0aq0eIBwQ0+kLv7hyJytdoWVtPE9a?=
 =?us-ascii?Q?MbITGIZ3BCcm8PE2Bn2LI2O2Z2YxcUNUYJC1xO3JCMrJujajwB8p3iDCRaMr?=
 =?us-ascii?Q?OVMyJoBQCveAsOB+HNyN7ojzb5H0AAVY+t28iE7Pdpe2ghS8LW6RS/vLiMl1?=
 =?us-ascii?Q?7+Gs71KKL1dCH33C5h7OYdPbOcuA7lS6h2WManpioaZwlo5oCPV0ZgmQDF+v?=
 =?us-ascii?Q?mthyKCHyNQYAmrsxNW/SM12iPewik42rNFOdRpf17BsFRpvtSaY7q0+y2dTo?=
 =?us-ascii?Q?JEgVx8g/tmkt63p8DmQQScRejFExl3qP8TNU7HenSsmYUQAuS+X2EgsS4eA4?=
 =?us-ascii?Q?Z5D/R66DIUNopxPv9obTUmjLO60L4HqFmr5YbvU/luP2RO2jx3PoVqBAp7Wf?=
 =?us-ascii?Q?QXFGgmjxsfkUkwESy9cTGfeOcFZ5nuUoNPaGMiv3+R9NnyjSCfup1oO6WVa9?=
 =?us-ascii?Q?+mqd53/xPT/hVtLyUMmLLWbuE5hobMqGnkruBHTZb55HvdO333BQOVDcloob?=
 =?us-ascii?Q?9BLDk2moSEg0e0GCbjmYL91KXTcL21FWWNSaw3xgeMxHSttv2lxoLys+UXJ9?=
 =?us-ascii?Q?kCjaXytiVe5MCeyHjvlSDio1Uj3w1lCF/8Fx3mtqgld3E/USj3knkPAHFXSE?=
 =?us-ascii?Q?MOjIaAIxgHhrSvKqLSIEgRbEXu68POnRfP3DRr+F7dvX5EBu4YItjWVuEaIM?=
 =?us-ascii?Q?SLMMCwHE4LD8c2K43872GDaCR8YhFaYpWrDaOEnorF+www1fRXffoHPzgTGS?=
 =?us-ascii?Q?UECAJKDWaA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d9010a-279b-4a19-0cfa-08de7deb35de
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:50:30.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn21QBZ+Z371WRpSvC2SUeclkW7h8/cClCuOSj0Rq7Mk9N67dFkz2QyzGZ4LDfsHZRgdn8UjqYT8uC6rcFZ13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6620
X-Rspamd-Queue-Id: 211B623AEE7
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
	TAGGED_FROM(0.00)[bounces-19886-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.590];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Steve, Yi,

This series addresses two issues stemming from the recent fast-path
optimisation used to reject non-NFS block devices, which were caught during
blktests.

    1.  [PATCH 1/2] fixes the glibc abort(3) by explicitly
        zero-initialising the device_info struct. This prevents the cleanup
        path from attempting to free uninitialised stack memory when the
        fast-path triggers an early exit.

    2.  [PATCH 2/2] updates the error handling in main() to log a
        descriptive debug message rather than a general error when a device
        is intentionally skipped, preventing misleading udev journal spam.

Aaron Tomlin (2):
  nfsrahead: zero-initialise device_info struct
  nfsrahead: quieten misleading error for non-NFS block devices

 tools/nfsrahead/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.51.0


