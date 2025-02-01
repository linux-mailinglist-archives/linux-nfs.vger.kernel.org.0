Return-Path: <linux-nfs+bounces-9823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D2A245F8
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 01:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB473A8841
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E4B3596E;
	Sat,  1 Feb 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkN6vi/2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC535964
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370097; cv=none; b=n2BhW+AGAENzDAYGvXEBftr6N0RljE1bBh/gy6e672p0CmhGwMzcnjbvXiwQDU2DRIDwfvNoCrNkgxoVivVnASNh3JdwahDxUCy4jvnehC12xQ70DB3YVTo5wuk5S79ukFjjXauZC+br7xCr1hQT3jcYht6iOsihEr8MjmJjHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370097; c=relaxed/simple;
	bh=zi3n9IrtQ0jF2YL/XzOjVVOehRfF8DoajD1KCU6lpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naa9zdYCaE/VK09yYNjKkAYv9m46eJNgoaVUI2lGO4d79r83/yutlD5+qxzk6uzxvQ9iUchnkayMAXwhI+BtbB5g5A80Kq6t/cmB4Aa5F3gu1LlW/fzHd422UxM75P6lSfYICoumr5ZCVDP332DMJ5rfXODmb6jxku+7hQHTmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkN6vi/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347AEC4CED1;
	Sat,  1 Feb 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738370096;
	bh=zi3n9IrtQ0jF2YL/XzOjVVOehRfF8DoajD1KCU6lpLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkN6vi/2cwiApemItbeaKY7A4VI3r7RGYX/HQwGZ7wGHeA0i87dhEtZLEiyOGUEuZ
	 AlrZtS5iurJFx/thVtS8hk6huMCIXJXPaoNPzK1wbqySZTXecp4NFZ46OGyddSU+/l
	 r0zi/bgUS37Mv97nmPoUA967kwj9xjqb0SNtcpGHg11qwkkbgY1XvidAvRWUcBg8ZW
	 QcCSE1qltXPvhmR0ehGpJpS64ioUEH8TTtZcvzolD9CGb8uifMopi4Qowco1Ptdu6x
	 5TJRViuq1UhSOr6gSlNGeQy16gjE0wfcAplKKySMA8Wy1YXwmtNCX4SJEMZ9oslS3O
	 3kzAbNnGe//rQ==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH v4 7/7] NFS: Refactor trace_nfs4_offload_cancel
Date: Fri, 31 Jan 2025 19:34:47 -0500
Message-ID: <20250201003447.54614-8-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250201003447.54614-1-cel@kernel.org>
References: <20250201003447.54614-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a trace_nfs4_offload_status trace point that looks just like
trace_nfs4_offload_cancel. Promote that event to an event class to
avoid duplicating code.

An alternative approach would be to expand trace_nfs4_offload_status
to report more of the actual OFFLOAD_STATUS result.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index f56558c58fe9..2c7f5cf6a46f 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -651,6 +651,7 @@ _nfs42_proc_offload_status(struct nfs_server *server, struct file *file,
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


