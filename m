Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A42DC25C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 15:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgLPOi2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 09:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgLPOi2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 09:38:28 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B67C061794;
        Wed, 16 Dec 2020 06:37:48 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id C673367C6; Wed, 16 Dec 2020 09:37:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C673367C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1608129466;
        bh=j7LWydzjSuYZxpAKvBq1ShS/WYafbK9TgdHglPE4vFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lnDgazlxhSpCEEROfWcyCpXSjVGEncgBmfLREHx1+ySUit3xM+WmxHrXM/1VBwVIt
         Hg52pGFuoQa0ll+czeblwJY151WtaJi2+c+5bl1devlaMMUGYNTzxLwv51TAgxQ936
         ft/70D1aU+h+k/NgtEuIbM4l/3HHUVA750DFoPOs=
Date:   Wed, 16 Dec 2020 09:37:46 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [GIT PULL] nfsd changes for 5.11
Message-ID: <20201216143746.GA26084@fieldses.org>
References: <200F1E47-2C8E-42FB-A661-0139F424C0D4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200F1E47-2C8E-42FB-A661-0139F424C0D4@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 14, 2020 at 03:41:13PM -0500, Chuck Lever wrote:
> Hi Linus-
> 
> Seasons greetings. tl;dr:
> 
> The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:
> 
>   Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.11
> 
> for you to fetch changes up to 716a8bc7f706eeef80ab42c99d9f210eda845c81:
> 
>   nfsd: Record NFSv4 pre/post-op attributes as non-atomic (2020-12-09 09:39:38 -0500)
> 
> ----------------------------------------------------------------
> 
> Several substantial changes this time around.
> 
> + Previously, exporting an NFS mount via NFSD was considered to be
>   an unsupported feature. With v5.11, the community has attempted
>   to make re-exporting a first-class feature of NFSD.

To be clear: this is work in progress.  I've been keeping notes at
https://wiki.linux-nfs.org/wiki/index.php/NFS_re-export

Remaining issues include reboot recovery, filehandle size limits, and an
unidentified crash in the nfsd file locking code.

--b.

