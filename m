Return-Path: <linux-nfs+bounces-18941-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDQlJItwkWnOigEAu9opvQ
	(envelope-from <linux-nfs+bounces-18941-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 08:06:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1498A13E2EF
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 08:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380DB3004F56
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Feb 2026 07:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6055244675;
	Sun, 15 Feb 2026 07:06:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020091.outbound.protection.outlook.com [52.101.152.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6517993
	for <linux-nfs@vger.kernel.org>; Sun, 15 Feb 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771139196; cv=fail; b=sQOKGE+N6gFAX0h/K41sU9iTK6QVLlwh6GDEZNsdxozsJ6HxQd8DH8Pgj6IKc9DrcOYwAX/abGyjxPiiF2+80q1fjoFyD5cW4GFKN9Fv5F0WsBaoSz9YkKZChvYHVkv8QGzjLm9ROHa7dBo7XB98kGNNHR3JOKrIwxkR9R6aTyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771139196; c=relaxed/simple;
	bh=CLGffWfXr9SxETpkZq1YYIzIiR6Rfuj6/KTE2o2Rh7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KdMu52rWmIkl/z56vDrQvtFs0n3sDjfJvLQnlTqjGxoZ5XMMSRGI4mQ6vPzxVG4Jdl3z8AvDEeZsm+Ijb5QKST9ei/e9xOoygOKgkMspjayHMnmXdb3R4P7UhMHYzhRCPPZu2C0ON/jl7QSSGKB+zvhG3cDpOYuyx3F0JUW1iI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.152.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxkyICkkORuekYrjGD+afn00bdEQW9OeN/UhMD+kl+J/QoYqbXSpaxmdTBmxVNiHaImNJBb9j9Nzq9ETVPFoV7raUnxBI+TkO3UCRkRAQmWFVFFyCvVBtw3+glHyxNHccHAl6ZbCC9rImN/xyOWx6DVZMvioTsIO1ARibZVdlG+hObVQiPhYuoKhnyO2kcLGqJjE6t7zdFVRDwN3+GSG6HpxcJ8SQeMSWiuh3i6h50nnb6O7RtK9Rw6qkrKLHYfK3qEZWiq98vRLkLXrt+VxoRrkPGcP8rYA7zwPSsCGy8uXUIrzbytBtuSfUompR0BBicGPQFFrT6gjsOmAzYeH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rWTX/v6zFBIQi9rZzmPdNIsK+N54oiE02xHiYIJvxk=;
 b=WeORH/AQOceRBvaqSySLIaRuJPrFx6v9z12zeot4/annvTiltWsRc1jl4CeL12+pNRV/BPozgDz/e/NlTgZzkWJAhn1JMoQiI2B+cnG8vqr9kfJ407G0yXFjw4m1YxDB8zxVTcYTyrKIKNVQ9rmhQqkstpiHGcO0nAOvnF4OEi6Ap1/Q+p4oCpOPWTAfZuGx3ozCDUTdiYCxuZyic6DU4ZIVRdcSKjkUPgx2x0D7mxAAFo26JkYhFLd55ED7AhRr7Jn465xEdRrso/+N4EnM58F4ZBO4GpY14GIW6Du6hI5zZx03K1Gwo/dQlLMktcvMO50Bp2nRmGnjpXH1CX+Clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 SY8P282MB5022.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.15; Sun, 15 Feb 2026 07:06:32 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 07:06:32 +0000
Date: Sun, 15 Feb 2026 07:06:18 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-nfs@vger.kernel.org
Cc: rudi@heitbaum.com
Subject: [PATCH 2/2] nfs-utils: conffile: fix discards const from pointer
 target
Message-ID: <aZFwasmAQKAa7nCc@1eac07209f0d>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEVP282CA0074.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:202::16) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|SY8P282MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 3149fb08-02d8-433c-6eec-08de6c60bfa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyJM2k0wjVvHMV9hij0ceq4zpWh4lp/BNgujL38D61mBEJzmTu4kmnjUx6js?=
 =?us-ascii?Q?rqwsbCpLlgaS2tW2YezH4LXDgjuXCXND+6EQAqh0avqlIkiiu6ED6QiYDRw6?=
 =?us-ascii?Q?HMW6maaBFse7moZN1ZpLUAZ8/C0nDI67ggNd/d2GeQ58l+cKWKfAy9k44MNc?=
 =?us-ascii?Q?JkYI4uh1ZeQWlN7C/3AMbnVd1fIJOnq1yL2iIMFU9sdgVYT2Y8NYUsilVO6+?=
 =?us-ascii?Q?8ycuH/aGPsNThcgk8jCUVgeNWA5/dDU52sqDv+l5ckA1OTOIdyuj20Cckucy?=
 =?us-ascii?Q?jYHq6dJeFofySpHBHU0efSSUhH46vq2yct665hcEn+K9XVtst/MEqSBbzYq6?=
 =?us-ascii?Q?ELYYdKqSU8HC0lKgHYWsYT5m1pMVobtnyhZAYYVbYNt5Fp8k4kPkFmvbxCab?=
 =?us-ascii?Q?YjIWCdBJGur25eYW35LwLpsP7ftYuRNme/S3K3loPnMBjFEeAM6ClenPCDf0?=
 =?us-ascii?Q?FVScNaIzWl+sEeWgzdxD7ebKSpPgNsm8KI6IiAnSmNiw7vw6W/qO9CQWQNll?=
 =?us-ascii?Q?junxcRt0pLc0as90Yi1YHjx4AyTxpTzL4rH+r0NaMBoCHleKntOShyNObcco?=
 =?us-ascii?Q?y7wWVJ4Htw5ICDStIJ24W+tM8UpRhb1Yg6GwAQthKNEcUHVA/bDGISEeAjXa?=
 =?us-ascii?Q?79eYQ2YSwaDL7qLY3ZL/6l2VSNT1cGDZEcAQj7mbMeb+8WIB9yEz8X9MBeMb?=
 =?us-ascii?Q?BSEgB1HWOjEua3JnOtcNOMqEpMCRcdouYJ0FSYyhQeOTXNClfEG1lBM6gHaU?=
 =?us-ascii?Q?5qZU+Jt+J7hdy3xSIhkWn/ZVEVyP9rzXXcX9XpwGCSx5B17dMwjFoyHZsJjE?=
 =?us-ascii?Q?8oxaqgR1feOVAnbWp7phwN97tE/piUhIEK7dJdzialpx5z6U39Ef4dxHG6k0?=
 =?us-ascii?Q?rX15qvfgeTDA2jHymeZXEdKi8xcxvW5+QZDE826hI8ncvv85rI96ullaC/oq?=
 =?us-ascii?Q?P16I25cMJ6vH/mwV8+1uVLZpRKB4LuRmOiB/Lz0dXUIgN6We5d049RVgwmE4?=
 =?us-ascii?Q?TWVPvmhoWjiCsZRnV20+jCrDUWvaKu8NRrDLgoZRDj5Q9CkT8mfyBq8K438S?=
 =?us-ascii?Q?OlVlL8DZSm4+CK9v6J+na6C4g9Nu5Xm7OIg+/AgXHUO7O4gfjnbh5xnr185N?=
 =?us-ascii?Q?/awYbWchj9aSwmXEW3oFapHkBwaA6vMGFv/o7+mhUwFGDWEa8AYPQUXZCZQ9?=
 =?us-ascii?Q?6o1aHUx+v7r60dfa5DSORbBm7vURE1m7QWsn/cbnzwgjpMBNfh5rUzd1Nkpc?=
 =?us-ascii?Q?Pn/EVWbC/Lm0i5FmBdnB0q6isSH810DgrCrpf65xsOo4Kc4SJrxYuPmpVVxG?=
 =?us-ascii?Q?mBPIdHiAz0sZaGLdxaNsUKw1SokIM/p1OrHG9DgLLXGbBHFsdMnQiVO3x6mq?=
 =?us-ascii?Q?ELeEulthI++0xPH7RAZEP+QyFDPNdtTM6W/JTI21ftc/UdiyVhjBNn4OgsFy?=
 =?us-ascii?Q?5etgF0XJkOJHbf3uTBw+KrC7NA00MetdV/rnh7dx79gm2zb4FU8Ibq9c96Tk?=
 =?us-ascii?Q?CIcKo4hvfM1FGcJJbpCMKwvexo439hUH7i5xS7QrJl8Q0sWZgXmQ+Sv5v1lE?=
 =?us-ascii?Q?MkVISi6Ib3BjgruYPGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1vpfmqjWY6Ix/LKwZvD8D4PnAa7TVlIMawZxqVYhFPs8f9BF9UICsBptyPJ?=
 =?us-ascii?Q?nKnMNIacIDd3rsU0X22Mac6UzyBx1ZCyszMSbd63C30wHuKFyX6DOCLBwaxr?=
 =?us-ascii?Q?6ia5jOBkxHLmT211Mo2jQvj3BZtpSNudt38WHFlJBeQpome0Glsa2HDp3Wts?=
 =?us-ascii?Q?rG44Bu2SghsZKEIcZcaa9+y0C/Ave3y919PO1Iy4dbdZTTSyztEnzfcaDqdU?=
 =?us-ascii?Q?GEd9na5az/9Dx3YsBS6f5vTVI+7xZHZojwwAkBMvFfbwWErgKyGih7uqlczi?=
 =?us-ascii?Q?drBtk7SO3XMWNkRIFzw+75n/mZ5jAuFJRz7i6ns8K/c8dZalDU6WqYZMykR0?=
 =?us-ascii?Q?9462prfAg6i0Nbi12GXKCnvsQ0S46VcPSwyXXVvVJP32rbneSWj3hrUFU6td?=
 =?us-ascii?Q?90n/ndymnCiD57bhm4pJuweCARFPZcPAuEzvyxHojsQlPiF1YdrXFxjnBKli?=
 =?us-ascii?Q?tlP3BrT191yYpyXASgkC04usbDQjzHWnC/5N0qusRz4D1/4cV1j8wMPDhY5A?=
 =?us-ascii?Q?sgFZsmZj9Se/bOmhueCqTCKb/C6cvdJyz9A37mBGfpEEGesSbvSsGvNxU40N?=
 =?us-ascii?Q?MvV8JdHWfOn2/NnL+bHhKOYHySIWGF3j8kwpnebHJ+v91M60cZ9yz9DI/rOq?=
 =?us-ascii?Q?E3x3ouJT/hAYX/leeMH7hfPMexk2Sv0PqRMMLJ516EME1IVn/ZKNqlOMaO9U?=
 =?us-ascii?Q?lhtgf1w20Kn7QZwi7mGXTv/hegEbLo1hfGiyzGx/1zZ1FxxmyRPp4HcxeGT/?=
 =?us-ascii?Q?9qBUcY8d4AN/3lhB303FUqEclS0W2Mh/VtkfKt4yJZ4u01zW0ITcEcmXk+bQ?=
 =?us-ascii?Q?JPVTsr65HHOqx9C/pB3hikKlB/87KBQbhYDAib+W9ySq0/xO7yaaXtPXg92F?=
 =?us-ascii?Q?dOK+irXNa/u8Q1wFO3Dyz1BatZwI0+affAJkl5n2yiI4RpsEKRWLXe9cH1d4?=
 =?us-ascii?Q?wMSa5BVF7iWT7LwxOhguyi1xGnpCiNXYLkThSTLDSkWi+MKJ9VBNk4klwOgi?=
 =?us-ascii?Q?8bEPpzX3rfUG4kW0LNaGShta+VVYhc9o5/7IaSJZmAiV5hAD7h5MNt2lZYri?=
 =?us-ascii?Q?rbcxPVRN1mhZzrSS9uBHAjROUyHiqI4F2Fp6woSwR4gSojxnFjtAgAtw5+mv?=
 =?us-ascii?Q?pSty3ndyqiXANHJUx8nJ36NI4AlNHAuVYQ78E7bKHh35LK16HtkLKbXN9gAv?=
 =?us-ascii?Q?4MFwpP0rakQ2M5QNnNkdBn1ECNHBmY+RlA4M3ejm40iyuMXBd8YTiAVSp1X/?=
 =?us-ascii?Q?3zcSw2TrGXg+f/JeBFdddQ2hUq1sSwnybORIcjcWI+D0ITrsZtxtwJTuYjlo?=
 =?us-ascii?Q?7EmbRXSQLYt1Ru9zd1YZPcAZKrEk+THcv3A0UkqJb41qkyUn7BopEsKR5kQ2?=
 =?us-ascii?Q?Jmm1pB0nx97AiIGFEWrbFKE3DaAggxzpnUG22kBDaG5jHcV4D9uwP6D/fbCj?=
 =?us-ascii?Q?GxX83AK8tKPU/lvW50Ujip2Hx0yBN92Ak4dMskLzEzDBe9bZBynui62S40Rv?=
 =?us-ascii?Q?/l2XOP8OqpM76MkHNvhAYJI5MURomS9jaY2DICHIqTw6Dc+AuQDNM4jEhhjn?=
 =?us-ascii?Q?w3cGTopKGd4xEwuowLoQzKlIcSBLmKnu8TriWtHtKYc2UyiFaJ6nD9xwV7vr?=
 =?us-ascii?Q?nA0N0vz7+M7DTBaAkj9BoafEsc0KaEVI0WYENXrvwDzxusRM6ihJDBvfsmcu?=
 =?us-ascii?Q?2hnhjus0exEDz36EI7Y42KQVTPEEzDThCa+lzYaS1+UzeY2k?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3149fb08-02d8-433c-6eec-08de6c60bfa8
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 07:06:32.2741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoJ+G0b3xdwrgIOgpIAp1Qjjk8CyrQ8+vEAh3pm95WtfgcYZjVNHYqu1Ik7FrXOkPEj7gZCognyihJ+jcKe+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[heitbaum.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rudi@heitbaum.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18941-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1498A13E2EF
X-Rspamd-Action: no action

end is used as the return from strchr(line) which is a const char and
then again as the return from strchr(name) which is a char pointer to
the strdup(line). Declare a const char * pounter for use in the first
case, addressing the warning.

fixes:
    conffile.c: In function 'is_tag':
    conffile.c:1711:13: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     1711 |         end = strchr(line, '=');
          |             ^
    conffile.c: In function 'is_taggedcomment':
    conffile.c:1825:13: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     1825 |         end = strchr(line, ':');
          |             ^

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 support/nfs/conffile.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 137fac8d..8d242c2f 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -1704,12 +1704,13 @@ static bool
 is_tag(const char *line, const char *tagname)
 {
 	char *end;
+	const char *equal;
 	char *name;
 	bool found = false;
 
 	/* quick check, is this even an assignment line */
-	end = strchr(line, '=');
-	if (end == NULL)
+	equal = strchr(line, '=');
+	if (equal == NULL)
 		return false;
 
 	/* skip leading white space before tag name */
@@ -1807,6 +1808,7 @@ static bool
 is_taggedcomment(const char *line, const char *field)
 {
 	char *end;
+	const char *equal;
 	char *name;
 	bool found = false;
 
@@ -1822,8 +1824,8 @@ is_taggedcomment(const char *line, const char *field)
 	line++;
 
 	/* quick check, is this even a likely formatted line */
-	end = strchr(line, ':');
-	if (end == NULL)
+	equal = strchr(line, ':');
+	if (equal == NULL)
 		return false;
 
 	/* skip leading white space before field name */
-- 
2.51.0


