Return-Path: <linux-nfs+bounces-8693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4B9F95BC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EAD1882720
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8874B21A444;
	Fri, 20 Dec 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAtav6GZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386221A438
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709365; cv=none; b=XqOAwYUF6xYxsnp0FvxTiEOsgc8stM9VLoAiUUy350PyzviJAVZp3HVUQOSG1RK6Mij5ywGtFZhFTDl21P1tXMiJzwBZuC0RYIAEOsi1i7b93a8R2d+0gJ3tdDQCuVfgVIJZT7Kb88oU2Ethsa67TMvXHK2wEJUTWnG3lJVQTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709365; c=relaxed/simple;
	bh=t0vGty6LVUUZRvHj87X/Y7MsqvPoleODWLsrFyVcrxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tyjp7wSHHXgPMBleLyH+A+546oMz04iO7UhBQ1+FhbQggPj4eK1womQiC/85HAq1kfQKxK8HrMnmVQaYcselA03lTb1yKJT4GQbzfblA4qwgUDdM2frYkhi3+cfu/7JDHnN3IHLzTGQe6OX55Fuua9UEiaVZLJ78wNRQDd3LDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAtav6GZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D5DC4CEDC;
	Fri, 20 Dec 2024 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709365;
	bh=t0vGty6LVUUZRvHj87X/Y7MsqvPoleODWLsrFyVcrxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eAtav6GZfeYvZVBlMWqRFXjgp3/WjHKzkzTbE6ByO8QiTbTGY+krKtQG3v787GM/m
	 D7FOlAsM5gNcDEvfE03kSJ4UqBO7BVLxPJHXe9yuUP1VGIsTL4JBVABARRa2+7iwM1
	 noHxbUqW20LKWsMxV3xql/WwOPrgyO2JCNWwjpUCsB9Sy0D+FyZt0I2thhROC5kqxT
	 LjHgdcA+HSmFHOYa4xxVeO7HreH+CL3n3f4noDev30VK20A3Hwbt1EjqHeENRb+eZw
	 kRUC5tddiW5vx9rWhd9riW4fZcR0wR//jqGpmfHM9vL6AHog/sIjs/bbsnz1Ev1iof
	 Ggfkc74r7BNxA==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 7/7] NFS: Refactor trace_nfs4_offload_cancel
Date: Fri, 20 Dec 2024 10:42:35 -0500
Message-ID: <20241220154227.16873-16-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220154227.16873-9-cel@kernel.org>
References: <20241220154227.16873-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=chuck.lever@oracle.com; h=from:subject; bh=cODENqW5Ok0dx4I8crX8CqX9dO69UuRUXqmbixqES1w=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBqZegPqFmB6In+7dySazamD9zX4rjc3ltul IEjPAL1SgmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQagAKCRAzarMzb2Z/ l7tBD/9FlN7rHxkzeTNDhsxysYojUkGP6y7ujTPXkfXhOBOwltEL9rDVRc/j/Dya3KuRIax6gIg a6D0Ip9rtLZAK6hORTYiK6oR8Q5sl3V4BtoYhiYzfIb+NmRC3wc5/AwvU16/IITfsVMuJEi1ryG 909q/7eX2qxv63VM+Bqm/MVFV/ntvwqTHMsEwM24Cpaoz6y4uENq88vmQzTR60Q+kYFrNFQ+DR6 6uYKxY7IqAdDCMPktnoiPL0b9DFK7GCIyX1VwD7BH44Mbin04xEtrBP21viWvPdg7aFSgI6r3Ih bHUm+lz6u6WpdztSVv25sf2JLuV7JJnYMVAM+/x8+bDKrKrZlLukOhs24KzSzvJYV/aEdnoZupn pT1jAEerKHjsRbCfRbS6owxY+Mk5aD0Ncrp1Qji9n9Boj+UDwlc+1+r7Wj7rS3rNsbdP5Z9o7M8 AOTSiaTBPnzSU1cgaMacQr1byU3Vde/J+NE0SLPk8yNRrffl8+YP2zwukuzHh2gpmCtGJ84x5ji K72cmXzjShFKtm5GhzkRh/9y7SzbiVhpIjuaktIMVNp4FXU/PTDxE+VqM4RZNMQu00fZmXyGfzC WiHzWcEXxM0hPKz/1iO7cBb4CCCk98058H9z0K9L7E5AtdUNvKBxLplnOAny+GCtyZvJHMipDlb orCPO7yMiib36qw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a trace_nfs4_offload_status trace point that looks just like
trace_nfs4_offload_cancel. Promote that event to an event class to
avoid duplicating code.

An alternative approach would be to expand trace_nfs4_offload_status
to report more of the actual OFFLOAD_STATUS result.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c |  1 +
 fs/nfs/nfs4trace.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 65cfdb5c7b02..3cdd4f6f87e9 100644
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


