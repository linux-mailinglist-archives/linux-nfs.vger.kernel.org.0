Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24B1F6D3A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2020 20:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgFKSLH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jun 2020 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgFKSLH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Jun 2020 14:11:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCBDC03E96F
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2020 11:11:06 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p5so6348993ile.6
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2020 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vP60nWjo4vFwYjtgC+RUq07KLGkUShk9achjv3Fjjtk=;
        b=YB0v91ywUmpq038Oi8o4O3Xte7l2xLJZRpBTbk/7LO1ce4pc+W6HzQlY4Dn1ngcn/9
         ryr1dkCyYmeWrvEo3d5fOhfcD5ZhcngkNP343Pp8a2pS5TzwT9MxytLQAcBFLLnp8MDP
         vsYxlghio8Kr4LmlbJ/H5GhDp+6jwW3u/ozWnXntRuTACIrOYrOn66mmx6lwC0NHBd1l
         fVc3qWRlBgaE6U1DULXsi7T+usyiCF+IPdjJ4huQv+0YWZCEfRnwsYEyuxSzw6UVSOOI
         AhkO+sf9vs2aEL+2FZARxa14t0TDLGfk0u8mkz7HMb/FZfXcXSG5Im8v0IGHBlULnt1T
         J5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=vP60nWjo4vFwYjtgC+RUq07KLGkUShk9achjv3Fjjtk=;
        b=EAC6//OGgCrReFwK5FvkU6hCEnFx9pSaXlUTAOI55BXYz33lAuWCh5KSfEQMIL7Vzx
         ipBppa41hCtRP1b9yy8Iypq1HW6B0c5k3na/5yJsyQWMJQSq7K4Hhi+lLKNynuZ01sVr
         1XGvn7/eUidl4h9Keq05pObFLm+M99yCl7Uzz1zehBOGYiAxbyS/2fuVxQNenDG3TGVO
         hTPNOgyKvPjk80tdGko+pQM1B5Wkcz3PgJapcSP4LXk5lrocCDLiW7mFN8OZApIrjOYz
         rl526mTeSC3Mp/Is+OwKvOBBUdcDBmZ20vE/tqeQxveovAe7V+B6a3qd+PeYoeL56XrB
         ctpQ==
X-Gm-Message-State: AOAM533mflIvyNpGBvw9qbsRQRAuUWXLUPoMs43ASL7c/pKlSOTdj5r/
        ohGSCCb01RS40Y2pOAaevRT+pfCkSYs=
X-Google-Smtp-Source: ABdhPJwDSGDPhByqiQ4tHzqHgLdloeQurjr+f6LVI4I2LWgrC0UJj0SKpwHCa9BtjimrUXnme5w6Cg==
X-Received: by 2002:a92:899b:: with SMTP id w27mr3063970ilk.16.1591899064857;
        Thu, 11 Jun 2020 11:11:04 -0700 (PDT)
