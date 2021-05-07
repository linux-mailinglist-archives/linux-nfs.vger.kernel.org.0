Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0123768A5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbhEGQ0X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbhEGQ0V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:21 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0283C061574
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:20 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o9so2998586ilh.6
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BqcGhgF8/hYMgr9KmDa15RfC9OMuM36vNMGXRXVVsJA=;
        b=BRbmQg9T53zC/17hmaBK9b1+LO7idsBAThZnavdLT3rDrg4BrU/NmPD20jNzZERKvt
         e1/p13vAQ+tQRxyaf/yKC44HaAQSvj277bTP3pXJ4XJ1IiUhtcxY63Sakl79ki+0mfDG
         wOoAdSygKJ2rNCggh3ubKQXu8EpraZPoZTPX5OXGfxxD+wIlQwg0p/ZVWMa0zbK+U0PX
         DFKXhtZKPnCuI+A5MqtSJWnwjcFt6tnev9X1oo/vG5vqgFtKyiE0VbY5ZjXEHLvA0WSK
         kfEJLiIJ3+OvkwAPcprGLZm5NKofk3/5xPN0mNOLDrz9kss2tzjVxAWoFPemTL4Wyxi4
         p4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BqcGhgF8/hYMgr9KmDa15RfC9OMuM36vNMGXRXVVsJA=;
        b=JhFIEFKQi9Bd6uK42EUVUTQu72nsRtNJQGTLXSvWmBZzispUBp+UQrqiEqmQdPzWIh
         vJWplh8fZTx5CmV4VVf22kpPOyccB2t9bPBXZ4FPofbT/EBZwc5ZWFsdvhD/EDnUmXHJ
         2Pz6nRL6io3jsZrkX4WX/3XbeqwIZpt0A7vEe5TvFaPNxo2KEsl1RZOadmeYdY5It/bO
         T47Rz+TXyPljNNgtxs0eStF979yAh4ISBO7cRfpJL/nyq8BHJkzewf1Sf+8vBI5p6r2H
         iFcqyoD/pqkfWNl0OUd8ybqMMZED4eXfsPapbFASbTapXLjQmFbp8Tyf463GzKkv3vyz
         eeTw==
X-Gm-Message-State: AOAM533pDPXvsCRwD01PNTd/aJS4NcG14rUacLu7iA0rDO7rMg+y3H5/
        Y2br4mLtqPgSTlTieK34ZXWX7VZU9FnvzQ==
X-Google-Smtp-Source: ABdhPJzwV7Nc6LIQ10oRhMiKsT2iPcML2PPGQku6kcl5Uf0tsM8VBPHx+MUBdFdBoTNW4uoTcvEaeg==
X-Received: by 2002:a92:d385:: with SMTP id o5mr10316855ilo.115.1620404720266;
        Fri, 07 May 2021 09:25:20 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:19 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 00/12] create sysfs files for changing IP address
Date:   Fri,  7 May 2021 12:25:06 -0400
Message-Id: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v6: hopefully the last one. a new and simplier approach to
switching destination IP is to a forced disconnect and then
let the tasks themselves recover and reconnect the transport
to the new IP.

--- for the next tasks: removal of a transport and migration of
tasks on such transport to a different transport is to come.

Anna Schumaker (3):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a client/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects

Dan Aloni (2):
  sunrpc: add xprt id
  sunrpc: add IDs to multipath

Olga Kornievskaia (7):
  sunrpc: keep track of the xprt_class in rpc_xprt structure
  sunrpc: add xprt_switch direcotry to sunrpc's sysfs
  sunrpc: add a symlink from rpc-client directory to the xprt_switch
  sunrpc: add add sysfs directory per xprt under each xprt_switch
  sunrpc: add dst_attr attributes to the sysfs xprt directory
  sunrpc: provide transport info in the sysfs directory
  sunrpc: provide multipath info in the sysfs directory

 include/linux/sunrpc/clnt.h          |   2 +
 include/linux/sunrpc/xprt.h          |   7 +
 include/linux/sunrpc/xprtmultipath.h |   6 +
 net/sunrpc/Makefile                  |   2 +-
 net/sunrpc/clnt.c                    |   5 +
 net/sunrpc/sunrpc_syms.c             |  10 +
 net/sunrpc/sysfs.c                   | 485 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  41 +++
 net/sunrpc/xprt.c                    |  28 +-
 net/sunrpc/xprtmultipath.c           |  34 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |   9 +
 12 files changed, 629 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

