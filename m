Return-Path: <linux-nfs+bounces-4195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF528911564
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E4A2840FC
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F09139580;
	Thu, 20 Jun 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="chR/bCWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VySjqKC/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="chR/bCWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VySjqKC/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E813777F
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921107; cv=none; b=LHsxVnL+q1YtkGK+k2csa0hKtS1rK0tUjLBNSwzZDN2eiZ8H8BseBmMqmdPRf2GeubgA4ruAhlcsb2H03TmZB7CZNdrYRHr8ma67HTseur44jY6XFYSCuNoo953YaRM1PEOKBoRGRMBsGmhIkLKormyR5KS+sKaDgqXoQTqZcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921107; c=relaxed/simple;
	bh=iQMhPY63iS3cXF4mkVOE9gTSzl5xagSNMnjxfsoysSo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ugwyHdvw2QXh8QbNOXlWfaIB54QYtF7wuVGqntPBnwxyiW52HD9Lqu5T8355lNKd2AU52/JXea25CRRxmsD6Vhbx6GREkhz7ALlahSteTfJhepF96a7cVAKKw6IejxHw7248qdYFUcgm6n/sbeGLGi6tDgm0WanrOa1CAGKf8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=chR/bCWc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VySjqKC/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=chR/bCWc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VySjqKC/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B732921AE6;
	Thu, 20 Jun 2024 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718921103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH0Q8Nsna8uuVpy5Kvpk4+FnnIjMS+mNEh4WWTL7fYA=;
	b=chR/bCWcG8qiyBTFwU+Wy2OZSoSCLsTI2ohAlbUuryKCmP3yytbsdlEkekEgzsXremAql9
	n7SKUFTBaUpiNKl7TT+LvX8LURiSpU8oycIg2j3LZneULxn6qA6FASOrd7pqGH6FHH5iSk
	RDHE9UmEr0k9n3K/mndgYKYW3mfJzgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718921103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH0Q8Nsna8uuVpy5Kvpk4+FnnIjMS+mNEh4WWTL7fYA=;
	b=VySjqKC/T8a8WqB1GXObhG/IYgnz17pNXpFHdhX1jmdHVh7YVdEmv/V+cCX8xPnbMutsdA
	g+vyKb4rm728LSDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="chR/bCWc";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VySjqKC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718921103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH0Q8Nsna8uuVpy5Kvpk4+FnnIjMS+mNEh4WWTL7fYA=;
	b=chR/bCWcG8qiyBTFwU+Wy2OZSoSCLsTI2ohAlbUuryKCmP3yytbsdlEkekEgzsXremAql9
	n7SKUFTBaUpiNKl7TT+LvX8LURiSpU8oycIg2j3LZneULxn6qA6FASOrd7pqGH6FHH5iSk
	RDHE9UmEr0k9n3K/mndgYKYW3mfJzgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718921103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH0Q8Nsna8uuVpy5Kvpk4+FnnIjMS+mNEh4WWTL7fYA=;
	b=VySjqKC/T8a8WqB1GXObhG/IYgnz17pNXpFHdhX1jmdHVh7YVdEmv/V+cCX8xPnbMutsdA
	g+vyKb4rm728LSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C7C213AC1;
	Thu, 20 Jun 2024 22:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ukzRB42ndGbsbAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Jun 2024 22:05:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Dave Chinner" <david@fromorbit.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: knfsd performance
In-reply-to: <2F6F431C-59AE-4070-B7FF-CF456B95CBB1@oracle.com>
References: <>, <2F6F431C-59AE-4070-B7FF-CF456B95CBB1@oracle.com>
Date: Fri, 21 Jun 2024 08:04:57 +1000
Message-id: <171892109781.14261.15071047015400493177@noble.neil.brown.name>
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B732921AE6
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

