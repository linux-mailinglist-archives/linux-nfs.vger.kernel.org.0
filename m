Return-Path: <linux-nfs+bounces-4041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9B90E10F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 03:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6851F22913
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E06AAD;
	Wed, 19 Jun 2024 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+trKNDS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A1wRZwyP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+trKNDS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A1wRZwyP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D9524F
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718758873; cv=none; b=Mm3o1HhXfEvEpRDTuuFIGuCJ4Omqot9oBkTK6LR1nbxxmd/EMvoIw79/MMRK4F8yOrwekn80w8mRxZhPJZys+V7PpIsj9fBvuA4DCbTy568Bqya6sson9XWxtZP1aPaDrCVfjL91ziBwzYYXLEv0zGzJWnQAbRSt0l8ZcaxrJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718758873; c=relaxed/simple;
	bh=G/KrYbKv8mjlrRSf8wF52b5BkUB22Fhq99L8+RoCviM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AXYGF3kA3tLAG04nJPeVcraBYFEo0NzwiDhM+f31wKKER4/49F/geTiyNzgX5z2p1fy6phioqCyrq6xHerJRznjAmIC2eBfN97AnXoxyhT8FhQDqwdEqzVrscXGuZbmZqFHL2IoOq59Kz6Jn97c8ZaGXBQNO8ADo0cx22fcPCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+trKNDS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A1wRZwyP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+trKNDS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A1wRZwyP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F3E5219A2;
	Wed, 19 Jun 2024 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718758869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnfCyowgtFQVeClPr8sUPFTYcIbDs09ZdayBZOGP6o=;
	b=o+trKNDSfsKidTzP+cNpbEDVKAgFAmA30bZCGwxbawVPUvQulMdxVUwU9LT09hitgRvVSB
	V+jtkvJxdR5TFQ6z4vZzkNSVmS1kZq2ukCk8B0vR5qAGgCHd/YA6n3wGSSH1BlSSOWdDa1
	HLaJ+7yEcJczwqa6+0GRCFierUiXEPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718758869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnfCyowgtFQVeClPr8sUPFTYcIbDs09ZdayBZOGP6o=;
	b=A1wRZwyPLojRb7I3yErfT9XnxEYJeKd+BOh+Xh2izAVkxHmrYDxiqDyFA46ZlKvcyhvAlW
	URHPHXFlONta6HAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o+trKNDS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A1wRZwyP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718758869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnfCyowgtFQVeClPr8sUPFTYcIbDs09ZdayBZOGP6o=;
	b=o+trKNDSfsKidTzP+cNpbEDVKAgFAmA30bZCGwxbawVPUvQulMdxVUwU9LT09hitgRvVSB
	V+jtkvJxdR5TFQ6z4vZzkNSVmS1kZq2ukCk8B0vR5qAGgCHd/YA6n3wGSSH1BlSSOWdDa1
	HLaJ+7yEcJczwqa6+0GRCFierUiXEPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718758869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGnfCyowgtFQVeClPr8sUPFTYcIbDs09ZdayBZOGP6o=;
	b=A1wRZwyPLojRb7I3yErfT9XnxEYJeKd+BOh+Xh2izAVkxHmrYDxiqDyFA46ZlKvcyhvAlW
	URHPHXFlONta6HAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEA221369F;
	Wed, 19 Jun 2024 01:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tqu0HNItcmaBJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 01:01:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: knfsd performance
In-reply-to: <ZnIpfgCrRe95sXdr@dread.disaster.area>
References: <>, <ZnIpfgCrRe95sXdr@dread.disaster.area>
Date: Wed, 19 Jun 2024 11:01:02 +1000
Message-id: <171875886281.14261.15016610844409785952@noble.neil.brown.name>
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,hammerspace.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0F3E5219A2
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Spam-Level: 

On Wed, 19 Jun 2024, Dave Chinner wrote:
> On Tue, Jun 18, 2024 at 07:54:43PM +0000, Chuck Lever III wrote  > On Jun 1=
8, 2024, at 3:50=E2=80=AFPM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > >=20
> > > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > >>=20
> > >>=20
> > >>> On Jun 18, 2024, at 3:29=E2=80=AFPM, Trond Myklebust
> > >>> <trondmy@hammerspace.com> wrote:
> > >>>=20
> > >>> On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > >>>>=20
> > >>>>=20
> > >>>>> On Jun 18, 2024, at 2:32=E2=80=AFPM, Trond Myklebust
> > >>>>> <trondmy@hammerspace.com> wrote:
> > >>>>>=20
> > >>>>> I recently back ported Neil's lwq code and sunrpc server
> > >>>>> changes to
> > >>>>> our
> > >>>>> 5.15.130 based kernel in the hope of improving the performance
> > >>>>> for
> > >>>>> our
> > >>>>> data servers.
> > >>>>>=20
> > >>>>> Our performance team recently ran a fio workload on a client
> > >>>>> that
> > >>>>> was
> > >>>>> doing 100% NFSv3 reads in O_DIRECT mode over an RDMA connection
> > >>>>> (infiniband) against that resulting server. I've attached the
> > >>>>> resulting
> > >>>>> flame graph from a perf profile run on the server side.
> > >>>>>=20
> > >>>>> Is anyone else seeing this massive contention for the spin lock
> > >>>>> in
> > >>>>> __lwq_dequeue? As you can see, it appears to be dwarfing all
> > >>>>> the
> > >>>>> other
> > >>>>> nfsd activity on the system in question here, being responsible
> > >>>>> for
> > >>>>> 45%
> > >>>>> of all the perf hits.
>=20
> Ouch. __lwq_dequeue() runs llist_reverse_order() under a spinlock.
>=20
> llist_reverse_order() is an O(n) algorithm involving full length
> linked list traversal. IOWs, it's a worst case cache miss algorithm
> running under a spin lock. And then consider what happens when
> enqueue processing is faster than dequeue processing.

My expectation was that if enqueue processing (incoming packets) was
faster than dequeue processing (handling NFS requests) then there was a
bottleneck elsewhere, and this one wouldn't be relevant.

It might be useful to measure how long the queue gets.

>=20
> This means the depth of the queue grows, and ultimate length of the
> queue is unbound. Because fo the batch processing nature of lwq -
> it takes ->new, reverses it and places it in ->ready - the length of
> the list that needs reversing ends up growing every batch that
> we queue faster than we dequeue. Unbound processing queues are bad
> even when they have O(1) behaviour. lwq has O(n) worst case
> behaviour, and that makes this even worse...
>=20
> Regardless, The current lwq could be slightly improved - the
> lockless enqueue competes for the same cacheline as the dequeue
> serialisation lock.
>=20
> struct lwq {
>         spinlock_t              lock;
>         struct llist_node       *ready;         /* entries to be dequeued */
>         struct llist_head       new;            /* entries being enqueued */
> };
>=20
> Adding __cacheline_aligned_in_smp to ->new (the enqueue side) might
> help reduce this enqueue/dequeue cacheline contention a bit by
> separating them onto different cachelines. That will push the point
> of catastrophic breakdown out a little bit, not solve the issue of
> queue depth based batch processing on the dequeue side.
>=20

Yes, that might be beneficial - thanks.


> I suspect a lockless ring buffer might be a more scalable solution
> for the nfsd...

We would need to size the buffer to the maximum number of connections
(if there is one - I don't recall) or resize the buffer as the number of
connections grows.  Certainly doable.

Thanks,
NeilBrown