Received: from [192.168.1.43] (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z9sm1888924ilq.22.2020.06.11.11.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 11:11:03 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     linux-nfs@vger.kernel.org
From:   Anna Schumaker <schumaker.anna@gmail.com>
Subject: [GIT PULL] Please pull NFS client changes for 5.8
Message-ID: <5149067d-621b-22b5-5f37-87fa9b14c181@gmail.com>
Date:   Thu, 11 Jun 2020 14:11:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.8-1

for you to fetch changes up to ba838a75e73f55a780f1ee896b8e3ecb032dba0f:

  NFS: Fix direct WRITE throughput regression (2020-06-11 13:33:48 -0400)

----------------------------------------------------------------

New features and improvements:
- Sunrpc receive buffer sizes only change when establishing a GSS credentials
- Add more sunrpc tracepoints
- Improve on tracepoints to capture internal NFS I/O errors

Other bugfixes and cleanups:
- Move a dprintk() to after a call to nfs_alloc_fattr()
- Fix off-by-one issues in rpc_ntop6
- Fix a few coccicheck warnings
- Use the correct SPDX license identifiers
- Fix rpc_call_done assignment for BIND_CONN_TO_SESSION
- Replace zero-length array with flexible array
- Remove duplicate headers
- Set invalid blocks after NFSv4 writes to update space_used attribute
- Fix direct WRITE throughput regression

Thanks,

Anna

----------------------------------------------------------------

Chen Zhou (1):
      NFS: remove duplicate headers

Chuck Lever (16):
      SUNRPC: receive buffer size estimation values almost never change
      SUNRPC: Trace GSS context lifetimes
      SUNRPC: Update the rpc_show_task_flags() macro
      SUNRPC: Update the RPC_SHOW_SOCKET() macro
      SUNRPC: Add tracepoint to rpc_call_rpcerror()
      SUNRPC: Split the xdr_buf event class
      SUNRPC: Trace transport lifetime events
      SUNRPC: trace RPC client lifetime events
      SUNRPC: rpc_call_null_helper() already sets RPC_TASK_NULLCREDS
      SUNRPC: rpc_call_null_helper() should set RPC_TASK_SOFT
      SUNRPC: Set SOFTCONN when destroying GSS contexts
      NFS: nfs_xdr_status should record the procedure name
      NFS: Trace short NFS READs
      NFS: Add a tracepoint in nfs_set_pgio_error()
      SUNRPC: rpc_xprt lifetime events should record xprt->state
      NFS: Fix direct WRITE throughput regression

Colin Ian King (1):
      NFS: remove redundant initialization of variable result

Fedor Tokarev (1):
      net: sunrpc: Fix off-by-one issues in 'rpc_ntop6'

Gustavo A. R. Silva (1):
      NFS: Replace zero-length array with flexible-array

Nishad Kamdar (1):
      NFS: Use the correct style for SPDX License Identifier

Olga Kornievskaia (1):
      NFSv4.1 fix rpc_call_done assignment for BIND_CONN_TO_SESSION

Xiongfeng Wang (1):
      sunrpc: add missing newline when printing parameter 'auth_hashtable_size' by sysfs

Xu Wang (1):
      NFS: move dprintk after nfs_alloc_fattr in nfs3_proc_lookup

Zheng Bin (2):
      nfs4: Remove unneeded semicolon
      nfs: set invalid blocks after NFSv4 writes

Zou Wei (1):
      xprtrdma: Make xprt_rdma_slot_table_entries static

 fs/nfs/direct.c                 |   4 +-
 fs/nfs/dns_resolve.c            |   1 -
 fs/nfs/inode.c                  |  14 ++++-
 fs/nfs/nfs3proc.c               |   2 +-
 fs/nfs/nfs4proc.c               |   2 +-
 fs/nfs/nfstrace.h               | 106 +++++++++++++++++++++++++++++++-
 fs/nfs/pagelist.c               |   2 +
 fs/nfs/read.c                   |   2 +
 fs/nfs/sysfs.h                  |   2 +-
 include/linux/nfs4.h            |   4 +-
 include/linux/nfs_fs.h          |   1 +
 include/linux/nfs_xdr.h         |   2 +-
 include/linux/sunrpc/auth.h     |   5 +-
 include/trace/events/rpcgss.h   |  89 +++++++++++++++++++++++++--
 include/trace/events/rpcrdma.h  |   4 --
 include/trace/events/sunrpc.h   | 329 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 net/sunrpc/addr.c               |   4 +-
 net/sunrpc/auth.c               |   2 +-
 net/sunrpc/auth_gss/auth_gss.c  |  56 +++++++++++------
 net/sunrpc/auth_gss/trace.c     |   1 +
 net/sunrpc/clnt.c               |  54 +++++++----------
 net/sunrpc/svc_xprt.c           |   4 +-
 net/sunrpc/xprt.c               |  23 +++----
 net/sunrpc/xprtrdma/rpc_rdma.c  |   4 +-
 net/sunrpc/xprtrdma/transport.c |  10 +---
 net/sunrpc/xprtrdma/verbs.c     |   1 -
 26 files changed, 575 insertions(+), 153 deletions(-)

