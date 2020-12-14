Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2283C2DA1E2
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Dec 2020 21:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503088AbgLNUoJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Dec 2020 15:44:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502980AbgLNUoJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Dec 2020 15:44:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEKeu62116934;
        Mon, 14 Dec 2020 20:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=YucIf150MnBfpyt5lZejE8h8AHSjfPaYULppbMVS7t8=;
 b=o3bbyBGzulmbuEjWy+4UX1zJ3pLQeHTPiuWNKdMgiY4Tfp92aOaULdsmU328/3jf5nEA
 H2WqGaqCc2C2N0gno9SeUBLjVodd7Gs9AkojaG+skZoSBvhixCxJ82iUsKOp7M2tneZe
 pdb5W548AY8qKejWD+IVtGEop/hYVlPfv395T2jnnVWwOYcBYR5Ub84QpDGP5GWEnXpM
 pRNhtqNiSCCKiGgKO2sIlD5zXuuqGCT187Wqhnx3tWnwkYumlq2FwF4176ypcDlyXB6F
 DyPWMIzyu6MuUjDKqFCl9qUv0yuG9Npr6VLiUAn8NxXKRhxngo0TEiAIExbqI0ArQgsq jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9r7da3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 20:43:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEKeqee093747;
        Mon, 14 Dec 2020 20:41:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35e6epdemw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 20:41:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BEKfFeI001291;
        Mon, 14 Dec 2020 20:41:15 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 12:41:15 -0800
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [GIT PULL] nfsd changes for 5.11
Message-Id: <200F1E47-2C8E-42FB-A661-0139F424C0D4@oracle.com>
Date:   Mon, 14 Dec 2020 15:41:13 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140138
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

Seasons greetings. tl;dr:

The following changes since commit =
b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.11

for you to fetch changes up to 716a8bc7f706eeef80ab42c99d9f210eda845c81:

  nfsd: Record NFSv4 pre/post-op attributes as non-atomic (2020-12-09 =
09:39:38 -0500)

----------------------------------------------------------------

Several substantial changes this time around.

+ Previously, exporting an NFS mount via NFSD was considered to be
  an unsupported feature. With v5.11, the community has attempted
  to make re-exporting a first-class feature of NFSD. This would
  enable the Linux in-kernel NFS server to be used as an intermediate
  cache for a remotely-located primary NFS server, for example, even
  with other NFS server implementations, like a NetApp filer, as the
  primary.

+ A short series of patches brings support for multiple RPC/RDMA
  data chunks per RPC transaction to the Linux NFS server's RPC/RDMA
  transport implementation. This is a part of the RPC/RDMA spec that
  the other premiere NFS/RDMA implementation (Solaris) has had for a
  very long time, and completes the implementation of RPC/RDMA
  version 1 in the Linux kernel's NFS server.

+ Long ago, NFSv4 support was introduced to NFSD using a series of
  C macros that hid dprintk's and goto's. Over time, the kernel's
  XDR implementation has been greatly improved, but these C macros
  have remained and become fallow. A series of patches in this pull
  request completely replaces those macros with the use of current
  kernel XDR infrastructure. Benefits include:

  - More robust input sanitization in NFSD's NFSv4 XDR decoders.
  - Make it easier to use common kernel library functions that use
    XDR stream APIs (for example, GSS-API).
  - Align the structure of the source code with the RFCs so it is
    easier to learn, verify, and maintain our XDR implementation.
  - Removal of more than a hundred hidden dprintk() call sites.
  - Removal of some explicit manipulation of pages to help make the
    eventual transition to xdr->bvec smoother.

+ On top of several related fixes in 5.10-rc, there are a few more
  fixes to get the Linux NFSD implementation of NFSv4.2 inter-server
  copy up to speed.

And as usual, there is a pinch of seasoning in the form of a
collection of unrelated minor bug fixes and clean-ups.

Many thanks to all who contributed this time around!

----------------------------------------------------------------
Alex Shi (1):
      nfsd/nfs3: remove unused macro nfsd3_fhandleres

Cheng Lin (1):
      nfs_common: need lock during iterate through the list

