Return-Path: <linux-nfs+bounces-5224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9C946A0B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2024 16:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A451281AC0
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2024 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015C1E895;
	Sat,  3 Aug 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="FrwiArAm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD051DA26
	for <linux-nfs@vger.kernel.org>; Sat,  3 Aug 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722694953; cv=none; b=h7th5AAF77NkvDqMNsUBkjV5spT+Itgqr3JzyiGmkZehRefRMAHlJ6dTI2JREEpED+fKywW3bOhvAM9IholS8sy3sE2OmqvYvQhoJsU+X1XnmNLN9I/dkGVkaSRrbV6zpRqiscJOC8x+Y6LTJ80e5ZOtBek6nktTl7r++jfO9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722694953; c=relaxed/simple;
	bh=QQhrTUm090zz6E/U6gQ09n+M/ixO06zRM3QE6YrLq1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tbz3HSIzQWFizCUzg8VtyHxPaKJpso+YHeknhm15Xhc8J9ybL4p93MoE80UtH2GSSTVId1FHh40MZzufVfMLSiMW8KESkwZQ3sqxSJj3rJ4zrSlW4T9FoEiIQJAQNlFDeGO5SU0uktjAYk2k38ZA1bHnR5p08pZMptvzrEZAwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=FrwiArAm; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=v9+U+E6gGyv3zoTHMcYMniz/edUGQHDA2sqRpT9cn/E=; 
	b=FrwiArAmgdzBixWXT/8paTnnLBlPVELuc/WVBB9CHotyrazPleEGtVs0pIFzNdg2RIbN/Q5kQfe
	3tY5V+YRyUCcApPC4vO/UH6POrRltH4wFLf+RGUSX2+/qzbnTIfWypKhiIfyTzfxu3uXv+/OkZSRs
	yJxQ317sCwqqLIvDZPwJ4KL5EcU5yaDSNErPAV/IMz7dq6nuxM7M91UDPN49SNK52JeQ/j9EifR55
	pGUAT4w9KBlejwYoh9GeJOb/JuyBSUpcRMhTF0p0XHf8lT1eVlyLKXs1hiVmLKYB/XVU0mvwMQCT5
	/5MHzM/ws9dbjEtPzEvN1Skl0oXrX0pCz+goba249wSEJufBy7DkfujQYNU3exCX3gKKEHjn8Vvvv
	AZyJ2zch3m6R/evO+4SEtTcVLJwDvGmLxenrF3XtaIUpdLjMxKNASGu2LNK2Iychiq9zXbU3CbOVA
	zUuqAhaS49ZwqCDdzx4nKLD+Qj35qmR+SG5ayY00SCCYX/cV9L7CBpgIY6ORUjIFjHYkRkU7jCjcD
	eHGR83JRuzbOR2PiEa0QZmyrY5MBwh9v9DSnLXf1MFPaO7KiFDK5Hp3kgkf9rKD2g+CDCmOx48FkN
	iLSkrGoEobbTNnwso4MHz/HWzOpljkd/lCCyrGlfd3O35H6igYWWhO47kzN/buTHuMpD4=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1saFeD-00000003Esz-2Es2
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Sat, 03 Aug 2024 14:22:17 +0000
Received: from a1-bg02.venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id gBjeBhk9rmZuyAsAT9YxdQ
	(envelope-from <hristo@venev.name>); Sat, 03 Aug 2024 14:22:17 +0000
Message-ID: <056dde73b48f7a6ee1ca9bf6cc2f0f11536424c3.camel@venev.name>
Subject: Re: kernel 6.10
From: Hristo Venev <hristo@venev.name>
To: Trond Myklebust <trondmy@hammerspace.com>, "dan.aloni@vastdata.com"
	 <dan.aloni@vastdata.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "blokos@free.fr" <blokos@free.fr>, "dhowells@redhat.com"
 <dhowells@redhat.com>
