Return-Path: <linux-nfs+bounces-20935-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKewCG4M4mkg1AAAu9opvQ
	(envelope-from <linux-nfs+bounces-20935-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 12:33:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5441A255
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E0CD3001A7D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED993B584A;
	Fri, 17 Apr 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b="Lu8eDa6w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from eu-smtp-delivery-195.mimecast.com (eu-smtp-delivery-195.mimecast.com [185.58.85.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD603B38A9
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421409; cv=none; b=VJlA2fpB/YG+HDHagi+n6doRb28wz4R+ro+htD9lGugP06m2t3qFuqIv90kacHBMwRTjfSdnyFztOjk+RDxlNjiQ1aoSW5V6oFQFyx69lJEsUdK4OvssXo1eotloO33LyK+LFCxElQEPZWSbaS6nTg+8+i0Hw1+U3sxJEX2nkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421409; c=relaxed/simple;
	bh=m9xYKdGnhHy+LMyv6tv+lj4vbStBQgtW+kozUi01xzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Dxx/j48bumVUElOfzsdgTIBnyUyPtusKy6wHKbzKGCwonizPdCGgUSe1dhGL5kaxBbvEG2IE+Dop0z+vmtevvO3G3OwiUnzCHrqHOxMso3I/KTUB93yXguYYSCZg5IAS84LXq6/YX0j/07tD4c4VkZ6QVAISIVLtG8/0sy0jSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com; spf=pass smtp.mailfrom=gsacapital.com; dkim=pass (1024-bit key) header.d=gsacapital.com header.i=@gsacapital.com header.b=Lu8eDa6w; arc=none smtp.client-ip=185.58.85.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gsacapital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gsacapital.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gsacapital.com;
	s=mimecast20170115; t=1776421404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOigYv6KMGmyM4t1Mi7xOBzYiET+hKih5DhF35ikYGE=;
	b=Lu8eDa6wQbC9hqLigjuq668LXd/RzxLBWLHUp3uO7G+LEUk5NFdBdGpvoOHmCtas9QoZi3
	TKZM8W0QD0Mq4fq0sVbvKXuvnZrWHkJyEQmCsuMWvQqKsSyky3Vs6FJXgdhiFH3MSMOaDd
	d34TEJ5Ndg3r3XHi2ND+l3vXfPEJNDA=
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022091.outbound.protection.outlook.com
 [52.101.66.91]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 uk-mta-257-eiBRXH1DODCNcUjUlRb9lQ-1; Fri, 17 Apr 2026 11:17:04 +0100
X-MC-Unique: eiBRXH1DODCNcUjUlRb9lQ-1
X-Mimecast-MFC-AGG-ID: eiBRXH1DODCNcUjUlRb9lQ_1776421023
Received: from AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 by GVXPR04MB11631.eurprd04.prod.outlook.com (2603:10a6:150:2c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:17:01 +0000
Received: from AM8PR04MB7764.eurprd04.prod.outlook.com
 ([fe80::1ecf:750b:3097:a66f]) by AM8PR04MB7764.eurprd04.prod.outlook.com
 ([fe80::1ecf:750b:3097:a66f%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:17:00 +0000
From: Ben Roberts <ben.roberts@gsacapital.com>
To: Benjamin Coddington <ben.coddington@hammerspace.com>
CC: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] pNFS: deadlock in pnfs_send_layoutreturn
Thread-Topic: [PATCH v2] pNFS: deadlock in pnfs_send_layoutreturn
Thread-Index: AQHcx1LQb9GHfiAvKEmU31eXdHmo/LXYXo0AgAYtabA=
Date: Fri, 17 Apr 2026 10:17:00 +0000
Message-ID: <AM8PR04MB7764059A4CC2893C16A3180E8A202@AM8PR04MB7764.eurprd04.prod.outlook.com>
References: <20260408122534.537816-1-ben.roberts@gsacapital.com>
 <B8730746-9646-4416-8417-D73B24FAB79A@hammerspace.com>
In-Reply-To: <B8730746-9646-4416-8417-D73B24FAB79A@hammerspace.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7764:EE_|GVXPR04MB11631:EE_
x-ms-office365-filtering-correlation-id: 536d7b7b-9f32-442c-519c-08de9c6a76e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021
x-microsoft-antispam-message-info: nVB9P4lnm0ffO44O9SOLG9vO2wIeLtmuve5BsYDgMVZTWGYSwxiOX5rQqt9pcVmparN+UMJlW9sXPNLVouZCOjpPKgby8ABscla3AfN5ltC/mJq0xlXHxXXuGAirL6EeslwD5N+2RM0o8IN1nS6ENCJJhybWpjkjYZ5fzSFCtpV53hatk74TvCSrFibqiYyy/ht2UJdi/U1JRVYE4plJAdYTtnNBzRUDS9NCMgWhesV4bVViebZtsh1xgkigd/hCky2SvTBTJnehS79GSbv3Niz8kuFHdlmf3w7OBWxwU0DAeT9WfZCHzJRIBnpfO0QXWo0qgT2WO7fTPi8iXaYUOoawXAY7BXHCgPKKx8hENyegxeXlmJOFuBoXqRIp9C6yQwFmj7nww2b/PL4L3w0qDhaaXTzz2j6JPlURK1Qx8FMq0y6h0HnM0RLK6Y2a3zbOrBQhoKtcw9TZk77UKybEb5PcLUxW9QxrCKtkxWfIaPC/SHYhNefJkyULqrhYEulskBlPjnZNI/HqWM4i0BR/AP+5OQ83vTl61VITCB6dyRA85VLQ4nZexU3gUtj20qRGyanJwrAdQTNJ7EmZ+Yn5/6sFZdQTGfGwbUIsGG0wZwIkQH/W7JqOIfdKzn8YaGB7hd9WAeBIgw6pxudatZOnpWMJyl948myPVIPqgVt6Ll0FbIeQtzSkL9xesENPG1SIOSUajwd1FakL0/4cMmZC75coIq/XMTOsBwfeCFa8hdZzol5tlEwR8Elhc8Y/MYJbDoflMQIEPmCxKwgBe0i51x0beGdphfL/Y7oT6mv67cE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7764.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kkm5oah2elBL8XD2DZXv9O83b2Tx9rNuUs8t8ZEl8xG/sZ5O+RhjObn4gV5W?=
 =?us-ascii?Q?JECC+oqp9SwUOJEWmO3TacCcGiMpz3lycTaxa0Z+NCYfveD0kltY0rcS3TOe?=
 =?us-ascii?Q?3cV50dog5uHVnzOAAiCC5wi9aqFNbm1XXsEZcD3GYQteptaJiOBfLVrnTt9o?=
 =?us-ascii?Q?yGOs2/JXlk8tKWgDwKINQfDlROVnf3pz1eaofduiWMGq6V2O9hQayajWoZWf?=
 =?us-ascii?Q?s2OcmLZB3FIyddvd120CKoiVFDu/gGMS9OuQb9WsfAZxb/tpDjA8hmzcKjG1?=
 =?us-ascii?Q?O+vJxM/ai0hkA29fu4mg82eyUdu0WCx6cl4MWTDHMM38oG28edX5aiIun466?=
 =?us-ascii?Q?aT1gTREmAtt1ltESysythK6l5F69F+1RH+wRvPmG7YFNkQQhT4VQn0iz46S3?=
 =?us-ascii?Q?nNpCW8/8v/m57DHidHeNLxznRHeaUXHIt9hxuYBCHuxG/0JzbcSYcJprzw7T?=
 =?us-ascii?Q?MwB34V56Soaq+LRGTmSxZ0IyvYwX4QlUfzXrbAfNFz4aPM429G8UzGY/NSBH?=
 =?us-ascii?Q?bhZSoKuQ2XNuizXnRxKL8UqDpa/fwwVHPC79y6Osv/yZ2ETcPDtYN9exVxDY?=
 =?us-ascii?Q?D9q0oNrT0WcEnLga6HuFT2EqzIpmztCu4pSMIMV9ZZb96FmsSmhkb65IBA9K?=
 =?us-ascii?Q?KhW5v4o1tgzilHJB/lVtaOkfXiehNoFZyN2d2hMhEST5DF1J6A5V8sgR/ihU?=
 =?us-ascii?Q?rXLsEpRn7f+CXG85cH2/5pdVI6ghnHQkZAL4jZqZZCWiIwOHcF6xklTpUPSx?=
 =?us-ascii?Q?rK8CLqmh1v8x3iJeiB292daJusCLgaBxgeyiJMa8XFHO34k5epCPPSidfbNa?=
 =?us-ascii?Q?E735C/kGiqUkSAd9Q/+1FsrMwci+QzFwygMBFCYPFS8wlCsGI+NftCuXs83K?=
 =?us-ascii?Q?2LgSIiZyTrQ4SzjyeDurfpubpcR1x2fB+sgiTkHQKAynyfgNgeOTRO/xSP9L?=
 =?us-ascii?Q?OY6xi42nT3YxIJF0fGWgb7WXgYCWmfUG30ND6Sa9Ri4uv4ZIiG2DGf6h+aD9?=
 =?us-ascii?Q?GnQDF1d7+MwSnx9gCwELwf1M4jDtrMctIekgciZhaMaoadBf99Y0yUsM3qmr?=
 =?us-ascii?Q?TJilpV2pygCt3pTlGNmB3yAsr80SBsDwO19MZ4gzPsSbdFmCneN2rRTElxxR?=
 =?us-ascii?Q?C2C8NVmSKyl7aLo2HzcFti61tkF/xl7W0a0AxuJinsZ61qc8p6ahLdSZM8pW?=
 =?us-ascii?Q?9CVvmDO9StZg9r8PBF81iWKhA9btEfHflmIDNbIdg101nAgkf+j6BKJ9P6o8?=
 =?us-ascii?Q?Em8KDBnGAIks+UKrPcZrr8JDF3mySodaK+PaBAf6pLxLWQtifaVFshgN8JKn?=
 =?us-ascii?Q?4CuEsf/XcgVH2A9ijG2P3bYmg4ji6/CcEccAWgmzw0SqEOOOfA0kMPeIa8j9?=
 =?us-ascii?Q?7/qh63Gidv/Zowth1sr7qiY+HS3WVrtPALl1+putsy7eASrlwN05n9+xYDAN?=
 =?us-ascii?Q?A6J16vKkK7YQSfGXk39dCu01G0aS2xXaB72AWxJ8mwsjRrzAztlMFDM7lf7k?=
 =?us-ascii?Q?ktDhpmLBWYkv0gQr4fIBPDpQpmrmPNqu7xcuFQuRhKbgMe/Q+WMk+pz0eKpz?=
 =?us-ascii?Q?Z3VS+VJzQr+H0tCrP85peZcammdPCbdVDvhp0ZVFAMUq/ci+smRX81II7SlD?=
 =?us-ascii?Q?AbK1aV4xY+Q3uyBoKTNXiMXa48GMAJJRsGXxuQEY0mKCqhd5gQtH4y2RVWo8?=
 =?us-ascii?Q?em7jpv6aIKjp7WqQEm3MUdLAhaaFqXWSCTmNLEUBXNXpKe1fYXu3aY8w8lIh?=
 =?us-ascii?Q?uoYecYi07g=3D=3D?=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oTpG9d9MBSOJGBYuSll+6kZ+hN2zgACEcX9Pq5HPCvHBLyKL1WAcJqo+dJmD9Eb7lMnsLbzKh/SChlCvtIPUV+/s4vhpjs+xDheKZLA99FaNQrPcr8bHfgArAL5o5zolntKw1OYjaC8FtNQURUWIMiyhul7QRSLQrQGpTQOsLXWQJ8mNL4Nn1vpNStw5XFMA3vxeS2o5Y5yz6y4sk1UTNlDWQDqHxRVcyp9/qmLUBIE/BkuHw3WzsTAPbkmcimPsoKHEhruh/fgY0Zg7D1KppQYKcXCqbU6SWR//Sd5hLvrwwu2+xUx+8430sIYySdkRBguC8P0lwXHudnz+iDKAUA==
X-OriginatorOrg: gsacapital.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7764.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536d7b7b-9f32-442c-519c-08de9c6a76e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:17:00.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1c223b65-c219-4d0f-b348-45bd61f327c6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhc8Tk3glJ2hcXDwNcjW01hdK3BSFD/uIQ9LioVkGZav/zaPlXfJ4IpCWmqf277y21csu4VdZtI6DZbgK5tazKUBEXkme/nLg0CS7cizZLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11631
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6_LfGam65rH7Px23Tsk1UOozI8omnlH_ar89sXNhWts_1776421023
X-Mimecast-Originator: gsacapital.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gsacapital.com,none];
	R_DKIM_ALLOW(-0.20)[gsacapital.com:s=mimecast20170115];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20935-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gsacapital.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.roberts@gsacapital.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AF5441A255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ben,

> Did you reproduce and diagnose this problem on a recent upstream kernel
> version?=20

I'm not able to switch the production systems to a more recent kernel at
this time, and don't have a reliable way to reproduce the issue in the
wild without risking production systems back on an unpatched kernel. The
best evidence I have that this patch is needed, is that we were seeing
this deadlock occur repeatedly under high loads and memory pressure last
year before applying this patch locally. It was rolled out to all
production systems in early Jan and we have not seen a single reoccurrence
since. The relevant code paths look similar between the modified EL9
kernel and the current git HEAD.

I've spent all this week trying to devise a precise reproduction (with a
lot of help from an LLM since I'm not that familar with kernel
development) on both 7.0.0-rc7 (9a9c8ce300cd) and 5.14.0-611.9.1 kernels
to definitively prove this patch is needed, but without success. The
initial analysis suggested the deadlock might be triggered from a single
process via a recursive call. This theory has been ruled out; all calling
paths triggered by a single process are guarded in such a way that a
recursive call does not happen. Revised theory for why this patch helps
is that the deadlock is subject to an inter-process race, where one
process suffers a memory allocation failure, causing a second process to
become a victim of bad state, leading to an unserviceable RPC request.
The timing appears to be very sensitive and hard to reproduce on demand.

The LLM-assisted analysis follows, and to my non-expert eyes seems
compelling.

Thanks,
Ben

---

When pnfs_send_layoutreturn() fails to allocate memory for the layoutreturn
structure, it returns -ENOMEM after calling pnfs_clear_layoutreturn_waitbit
to wake waiting processes. However, it fails to clear the
NFS_LAYOUT_RETURN_REQUESTED flag via pnfs_clear_layoutreturn_info().

This creates a race condition where processes woken by
pnfs_clear_layoutreturn_waitbit will see NFS_LAYOUT_RETURN_REQUESTED still
set and may attempt another layoutreturn on the corrupted layout state,
leading to hung tasks in rpc_wait_bit_killable().

The bug manifests during memory pressure when:
1. Process A calls pnfs_send_layoutreturn(), kzalloc fails
2. Error path calls pnfs_clear_layoutreturn_waitbit() (wakes waiters)
3. Error path does NOT call pnfs_clear_layoutreturn_info() (flag remains
   set)
4. Process B wakes from wait_on_bit() at _pnfs_return_layout:1484
5. Process B calls pnfs_put_layout_hdr(), refcount reaches zero
6. pnfs_layoutreturn_before_put_layout_hdr() checks flag at line 1400
7. Flag is still set, so Process B calls pnfs_send_layoutreturn() (async)
8. RPC operates on inconsistent/dying layout state
9. Process B hangs indefinitely in rpc_wait_bit_killable()

The fix ensures that when allocation fails in the error path, both the
waitbit AND the layoutreturn info are cleared, so waiting processes wake
to consistent state and do not attempt operations on the corrupted layout.

  The Deadlock Mechanism                                                   =
         =20
                                                           =20
  Thread A (allocation failure):                                           =
 =20
  // Line 1360-1368 in pnfs_send_layoutreturn()            =20
  if (unlikely(lrp =3D=3D NULL)) {
      status =3D -ENOMEM;
      spin_lock(&ino->i_lock);
      pnfs_clear_layoutreturn_waitbit(lo);  // Wakes Thread B
      spin_unlock(&ino->i_lock);
      // BUG: NFS_LAYOUT_RETURN_REQUESTED still set!
      put_cred(cred);
      pnfs_put_layout_hdr(lo);  // Decrements refcount
      goto out;
  }

  Thread B (wakes up):
  // In _pnfs_return_layout() around line 1458
  if (test_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags)) {
      spin_unlock(&ino->i_lock);
      if (wait_on_bit(...))  // Thread B was blocked HERE
          goto out_put_layout_hdr;  // Now wakes up and goes here
      spin_lock(&ino->i_lock);
  }
  // ... continues ...
  wait_on_bit(...);  // Line 1484 - passes through (bit already clear)
  out_put_layout_hdr:
  pnfs_free_lseg_list(&tmp_list);
  pnfs_put_layout_hdr(lo);  // Line 1487 - THE CRITICAL CALL

  Inside Thread B's pnfs_put_layout_hdr() call (line 306):
  void pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
  {
      inode =3D lo->plh_inode;
      pnfs_layoutreturn_before_put_layout_hdr(lo);  // 313 Called FIRST

      if (refcount_dec_and_lock(&lo->plh_refcount, &inode->i_lock)) {
          // If refcount reaches 0, layout is FREED here
          pnfs_detach_layout_hdr(lo);
          pnfs_free_layout_hdr(lo);  // Layout memory FREED!
      }
  }

  Inside pnfs_layoutreturn_before_put_layout_hdr() (line 1395):
  static void
  pnfs_layoutreturn_before_put_layout_hdr(struct pnfs_layout_hdr *lo)
  {
      if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
          return;  // Line 1399-1400 Would early return if flag was clear

      // BUG: Flag is STILL SET, so continues!
      spin_lock(&inode->i_lock);
      if (pnfs_layout_need_return(lo)) {
          ...
          send =3D pnfs_prepare_layoutreturn(lo, &stateid, &cred, &iomode);
          spin_unlock(&inode->i_lock);
          if (send) {
              // Sends ANOTHER layoutreturn RPC!
              pnfs_send_layoutreturn(lo, &stateid, &cred, iomode,
                                     PNFS_FL_LAYOUTRETURN_ASYNC);  // 1412
          }
      }
  }

  Why It Deadlocks

  The key issue is timing and state corruption:

  1. Thread B initiates async RPC at line 1412 that references layout lo
  2. Then Thread B returns to pnfs_put_layout_hdr() line 315
  3. If refcount reaches 0: Layout is DETACHED and FREED (lines 318-323)
  4. But the RPC from step 1 is still in flight!

  The RPC is now operating on a layout structure that may be:
  - Partially freed
  - Corrupted
  - Have invalid stateid
  - Have detached inode reference

  When the RPC machinery tries to complete this operation, it hits
  inconsistent state and hangs in rpc_wait_bit_killable() waiting for an
  RPC response that can never complete properly because the underlying
  state is corrupted.

