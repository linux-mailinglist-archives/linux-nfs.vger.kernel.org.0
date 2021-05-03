Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215D737167C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhECOQW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhECOQV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 May 2021 10:16:21 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CDEC061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 07:15:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6C68D50A1; Mon,  3 May 2021 10:15:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6C68D50A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1620051325;
        bh=OzE42fmko95bGicpk/f0oDzkH01ht5Mt19gHP7PbKJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaG6+tP7zXMNIXcPT9JYBvYgo/Lglk8MuklYodznR3iLrn53i+/lMbYVdKWe1ErrZ
         mugNw6w1rM/HjyXrYY+rm0gwyB8p9Zx3b0laTmyQw/SvIEnROE/pgFI4PDcSH8zASs
         +RrH+2LLCqw3upe59e0bSDY4VvNLygVjUn+k+GWs=
Date:   Mon, 3 May 2021 10:15:25 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org,
        Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexey Kodanev <alexey.kodanev@oracle.com>
Subject: Re: Re: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
Message-ID: <20210503141525.GA15181@fieldses.org>
References: <20210422191803.31511-1-pvorel@suse.cz>
 <20210422202334.GB25415@fieldses.org>
 <YIIuUPrlbBlr1ooD@pevik>
 <20210423142329.GB10457@fieldses.org>
 <YIL+KWuPmgm8A82C@pevik>
 <20210423181345.GE10457@fieldses.org>
 <162000848714.10466.9299093696289919822@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162000848714.10466.9299093696289919822@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 03, 2021 at 12:21:27PM +1000, NeilBrown wrote:
> On Sat, 24 Apr 2021, J . Bruce Fields wrote:
> > On Fri, Apr 23, 2021 at 07:04:41PM +0200, Petr Vorel wrote:
> > > Hi Bruce,
> > > 
> > > > On Fri, Apr 23, 2021 at 04:17:52AM +0200, Petr Vorel wrote:
> > > > > Hi,
> > > 
> > > > > > On Thu, Apr 22, 2021 at 09:18:03PM +0200, Petr Vorel wrote:
> > > > > > > LTP NFS tests (which use netns) fails on tmpfs since d4066486:
> > > 
> > > > > > > mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
> > > > > > > mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory
> > > 
> > > > > > We should figure out the reason for the failure.  A network trace might
> > > > > > help.
> > > 
> > > > > Anything specific you're looking for?
> > > 
> > > > Actually I was thinking of capturing the network traffic, something
> > > > like:
> > > > 	tcpdump -s0 -wtmp.pcap -i<interface>
> > > 
> > > > then try the mount, then kill tcpdump and look at tmp.pcap.
> > > 
> > > I don't see anything suspicious, can you please have a look?
> > > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v3.pcap
> > > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.pcap
> > > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.1.pcap
> > > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.2.pcap
> > 
> > It might be the "hide" option, that's odd:
> 
> Nup. I think "hide" is ignored for NFSv4 anyway.

Yes, that's just the default, sorry for the distraction....

> Problem is that a subdirectory of a tmpfs filesystem is being exported.

Yuck.

> That requires (for NFSv4), the top of the tmpfs filesystem to be
> exported with NFSEXP_V4ROOT so that an NFSv4 client can navigate down to
> it.
> But when mountd creates that V4ROOT export, it doesn't provide the fsid.
> So the kernel rejects the export request.
> 
> We need to fix mountd to set the fsid on all exports within a filesystem
> for which it was specified, particularly the NFSEXP_V4ROOT ancestors.

Got it, that makes sense.

--b.
