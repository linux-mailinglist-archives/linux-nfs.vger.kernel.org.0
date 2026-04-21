Return-Path: <linux-nfs+bounces-20978-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGpvFHxN52lW6QEAu9opvQ
	(envelope-from <linux-nfs+bounces-20978-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:12:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F4F4395B7
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8B8306B3B7
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62E3B3C0C;
	Tue, 21 Apr 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="kjmp8Jvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazon11022105.outbound.protection.outlook.com [40.107.40.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C43B2FF9;
	Tue, 21 Apr 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.40.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765828; cv=fail; b=jYby2ChNbqO7Z64EXff8IVrZjqbDKNeHZq6JteeLGpbtSipQgxKs8Wz0Hp2aX2dgaZCuI8JqTvSkvcyncH3cY8ikJMARPYmh6fbdTaepx0UYSnNtHQUWwWmCg8yAWPcIGXumeFjYoYdmax0HESruRr4hbpTrsgjg/YMiVE6eA9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765828; c=relaxed/simple;
	bh=Rgsmkwa46BtvzLjNz7OU2IEQtfWYRzKKkiSsS6oMELs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eyHR1HgWwaU/BEbj4nKUdVq1lKAzr/W7be4qY3lF7bCXQSggXzcL+Fjckr9Y6bcMZ8l8T4xjHj/EKwjT+CU32zJDv8bnJ9O9WZxDSRFQsJhsVTLTH0oIzZwGlJLkMwUHjChEkgrN5BrILmeaMbR5Co00eZMXkqe0k/cnLAH2Umo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=kjmp8Jvl reason="signature verification failed"; arc=fail smtp.client-ip=40.107.40.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOYUIirynE+wE6dFa2B6sKhGfIdntaQr+pWhSCGnWFssgLYlZVuNLpHX3d/P8A00Dveohnp+pl1/Qb843Rfv5kvmsTF0yiQYXdkal2LI4xE9j/V37flwcSnY36HnV6PlDp+t1rZ6Vny32r/3zn2N0Wh8mYoc2lHzZZWgmvGPFut+NL+B7sE28w4CbenKUtfReeX8OP2TxVC0J57GAx8XsAXMzcp8jwrWpHF4Ll7kT/Q8oTsByMuyWCATrLAUI+5P9JIJFnbF6FRjVDdMk3DCWxRbN2tM1bSu8ZyULpzLL3aBlsE7pjOs6Z4gDCHFRvqqNLV3VxlBk0FYxywfbzrT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RGGI4074a87aPkSnQfXUa8gWHaRbOzK3JMHfm3j278=;
 b=JHySsLz2c+rrK/N3JvCJ5aFG690Co8VK/HhluOxMdqW7TdzJL2ULoTmslQWaea4kKnAVM3kI+NgH/aZWpSiKqLNruYa/l6PES/SBI0Wk25yi1RXemjI8cfVDfjjWY3jZ1Yp2Pdx051a+MuXciM5DUeO4mcHuwY6UZHzPN/idMbHMapnLaj3TFe5PYVQGPIjOrpgGSSF7YZUxsTWJHbTcBFfGL89w7pz3i6VroJxzSKR2PmHTopSCn4GwnSAE+BxJKjiifI7rJmdn4DrVQxK3LuXbOZUjriiY1s/J3Hbmp2L3+z2I58XlRp1z6m49OFQ+9VwUy7RSfhypyCXpGV7IRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RGGI4074a87aPkSnQfXUa8gWHaRbOzK3JMHfm3j278=;
 b=kjmp8Jvlf6ipBkRiDY1sYcOuw8Vqf3PhWLfTwZbC7ZeROXoEbjG6jqwDakLDgy1EJ8wDFJcNeO86KN/4S9aYgqdHA28DproViVaYZwVvhm7qb16nqF8YySyErMHWPtkLtnIeksAip1oQAvNmzlZCQA3+lodNE9KdpcB74ecjvTdUq8CaVUphpMMNZQRGpni650ZNKVVybshzs4p8IfJJeKmL7mgMHsXUQL5/mlS4cio87RiVzBW5lVStzvQsvabEDFgVKj8Z69qQGJkcq1KPdRs3Hzj1kj1xGhKR37sdRCfCX85gYyh2hgFA1O6QsPPI8Pgg4IcrxbDw3bONTT9+qQ==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1529.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:03:42 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9846.017; Tue, 21 Apr 2026
 10:03:42 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Werner Kasselman <werner@verivus.ai>
Subject: [PATCH 1/2] pnfs/blocklayout: validate volume indices and limit
 recursion depth
Thread-Topic: [PATCH 1/2] pnfs/blocklayout: validate volume indices and limit
 recursion depth
Thread-Index: AQHc0XYiuLmD3qJpg0ifIwD9rIzO3Q==
Date: Tue, 21 Apr 2026 10:03:42 +0000
Message-ID: <20260421100338.1227152-2-werner@verivus.com>
References: <20260421100338.1227152-1-werner@verivus.com>
In-Reply-To: <20260421100338.1227152-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1529:EE_
x-ms-office365-filtering-correlation-id: a265329c-69fa-4255-78e8-08de9f8d44e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 x8pgr4aCCvrBdBoFgJSkLXcknmy19hupp1GWyfBBV45F7udACirE+uUJ2LTxH8JRwSs8xIyStMOqEHA8ofeoG1SxFo5QDqNVhieR2uSFXYm6CgHpGM3Fj6D7047aZKypgmwrUw6wN0VvF7ikU8loGindmUso3BrgAsogOgrnIJYjpVivce5rDI9L41mf28INqxfUgRQxhxZpuQVsLQ6CqeP306fV/DPe9ng9KNX/ClRpql2b9FgAi+OAI8+aS84EE5FtiGaZ5ob+xqhbRamMiCZrW/gNcYLBkfbjLf5xO3sq1BUFMj+2WmqRw1Wcg7kVSJdTePq5X91JRUquG0Mb5OwVaIDruQObrgzKMIkoKXjp9PuXy7n/3ZyUyEUIVciqup1gssYbsby5A/rSKYByb1e4GbjiwGSE+QxiyxKzTr/oBlmjJwmMwSZwzlYeDr6ma0sW7Tri3jSDz0pX8eB3eHm9GVKpUJ7Hz7tqk+mmklocd9xBCuo2zL2b1PGnARrZYPer2LlsiudTeBzjT7mV5Gj+e+UBFhE7yiQN5lvIQkWXJsDObRy8q4V/BUQPlUkso2Nwh5x+jz1HktOdnU6mqnxJX22A6mX10H9au6gV2GecpzkEZuXYkXQTmEcd34/Ks4FI9OiKDgoP+0oH37hHhUCImYm733yXljoU5NXSt6nGbC2WOtxWzJIoBwtUM112vM3sGvAriT/nW33zCI0Bdh13s4A7squI+CPmh/W7845s+KQoQ/tEbyuvPeQsL51ehW8c+afkSE1n98kt/LEQVBY0+8oK7y719HFUGJ8C2bo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Z4rmUmemN58XBueFvgcRxcZ1RpS6vNPJGLig6LlgQJb1r17uYXsByi2atb?=
 =?iso-8859-1?Q?SBkjJsTnFmOfiBm+n6tp23N1vwM/RlK1qNkTjW+hP+k1+2gn4cwNKXqiD9?=
 =?iso-8859-1?Q?atF8iy/a0wSV3P4LcCLbs4338J9d03Uvq8GtFSngJlhfQhG6LmUzNRqSVv?=
 =?iso-8859-1?Q?J4Bnj8M9sUX26pe9N6I20KR0qYUTaJ8+vLAzdNMAKXfbeVBBV12HoCIONp?=
 =?iso-8859-1?Q?7SuVVmLIVKkLDz1tVvDcIFcp/awlNeJgsNQEpfu09XmdGbS4bIh/tvxc7t?=
 =?iso-8859-1?Q?JyDQpbK4KyPeCMDVG/He2NB+lXogGLn3XDLShFRd2g2MuAC463fHF9ljV4?=
 =?iso-8859-1?Q?fz71gRj2UWelVUMhBq3H2g/seTSZjUzuzrIt6oKt9mKVimuqI79h3GeLvA?=
 =?iso-8859-1?Q?WtOxO3kOTyIg5Ed1gHbpIRHyB+Y+EXVa6zVgr59/h6uSSlF2Km46kCNwgV?=
 =?iso-8859-1?Q?P727O5LWHYfIs/1RqFE//msP7CX6ZdwBmgBQatNkmKisMGK/DydhZEQP01?=
 =?iso-8859-1?Q?XDn/WAzBqfvDlSJb+FjB96ynD+rfiPdnI5v5KFAN17X7D8gG2pj6gOlcfF?=
 =?iso-8859-1?Q?5IJBpUEfd4oSrZ5TrTX+XMvO0YpQjqeSt21YixF0Jo07gfpWu7snyrPsbO?=
 =?iso-8859-1?Q?fabKlEDa3eMK3PE+lbEoVeIDuAGdMx3dCs8p4V/Y42eqwSDK3EYET6vDJI?=
 =?iso-8859-1?Q?RUhqNaTVvMjzHsnItxZiLeR1rZsdUaoiJesJsNmlGJFGcHxWBOpvmci+qf?=
 =?iso-8859-1?Q?kejs7j0kAZgz6HhS5XoofzKJvo9eoMpLTbDEbFmXkF6oflgOeA2xMLaMcs?=
 =?iso-8859-1?Q?0L63dgghz0mLVJd7mZ6FBO0Ae6RN4qvP7C4SEUCHzKYUgTCrfnptGCvmYB?=
 =?iso-8859-1?Q?t5fp79/aKxJUwTG12yXqy+sHakEdt9GxAXQF5JMdPpPuLVXIUNEl+bmWG9?=
 =?iso-8859-1?Q?v5oemT8M1Clf/vmHWlmJxFVHEvoYWi99UqMxCTTcHPiyvC+qNDCvTzF0PT?=
 =?iso-8859-1?Q?ZFqKaXpmtiiq2l1pD0k4tR0Yw8ZT8kA0N35Ok9yfZqRDUn2Xnd2nTxNj66?=
 =?iso-8859-1?Q?UVdyjvHKuX7lJFof2ahQsTT7uceuEyD0ztjrPWyycddbDXwqhSIfqyLGhU?=
 =?iso-8859-1?Q?9usFyKe98G7Qsn+SunAxraHS8BSjpeZ/yRvxGbt+zJokcvZXm6mmr7d8UM?=
 =?iso-8859-1?Q?QPOTuG2q/lNb8ODOBmZmlxcrf7WlWOELYme+hG1hcQpzkcFF8f7Yf3GHYB?=
 =?iso-8859-1?Q?edAxYUfyrZMMETZllys0j8LJTp1yK3jOb4m7MkNxZ1AivjrfoRWUuMRNB3?=
 =?iso-8859-1?Q?ZGvyiwQ8z25DdGTOO3PEFcQVigC82wkJB0s24LcJ65zY/iU7DkzVvm+3c7?=
 =?iso-8859-1?Q?cWlJgZCGZpdSSDSgb/mAiyMmJDgVS9nmLCcd5hOj/wUpASAvt8f3ykJ8SR?=
 =?iso-8859-1?Q?YsUwV7bVcvkVpjq/Z24ZB7eDVGPE6HAPe3saMdrpFJ/BBd+RaBROBV7o3F?=
 =?iso-8859-1?Q?Jg6NacS6Nx2nNX41LDx7Hko5dj7g+UrfYecWIAd+4cFZWFYrmTnZ+bNRY2?=
 =?iso-8859-1?Q?e2LT4yjWvUPETpITZFMQp7WJzt0S0Mhs74cyXBQRqApSP+y1bF8IIPCHgH?=
 =?iso-8859-1?Q?G170VaE703wUJ1g8L9ADKk+8D1/nZqzMa4LcoRLJHyKW2Sjd2pZkKGKjWz?=
 =?iso-8859-1?Q?tuAtn4OT8X/eernXP4YMtSghyj7YJ45LMShN2dtq1wlGd/ZfcOCg3xwI0o?=
 =?iso-8859-1?Q?Ij4ubBG11xZRuvqaZ7c1Nf4jAVAT0ri4HKuTxYnYLXNjR8IpNvmh5LVO7t?=
 =?iso-8859-1?Q?vNWUB0CiOQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a265329c-69fa-4255-78e8-08de9f8d44e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 10:03:42.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/T4QOeUrLF34Xa2PBHx2Kej9HV17/PdMSbV2fqfcfPQ7UVqV1HDe8Rj5mo3lBDjYKw76ftq3OqpX76EbT5BMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1529
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20978-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[verivus.ai:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verivus.com:mid,verivus.com:email]
X-Rspamd-Queue-Id: 86F4F4395B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bl_parse_deviceid() trusts server-supplied volume indices from XDR=0A=
without bounds-checking and recurses with no depth limit.  A malicious=0A=
server can trigger an OOB heap read or overflow the kernel stack via=0A=
crafted GETDEVICEINFO responses.=0A=
=0A=
Validate that every child volume index falls within the allocated=0A=
volumes array, reject nr_volumes =3D=3D 0 before computing the entry-point=
=0A=
index, and cap recursion at PNFS_BLOCK_MAX_DEPTH (16).=0A=
=0A=
Found by static analysis (sqry).=0A=
=0A=
Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing=
")=0A=
Cc: stable@vger.kernel.org # 3.17+=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 fs/nfs/blocklayout/blocklayout.h |  1 +=0A=
 fs/nfs/blocklayout/dev.c         | 54 +++++++++++++++++++++++---------=0A=
 2 files changed, 41 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklay=
out.h=0A=
index 6da40ca19570..ec8917cc335d 100644=0A=
--- a/fs/nfs/blocklayout/blocklayout.h=0A=
+++ b/fs/nfs/blocklayout/blocklayout.h=0A=
@@ -48,6 +48,7 @@ struct pnfs_block_dev;=0A=
 =0A=
 #define PNFS_BLOCK_MAX_UUIDS	4=0A=
 #define PNFS_BLOCK_MAX_DEVICES	64=0A=
+#define PNFS_BLOCK_MAX_DEPTH	16=0A=
 =0A=
 /*=0A=
  * Random upper cap for the uuid length to avoid unbounded allocation.=0A=
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c=0A=
index cc6327d97a91..d9b1af863535 100644=0A=
--- a/fs/nfs/blocklayout/dev.c=0A=
+++ b/fs/nfs/blocklayout/dev.c=0A=
@@ -287,7 +287,8 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u=
64 offset,=0A=
 =0A=
 static int=0A=
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
-		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask);=0A=
+		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
+		int depth, gfp_t gfp_mask);=0A=
 =0A=
 =0A=
 static int=0A=
@@ -439,12 +440,14 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 =0A=
 static int=0A=
 bl_parse_slice(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
-		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)=0A=
+		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
+		int depth, gfp_t gfp_mask)=0A=
 {=0A=
 	struct pnfs_block_volume *v =3D &volumes[idx];=0A=
 	int ret;=0A=
 =0A=
-	ret =3D bl_parse_deviceid(server, d, volumes, v->slice.volume, gfp_mask);=
=0A=
+	ret =3D bl_parse_deviceid(server, d, volumes, nr_volumes,=0A=
+				v->slice.volume, depth + 1, gfp_mask);=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
@@ -455,7 +458,8 @@ bl_parse_slice(struct nfs_server *server, struct pnfs_b=
lock_dev *d,=0A=
 =0A=
 static int=0A=
 bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
-		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)=0A=
+		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
+		int depth, gfp_t gfp_mask)=0A=
 {=0A=
 	struct pnfs_block_volume *v =3D &volumes[idx];=0A=
 	u64 len =3D 0;=0A=
@@ -467,8 +471,9 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 		return -ENOMEM;=0A=
 =0A=
 	for (i =3D 0; i < v->concat.volumes_count; i++) {=0A=
-		ret =3D bl_parse_deviceid(server, &d->children[i],=0A=
-				volumes, v->concat.volumes[i], gfp_mask);=0A=
+		ret =3D bl_parse_deviceid(server, &d->children[i], volumes,=0A=
+				nr_volumes, v->concat.volumes[i],=0A=
+				depth + 1, gfp_mask);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 =0A=
@@ -484,7 +489,8 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 =0A=
 static int=0A=
 bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
-		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)=0A=
+		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
+		int depth, gfp_t gfp_mask)=0A=
 {=0A=
 	struct pnfs_block_volume *v =3D &volumes[idx];=0A=
 	u64 len =3D 0;=0A=
@@ -496,8 +502,9 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_=
block_dev *d,=0A=
 		return -ENOMEM;=0A=
 =0A=
 	for (i =3D 0; i < v->stripe.volumes_count; i++) {=0A=
-		ret =3D bl_parse_deviceid(server, &d->children[i],=0A=
-				volumes, v->stripe.volumes[i], gfp_mask);=0A=
+		ret =3D bl_parse_deviceid(server, &d->children[i], volumes,=0A=
+				nr_volumes, v->stripe.volumes[i],=0A=
+				depth + 1, gfp_mask);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 =0A=
@@ -513,19 +520,34 @@ bl_parse_stripe(struct nfs_server *server, struct pnf=
s_block_dev *d,=0A=
 =0A=
 static int=0A=
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,=0A=
-		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)=0A=
+		struct pnfs_block_volume *volumes, int nr_volumes, int idx,=0A=
+		int depth, gfp_t gfp_mask)=0A=
 {=0A=
+	if (idx < 0 || idx >=3D nr_volumes) {=0A=
+		dprintk("volume index %d out of range (0..%d)\n",=0A=
+			idx, nr_volumes - 1);=0A=
+		return -EIO;=0A=
+	}=0A=
+=0A=
+	if (depth >=3D PNFS_BLOCK_MAX_DEPTH) {=0A=
+		dprintk("volume nesting too deep (%d)\n", depth);=0A=
+		return -EIO;=0A=
+	}=0A=
+=0A=
 	d->type =3D volumes[idx].type;=0A=
 =0A=
 	switch (d->type) {=0A=
 	case PNFS_BLOCK_VOLUME_SIMPLE:=0A=
 		return bl_parse_simple(server, d, volumes, idx, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_SLICE:=0A=
-		return bl_parse_slice(server, d, volumes, idx, gfp_mask);=0A=
+		return bl_parse_slice(server, d, volumes, nr_volumes,=0A=
+				idx, depth, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_CONCAT:=0A=
-		return bl_parse_concat(server, d, volumes, idx, gfp_mask);=0A=
+		return bl_parse_concat(server, d, volumes, nr_volumes,=0A=
+				idx, depth, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_STRIPE:=0A=
-		return bl_parse_stripe(server, d, volumes, idx, gfp_mask);=0A=
+		return bl_parse_stripe(server, d, volumes, nr_volumes,=0A=
+				idx, depth, gfp_mask);=0A=
 	case PNFS_BLOCK_VOLUME_SCSI:=0A=
 		return bl_parse_scsi(server, d, volumes, idx, gfp_mask);=0A=
 	default:=0A=
@@ -559,6 +581,9 @@ bl_alloc_deviceid_node(struct nfs_server *server, struc=
t pnfs_device *pdev,=0A=
 		goto out_free_scratch;=0A=
 	nr_volumes =3D be32_to_cpup(p++);=0A=
 =0A=
+	if (nr_volumes <=3D 0)=0A=
+		goto out_free_scratch;=0A=
+=0A=
 	volumes =3D kzalloc_objs(struct pnfs_block_volume, nr_volumes, gfp_mask);=
=0A=
 	if (!volumes)=0A=
 		goto out_free_scratch;=0A=
@@ -573,7 +598,8 @@ bl_alloc_deviceid_node(struct nfs_server *server, struc=
t pnfs_device *pdev,=0A=
 	if (!top)=0A=
 		goto out_free_volumes;=0A=
 =0A=
-	ret =3D bl_parse_deviceid(server, top, volumes, nr_volumes - 1, gfp_mask)=
;=0A=
+	ret =3D bl_parse_deviceid(server, top, volumes, nr_volumes,=0A=
+				nr_volumes - 1, 0, gfp_mask);=0A=
 =0A=
 	node =3D &top->node;=0A=
 	nfs4_init_deviceid_node(node, server, &pdev->dev_id);=0A=
-- =0A=
2.43.0=0A=
=0A=

