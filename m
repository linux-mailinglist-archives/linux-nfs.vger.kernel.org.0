Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF96952CE
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 22:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBMVNv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 16:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMVNu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 16:13:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9091CAED
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 13:13:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B787D612A8
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 21:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A01C4339B;
        Mon, 13 Feb 2023 21:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676322828;
        bh=N1ZsLV4nkDU5i8watIYfLBdgua0bzrrGe1GKXvBTobo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5pxs3ZdMFj5cGfz5k7TbjGIew7nzinP6AuufyzDDI6hjh8MZq1s86Bn7FAZxz/NM
         KN17Nw52btVWusOzekWyI+rNndGCwn91nZ1k21ZzsV8NZfQmdeGZwO8L0NJEw+dkLk
         PljFl9Bm11Qsr54wv4YNB0NvhgQkQdg3cr+d2MC34/mBK125pAGgVs8koT9MsyZzZm
         J1GNX04WGbE3II1l0V6xkUvBFxjeozQseSfgcjBYjSjvOjMlFlkQfd/b67+dnvPbZq
         j/6b4f2UzLrinRic2RE1oe3mfMsNjqLBvLOBv2By0RyeoUO+JgH0Sa0c01VMZPEYpj
         eag013ElFUXvA==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, chuck.lever@oracle.com
Cc:     willy@infradead.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] nfsd: copy the whole verifier in nfsd_copy_write_verifier
Date:   Mon, 13 Feb 2023 16:13:43 -0500
Message-Id: <20230213211345.385005-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213211345.385005-1-jlayton@kernel.org>
References: <20230213211345.385005-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, we're only memcpy'ing the first __be32. Ensure we copy into
both words.

Fixes: 91d2e9b56cf5 (NFSD: Clean up the nfsd_net::nfssvc_boot field)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fe5e4f73bb98..3a38ab304b02 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -363,7 +363,7 @@ void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
 
 	do {
 		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
-		memcpy(verf, nn->writeverf, sizeof(*verf));
+		memcpy(verf, nn->writeverf, sizeof(*verf) * 2);
 	} while (need_seqretry(&nn->writeverf_lock, seq));
 	done_seqretry(&nn->writeverf_lock, seq);
 }
-- 
2.39.1

