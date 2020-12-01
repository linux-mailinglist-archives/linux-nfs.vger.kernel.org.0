Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973C12CAE3B
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbgLAVOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 16:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389080AbgLAVOp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 16:14:45 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0387C0613CF
        for <linux-nfs@vger.kernel.org>; Tue,  1 Dec 2020 13:14:05 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 99A616EAD; Tue,  1 Dec 2020 16:14:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 99A616EAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606857244;
        bh=mNkj+8URHhSHuTKaP/YJL0X7nI2mokw0QNd/WSwYqzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3B9vgk7wW39uPmPR1Y0U5S8qQKMSDzh28JQ7UXqN70KF8vLsJfCIp6qdgCe+BD4z
         Xz9wfd8n7npAs3+BES7ge+/izRBGtyRJlxAfwFjxkhgPafmfKvRnCqGGbqZ4bsvQfA
         ZDNr+h8uT0iANG6O8IEyB/TOtKJ1ovIIsb/2xa2k=
Date:   Tue, 1 Dec 2020 16:14:04 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Message-ID: <20201201211404.GE21355@fieldses.org>
References: <20201201041427.756749-1-trondmy@kernel.org>
 <20201201041427.756749-2-trondmy@kernel.org>
 <20201201193521.GA21355@fieldses.org>
 <63eaf3aab8814b2d65998123b6ba2e5b979a48d9.camel@hammerspace.com>
 <7181b1e7290dcfe4f92d9a8b00117a81b30f0cce.camel@hammerspace.com>
 <20201201205359.GC21355@fieldses.org>
 <34503d767cffb6b8ffc94dc80ae7632d38a7d68f.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34503d767cffb6b8ffc94dc80ae7632d38a7d68f.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 01, 2020 at 08:59:00PM +0000, Trond Myklebust wrote:
> On Tue, 2020-12-01 at 15:53 -0500, bfields@fieldses.org wrote:
> > On Tue, Dec 01, 2020 at 08:27:38PM +0000, Trond Myklebust wrote:
> > > As far as I can tell, there is no need for it at all, since both
> > > the
> > > NFSv3 and NFSv4 client can supply atomic struct change_info4 in the
> > > cases where it is relevant (those cases being recording the changes
> > > to
> > > the parent directory/ies when doing CREATE, OPEN(O_CREAT), LINK,
> > > REMOVE
> > > and RENAME).
> > 
> > I was wondering about that.  We'd need some additional interface to
> > allow nfs to supply that stuff to nfsd, right?
> 
> The only problem is the pre-op attributes, since those are supplied by
> the server but never recorded anywhere. Otherwise, all you really need
> is to hold the inode lock on the directory to prevent the client from
> making updates after the operation is done.

We already have the lock over all those operations.

I was worried that wouldn't prevent a getattr in another thread from
updating the change attribute.  Is that not possible?

My only idea for returning extra information was a hack using
kthread_data() as we're doing in nfsd_breaker_owns_lease(); nfs would
call something like:

	void nfsd_set_cinfo(struct nfs4_change_info *cinfo)
	{
		struct svc_rqst *rqst;

		if (!i_am_nfsd())
			return;
		rqst = kthread_data(current);
		rqst->cinfo = cinfo;
	}

Then nfsd fetches it afterwards.  Maybe there's a better way.

--b.
