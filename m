Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016A465B57C
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjABRFf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjABRFf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:05:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF81B86F
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:05:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19B160018
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD4CC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679132;
        bh=CS8aio7Ovgfw9jobnM0EAIGPAylSV5/miggRu7ZJHrM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=jutxukQpp3KHMy26KLWlJE7rUNpKhUYDIIJJllZu/3Wc4aY2153SKxjt91lba8TzN
         G+xha30WsTOu/9YLx15tpxGIaobYOF1YVomLuZzA1M/YnT0NOrl9ejeOAlhPWRBX9d
         OS1oegMyc3onwjkaz0HTsmk9q6ivD8+FHSlg/NUqE9eSkJ0+wvAlb9Y6fwRq6D2nR6
         xKsayfkaLGNXloLh9WzRU2cKb7TZcge1M9/IfOsYBAfNwe/KU8P8deNknW6kpgQB0C
         LIcgzCXjnr0KzKzMxySRj5jNkkd8wfG3Ie9chDJGi+AJTtIxJCWf24D3U5mwBVqviD
         gF9r5kGQtkgzA==
Subject: [PATCH v1 01/25] SUNRPC: Push svcxdr_init_decode() into
 svc_process_common()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:05:30 -0500
Message-ID: <167267913075.112521.8824598052324769614.stgit@manet.1015granger.net>
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Now that all vs_dispatch functions invoke svcxdr_init_decode(), it
is common code and can be pushed down into the generic RPC server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c        |    1 -
 fs/nfs/callback_xdr.c |    1 -
 fs/nfsd/nfssvc.c      |    1 -
 net/sunrpc/svc.c      |    1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 59ef8a1f843f..e56d85335599 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -695,7 +695,6 @@ static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
 
-	svcxdr_init_decode(rqstp);
 	if (!procp->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index d0cccddb7d08..46d3f5986b4e 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -984,7 +984,6 @@ nfs_callback_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
 
-	svcxdr_init_decode(rqstp);
 	svcxdr_init_encode(rqstp);
 
 	*statp = procp->pc_func(rqstp);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 56fba1cba3af..5375a28b102a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1040,7 +1040,6 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
 
-	svcxdr_init_decode(rqstp);
 	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 85f0c3cfc877..96806c3c61a5 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1302,6 +1302,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	if (progp == NULL)
 		goto err_bad_prog;
 
+	svcxdr_init_decode(rqstp);
 	rpc_stat = progp->pg_init_request(rqstp, progp, &process);
 	switch (rpc_stat) {
 	case rpc_success:


