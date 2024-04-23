Return-Path: <linux-nfs+bounces-2957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 653FD8AEA4C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E225B21DD2
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C4136E1A;
	Tue, 23 Apr 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXEXcuBf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0vk1CpN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXEXcuBf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0vk1CpN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E565820E
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885181; cv=none; b=V5JgkTu6UFKw8Up3dlb01EA6zSDzXA2gnlIziBzYEKDJFTj/dv3W4f8oflzr6neocD5jpCJidsO03XZ2p2abqQBKfD0ROQTRyanGsAbHHOky50rctIVlqobL+zP7vn3aqni/cPzQRsTggXCa6OZ9aAuMaY6uwBycff5FK1Tzge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885181; c=relaxed/simple;
	bh=Cz2IeJ4Kk2fbrQISNBs+lm9xIppMttlQETaDBdNphgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unIouGDkCh6LtnFqjX1uKkfmFd2t39g62CMXXRERnHyy3Udf2kIC5WgAH/4ly5IvqOCTxyrUyH6LeGOAq32HrLC+mXEkDD33HvatBvCvCS70cT3AI/0bHC5xGdk7Yr+djHHe9sg7w7c1as9hpasgIM9hjL0sq1TLufhGIuhKSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXEXcuBf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0vk1CpN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXEXcuBf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0vk1CpN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3534E60113;
	Tue, 23 Apr 2024 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713885178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1BlJPSt8WmNeTZtsOenhD9yPqe1gxalC0MBO4mz6TQ=;
	b=FXEXcuBf/5LLnIRmE2vX2Ju43bUMgj4IIrjvz1bNX3RAkh5DTM7KsXt1QmrRIwnpbdr2ml
	34vGT5eXXPKn7SxG0N7MRZKjQjGSA9BAsw4PTdG3o7vxI6BqvT/FUXGf0SiPo7l674UIQl
	7LgVN+dnIB7Fx3R8A9JZwtLNGAYGKww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713885178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1BlJPSt8WmNeTZtsOenhD9yPqe1gxalC0MBO4mz6TQ=;
	b=Y0vk1CpNrmskyuLeXDc0rrJpqBaYCOBa2WaSSBpvI8akEssVvYogPwLbjb9UGzz8e0d6D7
	bBe6MECA5Y4lE1DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713885178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1BlJPSt8WmNeTZtsOenhD9yPqe1gxalC0MBO4mz6TQ=;
	b=FXEXcuBf/5LLnIRmE2vX2Ju43bUMgj4IIrjvz1bNX3RAkh5DTM7KsXt1QmrRIwnpbdr2ml
	34vGT5eXXPKn7SxG0N7MRZKjQjGSA9BAsw4PTdG3o7vxI6BqvT/FUXGf0SiPo7l674UIQl
	7LgVN+dnIB7Fx3R8A9JZwtLNGAYGKww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713885178;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1BlJPSt8WmNeTZtsOenhD9yPqe1gxalC0MBO4mz6TQ=;
	b=Y0vk1CpNrmskyuLeXDc0rrJpqBaYCOBa2WaSSBpvI8akEssVvYogPwLbjb9UGzz8e0d6D7
	bBe6MECA5Y4lE1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1150313894;
	Tue, 23 Apr 2024 15:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SReYA/rPJ2b+CwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 23 Apr 2024 15:12:58 +0000
Date: Tue, 23 Apr 2024 17:12:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
Message-ID: <20240423151256.GA203608@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <171375175915.7600.6526208866216039031@noble.neil.brown.name>
 <ZiZnbV+htcvGuGQl@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiZnbV+htcvGuGQl@tissot.1015granger.net>
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.de:email];
	REPLYTO_EQ_FROM(0.00)[]

> On Mon, Apr 22, 2024 at 12:09:19PM +1000, NeilBrown wrote:
> > The calculation of how many clients the nfs server can manage is only an
> > heuristic.  Triggering the laundromat to clean up old clients when we
> > have more than the heuristic limit is valid, but refusing to create new
> > clients is not.  Client creation should only fail if there really isn't
> > enough memory available.

> > This is not known to have caused a problem is production use, but
> > testing of lots of clients reports an error and it is not clear that
> > this error is justified.

> It is justified, see 4271c2c08875 ("NFSD: limit the number of v4
> clients to 1024 per 1GB of system memory"). In cases like these,
> the recourse is to add more memory to the test system.

FYI the system is using 1468 MB + 2048 MB swap

$ free -m
               total        used        free      shared  buff/cache   available
Mem:            1468         347         589           4         686        1121
Swap:           2048           0        2048

Indeed increasing the memory to 3430 MB makes test happy. It's of course up to
you to see whether this is just unrealistic / artificial problem which does not
influence users and thus is v2 Neil sent is not worth of merging.

Kind regards,
Petr

> However, that commit claims that the client is told to retry; I
> don't expect client creation to fail outright. Can you describe the
> failure mode you see?

> Meanwhile, we need to have broader and more regular testing of NFSD
> on memory-starved systems. That's a long-term project.


> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)

> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index daf83823ba48..8a40bb6a4a67 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2223,10 +2223,9 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
> >  	struct nfs4_client *clp;
> >  	int i;

> > -	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) {
> > +	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients)
> >  		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> > -		return NULL;
> > -	}
> > +
> >  	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
> >  	if (clp == NULL)
> >  		return NULL;
> > -- 
> > 2.44.0

