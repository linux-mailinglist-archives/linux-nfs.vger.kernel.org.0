Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE541D0066
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgELVM4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgELVMz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:12:55 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F8C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:12:54 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r3so7224949qvm.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=h/OwMCVZvIr6zk3l70XxNt9q1DZsQ8edzDB+a1u6XDU=;
        b=Cf+FJ5PuupgBLMOqBTPJDSx+a7T6XwwDMBTQk2ikrV2pMAl55bf4NxJ62+tS8fE//7
         k35veSfDr1rHs1FVQe+sHcgwwnotHYecun7OmAA9lDUAM1gWFQBQur3ztd38FAKpaNZ8
         NrCSO3nwFMj+Zrc1MgJccA93wJZJwSYCTdSl4ZSo1S9BTX1UpgJWUWWGYiV9VnsLuLuZ
         D/LGQOZAyqAyxPS/YviTcAnE48fiWAnAQhhwYokJ9SZEQSqta93TkVXuyh6TBi0z9Wa4
         b7Nm/KlMkG7ZieP1cafnVzKwBmtTz7KlViFBD/C6Z5HcN/YHhub1kUV4XxtN9oSijVAP
         LJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=h/OwMCVZvIr6zk3l70XxNt9q1DZsQ8edzDB+a1u6XDU=;
        b=iBfjasmYef/sjXV2h3h8il7f5GNb6DbyupGsTGkTud1SK1xJQpZEonqHb5wC1nBhXO
         hx17d6MLdwbvYqAPyPe6+KfmHbm6iqBlfcjgHInbyLMpSVqdapxot6AjdrGWqgapXfJU
         jv0wYiSvdJgDRlYUE34dQ2+QVNtfoTgaIL+hW8FCXWQgEMHHp1WjEis9VgQmnfusVSay
         kMg9PDGNvy2Stv/EefDV361FyV6jdIHBL+1fbX5Vzr7i8UIiW+AA9tb7FPCVYFk5G3+S
         ZhetG3megprGiUIRpdS/ez2VVCM+UMkr6FZ5PF+TcSfsdCsjlcSCLxAfsWkNAj89IGqy
         lGHQ==
X-Gm-Message-State: AGi0PubiGyKqkQt3DeFlt+CgTl3p7c58kIlUGTbSKt5eZD/WHGvpQCER
        gYquUMCIPDzqZxcQ8MaA93s=
X-Google-Smtp-Source: APiQypKoKN3FvIokzXQ8IqgF/1YwCZz35DndBLKedqoHpRUTI1UEo3iKV4Yi8lXSd0O8qNnk7qSW6A==
X-Received: by 2002:a0c:dd8c:: with SMTP id v12mr22402164qvk.134.1589317973167;
        Tue, 12 May 2020 14:12:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o67sm12148513qkc.2.2020.05.12.14.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:12:52 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLCouI009783;
        Tue, 12 May 2020 21:12:50 GMT
Subject: [PATCH v1 00/15] Possible patches for v5.8
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:12:50 -0400
Message-ID: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes:
 - Make sure ASYNC rpc_tasks observe signals

Improvements:
 - Adjust reply slack values only once
 - More client-side RPC tracepoint curation
 - Add/improve tracepoints to capture internal NFS I/O errors

---

Chuck Lever (15):
      SUNRPC: Signalled ASYNC tasks need to exit
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


 fs/nfs/nfstrace.h               |  106 +++++++++++++-
 fs/nfs/pagelist.c               |    2 
 fs/nfs/read.c                   |    2 
 include/linux/sunrpc/auth.h     |    5 -
 include/trace/events/rpcgss.h   |   89 +++++++++++-
 include/trace/events/rpcrdma.h  |    4 -
 include/trace/events/sunrpc.h   |  301 ++++++++++++++++++++++++++++++++-------
 net/sunrpc/auth_gss/auth_gss.c  |   56 +++++--
 net/sunrpc/auth_gss/trace.c     |    1 
 net/sunrpc/clnt.c               |   59 +++-----
 net/sunrpc/svc_xprt.c           |    4 -
 net/sunrpc/xprt.c               |   23 ++-
 net/sunrpc/xprtrdma/rpc_rdma.c  |    4 -
 net/sunrpc/xprtrdma/transport.c |    8 -
 net/sunrpc/xprtrdma/verbs.c     |    1 
 15 files changed, 527 insertions(+), 138 deletions(-)

--
Chuck Lever
