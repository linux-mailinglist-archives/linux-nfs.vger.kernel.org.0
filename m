Return-Path: <linux-nfs+bounces-8964-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C76A04CFF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 00:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC97162423
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 23:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8011E3786;
	Tue,  7 Jan 2025 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V28xBRFR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y0t4taIF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V28xBRFR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y0t4taIF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF981F4E5C
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290927; cv=none; b=nNWGgUYTn6cQG/v6XslnUmivfzSyePiXS1KWgVqkHwkCE5LAyW2Ubfa61H/sTNOQqQYZ3SJKoNGMpbr401bVr3EWr69c142YxNIcd+9lunli/HflYtn6ILLIgX6W+OtvZ/UCeyd1Simp9TOEbOK/0+BkknaPqdgaIvA7fZVGHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290927; c=relaxed/simple;
	bh=I8KC1DaI25M49fVFkylWftHzoZUVwD9Dbe5oN5BzN4o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CNuOqhjZ9weq1u5ZaA0pBQ8CSOugT01kKrPdDDR8d2jdP1GB4zjqKDVO1+ingTjrezSk6+vmXKkZ6PBxqep8msvCYtbxwHABi6EtLy2BDgenKmGp+trIu1jUjuhUkjpwA0IaFfsFC51woNkF8QNqG7TnMzMIvWqv5EFZ35HdyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V28xBRFR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y0t4taIF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V28xBRFR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y0t4taIF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A53C51F385;
	Tue,  7 Jan 2025 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736290923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h52iajhioiDQ9EYVnsaUJEQEvzYBltWSYmCP9JN5B6M=;
	b=V28xBRFREek12TneDSgflA8vUGN5Uzw3R9ZmyF+2uJcULZonCPbSMnkNn+QMhuhgTurXR6
	WqLxVMOnMG75YvGT2BRvzyfxxt1W2ilEMloa53ouqe7dBHkNqSjIkSEgs3AT7fxqw8gigH
	JV80nXbsFByoof4CwI5WktHP/GtMgM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736290923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h52iajhioiDQ9EYVnsaUJEQEvzYBltWSYmCP9JN5B6M=;
	b=y0t4taIF/w4x4d49lxYObvdCKsVLpRDNbwn0Fl6D8ymgDd5HW9hsDJICSsY88fPhCPpPRM
	jsviG/F8bC3CLkBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V28xBRFR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y0t4taIF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736290923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h52iajhioiDQ9EYVnsaUJEQEvzYBltWSYmCP9JN5B6M=;
	b=V28xBRFREek12TneDSgflA8vUGN5Uzw3R9ZmyF+2uJcULZonCPbSMnkNn+QMhuhgTurXR6
	WqLxVMOnMG75YvGT2BRvzyfxxt1W2ilEMloa53ouqe7dBHkNqSjIkSEgs3AT7fxqw8gigH
	JV80nXbsFByoof4CwI5WktHP/GtMgM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736290923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h52iajhioiDQ9EYVnsaUJEQEvzYBltWSYmCP9JN5B6M=;
	b=y0t4taIF/w4x4d49lxYObvdCKsVLpRDNbwn0Fl6D8ymgDd5HW9hsDJICSsY88fPhCPpPRM
	jsviG/F8bC3CLkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8028213763;
	Tue,  7 Jan 2025 23:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q9DNDGmyfWfISAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 07 Jan 2025 23:02:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
In-reply-to: <e8eda0b1-c55f-4f86-8f7e-3c6a50dacac8@oracle.com>
References: <>, <e8eda0b1-c55f-4f86-8f7e-3c6a50dacac8@oracle.com>
Date: Wed, 08 Jan 2025 10:01:58 +1100
Message-id: <173629091812.22054.10406068450776372683@noble.neil.brown.name>
X-Rspamd-Queue-Id: A53C51F385
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
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 07 Jan 2025, Chuck Lever wrote:
> On 1/5/25 10:02 PM, NeilBrown wrote:
> > On Mon, 06 Jan 2025, Chuck Lever wrote:
> >> On 1/5/25 6:11 PM, NeilBrown wrote:
> 
> >>> +		unsigned long num_to_scan = min(cnt, 1024UL);
> >>
> >> I see long delays with fewer than 1024 items on the list. I might
> >> drop this number by one or two orders of magnitude. And make it a
> >> symbolic constant.
> > 
> > In that case I seriously wonder if this is where the delays are coming
> > from.
> > 
> > nfsd_file_dispose_list_delayed() does take and drop a spinlock
> > repeatedly (though it may not always be the same lock) and call
> > svc_wake_up() repeatedly - although the head of the queue might already
> > be woken.  We could optimise that to detect runs with the same nn and
> > only take the lock once, and only wake_up once.
> > 
> >>
> >> There's another naked integer (8) in nfsd_file_net_dispose() -- how does
> >> that relate to this new cap? Should that also be a symbolic constant?
> > 
> > I don't think they relate.
> > The trade-off with "8" is:
> >    a bigger number might block an nfsd thread for longer,
> >      forcing serialising when the work can usefully be done in parallel.
> >    a smaller number might needlessly wake lots of threads
> >      to share out a tiny amount of work.
> > 
> > The 1024 is simply about "don't hold a spinlock for too long".
> 
> By that, I think you mean list_lru_walk() takes &l->lock for the
> duration of the scan? For a long scan, that would effectively block
> adding or removing LRU items for quite some time.
> 
> So here's a typical excerpt from a common test:
> 
> kworker/u80:7-206   [003]   266.985735: nfsd_file_unhash: ...
> 
> kworker/u80:7-206   [003]   266.987723: nfsd_file_gc_removed: 1309 
> entries removed, 2972 remaining
> 
> nfsd-1532  [015]   266.988626: nfsd_file_free: ...
> 
> Here, the nfsd_file_unhash record marks the beginning of the LRU
> walk, and the nfsd_file_gc_removed record marks the end. The
> timestamps indicate the walk took two milliseconds.
> 
> The nfsd_file_free record above marks the last disposal activity.
> That takes almost a millisecond, but as far as I can tell, it
> does not hold any locks for long.
> 
> This seems to me like a strong argument for cutting the scan size
> down to no more than 32-64 items. Ideally spin locks are supposed
> to be held only for simple operations (eg, list_add); this seems a
> little outside that window (hence your remark that "a large
> nr_to_walk is always a bad idea" -- I now see what you meant).

This is useful - thanks.
So the problem seems to be that holding the list_lru while canning the
whole list can block all incoming NFSv3 for a noticeable amount of time
- 2 msecs above.  That makes perfect sense and as you say it suggests
that the lack of scheduling points isn't really the issue.

This confirms for me that the list_lru approach is no a good fit for
this problem.  I have written a patch which replaces it with a pair of
simple lists as I described in my cover letter.

It is a bit large and needs careful review.  In particular I haven't
given thought to the tracepoints which might need to be moved or changed
or discarded.

Thanks,
NeilBrown

