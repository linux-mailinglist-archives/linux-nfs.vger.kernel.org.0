Return-Path: <linux-nfs+bounces-7995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC49CD64F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 05:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495D428318B
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 04:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248861FEB;
	Fri, 15 Nov 2024 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="re5vjSth";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mdsZR53t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="re5vjSth";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mdsZR53t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62B17B439
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731646580; cv=none; b=YpxuvENsk/FxRRmGbGy17bE4rlQxPuOarrCbEzHKZFSOBVv+LDXcm468Z5Gf4XSPcLcYN3BxRV7rqvankglCCZk9IJKAELNji9P9gHnrnA9lJ8D3SWuaoNMFZHEiGakGcNC1h4lH2WPMCtPdPQuMo+gr42PSX1t4GNLyRm0paT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731646580; c=relaxed/simple;
	bh=sHQmyJ0RkkCYf1NzsK5WP04PnBTkp+NbeeX/MQ2vyA4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C2Wa0hG9BFFDLqJae8k+OXapJwM8T4cQgv7rGhIu8wM+X5eVD8w1rQ3N64nQBggm4/ly+AoaYrZgerTiiBTpcRGH9cAVCWgPK7J09Uwno45V0ZzuGXePgu7V4gSsGxFQ2LpXY+NKYFX2mws//rkYPmeqAjBJ1V2exgrZbmQMG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=re5vjSth; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mdsZR53t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=re5vjSth; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mdsZR53t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 663FB21195;
	Fri, 15 Nov 2024 04:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731646576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuQE5MnpBk70EBkNiK4D/xccIUwk5EF22mWiYD06dOY=;
	b=re5vjSthWor1AHHdXO7/m87WuPZ82SPbBtpaSxM54WBD82nAOrabJQA29N5HUDHYDcBPJx
	OFg9ffpoXJ3Uobj3fXBAc9yu/a6vYfbL+Q7+uNkoXQ/TQU9XeJ+xp/Xx7CQUaEdEjGfkuw
	Y/9WtUX7LXCICGbpSZRqYgET6tMjMz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731646576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuQE5MnpBk70EBkNiK4D/xccIUwk5EF22mWiYD06dOY=;
	b=mdsZR53t2ubBmUNRJYSeH6DpWAdru5wrpg7ZGzt+XCWJO8bNHGeqH+PAgRNhEjUQZF/qpK
	bI03L8KsbF1D5hDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=re5vjSth;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mdsZR53t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731646576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuQE5MnpBk70EBkNiK4D/xccIUwk5EF22mWiYD06dOY=;
	b=re5vjSthWor1AHHdXO7/m87WuPZ82SPbBtpaSxM54WBD82nAOrabJQA29N5HUDHYDcBPJx
	OFg9ffpoXJ3Uobj3fXBAc9yu/a6vYfbL+Q7+uNkoXQ/TQU9XeJ+xp/Xx7CQUaEdEjGfkuw
	Y/9WtUX7LXCICGbpSZRqYgET6tMjMz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731646576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuQE5MnpBk70EBkNiK4D/xccIUwk5EF22mWiYD06dOY=;
	b=mdsZR53t2ubBmUNRJYSeH6DpWAdru5wrpg7ZGzt+XCWJO8bNHGeqH+PAgRNhEjUQZF/qpK
	bI03L8KsbF1D5hDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 034DD13485;
	Fri, 15 Nov 2024 04:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SN1CKm3UNmekcgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Nov 2024 04:56:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Daire Byrne" <daire@dneg.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on demand
In-reply-to:
 <CAPt2mGN7is0xOqBxy62WwJ_iPXQ0fjvpv2MVEEwYqxvZSFY30w@mail.gmail.com>
References: <20241113055345.494856-1-neilb@suse.de>,
 <CAPt2mGN7is0xOqBxy62WwJ_iPXQ0fjvpv2MVEEwYqxvZSFY30w@mail.gmail.com>
