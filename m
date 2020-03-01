Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3306D1750F1
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgCAXZU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:20 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46908 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgCAXZU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:20 -0500
Received: by mail-yw1-f66.google.com with SMTP id n1so8945711ywe.13
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ro0Ba+6pk8IfNjZpm7XGUiBmJP7EtwT3otvd3Y4S3I=;
        b=NoeH/02sDCGzAReFr1cjK4kn/EJb8GMs+Xm5vue9MYAGufNOJWb4H7TM/3mtfwHD15
         1DOYdcWczakuTsMC/cCzyYv+4f4bzIoLclQ1QDkjQISjAVXk7JNXx27TW3lmefFp4RzL
         OHcmBHrB3D3EsFDRNy3taDVX7lKnXgBvn5iz9e0igjrvCeG+5CWWxvY8+PfGkG18hGc7
         uGX+ZlhZiZ8nrq4ObsmVqEnnjmt/8ZVdmnL9yqUyduPEpoKKcHdxgwHk6VYGZtt7jgUh
         Ys0s179EhmpGngBIpqTMoH27PsYiU4ZOTXO9P5lvEJPXFbQrecU0lv8DKGG/P46zrVbk
         wqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ro0Ba+6pk8IfNjZpm7XGUiBmJP7EtwT3otvd3Y4S3I=;
        b=TU7bNqugo3zLtF3k5H8/StltIrsYIMiXvWYskvWhXrZYhbSOeOztYVNx02jkcJxbAG
         Pgn9oT+pyH10yG1MXEWlBGlwzzkjA0iRHie4rCeUpLTzv+iqw/jBko5nnVm9XsS1sx2M
         aEeovLxIgK8dNr38zzHPsszpeaPKuJu/RQi21J11aG526gAHdMnwCt3EzKp+rRccUsNl
         pB6BxWN/LAOtEHom59iPa+D95Zx5snAhy/vY5omvXx3uTLyOkarl30BAbK+Z9no5Jqhk
         WuxN7pH+fkAxwbKDN7ya99V9AHTZGK4zqsUhs7pEGivof+WJetUkaUmuW3Ttzw5K32js
         wNrw==
X-Gm-Message-State: APjAAAU6p+frrblW3fPu3HrlXiYCQVjd5JLBHlukOYawvmkEst7ifff4
        0qbgH5rfF5g7JBT+fUWITTUiKoUH8A==
X-Google-Smtp-Source: APXvYqyQBXvbCa4hwZJKeGPaDQa696fXp+pdMGRn2SDQzeGVYqAenGiNmF2mTyKVW/yslQ16Iyy1bQ==
X-Received: by 2002:a0d:e657:: with SMTP id p84mr14169217ywe.444.1583105117840;
        Sun, 01 Mar 2020 15:25:17 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:17 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/8] nfsd: Add tracepoints for update of the expkey and export cache entries
Date:   Sun,  1 Mar 2020 18:21:41 -0500
Message-Id: <20200301232145.1465430-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/export.c | 24 +++++++++++++++---------
 fs/nfsd/trace.h  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index e867db0bb380..6e6cbeb7ac2b 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -141,7 +141,9 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 	if (len == 0) {
 		set_bit(CACHE_NEGATIVE, &key.h.flags);
 		ek = svc_expkey_update(cd, &key, ek);
-		if (!ek)
+		if (ek)
+			trace_nfsd_expkey_update(ek, NULL);
+		else
 			err = -ENOMEM;
 	} else {
 		err = kern_path(buf, 0, &key.ek_path);
@@ -151,7 +153,9 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 		dprintk("Found the path %s\n", buf);
 
 		ek = svc_expkey_update(cd, &key, ek);
-		if (!ek)
+		if (ek)
+			trace_nfsd_expkey_update(ek, buf);
+		else
 			err = -ENOMEM;
 		path_put(&key.ek_path);
 	}
@@ -644,15 +648,17 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 	}
 
 	expp = svc_export_lookup(&exp);
-	if (expp)
-		expp = svc_export_update(&exp, expp);
-	else
-		err = -ENOMEM;
-	cache_flush();
-	if (expp == NULL)
+	if (!expp) {
 		err = -ENOMEM;
-	else
+		goto out4;
+	}
+	expp = svc_export_update(&exp, expp);
+	if (expp) {
+		trace_nfsd_export_update(expp);
+		cache_flush();
 		exp_put(expp);
+	} else
+		err = -ENOMEM;
 out4:
 	nfsd4_fslocs_free(&exp.ex_fslocs);
 	kfree(exp.ex_uuid);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 3b9277d7b5f2..78c574251c60 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -105,6 +105,32 @@ TRACE_EVENT(nfsd_exp_find_key,
 	)
 );
 
+TRACE_EVENT(nfsd_expkey_update,
+	TP_PROTO(const struct svc_expkey *key, const char *exp_path),
+	TP_ARGS(key, exp_path),
+	TP_STRUCT__entry(
+		__field(int, fsidtype)
+		__array(u32, fsid, 6)
+		__string(auth_domain, key->ek_client->name)
+		__string(path, exp_path)
+		__field(bool, cache)
+	),
+	TP_fast_assign(
+		__entry->fsidtype = key->ek_fsidtype;
+		memcpy(__entry->fsid, key->ek_fsid, 4*6);
+		__assign_str(auth_domain, key->ek_client->name);
+		__assign_str(path, exp_path);
+		__entry->cache = !test_bit(CACHE_NEGATIVE, &key->h.flags);
+	),
+	TP_printk("fsid=%x::%s domain=%s path=%s cache=%s",
+		__entry->fsidtype,
+		__print_array(__entry->fsid, 6, 4),
+		__get_str(auth_domain),
+		__get_str(path),
+		__entry->cache ? "pos" : "neg"
+	)
+);
+
 TRACE_EVENT(nfsd_exp_get_by_name,
 	TP_PROTO(const struct svc_export *key,
 		 int status),
@@ -126,6 +152,26 @@ TRACE_EVENT(nfsd_exp_get_by_name,
 	)
 );
 
+TRACE_EVENT(nfsd_export_update,
+	TP_PROTO(const struct svc_export *key),
+	TP_ARGS(key),
+	TP_STRUCT__entry(
+		__string(path, key->ex_path.dentry->d_name.name)
+		__string(auth_domain, key->ex_client->name)
+		__field(bool, cache)
+	),
+	TP_fast_assign(
+		__assign_str(path, key->ex_path.dentry->d_name.name);
+		__assign_str(auth_domain, key->ex_client->name);
+		__entry->cache = !test_bit(CACHE_NEGATIVE, &key->h.flags);
+	),
+	TP_printk("path=%s domain=%s cache=%s",
+		__get_str(path),
+		__get_str(auth_domain),
+		__entry->cache ? "pos" : "neg"
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_io_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
-- 
2.24.1

