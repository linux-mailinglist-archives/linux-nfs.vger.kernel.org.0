Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5942467E4DE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 13:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjA0MOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 07:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjA0MOc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 07:14:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5396E84195
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 04:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FE4FB820BC
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 12:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC8AC433EF;
        Fri, 27 Jan 2023 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674821375;
        bh=rWvNdCb8M9M/Ismtnd4J+QmPNpFMDkcXzEkPnJvPOJw=;
        h=From:To:Cc:Subject:Date:From;
        b=gkx9eoGHd+zelmYCPHj2583HDOg7jN2CRifpXuky73qs6DTT0q/C2XdVvb5ZwZE03
         EAU7H0dsVNPQ4WI20bVmZ52CLMzTWHcEssDjxxUvFSuPJth2g1Idr3cOj/lqB67+xt
         YfVvoZRC22X1aRJw3wNDsDy0ulp6ccw9CpUd6ZR1mfA6uYP2VbvaBFNYp4oYyYpOF9
         V8FLJLZ3n08WOWM8nXa6k3KA3Z5ZmGImRHlJDh3mjsUO9B8wDH53DY965AshLzAg2x
         Y+KQR9Wstqgrnj2NGAov6r3egsdFKo7o3YssZ6GY2xa0AfSm6DZSp/cVxijn1PPqVi
         4yl6NCzzpBmhg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Boyang Xue <bxue@redhat.com>
Subject: [PATCH] nfsd: don't hand out delegation on setuid files being opened for write
Date:   Fri, 27 Jan 2023 07:09:33 -0500
Message-Id: <20230127120933.7056-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
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

We had a bug report that xfstest generic/355 was failing on NFSv4.0.
This test sets various combinations of setuid/setgid modes and tests
whether DIO writes will cause them to be stripped.

What I found was that the server did properly strip those bits, but
the client didn't notice because it held a delegation that was not
recalled. The recall didn't occur because the client itself was the
one generating the activity and we avoid recalls in that case.

Clearing setuid bits is an "implicit" activity. The client didn't
specifically request that we do that, so we need the server to issue a
CB_RECALL, or avoid the situation entirely by not issuing a delegation.

The easiest fix here is to simply not give out a delegation if the file
is being opened for write, and the mode has the setuid and/or setgid bit
set. Note that there is a potential race between the mode and lease
being set, so we test for this condition both before and after setting
the lease.

This patch fixes generic/355, generic/683 and generic/684 for me.

Reported-by: Boyang Xue <bxue@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e61b878a4b45..ace02fd0d590 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5421,6 +5421,23 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 	return 0;
 }
 
+/*
+ * We avoid breaking delegations held by a client due to its own activity, but
+ * clearing setuid/setgid bits on a write is an implicit activity and the client
+ * may not notice and continue using the old mode. Avoid giving out a delegation
+ * on setuid/setgid files when the client is requesting an open for write.
+ */
+static int
+nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *nf)
+{
+	struct inode *inode = file_inode(nf->nf_file);
+
+	if ((open->op_share_access & NFS4_SHARE_ACCESS_WRITE) &&
+	    (inode->i_mode & (S_ISUID|S_ISGID)))
+		return -EAGAIN;
+	return 0;
+}
+
 static struct nfs4_delegation *
 nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		    struct svc_fh *parent)
@@ -5454,6 +5471,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	spin_lock(&fp->fi_lock);
 	if (nfs4_delegation_exists(clp, fp))
 		status = -EAGAIN;
+	else if (nfsd4_verify_setuid_write(open, nf))
+		status = -EAGAIN;
 	else if (!fp->fi_deleg_file) {
 		fp->fi_deleg_file = nf;
 		/* increment early to prevent fi_deleg_file from being
@@ -5494,6 +5513,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (status)
 		goto out_unlock;
 
+	/*
+	 * Now that the deleg is set, check again to ensure that nothing
+	 * raced in and changed the mode while we weren't lookng.
+	 */
+	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
+	if (status)
+		goto out_unlock;
+
 	spin_lock(&state_lock);
 	spin_lock(&fp->fi_lock);
 	if (fp->fi_had_conflict)
-- 
2.39.1

