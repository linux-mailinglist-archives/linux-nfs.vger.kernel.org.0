Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4786736185C
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhDPDwy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhDPDwy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:52:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E8C061574
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id j7so19913616qtx.5
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoReNaw67x0t5Bt2GVT9L7+yeB0hHOS6Sz0nvofdhEo=;
        b=oBvl4wBpRAfIVeMKd2+ne014hPGGHScK4Eq6A04Ait7FwleRERPuWN/0bn56vJ43cc
         1+8suguQnl0gm/Jr+O4UOXXWWXpU2KiDSlZdU3qH2qlnk00VXUudle6IddPN3SSfczry
         gFx8+Ti0FmAUZ2GajOo49cy8aeYJaq0Zg+FNEIz67Wcz/leJ2mkxAOz/ewLgXxhnn3fS
         KOqmVfD7K9eYdfdphDZzunRXhEIb3ZuL9CewAIpCuk/ZusM9ArYQKY0WFx12rbnBSA8E
         gGyMoH1SX+R3Z02CWvLovc+A9jedICleACfCzn/xozo+1t+nwAhwBky29n1xNO8pfHk/
         Md0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoReNaw67x0t5Bt2GVT9L7+yeB0hHOS6Sz0nvofdhEo=;
        b=D5a0kKRIAELBIkujMpJ+rmVm2dW/Lqg7pqZYeK+U6iqtS0Rk3JXPRc/A6cOD3xo3J3
         7E8/R0YHwmNPLgycGRh9OMH8UI4GDwOdoYl0rGxMxgFKrBaobedgOB+B4Ugh2pxgJWUP
         E2/+KevJnlusB5bA+S6nng/EdsFjrFCJ0tJrUYXgW17M4hrRlIiJL+4PJ3xasL1pndYf
         yM7Ebg/cZ1bWSWyXSUzoHrMt1/8UY3Ax+OEN/UsxoLuM2D6rYKoB6OiBqpjx/iNsBC0V
         UmV3aKOfXmiNtUMHHXe6UvC2/SMhf2P/oWbj8kZCqu17Lksyiw5+bLGhPKfTSthjRrZ+
         4sXg==
X-Gm-Message-State: AOAM533unpcNfSSVnDg7P/TBQ9gZ02fHEVTa+zr1StkXLZXODw3d+e7s
        qIsGUtVrmgz+/X7FlqxxUWP7W//UJXA=
X-Google-Smtp-Source: ABdhPJz1ByiCvI4LVzPr43eTNBtajTrsGoswCsqtuJDNoTtcY0DPhBgKNNVqLnkspqAslP7E/6R/yA==
X-Received: by 2002:ac8:4802:: with SMTP id g2mr5941603qtq.210.1618545148817;
        Thu, 15 Apr 2021 20:52:28 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:28 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/13] create sysfs files for changing IP address
Date:   Thu, 15 Apr 2021 23:52:13 -0400
Message-Id: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This is the same patch series that was introduced by Anna Schumaker
and slightly redone with also including some elements of the proposed
additions by Dan Alohi.

The main motivation behind is a situation where an NFS server
goes down and then comes back up with a different IP. These patches
provide a way for administrators to handle this issue by providing
a new IP address for one ore more existing transports to connect to.

Sysfs structure has changed slightly. Everything is still off the
/sys/kernel/sunrpc which has 2 main subdirectories "rpc-clients" and
"xprt-switches".

"xprt-switches" contain one or more subdirectories
"switch-<uniqueid>" that represent a group of transports created
for a given NFS server. Under this directory is one or more directories
named "xprt-<uniqueid>-type" where type is "udp, tcp, rdma, local".
Under each transport directory are 2 files. "dstaddr" which can
be queried to see what's this transport is connected to and "dstaddr"
can be changed by providing a new IP for the server. The setting
of the new address is allowed only for "tcp" and "rdma" transport
types.

There is also "xprt_info" file which contains a list of possibly
useful information about the transport: xprt state, last time use,
etc (for the full list see an individual commit). At the
"switch-<uniqueid>" directory there is also "xprt_switch_info" which
contains the info about number of transports and active transports
and xprt_switch's queue len.

Going back to the "rpc-clients" directory, it contains a subdirectory
for each rpc client "clnt-<uniqueid>" and inside is a symlink to
the xprt_switch directory this rpc client is using.

Some of Anna's and Dan's patches were slightly modified to satisfy
checkpatch script.

v2: fixed kernel test robot issues.

Anna Schumaker (1):
  sunrpc: Prepare xs_connect() for taking NULL tasks

Dan Aloni (1):
  sunrpc: add xprt id

Olga Kornievskaia (11):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a client/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects
  sunrpc: add IDs to multipath
  sunrpc: keep track of the xprt_class in rpc_xprt structure
  sunrpc: add xprt_switch direcotry to sunrpc's sysfs
  sunrpc: add a symlink from rpc-client directory to the xprt_switch
  sunrpc: add add sysfs directory per xprt under each xprt_switch
  sunrpc: add dst_attr attributes to the sysfs xprt directory
  sunrpc: provide transport info in the sysfs directory
  sunrpc: provide multipath info in the sysfs directory

 include/linux/sunrpc/clnt.h          |   1 +
 include/linux/sunrpc/xprt.h          |   5 +
 include/linux/sunrpc/xprtmultipath.h |   5 +
 net/sunrpc/Makefile                  |   2 +-
 net/sunrpc/clnt.c                    |   5 +
 net/sunrpc/sunrpc_syms.c             |  10 +
 net/sunrpc/sysfs.c                   | 476 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  42 +++
 net/sunrpc/xprt.c                    |  26 ++
 net/sunrpc/xprtmultipath.c           |  32 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |  11 +-
 12 files changed, 615 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

