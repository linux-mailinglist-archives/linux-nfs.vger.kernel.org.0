Return-Path: <linux-nfs+bounces-4995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C7937CC7
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF6E281450
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 18:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143F1474CE;
	Fri, 19 Jul 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbDrs4mK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292541474BF;
	Fri, 19 Jul 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415371; cv=none; b=SvFTeyturrpc2Y+hamehSkuG3X1ucgvOjniQt/DwHyFdZIbbdG0NDRnEZK0qhPcQ1fRSGmk99auqE3FSuiRi1bQNB6DYLk6qYwD0Dl8fuI5TiW/WGatSdJjdEbYM6E8Qj8YXXAHVfvh4Dr3V1f7Ol8m6efAINu2OCzJ7U2hDh/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415371; c=relaxed/simple;
	bh=oZeASFZJtm0saJ5Rkfo1e5GWLBas2u1wYzcmZHteJSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b2gDYUZmhsc7wW4zZebG7GJ0CYSSb8uEXKhT0JL0CtKRWPp+mV/qmaVfqH4Gl4wCZOt3/WReIPU1wf/Cxdi6+d2VUtJ76iQha3Zme8/XTSE5hwupSlKEHjT1yKM7mFkcwGR8UsBuqLqhyEcLu8Tv42YBZBArYolPBEPSQVnnH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbDrs4mK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED70C32782;
	Fri, 19 Jul 2024 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721415370;
	bh=oZeASFZJtm0saJ5Rkfo1e5GWLBas2u1wYzcmZHteJSQ=;
	h=From:Date:Subject:To:Cc:From;
	b=EbDrs4mKOzktgpRes6xa8wzhFhqygl2yXUwt7Wpob5Nf9a3KWkLYua5JD4fNybIF4
	 Dps4vUsiEM1JPLXO3WrFA6sFMKig/WwupkfhgxeNrLcb9OSQmLo4UXhdWx9gFvtv9s
	 co4dUProO0TuTiD9E0r9LYT0lHwoVGvWR9SX+Yh/m2V7E8nH5lLOEL5ZSB9EdMfzUn
	 FPRBLjbUcOtXRoQiZIUo4U2iRlk+KhcuUe+aMswbD4kpzAo3+clH53FVqgQJXmBlBS
	 djGfqBijCkWvKgR5zOAxU9olr7liKDpCzwNwkofOXARoaj7D+SOvZg8kDVeTlE5leL
	 QY8RdaqKTh1TQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jul 2024 14:55:53 -0400
Subject: [PATCH] nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd
 sockets
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-nfsd-next-v1-1-b6a9a899a908@kernel.org>
X-B4-Tracking: v=1; b=H4sIALi2mmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NL3by04hTdvNSKEt0US1MLo0SjZFODZCMloPqCotS0zAqwWdGxtbU
 A4musjlsAAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steve Dickson <steved@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oZeASFZJtm0saJ5Rkfo1e5GWLBas2u1wYzcmZHteJSQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmmrbEmokRUHihWQMfxT4oYNDsIWoD/ozRDHcoY
 U0MYUs0KB+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpq2xAAKCRAADmhBGVaC
 FaZYD/4lrzX/VvNY+nkN+LFIklNottA2lOoAfeMop7XYtM93dtmdIROUXN7QQB2qVP3D7IaJKIT
 TOhNorC5iIEO0+5VrhxIS6zE74rNqu7UvPLUghfYW89Si7aRnB0z6+KZaRsdagQo+Lz0wbM5Dpe
 8l9Q4AatI9KzZK2aZKlNXr08vI7xAEcsSAi7f1YlGh7gVo0QNdhZ7pVO1CPy7aNyaT54kBX51uW
 SsdssVYYyf1eXq7ZVoaJUatkiEQ/XR+OFKIMk6HXXa5IaoUDUtCMESz7ZUfejiuegu2MCZYbR+S
 kBCWHtG2pEOm+JC2ZDUV/euTrSw+1bnV1GFZ14igm8Uzh8Frr5E9IkRr6maevK9V1sslTWbQE7d
 0BYaUlxc4CahhqEvs+DEVUlhJKZNyGtUzaiKvDwRHuacbzTzCk7WZTaqgXmU7PCd3mz10IjCeiG
 6m+By+5yisF5ssnwRs7l6cS8apeV7pAPjZ/oQ71qYRpxYescI+z4nY8cLkSwAmEBSKw0iY/vyK3
 VylyFcae1LPoUMWbSDaPRFRMXpTqVKG7hg0hu1pDQLbkZd7ZqirmK9KBH9QPAZ6uBw0IsuXj4+Q
 JImhVmqXI9kjaC012ga/QfAwpaXKe5qI7CykE8PbmiQG3Yp5rP0+SNSXFfSn/5r0yY8IJsaly+w
 ldeRFSPvHvD1/cg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When creating nfsd sockets via the netlink interface, we do want to
register with the portmapper. Don't set SVC_SOCK_ANONYMOUS.

Fixes: 16a471177496 NFSD: add listener-{set,get} netlink command
Reported-by: Steve Dickson <steved@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 9e0ea6fc2aa3..34eb2c2cbcde 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2069,8 +2069,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 			continue;
 		}
 
-		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa,
-					      SVC_SOCK_ANONYMOUS,
+		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
 					      get_current_cred());
 		/* always save the latest error */
 		if (ret < 0)

---
base-commit: 769d20028f45a4f442cfe558a32faba357a7f5e2
change-id: 20240719-nfsd-next-d9582a2c50c2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


