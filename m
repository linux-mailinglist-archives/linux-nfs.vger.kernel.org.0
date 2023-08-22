Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC178495B
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 20:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjHVSXX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjHVSXX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 14:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D98F11F
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692728561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2GZg9mfSjvtYALh+Cb+HACJnF6G28ckFRqbLrCAax9I=;
        b=aDne66lcNoAerhEu9lNvvi20bgNIvBtQRBZlAdr3SsK3Mp9/LLQKytlj2JTaHLIxnuJxmG
        o2RZVr9k+c2Msjipxy28qxPCs4HsapIAClH8WquaDU+OMgjiEg5FRIG1547qrmAM0Y/qci
        BFyAI6jv2KS3631yNoKa9D4HEtL8lTc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-EM1s4-mJPbeZNPR8kMINIQ-1; Tue, 22 Aug 2023 14:22:39 -0400
X-MC-Unique: EM1s4-mJPbeZNPR8kMINIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F9A83C108CA;
        Tue, 22 Aug 2023 18:22:39 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-2.rdu2.redhat.com [10.22.0.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C77FB2166B26;
        Tue, 22 Aug 2023 18:22:38 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN
Date:   Tue, 22 Aug 2023 14:22:38 -0400
Message-Id: <40e7e63d448698851c301e0c219875178103bc31.1692728474.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 64cfca85bacd asserts the only valid return values for
nfs2/3_decode_dirent should not include -ENAMETOOLONG, but for a server
that sends a filename3 which exceeds MAXNAMELEN in a READDIR response the
client's behavior will be to endlessly retry the operation.

We could map -ENAMETOOLONG into -EBADCOOKIE, but that would produce
truncated listings without any error.  The client should return an error
for this case to clearly assert that the server implementation must be
corrected.

Fixes: 64cfca85bacd ("NFS: Return valid errors from nfs2/3_decode_dirent()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs2xdr.c | 2 +-
 fs/nfs/nfs3xdr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 05c3b4b2b3dd..c19093814296 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -949,7 +949,7 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_filename_inline(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	/*
 	 * The type (size and byte order) of nfscookie isn't defined in
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 3b0b650c9c5a..60f032be805a 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1991,7 +1991,7 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_inline_filename3(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	error = decode_cookie3(xdr, &new_cookie);
 	if (unlikely(error))
-- 
2.40.1

