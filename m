Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF07CCF55
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Oct 2023 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJQVbp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Oct 2023 17:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjJQVbm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Oct 2023 17:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429A0F9
        for <linux-nfs@vger.kernel.org>; Tue, 17 Oct 2023 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697578254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oa3tZ8nEmTQ7g03CpQabtkzzRCmD2YRrHZ3zkA1/K5k=;
        b=Aem7lGPgeZQp8hDKfj73p2pHjUbCeix+yOcfiSNWjIzUCcVis1jP4EdSc/6xvedTQT8iVN
        QBhHRrZxEcFKT0kLTM+JrFFU6MS5iNS4buB7E71kTPagJrQvTGBOSelNKmrIE8O0mJwVLY
        igpL/CfAkHpvDM6o/nRF5L6NX5zr1NM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-9wwN7e38PrmpYOcQZYWQXA-1; Tue, 17 Oct 2023 17:30:46 -0400
X-MC-Unique: 9wwN7e38PrmpYOcQZYWQXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C02C1185A797;
        Tue, 17 Oct 2023 21:30:45 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408A9C15BB8;
        Tue, 17 Oct 2023 21:30:45 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Always ask for type with READDIR
Date:   Tue, 17 Oct 2023 17:30:43 -0400
Message-ID: <badc4f7fbd63c19a9f50a7c5c17968db16bebf5f.1697577945.git.bcodding@redhat.com>
In-Reply-To: <cover.1697577945.git.bcodding@redhat.com>
References: <cover.1697577945.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..7200d6f7cd7b 100644
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
@@ -1612,7 +1612,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 	unsigned int i;
 
 	if (readdir->plus) {
-		attrs[0] |= FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
+		attrs[0] |= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
 			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
 		attrs[1] |= FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_OWNER|
 			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
-- 
2.41.0

