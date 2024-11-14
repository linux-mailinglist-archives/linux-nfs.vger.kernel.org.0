Return-Path: <linux-nfs+bounces-7954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2104F9C8197
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F141B23C8D
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E99154C0B;
	Thu, 14 Nov 2024 03:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAWVJorG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A246BF
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556798; cv=none; b=bBje+xus2wtBC6Ovn6VPzOW74ty72XzE5tA8Zx/a7nY/m1B/t4Jekk49kFQb1ND3c8cP2ao0O9r4DJtQlkItwWfWIbP4AY/nlEBgtbsJI7jMW5qSg3bK3ZxmIQAhYYEPU9TMqSKX5qvPOIJdEFJQQgh7H43LzOpq5eBxo8o/0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556798; c=relaxed/simple;
	bh=ZBYnj3Ea/NZBkZws315uRVwroPK4UE+L8kyLv7DOk9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvHu+LKgbGAhoMXDjiIxg1+iV/RwJ0UAOv+D7CTzMG8OmncJq+sTwvk6b+tqV9ZhPJB2yCVpXYfXj5HM0vec/e9/M+PYicV6Jj6juv4ML06Wbf8pVpW89nGfH/z3LSMkqUpD1TtWlIRJaRrrNK187bV2FJFjHL/jYNalwc345as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAWVJorG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B91C4CED0;
	Thu, 14 Nov 2024 03:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556797;
	bh=ZBYnj3Ea/NZBkZws315uRVwroPK4UE+L8kyLv7DOk9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAWVJorGrviSOyDMT5ZlR7ugScTGuCAMLN5oGxo7O0Qa5dPAfCwdP4Z+S+Tyn7jA+
	 urOwGsRhfZM1NypkAUDzkJGusrG7ySg51kNceYKhPm6D/wcXiJVXC/iUeWL9/wJgeL
	 hJH3m29gDgEh2FoLsHSceYe2e8kwLJtF2ExOulYRNV3D4tgvZ2MJ8gTLEdg3+SdKvB
	 qoiFawsEElXuaWHYCpEOYkPgJ6TVO3v5CUuF31TzKc+RFzFql9RN3d8guLp4kzmAhm
	 ykPGp/fmr/78BgoAoFNC1SxBH6QW0JnUUWbsZ8aqm0raupDWk3HuUHNfdEJtHwN+3U
	 NRLdZbAv7SqbQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 03/15] nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
Date: Wed, 13 Nov 2024 22:59:40 -0500
Message-ID: <20241114035952.13889-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In later a commit LOCALIO must call both nfsd_file_get and
nfsd_file_put to manage extra nfsd_file references.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c          | 2 ++
 include/linux/nfslocalio.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index f441cb9f74d56..8beda4c851119 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -29,6 +29,8 @@ static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_serv_put  = nfsd_serv_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
+	.nfsd_file_get = nfsd_file_get,
+	.nfsd_file_put = nfsd_file_put,
 	.nfsd_file_file = nfsd_file_file,
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 9202f4b24343d..ab6a2a53f505f 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -56,6 +56,8 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
+	struct nfsd_file *(*nfsd_file_get)(struct nfsd_file *);
+	void (*nfsd_file_put)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
-- 
2.44.0


