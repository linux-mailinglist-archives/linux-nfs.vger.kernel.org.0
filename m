Return-Path: <linux-nfs+bounces-3826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4C908B22
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 13:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB667288329
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0D195B2A;
	Fri, 14 Jun 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GUM8XvO9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NmKl29sU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GUM8XvO9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NmKl29sU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003D1922CF
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366232; cv=none; b=HXR5Q+MKFtO9HUHGCKCnmBozeZBMf9zZPU0zx9BE7AzyM/TOzJgLcgM8TINMJutC/flz8aoGsLOnOoB52MJOXchIbE7xneqXOMtlAY68Mbk/wu6b90Nk18uDPRYMPM0leoJ8xdwYQiP1tqN7HxXVgPNZbHXJDxw3/nxuQP48XSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366232; c=relaxed/simple;
	bh=tjx6V5gM3qAvj3CjeYVhPAisFdqNA+kQhEoy9fqoU/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvEDGdfAinXipIejZDAn/Ty9t+xxwKpD2+ei7huobbUCa5VPdl61+6XUCmR1ohssGEVmuaCJbR2cif5ghLOUAbGsm9OsA/9JzM/VETgR4CUgrhpIU7/uy/E42+AUJP19/DaMwEDBEnhRVSK19xjxUhegUEv2sDjjuMbAz8+P8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GUM8XvO9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NmKl29sU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GUM8XvO9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NmKl29sU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6357833786;
	Fri, 14 Jun 2024 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718366228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GHpgEci693b/j5gKkHigiEYTE1UTfw42nIf3lOGf4M=;
	b=GUM8XvO9Jz1wLaeBBAhmvGxFvvTJwIVN3RROeVqhz+Vmp6a2NyIT3i7g2KlMunEd4nNTxm
	SKuS6s740vTLcK2xI4MX9sjB/op9LtCZJjV+PNVaosz6960O61HM4UWoT0DMJjXUh1N7C0
	FUwRgmvIelat2+5pZ9Gfw6PIxwGFJU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718366228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GHpgEci693b/j5gKkHigiEYTE1UTfw42nIf3lOGf4M=;
	b=NmKl29sUGbdlvrQBmId5+mL1jfRPbqv2pdzSFlECQoZpsyws9RrUKDQzLF8dy4U2LdDdpx
	Goq+2KYaPqQ3hfAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718366228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GHpgEci693b/j5gKkHigiEYTE1UTfw42nIf3lOGf4M=;
	b=GUM8XvO9Jz1wLaeBBAhmvGxFvvTJwIVN3RROeVqhz+Vmp6a2NyIT3i7g2KlMunEd4nNTxm
	SKuS6s740vTLcK2xI4MX9sjB/op9LtCZJjV+PNVaosz6960O61HM4UWoT0DMJjXUh1N7C0
	FUwRgmvIelat2+5pZ9Gfw6PIxwGFJU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718366228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GHpgEci693b/j5gKkHigiEYTE1UTfw42nIf3lOGf4M=;
	b=NmKl29sUGbdlvrQBmId5+mL1jfRPbqv2pdzSFlECQoZpsyws9RrUKDQzLF8dy4U2LdDdpx
	Goq+2KYaPqQ3hfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5825313AAF;
	Fri, 14 Jun 2024 11:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t1qAFRQwbGZQIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Jun 2024 11:57:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02A4AA0869; Fri, 14 Jun 2024 13:57:03 +0200 (CEST)
Date: Fri, 14 Jun 2024 13:57:03 +0200
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Jan Kara <jack@suse.cz>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] nfs: Block on write congestion
Message-ID: <20240614115703.spwq6kh623vxdkgq@quack3>
References: <20240612153022.25454-1-jack@suse.cz>
 <20240613082821.849-3-jack@suse.cz>
 <171831937031.14261.6690155619843129747@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171831937031.14261.6690155619843129747@noble.neil.brown.name>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Fri 14-06-24 08:56:10, NeilBrown wrote:
> On Thu, 13 Jun 2024, Jan Kara wrote:
> > @@ -698,12 +700,14 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
> >  	struct nfs_pageio_descriptor pgio;
> >  	struct nfs_io_completion *ioc = NULL;
> >  	unsigned int mntflags = NFS_SERVER(inode)->flags;
> > +	struct nfs_server *nfss = NFS_SERVER(inode);
> >  	int priority = 0;
> >  	int err;
> >  
> > -	if (wbc->sync_mode == WB_SYNC_NONE &&
> > -	    NFS_SERVER(inode)->write_congested)
> > -		return 0;
> > +	/* Wait with writeback until write congestion eases */
> > +	if (wbc->sync_mode == WB_SYNC_NONE && nfss->write_congested)
> > +		wait_event(nfss->write_congestion_wait,
> > +			   nfss->write_congested == 0);
> 
> If there is a network problem or the server reboot, this could wait
> indefinitely.  Maybe wait_event_idle() ??
> 
> Is this only called from the writeback thread that is dedicated to this
> fs?  If so that should be fine.  If it can be reached from a user
> processes, then wait_event_killable() might be needed.

Usually yes, but e.g. sync_file_range() can issue writeback that will block
here as well. So I guess wait_event_killable() is a good idea. I'll update
it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

