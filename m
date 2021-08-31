Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D013FCEB8
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhHaUnQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbhHaUnQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 16:43:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D8C061575;
        Tue, 31 Aug 2021 13:42:20 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7336D7C78; Tue, 31 Aug 2021 16:42:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7336D7C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630442540;
        bh=ZJrHJ1rrjSuvwptXsTtOjECxqaqdaPYC/UzcVlUmlXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyUBOH3PYncZRQP9mTJ69eM2IPr6lb/NZ2EP4wp1UYoz7McxcCb1smF7o+cqoTJig
         zQWVCQG0oPOpSFc9nQLZjGoe/Wg2KRaSjP0TYIOXPCWKOWH8WEeAN6GnPxhFdJFVwH
         UYORRk42ZkHMyU9iNilbjVUmHAHsrv7PdFuNQ5js=
Date:   Tue, 31 Aug 2021 16:42:20 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] NFSD: Pull Read chunks in XDR decoders
Message-ID: <20210831204220.GB7585@fieldses.org>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 31, 2021 at 03:05:09PM -0400, Chuck Lever wrote:
> Hi Bruce-
> 
> Here is part of what we discussed recently about trying to align
> pages in NFS WRITE requests so that splice can be used. This
> series updates server-side RPC and svcrdma to ensure that an
> aligned xdr_buf::pages array is presented to NFSD, which is then
> converted into an aligned rq_vec for the VFS layer.

Seems sensible to me.

Do you have a git tree?  It didn't apply cleanly to 5.14 when I tried,
but I didn't stop to figure out why.

> The next step would be to look at how to make the best use of the
> aligned rq_vec.

Have you done any performance comparison just with this?

Doesn't seem like it should make a significant difference, but it might
be interesting to check anyway.

--b.

> My naive thought is that where there is a PAGE_SIZE
> entry in rq_vec and there is no page in the file's page cache at
> that offset, the transport-provided page can be flipped into place.
> Might work for replacing whole pages as well, but baby steps first.
> 
> This series has been exercised a bit with both TCP and RDMA, but no
> guarantees that it is completely bug-free. NFSv4 compounds with
> multiple WRITE payloads on RDMA are treated like TCP: the RPC
> message is contained in an unstructured stream of unaligned pages.
> 
> Comments encouraged.
> 
> ---
> 
> Chuck Lever (6):
>       SUNRPC: Capture value of xdr_buf::page_base
>       SUNRPC: xdr_stream_subsegment() must handle non-zero page_bases
>       NFSD: Have legacy NFSD WRITE decoders use xdr_stream_subsegment()
>       SUNRPC: svc_fill_write_vector() must handle non-zero page_bases
>       NFSD: Add a transport hook for pulling argument payloads
>       svcrdma: Pull Read chunks in ->xpo_argument_payload
> 
> 
>  fs/nfsd/nfs3proc.c                       |   3 +-
>  fs/nfsd/nfs3xdr.c                        |  16 +--
>  fs/nfsd/nfs4proc.c                       |   3 +-
>  fs/nfsd/nfs4xdr.c                        |   6 +
>  fs/nfsd/nfsproc.c                        |   3 +-
>  fs/nfsd/nfsxdr.c                         |  13 +--
>  fs/nfsd/xdr.h                            |   2 +-
>  fs/nfsd/xdr3.h                           |   2 +-
>  include/linux/sunrpc/svc.h               |   6 +-
>  include/linux/sunrpc/svc_rdma.h          |   8 ++
>  include/linux/sunrpc/svc_xprt.h          |   3 +
>  include/trace/events/rpcrdma.h           |  26 +++++
>  include/trace/events/sunrpc.h            |  20 +++-
>  net/sunrpc/svc.c                         |  38 +++++--
>  net/sunrpc/svcsock.c                     |   8 ++
>  net/sunrpc/xdr.c                         |  32 +++---
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  37 +++++-
>  net/sunrpc/xprtrdma/svc_rdma_rw.c        | 139 ++++++++++++++++++++---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |   1 +
>  19 files changed, 292 insertions(+), 74 deletions(-)
> 
> --
> Chuck Lever
