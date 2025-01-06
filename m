Return-Path: <linux-nfs+bounces-8926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07BA01DF3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE3E16378B
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 03:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCB1990C7;
	Mon,  6 Jan 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="euQ3p4ZP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JCkuOWq4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="euQ3p4ZP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JCkuOWq4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E419D899
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736132540; cv=none; b=f4twluC21TWR7a4GTJYYtu/fvp9U0O5XmwwdYJmz/aSqknsJ8weQ0aKD69Kg3mx9jWKW1WKb7X79iRD8+v4IliTzD0vYBJoImrSVRyPK6dMEBOO7NO0ybyX6CYRDm+tUeXh7GZf2FKrzkG5pZ8A76VjkLo8rq4ca00OENIPz+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736132540; c=relaxed/simple;
	bh=biW0x7BDenWDB+KCWmdXhJ9OR7LiYXpu9XkEoIwiOMc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e1tGsEEtANL2WhP0rm5Xln6SUjt6YyhGSnJpzIbRfRLJjXs9t6ktCWbDGt/tk1YhzzPhFrpqaphEJ9/cvx6sksARzXWO6EhaFRvOJDRisDiL4jr68WYTrdp1ZZyuGEAq4ONh/yMwEE16FlKZJ2rgDay0xlZZtqeM0SOBXn5TRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=euQ3p4ZP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JCkuOWq4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=euQ3p4ZP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JCkuOWq4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 075071F74B;
	Mon,  6 Jan 2025 03:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736132536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67MQarqiqwH3RcKjxLosVbTeCKsGKRnG61YkQSIkx/8=;
	b=euQ3p4ZPdORuVBD7V/u/MLIorUrF/18ccUSDqpLN0Gjgs8ed2oDtjsKmdKhkB+qdpSWc4K
	iQGoI45DUQsXZuSQOkE0M1k10V2Deod+r4EiHmZebSA0ZigwlCZLHNU6JfjD8dJHk5dJZ3
	pjodK+MypSmyNaG68lfki3XBhLMJqdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736132536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67MQarqiqwH3RcKjxLosVbTeCKsGKRnG61YkQSIkx/8=;
	b=JCkuOWq49vD3mgKXjcuzqmHW4wyi5OL7DhwzKo4xsswz2MtxzNrM9Wr9T6fEW42aJXmred
	DWY8VrR4ujSmrrBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=euQ3p4ZP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JCkuOWq4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736132536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67MQarqiqwH3RcKjxLosVbTeCKsGKRnG61YkQSIkx/8=;
	b=euQ3p4ZPdORuVBD7V/u/MLIorUrF/18ccUSDqpLN0Gjgs8ed2oDtjsKmdKhkB+qdpSWc4K
	iQGoI45DUQsXZuSQOkE0M1k10V2Deod+r4EiHmZebSA0ZigwlCZLHNU6JfjD8dJHk5dJZ3
	pjodK+MypSmyNaG68lfki3XBhLMJqdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736132536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67MQarqiqwH3RcKjxLosVbTeCKsGKRnG61YkQSIkx/8=;
	b=JCkuOWq49vD3mgKXjcuzqmHW4wyi5OL7DhwzKo4xsswz2MtxzNrM9Wr9T6fEW42aJXmred
	DWY8VrR4ujSmrrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D63E7139AB;
	Mon,  6 Jan 2025 03:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1kYPIrVHe2eHFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 06 Jan 2025 03:02:13 +0000
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
In-reply-to: <de100fd1-b741-4386-ac9c-21f3957d342e@oracle.com>
References: <>, <de100fd1-b741-4386-ac9c-21f3957d342e@oracle.com>
Date: Mon, 06 Jan 2025 14:02:02 +1100
Message-id: <173613252284.22054.16371856139892298093@noble.neil.brown.name>
X-Rspamd-Queue-Id: 075071F74B
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 06 Jan 2025, Chuck Lever wrote:
> On 1/5/25 6:11 PM, NeilBrown wrote:
> > Under a high NFSv3 load with lots of different file being accessed The
> > list_lru of garbage-collectable files can become quite long.
> > 
> > Asking lisT_lru_scan() to scan the whole list can result in a long
> > period during which a spinlock is held and no scheduling is possible.
> > This is impolite.
> > 
> > So only ask list_lru_scan() to scan 1024 entries at a time, and repeat
> > if necessary - calling cond_resched() each time.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >   fs/nfsd/filecache.c | 17 ++++++++++++-----
> >   1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index a1cdba42c4fa..e99a86798e86 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -543,11 +543,18 @@ nfsd_file_gc(void)
> >   {
> >   	LIST_HEAD(dispose);
> >   	unsigned long ret;
> > -
> > -	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > -			    &dispose, list_lru_count(&nfsd_file_lru));
> > -	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > -	nfsd_file_dispose_list_delayed(&dispose);
> > +	unsigned long cnt = list_lru_count(&nfsd_file_lru);
> > +
> > +	while (cnt > 0) {
> 
> Since @cnt is unsigned, it should be safe to use "while (cnt) {"

"while (cnt > 0) {" is equally safe and for me it emphasises that it
is a decreasing counter, not a Bool.  But different people have
different tastes.

> 
> (I might use "total" and "remaining" here -- "cnt", when said aloud,
> leaves me snickering).

"remaining" would be better than "cnt".

> 
> 
> > +		unsigned long num_to_scan = min(cnt, 1024UL);
> 
> I see long delays with fewer than 1024 items on the list. I might
> drop this number by one or two orders of magnitude. And make it a
> symbolic constant.

In that case I seriously wonder if this is where the delays are coming
from.

nfsd_file_dispose_list_delayed() does take and drop a spinlock
repeatedly (though it may not always be the same lock) and call
svc_wake_up() repeatedly - although the head of the queue might already
be woken.  We could optimise that to detect runs with the same nn and
only take the lock once, and only wake_up once.

> 
> There's another naked integer (8) in nfsd_file_net_dispose() -- how does
> that relate to this new cap? Should that also be a symbolic constant?

I don't think they relate.
The trade-off with "8" is:
  a bigger number might block an nfsd thread for longer,
    forcing serialising when the work can usefully be done in parallel.
  a smaller number might needlessly wake lots of threads
    to share out a tiny amount of work.

The 1024 is simply about "don't hold a spinlock for too long".

> 
> 
> > +		ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > +				    &dispose, num_to_scan);
> > +		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> > +		nfsd_file_dispose_list_delayed(&dispose);
> 
> I need to go back and review the function traces to see where the
> delays add up -- to make sure rescheduling here, rather than at some
> other point, is appropriate. It probably is, but my memory fails me
> these days.

I would like to see those function traces too.

> 
> 
> > +		cnt -= num_to_scan;
> > +		if (cnt)
> > +			cond_resched();
> 
> Another approach might be to poke the laundrette again and simply
> exit here, but I don't feel strongly about that.

That wouldn't work without storing the 'remaining' count somewhere.
With the current design we need to scan the whole list every 2 seconds.

Thanks,
NeilBrown


> 
> 
> > +	}
> >   }
> >   
> >   static void
> 
> 
> -- 
> Chuck Lever
> 


