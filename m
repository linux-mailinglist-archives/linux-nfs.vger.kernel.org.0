Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3035FFFC
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhDOC22 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDOC22 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:28 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F503C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:06 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l19so15022010ilk.13
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1LIJOC97Dz3onNxCZYh7KrKitbgJa5hL+8WT/8rWG8=;
        b=TM0/6b0moQb67qwFZfZ+AC69pYSMIR3PGOO4DeJA4wIxwiyJSKsWMy9DVXJv44CFiA
         bvL3s7EN2KGm44odYl9dDxCcoMkm7B6Kn8aAHNW0VegvQHs5Hq0ly7n3E11HbjICqJ9p
         zuGrcBioa0kh9uadB93MG/ps7mdYJp1Ix67FfdyYNs726uvRqLb1+8TVzEkajJN1nTrr
         v7uolOlsRMEimjjDEunCmwwAXuIKqJYASn+O0iFdzkwUSPtuZ5k/mriTiwbQpNX5vVQ0
         QSsWRouDe6E8m37ygK20W1e22375IvwaR5Daq4Mfhxlv8hXrMx+Twmz/ULwf+lDHc6yq
         iUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h1LIJOC97Dz3onNxCZYh7KrKitbgJa5hL+8WT/8rWG8=;
        b=d5aJ7t083tC1O7h64JrFEDQaTam+VX3CrEkJO5UxQbkhMnhMVdeWEIiCs+dABjUwZq
         wOK6nXdyInBs4smfkTAMXCGXz2KMSA4xkaFkC2Y2keWozNZFzYN31pN5OxDtkDpwQr+Y
         IcXgOSgpudelLdgqBG9DhD6uac8oY/tUGQVUanQd2oCDAD/3svqVldhgL0wKx90OUXPf
         ua6Lbb3P3fXaPTG/oVy4t4h8PHnhQsZFUybM2la/ZoRa5ukZV87ry9iwY13IfDt5VMKj
         g6VodFKZOS8EPGf5z9NLiR5Ub5HBdd+Um9yNK8fxNcSy0aPewAgbJ/Qj+qBiUZsEJY61
         Jl2A==
X-Gm-Message-State: AOAM531aXEgZ0/EMx2NOpro8HL/Gwa6XMfsGmeIOIBdCl5T5A29NuDDF
        0y29FtBgB1RJVapJOIChpVs=
X-Google-Smtp-Source: ABdhPJzwOYBGzuWLkMZpwp/UZxFGVSuOLageua4BHg8wTomcc+cFNvQYMvYaOVdTwghIn8vYWa6xDg==
X-Received: by 2002:a92:d74c:: with SMTP id e12mr1007560ilq.13.1618453685728;
        Wed, 14 Apr 2021 19:28:05 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:05 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/13] create sysfs files for changing IP address
Date:   Wed, 14 Apr 2021 22:27:49 -0400
Message-Id: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
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

Anna Schumaker (4):
  sunrpc: Create a sunrpc directory under /sys/kernel/
  sunrpc: Create a client/ subdirectory in the sunrpc sysfs
  sunrpc: Create per-rpc_clnt sysfs kobjects
  sunrpc: Prepare xs_connect() for taking NULL tasks

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

 include/linux/sunrpc/clnt.h          |   1 +
 include/linux/sunrpc/xprt.h          |   5 +
 include/linux/sunrpc/xprtmultipath.h |   5 +
 net/sunrpc/Makefile                  |   2 +-
 net/sunrpc/clnt.c                    |   5 +
 net/sunrpc/sunrpc_syms.c             |  10 +
 net/sunrpc/sysfs.c                   | 477 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  42 +++
 net/sunrpc/xprt.c                    |  26 ++
 net/sunrpc/xprtmultipath.c           |  32 ++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |  11 +-
 12 files changed, 616 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

