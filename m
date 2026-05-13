Return-Path: <linux-nfs+bounces-21587-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN6JKJcSBGoMDAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21587-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 07:56:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C452DD67
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 07:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02A77307CE71
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 05:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EAD3AFAF1;
	Wed, 13 May 2026 05:56:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE63A8747;
	Wed, 13 May 2026 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651788; cv=none; b=m+X0qJuCZ6aZ+CiT35d/Fdi3yF7iEgGp7+C5aj3WTuk7wBC3Z1bnL4Z/eV7vwlEuvheSqT0tsSeOYrBs6tdFBlmoSWq5wj7XiRiA8MKcx+pTklxcREVtWRtskGHbtLo5ItJx1MetNpqbyzBtpe4NkzG2Vd9++sKxBENGVTwMzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651788; c=relaxed/simple;
	bh=s+h37/IOBmcvhCEzcH/fk+Et7jvVkVJRpnwV7+Hslrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFmvYHU5Su486fGMdo7feAfsIUnimECjTJwwMFxHFvnXdHo60fBH8MbI6u9XmAXId4R0P7RS9rE0LChYUVezfrw9leBjdLJc3b/W4QLoAZIUNzlV8LBAts3F1pNLezJlylX50+cHNuxXthBlBQ1y5GRY1zhvCVUSIFjgHw58mVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 693FC68BEB; Wed, 13 May 2026 07:56:22 +0200 (CEST)
Date: Wed, 13 May 2026 07:56:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 05/12] swap: cleanup setup_swap_extents
Message-ID: <20260513055622.GA1236@lst.de>
References: <20260512053625.2950900-1-hch@lst.de> <20260512053625.2950900-6-hch@lst.de> <20260512164308.GF9555@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512164308.GF9555@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Queue-Id: 504C452DD67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21587-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[lst.de,linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 09:43:08AM -0700, Darrick J. Wong wrote:
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 651c1b59ff9f..1b7fc03612f4 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -2783,25 +2783,24 @@ static int setup_swap_extents(struct swap_info_struct *sis,
> >  {
> >  	struct address_space *mapping = swap_file->f_mapping;
> >  	struct inode *inode = mapping->host;
> > -	int ret;
> > +	int ret, error = 0;
> 
> /me wonders why not reuse ret instead of declaring a new variable?

Because when I wrote this, the setup methods could still return a
positive number of extents value that must not be clobbered.  Since
then I added patches before this that removed that, so we can use
the same ret variable.


