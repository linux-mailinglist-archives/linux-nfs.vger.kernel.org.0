Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03CF62F13
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfGIDxJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 23:53:09 -0400
Received: from fieldses.org ([173.255.197.46]:38370 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIDxJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Jul 2019 23:53:09 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 99FED7CB; Mon,  8 Jul 2019 23:53:08 -0400 (EDT)
Date:   Mon, 8 Jul 2019 23:53:08 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 0/8] server-side support for "inter" SSC copy
Message-ID: <20190709035308.GA15860@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for resending.  What's the status of Amir's series?  I guess I've
been using that as an excuse to put off reviewing these, but I really
should anyway....

--b.

On Mon, Jul 08, 2019 at 03:23:44PM -0400, Olga Kornievskaia wrote:
> This patch series adds support for NFSv4.2 copy offload feature
> allowing copy between two different NFS servers.
> 
> This functionality depends on the VFS ability to support generic
> copy_file_range() where a copy is done between an NFS file and
> a local file system. This is on top of Amir's VFS generic copy
> offload series.
> 
> This feature is enabled by the kernel module parameter --
> inter_copy_offload_enable -- and by default is disabled. There is
> also a kernel compile configuration of NFSD_V4_2_INTER_SSC that
> adds dependency on the NFS client side functions called from the
> server.
> 
> These patches work on top of existing async intra copy offload
> patches. For the "inter" SSC, the implementation only supports
> asynchronous inter copy.
> 
> On the source server, upon receiving a COPY_NOTIFY, it generate a
> unique stateid that's kept in the global list. Upon receiving a READ
> with a stateid, the code checks the normal list of open stateid and
> now additionally, it'll check the copy state list as well before
> deciding to either fail with BAD_STATEID or find one that matches.
> The stored stateid is only valid to be used for the first time
> with a choosen lease period (90s currently). When the source server
> received an OFFLOAD_CANCEL, it will remove the stateid from the
> global list. Otherwise, the copy stateid is removed upon the removal
> of its "parent" stateid (open/lock/delegation stateid).
> 
> On the destination server, upon receiving a COPY request, the server
> establishes the necessary clientid/session with the source server.
> It calls into the NFS client code to establish the necessary
> open stateid, filehandle, file description (without doing an NFS open).
> Then the server calls into the copy_file_range() to preform the copy
> where the source file will issue NFS READs and then do local file
> system writes (this depends on the VFS ability to do cross device
> copy_file_range().
> 
> v4:
> --- allowing for synchronous inter server-to-server copy
> --- added missing offload_cancel on the source server
> 
> Already presented numbers for performance improvement for large
> file transfer but here are times for copying linux kernel tree
> (which is mostly small files):
> -- regular cp 6m1s (intra)
> -- copy offload cp 4m11s (intra)
>    -- benefit of using copy offload with small copies using sync copy
> -- regular cp 6m9s (inter)
> -- copy offload cp 6m3s (inter)
>    -- same performance as traditional as for most it fallback to traditional
> copy offload
> 
> Olga Kornievskaia (8):
>   NFSD fill-in netloc4 structure
>   NFSD add ca_source_server<> to COPY
>   NFSD return nfs4_stid in nfs4_preprocess_stateid_op
>   NFSD add COPY_NOTIFY operation
>   NFSD check stateids against copy stateids
>   NFSD generalize nfsd4_compound_state flag names
>   NFSD: allow inter server COPY to have a STALE source server fh
>   NFSD add nfs4 inter ssc to nfsd4_copy
> 
>  fs/nfsd/Kconfig     |  10 ++
>  fs/nfsd/nfs4proc.c  | 434 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  fs/nfsd/nfs4state.c | 135 ++++++++++++++--
>  fs/nfsd/nfs4xdr.c   | 172 ++++++++++++++++++++-
>  fs/nfsd/nfsd.h      |  32 ++++
>  fs/nfsd/nfsfh.h     |   5 +-
>  fs/nfsd/nfssvc.c    |   6 +
>  fs/nfsd/state.h     |  25 ++-
>  fs/nfsd/xdr4.h      |  37 ++++-
>  9 files changed, 790 insertions(+), 66 deletions(-)
> 
> -- 
> 1.8.3.1
