Return-Path: <linux-nfs+bounces-3381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F88CF247
	for <lists+linux-nfs@lfdr.de>; Sun, 26 May 2024 02:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A11C20D41
	for <lists+linux-nfs@lfdr.de>; Sun, 26 May 2024 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120533D62;
	Sun, 26 May 2024 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK59GkrJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6B3C24
	for <linux-nfs@vger.kernel.org>; Sun, 26 May 2024 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716681705; cv=none; b=JOvyrf8dLHtIf97kIHOu8JTSHRUpCngzF+mtEsm9Z9aEXbOO1ZzT3FnROWR2H9tOycLZzaG7uX8vsaSQmwzb+/ycd7HFb+mi5goV6j5JMAhLlLrbVFNTGlBEyo+h20jrLOrDKKh9zNIakWO26o1tGFlzyPKF7ufDnd0q6T+snPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716681705; c=relaxed/simple;
	bh=12Vy624mxOQoeYC01XZoI1hXJDJhOqfSU55FT1+zaS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMyTEyPX8Oaovl40o9HEvvJeHDIc9nK/ax/1nipjBTBPFzmLd05N+riQURJ17pzuf41llqcu2IkUBGoXjGAW736ZXCQLq1wUO/VEwx3NWrz920rgBd9mIrkE5CwAjkm9reKA5hSsB206Dw6ccq3dPKvvB2ei5CSsJt7OWsXaVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK59GkrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F90C2BD11;
	Sun, 26 May 2024 00:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716681704;
	bh=12Vy624mxOQoeYC01XZoI1hXJDJhOqfSU55FT1+zaS4=;
	h=From:To:Cc:Subject:Date:From;
	b=SK59GkrJhwMd6xi7G53715iyzEjlPtXlqcK0ZQluG4DZYB66yRM9ibhjjlpitrnuo
	 RJu+hdVcwxE/cXEoEr8KsLRy05IJmhloPwnMYIBieeaMLs7Okdq8JHq4qwrHQEYqHD
	 zsG1AA2eAZrvjt5kbGJr0SldzQDz74gQ3w3Bj4FVaGxq92D8XJZvPoM1VVjEd2Hd/P
	 BqrBsIZ2Exp9q6RGq7b41xmkC+99W/YI5EtD7KcoSQVFfaPfhFcBtrKNa1fv+YHZSu
	 TdbgZRDPzvSUm+dLk2p2SuNxGrRWTjSJX5eAmhcH35/RCbm3xc0yaiVB+NVM1yXuTH
	 Rru+yvaE2oqLA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: jaroslav.pulchart@gooddata.com,
	rankincj@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] sunrpc: use the struct net as the svc proc private
Date: Sat, 25 May 2024 20:01:22 -0400
Message-ID: <20240526000122.386951-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
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


I investigated the crash reported by Chris and Jaroslav. This patch
is missing from v6.8.y.


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


