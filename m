Return-Path: <linux-nfs+bounces-22121-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF44Mq9jG2o2BwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22121-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 00:24:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B6B613A73
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 00:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB060307A7E3
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1437C915;
	Sat, 30 May 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPq5gxhV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADA37B021
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780179611; cv=none; b=Iz9CvDy4oRv9jjjISHnw6lB9iUiecZ0opxZri86akkCWydwurd9rois/Pu6Xkn6+1Shvx0mHw1e+YP3M/5RWhHcBoLTioix8c4DIHzhkjtO87KMi8MiUfPkuDWvMMoF2XjLAvtkf2qolpESo9litQ1EEMBcIXveBhgMNXCvs5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780179611; c=relaxed/simple;
	bh=fXiH8h7PEvwaHD4dyUu+ol+a5g1XNap+MJztQQxaw6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjeQ04eOG1NiHl+czBbJVZ0OfbJweDmqwxxUC/392CALvzvPS2K5QBm4Tqg3XHYooAZTlNm24y4wOL+7+D9mVJ3U65Zo9WhDoWZF3iDQbOk1D5/jzOd8YYXisvQKepvwEOhfYSoaFMqprynkVshBjv+BIucxKK4Pw1AXR9U1p0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPq5gxhV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so1423086f8f.0
        for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780179607; x=1780784407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRFbpWDbRDz2hKuWATKrH2KKYigHlPqpASSyCuCCDYY=;
        b=GPq5gxhVlm9YIJHjdmYhTzupiSsKiq8J8wNYnMPM4Py9PoeUPb0StlZZ/JwWOBU/VN
         Q6TzuNtyS7uvm6ilHSQdKgvADYYKejGJzNl/m3GKKa93halpCta6rhwUsZ+pAkpMU4Sd
         cI7w4yfCArHTj6sJhvvUiil44eH1iSzqLdz73RcTR7+k6is/I8iiLuT2h6ma2L6cF1YR
         7F9z1Xi4spd2AnLTRi7GxICXBs1Ert6BIbrLPlc/945a/Dghch+NWtlWNnlge7OHXqoU
         DzusABHQHDJgdJgjZKELQM43vhx5rxQlmOZmThFujpuZOlEmHnukZtWB349t3vTq+HIR
         ZomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179607; x=1780784407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRFbpWDbRDz2hKuWATKrH2KKYigHlPqpASSyCuCCDYY=;
        b=fOHbO1cB2VgZHCC0cmnmcW/SwjEc72a5NoNhCXFo8g1jijITb2rQGnW80RCljrSvK0
         Y8rcLvoz2sssaw1ZuJksfLfa3LvJZB2t55I45z99pah9ggLP+5l7u3UG35J6KR73IyJY
         /OH1CEIvZzmsuydwfBnngPSbgfKBfqBFQn8unL1eQfcU56JJCEMbZC1LNnkuioItXAlA
         5+NESb0kLUs8a8Y/RmK3p0apu8iat2oAw5hnNjjG1MESw6f5dOZnXbF2/sBuvv1lP62E
         //itVyY4qmKZfiS3UTgMb91YQzmPqhf0AFAuemQKv6TW++6wyKoHvj+wzoHzf1BD/4rO
         iPJA==
X-Forwarded-Encrypted: i=1; AFNElJ9nkOQLg3kVts2ZHvybanQSRbCr8N0fX0Q5r+IVG4MkDxR4C5hw6yN1ijM0+3Dr0xqv5R6Kh3Ilyok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNiMaILdwx/HN/Y433UmslSFaKzS9t+HFnXYfUWAcVKBPFQmg
	YtpAerG2a+u2cgh+IHG4oq+gxD/uoTGFg6LKBCixFmYxS1O5RajNzl+z
