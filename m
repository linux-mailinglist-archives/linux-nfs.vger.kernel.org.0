Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E809027F299
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Sep 2020 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgI3TaY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Sep 2020 15:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgI3TaY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 30 Sep 2020 15:30:24 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610D120709;
        Wed, 30 Sep 2020 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601494223;
        bh=sr8l+h0loEx/Nka344oH3IdSkTwQ7DK50ztRrGIRvA8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=esABQH5Ct/K+xhBTVN+SAqfBHIhfWA9rMZ1OHm0P7YZxFSdeVecLh/2z8gwRpRw1c
         hEqWB79ZS5t/Uq+NhYRw+4TbRqh4YiawBfmNV//nabh+wkd38087JRk8JnK4G7XYv5
         a+96IipVpBnvPhLUrrWaV/WshEElj0JrbhOBZEfQ=
Message-ID: <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
From:   Jeff Layton <jlayton@kernel.org>
To:     Daire Byrne <daire@dneg.com>, linux-nfs <linux-nfs@vger.kernel.org>
Cc:     linux-cachefs <linux-cachefs@redhat.com>
Date:   Wed, 30 Sep 2020 15:30:22 -0400
In-Reply-To: <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
         <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2020-09-22 at 13:31 +0100, Daire Byrne wrote:
> Hi, 
> 
> I just thought I'd flesh out the other two issues I have found with re-exporting that are ultimately responsible for the biggest performance bottlenecks. And both of them revolve around the caching of metadata file lookups in the NFS client.
> 
> Especially for the case where we are re-exporting a server many milliseconds away (i.e. on-premise -> cloud), we want to be able to control how much the client caches metadata and file data so that it's many LAN clients all benefit from the re-export server only having to do the WAN lookups once (within a specified coherency time).
> 
> Keeping the file data in the vfs page cache or on disk using fscache/cachefiles is fairly straightforward, but keeping the metadata cached is particularly difficult. And without the cached metadata we introduce long delays before we can serve the already present and locally cached file data to many waiting clients.
> 
> ----- On 7 Sep, 2020, at 18:31, Daire Byrne daire@dneg.com wrote:
> > 2) If we cache metadata on the re-export server using actimeo=3600,nocto we can
> > cut the network packets back to the origin server to zero for repeated lookups.
> > However, if a client of the re-export server walks paths and memory maps those
> > files (i.e. loading an application), the re-export server starts issuing
> > unexpected calls back to the origin server again, ignoring/invalidating the
> > re-export server's NFS client cache. We worked around this this by patching an
> > inode/iversion validity check in inode.c so that the NFS client cache on the
> > re-export server is used. I'm not sure about the correctness of this patch but
> > it works for our corner case.
> 
> If we use actimeo=3600,nocto (say) to mount a remote software volume on the re-export server, we can successfully cache the loading of applications and walking of paths directly on the re-export server such that after a couple of runs, there are practically zero packets back to the originating NFS server (great!). But, if we then do the same thing on a client which is mounting that re-export server, the re-export server now starts issuing lots of calls back to the originating server and invalidating it's client cache (bad!).
> 
> I'm not exactly sure why, but the iversion of the inode gets changed locally (due to atime modification?) most likely via invocation of method inode_inc_iversion_raw. Each time it gets incremented the following call to validate attributes detects changes causing it to be reloaded from the originating server.
> 

I'd expect the change attribute to track what's in actual inode on the
"home" server. The NFS client is supposed to (mostly) keep the raw
change attribute in its i_version field.

The only place we call inode_inc_iversion_raw is in
nfs_inode_add_request, which I don't think you'd be hitting unless you
were writing to the file while holding a write delegation.

What sort of server is hosting the actual data in your setup?


> This patch helps to avoid this when applied to the re-export server but there may be other places where this happens too. I accept that this patch is probably not the right/general way to do this, but it helps to highlight the issue when re-exporting and it works well for our use case:
> 
> --- linux-5.5.0-1.el7.x86_64/fs/nfs/inode.c     2020-01-27 00:23:03.000000000 +0000
> +++ new/fs/nfs/inode.c  2020-02-13 16:32:09.013055074 +0000
> @@ -1869,7 +1869,7 @@
>  
>         /* More cache consistency checks */
>         if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
> -               if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
> +               if (inode_peek_iversion_raw(inode) < fattr->change_attr) {
>                         /* Could it be a race with writeback? */
>                         if (!(have_writers || have_delegation)) {
>                                 invalid |= NFS_INO_INVALID_DATA
> 
> With this patch, the re-export server's NFS client attribute cache is maintained and used by all the clients that then mount it. When many hundreds of clients are all doing similar things at the same time, the re-export server's NFS client cache is invaluable in accelerating the lookups (getattrs).
> 
> Perhaps a more correct approach would be to detect when it is knfsd that is accessing the client mount and change the cache consistency checks accordingly? 

Yeah, I don't think you can do this for the reasons Trond outlined.
-- 
Jeff Layton <jlayton@kernel.org>