>   This would
>   enable the Linux in-kernel NFS server to be used as an intermediate
>   cache for a remotely-located primary NFS server, for example, even
>   with other NFS server implementations, like a NetApp filer, as the
>   primary.
> 
> + A short series of patches brings support for multiple RPC/RDMA
>   data chunks per RPC transaction to the Linux NFS server's RPC/RDMA
>   transport implementation. This is a part of the RPC/RDMA spec that
>   the other premiere NFS/RDMA implementation (Solaris) has had for a
>   very long time, and completes the implementation of RPC/RDMA
>   version 1 in the Linux kernel's NFS server.
> 
> + Long ago, NFSv4 support was introduced to NFSD using a series of
>   C macros that hid dprintk's and goto's. Over time, the kernel's
>   XDR implementation has been greatly improved, but these C macros
>   have remained and become fallow. A series of patches in this pull
>   request completely replaces those macros with the use of current
>   kernel XDR infrastructure. Benefits include:
> 
>   - More robust input sanitization in NFSD's NFSv4 XDR decoders.
>   - Make it easier to use common kernel library functions that use
>     XDR stream APIs (for example, GSS-API).
>   - Align the structure of the source code with the RFCs so it is
>     easier to learn, verify, and maintain our XDR implementation.
>   - Removal of more than a hundred hidden dprintk() call sites.
>   - Removal of some explicit manipulation of pages to help make the
>     eventual transition to xdr->bvec smoother.
> 
> + On top of several related fixes in 5.10-rc, there are a few more
>   fixes to get the Linux NFSD implementation of NFSv4.2 inter-server
>   copy up to speed.
> 
> And as usual, there is a pinch of seasoning in the form of a
> collection of unrelated minor bug fixes and clean-ups.
> 
> Many thanks to all who contributed this time around!
> 
> ----------------------------------------------------------------
> Alex Shi (1):
>       nfsd/nfs3: remove unused macro nfsd3_fhandleres
> 
> Cheng Lin (1):
>       nfs_common: need lock during iterate through the list
> 
> Chuck Lever (112):
>       svcrdma: Catch another Reply chunk overflow case
>       SUNRPC: Adjust synopsis of xdr_buf_subsegment()
>       svcrdma: Const-ify the xdr_buf arguments
>       svcrdma: Refactor the RDMA Write path
>       SUNRPC: Rename svc_encode_read_payload()
>       NFSD: Invoke svc_encode_result_payload() in "read" NFSD encoders
>       svcrdma: Post RDMA Writes while XDR encoding replies
>       svcrdma: Clean up svc_rdma_encode_reply_chunk()
>       svcrdma: Add a "parsed chunk list" data structure
>       svcrdma: Use parsed chunk lists to derive the inv_rkey
>       svcrdma: Use parsed chunk lists to detect reverse direction replies
>       svcrdma: Use parsed chunk lists to construct RDMA Writes
>       svcrdma: Use parsed chunk lists to encode Reply transport headers
>       svcrdma: Support multiple write chunks when pulling up
>       svcrdma: Support multiple Write chunks in svc_rdma_map_reply_msg()
>       svcrdma: Support multiple Write chunks in svc_rdma_send_reply_chunk
>       svcrdma: Remove chunk list pointers
>       svcrdma: Clean up chunk tracepoints
>       svcrdma: Rename info::ri_chunklen
>       svcrdma: Use the new parsed chunk list when pulling Read chunks
>       svcrdma: support multiple Read chunks per RPC
>       SUNRPC: Move the svc_xdr_recvfrom() tracepoint
>       NFSD: Clean up the show_nf_may macro
>       NFSD: Remove extra "0x" in tracepoint format specifier
>       NFSD: Add SPDX header for fs/nfsd/trace.c
>       SUNRPC: Add xdr_set_scratch_page() and xdr_reset_scratch_buffer()
>       SUNRPC: Prepare for xdr_stream-style decoding on the server-side
>       NFSD: Add common helpers to decode void args and encode void results
>       NFSD: Add tracepoints in nfsd_dispatch()
>       NFSD: Add tracepoints in nfsd4_decode/encode_compound()
>       NFSD: Replace the internals of the READ_BUF() macro
>       NFSD: Replace READ* macros in nfsd4_decode_access()
>       NFSD: Replace READ* macros in nfsd4_decode_close()
>       NFSD: Replace READ* macros in nfsd4_decode_commit()
>       NFSD: Change the way the expected length of a fattr4 is checked
>       NFSD: Replace READ* macros that decode the fattr4 size attribute
>       NFSD: Replace READ* macros that decode the fattr4 acl attribute
>       NFSD: Replace READ* macros that decode the fattr4 mode attribute
>       NFSD: Replace READ* macros that decode the fattr4 owner attribute
>       NFSD: Replace READ* macros that decode the fattr4 owner_group attribute
>       NFSD: Replace READ* macros that decode the fattr4 time_set attributes
>       NFSD: Replace READ* macros that decode the fattr4 security label attribute
>       NFSD: Replace READ* macros that decode the fattr4 umask attribute
>       NFSD: Replace READ* macros in nfsd4_decode_fattr()
>       NFSD: Replace READ* macros in nfsd4_decode_create()
>       NFSD: Replace READ* macros in nfsd4_decode_delegreturn()
>       NFSD: Replace READ* macros in nfsd4_decode_getattr()
>       NFSD: Replace READ* macros in nfsd4_decode_link()
>       NFSD: Relocate nfsd4_decode_opaque()
>       NFSD: Add helpers to decode a clientid4 and an NFSv4 state owner
>       NFSD: Add helper for decoding locker4
>       NFSD: Replace READ* macros in nfsd4_decode_lock()
>       NFSD: Replace READ* macros in nfsd4_decode_lockt()
>       NFSD: Replace READ* macros in nfsd4_decode_locku()
>       NFSD: Replace READ* macros in nfsd4_decode_lookup()
>       NFSD: Add helper to decode NFSv4 verifiers
>       NFSD: Add helper to decode OPEN's createhow4 argument
>       NFSD: Add helper to decode OPEN's openflag4 argument
>       NFSD: Replace READ* macros in nfsd4_decode_share_access()
>       NFSD: Replace READ* macros in nfsd4_decode_share_deny()
>       NFSD: Add helper to decode OPEN's open_claim4 argument
>       NFSD: Replace READ* macros in nfsd4_decode_open()
>       NFSD: Replace READ* macros in nfsd4_decode_open_confirm()
>       NFSD: Replace READ* macros in nfsd4_decode_open_downgrade()
>       NFSD: Replace READ* macros in nfsd4_decode_putfh()
>       NFSD: Replace READ* macros in nfsd4_decode_read()
>       NFSD: Replace READ* macros in nfsd4_decode_readdir()
>       NFSD: Replace READ* macros in nfsd4_decode_remove()
>       NFSD: Replace READ* macros in nfsd4_decode_rename()
>       NFSD: Replace READ* macros in nfsd4_decode_renew()
>       NFSD: Replace READ* macros in nfsd4_decode_secinfo()
>       NFSD: Replace READ* macros in nfsd4_decode_setattr()
>       NFSD: Replace READ* macros in nfsd4_decode_setclientid()
>       NFSD: Replace READ* macros in nfsd4_decode_setclientid_confirm()
>       NFSD: Replace READ* macros in nfsd4_decode_verify()
>       NFSD: Replace READ* macros in nfsd4_decode_write()
>       NFSD: Replace READ* macros in nfsd4_decode_release_lockowner()
>       NFSD: Replace READ* macros in nfsd4_decode_cb_sec()
>       NFSD: Replace READ* macros in nfsd4_decode_backchannel_ctl()
>       NFSD: Replace READ* macros in nfsd4_decode_bind_conn_to_session()
>       NFSD: Add a separate decoder to handle state_protect_ops
>       NFSD: Add a separate decoder for ssv_sp_parms
>       NFSD: Add a helper to decode state_protect4_a
>       NFSD: Add a helper to decode nfs_impl_id4
>       NFSD: Add a helper to decode channel_attrs4
>       NFSD: Replace READ* macros in nfsd4_decode_create_session()
>       NFSD: Replace READ* macros in nfsd4_decode_destroy_session()
>       NFSD: Replace READ* macros in nfsd4_decode_free_stateid()
>       NFSD: Replace READ* macros in nfsd4_decode_getdeviceinfo()
>       NFSD: Replace READ* macros in nfsd4_decode_layoutcommit()
>       NFSD: Replace READ* macros in nfsd4_decode_layoutget()
>       NFSD: Replace READ* macros in nfsd4_decode_layoutreturn()
>       NFSD: Replace READ* macros in nfsd4_decode_secinfo_no_name()
>       NFSD: Replace READ* macros in nfsd4_decode_sequence()
>       NFSD: Replace READ* macros in nfsd4_decode_test_stateid()
>       NFSD: Replace READ* macros in nfsd4_decode_destroy_clientid()
>       NFSD: Replace READ* macros in nfsd4_decode_reclaim_complete()
>       NFSD: Replace READ* macros in nfsd4_decode_fallocate()
>       NFSD: Replace READ* macros in nfsd4_decode_nl4_server()
>       NFSD: Replace READ* macros in nfsd4_decode_copy()
>       NFSD: Replace READ* macros in nfsd4_decode_copy_notify()
>       NFSD: Replace READ* macros in nfsd4_decode_offload_status()
>       NFSD: Replace READ* macros in nfsd4_decode_seek()
>       NFSD: Replace READ* macros in nfsd4_decode_clone()
>       NFSD: Replace READ* macros in nfsd4_decode_xattr_name()
>       NFSD: Replace READ* macros in nfsd4_decode_setxattr()
>       NFSD: Replace READ* macros in nfsd4_decode_listxattrs()
>       NFSD: Make nfsd4_ops::opnum a u32
>       NFSD: Replace READ* macros in nfsd4_decode_compound()
>       NFSD: Remove macros that are no longer used
>       SUNRPC: Remove XDRBUF_SPARSE_PAGES flag in gss_proxy upcall
>       NFSD: Fix sparse warning in nfs4proc.c
> 
> Dai Ngo (1):
>       NFSD: Fix 5 seconds delay when doing inter server copy
> 
> Huang Guobin (1):
>       nfsd: Fix error return code in nfsd_file_cache_init()
> 
> J. Bruce Fields (5):
>       nfsd: only call inode_query_iversion in the I_VERSION case
>       nfsd: simplify nfsd4_change_info
>       nfsd: minor nfsd4_change_attribute cleanup
>       nfsd4: don't query change attribute in v2/v3 case
>       Revert "nfsd4: support change_attr_type attribute"
> 
> Jeff Layton (3):
>       nfsd: add a new EXPORT_OP_NOWCC flag to struct export_operations
>       nfsd: allow filesystems to opt out of subtree checking
>       nfsd: close cached files prior to a REMOVE or RENAME that would replace target
> 
> Roberto Bergantinos Corpas (1):
>       sunrpc: clean-up cache downcall
> 
> Tom Rix (1):
>       NFSD: A semicolon is not needed after a switch statement.
> 
> Trond Myklebust (4):
>       exportfs: Add a function to return the raw output from fh_to_dentry()
>       nfsd: Fix up nfsd to ensure that timeout errors don't result in ESTALE
>       nfsd: Set PF_LOCAL_THROTTLE on local filesystems only
>       nfsd: Record NFSv4 pre/post-op attributes as non-atomic
> 
> kazuo ito (1):
>       nfsd: Fix message level for normal termination
> 
>  Documentation/filesystems/nfs/exporting.rst |   52 ++
>  fs/exportfs/expfs.c                         |   32 +-
>  fs/nfs/blocklayout/blocklayout.c            |    2 +-
>  fs/nfs/blocklayout/dev.c                    |    2 +-
>  fs/nfs/dir.c                                |    2 +-
>  fs/nfs/export.c                             |    3 +
>  fs/nfs/filelayout/filelayout.c              |    2 +-
>  fs/nfs/filelayout/filelayoutdev.c           |    2 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c      |    2 +-
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c   |    2 +-
>  fs/nfs/nfs42xdr.c                           |    2 +-
>  fs/nfs/nfs4xdr.c                            |    6 +-
>  fs/nfs_common/grace.c                       |    6 +-
>  fs/nfsd/export.c                            |    6 +
>  fs/nfsd/filecache.c                         |    1 +
>  fs/nfsd/nfs2acl.c                           |   21 +-
>  fs/nfsd/nfs3acl.c                           |    8 +-
>  fs/nfsd/nfs3proc.c                          |   11 +-
>  fs/nfsd/nfs3xdr.c                           |   40 +-
>  fs/nfsd/nfs4proc.c                          |   35 +-
>  fs/nfsd/nfs4state.c                         |    3 +-
>  fs/nfsd/nfs4xdr.c                           | 2665 +++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------
>  fs/nfsd/nfsd.h                              |    9 +-
>  fs/nfsd/nfsfh.c                             |   34 +-
>  fs/nfsd/nfsfh.h                             |   22 +-
>  fs/nfsd/nfsproc.c                           |   25 +-
>  fs/nfsd/nfssvc.c                            |   50 +-
>  fs/nfsd/nfsxdr.c                            |   16 +-
>  fs/nfsd/trace.c                             |    1 +
>  fs/nfsd/trace.h                             |  176 +++++-
>  fs/nfsd/vfs.c                               |   29 +-
>  fs/nfsd/xdr.h                               |    2 -
>  fs/nfsd/xdr3.h                              |    2 -
>  fs/nfsd/xdr4.h                              |   43 +-
>  include/linux/exportfs.h                    |   13 +
>  include/linux/iversion.h                    |   13 +
>  include/linux/nfs4.h                        |    8 -
>  include/linux/sunrpc/svc.h                  |   22 +-
>  include/linux/sunrpc/svc_rdma.h             |   36 +-
>  include/linux/sunrpc/svc_rdma_pcl.h         |  128 +++++
>  include/linux/sunrpc/svc_xprt.h             |    4 +-
>  include/linux/sunrpc/xdr.h                  |   91 +++-
>  include/trace/events/rpcrdma.h              |  171 +++---
>  include/trace/events/sunrpc.h               |   24 -
>  net/sunrpc/auth_gss/gss_rpc_upcall.c        |   15 +-
>  net/sunrpc/auth_gss/gss_rpc_xdr.c           |    3 +-
>  net/sunrpc/cache.c                          |   41 +-
>  net/sunrpc/svc.c                            |   16 +-
>  net/sunrpc/svc_xprt.c                       |    4 +-
>  net/sunrpc/svcsock.c                        |    8 +-
>  net/sunrpc/xdr.c                            |   78 ++-
>  net/sunrpc/xprtrdma/Makefile                |    2 +-
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c  |   14 +-
>  net/sunrpc/xprtrdma/svc_rdma_pcl.c          |  306 +++++++++++
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c     |  316 ++++++-----
>  net/sunrpc/xprtrdma/svc_rdma_rw.c           |  608 +++++++++++++++------
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c       |  560 ++++++++++---------
>  net/sunrpc/xprtrdma/svc_rdma_transport.c    |    2 +-
>  58 files changed, 3536 insertions(+), 2261 deletions(-)
>  create mode 100644 include/linux/sunrpc/svc_rdma_pcl.h
>  create mode 100644 net/sunrpc/xprtrdma/svc_rdma_pcl.c
> --
> Chuck Lever
> 
> 
