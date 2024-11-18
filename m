Return-Path: <linux-nfs+bounces-8079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3429D1A7B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0C51F225BB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506781E9099;
	Mon, 18 Nov 2024 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyuAFKKs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897C1E9087;
	Mon, 18 Nov 2024 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964851; cv=none; b=lE12EyPnTmrioA+V7V3YGnRoDmhE+u+z0RVTBII+/LaqJtOAcwsXdpvbokehsxIfjW5GLo9CSwXmxC15XXHwT7GnhGAwYgrMNDLYIOI0+rJ/gsXNzoN2RZ1wccp99xoLduSOzO7xdJ4L8InTv23LmgS+nBsZGeCVSxvd1EEaMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964851; c=relaxed/simple;
	bh=DFrpZZ2NPQLLVDIJ8ns+Q2FkuW2fBXVGphkUeZbgVzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBT5NUdaXGMN/I1lv3bPzMPSuWjlGTj22sWq42ab6szog3iFhZ9Zbyb3+H3JXuqpQ18EH0AI5xuzT6z7W440sS//gEwuKsrhrguW8pTFW67d2XM5YrS8+ICFwxGRzVVRwMbvBehknIocWyXxwMy4GQ/n7UgFx2fDoNCEVvp+c3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyuAFKKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9680CC4CEDB;
	Mon, 18 Nov 2024 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964851;
	bh=DFrpZZ2NPQLLVDIJ8ns+Q2FkuW2fBXVGphkUeZbgVzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyuAFKKshtnzU37/5oWK5w2r0uEH/bX3A85pJsUG9eAbX3EDaI0nKjcensKMKdigb
	 uVSiqEOGLkdSDkNgVPn6ArjS0QR4GCCIO9yEYv9DHuj/tE//lHKCQnL6FpuAET8Lko
	 pk4bGLifsFPATOuKJH/nihGWZqGnFA80wowUNlFwKdC+aZ+hkaTKPzMVYZxnACIUfu
	 nWOyv0yPBZpwgwNWivRIv4dwx95Nl19yYh2q3LOMgINIOOUD15RTCEdupL8CEJ/b9u
	 eFOTyTT2wn/BUB99TUnn/4izFc5z2szRIyElsWOQ0WyyyuDW/Z1qjfJ4AYZ3qJdk62
	 H2MFHmF7CABpw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 5.15.y 13/18] sunrpc: use the struct net as the svc proc private
Date: Mon, 18 Nov 2024 16:20:30 -0500
Message-ID: <20241118212035.3848-19-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
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
index c964b48eaaba..a004c3ef35c0 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(rpc_proc_unregister);
 struct proc_dir_entry *
 svc_proc_register(struct net *net, struct svc_stat *statp, const struct proc_ops *proc_ops)
 {
-	return do_register(net, statp->program->pg_name, statp, proc_ops);
+	return do_register(net, statp->program->pg_name, net, proc_ops);
 }
 EXPORT_SYMBOL_GPL(svc_proc_register);
 
-- 
2.45.2


