Return-Path: <linux-nfs+bounces-9489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A462FA199F0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 21:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609D21889220
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20A21C1753;
	Wed, 22 Jan 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZvEEviFV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9CDp/MRT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZvEEviFV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9CDp/MRT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEE1AF0BB
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578366; cv=none; b=F+SLYZyeMOOPDWJR2PECvd8ApZp31yzwCMekyNlzBOvwjwpg/EwMG7wGKFLr6e/r69hV69InP09+OOjTreZQctyTYUiRM16ujL/1HnfmRW5n50hDlVb4V4vmpjPJOMx4DgQqkk0yJ0skJTMtevtYGRYF2Y8b8hZd9NrzL7goV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578366; c=relaxed/simple;
	bh=pXviSzTJZ3lFDABWo/aQQWIi1xEUG3HFZ/sHANN+E1g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Xk8EqN+1Wr9rp6gOEzWXGkagR6Zmcrtxtgpp3JFuLLkXz4dG7Nuhh8Y31QzZOHoFf1kgBAKp9ZsKbWo8gMQcCkRsWWzfyNi1//MuNomYGkmTdAo7VfKgnagXdlGytWBfccDybbN2QqVngA1IPTVoOiBokg2wC6W2HAtlE11GU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZvEEviFV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9CDp/MRT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZvEEviFV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9CDp/MRT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB3E021137;
	Wed, 22 Jan 2025 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737578362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gjUsjtCzCfRP0nmBchPG1PXuh/6+s3YGNrQSu9JZSU=;
	b=ZvEEviFVGD8SC4y+eHDoKI8O3Q+o5RBs1t3IdSarEuKBVj3TazIBhxtE4b6JGD8zsFo3Ic
	MeaN2Gdhbsxo36goc6emiNNAa6HxfeX25exVvG23ebLCSAPaCI1L1JJLmtPf+UNASzSiOZ
	whOdaJgE5DmGpwQOAws41bTi9Jfr0PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737578362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gjUsjtCzCfRP0nmBchPG1PXuh/6+s3YGNrQSu9JZSU=;
	b=9CDp/MRT8L0i1z5phx7oTChe8rVvUYo2IKz2GiTbBuJC8z82GoSWWLSJ0cEIjhtwVBV/Cm
	oQ/V0yOJhvSUENCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZvEEviFV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9CDp/MRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737578362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gjUsjtCzCfRP0nmBchPG1PXuh/6+s3YGNrQSu9JZSU=;
	b=ZvEEviFVGD8SC4y+eHDoKI8O3Q+o5RBs1t3IdSarEuKBVj3TazIBhxtE4b6JGD8zsFo3Ic
	MeaN2Gdhbsxo36goc6emiNNAa6HxfeX25exVvG23ebLCSAPaCI1L1JJLmtPf+UNASzSiOZ
	whOdaJgE5DmGpwQOAws41bTi9Jfr0PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737578362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gjUsjtCzCfRP0nmBchPG1PXuh/6+s3YGNrQSu9JZSU=;
	b=9CDp/MRT8L0i1z5phx7oTChe8rVvUYo2IKz2GiTbBuJC8z82GoSWWLSJ0cEIjhtwVBV/Cm
	oQ/V0yOJhvSUENCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 983CD136A1;
	Wed, 22 Jan 2025 20:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +jfjEnhXkWeXKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 20:39:20 +0000
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
In-reply-to: <fcad449de65d3b7d9379bd33b7a29ca3fde79482.camel@kernel.org>
References: <>, <fcad449de65d3b7d9379bd33b7a29ca3fde79482.camel@kernel.org>
Date: Thu, 23 Jan 2025 07:39:16 +1100
Message-id: <173757835699.22054.5691560323010037545@noble.neil.brown.name>
X-Rspamd-Queue-Id: BB3E021137
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu, 23 Jan 2025, Jeff Layton wrote:

> > @@ -854,7 +855,9 @@ nfsd_alloc_fcache_disposal(void)
> >  	if (!l)
> >  		return NULL;
> >  	spin_lock_init(&l->lock);
> > -	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
> > +	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
> > +	INIT_LIST_HEAD(&l->recent);
> > +	INIT_LIST_HEAD(&l->older);
> >  	INIT_LIST_HEAD(&l->recent);
> >  	INIT_LIST_HEAD(&l->older);
> 
> No need to do the list initializations twice. ^^^

Thanks.  I fixed up a few other merge-errors too.

> 
> It does seem like this is lightweight enough now that we can do the GC
> in interrupt context. I'm not certain that's best for latency, but it's
> worth experimenting.

What sort of latency are you thinking of?  By avoiding a scheduler
switch into the workqueue task we should be reducing overhead.
In the old code a timer would wake a thread which would need to be
scheduled to do the work.  In the new thread and identical time will do
the work directly.

Thanks,
NeilBrown


> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 


