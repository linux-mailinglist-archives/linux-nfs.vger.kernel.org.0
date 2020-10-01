Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D81280718
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgJASlT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 14:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJASlT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 14:41:19 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FCC0613E2
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 11:41:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EFA3367A2; Thu,  1 Oct 2020 14:41:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EFA3367A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601577678;
        bh=+Gud44h/DwgTXrk8DT7tVjKcn8XnzdMmrGsrqdJ/P0g=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=X5lcJDHhdNICZpQItgfe2uiJDCdWsfP6x4yxfqas108SMAmHf22CpJWs+Ox9COAvn
         MhxPdIn5FvLsr5JS10shsmSVuTPsJ7Q6jSO37sD5Nz6MEp7fmm7slM299UVrwQnouf
         MxI/qvuBMF0whOE/bU+hPiqugr/ZksBL6CrkOCGw=
Date:   Thu, 1 Oct 2020 14:41:18 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
Message-ID: <20201001184118.GE1496@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
 <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 30, 2020 at 03:30:22PM -0400, Jeff Layton wrote:
> On Tue, 2020-09-22 at 13:31 +0100, Daire Byrne wrote:
> > This patch helps to avoid this when applied to the re-export server but there may be other places where this happens too. I accept that this patch is probably not the right/general way to do this, but it helps to highlight the issue when re-exporting and it works well for our use case:
> > 
> > --- linux-5.5.0-1.el7.x86_64/fs/nfs/inode.c     2020-01-27 00:23:03.000000000 +0000
> > +++ new/fs/nfs/inode.c  2020-02-13 16:32:09.013055074 +0000
> > @@ -1869,7 +1869,7 @@
> >  
> >         /* More cache consistency checks */
> >         if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
> > -               if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
> > +               if (inode_peek_iversion_raw(inode) < fattr->change_attr) {
> >                         /* Could it be a race with writeback? */
> >                         if (!(have_writers || have_delegation)) {
> >                                 invalid |= NFS_INO_INVALID_DATA
> > 
> > With this patch, the re-export server's NFS client attribute cache is maintained and used by all the clients that then mount it. When many hundreds of clients are all doing similar things at the same time, the re-export server's NFS client cache is invaluable in accelerating the lookups (getattrs).
> > 
> > Perhaps a more correct approach would be to detect when it is knfsd that is accessing the client mount and change the cache consistency checks accordingly? 
> 
> Yeah, I don't think you can do this for the reasons Trond outlined.

I'm not clear whether Trond thought that knfsd's behavior in the case it
returns NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR might be good enough to allow
this or some other optimization.

--b.
