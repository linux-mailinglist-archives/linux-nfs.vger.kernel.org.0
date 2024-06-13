Return-Path: <linux-nfs+bounces-3775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A990788B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A3BB22B96
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B51494DF;
	Thu, 13 Jun 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvLoCzGp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6869149DEE
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297069; cv=none; b=bTdHBDIm1FW5GUcZ63QJIhfuAOTmK9/GqJqxKpTuK+nfP4P7ofmna0INqmwydBDBTY1WKk7zNsEyzHePOfa7bkJdYdYuJNdloOIXSOuF7bl9Um8XmZzGXbDNGeSvGbMLPNQhBXaz/w/0sHnGxcwXzdI3f+vR4Jcuso47ElIpgvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297069; c=relaxed/simple;
	bh=qntMwaaweWl+Gg/eTntykRnBFONN9GK9xqHM7sT7/nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eF/yhoMWANK7S83luMA0/McxrN/b5c0EY58oIHCEYQEbkUU3iBVm5Qt4F33ftKgYuM4b7kFDyxtN6kzrptv1W5/5gviILHvzoTmUe1GzX2AXookqlPdU70aLbFz5FpJbJkoSgAkzSDSyTAwUNZADgnSy2eAgoVueD2VvDTSaVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvLoCzGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE29C32786;
	Thu, 13 Jun 2024 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718297069;
	bh=qntMwaaweWl+Gg/eTntykRnBFONN9GK9xqHM7sT7/nI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HvLoCzGp8Ljv7ADHpBKrXtIQAgMWo8kgeb+Xu1hs5fOSKsSgNf3oF6WsXgjKZLGnd
	 rk2ur9uJhSNdZIUSOPRgZOfDdZ3s+c1I4Lmfvwu6Hrrw9OShkywpChH1ISDkgKYBbp
	 dsMImeAcAfNjsIQPDU7wEBiQFXKwL8iBO1+0Jiir2nTlMWCIghPWxmp8A5ecyKLi0A
	 VKMa/o74HXK3R8GHwKsWoPVG0kfGKqh2NCqEJHpFcRnp/XQBjPQlQBfrBEwGRKTFhR
	 kgXQxtlyJiFQ+1JfKSDL4lK8kWpy7w3b8V+UfcpMJy1Ql+v6Drdkv0ec+xSleMjy76
	 Ar8B4rFo50YbQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 12:44:08 -0400
Subject: [PATCH nfs-utils v5 3/4] systemd: use nfsdctl to start and stop
 the nfs server
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsdctl-v5-3-0b7a39102bac@kernel.org>
References: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
In-Reply-To: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qntMwaaweWl+Gg/eTntykRnBFONN9GK9xqHM7sT7/nI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmayHopArce4G0UNl4JBkVCnEhGD6/5qHKY1CRT
 gyi1VA3X9aJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmsh6AAKCRAADmhBGVaC
 FVoUEACEMsmVwstR4yAP9Mo1UKCot/yVugDyAZb4UYIOcvGOlexJaB9GHmeSnQ6cdERmNEqV4+5
 1Si6IyYaz+sev5nN1aAH8hUwhDy0+HbPUxwPYe9riKzRslz2yXG9T0T7N8NkxBnSHTvS6mk+Pg4
 LIaK4OtUA3P7+dXto3t1vHbhdMKGPdF3ZQ6e8/Ibb4D9RhtBFYuyYFPLFU3mOCMieTT76Wun/2y
 L2Cr7R/m8FW5PJgy0QQ3AE6AfTWd6REteWutoXJ+GZWe6reRFLILDOIQ9H95AxnIlVTtOgkk+LM
 Gf4ypvYYGEYnirolW+WLlNCftZeKXH38VxKsrZSCx1pk0VXAbQgkptaQRDLpyK6xRwo3evhdpAX
 mx01YHRKXZQ2ee8V8vXyjTzFxTATpFDWvEE0mo67fpSKkdL5Pjll9FU03c/iHys5sS1kNdkq6xA
 kBClvV9Z4+UPM/0O6bJlRCWwZvP68aY9CRmswXvNolmdBdiU9ChXq5r11JQTd8Ey4AiKJrHEQxr
 bq7s135aGjY9Z244romfl2qOdczA6jmAqN46Hm401qt15YMgJYgYeoRfTFT6VtxWlebbfqmA+p7
 7ypFu7V6woit9ktrhhFGKUN5J5F94yDdDgFPZz9K2qj8mEVDHm4Eot1A/Zf89gdjQmNo9MRDiD/
 0iInLYisV/ZX7Ag==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Attempt to use nfsdctl to start and stop the nfs-server. If that fails
for any reason, use rpc.nfsd to do it instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 systemd/nfs-server.service | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/nfs-server.service b/systemd/nfs-server.service
index ac17d5286d3b..8793856aa707 100644
--- a/systemd/nfs-server.service
+++ b/systemd/nfs-server.service
@@ -23,8 +23,8 @@ After=rpc-gssd.service gssproxy.service rpc-svcgssd.service
 Type=oneshot
 RemainAfterExit=yes
 ExecStartPre=-/usr/sbin/exportfs -r
-ExecStart=/usr/sbin/rpc.nfsd
-ExecStop=/usr/sbin/rpc.nfsd 0
+ExecStart=/bin/sh -c '/usr/sbin/nfsdctl autostart || /usr/sbin/rpc.nfsd'
+ExecStop=/bin/sh -c '/usr/sbin/nfsdctl threads 0 || /usr/sbin/rpc.nfsd 0'
 ExecStopPost=/usr/sbin/exportfs -au
 ExecStopPost=/usr/sbin/exportfs -f
 

-- 
2.45.2