Date: Sat, 03 Aug 2024 17:22:16 +0300
In-Reply-To: <eba1f68169ce0bfdd5e0881e04f67b0c57d6ce2e.camel@hammerspace.com>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
	 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
	 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
	 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
	 <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
	 <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>
	 <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
	 <eba1f68169ce0bfdd5e0881e04f67b0c57d6ce2e.camel@hammerspace.com>
Autocrypt: addr=hristo@venev.name; prefer-encrypt=mutual;
 keydata=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
 AjQ6o01lu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-31 at 15:27 +0000, Trond Myklebust wrote:
> On Sun, 2024-07-28 at 11:33 +0300, Dan Aloni wrote:
> > On 2024-07-28 02:57:42, Hristo Venev wrote:
> > >=20
> > >=20
> > > ... and 0x356 happens to be NETFS_FOLIO_COPY_TO_CACHE. Maybe the
> > > NETFS_RREQ_USE_PGPRIV2 flag is lost somehow?
> >=20
>=20
> Why is netfs setting folio->private at all when it is running on top
> of
> NFS? It doesn't own that field.

As I mentioned previously, there is something going on with the
`NETFS_RREQ_USE_PGPRIV2` flag. In particular, it appears that it isn't
always set in `netfs_alloc_request()`. This may happen when
`netfs_is_cache_enabled()` returns false on a cache-enabled filesystem.
Maybe the inode cache state is not yet fully initialized?

The patch below seems to fix the issue, in the sense that reading from
the filesystem is no longer a guaranteed crash.


diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f4a6427274792..a74ca90c86c9b 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -27,7 +27,6 @@ struct netfs_io_request *netfs_alloc_request(struct addre=
ss_space *mapping,
 	bool is_unbuffered =3D (origin =3D=3D NETFS_UNBUFFERED_WRITE ||
 			      origin =3D=3D NETFS_DIO_READ ||
 			      origin =3D=3D NETFS_DIO_WRITE);
-	bool cached =3D !is_unbuffered && netfs_is_cache_enabled(ctx);
 	int ret;
=20
 	for (;;) {
@@ -56,8 +55,9 @@ struct netfs_io_request *netfs_alloc_request(struct addre=
ss_space *mapping,
 	refcount_set(&rreq->ref, 1);
=20
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	if (cached) {
-		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+	if (!is_unbuffered && fscache_cookie_valid(netfs_i_cookie(ctx))) {
+		if (netfs_is_cache_enabled(ctx))
+			__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
 		if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags))
 			/* Filesystem uses deprecated PG_private_2 marking. */
 			__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);


However, there is still another issue: Unmounting deadlocks on
`folio_wait_private_2`:

   [root@localhost ~]# cat /proc/489/stack
   [<0>] folio_wait_private_2+0xc7/0x130
   [<0>] truncate_cleanup_folio+0x4a/0x80
   [<0>] truncate_inode_pages_range+0xe1/0x3c0
   [<0>] nfs4_evict_inode+0x10/0x70
   [<0>] evict+0xbd/0x160
   [<0>] evict_inodes+0x15e/0x1e0
   [<0>] generic_shutdown_super+0x34/0x160
   [<0>] kill_anon_super+0xd/0x40
   [<0>] nfs_kill_super+0x1c/0x30
   [<0>] deactivate_locked_super+0x27/0xa0
   [<0>] cleanup_mnt+0xb5/0x150
   [<0>] task_work_run+0x52/0x80
   [<0>] syscall_exit_to_user_mode+0xef/0x100
   [<0>] do_syscall_64+0x53/0x870
   [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
  =20
In 6.9 the `NETFS_RREQ_COPY_TO_CACHE` flag used to be considered by
`netfs_rreq_assess`. Now it no longer appears to be checked anywhere.
With the new netfs cache implementation, how/when is the `PG_private_2`
flag cleared and when is data written to cache?

