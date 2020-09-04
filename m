Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094FA25DD39
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgIDPYg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbgIDPYa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 11:24:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E73C061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 08:24:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4D3C11509; Fri,  4 Sep 2020 11:24:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4D3C11509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599233069;
        bh=Hd7d/Ov53FZg42ZH9GAiN85Zp3KOdBt8VgfG6P0v2I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVrONGurzomW3zq0zTRRlmz3usGCEvL2R5CtN2A41Kqx71VENf51caaEMFvISCQLZ
         2pqU4gr6R1zUnWrEuQ7c4LPKqlBMphEyzz6P4lSxqQTHI9PZBTGdZn9xZ4f9hS6UlQ
         xB6t+G9x36A523Je90sj9Ic/+I0GJyvVLRoi9Um4=
Date:   Fri, 4 Sep 2020 11:24:29 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
Message-ID: <20200904152429.GA1738@fieldses.org>
References: <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
 <20200901191854.GD12082@fieldses.org>
 <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
 <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
 <20200904142923.GE26706@fieldses.org>
 <C73640A5-E374-46D7-9F35-EF34B17E4F3C@oracle.com>
 <20200904144932.GA349848@pick.fieldses.org>
 <45DCF35D-A919-4A99-9B6D-0952ED0A78E5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45DCF35D-A919-4A99-9B6D-0952ED0A78E5@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 04, 2020 at 10:58:43AM -0400, Chuck Lever wrote:
> > What do you think might go wrong otherwise?
> 
> I don't see a data corruption issue here, if that's what
> you mean.
> 
> Suppose the server has a large file with a lot of holes,
> and these holes are all unallocated. This might be
> typical of a container image.
> 
> Suppose further the client is able to punch holes in a
> destination file as a thin provisioning mechanism.
> 
> Now, suppose we copy the file via TCP/READ_PLUS, and
> that preserves the holes.
> 
> Copy with RDMA/SEEK_HOLE and maybe it doesn't preserve
> holes. The destination file is now significantly larger
> and less efficiently stored.
> 
> Or maybe it's the other way around. Either way, one
> mechanism is hole-preserving and one isn't.
> 
> A quality implementation would try to preserve holes as
> much as possible so that the server can make smart storage
> provisioning decisions.

OK, I can see that, thanks.

So, I was trying to make sure we handle cases where SEEK results are
weirdly aligned or segments returned are very small.  I don't think
that'll happen with any "normal" setup, I think it probably requires
strange FUSE filesystems or unusual races or malicious users or some
combination thereof.  So suboptimal handling is OK, I just don't want to
violate the protocol or crash or hang or something.

I'm not seeing the RDMA connection, by the way.  SEEK and READ_PLUS
should work the same over TCP and RDMA.

--b.
