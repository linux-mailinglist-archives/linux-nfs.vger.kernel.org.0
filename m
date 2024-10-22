Return-Path: <linux-nfs+bounces-7369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AEB9AB560
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 19:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA88F283BC1
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727CA1C0DCA;
	Tue, 22 Oct 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGYLWIiC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33D1BC078
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619050; cv=none; b=gVuZkTl2DuiXgMYIYoztQlOhNvYuNmuUgPlLDiZ16q2/HxHBE2ST3fbg4KimUbDQjmCq68790qgfUjMD2Ux6tzvXSx+aPrbtHp/fAaAo3H/UxaIE/sj7vpL7HstRPiGVHvKbDbbZdiV7FYz42QQnX8X8J7M8A8dQe+PhqOx/S+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619050; c=relaxed/simple;
	bh=8QzON+gDjgE+tzljL5mmtNzMvTUXr0Ifdp2X7UBE5uA=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHxS+25QSCt6UvxWtZ0YszTcHh65TYXkA+YHCZDnc4qpWbHSSJDSOlppkcQSEhgJp720/LQUOGxkIaYKJHoLkc+FRb2Vu3r9EvTHXiT3VQNGludI0UOqtr/HcNV2aDlFcWRlDjxLXEJwB4YYw0V6dh2NcnJBEQiHSHxjhBoAt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGYLWIiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF9C4CEC3
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619050;
	bh=8QzON+gDjgE+tzljL5mmtNzMvTUXr0Ifdp2X7UBE5uA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=YGYLWIiCJjs7VhFoPy4EiFDxNpNDdDcUK58e3ccecuBBF7lfgKJ9RmI0Jej6+Yf/E
	 hy2nW47Lltu9/E4RXh/v54YyW+aYxmvECJnBd0v8EK870gvs8URxyj91jBA8dwibo3
	 KApxnkWkhv5MR+x7FqKWOoQlD7BzCNlxB2FArMZQBOHpK6rt6nyOfmoewFebz3/PPm
	 VNFIwdlfcwWz2H6V0W0028FrCxKFR5mMELc50PcL8bx9nqxiVy5G1kQztCikghhyzM
	 O0vUqwtw9/nRo8CvK6rbKtnC6NKiA3jkb7UirL/IXshFozOlup/fq1KRUQ88JuJpcD
	 gD48c6Bfa7P9g==
Subject: [PATCH 3/4] xdrgen: Update the files included in client-side source
 code
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Tue, 22 Oct 2024 13:44:08 -0400
Message-ID: 
 <172961904845.5686.11045358540704984065.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
In-Reply-To: 
 <172961889678.5686.2180145399460027810.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
References: 
 <172961889678.5686.2180145399460027810.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

In particular, client-side source code needs the definition of
"struct rpc_procinfo" and does not want header files that pull
in "struct svc_rqst". Otherwise, the source does not compile.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../sunrpc/xdrgen/templates/C/source_top/client.j2 |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2 b/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2
index e3a802cbc4d7..c5518c519854 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2
@@ -3,6 +3,11 @@
 // XDR specification file: {{ filename }}
 // XDR specification modification time: {{ mtime }}
 
-#include <linux/sunrpc/xprt.h>
+#include <linux/types.h>
 
-#include "{{ program }}xdr_gen.h"
+#include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+#include <linux/sunrpc/xdrgen/_builtins.h>
+#include <linux/sunrpc/xdrgen/nlm4.h>
+
+#include <linux/sunrpc/clnt.h>



