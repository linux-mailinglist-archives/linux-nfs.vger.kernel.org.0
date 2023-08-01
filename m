Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE776B5E9
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjHANdR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Aug 2023 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjHANdM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Aug 2023 09:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A53E1BDB;
        Tue,  1 Aug 2023 06:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FEDC615A4;
        Tue,  1 Aug 2023 13:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC329C433C7;
        Tue,  1 Aug 2023 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896790;
        bh=qW9IP+djYLOwZukIeqaHto6GDgMjZwheXduDcYTrR/c=;
        h=From:Date:Subject:To:Cc:From;
        b=iFu9TKbcb3PzeiZVSO6f9KNXrcQ2wDLU8Z/igj3oTts8ZzyTz6CYgAjBYty8yO4mt
         a9450h9QLAurU11lxSvBWojiK/h6w1U1KprjTILupy8al6VQZ+0dsb5n7Xs2z78y/N
         /Wyfq1aTY2wHoqd/M3ZaHUpoLm+L75/YM6xWDI6IYEQbxsTDlNj1R+eiCsOrKqEsWA
         EFUPNU+HmoqMzj6HHe2yjapybiou+ik+zVI2GCyqMTZ04xIWX8Ri9uJT37DMa5lbFf
         ugNkBMwAWrX4dwxcSdhWTVOvxrsFRSB6V4XnfUik94SRHKbjMWnmCurT5VWUSUa0T/
         ArNIhYU9fAD9g==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Tue, 01 Aug 2023 09:33:06 -0400
Subject: [PATCH v2] nfsd: don't hand out write delegations on O_WRONLY
 opens
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-wdeleg-v2-1-20c14252bab4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJIJyWQC/2XMQQ7CIBCF4as0sxbTgYjGlfdouigw0IkNNWBQ0
 3B3sVuX/8vLt0GmxJTh2m2QqHDmNbaQhw7sPMVAgl1rkL1U/VmheDlaKAhjnNFGniZlNbTzI5H
 n9w4NY+uZ83NNn90t+Fv/iIIChb94QkuIRunbnVKk5bimAGOt9QtQKItCnQAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3422; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qW9IP+djYLOwZukIeqaHto6GDgMjZwheXduDcYTrR/c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkyQmVvF49eJYxC8Cze43AUKz+wTs72Hw99FIhD
 H/3ISU/H/2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZMkJlQAKCRAADmhBGVaC
 FUDvEACPOE0efmtrAtjPvrN6+mM0+nCautiP4Et5TfR5vMua2dkdW7Jj+uH9C/ortYSO2HZ1cCM
 OLNoW6ZR5ehyrc+Xo8g8uW2AyrRe6eCravWjeHFQErTf6Mm3RriI6cSHeBJ05uE/AwPbLqUCZJ6
 KDPMOU+0Ebr8q9EVvnLMqtkbD0ePEsroFB0UdNmuKKuBH72Ae0CwI+CgZA8s9SGbWXs7mTqmMnE
 P9co02/XQNX9UgxP1/MopRHJPrpuSFzmVxP6feomQvX242lRmhZrOyjLkiNRbEIhrFuuN1frrBS
 aFvRTIw9imnVApsTp9xDQz9YQNxh7yzQLHw93SP5GzEaiu3cNAmf8bq4EqBqWKRt2H4S7RtIwMS
 +FUSu9CXj9GueO/mQOpoIEaCI3PaQRR+HkQMD43dKAGVKpRrYufcv1TLNYa8JeWHkzTAunuc4vc
 5iefJdp9dOJAu4hVI++PqwHAYkpwjV/p3OuboJu5J+9V43hHBrwFuJ1Z/UDizkqLyF0q4zci/Zg
 dsDbuoYTlibqqYIrrBKU10Sy23OUjmesOLK7HfpFRGLwrA9Qq75caQLh/ULQs5Ifw06zHAF9zve
 8m10Jz6cMTn4aHucUORJTOZODpNVmGT07lgbKjusM5T0ojGjDg7Or9i9iV2usJtDRczyHJOKfJf
 TluOvGrnosstehQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Changes in v2:
- Rework the logic when finding struct file for the delegation. The
  earlier patch might still have attached a O_WRONLY file to the deleg
  in some cases, and could still have handed out a write delegation on
  an O_WRONLY OPEN request in some cases.
---
 fs/nfsd/nfs4state.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ef7118ebee00..e79d82fd05e7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5449,7 +5449,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct nfs4_file *fp = stp->st_stid.sc_file;
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
-	struct nfsd_file *nf;
+	struct nfsd_file *nf = NULL;
 	struct file_lock *fl;
 	u32 dl_type;
 
@@ -5461,21 +5461,28 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		return ERR_PTR(-EAGAIN);
 
-	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		nf = find_writeable_file(fp);
+	/*
+	 * Try for a write delegation first. We need an O_RDWR file
+	 * since a write delegation allows the client to perform any open
+	 * from its cache.
+	 */
+	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
+		nf = nfsd_file_get(fp->fi_fds[O_RDWR]);
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

