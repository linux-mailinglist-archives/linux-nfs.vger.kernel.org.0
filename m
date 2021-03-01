Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2824932820E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhCAPQc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:16:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236841AbhCAPP7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:15:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37801600CC
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:15:19 +0000 (UTC)
Subject: [PATCH v1 00/42] NFSv2/3 XDR encoder overhaul
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:15:18 -0500
Message-ID: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
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

I expect that the only controversial part of the series is the
changes to NFSv3 READDIR and the per-entry encoders. If the reader
has no time for anything else, please have a close look at those.

The series is also available in the for-next topic branch here:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

---

Chuck Lever (42):
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
      SUNRPC: Fix xdr_get_next_encode_buffer() page boundary handling
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


 fs/nfs_common/nfsacl.c     |   71 +++
 fs/nfsd/nfs2acl.c          |   87 ++-
 fs/nfsd/nfs3acl.c          |   39 +-
 fs/nfsd/nfs3proc.c         |   97 ++--
 fs/nfsd/nfs3xdr.c          | 1044 ++++++++++++++++++++++--------------
 fs/nfsd/nfsfh.c            |    2 +-
 fs/nfsd/nfsfh.h            |    2 +-
 fs/nfsd/nfsproc.c          |   53 +-
 fs/nfsd/nfsxdr.c           |  411 ++++++++------
 fs/nfsd/vfs.h              |    2 +-
 fs/nfsd/xdr.h              |   23 +-
 fs/nfsd/xdr3.h             |   37 +-
 include/linux/nfsacl.h     |    3 +
 include/linux/sunrpc/xdr.h |   20 +
 net/sunrpc/xdr.c           |    2 +-
 15 files changed, 1143 insertions(+), 750 deletions(-)

--
Chuck Lever

