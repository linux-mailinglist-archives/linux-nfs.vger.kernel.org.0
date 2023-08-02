Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793BB76D734
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 20:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjHBSyM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 14:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjHBSyD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 14:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12B82701;
        Wed,  2 Aug 2023 11:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E9561AB0;
        Wed,  2 Aug 2023 18:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07A4C433C7;
        Wed,  2 Aug 2023 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691002397;
        bh=TvgIJlHzFWDffomtHVsmKn5zC5v3OVkVeJam/u/ReGY=;
        h=From:Date:Subject:To:Cc:From;
        b=mRze6LWQqphoK2Pr7ODLQ68f2QZHF/K90CGSQUcur+5dzicbVIP7GtMESk4qQn0vU
         emEAcoVLHAYY9XWHCtBGOqFmOSEYF0pN/wepjDbSqFhALK+M/xmp2AOnv9CuGp+5sW
         M3cI8z5nn/S76EKnX07RWOVMKAGzVJbg87OHmHwyF6/dmRW9haYBZu9UlpGqw5ChY9
         EKAsHnV8xz/dJ7ULXTkfHw4jSeewPKXDvkWyAT1yO7R4yZwDFx7q80jqdotM88m1b7
         uVRl92tRTo5E156O96A9cjGtphn/CLSSmccPYwnzylqLwC6GtaLsZDJcjR2iqeGM54
         jD7pWU61A0Dow==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 02 Aug 2023 14:53:00 -0400
Subject: [PATCH v3] nfsd: don't hand out write delegations on O_WRONLY
 opens
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-wdeleg-v3-1-d7cd1d696045@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAumymQC/2WMQQ6CMBBFr0JmbU1nCkhceQ/jgikDNBIwrakaw
 t0tbIhx+X7+ezME8U4CnLMZvEQX3DQmMIcMbF+PnSjXJAbSZPTJoHo1MkinmBsumYra2BLS+eG
 lde8tdL0l7l14Tv6zdSOu618iokLVVq2gFUQ25eUufpThOPkO1kak3av07lHySFvMqSCuOf/xl
 mX5AtjFDnvVAAAA
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4270; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TvgIJlHzFWDffomtHVsmKn5zC5v3OVkVeJam/u/ReGY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkyqYY70ujOe+WDZ5WtkzxThP97DCMC+KbsNdUd
 kMjE5a5L6yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZMqmGAAKCRAADmhBGVaC
 FQ/sD/46vC+P5i0iV3hoSC8Yl7Fs+tSnHPH25PhUwOLvzsvCJgtJyu6vudsEs9n4eZ89hayUJBp
 ducx/hwrbI+WJ5aIMxYf7rOvIjsLjv/BF558Eaw6qyhq1ie9Cfq802Z/FxcYa5oIrtxNuC5b6RE
 MO/0wOK1FGNW6VxTATjdq/IY11hu6f1z2m2cP1qbQMqQAmP3qAw9n+hL8k4aUu4FxQ4P+Ls/5xy
 o8a2Ym8USMoQEJeP6EiqD501IHcSr93CPhfSFofQ70M29+sIPPwjMUA/7isCIZPkWchOc8Wsb5A
 0DPjtSb/eYgTjG1xxYgeuS4VfeUtXY5tm9f3syGOIeNL2pp3ma2o8T22blMDiaux841Qmsbu4Ug
 V6WCR5MljL1WFeZJVIrBdMoZOdXz2qVSaFw/3hAsvor/2Q8Ztm0SgMzLPsxkkmnDQBugs1O53B/
 h/G2Tov5udfjtseIz+lxp+/OewvCjtHUbRnlXQXueCxL8K5VmnzsfgVC+821yPKlYPFurAwkZ78
 twz5unRnetfBHM7lvHSLOv5JW74ZOOenCL0pJPgATNGBgfmB5GmdULxFcOwc3a6kDiTd/nayDcG
 En9TEdUz2NMq6kIhQg+zHA8mcTR3uAhBmrQrlIaJUUNijQ7x/G2xWGi5btsf7TVURIV+/k1aYOQ
 8GUFgb2dIOMCHWQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I noticed that xfstests generic/001 was failing against linux-next nfsd.

The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
would hand out a write delegation. The client would then try to use that
write delegation as the source stateid in a COPY or CLONE operation, and
the server would respond with NFS4ERR_STALE.

The problem is that the struct file associated with the delegation does
not necessarily have read permissions. It's handing out a write
delegation on what is effectively an O_WRONLY open. RFC 8881 states:

 "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
  own, all opens."

Given that the client didn't request any read permissions, and that nfsd
didn't check for any, it seems wrong to give out a write delegation.

Only hand out a write delegation if we have a O_RDWR descriptor
available. If it fails to find an appropriate write descriptor, go
ahead and try for a read delegation if NFS4_SHARE_ACCESS_READ was
requested.

This fixes xfstest generic/001.

Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- add find_rw_file helper to ensure spinlock is taken appropriately
- refine comments over conditionals
- Link to v2: https://lore.kernel.org/r/20230801-wdeleg-v2-1-20c14252bab4@kernel.org

Changes in v2:
- Rework the logic when finding struct file for the delegation. The
  earlier patch might still have attached a O_WRONLY file to the deleg
  in some cases, and could still have handed out a write delegation on
  an O_WRONLY OPEN request in some cases.
---
 fs/nfsd/nfs4state.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ef7118ebee00..c551784d108a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -649,6 +649,18 @@ find_readable_file(struct nfs4_file *f)
 	return ret;
 }
 
+static struct nfsd_file *
+find_rw_file(struct nfs4_file *f)
+{
+	struct nfsd_file *ret;
+
+	spin_lock(&f->fi_lock);
+	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
+	spin_unlock(&f->fi_lock);
+
+	return ret;
+}
+
 struct nfsd_file *
 find_any_file(struct nfs4_file *f)
 {
@@ -5449,7 +5461,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
-	struct nfsd_file *nf;
+	struct nfsd_file *nf = NULL;
 	struct file_lock *fl;
 	u32 dl_type;
 
@@ -5461,21 +5473,35 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		return ERR_PTR(-EAGAIN);
 
-	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		nf = find_writeable_file(fp);
+	/*
+	 * Try for a write delegation first. RFC8881 section 10.4 says:
+	 *
+	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
+	 *   on its own, all opens."
+	 *
+	 * Furthermore the client can use a write delegationf or most read
+	 * operations as well, so we require a O_RDWR file here.
+	 *
+	 * Only a write delegation in the case of a BOTH open, and ensure
+	 * we get the O_RDWR descriptor.
+	 */
+	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
+		nf = find_rw_file(fp);
 		dl_type = NFS4_OPEN_DELEGATE_WRITE;
-	} else {
+	}
+
+	/*
+	 * If the file is being opened O_RDONLY or we couldn't get a O_RDWR
+	 * file for some reason, then try for a read deleg instead.
+	 */
+	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
 		nf = find_readable_file(fp);
 		dl_type = NFS4_OPEN_DELEGATE_READ;
 	}
-	if (!nf) {
-		/*
-		 * We probably could attempt another open and get a read
-		 * delegation, but for now, don't bother until the
-		 * client actually sends us one.
-		 */
+
+	if (!nf)
 		return ERR_PTR(-EAGAIN);
-	}
+
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))

---
base-commit: a734662572708cf062e974f659ae50c24fc1ad17
change-id: 20230731-wdeleg-bbdb6b25a3c6

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

