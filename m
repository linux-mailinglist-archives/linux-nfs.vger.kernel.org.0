Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999B81154E1
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 17:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLFQMC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 11:12:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfLFQMC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 11:12:02 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63349206DF;
        Fri,  6 Dec 2019 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575648721;
        bh=3R+PC8Ff3M5yx19vaH341IDsCcc0jMlrqtmK1IJiZAc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2KY561JwdQ6U0gtI10EgrHS/V+IZj3bshbV5dB/HBR3ySMGIm6HWbbvYTEuBx8dFI
         x/GqAF17JWtwmewJ76R82AKu0jZ1gLyLhcSaHc0BHvEqXJ7hG7orMrs3JovQys3+gc
         0EHwNmuiae58NPAYHd88l9LkQszbRRUhjUjzywRM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3768835206AB; Fri,  6 Dec 2019 08:12:01 -0800 (PST)
Date:   Fri, 6 Dec 2019 08:12:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     madhuparnabhowmik04@gmail.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191206161201.GF2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
 <20191206160002.GB15547@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206160002.GB15547@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 06, 2019 at 11:00:02AM -0500, Joel Fernandes wrote:
> +Paul, here is the dependent patch for the list_prev_rcu() patch Madhuparna
> posted.

Got it, thank you!

And however this turns out, it does illustrate the value of the sparse
address-space checks!

							Thanx, Paul

> On Fri, Dec 06, 2019 at 08:46:40PM +0530, madhuparnabhowmik04@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > 
> > This patch fixes the following errors:
> > fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
> > fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
> > fs/nfs/dir.c:2353:14:    struct list_head *
> > 
> > caused due to directly accessing the prev pointer of
> > a RCU protected list.
> > Accessing the pointer using the macro list_prev_rcu() fixes this error.
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > ---
> >  fs/nfs/dir.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index e180033e35cf..2035254cc283 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
> >  	rcu_read_lock();
> >  	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
> >  		goto out;
> > -	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
> > +	lh = rcu_dereference(list_prev_rcu(&nfsi->access_cache_entry_lru));
> >  	cache = list_entry(lh, struct nfs_access_entry, lru);
> >  	if (lh == &nfsi->access_cache_entry_lru ||
> >  	    cred != cache->cred)
> > -- 
> > 2.17.1
> > 
