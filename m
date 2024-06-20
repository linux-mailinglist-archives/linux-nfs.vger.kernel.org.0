Return-Path: <linux-nfs+bounces-4135-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246891014F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 12:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8DD1F211B2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF421A8C17;
	Thu, 20 Jun 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF7PGGyB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62C1A8C05
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878733; cv=none; b=ARHV8wzAPK22+lNkkxDg8UwyUYAvh9O/iW3B8fYFYa8Wld8YGlWxJZ/ZHJORPJmoRaSE9xO3y6eGofYqFBVKqUD6i9nAiXJP8JUX9V5B4pELe3SPY6ChnY5BWQc7739ftB+yWgGZJ1DfGyD82R1PsedMSCU1Cjr5gU1NialttRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878733; c=relaxed/simple;
	bh=E4/Z4NDMVUyAKOu0T40w/+rOpxPsOMauE03Si9z+VA8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BHCi2Xai9jwCGzYnOppnQbMAy0laIkXe8mO5sEbQs3HjE4PydOQFwwf/fcaJUUf4LopgIFKapZdrvI+t5i1Q/4NEgN56ofllfOl1i/QontRQtRdQGEZNNuX0Iu7ATbyK18NfnYVjB7I/O068tow3GfDW6QW9uU+zMOzv3cnmiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF7PGGyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB472C2BD10;
	Thu, 20 Jun 2024 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718878733;
	bh=E4/Z4NDMVUyAKOu0T40w/+rOpxPsOMauE03Si9z+VA8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dF7PGGyBpVtDV3a72UdBhyn2MxSVRZyUT4sdq9EPp16vPDGwtH9Fakl76hIRmdfDc
	 Qi7b7qHwTwMSDRup3w7CK6+gL+Y4y0kBeeINkQ930iYufmzOXQR3JuX6kZ9v36XbKm
	 yIW/5JEYDMEyElgF8ddMPipeYKbxx/j7ye8w8ei0Axz2wS3qqZQ4+Y7cA6NgDbn3+d
	 Ze0dMbEKUeB0VKRheht/gTuXu9ZHPIEMTl7rmGCP/Lf0rRQ/5ypGL66JkhfPOiyep1
	 cSMSZAfU+sBaUrCgg0dCkkbFPK+rju7P1l9/7Ypx1dmq7+d6eriLIsVdQQZWsYx4n5
	 51zzhZ5JtNa9A==
Message-ID: <c98bb317d7e7c9a11346433c31929139be045731.camel@kernel.org>
Subject: Re: knfsd performance
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>
Cc: Chuck Lever III <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>
Date: Thu, 20 Jun 2024 06:18:51 -0400
In-Reply-To: <ZnOUG2Nh80vTJXxe@dread.disaster.area>
References: <> <ZnIpfgCrRe95sXdr@dread.disaster.area>
	 <171875886281.14261.15016610844409785952@noble.neil.brown.name>
	 <171883231568.14261.16495433738354176501@noble.neil.brown.name>
	 <ZnOUG2Nh80vTJXxe@dread.disaster.area>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 12:29 +1000, Dave Chinner wrote:
> On Thu, Jun 20, 2024 at 07:25:15AM +1000, NeilBrown wrote:
> > On Wed, 19 Jun 2024, NeilBrown wrote:
> > > On Wed, 19 Jun 2024, Dave Chinner wrote:
> > > > On Tue, Jun 18, 2024 at 07:54:43PM +0000, Chuck Lever III wrote  > =
On Jun 18, 2024, at 3:50=E2=80=AFPM, Trond Myklebust <trondmy@hammerspace.c=
om> wrote:
> > > > > >=20
> > > > > > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > > On Jun 18, 2024, at 3:29=E2=80=AFPM, Trond Myklebust
> > > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > >=20
> > > > > > > > On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > On Jun 18, 2024, at 2:32=E2=80=AFPM, Trond Myklebust
> > > > > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > > > >=20
> > > > > > > > > > I recently back ported Neil's lwq code and sunrpc serve=
r
> > > > > > > > > > changes to
> > > > > > > > > > our
> > > > > > > > > > 5.15.130 based kernel in the hope of improving the perf=
ormance
> > > > > > > > > > for
> > > > > > > > > > our
> > > > > > > > > > data servers.
> > > > > > > > > >=20
> > > > > > > > > > Our performance team recently ran a fio workload on a c=
lient
> > > > > > > > > > that
> > > > > > > > > > was
> > > > > > > > > > doing 100% NFSv3 reads in O_DIRECT mode over an RDMA co=
nnection
> > > > > > > > > > (infiniband) against that resulting server. I've attach=
ed the
> > > > > > > > > > resulting
> > > > > > > > > > flame graph from a perf profile run on the server side.
> > > > > > > > > >=20
> > > > > > > > > > Is anyone else seeing this massive contention for the s=
pin lock
> > > > > > > > > > in
> > > > > > > > > > __lwq_dequeue? As you can see, it appears to be dwarfin=
g all
> > > > > > > > > > the
> > > > > > > > > > other
> > > > > > > > > > nfsd activity on the system in question here, being res=
ponsible
> > > > > > > > > > for
> > > > > > > > > > 45%
> > > > > > > > > > of all the perf hits.
> > > >=20
> > > > Ouch. __lwq_dequeue() runs llist_reverse_order() under a spinlock.
> > > >=20
> > > > llist_reverse_order() is an O(n) algorithm involving full length
> > > > linked list traversal. IOWs, it's a worst case cache miss algorithm
> > > > running under a spin lock. And then consider what happens when
> > > > enqueue processing is faster than dequeue processing.
> > >=20
> > > My expectation was that if enqueue processing (incoming packets) was
> > > faster than dequeue processing (handling NFS requests) then there was=
 a
> > > bottleneck elsewhere, and this one wouldn't be relevant.
> > >=20
> > > It might be useful to measure how long the queue gets.
> >=20
> > Thinking about this some more ....  if it did turn out that the queue
> > gets long, and maybe even if it didn't, we could reimplement lwq as a
> > simple linked list with head and tail pointers.
> >=20
> > enqueue would be something like:
> >=20
> >   new->next =3D NULL;
> >   old_tail =3D xchg(&q->tail, new);
> >   if (old_tail)
> >        /* dequeue of old_tail cannot succeed until this assignment comp=
letes */
> >        old_tail->next =3D new
> >   else
> >        q->head =3D new
> >=20
> > dequeue would be
> >=20
> >   spinlock()
> >   ret =3D q->head;
> >   if (ret) {
> >         while (ret->next =3D=3D NULL && cmp_xchg(&q->tail, ret, NULL) !=
=3D ret)
> >             /* wait for enqueue of q->tail to complete */
> >             cpu_relax();
> >   }
> >   cmp_xchg(&q->head, ret, ret->next);
> >   spin_unlock();
>=20
> That might work, but I suspect that it's still only putting off the
> inevitable.
>=20
> Doing the dequeue purely with atomic operations might be possible,
> but it's not immediately obvious to me how to solve both head/tail
> race conditions with atomic operations. I can work out an algorithm
> that makes enqueue safe against dequeue races (or vice versa), but I
> can't also get the logic on the opposite side to also be safe.
>=20
> I'll let it bounce around my head a bit more...
>=20

The latest version of the multigrain timestamp patches doesn't use it,
but Jan Kara pointed out to me that there is a cmpxchg128 function in
the kernel. It's only defined for some arches (x86, s390, and aarch64,
I think), but maybe that could be used here.
--=20
Jeff Layton <jlayton@kernel.org>

