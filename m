Return-Path: <linux-nfs+bounces-20395-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AATbDN7FxGmu3QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20395-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 06:36:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBCE32F707
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 06:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AEE63016830
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 05:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184C2E62C3;
	Thu, 26 Mar 2026 05:34:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28C262FD0;
	Thu, 26 Mar 2026 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774503244; cv=none; b=Y9emtgk6o/gQcgadHM4BV52D12foVEEb0PF36rdDf/azVhyiqKMZULmu2JAGR/caI35xAIRyEh3SYyighP1479n55XN63yr1fzKFZ6crzaYEhfOQrTy5bCVTwQQiAhoXpTwWrVZtDLKv0D6If/otGVQWhOQtM2J9CQ5bOf4mkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774503244; c=relaxed/simple;
	bh=5MTA2DPMYyZniXlYbofp7xzCbU3fURObtreH4bfCMFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQMhav9k90IYCYucDj61fo91IjOf4Ih7Al8ch3tbrv4Tf31iV9YvHV66kdnqqv+RwPLueotCm4jsqP6OBkzWcF5B4O7gDflrInwVJMsZCmmQfssL9dPkzpNgdVssfj5pp0diEYi7nRqSzM6HCwhI4mAxCwdjSClj6rZ0XH5AuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9886168C4E; Thu, 26 Mar 2026 06:33:59 +0100 (CET)
Date: Thu, 26 Mar 2026 06:33:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>, linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] exportfs: split out the ops for layout-based block
 device access
Message-ID: <20260326053359.GA23157@lst.de>
References: <20260323070746.2940140-1-hch@lst.de> <20260323070746.2940140-2-hch@lst.de> <1fbdc5d9-d95c-4d1a-816e-028ffd1231b0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fbdc5d9-d95c-4d1a-816e-028ffd1231b0@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20395-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,oracle.com,kernel.org,gmail.com,brown.name,redhat.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBBCE32F707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:39:48AM -0400, Chuck Lever wrote:
> > -	    sb->s_export_op->commit_blocks &&
> > +	if (bops->map_blocks && bops->commit_blocks &&
> >  	    sb->s_bdev &&
> >  	    sb->s_bdev->bd_disk->fops->pr_ops &&
> >  	    sb->s_bdev->bd_disk->fops->get_unique_id)
> 
> block_ops itself is NULL for any filesystem that does not provide
> block layout support (everything other than XFS today).
> 
> When an admin exports such a filesystem with pNFS enabled
> (NFSEXP_PNFS), svc_export_parse() calls nfsd4_setup_layout_type(),
> and bops->get_uuid dereferences a NULL pointer.
> 
> Something like the following would restore the original behavior:
> 
>     if (bops && bops->get_uuid && ...)

Yes, I'll fix it up.


