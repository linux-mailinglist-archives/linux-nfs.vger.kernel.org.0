Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1504E1A8477
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbgDNQRr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733258AbgDNQRo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Apr 2020 12:17:44 -0400
X-Greylist: delayed 3880 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 09:17:44 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CDEC061A0C;
        Tue, 14 Apr 2020 09:17:44 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4AA271C7A; Tue, 14 Apr 2020 12:17:44 -0400 (EDT)
Date:   Tue, 14 Apr 2020 12:17:44 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200414161744.GB9796@fieldses.org>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
 <20200413192907.GA23596@fieldses.org>
 <20200414121931.GA5100@ziepe.ca>
 <20200414151303.GA9796@fieldses.org>
 <20200414152016.GE5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414152016.GE5100@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 14, 2020 at 12:20:16PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 14, 2020 at 11:13:03AM -0400, J. Bruce Fields wrote:
> > On Tue, Apr 14, 2020 at 09:19:31AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Apr 13, 2020 at 03:29:07PM -0400, J. Bruce Fields wrote:
> > > > On Thu, Apr 09, 2020 at 02:47:50PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> > > > > > The commit ID is what automation should key off of. The short
> > > > > > description is only for human consumption. 
> > > > > 
> > > > > Right, so if the actual commit message isn't included so humans can
> > > > > read it then what was the point of including anything?
> > > > 
> > > > Personally as a human reading commits in a terminal window I prefer the
> > > > abbreviated form.
> > > 
> > > Frankly, I think they are useless, picking one of yours at random:
> > > 
> > >     Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
> > > 
> > > And sadly the '4e48f1cccab3' commit doesn't appear in Linus's tree so
> > 
> > Ow, apologies.  Looks like I rebased after writing that Fixes tag.
> > 
> > I wonder if it's possible to make git warn....
> > 
> > Looks like a pre-rebase hook could check the branch being rebased for
> > "Fixes:" lines referencing commits on the rebased branch.
> 
> I have some silly stuff to check patches before pushing them and it
> includes checking the fixes lines because they are very often
> wrong, both with wrong commit IDs and wrong subjects!

I'd be interested in seeing it.

> linux-next now automates complaining about them, but perhaps not
> following the standard format defeats that..

It's managed before:

	https://lore.kernel.org/r/20190704074048.65556740@canb.auug.org.au

though admittedly I was breaking the rule in a different way.  I can't
even be consistently rebellious.

> Use 'git merge-base --is-ancestor fixes_id linus/master' to check
> them.

Oh, yeah, that's better than what I was trying to do, thanks.

--b.
