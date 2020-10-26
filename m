Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF732995E6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790969AbgJZSyB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40482 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790526AbgJZSx5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:53:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id h140so9395848qke.7;
        Mon, 26 Oct 2020 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jIJQoWncpsWk9DsWYEdY/6ZiFxZd7ccRplO+7df8OgA=;
        b=shAqUZ2h0nbZdVqfdHk/SQrkoky/OraotfDg/YWsuzOTdPyi9WBvkpZHRiElqYvVRN
         xfA51ni4uIneZ0V6d2bzlsCkLfq02S2jAMTaKr3789xnfu5FcEBwhAtJkcrWu3LZg5Jo
         2XaZLYyoFSK2qrmrkP4uwQc2kCXY//Lxeso0Gi9esiOKoPP4BS1jwdY2GdmjByubG/25
         lW7/ytiXTkPN3aE75Ty2alJqm90DfYeM6PfPT3YLmfRwQD02YeKiLnObUOh5zvhZq9Fo
         ao77QBNOHTHEluw90GCMR0KR/sRYidQ9tRA9dpgtRBYNvi+F32dDMN3p7mGscO2hZK6T
         A/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jIJQoWncpsWk9DsWYEdY/6ZiFxZd7ccRplO+7df8OgA=;
        b=AgZQc0siz4T9pwFtfW9m86Ijz3WlZnrT44j4DaunyZ75BeMlIaMQFTRPyY14AT9O+Q
         uhNepSBTfDugfO3QsDdw3Rb1J5pB5yK2Pvf17VwY0pTMM7aeQR5mXO3dPKSoqOELFR4h
         HA2KoMt1RLlbivQvOn8PMf1CITqXrnRoA1Do950ZZzvB1+L/Et9notOq1tuLc02dReof
         y93gLl8NWfeGrLXUlUD3Jh3KRwpbrFvFTEpq2yT5Jwu7yR4iNRXqb9KE7xCqgV6E56AR
         2WCcPHQ8dhk427EU9RYBP0Rmab5E9B6Hc7ehoiVKfS8WI2RQsf5FvYsLNSAQgpKE47tK
         bnZw==
X-Gm-Message-State: AOAM5308vnxi3NkLN707daXC1zjBmePbpe2hUa02zhqj0L+sDLzfC8gl
        8yES59aW1VNYRhhW0alOiaeYCtbpVrk=
X-Google-Smtp-Source: ABdhPJxnD2KLlb8ltu6Pe/A5gOnSG3k0rcqofRTU5tw1F+G3lSFbt78eeNTDMfk9jwExlU+/EJ5f9g==
X-Received: by 2002:a05:620a:15a9:: with SMTP id f9mr2764268qkk.359.1603738434678;
        Mon, 26 Oct 2020 11:53:54 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o2sm7057882qkk.121.2020.10.26.11.53.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:53:53 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIrrRZ013613;
        Mon, 26 Oct 2020 18:53:53 GMT
Subject: [PATCH 00/20] NFSD support for multiple RPC/RDMA chunks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:53:53 -0400
Message-ID: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series implements support for multiple RPC/RDMA chunks per RPC
transaction. This is one of the few remaining generalities that the
Linux NFS/RDMA server implementation lacks.

There is currently one known NFS/RDMA client implementation that can
send multiple chunks per RPC, and that is Solaris. Multiple chunks
are rare enough that the Linux NFS/RDMA implementation has been
successful without this support for many years.

Along with multiple chunk support, this series adds the following
benefits:

- More robust input sanitization of RPC/RDMA headers
- An internal representation of chunks that is agnostic to their
  wire format

The cost is a little additional complexity and some extra memory
allocations when handling non-empty chunk lists. Most of these
allocations can be optimized away if we find they are a problem.

---

Chuck Lever (20):
      SUNRPC: Adjust synopsis of xdr_buf_subsegment()
      svcrdma: Const-ify the xdr_buf arguments
      svcrdma: Refactor the RDMA Write path
      SUNRPC: Rename svc_encode_read_payload()
      NFSD: Invoke svc_encode_result_payload() in "read" NFSD encoders
      svcrdma: Post RDMA Writes while XDR encoding replies
      svcrdma: Clean up svc_rdma_encode_reply_chunk()
      svcrdma: Add a "parsed chunk list" data structure
      svcrdma: Use parsed chunk lists to derive the inv_rkey
      svcrdma: Use parsed chunk lists to detect reverse direction replies
      svcrdma: Use parsed chunk lists to construct RDMA Writes
      svcrdma: Use parsed chunk lists to encode Reply transport headers
      svcrdma: Support multiple write chunks when pulling up
      svcrdma: Support multiple Write chunks in svc_rdma_map_reply_msg()
      svcrdma: Support multiple Write chunks in svc_rdma_send_reply_chunk
      svcrdma: Remove chunk list pointers
      svcrdma: Clean up chunk tracepoints
      svcrdma: Rename info::ri_chunklen
      svcrdma: Use the new parsed chunk list when pulling Read chunks
      svcrdma: support multiple Read chunks per RPC


 fs/nfsd/nfs3xdr.c                          |   4 +
 fs/nfsd/nfs4xdr.c                          |   5 +-
 fs/nfsd/nfsxdr.c                           |   4 +
 include/linux/sunrpc/svc.h                 |   6 +-
 include/linux/sunrpc/svc_rdma.h            |  36 +-
 include/linux/sunrpc/svc_rdma_pcl.h        | 128 +++++
 include/linux/sunrpc/svc_xprt.h            |   4 +-
 include/trace/events/rpcrdma.h             | 143 +++--
 net/sunrpc/svc.c                           |  11 +-
 net/sunrpc/svcsock.c                       |   8 +-
 net/sunrpc/xprtrdma/Makefile               |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  14 +-
 net/sunrpc/xprtrdma/svc_rdma_pcl.c         | 306 +++++++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 314 ++++++-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c          | 598 +++++++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 561 ++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |   2 +-
 17 files changed, 1488 insertions(+), 658 deletions(-)
 create mode 100644 include/linux/sunrpc/svc_rdma_pcl.h
 create mode 100644 net/sunrpc/xprtrdma/svc_rdma_pcl.c

--
Chuck Lever

