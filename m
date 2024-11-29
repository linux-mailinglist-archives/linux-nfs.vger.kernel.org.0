Return-Path: <linux-nfs+bounces-8261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C69DE7CF
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Nov 2024 14:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4790D280A6E
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Nov 2024 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9F1A3AB1;
	Fri, 29 Nov 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptsf66kg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CA1A3A8D;
	Fri, 29 Nov 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887571; cv=none; b=q7Z6ErOatd8Kee3OVMAcj7zreDU8WPTRLusS4DHZEqTcaVl7dQhIQ5YXSCD+IWEZ8xdlM/QoHN91Ar12hJHPj0vEsUbo0rg3a6RMPdABhme/8AVIaY1zyZKbroBUN89xFZJGx78LmzKP8UlQfewCLEMdte0v5lBAYjtq7miHUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887571; c=relaxed/simple;
	bh=MbJKDBcZ0ddGFSB0evIr2caQuD86w7k3PwTvETORd2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpvYJFLoMIIi7a/aZinegr2ga0C7iXwjzv0Wg9KeuUc2FxKGdgWR/QzEaXskHk3PGBH5MxgR/Metb8U3M3w7pzsoCgHS3CMZvBv5evmWH0rtyQcJl71QqNOeXPsCGpZFx0dy4vmA1ufddZ59YVh3B3iq6gjUVK+i7v2T8f7fwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptsf66kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BF3C4CED3;
	Fri, 29 Nov 2024 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887570;
	bh=MbJKDBcZ0ddGFSB0evIr2caQuD86w7k3PwTvETORd2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptsf66kgpx7grHugaR6QWoO01Rr9p1R+dSgN8EPlZdnlNJ1YEAy0trh+SvxA/oK88
	 E+uhV1yUdieg9ytE/XnzVoZKkgwgmRKzFm52f31AggpFY9krgmJwN7dcU+2aoL000s
	 UfiDpH9RLSZ51rQXTvpqSV1wMpi32XJWP/uOOLEqZY9TQfGbUNnmxHWOrcDpOkDUoL
	 IM5/+dK62FUBxl/Z89Hch0oZMxFdBTEyuZQR70C84C4b94HsJYRUNzM6e0AZ50CwbG
	 a/tWGrN8lHqvDDJGzJ1Y6eRLYbrDzQbgWkjecbkfw3ZhQcebCPDi6+qBKCw9nFeEZ2
	 cxlgL7uOqAqkw==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 4/6] fhandle: pull CAP_DAC_READ_SEARCH check into may_decode_fh()
Date: Fri, 29 Nov 2024 14:38:03 +0100
Message-ID: <20241129-work-pidfs-file_handle-v1-4-87d803a42495@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=brauner@kernel.org; h=from:subject:message-id; bh=MbJKDBcZ0ddGFSB0evIr2caQuD86w7k3PwTvETORd2c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7Hj64M6Hgtdm8KPvSJbdnX47QCHvct3dtZOeO9GXVh 4QURdkyOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy7RYjw8dcBt6NqqrMzeab bipkPX3CXPpeU6DVoXN92gFT2yV8nxj+F39JrJljtPO+r8g6Jy5l42N6yUf5c+ZGaU280HJT434 9BwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

There's no point in keeping it outside of that helper. This way we have
all the permission pieces in one place.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index c00d88fb14e16654b5cbbb71760c0478eac20384..031ad5592a0beabcc299436f037ad5fe626332e6 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -298,6 +298,9 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 {
 	struct path *root = &ctx->root;
 
+	if (capable(CAP_DAC_READ_SEARCH))
+		return true;
+
 	/*
 	 * Restrict to O_DIRECTORY to provide a deterministic API that avoids a
 	 * confusing api in the face of disconnected non-dir dentries.
@@ -337,7 +340,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	if (retval)
 		goto out_err;
 
-	if (!capable(CAP_DAC_READ_SEARCH) && !may_decode_fh(&ctx, o_flags)) {
+	if (!may_decode_fh(&ctx, o_flags)) {
 		retval = -EPERM;
 		goto out_path;
 	}

-- 
2.45.2


