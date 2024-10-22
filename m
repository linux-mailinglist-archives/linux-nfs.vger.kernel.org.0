Return-Path: <linux-nfs+bounces-7367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1F9AB55C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 19:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A086280B83
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9271C0DE1;
	Tue, 22 Oct 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAGpus4n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC191BFE1F
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619036; cv=none; b=i6RJlncYX27PuPu3aqXPXiM2nkOUTTtLMaQwXAsWtz6P3SuHQ7FAsFam0SZ2YJEiz8NdRJjk/yWW4LLYIxDGg6En4pyluNsTwYR8AyOqZnov8DBltS3BHrYEjCDEUuDtpF3LhJMjSpAoZEIJ7TQ5fRVYpgga2ukyMjhlOyporTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619036; c=relaxed/simple;
	bh=ONXMGBOwscW3Oa8N9oi6m2dARmqurG+/jgzEWMo28mU=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoWe5B7g6mjL2iu1t8DImFUugbOgX7RtPg6kmKNuiks5oYwC4OYdu1/FELD5tFuuowEyHkXDKTI+4m6TPnx/oUjQOZo1M9QVyj6dLM+OsyZ2hR/Eg7FNC8lHusjgB2FrvxeQfu5b48k+4hC/WO4I2b+JU2HsCJ7gLboMQQpfywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAGpus4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECA6C4CEC7
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619036;
	bh=ONXMGBOwscW3Oa8N9oi6m2dARmqurG+/jgzEWMo28mU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=pAGpus4n/nZnrqsI9h2joIZa7o3r1+lWbSwd4rdJsf/IPjSMvmJEQIGP1oHkAUVK8
	 bfpbDSvlQsYiDKW39wWyaUvUgqv4ffgbANjvoQ+nAyylkTfGvcgMH+nepM339rXR9G
	 4fZBRTEg3ww0WXi31xMLew/cAaXgj9wqBh2luWvy0ndYlna+Vn4Ov9mt5a217BjLyE
	 B/oy4I3mKuW65rOkYXWC1228df4XR9Je8ewZe46XwA3zz/anvseG4uQuvcZBYpeD4c
	 0BEFany1vzEae2t8cNN5qAFDsBpBYRv+FElRD5GQJlXFVK5dBnwHCto6YZpaskkWZh
	 oUdxQw3sytmJQ==
Subject: [PATCH 1/4] xdrgen: Remove tracepoint call site
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Tue, 22 Oct 2024 13:43:54 -0400
Message-ID: 
 <172961903460.5686.4793239936310073455.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
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

This tracepoint was a "note to self" and is not operational. It is
added only to client-side code, which so far we haven't needed. It
will cause immediate breakage once we start generating client code,
though, so remove it now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../xdrgen/templates/C/program/decoder/result.j2   |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
index d304eccb5c40..38c31b3f0589 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
@@ -13,10 +13,8 @@ static int {{ program }}_xdr_dec_{{ result }}(struct rpc_rqst *req,
 
 	if (!xdrgen_decode_{{ result }}(xdr, result))
 		return -EIO;
-	if (result->stat != nfs_ok) {
-		trace_nfs_xdr_status(xdr, (int)result->stat);
+	if (result->stat != nfs_ok)
 		return {{ program }}_stat_to_errno(result->stat);
-	}
 {% endif %}
 	return 0;
 }