On Fri, 21 Jun 2024, Chuck Lever III wrote:
>=20
>=20
> > On Jun 19, 2024, at 10:29=E2=80=AFPM, Dave Chinner <david@fromorbit.com> =
wrote:
> >=20
> > On Thu, Jun 20, 2024 at 07:25:15AM +1000, NeilBrown wrote:
> >> On Wed, 19 Jun 2024, NeilBrown wrote:
> >>> On Wed, 19 Jun 2024, Dave Chinner wrote:
> >>>> On Tue, Jun 18, 2024 at 07:54:43PM +0000, Chuck Lever III wrote  > On =
Jun 18, 2024, at 3:50=E2=80=AFPM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
> >>>>>>=20
> >>>>>> On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> >>>>>>>=20
> >>>>>>>=20
> >>>>>>>> On Jun 18, 2024, at 3:29=E2=80=AFPM, Trond Myklebust
> >>>>>>>> <trondmy@hammerspace.com> wrote:
> >>>>>>>>=20
> >>>>>>>> On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> >>>>>>>>>=20
> >>>>>>>>>=20
> >>>>>>>>>> On Jun 18, 2024, at 2:32=E2=80=AFPM, Trond Myklebust
> >>>>>>>>>> <trondmy@hammerspace.com> wrote:
> >>>>>>>>>>=20
> >>>>>>>>>> I recently back ported Neil's lwq code and sunrpc server
> >>>>>>>>>> changes to
> >>>>>>>>>> our
> >>>>>>>>>> 5.15.130 based kernel in the hope of improving the performance
> >>>>>>>>>> for
> >>>>>>>>>> our
> >>>>>>>>>> data servers.
> >>>>>>>>>>=20
> >>>>>>>>>> Our performance team recently ran a fio workload on a client
> >>>>>>>>>> that
> >>>>>>>>>> was
> >>>>>>>>>> doing 100% NFSv3 reads in O_DIRECT mode over an RDMA connection
> >>>>>>>>>> (infiniband) against that resulting server. I've attached the
> >>>>>>>>>> resulting
> >>>>>>>>>> flame graph from a perf profile run on the server side.
> >>>>>>>>>>=20
> >>>>>>>>>> Is anyone else seeing this massive contention for the spin lock
> >>>>>>>>>> in
> >>>>>>>>>> __lwq_dequeue? As you can see, it appears to be dwarfing all
> >>>>>>>>>> the
> >>>>>>>>>> other
> >>>>>>>>>> nfsd activity on the system in question here, being responsible
> >>>>>>>>>> for
> >>>>>>>>>> 45%
> >>>>>>>>>> of all the perf hits.
> >>>>=20
> >>>> Ouch. __lwq_dequeue() runs llist_reverse_order() under a spinlock.
> >>>>=20
> >>>> llist_reverse_order() is an O(n) algorithm involving full length
> >>>> linked list traversal. IOWs, it's a worst case cache miss algorithm
> >>>> running under a spin lock. And then consider what happens when
> >>>> enqueue processing is faster than dequeue processing.
> >>>=20
> >>> My expectation was that if enqueue processing (incoming packets) was
> >>> faster than dequeue processing (handling NFS requests) then there was a
> >>> bottleneck elsewhere, and this one wouldn't be relevant.
> >>>=20
> >>> It might be useful to measure how long the queue gets.
> >>=20
> >> Thinking about this some more ....  if it did turn out that the queue
> >> gets long, and maybe even if it didn't, we could reimplement lwq as a
> >> simple linked list with head and tail pointers.
> >>=20
> >> enqueue would be something like:
> >>=20
> >>  new->next =3D NULL;
> >>  old_tail =3D xchg(&q->tail, new);
> >>  if (old_tail)
> >>       /* dequeue of old_tail cannot succeed until this assignment comple=
tes */
> >>       old_tail->next =3D new
> >>  else
> >>       q->head =3D new
> >>=20
> >> dequeue would be
> >>=20
> >>  spinlock()
> >>  ret =3D q->head;
> >>  if (ret) {
> >>        while (ret->next =3D=3D NULL && cmp_xchg(&q->tail, ret, NULL) !=
=3D ret)
> >>            /* wait for enqueue of q->tail to complete */
> >>            cpu_relax();
> >>  }
> >>  cmp_xchg(&q->head, ret, ret->next);
> >>  spin_unlock();
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
>=20
> I agree that O(n) dequeuing is potentially alarming.

Only O(n) 1/n of the time.  On average it is still constant time.

>=20
> Before we go too far down this path, I'd like to see
> reproducible numbers that show there is a problem
> when a recent upstream NFS server is properly set up
> with a sensible number of threads and running a real
> workload.

Question for Trond: was nconnect configured, or was there only a single
connection?

With a single connection there is only ever zero or one xprt in the
queue to be dequeued, and if there are zero we don't take the lock.

With 16 connections they might always be busy so as soon as a request is
read from the connection it is requeued.  This means 1/16 of dequeue
operations would be slowish and the other 15/16 would be fast.

Maybe the 1/16 slow case could swamp the others but I'd be surprised.


>=20
> Otherwise there is a risk of introducing code in a
> fundamental part of SunRPC that is optimized to the
> point of brittleness, and for no good reason.
>=20
> This is what keeps me from sleeping at night: [1]
> See, it even has my name on it. :-)
>=20
>=20
> --
> Chuck Lever
>=20
> [1] - https://www.linusakesson.net/programming/kernighans-lever/index.php

The conclusion of that article is that we SHOULD try to write clever
code because the effort invested in writing it and then debugging it
makes us cleverer so that the next time we can do even better.  That
thought would help me sleep at night!

NeilBrown

