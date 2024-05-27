Return-Path: <linux-nfs+bounces-3410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F18D0664
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0084DB2E565
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736B15FCFC;
	Mon, 27 May 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se4xx5vb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57815FCF9;
	Mon, 27 May 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823661; cv=none; b=BE2QbFhGpexzyyPZg98MoH9NjvU/VIY3vAn+rrHPPdz4AUMBQ2bGhb2lPz1UF/CetYt/fAY9ey5YUVV9oh/aAwHjoWUxzdk/+uw7qYVji6Q2vA+IOpU0QjMyYnRriIpityI5VPWw0McNMcGeWwf790JsH3bxiy8OkW11QTp0BVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823661; c=relaxed/simple;
	bh=eUlfksv76WqSMUglVS8Fo4aPW+gKMJ7VuKJQT65Dnks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTC3ClAHrexUXS9jLpRckJFurP1n1gce+piWawLnYW55/uNsADkWbOfLy3rEt8A2jIWCtUxBXe2p6MRHfaicXthDZwr4r5y0uLcl6BWpkGFkbuM7JfifhRXJwFC9j8dwESaf4enaPhd2hyB+3BmlRzGd4xxfSMri0FJPUB1+YG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se4xx5vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2C6C2BBFC;
	Mon, 27 May 2024 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823661;
	bh=eUlfksv76WqSMUglVS8Fo4aPW+gKMJ7VuKJQT65Dnks=;
	h=From:To:Cc:Subject:Date:From;
	b=Se4xx5vb0AY0N6y8UswlPHhMOzudyGQDY7zjX9WNgNK2kVwTcGPHuM0d7qTiU5mKv
	 7bKx3jpK5AvyJhJkD7lUP1ZD/vjtdmIGgW8thZCwVbgmheynTJfGfjGbPnDocxIX9M
	 Fdi2aWblWNBD9NPFcIU1yttsmEqOJIJw98rZGYwu994tUlvssoKS02AmQx9zSMYYze
	 SVg9p1LfbvQqS40YSMzZ1j20/WdCKjum7Qi7PyqEUh4R6mbfm/JeMXfu259QYUnaGK
	 ki+CQX7Pknf3OBVc+MCDrNKYLdzh7fRdK6DoN8pkR8oY+ADCvdfezrKj4Rn73OP/OB
	 sjYKTI+EedjEg==
From: cel@kernel.org
To: <stable@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>
Cc: regressions@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.8.y] sunrpc: use the struct net as the svc proc private
Date: Mon, 27 May 2024 11:27:28 -0400
Message-ID: <20240527152728.1097505-1-cel@kernel.org>
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

This pre-requisite is needed for upstream commit 4b14885411f7 ("nfsd:
make all of the nfsd stats per-network namespace").

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


