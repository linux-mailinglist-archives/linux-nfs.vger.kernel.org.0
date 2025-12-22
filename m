Return-Path: <linux-nfs+bounces-17255-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3939CD66C4
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 15:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0134A301BE8C
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57641303A05;
	Mon, 22 Dec 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOLaoWib"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A252FF651
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414672; cv=none; b=bCzS7wGJEYQL29yUPdzfxdU5DuCnk+ioBi3tHNH16xklS1Yifx8VWBrQTHOZvH0VhFotItuTOPwQvdpF7MfdPQiQoiu8UNeImuLOdOEEaDa0AiM1V9r5viZFbDR9Tyb49IyFQwuaD/Iald6ZrCYTO7k2ZBIHjgMqyFeIyj0PYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414672; c=relaxed/simple;
	bh=0MVWiJ41KizFxo3jDRPj20ajRcuhcsoOtLFp3mnPEtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5x5WbJ1JgTmAVop6aNntZVzY3KE+OE7LRP01/RWRadQ+ZqZkgVAQUzkIYv/oGT+Pzz8xjKqr+xf1Qfy/pFtNL4b056tTc36TUW4N8jgV3iw0n8wSMfkY95FAvhvTTyDJfwk2armbrIMyos31xI6iBatHX9aNhwsN/5HinSJuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOLaoWib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C36FC4CEF1;
	Mon, 22 Dec 2025 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766414671;
	bh=0MVWiJ41KizFxo3jDRPj20ajRcuhcsoOtLFp3mnPEtU=;
	h=From:To:Cc:Subject:Date:From;
	b=nOLaoWibonZCD7nuLibvFMZxYVQNTZmG737io0HBSGpTOM69cFWQxJEkW+uD9yRVZ
	 vjfW1GrBe7/BXRDt6Eg1YUU/bNv/Xu8+IQ1AP/ro5H9rgSwpluzOXGoRdaX56wWaBA
	 n6YvaVwcLzLa+8bXw7GnLoL9LHQokf2lQn0noNz+AtWS02en2G0ekxD018zS8qH1Nt
	 DOsg+ZLgM50nnj1sAqcTHvWvXnJkyuQl+OWxuESiOvU6ABaisTYvREgEebzQcGSrsI
	 1q0T6IfXuOCqpshZE7LFUB1WnzYJjVujKf8Vq0FP3TJp25Zc9WpDw0+DP5l++0KvJY
	 UVkn+WOkx8NOA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] xdrgen: Remove inclusion of nlm4.h header
Date: Mon, 22 Dec 2025 09:44:29 -0500
Message-ID: <20251222144429.1331137-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The client-side source code template mistakenly includes the
nlm4.h header file, which is specific to the NLM protocol and
should not be present in the generic template that generates
client stubs for all XDR-based protocols.

Fixes: 903a7d37d9ea ("xdrgen: Update the files included in client-side source code")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2 b/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2
index c5518c519854..df3598c38b2c 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2
@@ -8,6 +8,5 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/xdrgen/_defs.h>
 #include <linux/sunrpc/xdrgen/_builtins.h>
-#include <linux/sunrpc/xdrgen/nlm4.h>
 
 #include <linux/sunrpc/clnt.h>
-- 
2.52.0


