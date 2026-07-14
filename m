Return-Path: <linux-nfs+bounces-23319-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FP/sHPCGVmr38AAAu9opvQ
	(envelope-from <linux-nfs+bounces-23319-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 20:58:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FF758017
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 20:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=prodromou.com header.s=selector1 header.b=jgi+SszH;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23319-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23319-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=prodromou.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB8A300F16D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2026 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07275377A8E;
	Tue, 14 Jul 2026 18:58:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022076.outbound.protection.outlook.com [52.101.43.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0B377AB4
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jul 2026 18:58:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055532; cv=fail; b=IFamMxW104xEWGaXNUK52lBCZtJxEiSkBIzG+d3MTXalsxIYVt9+J5PCmu1UFoa+rm9VUsJN9AaFMhbocDxIf9i+g2UXUbLqIF/YdDFB0wIVqZljbgqvKzksWARS+uDEiBdurz6fBxrQvC5/pN3uC/aW5E6NrZR8TULRnxFjFlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055532; c=relaxed/simple;
	bh=f26yXErMDLCrCJUb4cyK+dKHiLupJs1V6oHsGXrscIM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nohdENHfPH+dFB6MrtOSCixLlnDscfjnW1b00WTz17kpdJ5w+ElDnAVxW3RDpBXRJ8IEdLdh4EPfMQzVoNoXkHzVTTfFcQq7Ql0HgtoZA55oPDiZ+1tosN4SPUQUID0W7MRnKG+Ycv0j31NrfVJMYoWNvRXr6FDvFKKcJ95OJVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prodromou.com; spf=pass smtp.mailfrom=prodromou.com; dkim=pass (2048-bit key) header.d=prodromou.com header.i=@prodromou.com header.b=jgi+SszH; arc=fail smtp.client-ip=52.101.43.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsNuUMBQMk0FQB4XUgOjliWeLjxOl73fMnVd8i/KFl88gVTJ8S8UsqCgK2ZuMTrPx0FHRxY8jVqlyvCC7on0aMS+DvNvg5SkMygOonOYjMbxpkS6mGNk/Oh1bFlq4DC3IG4VN7gsSLsPaEgEw3Rdd4GqajNP75/Jq3EFqr96iyIP7S1ubkg8eZ3c6AgfSoyZCRqYgraKQ6ARPD1K6zQkIWUQrmo3ks39/a5Gu+SXr4yC8BhxkYd6nipenjsMXhCzp84gQ6T8zO8J2UL9mLDjsDpjXMamZ7T4IrTEXDU6Ae8QhLf+Vpb7/WxKYIRqiQ2Sd2fslS9FoOVPe0zNd8i6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR94Ca51ZGCUdYJQIR8zDOBtt+x3tSqx68F1ECItsAU=;
 b=iyZ5IyDUFFRyya/pgiC+Qkw18QdPdA+6h1ACFaGrCYgiccMjRuU5d542x2/Oj890/WS7XPZm6OD6fUGgJ7v6doc2C5iRoOso6kOLG8T9iic4tFxfa/P/tMNuaVBqG1F8B+b3yo4KdFn1OrdHZGi4n8CbPctPKKPaGo0AVK08bzvyDg6mT6tTRbpUq2f23TrlMo2OQ8Gxy/AY+6uWzKv0Emq6G9PJbV+8/Hgw1Obi3X3T8wKn9O7/thzo6a/eS3O2K5g1RG7ZxFBDuTSAstUwuEd6YZaRdb2XUpctkSSq3bITHP2j0u/41Kynk7DlVulWxur5px5QKaVCAB1tGulxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodromou.com; dmarc=pass action=none
 header.from=prodromou.com; dkim=pass header.d=prodromou.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prodromou.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR94Ca51ZGCUdYJQIR8zDOBtt+x3tSqx68F1ECItsAU=;
 b=jgi+SszHoSeFeYY5zpmRJmu20taY0y67gX7/Z+MTdA9TTIKgfoB9lMKRZ1/PbaLNTFuVDcBD4nh0C319tfJaw8Atc58hZH5vufnfHE+qDING1fR1XIGBF42QpdRmdCcBwAJ/Tb1AdcEM+D6SeozYWU8LcypsS8thfjzB/Qv4WUxpwwEZ3VArI2w+FTw4u39FTQbB+/eyJIEGEJHqA2C9oukYmNwMooCp9bJ4KIOJOlCWua4AjrR6NQ5wqd9/mbCeUAftMTeimjNzVe+Lpzq09EAOscbjP4Ujrr653BVwxK9J52cFravgkLPz5M/DJ6C5M0iVk3Q2zDmMJpq2L/VIUA==
Received: from SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:3c6::20)
 by LV8P220MB1709.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 18:58:47 +0000
Received: from SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM
 ([fe80::c968:514:7fbf:1ebc]) by SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM
 ([fe80::c968:514:7fbf:1ebc%7]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 18:58:46 +0000
From: Nate Prodromou <nate@prodromou.com>
To: "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
	"anna@kernel.org" <anna@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: [PATCH] NFS: fix delegation_hash_table leak when
 nfs4_server_common_setup() fails
Thread-Topic: [PATCH] NFS: fix delegation_hash_table leak when
 nfs4_server_common_setup() fails
Thread-Index: AQHdE8LMVWdv46JJY0SWhrZfnQHoew==
Date: Tue, 14 Jul 2026 18:58:46 +0000
Message-ID:
 <SA1P220MB14925066FEE37CAC1C083DEBC8F92@SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P220MB1492:EE_|LV8P220MB1709:EE_
x-ms-office365-filtering-correlation-id: c583439d-4c5b-4299-25c7-08dee1d9ef1c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|55112099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 /LldksPYai0orDZBjl4K8XUITlvX/dG9XQVk6bPuugh5gW/VdMQ/nhcTCuQhdDAYTVb9FPdayAnO3hg96XjGpseXx63Tmo4WvWZJnwgD0/hth+5a7P7gOvsYbIi5LXGpibro8rXWf1wH2dCw8b8f9vnmSBXIGIJXDUnf7GrlYGDzW7wLjifFuTbQ4HcfS08oEtrPOT9xtG1GMLlQtYOwmO33aFcoQJLENZGtn1uiGAaaCh/c6qan/D0S7bYzuXTVjjXdocYhgZt7+rC88vnv39CsqJdp23oTL10Kxr7AGlVUa8qgpm+HPU7XG6JjM/soWGzR942yq1qYjqaVk3emoXm698DIUJfJc44fu345xqeJmPbDTx7bP6WskuJe1iFiHDx/VIMbf1EYBsLxbqVZDfFXT4h5UvXpaIMeGYFF0Lb9zKYFBD1bbRkqjHlqVg5XmJscQLAC5HwmR8Ai+X5aBWfemwl3+rhYM1T+Q9p/9g9UW+JmVrPvX3CUt3QVv7tZpjLu7XUpH2EKqTllzdAd9xr4VpkKtPD2au370txwJu+tYPjqkJjqGdu7cJwLg4HnOreUFltGZsdnFlVKYpZzbezUr8bAmz7UI+txBSnu76oOAzZTSyeJEsv47iSUOHGKA0cOjf6r4sKohL+e2Sp1g3XdDJpjaMsrNQBJS12MfJkDXD9o0BpPrjVVDylgiY/gHEvojcgoR2oTcyLZeqET9Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(55112099003)(18002099003)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7W0FevSY8kRPmIJMDiOkg2g+MZYYrgYgJOyNSliLvM9cZGm8u3WtOiU+FWLU?=
 =?us-ascii?Q?MlZqV2RrYvU4U/ljvJtE7Zkz3rQ+SDFrokUj7YKBoOFm5Jj/bu5XE5ywRiWo?=
 =?us-ascii?Q?s4wJ19DZpqbeEMfUHn91Vu73USICBRsjCNzNSCVSkxH0S+XjUkUSGD4CHLGA?=
 =?us-ascii?Q?2hd7kjvRlFp1v06W9KkUdkSHl8JgZ//xAoKe+pi0Q0v0dsnrXIPzC5myyHgd?=
 =?us-ascii?Q?QQZqW1+9eUFv3rJ1zybDFpd+h+Hlj9Banu2P9GE3Cyn4RLdU1lt1Av2pz0eH?=
 =?us-ascii?Q?VwC0fuZtPfe9Yl4hCxh13KiT7tuGGsvV2ovNgvDDVld2khV/AeFv69xDTQB4?=
 =?us-ascii?Q?Esn5VCWoaYmUNA05h/NfmeIfi8bJQ7nv05LOpoV5KY1+1+w0oWBUbcwtxlSA?=
 =?us-ascii?Q?zq3mtuCcRim68YWIqChULcIfA1CNd1HzfszltSsrBJ/NrJNhzpOzTZvX2D1k?=
 =?us-ascii?Q?BfOIOKLiNV3YKR8tccU0FzTnahWUbxQKP7jR+nkpPK99Gku8+1t0A6dm33XF?=
 =?us-ascii?Q?lfB6/exjSTTa6H2JXwHcP1rD9+53ys6eSZf08tYbw3AemEwGOxvyoJ07XmW6?=
 =?us-ascii?Q?HSK1HwNcyLmQNdoHy8lXfIuj3WIUwCoqNnafvmX5mCog0QrypsW6wY2OspLm?=
 =?us-ascii?Q?hUzvNEN8QED/UhSktt+DKx+zWi7CvhssOqMOrTjif2Rj9UrPWhzSvxy8nWpp?=
 =?us-ascii?Q?epX5eguWigeWsq0ru+Vn8za1KxjWaGIwc4AceJEk6oJjDm8pvRPYbC7tCJCp?=
 =?us-ascii?Q?zgrMqIiCdN4/uv2TvjpBPLLEGSQ70S+Zm/wBOXmuzgJkIQkPs0gykVu7hfa5?=
 =?us-ascii?Q?YTk3NpraSc43GKhKDkIg4L+EUxWMhZLOpf6+MjGhjHgKSArzsC2DLe1UTW2F?=
 =?us-ascii?Q?cWzhCWhuoLmo3Jc3tVfgewVS/abmDIOECN5Ketr5NVmtvIUiBfgddxN4F3QK?=
 =?us-ascii?Q?YatSIRLCbIfQDDL3Tk1gQPEYlOcZL7BT3XxIA39Kc8Rasl/VrnkxztJFU8GV?=
 =?us-ascii?Q?leIG7MOTEB1oicjpPTJo6EW+vGig1GZnX7Xnrr3Zzbvv87R0+gY+lGfiRH3F?=
 =?us-ascii?Q?kVkCKV64jlSSW9ox6GE7C2m08SkXOX+pYZcQ97fOAuhMipUHsN1v1mumxyV0?=
 =?us-ascii?Q?HVMx3lDdLpinupjUfxAW7blNarkCcpyn2nKMsgiwCys8wFNKOGqSAN3QGfFd?=
 =?us-ascii?Q?rrFXUrJfuK+EyU9eku+doL8687qlQWKZJuDrIu1ZUhg2tdqpqLxn10J2SZ8I?=
 =?us-ascii?Q?6gr66eZmS5LoHNqoqs70TbvvQgc/vvGCJgtdvUd6ghPDgwWUjbR4l9q/AUx+?=
 =?us-ascii?Q?+MCvuxh6quS2K3GIy+KvOU7pgf3dv1df36axBvBGeZY3HdBc+OF1nhslZcu/?=
 =?us-ascii?Q?8y5XJ3FzfDYwG22NFo5hVHuM80cE3Qt7A5ver8flhu83YP+J/kswKzDkAYMa?=
 =?us-ascii?Q?u48Tp8UpA9OpBC3evDi3FmoTCB9YZLUr0FzdCRVOzVJtXZ2tFlIUOjX8kdhO?=
 =?us-ascii?Q?BellYxRG7DtayPWjZ8Hepix+YfmWtmKRP8tESS/Hz2ZLNUnvziUdBqFbENVt?=
 =?us-ascii?Q?Dd59HR/6XjxGRDX8HWaW5vtmGv+qhbt0lLuGpnnyt7k1Lt3ATtargzKt5Jhb?=
 =?us-ascii?Q?XK49A6cOX1Hpq0X0jUibSIbaO/c74tSQYDTlBuMY/8whSMBvagn35QdyevTy?=
 =?us-ascii?Q?mcAw1steEk3jSTEbG/iI+9uYPO483dnmmieGQOPRyE1Z8i9H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: prodromou.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c583439d-4c5b-4299-25c7-08dee1d9ef1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 18:58:46.8751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b1638132-4a5e-4b5d-9640-f0738f99b12e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+KHYqahO9r6AtooUPhmBSMdpmgOA9rWhp8ZjEW+PejjgdYnwgfz5smTN8WEqoPkB4gxLIUSVU6FLkl7O09+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8P220MB1709
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[prodromou.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[prodromou.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trond.myklebust@hammerspace.com,m:anna@kernel.org,m:hch@lst.de,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nate@prodromou.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23319-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nate@prodromou.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[prodromou.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[prodromou.com:from_mime,prodromou.com:email,prodromou.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA7FF758017

nfs4_server_common_setup() allocates server->delegation_hash_table=0A=
first, but server->destroy - the only path that frees the table via=0A=
nfs4_destroy_server() - is not assigned until the very end of the=0A=
function. If any intermediate step fails (the is_ds_only_client()=0A=
check, nfs4_init_session(), nfs4_get_rootfh(), or nfs_probe_server()),=0A=
the function returns with server->destroy still NULL, so the caller's=0A=
nfs_free_server() skips the destroy callback and the hash table is=0A=
leaked (4 KiB per attempt with the default delegation watermark).=0A=
=0A=
This is trivially reachable from userspace: every failed NFSv4 mount=0A=
leaks one allocation. A client that persistently retries a mount that=0A=
cannot succeed leaks kernel memory without bound. Observed in=0A=
production where a Longhorn backup poller retried mount.nfs4 against=0A=
an NFSv3-only server roughly 10 times per second, leaking ~3.4 GiB of=0A=
unreclaimable slab (kmalloc-rnd-13-4k) per day; the node accumulated=0A=
12 GiB of leaked slab before the source was identified via the=0A=
kmem:kmalloc tracepoint (call_site=3Dnfs4_delegation_hash_alloc).=0A=
=0A=
Reproducer:=0A=
=0A=
  # server exports NFSv3 only (or export path absent for v4)=0A=
  while :; do mount -t nfs4 <server>:/missing /mnt; done=0A=
  # watch SUnreclaim in /proc/meminfo grow 4 KiB per iteration=0A=
=0A=
Free the table on the error paths between the allocation and the=0A=
assignment of server->destroy.=0A=
=0A=
Fixes: f5b3108e6a14 ("NFS: use a hash table for delegation lookup")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Nate Prodromou <nate@prodromou.com>=0A=
---=0A=
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c=0A=
--- a/fs/nfs/nfs4client.c=0A=
+++ b/fs/nfs/nfs4client.c=0A=
@@ -915,20 +915,22 @@ static int nfs4_server_common_setup(struct nfs_server=
 =0A=
 		return error;=0A=
 =0A=
 	/* data servers support only a subset of NFSv4.1 */=0A=
-	if (is_ds_only_client(server->nfs_client))=0A=
-		return -EPROTONOSUPPORT;=0A=
+	if (is_ds_only_client(server->nfs_client)) {=0A=
+		error =3D -EPROTONOSUPPORT;=0A=
+		goto out_free_delegation_hash;=0A=
+	}=0A=
 =0A=
 	/* We must ensure the session is initialised first */=0A=
 	error =3D nfs4_init_session(server->nfs_client);=0A=
 	if (error < 0)=0A=
-		return error;=0A=
+		goto out_free_delegation_hash;=0A=
 =0A=
 	nfs_server_set_init_caps(server);=0A=
 =0A=
 	/* Probe the root fh to retrieve its FSID and filehandle */=0A=
 	error =3D nfs4_get_rootfh(server, mntfh, auth_probe);=0A=
 	if (error < 0)=0A=
-		return error;=0A=
+		goto out_free_delegation_hash;=0A=
 =0A=
 	dprintk("Server FSID: %llx:%llx\n",=0A=
 			(unsigned long long) server->fsid.major,=0A=
@@ -937,7 +939,7 @@ static int nfs4_server_common_setup(struct nfs_server =
=0A=
 =0A=
 	error =3D nfs_probe_server(server, mntfh);=0A=
 	if (error < 0)=0A=
-		return error;=0A=
+		goto out_free_delegation_hash;=0A=
 =0A=
 	nfs4_session_limit_rwsize(server);=0A=
 	nfs4_session_limit_xasize(server);=0A=
@@ -949,6 +951,11 @@ static int nfs4_server_common_setup(struct nfs_server =
=0A=
 	server->mount_time =3D jiffies;=0A=
 	server->destroy =3D nfs4_destroy_server;=0A=
 	return 0;=0A=
+=0A=
+out_free_delegation_hash:=0A=
+	kfree(server->delegation_hash_table);=0A=
+	server->delegation_hash_table =3D NULL;=0A=
+	return error;=0A=
 }=0A=
 =0A=
 /*=0A=
-- =0A=
2.47.0=0A=

