Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB978DF8B
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 22:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjH3UEy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 16:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbjH3UEK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 16:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE34ED6
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693424500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HrzYYf/XZbSPx0ZRpTT3F2/naN0tf+Zt3qA2lcpgW6w=;
        b=Y2UYYjE/fbblSwlb17mrVxrATqK6FCkE0YbZOyfHkrzgVp4MkmTnW3EF+lBEGJfQzBzs4z
        LTHbq/Lzo09lMxOouCAQNkIaBdg2UlRkGSXSAdvSn+eTk6cky/fRU3rpDK8IxxKKrS4B5b
        iWu3oTSf6/HiuNUJmPjxCLdyKrL/Vpw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-WImT6Bv6ND-0bE4N_4nlMA-1; Wed, 30 Aug 2023 15:38:23 -0400
X-MC-Unique: WImT6Bv6ND-0bE4N_4nlMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93BF41C04357;
        Wed, 30 Aug 2023 19:38:22 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F8EF63F7A;
        Wed, 30 Aug 2023 19:38:21 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, jlayton@kernel.org
Subject: [PATCH] NFSv4: Always ask for type with READDIR
Date:   Wed, 30 Aug 2023 15:38:21 -0400
Message-Id: <ebc91231748a42cd72ee4e9d8f82ea0d42153b34.1693424222.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Again we have claimed regressions for walking a directory tree, this time
with the "find" utility which always tries to optimize away asking for any
attributes until it has a complete list of entries.  This behavior makes
the readdir plus heuristic do the wrong thing, which causes a storm of
GETATTRs to determine each entry's type in order to continue the walk.

For v4 add the type attribute to each READDIR request to include it no
matter the heuristic.  This allows a simple `find` command to proceed
quickly through a directory tree.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..3c583e055689 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1602,7 +1602,7 @@ static void encode_read(struct xdr_stream *xdr, const struct nfs_pgio_args *args
 static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
 {
 	uint32_t attrs[3] = {
-		FATTR4_WORD0_RDATTR_ERROR,
+		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
 		FATTR4_WORD1_MOUNTED_ON_FILEID,
 	};
 	uint32_t dircount = readdir->count;
-- 
2.40.1

