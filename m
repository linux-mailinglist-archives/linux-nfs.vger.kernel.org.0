Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5498F7E7FD2
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 18:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjKJR7x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 12:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjKJR7O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 12:59:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7963E424
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 08:28:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F3FC433C7
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699633714;
        bh=zB4gtgeUsd/z45jK1/biV1ZJOlO8IUzHXhr8gB075RM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=fSgd2zBp23Y4Tu8qyWosCiAYRFyCQBVOGaI1Khe1L4RSoE0jWBOXuHA27KQLZkcBr
         1dJjW8lQXxyEDsIBbrES0RutG0k2NIbl8+fJSf0+rwlFXXQG9LHwazNG27IoDnh4DD
         aLxF38G9F5aWL9VOfEluCKM02g2QedbntC74fTOcKXYzitsZrQFhtYWF7Oikr7tTgw
         MNzgY9PeSpoYk2st57X74Yf0vZcjn7fH5s+Yn6jQ4HcYF6MHghPISvmMZ5dLcno2ch
         BR9KmtUy+kCO5zL1BguYAul1ZVSyKJlPxq1hjd9jQFqi4jl8BdPZ7VydIdAcAm7mHm
         NUr8oGxnakC3Q==
Subject: [PATCH v2 1/3] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 10 Nov 2023 11:28:33 -0500
Message-ID: <169963371324.5404.3057239228897633466.stgit@bazille.1015granger.net>
In-Reply-To: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
References: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The "statp + 1" pointer that is passed to nfsd_cache_update() is
supposed to point to the start of the egress NFS Reply header. In
fact, it does point there for AUTH_SYS and RPCSEC_GSS_KRB5 requests.

But both krb5i and krb5p add fields between the RPC header's
accept_stat field and the start of the NFS Reply header. In those
cases, "statp + 1" points at the extra fields instead of the Reply.
The result is that nfsd_cache_update() caches what looks to the
client like garbage.

A connection break can occur for a number of reasons, but the most
common reason when using krb5i/p is a GSS sequence number window
underrun. When an underrun is detected, the server is obliged to
drop the RPC and the connection to force a retransmit with a fresh
GSS sequence number. The client presents the same XID, it hits in
the server's DRC, and the server returns the garbage cache entry.

The "statp + 1" argument has been used since the oldest changeset
in the kernel history repo, so it has been in nfsd_dispatch()
literally since before history began. The problem arose only when
the server-side GSS implementation was added twenty years ago.

This particular patch applies cleanly to v6.5 and later, but needs
some context adjustment to apply to earlier kernels. Before v5.16,
nfsd_dispatch() does not use xdr_stream, so saving the NFS header
pointer before calling ->pc_encode is still an appropriate fix
but it needs to be implemented differently.

Cc: <stable@vger.kernel.org> # v5.16+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d6122bb2d167..60aacca2bca6 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -981,6 +981,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
 	struct nfsd_cacherep *rp;
+	__be32 *nfs_reply;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1014,6 +1015,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
 
+	nfs_reply = xdr_inline_decode(&rqstp->rq_res_stream, 0);
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
@@ -1023,7 +1025,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	 */
 	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
 
-	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
+	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, nfs_reply);
 out_cached_reply:
 	return 1;
 


