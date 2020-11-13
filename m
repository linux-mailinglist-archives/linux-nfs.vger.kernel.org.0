Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41D62B2443
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 20:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgKMTIw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 14:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMTIw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 14:08:52 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CE4C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 11:08:51 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id s24so10810917ioj.13
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GlJdIxuBDbX4x2xtXrixslFihf9du2KKRXvP+Xfqt7I=;
        b=tT7HJY0GDHU++JUW3/HhZtDjVfPW0IS6ZoayRCugtRpC7PgIIHrEA86EMOsXNIPLPB
         njPb9bLItcsfHHW3gLh9DKxrqCuey/70JmCiutFOtdr53gen5YZWHzjQmas+MUV3YX4e
         Gt9Bm+0La53gSRJjrJqUP66txzPYINSZ12NEBRGrzIyYLIra+SMmmJeUDWNjhE5r+NWl
         c37LS5X88t/b+G3Nu7ScgAl25hIBEACeoN3l1dwVV17l97q2VFkAoMpyz2SRZNmzCAcV
         DZKW7JJMCIJYCgRrpUMxrS7RmXxoOvO+efxHOq7vOwTxLWH3ioEmpspkAqg7Zk2s8M3O
         gKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GlJdIxuBDbX4x2xtXrixslFihf9du2KKRXvP+Xfqt7I=;
        b=ILmxOmPiKzqtkjLfhlTDJG7BOMydiLUKw1W4V38HlCjT6xsAR5DcwvZnKrDQSY/LWB
         KX17kU26uThmjfGAwQ4mppRPB+usUHn7tA4hA8xdcfh/ZfzPwwrpc8q4y+b5+nV8M6BS
         LwmXScVrOqZCtNVSvWg3XV+OsY8uIGpQCqQ3bZzXkFVu3ia7vik/m7rlPDP1nVV6Q4nb
         1de3hKpEPpBUVCmt3/OfaQN/mx29R0ws5qf3IBm2TMBfk53HcTHhhscHx1/Dgab0mtPb
         tz+CXxudqlHGzW9qD5GSO1aZWwODVbi2wXaMl+cLx7hYWt07qIx0sz6Ra4rubFnmIG69
         nvmQ==
X-Gm-Message-State: AOAM532e1Nl+TPtWVSuGbfXG53r5Vt9XBOTagCf7gXi6KetzkK6dhuVv
        gJsMmmQhRrBhF2vlqVS98O+o+sMhTvk=
X-Google-Smtp-Source: ABdhPJxIS5/bAsWKGVowZekKqR/WnucWcRJWaLhoy+igfC0+psYxrLvd8FDHpSTEabqTcEakrq3L7g==
X-Received: by 2002:a5e:8601:: with SMTP id z1mr944309ioj.160.1605294530236;
        Fri, 13 Nov 2020 11:08:50 -0800 (PST)
Received: from Olgas-MBP-377.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id k15sm5207258ils.87.2020.11.13.11.08.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 13 Nov 2020 11:08:49 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
Date:   Fri, 13 Nov 2020 14:08:51 -0500
Message-Id: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

xfstest generic/013 over on a NFSoRDMA over SoftRoCE or iWarp panics
and running with KASAN reports:

[  216.018711] BUG: KASAN: wild-memory-access in rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
[  216.024195] Write of size 12 at addr 0005088000000000 by task kworker/1:1H/480
[  216.028820]
[  216.029776] CPU: 1 PID: 480 Comm: kworker/1:1H Not tainted 5.8.0-rc5+ #37
[  216.034247] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  216.040604] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[  216.043739] Call Trace:
[  216.045014]  dump_stack+0x7c/0xb0
[  216.046757]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
[  216.050008]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
[  216.053091]  kasan_report.cold.10+0x6a/0x85
[  216.055703]  ? rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
[  216.058979]  check_memory_region+0x183/0x1e0
[  216.061933]  memcpy+0x38/0x60
[  216.064077]  rpcrdma_complete_rqst+0x447/0x6e0 [rpcrdma]
[  216.067502]  ? rpcrdma_reset_cwnd+0x70/0x70 [rpcrdma]
[  216.070268]  ? recalibrate_cpu_khz+0x10/0x10
[  216.072585]  ? rpcrdma_reply_handler+0x604/0x6e0 [rpcrdma]
[  216.075469]  __ib_process_cq+0xa7/0x220 [ib_core]
[  216.078077]  ib_cq_poll_work+0x31/0xb0 [ib_core]
[  216.080451]  process_one_work+0x387/0x6c0
[  216.082498]  worker_thread+0x57/0x5a0
[  216.084425]  ? process_one_work+0x6c0/0x6c0
[  216.086583]  kthread+0x1ca/0x200
[  216.088775]  ? kthread_create_on_node+0xc0/0xc0
[  216.091847]  ret_from_fork+0x22/0x30

Fixes: 6c2190b3fcbc ("NFS: Fix listxattr receive buffer size")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42xdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6e060a8..e88bc7a 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -196,7 +196,8 @@
 				 1 + nfs4_xattr_name_maxsz + 1)
 #define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
 #define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
-#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + 1)
+#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1 + \
+				  XDR_QUADLEN(NFS4_OPAQUE_LIMIT))
 #define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
 				  nfs4_xattr_name_maxsz)
 #define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
-- 
1.8.3.1

