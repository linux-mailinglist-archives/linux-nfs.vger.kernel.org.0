Return-Path: <linux-nfs+bounces-18225-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKaDONuTcGlyYgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18225-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:52:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72C53E6A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459554EDA5A
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27645BD67;
	Wed, 21 Jan 2026 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtXC1NKw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276F43D50B
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985435; cv=none; b=ZNKk7+jtEADcEVa/DMtS2JR59mYLOl+LMh1EpshRtyPNl4TXIlcnan4lrfILK3iQe1/9nkz7kHKSpB0tnKI9TGfVpnBCCMV7z1a9r0twN39eT4LTMgUhz9eZQ7xUx47v4NFducB/Yvl7OHInipC1CSa0qycvIi+wEUEtG+QZLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985435; c=relaxed/simple;
	bh=WAqqvlkEfgyIrnhaubplQ0uzr8/tj2pqp8HJa3CUEt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcgASc6ht9cdrqMTCtdlXuKeSOnLBybycmq96kHWu0E3tBuIoCHazznLZ4rNrub/dBwcrC5Uwgt9Qj+rvIh4B1v2V6wcbqxD20BRMv7JRATnK4ReCPYca6/ag7gdHwQHlxgqdg4Nql76SaZoGcQjzQ2UofExiAcyoMgkKbGWiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtXC1NKw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-655ae329d6bso9490616a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 00:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768985430; x=1769590230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5YZG1zJ7jWuGeoMG2viDWNiVus/gdfkiySQBNQMP44=;
        b=FtXC1NKwz5A1ze/gwCPH1/m6ec38DwE95td7denVvt3kApmN/rIE3ji7LXN5NYTFDC
         t7kVf66wPssrbKjys82kK8twNGoN0q/AO1d4OoIOEwPr/AlCJ/UJ6Yo0XdEgPFce7+NF
         FlrJOp9H4bKEQzFmHxOMuezrcUESf0nDTdNMWn9IcEbmSJcj+VsRMewAeHzLh1jjwq2p
         AVzvBRcy1bIWAZvdImwTxbBeHCcgIp9dKhKHlB1kUGUNtkuaEVDaTjYDRBrC/y88JFGa
         RYAyERqCufRm20PPust1Wewl82Lc51WIXYuaXBSzQOOo0AiEXmeaRN3s3FLTrWofdwbk
         AVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768985430; x=1769590230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5YZG1zJ7jWuGeoMG2viDWNiVus/gdfkiySQBNQMP44=;
        b=qqWp8wMy6ILjgT0YK/X3g011Wj3ghi31h9PV38A2SPi27UY6P3HnvdJLqRcM3GEruL
         ULDuJZOmuy8Nd0dMTYOpGGmCmMqh511b2m2Ea8/Qi3fUbUxlgn5TxHh6jiIg0JzAAS65
         Szo2rqAIaq1fkYKGzWGOLlm37kMdPM7bZMgNCWwInPPVjTjUUrxsLVjAus7I8SIq2GIo
         naXBmNANvBNFU3eeYHLdFwyvzCDlBhlYSPu8l7qY747/eACSVRV5ppRqPJ7iouVhY0ge
         AOT+kS/XeMbfITgl/f2YXOZd5G2j7JNsxn+QbspRF5IGmzPuIgP7MXHnjUfUWDVaCnEJ
         BRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjg/+/I0pnoiJGeS22kB+0IdvLEAwJSKVQK0VwN4PRfxQZ/Bnmu8czaz+6ZNklZWTSu8n/y0sZQwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10J05TEqaJrg4TL8CwEmDC925WwTTypevJXG3vmKT8fQxjbm5
	ijal6s+ydaS8zkEKSBu25vzxmCoH/QaR9UmkkDrMzRZaZJ0Ci48pJWU4
