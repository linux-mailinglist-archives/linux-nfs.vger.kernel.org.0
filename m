Return-Path: <linux-nfs+bounces-22555-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id siM7BdqnLmp+1gQAu9opvQ
	(envelope-from <linux-nfs+bounces-22555-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 15:08:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D802681155
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 15:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YoBq16Fe;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22555-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22555-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20FEA300E63F
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B539FCBF;
	Sun, 14 Jun 2026 13:08:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D43A5E71
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 13:08:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442505; cv=none; b=oXXmZoGpjRLb0KWdhgqcXRhUPjN2w94QqXxMAlDW48twJ3oCfPepLCM/V47l3axAJvudGsApT79Srs0YF52XTfqc5i2twuQHKOuPpIE8KXww1vn5slF4B6jFH2dVIn6Ia2vg4XtFfxGH3c3kGSgIVwFLu16scXtfCchXXliRs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442505; c=relaxed/simple;
	bh=MpLnIeYn7owYSdnYQlJ38aky7+NM7yEMTY5VxwzIAcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7PoctvOZSk2/8ef69oXdwpo4dgDpnLzfDowQH05xEUf8z8M0yDj1CWkrHOUxKdyiiqu12mRKh5oCx6ukWjwuCUA4q+yoDSsZ3TWyBoxxSwxkKd7chRVNWpOHDm+4i7CdLnjGCVBmwZdaU9XMMG93slJL8+NLrggdpEVvoI8wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoBq16Fe; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso27815556d6.2
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442501; x=1782047301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnL26yNc7x7CUKnmGQn06aGfaRhQ08nHiRAS64LIsU8=;
        b=YoBq16Fer6ypaxqbr7/m5rkyM7NmFt/BDdRw1ZE9Jc1kFtduZTsY3hn6w6L0LqWeLF
         ZYjFBZ54rDdrNon5bn5QLvswWl3Be1gzJKyVkQlt+pUIcrJIdN+faIEicuNaPigw6C/L
         Y4ld9WbMiK49Dpgq4MbSMkHpXG4sz38Xud291M4E+a23zkByM82fDZ2PNTVZ3co/GpXB
         K5Cw124ooUnLN9gJVwQxVARG4zNMOcVtVLhXAiHc5AdkrVEZc7cEceGD+IOg97MwoXfh
         LjC2G8xQpupz/qm2YxJ2/ul0azy2MguO64ugPO0xAo+HYIlRKvnCMG1T9ZCDJB9DaLPW
         0U8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442501; x=1782047301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hnL26yNc7x7CUKnmGQn06aGfaRhQ08nHiRAS64LIsU8=;
        b=TvOc0LICkmLe6WQqY9Z0j1KmXItUoglp9sIXwKlHf9izFVLVjN9zIGilYN+EU56uIn
         DBSksTGHqqLHgSQE9Zaj84OsQElST8ewxdH8AB6CoJqdh8noTCUQN+PomYj9GaabIweS
         hxpEhG8DvhQ4m0wNvJao/sOOAMMMXNNutwhCS+A2BQ7zJh/Y71VpRg59UYdTtOFb1qUX
         NPgV+InaHXtZynmIbGVRc5dE4qEk5nKsFn6Pp5q3sDnCoqBWDGn9G6VssogrEdN1PKKP
         xcL3uKSJWE65KxjMcjNyVE8CvJR+cDdOf3EtCk3oHFXoad5zyJxpuCtVNFZDQ69bC8mR
         5MLg==
X-Gm-Message-State: AOJu0Yy8apAy6Gn/Di/ggX4hjzYz5aitbNT/iN0Dr54PBAj1jRItc8BL
	5vlF7EQw2ZpRiastMIDa77SI1gPic0+DKhAmYe5Y1EBh+EJcz/BD9gRRHSDKuMST
X-Gm-Gg: Acq92OHThby5UX4BqCOvAcrKdG4tYWunrlw9AO49axSYGPsosIydKJ/pOd/CB3dp0u9
	w9Q+5h6JqvrFiOc3CQfAjCNhkKeRfIMeeA35+O1Tg7qe90wAMb9HLvzmTaAGCWdD1dffJNDpCmg
	YxYoSN7F9xNNjrspM1c+vnaWU0fBYss4rMUR7UKA04HeN6vPr2zCLLFsihcD6hj+fAc+zDvVgbi
	SfZcyGZhin4toeIvCWSboaE3BPiPgZKeXeDUVT5JbSW6xFi7JiBX4zMymdxWJKKbe2SJlZQTH8H
	OuMWq3sQEHcvph/0EZp4S2ry4NWRpQIQouKKMnUePowGO1u5c3qZcJqAf3bDfM6PZx61c0YLBFs
	ag5C34Iiy+fB2J4EIJRX5aIEkhp3XN2BwYqkqlAN5gILA1kjj99pP3dVsV9/K87JD33WjUqmjBc
	syNWh+aLaTy/lVu/coph3sTx4MBP0FNl1laSmEdItNhZVdWFq/IF7emM2EqgRabxo+UsqsoG1tt
	KKGb0YEIrotCu7XCU8tCoqWWfTSJnG8neCAo/vPHNI=
X-Received: by 2002:a05:6214:53c1:b0:8cc:e8f4:1636 with SMTP id 6a1803df08f44-8d32e30e81fmr199155156d6.25.1781442501242;
        Sun, 14 Jun 2026 06:08:21 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301b2cf04sm77838966d6.16.2026.06.14.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:08:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] NFSv4.1/pnfs: add KUnit coverage for GETDEVICEINFO notification decode
