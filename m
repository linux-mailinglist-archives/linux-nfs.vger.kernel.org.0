Return-Path: <linux-nfs+bounces-18561-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KelDEbweWnT1AEAu9opvQ
	(envelope-from <linux-nfs+bounces-18561-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 12:17:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB68FA02B7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 12:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F6653008C3F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9E33D4E4;
	Wed, 28 Jan 2026 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzU+ynPD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C162BE632
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599013; cv=none; b=amdtvTmDmYjRsDVRVxR7wTOYPRpXJE5qW9jp/x91fcZyrJZ5MN7/kZQX0QGDNBi0Wa/hdKNf/oMZIQ78170GprWuNRbkHToCWnUs0/3OAAz5oTLx01jeoPj8eHHTb9cWiUexlNIggLiXymrUpN4s8C2SWdKCaz9zTThQ0YWoIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599013; c=relaxed/simple;
	bh=TZeFTs2VfQOracwm4fh3obHJ71O7vhmqc6LKf0cH3TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTmnJx+62AhelCmpzxSWeW8jfb1rSuHOni+GB8yvaPwupIQO8bYG/VUZHc6Zes17+lQJmgTu1LKJDoy/sn/kX2z7vKoynt3Lz9/HNj0pOiEcI3QsnifKSsEqvi+L9N4obx0Wfn4mtrcCC7Skcfc2pKnliASeu/5XhznZO6J9u9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzU+ynPD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b88455e6663so1017825466b.1
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 03:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599010; x=1770203810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1xpuxvVRDxxVbhM+wdY6Xj3hRc+mpF5HHDMVBND8Zk=;
        b=RzU+ynPDXIvklMYNfhe7mm1l5zQd5njHUTR787fNmWVFC73cXIkcSXwMuNQt/UXmyf
         2vrFIUwjnEPtQTuK/FVrYELy3M+gtbz83tubYlQdYh0Yf0k2vVkPAiseIgjc5pSfsWhU
         6R8+KhSwU24asSgFyc3pSO0Pu6ZsOUMuajZReyZND4EWEoH1E81KWzmKD/cbA1A2S84q
         bB/KuE67hpKCobgHNKd6o/OOcgrke6mvSt8dqCht11uvRQgbNmy/HDAwf6yyjy2VGtc3
         6M/o5cctClKoiy/ptZYeJMVE95B3tYzaW7+WOIZSIMRhJs9uydyGCDNDMr0Dp+fldNNE
         3IMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599010; x=1770203810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1xpuxvVRDxxVbhM+wdY6Xj3hRc+mpF5HHDMVBND8Zk=;
        b=VdInpbGwRulxD4zyu0nAfvpvHyD7MocQDauPqI0FWKUFcreAY5I6DB4Ivo/FCPSZj7
         uoSSg0OIAhDC0CdSjlN61SSqEOQ9jHJuzBcGzKtt7Vt05P7INEDmHtwdO085jJisUdpE
         l+xZppGgAb67X8Pb13ogbbsV4fm6gUnyJ5CvgReUK6dDFvg/IGuESQu1cqLt8UuEbRGc
         7a7g7xFccejffbIqS6zXOWWUk+gH+X5jk1B5LDd01gI3E3xGR9ALxtkN6Qhjx0kSLhsQ
         C5FZ1hgFpXjQmT1CPYHvv67zJ6HkNKN93upe4PZDA8ZUawYKnIhfmQPqSI6Cspp/NTi/
         73LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX06CqDMTMKV1EcyVnJlLq9qVKK6g896sGs601XtzxWaMoXB4HStfk6khf1Eq4Df61C9T4rCE2SOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyPXssTxEtVYNGVlv7vkD3c9uyDEaYiTtUpjSzY8BcK4/yEpv
	S6DvIhDyGS7iS80dQcG4UbaL3QTULkLmXwXe/Aj7DP02NUbklwgZgEdA
X-Gm-Gg: AZuq6aI7Oabj4Hbo6Cp180pxFZ7F6rZ1PiuK7ZBeaDQ40PremdlxJaXhBHBcUEAqyLz
	xTgpHlnQwIys+uQxT5XeRT8tuQQWligM+rvmuF+xDijml92C0niuXKS4tW2TaVRWTTxmhmIn7gJ
	w/MakzCrourSfKOvB0yWXXz47w3ZqkXpFWJhd+r8dvvVMz/b5VVSPsR0F2VqUWk+n6ppEDEGLyb
	89WFo21P2kxwOtqauj+XaGTA/he+hLX+RSKR0UiOrya89BEVbUfYAZ0NePhOT74fbHzAQsNzaF0
	nIryAv/IE6/0ri6dDEI+bH1pC2DqXV3ipXqWT+Kt10LaCSYc2KGAXJG+BEuDnaPOtNBoEEaiUE9
	u3ZVQZW8169dQNtyJoGG90whqAPd1MJNsWsJaj5nP95L2Uz4Y826UbQVR4L5li0IyadPpNAjbFQ
	tp7t9YxarzdiaS8SaFY8U78jaWb7XNGqSOlu7mPIaa1jBSxF5nfo7bHXjmchdO/M0NGTxK91VLu
	n77RjbFG9wRrSQ7
X-Received: by 2002:a17:907:e104:b0:b8d:bf38:7025 with SMTP id a640c23a62f3a-b8dbf387f46mr116212366b.16.1769599009937;
        Wed, 28 Jan 2026 03:16:49 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-970d-2293-1f03-db81.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:970d:2293:1f03:db81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef87254sm112306966b.12.2026.01.28.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:16:48 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] nfsd: do not allow exporting of special kernel filesystems
Date: Wed, 28 Jan 2026 12:16:45 +0100
Message-ID: <20260128111645.902932-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128111645.902932-1-amir73il@gmail.com>
References: <20260128111645.902932-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18561-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB68FA02B7
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/opan_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Therefore, do not allow nfsd to export filesystems with custom ->open()
or ->permission() methods.

Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
Fixes: 5222470b2fbb3 ("nsfs: support file handles")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/export.c         | 8 +++++---
 include/linux/exportfs.h | 9 +++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad196..09fe268fe2c76 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -427,7 +427,8 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	 *       either a device number (so FS_REQUIRES_DEV needed)
 	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
 	 * 2:  We must be able to find an inode from a filehandle.
-	 *       This means that s_export_op must be set.
+	 *       This means that s_export_op must be set and comply with
+	 *       the requirements for remote filesystem export.
 	 * 3: We must not currently be on an idmapped mount.
 	 */
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
@@ -437,8 +438,9 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
-		dprintk("exp_export: export of invalid fs type.\n");
+	if (!exportfs_may_export(inode->i_sb->s_export_op)) {
+		dprintk("exp_export: export of invalid fs type (%s).\n",
+			inode->i_sb->s_type->name);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fafd22ed4c648..bf3dee2ad5f97 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -340,6 +340,15 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 	return nop && nop->fh_to_dentry;
 }
 
+static inline bool exportfs_may_export(const struct export_operations *nop)
+{
+	/*
+	 * Do not allow nfs export for filesystems with custom ->open() and
+	 * ->permission() ops, which nfsd does not respect (e.g. pidfs, nsfs).
+	 */
+	return exportfs_can_decode_fh(nop) && !nop->open && !nop->permission;
+}
+
 static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 					  int fh_flags)
 {
-- 
2.52.0


