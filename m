Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBCF1A88BC
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2020 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503527AbgDNSL4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 14:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503521AbgDNSLv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 14 Apr 2020 14:11:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40B220767;
        Tue, 14 Apr 2020 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586887910;
        bh=PXyEm7hJ8M3gDvk5QS/Bwpkh+X2oP5lM7oQmHn/oohM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwkg7EcBmDByFE6ub/7Cx3FrX4bOqN9fJi79Rin1bc9rhyf+Dtj5hGHES4sOFObDl
         uMurHGzZLefYtz9IrdKOnK6apNl7y6mK050DsVK1LE+qzRYWABZwEc3tyMAllmoGQF
         0i5Z64usbhFbnI9bFmrJw4yR9RLJfPLB80uIMbY8=
Date:   Tue, 14 Apr 2020 21:11:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
Message-ID: <20200414181141.GA1239315@unreal>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
 <20200413192907.GA23596@fieldses.org>
 <20200414121931.GA5100@ziepe.ca>
 <20200414151303.GA9796@fieldses.org>
 <20200414152016.GE5100@ziepe.ca>
 <20200414161744.GB9796@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161744.GB9796@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 14, 2020 at 12:17:44PM -0400, J. Bruce Fields wrote:
> On Tue, Apr 14, 2020 at 12:20:16PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 14, 2020 at 11:13:03AM -0400, J. Bruce Fields wrote:
> > > On Tue, Apr 14, 2020 at 09:19:31AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Apr 13, 2020 at 03:29:07PM -0400, J. Bruce Fields wrote:
> > > > > On Thu, Apr 09, 2020 at 02:47:50PM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
> > > > > > > The commit ID is what automation should key off of. The short
> > > > > > > description is only for human consumption.
> > > > > >
> > > > > > Right, so if the actual commit message isn't included so humans can
> > > > > > read it then what was the point of including anything?
> > > > >
> > > > > Personally as a human reading commits in a terminal window I prefer the
> > > > > abbreviated form.
> > > >
> > > > Frankly, I think they are useless, picking one of yours at random:
> > > >
> > > >     Fixes: 4e48f1cccab3 "NFSD: allow inter server COPY to have... "
> > > >
> > > > And sadly the '4e48f1cccab3' commit doesn't appear in Linus's tree so
> > >
> > > Ow, apologies.  Looks like I rebased after writing that Fixes tag.
> > >
> > > I wonder if it's possible to make git warn....
> > >
> > > Looks like a pre-rebase hook could check the branch being rebased for
> > > "Fixes:" lines referencing commits on the rebased branch.
> >
> > I have some silly stuff to check patches before pushing them and it
> > includes checking the fixes lines because they are very often
> > wrong, both with wrong commit IDs and wrong subjects!
>
> I'd be interested in seeing it.

checkpatch.pl checks it or supposed to check.

commit a8dd86bf746256fbf68f82bc13356244c5ad8efa
Author: Matteo Croce <mcroce@redhat.com>
Date:   Wed Sep 25 16:46:38 2019 -0700

    checkpatch.pl: warn on invalid commit id

    It can happen that a commit message refers to an invalid commit id,
    because the referenced hash changed following a rebase, or simply by
    mistake.  Add a check in checkpatch.pl which checks that an hash
    referenced by a Fixes tag, or just cited in the commit message, is a valid
    commit id.

        $ scripts/checkpatch.pl <<'EOF'
        Subject: [PATCH] test commit

        Sample test commit to test checkpatch.pl
        Commit 1da177e4c3f4 ("Linux-2.6.12-rc2") really exists,
        commit 0bba044c4ce7 ("tree") is valid but not a commit,
        while commit b4cc0b1c0cca ("unknown") is invalid.

        Fixes: f0cacc14cade ("unknown")
        Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
        EOF
        WARNING: Unknown commit id '0bba044c4ce7', maybe rebased or not pulled?
        #8:
        commit 0bba044c4ce7 ("tree") is valid but not a commit,

        WARNING: Unknown commit id 'b4cc0b1c0cca', maybe rebased or not pulled?
        #9:
        while commit b4cc0b1c0cca ("unknown") is invalid.

        WARNING: Unknown commit id 'f0cacc14cade', maybe rebased or not pulled?
        #11:
        Fixes: f0cacc14cade ("unknown")

        total: 0 errors, 3 warnings, 4 lines checked

    Link: http://lkml.kernel.org/r/20190711001640.13398-1-mcroce@redhat.com
    Signed-off-by: Matteo Croce <mcroce@redhat.com>
    Cc: Joe Perches <joe@perches.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
