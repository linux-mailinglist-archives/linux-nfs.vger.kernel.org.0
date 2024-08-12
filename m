Return-Path: <linux-nfs+bounces-5333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C194F9B3
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C46283B21
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8BB198E78;
	Mon, 12 Aug 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBcl6eG9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A7198E88;
	Mon, 12 Aug 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502247; cv=none; b=ULRbkch70TpQhOt1dwkcNku/BeaNngmrJcJDFVtet1YQbdQjBNvgQixiPfbiU5WLokNx0dFV4PJt6NSdNFPQcK8P0EuwhQHNLZlFk0eeEsRuejzPiPvgyXW2Mvm3voVV+7aSdhitkYLP2GhAIAHz/WF3VA5gkYFTG2K5WB0cDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502247; c=relaxed/simple;
	bh=Iqw1izZVrLP6PyLzjDyHGBVjOflGvpUWanctSSSGbnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhMm7pycJ07t6Dy30GJbO40IBgLCp9lImyd90Qp/KsQa3BgbWywQo5d+2BAJ7vBBf8dlzNH5dw6oDPBOAUvikUuzsLNf4qSpIE1mchaYjS+gy93oPw/q3Gx6yxR5nq4+T3O+/UVZk3ug1PSp+L91CtLENubvXY8xvbVfyDGry1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBcl6eG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9CC4AF0D;
	Mon, 12 Aug 2024 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502245;
	bh=Iqw1izZVrLP6PyLzjDyHGBVjOflGvpUWanctSSSGbnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBcl6eG9lAiEiT/+72gZpFum3bbSzzquwWshxVA0kU0bcyKHOpnoUoNZqxzHBiHsS
	 qPn8hhj15CjACKJwyskH5AwuYitP6oIAygDBvXvxkuEpVXeJabU5c8TMkFvi12WUwY
	 J+eEoK4rlfo82Jtq9VTmt71bI2NNPjhb9wS9T33wh88VbKaekj7DQWnNHT5EtYIJa0
	 CWHDyvyb1WTPLJ3osO6g8GVnGuLMFrC7ux3DRqCIt2nl7V5ahVim7SDsaraWu7e4ac
	 w2Rpq3xtHg4+c521dTW13xuPi8SLRkhCYL0fYS8hEIMpPHG/ekBrHnrwazr5s+eiXP
	 abNM4DJiN9krg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 07/12] sunrpc: use the struct net as the svc proc private
Date: Mon, 12 Aug 2024 18:35:59 -0400
Message-ID: <20240812223604.32592-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
References: <20240812223604.32592-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 418b9687dece5bd763c09b5c27a801a7e3387be9 ]

nfsd is the only thing using this helper, and it doesn't use the private
currently.  When we switch to per-network namespace stats we will need
the struct net * in order to get to the nfsd_net.  Use the net as the
proc private so we can utilize this when we make the switch over.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 65fc1297c6df..383860cb1d5b 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
 struct proc_dir_entry *
 svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
 {
-	return do_register(net, statp->program->pg_name, statp, proc_ops);
+	return do_register(net, statp->program->pg_name, net, proc_ops);
 }
 EXPORT_SYMBOL_GPL(svc_proc_register);
 
-- 
2.45.1


