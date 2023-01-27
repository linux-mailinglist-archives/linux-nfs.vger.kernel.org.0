Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE31F67EAAB
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjA0QT5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 11:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjA0QTt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 11:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365945228
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 08:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674836340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oBD82ET37hayPo7F26/s85pvG/4hY3FyJGCUmHt9Ieo=;
        b=CWcYoOEf9uxFZ5j10zIZfFQAT1XG4Ku3OYTuHyerZzbnJeaKhW/hj6o0BnKTVVZPxO7hGM
        lFNhPJSNFLG+svTSPcCoh8I7i8T9RDalA6FYgYBelVJDE3RaOd5arUG2ic9vKoHE24Amdz
        tDk4gW5DKQ1KSOT1rno0ZrxRgwbnzWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-UqvVfd-rPFep_I0r2CWfvA-1; Fri, 27 Jan 2023 11:18:57 -0500
X-MC-Unique: UqvVfd-rPFep_I0r2CWfvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FEBD1991C42;
        Fri, 27 Jan 2023 16:18:57 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C8C87AD4;
        Fri, 27 Jan 2023 16:18:57 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 83BF310C30E1; Fri, 27 Jan 2023 11:18:56 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix race to check ls_layouts
Date:   Fri, 27 Jan 2023 11:18:56 -0500
Message-Id: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Its possible for __break_lease to find the layout's lease before we've
added the layout to the owner's ls_layouts list.  In that case, setting
ls_recalled = true without actually recalling the layout will cause the
server to never send a recall callback.

Move the check for ls_layouts before setting ls_recalled.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfsd/nfs4layouts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 3564d1c6f610..e8a80052cb1b 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -323,11 +323,11 @@ nfsd4_recall_file_layout(struct nfs4_layout_stateid *ls)
 	if (ls->ls_recalled)
 		goto out_unlock;
 
-	ls->ls_recalled = true;
-	atomic_inc(&ls->ls_stid.sc_file->fi_lo_recalls);
 	if (list_empty(&ls->ls_layouts))
 		goto out_unlock;
 
+	ls->ls_recalled = true;
+	atomic_inc(&ls->ls_stid.sc_file->fi_lo_recalls);
 	trace_nfsd_layout_recall(&ls->ls_stid.sc_stateid);
 
 	refcount_inc(&ls->ls_stid.sc_count);
-- 
2.31.1

