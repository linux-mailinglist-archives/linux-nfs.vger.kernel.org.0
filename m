Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD62D73B3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 11:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403826AbgLKKPF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 05:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732294AbgLKKOi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Dec 2020 05:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607681592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kgwSr4PAiMbSkQS5fVTvEXAojEXOpIS4aLZExiziWKA=;
        b=L77Yt7sLLmExJ14UAv8yN/H3yUCt8CBd1N5LIRn3/0WRsyeRhXRjQ500sxgiSMi8EBWT3n
        pgZlzGrzLCSdl+PwEC85klAj9Q3OpPklI3Zi+3jANOSSZyrWhesMwEJz4G7pTEUrCwW+9R
        UKFqtUBI0eCCsDPJgzGgAcFQRCzz7jI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-ggoy94WhNdSPcNuRCx6s7A-1; Fri, 11 Dec 2020 05:13:11 -0500
X-MC-Unique: ggoy94WhNdSPcNuRCx6s7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C998049C9;
        Fri, 11 Dec 2020 10:13:09 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-119-199.rdu2.redhat.com [10.10.119.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B63FD10013C0;
        Fri, 11 Dec 2020 10:13:08 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS4: Fix use-after-free in trace_event_raw_event_nfs4_set_lock
Date:   Fri, 11 Dec 2020 05:12:51 -0500
Message-Id: <1607681571-10202-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is only safe to call the tracepoint before rpc_put_task() because
'data' is freed inside nfs4_lock_release (rpc_release).

Fixes: 48c9579a1afe ("Adding stateid information to tracepoints")
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d23edbc36803..6bf0457032c7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7110,9 +7110,9 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 					data->arg.new_lock_owner, ret);
 	} else
 		data->cancelled = true;
+	trace_nfs4_set_lock(fl, state, &data->res.stateid, cmd, ret);
 	rpc_put_task(task);
 	dprintk("%s: done, ret = %d!\n", __func__, ret);
-	trace_nfs4_set_lock(fl, state, &data->res.stateid, cmd, ret);
 	return ret;
 }
 
-- 
1.8.3.1

