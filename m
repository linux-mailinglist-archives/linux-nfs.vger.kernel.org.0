Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEABC3A04D5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhFHUBX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhFHUBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:01:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD33C061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 12:59:26 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o27so21448106qkj.9
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAbpy/DzMmt58N9hP1WU8Q0i8TjtLvhjDorJGeiNmDo=;
        b=t4IQ1P8a66q+42kaPOpBX7h3AjolurfkYb8WofsHjbqzf9r43i2RPN2z5ihCLKYfYX
         IKa0vT+u8sHQATe508eoiFkJpzPV4VmBuQ1R2Fc8ETChA3LK+J1GUj0U9BnDW90iIoXY
         wTzliaKX/pxykkXf4m8Wrp0fVYCB74IHwCu6YMyBjQ3HUc9wLYenWFBn0FI2Mb6BDlgw
         ytcuc4aK+MUvyffvlEhwR+iKrmIlmjLvsCqj0cQxcF9ikU79dRdrdW0MplYp3xH5wa0/
         25gnBvXkldLB0jqis2hIf1Bm5O4Jef4Iautv+uItxG3ty7yJkzN8hngrrxQ7z22DbRj8
         r+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAbpy/DzMmt58N9hP1WU8Q0i8TjtLvhjDorJGeiNmDo=;
        b=t06m6S5AKtonN8bs6aNt4UonBGemj8/Px8YoUtX8m7leiPz5d42bjdnRcU86X+ma05
         immPJ7CqGgHuj5DgQY4LePYUlX6NvJR5yDFGK1tpA8AcQfn1Zc3z5jFiJbi7JBQyHKCV
         pBuS3WdQ2Lcpsy1potA0dsbTsFRYaafO3ZTSqt3NKJTaDRHlA8r3+7h4OSYKbmWj3SOq
         qnZ6/oD6dpRHV75VnnywyAyT48qi8RU5zGTGny+dwQBVV5SufgDv1vL4Mm7YDqxb+WOr
         9/FxdsdjuI09/38pnIACeYCW2RZH9YtcRgPsxgFHCKUunyB6MmHmD5uEjwxbZgoDHqyh
         W6Rg==
X-Gm-Message-State: AOAM530XWQ5T2UNi5Xs0R5hN51GtPnHvPQowHOXoN6ZabkbZjKFpIbL1
        pNxX/2mFTDFMKboaLq2eiHUibOvACWk=
X-Google-Smtp-Source: ABdhPJwWfooLGNrKORnM2lVR5kcgN8BrCnHwieLR4lBCuZXyFGEsYD0g4apgcYRSoYmSKuex9LOhtw==
X-Received: by 2002:a37:5b46:: with SMTP id p67mr22350176qkb.358.1623182365453;
        Tue, 08 Jun 2021 12:59:25 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 00/13] create sysfs files for changing IP address
Date:   Tue,  8 Jun 2021 15:59:09 -0400
Message-Id: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v10: patch 10 change to adjust the copied input length based on 
whether or not the input buffer had an '\n' (from echo) or '\0'
from an nfs script.

Anna Schumaker (3):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a client/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects

Dan Alohi (2):
  sunrpc: add xprt id
  sunrpc: add IDs to multipath

Olga Kornievskaia (8):
  sunrpc: keep track of the xprt_class in rpc_xprt structure
  sunrpc: add xprt_switch direcotry to sunrpc's sysfs
  sunrpc: add a symlink from rpc-client directory to the xprt_switch
  sunrpc: add add sysfs directory per xprt under each xprt_switch
  sunrpc: add dst_attr attributes to the sysfs xprt directory
  sunrpc: provide transport info in the sysfs directory
  sunrpc: provide multipath info in the sysfs directory
  sunrpc: provide showing transport's state info in the sysfs directory

 include/linux/sunrpc/clnt.h          |   2 +
 include/linux/sunrpc/xprt.h          |   7 +
 include/linux/sunrpc/xprtmultipath.h |   6 +
 net/sunrpc/Makefile                  |   2 +-
 net/sunrpc/clnt.c                    |   5 +
 net/sunrpc/sunrpc_syms.c             |  10 +
 net/sunrpc/sysfs.c                   | 506 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  41 +++
 net/sunrpc/xprt.c                    |  30 +-
 net/sunrpc/xprtmultipath.c           |  32 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |   9 +
 12 files changed, 650 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

