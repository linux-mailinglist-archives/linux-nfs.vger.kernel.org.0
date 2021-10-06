Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D9423FE9
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhJFOUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 10:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231738AbhJFOUC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 10:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633529889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tzSVNnWn537dzbTNpOX/6VTrA1FAmVdPWRr+u/Ymfnw=;
        b=N6BqtZ0OXzsXV+zPBKG8iS/SpCbCIOhbU5GRI6SN8gUj2a6Dn1f+YTYBfmVwrBotIhfcHY
        j05A6mUZAf+lA9ThXogrvWSMWX883pRbqTvm/y1J7modlZKuSrhCIsi7yRoeRVFLZISO3w
        NzVY3dz3I+M5cpaIb2gKfPmxrsbOd4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-rjmj3xWuPXqygI47Db4KXg-1; Wed, 06 Oct 2021 10:18:07 -0400
X-MC-Unique: rjmj3xWuPXqygI47Db4KXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 072A58015C7;
        Wed,  6 Oct 2021 14:18:06 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C42826091B;
        Wed,  6 Oct 2021 14:18:05 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 2AA7E1043453; Wed,  6 Oct 2021 10:18:05 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Keep existing listners on portlist error
Date:   Wed,  6 Oct 2021 10:18:05 -0400
Message-Id: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index c2c3d9077dc5..df4613a4924c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -793,7 +793,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	nfsd_destroy(net);
+	if (list_empty(&nn->nfsd_serv->sv_permsocks))
+		nfsd_destroy(net);
+	else
+		nn->nfsd_serv->sv_nrthreads--;
 	return err;
 }
 
-- 
2.30.2

