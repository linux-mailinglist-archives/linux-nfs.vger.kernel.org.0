Return-Path: <linux-nfs+bounces-22554-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XfTJNE2oLmqS1gQAu9opvQ
	(envelope-from <linux-nfs+bounces-22554-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 15:10:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101A68117D
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 15:10:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KWXDCQ6A;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22554-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22554-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CFA3022073
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38B3A59A7;
	Sun, 14 Jun 2026 13:08:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3C383C8F
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 13:08:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442502; cv=none; b=BRJu7gvzzarkI0lYZMuSGHmA3M+8ykzpM4Mo9Sfq5OGi/K0IKceakklrwT0SYxsfIqfW3BiUCcBU5US1v09EvfdUU585eSA1v7nj43fwys4PZ5l4vQDIixy/28nfiIeepV9QNOJEvhoMWOH6UUNPJkHn6zfVjD25ft0zttqcjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442502; c=relaxed/simple;
	bh=3MtfM1Qyu/t87NzrDVA64XY6Ez056KsITzsVx5QU/rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge/XsvWH5O2qnORFqU0U+MUn9FdJrjNjmzf48LDQ3NzKiTyHaQRnktx3frNXoRMOpk+gfcohDdr/ZRQZUbazmnMvh8o45ETu3sDX9biRVypwIQv1I8owJ/egbsKf5bnZlhFuTxbajmsFcWmMFhc//qAzadDdNDlzn78dXn3lmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWXDCQ6A; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8cceaacd07bso31377106d6.3
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442500; x=1782047300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLcJQAEh9qnNHFXcDU3bTHmyrHQVoMdy5YkzbmFTV6M=;
        b=KWXDCQ6A2NSmaPJGTVFAcerVWsPYwmGDh0TbVo+0QlKdpQniQo5ELgwrHx03vadknd
         KGOW4QHkXBTO/6m4n4Z/AqT3+pWGmsIs5eagN7eEItqYcYTqVNoCbG8NkxNphFlLaG9S
         DrjqamGvaN3okSon+iiFaPddHBrXTa5vBoJ96Jvckeo3GUI/C87dTCu2qsqYiGamsGnM
         Rnd/BAAHJP/8W/jCvQhUCHF78CarQhYmqAKwUGqPVbuZWPcWLzTttKSEz6/2Bsii+dZV
         ZZ2Dn8sUl3c358Ow1oRV7LHtFd3o3o+LMm2pDEzpFekCpZgAKA2FBnT7hJp8leBxHc2l
         Qn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442500; x=1782047300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLcJQAEh9qnNHFXcDU3bTHmyrHQVoMdy5YkzbmFTV6M=;
        b=P76qP5dHQ9rYzar84K+P65myj4W2N1uwYwdUZs8Q9XNlR6YB2OSxrC/u5/FR9zJE7d
         IfR1z/OWcIKZOwB30cVd27MIczgKBX4SEHXJETksqCcGkjpSNGhJeKEZymF6gvqrWlu5
         +Pm+nWRH/iETa4uEZUZ+PI//QLApTN0oN/tb+zKDVnoTqk8gKr8YR8JLvugEa5NOqQQK
         Y1xOSl+6+QRYsZzcL/cyL0aon3AK85VodOOn6I9cWUMIx/sTl00CnzI6TdTAYMmz09U1
         J1ZcDE5XEc5on/A1simSe/Jd9Y/QEJ2omkVnKoxs/psm46YeX8jtwc5A2HxVcsnBgNNd
         CO+g==
X-Gm-Message-State: AOJu0Yx7l2MwP/R1PihcTqyxl3TARLjalrVvrCHqE+YS7ZDvUy1mgAV5
	0OGhg5ymQoftbhNn11uZMlIJizlfLk4fw02yjP+ies5xBnpOyICqlIug
X-Gm-Gg: Acq92OEEas8RC88gAzsaS1Ral3KML79bbe9UJ9JWnJ/L/Mq8SO8MD/xmWgWpLeImHlu
	Pdzc5YIu+TkEsTIWFeYCJu0zUwJTSydDAHNcCPujq22f4hqzY8MpFTnfOEa8b0pVtCepF5qoxHH
	0H0hfDYPVX9qcqJRU6xdA4VxTmma7JWsSxY3rXLHPhIRPt1TuzjlhEYqnX+YhqcH3dxc8yQ18NQ
	uZvqfj3xdJ/iHxMPbXX+pMPqixe+98HroI4twPuAmHUoiST3mxmPJ8uRHkO/LZsg/gVoo4XskYs
	JiZnS5sqJ+i2cKbEyQFQORj1+ggAQ+donHmIkmOR0erkmYWsHn73FBE4i/geS4rId8OCWjBS/gl
	Gk4CCjnKPtTtGxT5rCZBWs08/TReIkovJe4+4LkuVi2+Mp1uoccDrigfxdfsa3pnMgMukrnYm3W
	MN3UprG69KYykfib3Jkns7KqvV6E+Hve5Mpa2o8bpQjleLtR4VUgFXDuY3I+HTrwJJGMvnXhoqY
	hRpRyQEqiGudXltYcQIwRP+RMy2t4U19RC/0q88C0Y=
X-Received: by 2002:a05:6214:4002:b0:8ce:d101:6266 with SMTP id 6a1803df08f44-8d32bb3ca13mr172788006d6.5.1781442499921;
        Sun, 14 Jun 2026 06:08:19 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b2cf04sm77838966d6.16.2026.06.14.06.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:08:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] NFSv4.1/pnfs: bound notification bitmap length in decode_getdeviceinfo
