Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4079ACFD
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355497AbjIKWAF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244037AbjIKSuK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 14:50:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868191AD
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:50:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ee895a3cbso298215885a.0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694458203; x=1695063003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zK8DWJoKdAgv6TJ+vD8/MlOLgNjIDr7xlrcyP466uEw=;
        b=gasnhjh+ytRpH8MxgROs8F3oeiliBhOSBnpAw2NZzjFCdToSLGdQ7X57b7kershMEI
         IIjdpHOMYfFcoP6zYmbGilbSALcjk26wu8poXn4tcEnx0D7aaa+CN5bW5gjWQijVov9d
         TgIQHeh36/JBLrwrV6kwWV5RcGLLldN+r/L0To7JGdvEeWHXFFDGl9bvAuqLWkyNEgwq
         fvjYDde4XJ0qYKcxR9yYkrJklwJovB8jclzxaqntKYKgW0KHidgmv1cOPx/sTpAFIRRZ
         geYAt8k68EwZ+WlMZ9FnOotJm1iLI62fDlBybClBp/MGP/u8Q8kcq/51IsnmYcgsNW8M
         714A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458203; x=1695063003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zK8DWJoKdAgv6TJ+vD8/MlOLgNjIDr7xlrcyP466uEw=;
        b=Ml5uNGWdK9hgTAxI0UUs44hBeTd9D2MzImvDrCWzu6y5TTZfFpIiS7E6ZuKhGrJgX+
         TpIZHWugUQat5C+YDDo85yzQ28P/E6Knw8QmwJSs+vzylBKISJ4kOW1oj2xFevuyb1Rj
         JixFxE0nlZ1Ujb4ud4QMNfeZEnUy5uBjXn//eK9rbJKAvxEpjsL2+jVTc6uk62VPsYOq
         AkrTvcei4t8vYcy0g31sm6n3vv+Ny1hlm6xTDrXAPnIVJfQ9WDdSIqavHEZD80rqfEuP
         pUB3AqGxfq3DSbs8dTOFliJA/Geg6H2XgkT0z8po1/lS1QfKeguxHNFsebN5HJdBQcJe
         tzcA==
X-Gm-Message-State: AOJu0YwHjdtc9JJ3XzxdQIuoutkZHIRn3Xve10VS7IUIXwu6rSgbv0dM
        URdM4DUf7W5yQNtar0R+o2T+KB2f4g==
X-Google-Smtp-Source: AGHT+IFjSDgP6jvAt5cjklVP8BIe3paNhmIgaI8Ds8VA1gDiztVQQ5vJUggEt1KrIERbbcL0jY/FLA==
X-Received: by 2002:a37:ac08:0:b0:76d:acd1:447b with SMTP id e8-20020a37ac08000000b0076dacd1447bmr10587353qkm.41.1694458203608;
        Mon, 11 Sep 2023 11:50:03 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id p4-20020a05620a112400b007675c4b530fsm2703460qkk.28.2023.09.11.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:50:03 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
Date:   Mon, 11 Sep 2023 14:43:57 -0400
Message-ID: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If fsync() is returning EAGAIN, then we can assume that the filesystem
being exported is something like NFS with the 'softerr' mount option
enabled, and that it is just asking us to replay the fsync() operation
at a later date.
If we see an ESTALE, then ditto: the file is gone, so there is no danger
of losing the error.
For those cases, do not reset the write verifier.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 98fa4fd0556d..31daf9f63572 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -337,6 +337,20 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	return err;
 }
 
+static void
+commit_reset_write_verifier(struct nfsd_net *nn, struct svc_rqst *rqstp,
+			    int err)
+{
+	switch (err) {
+	case -EAGAIN:
+	case -ESTALE:
+		break;
+	default:
+		nfsd_reset_write_verifier(nn);
+		trace_nfsd_writeverf_reset(nn, rqstp, err);
+	}
+}
+
 /*
  * Commit metadata changes to stable storage.
  */
@@ -647,8 +661,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 					&nfsd4_get_cstate(rqstp)->current_fh,
 					dst_pos,
 					count, status);
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, status);
+			commit_reset_write_verifier(nn, rqstp, status);
 			ret = nfserrno(status);
 		}
 	}
@@ -1170,8 +1183,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	file_end_write(file);
 	if (host_err < 0) {
-		nfsd_reset_write_verifier(nn);
-		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
+		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
 	}
 	*cnt = host_err;
@@ -1183,10 +1195,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
-		if (host_err < 0) {
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, host_err);
-		}
+		if (host_err < 0)
+			commit_reset_write_verifier(nn, rqstp, host_err);
 	}
 
 out_nfserr:
@@ -1329,8 +1339,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			err = nfserr_notsupp;
 			break;
 		default:
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, err2);
+			commit_reset_write_verifier(nn, rqstp, err2);
 			err = nfserrno(err2);
 		}
 	} else
-- 
2.41.0

