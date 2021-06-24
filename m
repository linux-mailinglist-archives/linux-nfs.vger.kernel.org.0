Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B424E3B2575
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFXDbQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFXDbP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:15 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4176C061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:56 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i13so486836ilu.4
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyiaKFagLBAklqwpiHgbvnvD0KzlBMKBb++MCDTnBg4=;
        b=G5hd+8+80RAwJ4ZVJLGcl+Q9zmi2raxR46qaE0T28BVNi9p2w0EIRsSRwWpZcedCtK
         4tik+W3Jn+bMP+bZDWqVXzcJyvTLlhuFoXiuOE7M1cp8w/S+ICnVVhy75tKu1xttJIwk
         tjCgQMlAf5NgF9ekJZKaJWdaMob4LpA9dXE2KFLnNrDtrJ9LkO3mvJVdsrtqGRlkTPdM
         t4/sp3kW6nvspMAMLqJyZycClSpjxvravhhcQzMOEi101HjRQOaY7A5PvSySo5PUKiX1
         Nx5PuC/QGqfeMue+L1vKZrcAmZ1io+3wxSlBIeOunqnrO9sdQ4luHQMsL1JP58ALIL/i
         sZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CyiaKFagLBAklqwpiHgbvnvD0KzlBMKBb++MCDTnBg4=;
        b=KKpqALHM9Ldks/EedF14u5InAD6t6lZYgCiTejVNaQXva44OWDsHOhvYtHVNKnjnAI
         K/JVIr0dZeMY4Wjwme4uDEqHnqoku1yoS86pbD7MppxruSW6WXmWvCdzBplrfMH2Oizv
         HE6GqSPgWE4g184ulVEg0p8Jeubtd/mq8A4LZBvYnA0Bp0IB7IKfRofmREfitXXxK2TF
         7UDqPe27SCmyLi97snxNlu9xjhvWojbTd2g1mGjYS88u2kpDptrtoUCVMuiCnXkCoaV5
         dlZlZWCbOvUsTSWlacni9bcwPRkOgLF/ZLiJRKS3lqsf2RpAvk9opWl5sHactaOf8JMx
         xohQ==
X-Gm-Message-State: AOAM530Wt/NjXFgpx1lJ21buOPArg1WHdN+BgH/6Qi/2NK2ZvLhXeamb
        +yKgkYxzaiXibz4ajwW4yMU=
X-Google-Smtp-Source: ABdhPJyBBYFEqGNfH0AwOFpwNfXOteKiJs9SbwUNdcoPHAN5RlkGILVaZ2O9ABasIYwrgaSXCn9BsQ==
X-Received: by 2002:a92:dcc5:: with SMTP id b5mr2068181ilr.306.1624505336196;
        Wed, 23 Jun 2021 20:28:56 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.28.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:28:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/8] allow for offlining/removing xprt via sysfs
Date:   Wed, 23 Jun 2021 23:28:45 -0400
Message-Id: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In this patch series, I propose to add ability to offline a transport
so that it's no longer available for tasks with ability to either
bring it back online (if this transport recovers) or it can be removed
all together. When a transport is begin removed, all the moveable tasks
that have been assigned to this transport but didn't complete will be
retried on a different transport. Note, that if a transport has stuck,
un-moveable tasks, it can't be removed.

in v2 of this patch series:
-- able to online an offlined transport
-- for the getattr, to mark it moveable, use presense of session instead
of the minorversion
-- added things to the xprt_info displayed via sysfs: (1) whether or not
this is a main transport, in hopes to prevent to offline/remove a main
transport. (2) display source port of the TCP transport, as it makes it
easier to make transports to the network trace. (2) display xprt's
queuelen which keeps track of tasks that have been assigned to this
xprt.

Olga Kornievskaia (8):
  SUNRPC mark the first transport
  SUNRPC display xprt's main value in sysfs's xprt_info
  SUNRPC query transport's source port
  SUNRPC for TCP display xprt's source port in sysfs xprt_info
  SUNRPC: take a xprt offline using sysfs
  NFSv4.1 identify and mark RPC tasks that can move between transports
  sunrpc: display xprt's queuelen of assigned tasks via sysfs
  sunrpc: remove an offlined xprt using sysfs

 fs/nfs/nfs4proc.c               | 38 +++++++++++--
 fs/nfs/pagelist.c               |  8 ++-
 fs/nfs/write.c                  |  6 +-
 include/linux/sunrpc/sched.h    |  2 +
 include/linux/sunrpc/xprt.h     |  3 +
 include/linux/sunrpc/xprtsock.h |  1 +
 net/sunrpc/clnt.c               | 25 +++++++++
 net/sunrpc/sysfs.c              | 98 ++++++++++++++++++++++++++++++---
 net/sunrpc/sysfs.h              |  1 +
 net/sunrpc/xprtmultipath.c      |  6 +-
 net/sunrpc/xprtsock.c           |  7 +++
 11 files changed, 177 insertions(+), 18 deletions(-)

-- 
2.27.0

