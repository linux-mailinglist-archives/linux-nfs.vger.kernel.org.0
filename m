Return-Path: <linux-nfs+bounces-9708-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06222A20066
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 23:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5084D3A27BF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE21A01B0;
	Mon, 27 Jan 2025 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t8tLtITp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+kolro2R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t8tLtITp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+kolro2R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1D1946C3;
	Mon, 27 Jan 2025 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016297; cv=none; b=QvtNZ9KltWtGbSzXajM3b7Z+Rje6KlBN6St7728sAKabi7LxpE1jqmHtZc+30jYQ/f+d3yvl3hyXThYTa86V7taK7i5g79ZO0aQu0epm0unbdtw3QRyEwgzf5CMz1MeA0vo2LWNmIbSYLE7LbBIaF/4bksG4UOLHXI117HUXMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016297; c=relaxed/simple;
	bh=mBWUQK/WLP79/DVZLLfxb5gJDlFTEifdma65m5Z2V+0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DN4kM5Jt5c+1ca5MLxLbEeOi+WmS3sbVR9CMoa5XnNHyWZl6G6qAvCPM3LLe2ANznsLX5ARVzY12PSC8H0C10EIFykCA+O939wYp2FDspjbgGxA49xqyFPu/hPlgY65ggw3MaNbfAP2pXMBSkQQHDx9JqY0O+x/DScaLTwngw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t8tLtITp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+kolro2R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t8tLtITp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+kolro2R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A58A2210F4;
	Mon, 27 Jan 2025 22:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738016292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPqMltZkGoX3IwUv9LCmaMNt4M15JwDsRUMdxXlXiZw=;
	b=t8tLtITpS9J7Mg40SYRKZmvxxiRbwGLLXzO4X/e30RoCl4LQ01xDj4TZ69ayFJr6s0XSmh
	fBXl+8u1+nSLEFKVgJCvmBkq2sF/VZ747bxbSkB0f68mzpM5/dcTOombL+scfgR/mo/6ic
	/a/I7+fKJTHswXHn1fKs5pPI6cpshf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738016292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPqMltZkGoX3IwUv9LCmaMNt4M15JwDsRUMdxXlXiZw=;
	b=+kolro2RPBRV0w6Q0uZMWYpNSC7Y4Wt3z1U/NflVIwmCrQJiugTGBRcTomWrDjLBSLPmWq
	+OiOyV7Udfqs4EBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t8tLtITp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+kolro2R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738016292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPqMltZkGoX3IwUv9LCmaMNt4M15JwDsRUMdxXlXiZw=;
	b=t8tLtITpS9J7Mg40SYRKZmvxxiRbwGLLXzO4X/e30RoCl4LQ01xDj4TZ69ayFJr6s0XSmh
	fBXl+8u1+nSLEFKVgJCvmBkq2sF/VZ747bxbSkB0f68mzpM5/dcTOombL+scfgR/mo/6ic
	/a/I7+fKJTHswXHn1fKs5pPI6cpshf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738016292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPqMltZkGoX3IwUv9LCmaMNt4M15JwDsRUMdxXlXiZw=;
	b=+kolro2RPBRV0w6Q0uZMWYpNSC7Y4Wt3z1U/NflVIwmCrQJiugTGBRcTomWrDjLBSLPmWq
	+OiOyV7Udfqs4EBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3AAF137C0;
	Mon, 27 Jan 2025 22:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zv8oFiEGmGe/SAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 22:18:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Salvatore Bonaccorso" <carnil@debian.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
