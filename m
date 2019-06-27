Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C0586D4
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2019 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0QRH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jun 2019 12:17:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42469 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfF0QRH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jun 2019 12:17:07 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so5958622ior.9
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2019 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuZSacbFHwYrc+AErOsr/oGojyisv6qzPYJ5puHzY0k=;
        b=rMwrgkhcq23+Wf0xY24i2A6PqnADaGJ2oX6HGWU+qu/MU9m+533wGX8+3v5irwPBa7
         Uk6lsmoYgBZm1fOv+oT4T3MK/2yXptkOLiuGiEl+Jtn5gvQG0FGfx5h5JMNqDqXtgO32
         fKuCjvcQJ7o9xpnTheesPtfJpEtVC5rEb4WcI9eXhjgFzSP9IF8iFsgbFLxR6QkgKjRb
         rKzgzA6jiyh38/OyTw8nuLj/Baj40SVultI7GV4NMDZyhAxsVItn6Yo/znofzBGst+er
         lWekt7F54dggjbO649QeXgabvsVi/8o1Gxz/tEtE20DFewmwzZzBIp0VfuqVVpkyAQ+Y
         DWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuZSacbFHwYrc+AErOsr/oGojyisv6qzPYJ5puHzY0k=;
        b=PzkYcJ9rBLlWpv5cO5ergi3Fk6btyY4gTQg4xp1hLtscuT84Hp8xyEu2MGgKiSMa6y
         TfISSmwFyADULc9ObdJCT2/4r+qzC/HmiARFPC+BWOMnr//1SpEB+aa/EiogxHbGo7R4
         rW6zso6wxXBL5Lfi9luL84kRk4F4T+hmky5dGHRvceFXPLdD9hzConRAHfpIdSSJkItw
         7p4RRoubJfMpOydl45lEhrhXI3bRtxtASSL4YKYIrZvcbpfIS7GUULcdVQe5n5dYmQab
         2PCHgS4E68iYsjRATgYwT2XB5fJzqLo7bOEFdF7KnjLTHIXeEZ9umywyPVS6qKEnHVkS
         1C+A==
X-Gm-Message-State: APjAAAViKD7+16Zg6sLFUQZ875yErrNZKnaHMHCq4lyTey1DQzQXbXAO
        Wj9hwB0wwxVtpA4tyZWkUeoDLGUkGw==
X-Google-Smtp-Source: APXvYqydrA7YcV9GEK/0QimUs0QDmYQ/qyxCzkHfh//tasdizGa8J3sC0AmxzWQOHMqmFWgVLjTlaQ==
X-Received: by 2002:a02:5a89:: with SMTP id v131mr5843633jaa.130.1561652226145;
        Thu, 27 Jun 2019 09:17:06 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j1sm1896886iop.14.2019.06.27.09.17.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 09:17:05 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Handle open for execute correctly
Date:   Thu, 27 Jun 2019 12:14:57 -0400
Message-Id: <20190627161458.46784-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When mapping the NFSv4 context to an open mode and access mode,
we need to treat the FMODE_EXEC flag differently. For the open
mode, FMODE_EXEC means we need read share access. For the access
mode checking, we need to verify that the user actually has
execute access.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6418cb6c079b..26626ea1f197 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1165,6 +1165,18 @@ static bool nfs4_clear_cap_atomic_open_v1(struct nfs_server *server,
 	return true;
 }
 
+static fmode_t _nfs4_ctx_to_accessmode(const struct nfs_open_context *ctx)
+{
+	 return ctx->mode & (FMODE_READ|FMODE_WRITE|FMODE_EXEC);
+}
+
+static fmode_t _nfs4_ctx_to_openmode(const struct nfs_open_context *ctx)
+{
+	fmode_t ret = ctx->mode & (FMODE_READ|FMODE_WRITE);
+
+	return (ctx->mode & FMODE_EXEC) ? FMODE_READ | ret : ret;
+}
+
 static u32
 nfs4_map_atomic_open_share(struct nfs_server *server,
 		fmode_t fmode, int openflags)
@@ -2900,14 +2912,13 @@ static unsigned nfs4_exclusive_attrset(struct nfs4_opendata *opendata,
 }
 
 static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
-		fmode_t fmode,
-		int flags,
-		struct nfs_open_context *ctx)
+		int flags, struct nfs_open_context *ctx)
 {
 	struct nfs4_state_owner *sp = opendata->owner;
 	struct nfs_server *server = sp->so_server;
 	struct dentry *dentry;
 	struct nfs4_state *state;
+	fmode_t acc_mode = _nfs4_ctx_to_accessmode(ctx);
 	unsigned int seq;
 	int ret;
 
@@ -2946,7 +2957,8 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	/* Parse layoutget results before we check for access */
 	pnfs_parse_lgopen(state->inode, opendata->lgp, ctx);
 
-	ret = nfs4_opendata_access(sp->so_cred, opendata, state, fmode, flags);
+	ret = nfs4_opendata_access(sp->so_cred, opendata, state,
+			acc_mode, flags);
 	if (ret != 0)
 		goto out;
 
@@ -2978,7 +2990,7 @@ static int _nfs4_do_open(struct inode *dir,
 	struct dentry *dentry = ctx->dentry;
 	const struct cred *cred = ctx->cred;
 	struct nfs4_threshold **ctx_th = &ctx->mdsthreshold;
-	fmode_t fmode = ctx->mode & (FMODE_READ|FMODE_WRITE|FMODE_EXEC);
+	fmode_t fmode = _nfs4_ctx_to_openmode(ctx);
 	enum open_claim_type4 claim = NFS4_OPEN_CLAIM_NULL;
 	struct iattr *sattr = c->sattr;
 	struct nfs4_label *label = c->label;
@@ -3024,7 +3036,7 @@ static int _nfs4_do_open(struct inode *dir,
 	if (d_really_is_positive(dentry))
 		opendata->state = nfs4_get_open_state(d_inode(dentry), sp);
 
-	status = _nfs4_open_and_get_state(opendata, fmode, flags, ctx);
+	status = _nfs4_open_and_get_state(opendata, flags, ctx);
 	if (status != 0)
 		goto err_free_label;
 	state = ctx->state;
@@ -3594,9 +3606,9 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 	if (ctx->state == NULL)
 		return;
 	if (is_sync)
-		nfs4_close_sync(ctx->state, ctx->mode);
+		nfs4_close_sync(ctx->state, _nfs4_ctx_to_openmode(ctx));
 	else
-		nfs4_close_state(ctx->state, ctx->mode);
+		nfs4_close_state(ctx->state, _nfs4_ctx_to_openmode(ctx));
 }
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
-- 
2.21.0

