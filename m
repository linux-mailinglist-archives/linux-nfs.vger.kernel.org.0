Return-Path: <linux-nfs+bounces-22343-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yZrEKJMeJWrTDgIAu9opvQ
	(envelope-from <linux-nfs+bounces-22343-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 09:32:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBF64F057
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 09:32:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WluwxSFQ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22343-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22343-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4F23022AB4
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2026 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A945348C45;
	Sun,  7 Jun 2026 07:32:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD46305694
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jun 2026 07:32:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817529; cv=none; b=gLMQJIcuuzb0iF0PHfeeVpGi95qxqFQB5iK1UB9mZcIr6u9zyChlh2AQFlhI52O4tA1kOUAcMVzZcDTVYuLdTVffvSdPA0kwJtKrW8D4onkOxXMbX5zjKDtn3b6YitnSIsE0zYaju5eGOA4guJBEoli8+SLmyhf3m7oDSp6sirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817529; c=relaxed/simple;
	bh=ixLRwyZ7Jxo5tM81pF8bPmeIBDeeOOSq2YWj9b8+M0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ8yc8R+rxlsBMUQXro0I5czIbNI98d9dvKUaIUdJwussQKChwOcD1ozjrNnhzkHHwN37BjWbm0GM+U5QULpNt6h5mStJwdZe2O/7hzPjzgNFDbZ45u8gX1AstOMN3zSvmGKG8IMl4HTpHq7ZNVUdObe54dJy36s94xdsK1WrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WluwxSFQ; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so2271704f8f.0
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jun 2026 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780817526; x=1781422326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awuv5dGGzG/SbXd109I+wvKTasG/T2oytd+uKQuR6kU=;
        b=WluwxSFQUIlOv/Yki4ftq8ZQBoJqeGKJdy8y0epSKUD+SQN84qNLOtNWSn8J4ytBwq
         pS0D/ysI51vMmvJrjtuqeJaaI6DJR0/0gOzuB4GnYnf3m9yrqsh5VZStJMcRRABLyUZg
         Y0GNWctY/EQokjb69mYSV7A68W76EUj0Yu7RD+6NTYD0x6A84gtdxvNO4OPqyUd0C9fe
         m/hw6o/IafHf5QZ2SPUQ8sQtWBkaQOpU60u5cbUMwJaWT9Mgn0ypcyu3AWB4Q7ZxLMIh
         Ol1sP+ea/8r9YClg1mgWO3QuYB9zvkjSYPuZabmFfUwPF+51K+AGryz0TSQRvuZhlvJL
         uDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780817526; x=1781422326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awuv5dGGzG/SbXd109I+wvKTasG/T2oytd+uKQuR6kU=;
        b=mSzpVkzlQDzimXOOuI0a9GOxKDJK3FBG9l2gG9nBrL/ciZu0ODiE6adu05dtkHkTmA
         PMCQ2Pc/VT2Gzi8w5PyAwtesh5PxLm0CyXroe4lVGtUaExU/XzLdU067mS/FjaKCmNkR
         oMTegm3pHbyvwML3YF8c8EbV/wbqoGRuvW1SoEJXcFvi4Ur3ySpYXJVij9oBrlw63+OE
         Vo2sJRSiulMGwJrdpCUETpLP64uvxSMyPAbU6yFqLA8LFFbwWyRSECQGhggunK4yQTHd
         P5lWQLPHPOnfl0YZJwGqBxJM7FlVhjwejg9gJg+NPBF0HeJn2MMdx44g/iTfhqe+vCLJ
         tcfA==
X-Forwarded-Encrypted: i=1; AFNElJ/rkPxDCyK+J1uk5psUEvVxVucMUFftL1jH3jQBwhX0ihQR7kDzXh3ngKZxnA/Kd4Aa4EHpqo8huDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxdtDkRt/GxONwY+G4Azto3a+67VIbKdI6bltCj+cIjMCUMOV
	H5D+AMrNp7awQzg6LrXvkQ1BzdRXhb3pHR7Mi4oHAfyqV3VPK9KLDLkl
X-Gm-Gg: Acq92OF9oh0FHPDfe5xTEkH+rJrbcggJXzvr3hLsTResGw1FgvSm7PCqsNiNpQrChd1
	yITaa+j5W3IUn2eZ1kr3+LhtuhYqw2obLX2VoRibQCruKuSlgqbQqn5j71gx4hTK3jkk7aGbmSn
	BZI4J1HDodSz5k26Mx3z6z2DEqOayjqIJUtJPykgPs3Il4GeF21lMXTQsikoPdnAI5xe3PSIK38
	fbayJioSVxgiliG42RwgWy9Ezh8ZAZFkQmvDNv0tY+fSjf6g9nNhar+OQf4qjGbYO4V5hyTRq6U
	G6F68bVGLFlsZ5pYqQFlSE1f+byKqk+iuRz6txDOb52Exof3UgMsqXVcJiujzUgpRh1MIWPQY/e
	lbP0y4ugxthbLYNsPiDHO9wUXpQEN8x/gBn8nZ0vwQVuxHIxXhJTJ8797yd3xcIlsoBjdmwYFAR
	3I2MU4aHhDEebFcBzPMZ1zb/xwcQ7AB6oPH730ZXOyPitRtW8+2nGl
X-Received: by 2002:a05:6000:43c5:10b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-46030766a2dmr12519915f8f.35.1780817525922;
        Sun, 07 Jun 2026 00:32:05 -0700 (PDT)
Received: from puck (234.243.199.146.dyn.plus.net. [146.199.243.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm40459372f8f.26.2026.06.07.00.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 00:32:04 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Cc: axboe@kernel.dk,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH v2 1/2] nfs: add nowait version of nfs_start_io_direct
Date: Sun,  7 Jun 2026 08:31:54 +0100
Message-ID: <20260607073155.105314-2-dyudaken@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22343-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:axboe@kernel.dk,m:io-uring@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dyudaken@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dyudaken@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AEBF64F057

nfs_start_io_direct might block on existing operations to the same
inode. In order to support NOWAIT O_DIRECT reads, add a non-blocking
version of this nfs_start_io_direct that just returns -EAGAIN if locks
could not be taken.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
---
 fs/nfs/internal.h |  1 +
 fs/nfs/io.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index 8337f0ae852d..2faf2003faf6 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -109,6 +109,16 @@ static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
 	}
 }
 
+static int nfs_block_buffered_nowait(struct nfs_inode *nfsi, struct inode *inode)
+{
+	if (!test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
+		if (inode->i_mapping->nrpages != 0)
+			return 1;
+		set_bit(NFS_INO_ODIRECT, &nfsi->flags);
+	}
+	return 0;
+}
+
 /**
  * nfs_start_io_direct - declare the file is being used for direct i/o
  * @inode: file inode
@@ -149,6 +159,37 @@ nfs_start_io_direct(struct inode *inode)
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
+	if (nfs_block_buffered_nowait(nfsi, inode)) {
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


