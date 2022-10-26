Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0460DCDE
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 10:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiJZIPr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiJZIPp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 04:15:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ED67AC29
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 01:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42645B82143
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 08:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74921C433C1;
        Wed, 26 Oct 2022 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666772141;
        bh=MEgvs+JJcXtyuKy8yCPU/2WQ5A6TlZb2ufpEIO7cOsI=;
        h=From:To:Cc:Subject:Date:From;
        b=Y0ZIvO2KWcw9vjfshznNb+L5SY8LzTho7fY8dKAUc6G9fW46k0yRLEc/bNJKkDsxc
         +A5Mi9+htPBwCk5nWkUmb+DhHi46y7rUcNHDCiDxwAJNIkDQY7v1AYuk94FHKWGuGd
         YUk34Q4CHY93Ua84ne/MCzrfEeTFXQb9ptWvCMVvIkKl2LACHQgoaolxSB5wlWoS0C
         zWwnHaTXZNikX4/0r7K+Q9Py5TYhzXI2TTxjUPTHtD7ExMZ8mPbfA5W3Cj7G88uS+5
         8aLBImIg3V8ZH/Em+hYM4fQlvUd9QJbEG5hOglQGc7ToCjhjg3oXH6XoZUMeL8NFuM
         Zom9OepWd4qww==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: make "gc" parameter a bool
Date:   Wed, 26 Oct 2022 04:15:38 -0400
Message-Id: <20221026081539.219755-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This gets compared to the result of test_bit which may or may not always
exactly match what the bitfield holds. Bitfields in C can be unintuitive
to deal with. Make it a bool instead. This doesn't change the size of
the struct anyway.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 106e99b24b6f..918d67cec1ad 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -63,7 +63,7 @@ struct nfsd_file_lookup_key {
 	struct net			*net;
 	const struct cred		*cred;
 	unsigned char			need;
-	unsigned char			gc:1;
+	bool				gc;
 	enum nfsd_file_lookup_type	type;
 };
 
@@ -1034,7 +1034,7 @@ nfsd_file_is_cached(struct inode *inode)
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf,
-		     bool open, int want_gc)
+		     bool open, bool want_gc)
 {
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_FULL,
@@ -1161,7 +1161,7 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 1);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
 }
 
 /**
@@ -1182,7 +1182,7 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 0);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
 }
 
 /**
-- 
2.37.3

