Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9BA75B1DD
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjGTO7s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGTO7r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 10:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B826BF;
        Thu, 20 Jul 2023 07:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C521161B3C;
        Thu, 20 Jul 2023 14:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D27AC433C8;
        Thu, 20 Jul 2023 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689865184;
        bh=NVSj3yPSDNG8YMeRjXuM5Ny9+fxN7LMNYpHVLjFx72A=;
        h=From:Date:Subject:To:Cc:From;
        b=mqjrENq3acvkiIcVa7UsFjqlOitO5Yx++TWzcQXepg+6VMDNsOAuVjfzBG0lhw3K9
         UOLNlYiPZOhAhkXZ99zFaIvF5LF8CbEC/vR6ueuukWPtj0DI7SOM1bv4BhvilI09ii
         DQ47sm8FX8jBD9W3yU1buUsxUZuLxecr0gg4VGNqdCwLO7RkzFJjQ+1+5I7mXlqDuT
         837VshLJod7KL4iCeFWWAumDnHSXskJdM8D5xS+Dg+ZwxNJ2tveLvZSrJMkzC33htS
         ad+eAsXMZtfoVdQAZpB4mCCfyLbkIASyc/pc0ftIAps8xkUpVnShX/9v/dQkemqzLy
         4J9CVf/lEuVrQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 20 Jul 2023 10:59:36 -0400
Subject: [PATCH] nfsd: remove unsafe BUG_ON from set_change_info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-bz2223560-v1-1-edb4900043b8@kernel.org>
X-B4-Tracking: v=1; b=H4sIANhLuWQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyMD3aQqIyMjY1MzA13LZBMzS4NECyND8yQloPqCotS0zAqwWdGxtbU
 Aa9M/xVsAAAA=
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boyang Xue <bxue@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3426; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NVSj3yPSDNG8YMeRjXuM5Ny9+fxN7LMNYpHVLjFx72A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkuUvfqtQRs9W8cy4gVl5V+DKJstR2jCtWUtH0u
 Yb9HJ9SZjKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLlL3wAKCRAADmhBGVaC
 FXJSD/4sTrUQSJc0MjP9DJ7Ahlc4Vx+QRnsayixlawXrrFefhFRw7j6OGyxcpaeCHMeVZEMW4EY
 bzl8jWec+LNIt68AWDFon/XNK7NYoycu8bbs+9nSqV4GelYDf/Qg7PHYhfBuAucwN/K/AYz0Xut
 4soQT9hCqbfCbTAZQ3saxfmlt76onLArmBflc+AKpX+cp2HQInt4zw4tLzH/8CQE1fhbfsLm2oA
 XgTWqbdt8lKScICaSegqK2BDIpFNOTNVa6umYpNaZ6IHWF9eD0NdDv4YMt/Ylkv6IO6GdkLkugc
 ZNuUarm2SMECIQQnJ72KbwTH+S9LJzQPkp5vAqjwj3o9MzDL2N2sFC0vqYfpydFMH7TxNcKNwDy
 zEK5X2d4gYWbx9EeOoAGpGXEhQdof/KTnicgyMQaCx46nlz4nmaEKIVQIPAIfriKcoj5gRcu1wS
 xl/ix47Kflrx1CqbWmHY/ZaeMhxw4jl/+JyhkoHvLZALIyl7J56TBkHjIsvXImlBOhM9JymG8yG
 JYWAFjcaTGUeIlb0Qo3nqA4HYB8Btp86834TqxhRt7rDfFuIfBjhpsYvuVAHz/2IYulkuXXGvHJ
 weUigdN/D9X2HDPM3hezv7vMqyhDrBxgFQi5lHLFYTpIzlTlUG8oexpf/WRm5JiYGf4/9gvNSfN
 z8GhGwajY07/+Rg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

At one time, nfsd would scrape inode information directly out of struct
inode in order to populate the change_info4. At that time, the BUG_ON in
set_change_info made some sense, since having it unset meant a coding
error.

More recently, it calls vfs_getattr to get this information, which can
fail. If that fails, fh_pre_saved can end up not being set. While this
situation is unfortunate, we don't need to crash the box.

Move set_change_info to nfs4proc.c since all of the callers are there.
Revise the condition for setting "atomic" to also check for
fh_pre_saved. Drop the BUG_ON and make it a WARN_ON, and just have it
zero out both change_attr4s when this occurs.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2223560
Reported-by: Boyang Xue <bxue@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 30 ++++++++++++++++++++++++++++++
 fs/nfsd/xdr4.h     | 11 -----------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d8e7a533f9d2..e6f406f27821 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -380,6 +380,36 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return status;
 }
 
+/**
+ * set_change_info - set up the change_info4 for a reply
+ * @cinfo: pointer to nfsd4_change_info to be populated
+ * @fhp: pointer to svc_fh to use as source
+ *
+ * Many operations in NFSv4 require change_info4 in the reply. This function
+ * populates that from the info that we (should!) have already collected. In
+ * the event that we didn't get any pre-attrs, throw a warning and just
+ * zero out both change_attr4 fields.
+ */
+static void
+set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
+{
+	cinfo->atomic = (u32)(fhp->fh_pre_saved && fhp->fh_post_saved && !fhp->fh_no_atomic_attr);
+
+	/*
+	 * In the event that we couldn't fetch attributes from the
+	 * server for some reason, just zero out the before and after
+	 * change values, after throwing a warning.
+	 */
+	if (WARN_ON_ONCE(!fhp->fh_pre_saved)) {
+		cinfo->before_change = 0;
+		cinfo->after_change = 0;
+		return;
+	}
+
+	cinfo->before_change = fhp->fh_pre_change;
+	cinfo->after_change = fhp->fh_post_change;
+}
+
 static __be32
 do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh **resfh)
 {
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index b2931fdf53be..9e67f63c5f4d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -775,17 +775,6 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op);
 
 #define NFS4_SVC_XDRSIZE		sizeof(struct nfsd4_compoundargs)
 
-static inline void
-set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
-{
-	BUG_ON(!fhp->fh_pre_saved);
-	cinfo->atomic = (u32)(fhp->fh_post_saved && !fhp->fh_no_atomic_attr);
-
-	cinfo->before_change = fhp->fh_pre_change;
-	cinfo->after_change = fhp->fh_post_change;
-}
-
-
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream *xdr);

---
base-commit: 070f391ca4d48e1750ee6108eb44f751a9e9448e
change-id: 20230720-bz2223560-9c4690a8217b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

