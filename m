Return-Path: <linux-nfs+bounces-2885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B898A8B2D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 20:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FEF1C223F3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473ED8BF3;
	Wed, 17 Apr 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGaf/4Pz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qkz4BQK3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGaf/4Pz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qkz4BQK3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD538F4A
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378843; cv=none; b=l+Vlga8w0dZAr78dXQnGuyreomME0W0ZZY766j2iyvhctmDygbcE11IL6XPqv8tiRPYW9tTvMdUxtuJIX3WFRBJXViOEOSFfyvoTDwmaVJCT8OIaUYHp2XXvDqb4ZC9WrFhAmioFPtVtYtAjNIojCfvfVCA+6dXITl4P1PSgw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378843; c=relaxed/simple;
	bh=WvqWGOAojlm29K4jLtxw3NHax7NN6vfBRQbexJZM9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgXtAcrqnf40hx0z+vqeUsXoTjwjPs8sfMC14mkR/7ELjVSpY7+1a0i1gqPJfKBePXbVQWNukFqgdOHe/njQrxO9eB93o9eZtWKqnZ/rUTchFwwtOyDjM8loQH5g5Zej0/jJnqGSeXRacPJeMZXw6xYhD6Sm4x2pJBwMbWbJJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGaf/4Pz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qkz4BQK3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGaf/4Pz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qkz4BQK3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49FA734040;
	Wed, 17 Apr 2024 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713378836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIgO9SonX4JPIhnepj1feIbW+n98L0avYFmq2WT2VdE=;
	b=qGaf/4PzAHSxrzjpZdmb7otyia6vCNb0YrkSnF4LsYJx56Hb3oOMlFk7oFRVhe73ebAGCl
	QerYW6kEGCPgvKJhK/7eytZjw9ubpSEh7uZLt439tKgT7qRn7BPis9a2NHHY+g8TDUCufT
	/VnMObiHoE6GGp9jpYx3Y7dsVLcFifk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713378836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIgO9SonX4JPIhnepj1feIbW+n98L0avYFmq2WT2VdE=;
	b=qkz4BQK30JfGoUirvxzkuBAPYdSszUpSKGV6Yvl0s1nZ4v9+BpsKcQCimH0l128eSvMx8A
	ZYg+Yd/Oq2QYOfAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713378836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIgO9SonX4JPIhnepj1feIbW+n98L0avYFmq2WT2VdE=;
	b=qGaf/4PzAHSxrzjpZdmb7otyia6vCNb0YrkSnF4LsYJx56Hb3oOMlFk7oFRVhe73ebAGCl
	QerYW6kEGCPgvKJhK/7eytZjw9ubpSEh7uZLt439tKgT7qRn7BPis9a2NHHY+g8TDUCufT
	/VnMObiHoE6GGp9jpYx3Y7dsVLcFifk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713378836;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YIgO9SonX4JPIhnepj1feIbW+n98L0avYFmq2WT2VdE=;
	b=qkz4BQK30JfGoUirvxzkuBAPYdSszUpSKGV6Yvl0s1nZ4v9+BpsKcQCimH0l128eSvMx8A
	ZYg+Yd/Oq2QYOfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1676513977;
	Wed, 17 Apr 2024 18:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OqEBBQWIGZyJQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 18:33:56 +0000
Date: Wed, 17 Apr 2024 20:33:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't create nfsv4recoverydir in nfsdfs when not
 used.
Message-ID: <20240417183354.GB35911@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <171330258224.17212.9790424282163530018@noble.neil.brown.name>
 <20240417052516.GA681570@pevik>
 <Zh/4pd4stFgjV7gp@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/4pd4stFgjV7gp@tissot.1015granger.net>
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	REPLYTO_EQ_FROM(0.00)[]

> On Wed, Apr 17, 2024 at 07:25:16AM +0200, Petr Vorel wrote:
> > Hi Neil, all,

> > > When CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set, the virtual file
> > >   /proc/fs/nfsd/nfsv4recoverydir
> > > is created but responds EINVAL to any access.
> > > This is not useful, is somewhat surprising, and it causes ltp to
> > > complain.

> > > The only known user of this file is in nfs-utils, which handles
> > > non-existence and read-failure equally well.  So there is nothing to
> > > gain from leaving the file present but inaccessible.

> > > So this patch removes the file when its content is not available - i.e.
> > > when that config option is not selected.

> > > Also remove the #ifdef which hides some of the enum values when
> > > CONFIG_NFSD_V$ not selection.  simple_fill_super() quietly ignores array
> > > entries that are not present, so having slots in the array that don't
> > > get used is perfectly acceptable.  So there is no value in this #ifdef.

> > > Reported-by: Petr Vorel <pvorel@suse.cz>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfsctl.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)

> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 93c87587e646..340c5d61f199 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -48,12 +48,10 @@ enum {
> > >  	NFSD_MaxBlkSize,
> > >  	NFSD_MaxConnections,
> > >  	NFSD_Filecache,
> > > -#ifdef CONFIG_NFSD_V4
> > >  	NFSD_Leasetime,
> > >  	NFSD_Gracetime,
> > >  	NFSD_RecoveryDir,
> > >  	NFSD_V4EndGrace,
> > > -#endif
> > >  	NFSD_MaxReserved
> > >  };

> > > @@ -1360,7 +1358,9 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
> > >  #ifdef CONFIG_NFSD_V4
> > >  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
> > >  		[NFSD_Gracetime] = {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
> > > +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> > >  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
> > > +#endif

> > LGTM.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Kind regards,
> > Petr

> > >  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
> > >  #endif
> > >  		/* last one */ {""}

> Thanks to you both! Applied to nfsd-next (for v6.10), unless you'd
> like this to go in sooner.

OK for me, I guess LTP testers can wait.

Kind regards,
Petr

