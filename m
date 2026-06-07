Return-Path: <linux-nfs+bounces-22344-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hA6YF4seJWrODgIAu9opvQ
	(envelope-from <linux-nfs+bounces-22344-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 09:32:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E081264F051
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 09:32:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B72W9hcH;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22344-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22344-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52108300D4F8
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2026 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DC63090CC;
	Sun,  7 Jun 2026 07:32:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0863469F5
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jun 2026 07:32:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817530; cv=none; b=pvVXDuyZY0P4tEjnHEAmewyarkNKwIEDGVZELLNwy4gWU9R4Up6l913NcfLUwJWtxP3OHJTbEvFKmCWdtL5H9FrGphf7SzIt0H1Paii4YhgD1JcR4QmL76w0nnJl+VZVNmSU4w5ck1AMtE5s1wMChwXmtHBXEHqsErzcnolzd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817530; c=relaxed/simple;
	bh=TcJi1kY6w0L+kvlTtQn8bf3Yvzy8onv7gAt+BEvpDSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4V2dMm7oktEgiBkC/vdF6sgwcv4CGYvxgG0RRB3PXDCuKUNRHaDk9NT6DR2n10IHEvgTrfbCn9hXXHGRQs7Nwbwwh0JWuVGtvRhrJDm2nDeNQOIG/10Sta5zvQ7N8Svn5yAt8CBA73wEfEH8iT6neIo85U9W0ML8AObKci5s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B72W9hcH; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef1198766so1772161f8f.0
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jun 2026 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780817527; x=1781422327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL6OlgcDlgjF+B0ED6UmCWmqxd3IQOhibpTPajkvSC4=;
        b=B72W9hcHAMrCc22dO4/1Jhn4x7kFV8mUWhzhn8sCbCPTK29D1FZ9AevaQm2xj/+mJ3
         cB3VhI44FRldOp03ZL8pjRbF6ItInLbZGb/2/Q4t8kusV5K6mYtQUNnQ/Bkj5Poa4Kaa
         Jg686BrFEfq5U8O+S7wAVw9O4WCV0bKZf9f/UcfgmtA8XRTF4gYvzvpmHzfXug+5/cKl
         7I1IX0jjy0XTkYFRa6+GTnA3LXwW5R94aJRAqImkjoXLdu7HJLy3o+xieL0XzS5Ap2n0
         IVVkfrpzpp54UaAMvKPZQU9B6GfK2mx3/3vJowiyCJRm/cZ/dFY7RBcy2fvFExSN0fTQ
         keRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780817527; x=1781422327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uL6OlgcDlgjF+B0ED6UmCWmqxd3IQOhibpTPajkvSC4=;
        b=LT7aWiBCkNJ0hHomp64Oaypki6bFRjUlpeMpt74uh08deTpOnsMFOz8nL9aFZ3aG3k
         v2+4DLRrwdwxt3SxDe7+pGRV/cTuInnNexShidJp5KWr+dLttrZFswKL606Jc9YSWYaT
         FM2sw8CIbfHiZoShNctbB/uJ3A48p95vJWh3VJRCXvrqG2tX4M19OTgPNVmM99oZE55n
         Rq8aH48q1ufb/emmg1Zs3VhaDAJa0k4bSijKxgfaskqVrHm8dPY7HHk/Pm0WS6WLIbHe
         ufekN18m3eKKxc8KIXnZ6KxtAR15Mc2dOWzQelUHLkEZRxiocY0zfqYFe2bdV56poz7b
         DmJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9e0yig+NZYsFISMoujdGN/Zm+xVqG4qtPqyLAePH3Kt0tjDtfCXU4tesE7ULPzEElq9HAiKapv24w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gjALvDKsdZj9L2KNTuE3RvfcPClnOQOo6q8X2LoxAVHR0GOM
	mqoAa7axJ+S55/gzulJlSKszbRx/7BO8fdMZZaF8hZDcsV+O5p2cagLWYUvUYQ==
X-Gm-Gg: Acq92OGPqvHmSdy/pGfPml9wzarJCrLkZe9vWospQLGkIVtP2zYZDLOqLxvhoqrH/iE
	30VGyM1fPwmPXSBFcHuWWHllg4K6sk/lhpsvvU060pcA5cZiXaY8UqA9NATposNNZ8Ze2uqFDXD
	Lg8zhqeZPS13ms1WQFnO4x+d/eTH4YYrB3/PIzS+NnSKlfqC45SluO28M2bP+UzklzQ9qvoQLTH
	LRbY6r5HA6i6sQBAbhAIFHy3X+EUTsOeFRouErk6XIBa45lsAQRHhT+VIGovL3yvkUj9gR8N0d6
	BNdiKrkbloGfG8pAaHenJEstBfB8q08kO4y20yQ/E41YqyVjvSWXIwR7OHVYMTU0MEi2va5ui0w
	SiM0E2q83kUECcQYWpYxynpxjZi4XLqrLws6Hrb/goq8K4GWHlFbkLtZroe6tuSp2NkvdJYflkZ
	Uv4Qs2PjzQlsJItXrOWUE7f6eNxuZ36ps66T86j7j/PSAawLV3Q1Fd
X-Received: by 2002:a05:6000:4b07:b0:460:21e7:330e with SMTP id ffacd0b85a97d-46032b8164fmr13341511f8f.10.1780817527355;
        Sun, 07 Jun 2026 00:32:07 -0700 (PDT)
Received: from puck (234.243.199.146.dyn.plus.net. [146.199.243.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm40459372f8f.26.2026.06.07.00.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 00:32:06 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Cc: axboe@kernel.dk,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH v2 2/2] nfs: expose FMODE_NOWAIT for read-only files
Date: Sun,  7 Jun 2026 08:31:55 +0100
Message-ID: <20260607073155.105314-3-dyudaken@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607073155.105314-1-dyudaken@gmail.com>
References: <20260607073155.105314-1-dyudaken@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22344-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:axboe@kernel.dk,m:io-uring@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dyudaken@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dyudaken@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyudaken@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E081264F051

NFS O_DIRECT reads already (mostly) handle async requests, with the
exception of locking the inode for direct.
Handle async requests properly by using nfs_start_io_direct_nowait,
and then expose FMODE_NOWAIT since it's now supported for direct reads.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
---
 fs/nfs/direct.c | 12 ++++++++++--
 fs/nfs/file.c   | 16 +++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 48d89716193a..e626c72495e6 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -466,14 +466,22 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 		goto out_release;
 	}
 	dreq->l_ctx = l_ctx;
-	if (!is_sync_kiocb(iocb))
+	if (!is_sync_kiocb(iocb)) {
 		dreq->iocb = iocb;
+	} else if (iocb->ki_flags & IOCB_NOWAIT) {
+		result = -EAGAIN;
+		nfs_direct_req_release(dreq);
+		goto out_release;
+	}
 
 	if (user_backed_iter(iter))
 		dreq->flags = NFS_ODIRECT_SHOULD_DIRTY;
 
 	if (!swap) {
-		result = nfs_start_io_direct(inode);
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			result = nfs_start_io_direct_nowait(inode);
+		else
+			result = nfs_start_io_direct(inode);
 		if (result) {
 			/* release the reference that would usually be
 			 * consumed by nfs_direct_read_schedule_iovec()
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 25048a3c2364..a0d8f1c1cf10 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -72,8 +72,12 @@ nfs_file_open(struct inode *inode, struct file *filp)
 		return res;
 
 	res = nfs_open(inode, filp);
-	if (res == 0)
+	if (res == 0) {
 		filp->f_mode |= FMODE_CAN_ODIRECT;
+		/* flag NOWAIT on read-only files only */
+		if (!(filp->f_mode & FMODE_WRITE))
+			filp->f_mode |= FMODE_NOWAIT;
+	}
 	return res;
 }
 
@@ -166,6 +170,10 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return nfs_file_direct_read(iocb, to, false);
 
+	/* NOWAIT only supported on direct reads */
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
 	dprintk("NFS: read(%pD2, %zu@%lu)\n",
 		iocb->ki_filp,
 		iov_iter_count(to), (unsigned long) iocb->ki_pos);
@@ -705,6 +713,12 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 	trace_nfs_file_write(iocb, from);
 
+	/*
+	 * FMODE_NOWAIT is not set for writable files
+	 */
+	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_NOWAIT))
+		return -EAGAIN;
+
 	result = nfs_key_timeout_notify(file, inode);
 	if (result)
 		return result;
-- 
2.50.1


