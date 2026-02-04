Return-Path: <linux-nfs+bounces-18717-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIiIIfh4g2nyngMAu9opvQ
	(envelope-from <linux-nfs+bounces-18717-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:51:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DAEA8F5
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7F88301493F
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493233C1A5;
	Wed,  4 Feb 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMstBoQw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FB27B327
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223730; cv=none; b=JgVqYNvCUJ789rGUn8bRJy+0WmZzABo1IQX83t+BKkjxVhU5/Fdgz8ebs+XtwOdvQkkPcUbggxsWm4ShR9JXB28hijkpyqFdqXgbvYl0JDmaJVgLnWjY0PDB+gq45HBYGKgzywk1aAq161N1jdaG+zn6CnfeyD2ImCDfW63VvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223730; c=relaxed/simple;
	bh=AlvKAXEx3vzyEsO3AxSAuqpcAHBHwm+4jfisbIYt++k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgHElQaWABUDh+YqFfYIWmu4+g57btFf9akd/2UHWSAqJxkmGSwtqJ6m6RXNdTV6/5JxOymc/fgrhjCqM4xzlwThcCzDLnJDh9T0kla1yjxBnBt39jn8VcmDf07gReo+tqRYj86//y+O/DMNOXMhWs6wPPiNQ4ymGeDj8Fw3S+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMstBoQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F45C19424;
	Wed,  4 Feb 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223730;
	bh=AlvKAXEx3vzyEsO3AxSAuqpcAHBHwm+4jfisbIYt++k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMstBoQwNf5J5MEdG7sJXCyqkIzPkhgYG6Z6FG93Pxm02RUuVQfXzayy5yeqTFUMv
	 CLcOG1yNkGKx9pk32bET4Yb1zFY4337/FMFSO5lY0WUw7gFeIG9d948L0D8+A022pm
	 EI2hPUSQ+QTvyW/rL96a1AviUV9PHb/+AQs18jCnIQAty8R50t5N/ewi3ZXVGXiOF8
	 BAhl28pK/bLsuP/LMSNpY3xpqV5Oj6hJ7ciWs1wB+VkWuzZ58DjKCjBCa5uxFBVtdH
	 NPTTGKPUXsAjvyXaVxdgH878xiGb/5WbEQM6zUm2Vov6BJskc567UOQKlYqreHC01n
	 THdeqdKBdOimw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 11:48:25 -0500
Subject: [PATCH nfs-utils v2 4/4] nfsdctl: remove unneeded newlines from
 xlog() format strings
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v2-4-a7eba34201e9@kernel.org>
References: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
In-Reply-To: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AlvKAXEx3vzyEsO3AxSAuqpcAHBHwm+4jfisbIYt++k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpg3huTVEDwzJ7liuwcYVi+ixdkJl0v6nzvcTae
 lD2fiABhGOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYN4bgAKCRAADmhBGVaC
 FTLLEACaYtbCKA9CaXfGoVCZVYwGIO3mHJTMH3+LtCJyAX8NL9PTQB5LSCYB3lbbb+TuFYtp47I
 pokvKrdDVpH2kCU2Kz/rswqKPPNO5a84SZAiSiBCAbXMGv9LctGGv800pLvuidxK0exhF2Giorn
 3zBeXbP0hW12HIRSyCu9uf2opP23aVisg2f9ZkduK3njO7KePRLLhM+wpqLfjJlcsieryU6YI91
 dTozvROPejnjoWceeT/WA5qk7flCjanc2HqGPd4wJii9kdcWDHCJK2HsdBVZ4e+//ngqhQvW2WH
 v5cWnULZLbNIM3XSg31uH2AB9Ng7sETxSFuRJRQQ3ACu2yKw0+38QDOWEmzP0/xsvW8n5ZSmHDj
 8V4lhNHVv7LPmdp69lG7Iz8xqdcYs2za1ypkP64K9KlmFpIx6r2ScwKOQv9pPmpFPJtOhPTQ11z
 LqNKuUUIeah66fOV+ChPmOv9vPphthx/7LWGdHYPsXWRJJGZ/tBkBBDzWuS0dmswXf1E47R9hqx
 nyHgzY6zj/KuV9ksqMgef+lLMxvl5R+lT57+3Kgdbej9o0J7wz1CRIw7Y9hpVC6NBgkdHzubxvj
 IVmWALeArK190tFQL+uOvGo0K6frKUKKSQS9oWcK4qUTqS3RzfnaV3V/ft/dgSnr9RZKB72aL48
 Tdh01me9P8J+mLA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18717-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A58DAEA8F5
X-Rspamd-Action: no action

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 4a3744a1c22e6beac7c039bded05fc087a121200..2b01f705874a4a3cad04042f6dfad22a66a7536f 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1514,14 +1514,14 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		xlog(L_ERROR, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "send failed (%d)!\n", ret);
+		xlog(L_ERROR, "send failed (%d)!", ret);
 		goto out_cb;
 	}
 
@@ -1534,7 +1534,7 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1554,7 +1554,7 @@ static int get_service(const char *svc)
 
 	ret = getaddrinfo(NULL, svc, &hints, &res);
 	if (ret) {
-		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s\n",
+		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s",
 			svc, gai_strerror(ret));
 		return -1;
 	}
@@ -1575,7 +1575,7 @@ static int get_service(const char *svc)
 		}
 		break;
 	default:
-		xlog(L_ERROR, "Bad address family: %d\n", res->ai_family);
+		xlog(L_ERROR, "Bad address family: %d", res->ai_family);
 		port = -1;
 	}
 	freeaddrinfo(res);

-- 
2.52.0


