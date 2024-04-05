Return-Path: <linux-nfs+bounces-2676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E489A3C3
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 19:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74998285E0A
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9946171E53;
	Fri,  5 Apr 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKn2vHcp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002F17109C;
	Fri,  5 Apr 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339796; cv=none; b=NzUUoCDBZxR2MDN5VrhkTMonhXpcng7qGQmIwkjQqDeYsz9fLJLSPzb/ZLr047kN2whQmI2F9ZdWQzU2Kznzbs3QGf7oolpKGYus+pTHu5FvYcIUXTFqdZseEzCgSxs86N2z/RvX00eGqAEbR5N3eX9kHooTvOV+G25ZG87J+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339796; c=relaxed/simple;
	bh=JRjEaIMmngOjNnpfg5q4+lawVX0ZNNOFgJyaMl6eIuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qnk4VZgobIrZ3yAo+U+fN+uFGlj1rwPAnOjXcxEw3H4jANHiX4kezfjswyEGwofYlbgFjbb9lgmwdAFVVYaUQR5xVvSdFOIFC4GGHvJ1Uk+/7ZNk1rfzkp3i4hEFiCEMQs8Mn3R6B9shUXetzQDANYMl0GJHD2rWE8zSv/xJ0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKn2vHcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA61C433F1;
	Fri,  5 Apr 2024 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712339796;
	bh=JRjEaIMmngOjNnpfg5q4+lawVX0ZNNOFgJyaMl6eIuo=;
	h=From:Date:Subject:To:Cc:From;
	b=AKn2vHcpvPe7FQLxUXV2mEFD6f9xMyi6127qjJx3Su/fdUBcDZAPbEUN1257I9tpw
	 fO018bGZaQa/IZ13zqnQlj0UxSM4Vrd0D2FFNFIoqZt2dixc3X68Br3+Wz8hG4YXvP
	 BPCJe8W2ZjuivIGtalPNvy3H9QePXFgFU2iCGVNjNWpe0QuTz+NQn6dHJlvy8rLqrp
	 H9vNTlUOnvE+5b5SB6ef/7uU4IBNHfDx+gZlJ5hilWbFKIyPA3FGM9kp+5/qF4CPiN
	 tyQBLClwhJQdvOsaWcoeeWbazlI+s4uNDPX/WErYJh6c6MwqqfJw1QXShtE5Ac/YrW
	 Bs1fRWrCUuTLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 05 Apr 2024 13:56:18 -0400
Subject: [PATCH v2] nfsd: hold a lighter-weight client reference over
 CB_RECALL_ANY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-rhel-31513-v2-1-b0f6c10be929@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEI7EGYC/23MSwrCMBSF4a2UOzaSN+rIfUgH0d40wZKUGwlKy
 d6NHTv8D5xvg4IUscBl2ICwxhJz6iEPAzyCSzOyOPUGyaXmmhtGARemhBGKcXlyd+uFlkZCP6y
 EPr537Db2DrG8Mn12u4rf+pepggmmuVVKW+XPk7s+kRIux0wzjK21L/nvzSGlAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Vladimir Benes <vbenes@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JRjEaIMmngOjNnpfg5q4+lawVX0ZNNOFgJyaMl6eIuo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmEDtNQkE2HuQ910LLd1UzFqnpajBHhFC2+/2bN
 xGB235LPEuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZhA7TQAKCRAADmhBGVaC
 FcN4D/94x5SNIMOx2NXzJgRKLSj7eN3I0WLl+0UOq3bHoJ+RgJbJGL2cIRHLG4I2ErBiy91gUgw
 GkNKGz4QA8NVMj6Bc5bF9tOJSYlUJSP6UqdfzZKNezA9qq4pwEBYv1iDSDMBixAfoM1oFxteUYq
 wBaW2bY3qoWgDx+sTrs9v88fi0doR8kKrY8xKrBXblmqNrj3ZdlmmA3wVgKKL4fN9gPo1tP+Bxw
 F7djeTgfzZzcS9UOGUpKQ1FRzOgdhZAhLIBgymsDBa+QYvOSFOqNqSqgq2qgdPWZxtN5ejXpEBg
 4vPI9E1HCv5L8PcR11z6jmQLzVzf5gMOqpb5QGELE9ec+q3d150Jngd3tv09DIX3A5LpU7r75it
 5CK9iw+62HKu3rTQqGavKnUveiK/BEEZXHr6i1EAMnzpVACc4//BZLwnIwCLqO/S/hmPQx+7PUM
 sESSiZ3odPA63jHJjHPW4Ks+Fskb9ds8+de+qGvfbpwmf+TSk4/NnMt/CSjtMhErcPSkN0S2x5p
 zYjm1ocy6OVPbUfLnM0CwBbqI0kDDnT41wDb4pj/z/NiulAF+tpRrw1gLElnOQtlDGVZTFFriDg
 MwTEb+mwUHjTtRvzxKzuOOtgJt9OIuqLYLWVspryIuTmEszOR/yckn4rgDzdPiC2bCvyHltDC/3
 EsEXz7OwJu/qAhA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently the CB_RECALL_ANY job takes a cl_rpc_users reference to the
client. While a callback job is technically an RPC that counter is
really more for client-driven RPCs, and this has the effect of
preventing the client from being unhashed until the callback completes.

If nfsd decides to send a CB_RECALL_ANY just as the client reboots, we
can end up in a situation where the callback can't complete on the (now
dead) callback channel, but the new client can't connect because the old
client can't be unhashed. This usually manifests as a NFS4ERR_DELAY
return on the CREATE_SESSION operation.

The job is only holding a reference to the client so it can clear a flag
in the after the RPC completes. Fix this by having CB_RECALL_ANY instead
hold a reference to the cl_nfsdfs.cl_ref. Typically we only take that
sort of reference when dealing with the nfsdfs info files, but it should
work appropriately here to ensure that the nfs4_client doesn't
disappear.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Reported-by: Vladimir Benes <vbenes@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Clean up the changelog
- Add Fixes: tag
- Use kref_get instead of kref_get_unless_zero
---
 fs/nfsd/nfs4state.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5fcd93f7cb8c..3cef81e196c6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3042,12 +3042,9 @@ static void
 nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	spin_lock(&nn->client_lock);
 	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
-	put_client_renew_locked(clp);
-	spin_unlock(&nn->client_lock);
+	drop_client(clp);
 }
 
 static int
@@ -6616,7 +6613,7 @@ deleg_reaper(struct nfsd_net *nn)
 		list_add(&clp->cl_ra_cblist, &cblist);
 
 		/* release in nfsd4_cb_recall_any_release */
-		atomic_inc(&clp->cl_rpc_users);
+		kref_get(&clp->cl_nfsdfs.cl_ref);
 		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
 	}

---
base-commit: 05258a0a69b3c5d2c003f818702c0a52b6fea861
change-id: 20240405-rhel-31513-028ab6f14252

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


