Return-Path: <linux-nfs+bounces-2886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3188A8B31
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD8A1C225D3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B08F4A;
	Wed, 17 Apr 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rk8nuhn0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="StaAtLo9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rk8nuhn0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="StaAtLo9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8D10942
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378868; cv=none; b=qWKpOu+6mwxvLmcUNPeiArMoRs7AWpF/0PWhHvruVeqXthrPavvuvxvJqGSg+uPK3vtMHEEullverMVlFjCMUcQtkw5VBC0+hy/ZJRq+BpD/ggz7neER0MO4KKxiXee6z2r66HbNqs4M9AA6NaqrRKJQC0j99sPIi4Hu7RYl9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378868; c=relaxed/simple;
	bh=OWTfB2sNxhXnPRf4JCFtHaBtdpyYqVH6cqduLDVDt0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc/ipJNX3pzJIn1nOt8CSHjNM0A14LfAr2EJwsKHREmTlMEwHWU5pc59myIrqKwMFqzChVhjyQKlz+L+lMDHZBftJjywp1gw9b4euBMkZGHYfpoAji/UZck2ZBEM4atkebylEa0iuSfSq9tXKPD/EDXrrCSFE2lfCGPo5bQnZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rk8nuhn0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=StaAtLo9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rk8nuhn0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=StaAtLo9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C6FE34041;
	Wed, 17 Apr 2024 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713378864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HAenkq8qRBBosk0UEAayly+02OLnmzeLDBc0anltSY=;
	b=rk8nuhn0rCtmRN2+ZNXXhF67uHHBXgEUGiTxDh/fLqhRtXLUbL7KQQptDez2POPCPrJ/LQ
	2IM30f6L92pXtAQo1nqkQ1PfiiJx7jQ+oHN2O1VB1nKvaNC9QcGbvN2B+7ukbwihpbeTOa
	jYpMrDx5fo6YiD6Yqcv2WykQCPUHGEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713378864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HAenkq8qRBBosk0UEAayly+02OLnmzeLDBc0anltSY=;
	b=StaAtLo9P4sHzMgnLy+Xte3aknOxYlfszzgYzFo9HoAmat4eky8aSPZ8gipIIPGWCRvP5H
	6l8Pe29X72vU8gCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713378864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HAenkq8qRBBosk0UEAayly+02OLnmzeLDBc0anltSY=;
	b=rk8nuhn0rCtmRN2+ZNXXhF67uHHBXgEUGiTxDh/fLqhRtXLUbL7KQQptDez2POPCPrJ/LQ
	2IM30f6L92pXtAQo1nqkQ1PfiiJx7jQ+oHN2O1VB1nKvaNC9QcGbvN2B+7ukbwihpbeTOa
	jYpMrDx5fo6YiD6Yqcv2WykQCPUHGEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713378864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HAenkq8qRBBosk0UEAayly+02OLnmzeLDBc0anltSY=;
	b=StaAtLo9P4sHzMgnLy+Xte3aknOxYlfszzgYzFo9HoAmat4eky8aSPZ8gipIIPGWCRvP5H
	6l8Pe29X72vU8gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD5BE13977;
	Wed, 17 Apr 2024 18:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4YUoLi8WIGaLJQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 18:34:23 +0000
Date: Wed, 17 Apr 2024 20:34:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't create nfsv4recoverydir in nfsdfs when not
 used.
Message-ID: <20240417183421.GC35911@pevik>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.cz:replyto,suse.cz:email];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
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

Also thanks to all for a very quick fix.

Kind regards,
Petr

