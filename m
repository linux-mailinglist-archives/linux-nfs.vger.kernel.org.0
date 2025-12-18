Return-Path: <linux-nfs+bounces-17223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 132E2CCD813
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1862030407A2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386D2D94B0;
	Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH1Xl4zL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2B2D8DA8
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088857; cv=none; b=rdlBxK3N1Qoy5rCYci5wRdUAlbWlk6aoU2lz8pzmdYYpCsdjMQY4U/CiYWGYa5j0jJIPv7QUf9lzlW1TzZIftJbu0pvtNHtDmsx2zZXggCUcD0lLncxCisHulPl1BQUDlBa+Tl5G8DjS5FDtCWus8EKjEZIsbavbq4MyCyu3oUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088857; c=relaxed/simple;
	bh=2OOEALvCZsbI2C9R1rPzj5HWfn4YzjLzJDcZjRYg0ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvO16o2xmHbWNm8KzmF2RAc3N4vUyFY5bve3pwHvGdSP/DETdS7kpdcQkaUvo398dASQpl1OaAYnwVzOh8CXFVWIjM9iwygmO4kllD1+IauSKXJptxgu81Yb+OeatA10rmLXQCVV/DNixMb2rAYdmHsmvVUIzhu+Vsvma0fVlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH1Xl4zL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F84C4CEFB;
	Thu, 18 Dec 2025 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088857;
	bh=2OOEALvCZsbI2C9R1rPzj5HWfn4YzjLzJDcZjRYg0ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eH1Xl4zL5RknmOKAMcJw6iVJ7Zjeztjir8L5jPm4HeXlBlc1zW1vGFKn56S3c1a9+
	 Lpw/NCRUuiHt5A8IMuL1mb/vMWbGh9lckTNv4I+jllbxQ1cLzqCIP2v02Am68UvrwY
	 +oUXuylrLtRs5VmuP+7ZfKKY4+EI+m0WrO9kfixKbXzkH5hLAAn3BxRcMfjLt1BPPO
	 I/ZIuDZfVQUTkj6D3H34KpF9pjd9Ri3XY/Wsl5GbCUaZIcr+pSHxk3MpqMYOky/K7k
	 GppP8TAEXtC4E01BFCCIEBNk+IjM48O9R+O7P8Xyiy3U5vrSl91qAVRkXQ+OCjryUB
	 A1yFu8mZmG7HA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 35/36] lockd: Remove utilities that are no longer used
Date: Thu, 18 Dec 2025 15:13:45 -0500
Message-ID: <20251218201346.1190928-36-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index ea5b502e1983..44aa7df36915 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -17,8 +17,6 @@
 #include "nlm4xdr_gen.h"
 #include "xdr4.h"
 
-#define NLMDBG_FACILITY		NLMDBG_CLIENT
-
 static __be32
 nlm4_netobj_to_cookie(struct nlm_cookie *cookie, netobj *object)
 {
@@ -975,16 +973,9 @@ static __be32 nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 
 
 /*
- * NLM Server procedures.
+ * NLMv4 Server procedures.
  */
 
-struct nlm_void			{ int dummy; };
-
-#define	Ck	(1+XDR_QUADLEN(NLM_MAXCOOKIELEN))	/* cookie */
-#define	No	(1+1024/4)				/* netobj */
-#define	St	1					/* status */
-#define	Rg	4					/* range (offset + length) */
-
 const struct svc_procedure nlmsvc_procedures4[24] = {
 	[NLMPROC4_NULL] = {
 		.pc_func	= nlm4svc_proc_null,
-- 
2.52.0