X-Gm-Gg: AZuq6aL9NAVQD00xE9bsbtyAWVsk0kr/ZZ2Mdvq08YTKYP4pztVC/bu7T2Fuu1A6dHf
	KwNVYTpXFnPxC5XhXYkhOvM9PzKpQR5Wv61DncDyaMzTxs0ED8di/ojHu5cVYTqNO55oFzVC/d/
	TYJOg2/2sSdvx07btPAs2OiEdKHj7YtyKUefIRxKeXYDCUlLmZ3Q+D4eOT+6NFhQIThWl1/EH10
	sMYNxsbajqXQgcDxLjk2Uedpy3Yz9ByvxQbmrd7rfTojzmBnt06Y2T9v7mdzBu4k7o7HzfEkE8d
	X8Mq5ZF581niJfZycpgEQRx6zO05FI/JsfpEYzfq3MfhbsD4XQ4b0UuRq2z+os9nJq3QMAOizYo
	hWrFuTXpv5mEYWIS/2KCK2AYxkBPq9djcLv6Pt5IcHQeEFb2BXi8nJSUOtHgOXQsdGLu1exJtOA
	0VvoYThYcb7YUlf01vR0OlW6LCZ+5LNe/g2C9YEFUgd0YzwY8zZUAh0TXVuwJ2+MhuRmea+42kS
	uSP13pXeqkOroEL
X-Received: by 2002:a17:907:9410:b0:b73:7fc8:a9c9 with SMTP id a640c23a62f3a-b8796a5bce3mr1424085966b.29.1768985429526;
        Wed, 21 Jan 2026 00:50:29 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-5298-1165-6703-de60.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:5298:1165:6703:de60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795168c7bsm1627542866b.20.2026.01.21.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 00:50:28 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: do not allow exporting of special kernel filesystems
Date: Wed, 21 Jan 2026 09:50:27 +0100
Message-ID: <20260121085028.558164-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18225-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9D72C53E6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 fs/nfsd/export.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

Christian,

I had enough of the stable file handles discussion [1].

This patch which I already suggested [2] on week ago, states a justified
technical reason why pidfs and nsfs should not be exported by nfsd,
so let's use this technical reasoning and stop the philosophic discussions
about what is a stable file handle is please.

Regarding cgroupfs, we can either deal with it later or not - it is not
a clear but as pidfs and nsfs which absolutely should be fixed
retroactively in stable kernels.

If you think that cgroupfs could benefit from "exhaustive" file handles [3]
then we can implement open_by_handle_at(FD_CGROUPFS_ROOT, ... and that
would classify cgroupfs the same as pidfs and nsfs.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-0-1a247645cef5@kernel.org/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhkaGFtQRzTj2xaf2GJucoAY5CGiyUjB=8YA2zTbOtFvw@mail.gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-29-1a247645cef5@kernel.org/

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad196..232dacac611e9 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -405,6 +405,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
 static int check_export(const struct path *path, int *flags, unsigned char *uuid)
 {
 	struct inode *inode = d_inode(path->dentry);
+	const struct export_operations *nop = inode->i_sb->s_export_op;
 
 	/*
 	 * We currently export only dirs, regular files, and (for v4
@@ -422,13 +423,12 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	if (*flags & NFSEXP_V4ROOT)
 		*flags |= NFSEXP_READONLY;
 
-	/* There are two requirements on a filesystem to be exportable.
-	 * 1:  We must be able to identify the filesystem from a number.
-	 *       either a device number (so FS_REQUIRES_DEV needed)
-	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
-	 * 2:  We must be able to find an inode from a filehandle.
-	 *       This means that s_export_op must be set.
-	 * 3: We must not currently be on an idmapped mount.
+	/*
+	 * The requirements for a filesystem to be exportable:
+	 * 1. The filehandle must identify a filesystem by number
+	 * 2. The filehandle must uniquely identify an inode
+	 * 3. The filesystem must not have custom filehandle open/perm methods
+	 * 4. The requested file must not reside on an idmapped mount
 	 */
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
 	    !(*flags & NFSEXP_FSID) &&
@@ -437,11 +437,16 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
+	if (!exportfs_can_decode_fh(nop)) {
 		dprintk("exp_export: export of invalid fs type.\n");
 		return -EINVAL;
 	}
 
+	if (nop->open || nop->permission) {
+		dprintk("exp_export: export of non-standard fs type.\n");
+		return -EINVAL;
+	}
+
 	if (is_idmapped_mnt(path->mnt)) {
 		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
 		return -EINVAL;
-- 
2.52.0


