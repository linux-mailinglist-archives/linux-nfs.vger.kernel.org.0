Return-Path: <linux-nfs+bounces-9494-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE17A19A23
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35203166231
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008741AF4EA;
	Wed, 22 Jan 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RsfdlJg9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sSac7W3O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RsfdlJg9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sSac7W3O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442451C5D49
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580051; cv=none; b=PKBYzZP4ekT+1+YcV8C2WbipKBquAI7rziuUWfUdmqR1fZV7id4yNT6xu1QYAyy2N5UB4oHpCsRQtEW4zeGgg9nudFsMbWg9Tcjpdfy/4J4LkPrEnm18Lp6Bm8rOxMpO/YvbzPw9LAd2s7sd7VTwmbDM0eWMD6cC8OKtnBz01Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580051; c=relaxed/simple;
	bh=pqNc5siisFJEYff4YUZsMbU4ezOmeAq7wDfg3gv4f3k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Lumr66WewTQzPhzxPc3+EG/q4IYzkVKepOya48PprRO/yH+fJlIIroFfs77YSKlKoWUBTw8cfvFUun2eZFpLJcUY5xNP5bLQ7eUI1Bx9cKIMGlyreWBwhZtiQOJnoSf1KBPwLt7hwC1sxGYyuLA5R3tdhEYRwgPTWK3hsvspZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RsfdlJg9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sSac7W3O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RsfdlJg9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sSac7W3O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7898421178;
	Wed, 22 Jan 2025 21:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737580048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZpb0xM7rRckZK/O68AS+Txj1rCcIJaKABms19BHDBI=;
	b=RsfdlJg9UaVIqsaNiUJ5nPPwPigjH2v9l6jih+dlzuNvDq+1IbzF6d58y9ySc8/EZQGS1X
	3589zijCMC8Kyth4FI7KMq5uADUSXnUdcyepwoCZygBYQohLHfcpyFGLXIei8jCK9nZhye
	Ke6sU7yNZkC+Dpauo0UP/yUZAH443gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737580048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZpb0xM7rRckZK/O68AS+Txj1rCcIJaKABms19BHDBI=;
	b=sSac7W3Ol2kc1PJ62DEvJCbDGFaK6AwXQfYHvQvF0t69Z08cFvhwuelS5FkIuSJ4FWAg2E
	yQUst8+IL2oM7tAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737580048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZpb0xM7rRckZK/O68AS+Txj1rCcIJaKABms19BHDBI=;
	b=RsfdlJg9UaVIqsaNiUJ5nPPwPigjH2v9l6jih+dlzuNvDq+1IbzF6d58y9ySc8/EZQGS1X
	3589zijCMC8Kyth4FI7KMq5uADUSXnUdcyepwoCZygBYQohLHfcpyFGLXIei8jCK9nZhye
	Ke6sU7yNZkC+Dpauo0UP/yUZAH443gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737580048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZpb0xM7rRckZK/O68AS+Txj1rCcIJaKABms19BHDBI=;
	b=sSac7W3Ol2kc1PJ62DEvJCbDGFaK6AwXQfYHvQvF0t69Z08cFvhwuelS5FkIuSJ4FWAg2E
	yQUst8+IL2oM7tAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A628136A1;
	Wed, 22 Jan 2025 21:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M70wBA5ekWdQNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 21:07:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 4/4] nfsd: filecache: change garbage collection to a timer.
In-reply-to: <b53c55c44e24cf562a539740496c37d96be1ccd7.camel@kernel.org>
References: <>, <b53c55c44e24cf562a539740496c37d96be1ccd7.camel@kernel.org>
Date: Thu, 23 Jan 2025 08:07:19 +1100
Message-id: <173758003937.22054.14500808810999904597@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 23 Jan 2025, Jeff Layton wrote:
> On Thu, 2025-01-23 at 07:39 +1100, NeilBrown wrote:
> > On Thu, 23 Jan 2025, Jeff Layton wrote:
> > 
> > > > @@ -854,7 +855,9 @@ nfsd_alloc_fcache_disposal(void)
> > > >  	if (!l)
> > > >  		return NULL;
> > > >  	spin_lock_init(&l->lock);
> > > > -	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
> > > > +	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
> > > > +	INIT_LIST_HEAD(&l->recent);
> > > > +	INIT_LIST_HEAD(&l->older);
> > > >  	INIT_LIST_HEAD(&l->recent);
> > > >  	INIT_LIST_HEAD(&l->older);
> > > 
> > > No need to do the list initializations twice. ^^^
> > 
> > Thanks.  I fixed up a few other merge-errors too.
> > 
> > > 
> > > It does seem like this is lightweight enough now that we can do the GC
> > > in interrupt context. I'm not certain that's best for latency, but it's
> > > worth experimenting.
> > 
> > What sort of latency are you thinking of?  By avoiding a scheduler
> > switch into the workqueue task we should be reducing overhead.
> > In the old code a timer would wake a thread which would need to be
> > scheduled to do the work.  In the new thread and identical time will do
> > the work directly.
> > 
> > 
> 
> Anytime we have to take *_bh locks, we block interrupts. In this case,
> I think you're right that that's probably the lesser evil, but we will
> be taking these locks somewhat frequently. It's certainly worth
> starting here though, and only offloading to a workqueue if that proves
> to be a problem.

We only block soft-interrupts, not hard interrupts.  So yes it could
cause some latency for softirqs.
If we really cared we could spin_try_lock in the timer and if that
fails, don't bother but reschedule the timer for a shorter timeout.

But I agree that we don't need to fix until we see a problem.

Thanks,
NeilBrown

