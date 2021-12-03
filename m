Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E816B467A26
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 16:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381683AbhLCPXV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 10:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352668AbhLCPXV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 10:23:21 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35873C061751;
        Fri,  3 Dec 2021 07:19:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 56987574C; Fri,  3 Dec 2021 10:19:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 56987574C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638544796;
        bh=bonjMMvW/Ei1QkvKqVke6WBYxPWF6U3BWJGAeHtFz1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MojdB+da+INH9uRteWaznyWbV8CMcgEKiKH4RHoM6jw7AY7GUyfEqj3tuHkWFVP02
         yb1fRCn16IngEIYhp5CoAdEJUuGuS9GNFH74PSByEbmZYd4lyy4oskv77dVrqmI/1U
         5roR9yPqhVQlIW0+wwSqaZo47RKBBXwlDPY+c41E=
Date:   Fri, 3 Dec 2021 10:19:56 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Message-ID: <20211203151956.GA24150@fieldses.org>
References: <20211130113436.1770168-1-weiyongjun1@huawei.com>
 <888F3743-AB98-41A6-9651-EFDE5987AA01@oracle.com>
 <20211203112505.GI9522@kadam>
 <0428D783-49FE-451E-827B-6DB8F03347D1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0428D783-49FE-451E-827B-6DB8F03347D1@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 03, 2021 at 03:17:30PM +0000, Chuck Lever III wrote:
> 
> 
> > On Dec 3, 2021, at 6:25 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > On Tue, Nov 30, 2021 at 08:19:47PM +0000, Chuck Lever III wrote:
> >>> 
> >>> -DEFINE_SPINLOCK(nfsd_notifier_lock);
> >>> +static DEFINE_SPINLOCK(nfsd_notifier_lock);
> >>> static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
> >>> 	void *ptr)
> >>> {
> >>> 
> >> 
> >> Thanks! This was pushed to the tip of the for-next branch at
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> >> 
> >> I removed the Fixes: line because a backport is unnecessary, and
> >> the commit ID is not yet permanent.
> > 
> > Removing the tag, makes it more complicated for backporters.  Before
> > they could tell automatically from the Fixes tag that backporting was
> > not necessary.
> > 
> > On the other hand, does this patch really need a Fixes tag since it's
> > not a runtime bug?  Different maintainers take different sides in that
> > argument.
> > 
> > If the patch needed a fixes tag then a lot of maintainers have scripts
> > to update the tag during a rebase.  There are also automated tool run on
> > linux-next which emails a warning when the Fixes tags point to an
> > invalid hash.
> 
> Hi Dan, the patch fixes a bug in my for-next branch, not in mainline.
> There's really no need for a Fixes: tag.

Assuming it doesn't get folded into the fixed patch before going
upstream, it'd be useful information to have there.

--b.
