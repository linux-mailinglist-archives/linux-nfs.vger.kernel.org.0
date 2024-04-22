Return-Path: <linux-nfs+bounces-2914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656238AC38C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 07:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4AB2106C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4614A81;
	Mon, 22 Apr 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZZg4khR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZvxCqbi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6k/2h/l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ClPrvdm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7EF9EB
	for <linux-nfs@vger.kernel.org>; Mon, 22 Apr 2024 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713762028; cv=none; b=nqAERjk81hMbnL5/W85GAoaO61xG3o4qAIqGQeiYZZXp3nQUtCCacsV8UqNDvabvvhTqRky/igNdRhpXFYGitrwQyjFPajJoe77E30cy4TS1QQMdrD+OyxQTW7/cIBqeNSp+oRPxT2IcEyy0UbcuaT1TmjuRbdvVBpJD/KpteSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713762028; c=relaxed/simple;
	bh=attXa3oG1I3/COTxUaEy99F/ejGy292UUAOPwNesi+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvfPb8a0QV21EgjTuk/i5MDFWwTjHdowIPqXWMCOQpE/GvJCUOPuvV2M0lndgICdQmycozSuPvIE03hAhx+yEp0ZrLkc9KEo+t5nUSb7qsbd92SMny6ZekSefh+PnIVUiDluC5/PrFRAQDSJfWBq3gJn39eJbutzDiDbBfhfVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZZg4khR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZvxCqbi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6k/2h/l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ClPrvdm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3E4820223;
	Mon, 22 Apr 2024 05:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713762025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q37LHbohpv6nAU0jbrurpg4hVLaEc9j9h8ykK9eiNOA=;
	b=MZZg4khRLihiibTSlbhDvISEhRqg1w5xk+PA2YSL3P0Tpuqh7T/NNnpdVEgPuxkKGWhbTm
	2odihXA9EgbHtDbmxftHnOPQ23NpdYoGVHjrR3LtBbFJbqUT+0vnYrYZAvGJjjSoTj4zc9
	ydHgocPXkBZEkkpP8w1nsRRdviEAmmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713762025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q37LHbohpv6nAU0jbrurpg4hVLaEc9j9h8ykK9eiNOA=;
	b=MZvxCqbiE8eMCKqtLjn8Y5MzlFkwNwjDQK7olu7iU5VKxV7Tgk459QVTX4+pE3722if9ER
	ITHcOAnmzCs/aFDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713762023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q37LHbohpv6nAU0jbrurpg4hVLaEc9j9h8ykK9eiNOA=;
	b=T6k/2h/l8Vf2xrQjY5KNSEU3BeRKiWZaUfGYXxyRGl5GCIHgQoxvLLso8NbwnqCI/brWXI
	+N4IkpZrx+LqlgLZHSTMfd9gM6QX1JbV4QycmgL20UJPnQQGoGwAjRKOOKnnHgBsYKLlcU
	mhUub1DdW4e0PosUwAjZbHrcZ/wE3pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713762023;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q37LHbohpv6nAU0jbrurpg4hVLaEc9j9h8ykK9eiNOA=;
	b=6ClPrvdmrNyTMjCFd3S/nypHvl/7K/VeEoXtHvoRO8Edq+YDyPYsLNLL8FV4NHLRapgBJt
	7veZ8jmaocaa91Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 816A013687;
	Mon, 22 Apr 2024 05:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uIqCHufuJWarQQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 22 Apr 2024 05:00:23 +0000
Date: Mon, 22 Apr 2024 07:00:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
Message-ID: <20240422050018.GA64791@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <171375175915.7600.6526208866216039031@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171375175915.7600.6526208866216039031@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -3.49
X-Spam-Level: 
X-Spamd-Result: default: False [-3.49 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	REPLYTO_EQ_FROM(0.00)[]

Hi all,

> The calculation of how many clients the nfs server can manage is only an
> heuristic.  Triggering the laundromat to clean up old clients when we
> have more than the heuristic limit is valid, but refusing to create new
> clients is not.  Client creation should only fail if there really isn't
> enough memory available.

> This is not known to have caused a problem is production use, but
> testing of lots of clients reports an error and it is not clear that
> this error is justified.

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index daf83823ba48..8a40bb6a4a67 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2223,10 +2223,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>  	struct nfs4_client *clp;
>  	int i;

> -	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) {
> +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients)
>  		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -		return NULL;
> -	}

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
>  	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
>  	if (clp == NULL)
>  		return NULL;

