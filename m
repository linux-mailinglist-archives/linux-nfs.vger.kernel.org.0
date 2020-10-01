Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA052807B3
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 21:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgJAT0D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJAT0D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 15:26:03 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D397C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 12:26:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 94D9F6192; Thu,  1 Oct 2020 15:26:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 94D9F6192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601580362;
        bh=ltvXPcwR2LtwQlvGVIAU+/wSgDtYkdhW2Yz9vWNl9qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wT6NCwFcDZrhhcL21aaopfj5zSZTWkA+bdISv+Y7FADO2AssZ0NYhlITENVnyodu4
         neA161RsKMIkTX7myBgNkvJmvgC4IYl8Zdz1cVRAoNyU4yvjGoDpPxB2Hioe1hNIa8
         Qx09ja5v/HfUjgauRi6McOM/wJW4MiM9TdxSwsas=
Date:   Thu, 1 Oct 2020 15:26:02 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
Message-ID: <20201001192602.GF1496@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
 <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
 <20201001184118.GE1496@fieldses.org>
 <1424d45ba1d140bfcff4ae834c70b0a79daa6807.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424d45ba1d140bfcff4ae834c70b0a79daa6807.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 01, 2020 at 07:24:42PM +0000, Trond Myklebust wrote:
> On Thu, 2020-10-01 at 14:41 -0400, J. Bruce Fields wrote:
> > On Wed, Sep 30, 2020 at 03:30:22PM -0400, Jeff Layton wrote:
> > > On Tue, 2020-09-22 at 13:31 +0100, Daire Byrne wrote:
> > > > This patch helps to avoid this when applied to the re-export
> > > > server but there may be other places where this happens too. I
> > > > accept that this patch is probably not the right/general way to
> > > > do this, but it helps to highlight the issue when re-exporting
> > > > and it works well for our use case:
> > > > 
> > > > --- linux-5.5.0-1.el7.x86_64/fs/nfs/inode.c     2020-01-27
> > > > 00:23:03.000000000 +0000
> > > > +++ new/fs/nfs/inode.c  2020-02-13 16:32:09.013055074 +0000
> > > > @@ -1869,7 +1869,7 @@
> > > >  
> > > >         /* More cache consistency checks */
> > > >         if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
> > > > -               if (!inode_eq_iversion_raw(inode, fattr-
> > > > >change_attr)) {
> > > > +               if (inode_peek_iversion_raw(inode) < fattr-
> > > > >change_attr) {
> > > >                         /* Could it be a race with writeback? */
> > > >                         if (!(have_writers || have_delegation)) {
> > > >                                 invalid |= NFS_INO_INVALID_DATA
> > > > 
> > > > With this patch, the re-export server's NFS client attribute
> > > > cache is maintained and used by all the clients that then mount
> > > > it. When many hundreds of clients are all doing similar things at
> > > > the same time, the re-export server's NFS client cache is
> > > > invaluable in accelerating the lookups (getattrs).
> > > > 
> > > > Perhaps a more correct approach would be to detect when it is
> > > > knfsd that is accessing the client mount and change the cache
> > > > consistency checks accordingly? 
> > > 
> > > Yeah, I don't think you can do this for the reasons Trond outlined.
> > 
> > I'm not clear whether Trond thought that knfsd's behavior in the case
> > it
> > returns NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR might be good enough to
> > allow
> > this or some other optimization.
> > 
> 
> NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR should normally be good enough to
> allow the above optimisation, yes. I'm less sure about whether or not
> we are correct in returning NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR when in
> fact we are adding the ctime and filesystem-specific change attribute,
> but we could fix that too.

Could you explain your concern?

--b.
