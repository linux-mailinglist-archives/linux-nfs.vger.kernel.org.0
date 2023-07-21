Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D02875CA06
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGUO3V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGUO3U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 10:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC61E68;
        Fri, 21 Jul 2023 07:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103B161CDE;
        Fri, 21 Jul 2023 14:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B311BC433C7;
        Fri, 21 Jul 2023 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949758;
        bh=n5CM7X3lN74+RyydF842JksyHcy3Wi22/2HsBm0XHug=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=eM1PESOg5xMGMQaVB7l97rvozA/NGL2jli8sDbORbMwaqJIc6jMzUKBHHQx1EtFo6
         hQYvt5GWeXmG30IRgrSon1Sm6paEtGn+f6yXdEFm94zvOATHfyXgCjhLbWQQxBE9jX
         37O+FAD8F7ki2cs7Rr8q7O+YIFkp70M+hTt20XPf8frZWCl7C9a9Ykey18y3adYpH8
         jiD9Dy1UtpZgCgOUTqKI5HfoKtXdA40K8vlfzE6pGqMiaOb/7/U+5GvaaNfaqyfBzA
         cUVAv2zhkS2B/6AYbgwaa4nrAPJlw0cN4/pye1F54VZyglzxOP/PPhtlG8AKWrPZk0
         br8pnq5BTD5uw==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 21 Jul 2023 10:29:11 -0400
Subject: [PATCH v3 2/2] nfsd: remove unsafe BUG_ON from set_change_info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-bz2223560-v3-2-bb57e302bab7@kernel.org>
References: <20230721-bz2223560-v3-0-bb57e302bab7@kernel.org>
In-Reply-To: <20230721-bz2223560-v3-0-bb57e302bab7@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Boyang Xue <bxue@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3480; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=n5CM7X3lN74+RyydF842JksyHcy3Wi22/2HsBm0XHug=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkupY7P/EQhQx0cLkz0dwczVoxvUEnc6+CSgZzW
 j0jrAvv4kqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLqWOwAKCRAADmhBGVaC
 FUOGD/9WfQyqmzYlBzNM3CcAxjJYoeQATI72bqz1Ro3NcJ5P+eoaNx+m6LMcI6NTk6xekuBTxKX
 TdOQ5smFiBBfDYSDYom7MJyH8qGTzDmR6EeuiW0xTBTHvfLd4CjHDpjgWtDHHjCwPs8OrJ7bJzu
 27Yo7rfyEleWB8/utCZWiYoXMpqH04ndieR5A5WUWOCxUuQ1SXOTSdYCXpUuUGGX/JKB+fEAgYs
 26g3mgxSP3T8UbDy9ykAarejEZGjqTjUshvUCY4cpvYqkN6Bsn2TQE9UM8mDsS3KibXtQ8pJHPF
 loL64gwt+CkbUJoUVbkuh2YpKCHbxvFBoeTOre3K66x6SkfpcYFDUlxzLrScoeMnvaF+PhZiP5q
 s8eyGupKvZNHOlqwlAEs/sVZchc7vAkwAPRdjofl78+s+S45LupZLUO5+t//fMjJqG28ldAtkd6
 KSIVkIzmzqjyq/t8yPLJfW2WXOBcsd05gklfTsyufDYua4vrpBFaVNiBjThjvGj+2sVMMCqE6L8
 ufnyA1PgCaeckHttJyTUMaMWSc7ami+h31JRyFfDpjgADX9K3FM4in5hTxk116MJVFO8v0fOwJd
 5MVQJhpcZV1+Fsi9LemvWr7K8D4KuhhEKPxgMv9fgdsN+IO5DY7S2QF6uxB0pZhIKypCCQjdL9E
 eqTHmjMjfVY8YRA==
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
fh_pre_saved. Drop the BUG_ON and and just have it zero out both
change_attr4s when this occurs.

Reported-by: Boyang Xue <bxue@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2223560
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 32 ++++++++++++++++++++++++++++++++
 fs/nfsd/xdr4.h     | 11 -----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9285e1eab4d5..3f6710c9c5c9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -382,6 +382,38 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return status;
 }
 
+/**
+ * set_change_info - set up the change_info4 for a reply
+ * @cinfo: pointer to nfsd4_change_info to be populated
+ * @fhp: pointer to svc_fh to use as source
+ *
+ * Many operations in NFSv4 require change_info4 in the reply. This function
+ * populates that from the info that we (should!) have already collected. In
+ * the event that we didn't get any pre-attrs, just zero out both.
+ */
+static void
+set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
+{
+	cinfo->atomic = (u32)(fhp->fh_pre_saved && fhp->fh_post_saved && !fhp->fh_no_atomic_attr);
+	cinfo->before_change = fhp->fh_pre_change;
+	cinfo->after_change = fhp->fh_post_change;
+
+	/*
+	 * If fetching the pre-change attributes failed, then we should
+	 * have already failed the whole operation. We could have still
+	 * failed to fetch post-change attributes however.
+	 *
+	 * If we didn't get post-op attrs, just zero-out the after
+	 * field since we don't know what it should be. If the pre_saved
+	 * field isn't set for some reason, throw warning and just copy
+	 * whatever is in the after field.
+	 */
+	if (WARN_ON_ONCE(!fhp->fh_pre_saved))
+		cinfo->before_change = 0;
+	if (!fhp->fh_post_saved)
+		cinfo->after_change = 0;
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

-- 
2.41.0

