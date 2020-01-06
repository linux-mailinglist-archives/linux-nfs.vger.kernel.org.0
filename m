Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF21317AB
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFSmx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:42:53 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36002 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFSmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:42:52 -0500
Received: by mail-yb1-f195.google.com with SMTP id w126so20580249yba.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DnEWwYmni+ziqYug2P07l7EynLLIjlkk9quvtChv4k4=;
        b=Cg8K+b7p49qtrG4cMqxWApS+l6OOxCZO1YtFl3Lq8XD97aldv8/Pfg5XX9weUdm5BC
         KznhguRblexmyhCA7HjP+dD3GOeK2wVRo2E27m9IJY+98zI5L8yGfHg2ucaBTBh2u2vi
         E5xZiOjUIvtHqbOqN/5bb/M2MyGymiEpLpgPHTPNpnHzZHJdFw88BMVm/e9mj7KYeO1S
         hx0++NrsgzDmvt43aYLrKURXpqaJ0Sx1XFxcGa9NMO7LJcCPeksly9KEopYZscjX84Aw
         h4XgsNSbagwLmL8LVpbbpcWOT+h+gtJJ5Kp5hH8N3IsldPwWLt7xz5RZGc38GkE5SoJb
         5VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnEWwYmni+ziqYug2P07l7EynLLIjlkk9quvtChv4k4=;
        b=jZVPoGvWDw5uyYDVALGtje2sAXMVqCxZf0Qvnnmc4PTMIUDWAadQVCEUDG9Pyfh71m
         iOyZw9T/vkT/hWpZY9PnucPCa33PU9jcrU0jdG1fOD2hfkxIllW5DP4NGtNcoeDPdXi2
         j3+B34SpaPk7u/FuRK8UvvZa5iQt+Wvwf+yXJjL1tj5L/aBCV6AFadiXsB+kNgN0dqCu
         U1c3R9ASmcPIeUOogfuk2OHE7naVDnXbDcJ9D+rfZhIB5kC66sUnSh0B08RwckqjjFpm
         nkEVmn8WpbMSkpI2f0s5H0pKqBYoAlYlC6cYsV39GD5QqlFsX6dhtLwK7jPK0+e7+56w
         aaXA==
X-Gm-Message-State: APjAAAXSvltOOIguGzI1ei7bQH0LOWuf7fWKTT6l8cypReOIulMLVGju
        ZODN1m+U/V7YxBiQg+iNu0//wXunIw==
X-Google-Smtp-Source: APXvYqwsb998BZDP1X5auua/MHciHuUtfzNHD4wErxNCSkzkEzm2zmereOE2VImFsS15g+sPepBOlA==
X-Received: by 2002:a25:3741:: with SMTP id e62mr74990165yba.414.1578336171595;
        Mon, 06 Jan 2020 10:42:51 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm28223497ywf.101.2020.01.06.10.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:42:51 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/9] nfsd: Pass the nfsd_file as arguments to nfsd4_clone_file_range()
Date:   Mon,  6 Jan 2020 13:40:32 -0500
Message-Id: <20200106184037.563557-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106184037.563557-4-trond.myklebust@hammerspace.com>
References: <20200106184037.563557-1-trond.myklebust@hammerspace.com>
 <20200106184037.563557-2-trond.myklebust@hammerspace.com>
 <20200106184037.563557-3-trond.myklebust@hammerspace.com>
 <20200106184037.563557-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Needed in order to fix exclusion w.r.t. writes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 fs/nfsd/vfs.c      | 6 ++++--
 fs/nfsd/vfs.h      | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3d4e78118e53..7fce319e5b85 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1076,8 +1076,8 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	status = nfsd4_clone_file_range(src->nf_file, clone->cl_src_pos,
-			dst->nf_file, clone->cl_dst_pos, clone->cl_count,
+	status = nfsd4_clone_file_range(src, clone->cl_src_pos,
+			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
 	nfsd_file_put(dst);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 38db4a083375..7e7e31dfc672 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -530,9 +530,11 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 #endif
 
-__be32 nfsd4_clone_file_range(struct file *src, u64 src_pos, struct file *dst,
-		u64 dst_pos, u64 count, bool sync)
+__be32 nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
+		struct nfsd_file *nf_dst, u64 dst_pos, u64 count, bool sync)
 {
+	struct file *src = nf_src->nf_file;
+	struct file *dst = nf_dst->nf_file;
 	loff_t cloned;
 
 	cloned = vfs_clone_file_range(src, src_pos, dst, dst_pos, count, 0);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index fd779c3bb35b..69d23e9926cf 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -57,8 +57,9 @@ __be32          nfsd4_set_nfs4_label(struct svc_rqst *, struct svc_fh *,
 		    struct xdr_netobj *);
 __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
 				    struct file *, loff_t, loff_t, int);
-__be32		nfsd4_clone_file_range(struct file *, u64, struct file *,
-				       u64, u64, bool);
+__be32		nfsd4_clone_file_range(struct nfsd_file *nf_src, u64 src_pos,
+				       struct nfsd_file *nf_dst, u64 dst_pos,
+				       u64 count, bool sync);
 #endif /* CONFIG_NFSD_V4 */
 __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
-- 
2.24.1

