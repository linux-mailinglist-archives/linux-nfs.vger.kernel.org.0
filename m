Return-Path: <linux-nfs+bounces-16790-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E253EC937D8
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 05:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6AEC34A789
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 04:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C86230BF8;
	Sat, 29 Nov 2025 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaU4b10D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEE22F76F
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389197; cv=none; b=feJYj7pSGCI7LXN9OnbHESoLe9UpbPTtMejF6+jYpdJxCoZ8gNasR/ILDxkGvOTsw//RyFnjb4FRDYwYvdYxTm8TNQtTzAcfMKJL5kK48lrSchkgKrvMxq+q8xkb7lK1bYwzpr9qhI9ikhpxCBKsvjUkZ5c2ZEvBa2vIAbqY7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389197; c=relaxed/simple;
	bh=uYmBgUIREUzvRIowf24la8cVAv4jILdlPkTO5eRAVPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mwpk+I/OPZpATiomBhOpv/CrInPZOwBegeiBYbO3z0bEZc6ZQffXFwPjG8yhODLX79f7ivDl9D9UpWRiq8NIFoxe7LT+qF6yWpZsa2PPveDQo4qBADJZtRIa1JiiovZ5/ba3fS0M17b79KDdva5FzKvXei3VRlozvpbfkZ7Sl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaU4b10D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CFC4CEF7;
	Sat, 29 Nov 2025 04:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389196;
	bh=uYmBgUIREUzvRIowf24la8cVAv4jILdlPkTO5eRAVPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaU4b10DH/29YzObQc7LLgjFVd0YpeAfhoq4UcIa9/Fhu1m9pgsHSY6N259FdDjr/
	 tGNdqHyxRtxIMKMRjLL9CM4Hv3nueE0GHwfy6nIa5F5Lcv6nfWKUT1vTYW0QdqQUYf
	 FRI3ncepehPQum45VIBngIvW2MihtH9wz0wrwkvZYzXE5gmVSY5n9e4NJG+0ZXNRgg
	 EFfytJeDBfnwNIcv8TF6ygpt3VP7mOrvVboCEqQs8YB010mXnmIiZMYNNXEf60cQkr
	 kiwyY3edeyuOXGjaYCSr3j291VheEAA6r1JzDReVW7dtKnGBqqkJVVMfmi30kDQuIe
	 i//kkNsAVBU/g==
From: Trond Myklebust <trondmy@kernel.org>
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 6/6] NFS: Fix up the automount fs_context to use the correct cred
Date: Fri, 28 Nov 2025 23:06:32 -0500
Message-ID: <c2039c2856c486ca61b07d8723a02aa74d688602.1764388528.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764388528.git.trond.myklebust@hammerspace.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com> <cover.1764388528.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When automounting, the fs_context should be fixed up to use the cred
from the parent filesystem, since the operation is just extending the
namespace. Authorisation to enter that namespace will already have been
provided by the preceding lookup.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 9e4d94f41fc6..af9be0c5f516 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -170,6 +170,11 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	if (!ctx->clone_data.fattr)
 		goto out_fc;
 
+	if (fc->cred != server->cred) {
+		put_cred(fc->cred);
+		fc->cred = get_cred(server->cred);
+	}
+
 	if (fc->net_ns != client->cl_net) {
 		put_net(fc->net_ns);
 		fc->net_ns = get_net(client->cl_net);
-- 
2.52.0


