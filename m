Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF543E43A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1Ovd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 10:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231400AbhJ1Ov3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 10:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635432541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpKeiX6rgD07szVAgEz/Tm+mcan/kkRZFrxcz0YR3UE=;
        b=iXglX7b7D7bBazRS1V9aFG9Y1IK0bRtoCCJKK1UDl1MRpj1pyBzkvfqhYpyrmmb1NxWV4F
        1QoFSrA7iT5atvN2Alt710ib1DIHvxeqqBGibdYcBWuW/D70cKwOes7iVGw5cj/cdy/Z2r
        p1gTI0D04DH1FfXtPZ9uiPVEKrjzw1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-g1q8U6GDOw6zpXiehkilZQ-1; Thu, 28 Oct 2021 10:48:54 -0400
X-MC-Unique: g1q8U6GDOw6zpXiehkilZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E8EEBAF82
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:48:53 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-114-186.phx2.redhat.com [10.3.114.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E809D19D9F
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:48:52 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/1] nfsd4_copy: Adds the ability to do inter server to server on an export
Date:   Thu, 28 Oct 2021 10:48:51 -0400
Message-Id: <20211028144851.644018-2-steved@redhat.com>
In-Reply-To: <20211028144851.644018-1-steved@redhat.com>
References: <20211028144851.644018-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This adds the 's2sc' export option allowing inter server
to server copies on the destination server.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 fs/nfsd/nfs4proc.c               | 3 ++-
 include/uapi/linux/nfsd/export.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 486c5dba4b65..df3ca5f7f86f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1654,9 +1654,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_copy *copy = &u->copy;
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
+	int s2sc = (cstate->current_fh.fh_export->ex_flags & NFSEXP_S2SC);
 
 	if (!copy->cp_intra) { /* Inter server SSC */
-		if (!inter_copy_offload_enable || copy->cp_synchronous) {
+		if (s2sc == 0 && (!inter_copy_offload_enable || copy->cp_synchronous)) {
 			status = nfserr_notsupp;
 			goto out;
 		}
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index 2124ba904779..53ba8d989689 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -53,6 +53,7 @@
  */
 #define	NFSEXP_V4ROOT		0x10000
 #define NFSEXP_PNFS		0x20000
+#define NFSEXP_S2SC		0x40000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
 #define NFSEXP_ALLFLAGS		0x3FEFF
-- 
2.31.1

