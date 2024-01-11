Return-Path: <linux-nfs+bounces-1041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962182B328
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D7B28A863
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADE50250;
	Thu, 11 Jan 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcieYNXp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B3A5D
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704991338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VqrInYkNLx1NtjOqgVxpVM91IYukVc31dOGwzdzlGfI=;
	b=bcieYNXpRqMoVNkm5HaKE8DRiwDcnBbtKQmpOY/4l52X36j3lpwsLwGUK1K9MKDAW7tpTk
	8cfbv1g58trjOLTM4/bLPknjsIkWkY3icH3yH6l6YlIn78ihO80hL58P1b2LhZlLyt7fZR
	QgX8CaXfIEsS4DZsBQls5sMwQ0GW/Xc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-UpLrGVGfMfWuXurDF-TKjw-1; Thu, 11 Jan 2024 11:42:13 -0500
X-MC-Unique: UpLrGVGfMfWuXurDF-TKjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF910882321;
	Thu, 11 Jan 2024 16:42:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5C7A2166B31;
	Thu, 11 Jan 2024 16:42:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever III <chuck.lever@oracle.com>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
    linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Rebuilding at least part of my krb5 crypto lib on crypto-aead
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2131431.1704991328.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jan 2024 16:42:08 +0000
Message-ID: <2131432.1704991328@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi Herbert, Chuck,

I've been thinking more on how I might go about rebuilding at least part o=
f my
krb5 crypto library on top of the AEAD template.

I don't think it makes sense to try and put the entirety of it in there.
There are functions that completely don't fit (such as key generation) and=
 the
catalogue of Kerberos type values and associated parameters.

Also, I'm not sure it makes sense to try and squeeze the Integrity-type
operations get_mic and verify_mic as AEAD.  get_mic might work as AEAD, bu=
t
all a wrapper would add is to emplace the checksum into ciphertext buffer.
The actual checksumming is handled by a SHASH algorithm perfectly well.
verify_mic doesn't really make sense as it has no output other than "yes/n=
o" -
and so is also handled fine by a SHASH algorithm.

Where it does make sense is at the core of the encrypt/decrypt ops where I
have four compound ops to choose from:

	- encrypt-then-hash
	- hash-then-decrypt
	- hash-then-encrypt
	- decrypt-then-hash

These can conceivably be hardware optimised to do both parts of the op
simultaneously.  I *think* I've seen a suggestion that x86_64 AVX has
sufficient registers available to do both AES and SHA simultaneously, say.

The question I then have is this: How do I parameterise the crypto algorit=
hm
inside AEAD?  Can I do something like:

	cipher =3D crypto_alloc_sync_aead("enc-then-hash(cts(cbc(camellia)),cmac(=
camellia))");

David


