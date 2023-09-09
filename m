Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B28799794
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Sep 2023 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjIILMq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Sep 2023 07:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIILMq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Sep 2023 07:12:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB56CF4;
        Sat,  9 Sep 2023 04:12:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07380C433C7;
        Sat,  9 Sep 2023 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694257958;
        bh=WNxELE4zmDBT1E4H7P0lP6ekrYFVDFSU/OtCPNtAzMg=;
        h=From:Date:Subject:To:Cc:From;
        b=Tg2DOOUemV66FwEkmypwT5dUaooAsnT4A+KW0m3HkZBef4ijKkEgddIUjFC5bwo5C
         6vQylXoDzhcc3tw4jmVQqF2pCup9vnLltCGHgueUXe+vonwwu0KboJyqpb4EES1KHI
         CfzYknq/ue3N1JX4BA00+mqlEQifoEkT9dwdbpcqZtlp0e2VDZLJe1CBSUzF/cUeFD
         nRUWKh8FPk2Xj1dOSd9+pRRqtNiVk85CU3PlHKToaJhTL1VW5QPNAJW/WkV5kG/44b
         +FKyqkdnc485SnNxWma7hqHE+JGzlmlrL/5tXkANLbNrtOT4763PqH+c/1IopUJNoJ
         xUUyYdwlpr8Ag==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Sat, 09 Sep 2023 07:12:30 -0400
Subject: [PATCH] nfsd: fix change_info in NFSv4 RENAME replies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230909-nfsd-fixes-v1-1-2ebc659c0cf4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB1T/GQC/x2LQQqAIBAAvyJ7TjDFsr4SHTLX2ouFCxGIf086D
 jNTgDETMsyiQMaHmK7UoO8E7OeWDpQUGoNW2qhJOZkiBxnpRZbR+uDdiIMyFtpwZ/xF65e11g9
 IoXcfXAAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1557; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WNxELE4zmDBT1E4H7P0lP6ekrYFVDFSU/OtCPNtAzMg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk/FMgt7PjWKsoyFpjqHVUvZl57TYCiMAQdLbHP
 xARC/EAKGWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPxTIAAKCRAADmhBGVaC
 FdYOEADMjm6EEw2gdOyWTo7tdg1WJowtrSh6jBzB9VDA1FGuZP2g+rk6GNp9MgURKGMTzqzQs8I
 XyzmL137ugLfU/PsYJsSSKyG/wmaRYBhgcRJyt6QN13U9PFPnoczmr5axAcAK208wZIIOXbe3S/
 lJNVPw0UFeevgAUfKE+ZATF6p+IGkjW6MZ9VGnokdYE4sv/YjVVuKk9N3GJKEIxu1cRatjQE+58
 4WRx4lUybsjdtMjeghXw9iUQ0ltgPBsS18/qcVPlyn6x+zJlrf3JJ6nbVUopO8rN/j6PFw51fKT
 RSeYRKTsXykvhmKnch+Oa/7sz69/Kmx1A4rQBs3ELmjRiw1T57+mkKYNl0wfVH2aCLwZQpnhKsl
 RYWZLNPWRzg7aHnZKJDxxrz46oQJntXWMLml7zcgU/+bKTF13iC0KRLo1gObqvsXJybeDmF5AhJ
 HLGiM+rwwThJ6X5msGtDx2P3p7GLe3WAgTCZwetg/IYEzeeSQexHll5LjxVoE+7XntglWDFrDwb
 BhDmoRNBkTHtqob/hIG8jWG15HduRoD5iXJFSmN0Fe7E7z3/zwOfpp8ZlFet97kfNnAG6gJ3fU8
 AEtLeWyYpeBLiJ9k3byOZVFTAiBRclI1kkoGOQ6snZ+nB9rg6juAzvWNx5SPqSFMhSlr09mglCL
 sjMMD44YihJZsKA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd sends the transposed directory change info in the RENAME reply. The
source directory is in save_fh and the target is in current_fh.

Reported-by: Zhi Li <yieli@redhat.com>
Reported-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This bug predates git, so I can't add a proper Fixes tag. I think this
is probably appropriate for stable series kernels though.

This bug was largely papered over by the fact that we factored in the
ctime when generating a change attribute. Since this commit, however:

    638e3e7d9493 nfsd: use the getattr operation to fetch i_version

We stopped doing that for directory inodes and that caused this bug to
pop up.
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5ca748309c26..4199ede0583c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1058,8 +1058,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			     rename->rn_tname, rename->rn_tnamelen);
 	if (status)
 		return status;
-	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
-	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
 	return nfs_ok;
 }
 

---
base-commit: dd1386dd3c4f4bc55456c88180f9f39697bb95c0
change-id: 20230908-nfsd-fixes-f5bdb87e6035

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

