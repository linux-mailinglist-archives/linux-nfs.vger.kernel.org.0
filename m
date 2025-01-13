Return-Path: <linux-nfs+bounces-9170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A91A0BC18
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCD7163AF8
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD21FBBE6;
	Mon, 13 Jan 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SABFvM3r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E241FBBE7
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782373; cv=none; b=fBMHD/5LfCAhEoSN19/wdpX4RVFn4FNiUaAFOVcMr2cfQP8CSyM2apuer9iYN/MYhGx6VwHV4uof27nI67fuJ0Seh7cMtqlMYQomtm4cwZtM2OENU/oPBtAwJKdf3782SzgGfmBTfboKIihSxgDrbo/GgaYb75rdkTS1ht7mfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782373; c=relaxed/simple;
	bh=Z09/2VuvQ3zxAG1O6Wkbe4RdL66Mg44UjtK5uMkgSvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwIszeEsjRZMARv+ryo1kl/gRCrourir/5TjQLQCr6oEEDImKjy5V8MZTiQgkKpbnjOf0rzlG96u62wTZazF73xuNyPHYB4pfMahhP0lhirZdKWaseifJPvn6jUhX4NhDFWmJA9WFjAZhVj5CWrr0jZXH9L449qk1O9YMGITdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SABFvM3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00782C4CEE4;
	Mon, 13 Jan 2025 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736782372;
	bh=Z09/2VuvQ3zxAG1O6Wkbe4RdL66Mg44UjtK5uMkgSvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SABFvM3reoUizAegEU0Z4bkac1SqzyonHhIVpBjdw6QYfaPftJdqk3OQWz+KeFh95
	 6I08aMHSLzMD64lGwWbNqZZEybXSd5nUZWeefWTnL4MZ/1XvWABefkHQLgUv4nXUuC
	 6eTId4BAjaizjk1mr5fKvY6ztfIheUffosGzXQYVoYUO5D2qgWyD5tr8mIW3pPwacq
	 +lDtRDGiyufXKMEZ9GGvctK5Q0OtPwErT1stPieQRi/nhPIfpUjDpyaVVAKRkXQk+Z
	 alC6vMqn519CzOUWTc8QvfyE2mk1L3KX6lGxG4ZFCNoWqDJyaOec522m2H0kJO5HAN
	 BjUps8iMqGQMQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 7/7] NFS: Refactor trace_nfs4_offload_cancel
Date: Mon, 13 Jan 2025 10:32:42 -0500
Message-ID: <20250113153235.48706-16-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250113153235.48706-9-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=chuck.lever@oracle.com; h=from:subject; bh=lS7gLKxLV6e35cAwmz+7g8/4d/Vm+xpaV7ZAzDdK8gM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnhTIbh+yLG8krlIp/tYnQNbc5i47MlJlTzkCK0 MFrpBCdENuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ4UyGwAKCRAzarMzb2Z/ l7DmEACbXHKbJUvNn1FW38yJiZ/z34HRvk4sXArThUrZO4Tp0jSD3RMQy9Jkq8Etp/MOMwpB2/e 42yVtruJc+lSIPenP9A7BSkhuIxzyLX3dXLXpodeqC0/ImNu5GxQgdsbpcYw8I8KS44OUDPoT+4 IV0WIjFw2OUlnVLVhX2OckAMLAx9HPuCavgA649Yd2OB6oiMRACNPRRgyfLSlpeVud16zOjIual EPjOJUjxMcjwOcJ54zT/z8SEsq8/u/OkIx/k/J8PDFvbfBlFjIp4rF8mCGwxETGlWcslgQ3nIwr YmWqvboOU7ozp2EmS+HAj0XQ0l7yJXOf/+MLKLRAsvjwf212CXz61OE1bEr+jM+A7csdhXh6yCt E7p0QMd6UYPC49n1oZWHPQdeDa3LhhCun/qNikMWEb6RD+bUGoDnrtyKbREJG0pjLAj+E/MdBtH xCWF8/JhQV0Jrs4JZTdTk63ES6Dc8hpKuMn5uWVW5NBszbi905m7a5X6NLqcvFaZYf6SmHNJ5D7 1FwOQHDXLJtmjt/tQEOnr9PfTUCdZ5dhRsze5TiF83PRHUlskt0cfj9jfHYMvJfVazAt8xnEA4X MNN67mHgmLrmcUg8Dqrm5LGoojSX8zmBr5tKQ7Zf2ZFJHFQwZScYFnMNXmLAnBwyU3jJtO3RCfb gsdSSZqzXE8ruaQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a trace_nfs4_offload_status trace point that looks just like
trace_nfs4_offload_cancel. Promote that event to an event class to
avoid duplicating code.

An alternative approach would be to expand trace_nfs4_offload_status
to report more of the actual OFFLOAD_STATUS result.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 4baa66cd966a..9dbb93dc3839 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -648,6 +648,7 @@ _nfs42_proc_offload_status(struct nfs_server *server, struct file *file,
 	status = nfs4_call_sync(server->client, server, &msg,
 				&data->args.osa_seq_args,
 				&data->res.osr_seq_res, 1);
+	trace_nfs4_offload_status(&data->args, status);
 	switch (status) {
 	case 0:
 		break;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 22c973316f0b..bc67fe6801b1 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2608,7 +2608,7 @@ TRACE_EVENT(nfs4_copy_notify,
 		)
 );
 
-TRACE_EVENT(nfs4_offload_cancel,
+DECLARE_EVENT_CLASS(nfs4_offload_class,
 		TP_PROTO(
 			const struct nfs42_offload_status_args *args,
 			int error
@@ -2640,6 +2640,15 @@ TRACE_EVENT(nfs4_offload_cancel,
 			__entry->stateid_seq, __entry->stateid_hash
 		)
 );
+#define DEFINE_NFS4_OFFLOAD_EVENT(name) \
+	DEFINE_EVENT(nfs4_offload_class, name,  \
+			TP_PROTO( \
+				const struct nfs42_offload_status_args *args, \
+				int error \
+			), \
+			TP_ARGS(args, error))
+DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_cancel);
+DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_status);
 
 DECLARE_EVENT_CLASS(nfs4_xattr_event,
 		TP_PROTO(
-- 
2.47.0


