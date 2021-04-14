Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5E35FC6C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346419AbhDNUQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbhDNUQB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 16:16:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73130C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:15:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id A943B724B; Wed, 14 Apr 2021 16:15:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A943B724B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618431338;
        bh=qY7ILaA1UzM1rB08jQttrTFG4+Lz1cYW4bwnYYvahEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zBZmTXQDBpLUOsvAsvHKGhotzILegfvy5DwZxiAFksWgkuany4NGUOfr68gxcqbfq
         /ugli6Qhug+gpwHaMn6Fg0whfFLO9yNEl5DoR5aU6dip6fUtKp4uzXlRVZdvti8v6s
         zXRlQ/j7g9ZJYrQ0hmRKwnlx5+4fbCUvrOx/HykU=
Date:   Wed, 14 Apr 2021 16:15:38 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 2/2] NFSv42: Don't force attribute revalidation of the
 copy offload source
Message-ID: <20210414201538.GF16800@fieldses.org>
References: <20210414143138.15192-1-trondmy@kernel.org>
 <20210414143138.15192-2-trondmy@kernel.org>
 <20210414144033.GC16800@fieldses.org>
 <20210414170519.GD16800@fieldses.org>
 <608b1babd125f72517a5116c4ed1e39e8104ae52.camel@hammerspace.com>
 <20210414172825.GE16800@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210414172825.GE16800@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 14, 2021 at 01:28:25PM -0400, bfields@fieldses.org wrote:
> On Wed, Apr 14, 2021 at 05:23:53PM +0000, Trond Myklebust wrote:
> > On Wed, 2021-04-14 at 13:05 -0400, J. Bruce Fields wrote:
> > > On Wed, Apr 14, 2021 at 10:40:33AM -0400, bfields wrote:
> > > > Thanks!  Testing....
> > > 
> > > ... and, test results back with these two patches applied, looks
> > > good!
> > 
> > So, just out of curiosity. With which backing filesystem were you
> > testing? If it was XFS, then note that you may have been testing the
> > CLONE functionality instead of copy offload. As you saw, I added the
> > same fix for both clone and copy offload because they have the same
> > requirements for how the page and attribute caches are handled, so the
> > end result should be the same. However the unpatched code is very
> > different for the two methods, and clone may have been missing more
> > functionality than the actual copy-offload was.
> 
> I think it was actually xfs, but I did look at a trace and my memory is
> it was trying a CLONE and falling back on COPY.  I'll double check....

Yes, confirmed.  At least on my test server's distro (Fedora 28) xfs
doesn't seem to be enabling it by default.  I recreated the filesystems
with "mkfs.xfs -f -mreflink=1 /dev/vdf" and generic/430 is still passing
with your patches.

--b.


> 
> --b.
> 
> > 
> > > 
> > > --b.
> > > 
> > > > 
> > > > --b.
> > > > 
> > > > On Wed, Apr 14, 2021 at 10:31:38AM -0400, trondmy@kernel.org wrote:
> > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > 
> > > > > When a copy offload is performed, we do not expect the source
> > > > > file to
> > > > > change other than perhaps to see the atime be updated.
> > > > > 
> > > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > ---
> > > > >  fs/nfs/nfs42proc.c | 7 +------
> > > > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > > index 3875120ef3ef..a24349512ffe 100644
> > > > > --- a/fs/nfs/nfs42proc.c
> > > > > +++ b/fs/nfs/nfs42proc.c
> > > > > @@ -390,12 +390,7 @@ static ssize_t _nfs42_proc_copy(struct file
> > > > > *src,
> > > > >         }
> > > > >  
> > > > >         nfs42_copy_dest_done(dst_inode, pos_dst, res-
> > > > > >write_res.count);
> > > > > -
> > > > > -       spin_lock(&src_inode->i_lock);
> > > > > -       nfs_set_cache_invalid(src_inode, NFS_INO_REVAL_PAGECACHE
> > > > > |
> > > > > -                                               
> > > > > NFS_INO_REVAL_FORCED |
> > > > > -                                               
> > > > > NFS_INO_INVALID_ATIME);
> > > > > -       spin_unlock(&src_inode->i_lock);
> > > > > +       nfs_invalidate_atime(src_inode);
> > > > >         status = res->write_res.count;
> > > > >  out:
> > > > >         if (args->sync)
> > > > > -- 
> > > > > 2.30.2
> > 
> > -- 
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> > 
> > 
