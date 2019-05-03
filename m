Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3B12C3B
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 13:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfECLWX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 07:22:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56004 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfECLWX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 07:22:23 -0400
Received: by mail-it1-f195.google.com with SMTP id i131so8466985itf.5
        for <linux-nfs@vger.kernel.org>; Fri, 03 May 2019 04:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Um/3dZPVhN75ts3t++gUloYm2MjFnE79by4QieaIog=;
        b=HWGgRIHroP1+NoSG0bVpsMJHJKvx4+O/r50+Uc/gf1r618rgrGr8BAiQazabDCS/Gx
         DpewKurK74dnlhUQlD1RsReq61gz5+xgBEWiITFttwBK01Jwnj84AON/pWg5ZHmYhuvu
         sLO3RKjPM0dfoM5vDo5a0kGkEBDPcMQM0dBrFMLuYnFJorGIj8afcH3a54boosCJfpfK
         aYZn3V5bLn7u+qKzdhtJEXNuCZfde+Ho04OxY8dPMq2z2seyeFeTRxYBZ+d3NRGIBuG2
         gxwJtdEDx8SXF4NDoG9wbTfZUYRbTTzojrRph8P3Jj0x5a5F2YIxx4LDWO+Qe9yPKKOZ
         iLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Um/3dZPVhN75ts3t++gUloYm2MjFnE79by4QieaIog=;
        b=B51akJiN8/22gaL8P9WfcF9+OwHqTW92O0acmV8zmqgEMVfi7CmR1csZUWy118x8FT
         bv7ccHD4PxMj4wStnTflbh/pLGu4rIx+X3OukCHNCo3LDY/vb5CgbTQicjudbx+EYuax
         tOmDgdmWLQe1D+eEDjWHTWC5XiHQeaHGenawApwyviCFnqm8CL2lZckcM3NRDjDXubZF
         NBB8538cl+YJcitAg6rXPOCfGCzx5G7YbKkfGCqub1sJ+T7zc6wAKDNoMy6gbJeHP1Ba
         CjJBRxRbJRH7Q/Vct1u5FtHYHTVvBTawcMcXCuXy/l5Pb5gld0vqBVX7cWdCnK3B9Zf2
         P83g==
X-Gm-Message-State: APjAAAW2q07QctjM7SwPKh3ni3X3L0LUPzYPrZZBNQdQhPa2rycBQ2Tx
        mJ2VE61zfmV7DngDw7ko8Rrl9B+IxQ==
X-Google-Smtp-Source: APXvYqw/2I4a2jQLoNg9jVuE6uyZeiWXEhBTT9LM+2NQF1+qNlWoWgRJVe4HsmbYb60EMIb50R5lsg==
X-Received: by 2002:a02:8501:: with SMTP id g1mr6779402jai.120.1556882541947;
        Fri, 03 May 2019 04:22:21 -0700 (PDT)
Received: from localhost.localdomain ([8.46.76.65])
        by smtp.gmail.com with ESMTPSA id d193sm737325iog.34.2019.05.03.04.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:22:21 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/5] bh-safe lock removal for SUNRPC
Date:   Fri,  3 May 2019 06:18:36 -0500
Message-Id: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patchset aims to remove the bh-safe locks on the client side.
At this time it should be seen as a toy/strawman effort in order to
help the community figure out whether or not there are setups out
there that are actually seeing performance bottlenecks resulting
from taking bh-safe locks inside other spinlocks.

Trond Myklebust (5):
  SUNRPC: Replace the queue timer with a delayed work function
  SUNRPC: Replace direct task wakeups from softirq context
  SUNRPC: Remove the bh-safe lock requirement on xprt->transport_lock
  SUNRPC: Remove the bh-safe lock requirement on the
    rpc_wait_queue->lock
  SUNRPC: Reduce the priority of the xprtiod queue

 include/linux/sunrpc/sched.h               |   3 +-
 include/linux/sunrpc/xprtsock.h            |   5 +
 net/sunrpc/sched.c                         |  76 +++++++++-------
 net/sunrpc/xprt.c                          |  61 ++++++-------
 net/sunrpc/xprtrdma/rpc_rdma.c             |   4 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   4 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |   8 +-
 net/sunrpc/xprtsock.c                      | 101 +++++++++++++++++----
 8 files changed, 168 insertions(+), 94 deletions(-)

-- 
2.21.0