Date: Fri, 15 Nov 2024 15:56:08 +1100
Message-id: <173164656863.1734440.5228838461812970848@noble.neil.brown.name>
X-Rspamd-Queue-Id: 663FB21195
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux-nfs.org:url,noble.neil.brown.name:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 13 Nov 2024, Daire Byrne wrote:
> Neil,
>=20
> I'm curious if this work relates to:
>=20
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D375
> https://lore.kernel.org/all/CAPt2mGMZh9=3DVwcqjh0J4XoTu3stOnKwswdzApL4wCA_u=
sOFV_g@mail.gmail.com

Yes, it could possibly help with that - though more work would be
needed.
nfsd currently has a hard limit of 160 slots per session.  That wouldn't
be enough I suspect.  The Linux client has a hard limit of 1024.  That
might be enough.
Allowed nfsd to have 1024 (or more) shouldn't be too hard...

>=20
> As my thread described, we currently use NFSv3 for our high latency
> NFS re-export cases simply because it performs way better for parallel
> client operations. You see, when you use re-exporting serving many
> clients, you are in effect taking all those client operations and
> stuffing them through a single client (the re-export server) which
> then becomes a bottleneck. Add any kind of latency on top (>10ms) and
> the NFSD_CACHE_SIZE_SLOTS_PER_SESSION (32) for NFSv4 becomes a major
> bottleneck for a single client (re-export server).
>=20
> We also used your "VFS: support parallel updates in the one directory"
> patches for similar reasons up until I couldn't port it to newer
> kernels anymore (my kernel code munging skills are not sufficient!).

Yeah - I really should get back to that.  Al and Linus suggested some
changes and I just never got around to making them.

Thanks,
NeilBrown


>=20
> Sorry to spam the thread if I am misinterpreting what this patch set
> is all about.
>=20
> Daire
>=20
>=20
> On Wed, 13 Nov 2024 at 05:54, NeilBrown <neilb@suse.de> wrote:
> >
> > This patch set aims to allocate session-based DRC slots on demand, and
> > free them when not in use, or when memory is tight.
> >
> > I've tested with NFSD_MAX_UNUSED_SLOTS set to 1 so that freeing is
> > overly agreesive, and with lots of printks, and it seems to do the right
> > thing, though memory pressure has never freed anything - I think you
> > need several clients with a non-trivial number of slots allocated before
> > the thresholds in the shrinker code will trigger any freeing.
> >
> > I haven't made use of the CB_RECALL_SLOT callback.  I'm not sure how
> > useful that is.  There are certainly cases where simply setting the
> > target in a SEQUENCE reply might not be enough, but I doubt they are
> > very common.  You would need a session to be completely idle, with the
> > last request received on it indicating that lots of slots were still in
> > use.
> >
> > Currently we allocate slots one at a time when the last available slot
> > was used by the client, and only if a NOWAIT allocation can succeed.  It
> > is possible that this isn't quite agreesive enough.  When performing a
> > lot of writeback it can be useful to have lots of slots, but memory
> > pressure is also likely to build up on the server so GFP_NOWAIT is likely
> > to fail.  Maybe occasionally using a firmer request (outside the
> > spinlock) would be justified.
> >
> > We free slots when the number of unused slots passes some threshold -
> > currently 6 (because ...  why not).  Possible a hysteresis should be
> > added so we don't free unused slots for a least N seconds.
> >
> > When the shrinker wants to apply presure we remove slots equally from
> > all sessions.  Maybe there should be some proportionality but that would
> > be more complex and I'm not sure it would gain much.  Slot 0 can never
> > be freed of course.
> >
> > I'm very interested to see what people think of the over-all approach,
> > and of the specifics of the code.
> >
> > Thanks,
> > NeilBrown
> >
> >
> >  [PATCH 1/4] nfsd: remove artificial limits on the session-based DRC
> >  [PATCH 2/4] nfsd: allocate new session-based DRC slots on demand.
> >  [PATCH 3/4] nfsd: free unused session-DRC slots
> >  [PATCH 4/4] nfsd: add shrinker to reduce number of slots allocated
> >
>=20