Chuck Lever (112):
      svcrdma: Catch another Reply chunk overflow case
      SUNRPC: Adjust synopsis of xdr_buf_subsegment()
      svcrdma: Const-ify the xdr_buf arguments
      svcrdma: Refactor the RDMA Write path
      SUNRPC: Rename svc_encode_read_payload()
      NFSD: Invoke svc_encode_result_payload() in "read" NFSD encoders
      svcrdma: Post RDMA Writes while XDR encoding replies
      svcrdma: Clean up svc_rdma_encode_reply_chunk()
      svcrdma: Add a "parsed chunk list" data structure
      svcrdma: Use parsed chunk lists to derive the inv_rkey
      svcrdma: Use parsed chunk lists to detect reverse direction =
replies
      svcrdma: Use parsed chunk lists to construct RDMA Writes
      svcrdma: Use parsed chunk lists to encode Reply transport headers
      svcrdma: Support multiple write chunks when pulling up
      svcrdma: Support multiple Write chunks in svc_rdma_map_reply_msg()
      svcrdma: Support multiple Write chunks in =
svc_rdma_send_reply_chunk
      svcrdma: Remove chunk list pointers
      svcrdma: Clean up chunk tracepoints
      svcrdma: Rename info::ri_chunklen
      svcrdma: Use the new parsed chunk list when pulling Read chunks
      svcrdma: support multiple Read chunks per RPC
      SUNRPC: Move the svc_xdr_recvfrom() tracepoint
      NFSD: Clean up the show_nf_may macro
      NFSD: Remove extra "0x" in tracepoint format specifier
      NFSD: Add SPDX header for fs/nfsd/trace.c
      SUNRPC: Add xdr_set_scratch_page() and xdr_reset_scratch_buffer()
      SUNRPC: Prepare for xdr_stream-style decoding on the server-side
      NFSD: Add common helpers to decode void args and encode void =
results
      NFSD: Add tracepoints in nfsd_dispatch()
      NFSD: Add tracepoints in nfsd4_decode/encode_compound()
      NFSD: Replace the internals of the READ_BUF() macro
      NFSD: Replace READ* macros in nfsd4_decode_access()
      NFSD: Replace READ* macros in nfsd4_decode_close()
      NFSD: Replace READ* macros in nfsd4_decode_commit()
      NFSD: Change the way the expected length of a fattr4 is checked
      NFSD: Replace READ* macros that decode the fattr4 size attribute
      NFSD: Replace READ* macros that decode the fattr4 acl attribute
      NFSD: Replace READ* macros that decode the fattr4 mode attribute
      NFSD: Replace READ* macros that decode the fattr4 owner attribute
      NFSD: Replace READ* macros that decode the fattr4 owner_group =
attribute
      NFSD: Replace READ* macros that decode the fattr4 time_set =
attributes
      NFSD: Replace READ* macros that decode the fattr4 security label =