Date: Sun, 14 Jun 2026 09:08:14 -0400
Message-ID: <20260614130814.2521819-3-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22555-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D802681155

Add a KUnit suite driving the real file-local decode_getdeviceinfo()
over a crafted GETDEVICEINFO reply to cover the notification-bitmap
length pass. It is included into nfs4xdr.c (gated by
CONFIG_NFS_GETDEVICEINFO_KUNIT_TEST) to reach the static decoder without
exporting it.

A trigger supplies the wrapping length and two benign controls drive the
same decoder in bounds. Integer overflow has no sanitizer, so the oracle
is the downstream KASAN slab-out-of-bounds read: on QEMU x86_64 with
KASAN the trigger faults on stock and passes after patch 1, while both
controls pass on stock and fixed trees.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

On QEMU x86_64 with KASAN: the trigger faults on stock (slab-out-of-
bounds READ) and passes after patch 1; both benign controls pass on
stock and patched. The suite builds the reply in a kmalloc(PAGE_SIZE)
buffer with the notification fields in the XDR tail.

 fs/nfs/Kconfig                      |  14 ++++
 fs/nfs/getdeviceinfo_notify_kunit.c | 110 ++++++++++++++++++++++++++++
 fs/nfs/nfs4xdr.c                    |   4 +
 3 files changed, 128 insertions(+)
 create mode 100644 fs/nfs/getdeviceinfo_notify_kunit.c

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 6bb30543eff00..73cdf201ebb23 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -215,3 +215,17 @@ config NFS_V4_2_READ_PLUS
 	default y
 	help
 	 Choose Y here to enable use of the NFS v4.2 READ_PLUS operation.
