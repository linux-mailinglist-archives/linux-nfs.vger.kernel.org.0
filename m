Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986AF1689A8
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBUWAN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:13 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43387 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUWAN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:13 -0500
Received: by mail-yw1-f65.google.com with SMTP id f204so1779436ywc.10;
        Fri, 21 Feb 2020 14:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Qi2N2DE4kidOB1UvL1ljaWshUxorlbyFmUwWFR+Pkbk=;
        b=aSDNxbQ6S/fWZFbOmAGJAWLgMDxXIe/6+ZliB6DRYVTf1fiV0rR2pbNJZPn0dqsztx
         HgpRiEtHYxTr9ftN4cv2smtS2RWKTqj1VdHH4uK6R8fizQmBucmPwqN5KtyHs/f/RH+Y
         4lcXaYlh8B06Z6CkENILXiE+fgWvQpmomyGPAR72zEak9PUanfEHLdrCzOcmwaDpbpuU
         N2vwpyLppC8hiWHDT7oy0bCvE8T+Kh7cbdEpV/DJuIx++/HJ653/z0zXxd3LlANBrP2b
         8G7cnxpKgqnOZU9/f4bcGf7WxD19/UraOfZTFarCzdz27FpU4M8IRX9em9zu8JG7t0g/
         RprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Qi2N2DE4kidOB1UvL1ljaWshUxorlbyFmUwWFR+Pkbk=;
        b=cMJjbshLIQDRr385Ig6DTiYqWyGjlDuY8AF/ORhiB9V/jIJh78k116RvZcABsjWyY4
         MIXiurE91L+Qfy74TFbXj+gdpXKHLs2UnlHrDdbqyKhwpL3VBxdBxasebyK9oAvqin7W
         gPKD4DiGeLYj1AF71M2DYYIoipfGg9BEm/2qMShs1O8QVN+BeXlr7pOq2MMQN5NsoIUO
         N3L055QeBPAKVVKjC/8mBZA5OwxysfIi1wQ2XcrWi6SVbhjIET7QDDQuz6Bri9emoIkR
         GCzCSCtfQUorqKIrKGTxQeIAAVs7TfxQd2NYFKlJFVvoxKsgBllOVZFfey9AJ7KTCVdN
         GumQ==
X-Gm-Message-State: APjAAAXXbdTJE2H6n8twHgkx42zh/Mb5p45NGrISFeAKoYibN7IuirZi
        Cw2PY8udXHOYMWgXVEQzrak3x8ze
X-Google-Smtp-Source: APXvYqy3e0wGM1c/yEoFCpXyT7R91pCXvEwag6phpjAsfMiZ6XxpaXwV787rTYth9YeIDVVNK6KH+Q==
X-Received: by 2002:a81:2313:: with SMTP id j19mr33469521ywj.201.1582322408625;
        Fri, 21 Feb 2020 14:00:08 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m137sm1860991ywd.108.2020.02.21.14.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:08 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM063k018975;
        Fri, 21 Feb 2020 22:00:07 GMT
Subject: [PATCH v1 00/11] NFS/RDMA client side connection overhaul
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:06 -0500
Message-ID: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Howdy.

I've had reports (and personal experience) where the Linux NFS/RDMA
client waits for a very long time after a disruption of the network
or NFS server.

There is a disconnect time wait in the Connection Manager which
blocks the RPC/RDMA transport from tearing down a connection for a
few minutes when the remote cannot respond to DREQ messages.

An RPC/RDMA transport has only one slot for connection state, so the
transport is prevented from establishing a fresh connection until
the time wait completes.

This patch series refactors the connection end point data structures
to enable one active and multiple zombie connections. Now, while a
defunct connection is waiting to die, it is separated from the
transport, clearing the way for the immediate creation of a new
connection. Clean-up of the old connection's data structures and
resources then completes in the background.

Well, that's the idea, anyway. Review and comments welcome. Hoping
this can be merged in v5.7.

---

Chuck Lever (11):
      xprtrdma: Invoke rpcrdma_ep_create() in the connect worker
      xprtrdma: Refactor frwr_init_mr()
      xprtrdma: Clean up the post_send path
      xprtrdma: Refactor rpcrdma_ep_connect() and rpcrdma_ep_disconnect()
      xprtrdma: Allocate Protection Domain in rpcrdma_ep_create()
      xprtrdma: Invoke rpcrdma_ia_open in the connect worker
      xprtrdma: Remove rpcrdma_ia::ri_flags
      xprtrdma: Disconnect on flushed completion
      xprtrdma: Merge struct rpcrdma_ia into struct rpcrdma_ep
      xprtrdma: Extract sockaddr from struct rdma_cm_id
      xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt


 include/trace/events/rpcrdma.h    |   97 ++---
 net/sunrpc/xprtrdma/backchannel.c |    8 
 net/sunrpc/xprtrdma/frwr_ops.c    |  152 ++++----
 net/sunrpc/xprtrdma/rpc_rdma.c    |   32 +-
 net/sunrpc/xprtrdma/transport.c   |   72 +---
 net/sunrpc/xprtrdma/verbs.c       |  681 ++++++++++++++-----------------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |   89 ++---
 7 files changed, 445 insertions(+), 686 deletions(-)

--
Chuck Lever
