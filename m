Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59A264CCB
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIJSYj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgIJSYJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 14:24:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D186C061796
        for <linux-nfs@vger.kernel.org>; Thu, 10 Sep 2020 11:23:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E4CE7AB6; Thu, 10 Sep 2020 14:23:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E4CE7AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599762232;
        bh=4TcYDGJM97PTk+lIjXws9nrn3BETA7VtDCtpGUmrta4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=au/tda0rak6hz4Kp+uptqZN5jPoNVR8c2zloziUbQOqxahecQNyRF2RuHr4o7Q6IF
         ZvnqBbwULBbe9J83rn7EpCDnaqnOTFnmXCiGG1WMxeFmkQg31vPQmT9f/u8PHRvIAJ
         VAMdBm6HjDYrOigaCTf2MQqlkkVeVhGBxqWSK6nQ=
Date:   Thu, 10 Sep 2020 14:23:52 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: [PATCH] mountd: Ignore transient and non-fatal filesystem errors
 in nfsd_export
Message-ID: <20200910182352.GC28793@fieldses.org>
References: <20200908211958.38741-1-trondmy@kernel.org>
 <20200910170220.GB28793@fieldses.org>
 <5672634521118539d469018df083d4c5a221d330.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5672634521118539d469018df083d4c5a221d330.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 10, 2020 at 05:25:19PM +0000, Trond Myklebust wrote:
> On Thu, 2020-09-10 at 13:02 -0400, J. Bruce Fields wrote:
> > On Tue, Sep 08, 2020 at 05:19:58PM -0400, trondmy@kernel.org wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > If the mount point check in nfsd_export fails due to a transient
> > > error,
> > > then ignore it to avoid spurious NFSERR_STALE errors being returned
> > > by
> > > knfsd.
> > 
> > What sort of transient errors?
> > 
> > I guess this makes the upcall (and the original rpc) eventually time
> > out?
> 
> The point here is that is_mountpoint() is making the assumption that
> _any_ error from stat() can be used to infer that there is nothing
> mounted. In reality, only a subset of errors allow it to make that
> assumption (specifically the errors ELOOP, ENAMETOOLONG, ENOENT, and
> ENOTDIR).
> 
> In our case, we're seeing a problem when the underlying filesystem is a
> soft mounted NFSv4.2 client (i.e. we're running our Hammerspace use
> case of proxying NFSv4.2 to legacy NFSv3 clients) and that NFS4.2 mount
> times out due to a reboot of the underlying server, for instance.
> 
> So, yes, in that case we want the upcall to time out instead of poking
> knfsd into declaring that the directory is stale.

Thanks for the explanation, I guess I agree that's the best you can do
in that situation.

--b.

> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > >  utils/mountd/cache.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
> > > index 6cba2883026f..93e868341d15 100644
> > > --- a/utils/mountd/cache.c
> > > +++ b/utils/mountd/cache.c
> > > @@ -1411,7 +1411,10 @@ static void nfsd_export(int f)
> > >  
> > >  		if (mp && !*mp)
> > >  			mp = found->m_export.e_path;
> > > -		if (mp && !is_mountpoint(mp))
> > > +		errno = 0;
> > > +		if (mp && !is_mountpoint(mp)) {
> > > +			if (errno != 0 && !path_lookup_error(errno))
> > > +				goto out;
> > >  			/* Exportpoint is not mounted, so tell kernel
> > > it is
> > >  			 * not available.
> > >  			 * This will cause it not to appear in the V4
> > > Pseudo-root
> > > @@ -1420,9 +1423,12 @@ static void nfsd_export(int f)
> > >  			 * And filehandle for this mountpoint from an
> > > earlier
> > >  			 * mount will block in nfsd.fh lookup.
> > >  			 */
> > > +			xlog(L_WARNING,
> > > +			     "Cannot export path '%s': not a
> > > mountpoint",
> > > +			     path);
> > >  			dump_to_cache(f, buf, sizeof(buf), dom, path,
> > >  				      NULL, 60);
> > > -		else if (dump_to_cache(f, buf, sizeof(buf), dom, path,
> > > +		} else if (dump_to_cache(f, buf, sizeof(buf), dom,
> > > path,
> > >  					 &found->m_export, 0) < 0) {
> > >  			xlog(L_WARNING,
> > >  			     "Cannot export %s, possibly unsupported
> > > filesystem"
> > > -- 
> > > 2.26.2
> -- 
> Trond Myklebust
> CTO, Hammerspace Inc
> 4984 El Camino Real, Suite 208
> Los Altos, CA 94022
> www.hammer.space
> 
