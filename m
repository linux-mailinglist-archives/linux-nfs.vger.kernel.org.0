Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04E72C0FBE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgKWQFe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 11:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgKWQFe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 11:05:34 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A22C061A4D
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 08:05:34 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id AB6BD6EA1; Mon, 23 Nov 2020 11:05:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AB6BD6EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606147533;
        bh=JdxQXeb6gs/2+wit7MyaDdwCihwr7XsUtq91Wzla6Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lq/PMlfhvsJObMdBTLzRt+0v/iV4jl0iTbdqGqofAJVa3S3KcbPF9WHn42Qt+902m
         mUHQ68zxr2/3TQgYee46369UZPnZYRZk//FHOhTNEDCUEc80Yz56iGSWxsRR7ppVvh
         XRj+1ZZIWKH65SYxqMMl8CBFCAPlvc50QCuLj6eU=
Date:   Mon, 23 Nov 2020 11:05:33 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Roberto Bergantinos Corpas <rbergant@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc : make RPC channel buffer dynamic for slow case
Message-ID: <20201123160533.GE32599@fieldses.org>
References: <20201026150530.29019-1-rbergant@redhat.com>
 <20201106215128.GD26028@fieldses.org>
 <CACWnjLxiCTAkxBca_NFrUSPCq_g4y0yNaHuNKX+Rwr=-xPhibw@mail.gmail.com>
 <20201123153627.GD32599@fieldses.org>
 <F4985547-8F5A-4694-8785-E05E5BC5390F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4985547-8F5A-4694-8785-E05E5BC5390F@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 10:48:02AM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 23, 2020, at 10:36 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > On Sat, Nov 21, 2020 at 11:54:30AM +0100, Roberto Bergantinos Corpas wrote:
> >> Hi Bruce,
> >> 
> >>  Sorry for late response as well.
> >> 
> >>    Ok, here's a possible patch, let me know your thoughts
> > 
> > Looks good to me!  Could you just submit with changelog and
> > Signed-off-by?
> 
> Bruce, are you taking this for v5.10-rc, or shall I include it
> with v5.11 ?

I think the immediate problem was fixed by 27a1e8a0f79e and this is more
clean-up, so it can wait for v5.11, if you don't mind taking it.

--b.
