Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572C07D6AB6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 14:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjJYMBx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 08:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjJYLmg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 07:42:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581A4129;
        Wed, 25 Oct 2023 04:42:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9effe314so3783855f8f.3;
        Wed, 25 Oct 2023 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698234153; x=1698838953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztxc7fGS03CwDDABLfZLza22pE8XDXpGxJKNBdIYUXU=;
        b=bzsgmTnY17zg5np2VmDz3XlAMk9VsA3IVErVBuWyK+dhzaD5MW7cn33GuyC7OMZ8fa
         0Qi9o2F/YcycHsJyPeB7x1b3PcEqZgWcDa1Geh8M4pTm2VD0++qUwRV+zlqahuieHME/
         zn5qbUCAHOR09b7pmuRX+6XPzTiriTA4Whel20mgR+38B0LQ/2W3lx6fFfgc2VLQncxY
         +fwTN81covF9zPITqU7CvpjS1iF+xe4W5na5DaME/BMXpAlG/KDKHsvPSB246PUP7WuH
         T91VPcLBCSLMHCAwfKMLIygG7hHLWlnmeKT2l96/Gz9TeRhYcH5LbQow8zMVN1VpxAet
         /01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698234153; x=1698838953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ztxc7fGS03CwDDABLfZLza22pE8XDXpGxJKNBdIYUXU=;
        b=ZLjTgnenZpgNwaWkp6+e1WVFfbN6NCP0lcR3EhB0MJX5OfWW5VC2RCAdg17Jny2whv
         JIO57X0enYZQW0ch7JxruFOfikF7/UDhs4OEZq21hAnbK+IuXgub6n5nHSwwgO3NwW3D
         3ov+QMckObcdVWfkXA6uHKQGx2XO5GiSO4GFtZyNdQORRm6HVE3tKiLO3ftEcXLWdkoJ
         gL79VDYnT1MaX5Br6L6KuDvCeyWW60RGC/sWWRL0LUwP38rVyh5IrbYm/CfPQTif6Tcf
         Jrb6ka0Wdza6hU5WOVelZO9eY75sm23S/QJSNj30goFNFQqk3s17oFVSsHNQrW5mccrY
         pqKQ==
X-Gm-Message-State: AOJu0YypdTH/H31qxotp1uICeYt9romP1i1TSFrE0VzqfzhwBC/zVNWy
        0xKmqaAkTvO8wZCHlmUO0f8=
X-Google-Smtp-Source: AGHT+IFY+SR+Sf5nD52JKdyMtbcRm3JEuKPSzPT36Byf04+0cg6qCgx+Sz1a4qdOIy3xAs9+I1LM8w==
X-Received: by 2002:adf:ef4e:0:b0:324:8502:6355 with SMTP id c14-20020adfef4e000000b0032485026355mr9735089wrp.46.1698234152508;
        Wed, 25 Oct 2023 04:42:32 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d6946000000b00318147fd2d3sm11844955wrw.41.2023.10.25.04.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:42:32 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] fuse: derive f_fsid from s_dev and connection start time
Date:   Wed, 25 Oct 2023 14:42:28 +0300
Message-Id: <20231025114228.23167-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Use s_dev number and connection start time to report f_fsid in statfs(2).

The s_dev number could be easily recycled, so we use lower 32bits of the
connection start time to try to avoid the recycling of f_fsid.
The anon bdev number is only 20 bits (major is 0), so we could use more
bits from connection start time, but avoiding f_fsid recycling is not
critical, so 32bit is enough.

If the server does not support NFS export, fuse client still advertizes
->s_export_op, but those are non compliant operations that often cannot
decode file handles, or worse, decode file hanldes to wrong objects.

In this case, leave f_fsid zero to signal fanotify and aware users to
avoid exporting this incompliant fuse filesystem to NFS.

This allows fuse client to be monitored by fanotify filesystem watch
for local client file access if server supports NFS export.

For example, with inotify-tools 4.23.8.0, the following command can be
used to watch local client access over entire nfs filesystem:

  fsnotifywatch --filesystem /mnt/fuse

Note that fanotify filesystem watch does not report remote changes on
server.  It provides the same notifications as inotify, but it watches
over the entire filesystem and reports file handle of objects and fsid
with events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

I'd like to explain why I chose to tie setting fuse f_fsid with fuse
server NFS export capability.

Since v6.6-rc7, fanotify permits sb/mount watch only for filesystems
that know how to decode ALL file handles (not only how to encode).
fanotify checks for the ->fh_to_dentry() method, which fuse always
implements regardless of server NFS export support.

At first I considered assigning s_export_op depending on server NFS
export support, but that would break the exising fuse best-effort decode
behavior, whatever it is worth.

Currently, fanotify sb watch does not support fuse because of zero f_fsid,
so I decided to keep it this way for the incomplete NFS export case.

Regardless of my own reasons, I think this behavior also makes sense for
users that want to export fuse to NFS:

In order to export fuse to NFS, user needs to specify an explicit "fsid"
argument in /etc/exports.  Until now, there was no clue from fuse w.r.t
a good value for the export fsid.

With this change, f_fsid would be a good candidate for export fsid.
Naturally, exported file handles would become stale after fuse server
restart, but that is much better that having file handles decode the
wrong object.

Even more important, if users would know that they can use f_fsid as
a valid export fsid, a zero f_fsid is also a good indication that
exporting this fuse fs is not a good idea.

Thanks,
Amir.

 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  | 26 +++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bf0b85d0b95c..963a7dbf4224 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -815,6 +815,9 @@ struct fuse_conn {
 	/** Device ID from the root super block */
 	dev_t dev;
 
+	/** Connection start time in jiffies */
+	u64 start_time;
+
 	/** Dentries in the control filesystem */
 	struct dentry *ctl_dentry[FUSE_CTL_NUM_DENTRIES];
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e63f966698a5..480bd2e7ad37 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -533,7 +533,6 @@ static void fuse_send_destroy(struct fuse_mount *fm)
 
 static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr)
 {
-	stbuf->f_type    = FUSE_SUPER_MAGIC;
 	stbuf->f_bsize   = attr->bsize;
 	stbuf->f_frsize  = attr->frsize;
 	stbuf->f_blocks  = attr->blocks;
@@ -542,7 +541,22 @@ static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr
 	stbuf->f_files   = attr->files;
 	stbuf->f_ffree   = attr->ffree;
 	stbuf->f_namelen = attr->namelen;
-	/* fsid is left zero */
+}
+
+static void fuse_get_fsid(struct super_block *sb, __kernel_fsid_t *fsid)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+
+	/* fsid is left zero when server does not support NFS export */
+	if (!fm->fc->export_support)
+		return;
+
+	/*
+	 * Using the anon bdev number to avoid local f_fsid collisions with
+	 * lowers bit of connection start time to avoid recycling of f_fsid.
+	 */
+	fsid->val[0] = new_encode_dev(sb->s_dev);
+	fsid->val[1] = (u32) fm->fc->start_time;
 }
 
 static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -553,10 +567,11 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct fuse_statfs_out outarg;
 	int err;
 
-	if (!fuse_allow_current_process(fm->fc)) {
-		buf->f_type = FUSE_SUPER_MAGIC;
+	buf->f_type = FUSE_SUPER_MAGIC;
+	fuse_get_fsid(sb, &buf->f_fsid);
+
+	if (!fuse_allow_current_process(fm->fc))
 		return 0;
-	}
 
 	memset(&outarg, 0, sizeof(outarg));
 	args.in_numargs = 0;
@@ -874,6 +889,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
+	fc->start_time = get_jiffies_64();
 
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
-- 
2.34.1

