Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F174A2BB958
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 23:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgKTWoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 17:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgKTWoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 17:44:39 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23EEC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 14:44:38 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 44A836E9D; Fri, 20 Nov 2020 17:44:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 44A836E9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605912278;
        bh=iahjJpmb2a36itD0CZCcwaZpdndHSna/vFK2IWBbsfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iaWJ1kSw/lP0zRUiO2skY2hvsXh6ZaOBzCpPCeTkI0eaKPqWEDRv+ddCosr15N4MF
         GEiCgPCTOn40PGte7q54BBsVWoW5zKv1g+7FKcjvqO7xiuF/tWk62PJjVtJ3e53M1j
         G25lxBgBIFGmaevV+ZMVZnwUIu6wtiKnjCD+/qUE=
Date:   Fri, 20 Nov 2020 17:44:38 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
Message-ID: <20201120224438.GC7705@fieldses.org>
References: <20201117031601.GB10526@fieldses.org>
 <1605583086-19869-1-git-send-email-bfields@redhat.com>
 <1605583086-19869-2-git-send-email-bfields@redhat.com>
 <a5704a8f7a6ebdfa60d4fa996a4d9ebaacc7daaf.camel@kernel.org>
 <20201117152636.GC4556@fieldses.org>
 <725499c144317aac1a03f0334a22005588dbdefc.camel@kernel.org>
 <20201120223831.GB7705@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120223831.GB7705@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 20, 2020 at 05:38:31PM -0500, J. Bruce Fields wrote:
> On Tue, Nov 17, 2020 at 10:34:57AM -0500, Jeff Layton wrote:
> > On Tue, 2020-11-17 at 10:26 -0500, J. Bruce Fields wrote:
> > > On Tue, Nov 17, 2020 at 07:34:49AM -0500, Jeff Layton wrote:
> > > > I don't think I described what I was thinking well. Let me try again...
> > > > 
> > > > There should be no need to change the code in iversion.h -- I think we
> > > > can do this in a way that's confined to just nfsd/export code.
> > > > 
> > > > What I would suggest is to have nfsd4_change_attribute call the
> > > > fetch_iversion op if it exists, instead of checking IS_I_VERSION and
> > > > doing the stuff in that block. If fetch_iversion is NULL, then just use
> > > > the ctime.
> > > > 
> > > > Then, you just need to make sure that the filesystems' export_ops have
> > > > an appropriate fetch_iversion vector. xfs, ext4 and btrfs can just call
> > > > inode_query_iversion, and NFS and Ceph can call inode_peek_iversion_raw.
> > > > The rest of the filesystems can leave fetch_iversion as NULL (since we
> > > > don't want to use it on them).
> > > 
> > > Thanks for your patience, that makes sense, I'll try it.
> > > 
> > 
> > There is one gotcha in here though... ext4 needs to also handle the case
> > where SB_I_VERSION is not set. The simple fix might be to just have
> > different export ops for ext4 based on whether it was mounted with -o
> > iversion or not, but maybe there is some better way to do it?
> 
> I was thinking ext4's export op could check for I_VERSION on its own and
> vary behavior based on that.
> 
> I'll follow up with new patches in a moment.
> 
> I think the first one's all that's needed to fix the problem Daire
> identified.  I'm a little less sure of the rest.
> 
> Lightly tested, just by running them through my usual regression tests
> (which don't re-export) and then running connectathon on a 4.2 re-export
> of a 4.2 mount.
> 
> The latter triggered a crash preceded by a KASAN use-after free warning.
> Looks like it might be a problem with blocking lock notifications,
> probably not related to these patches.

Another nit I ran across:

Some NFSv4 directory-modifying operations return pre- and post- change
attributes together with an "atomic" flag that's supposed to indicate
whether the change attributes were read atomically with the operation.
It looks like we're setting the atomic flag under the assumptions that
local vfs locks are sufficient to guarantee atomicity, which isn't right
when we're exporting a distributed filesystem.

In the case we're reexporting NFS I guess ideal would be to use the pre-
and post- attributes that the original server returned and also save
having to do extra getattr calls.  Not sure how we'd do that,
though--more export operations?  Maybe for now we could just figure out
when to turn off the atomic bit.

--b.
