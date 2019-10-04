Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8ACBC6B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2019 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbfJDN64 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Oct 2019 09:58:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40638 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbfJDN64 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Oct 2019 09:58:56 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so13676974iof.7
        for <linux-nfs@vger.kernel.org>; Fri, 04 Oct 2019 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SU35H9WM1romdOrNqRMS+gWR04uJNoDD6xNcF5fIYYY=;
        b=WxQ48ZsRkyxpru6iHzybkPC38uCu8BL2o3jXDm7j5uLzyZD9s9CyszjKF2lkmbkXgX
         M7+Y5dcc64Oi7cc78BS3flvqBxOt07RGHYzAKidMkv93dVbK+sklBC5M1I1lMGu+ldXY
         U4xfqYG26tuDrb1u6Xjlc0+IwzQn364c8h5v9aSYIOpTN2uYz20Z3Fk0i+CdUHL8huNE
         VdKXF5N+BjjBDq5NybWhXUEfH2gtpBpuAbIZihiW/ClpPi4hw026y0dSYO6gLKMex0cC
         htRlf+C9DhHid98ozG0OwnbVj0UUrajBh5M6Bjx0S2Evp3yx8BgK1O+Cd2nf0VjNLjSe
         AzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SU35H9WM1romdOrNqRMS+gWR04uJNoDD6xNcF5fIYYY=;
        b=p2UOCzqBaCOvnEx9ZLgSRuJgp7jiOv1vwHmixMx9fJl9Pj2osOm4sH+oBTHqIxOiJU
         EHBSlLXNQJvlTpjnoFmKH+X09Rgat2TWwJXpDcZQXDWZO57WKDI39pjNoIa3r0YdhCcJ
         g735SaAxCpfwnvb+/No3bReJ1gM7HideZ20IqtejKjHoVJfaicv2LTvCxefU/ZtfaHr1
         NP4IufMXwi0T/4+ILsUDgMCZ6SfaNkt08BtLSWuJ4mimF5nsfz0I6ulmhbSqsB0jgwaf
         U47oszoNktf0PgHrno46R52gDj9BV1+7uLfbqreSg0kg6IxyPxEZk6JzUgPUHdf7TfdP
         L+kQ==
X-Gm-Message-State: APjAAAV9YOPPWEZC9g5s9H2nWZgtsHCxjGRWCL4g/ZxIMZhMNlXa4uD0
        N9RFSYuXxT8g/rHm3GjLvI7o7MLj
X-Google-Smtp-Source: APXvYqzykH/glacRnRQ2rGBWw8pTGicDRBCR+jwKSNltjhL9JVid1oszRDyWnECYjhAWCvqPDkhZ4w==
X-Received: by 2002:a92:9a94:: with SMTP id c20mr15272094ill.65.1570197535881;
        Fri, 04 Oct 2019 06:58:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r2sm3075062ila.52.2019.10.04.06.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:58:55 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x94Dws4o019114;
        Fri, 4 Oct 2019 13:58:54 GMT
Subject: [PATCH] NFSv4: Fix leak of clp->cl_acceptor string
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:58:54 -0400
Message-ID: <20191004135854.2564.20943.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Our client can issue multiple SETCLIENTID operations to the same
server in some circumstances. Ensure that calls to
nfs4_proc_setclientid() after the first one do not overwrite the
previously allocated cl_acceptor string.

unreferenced object 0xffff888461031800 (size 32):
  comm "mount.nfs", pid 2227, jiffies 4294822467 (age 1407.749s)
  hex dump (first 32 bytes):
    6e 66 73 40 6b 6c 69 6d 74 2e 69 62 2e 31 30 31  nfs@klimt.ib.101
    35 67 72 61 6e 67 65 72 2e 6e 65 74 00 00 00 00  5granger.net....
  backtrace:
    [<00000000ab820188>] __kmalloc+0x128/0x176
    [<00000000eeaf4ec8>] gss_stringify_acceptor+0xbd/0x1a7 [auth_rpcgss]
    [<00000000e85e3382>] nfs4_proc_setclientid+0x34e/0x46c [nfsv4]
    [<000000003d9cf1fa>] nfs40_discover_server_trunking+0x7a/0xed [nfsv4]
    [<00000000b81c3787>] nfs4_discover_server_trunking+0x81/0x244 [nfsv4]
    [<000000000801b55f>] nfs4_init_client+0x1b0/0x238 [nfsv4]
    [<00000000977daf7f>] nfs4_set_client+0xfe/0x14d [nfsv4]
    [<0000000053a68a2a>] nfs4_create_server+0x107/0x1db [nfsv4]
    [<0000000088262019>] nfs4_remote_mount+0x2c/0x59 [nfsv4]
    [<00000000e84a2fd0>] legacy_get_tree+0x2d/0x4c
    [<00000000797e947c>] vfs_get_tree+0x20/0xc7
    [<00000000ecabaaa8>] fc_mount+0xe/0x36
    [<00000000f15fafc2>] vfs_kern_mount+0x74/0x8d
    [<00000000a3ff4e26>] nfs_do_root_mount+0x8a/0xa3 [nfsv4]
    [<00000000d1c2b337>] nfs4_try_mount+0x58/0xad [nfsv4]
    [<000000004c9bddee>] nfs_fs_mount+0x820/0x869 [nfs]

Fixes: f11b2a1cfbf5 ("nfs4: copy acceptor name from context ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4proc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 11eafcf..ab8ca20 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6106,6 +6106,7 @@ int nfs4_proc_setclientid(struct nfs_client *clp, u32 program,
 
 	status = nfs4_call_sync_custom(&task_setup_data);
 	if (setclientid.sc_cred) {
+		kfree(clp->cl_acceptor);
 		clp->cl_acceptor = rpcauth_stringify_acceptor(setclientid.sc_cred);
 		put_rpccred(setclientid.sc_cred);
 	}

