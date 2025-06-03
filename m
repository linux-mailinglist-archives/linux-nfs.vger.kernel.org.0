Return-Path: <linux-nfs+bounces-12071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFACACC5AA
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 13:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5537A16CF9B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CA2309BE;
	Tue,  3 Jun 2025 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvB4PwUA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F23099F;
	Tue,  3 Jun 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950955; cv=none; b=JCPY+dSZAdJIAP4chd+6NVfX2K/jyD5ZrxJjjG1+yIbOmHqPOjAZJPu0wkElS7zZijeImWf/W/84l57XAHvG1D+curfxq8r2Up5wSfQnGSS9GCk27hcxp/meO2TkncHpVm8xz5K2IF6z0tJ0E61LYx+3cXAW9aBpzuHTwlOofGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950955; c=relaxed/simple;
	bh=FvY8QaoJqci3tuIuqKZdMMJaO5JY+0JaOUDV7Pkhs24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/jOcrLPMH7e06QxJI5qgcDVUtNadCcxAkA0peBRQATGSve3fcwoWDa/dpMc9yIhu6UI0Rbk4TH4eEuAuH3zzj2b+Hkv9ki9mMuq8RqthVVpsY4Up6e3Ovl0T9pznzF6WK5iexP8vQwrzE62aZ9j6rTRooK3lK1FFKn+ZauhiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvB4PwUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C299C4CEF3;
	Tue,  3 Jun 2025 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950954;
	bh=FvY8QaoJqci3tuIuqKZdMMJaO5JY+0JaOUDV7Pkhs24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZvB4PwUAdTN7Z5Uuxgy2GtMLshUsW414n418u0MLUGBGzR2GGH37pXkD0dchrabtV
	 F0OFa9bVB/hD7ULExkI0Zmy51oB2kFhEHk+48ISdtX2T8p0WsZ/NNwJjmbxWIuOvm1
	 lMcKv6XRq+6aJmh6QO8zP363vlEwcuXCOG3cx3UlclFaidVMe4j+daraELr/OjfYlc
	 6pI5zmAQZh426i09N0JltNssVVOItPaD4M4wDKR6mKrJrlEQL2imj5tOfBCkHSC51h
	 v7OCnzzyRZSvmarguVjH43KSVCH1wWjkszCR0kPxEc7MKGJ/msyGAUH4u7nm5PqN1o
	 DKKFH1cYn3/kQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:42:25 -0400
Subject: [PATCH 3/4] nfs: new tracepoint in nfs_delegation_need_return
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-nfs-tracepoints-v1-3-d2615f3bbe6c@kernel.org>
References: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
In-Reply-To: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3050; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FvY8QaoJqci3tuIuqKZdMMJaO5JY+0JaOUDV7Pkhs24=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPt+nUIl0NFrrN2dL02077gxtjmmO1RGPSM474
 FsiSwlYFcqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7fpwAKCRAADmhBGVaC
 FW51D/44YTUIPIjBsdVVRGDtIt28ZG1RHlTF/kRKj6YwsOOcgYoMLaX+h+w+wJcL2OQRioKyObt
 qFx8cQEdyI78XFQdm2e/y6DEYAE56ZpIwY03/jI0Pokgmu3UdlY7FIZPVc2JM1HI2w1rsNkoZgP
 GFKRRv+tK75xg8qVQWAxb60gfdfV6Uye4v5LQo9d44iA0YPbDYBhdftcQc60duz/RPYFTdezTsf
 4nYgsUjxXzO/2gv4Z2DPdH8Egcd2X5moFXP5M/+1U8vxpqvkS17BwPmc0YAXg2Z99GSswZD8XCY
 YgBz+gg0ERl9yKrRX26MIHHnQUmcO0KLOWbTqQPtDU7O7u7dr/1r/P6kTFu+rstqW4hBCkiOgav
 74cvTiZG4XQViK4e3uEAgQ7CmQGGtjIHkJyzLoGulkB0C1BUQTile9YYOl6jhTCGQJUwLIFpMNR
 BCTHZ4MODofMtCTJpsZ2EE7GN8U830QZ9+DPGjw1IY0sh/Am0/aW9Q9VJJaVjd2d91iCzX9By/D
 8etL3biCwUrcH1nIyDxrwOD7SEGtZyUYx4Ygif+B8vkE2pcilzxM1kDxibZS4yoGD0vMLhDXd7K
 0qTy2ijTI0QMzjHnT3iBmBiX5OgBhSFBRNaBf83Smlc1I11qHD5FhTJVGWtq61LEnIHaGAhQ5/M
 5yThsmqKZeg+6eQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a tracepoint in the function that decides whether to return a
