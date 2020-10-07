Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555FA286A69
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 23:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgJGVpf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 17:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgJGVpf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 17:45:35 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D0C061755
        for <linux-nfs@vger.kernel.org>; Wed,  7 Oct 2020 14:45:34 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BC16A69C3; Wed,  7 Oct 2020 17:45:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BC16A69C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602107133;
        bh=lct7441mpqawxnuKm9iUmrFaJyF5oFkJ0zNGgKuYKwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZyLik0OZDdkxYoKhxt0azjHr1xO+5e0uuEw1AVFnwerw3g8U/J9Xr3N5h7qmeKbq
         Axq+5rFOIgLmLy+zilG2tkN2no0jp0JifHJ3diDCOscYxuWNZFy8HIyxIJII8VuHA+
         2Xvc7Ib4lN2mevOqXQ5mz6tGhjqBaPNCt0DbiLWI=
Date:   Wed, 7 Oct 2020 17:45:33 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH 2/2] NFSv4: Use the net namespace uniquifier if it is set
Message-ID: <20201007214533.GJ23452@fieldses.org>
References: <20201007210720.537880-1-trondmy@kernel.org>
 <20201007210720.537880-2-trondmy@kernel.org>
 <20201007210720.537880-3-trondmy@kernel.org>
 <20201007212500.GI23452@fieldses.org>
 <9b44b51fd7f65274a76b167b9c0b3231a7d50f99.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b44b51fd7f65274a76b167b9c0b3231a7d50f99.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 07, 2020 at 09:34:17PM +0000, Trond Myklebust wrote:
> On Wed, 2020-10-07 at 17:25 -0400, J. Bruce Fields wrote:
> > On Wed, Oct 07, 2020 at 05:07:20PM -0400, trondmy@kernel.org wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > If a container sets a net namespace specific uniquifier,
> > 
> > What you're actually checking is if nn->nfs_client != NULL, and
> > that's
> > pretty much always true.  (The only time it's NULL is an allocation
> > failure in some initialization code, I think.)
> > 
> > > +	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
> > > +	struct nfs_netns_client *nn_clp = nn->nfs_client;
> > > +	const char *id;
> > > +	size_t len;
> > > +
> > >  	buf[0] = '\0';
> > > +
> > > +	if (nn_clp) {
> > 
> > Are you sure you don't mean
> > 
> > 	if (nn_clp->identifier)
> > 
> > ?
> > 
> > I think that's how you tell if someone's set it.
> 
> We're not holding the rcu_read_lock() here, so there is no point in
> dereferencing the identifier pointer. That would cause a toctou race...

Oh, right:

> > > +		rcu_read_lock();
> > > +		id = rcu_dereference(nn_clp->identifier);
> > > +		if (id && *id != '\0')

My bad, I saw the first check and missed that one somehow.

> > > +			len = strlcpy(buf, id, buflen);
> > > +		rcu_read_unlock();
> > > +		if (len)
> > > +			return len;
> 
> Oops. However I do need to ensure that 'len' is always initialised
> here.

OK.--b.

> 
> > > +	}
> > > +
> > >  	if (nfs4_client_id_uniquifier[0] != '\0')
> > >  		return strlcpy(buf, nfs4_client_id_uniquifier, buflen);
> > >  	return 0;
> > > @@ -6034,7 +6051,7 @@ nfs4_init_nonuniform_client_string(struct
> > > nfs_client *clp)
> > >  		1;
> > >  	rcu_read_unlock();
> > >  
> > > -	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
> > > +	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
> > >  	if (buflen)
> > >  		len += buflen + 1;
> > >  
> > > @@ -6081,7 +6098,7 @@ nfs4_init_uniform_client_string(struct
> > > nfs_client *clp)
> > >  	len = 10 + 10 + 1 + 10 + 1 +
> > >  		strlen(clp->cl_rpcclient->cl_nodename) + 1;
> > >  
> > > -	buflen = nfs4_get_uniquifier(buf, sizeof(buf));
> > > +	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
> > >  	if (buflen)
> > >  		len += buflen + 1;
> > >  
> > > -- 
> > > 2.26.2
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
