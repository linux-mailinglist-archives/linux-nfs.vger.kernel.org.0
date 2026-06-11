Return-Path: <linux-nfs+bounces-22458-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fRiWK9qfKmqLtwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22458-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 13:45:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0500867180D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 13:45:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=TUF9dbrR;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22458-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22458-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0D55326371E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448D3EE1C4;
	Thu, 11 Jun 2026 11:45:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBA3E8C64;
	Thu, 11 Jun 2026 11:45:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178323; cv=none; b=JUWz3FWaI/RZRj4tlb6Yf16E9xkllxyXhapIpdL3sKfk1w0aZoERvsZ3n+9YjJhF9nER4OSwsanO6i59r+m9BbriKwA4RpE4GMgDVvyzacCHMft2h7FVZRX9q7FJf+6ipKnb0B/+x4YX4oHJox5FWXzOxM7mIKV7BQQZUkgTlMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178323; c=relaxed/simple;
	bh=8LHvBLqByAf2B1a9NHF04SuxZHU14nrz6wUY4lJbUQI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iPbPPI45IvUXDGkYn9ZZffIa+4eTCjE/jPCPbuuw9ltm8n6fZ6UujUp8XiN303cC/zneu2ha1P/BpgwM5kp8Ve/e2rxSE3GnqQUhY2TxCvNKlEkZ1B/pqhqRzDooeAucOjJ5PTajENjwvMSYy9Cva72dWqCNyBUJyEEnNTxR+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TUF9dbrR; arc=none smtp.client-ip=212.227.15.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781178315; x=1781783115; i=markus.elfring@web.de;
	bh=pmNl99gE9ynr+wWE6+wPO04nd9FEkYkvRRy2DxgMP+c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TUF9dbrRyljgop5Y8DznB95BwjM+NwQj6f+UYBwL97SovvJAz87h2UxV5nkVv0QE
	 10hOiGs1bdQGIRU+VY6OsguuwmKBNYpZqnD6rKhalmChSwybIrDZ9KxqVvluMdbVG
	 wrpvoX7Y1VAqrnoEY736UoTdNCiLhJrAMpIqN6PDC99tB0G+ceqgwGJS8pBhog4Mb
	 Jk8AG+7f+FVjo4Hta08DgEOOUz7RBrzoDyPrkvD8UCbMWw+n3EBguYDHGavX0eaT5
	 Hy/utl9EtK4gWQZhjnJAGsxDCsoLMZnuy3xdmbdW28RG41SnATNlkuZ9ifLj4QXyz
	 bwGihWM00N2FwP6R/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB3y-1wNDC03lZG-002Pwk; Thu, 11
 Jun 2026 13:45:14 +0200
Message-ID: <c4e92afa-518b-4111-a750-66206e5e752e@web.de>
Date: Thu, 11 Jun 2026 13:45:12 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] NFS: Use common error handling code in nfs_sysfs_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hq69W1cPeE0uXIyslenPy/y9nb1+FICyrzmfKXAlrs2rkq+G3a5
 dTZydtrkFrUOVt3iBaBSgt0j43DmBniTIzteU/qSjqw4NA12BJOl4WLiG/GYlIu4kzql9Bt
 zmvE4kyrCwKq6ULrJ/c1Kb5KLU/imhpXysb0ZY/I1R8Od3WQ+sfH/gPxKiXBg9ED24hopOI
 E1FqouPcsTBC3zhtMpD3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mrE9P7SUkKk=;vhClM5mKcby4b25K7I95+b6Z6qh
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22458-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:anna@kernel.org,m:trondmy@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[web.de]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0500867180D

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 11 Jun 2026 13:40:30 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 3a197252a132..c4ccaa6fe87f 100644
=2D-- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -49,22 +49,22 @@ int nfs_sysfs_init(void)
 		return -ENOMEM;
=20
 	ret =3D kobject_set_name(&nfs_kset->kobj, "nfs");
-	if (ret) {
-		kfree(nfs_kset);
-		return ret;
-	}
+	if (ret)
+		goto free_kset;
=20
 	nfs_kset->kobj.parent =3D fs_kobj;
 	nfs_kset->kobj.ktype =3D &nfs_kset_type;
 	nfs_kset->kobj.kset =3D NULL;
=20
 	ret =3D kset_register(nfs_kset);
-	if (ret) {
-		kfree(nfs_kset);
-		return ret;
-	}
+	if (ret)
+		goto free_kset;
=20
 	return 0;
+
+free_kset:
+	kfree(nfs_kset);
+	return ret;
 }
=20
 void nfs_sysfs_exit(void)
=2D-=20
2.54.0


