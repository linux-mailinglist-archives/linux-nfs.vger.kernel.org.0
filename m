Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3839AE75
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFCXA4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 19:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCXA4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 19:00:56 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B5FC06174A
        for <linux-nfs@vger.kernel.org>; Thu,  3 Jun 2021 15:59:11 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a7so4061041qvf.11
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1v+/VU/r/WBOX0FuGLr6KFrZZrph7pTqkFWwrqa+PQ=;
        b=knxCeZIqi9r2aLqPRAFOVBq45cq7B2rLwv/U+u0xl4M5WD1Mx4MwE91iBon29+OROv
         n1oomIEiwzgMTDN7g2cQzZNQQp7rC091CUO0ZWCLpO59HH5DmyuA/AEsjcXnrRTzTOTA
         +0KqChjUZqIyqqXihzoyKWdZuE0UI2DJ2lyZnKBnlodcB7D+fwNwJXncsQUyhhujBI2y
         D/uRilzsu3Y7i7HZvOJ3gnlUv7+IdEW0qhF8OOqVFQNthDsiLdPAqawIHVuWmalyrxY1
         FZlOgY8xa4JyD9qDl+75BTkU8hFIKJvsmfIrMGoZ4OPiY1MNYM9jtHyTLFCd379JPsql
         b/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1v+/VU/r/WBOX0FuGLr6KFrZZrph7pTqkFWwrqa+PQ=;
        b=bPrCjQH7yFVzHEEiu2gsxZhAQtVNFpW+8WR5RwPC0kBZ/ZJul6vPFQ81d1APu++RsP
         drGfpfy4K1h3B5QZEdH29XDnzD95AmXjFgXtuBUUhnCK+3KIfESZRewNxGCADEUZx1Nq
         so59I41mUx1uQGbCXJNiuhIX3Pyj1tYkfbjiV3XvwDXyohH804FD3+/Rr0UsU0x1C9Xv
         dJ2QP5l8FxPr6+BQDWcA1bHxQLewcLFRI6nVzLx4HLiSHF0Pa7REnN8kCvatkP0maIto
         CcaOczyvNO77UHWGEiOErrxaDF4VrkMdj8Z0OWpz5U5xwxcciZ3pUfM2V5jX0uugzq1S
         Yahw==
X-Gm-Message-State: AOAM530DSj67yldCeAkT0xLMIPBI5ahSuAMGgNi+LEWVL0KTLwMOu1AC
        urrSBaWwV/gSeR9haZ3fCJsih911pnA=
X-Google-Smtp-Source: ABdhPJzqqteq5RlrT+OwYEzTmrJQPvm6sLW2+g7HeMn7F8srsxMVDTACtG53sNk3FyQeC0Kh3vE3Gw==
X-Received: by 2002:ad4:4950:: with SMTP id o16mr1926338qvy.56.1622761150143;
        Thu, 03 Jun 2021 15:59:10 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id h19sm1479497qtq.5.2021.06.03.15.59.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:59:09 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 0/3] modify xprt state using sysfs 
Date:   Thu,  3 Jun 2021 18:59:04 -0400
Message-Id: <20210603225907.19981-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When a transport gets stuck, it is desired to be able to move the tasks
that have been stuck/queued on that transport to another. This patch
series attempts to do so. First patch, takes a transport and marks 
it offline so that no more tasks are queued on it. Second,
we identify which tasks are able to be re-tried on a different
transport (only 4.1+). Lastly, once the transport is deemed bad and
in need of a removal, it's marked to be removed. Any tasks that are
stuck there will now release the transport and try picking a different
one. This transport will be removed from the list of xprts. First 
transport with which the RPC client was created is considered the main
transport and can't be taken offline or removed.

Olga Kornievskaia (3):
  sunrpc: take a xprt offline using sysfs
  NFSv4.1 identify and mark RPC tasks that can move between transports
  sunrpc: remove an offlined xprt using sysfs

 fs/nfs/nfs4proc.c            | 38 ++++++++++++++++++++++----
 fs/nfs/pagelist.c            |  8 ++++--
 fs/nfs/write.c               |  6 ++++-
 include/linux/sunrpc/sched.h |  2 ++
 include/linux/sunrpc/xprt.h  |  3 +++
 net/sunrpc/clnt.c            | 21 +++++++++++++++
 net/sunrpc/sysfs.c           | 52 +++++++++++++++++++++++++++++++++---
 net/sunrpc/xprtmultipath.c   |  3 ++-
 8 files changed, 120 insertions(+), 13 deletions(-)

-- 
2.27.0

