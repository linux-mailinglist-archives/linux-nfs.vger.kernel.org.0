Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E813FCD72
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbhHaTGL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 15:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240249AbhHaTGG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Aug 2021 15:06:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79EB061041;
        Tue, 31 Aug 2021 19:05:10 +0000 (UTC)
Subject: [PATCH RFC 0/6] NFSD: Pull Read chunks in XDR decoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 31 Aug 2021 15:05:09 -0400
Message-ID: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

Here is part of what we discussed recently about trying to align
pages in NFS WRITE requests so that splice can be used. This
series updates server-side RPC and svcrdma to ensure that an
aligned xdr_buf::pages array is presented to NFSD, which is then
converted into an aligned rq_vec for the VFS layer.

The next step would be to look at how to make the best use of the
aligned rq_vec. My naive thought is that where there is a PAGE_SIZE
entry in rq_vec and there is no page in the file's page cache at
that offset, the transport-provided page can be flipped into place.
Might work for replacing whole pages as well, but baby steps first.

This series has been exercised a bit with both TCP and RDMA, but no
guarantees that it is completely bug-free. NFSv4 compounds with
multiple WRITE payloads on RDMA are treated like TCP: the RPC
message is contained in an unstructured stream of unaligned pages.

Comments encouraged.

---

Chuck Lever (6):
      SUNRPC: Capture value of xdr_buf::page_base
      SUNRPC: xdr_stream_subsegment() must handle non-zero page_bases
      NFSD: Have legacy NFSD WRITE decoders use xdr_stream_subsegment()
      SUNRPC: svc_fill_write_vector() must handle non-zero page_bases
      NFSD: Add a transport hook for pulling argument payloads
      svcrdma: Pull Read chunks in ->xpo_argument_payload


 fs/nfsd/nfs3proc.c                       |   3 +-
 fs/nfsd/nfs3xdr.c                        |  16 +--
 fs/nfsd/nfs4proc.c                       |   3 +-
 fs/nfsd/nfs4xdr.c                        |   6 +
 fs/nfsd/nfsproc.c                        |   3 +-
 fs/nfsd/nfsxdr.c                         |  13 +--
 fs/nfsd/xdr.h                            |   2 +-
 fs/nfsd/xdr3.h                           |   2 +-
 include/linux/sunrpc/svc.h               |   6 +-
 include/linux/sunrpc/svc_rdma.h          |   8 ++
 include/linux/sunrpc/svc_xprt.h          |   3 +
 include/trace/events/rpcrdma.h           |  26 +++++
 include/trace/events/sunrpc.h            |  20 +++-
 net/sunrpc/svc.c                         |  38 +++++--
 net/sunrpc/svcsock.c                     |   8 ++
 net/sunrpc/xdr.c                         |  32 +++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  37 +++++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 139 ++++++++++++++++++++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   1 +
 19 files changed, 292 insertions(+), 74 deletions(-)

--
Chuck Lever

