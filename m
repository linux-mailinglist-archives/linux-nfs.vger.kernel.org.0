Return-Path: <linux-nfs+bounces-2864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF798A7BD0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 07:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DF91F23F19
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4A524BC;
	Wed, 17 Apr 2024 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xSj542OO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/LCvqsA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xSj542OO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/LCvqsA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23E249FF
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331522; cv=none; b=La9jAbX8VigO5ndFOLVkwQD43xq4DfmZpMeym5CTJyA2buw05PUZZByFAzPP7FiAXMk/BIvjRxA3dLJu/KFHRj6qiifEv4lG1ZbSl4ByBP7uWixYJQVphBMcSXp4rUdCC9IV5+fDLgiCyg4XSVQrQNtQfc6mQuZlQB/50H4CkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331522; c=relaxed/simple;
	bh=w3eL7iGh5bby4CV1TRU4QZPnCLKv5gb60GhvJgD2xtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4KJPUf8VSp8tM3wn6c2Bf65uu3Ttb8F2NyhynZQ4Q+PqX5+cQHV9z9oN+MwVdyhwpB9yUTL9hJ7xP/ckFtrIPx79+q2JZ70sc29M8dwSWaSTPjPA9UE/Y2BW7THx/b2u9qh1nTZFdy1TfDe9GuLDTtCofp7CohYJBdr+FcRM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xSj542OO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/LCvqsA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xSj542OO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/LCvqsA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 843B733801;
	Wed, 17 Apr 2024 05:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713331518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miS1r8rm0FuNflzSpnwvacVvuVWufhXM+vr+kyE6RTc=;
	b=xSj542OOg2k8KaGwT/Rlkxf8CdRlr68NvTibQ+wPXHBNntWrnVAQq3aLDqnjKD/Mml71yM
	bLkRmKtDsVAhys7UwVqDbpTn/QVUe4gukysbO8isbSbalmPOYjuCnRnpfvCTtCqHWrAmIA
	oiyePjXUE47TweQJ4NfEJLJUMb6lZoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713331518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miS1r8rm0FuNflzSpnwvacVvuVWufhXM+vr+kyE6RTc=;
	b=V/LCvqsAVGmdyh6gdUUfotbJAkzCib0xll5WTndq81eqa+m7FOyDbXteJ3y/97dczs4yWD
	xRD1EOWvUdOkqFAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713331518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miS1r8rm0FuNflzSpnwvacVvuVWufhXM+vr+kyE6RTc=;
	b=xSj542OOg2k8KaGwT/Rlkxf8CdRlr68NvTibQ+wPXHBNntWrnVAQq3aLDqnjKD/Mml71yM
	bLkRmKtDsVAhys7UwVqDbpTn/QVUe4gukysbO8isbSbalmPOYjuCnRnpfvCTtCqHWrAmIA
	oiyePjXUE47TweQJ4NfEJLJUMb6lZoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713331518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miS1r8rm0FuNflzSpnwvacVvuVWufhXM+vr+kyE6RTc=;
	b=V/LCvqsAVGmdyh6gdUUfotbJAkzCib0xll5WTndq81eqa+m7FOyDbXteJ3y/97dczs4yWD
	xRD1EOWvUdOkqFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52D411386E;
	Wed, 17 Apr 2024 05:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2iB6Ej5dH2YRBAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 05:25:18 +0000
Date: Wed, 17 Apr 2024 07:25:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't create nfsv4recoverydir in nfsdfs when not
 used.
Message-ID: <20240417052516.GA681570@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <171330258224.17212.9790424282163530018@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171330258224.17212.9790424282163530018@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -7.50
X-Spam-Level: 
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

Hi Neil, all,

> When CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set, the virtual file
>   /proc/fs/nfsd/nfsv4recoverydir
> is created but responds EINVAL to any access.
> This is not useful, is somewhat surprising, and it causes ltp to
> complain.

> The only known user of this file is in nfs-utils, which handles
> non-existence and read-failure equally well.  So there is nothing to
> gain from leaving the file present but inaccessible.

> So this patch removes the file when its content is not available - i.e.
> when that config option is not selected.

> Also remove the #ifdef which hides some of the enum values when
> CONFIG_NFSD_V$ not selection.  simple_fill_super() quietly ignores array
> entries that are not present, so having slots in the array that don't
> get used is perfectly acceptable.  So there is no value in this #ifdef.

> Reported-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 93c87587e646..340c5d61f199 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -48,12 +48,10 @@ enum {
>  	NFSD_MaxBlkSize,
>  	NFSD_MaxConnections,
>  	NFSD_Filecache,
> -#ifdef CONFIG_NFSD_V4
>  	NFSD_Leasetime,
>  	NFSD_Gracetime,
>  	NFSD_RecoveryDir,
>  	NFSD_V4EndGrace,
> -#endif
>  	NFSD_MaxReserved
>  };

> @@ -1360,7 +1358,9 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>  #ifdef CONFIG_NFSD_V4
>  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_Gracetime] = {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
> +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
>  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
> +#endif

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
>  #endif
>  		/* last one */ {""}

