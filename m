Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADE27581A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIWMkk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgIWMkk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 08:40:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF8C0613CE
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 05:40:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C099D4F41; Wed, 23 Sep 2020 08:40:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C099D4F41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600864838;
        bh=3YXQbvaSTzvoBMc/MLvZ4AYBg6W6cET2VwUBXbTuDCA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Scrd+giOZXw9FpM0OiKGtEgIfBzdR21nUqCb+duXxtiPJv+LNT7fftoofIRJaitM9
         56MGxpbE/ZiXWD6/0Rymjb6OVIVy5aDkwg042vzLAYGkGitEOdHZRmgNFWQ2FCPmb6
         /+sqW2Pl/+LsTy2BzCVb4ienWUCsLi4tpcebqLOE=
Date:   Wed, 23 Sep 2020 08:40:38 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20200923124038.GA4691@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
 <ecd78fe32a1d5a3c6cf3c5a77b1841293b3f5cb1.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd78fe32a1d5a3c6cf3c5a77b1841293b3f5cb1.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 22, 2020 at 01:52:25PM +0000, Trond Myklebust wrote:
> On Tue, 2020-09-22 at 13:31 +0100, Daire Byrne wrote:
> > Hi, 
> > 
> > I just thought I'd flesh out the other two issues I have found with
> > re-exporting that are ultimately responsible for the biggest
> > performance bottlenecks. And both of them revolve around the caching
> > of metadata file lookups in the NFS client.
> > 
> > Especially for the case where we are re-exporting a server many
> > milliseconds away (i.e. on-premise -> cloud), we want to be able to
> > control how much the client caches metadata and file data so that
> > it's many LAN clients all benefit from the re-export server only
> > having to do the WAN lookups once (within a specified coherency
> > time).
> > 
> > Keeping the file data in the vfs page cache or on disk using
> > fscache/cachefiles is fairly straightforward, but keeping the
> > metadata cached is particularly difficult. And without the cached
> > metadata we introduce long delays before we can serve the already
> > present and locally cached file data to many waiting clients.
> > 
> > ----- On 7 Sep, 2020, at 18:31, Daire Byrne daire@dneg.com wrote:
> > > 2) If we cache metadata on the re-export server using
> > > actimeo=3600,nocto we can
> > > cut the network packets back to the origin server to zero for
> > > repeated lookups.
> > > However, if a client of the re-export server walks paths and memory
> > > maps those
> > > files (i.e. loading an application), the re-export server starts
> > > issuing
> > > unexpected calls back to the origin server again,
> > > ignoring/invalidating the
> > > re-export server's NFS client cache. We worked around this this by
> > > patching an
> > > inode/iversion validity check in inode.c so that the NFS client
> > > cache on the
> > > re-export server is used. I'm not sure about the correctness of
> > > this patch but
> > > it works for our corner case.
> > 
> > If we use actimeo=3600,nocto (say) to mount a remote software volume
> > on the re-export server, we can successfully cache the loading of
> > applications and walking of paths directly on the re-export server
> > such that after a couple of runs, there are practically zero packets
> > back to the originating NFS server (great!). But, if we then do the
> > same thing on a client which is mounting that re-export server, the
> > re-export server now starts issuing lots of calls back to the
> > originating server and invalidating it's client cache (bad!).
> > 
> > I'm not exactly sure why, but the iversion of the inode gets changed
> > locally (due to atime modification?) most likely via invocation of
> > method inode_inc_iversion_raw. Each time it gets incremented the
> > following call to validate attributes detects changes causing it to
> > be reloaded from the originating server.
> > 
> > This patch helps to avoid this when applied to the re-export server
> > but there may be other places where this happens too. I accept that
> > this patch is probably not the right/general way to do this, but it
> > helps to highlight the issue when re-exporting and it works well for
> > our use case:
> > 
> > --- linux-5.5.0-1.el7.x86_64/fs/nfs/inode.c     2020-01-27
> > 00:23:03.000000000 +0000
> > +++ new/fs/nfs/inode.c  2020-02-13 16:32:09.013055074 +0000
> > @@ -1869,7 +1869,7 @@
> >  
> >         /* More cache consistency checks */
> >         if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
> > -               if (!inode_eq_iversion_raw(inode, fattr-
> > >change_attr)) {
> > +               if (inode_peek_iversion_raw(inode) < fattr-
> > >change_attr) {
> >                         /* Could it be a race with writeback? */
> >                         if (!(have_writers || have_delegation)) {
> >                                 invalid |= NFS_INO_INVALID_DATA
> 
> 
> There is nothing in the base NFSv4, and NFSv4.1 specs that allow you to
> make assumptions about how the change attribute behaves over time.
> 
> The only safe way to do something like the above is if the server
> supports NFSv4.2 and also advertises support for the 'change_attr_type'
> attribute. In that case, you can check at mount time for whether or not
> the change attribute on this filesystem is one of the monotonic types
> which would allow the above optimisation.

Looking at https://tools.ietf.org/html/rfc7862#section-12.2.3 .... I
think that would be anything but NFS4_CHANGE_TYPE_IS_UNDEFINED ?

The Linux server's ctime is monotonic and will advertise that with
change_attr_type since 4.19.

So I think it would be easy to patch the client to check
change_attr_type and set an NFS_CAP_MONOTONIC_CHANGE flag in
server->caps, the hard part would be figuring out which optimisations
are OK.

--b.
