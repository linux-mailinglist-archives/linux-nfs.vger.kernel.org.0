Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B83D29D5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbfJJMqa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37486 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfJJMqa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:30 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so13337168iob.4
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7IlITqP9Y6iPkUe+B4M9/X1/cAINLpB8Gc9iOTZo000=;
        b=d51mOticr9BERmj0f80diLODJXgbfIC/qKu/G1LG7e38O5QlA8WNF06NEBONz3qPEK
         1OI1utPymrzqQaFMb3vdE22Gu3/V9scXhafADl29txtYtKx9hN30fvnEke2m8Ifp0JlC
         vRaWE2aLYnErnZoGPLF1ikFJGUV2xziLtVDjeFCTAgLdpaTi9QHOSQ+OxGJyi5U9AnF5
         o8/wiicBuJJ8t4+zYMZWkecJhwZ2qb+AK7gpQlMdNYs8AbhLIW9CrsJllGK81eVn6u1t
         twQPIHXJ2KHPHLHTCKZcKoW+nx5W/yS3lCXTDWm8Vf3f9Vx2DZpGj5P/WlIpLdgyea8Y
         644g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7IlITqP9Y6iPkUe+B4M9/X1/cAINLpB8Gc9iOTZo000=;
        b=JSqGYfdrekzmseiThg64OyjVolS9cV+TkpsxjOH//UFZM7OanZ5r26SrLMc9k2mtLz
         hd5OTiTq03t4U2Xk9qZpLGXKKL18TRIeU/ZnnJ0WZpu1Rhh7OWhfyfHVBPPW1nz40c0j
         qaYUIPFkN/ZpibeswaZcU5YWLdEdKTTt3Onh9xU7JrsY+LBkGnahffIzM1hY6xLEg/e3
         KzDohWvFPySpmfa3vjVASdnbxoXtftgtaXgi+TH9U2dP1B5CFLZPlPsL0+WhXQ2C7nMx
         w1bLwdwiZummh/ijOCI+bVBv49tGtcUXNEZwqrdBnFOsv2mFGsxF5OOISpVqiWr8E6W/
         UZQw==
X-Gm-Message-State: APjAAAWhlS3NAvW/DL8DaXZAWi9ofcXnkZ2jqAcBeMgVYKcy0Iqhkto2
        EwU+VsquGVkF30wU52+PS04=
X-Google-Smtp-Source: APXvYqxTHiK5QcWOfsKEfwl+bRXzioXY6PYM2yB52tHG7bkmVkz9cGLL+OwCubTVo0/VGpCtjLP+hg==
X-Received: by 2002:a92:1f44:: with SMTP id i65mr15728ile.123.1570711589673;
        Thu, 10 Oct 2019 05:46:29 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 04/20] NFS: inter ssc open
Date:   Thu, 10 Oct 2019 08:46:06 -0400
Message-Id: <20191010124622.27812-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

NFSv4.2 inter server to server copy requires the destination server to
READ the data from the source server using the provided stateid and
file handle.

Given an NFSv4 stateid and filehandle from the COPY operaion, provide the
destination server with an NFS client function to create a struct file
suitable for the destiniation server to READ the data to be copied.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Andy Adamson <andros@netapp.com>
---
 fs/nfs/nfs4_fs.h  |  7 +++++
 fs/nfs/nfs4file.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c |  5 ++-
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 8e590b4..5f27942 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -311,6 +311,13 @@ extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 		const struct nfs_open_context *ctx,
 		const struct nfs_lock_context *l_ctx,
 		fmode_t fmode);
+extern int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
+			     struct nfs_fattr *fattr, struct nfs4_label *label,
+			     struct inode *inode);
+extern int update_open_stateid(struct nfs4_state *state,
+				const nfs4_stateid *open_stateid,
+				const nfs4_stateid *deleg_stateid,
+				fmode_t fmode);
 
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
 		struct nfs_fsinfo *fsinfo);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index b68b41b..1898262a 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/falloc.h>
 #include <linux/nfs_fs.h>
+#include <linux/file.h>
 #include "delegation.h"
 #include "internal.h"
 #include "iostat.h"
@@ -286,6 +287,99 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 out:
 	return ret < 0 ? ret : count;
 }
