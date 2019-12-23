Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878A9129837
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2019 16:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLWP2Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Dec 2019 10:28:25 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45014 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfLWP2Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Dec 2019 10:28:25 -0500
Received: by mail-yw1-f67.google.com with SMTP id t141so7185485ywc.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2019 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Web1ExWRXk6jst+PTReXF4mcoyZuyzsOA6DOVsW3RCk=;
        b=Br0oXxElEdEmTGQz0FvTS0lT7QxVZDNHN5n7fyq8KMkjBn0v8k4d4Z5c48oN2iEbG5
         g4IeaXVesKlivwtMrgQtqlibP9FS10iQqye0kpTpTgNlwrRr8lKDwgs9MekNHi3O+9zn
         /itjiqJjOjIDEaAMVjewnkWzGlEGkMibicjLkMOptC6WUBTGQdOKbIFfZmGbJ4ubdHGA
         Bi5BKIAemTcxzjeO6ehct1aAvfMChocKQbEAM5yVxWRDIo75mBKy4a8GcEga6n5DhRPB
         TBIOmmlHKJWND86zKrnjDbIyl8rMDwvo2KVRF03xkUW/im8t+Oa2NKBKMK0bj0QffzT/
         6RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Web1ExWRXk6jst+PTReXF4mcoyZuyzsOA6DOVsW3RCk=;
        b=r8Zeytc7EPd92tLr9Bm2u7VgrvThyHC95E1tmzAK7DJya0I6flpWf6Mo6Lux8gkMDC
         Hx/srxlNBwzzykwBnBHT/5bfnD19tgQoIcb9cOCjShYgHBPpme5wt6AWHxc4sNfuzK44
         QHtQLVcJCjzSSxI8GIwC6otqkFzgSdjTAVLWlKUQc67kcHqEyxIYjVEHBnLNyEHLsaDw
         lUkjVvaApUIJEPT5PmdOU2PdgSRdFL2okDqIQofPt1BJ3GYtF9JFgV/BQBOXUVW5QG8a
         g0XfCHZhMDZ8NOWkglYT/Sq9oemE+yzCfvBUxxcZTupKk1OJUxFRrYQbj+2VRz6WIQgK
         WFcg==
X-Gm-Message-State: APjAAAV+zwueJWiulMMMDPslJLFYPAGGKC3XYYKNxoo91asydtHDKMPS
        iFJoH/mU4kuWCQS3WCUidafCCWsr
X-Google-Smtp-Source: APXvYqwkc/xzrhoIST4BNqr6KRvnyAk+xBmlO6cmXuYOJnBXLU07Vzrl3U/9WOJzPPCpspiFnXzWTg==
X-Received: by 2002:a81:a210:: with SMTP id w16mr22337589ywg.261.1577114904469;
        Mon, 23 Dec 2019 07:28:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g5sm8136778ywk.46.2019.12.23.07.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:28:23 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBNFSMcR008874;
        Mon, 23 Dec 2019 15:28:22 GMT
Subject: [PATCH v1 0/4] NFS/RPC patches for v5.6
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Dec 2019 10:28:22 -0500
Message-ID: <20191223152539.17724.52438.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi -

Three patches that add diagnostic trace points in the NFS client
and the RPC client implementations, and one RPC patch that is a
pre-requisite to overhauling the RPC/RDMA connection logic.

Would you consider these for v5.6 please?

---

Chuck Lever (4):
      SUNRPC: Capture signalled RPC tasks
      NFS: Introduce trace events triggered by page writeback errors
      NFS4: Report callback authentication errors
      SUNRPC: call_connect_status should handle -EPROTO


 fs/nfs/callback_xdr.c         |   11 +++++++---
 fs/nfs/nfs4trace.h            |   35 ++++++++++++++++++++++++++++++++
 fs/nfs/nfstrace.h             |   45 +++++++++++++++++++++++++++++++++++++++++
 fs/nfs/write.c                |    3 +++
 include/trace/events/sunrpc.h |    1 +
 net/sunrpc/clnt.c             |    1 +
 net/sunrpc/sched.c            |    4 +++-
 7 files changed, 96 insertions(+), 4 deletions(-)

--
Chuck Lever