+
+config NFS_GETDEVICEINFO_KUNIT_TEST
+	tristate "KUnit test for pNFS GETDEVICEINFO notification decode" if !KUNIT_ALL_TESTS
+	depends on NFS_V4 && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit coverage for the notification-bitmap length pass in
+	  the NFS client pNFS GETDEVICEINFO reply decoder. The test drives
+	  the real decode_getdeviceinfo() over a crafted reply and, on an
+	  unfixed kernel built with CONFIG_KASAN, reports the slab-out-of-
+	  bounds read caused by a 32-bit overflow in the notification-bitmap
+	  length handling.
+
+	  If unsure, say N.
diff --git a/fs/nfs/getdeviceinfo_notify_kunit.c b/fs/nfs/getdeviceinfo_notify_kunit.c
new file mode 100644
index 0000000000000..1bfc40aabd15d
--- /dev/null
+++ b/fs/nfs/getdeviceinfo_notify_kunit.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit coverage for decode_getdeviceinfo()'s notification-bitmap length.
+ * Drives the real static decoder over a crafted reply: with len = 0x40000000
+ * the u32 "4 * len" wraps to 0, defeating the bounds check, and the verify
+ * loop reads past the buffer. The length word sits at the page edge so the
+ * first over-read word hits the KASAN redzone. Level 2; from nfs4xdr.c.
+ */
+#include <kunit/test.h>
+
+#define GDI_OPNUM	47U		/* OP_GETDEVICEINFO */
+#define GDI_LAYOUT_TYPE	1U		/* arbitrary; pdev->layout_type matches */
+
+/* Fixed fields in the XDR head, notification bitmap in the tail ending at @tail_end. */
+static int run_decode(struct kunit *test, __be32 *tail_end, u32 notify_len,
+		      u32 notify_word0)
+{
+	struct pnfs_device pdev = { .layout_type = GDI_LAYOUT_TYPE };
+	struct nfs4_getdeviceinfo_res res = { .pdev = &pdev };
+	struct xdr_stream xdr;
+	struct xdr_buf buf;
+	__be32 head[4];
+	unsigned int tail_words = notify_len <= 2 ? notify_len + 1 : 1;
+	__be32 *tail = tail_end - tail_words;
+
+	head[0] = cpu_to_be32(GDI_OPNUM);	/* op_hdr: opnum    */
+	head[1] = cpu_to_be32(0);		/* op_hdr: NFS_OK   */
+	head[2] = cpu_to_be32(GDI_LAYOUT_TYPE);	/* device type      */
+	head[3] = cpu_to_be32(0);		/* mincount = 0     */
+	tail[0] = cpu_to_be32(notify_len);	/* notification len */
+	if (notify_len == 1) {
+		tail[1] = cpu_to_be32(notify_word0);
+	} else if (notify_len == 2) {
+		tail[1] = cpu_to_be32(notify_word0);
+		tail[2] = cpu_to_be32(1);
+	}
+
+	memset(&buf, 0, sizeof(buf));
+	buf.head[0].iov_base = head;
+	buf.head[0].iov_len = sizeof(head);
+	buf.tail[0].iov_base = tail;
+	buf.tail[0].iov_len = tail_words * sizeof(*tail);
+	buf.len = buf.head[0].iov_len + buf.tail[0].iov_len;
+	buf.buflen = buf.len;
+	xdr_init_decode(&xdr, &buf, head, NULL);
+	return decode_getdeviceinfo(&xdr, &res);
+}
+
+/* Control: one-word bitmap (len 1, word 0) decodes cleanly; PASS stock+patched. */
+static void getdeviceinfo_notify_control_len1(struct kunit *test)
+{
+	__be32 *obj = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+	/* Place reply mid-buffer; nothing reads past it. */
+	ret = run_decode(test, obj + 32, 1, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	kfree(obj);
+}
+
+/* Control: len 2, nonzero unsupported word -> -EIO in bounds; PASS stock+patched. */
+static void getdeviceinfo_notify_control_unsupported_len2(struct kunit *test)
+{
+	__be32 *obj = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+	ret = run_decode(test, obj + 32, 2, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	kfree(obj);
+}
+
+/* Trigger: wrapping len 0x40000000 at the page edge -> KASAN OOB on stock, -EIO patched. */
+static void getdeviceinfo_notify_trigger_oob(struct kunit *test)
+{
+	__be32 *obj = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	__be32 *obj_end = (__be32 *)((char *)obj + PAGE_SIZE);
+	int ret;
+
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+	ret = run_decode(test, obj_end, 0x40000000U, 0);
+	/* Reached only on the patched tree. */
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	kfree(obj);
+}
+
+static struct kunit_case getdeviceinfo_notify_cases[] = {
+	KUNIT_CASE(getdeviceinfo_notify_control_len1),
+	KUNIT_CASE(getdeviceinfo_notify_control_unsupported_len2),
+	KUNIT_CASE(getdeviceinfo_notify_trigger_oob),
+	{}
+};
+
+static struct kunit_suite getdeviceinfo_notify_suite = {
+	.name = "nfs4_getdeviceinfo_notify",
+	.test_cases = getdeviceinfo_notify_cases,
+};
+
+kunit_test_suite(getdeviceinfo_notify_suite);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index ca84d0c872a6c..42eb82ab0346f 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7788,3 +7788,7 @@ const struct rpc_version nfs_version4 = {
 	.procs			= nfs4_procedures,
 	.counts			= nfs_version4_counts,
 };
+
+#if IS_ENABLED(CONFIG_NFS_GETDEVICEINFO_KUNIT_TEST)
+#include "getdeviceinfo_notify_kunit.c"
+#endif
-- 
2.53.0


