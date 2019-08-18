Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B036918C4
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfHRSV2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39683 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHRSV1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:27 -0400
Received: by mail-io1-f67.google.com with SMTP id l7so16099596ioj.6
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6sAgAQlAGBifc+BShfgDUPv8xKQaJuq/S7X+beGv9Q=;
        b=YtFEVHh+1W7uKWtaxSMli5VEKD1+ECqoo1n8BhzcmeSBh1Z9gPD1TjrZaXnlEMgO71
         TpkCC9vD5TDmzUyKdtp0+MnI+onHeZrqETFxm4reCgX+Jwoekb8w02j4ZcjBKuNZvK6w
         rqx2f97DA9pbGog1aaV/sb4mDk44I0OcYl0MvC8a9AnTTTjXKzWG8iTmgkTWvh7O0/Np
         Da5nNjPHn8SNLOQJ9gUNzJO50Ao4A10zyyQOqPotpRlx+9oRYX+zUMyyRImNRnhVUb8T
         8BxPawAHeuZk21zykwGpXV5ROunnTf7/ivWYXV3kPsIblYrMdJigXSd8MUHBus8LL4zb
         kx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6sAgAQlAGBifc+BShfgDUPv8xKQaJuq/S7X+beGv9Q=;
        b=MtWCNRXWEPtL/cLai56qdo3u/H+tD65s50fqANF+r1pqeAF8FOlWXupeEauval90CW
         NlFnu3tKwnTKwd2Bqyj2MphgiVumxwyGIvc0+P+XTbNZdBhGIIbCsxUa75Zmf6jqT54M
         AZ/VL5FUY47febsq3qi3nVV0Y+K8H7wyXCAPWiWL8LQXfyhFJmLS6ZMCV6DmF3VPAM1j
         y8bEesewTNh/kSbLkXJ2xCtjc7/N04Whh9hvJ1dkG+XgOxSg1MX0Yd2eAisicOojp+33
         3vI2dOyj6b9lOudRba9Tk4q2TJHtFTpEfX59LUV28W5PlPl1KPWZOA4V/ah3S+YDJzNZ
         k+9g==
X-Gm-Message-State: APjAAAVk9+HqKRhR7l86Y5SnBGWJ2xrfsJXcY36OxA1KVdw0a1QssafZ
        YdjXkVH3GELjXvafsp58IA==
X-Google-Smtp-Source: APXvYqwLeEmDdBSFXN1dZ/M8nGsfwb/Hj2X/NqffISd+81/s3P+uSw2L2s6vQs23BdbQgZMHDTfEpQ==
X-Received: by 2002:a02:c90e:: with SMTP id t14mr3349615jao.131.1566152486465;
        Sun, 18 Aug 2019 11:21:26 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:25 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 12/16] nfsd: have nfsd_test_lock use the nfsd_file cache
Date:   Sun, 18 Aug 2019 14:18:55 -0400
Message-Id: <20190818181859.8458-13-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-12-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
 <20190818181859.8458-9-trond.myklebust@hammerspace.com>
 <20190818181859.8458-10-trond.myklebust@hammerspace.com>
 <20190818181859.8458-11-trond.myklebust@hammerspace.com>
 <20190818181859.8458-12-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4state.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index af6b191bdafc..cd28517b4781 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6605,11 +6605,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  */
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
-	struct file *file;
-	__be32 err = nfsd_open(rqstp, fhp, S_IFREG, NFSD_MAY_READ, &file);
+	struct nfsd_file *nf;
+	__be32 err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (!err) {
-		err = nfserrno(vfs_test_lock(file, lock));
-		fput(file);
+		err = nfserrno(vfs_test_lock(nf->nf_file, lock));
+		nfsd_file_put(nf);
 	}
 	return err;
 }
-- 
2.21.0

