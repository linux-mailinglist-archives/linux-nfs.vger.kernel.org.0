Return-Path: <linux-nfs+bounces-6407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF59769E0
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AD6B2489D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C471A76AB;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJQOTpfc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B461A724B;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146161; cv=none; b=CAKGTGvKPqhV2yJp0oztuqNLqNimValUs0IR+AAkuN7+EXv5NfANMCOItMxB6REAscRdB/zsJoxJtprUMsDOe+enfzOOa2PX4UUNkf2VZWDnlbOC77z0YAYEhyeCLblmYuua4bkxH+n6qDBpxO+tBNV+41OCMVI5Cd0PYvqqWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146161; c=relaxed/simple;
	bh=8NnT5GcEEYmNpynFrCa/PdBFk8587dLDSKFdhXjTYvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V67mYshBF04PASdwxHP66YSj3Skn38mC0LCsbLbotvYthY6Ws1ZXEQ8a3UELf6a4gSkFPKNiiOyxF0Bq+Gh0205K4ZNzvPwBZ9DStCoXrn/uoHJ+oF4LNs/13ANavby0PUaTw1Q7L3UHSuQIXFm2Pah0xcIuYHE4qomuFIMKWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJQOTpfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319FEC4CED5;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146161;
	bh=8NnT5GcEEYmNpynFrCa/PdBFk8587dLDSKFdhXjTYvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJQOTpfcIWk1NVNqFo9JqHoubAl88u+eQ7oGyxtJ207285fZo5KjYLikDJJW0NcOV
	 OWQ6IcCWJu3a2/yiTZNeMK51RXxPtr0Bfq21pPAbb2yPDfc09irLU6zlYJf8sU90e7
	 31hvwOLmUgYR7M7wYZISh7LL3qFy0FJlNSkRxmn7UYhoz/DQwAulnUkF0yX/JNfPu+
	 CNrfC8TMMiKxJI4BDJ9S+SzSpYbeBynEKfEQLzrrb7Vv0F39CFBwzPsn1/Is605Tmm
	 qwBw3k28nmf9u5Bj203fBFDjXzM73aF1sM8n6zlmcLxPWHpP7wfTwAyDBXKZXk31ME
	 ayvXToHbNJMkw==
Received: by pali.im (Postfix)
	id 4600CC46; Thu, 12 Sep 2024 15:02:36 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] nfs: Remove duplicate debug message 'using auth flavor'
Date: Thu, 12 Sep 2024 15:02:20 +0200
Message-Id: <20240912130220.17032-6-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912130220.17032-1-pali@kernel.org>
References: <20240912130220.17032-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Function nfs_verify_authflavors() prints debug message 'using auth flavor'
on success. So not print same debug message after nfs_verify_authflavors()
call again.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/nfs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 86d98d15ee22..be487118cedc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -938,8 +938,6 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 	 */
 	if (ctx->auth_info.flavor_len > 0) {
 		status = nfs_verify_authflavors(ctx, authlist, authlist_len);
-		dfprintk(MOUNT, "NFS: using auth flavor %u\n",
-			 ctx->selected_flavor);
 		if (status)
 			return ERR_PTR(status);
 		return ctx->nfs_mod->rpc_ops->create_server(fc);
-- 
2.20.1


