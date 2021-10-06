Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674564243D2
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhJFRSo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 13:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhJFRSn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 13:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633540611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2Y4eQKCGMlkQkSt3y/8+c1KH4dOiH7+fhTB1mD+8Qs=;
        b=Er5+Nhb+jvtRwne9qkrZJ12WGzMG4WILJpuX9rwpNThJxvwvx8bheYcui+D17QY/lD1OZn
        f4vlSjSaUNl/aYFW3d3wlMWTpi50RvMpylWs+UT5R1awNvpqb2kHx3rrbTIntKsD0hAlCB
        FF8ZHvvbBL38Hf0g8n/7IuLit+MOwRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-EJrTy5hrOzOYsnpO56NEtQ-1; Wed, 06 Oct 2021 13:16:48 -0400
X-MC-Unique: EJrTy5hrOzOYsnpO56NEtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 881FB835DE4;
        Wed,  6 Oct 2021 17:16:47 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EA6D60657;
        Wed,  6 Oct 2021 17:16:47 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id DE95D1043453; Wed,  6 Oct 2021 13:16:46 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Keep existing listners on portlist error
Date:   Wed,  6 Oct 2021 13:16:46 -0400
Message-Id: <74ed9f09bc3e3efbc70ff0414fb13c533b810a20.1633540569.git.bcodding@redhat.com>
In-Reply-To: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
References: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If nfsd has existing listening sockets without any processes, then an error
returned from svc_create_xprt() for an additional transport will remove
those existing listeners.  We're seeing this in practice when userspace
attempts to create rpcrdma transports without having the rpcrdma modules
present before creating nfsd kernel processes.  Fix this by checking for
existing sockets before callingn nfsd_destroy().

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfsd/nfsctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c2c3d9077dc5..696a217255fc 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -793,7 +793,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	nfsd_destroy(net);
+	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
+		nn->nfsd_serv->sv_nrthreads--;
+	 else
+		nfsd_destroy(net);
 	return err;
 }
 
-- 
2.30.2

