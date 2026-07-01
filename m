Return-Path: <linux-nfs+bounces-22917-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O9y4DQR8RWq7AwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22917-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E377B6F18BD
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:43:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=Sd4WldOG;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22917-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22917-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95B0B300F192
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC43955C6;
	Wed,  1 Jul 2026 20:43:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA560349CC2
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 20:43:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938625; cv=none; b=KE8x+f9LpcF5/gyRSK+JHAatKFbNi+Fi2hN4KwtsDmPKo4dxFScq9L4ddihlEeAuCejE65U2So+P7PBcoUmyN1Z42eoYyPt4K+9bxSWveaKZHuopNKI/KZgfMiY4HiKEXd1ZEJP2V1SSi3UE0qhigYUmRfmRjcR5XnHoREcV0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938625; c=relaxed/simple;
	bh=nda0CbvlHctsA9zSNcKhtAYAJc2BzqepRUIo9IocYRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChA7zbvQD7Eb0vU/FfTHg4IkGqRhBoNyBtI8iD3/5aOIq7C9hdGWeAikLANJdvUY2/GLHSX1VWd+S1sO6mcs6W8w2fNtcxQKoOq96W6lyeWAs/zBCuymrbQLsY2ed5BOKwfaAqg+/OHD62GRS7/uvJCuxDCJGBCwxR1fE8jSrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Sd4WldOG; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-920f33347f5so63243985a.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 Jul 2026 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782938623; x=1783543423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmDv8as+Wrz9bGw5yoXAXWgLir9Tdr/BU1ivmzH0STU=;
        b=Sd4WldOG4ySeZG6j/V6zgsqs20XyCfiBryDRiYaQykgXXtiRWaxBKjyqMb4/GTzC9d
         u+qU4NGaAdcln4yBNzhCZphFyXlJPfgfYJxuzBfPG1rY8LgFZA5CsU79gva/1oSG/SPz
         c9/KRiDQ6W9qQ7Ig5mNLt5ZTVEXi/JkAyjEwnKvc9pGifcj4YfkLhaju7B5Hka+vAGo5
         92ViB8D7htXGtaJxGDXOGlxhVQXxgpIhZu3axF7rtcI3UQKpHmTIhvyotHcVZ7eizmMw
         hKXFMFpXXO7Nzi8tw+C981ltdba5c35ed+reR2nnhn6Cep3GxybNS7036MHJUFkm2ktH
         LjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938623; x=1783543423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmDv8as+Wrz9bGw5yoXAXWgLir9Tdr/BU1ivmzH0STU=;
        b=Bxx4X6RRfGvMt+9UY0BtP9683gmtiWb5RMmfb9qibo4p1n0Eo+5A7f7IK3ytS09MpL
         Jku2y+ws9XR4fdsaysm9DPDvDjRRAtDnWADVhlQ9lSCuLCzXNx4820RQaauVYTCddcBO
         0YEI/CrpR8C5vNBGeTSGs4M5MM3Do3LZ5mRp0dR7p0Z2kdKViM+HXhPxZ2ydH0yP2m+z
         uBJunMJnEFW4wWJSikisVfcnpunQb4mkl5YZZD7XXtEejM5URk5+96xLUK3x2UUtGejz
         sHLWXpMDXzPZoQDtobcouZyfJKb1utlUt1z6VC4Fdhkg+jE8kUSjR8TCglWzzTkqGjYH
         W6Iw==
X-Forwarded-Encrypted: i=1; AFNElJ9S0VHfk2kreP+0V/v+GOdtg38ubWKFpfLqssO0Nw/qcfc6PK7PI6x02HKl9tVaPTZkz9W9PFve7iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLrruU53WMN+948DGso6B2JvpS7Pr5Rze0dv51pdTIHs0T7lv
	c0aroJM+6U+5TkfZYwz/c1oLAiZ4hw4wDo+fO+xWlI8cxDE4d7HnkOhKt/14oRu1Wl4=
X-Gm-Gg: AfdE7cmWwX/QBwvBzTgpEbNqcq8vvcaGBn03spDy+3g/GKwV/XpAaGOAnyh+Pz+ZF3h
	kQqEqfza+k4Jrbj/zV5f2bK3ivC7QYpe0fzliEjkIww6Ygkzr8czQqdzz7ZfNcfqzjxV0cC8NyP
	50VSWNTBos2uhqCCrkI+f28GCYMNy3v3woPh0i+nwh03bj58QJeQsf1piyDOIu/MnmYNEsOV1Yj
	U++JSNASAQoxZeW/3ARriDEVPQK6xYdAX28X+T3IB31bR7ftGaxKsIOGMmtkwRvWDKrRsy3+FFv
	OyynTee477/IHVQry/BtUYXZgnoTsA8yVHn69Fm9kcLvlC6+AkFFN/GpVh2kHOkKOabDa6kBukE
	EZWVz6lHtbjjT31KPkSf5YKv3sPx9P7EB9dp3DCcwdDC8dDjYpT2c+vzZbqAJMwjh72MBk/is8M
	+qkCAZGt+H5Ff18S21VBwwtAdbitiGU6gZAGJ5BUurWU8cCLDLy4UsFQYrboobGum6qu+YhvoUk
	5Z0rw==
