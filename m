Return-Path: <linux-nfs+bounces-19077-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCwnNhHkmWkRXQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19077-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 17:57:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB51516D570
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 947CD3075F63
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Feb 2026 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB2354AD6;
	Sat, 21 Feb 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7iDAGeG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F5354AC4
	for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771693068; cv=none; b=aoCuI+C1+NN88vRXE3EXobs4U+hcYWoO2zh1j68I2XHUIdOujCweIG/yF3yoT5JP8+FhcOKCHjBUelfOvfFwnWW5ovfwXrT50DPqjr5qnC1FQBDj3+xsvhkmg9aTiwEVofTJO0QWV+r86w0K+ZCynYC/IhOerRycp/zuMY9E6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771693068; c=relaxed/simple;
	bh=U57Xqi41GmcO0x6P9Zx3BaCcGSfhRtmMSS7Uf1PuLxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNPL00r7fh2k5BOjPPNM3RkF9J9/wE06x2iAlq47t0wSbdptvVoMojlRdBHYyfEykgUTqFboFvmQZvTcdhNw3ttJ7oMH8dACT8KlKVdRmUpisOMKVDCGSLGU/Kp+jcb3Oh56XhOYLY2rV2qYwkP1pBgLqHoo3kowRvc70nOJfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7iDAGeG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c713a6a6f8so331687185a.0
        for <linux-nfs@vger.kernel.org>; Sat, 21 Feb 2026 08:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771693066; x=1772297866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+im6HE0V+UhU/UpPycv1gj885b94imjLQRZ7n5HPX5c=;
        b=f7iDAGeGONdp10oJjQNFKs6YshJUB/SkwLIdjXoyJcrv0rJuQHa+TQLd6F71S3iIPg
         aY/YhQiCRFMKnr3EIJNLvmdLuQCGXSxCVbLul3DGM1frjHhI7YJZVFwAdUZR6G1H3l8H
         udvi1eg/aVOkq6eCHXGwQ3ayli1h2sxeCHpWfbOJibwuMBZCCxduz9x92hxFDbkqVaKn
         GLi0JEbC8FTnLpaLHj3ZTNC+gPAVRfcR11noVNARe+d/KiixOFeQH0KlcyEOU1vKOofn
         C6z5pgW7P3E6wmPalf6BPzGcG55mPOGhMSjBlnG127rpApTlIAzMKvLmesOKKEYbXlye
         NYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771693066; x=1772297866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+im6HE0V+UhU/UpPycv1gj885b94imjLQRZ7n5HPX5c=;
        b=R/W3THfiCt2L2r/+JQ4A6Skd7hgnCEqc8dX0psNz91xMP9JtOQvGroK1dWHTXiltAf
         HwfFnUZIvb3xv4lbHqaN223nbk2wRWhyXSMNVBbwMWAHDPC6lF5q+Maft7CVuigBxyyI
         EfEELRZim1QH7Ya+WqIVVzqRZ1+SsW7O9Z8InCGzOKX4ecosTSzz5VROjJa7n1es9AVS
         zbx4TDVZwGNxSWwdIyICZTEp2QJGeGy6D6ug02IPEtuSl7g21oTwQzar2C34ddyvjmtI
         Z5lXgnYYF43cClgvdSrHawdLKcxGU+GZ9tdxJfNx47DmV2U+gfqHyP/lmni1UAAQbOBf
         rnxg==
X-Forwarded-Encrypted: i=1; AJvYcCUkM6G+unq97Di/bLc5rJFz8lPCbNqj83LkH86/M/stT/br5htochsnAIqDvzdomCmFZCIFcaLMUPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kBFu5u9kNDtQz5BNKNPBROo21olJAK49+Q99QilW55/oKa+7
	HxRXyScsHrfU+JWl6AtWqC1KNCl5YyZjhgbdQMw85kBgWddoP1fmIG7r
