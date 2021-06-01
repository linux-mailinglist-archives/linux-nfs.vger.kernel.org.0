Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4096C397C39
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 00:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhFAWLH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 18:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhFAWLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 18:11:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F1C061574
        for <linux-nfs@vger.kernel.org>; Tue,  1 Jun 2021 15:09:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v8so466633qkv.1
        for <linux-nfs@vger.kernel.org>; Tue, 01 Jun 2021 15:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcPY6BsvMkdwEm+rRVP5JTZW184pKmFOJjslDEIdVYk=;
        b=saXrc2rr2rHLSTRTOZSwoG/Dsp+NTxxSt7wOIloxPCmOTzTyQpvztNyKEImf1KMa8s
         B1XXH6uKs9lfPvXEke2zZzu1N8NoRFB3oA3/0wG3WwATOgh32tS9jaQTX+Rj8jOPaV2N
         0PNKL9Y5Qr2CvfYyjW7W2avz9Oo/Kd9gginG644Sm4ZOAC/WC71mZQ4ou3BHeIS7wnMe
         mtp0nmLbRfah95lu7lK8f8rCuOeO+Ufu5hEP4wMiuiHnbx7hJMA8GZNhDQDr8wtArK41
         ph0Nx0JU9u8xSwFiSsXzaAPy8Y6MtbxN9J3kubG/DYZekn7zeWFKkQObTApXLx6fhMtE
         qf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcPY6BsvMkdwEm+rRVP5JTZW184pKmFOJjslDEIdVYk=;
        b=cMsdfJjXesucnaOEkKKNhlaTkVPKVOBFaq1bGXpB3981KnSTp7Rl6o8Uo76J/qnvdJ
         09TOH+UJckjfghGynaLWsUckWzIe2oLEUcfEewjm89+SSvTRM82ZY5Ng4k1gv6ivMhsG
         upLgMYbVGdarnragE5ehYoKQTaToAB35xTbBy0jtqW2L8z2Sj0TocditK0fafunOAeGZ
         2xV+LYKC4BT4nR3yhSxD4sfqCdRkKamiqOgJKeFmLDt2mS2zW2Wis+M/iH/5yR7Aze0L
         6cFYiKJ2xIoNbJZiI4aMHeboTZzOl3dHxa6j9HN+f5GIIBOSI+CmSf02lNmCmQO0wRfK
         5ZnQ==
X-Gm-Message-State: AOAM532dXQZbyOG590G1nhFenHhIrgkXCVF5v8HeYbWv0kbn0bwGVJFp
        KShvuQa4KKR4c+m3PeWSI0KPLre+/cc=
X-Google-Smtp-Source: ABdhPJzSoAv6a43I/xJtaigIKovYw2k+Ub5P+5ANr6UYtRWPAfIN+bVr9wWxcVGjN4dLhbs8/d2gGw==
X-Received: by 2002:a37:80c6:: with SMTP id b189mr3200034qkd.332.1622585363187;
        Tue, 01 Jun 2021 15:09:23 -0700 (PDT)
Received: from kolga-mac-1.lan (50-124-240-218.alma.mi.frontiernet.net. [50.124.240.218])
        by smtp.gmail.com with ESMTPSA id q13sm12419789qkn.10.2021.06.01.15.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 15:09:22 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 00/13] create sysfs files for changing IP address
Date:   Tue,  1 Jun 2021 18:09:02 -0400
Message-Id: <20210601220915.18975-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v8:
in patch 10: moved removal of sysfs xprt entry into xprt_free(). 
in patch 11: removed the display of xprt state from the common xprt info
into its own attribute/file "xprt_state" in preparation of being able
to modify xprt's state. moved the display of xprt state into its own
patch.

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
 net/sunrpc/sysfs.c                   | 501 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  41 +++
 net/sunrpc/xprt.c                    |  30 +-
 net/sunrpc/xprtmultipath.c           |  32 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |   9 +
 12 files changed, 645 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

