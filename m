Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26C3D25D8
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jul 2021 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhGVNxu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jul 2021 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhGVNxu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jul 2021 09:53:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7CC061575
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jul 2021 07:34:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BF66F6C06; Thu, 22 Jul 2021 10:34:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BF66F6C06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1626964463;
        bh=Q6b9s+hgK3cgMIPgu7+H5W75yCavUFn9vWMzxEBJV3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4tMF3TYVQBeYRnFDG0MVlTGcpneXZfkj0o0cr9QKXj2ft+1U2c8W8G+601XLNJRZ
         qaiji/H43pKZzs4D5cH8Iki7NGx+ME/6HfsUJe0UsFxRxdTX56e8UvdUBIEqjdvmeC
         /2SQP+WYvCmETJ6Yl4J719nv8F9jf73yqrBj0Y0Q=
Date:   Thu, 22 Jul 2021 10:34:23 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [PATCH 3/3] nfs: don't allow reexport reclaims
Message-ID: <20210722143423.GB4552@fieldses.org>
References: <1623682098-13236-1-git-send-email-bfields@redhat.com>
 <1623682098-13236-4-git-send-email-bfields@redhat.com>
 <3189d061c1e862fe305e501226fcc9ebc1fe544d.camel@hammerspace.com>
 <20210614193409.GA16500@fieldses.org>
 <7b119b40fd29c424ce4e85fa4703b472bf0d379d.camel@hammerspace.com>
 <20210614200359.GC16500@fieldses.org>
 <2c776400a50afcd3e82f71f6ecb806fda1bce984.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c776400a50afcd3e82f71f6ecb806fda1bce984.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 14, 2021 at 09:03:35PM +0000, Trond Myklebust wrote:
> I want to avoid the kind of issues we've be met with earlier when
> mixing types just because they happened to be integer valued.
> 
> We introduced the mixing of POSIX/Linux and NFS errors in the NFS
> client back in the 1990s, and that was a mistake that we're still
> paying for. For instance, the value ERR_PTR(-NFSERR_NO_GRACE) will be
> happily declared as a valid pointer by the IS_ERR() test, and every so
> often we find an Oops around that issue because someone used the return
> value from a function that they thought was POSIX/Linux error valued,
> because it usually is returning POSIX errors.

I did this, by the way, but also ran across a couple more bugs in
testing.

At this point I've got connectathon locking tests passing on a
re-export--I need to do a little more cleanup and then I'll repost.

--b.
