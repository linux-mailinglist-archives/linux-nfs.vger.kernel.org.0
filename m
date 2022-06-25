Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1FE55ACAD
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jun 2022 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiFYUxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Jun 2022 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiFYUxD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 25 Jun 2022 16:53:03 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE90D58;
        Sat, 25 Jun 2022 13:53:00 -0700 (PDT)
Received: from hednb3.intra.ispras.ru (unknown [109.252.120.191])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0B33140737A8;
        Sat, 25 Jun 2022 20:52:57 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] NFSD: restore EINVAL error translation in nfsd_commit()
Date:   Sat, 25 Jun 2022 23:52:43 +0300
Message-Id: <1656190363-29148-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

commit 555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")
incidentally broke translation of -EINVAL to nfserr_notsupp.
The patch restores that.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")
---
 fs/nfsd/vfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 840e3af63a6f..1b09d7293bc5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1173,6 +1173,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
 			nfsd_copy_write_verifier(verf, nn);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
+			err = nfserrno(err2);
 			break;
 		case -EINVAL:
 			err = nfserr_notsupp;
@@ -1180,8 +1181,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
 		default:
 			nfsd_reset_write_verifier(nn);
 			trace_nfsd_writeverf_reset(nn, rqstp, err2);
+			err = nfserrno(err2);
 		}
-		err = nfserrno(err2);
 	} else
 		nfsd_copy_write_verifier(verf, nn);
 
-- 
2.7.4

