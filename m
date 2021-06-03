Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A843B39ADE9
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFCWXn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:23:43 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:46630 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFCWXm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:23:42 -0400
Received: by mail-qk1-f169.google.com with SMTP id 76so7510107qkn.13
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNXjQu/OyOieELxx7Ztab2V8n64Xussn67PlcRV/b1Y=;
        b=WFExQMIriAhRN63Lk6Fy2+mHj+/JNa2v8jf9UDYpV2Qhr/965dYJaIefoPfcUEPa2y
         5rd/me3LM2O69Del/pxF8aUGVmGcOwYudyvyLoJH19XxBvehyNB6PKvKyIGllZk/Mbyx
         H+zoPFizBpLS47FDH2pHfVZocUp8ivbO+oLL6rcRPuUl2SxtMECw6Gpmfo7vpf+gW6Kn
         FAKpa1nHZpw04yz9FGWDUXjGAxZ7oCYchdEOKZHTT4/JhpaS1nJQEgcy2hC0NJZbwAfc
         KIwErrJKd/gdTWwlYOPShGrLv9jJOZtIQQGnLmF8x9OML4XP/FpFEnCHuLzOK5j5Dviv
         SuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zNXjQu/OyOieELxx7Ztab2V8n64Xussn67PlcRV/b1Y=;
        b=SUMiIWMoK/iefHbwuiZlBR0tCZ4H+jKT6Vqk/1BUBGvJJtMlQ2lZPefzt78nEfijwz
         lGmI6EOKnTpVQUQFnINgxkc7YJjE2p2AkT+hob8eKv4Vlu9sB3WoSDuhPwj99AXiIblI
         vet0/LSSdS9eA06i+3UVmF7obiaNSFOe1NDzFvIEmsvXFF9lS9QO7MS5ZEIFJ03BDo2L
         xFYIPndt6hNdSX/xM9fh2xaz5mGYFzyCtW6vWElIn83ieiKCdUEdfzIos5uSpGhmW4yE
         i7z3usOK/dOaAabyTQSO5qBf7DTwxT3DEeo16wpOGthFTduqQZG88i1r+FoALDmVCYRk
         5lwA==
X-Gm-Message-State: AOAM531ROoST0rPJPUeu1tJc31UhX9wZ4sSvc4f9Etx/tpLG4qOMg+fH
        aHUZTsVAMyPWuiv1Vjlp7rM=
X-Google-Smtp-Source: ABdhPJwclJr6rCc0k6gSNGhBGYSuhILr/9HIrkLMpl9z+kNpkoZyYHafjamc1PpqJLa4g8bFD7gU4A==
X-Received: by 2002:a05:620a:15f7:: with SMTP id p23mr1517113qkm.178.1622758842122;
        Thu, 03 Jun 2021 15:20:42 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:41 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 00/13] create sysfs files for changing IP address 
Date:   Thu,  3 Jun 2021 18:20:26 -0400
Message-Id: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v9: removed unnecessary #include flagged by kbot

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
 net/sunrpc/sysfs.c                   | 500 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  41 +++
 net/sunrpc/xprt.c                    |  30 +-
 net/sunrpc/xprtmultipath.c           |  32 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |   9 +
 12 files changed, 644 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

