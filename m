Return-Path: <linux-nfs+bounces-5293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEEE94DE6C
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A01C21420
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23D13B5B9;
	Sat, 10 Aug 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifKy31WL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D81311A3;
	Sat, 10 Aug 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320077; cv=none; b=XKe7ipxWjPe9CeO8Ajhz/k0AqjqY9xhuNc2VpxgtmdrOwpPbMrH++MNfPqn+0w0CNEXla36/NpRwBh8n61majt1O7eZKnL/1fUQmoU7HYLY9dUbmbkxyPh7iUv8citBPhih9TIdENw/0AqfWALLsNVFLzFpuUB9EwjexyCzJN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320077; c=relaxed/simple;
	bh=fSa2kBlpMmnpoyWnA7ZNT2P1yMdtnbACiuDmxn1ZLNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP/3iCjtW51CWLUVx04CBZjJ211qTyRhUWpFgoAG3zqATp5TkJr5Tq2EAYYGOWf6YF20mwSfRtprdLNKYm3tF7kwgSBjl5UBEdQnYB6Ni8LVZVJICp8BVdyvOCDWI32HZSO/3W6byHeK8mdDj4jW4yjPdc+OP8c29qSSQWbLGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifKy31WL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C62C32781;
	Sat, 10 Aug 2024 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320077;
	bh=fSa2kBlpMmnpoyWnA7ZNT2P1yMdtnbACiuDmxn1ZLNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifKy31WLyGbQ6Eu0jmq4HxpZdpr89jWd9EwJKm9Q8adyaNCiTmaT0s49YdG7oRYkO
	 pzzbULvwlK8xp/s21dTkCTZz3THMxeCAfbliCrzWZ12zu632R5HmXiwuRr5MVTZWe0
	 CMBoLb+84BiGSRXdfaO34T4G7kXu708Mtymn8/sfPSU9k+0a2YTuNcQaTRJp+R1CDL
	 eNRQ1M21rknYbqEz98IbziXpYexmBOCVEXEkxcENqH2zg56PTSyHGsOiSka8d0GRZ+
	 LrCuu4tEmnAozluqVGWMPGOxEk/wbl5ukTw+IJ90Cckjsacf/jDUG/ton0HNu9BOkN
	 sxI4KnsgHqKlg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 13/18] sunrpc: use the struct net as the svc proc private
Date: Sat, 10 Aug 2024 16:00:04 -0400
Message-ID: <20240810200009.9882-14-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
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
index 52908f9e6eab..9a0b3e8cc62d 100644
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
2.45.1


