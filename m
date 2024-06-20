Return-Path: <linux-nfs+bounces-4193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82E9114D2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 23:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8B1F23639
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9680605;
	Thu, 20 Jun 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rSa/pQ63";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QmPAmMC8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rmSCPY1n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6+cfxczN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED07C6CE
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919584; cv=none; b=nL8T6ZMA5ejkH8NGIE8FLjDug+5H4fTBmmmrulwwn+1IXN8Sui2XCrA7rIw1luRu2hkGZxmbVDFhzyvtp+ypxih2faoEwt+8WeaMA14g1/6rkx2wE6Pf4Na4gR52q0TtyLYML0J2BNfSLzWm6P4R1cjlafqGe5NYtkKHw1iPAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919584; c=relaxed/simple;
	bh=1oExyM1IpiWyacnGuaBr8Ivy6zFqvp2zV/doTIWWP5Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GQS8r2ugUcz6n7iRpKCEpJNBgPkSYevsaqL42kNNE5Pk/B8jTitkuanR6zmaLXIlPXeEoFTLlVa7+kiUwZRrtTWBIZrY5Aw8T8ERfuz98hNPKmukIrDRWZPAm5Xi2uVFEJMskg5OMYlvV5vNZ5zJaNKBd0C4za8GlyOrZepJe+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rSa/pQ63; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QmPAmMC8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rmSCPY1n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6+cfxczN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1A6921AED;
	Thu, 20 Jun 2024 21:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718919580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEWPM8jTZeDVvxZU4kAZwKp3wcJntGNXs/u5FY5qFvM=;
	b=rSa/pQ63BrNBxlrk3aZk51xBAUqsOmjcyDNhwdlyrS0wVfnE6pGBMoY/H4CpM+Y3Jaqvrl
	xtnNpO1WLrZMV4Thxi35J36lOfJI9skesH5Vnt4f9USmWlJohokgCvJvxJz+1KQ+DuoPQX
	dk+N4TkPzl06UKxMufSEaGva9Eis/tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718919580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEWPM8jTZeDVvxZU4kAZwKp3wcJntGNXs/u5FY5qFvM=;
	b=QmPAmMC8fHXPjmf+NGh4ZSaU1zy0U3oFnDudXzlYdEQf8HtkWYRQNezPGbUPynDL82c7AD
	wzXTaJFnHap9F8AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718919579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEWPM8jTZeDVvxZU4kAZwKp3wcJntGNXs/u5FY5qFvM=;
	b=rmSCPY1nsciHpsMcp22Kq9iuFSEv4w+qOm+DL7Wn1HD5sWwN1Pf343Ar3YYWDsPEMCqvcA
	TWJHmw8/nATG7vdaO/EaTfkoXbcPzBcUGS3BTzwILQMiTtgaQL8tcKJKfplduMN53DCcfu
	wu9CcGej5B5L9TsL7DA3ZAy+0R8Tdco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718919579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEWPM8jTZeDVvxZU4kAZwKp3wcJntGNXs/u5FY5qFvM=;
	b=6+cfxczNZoNu3q5XUYRP5+37wkR4nKR1ggpzwkAryxc/kPQ+FARh7VGKFGX8YEz1uYcVFX
	ACZ2c7Dmb8F2JZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBA4613AC1;
	Thu, 20 Jun 2024 21:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wGidI5ihdGasZQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Jun 2024 21:39:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Dave Chinner" <david@fromorbit.com>,
 "Chuck Lever III" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
