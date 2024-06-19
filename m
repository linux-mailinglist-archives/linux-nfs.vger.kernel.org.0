Return-Path: <linux-nfs+bounces-4111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D090F876
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 23:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189A11F226E9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D57E57F;
	Wed, 19 Jun 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YA+GFSF4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e9U3EWAY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YA+GFSF4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e9U3EWAY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346E79B84
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832325; cv=none; b=AENPqZMuwJGXmqbitwhIw6AuvW69aTYBZDBhGjYz8bjLmCPVZB7KDk2SU/kw3Sn0hDJrcgBxxOF7iJi5hHnFJqkJeN/lm2/HLAF1+Ug0B/2LfbadXKs1fcHdoOPUJSYoWEUL/QNiN9mO9kyoXebVlGO9/VkpaIZlS62yopFELXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832325; c=relaxed/simple;
	bh=iKWgCVYxv8wRgno6ahmz642Fa2j5RxJxXEvCeBeLxK4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FyWghE3uP5FEdRz2lzRjhSJZwM/gHC4pgR3fSbQuA4OvGe0+QlXVojrpiz22izINyNsFwz+5KEnLjCo1D/oLmCoGhp/cslnIoAU8/Vc2sNrRV/ml5dyQiXGTsAs4YAoGkPCn9izYUiAtaRh3p/k+AgShOxtmf9cVwN/oDb210x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YA+GFSF4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e9U3EWAY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YA+GFSF4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e9U3EWAY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B277D21A50;
	Wed, 19 Jun 2024 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718832321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9XDzf/zAN2aBOVkoE+8/uBRFj+gH1eSu0Mtmwiv9Mk=;
	b=YA+GFSF431GeGMFaN1G2P4vLEMNwi+E7bEjZG2KvGRgSXME6slUP9M5cZpexnvj8S8S7uX
	RHHCs0YxYz/lzWVAUNHb629Q9jLlDw4qewvenbBdz1XhCJ1Eeb0XwpTJGdIcBVKITjY1cA
	s1bjhNZygGnJMQpCOZkA7j+Jx77JRa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718832321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9XDzf/zAN2aBOVkoE+8/uBRFj+gH1eSu0Mtmwiv9Mk=;
	b=e9U3EWAYDinA/sLuC3OoPawpjyYps3VcjlS/02kz2zfogyrgGOIzgzrxyAnbZZX8/LpYos
	uE3RgclaKtR9u+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718832321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9XDzf/zAN2aBOVkoE+8/uBRFj+gH1eSu0Mtmwiv9Mk=;
	b=YA+GFSF431GeGMFaN1G2P4vLEMNwi+E7bEjZG2KvGRgSXME6slUP9M5cZpexnvj8S8S7uX
	RHHCs0YxYz/lzWVAUNHb629Q9jLlDw4qewvenbBdz1XhCJ1Eeb0XwpTJGdIcBVKITjY1cA
	s1bjhNZygGnJMQpCOZkA7j+Jx77JRa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718832321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9XDzf/zAN2aBOVkoE+8/uBRFj+gH1eSu0Mtmwiv9Mk=;
	b=e9U3EWAYDinA/sLuC3OoPawpjyYps3VcjlS/02kz2zfogyrgGOIzgzrxyAnbZZX8/LpYos
	uE3RgclaKtR9u+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7124913668;
	Wed, 19 Jun 2024 21:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dTgVBb9Mc2YgCwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 21:25:19 +0000
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
In-reply-to: <171875886281.14261.15016610844409785952@noble.neil.brown.name>
References: <>, <ZnIpfgCrRe95sXdr@dread.disaster.area>,
 <171875886281.14261.15016610844409785952@noble.neil.brown.name>
Date: Thu, 20 Jun 2024 07:25:15 +1000
Message-id: <171883231568.14261.16495433738354176501@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Wed, 19 Jun 2024, NeilBrown wrote:
> On Wed, 19 Jun 2024, Dave Chinner wrote:
> > On Tue, Jun 18, 2024 at 07:54:43PM +0000, Chuck Lever III wrote  > On Jun=
 18, 2024, at 3:50=E2=80=AFPM, Trond Myklebust <trondmy@hammerspace.com> wrot=
e:
> > > >=20
> > > > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > > >>=20
> > > >>=20
> > > >>> On Jun 18, 2024, at 3:29=E2=80=AFPM, Trond Myklebust
> > > >>> <trondmy@hammerspace.com> wrote:
> > > >>>=20
> > > >>> On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > > >>>>=20
> > > >>>>=20
> > > >>>>> On Jun 18, 2024, at 2:32=E2=80=AFPM, Trond Myklebust
> > > >>>>> <trondmy@hammerspace.com> wrote:
> > > >>>>>=20
> > > >>>>> I recently back ported Neil's lwq code and sunrpc server
> > > >>>>> changes to
> > > >>>>> our
> > > >>>>> 5.15.130 based kernel in the hope of improving the performance
> > > >>>>> for
> > > >>>>> our
> > > >>>>> data servers.
> > > >>>>>=20
> > > >>>>> Our performance team recently ran a fio workload on a client
> > > >>>>> that
> > > >>>>> was
> > > >>>>> doing 100% NFSv3 reads in O_DIRECT mode over an RDMA connection
> > > >>>>> (infiniband) against that resulting server. I've attached the
> > > >>>>> resulting
> > > >>>>> flame graph from a perf profile run on the server side.
> > > >>>>>=20
> > > >>>>> Is anyone else seeing this massive contention for the spin lock
> > > >>>>> in
> > > >>>>> __lwq_dequeue? As you can see, it appears to be dwarfing all
> > > >>>>> the
> > > >>>>> other
> > > >>>>> nfsd activity on the system in question here, being responsible
> > > >>>>> for
> > > >>>>> 45%
> > > >>>>> of all the perf hits.
> >=20
> > Ouch. __lwq_dequeue() runs llist_reverse_order() under a spinlock.
> >=20
> > llist_reverse_order() is an O(n) algorithm involving full length
> > linked list traversal. IOWs, it's a worst case cache miss algorithm
> > running under a spin lock. And then consider what happens when
> > enqueue processing is faster than dequeue processing.
>=20
> My expectation was that if enqueue processing (incoming packets) was
> faster than dequeue processing (handling NFS requests) then there was a
> bottleneck elsewhere, and this one wouldn't be relevant.
>=20
> It might be useful to measure how long the queue gets.

Thinking about this some more ....  if it did turn out that the queue
gets long, and maybe even if it didn't, we could reimplement lwq as a
simple linked list with head and tail pointers.

enqueue would be something like:

  new->next =3D NULL;
  old_tail =3D xchg(&q->tail, new);
  if (old_tail)
       /* dequeue of old_tail cannot succeed until this assignment completes =
*/
       old_tail->next =3D new
  else
       q->head =3D new

dequeue would be

  spinlock()
  ret =3D q->head;
  if (ret) {
        while (ret->next =3D=3D NULL && cmp_xchg(&q->tail, ret, NULL) !=3D re=
t)
            /* wait for enqueue of q->tail to complete */
            cpu_relax();
  }
  cmp_xchg(&q->head, ret, ret->next);
  spin_unlock();

plus some barriers and a bit more careful thought.  That would put a
stronger limit on the time that the spinlock was held, though it could
still have to wait for another CPU occasionally.

NeilBrown

