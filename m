Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B075380B3C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhENOOi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhENOOi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:38 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB78C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:26 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w7so9201662ilg.13
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4e2RE2lfFmfom62gb+8MEqPHMaRxUsNpEXyK+1BEss=;
        b=g6XYN4cvIytm4ySGVav4pAK7+Bd9yaIglDX5L0YiNhxC723nEpcmykas9NoC1jClwo
         0zKmenhG7gPUi06hFOmTUdqD4ArkpiT2pQVwXdFfkHcD69cbo9XgDex0u1Mrp5s65JmJ
         fpk9bcYb75kIFBKua0iyydqLUphcyxTPCqraw/xAXhKf9fkyBtu42kOBKP+aAX4nYVcV
         QQGvrb89c0q5BKLchycmstCZGoSMDqFUoHbzmtbjoDWZF/pGtTN1eJdL5gkiRiZqw5R9
         XSk0yRfIzGgfqMO3jR3Zq95/daF/9M5hsJWMyvBhCNeV4IIsQvHSBzGyrku+e7ow/YGh
         RGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4e2RE2lfFmfom62gb+8MEqPHMaRxUsNpEXyK+1BEss=;
        b=bpHcQzcEtYDk/fxEZq/9gpMwuSDGPEIqOkVA9ojPHEP9CsJUnFIgGlrkhO+GWU8isP
         QHHlyFBDGkNW6TxO38khRcy6DCLiT8my8hYW9RZyHgIc/SSr5OntFslUb8eq912w2VjX
         pbaNn/ZOP7+gJtSji+qnE2mS9WLmyCnkKiPpS1PDgBEPu1KtFUf3Y7iS/vcWCqNgONne
         S82GROtML+V3pTR/OWjF1zuQ0zROIRBuj298U5NDh0s9SW5UblB24oRSfFpeZ4i+vKb/
         SjaJ3dltCwqOtAetTsuUN7yPK8M583gRVDFqefRkDYKHklnxAkMeJiGFw0iQSoGKWS7V
         bm4g==
X-Gm-Message-State: AOAM533UdhDiiFjEXkh0WGIdgTn6wGYwB0vDtnneXpq7TtXjvgeEd5W+
        87bZwl9hE8cU9KaniKTiX3ojT88J13Pbxw==
X-Google-Smtp-Source: ABdhPJxxKymYbT9Z1lt6ten5MtABCJTKjK62mVLSp2w+xgadkMmMlmhPCO3gqbcm0eDeiRjXGvGRww==
X-Received: by 2002:a05:6e02:13d3:: with SMTP id v19mr4225293ilj.168.1621001606210;
        Fri, 14 May 2021 07:13:26 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 00/12] create sysfs files for changing IP address
Date:   Fri, 14 May 2021 10:13:11 -0400
Message-Id: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

v7: change client's link to hardcoded "switch"

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
 net/sunrpc/sysfs.c                   | 482 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  41 +++
 net/sunrpc/xprt.c                    |  28 +-
 net/sunrpc/xprtmultipath.c           |  34 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |   9 +
 12 files changed, 626 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

