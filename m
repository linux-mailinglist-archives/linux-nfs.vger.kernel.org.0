Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D6B1750EF
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2020 00:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCAXZS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 18:25:18 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42398 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAXZS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 18:25:18 -0500
Received: by mail-yw1-f66.google.com with SMTP id n127so9454620ywd.9
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2020 15:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9LwGjWOmssh6gQXkXnUBTSYCwZetwFOik6mpoK+NvY=;
        b=g84hdTyVdEJdVrU7A+7QU8J9vLzWRX/p9A61pNRmvPJC5uWZ0ezkw5eoDSUyzTtqdc
         nn8qqOw5Kps1A5AntdAANlByv/AEItj9F0niXS7fczW10JvTawYJxYYvlRYslTHX4reb
         2gcyGo0j7+C9SFoIgfjJlrFxMguY/e4GR0+n5yxcu9sA4AU3oRyPYqp3GV/bdTE2wCGB
         maGH3B2x5oOaIyDvqxnAsrhulJDu0VuGKApaDa0xF+Ii4S43C+dmXMLHM//GfTrUqlgR
         w7/zRynPuW0qE5NqtrcfQtIARcrGADJCrSUG+i7ndvipnk+8du+oVQz5HXK/MOp7EXBx
         bwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9LwGjWOmssh6gQXkXnUBTSYCwZetwFOik6mpoK+NvY=;
        b=hRD86ScRjWL3eJHFSmtFld9D2dkAN7gJeYHQqzz1yAdfUxWFsZ6lqQHWPyUoBY1C23
         uwN3VtbMVNhEEeWRbOsBWKkfjGDDpnDBXoVMqpYOpY9fYJFiPVf0rECWOi4HfIMe1eG+
         HwYPcymw054RGHT5N5TOQ5gdBGDQJNjHvbnYvqdfUyrvqdJvSOROzr85HpORlyNGE36/
         BsT5OPh/naQ9kHZShbFjQ3pkKyk/VM77MCasZ5Nq4NPElS867NOG+6+Nb0fokuiHcBwS
         PkDYiw4/223PX6bWJRiA9rRNQoI2G2LHjglt7mXAys/zYG7bolgPfRDn8pBt7fjlgceO
         hOtA==
X-Gm-Message-State: APjAAAVdsIHua+BMWw1mYcj0Ju92WbFNsXhShooFqfrtQNtxrCP97Za/
        jP3ly92oS1lqpmVmyUodFEVnxYUgVA==
X-Google-Smtp-Source: APXvYqyviRdG8PiOkecFwVw0wHEbrxJ10k3QXNOGBOoROx8w7C7arjH4IkCO7hlIKVg5pkPzQ3oJ6g==
X-Received: by 2002:a81:4603:: with SMTP id t3mr14219487ywa.97.1583105116864;
        Sun, 01 Mar 2020 15:25:16 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm7167301ywu.26.2020.03.01.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:25:16 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/8] nfsd: Add tracepoints for exp_find_key() and exp_get_by_name()
Date:   Sun,  1 Mar 2020 18:21:40 -0500
Message-Id: <20200301232145.1465430-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
References: <20200301232145.1465430-1-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-2-trond.myklebust@hammerspace.com>
 <20200301232145.1465430-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add tracepoints for upcalls.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/export.c |  9 +++++++--
 fs/nfsd/trace.h  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 15422c951fd1..e867db0bb380 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -23,6 +23,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_EXPORT
 
@@ -832,8 +833,10 @@ exp_find_key(struct cache_detail *cd, struct auth_domain *clp, int fsid_type,
 	if (ek == NULL)
 		return ERR_PTR(-ENOMEM);
 	err = cache_check(cd, &ek->h, reqp);
-	if (err)
+	if (err) {
+		trace_nfsd_exp_find_key(&key, err);
 		return ERR_PTR(err);
+	}
 	return ek;
 }
 
@@ -855,8 +858,10 @@ exp_get_by_name(struct cache_detail *cd, struct auth_domain *clp,
 	if (exp == NULL)
 		return ERR_PTR(-ENOMEM);
 	err = cache_check(cd, &exp->h, reqp);
-	if (err)
+	if (err) {
+		trace_nfsd_exp_get_by_name(&key, err);
 		return ERR_PTR(err);
+	}
 	return exp;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 9abd1591a841..3b9277d7b5f2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -9,6 +9,7 @@
 #define _NFSD_TRACE_H
 
 #include <linux/tracepoint.h>
+#include "export.h"
 #include "nfsfh.h"
 
 TRACE_EVENT(nfsd_compound,
@@ -80,6 +81,51 @@ DEFINE_EVENT(nfsd_fh_err_class, nfsd_##name,	\
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
 
+TRACE_EVENT(nfsd_exp_find_key,
+	TP_PROTO(const struct svc_expkey *key,
+		 int status),
+	TP_ARGS(key, status),
+	TP_STRUCT__entry(
+		__field(int, fsidtype)
+		__array(u32, fsid, 6)
+		__string(auth_domain, key->ek_client->name)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		__entry->fsidtype = key->ek_fsidtype;
+		memcpy(__entry->fsid, key->ek_fsid, 4*6);
+		__assign_str(auth_domain, key->ek_client->name);
+		__entry->status = status;
+	),
+	TP_printk("fsid=%x::%s domain=%s status=%d",
+		__entry->fsidtype,
+		__print_array(__entry->fsid, 6, 4),
+		__get_str(auth_domain),
+		__entry->status
+	)
+);
+
+TRACE_EVENT(nfsd_exp_get_by_name,
+	TP_PROTO(const struct svc_export *key,
+		 int status),
+	TP_ARGS(key, status),
+	TP_STRUCT__entry(
+		__string(path, key->ex_path.dentry->d_name.name)
+		__string(auth_domain, key->ex_client->name)
+		__field(int, status)
+	),
+	TP_fast_assign(
+		__assign_str(path, key->ex_path.dentry->d_name.name);
+		__assign_str(auth_domain, key->ex_client->name);
+		__entry->status = status;
+	),
+	TP_printk("path=%s domain=%s status=%d",
+		__get_str(path),
+		__get_str(auth_domain),
+		__entry->status
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_io_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
-- 
2.24.1

