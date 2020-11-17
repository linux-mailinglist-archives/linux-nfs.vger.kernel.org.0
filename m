Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355DC2B68CE
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 16:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKQPe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 10:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgKQPe7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Nov 2020 10:34:59 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD312222A;
        Tue, 17 Nov 2020 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605627298;
        bh=el8G+Am8q1n3OH+POVa4s76h0YooRTNz9Js8xrSRXV0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kPx6L6Vyde9MYeq2nGGqmACfxBHr/2+RbE+x0OVjH2UC1ZVd+UrugVm/YG1d0WilI
         pukdCvk+38nRShKAiklWyhTurGrvC/e6CQF062ksz0L0U/bvxQZCFcX2rozx2RiVSz
         +z7nXzPL7aOvMGGrHgfbKzB4kX8Sjbh5rk7V+BH4=
Message-ID: <725499c144317aac1a03f0334a22005588dbdefc.camel@kernel.org>
Subject: Re: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Tue, 17 Nov 2020 10:34:57 -0500
In-Reply-To: <20201117152636.GC4556@fieldses.org>
References: <20201117031601.GB10526@fieldses.org>
         <1605583086-19869-1-git-send-email-bfields@redhat.com>
         <1605583086-19869-2-git-send-email-bfields@redhat.com>
         <a5704a8f7a6ebdfa60d4fa996a4d9ebaacc7daaf.camel@kernel.org>
         <20201117152636.GC4556@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2020-11-17 at 10:26 -0500, J. Bruce Fields wrote:
> On Tue, Nov 17, 2020 at 07:34:49AM -0500, Jeff Layton wrote:
> > I don't think I described what I was thinking well. Let me try again...
> > 
> > There should be no need to change the code in iversion.h -- I think we
> > can do this in a way that's confined to just nfsd/export code.
> > 
> > What I would suggest is to have nfsd4_change_attribute call the
> > fetch_iversion op if it exists, instead of checking IS_I_VERSION and
> > doing the stuff in that block. If fetch_iversion is NULL, then just use
> > the ctime.
> > 
> > Then, you just need to make sure that the filesystems' export_ops have
> > an appropriate fetch_iversion vector. xfs, ext4 and btrfs can just call
> > inode_query_iversion, and NFS and Ceph can call inode_peek_iversion_raw.
> > The rest of the filesystems can leave fetch_iversion as NULL (since we
> > don't want to use it on them).
> 
> Thanks for your patience, that makes sense, I'll try it.
> 

There is one gotcha in here though... ext4 needs to also handle the case
where SB_I_VERSION is not set. The simple fix might be to just have
different export ops for ext4 based on whether it was mounted with -o
iversion or not, but maybe there is some better way to do it?

-- 
Jeff Layton <jlayton@kernel.org>

