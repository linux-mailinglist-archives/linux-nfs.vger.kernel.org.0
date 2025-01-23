Return-Path: <linux-nfs+bounces-9554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14818A1AB45
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A173916C637
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BF21F8937;
	Thu, 23 Jan 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1C958ad"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A61CBE9D;
	Thu, 23 Jan 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663940; cv=none; b=meqz//pXJlmH4m+W72WHLmhmBA/sf3CYxE5hH5yt4mA72RBx6S/iYKphKAbTdRi9mYmtFPCJUOAG5+ItgJdCOLEbbWW7Ym5pZ7yF8xxKiZqQYJfofk19yin3ISCwgFJhL5IkxOz0jVZdI6TSBew67Nr2qbVeoHvT/IW0EZJSz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663940; c=relaxed/simple;
	bh=aSOD5+DAmZZ0xUmUGq54Lf5+/Ud5toy4MmXipvDzm5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvDmGZShOT4g9LIofWitgGALFlDoY8rsQSotZmgCpKd6jQctCKnyK2DqhWwMNcJfpIa/LKEY3BrBesPF8cq8zztnB3NPXLzyDcUSXiX0Kgeut5XHNAxDkka1FIvhGM3hJB4P7SIYC6vqpuvnuZwUGYTXtk88rVzj+811DlU6/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1C958ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EA7C4CEE2;
	Thu, 23 Jan 2025 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663940;
	bh=aSOD5+DAmZZ0xUmUGq54Lf5+/Ud5toy4MmXipvDzm5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U1C958adTbgxL7bLBVDARs6R8UB1H+o2UldkNtr3BMYj1mzXM7v/C5HGvKTo8IMNO
	 PNQpUj/z7K/Y4xG8EJ3fJHx/I19TepDJpoCjMpQPtClAn2klJhcSQCShtfBme+mfVq
	 KGEJ+fzd6bKNSL5jm64zxvkyjELIBOoD0squQXSDzWjLaM3Etb3mD/kNM6pdh6kc3/
	 ZEozSdBeQxBvt8quB5SKtuUqIhNZc4lbeG9ic1uf4xICWYsKBbbFr9OlNtJasyQwrC
	 O1fAIlHzxnzC9a5+t2BbLEmMBNelr5ujeiBU37+yrDc69haxw9twQCnHhL7WJ0jBjc
	 D9zW7hcsbVizA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:20 -0500
Subject: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release the
 slot
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
In-Reply-To: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aSOD5+DAmZZ0xUmUGq54Lf5+/Ud5toy4MmXipvDzm5Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW8N7ZlMjnpKJ31AvMVqai34j8DE8KSt484G
 igYEh6a51mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KlvAAKCRAADmhBGVaC
 FUXHEACrtm5qNLxkL4M0xnuUb/U92RRi9U7auTEGXBRRGwcsxCBNdFfoF6tK/id1uWFng+Il5dJ
 mcADoxmcDhDd+38uOPek5tiZxdHhozzD8LAwb876w0TMkFSB27nIJWE7J7BZD/Mxf5JAPRYH7cA
 yHG0CsxrDzSFzfTnueAABGaFOz3T87abf7r3DzXoa1TYzSOCz0AmO7cVUZfoLT8UvRzh6lbbzRC
 dfO312i8qF8yG2AjE7RUGT2bzarF8AYabjNlEkpIB51xBCEQxFnGD/5nmHpGnWH4zS1beROxb/b
 UJevkqc4mr3GpYMcpCu3ybBKfXDsZUMiBLip/o9b2NT++aJXvLmpYvL5nU/fw4PV1WL9Lp1SWO6
 DzbSwC+E5+P2D33aERxtAteqM0vsUNNsJkgfEOaWJc6XrGgfs50mO3leCS+oulaojDrXIe0rNt6
 9i3dr1ytaYkg4+xDzaNl+EaHmxqdPte9M4dLfeHJAAV5DneqXAgg0YqmddsFY7K2r+3yqTapONI
 Kotp19O9DD9PZ+XIKvvXc+8+8W1E4RutVUOueYeEEGA2ZzcAGZky3V5cvqmYW2pImtFI1IG7fug
 MYJiVSdoFP7PU31gRDPREgMYYscH6n6G10sxTPaNYl6nRRlOe1Qh5EgG3LS5x3dlrGgbyZ490UQ
 xUSQh+URXZE9NIA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:

"For any of a number of reasons, the replier could not process this
 operation in what was deemed a reasonable time. The client should wait
 and then try the request with a new slot and sequence value."

This is CB_SEQUENCE, but I believe the same rule applies. Release the
slot before submitting the delayed RPC.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499fc908833a384d741e966a8db 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		goto need_restart;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
+		nfsd41_cb_release_slot(cb);
 		if (!rpc_restart_call(task))
 			goto out;
 

-- 
2.48.1


