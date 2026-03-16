Return-Path: <linux-nfs+bounces-20205-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wImBDBwhuGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20205-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D085129C49E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069853054CAC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3FB3A2540;
	Mon, 16 Mar 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOCqirdb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5213A1A5B
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674219; cv=none; b=a2TsklaagfBPfrIvGfYw+G/CyDIWfAZUzjDfG3gfXL8UpGgQlODlsObGt+QvrS2vzpE8q5V+99QukXrVMiEKpnQ0UyP3SYBcL0d9Zk7kIqwJrZt1VJprXQBOU1JQic3MoKUOCnzXShUJ2brrBcYIxYi9W1+tSGCTGu2HJFacYlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674219; c=relaxed/simple;
	bh=gPKPvQuSEi2Rhu6IBIYF+sfDVmSgFIgQSGf8j1v3HLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXwCbzFEJjB/DNMLKEECY42pd4DJXc4zML0WIwKmkvA6W5kYmWbahDkvpVN7j1GMWTMNYmRWusBq9mtZe4ZtDbR2QgvnheyodJktmteG9V9IQ4W1HuF1woRapjaG6FcB9+myOUKQB7qYB7HGyd7TL4Mbw0Gzd7wJzC0zDd4IuCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOCqirdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C996FC2BC9E;
	Mon, 16 Mar 2026 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674219;
	bh=gPKPvQuSEi2Rhu6IBIYF+sfDVmSgFIgQSGf8j1v3HLY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EOCqirdbpmGWhCoGM+BYC08p4xIO5ETe0t7HjoO86K8qO/POgG994X8fc3AP0qSAI
	 C3r4bmHTqfiWTocDApZ3J/5G4HZtojmSpX6dFoOa8VVYF871dG+1J6vKa5CuVo/3Of
	 kXcDXlneYR++6EsuwSoVOpDYIAW2UVkD0FZELjgHX54KAVfj964r6iWRVgAB1rTE9/
	 mYHa8JK9lM8pBNwnAGN9Qqz81Z7no34K6wKFHLWGPO2/JiY8ep0uzrjPzAaXWuuUfA
	 qVDFVGKDgtwDwLmMuCPXtdu4PNW8IkURxdyS76b3jgdtDfV8LON6Vqvg/xIdCzziD1
	 89XIjxkwkhfpg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:44 -0400
Subject: [PATCH nfs-utils 06/17] xlog: claim D_FAC3 as D_NETLINK
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-6-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gPKPvQuSEi2Rhu6IBIYF+sfDVmSgFIgQSGf8j1v3HLY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7hqsI+RJbEkNXxFnTiONWrRa0jejbX8IcD2
 KxevtX+J9mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4QAKCRAADmhBGVaC
 FRrTEACpSUtpgGJ8lG2zYaad97T0KcwXbs93ouFeQR6mC0/cRyA3sHyNq0eQ5jqa9Wy27hZ68sW
 BW5gL5oqisIseohqC/1MkrxI6dKsSX788TrKrh/Dhzf9qgO8uYqISvkZGCOJODXn52TtXmO4Dt8
 FnG6fqquvXBVhIfdnJDIwv1w4vN2pgYov6uLe5a/cwBdXZwEaE9eRP2Ly77bLvp2y3fmKDqUcyi
 E7YBcFhXFDmxbL0ZT+pBGDcAdmfyPbvyK5yFzVqh+OXgzNipgc8lxe176hQJivEgZIxi3HzndQq
 mz9QXNx69xso2pE5E7tYlEn4GuzM+M8GwLkyKys+BO+DfneInIoLz4C8g+JVkdT7Xjbec91z+KH
 fl2ELlQ3rebQ+6T/bAvWEfJrgbHXoJlTA3/XG3toVtQILyBIlnKvtInc8UWAQ6YOQMgvI6sunzL
 NmbeKOA0KFye1JlPC+fu15/LrTXx0TZZf8TGTvnC7W5Yru0PBXRKLaomFuK0MsTCR2nOeEibCtb
 tX0lyidttyPdFdpf2MsCQBvVPfXihzn/V1lt11L7aWraUOLYb911tQseRhqPrccyEJl+JeCKqni
 yAKWsIjZRy/87uktwiqwdp0OEFzJlOUBDBWRHJlY2B6ZOpLbjtYjK1bA3hTqbqL98g2L3Mn8DzB
 C6i2lOWrANO4ALg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20205-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D085129C49E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nothing uses the D_FAC* debugging bits, so claim D_FAC3 as D_NETLINK
for logging about netlink activity.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/include/xlog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/support/include/xlog.h b/support/include/xlog.h
index 69cdf61eaf370bf70a0da57c422f65f2f49ee06b..755105e0dc9a0298a17be6a3f63f0b471c53f8a4 100644
--- a/support/include/xlog.h
+++ b/support/include/xlog.h
@@ -25,7 +25,7 @@
 #define D_GENERAL	0x0001		/* general debug info */
 #define D_CALL		0x0002
 #define D_AUTH		0x0004
-#define D_FAC3		0x0008
+#define D_NETLINK	0x0008
 #define D_FAC4		0x0010
 #define D_FAC5		0x0020
 #define D_PARSE		0x0040

-- 
2.53.0


