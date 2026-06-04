Return-Path: <linux-nfs+bounces-22273-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rYcNf2OIWqIIwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22273-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:43:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0BF640FD3
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:43:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Dfo0DrQt;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22273-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22273-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD6603012855
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27D47CC78;
	Thu,  4 Jun 2026 14:26:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14442EEAD
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 14:26:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583166; cv=none; b=RfzTxlocXk4uuNsW4Ijx2rAMmSsW7HnphN/w+m7+O3FRN7dm/PUe7KUE9Iif9AQssFHgV5fvdeWDNljmYKD+77JlVm78i0SrXjX9Kngwk0lhTNszwf9WOUQZ4w4M51D0GXnSPICj4lJxc5s6Zq7tEVB31GQHmKTr/rV5nLXElXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583166; c=relaxed/simple;
	bh=Twt+eDHBoEludCqGvDcVV+Ad8p7sVgzFKO5UzAtXH44=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=jafIWsBqYr7BW221wjGbRn60KNGks13cVNdAHduzH8vzQrx7uaVqpKMz0yZIE1afraXsVHIPXaRyQJP0CbFsgsfer4RoDO3vXfkdN1P+c8WHR7IOOpb5h6R3uNBH4dg94JQJ1eIrQuPJeiMdDN2qafwlBlsXyXFUu53TrGntIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dfo0DrQt; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780583164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtAwq+kBbu0Jre6SowbAzwYpDgzV/li3NBaF67YwMAg=;
	b=Dfo0DrQtp1n6c8Zv/AEkr76uu887JNul49k9mQ9cWAo6JjZ06bUDqG0MSNKn79jNv51Gij
	SOP6XbPPnYDPP6vNhPgJERtOAuQvvAuYyAu0VFus0MnhHhzNYkFF5d1JlcD/pgYyc/OlkL
	kI8/ZrkHMRfL+NjwsvefJHEJhj44Bc4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-010EzjtuPq6sAk9ZnnOTDQ-1; Thu,
 04 Jun 2026 10:26:00 -0400
X-MC-Unique: 010EzjtuPq6sAk9ZnnOTDQ-1
X-Mimecast-MFC-AGG-ID: 010EzjtuPq6sAk9ZnnOTDQ_1780583158
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2813A1956094;
	Thu,  4 Jun 2026 14:25:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3B2130001A1;
	Thu,  4 Jun 2026 14:25:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ahPodavlA-gt44FO@infradead.org>
References: <ahPodavlA-gt44FO@infradead.org> <20260518222959.488126-1-dhowells@redhat.com> <20260518222959.488126-6-dhowells@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
    Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
    ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org
Subject: Re: [PATCH v2 05/21] Add a function to kmap one page of a multipage bio_vec
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <127137.1780583146.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:25:46 +0100
Message-ID: <127138.1780583146@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,brauner.io,infradead.org,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22273-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,warthog.procyon.org.uk:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC0BF640FD3

Christoph Hellwig <hch@infradead.org> wrote:

> > +static inline void *kmap_local_bvec(struct bio_vec *bvec, size_t offs=
et)
> =

> The name is rather confusing for something that does not map the entire
> bvec, and is an anagram of the existing bvec_kmap_local.  So please
> rename it to bvec_kmap_partial or something.

Sure...  But it then differs in pattern from the various kmap_local_*() th=
at
we have.

> > +{
> > +	offset +=3D bvec->bv_offset;
> > +
> > +	return kmap_local_page(bvec->bv_page + offset / PAGE_SIZE) + offset =
% PAGE_SIZE;
> =

> ...  Also this can use shits and byte masking to be a tad more efficient=
 and
> matching the rest of the bvec code.

PAGE_SIZE is a constant power-of-2, so it shouldn't make a difference if t=
he
compiler is doing its job properly, but okay.

One thought: I could just give bvec_kmap_local() an offset parameter and u=
se
that instead.

> Users of this would be interesting

It's used four times in patch 10 ("afs: Use a bvecq to hold dir content ra=
ther
than folioq").  I could merge this patch (patch 5) into one of the other
patches, it's just been more convenient for it not be in a later patch whe=
n
flipping backwards and forwards to cut down on recompiling.

> and why you're not simply using a bvec_iter at page granularity, which i=
s
> what other block kmap code does.

Because for the most part I don't want to do linear iteration.  There are =
a
number of cases:

 (*) Read-link and follow-link: For symlinks, there will only be a single
     block and it will fit within PAGE_SIZE.

 (*) Readdir and dir checking: I iterate over the directory contents using
     iov_iter and iterate_bvecq(), though I could also use bvec_iter insid=
e a
     loop to step through the bvecq chain.

 (*) Lookup: Follows the hash chain in the directory rather than searching
     linearly.

 (*) Editing of local directory copy: Doesn't do linear iteration, but rat=
her
     does random access of blocks in the directory.  (This is to avoid hav=
ing
     to reload the dir from the server when doing mkdir, rename, etc.)

Note that directories are 2K, not PAGE_SIZE, and, when editing, I may need=
 to
modify more than one block in a directory operation and they may share a p=
age
(which may be part of a higher order page).  Can we drop 32-bit arches yet=
 -
or, at least, highem support?

David


