Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7D157E836
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiGVUTo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiGVUTo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:19:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4F7F50A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 698D3B82A6C
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A696C341C7
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:40 +0000 (UTC)
Subject: [PATCH v1 07/11] NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:19:40 -0400
Message-ID: <165852118011.11403.6364411635740513013.stgit@manet.1015granger.net>
In-Reply-To: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move the nfsd4_cleanup_*() call sites out of nfsd4_do_copy(). A
subsequent patch will modify one of the new call sites to avoid
the need to manufacture the phony struct nfsd_file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bbefa2225f22..e47106698967 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1724,13 +1724,6 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 		nfsd4_init_copy_res(copy, sync);
 		status = nfs_ok;
 	}
-
-	if (nfsd4_ssc_is_inter(copy))
-		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src->nf_file,
-					copy->nf_dst);
-	else
-		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
-
 	return status;
 }
 
@@ -1786,9 +1779,14 @@ static int nfsd4_do_async_copy(void *data)
 			nfsd4_interssc_disconnect(copy->ss_mnt);
 			goto do_callback;
 		}
+		copy->nfserr = nfsd4_do_copy(copy, 0);
+		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src->nf_file,
+					copy->nf_dst);
+	} else {
+		copy->nfserr = nfsd4_do_copy(copy, 0);
+		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
 	}
 
-	copy->nfserr = nfsd4_do_copy(copy, 0);
 do_callback:
 	cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 	if (!cb_copy)
@@ -1864,6 +1862,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfs_ok;
 	} else {
 		status = nfsd4_do_copy(copy, 1);
+		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
 	}
 out:
 	return status;


