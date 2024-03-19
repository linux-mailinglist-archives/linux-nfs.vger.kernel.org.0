Return-Path: <linux-nfs+bounces-2394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFFB87FF21
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 14:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A2D282C14
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7304581723;
	Tue, 19 Mar 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3DCeaR1+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8orh92XI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3DCeaR1+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8orh92XI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F281721
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856438; cv=none; b=dkwM1OoSQyXsaA9qwQzOw8UgwpfJTbzjYgk6JebTSP8JPDfmHO4u8BD4sXVH0eLnQ2h7VLZ69mRXMIod+8d9hVbnLUnAsFzWzgnJ6UvCDm8RprbtqvozT28DU88n/5aiRT8mgmBr4hADGMOPtKKdussUHc0aavNddLCqehMLHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856438; c=relaxed/simple;
	bh=erxfAtepRm0S1Pd5u7ftgqbq7utEX0Eacb5ZHk7qyGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+aJ26uWzU6b2ks6S/LnlYcCTbeDOBMnLaYe36OxXcbAnsxdrmZWKFlGUMb6rlldSC4ZitLI0dp0Vvm8kYpDgDr6dufrssRG39aJ9PlQQjyToqo8HWQ1AnISRrYLpjLBwVqw7OxZqvAo9iN3cApv0QvMQ9QIt1SnvLR4RbrbGNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3DCeaR1+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8orh92XI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3DCeaR1+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8orh92XI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 767B33790C;
	Tue, 19 Mar 2024 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710856434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02vjYArBkTQyFlS6kbN2N5FiDrC1czZ+aDsD1Ke2rU8=;
	b=3DCeaR1+fIjPfC7wP5+wLmZDmHNl2fv1+1oUtghxhhaBoxM1wZ1obq19eyzvy7YGhlnvuX
	eSyZ1aEPyCKca0zWhJfJ48HkfMIvg5ppDiV6nWio5TA3/tC2WkHMvjH5Ev/LmAw6WHtyur
	IrH+W1KpY4YvkYZ36g1H5D+5JuBMqow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710856434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02vjYArBkTQyFlS6kbN2N5FiDrC1czZ+aDsD1Ke2rU8=;
	b=8orh92XI4TPyOpTnYTiCFGVhv6fT1eH6NSm0ZoRHAtxrI77OxHJMOJlWFF7Hr4kjDHRt1E
	soLwq0YUBaVlR5Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710856434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02vjYArBkTQyFlS6kbN2N5FiDrC1czZ+aDsD1Ke2rU8=;
	b=3DCeaR1+fIjPfC7wP5+wLmZDmHNl2fv1+1oUtghxhhaBoxM1wZ1obq19eyzvy7YGhlnvuX
	eSyZ1aEPyCKca0zWhJfJ48HkfMIvg5ppDiV6nWio5TA3/tC2WkHMvjH5Ev/LmAw6WHtyur
	IrH+W1KpY4YvkYZ36g1H5D+5JuBMqow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710856434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02vjYArBkTQyFlS6kbN2N5FiDrC1czZ+aDsD1Ke2rU8=;
	b=8orh92XI4TPyOpTnYTiCFGVhv6fT1eH6NSm0ZoRHAtxrI77OxHJMOJlWFF7Hr4kjDHRt1E
	soLwq0YUBaVlR5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BF3C136A5;
	Tue, 19 Mar 2024 13:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gx9UGvKY+WUYbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 Mar 2024 13:53:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1DB43A0806; Tue, 19 Mar 2024 14:53:54 +0100 (CET)
Date: Tue, 19 Mar 2024 14:53:54 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: Fix error cleanup path in nfsd_rename()
Message-ID: <20240319135354.lyvyc7kvihp3kmt4@quack3>
References: <20240318163209.26493-1-jack@suse.cz>
 <ZfigId5Anil0U3cs@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfigId5Anil0U3cs@manet.1015granger.net>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.84
X-Spamd-Result: default: False [-0.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.993];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[58.17%]
X-Spam-Flag: NO

On Mon 18-03-24 16:12:17, Chuck Lever wrote:
> On Mon, Mar 18, 2024 at 05:32:09PM +0100, Jan Kara wrote:
> > Commit a8b0026847b8 ("rename(): avoid a deadlock in the case of parents
> > having no common ancestor") added an error bail out path. However this
> > path does not drop the remount protection that has been acquired. Fix
> > the cleanup path to properly drop the remount protection.
> > 
> > Fixes: a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having no common ancestor")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Al, Jan, let me know if you'd like me to take this through the
> nfsd tree for v6.9-rc. If not:
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>

Yeah, I guess taking this through NFS tree is the best.

								Honza

> 
> 
> > ---
> >  fs/nfsd/vfs.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 6a9464262fae..2e41eb4c3cec 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1852,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
> >  	trap = lock_rename(tdentry, fdentry);
> >  	if (IS_ERR(trap)) {
> >  		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
> > -		goto out;
> > +		goto out_want_write;
> >  	}
> >  	err = fh_fill_pre_attrs(ffhp);
> >  	if (err != nfs_ok)
> > @@ -1922,6 +1922,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
> >  	}
> >  out_unlock:
> >  	unlock_rename(tdentry, fdentry);
> > +out_want_write:
> >  	fh_drop_write(ffhp);
> >  
> >  	/*
> > -- 
> > 2.35.3
> > 
> 
> -- 
> Chuck Lever
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

