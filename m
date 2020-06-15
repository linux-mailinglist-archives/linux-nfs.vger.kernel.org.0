Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1061F983C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgFONUt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 09:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbgFONUs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 09:20:48 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7ACC061A0E;
        Mon, 15 Jun 2020 06:20:48 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t9so17752385ioj.13;
        Mon, 15 Jun 2020 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+SAKf2PrrgGkANxHrsuAJ5/9n8tv9Ilw1WTjGnmrFtQ=;
        b=AfUQqtTzf8AbLw08e/Zkqh4XuzAjIPTRFXwyB5RQ3WavBhWPClrROj0tNvOl4hBWML
         ypE56S5E+05lo15ZmUHaDEsIPwL5AucJgq1Yp28eIVwUsBTJBH4fXw9dbMQBfHM3ZrrU
         pI/jcemudz7bS0vfqZu1+7cZxKw+0ZxWgrTEMernKfqEzF9lBrfMq3d8hd9G+9BR1yTm
         XdIe73G9Y6FIXiaFfcGT9pZdnbfruE4VhAKnzQ6BILViNqhsxS/E6GCRqkwoookV8aHz
         6MCKNXjBHlK9rJtp1RHG7bQnjSxXG3TcF89InFPPxPTSxabcDP89AunNrsJHsYgb1H0a
         bp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+SAKf2PrrgGkANxHrsuAJ5/9n8tv9Ilw1WTjGnmrFtQ=;
        b=QpPBqI7meyfeBuBJFgUXB9cWoeLS1O1d6L3wWuf4fPYW7qNaTIyQcpjv3kAGazONlg
         JEZvg1rXsBpl1N7fBhnCySQDPx3/bpbWLil8yGIDTTsn5YHdbqrM2D1ej3Oo3p1Ym3Fs
         etB8zWaOx+Iab7cygKP0sKrlG8jswNX0cXDoaKPJSkJXTiJD8ldQO17cV3/dEJd9viO+
         o++sKRbyGSQiosrBrt2t5XOFOWL83mLBmJ1F4AL6i20eHnp4ycAKkuEx1thWMVXcLIO/
         kzcfiOqyCb4MOocKs9dFF1uN6QkGAL//hFVGns3RsO9gpPqHiTuxsVzVTEIrJTRM94/Z
         L7Cg==
X-Gm-Message-State: AOAM530ZpQMqXN6w85UJbTBRlPsguT1puyzGwSpIVeITk6JV/ZKLma8U
        rijBFId4+PDWaM56RomzR++kXRsQ
X-Google-Smtp-Source: ABdhPJyR24dRzmG5RECjhQHL8VqQNBPs2e4tyNUnMmgdqMtPoVmZY9YiRSAyH/tiR8eW3rHdFNIJ7w==
X-Received: by 2002:a02:cc96:: with SMTP id s22mr20776862jap.102.1592227248127;
        Mon, 15 Jun 2020 06:20:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y3sm7990789ioy.40.2020.06.15.06.20.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:20:47 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05FDKkpD018429;
        Mon, 15 Jun 2020 13:20:46 GMT
Subject: [PATCH v1 0/5] RPC/RDMA client fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:20:46 -0400
Message-ID: <20200615131642.11800.27486.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

This short series attempts to address a crasher (also seen recently
by Olga), prevent races during disconnect, and fix incorrect client
behavior when the server responds with ERR_CHUNK.

Please consider these for v5.8-rc. Thanks!

---

Chuck Lever (5):
      xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed
      xprtrdma: Use re_connect_status safely in rpcrdma_xprt_connect()
      xprtrdma: Clean up synopsis of rpcrdma_flush_disconnect()
      xprtrdma: Clean up disconnect
      xprtrdma: Fix handling of RDMA_ERROR replies


 net/sunrpc/xprtrdma/frwr_ops.c  |  8 +++----
 net/sunrpc/xprtrdma/rpc_rdma.c  |  9 +++-----
 net/sunrpc/xprtrdma/transport.c |  2 +-
 net/sunrpc/xprtrdma/verbs.c     | 38 ++++++++++++++++-----------------
 net/sunrpc/xprtrdma/xprt_rdma.h |  3 ++-
 5 files changed, 29 insertions(+), 31 deletions(-)

--
Chuck Lever
