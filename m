Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E23F4D12
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhHWPMM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhHWPML (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 11:12:11 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B7C061575
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 08:11:27 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 368826855; Mon, 23 Aug 2021 11:11:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 368826855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629731487;
        bh=zHsshka57LdVeAEwBFskmUltem0scBimosKO/3TgeyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZBBZT9BNCGDd2do3JSwG972J3O4yAz0zoEPshfbSvTP1B93x+3XAfbl3QShCVDIK
         VOtfpL/5nz0TAt6Lt262AvjCYf5KLfAMBZNfST+5+aGpgqY7QnUm5V9TlPkZBc6BHL
         TnC8cFaoAW06Xi02zmcR8B8jBm3pPjoz8kWlUFpU=
Date:   Mon, 23 Aug 2021 11:11:27 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: sporadic generic/154 failure
Message-ID: <20210823151127.GB883@fieldses.org>
References: <20210823144802.GA883@fieldses.org>
 <e3ea3f425fb8765d13e7b73aaf7df5022c4183e5.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ea3f425fb8765d13e7b73aaf7df5022c4183e5.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 23, 2021 at 03:06:21PM +0000, Trond Myklebust wrote:
> On Mon, 2021-08-23 at 10:48 -0400, J. Bruce Fields wrote:
> > I'm seeing generic/154 failing sometimes.
> > 
> > It does a "cp --reflink" (which uses FI_CLONE, which results in a
> > ->remap_file_range call that NFS maps to the CLONE operation), then
> > overwriting parts of the fire, and checking free blocks (with "stat -f
> > /path -c "%f") at various points, and failing when the number of free
> > blocks is outside an expected range.
> > 
> > I don't know if it might be some caching issue, or something about how
> > NFS reports free blocks.
> > 
> > Honestly it looks unlikely to be critical, so for now I'm ignoring
> > it....
> > 
> 
> XFS backend?

Yes.

> It could be speculative preallocation. The fact that NFS
> can defer closing the file (either due to delegations or due to the
> NFSv3 file cache) typically results in it taking longer for XFS to free
> up the blocks it preallocated. That again means it takes longer for the
> 'space used' to settle to the correct final value.
> 
> https://linux-xfs.oss.sgi.narkive.com/jjjfnyI1/faq-xfs-speculative-preallocation

That sounds plausible.

--b.
