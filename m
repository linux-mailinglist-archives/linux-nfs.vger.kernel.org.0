Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98012EEBCF
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jan 2021 04:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhAHDSm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 22:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbhAHDSm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jan 2021 22:18:42 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3DC0612F4
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 19:18:02 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 97C956C79; Thu,  7 Jan 2021 22:18:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 97C956C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610075880;
        bh=Bqtd5hnau7tHNZDG9YSh2HwWYdArmGgc85l8dz8Zhz4=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=K3dOVQbC+4JfYg/GJ/KqnXapcnEfWDRq+8RiONAbPn18RIXx2pMnyhLnfbRjEkKTT
         EQtEf/U3uJO3Bi+x0DhfqR0vosPnKfZrYXj3cIcGS6WVS+BTOrqxOPvc8AC5XdHis3
         1C1XkywtL1ZoU3ubUjc+kBDrSEYe5Zn7agvj8F98=
Date:   Thu, 7 Jan 2021 22:18:00 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 00/42] Update NFSD XDR functions
Message-ID: <20210108031800.GA13604@fieldses.org>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I haven't had a chance to review these, but thought I should mention I'm
seeing a failure in xfstests generic/465 that I don't *think* is
reproduceable before this series.  Unfortunately it's intermittent,
though, so I'm not certain yet.

--b.

On Tue, Jan 05, 2021 at 10:29:40AM -0500, Chuck Lever wrote:
> The long-term purpose is to convert the NFSD XDR encoder and decoder
> functions to use the struct xdr_stream API. This is a refactor and
> clean-up with few or no changes in behavior expected, but there are
> some long-term benefits:
> 
> - More robust input sanitization in the NFSD decoders.
> - Help make it possible to use common kernel library functions with
>   XDR stream APIs (for example, GSS-API).
> - Align the structure of the source code with the RFCs so it is
>   easier to learn, verify, and maintain our XDR implementation.
> - Removal of more than a hundred hidden dprintk() call sites.
> - Removal of as much explicit manipulation of pages as possible to
>   help make the eventual transition to xdr->bvecs smoother.
> 
> The current series focuses on NFSv2 and NFSv3 decoder changes. Please
> review and comment!
> 
> The full set of patches lives in a topic branch in my git repo:
> 
>  git://git.linux-nfs.org/projects/cel/cel-2.6.git nfsd-xdr_stream
> 
> 
> ---
> 
> Chuck Lever (42):
>       SUNRPC: Make trace_svc_process() display the RPC procedure symbolically
>       SUNRPC: Display RPC procedure names instead of proc numbers
>       SUNRPC: Move definition of XDR_UNIT
>       NFSD: Update GETATTR3args decoder to use struct xdr_stream
>       NFSD: Update ACCESS3arg decoder to use struct xdr_stream
>       NFSD: Update READ3arg decoder to use struct xdr_stream
>       NFSD: Update WRITE3arg decoder to use struct xdr_stream
>       NFSD: Update READLINK3arg decoder to use struct xdr_stream
>       NFSD: Fix returned READDIR offset cookie
>       NFSD: Add helper to set up the pages where the dirlist is encoded
>       NFSD: Update READDIR3args decoders to use struct xdr_stream
>       NFSD: Update COMMIT3arg decoder to use struct xdr_stream
>       NFSD: Update the NFSv3 DIROPargs decoder to use struct xdr_stream
>       NFSD: Update the RENAME3args decoder to use struct xdr_stream
>       NFSD: Update the LINK3args decoder to use struct xdr_stream
>       NFSD: Update the SETATTR3args decoder to use struct xdr_stream
>       NFSD: Update the CREATE3args decoder to use struct xdr_stream
>       NFSD: Update the MKDIR3args decoder to use struct xdr_stream
>       NFSD: Update the SYMLINK3args decoder to use struct xdr_stream
>       NFSD: Update the MKNOD3args decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 GETATTR argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 READ argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 WRITE argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 READLINK argument decoder to use struct xdr_stream
>       NFSD: Add helper to set up the pages where the dirlist is encoded
>       NFSD: Update the NFSv2 READDIR argument decoder to use struct xdr_stream
>       NFSD: Update NFSv2 diropargs decoding to use struct xdr_stream
>       NFSD: Update the NFSv2 RENAME argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 LINK argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 SETATTR argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 CREATE argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 SYMLINK argument decoder to use struct xdr_stream
>       NFSD: Remove argument length checking in nfsd_dispatch()
>       NFSD: Update the NFSv2 GETACL argument decoder to use struct xdr_stream
>       NFSD: Add an xdr_stream-based decoder for NFSv2/3 ACLs
>       NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 ACL GETATTR argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 ACL ACCESS argument decoder to use struct xdr_stream
>       NFSD: Clean up after updating NFSv2 ACL decoders
>       NFSD: Update the NFSv3 GETACL argument decoder to use struct xdr_stream
>       NFSD: Update the NFSv2 SETACL argument decoder to use struct xdr_stream
>       NFSD: Clean up after updating NFSv3 ACL decoders
> 
> 
>  fs/nfs_common/nfsacl.c          |  52 +++
>  fs/nfsd/nfs2acl.c               |  62 ++--
>  fs/nfsd/nfs3acl.c               |  42 ++-
>  fs/nfsd/nfs3proc.c              |  71 +++--
>  fs/nfsd/nfs3xdr.c               | 538 ++++++++++++++++++--------------
>  fs/nfsd/nfsproc.c               |  74 +++--
>  fs/nfsd/nfssvc.c                |  34 --
>  fs/nfsd/nfsxdr.c                | 350 ++++++++++-----------
>  fs/nfsd/xdr.h                   |  12 +-
>  fs/nfsd/xdr3.h                  |  20 +-
>  include/linux/nfsacl.h          |   3 +
>  include/linux/sunrpc/msg_prot.h |   3 -
>  include/linux/sunrpc/xdr.h      |  13 +-
>  include/trace/events/sunrpc.h   |  15 +-
>  include/uapi/linux/nfs3.h       |   6 +
>  15 files changed, 680 insertions(+), 615 deletions(-)
> 
> --
> Chuck Lever