In-reply-to: <c98bb317d7e7c9a11346433c31929139be045731.camel@kernel.org>
References: <>, <c98bb317d7e7c9a11346433c31929139be045731.camel@kernel.org>
Date: Fri, 21 Jun 2024 07:39:27 +1000
Message-id: <171891956789.14261.10741446134657217484@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Thu, 20 Jun 2024, Jeff Layton wrote:
> On Thu, 2024-06-20 at 12:29 +1000, Dave Chinner wrote:
> > On Thu, Jun 20, 2024 at 07:25:15AM +1000, NeilBrown wrote:
> > > On Wed, 19 Jun 2024, NeilBrown wrote:
> > > > On Wed, 19 Jun 2024, Dave Chinner wrote:
> > > > > On Tue, Jun 18, 2024 at 07:54:43PM +0000, Chuck Lever III wrote  > =
On Jun 18, 2024, at 3:50=E2=80=AFPM, Trond Myklebust <trondmy@hammerspace.com=
> wrote:
> > > > > > >=20
> > > > > > > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > On Jun 18, 2024, at 3:29=E2=80=AFPM, Trond Myklebust
> > > > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > > >=20
> > > > > > > > > On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > On Jun 18, 2024, at 2:32=E2=80=AFPM, Trond Myklebust
> > > > > > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > > > > >=20
> > > > > > > > > > > I recently back ported Neil's lwq code and sunrpc server
> > > > > > > > > > > changes to
> > > > > > > > > > > our
> > > > > > > > > > > 5.15.130 based kernel in the hope of improving the perf=
ormance
> > > > > > > > > > > for
> > > > > > > > > > > our
> > > > > > > > > > > data servers.
> > > > > > > > > > >=20
> > > > > > > > > > > Our performance team recently ran a fio workload on a c=
lient
> > > > > > > > > > > that
> > > > > > > > > > > was
> > > > > > > > > > > doing 100% NFSv3 reads in O_DIRECT mode over an RDMA co=
nnection
> > > > > > > > > > > (infiniband) against that resulting server. I've attach=
ed the
> > > > > > > > > > > resulting
> > > > > > > > > > > flame graph from a perf profile run on the server side.
> > > > > > > > > > >=20
> > > > > > > > > > > Is anyone else seeing this massive contention for the s=
pin lock
> > > > > > > > > > > in
> > > > > > > > > > > __lwq_dequeue? As you can see, it appears to be dwarfin=
g all
> > > > > > > > > > > the
> > > > > > > > > > > other
> > > > > > > > > > > nfsd activity on the system in question here, being res=
ponsible
> > > > > > > > > > > for
> > > > > > > > > > > 45%
> > > > > > > > > > > of all the perf hits.
> > > > >=20
> > > > > Ouch. __lwq_dequeue() runs llist_reverse_order() under a spinlock.
> > > > >=20
> > > > > llist_reverse_order() is an O(n) algorithm involving full length
> > > > > linked list traversal. IOWs, it's a worst case cache miss algorithm
> > > > > running under a spin lock. And then consider what happens when
> > > > > enqueue processing is faster than dequeue processing.
> > > >=20
> > > > My expectation was that if enqueue processing (incoming packets) was
> > > > faster than dequeue processing (handling NFS requests) then there was=
 a
> > > > bottleneck elsewhere, and this one wouldn't be relevant.
> > > >=20
> > > > It might be useful to measure how long the queue gets.
> > >=20
> > > Thinking about this some more ....  if it did turn out that the queue
> > > gets long, and maybe even if it didn't, we could reimplement lwq as a
> > > simple linked list with head and tail pointers.
> > >=20
> > > enqueue would be something like:
> > >=20
> > >   new->next =3D NULL;
> > >   old_tail =3D xchg(&q->tail, new);
> > >   if (old_tail)
> > >        /* dequeue of old_tail cannot succeed until this assignment comp=
letes */
> > >        old_tail->next =3D new
> > >   else
> > >        q->head =3D new
> > >=20
> > > dequeue would be
> > >=20
> > >   spinlock()
> > >   ret =3D q->head;
> > >   if (ret) {
> > >         while (ret->next =3D=3D NULL && cmp_xchg(&q->tail, ret, NULL) !=
=3D ret)
> > >             /* wait for enqueue of q->tail to complete */
> > >             cpu_relax();
> > >   }
> > >   cmp_xchg(&q->head, ret, ret->next);
> > >   spin_unlock();
> >=20
> > That might work, but I suspect that it's still only putting off the
> > inevitable.
> >=20
> > Doing the dequeue purely with atomic operations might be possible,
> > but it's not immediately obvious to me how to solve both head/tail
> > race conditions with atomic operations. I can work out an algorithm
> > that makes enqueue safe against dequeue races (or vice versa), but I
> > can't also get the logic on the opposite side to also be safe.
> >=20
> > I'll let it bounce around my head a bit more...
> >=20
>=20
> The latest version of the multigrain timestamp patches doesn't use it,
> but Jan Kara pointed out to me that there is a cmpxchg128 function in
> the kernel. It's only defined for some arches (x86, s390, and aarch64,
> I think), but maybe that could be used here.

One of the particularly pernicious scenarios that a non-locking approach
needs to deal with is if two threads try to dequeue at the same time and
just before the atomic ops which commits the dequeue, one of the threads
is suspends - e.g. by an interrupt or VM pauses or whatever.
While that thread is paused the other thread completes the dequeue,
consumes the event, recycles the object, and it ends up back at the
start of the queue, though this time with a different ->next pointer.
The paused thread then wakes up and the cmpxchg succeeds but does the
wrong thing.

This can be addressed with ll/sc because the sc will always fail after a
long pause like that.  With cmpxchg we could fix it by including a large
sequence counter with the address in the atomic exchange.  That is where
cmpxchg128 comes in.

So:
   head =3D q->head
   ctr =3D q->ctr
   new =3D head->next
   if (cmpxchg128(q, [head,ctr] [new,ctr+1]) fails)
      goto So;

would avoid that problem as the ctr would be different - and a 64 bit
counter never cycles.

This only solves that particular issue.  There are other more obvious
races but I think it could be made to work.  We'd need a spinlock
fallback of other archs of course.

Thanks,
NeilBrown