In-reply-to: <37fb186b-ffb6-44dc-a097-ec669079c801@oracle.com>
References: <>, <37fb186b-ffb6-44dc-a097-ec669079c801@oracle.com>
Date: Tue, 28 Jan 2025 09:16:01 +1100
Message-id: <173801616176.22054.7568435634151185350@noble.neil.brown.name>
X-Rspamd-Queue-Id: A58A2210F4
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 28 Jan 2025, Chuck Lever wrote:
> On 1/27/25 8:39 AM, Chuck Lever wrote:
> > On 1/27/25 8:32 AM, Jeff Layton wrote:
> >> On Mon, 2025-01-27 at 08:22 -0500, Chuck Lever wrote:
> >>> On 1/27/25 8:07 AM, Jeff Layton wrote:
> >>>> On Mon, 2025-01-27 at 11:15 +1100, NeilBrown wrote:
> >>>>> On Mon, 27 Jan 2025, Jeff Layton wrote:
> >>>>>> On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
> >>>>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
> >>>>>>>> On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
> >>>>>>>>> On Sun, 26 Jan 2025, Jeff Layton wrote:
> >>>>>>>>>> nfsd_file_dispose_list_delayed can be called from the filecache
> >>>>>>>>>> laundrette, which is shut down after the nfsd threads are shut=20
> >>>>>>>>>> down and
> >>>>>>>>>> the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL=20
> >>>>>>>>>> then there
> >>>>>>>>>> are no threads to wake.
> >>>>>>>>>>
> >>>>>>>>>> Ensure that the nn->nfsd_serv pointer is non-NULL before calling
> >>>>>>>>>> svc_wake_up in nfsd_file_dispose_list_delayed. This is safe=20
> >>>>>>>>>> since the
> >>>>>>>>>> svc_serv is not freed until after the filecache laundrette is=20
> >>>>>>>>>> cancelled.
> >>>>>>>>>>
> >>>>>>>>>> Fixes: ffb402596147 ("nfsd: Don't leave work of closing files=20
> >>>>>>>>>> to a work queue")
> >>>>>>>>>> Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> >>>>>>>>>> Closes: https://lore.kernel.org/linux-=20
> >>>>>>>>>> nfs/7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@kernel.org/
> >>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >>>>>>>>>> ---
> >>>>>>>>>> This is only lightly tested, but I think it will fix the bug that
> >>>>>>>>>> Salvatore reported.
> >>>>>>>>>> ---
> >>>>>>>>>> =C2=A0=C2=A0 fs/nfsd/filecache.c | 11 ++++++++++-
> >>>>>>>>>> =C2=A0=C2=A0 1 file changed, 10 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> >>>>>>>>>> index=20
> >>>>>>>>>> e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2dd7=
50f43239b4af6d37b0 100644
> >>>>>>>>>> --- a/fs/nfsd/filecache.c
> >>>>>>>>>> +++ b/fs/nfsd/filecache.c
> >>>>>>>>>> @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct=20
> >>>>>>>>>> list_head *dispose)
> >>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct nfsd_file, nf_gc);
> >>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str=
uct nfsd_net *nn =3D net_generic(nf->nf_net,=20
> >>>>>>>>>> nfsd_net_id);
> >>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str=
uct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> >>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_serv *ser=
v;
> >>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
n_lock(&l->lock);
> >>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lis=
t_move_tail(&nf->nf_gc, &l->freeme);
> >>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
n_unlock(&l->lock);
> >>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc_wake_up(nn->nfsd=
_serv);
> >>>>>>>>>> +
> >>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The filecach=
e laundrette is shut down after the
> >>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nn->nfsd_ser=
v pointer is cleared, but before the
> >>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * svc_serv is =
freed.
> >>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serv =3D nn->nfsd_se=
rv;
> >>>>>>>>>
> >>>>>>>>> I wonder if this should be READ_ONCE() to tell the compiler=20
> >>>>>>>>> that we
> >>>>>>>>> could race with clearing nn->nfsd_serv.=C2=A0 Would the comment=20
> >>>>>>>>> still be
> >>>>>>>>> needed?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I think we need a comment at least. The linkage between the=20
> >>>>>>>> laundrette
> >>>>>>>> and the nfsd_serv being set to NULL is very subtle. A READ_ONCE()
> >>>>>>>> doesn't convey that well, and is unnecessary here.
> >>>>>>>
> >>>>>>> Why do you say "is unnecessary here" ?
> >>>>>>> If the code were
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (nn->nfsd_serv)
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 svc_wake_up(nn->nfsd_serv);
> >>>>>>> that would be wrong as nn->nfds_serv could be set to NULL between=20
> >>>>>>> the
> >>>>>>> two.
> >>>>>>> And the C compile is allowed to load the value twice because the=20
> >>>>>>> C memory
> >>>>>>> model declares that would have the same effect.
> >>>>>>> While I doubt it would actually change how the code is compiled,=20
> >>>>>>> I think
> >>>>>>> we should have READ_ONCE() here (and I've been wrong before about=20
> >>>>>>> what
> >>>>>>> the compiler will actually do).
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> It's unnecessary because the outcome of either case is acceptable.
> >>>>>>
> >>>>>> When racing with shutdown, either it's NULL and the laundrette won't
> >>>>>> call svc_wake_up(), or it's non-NULL and it will. In the non-NULL=20
> >>>>>> case,
> >>>>>> the call to svc_wake_up() will be a no-op because the threads are=20
> >>>>>> shut
> >>>>>> down.
> >>>>>>
> >>>>>> The vastly common case in this code is that this pointer will be non-
> >>>>>> NULL, because the server is running (i.e. not racing with=20
> >>>>>> shutdown). I
> >>>>>> don't see the need in making all of those accesses volatile.
> >>>>>
> >>>>> One of us is confused.=C2=A0 I hope it isn't me.
> >>>>>
> >>>>
> >>>> It's probably me. I think you have a much better understanding of
> >>>> compiler design than I do. Still...
> >>>>
> >>>>> The hypothetical problem I see is that the C compiler could generate
> >>>>> code to load the value "nn->nfsd_serv" twice.=C2=A0 The first time it=
 is=20