X-Gm-Gg: AZuq6aKF55SqTOGDI/FRGjt+HDG3aHjXNxRNQzPGN/sorGNlHRZ1jORC/3lsYyH3QzF
	xh3EoFdjeXdmIUHfjho7plQJQ8qaid25TLSNW0kxe4zqLrYF9QT/uNXqLvwarJ9GHYfw2CrQXAd
	LXMyJIKoFWoeEOBGC1keYCduQKi23MYim6UzbuTYS1aUEwoOoWiMb04Mcv8sanhLs4icPPjusEK
	75Ztbb9DXxsG8jh0Vh8NP9w6uIQpcG0zSh6G5rlitxONgUOmsoNLqBjfEGG3GXz0JiacTJI/C++
	QdedLHlXrMn20cPV/wARusTy7CYUPPd2C7IghR++4esRbifd4tL/m7MrhJQwlEro/jhJVLCbMEY
	myPQCP7r/Mm0peFpeKDcnuymEpWKNefGaym4jFj11h3/UdWc7+0cKXw4UEeetSdjHWo9CNVi7U2
	GEoXlvw8W31pyoM8I4Sd0vHfjoR3hCPGue3H6JmaCxGpYlyL9F47cpSeQ=
X-Received: by 2002:a17:902:d48c:b0:2aa:f5b4:9a2e with SMTP id d9443c01a7336-2ad5f7349eemr96972465ad.11.1771685998012;
        Sat, 21 Feb 2026 06:59:58 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:59:57 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
Date: Sat, 21 Feb 2026 20:45:43 +0600
Message-ID: <20260221145915.81749-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19077-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uapi-group.org:url]
X-Rspamd-Queue-Id: DB51516D570
X-Rspamd-Action: no action

This flag indicates the path should be opened if it's a regular file.
This is useful to write secure programs that want to avoid being
tricked into opening device nodes with special semantics while thinking
they operate on regular files. This is a requested feature from the
uapi-group[1].

A corresponding error code EFTYPE has been introduced. For example, if
openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
param, it will return -EFTYPE.

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
 fs/gfs2/inode.c                            |  2 ++
 fs/namei.c                                 |  4 ++++
 fs/nfs/dir.c                               |  4 +++-
 fs/open.c                                  |  4 +++-
 fs/smb/client/dir.c                        | 11 ++++++++++-
 include/linux/fcntl.h                      |  2 ++
 include/uapi/asm-generic/errno.h           |  2 ++
 include/uapi/asm-generic/fcntl.h           |  4 ++++
 tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
 tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
 tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
 tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
 tools/include/uapi/asm-generic/errno.h     |  2 ++
 21 files changed, 55 insertions(+), 3 deletions(-)

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
index 31b691b2aea2..0a4220f72ada 100644
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
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8344040ecaf7..0dc3e4240d9e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -749,6 +749,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		if (file) {
 			if (S_ISREG(inode->i_mode))
 				error = finish_open(file, dentry, gfs2_open_common);
+			else if (file->f_flags & OPENAT2_REGULAR)
+				error = -EFTYPE;
 			else
 				error = finish_no_open(file, NULL);
 		}
diff --git a/fs/namei.c b/fs/namei.c
index 5fe6cac48df8..aa5fb2672881 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4651,6 +4651,10 @@ static int do_open(struct nameidata *nd,
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
index b3f5c9461204..ef61db67d06e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2195,7 +2195,9 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			break;
 		case -EISDIR:
 		case -ENOTDIR:
-			goto no_open;
+			if (!(open_flags & OPENAT2_REGULAR))
+				goto no_open;
+			break;
 		case -ELOOP:
 			if (!(open_flags & O_NOFOLLOW))
 				goto no_open;
diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..1524f52a1773 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1198,7 +1198,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
@@ -1237,6 +1237,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
+	} else if ((flags & O_DIRECTORY) && (flags & OPENAT2_REGULAR)) {
+		return -EINVAL;
 	}
 	if (flags & O_PATH) {
 		/* O_PATH only permits certain other flags to be set. */
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index cb10088197d2..d12ed0c87599 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -236,6 +236,11 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 				 * lookup.
 				 */
 				CIFSSMBClose(xid, tcon, fid->netfid);
+				if (oflags & OPENAT2_REGULAR) {
+					iput(newinode);
+					rc = -EFTYPE;
+					goto out;
+				}
 				goto cifs_create_get_file_info;
 			}
 			/* success, no need to query */
@@ -433,11 +438,15 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		goto out_err;
 	}
 
-	if (newinode)
+	if (newinode) {
 		if (S_ISDIR(newinode->i_mode)) {
 			rc = -EISDIR;
 			goto out_err;
+		} else if ((oflags & OPENAT2_REGULAR) && !S_ISREG(newinode->i_mode)) {
+			rc = -EFTYPE;
+			goto out_err;
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