X-Received: by 2002:a05:620a:284e:b0:915:a894:1b43 with SMTP id af79cd13be357-92e7824311emr487657085a.28.1782938622688;
        Wed, 01 Jul 2026 13:43:42 -0700 (PDT)
Received: from localhost (pool-68-160-167-46.bstnma.fios.verizon.net. [68.160.167.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e7ffdd84esm40427185a.10.2026.07.01.13.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:43:42 -0700 (PDT)
Sender: Mike Snitzer <mike.snitzer@hammerspace.com>
From: Mike Snitzer <snitzer@hammerspace.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/6] nfs4.2: open UNCACHEABLE_FILE_DATA files with O_DIRECT
Date: Wed,  1 Jul 2026 16:43:34 -0400
Message-ID: <20260701204337.54314-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701204337.54314-1-snitzer@kernel.org>
References: <20260701204337.54314-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22917-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@hammerspace.com,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E377B6F18BD

Honor the per-file UNCACHEABLE_FILE_DATA attribute by transparently
opening such regular files with O_DIRECT, so reads and writes bypass the
page cache as the attribute requires, without the application having to
request O_DIRECT itself.

This follows the model the specification describes: the attribute is
"similar in intent to O_DIRECT" and clients "retain flexibility in how
they satisfy the requirements" (draft-ietf-nfsv4-uncacheable-files
Section 4.4, "Relationship to Direct I/O"), and its Implementation
Status (Section 6) describes a prototype Linux client that "treats the
attribute as an indication to use O_DIRECT-like behavior for file
access".

Introduce an NFS_CONTEXT_O_DIRECT open-context flag: nfs4_atomic_open()
sets it when the resolved inode has uncacheable_file_data set (and the
open is not O_APPEND), and the open paths nfs_atomic_open() and
nfs4_file_open() apply O_DIRECT to the file when the flag is set.

The I/O mode is thus selected at open time and is not changed for an
already-open file: a later change to the attribute takes effect on the
next open.  The specification permits this -- a client that has already
opened a file MAY continue with its existing caching behavior and apply
the updated attribute to subsequent operations (Section 5).

The delegation interaction in Section 4.3 was considered: it permits read
caching to remain when another NFSv4.2 mechanism, such as a delegation,
already ensures a consistent view of the file.  That relaxation is
optional ("may remain appropriate") and read-only -- it does not relax
write-behind suppression (Section 4.1) or the WRITE durability invariant
(Section 4.2).  This implementation deliberately does not take it: an
uncacheable file is opened O_DIRECT regardless of any delegation held,
which is compliant (read caching is simply suppressed more aggressively
than the Section 4.3 minimum) and avoids decoupling read vs write caching
behind a single open flag.  Relaxing reads under a delegation is left as
a possible future optimization.

Section 6 observes the benefit holds "for applications that issue
well-formed I/O requests".  That alignment caveat does not constrain the
Linux NFS client's over-the-wire path: the client readily issues
misaligned I/O using O_DIRECT over SunRPC to the remote NFS server.  The
only place a fallback from O_DIRECT to buffered I/O for misaligned I/O
applies is NFS LOCALIO (fs/nfs/localio.c), which detects non-DIO-aligned
I/O and falls back internally; that path is unaffected by this change.

See: https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-files/

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/nfs/dir.c           |  4 ++++
 fs/nfs/nfs4file.c      |  2 ++
 fs/nfs/nfs4proc.c      | 10 ++++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 17 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c7b723c18620..6b07abf272b1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2208,6 +2208,10 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 	file->f_mode |= FMODE_CAN_ODIRECT;
+	if (test_bit(NFS_CONTEXT_O_DIRECT, &ctx->flags)) {
+		file->f_flags |= O_DIRECT;
+		open_flags |= O_DIRECT;
+	}
 
 	err = nfs_finish_open(ctx, ctx->dentry, file, open_flags);
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index be40e126c539..6401f6363f75 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -91,6 +91,8 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	nfs_fscache_open_file(inode, filp);
 	err = 0;
 	filp->f_mode |= FMODE_CAN_ODIRECT;
+	if (test_bit(NFS_CONTEXT_O_DIRECT, &ctx->flags))
+		filp->f_flags |= O_DIRECT;
 
 out_put_ctx:
 	put_nfs_open_context(ctx);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a0d088cd47ac..3903d613f3eb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3853,6 +3853,16 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 
 	if (IS_ERR(state))
 		return ERR_CAST(state);
+
+	/*
+	 * Use O_DIRECT if file was marked as Uncacheable, see:
+	 * https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-files/
+	 */
+	if (!(open_flags & O_DIRECT) && NFS_I(state->inode)->uncacheable_file_data) {
+		if (!(open_flags & O_APPEND))
+			set_bit(NFS_CONTEXT_O_DIRECT, &ctx->flags);
+	}
+
 	return state->inode;
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 8552a0d778d9..48b806aa3a2f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -110,6 +110,7 @@ struct nfs_open_context {
 #define NFS_CONTEXT_UNLOCK	(3)
 #define NFS_CONTEXT_FILE_OPEN		(4)
 #define NFS_CONTEXT_WRITE_SYNC		(5)
+#define NFS_CONTEXT_O_DIRECT		(6)
 
 	struct nfs4_threshold	*mdsthreshold;
 	struct list_head list;
-- 
2.47.3