delegation to the server.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c |  2 ++
 fs/nfs/nfs4trace.h  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 78a97d340bbd98390ca8302176c17caf08dcab4a..6f136c47eed7f1801af337f0e88f1a6bf477d0c6 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -594,6 +594,8 @@ static bool nfs_delegation_need_return(struct nfs_delegation *delegation)
 {
 	bool ret = false;
 
+	trace_nfs_delegation_need_return(delegation);
+
 	if (test_and_clear_bit(NFS_DELEGATION_RETURN, &delegation->flags))
 		ret = true;
 	if (test_bit(NFS_DELEGATION_RETURNING, &delegation->flags) ||
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 6e1c4590ef9bf60eac994e85be816e82f5e0c741..73a6b60a848066546c2ae98b4982b0ab36bb0f73 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -14,6 +14,8 @@
 #include <trace/misc/fs.h>
 #include <trace/misc/nfs.h>
 
+#include "delegation.h"
+
 #define show_nfs_fattr_flags(valid) \
 	__print_flags((unsigned long)valid, "|", \
 		{ NFS_ATTR_FATTR_TYPE, "TYPE" }, \
@@ -958,6 +960,51 @@ DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_set_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_reclaim_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 
+#define show_delegation_flags(flags) \
+	__print_flags(flags, "|", \
+		{ BIT(NFS_DELEGATION_NEED_RECLAIM), "NEED_RECLAIM" }, \
+		{ BIT(NFS_DELEGATION_RETURN), "RETURN" }, \
+		{ BIT(NFS_DELEGATION_RETURN_IF_CLOSED), "RETURN_IF_CLOSED" }, \
+		{ BIT(NFS_DELEGATION_REFERENCED), "REFERENCED" }, \
+		{ BIT(NFS_DELEGATION_RETURNING), "RETURNING" }, \
+		{ BIT(NFS_DELEGATION_REVOKED), "REVOKED" }, \
+		{ BIT(NFS_DELEGATION_TEST_EXPIRED), "TEST_EXPIRED" }, \
+		{ BIT(NFS_DELEGATION_INODE_FREEING), "INODE_FREEING" }, \
+		{ BIT(NFS_DELEGATION_RETURN_DELAYED), "RETURN_DELAYED" })
+
+DECLARE_EVENT_CLASS(nfs4_delegation_event,
+		TP_PROTO(
+			const struct nfs_delegation *delegation
+		),
+
+		TP_ARGS(delegation),
+
+		TP_STRUCT__entry(
+			__field(u32, fhandle)
+			__field(unsigned int, fmode)
+			__field(unsigned long, flags)
+		),
+
+		TP_fast_assign(
+			__entry->fhandle = nfs_fhandle_hash(NFS_FH(delegation->inode));
+			__entry->fmode = delegation->type;
+			__entry->flags = delegation->flags;
+		),
+
+		TP_printk(
+			"fhandle=0x%08x fmode=%s flags=%s",
+			__entry->fhandle, show_fs_fmode_flags(__entry->fmode),
+			show_delegation_flags(__entry->flags)
+		)
+);
+#define DEFINE_NFS4_DELEGATION_EVENT(name) \
+	DEFINE_EVENT(nfs4_delegation_event, name, \
+			TP_PROTO( \
+				const struct nfs_delegation *delegation \
+			), \
+			TP_ARGS(delegation))
+DEFINE_NFS4_DELEGATION_EVENT(nfs_delegation_need_return);
+
 TRACE_EVENT(nfs4_delegreturn_exit,
 		TP_PROTO(
 			const struct nfs4_delegreturnargs *args,

-- 
2.49.0


