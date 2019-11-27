Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AAA10C003
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2019 23:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfK0WID (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Nov 2019 17:08:03 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41620 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfK0WIC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Nov 2019 17:08:02 -0500
Received: by mail-yw1-f68.google.com with SMTP id j190so8985566ywf.8
        for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2019 14:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDR7Yf2JpouK3zT+2zSWb+MjhVS7162OUhlKbuj0WDE=;
        b=iGYcc7gcCU3hkPYGZHUTAeluZbeWJROq57sZ9UhvlrA7m8RtfKRg31iKeWXONnVKUz
         P4ARhRTzAHmFkFplkKS2drNAD4VDtQGzFXJ19viV4rGuMRopJfbrO/GST02+TVsIv+Fc
         tK6QY+hjHLkkPvRKPWkT9rxWvCeX43DvzMfNS87RQ2SK/916P4xSD47RFg9fjVeazeLr
         POmIQuadJIvJ8GE/BRa9ygZyHpGmrfeFSmhdPhv/9c7JRsklYkNM/I9k0sFJyTDu9BDz
         V0pLSgKX1X06wbTT3WLuYOFgta0jDnm5Qo+EDoqsymcf4URV4tV3FE9HoyeQuVtOXL3t
         r75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDR7Yf2JpouK3zT+2zSWb+MjhVS7162OUhlKbuj0WDE=;
        b=anXaaYSsAxaXsZZUF5B1/axmE14/FHdBHeNolzB+Dd3/n8BVEl0EESiudCV7cnNRrI
         7SDCCr1EXtPMsq4DyJj7u+b5FGNkjUTGnjKUSX7Odi/y0oIricAK0zQdFfQkwtBABnJI
         6zt0FT+RtSVb3d4NUf7aQ3msnevbFBCmv2u49yUj1Xta/o9Sv1CsgX8mOjHxboJVqoZ5
         y6BXpSYcWzzQz1X1r5V/xYQigfkBgBunlVQF71N6lKeu8nmFXpteEzluFLmUmF4lte1G
         xj7vxJdpZ/NJ82ONZ4sKFxjV97V0pGabtr7CxAUONEkNeIdHnbPfQ1x5kiHJhVuWm/iO
         rdqA==
X-Gm-Message-State: APjAAAVE2c8j0eVWAUhETRlTArGu9rcPurSQBFr+85mMTT1wkQgk3EEL
        J1Vxc9/B1CM4Qd/ek9PNkg==
X-Google-Smtp-Source: APXvYqwDeyw7ViowTQQFqY24XCWCikjfTvIXOZf/HCpaaNA10clZN4mTmPE7xhZ4Gq6fIzSoMEESCA==
X-Received: by 2002:a81:2708:: with SMTP id n8mr4456869ywn.437.1574892481347;
        Wed, 27 Nov 2019 14:08:01 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id e82sm7561211ywb.87.2019.11.27.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 14:08:00 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Ensure CLONE persists data and metadata changes to the target file
Date:   Wed, 27 Nov 2019 17:05:51 -0500
Message-Id: <20191127220551.36159-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFSv4.2 CLONE operation has implicit persistence requirements on the
target file, since there is no protocol requirement that the client issue
a separate operation to persist data.
For that reason, we should call vfs_fsync_range() on the destination file
after a successful call to vfs_clone_file_range().

Fixes: ffa0160a1039 ("nfsd: implement the NFSv4.2 CLONE operation")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.5+
---
 fs/nfsd/nfs4proc.c | 3 ++-
 fs/nfsd/vfs.c      | 9 ++++++++-
 fs/nfsd/vfs.h      | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4e3e77b76411..38c0aeda500e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1077,7 +1077,8 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 
 	status = nfsd4_clone_file_range(src->nf_file, clone->cl_src_pos,
-			dst->nf_file, clone->cl_dst_pos, clone->cl_count);
+			dst->nf_file, clone->cl_dst_pos, clone->cl_count,
+			EX_ISSYNC(cstate->current_fh.fh_export));
 
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index bd0a385df3fc..9d66c4719067 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -525,7 +525,7 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 #endif
 
 __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
-		u64 dst_pos, u64 count)
+		u64 dst_pos, u64 count, bool sync)
 {
 	loff_t cloned;
 
@@ -534,6 +534,13 @@ __be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
 		return nfserrno(cloned);
 	if (count && cloned != count)
 		return nfserrno(-EINVAL);
+	if (sync) {
+		loff_t dst_end = count ? dst_pos + count - 1 : LLONG_MAX;
+		int status = vfs_fsync_range(dst, dst_pos, dst_end,
+				commit_is_datasync);
+		if (status < 0)
+			return nfserrno(status);
+	}
 	return 0;
 }
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index a13fd9d7e1f5..cc110a10bfe8 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -56,7 +56,7 @@ __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
 				    struct file *, loff_t, loff_t, int);
 __be32		nfsd4_clone_file_range(struct file *, u64, struct file *,
-			u64, u64);
+				       u64, u64, bool);
 #endif /* CONFIG_NFSD_V4 */
 __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
-- 
2.23.0