---

Example stack trace for a deadlocked process:

[<0>] rpc_wait_bit_killable+0xd/0x60 [sunrpc]
[<0>] __rpc_execute+0x13a/0x300 [sunrpc]
[<0>] rpc_execute+0xc5/0xf0 [sunrpc]
[<0>] rpc_run_task+0x14d/0x1c0 [sunrpc]
[<0>] nfs4_proc_layoutreturn+0x14f/0x270 [nfsv4]
[<0>] pnfs_send_layoutreturn+0x119/0x190 [nfsv4]
[<0>] _pnfs_return_layout+0x1b6/0x280 [nfsv4]
[<0>] nfs4_evict_inode+0x6d/0x70 [nfsv4]
[<0>] evict+0xcc/0x1d0
[<0>] dispose_list+0x48/0x70
[<0>] evict_inodes+0x1a0/0x1b0
[<0>] generic_shutdown_super+0x37/0x100
[<0>] kill_anon_super+0x12/0x40
[<0>] nfs_kill_super+0x22/0x40 [nfs]
[<0>] deactivate_locked_super+0x2e/0xb0
[<0>] cleanup_mnt+0x100/0x160
[<0>] task_work_run+0x59/0x90
[<0>] do_exit+0x264/0x480
[<0>] do_group_exit+0x2d/0x90
[<0>] get_signal+0x839/0x860
[<0>] arch_do_signal_or_restart+0x25/0x100
[<0>] exit_to_user_mode_loop+0x9c/0x130
[<0>] exit_to_user_mode_prepare+0xb9/0x100
[<0>] syscall_exit_to_user_mode+0x12/0x40
[<0>] do_syscall_64+0x6b/0xe0
[<0>] entry_SYSCALL_64_after_hwframe+0x78/0x80

Ben Roberts=20

For details of how GSA uses your personal information, please see our Priva=
cy Notice here: https://www.gsacapital.com/privacy-notice=20

This email and any files transmitted with it contain confidential and propr=
ietary information and is solely for the use of the intended recipient.
If you are not the intended recipient please return the email to the sender=
 and delete it from your computer and you must not use, disclose, distribut=
e, copy, print or rely on this email or its contents.
This communication is for informational purposes only.
It is not intended as an offer or solicitation for the purchase or sale of =
any financial instrument or as an official confirmation of any transaction.
Any comments or statements made herein do not necessarily reflect those of =
GSA Capital.
GSA Capital Partners LLP is authorised and regulated by the Financial Condu=
ct Authority and is registered in England and Wales at Stratton House, 5 St=
ratton Street, London W1J 8LA, number OC309261.
GSA Capital Services Limited is registered in England and Wales at the same=
 address, number 5320529.


