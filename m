Return-Path: <linux-nfs+bounces-14378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D478B5535C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A36B1D665B8
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70212222A7;
	Fri, 12 Sep 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq5C6nyX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E6221D96
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690849; cv=none; b=ZeBk+GjVcNrW1ynN+xNP0az3CMbz25QUwXRShKmjugY8b8O549gOsDGwD2Wx5yPFJexDrMIsHt81rPPRF/rA6hwNtkPxtNqCNiUSrOSzq1QaopqBJJ+jlg7HVmdE2vxLtVvwFCh5PBHzFjGXDBgjFtpBaPn8Ke9LoeYTKBEZLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690849; c=relaxed/simple;
	bh=gX9LM04WuGkmadDIeCCzsTULPHnflype1+UrWxWmNd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kggsNQunqFGAh9iPY1QDLulYBq+A1Ep+0MxmGgD0S8LYdRPBoRH089na5bxOryKsW6P7gChkhIZeIRS4dbv/iGoMwmwhlaLznn1/0QTfABeUjHPVW/iTpQSQRCaJd53DPRgDApnqDraUeRCW9m3flKRf4eT3MyWyBJhysSJzMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq5C6nyX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7741991159bso3052555b3a.0
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757690847; x=1758295647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkS1HpoO21kqYsaFddGIvi50oyb/ms3N1SDnlykzSp4=;
        b=Cq5C6nyXfYUZ/oAMt3BrfWNxoseLIW5v8L7owvmXwhuygiegx3wjHX76XESS8FgHmh
         p1EC/KgIDp3SLSnEOzGychfvTJ6cvtBXD1Udnb6izdZzlZVYYESHBfQCNSEdmqKwd2p2
         RupMlKMcX3eLuRiqnqYDJVIs1JPNHJ2IrlkCSrjqy12qwNoTr/ybAjNfL5njfvPaGD1a
         zLM/Pog+GshljgjbXbqIfMluCQUmh4oLBusq2Abn9TWflCMJRxHtG+HkXjnSeBJ4Ujfa
         Sa5jZfWN3NCKlFZ7bIwR9gUMSVNOkmFIkdCKCdnP+yN8bM4WaLRxaDuiCGUX2U3RhFI1
         Se6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690847; x=1758295647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkS1HpoO21kqYsaFddGIvi50oyb/ms3N1SDnlykzSp4=;
        b=c1Yn4RAt3Lo1+UHZTayxOQyxAk5kvcl4bH6FPDSAZPQlcsrt3HfB6aKNKGrYuDmL75
         faNsjb07WgwRbvkc3W5oyz651/q8jtLSVpV6bi9/ChUjroKcuwQAXd8W8KrRQyBlvBre
         v6LVUoP8xcYIGWLtcUaNbpvgJyiCn4jGI38762Ap8gckYsxLClMt30bsb8s4r/02hhSh
         zDsT654wkg1sMPaAX86mBjfQ69RC5QLsNo0zyPwOWJWEK+eSjs36Lq7YM3W+HQxAOwiK
         Qnaf7qyN9uz+x+rREpThPJ8bbDtETDlSqYoJC+sGTYyoQCTDApBJtk2037lgOZeRQFhb
         5IWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+suxO2yoIlOUSIsUyHPuQSgImR006QfbPlj0/FraoMDWHmVaAh5OVJiRt++YbUzFdLq9gHC6+Ync=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPPor22PQ8rknE0FNmELBKVTb3nPpoVtNKQpfb7KTCVBGqGut
	CAOz7SktAvJxedMrEF1FhLdk4iRh8CCsGvZl0wbtAv6hn+gamwNJ/jcm
X-Gm-Gg: ASbGncv7tBlUkw01cJ4flfAEJS2Pd+k6ApdNU79mKnOssjV9uF5LmRxLLU6dmlYg8lV
	I+iVVxymUyrTg6G40Y2pcDJQnFJ9R4F4ozDP6uVU4YnAVAxya5BGwHskCT41Q/yOE0z13KmRQgY
	PZEgF0AT6/W0y5Z43Ydw6qLo7YYTEsR3JTocfExW7XgklRnnmtuRgiWZFw2Ydkp4jOQ6YoyFLc2
	JT/Vz7cbjzN1RjKm5yWMPRMHgdIxdsP/II3VuQtpih7rkTf1N71S0m0fA/PMGqZUdAaS7h65tg5
	6pngDlZ6VqWL4cwiKkdgmIdavghCrLb2jXM+5hnbASImvDTcikuG0V3nh2PcNIMFjE8P8SsqWAc
	1c4VSsTKRy7xQWTFsh9s84lgxnHyoWemFNARu
