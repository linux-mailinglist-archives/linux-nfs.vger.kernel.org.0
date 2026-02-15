Return-Path: <linux-nfs+bounces-18940-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIflEUBwkWnOigEAu9opvQ
	(envelope-from <linux-nfs+bounces-18940-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 08:05:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389F13E2D1
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 08:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D2C300C93B
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247F23D7F5;
	Sun, 15 Feb 2026 07:05:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021143.outbound.protection.outlook.com [40.107.39.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FA19F11B
	for <linux-nfs@vger.kernel.org>; Sun, 15 Feb 2026 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771139132; cv=fail; b=rJ5ka64Wz2Ba+/bwkEZh4jU9PGo8YZAlO+9LXNmA9i9ey6u/m4LWZ3LemLevaYsfjJfZC2dqZSvEvj4/eKtKyCqq8KrnIFFxGO++QunFouBkAOgLEkMsdj3lfoXnuYUTEz7uPFhd93PQJpwtCTZk9BxGBWQr/QkDngnd32+M8QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771139132; c=relaxed/simple;
	bh=MTZuLf+Ym5VHPRwtQampXVUUhBfB9saD10XYyE6prFM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NliVN4UCeZYZErpgGcuSItZJVmQgmsgODjrr218BLK9d1hgM+tJvUsf9ZS1KW4e9R7GcnFbqOAf8cU5NyzC84khNWHdvVBG+jKI/MtqpwaaHUBbu3JfCDsnrzmxDbodCy7CG1ZCaSJuMUtdyXF0IErAT/1VK1zS4xV4GqFB9JZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F25UFhYuCkMOSQ0BMu2lwPdmFRHcWO7FxleEtnfaoJ/vwCjm2FR60jWBZ00OixBXnGGyuKxONouqDtE4YRQPnJu6rmv3QDLx6voGKKIOKu2cv30mHCpOtnoW/mIrWW+f9Ut1KgfjiimEuwc/0YbIKieRfKxKGKMBdur0q4OVHOdwLf4NDkrmGUTOVU8a7f/Px+EGiH0SiB7hxU+N/wB1SJ/Rli9LPI/6G0RL8Rg76R68Y7b/p8cFlFbzTy36TlGZ2mSKujAXdi43txmgM/Qcy84LxU47CJDo4ZY3GIZ1HOuZ3ci3APxI82+0KLDi+h8w0n2h4aNU2aRywGJH1yOk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/BaPDXtHV3CFUtVoAojZOupu2Z0vF7AMVfeTrMUtfU=;
 b=Je/cuQceZcX9I8D/SCIw1PpTPaowNCX2wkznorZc7jYCkbiXQki73K4jbDgZBH9Jf5n6QcjRTGJnuywZuHx07OWvjpUjc7u5X4w7lFlGgnVU814TOrMAocIgD8lt6lCTC6cS0plt0e0rYCKyVs0uNzJe3LypVv4udZhwxcplBpH5NoqdJ2hpNjxG4yT/T9efTAusGbHMeMiMZYbOqV06jprwI83Fj7G01t2pO2lr6cKbTF+RD35gFIGEpB0qfeSN4OFB7FAmTn5gQncbVUW4u8tJActczDJJ6XDp/VJnr9GwQTmUAsxf8EksNtCmzrdZE+ztn7/+QvhYEpBA3uW6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 SY8P282MB5022.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.15; Sun, 15 Feb 2026 07:05:26 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 07:05:24 +0000
Date: Sun, 15 Feb 2026 07:05:10 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-nfs@vger.kernel.org
Cc: rudi@heitbaum.com
Subject: [PATCH 1/2] nfs-utils: mount.nfs: fix discards const from pointer
 target
Message-ID: <aZFwJmiqqLgWYSl6@1eac07209f0d>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWP282CA0015.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1e6::17) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|SY8P282MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: ba448f29-e53d-46b9-e77f-08de6c609760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkyrUBU9u8codIWrB4hUNhDAGvGW/FxadvyUGJYZ2IVuS75ooQbEzklN6t1j?=
 =?us-ascii?Q?L7+f8YDY2VVs0pQ/hVuYuyq+CtFW9s3RN5lXyfxCtYpCm1bwgWu01LtqHx4Z?=
 =?us-ascii?Q?wjvn5EWB6uVyLhCeWSuLP2d5cIWFavIQ+SRt0sIEOYpnhqbVoIQvtEm9LVoF?=
 =?us-ascii?Q?X9GDfbUU0xQY6gEl5cNGATImxKQE6yuW6OpNmm6gThR+o22+cB8NnT19cK5t?=
 =?us-ascii?Q?BVuacNcIUa36jbJi6qQnfkLOG6YH8JAfRkttKBbYJKHR93e7offe1goHexFX?=
 =?us-ascii?Q?Q6Uxc0VyBIifoxjkpVVyzJ7UR1WDl5PdLltzAdDR0Wdwp2HSjLFZAqDVBAWc?=
 =?us-ascii?Q?O2kiroMkZkeB2UWMDwLB8xUJao1bt2u/1nhXE9mQbkRsUrqgn+6Tm7fkjVN3?=
 =?us-ascii?Q?EQPXNzm/pQsMF6GbyAT4bANl7ylSEcjJGa+F6sVav/DMfdY530cWuuzw2muW?=
 =?us-ascii?Q?Hn5m19eUDuh74J+Knz8VpGJTScD0QjhTFddshoUnbd498Qe4SAFM6dgnXa5+?=
 =?us-ascii?Q?+pGNUMAjc26SRz4mnZwqUKVmgNYF7lJDQTwhl/XCIFBYqEWHIsMTn/DVbHj6?=
 =?us-ascii?Q?Gy4A3LVDAxgNVXQexuEvIaMmZ5xKug58lRgZAXPnDnjEAAlGfpKfDyXcRPZF?=
 =?us-ascii?Q?I0Z60nZPkiYmhZ5JZEW4nR6zLe6w/Vu6IYBS2SVsGbF0QeYn24D7KOTeMts1?=
 =?us-ascii?Q?OXlhuL3/NN75HMbDewRxXiObKwaW5p930Hx2hGX5J6NdQzjN323MdFEnitSl?=
 =?us-ascii?Q?wAK+AJnYfN/h1z2NH2sy51kUDyiYl3MTropK26Bi80xjoiJcjfHK6pGXM9ju?=
 =?us-ascii?Q?Cx39C2tEIs2KfN78CKEvWVSU+zMEbZJ0Q+Fsct6Tb2x5Fazf+ZwqLyd5WA0y?=
 =?us-ascii?Q?cj3QZuGSl8XJR7cpEO6AXrYTOlM6pos9n2H6eiRV7O/NAvCqGR8SEsST9Aqd?=
 =?us-ascii?Q?Jda8BCGv2OAk5+yXoc9d5iMwnVzO47HpXioRU6dX5vlUMtpQKhTXdvSyYUQc?=
 =?us-ascii?Q?8M6NicKXAoOuTLNzr3P0MlpNrCRdGl/s0aocxR1Jcz7w2o4TH9XvCiNpjGkr?=
 =?us-ascii?Q?YNYRhglnJ8jdXB8sEq6rFUL7jnBYVDgQbRDBhpfWAwzv4bBo6KBUs4TAFHLU?=
 =?us-ascii?Q?Lf9PQOo2Iomee5B7PoqygvekoIylYsDa/y1PZBB/CgGN8dMwqtg0DpLNtYbn?=
 =?us-ascii?Q?kS1ktLsB1bqBzYstlEbhQhhpGRpR6NNczeEpMI1Bu6jdLZqHHphLI36k1Dq9?=
 =?us-ascii?Q?wFJ2ZTPBC+d9aASM+jlpztQbT9J3YmoUSTtMYylr0dqqTyPXY5PAlDQvKsc1?=
 =?us-ascii?Q?qq5UFSLw9eRTqw3eBDwNcyQU3+dYHtH1/jgDAEt33r3k/y5evLfA/oM+L5TQ?=
 =?us-ascii?Q?4DwBnbtKQB8Wp7piBD/WwjFPXhBfXRq0ZVop7ZIRnHqXBLVP41RPG1i+el4N?=
 =?us-ascii?Q?MgWqtF7pxWsweimLs2BkKALpQeGsGY4R7lbE6+RTTh/DODDEnFNiFwKiya9l?=
 =?us-ascii?Q?1WGMBHv413lOFKln0bGcQgFDGaC0skXHu2gGPdod/sONjo9Ik60wRr5M4djy?=
 =?us-ascii?Q?a/bZrePLVyBIDySptIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3fHrQtTrCuF3yVjtVN9z2oiAlL53Y5ZbO7PV3UdQIos022TW9Q/DWYIk/Pg?=
 =?us-ascii?Q?xWQu9ZvG7Zl/NqFmSff745liLvgobhV7dpkUxQTo196LUG8dnPbzOysVpXdl?=
 =?us-ascii?Q?WxGF+AWqSyQOceTMCO3WX6gWhOi3a7Q8TDxA9dHGrzTz1WCNoSgbBHuTlenW?=
 =?us-ascii?Q?Kglb8JQxagjUPUUQJUxwGgYoesCHUwhblh40UmgQ/KLJITUHetJtv2+NM/st?=
 =?us-ascii?Q?gcc+h/GZK699kVMCJRmM8hRJATdiS6usm/4VhwJiKpxLcRdWWYeihwh31/M5?=
 =?us-ascii?Q?NquKgl8wFhZ9njPpfrpbovlvfCkIWyhjHt98qvtUmmSxYNjUtXs5Y120JYC3?=
 =?us-ascii?Q?V2JAAHk+uPCOpUMlLxe3z6NrQhWOd9abs87KG6kKPUv9/U15cUvi5q4Dbhcq?=
 =?us-ascii?Q?pdwoC+7bzyMoCLpUa8MuX3DT44R3PW5xBAOTppKRHCag1MZSsaaAYO2uNgZC?=
 =?us-ascii?Q?zUD4bt0TkEBouVGhYRHEJOFveEF8NRisnQeEtaQq1Cu4Ce5APNbKLAH0fj36?=
 =?us-ascii?Q?AZW/+sYxWg1sEZVYIRWeTrxU1OLUY4EgrEMxbF6XsKXXxCCjrfs/ytifLMwi?=
 =?us-ascii?Q?QJJkHQ+z0RgVPJJS9xXu6hbFPox1GDJ9R/rw1b8o/4IXuEmQrWCcORMvtOWg?=
 =?us-ascii?Q?9ktAG61YvIXe8O9lflzHZMVUuVQAWUc37K6K2JeOmi+pF/gIapsqsqnjfriu?=
 =?us-ascii?Q?36blSQVG9dtlVXt6Fl93GzePHqOhTrt0pqWc4E5fECd6YEwuO3nnMQkhdhef?=
 =?us-ascii?Q?6pWeduHnDEcWiIRJABnE4zRkJOaBgz739YD0EJ2ITsmodG0B/QcXJ1hmqihD?=
 =?us-ascii?Q?TzxBBPIBNyxzZlaSMZFF175u4KNi6791TEkDNgymy8MH8+UJ6waQrsf7X7Qa?=
 =?us-ascii?Q?HH31U9wIHfRATPkALVvrnXSa18w2G3MklkKH7AvWRvxvTjM0ZInVgv446fIw?=
 =?us-ascii?Q?H95j3S796NKhZi7OfMi0I49GnKaLx9OocNHX3bhD3fWMwjDhDK1mLtYxXRcY?=
 =?us-ascii?Q?S6vLXVGu1+o1CWUDrjfSi0nqnpCZvnsLr+3vBbPzzjwmQBhOhcL0inu168DP?=
 =?us-ascii?Q?7fGPfZItA+MA5OkTdCaJcfWXi752cUK6bf5WN7Ow+YH1VRXqnD3Eb/pEfen/?=
 =?us-ascii?Q?N5CKq+qwMcF/MUCPjANg50y09jiTpl34AlB8zDZheTNu1nYSbB7xgaXCjz0m?=
 =?us-ascii?Q?g+YCQB/pTn5Gi04kkY0kU2h3leWTkn8Q8pPklf9CshCuWa6ruK9WEYJ7DSlQ?=
 =?us-ascii?Q?Kjncr7IcFvcuZz++5ohmOMWJQkVxH6X+jqSzquvbTf0JzoJ5bRb8kyZhZxHM?=
 =?us-ascii?Q?oyIDxzuBXTJWEgXMN7B9GNg2MO6KS/YTo65u1M269RZ8nA7GpymQ5Q6dfNRc?=
 =?us-ascii?Q?W3cnNpjdfAAcKQuRLInetH3dP5Z0O7y5BdjM9YTQcH8TZSI3RFjfW/D16mbs?=
 =?us-ascii?Q?TR/sACmJkFeINS9qVaoEv96mUw3+En0em3q9DozXty5RkhzoiVNDptxQzipt?=
 =?us-ascii?Q?jzYOFB6RfSTeMCLypd+2/8yNCYZRUr3gXd4nmpkbZmFMmqOxYC1dL0hyxcrR?=
 =?us-ascii?Q?x6Eoq5kitvJFl0rUy2VfAzjMVcEiI/KLOR1WxAF7NW5znmPHQ3PHZubA3kWR?=
 =?us-ascii?Q?+J8TBtWIqMoKkyON0NvSW6N/mslVIy5hfMnK0sFjCcXbONdD6u8K54lrKa+G?=
 =?us-ascii?Q?wKxMY3qLg27XrLFoTkEAbKByAkQAlrc7Yewq75qSYbPoc5Ee?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba448f29-e53d-46b9-e77f-08de6c609760
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 07:05:24.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaKkweZPXW44zyso+sSMggBz5wEfN4ud8VnZWfLJnJS+o/1KjRu2i8r6LO63kQYeoHqf4/aF3IbpYo+eyuwCOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[heitbaum.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rudi@heitbaum.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18940-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9389F13E2D1
X-Rspamd-Action: no action

dev is passed by nfs_parse_devname to nfs_parse_... as a copy of the
device name, the parser destructively modifies dev, so pass as non const
so that it can be modified without warning.

fixes:
    parse_dev.c: In function 'nfs_parse_simple_hostname':
    parse_dev.c:89:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
       89 |         colon = strchr(dev, ':');
          |               ^
    parse_dev.c:100:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      100 |         comma = strchr(dev, ',');
          |               ^
    parse_dev.c: In function 'nfs_parse_square_bracket':
    parse_dev.c:146:16: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      146 |         cbrace = strchr(dev, ']');
          |                ^

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 utils/mount/parse_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
index 2ade5d5d..a6354bba 100644
--- a/utils/mount/parse_dev.c
+++ b/utils/mount/parse_dev.c
@@ -79,7 +79,7 @@ static int nfs_pdn_missing_brace_err(void)
 /*
  * Standard hostname:path format
  */
-static int nfs_parse_simple_hostname(const char *dev,
+static int nfs_parse_simple_hostname(char *dev,
 				     char **hostname, char **pathname)
 {
 	size_t host_len, path_len;
@@ -134,7 +134,7 @@ static int nfs_parse_simple_hostname(const char *dev,
  * There could be anything in between the brackets, but we'll
  * let DNS resolution sort it out later.
  */
-static int nfs_parse_square_bracket(const char *dev,
+static int nfs_parse_square_bracket(char *dev,
 				    char **hostname, char **pathname)
 {
 	size_t host_len, path_len;
@@ -185,7 +185,7 @@ static int nfs_parse_square_bracket(const char *dev,
  * with the mount request and failing with a cryptic error message
  * later.
  */
-static int nfs_parse_nfs_url(__attribute__((unused)) const char *dev,
+static int nfs_parse_nfs_url(__attribute__((unused)) char *dev,
 			     __attribute__((unused)) char **hostname,
 			     __attribute__((unused)) char **pathname)
 {
-- 
2.51.0