attribute
      NFSD: Replace READ* macros that decode the fattr4 umask attribute
      NFSD: Replace READ* macros in nfsd4_decode_fattr()
      NFSD: Replace READ* macros in nfsd4_decode_create()
      NFSD: Replace READ* macros in nfsd4_decode_delegreturn()
      NFSD: Replace READ* macros in nfsd4_decode_getattr()
      NFSD: Replace READ* macros in nfsd4_decode_link()
      NFSD: Relocate nfsd4_decode_opaque()
      NFSD: Add helpers to decode a clientid4 and an NFSv4 state owner
      NFSD: Add helper for decoding locker4
      NFSD: Replace READ* macros in nfsd4_decode_lock()
      NFSD: Replace READ* macros in nfsd4_decode_lockt()
      NFSD: Replace READ* macros in nfsd4_decode_locku()
      NFSD: Replace READ* macros in nfsd4_decode_lookup()
      NFSD: Add helper to decode NFSv4 verifiers
      NFSD: Add helper to decode OPEN's createhow4 argument
      NFSD: Add helper to decode OPEN's openflag4 argument
      NFSD: Replace READ* macros in nfsd4_decode_share_access()
      NFSD: Replace READ* macros in nfsd4_decode_share_deny()
      NFSD: Add helper to decode OPEN's open_claim4 argument
      NFSD: Replace READ* macros in nfsd4_decode_open()
      NFSD: Replace READ* macros in nfsd4_decode_open_confirm()
      NFSD: Replace READ* macros in nfsd4_decode_open_downgrade()
      NFSD: Replace READ* macros in nfsd4_decode_putfh()
      NFSD: Replace READ* macros in nfsd4_decode_read()
      NFSD: Replace READ* macros in nfsd4_decode_readdir()
      NFSD: Replace READ* macros in nfsd4_decode_remove()
      NFSD: Replace READ* macros in nfsd4_decode_rename()
      NFSD: Replace READ* macros in nfsd4_decode_renew()
      NFSD: Replace READ* macros in nfsd4_decode_secinfo()
      NFSD: Replace READ* macros in nfsd4_decode_setattr()
      NFSD: Replace READ* macros in nfsd4_decode_setclientid()
      NFSD: Replace READ* macros in nfsd4_decode_setclientid_confirm()
      NFSD: Replace READ* macros in nfsd4_decode_verify()
      NFSD: Replace READ* macros in nfsd4_decode_write()
      NFSD: Replace READ* macros in nfsd4_decode_release_lockowner()
      NFSD: Replace READ* macros in nfsd4_decode_cb_sec()
      NFSD: Replace READ* macros in nfsd4_decode_backchannel_ctl()
      NFSD: Replace READ* macros in nfsd4_decode_bind_conn_to_session()
      NFSD: Add a separate decoder to handle state_protect_ops
      NFSD: Add a separate decoder for ssv_sp_parms
      NFSD: Add a helper to decode state_protect4_a
      NFSD: Add a helper to decode nfs_impl_id4
      NFSD: Add a helper to decode channel_attrs4
      NFSD: Replace READ* macros in nfsd4_decode_create_session()
      NFSD: Replace READ* macros in nfsd4_decode_destroy_session()
      NFSD: Replace READ* macros in nfsd4_decode_free_stateid()
      NFSD: Replace READ* macros in nfsd4_decode_getdeviceinfo()
      NFSD: Replace READ* macros in nfsd4_decode_layoutcommit()
      NFSD: Replace READ* macros in nfsd4_decode_layoutget()
      NFSD: Replace READ* macros in nfsd4_decode_layoutreturn()
      NFSD: Replace READ* macros in nfsd4_decode_secinfo_no_name()
      NFSD: Replace READ* macros in nfsd4_decode_sequence()
      NFSD: Replace READ* macros in nfsd4_decode_test_stateid()
      NFSD: Replace READ* macros in nfsd4_decode_destroy_clientid()
      NFSD: Replace READ* macros in nfsd4_decode_reclaim_complete()
      NFSD: Replace READ* macros in nfsd4_decode_fallocate()
      NFSD: Replace READ* macros in nfsd4_decode_nl4_server()
      NFSD: Replace READ* macros in nfsd4_decode_copy()
      NFSD: Replace READ* macros in nfsd4_decode_copy_notify()
      NFSD: Replace READ* macros in nfsd4_decode_offload_status()
      NFSD: Replace READ* macros in nfsd4_decode_seek()
      NFSD: Replace READ* macros in nfsd4_decode_clone()
      NFSD: Replace READ* macros in nfsd4_decode_xattr_name()
      NFSD: Replace READ* macros in nfsd4_decode_setxattr()
      NFSD: Replace READ* macros in nfsd4_decode_listxattrs()
      NFSD: Make nfsd4_ops::opnum a u32
      NFSD: Replace READ* macros in nfsd4_decode_compound()
      NFSD: Remove macros that are no longer used
      SUNRPC: Remove XDRBUF_SPARSE_PAGES flag in gss_proxy upcall
      NFSD: Fix sparse warning in nfs4proc.c

Dai Ngo (1):
      NFSD: Fix 5 seconds delay when doing inter server copy

Huang Guobin (1):
      nfsd: Fix error return code in nfsd_file_cache_init()

J. Bruce Fields (5):
      nfsd: only call inode_query_iversion in the I_VERSION case
      nfsd: simplify nfsd4_change_info
      nfsd: minor nfsd4_change_attribute cleanup
      nfsd4: don't query change attribute in v2/v3 case
      Revert "nfsd4: support change_attr_type attribute"

Jeff Layton (3):
      nfsd: add a new EXPORT_OP_NOWCC flag to struct export_operations
      nfsd: allow filesystems to opt out of subtree checking
      nfsd: close cached files prior to a REMOVE or RENAME that would =
replace target