X-Google-Smtp-Source: AGHT+IHFvbnI0pLASoGPdv6sSFlzhJfcFJ7Qel8fvRdrToBY/qELc92CZIVaOr2K4Dl7zx1fqjFbrA==
X-Received: by 2002:a05:6a20:9148:b0:250:429b:9e5c with SMTP id adf61e73a8af0-26029eaa48amr4515323637.10.1757690847453;
        Fri, 12 Sep 2025 08:27:27 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760944a9a9sm5436846b3a.78.2025.09.12.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:27:26 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	cem@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	amir73il@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH v3 02/10] io_uring: add support for IORING_OP_NAME_TO_HANDLE_AT
Date: Fri, 12 Sep 2025 09:28:47 -0600
Message-ID: <20250912152855.689917-3-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912152855.689917-1-tahbertschinger@gmail.com>
References: <20250912152855.689917-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for name_to_handle_at(2) to io_uring.

Like openat*(), this tries to do a non-blocking lookup first and resorts
to async lookup when that fails.

This uses sqe->addr for the path, ->addr2 for the file handle which is
filled in by the kernel, and ->addr3 for the mouint_id which is filled
in by the kernel.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 include/uapi/linux/io_uring.h |  2 ++
 io_uring/opdef.c              | 11 +++++++++
 io_uring/openclose.c          | 45 +++++++++++++++++++++++++++++++++++
 io_uring/openclose.h          |  5 ++++
 4 files changed, 63 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 6957dc539d83..a4aa83ad9527 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -74,6 +74,7 @@ struct io_uring_sqe {
 		__u32		install_fd_flags;
 		__u32		nop_flags;
 		__u32		pipe_flags;
+		__u32		name_to_handle_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	/* pack this to avoid bogus arm OABI complaints */
@@ -289,6 +290,7 @@ enum io_uring_op {
 	IORING_OP_READV_FIXED,
 	IORING_OP_WRITEV_FIXED,
 	IORING_OP_PIPE,
+	IORING_OP_NAME_TO_HANDLE_AT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 9568785810d9..76306c9e0ecd 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -574,6 +574,14 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_pipe_prep,
 		.issue			= io_pipe,
 	},
+	[IORING_OP_NAME_TO_HANDLE_AT] = {
+#if defined(CONFIG_FHANDLE)
+		.prep			= io_name_to_handle_at_prep,
+		.issue			= io_name_to_handle_at,
+#else
+		.prep			= io_eopnotsupp_prep,
+#endif
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -824,6 +832,9 @@ const struct io_cold_def io_cold_defs[] = {
 	[IORING_OP_PIPE] = {
 		.name			= "PIPE",
 	},
+	[IORING_OP_NAME_TO_HANDLE_AT] = {
+		.name			= "NAME_TO_HANDLE_AT",
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index d70700e5cef8..884a66e56643 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -27,6 +27,15 @@ struct io_open {
 	unsigned long			nofile;
 };
 
+struct io_name_to_handle {
+	struct file			*file;
+	int				dfd;
+	int				flags;
+	struct file_handle __user	*ufh;
+	char __user			*path;
+	void __user			*mount_id;
+};
+
 struct io_close {
 	struct file			*file;
 	int				fd;
@@ -187,6 +196,42 @@ void io_open_cleanup(struct io_kiocb *req)
 		putname(open->filename);
 }
 
+#if defined(CONFIG_FHANDLE)
+int io_name_to_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_name_to_handle *nh = io_kiocb_to_cmd(req, struct io_name_to_handle);
+
+	nh->dfd = READ_ONCE(sqe->fd);
+	nh->flags = READ_ONCE(sqe->name_to_handle_flags);
+	nh->path = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	nh->ufh = u64_to_user_ptr(READ_ONCE(sqe->addr2));
+	nh->mount_id = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+
+	return 0;
+}
+
+int io_name_to_handle_at(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_name_to_handle *nh = io_kiocb_to_cmd(req, struct io_name_to_handle);
+	int lookup_flags = 0;
+	long ret;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		lookup_flags = LOOKUP_CACHED;
+
+	ret = do_sys_name_to_handle_at(nh->dfd, nh->path, nh->ufh, nh->mount_id,
+				       nh->flags, lookup_flags);
+
+	if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
+		return -EAGAIN;
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+#endif /* CONFIG_FHANDLE */
+
 int __io_close_fixed(struct io_ring_ctx *ctx, unsigned int issue_flags,
 		     unsigned int offset)
 {
diff --git a/io_uring/openclose.h b/io_uring/openclose.h
index 4ca2a9935abc..2fc1c8d35d0b 100644
--- a/io_uring/openclose.h
+++ b/io_uring/openclose.h
@@ -10,6 +10,11 @@ void io_open_cleanup(struct io_kiocb *req);
 int io_openat2_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_openat2(struct io_kiocb *req, unsigned int issue_flags);
 
+#if defined(CONFIG_FHANDLE)
+int io_name_to_handle_at_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_name_to_handle_at(struct io_kiocb *req, unsigned int issue_flags);
+#endif /* CONFIG_FHANDLE */
+
 int io_close_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_close(struct io_kiocb *req, unsigned int issue_flags);
 
-- 
2.51.0


