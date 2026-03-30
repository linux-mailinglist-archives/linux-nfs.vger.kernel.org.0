Return-Path: <linux-nfs+bounces-20521-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FKuFR59ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20521-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDB35C230
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0B9E3019C8D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CF3D5253;
	Mon, 30 Mar 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVUbyAQP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267C3D522F
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877929; cv=none; b=VWEXNVU+12HKTEJH1rteSufiZvHmxMulggaqADUYzxkMZDjg/DqnzuNm46nBnGhxsYRMikCOeHvzzGfBr9UQMb89QJOKIzPydbtS3Xh21RrgL1xdQY9d/fwds0re7EP9CtKbx+cU3RufKQXGUn4SjwFQjzBU6JTkBnBOPDs4mMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877929; c=relaxed/simple;
	bh=gPKPvQuSEi2Rhu6IBIYF+sfDVmSgFIgQSGf8j1v3HLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y64/PszDJeNDLugFqbKV8p0vvVYFFSXlXQgjwBTNXX9qoMJrNvq1hKm2sVSQDXDk0Qb8dQoA2Thv35uCTpjmxOp9X0rgCfj7xpNmpAXN8ukiPQtxDYXCTpccU/9iGVF6oukbN6p++K+JY/lTcF4DV6lyL0KEF8edXVFjHZ8NKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVUbyAQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34D6C4CEF7;
	Mon, 30 Mar 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877929;
	bh=gPKPvQuSEi2Rhu6IBIYF+sfDVmSgFIgQSGf8j1v3HLY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BVUbyAQP8n4M2R3lZ1hOBOrPhQClogi9ssD82McUky0jmHo3On7up/rWtyd6TskH6
	 pDe0nGdmYXs+CSBTIZSf8BSpS3VZIJmor97eO2oQd3iqsYesM+MJvNw/rOfo/eXjI7
	 4N5r/+bokjU0ayayjevaNMW3DM3qZ/cNcKTeyABylU7JWWVvdVvW0f8fC7TLoriSVV
	 7hQFrjWY7KhvQNGBvWAHqsx7NWjg+1R7yXWDbG+LbIMKCaX8+BEvMnJ1YBSHXXyWU+
	 Mu1Xx2Zpq8bxp6mK5z3VMnaxj83XbI09xeveRKUrjsHbmfwvhfpAgfEqacWzu8BnCs
	 HGCStQ8nwRlIQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:26 -0400
Subject: [PATCH nfs-utils v2 06/16] xlog: claim D_FAC3 as D_NETLINK
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-6-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gPKPvQuSEi2Rhu6IBIYF+sfDVmSgFIgQSGf8j1v3HLY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzfAqfSCplnOexwIj2Vm/OzO/SjVSkO3EvwI
 tw9bBc1dwiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83wAKCRAADmhBGVaC
 FWoUD/4tcx9QFEZSDs+W1CN/EvqaBc6ChWbdefOH/4x03GN0oJPlq7AF3Ckchh5i9WbXe5K8QRD
 ad+ztPukKSg3caXRssSC2bIZMO0xoyLavxRtcdFBMC6KOIS3i2KLmtKXbdsaKVSbMPYVWzNVSu7
 0FrZqNHkQ5IDbWKaTHihz/YsA0ScZM1dhm9O6UiP8IAjZ/r7YqtpRvR+tuuf+qT7L0SEL4NZQLL
 dGzz6T4Sp7FbARKFpHoWk6Br+W2AcroH2HaRzNCioERJfbcfycGrfHfzRu9sNxcSJZ7bxhNyPWt
 a6GfpYDFd6roPGKaOM0Krgc1p/J5fOiWIHu+qdywJKZZmyaCLHRZTE4xXW7zwOaGVFOqmcmLFJE
 HyilNHguhlV5bh7pM8ooex+1/lMIrGs3cQtAWzjhi/8NE2MNHSzqmqDjux5kpN6u/NBYxx+AqyV
 ozonpLVuKs38Rn6RhnVs+TrzyI09pkHyz5R2VPAYv4F1ernSYEdLN0hR3F8gLI1Fsp1+TO2aLta
 rObu37CyJXf/c5NmAICJh16HpKy4CTLG2glUYXPMxawIt8q8aN+yo23+hBj4TAkbkH+el2KuYz5
 60nWxTgxpP0Emai7VSCfWBE3UTsaxqhbEzSJ78nRGADaFxLov/0Q+kJyNkPU7sprV5f70qq1e4d
 nIOjJhjfZmFjN1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20521-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2ACDB35C230
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