> >>>>> not
> >>>>> NULL, the second time it is NULL.
> >>>>> The first is used for the test, the second is passed to svc_wake_up().
> >>>>>
> >>>>> Unlikely though this is, it is possible and READ_ONCE() is designed
> >>>>> precisely to prevent this.
> >>>>> To quote from include/asm-generic/rwonce.h it will
> >>>>> =C2=A0=C2=A0 "Prevent the compiler from merging or refetching reads"
> >>>>>
> >>>>> A "volatile" access does not add any cost (in this case).=C2=A0 What =
it=20
> >>>>> does
> >>>>> is break any aliasing that the compile might have deduced.
> >>>>> Even if the compiler thinks it has "nn->nfsd_serv" in a register, it
> >>>>> won't think it has the result of READ_ONCE(nn->nfsd_serv) in that=20
> >>>>> register.
> >>>>> And if it needs the result of a previous READ_ONCE(nn->nfsd_serv) it
> >>>>> won't decide that it can just read nn->nfsd_serv again.=C2=A0 It MUST=
 keep
> >>>>> the result of READ_ONCE(nn->nfsd_serv) somewhere until it is not=20
> >>>>> needed
> >>>>> any more.
> >>>>
> >>>> I'm mainly just considering the resulting pointer. There are two
> >>>> possible outcomes to the fetch of nn->nfsd_serv. Either it's a valid
> >>>> pointer that points to the svc_serv, or it's NULL. The resulting code
> >>>> can handle either case, so it doesn't seem like adding READ_ONCE() will
> >>>> create any material difference here.
> >>>>
> >>>> Maybe I should ask it this way: What bad outcome could result if we
> >>>> don't add READ_ONCE() here?
> >>>
> >>> Neil just described it. The compiler would generate two load operations,
> >>> one for the test and one for the function call argument. The first load
> >>> can retrieve a non-NULL address, and the second a NULL address.
> >>>
> >>> I agree a READ_ONCE() is necessary.
> >>>
> >>>
> >>
> >> Now I'm confused:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_serv *serv;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The filecache laundrette is shut down after =
the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nn->nfsd_serv pointer is cleared, but before=
 the
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * svc_serv is freed.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 serv =3D nn->nfsd_serv;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (serv)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc_=
wake_up(serv);
> >>
> >> This code is explicitly asking to fetch nn->nfsd_serv into the serv
> >> variable, and then is testing that copy of the pointer and passing it
> >> into svc_wake_up().
> >>
> >> How is the compiler allowed to suddenly refetch a NULL pointer into
> >> serv after testing that serv is non-NULL?
> >=20
> > There's nothing here that tells the compiler it is not allowed to
> > optimize this into two separate fetches if it feels that is better
> > code. READ_ONCE is what tells the compiler we do not want that re-
> > organization /ever/.
> >=20
> >=20
>=20
> Well, I think you can argue that even if the compiler does split this
> code into two reads of nn->nfsd_serv, it is guaranteed that the read
> value is always the same both times -- I guess that's that the comment
> is arguing, yes?

I don't think that argument can stand.  This code is run from the
filecache laundrette which can still be active when nn->nfsd_serv is set
to NULL.  That is what the comment says: it is only shutdown *after*
->nfsd_serv is cleared.

NeilBrown

