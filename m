Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0FB42C0
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391483AbfIPVOC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46356 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391481AbfIPVOB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:01 -0400
Received: by mail-io1-f68.google.com with SMTP id d17so2346889ios.13
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HsoXM+mEYIMjXOh8kTXzl2qJg6dzdkI/oW/I1UQipp4=;
        b=SJIlmB+DYrxkY7q+oq7jcEruRdTvuifvDydFPuo3KOnGrFEHdqCMVPGsqUtyhP8vQi
         vWeoNASbtsOKm+0bl1TI32HqZdV0lMGQWvOoVXZbtP9A0NB3lc305Kjda7k62AzyofDZ
         5Q6VAQflFzfWtjBWmxZzRxHH9TowY29rh0FP+vwSNs+WdAaVJKIkLM77on1UMGMZyA9Q
         srMc/kD7DtI75FtvhWe7ldACCYJXJfWPlDBXshos2BzuFkXtDyPagbTctHC5/Pu9r3fJ
         Gu8jJbpTdkXRinvce0jBsXl5xfafq1b7hTnqASxHpPbLdsEhse2CdcDj/11Zinptl6bv
         09Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HsoXM+mEYIMjXOh8kTXzl2qJg6dzdkI/oW/I1UQipp4=;
        b=J+I9eGB1OC742Gg3wZpq7M4WgT5TrCbruRCO4DNjMroaRNQEbNo3hfbgoLY/eTGYA6
         cVjq7PjC24mCOjTiQ6dB8G/e2UpzI6dTQGlJaEcDYzpvDw0Blv95ldoEQdMekRBWTz0s
         hsLU53AXjsJJdlMlG01yKu3Gu54fsngHJm3H30TnjkUlLszAP5f/crszT/hx35cfjJnd
         vd/sGeg5yg5bpI8tQx2jGUR8xcOBTtijaCnI0ASidiG6RCd36lsbIyvSicyX41mBW9Wr
         4aVPTFgbmqxpdUTNSwXdnrcsO6Jzrqd5wf3zGBcc4U/f0yNqgyiPwCzCIpchjaiL7/WJ
         6joQ==
X-Gm-Message-State: APjAAAWZfhN7jnp8y1w/6X34TagJiyDBZJUAU7bxu7h1iy9p+O7l/0M/
        x27qpDc+Ls7yHdrWogbwXZt6yMMN
X-Google-Smtp-Source: APXvYqxS2hlmn4NDavV4k/MJN5SwufMrJJts00ffNfEkAZgj1qwoJg4DuBIrurhmfOPmnptQc89wOA==
X-Received: by 2002:a6b:bd42:: with SMTP id n63mr372428iof.53.1568668440753;
        Mon, 16 Sep 2019 14:14:00 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.13.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:00 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 05/19] NFS: inter ssc open
Date:   Mon, 16 Sep 2019 17:13:39 -0400
Message-Id: <20190916211353.18802-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
index bd37fff..8b9f039 100644
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
index 1bec960..d9ca8af 100644
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
index 1012cbe..b783699 100644
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
@@ -1705,7 +1704,7 @@ static void nfs_state_clear_delegation(struct nfs4_state *state)
 	write_sequnlock(&state->seqlock);
 }
 
-static int update_open_stateid(struct nfs4_state *state,
+int update_open_stateid(struct nfs4_state *state,
 		const nfs4_stateid *open_stateid,
 		const nfs4_stateid *delegation,
 		fmode_t fmode)
@@ -3997,7 +3996,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	return nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 }
 
-static int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
+int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr, struct nfs4_label *label,
 				struct inode *inode)
 {
-- 
1.8.3.1

