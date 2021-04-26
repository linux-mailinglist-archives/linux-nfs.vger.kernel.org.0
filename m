Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9817C36B7FC
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhDZRUw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhDZRUk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:40 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D5C061763
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l19so6682874ilk.13
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGk3rj9HWcGHEZUroTHDDdyFNkq1dkS20B/ttW4ptdc=;
        b=KuId4pLBPqEEsH+UzFjJNnoqrQPE0osIlu/7RmUC69GDjviJ5X4pKGncOQWJJFJFg0
         cyH5m5/XLbOc8wYwpkFREkv4kBXG8erK9CPI8FgNYJIQOlqoqM1fDoCSe6zDvwwZ8GRw
         vjL3E5Yy8ql387L0Z/4/Rcvl8xXs50fgMM3oOLi6Y/MdO4O+x4+tIot/7kBptODCvclV
         XJZJvqLNecomBTP+rqdZZbouimiK0G/fmuyLTNUfXR4+QnuK5C0wBLfOgGpwlCcEi8+Z
         o2hR7byUVgzgesUNMyAPKZrHM2KDTGIFIbATfY767fc7wm6BVTkpbjJWwo3AMuEIVGHT
         iRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iGk3rj9HWcGHEZUroTHDDdyFNkq1dkS20B/ttW4ptdc=;
        b=jBnOEMnBMhUjOHF5/tpAeWMMkVCX+lCNZxGYBpj3nir+pDGYlcXoI0QKdpgJVZl4sq
         3tV3cT8MgB3LasO2tpF414AcgPwA50vqkTQEJ4eZ3YnxrIpWzwiq8w7N3+OzKkaWkwfC
         zF25BAV2gZfIT6CpLSq6ulI1fbMo8ZwPdhFttyH2ob97TVfearf9MvVz5P9/36GUb0MT
         xrnC6LJqO+32H1XB9gqJSaQX4Sr1zpY0Pc/X5vnztEdfUUZiAPNocbIpdm3qF0tlehyi
         boIig9Q83U51pu9aR7NimrdOsLFnvvISb3dZyo4WxjeqaVQt3eBdKqxystGVTpft3OP9
         jRzg==
X-Gm-Message-State: AOAM53360L5JqLyPUxR0X5YHHw8x+XC1/QzpeQYIlAaDdGieeOaZSTtB
        nDr9QD2FWadrMzSsOP7L8nCksfGQROcW0w==
X-Google-Smtp-Source: ABdhPJyxm99hChi428KTSRiTD8LSTVTR2+qPf8LqktabnfBc5eytr89XUryqr2G48eOkGK2PxLvHeQ==
X-Received: by 2002:a05:6e02:12e5:: with SMTP id l5mr14429442iln.140.1619457590157;
        Mon, 26 Apr 2021 10:19:50 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.19.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:49 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/13] create sysfs files for changing IP address
Date:   Mon, 26 Apr 2021 13:19:34 -0400
Message-Id: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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

Not included before is a sample output for the nconnect=2 mount:
ls /sys/kernel/sunrpc/xprt-switches/
switch-0
[root@localhost aglo]# ls /sys/kernel/sunrpc/xprt-switches/switch-0/
xprt-0-tcp  xprt-1-tcp  xprt_switch_info
[root@localhost aglo]# ls /sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp/
dstaddr  xprt_info
[root@localhost aglo]# cat /sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp/dstaddr 
192.168.1.68
[root@localhost aglo]# cat /sys/kernel/sunrpc/xprt-switches/switch-0/xprt-0-tcp/xprt_info 
state= CONNECTED   BOUND     
last_used=4294830258
cur_cong=0
cong_win=256
max_num_slots=65536
min_num_slots=2
num_reqs=2
binding_q_len=0
sending_q_len=0
pending_q_len=0
backlog_q_len=0
[root@localhost aglo]# cat /sys/kernel/sunrpc/xprt-switches/switch-0/xprt
xprt-0-tcp/       xprt-1-tcp/       xprt_switch_info  
[root@localhost aglo]# cat /sys/kernel/sunrpc/xprt-switches/switch-0/xprt_switch_info 
num_xprts=2
num_active=2
queue_len=0
[root@localhost aglo]# ls /sys/kernel/sunrpc/rpc-clients/
clnt-0  clnt-1
[root@localhost aglo]# ls /sys/kernel/sunrpc/rpc-clients/clnt-0
switch-0
[root@localhost aglo]# ls /sys/kernel/sunrpc/rpc-clients/clnt-1
switch-0

v3: 
--addressed the memory allocations. Patches 6,8,10 were modified
to pass in gfp_t flags into the functions. 
-- To address the allocation with the locked environment problem 
the call to rpc_sysfs_xprt_switch_xprt_setup() was removed from the
xprt_switch_add_xprt_locked() and called after but also I bumped the
refcount on xprt_switch and xprt structures being used.
-- changed patch13 to remove rcu_dereference() use in 
rpc_sysfs_xprt_switch_kobj_get_xprt() because it's not an "__rcu"
field. 

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

 include/linux/sunrpc/clnt.h          |   1 +
 include/linux/sunrpc/xprt.h          |   5 +
 include/linux/sunrpc/xprtmultipath.h |   5 +
 net/sunrpc/Makefile                  |   2 +-
 net/sunrpc/clnt.c                    |   5 +
 net/sunrpc/sunrpc_syms.c             |  10 +
 net/sunrpc/sysfs.c                   | 481 +++++++++++++++++++++++++++
 net/sunrpc/sysfs.h                   |  42 +++
 net/sunrpc/xprt.c                    |  26 ++
 net/sunrpc/xprtmultipath.c           |  40 +++
 net/sunrpc/xprtrdma/transport.c      |   2 +
 net/sunrpc/xprtsock.c                |  11 +-
 12 files changed, 628 insertions(+), 2 deletions(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

-- 
2.27.0

