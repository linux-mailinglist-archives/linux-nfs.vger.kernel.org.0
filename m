Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E05918BE
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfHRSVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42541 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfHRSVW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:22 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so16077151iob.9
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpmWU4/xYTCq6L/8cgpFRThI2/K1Eiepxk6ndD9JkI8=;
        b=KgoLeubNb9M0xc5y7ugTcnbObCZqZHBgNi/UEd4DMRwpVi6ZgRMVZgYPHGmhialOWG
         s0k6B5z/5VCUrPrb04P0dssqnWo4j9drL7BcUDMByMsBaOaeO43UhUSgtMA8yCYrM9aU
         3obZwEjvBvuKmXbcTwP3VFruR1VgHucghVVkMCIGcKSseWR2gFgazrOIKyp8ZMBplv7X
         O7dMRZimDiAZgTmoFSTBdo+fRLV/ukPoQp/3vzY4vogzySqQjiPPX2DbapRSYFL2sk/2
         X63WIjQAOHhUUO2VEEc3QKqkSfehJzX7T/ZHLW3lMgTNpaoujzENaRjqu69kCcAQpvxx
         +HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpmWU4/xYTCq6L/8cgpFRThI2/K1Eiepxk6ndD9JkI8=;
        b=cseP06RGahiv0dHcpXdBgL6C4zU7VPXkhFa55wi+xNVbaLKO1yjnstBpaaG9vogh1B
         JKJg2Y319GKe1B0pTUOFjZ3+xU96JuHYPdJivrxKqp1YvTaHuEvtrzW+V8FQWKfYdjaC
         gA6drG2opA0XmGpHByxlI1nYLZj/fi+yVsTjc2QG0wh+dP0Ft3HyIlfiLi6Cbpk/fR0t
         y9euIr9ocVbrQhaOu6qIWbO/r1mU6TIHPNRWRJNOxIliOSzdnUNRMICLioUYsyN9bH35
         8yw/cb6jztBBdRbo3iU890cWnEV3VlrxQuFAsPsbvuE2igbWrH8/16P8LMg7KODnDCrE
         amQg==
X-Gm-Message-State: APjAAAUvQW/kiS8HJf64QnbFX8Z/b/df9B7bhf+LZWbXjScCCxQsryj+
        e3OjvAcgOjSxC2hDpWaXMA==
X-Google-Smtp-Source: APXvYqw78ZV/WjEykOjhX0oTovIcqjKqabeVR9Vq8m6d+9iMpzZTr7au+J+VdPM93B2G5noB+7DkFQ==
X-Received: by 2002:a02:770a:: with SMTP id g10mr21522006jac.15.1566152481630;
        Sun, 18 Aug 2019 11:21:21 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:20 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/16] nfsd: hook nfsd_commit up to the nfsd_file cache
Date:   Sun, 18 Aug 2019 14:18:51 -0400
Message-Id: <20190818181859.8458-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-8-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Use cached filps if possible instead of opening a new one every time.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/vfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8593c6423336..ec254bff1893 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1133,9 +1133,9 @@ __be32
 nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
                loff_t offset, unsigned long count)
 {
-	struct file	*file;
-	loff_t		end = LLONG_MAX;
-	__be32		err = nfserr_inval;
+	struct nfsd_file	*nf;
+	loff_t			end = LLONG_MAX;
+	__be32			err = nfserr_inval;
 
 	if (offset < 0)
 		goto out;
@@ -1145,12 +1145,12 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 	}
 
-	err = nfsd_open(rqstp, fhp, S_IFREG,
-			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &file);
+	err = nfsd_file_acquire(rqstp, fhp,
+			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
 	if (err)
 		goto out;
 	if (EX_ISSYNC(fhp->fh_export)) {
-		int err2 = vfs_fsync_range(file, offset, end, 0);
+		int err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
 
 		if (err2 != -EINVAL)
 			err = nfserrno(err2);
@@ -1158,7 +1158,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			err = nfserr_notsupp;
 	}
 
-	fput(file);
+	nfsd_file_put(nf);
 out:
 	return err;
 }
-- 
2.21.0

