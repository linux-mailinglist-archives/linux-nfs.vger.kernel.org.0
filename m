Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231131A81C7
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437652AbgDNPNp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 11:13:45 -0400
Received: from fieldses.org ([173.255.197.46]:48090 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437512AbgDNPNI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 14 Apr 2020 11:13:08 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id DF77D1CE6; Tue, 14 Apr 2020 11:13:03 -0400 (EDT)
Date:   Tue, 14 Apr 2020 11:13:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200414151303.GA9796@fieldses.org>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
 <20200413192907.GA23596@fieldses.org>
 <20200414121931.GA5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414121931.GA5100@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 14, 2020 at 09:19:31AM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2020 at 03:29:07PM -0400, J. Bruce Fields wrote:
> > On Thu, Apr 09, 2020 at 02:47:50PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> > > > The commit ID is what automation should key off of. The short
> > > > description is only for human consumption. 
> > > 
> > > Right, so if the actual commit message isn't included so humans can
> > > read it then what was the point of including anything?
> > 
> > Personally as a human reading commits in a terminal window I prefer the
> > abbreviated form.
> 
> Frankly, I think they are useless, picking one of yours at random:
> 
>     Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
> 
> And sadly the '4e48f1cccab3' commit doesn't appear in Linus's tree so

Ow, apologies.  Looks like I rebased after writing that Fixes tag.

I wonder if it's possible to make git warn....

Looks like a pre-rebase hook could check the branch being rebased for
"Fixes:" lines referencing commits on the rebased branch.

> now we are just totally lost, with a bad commit ID and a mangled
> subject line.

For what it's worth, that part of the subject line is enough to find the
original commit (even to uniquely specify it).

> > I haven't been doing the redundant parentheses and quotes either.  Was
> > that dreamt up by an Arlo Guthrie fan?  ("KID, HAVE YOU REHABILITATED
> > YOURSELF?")
> 
> Well it seems like you are just aren't following the standard style
> at all. :(

Yeah, I don't like it.

I'll admit I don't know why *this* exactly is what I'm choosing to feel
stubborn about.

--b.