Roberto Bergantinos Corpas (1):
      sunrpc: clean-up cache downcall

Tom Rix (1):
      NFSD: A semicolon is not needed after a switch statement.

Trond Myklebust (4):
      exportfs: Add a function to return the raw output from =
fh_to_dentry()
      nfsd: Fix up nfsd to ensure that timeout errors don't result in =
ESTALE
      nfsd: Set PF_LOCAL_THROTTLE on local filesystems only
      nfsd: Record NFSv4 pre/post-op attributes as non-atomic

kazuo ito (1):
      nfsd: Fix message level for normal termination

 Documentation/filesystems/nfs/exporting.rst |   52 ++
 fs/exportfs/expfs.c                         |   32 +-
 fs/nfs/blocklayout/blocklayout.c            |    2 +-
 fs/nfs/blocklayout/dev.c                    |    2 +-
 fs/nfs/dir.c                                |    2 +-
 fs/nfs/export.c                             |    3 +
 fs/nfs/filelayout/filelayout.c              |    2 +-
 fs/nfs/filelayout/filelayoutdev.c           |    2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c      |    2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c   |    2 +-
 fs/nfs/nfs42xdr.c                           |    2 +-
 fs/nfs/nfs4xdr.c                            |    6 +-
 fs/nfs_common/grace.c                       |    6 +-
 fs/nfsd/export.c                            |    6 +
 fs/nfsd/filecache.c                         |    1 +
 fs/nfsd/nfs2acl.c                           |   21 +-
 fs/nfsd/nfs3acl.c                           |    8 +-
 fs/nfsd/nfs3proc.c                          |   11 +-
 fs/nfsd/nfs3xdr.c                           |   40 +-
 fs/nfsd/nfs4proc.c                          |   35 +-
 fs/nfsd/nfs4state.c                         |    3 +-
 fs/nfsd/nfs4xdr.c                           | 2665 =
+++++++++++++++++++++++++++++++++++++++++++++++---------------------------=
-----------------
 fs/nfsd/nfsd.h                              |    9 +-
 fs/nfsd/nfsfh.c                             |   34 +-
 fs/nfsd/nfsfh.h                             |   22 +-
 fs/nfsd/nfsproc.c                           |   25 +-
 fs/nfsd/nfssvc.c                            |   50 +-
 fs/nfsd/nfsxdr.c                            |   16 +-
 fs/nfsd/trace.c                             |    1 +
 fs/nfsd/trace.h                             |  176 +++++-
 fs/nfsd/vfs.c                               |   29 +-
 fs/nfsd/xdr.h                               |    2 -
 fs/nfsd/xdr3.h                              |    2 -
 fs/nfsd/xdr4.h                              |   43 +-
 include/linux/exportfs.h                    |   13 +
 include/linux/iversion.h                    |   13 +
 include/linux/nfs4.h                        |    8 -
 include/linux/sunrpc/svc.h                  |   22 +-
 include/linux/sunrpc/svc_rdma.h             |   36 +-
 include/linux/sunrpc/svc_rdma_pcl.h         |  128 +++++
 include/linux/sunrpc/svc_xprt.h             |    4 +-
 include/linux/sunrpc/xdr.h                  |   91 +++-
 include/trace/events/rpcrdma.h              |  171 +++---
 include/trace/events/sunrpc.h               |   24 -
 net/sunrpc/auth_gss/gss_rpc_upcall.c        |   15 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c           |    3 +-
 net/sunrpc/cache.c                          |   41 +-
 net/sunrpc/svc.c                            |   16 +-
 net/sunrpc/svc_xprt.c                       |    4 +-
 net/sunrpc/svcsock.c                        |    8 +-
 net/sunrpc/xdr.c                            |   78 ++-
 net/sunrpc/xprtrdma/Makefile                |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c  |   14 +-
 net/sunrpc/xprtrdma/svc_rdma_pcl.c          |  306 +++++++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c     |  316 ++++++-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c           |  608 =
+++++++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c       |  560 ++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_transport.c    |    2 +-
 58 files changed, 3536 insertions(+), 2261 deletions(-)
 create mode 100644 include/linux/sunrpc/svc_rdma_pcl.h
 create mode 100644 net/sunrpc/xprtrdma/svc_rdma_pcl.c
--
Chuck Lever