X-Gm-Gg: Acq92OGblArgq9aWI8WVE1The8QDxEV91LtcmRwQUYubq77XwqlhRrbYu6Z8XlzGxcV
	8iYVMOQeccWxmC0293WCebjbCeRG717+okdII8bP+M1JBixkS1cbadWyLv7RKqhB66vU1hxZOcH
	H/OfMJh2eLm5Wu6W9Z+L530MJSZc10a+d3axx/w9j9iOE/zJyGhWu3BAFkJTuvwC23TfkUi8w+8
	Y2In2C/zJWopvqsfzP8yGvg2IGvejS+huDuuT22hXEtqyWDMCZyP/nr6fIwSFCgM3PpFLhNa840
	XtM1HbSfzWyAdRhsDVSwLJBAMF+5TmRxq8TrykQ6I/ftKbJGjU5VVBGs2Iqcl/K7ojijTOc+eI5
	fh5x+WqVoxuPTJsFdgEOP5n/2cr229UPeJ/hxE5L7UrwgRDxpCnvZhZDoqxOKnO9U1+FSOMbHvg
	95JsD//BczFtfvG70hMeQCzOQBwsEow3Zeq5b5KkzCry/WSqE1bNSl
X-Received: by 2002:a5d:4b04:0:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-45ef6b5b49dmr6538243f8f.22.1780179607132;
        Sat, 30 May 2026 15:20:07 -0700 (PDT)
Received: from puck (234.243.199.146.dyn.plus.net. [146.199.243.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm13443784f8f.18.2026.05.30.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:20:06 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Cc: axboe@kernel.dk,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH 1/2] nfs: add nowait version of nfs_start_io_direct
Date: Sat, 30 May 2026 23:19:46 +0100
Message-ID: <20260530221947.49518-2-dyudaken@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530221947.49518-1-dyudaken@gmail.com>
References: <20260530221947.49518-1-dyudaken@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22121-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyudaken@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 84B6B613A73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfs_start_io_direct might block on existing operations to the same
inode. In order to support NOWAIT O_DIRECT reads, add a non-blocking
version of this nfs_start_io_direct that just returns -EAGAIN if locks
could not be taken.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
---
 fs/nfs/internal.h |  1 +
 fs/nfs/io.c       | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 18d46b0e71dd..0c9aca624353 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -532,6 +532,7 @@ extern void nfs_end_io_read(struct inode *inode);
 extern  __must_check int nfs_start_io_write(struct inode *inode);
 extern void nfs_end_io_write(struct inode *inode);
 extern __must_check int nfs_start_io_direct(struct inode *inode);
+extern __must_check int nfs_start_io_direct_nowait(struct inode *inode);
 extern void nfs_end_io_direct(struct inode *inode);
 
 static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index 8337f0ae852d..f359a19f7879 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -101,12 +101,15 @@ nfs_end_io_write(struct inode *inode)
 EXPORT_SYMBOL_GPL(nfs_end_io_write);
 
 /* Call with exclusively locked inode->i_rwsem */
-static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
+static int nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode, bool nowait)
 {
 	if (!test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
+		if (nowait && !mapping_empty(inode->i_mapping))
+			return 1;
 		set_bit(NFS_INO_ODIRECT, &nfsi->flags);
 		nfs_sync_mapping(inode->i_mapping);
 	}
+	return 0;
 }
 
 /**
@@ -143,12 +146,43 @@ nfs_start_io_direct(struct inode *inode)
 	err = down_write_killable(&inode->i_rwsem);
 	if (err)
 		return err;
-	nfs_block_buffered(nfsi, inode);
+	nfs_block_buffered(nfsi, inode, false);
 	downgrade_write(&inode->i_rwsem);
 
 	return 0;
 }
 
+/**
+ * nfs_start_io_direct_nowait - non-blocking variant of nfs_start_io_direct()
+ * @inode: file inode
+ *
+ * Try to declare that a direct I/O operation is about to start without
+ * blocking.
+ * Ensure all buffered I/O is blocked.
+ * If this could not be done without blocking then returns -EAGAIN.
+ */
+int
+nfs_start_io_direct_nowait(struct inode *inode)
+{
+	struct nfs_inode *nfsi = NFS_I(inode);
+
+	if (!down_read_trylock(&inode->i_rwsem))
+		return -EAGAIN;
+	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags))
+		return 0;
+	up_read(&inode->i_rwsem);
+
+	/* Slow path: try to flip NFS_INO_ODIRECT without blocking. */
+	if (!down_write_trylock(&inode->i_rwsem))
+		return -EAGAIN;
+	if (nfs_block_buffered(nfsi, inode, true)) {
+		up_write(&inode->i_rwsem);
+		return -EAGAIN;
+	}
+	downgrade_write(&inode->i_rwsem);
+	return 0;
+}
+
 /**
  * nfs_end_io_direct - declare that the direct i/o operation is done
  * @inode: file inode
-- 
2.50.1


