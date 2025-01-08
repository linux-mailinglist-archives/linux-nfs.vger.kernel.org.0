Return-Path: <linux-nfs+bounces-8980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75DA0667F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94C6188A456
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC42036E8;
	Wed,  8 Jan 2025 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="egvB5TSJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ogtn6ic2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="egvB5TSJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ogtn6ic2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487F2036E9
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368916; cv=none; b=DNL4rPJJvOUwOEYS+GkiRP3LQt28fj2vgmEZcln3RTjMmc+GRo0y65wTaMfbPIBQb/p/6c1XxQ4NWGaFjtq6OeYBYXv9cYZa07WlVBbPQIT/aUiWdbzagDamahYUhiJnDrDTfRhJWl06kOBv7O330W0k1KjVHCOy0VUYlM45vig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368916; c=relaxed/simple;
	bh=o0Ys5pgFrtq+idNSluYAHtJtUof5pWBJqZnPU4UM/Hk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gCjsL1eZGCeRkiYQpO8MzMwN6yvT07tm3sG8YYM81LtVmizjNVBGEcvqfjvWkkKVMaCuYAfCKcG0alMybjVkfTSgCzv3Y+rvBsmiR2uMSffTlNeKeP3/M3yqBnPOVc8GszIL5DzGokxv9PEdYdGJ9liGVivmmt3+ks1gjDwH2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=egvB5TSJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ogtn6ic2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=egvB5TSJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ogtn6ic2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C70BF1F385;
	Wed,  8 Jan 2025 20:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736368912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od/ZgTWYtty6qPOjLkfkMPsMcCyJ5TkuT9APAgu8kY8=;
	b=egvB5TSJ8k4JzF4mfxqFBjvviR4aWbz2d/zlAII5h1HmWlKBAipzmKn/5Kj2Hi84BxL2hQ
	Y4uYbkJwK/q9Vpa326l/1EwcLOAIuxCNzp1oJ/Obmw8LU2kHVJL0zlAZ5hd+GSDkmt34GZ
	JhwtCeXrtM7QfAXnMIVRcQWbRFzQWOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736368912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od/ZgTWYtty6qPOjLkfkMPsMcCyJ5TkuT9APAgu8kY8=;
	b=ogtn6ic27Fdu4D63Os0LC1U9DHzuWvZFh+AcIK3B8Q2eMbQD51y2+QXwXNfgQFBuK4CJPl
	zWWtoZi9wsSHz9Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736368912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od/ZgTWYtty6qPOjLkfkMPsMcCyJ5TkuT9APAgu8kY8=;
	b=egvB5TSJ8k4JzF4mfxqFBjvviR4aWbz2d/zlAII5h1HmWlKBAipzmKn/5Kj2Hi84BxL2hQ
	Y4uYbkJwK/q9Vpa326l/1EwcLOAIuxCNzp1oJ/Obmw8LU2kHVJL0zlAZ5hd+GSDkmt34GZ
	JhwtCeXrtM7QfAXnMIVRcQWbRFzQWOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736368912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od/ZgTWYtty6qPOjLkfkMPsMcCyJ5TkuT9APAgu8kY8=;
	b=ogtn6ic27Fdu4D63Os0LC1U9DHzuWvZFh+AcIK3B8Q2eMbQD51y2+QXwXNfgQFBuK4CJPl
	zWWtoZi9wsSHz9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A883F1351A;
	Wed,  8 Jan 2025 20:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pz49Fw7jfmdDOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 08 Jan 2025 20:41:50 +0000
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
Subject: Re: [PATCH] nfsd: add scheduling point in nfsd_file_gc()
In-reply-to: <c205384d-cf12-4dde-8875-e826e4a7c2f6@oracle.com>
References: <>, <c205384d-cf12-4dde-8875-e826e4a7c2f6@oracle.com>
Date: Thu, 09 Jan 2025 07:41:43 +1100
Message-id: <173636890368.22054.15435316321445899208@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 09 Jan 2025, Chuck Lever wrote:
> On 1/7/25 6:01 PM, NeilBrown wrote:
> > On Tue, 07 Jan 2025, Chuck Lever wrote:
> >> On 1/5/25 10:02 PM, NeilBrown wrote:
> >>> On Mon, 06 Jan 2025, Chuck Lever wrote:
> >>>> On 1/5/25 6:11 PM, NeilBrown wrote:
> >>
> >>>>> +		unsigned long num_to_scan =3D min(cnt, 1024UL);
> >>>>
> >>>> I see long delays with fewer than 1024 items on the list. I might
> >>>> drop this number by one or two orders of magnitude. And make it a
> >>>> symbolic constant.
> >>>
> >>> In that case I seriously wonder if this is where the delays are coming
> >>> from.
> >>>
> >>> nfsd_file_dispose_list_delayed() does take and drop a spinlock
> >>> repeatedly (though it may not always be the same lock) and call
> >>> svc_wake_up() repeatedly - although the head of the queue might already
> >>> be woken.  We could optimise that to detect runs with the same nn and
> >>> only take the lock once, and only wake_up once.
> >>>
> >>>>
> >>>> There's another naked integer (8) in nfsd_file_net_dispose() -- how do=
es
> >>>> that relate to this new cap? Should that also be a symbolic constant?
> >>>
> >>> I don't think they relate.
> >>> The trade-off with "8" is:
> >>>     a bigger number might block an nfsd thread for longer,
> >>>       forcing serialising when the work can usefully be done in paralle=
l.
> >>>     a smaller number might needlessly wake lots of threads
> >>>       to share out a tiny amount of work.
> >>>
> >>> The 1024 is simply about "don't hold a spinlock for too long".
> >>
> >> By that, I think you mean list_lru_walk() takes &l->lock for the
> >> duration of the scan? For a long scan, that would effectively block
> >> adding or removing LRU items for quite some time.
> >>
> >> So here's a typical excerpt from a common test:
> >>
> >> kworker/u80:7-206   [003]   266.985735: nfsd_file_unhash: ...
> >>
> >> kworker/u80:7-206   [003]   266.987723: nfsd_file_gc_removed: 1309
> >> entries removed, 2972 remaining
> >>
> >> nfsd-1532  [015]   266.988626: nfsd_file_free: ...
> >>
> >> Here, the nfsd_file_unhash record marks the beginning of the LRU
> >> walk, and the nfsd_file_gc_removed record marks the end. The
> >> timestamps indicate the walk took two milliseconds.
> >>
> >> The nfsd_file_free record above marks the last disposal activity.
> >> That takes almost a millisecond, but as far as I can tell, it
> >> does not hold any locks for long.
> >>
> >> This seems to me like a strong argument for cutting the scan size
> >> down to no more than 32-64 items. Ideally spin locks are supposed
> >> to be held only for simple operations (eg, list_add); this seems a
> >> little outside that window (hence your remark that "a large
> >> nr_to_walk is always a bad idea" -- I now see what you meant).
> >=20
> > This is useful - thanks.
> > So the problem seems to be that holding the list_lru while canning the
> > whole list can block all incoming NFSv3 for a noticeable amount of time
> > - 2 msecs above.  That makes perfect sense and as you say it suggests
> > that the lack of scheduling points isn't really the issue.
> >=20
> > This confirms for me that the list_lru approach is no a good fit for
> > this problem.  I have written a patch which replaces it with a pair of
> > simple lists as I described in my cover letter.
>=20
> Before proceeding with replacement of the LRU, is there interest in
> addressing this issue in LTS kernels as well? If so, then IMO the
> better approach would be to take a variant of your narrower fix for
> v6.14, and then visit the deeper LRU changes for v6.15ff.

That is probably reasonable.  You could take the first patch, drop the
1024 to 64 (or less if testing suggests that is still too high), and
maybe drop he cond_resched().

Thanks,
NeilBrown

