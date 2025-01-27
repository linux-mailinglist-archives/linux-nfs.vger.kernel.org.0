Return-Path: <linux-nfs+bounces-9709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57675A20082
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 23:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C33018874C4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B81DCB24;
	Mon, 27 Jan 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="biizl2Mx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EmYwWyIO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="biizl2Mx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EmYwWyIO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38881DC197
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016528; cv=none; b=DMNekwDUjoK1A3yiUxZn+Hw1rsbPSkZtg3neaGUC2lY9fu6aFZ/79nOOBEi0hVMnTyQVLsY+9zrQ711KqvZntcmBxiWOtlQqzpD5IOYJphWJzHbbsM9198Hi3bi5efORas5Mm1F/m7wGihV0AbSWW/1GAFDQF5Rqf40JKd19CBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016528; c=relaxed/simple;
	bh=7jC6xzL4kXojHoWOoA9eL0uNvPuaRl4QPGCAiOHVW7k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FLy0olRUSVoQS3KpDp1n94FerfYDciiLTykiHonG3Xcc6LrUsQBMfZICIqUa8MCCSq7NOY+3GJHeP9InERAqbRuD2y7u8yepb8JK51ROZiWn+NR0vwlrqtUp+dP+Ulj4rBr+aB7qDTfKuKYsQbdw9lq83qD1rak5FPVnfztjw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=biizl2Mx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EmYwWyIO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=biizl2Mx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EmYwWyIO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A3E5210F8;
	Mon, 27 Jan 2025 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738016522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7sxcatuMpv2yK0JYCxDM9Am5nvYIMJvT+Pmpp+41zE=;
	b=biizl2MxRNrM8QhyxMa0k7tfsME4xQwv1nLr6h5Vl8QhK9v6qmB39qG0/D4WSVWxXRVCj6
	2VjxhKxwnaip2MGhzQHxpmiHGXS5+D0yIcfF9zHfcazemwZJEgT1S0bojzcIWt7rl3I3a4
	g/2sRpb6i7Ux62ea76guEDkdAVJoJAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738016522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7sxcatuMpv2yK0JYCxDM9Am5nvYIMJvT+Pmpp+41zE=;
	b=EmYwWyIONYaaqcWq9OW8E/ceKfZ+BJk5tT4k1Sg52IvhzdFualHDQSL8Z+x3QkccruMmla
	Zj/0oPhyebZu80Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=biizl2Mx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EmYwWyIO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738016522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7sxcatuMpv2yK0JYCxDM9Am5nvYIMJvT+Pmpp+41zE=;
	b=biizl2MxRNrM8QhyxMa0k7tfsME4xQwv1nLr6h5Vl8QhK9v6qmB39qG0/D4WSVWxXRVCj6
	2VjxhKxwnaip2MGhzQHxpmiHGXS5+D0yIcfF9zHfcazemwZJEgT1S0bojzcIWt7rl3I3a4
	g/2sRpb6i7Ux62ea76guEDkdAVJoJAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738016522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7sxcatuMpv2yK0JYCxDM9Am5nvYIMJvT+Pmpp+41zE=;
	b=EmYwWyIONYaaqcWq9OW8E/ceKfZ+BJk5tT4k1Sg52IvhzdFualHDQSL8Z+x3QkccruMmla
	Zj/0oPhyebZu80Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A144137C0;
	Mon, 27 Jan 2025 22:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xuPIBwgHmGezEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 22:22:00 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 nfsd_file_shrinker to be per-net
In-reply-to: <d4183be8-5ef0-4db1-adf8-f27a576714e6@oracle.com>
References: <>, <d4183be8-5ef0-4db1-adf8-f27a576714e6@oracle.com>
Date: Tue, 28 Jan 2025 09:21:48 +1100
Message-id: <173801650852.22054.3481534429906924393@noble.neil.brown.name>
X-Rspamd-Queue-Id: 8A3E5210F8
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 28 Jan 2025, Chuck Lever wrote:
> On 1/26/25 5:33 PM, NeilBrown wrote:
> > On Fri, 24 Jan 2025, Chuck Lever wrote:
> >> On 1/22/25 5:10 PM, NeilBrown wrote:
> >>> On Thu, 23 Jan 2025, Chuck Lever wrote:
> >>>> On 1/21/25 10:54 PM, NeilBrown wrote:
> >>>>> The final freeing of nfsd files is done by per-net nfsd threads (which
> >>>>> call nfsd_file_net_dispose()) so it makes some sense to make more of =
the
> >>>>> freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.
> >>>>>
> >>>>> This is a step towards replacing the list_lru with simple lists which
> >>>>> each share the per-net lock in nfsd_fcache_disposal and will require
> >>>>> less list walking.
> >>>>>
> >>>>> As the net is always shutdown before there is any chance that the rest
> >>>>> of the filecache is shut down we can removed the tests on
> >>>>> NFSD_FILE_CACHE_UP.
> >>>>>
> >>>>> For the filecache stats file, which assumes a global lru, we keep a
> >>>>> separate counter which includes all files in all netns lrus.
> >>>>
> >>>> Hey Neil -
> >>>>
> >>>> One of the issues with the current code is that the contention for
> >>>> the LRU lock has been effectively buried. It would be nice to have a
> >>>> way to expose that contention in the new code.
> >>>>
> >>>> Can this patch or this series add some lock class infrastructure to
> >>>> help account for the time spent contending for these dynamically
> >>>> allocated spin locks?
> >>>
> >>> Unfortunately I don't know anything about accounting for lock contention
> >>> time.
> >>>
> >>> I know about lock classes for the purpose of lockdep checking but not
> >>> how they relate to contention tracking.
> >>> Could you give me some pointers?
> >>
> >> Sticking these locks into a class is all you need to do. When lockstat
> >> is enabled, it automatically accumulates the statistics for all locks
> >> in a class, and treats that as a single lock in /proc/lock_stat.
> >>
> >=20
> > Ahh thanks.  So I don't need to do anything as this lock has it's own
> > spin_lock_init() so it already has it's own class.
> > However.... the init call is :
> >=20
> > 	spin_lock_init(&l->lock);
> >=20
> > so that appear in /proc/lock_stat as
> >=20
> >        &l->lock:
> > or maybe
> >        &l->lock/1:
> > or even
> >        &l->lock/2:
>=20
> Well, that's the problem, as I see it. They might all appear separately,
> but we want lock_stat to group them together so we can see the aggregate
> wait time and contention metrics.

That isn't what is happening here.

$ git grep 'spin_lock_init(&l->lock)'
fs/bcachefs/nocow_locking.c:            spin_lock_init(&l->lock);
fs/nfsd/filecache.c:    spin_lock_init(&l->lock);
kernel/bpf/bpf_lru_list.c:      raw_spin_lock_init(&l->lock);
mm/list_lru.c:  spin_lock_init(&l->lock);

so there are 4 completely different locks that can appear in
/proc/locks_stat as &l->lock.  So subsequent ones are given numeric
suffixes.=20

>=20
> Have a look at svc_reclassify_socket().

Ahh - nice.
I was thinking it would be good to have
    spin_lock_init_name()
for cases like this.  Maybe I should post a patch..

Thanks,
NeilBrown

>=20
>=20
> > Maybe I should change the "l" to something more unique. "nfd" ??
> > Or I could actually define a lock_class_key and call __spin_lock_init:
> >=20
> >     __skin_lock_init(&l->lock, "nfsd_fcache_disposal->lock", &key,
> >       false);
> >=20
> > There is no precedent for that though.
> >=20
> > NeilBrown
> >=20
>=20
>=20
> --=20
> Chuck Lever
>=20


