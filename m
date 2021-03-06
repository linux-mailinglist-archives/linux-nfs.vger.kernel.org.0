Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7B32FDB8
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCFW30 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhCFW3N (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:29:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15D266509D
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:29:13 +0000 (UTC)
Subject: [PATCH v2 00/43] NFSv2/3 XDR encoder overhaul
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:29:12 -0500
Message-ID: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

This patch series updates the server-side XDR encoder functions for
NFS versions 2 and 3. The series was available on both test servers
I maintained at last week's virtual bake-a-thon event.

This series is available in the for-next topic branch here:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Changes since v1:
- Added an xdr_encode_bool() helper
- Dropped "SUNRPC: Fix xdr_get_next_encode_buffer() page boundary handling"
- Added a generic tracepoint to report directory entry decoding
- Removed NFSDBG macro - no longer needed

---

Chuck Lever (43):
      NFSD: Extract the svcxdr_init_encode() helper
      NFSD: Update the GETATTR3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 ACCESS3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 LOOKUP3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 wccstat result encoder to use struct xdr_stream
      NFSD: Update the NFSv3 READLINK3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 READ3res encode to use struct xdr_stream
      NFSD: Update the NFSv3 WRITE3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 CREATE family of encoders to use struct xdr_stream
      NFSD: Update the NFSv3 RENAMEv3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 LINK3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 FSSTAT3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 FSINFO3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 PATHCONF3res encoder to use struct xdr_stream
      NFSD: Update the NFSv3 COMMIT3res encoder to use struct xdr_stream
      NFSD: Add a helper that encodes NFSv3 directory offset cookies
      NFSD: Count bytes instead of pages in the NFSv3 READDIR encoder
      NFSD: Update the NFSv3 READDIR3res encoder to use struct xdr_stream
      NFSD: Update NFSv3 READDIR entry encoders to use struct xdr_stream
      NFSD: Remove unused NFSv3 directory entry encoders
      NFSD: Reduce svc_rqst::rq_pages churn during READDIR operations
      NFSD: Update the NFSv2 stat encoder to use struct xdr_stream
      NFSD: Update the NFSv2 attrstat encoder to use struct xdr_stream
      NFSD: Update the NFSv2 diropres encoder to use struct xdr_stream
      NFSD: Update the NFSv2 READLINK result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 READ result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 STATFS result encoder to use struct xdr_stream
      NFSD: Add a helper that encodes NFSv3 directory offset cookies
      NFSD: Count bytes instead of pages in the NFSv2 READDIR encoder
      NFSD: Update the NFSv2 READDIR result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 READDIR entry encoder to use struct xdr_stream
      NFSD: Remove unused NFSv2 directory entry encoders
      NFSD: Add an xdr_stream-based encoder for NFSv2/3 ACLs
      NFSD: Update the NFSv2 GETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 SETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL GETATTR result encoder to use struct xdr_stream
      NFSD: Update the NFSv2 ACL ACCESS result encoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv2 ACL encoders
      NFSD: Update the NFSv3 GETACL result encoder to use struct xdr_stream
      NFSD: Update the NFSv3 SETACL result encoder to use struct xdr_stream
      NFSD: Clean up after updating NFSv3 ACL encoders
      NFSD: Add a tracepoint to record directory entry encoding
      NFSD: Clean up NFSDDBG_FACILITY macro


 fs/nfs_common/nfsacl.c     |   71 +++
 fs/nfsd/nfs2acl.c          |   87 ++-
 fs/nfsd/nfs3acl.c          |   39 +-
 fs/nfsd/nfs3proc.c         |   97 ++--
 fs/nfsd/nfs3xdr.c          | 1043 ++++++++++++++++++++++--------------
 fs/nfsd/nfsfh.c            |    2 +-
 fs/nfsd/nfsfh.h            |    2 +-
 fs/nfsd/nfsproc.c          |   53 +-
 fs/nfsd/nfsxdr.c           |  413 ++++++++------
 fs/nfsd/trace.h            |   24 +
 fs/nfsd/vfs.c              |    9 +-
 fs/nfsd/vfs.h              |    2 +-
 fs/nfsd/xdr.h              |   23 +-
 fs/nfsd/xdr3.h             |   37 +-
 include/linux/nfsacl.h     |    3 +
 include/linux/sunrpc/xdr.h |   34 ++
 16 files changed, 1184 insertions(+), 755 deletions(-)

--
Chuck Lever

