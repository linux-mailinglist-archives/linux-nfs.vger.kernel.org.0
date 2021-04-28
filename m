Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F9A36E0F3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhD1Vc6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhD1Vcy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:32:54 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D08C06138B
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 66so25633875qkf.2
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znbi2V1G9+lh5SWQ2wjhUpCMQOWdAW5F7lv8aepc2rY=;
        b=YklskzmMmLoe2KdMZABggFADunJICwf4yMzFKgUGx4TZVbYl1KqirA2+KBDwB5uCfO
         9VwNlwR+pnlSoO6IXKDt6Jm2h3OCEEpOPiMjI7OPlsKg83bhvp4hUQut/DlZkvsECCCQ
         7wsjDCSzIyCeXG3/FzSTe0hBz3YiRgVFhoHObp0jmlaNhsX5t2jP2vNIEram+ipHtRmX
         tKCvtz42h2/1IEI2GsXSbxUvYnQ50K4PKPaDEVgTWD4wFjZFOUj3kkQwWC8L7z0qtH4/
         jDFa7V2LqGjMqn5Ni+7gPP+q1Lxq/s0M2ljdzxPwYqkXd9C2FU1NJxEsJYhFR0bKrR72
         ykVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znbi2V1G9+lh5SWQ2wjhUpCMQOWdAW5F7lv8aepc2rY=;
        b=DddJk5yThfgX//UkRG+cpQmSYExcTrwQu2GLc11pn+gP62k1Nj997drA8sG4YE6SKx
         3qItexYr4i1ykLNKS+Qg3gXpd0yG89i8PuJ8yEq02EG85w0bTgJZd5EvFv80zd76/Sbp
         /ZAshzmjRSY05fLD9hcpHmYLNm1WpYTm3/DcxaStAb6HJoBkykh/BQrxH1rQ8HXhZ5gd
         458EjBTFtCPWa+DqPEYxU+ogp8UWSX7DRnnNf1bcE/7q6A9Cbp5uE0vbwQ4Zqr+CJOJR
         bHBfsJU1ir1aoivMMOZx4FlKTjn883Yneg4E3LXxUwTAaNsGJ//TXN4sBQQxhxVTtabe
         9gAw==
X-Gm-Message-State: AOAM53003NdIWKH7SQtEZ7oFJVcg3T/L+EMv4MEA5tc+85bCsSmrTbek
        yGGMB80Tck8GSD1tfUkQGc53zfhlZv60Lw==
X-Google-Smtp-Source: ABdhPJzEVfWj5Ec81wqzMM1aQ267vKZybu5/uudeo4kVaZe+IU4QawSBeGqMpepqrapO5SH8nZtmjA==
X-Received: by 2002:a05:620a:ece:: with SMTP id x14mr32010589qkm.98.1619645526489;
        Wed, 28 Apr 2021 14:32:06 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:05 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 00/13] create sysfs files for changing IP address
Date:   Wed, 28 Apr 2021 17:31:50 -0400
Message-Id: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v4: addresses the latest comments:
--- void sysfs pointers are changed to pointers to structures
--- removed the xprt_get/xprt_switch_get() before calling setup
--- using xprt->address_strings[RPC_DISPLAY_PROTO] instead of creating
adhoc labels for type of transport
--- addressing the switching of xprt->address_strings[RPC_DISPLAY_ADDR]
by using rcu_assign_pointer and freeing the old pointer using call_rcu()


Anna Schumaker (4):
  sunrpc: Prepare xs_connect() for taking NULL tasks
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
 include/linux/sunrpc/xprt.h          |   6 +
 include/linux/sunrpc/xprtmultipath.h |   6 +
 net/sunrpc/Makefile                  |   2 +-
 net/sunrpc/clnt.c                    |   5 +
 net/sunrpc/sunrpc_syms.c             |  10 +
 net/sunrpc/sysfs.c                   | 472 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  41 +++
 net/sunrpc/xprt.c                    |  26 ++
 net/sunrpc/xprtmultipath.c           |  34 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |  11 +-
 12 files changed, 615 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