Date: Sun, 14 Jun 2026 09:08:13 -0400
Message-ID: <20260614130814.2521819-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614130814.2521819-1-michael.bommarito@gmail.com>
References: <20260614130814.2521819-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22554-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4101A68117D

decode_getdeviceinfo() reads a server-supplied notification bitmap
length into a u32 and scales it by four for xdr_inline_decode(). The
multiply is 32-bit and wraps to 0 for len >= 0x40000000, so the !p
bounds check passes on an empty request and the verify loop reads up to
~2^30 words past the inline XDR buffer. A malicious or compromised pNFS
server, or a man in the middle on an unprotected mount, can drive this
out-of-bounds read while the client decodes a GETDEVICEINFO reply.

RFC 8881 defines only the CHANGE and DELETE deviceid notification bits,
both in word 0, so a conformant reply uses a single word. Bound len to
NFS4_GETDEVICEINFO_NOTIFY_MAXWORDS before scaling, which cannot wrap and
still tolerates trailing zero words the decoder keeps verifying.

Reproduced under KASAN on QEMU via a KUnit case driving the real
decode_getdeviceinfo(); the out-of-bounds read is gone after this change.

Fixes: b1f69b754ee3 ("NFSv4.1: pnfs: add LAYOUTGET and GETDEVICEINFO infrastructure")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

Reproduction (v7.1-rc4, x86_64 QEMU/KVM, KASAN):

  BUG: KASAN: slab-out-of-bounds in decode_getdeviceinfo

A KUnit case (patch 2) drives the real decode_getdeviceinfo() with a
0x40000000 notification length placed at a page edge; the wrapped 4*len
multiply over-reads the receive buffer on stock and faults. Patched, the
length is rejected with -EIO. Two benign in-bounds controls pass on both
stock and patched. fs/nfs has no existing kselftest for this decoder.

 fs/nfs/nfs4xdr.c     | 6 +++++-
 include/linux/nfs4.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c23c2eee1b5c4..ca84d0c872a6c 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6089,7 +6089,11 @@ static int decode_getdeviceinfo(struct xdr_stream *xdr,
 	if (len) {
 		uint32_t i;
 
-		p = xdr_inline_decode(xdr, 4 * len);
+		/* Bound len so len << 2 cannot wrap and defeat the check below. */
+		if (len > NFS4_GETDEVICEINFO_NOTIFY_MAXWORDS)
+			return -EIO;
+
+		p = xdr_inline_decode(xdr, len << 2);
 		if (unlikely(!p))
 			return -EIO;
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index d87be1f25273a..d6a84c4545864 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -752,6 +752,9 @@ enum pnfs_notify_deviceid_type4 {
 	NOTIFY_DEVICEID4_DELETE = 1 << 2,
 };
 
+/* All defined deviceid notification bits live in word 0; bound the decoder. */
+#define NFS4_GETDEVICEINFO_NOTIFY_MAXWORDS	4
+
 enum pnfs_block_volume_type {
 	PNFS_BLOCK_VOLUME_SIMPLE	= 0,
 	PNFS_BLOCK_VOLUME_SLICE		= 1,
-- 
2.53.0


