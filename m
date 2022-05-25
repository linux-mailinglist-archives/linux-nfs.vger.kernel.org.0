Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901C65340A2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 May 2022 17:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbiEYPr4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 May 2022 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbiEYPr4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 May 2022 11:47:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844634649
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 08:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E55EB81C3B
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 15:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C17C385B8
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 15:47:52 +0000 (UTC)
Subject: [PATCH v3 4/4] NFSD: nfsd_file_put() can sleep
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 25 May 2022 11:47:51 -0400
Message-ID: <165349367176.4205.10498843571683722925.stgit@bazille.1015granger.net>
In-Reply-To: <165349272692.4205.8499763565429173274.stgit@bazille.1015granger.net>
References: <165349272692.4205.8499763565429173274.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that there are no more callers of nfsd_file_put() that might
hold a spin lock, ensure the lockdep infrastructure can catch
newly introduced calls to nfsd_file_put() made while a spinlock
is held.

Link: https://lore.kernel.org/linux-nfs/ece7fd1d-5fb3-5155-54ba-347cfc19bd9a@oracle.com/T/#mf1855552570cf9a9c80d1e49d91438cd9085aada
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a7e3a443a2cb..d32fcd8ad457 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -302,6 +302,8 @@ nfsd_file_put_noref(struct nfsd_file *nf)
 void
 nfsd_file_put(struct nfsd_file *nf)
 {
+	might_sleep();
+
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0) {
 		nfsd_file_flush(nf);


