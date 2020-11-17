Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50B2B68AB
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 16:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgKQP0g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 10:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbgKQP0g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Nov 2020 10:26:36 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F74C0613CF
        for <linux-nfs@vger.kernel.org>; Tue, 17 Nov 2020 07:26:36 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 194D31C21; Tue, 17 Nov 2020 10:26:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 194D31C21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605626796;
        bh=n5U3zWqM+ZL59vEcrCsKK3dQNxfJZWM5yIvTYJL+EWI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=N5SZshkoZVjxu+GC6PePpixs6+uA4uME+9QXVsAds4y6eJ0o236hmcFWmT44Kh93J
         A7qPlwHCgtcZZUH74zGORe8+T1o2zPFwdkH2l+d1Jmqvol+FgEmgPiAoxSstLyJC2U
         KxbK4YqMm2GObXkUT+OOsF4pKm3EdPLe/1g0Eri8=
Date:   Tue, 17 Nov 2020 10:26:36 -0500
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
Message-ID: <20201117152636.GC4556@fieldses.org>
References: <20201117031601.GB10526@fieldses.org>
 <1605583086-19869-1-git-send-email-bfields@redhat.com>
 <1605583086-19869-2-git-send-email-bfields@redhat.com>
 <a5704a8f7a6ebdfa60d4fa996a4d9ebaacc7daaf.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5704a8f7a6ebdfa60d4fa996a4d9ebaacc7daaf.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 17, 2020 at 07:34:49AM -0500, Jeff Layton wrote:
> I don't think I described what I was thinking well. Let me try again...
> 
> There should be no need to change the code in iversion.h -- I think we
> can do this in a way that's confined to just nfsd/export code.
> 
> What I would suggest is to have nfsd4_change_attribute call the
> fetch_iversion op if it exists, instead of checking IS_I_VERSION and
> doing the stuff in that block. If fetch_iversion is NULL, then just use
> the ctime.
> 
> Then, you just need to make sure that the filesystems' export_ops have
> an appropriate fetch_iversion vector. xfs, ext4 and btrfs can just call
> inode_query_iversion, and NFS and Ceph can call inode_peek_iversion_raw.
> The rest of the filesystems can leave fetch_iversion as NULL (since we
> don't want to use it on them).

Thanks for your patience, that makes sense, I'll try it.

--b.
