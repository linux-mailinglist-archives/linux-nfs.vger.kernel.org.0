Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C2371085
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 04:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhECCYO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sun, 2 May 2021 22:24:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232845AbhECCYN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 2 May 2021 22:24:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FC84B20B;
        Mon,  3 May 2021 02:23:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     "Petr Vorel" <pvorel@suse.cz>, linux-nfs@vger.kernel.org,
        "Steve Dickson" <steved@redhat.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Subject: Re: Re: [RFC PATCH 1/1] mount.nfs: Fix mounting on tmpfs
In-reply-to: <20210423181345.GE10457@fieldses.org>
References: <20210422191803.31511-1-pvorel@suse.cz>,
 <20210422202334.GB25415@fieldses.org>, <YIIuUPrlbBlr1ooD@pevik>,
 <20210423142329.GB10457@fieldses.org>, <YIL+KWuPmgm8A82C@pevik>,
 <20210423181345.GE10457@fieldses.org>
Date:   Mon, 03 May 2021 12:21:27 +1000
Message-id: <162000848714.10466.9299093696289919822@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 24 Apr 2021, J . Bruce Fields wrote:
> On Fri, Apr 23, 2021 at 07:04:41PM +0200, Petr Vorel wrote:
> > Hi Bruce,
> > 
> > > On Fri, Apr 23, 2021 at 04:17:52AM +0200, Petr Vorel wrote:
> > > > Hi,
> > 
> > > > > On Thu, Apr 22, 2021 at 09:18:03PM +0200, Petr Vorel wrote:
> > > > > > LTP NFS tests (which use netns) fails on tmpfs since d4066486:
> > 
> > > > > > mount -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp /tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/0
> > > > > > mount.nfs: mounting 10.0.0.2:/tmp/ltp.nfs01.nfs-4.2/LTP_nfs01.UF6gRZCy3O/4.2/tcp failed, reason given by server: No such file or directory
> > 
> > > > > We should figure out the reason for the failure.  A network trace might
> > > > > help.
> > 
> > > > Anything specific you're looking for?
> > 
> > > Actually I was thinking of capturing the network traffic, something
> > > like:
> > > 	tcpdump -s0 -wtmp.pcap -i<interface>
> > 
> > > then try the mount, then kill tcpdump and look at tmp.pcap.
> > 
> > I don't see anything suspicious, can you please have a look?
> > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v3.pcap
> > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.pcap
> > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.1.pcap
> > https://gitlab.com/pevik/tmp/-/raw/master/nfs.v4.2.pcap
> 
> It might be the "hide" option, that's odd:

Nup. I think "hide" is ignored for NFSv4 anyway.

Problem is that a subdirectory of a tmpfs filesystem is being exported.
That requires (for NFSv4), the top of the tmpfs filesystem to be
exported with NFSEXP_V4ROOT so that an NFSv4 client can navigate down to
it.
But when mountd creates that V4ROOT export, it doesn't provide the fsid.
So the kernel rejects the export request.

We need to fix mountd to set the fsid on all exports within a filesystem
for which it was specified, particularly the NFSEXP_V4ROOT ancestors.

I might see if I how easy that is later.

NeilBrown