+
+static int read_name_gen = 1;
+#define SSC_READ_NAME_BODY "ssc_read_%d"
+
+struct file *
+nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
+		nfs4_stateid *stateid)
+{
+	struct nfs_fattr fattr;
+	struct file *filep, *res;
+	struct nfs_server *server;
+	struct inode *r_ino = NULL;
+	struct nfs_open_context *ctx;
+	struct nfs4_state_owner *sp;
+	char *read_name;
+	int len, status = 0;
+
+	server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
+
+	nfs_fattr_init(&fattr);
+
+	status = nfs4_proc_getattr(server, src_fh, &fattr, NULL, NULL);
+	if (status < 0) {
+		res = ERR_PTR(status);
+		goto out;
+	}
+
+	res = ERR_PTR(-ENOMEM);
+	len = strlen(SSC_READ_NAME_BODY) + 16;
+	read_name = kzalloc(len, GFP_NOFS);
+	if (read_name == NULL)
+		goto out;
+	snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
+
+	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, &fattr,
+			NULL);
+	if (IS_ERR(r_ino)) {
+		res = ERR_CAST(r_ino);
+		goto out;
+	}
+
+	filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
+				     r_ino->i_fop);
+	if (IS_ERR(filep)) {
+		res = ERR_CAST(filep);
+		goto out;
+	}
+	filep->f_mode |= FMODE_READ;
+
+	ctx = alloc_nfs_open_context(filep->f_path.dentry, filep->f_mode,
+					filep);
+	if (IS_ERR(ctx)) {
+		res = ERR_CAST(ctx);
+		goto out_filep;
+	}
+
+	res = ERR_PTR(-EINVAL);
+	sp = nfs4_get_state_owner(server, ctx->cred, GFP_KERNEL);
+	if (sp == NULL)
+		goto out_ctx;
+
+	ctx->state = nfs4_get_open_state(r_ino, sp);
+	if (ctx->state == NULL)
+		goto out_stateowner;
+
+	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
+	memcpy(&ctx->state->open_stateid.other, &stateid->other,
+	       NFS4_STATEID_OTHER_SIZE);
+	update_open_stateid(ctx->state, stateid, NULL, filep->f_mode);
+
+	nfs_file_set_open_context(filep, ctx);
+	put_nfs_open_context(ctx);
+
+	file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
+	res = filep;
+out:
+	return res;
+out_stateowner:
+	nfs4_put_state_owner(sp);
+out_ctx:
+	put_nfs_open_context(ctx);
+out_filep:
+	fput(filep);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(nfs42_ssc_open);
+void nfs42_ssc_close(struct file *filep)
+{
+	struct nfs_open_context *ctx = nfs_file_open_context(filep);
+
+	ctx->state->flags = 0;
+}
+EXPORT_SYMBOL_GPL(nfs42_ssc_close);
 #endif /* CONFIG_NFS_V4_2 */
 
 const struct file_operations nfs4_file_operations = {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 505045b..f3a1f8d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -91,7 +91,6 @@
 static int _nfs4_recover_proc_open(struct nfs4_opendata *data);
 static int nfs4_do_fsinfo(struct nfs_server *, struct nfs_fh *, struct nfs_fsinfo *);
 static void nfs_fixup_referral_attributes(struct nfs_fattr *fattr);
-static int nfs4_proc_getattr(struct nfs_server *, struct nfs_fh *, struct nfs_fattr *, struct nfs4_label *label, struct inode *inode);
 static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle, struct nfs_fattr *fattr, struct nfs4_label *label, struct inode *inode);
 static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 			    struct nfs_fattr *fattr, struct iattr *sattr,
@@ -1718,7 +1717,7 @@ static void nfs_state_clear_delegation(struct nfs4_state *state)
 	write_sequnlock(&state->seqlock);
 }
 
-static int update_open_stateid(struct nfs4_state *state,
+int update_open_stateid(struct nfs4_state *state,
 		const nfs4_stateid *open_stateid,
 		const nfs4_stateid *delegation,
 		fmode_t fmode)
@@ -4065,7 +4064,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	return nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 }
 
-static int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
+int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr, struct nfs4_label *label,
 				struct inode *inode)
 {
-- 
1.8.3.1

