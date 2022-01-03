Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5EC4838A0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 22:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiACVq3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 16:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACVq2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 16:46:28 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05A1C061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 13:46:28 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 17F4A6F28; Mon,  3 Jan 2022 16:46:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 17F4A6F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641246388;
        bh=xWcZGgyF07+cZQ7nJtIEk+uxj372QYC9qK/Blf7ZJas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irjhKfDg+JFsOY12usYehiQhpi+tr1vYOfedvmI0i9OlK3ag5QaAJeDYmczL9uBRm
         JlHHdjVxhTAox4CMvvmx2roUb6xEsQKKr5ds7Kz7k7hg41BBN9IrbdZfpqSWePHdh0
         ferW4OH+8ZOvln95ADx6AZPrZ/G26dlqlbZ581jA=
Date:   Mon, 3 Jan 2022 16:46:28 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] Support case insensitive filesystems in NFSv4
Message-ID: <20220103214628.GM21514@fieldses.org>
References: <20211217203658.439352-1-trondmy@kernel.org>
 <20220103200847.GH21514@fieldses.org>
 <cb2b119e0c95c8d9d783d8b28c7f2bc7973f7598.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2b119e0c95c8d9d783d8b28c7f2bc7973f7598.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 03, 2022 at 08:11:57PM +0000, Trond Myklebust wrote:
> On Mon, 2022-01-03 at 15:08 -0500, J. Bruce Fields wrote:
> > On Fri, Dec 17, 2021 at 03:36:53PM -0500, trondmy@kernel.org wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > Add support for detecting an export of a case insensitive
> > > filesystem in
> > > NFSv4. If that is the case, then we need to adjust the dentry
> > > caching
> > > and invalidation rules to ensure that we don't inadvertently end up
> > > caching other case folded aliases after an operation that results
> > > in a
> > > directory entry name change.
> > 
> > What server and configuration are you testing this against?
> 
> Ours.

You mean, hammerspace?

> Why?

Partly just curiousity.  Partly I thought we'd previously been trying to
add features on server and client side together when it makes sense, if
only to make it possible to test without access to proprietary software.

I don't actually have a strong opinion on the policy, but if this *is* a
change in policy then it's worth mentioning.

There should be other exportable filesystems supporting those attributes
so the work to export them on the server side wouldn't be a whole lot.
(But I can't volunteer.)

--b.

> > > 
> > > Trond Myklebust (5):
> > >   NFSv4: Add some support for case insensitive filesystems
> > >   NFSv4: Just don't cache negative dentries on case insensitive
> > > servers
> > >   NFS: Invalidate negative dentries on all case insensitive
> > > directory
> > >     changes
> > >   NFS: Add a helper to remove case-insensitive aliases
> > >   NFS: Fix the verifier for case sensitive filesystem in
> > >     nfs_atomic_open()
> > > 
> > >  fs/nfs/dir.c              | 41 +++++++++++++++++++++++++++++++++--
> > > ----
> > >  fs/nfs/internal.h         |  1 +
> > >  fs/nfs/nfs4proc.c         | 13 +++++++++++--
> > >  fs/nfs/nfs4xdr.c          | 40
> > > ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/nfs_fs_sb.h |  2 ++
> > >  include/linux/nfs_xdr.h   |  2 ++
> > >  6 files changed, 91 insertions(+), 8 deletions(-)
> > > 
> > > -- 
> > > 2.33.1
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
