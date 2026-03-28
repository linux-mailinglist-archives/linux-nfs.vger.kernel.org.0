Return-Path: <linux-nfs+bounces-20493-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFK+OBAPyGmNggUAu9opvQ
	(envelope-from <linux-nfs+bounces-20493-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:25:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF9A34F524
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52AAE30488C8
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2313A4F32;
	Sat, 28 Mar 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5WtCyMH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353A3590CD
	for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718638; cv=none; b=bEgaeZkpJY75guOdxo+/gr2ifbernsDFEVgWn1Xr/5oWC20rEbh9+uuAOj/1kOQBgmB+ZThha0pw+oZddtordclkIFeEcqfrdVJLlZMPhffsdvwYq0dhHrkKQoujL+rVlwx63qLh7d/uVVGmBkVi5l1georNh3SnkyyscsEHT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718638; c=relaxed/simple;
	bh=uOVzfWG1cEqPUu6ILHQ5GnAuA4A8tWSLFbiZYE0vCEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIGuHYVe+NATNyoSjD1i6AgjRtheJZKW06Ov8RrWWdTa0+TeyyUTVMM8FNVEfTtjJHeolfinrrhtm0UtCQp1ead2YOlKGY6+HPy0IjHumIwBNs2KywwnHnGNlxwjUz07SBmIMGP1FTk0j605R0oRd5BsC0xY1iCo6FGtcefxZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5WtCyMH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-356337f058aso1806562a91.2
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2026 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718635; x=1775323435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbnvXfR2LaRdidXXHDujD9nIDm40TWJH2LHLfYsO5m4=;
        b=D5WtCyMHiOUwJ/1EQUM0mTQ7muTam9ZHjv5jlgzW4sQx+kYd0dgFyxYI6F6wnIndMI
         2OoIT5zVXOVOBXkdGg1gbKzoSKPYHBUIQdcMp8PlGNAYMMTqNYQDL2QKizxwHu5vjbZq
         9qIsoc7pGUFK4IyK10lB8xzqcGrUjantkwM17lnwQDe83RRIBGyNrx+GFUCsConYk6Dp
         B39nxBaE8+0lGxbuOVItBmL42cO/5elBpRJPrWcC6M6O1EGDKH3h21Mrd3YS6suKfrvb
         PXeviOhvsrX+Dpbd0jsXWgDUrW+PJizPBIk0Ha8HbPJRH8u0yGxCL8udoowBEzxRekmO
         26/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718635; x=1775323435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbnvXfR2LaRdidXXHDujD9nIDm40TWJH2LHLfYsO5m4=;
        b=AgNqqfj1Ii04cuP5UYQUQqB/afbpaDlZ5angaGAQ1JKKbgCfaUNudT3YXEiONSQ/k/
         VStcES9cFMNzvfe01QlsFCGYjei6jLlurBLVIzud/BFG0jIBTRllpOcWkd3f2699mCpG
         vs0+YCJzIbmCtz1UGHHtGImi1q3uXf+MkpeqeD9phW8GkGg58ogjwSj2/B5ulhpVRW+P
         7ZVCqORa7HBqL+cxudFzddQSfkRbWdVy5RnsJ/oR3zs/UN28qK+/t4RhbP1mPaB69CqM
         EAAuphZ3+L1+NGN4+tHkkK4oONRxnUVVpHqvaUFy2w4odg5rS4mYGmfhAXYy5ITjKlxP
         BJhw==
X-Forwarded-Encrypted: i=1; AJvYcCX5vXGT1urid1fs/Yt9LKJueMiDmQ086uPErhNhWF+n7NZ7Nns4ODVq0mMrRF9Ycrl1ufbXn73K6hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+eJ5O90AGy2qth07HMwX/W0/PfCAgWb31FjHaSz96vZTR2NE
	8ISgEgygFyGs64ze2Em3Ve3q0MrwOJkaWvZ04KuQrq9K3IuZ5MlgnyrD
X-Gm-Gg: ATEYQzxCjeRiuC9pKFTWbe/1wZ0Pg0OwDk1HLjCd1Zc2JNhtVGLAzKDhwIO3/5gj2Lm
	u/j+lZ9gHnJyzrwGN1qsuPsndMDMT1ljhsGPBkAkaF9j9xdq3cPt4oPzT4KSKR93zOT4wPreUK4
	VzcQoWNRDGLCR+kkuAzT7sBhmqE3pKtLoAcQ9ffXq3w9PideRvmCmJg+5YMmRNNBYEScWG2grVU
	CitsHLZ1vgBHlK1mBzhWHFvHYXLARDn2wR5mkZ14Ppp3EZ760t4nYVlj5Ry3r6Dt+8mBlszkkxh
	/KSjJPUCbaoo/9ZtX9yYFfiJ1chTYm/L3WWh3EB/g7B+LejF3lQTT3sxwefk8LSWLaD5sgd9rrZ
	vXGMfPWJJolimCoS9E0sGP4pGWjT3k6U+lP3Byz35W6nfYhfetxGRNUjigyhDV/6nkQOYGF9FXV
	hl5J5zw48mi6HqsCbxICYbVgGFqRphJwbpOuwWeFoWrtmKEvEOBhydkbE=
X-Received: by 2002:a17:90b:2787:b0:35b:e4d5:dc71 with SMTP id 98e67ed59e1d1-35c2ffa9e40mr6824533a91.14.1774718635343;
        Sat, 28 Mar 2026 10:23:55 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:23:55 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Date: Sat, 28 Mar 2026 23:22:22 +0600
Message-ID: <20260328172314.45807-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328172314.45807-1-dorjoychy111@gmail.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20493-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FF9A34F524
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This flag indicates the path should be opened if it's a regular file.
This is useful to write secure programs that want to avoid being
tricked into opening device nodes with special semantics while thinking
they operate on regular files. This is a requested feature from the
uapi-group[1].

A corresponding error code EFTYPE has been introduced. For example, if
openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
param, it will return -EFTYPE. EFTYPE is already used in BSD systems
like FreeBSD, macOS.

When used in combination with O_CREAT, either the regular file is
created, or if the path already exists, it is opened if it's a regular
file. Otherwise, -EFTYPE is returned.

When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
as it doesn't make sense to open a path that is both a directory and a
regular file.

[1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/alpha/include/uapi/asm/errno.h        |  2 ++
 arch/alpha/include/uapi/asm/fcntl.h        |  1 +
 arch/mips/include/uapi/asm/errno.h         |  2 ++
 arch/parisc/include/uapi/asm/errno.h       |  2 ++
 arch/parisc/include/uapi/asm/fcntl.h       |  1 +
 arch/sparc/include/uapi/asm/errno.h        |  2 ++
 arch/sparc/include/uapi/asm/fcntl.h        |  1 +
 fs/ceph/file.c                             |  4 ++++
 fs/fcntl.c                                 |  4 ++--
 fs/gfs2/inode.c                            |  6 ++++++
 fs/namei.c                                 |  4 ++++
 fs/nfs/dir.c                               |  4 ++++
 fs/open.c                                  |  8 +++++---
 fs/smb/client/dir.c                        | 14 +++++++++++++-
 include/linux/fcntl.h                      |  2 ++
 include/uapi/asm-generic/errno.h           |  2 ++
 include/uapi/asm-generic/fcntl.h           |  4 ++++
 tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
 tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
 tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
 tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
 tools/include/uapi/asm-generic/errno.h     |  2 ++
 22 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..fe488bf7c18e 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define OPENAT2_REGULAR	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..d46812f2f0f4 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define OPENAT2_REGULAR	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..bb6e9fa94bc9 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define OPENAT2_REGULAR	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 66bbf6d517a9..6d8d4c7765e6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			ceph_init_inode_acls(newino, &as_ctx);
 			file->f_mode |= FMODE_CREATED;
 		}
+		if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
+			err = -EFTYPE;
+			goto out_req;
+		}
 		err = finish_open(file, dentry, ceph_open);
 	}
 out_req:
diff --git a/fs/fcntl.c b/fs/fcntl.c
index beab8080badf..240bb511557a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
-			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
+			(VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8344040ecaf7..4604e2e8a9cc 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	inode = gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode) || excl);
 	error = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
+		if (file && (file->f_flags & OPENAT2_REGULAR) && !S_ISREG(inode->i_mode)) {
+			iput(inode);
+			inode = NULL;
+			error = -EFTYPE;
+			goto fail_gunlock;
+		}
 		if (S_ISDIR(inode->i_mode)) {
 			iput(inode);
 			inode = NULL;
diff --git a/fs/namei.c b/fs/namei.c
index 2113958c3b7a..e557c538c238 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4679,6 +4679,10 @@ static int do_open(struct nameidata *nd,
 		if (unlikely(error))
 			return error;
 	}
+
+	if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry))
+		return -EFTYPE;
+
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ddc3789363a5..bfe9470327c8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2195,6 +2195,10 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			break;
 		case -EISDIR:
 		case -ENOTDIR:
+			if (open_flags & OPENAT2_REGULAR) {
+				err = -EFTYPE;
+				break;
+			}
 			goto no_open;
 		case -ELOOP:
 			if (!(open_flags & O_NOFOLLOW))
diff --git a/fs/open.c b/fs/open.c
index 681d405bc61e..a6f445f72181 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
 	if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
 		f->f_mode |= FMODE_CAN_ODIRECT;
 
-	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2_REGULAR);
 	f->f_iocb_flags = iocb_flags(f);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
@@ -1183,7 +1183,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
-	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
+	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPENAT2_FLAGS),
 			 "struct open_flags doesn't yet handle flags > 32 bits");
 
 	/*
@@ -1196,7 +1196,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
@@ -1235,6 +1235,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
+	} else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
+		return -EINVAL;
 	}
 	if (flags & O_PATH) {
 		/* O_PATH only permits certain other flags to be set. */
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 953f1fee8cb8..355681ebacf1 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -222,6 +222,13 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 				goto cifs_create_get_file_info;
 			}
 
+			if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
+				CIFSSMBClose(xid, tcon, fid->netfid);
+				iput(newinode);
+				rc = -EFTYPE;
+				goto out;
+			}
+
 			if (S_ISDIR(newinode->i_mode)) {
 				CIFSSMBClose(xid, tcon, fid->netfid);
 				iput(newinode);
@@ -436,11 +443,16 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		goto out_err;
 	}
 
-	if (newinode)
+	if (newinode) {
+		if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
+			rc = -EFTYPE;
+			goto out_err;
+		}
 		if (S_ISDIR(newinode->i_mode)) {
 			rc = -EISDIR;
 			goto out_err;
 		}
+	}
 
 	d_drop(direntry);
 	d_add(direntry, newinode);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..a80026718217 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OPENAT2_REGULAR)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..b2c2ddd0edc0 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/tools/arch/alpha/include/uapi/asm/errno.h
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/tools/arch/mips/include/uapi/asm/errno.h
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/tools/arch/sparc/include/uapi/asm/errno.h
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/tools/include/uapi/asm-generic/errno.h
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
-- 
2.53.0


