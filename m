Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9872EB539
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 23:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbhAEWIF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 17:08:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731696AbhAEWIE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 17:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609884397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FGLtQrM2gbMoWYy90TwZj98DcwKI8Nzc/wMX93YjHs=;
        b=fSy2J4vKJFVyll6IjJsfhsmFPydn5WQwwEbZvYVmVpl9Xtup4rCmbC2ydM/I/m+CWTjCK8
        7+is6m0q/K3uGbxqdmor6/BZ+ZEYgN0faPWHy+rHlCbGhSWDRdQ0LA/DE7Ba1UCqqnOQiA
        1l5m38/ie/6St+uFsiDhuRe9g9QAqjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-WVW436W-NPyC7c7pyaX7Ew-1; Tue, 05 Jan 2021 17:06:36 -0500
X-MC-Unique: WVW436W-NPyC7c7pyaX7Ew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64D5D1800D41
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 22:06:35 +0000 (UTC)
Received: from f31-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33684271A9
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 22:06:35 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] SUNRPC: Handle 0 length opaque XDR object data properly
Date:   Tue,  5 Jan 2021 17:06:34 -0500
Message-Id: <20210105220634.27910-3-dwysocha@redhat.com>
In-Reply-To: <20210105220634.27910-1-dwysocha@redhat.com>
References: <20210105220634.27910-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When handling an auth_gss downcall, it's possible to get 0-length
opaque object for the acceptor.  In this case we should make sure
simple_get_netobj() returns -EFAULT and does not continue to
kmemdup() which will return a special pointer value of
ZERO_SIZE_PTR.  If it just so happens that the rpcgss_context
trace event is enabled, the kernel will crash as follows:

[  162.887992] BUG: kernel NULL pointer dereference, address: 0000000000000010
[  162.898693] #PF: supervisor read access in kernel mode
[  162.900830] #PF: error_code(0x0000) - not-present page
[  162.902940] PGD 0 P4D 0
[  162.904027] Oops: 0000 [#1] SMP PTI
[  162.905493] CPU: 4 PID: 4321 Comm: rpc.gssd Kdump: loaded Not tainted 5.10.0 #133
[  162.908548] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  162.910978] RIP: 0010:strlen+0x0/0x20
[  162.912505] Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
[  162.920101] RSP: 0018:ffffaec900c77d90 EFLAGS: 00010202
[  162.922263] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000fffde697
[  162.925158] RDX: 000000000000002f RSI: 0000000000000080 RDI: 0000000000000010
[  162.928073] RBP: 0000000000000010 R08: 0000000000000e10 R09: 0000000000000000
[  162.930976] R10: ffff8e698a590cb8 R11: 0000000000000001 R12: 0000000000000e10
[  162.933883] R13: 00000000fffde697 R14: 000000010034d517 R15: 0000000000070028
[  162.936777] FS:  00007f1e1eb93700(0000) GS:ffff8e6ab7d00000(0000) knlGS:0000000000000000
[  162.940067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  162.942417] CR2: 0000000000000010 CR3: 0000000104eba000 CR4: 00000000000406e0
[  162.945300] Call Trace:
[  162.946428]  trace_event_raw_event_rpcgss_context+0x84/0x140 [auth_rpcgss]
[  162.949308]  ? __kmalloc_track_caller+0x35/0x5a0
[  162.951224]  ? gss_pipe_downcall+0x3a3/0x6a0 [auth_rpcgss]
[  162.953484]  gss_pipe_downcall+0x585/0x6a0 [auth_rpcgss]
[  162.955953]  rpc_pipe_write+0x58/0x70 [sunrpc]
[  162.957849]  vfs_write+0xcb/0x2c0
[  162.959264]  ksys_write+0x68/0xe0
[  162.960706]  do_syscall_64+0x33/0x40
[  162.962238]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  162.964346] RIP: 0033:0x7f1e1f1e57df

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 include/linux/sunrpc/xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8ef788ff80b9..aca38bdb0059 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -53,7 +53,7 @@ simple_get_netobj(const void *p, const void *end, struct xdr_netobj *dest)
 	if (IS_ERR(p))
 		return p;
 	q = (const void *)((const char *)p + len);
-	if (unlikely(q > end || q < p))
+	if (unlikely(q > end || q <= p))
 		return ERR_PTR(-EFAULT);
 	dest->data = kmemdup(p, len, GFP_NOFS);
 	if (unlikely(dest->data == NULL))
-- 
2.25.2

