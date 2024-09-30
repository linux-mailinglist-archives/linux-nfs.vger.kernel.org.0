Return-Path: <linux-nfs+bounces-6704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E119898AD
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 02:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051FDB22886
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4274B6FC3;
	Mon, 30 Sep 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsvajxyv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE186FB6
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657432; cv=none; b=dbM5bfGYXtCZD6YLmZbv145MpoiTaBaGkMFU7wXAyPq61Btm357MSQXdSTvwC+O/8CzFq0mpQi5LvFxBxg8HLBmdTeARzFZzhXAAM3/Uhj30UeG0WfjI49CqRjQrpYgo7Q/pmz9Lksk0HxfUF8mgrjsijGgWTlwYw7Xah3o63YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657432; c=relaxed/simple;
	bh=Vz1j5PESoikwRGTiVNr+qkBDOs6KPUPeGmy5A7asREI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoMhnrTu1kbOjoim1KHlpmk3QVlEkwEr+BD2zZ4rlQktmZ36zQWixrbu7mJdtUx5nZKJsMFuJFrWw2vysc6w9wEoqTsfyfDyFM962pQ/4EDIqNVfXYzG+VT6acOYVEedBqteGGj+mcA1pYpUgegFXOaNq5wnIpo+Nqape6QRrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsvajxyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BF7C4CEC6;
	Mon, 30 Sep 2024 00:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727657431;
	bh=Vz1j5PESoikwRGTiVNr+qkBDOs6KPUPeGmy5A7asREI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsvajxyvz22fs7ZOkFPaGX72dL53Taxpr/SxLVaFaQmoHuxrUMv5pyUBVixv6Yi2n
	 lGI+8zZX9HJT61NaapSu2G3v2FK4shp9rv3vLEvI0EASEzYA4M4Dz/d/fq9mh00ERY
	 ec0YJZgNXfeUBs7hGTaT0tLjEG50f7V3yxPS01L0gkjumk92oMgbxlLPctV1ZpkNqY
	 e43e1Uh1H1O1BcyKBAwUW1eqJ47mSlzWkKj9Pk4yWdqxJ10umy2xl4v5Kewmd0iNAh
	 0oo+LADYqz8vIUO8HNqa2NLgoWbaH+E4Q7SKXzf78MgmPwZZmvUqwaZ+wU0BXxx/H1
	 8qDSXVPqM+Gtg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/6] xdrgen: Clean up type_specifier
Date: Sun, 29 Sep 2024 20:50:12 -0400
Message-ID: <20240930005016.13374-4-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930005016.13374-1-cel@kernel.org>
References: <20240930005016.13374-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: Make both arms of the type_specifier AST transformer
match. No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index dbd3fcf9c957..5d96c544a07b 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -303,9 +303,9 @@ class ParseToAst(Transformer):
                 c_classifier=c_classifier,
             )
 
-        token = children[0].data
+        name = children[0].data.value
         return _XdrBuiltInType(
-            type_name=token.value,
+            type_name=name,
             c_classifier=c_classifier,
         )
 
-- 
2.46.2


