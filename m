Return-Path: <linux-nfs+bounces-18459-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCNHMngEd2mRagEAu9opvQ
	(envelope-from <linux-nfs+bounces-18459-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:06:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B728460D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79D3930011BA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE75C246788;
	Mon, 26 Jan 2026 06:06:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259329A1
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769407603; cv=none; b=ovF6HyUJQ0SBaOrMbRKDjKntbiUYzOpz4yCQpmFjE0Lcg27dhNS/k1gDwRlxyHU3saZTzZLAHDLWoNc4dewoiMOsszTZzeoPXuB40mYDrYywZ56gZTbTjjW9WcElsLpqlX5yJDwnSeXe9H4uzO5PRICcKSqFmLOOjA321dU4N+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769407603; c=relaxed/simple;
	bh=KmVYpAIQlNgKdfYMTle8mVvI1/VAXpzZFm3GYV5NAIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIfvzQMcmo0iKKEI7ZBvYKsv6cENEaBKQC/YapEwvz+WLVt69/kuSEMyaa3NiARSXm1KWzyDAVLzPMtDw82bRIdgK7eIqlhn0BxIAupDu5LvCqNPm+z6VP+aogooOcTpMBbeMM5mdErGgBJQD6MCM4WFug/C72242pWuN2ClXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44C5D227A88; Mon, 26 Jan 2026 07:06:39 +0100 (CET)
Date: Mon, 26 Jan 2026 07:06:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@meta.com>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 22/24] NFS: add a separate delegation return list
Message-ID: <20260126060638.GA1304@lst.de>
References: <20260107072720.1744129-1-hch@lst.de> <20260107072720.1744129-23-hch@lst.de> <20260125133300.2723227-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125133300.2723227-1-clm@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18459-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: E6B728460D
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 05:30:07AM -0800, Chris Mason wrote:
> > +	spin_lock(&server->delegations_lock);
> > +	list_for_each_entry_rcu(d, &server->delegations_return, entry) {
> > +		if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
> > +			clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
> >  		ret = true;
> >  	}
> > -out:
> > +
> >  	return ret;
> >  }
> 
> Is there a missing spin_unlock() here? The spin_lock() is taken but
> the function returns without releasing it. This appears to cause a
> deadlock when delegations_lock is next acquired.

Yes.  I'm kinda surprised the sparse lock context tracking didn't
catch it, but maybe it gives up after multiple 'bad constant expression'
from the module parameters.

> > +	if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
> > +	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) ||
> > +	    test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
> > +		spin_unlock(&delegation->lock);
> > +		goto out_put_inode;
> > +	}
> 
> When a delegation has RETURN_DELAYED set, the code removes it from
> delegations_return (via list_del_init above) and then skips to
> out_put_inode without re-adding it to the list. Since
> nfs_server_clear_delayed_delegations() only iterates delegations_return,
> will this delegation ever have its RETURN_DELAYED flag cleared so it
> can be processed again?
> 
> The scenario is: nfs_end_delegation_return() returns -EAGAIN, which
> sets RETURN_DELAYED via nfs_abort_delegation_return(), then
> nfs_mark_return_delegation() re-adds the delegation to
> delegations_return. On the next iteration of the loop, this check
> triggers and the delegation is dropped from the list without being
> re-queued.

This looks like a mess before and after.  I think the best
idea is a separate list for the delayed returns, but I really
need to find a way to actually generate the delayed returns first.
I'll look into that, thanks!


