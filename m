Return-Path: <linux-nfs+bounces-22014-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCDeGtMIF2pA2AcAu9opvQ
	(envelope-from <linux-nfs+bounces-22014-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:08:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD05E6959
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B33301D6BE
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA25A39903B;
	Wed, 27 May 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gys1Cc4F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD0426EDE;
	Wed, 27 May 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894025; cv=none; b=EVBBU1Q4ilC29EQZxPv4xytXXNBZD/Fmb2UXM0SJnTHFQjBZUGjjGCHKVRwicE2FUkgZtVTp6/Mghjpjk+D6xHWFeezS9QGiFQ7p2KjuwRQjp2l9MEzcIrieRskqNpmxtDYqH7pnwfm0mbMztEOFDfPFHxxEJ1vYqe/C5uzxYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894025; c=relaxed/simple;
	bh=9AMzy1ugmVX8Wn4pRJbatkEC8cj+BjI9aHrzu0hGgSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8DU+nzcu8UX15iGJYEfGIPYOIqbkRrPmH0kWZl/iW2V+T92mXQoT0Zrxq6hlkalR18mDXpkt9PfSBSXXHVPiSKXjtiFlwNErkfsFW0lUZugcnADFj98xaoAv8+pHdzeGNKCR7DDAk9v7+rQHiPUHbAfseopVHg+TW30QIn1BoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gys1Cc4F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1741F000E9;
	Wed, 27 May 2026 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894024;
	bh=7a8NXcKnTmrF+j9AYeQ1R0JfaCCeR4c9wWdPK/pcVqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Gys1Cc4Fhjx7QitXfs7eatkRs7k/SZQXjVhthZ6CKV24niZY0y4EcKbpkzrVkEAnh
	 /MGIaWanQ37PkAFtZYRADvrnExpH/h3eywdkaV9R9cY8wci1CHI/Fx4l8Hr8VZUmdp
	 9pbGh91O9H2GFPz/eAWT0iO+J516XxxeMT4ZQkvaZU0OFAPfmw0IajruALdwi18Fgn
	 wZGwXG/GsiYDfyYW7/7rdeNFd4xQ+6njoxgkoRXvBpVCyRjDXs9ztmH71vZhkFQI6M
	 3HhB1xBnKwZHXeqvUFw/6wE/GWBnzTPrSUMU5b1YZSIyG+hfsUxMi3KJ7NvLqCK1/l
	 NRl6zkjQKLuTg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:13 -0400
Subject: [PATCH 3/5] svcrdma: Use svc_xprt_put to free listener on create
 failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-rdma-follow-on-v1-3-1b09bd87b6cd@oracle.com>
References: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
In-Reply-To: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=BKGu4QmSfRQNurHDFhc7+7MVnClmGf+i9axgiun39XM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFwcEbqKi7bEFfGSSSyOTFdey40On9VE/QVAQg
 ggQiwzdUJiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahcHBAAKCRAzarMzb2Z/
 lzVsD/0f7VIWx7s66q0MbJSAKfDCOeZz3+OXiGY2MFicKHn8nzlBKDpfFHYc4fDcc/kJIdYntq4
 uwjjUjkpL3lH4YS+Lk5j+K0UDRXsEiS9tEDtCRG9it6FX552l4Vd70Vw5L6i6UqTDs0gLoKCF7A
 3U+2dChUMqmXDkjp9P/0vrTOVpib9TfxsJYvHfGJWpJDyEuj/b9lWGnTEaz+SBQlwMMzpFY4hmM
 LshlS/wJSJQs16UEcX+LzfKUX1czJD3RqWF+aRyo3mOIP13L1yg2MAd9oJ+BqAlEzmmrp7SfRR+
 fuloTbhqEKcbZn6cOQI8QO6eGNSbgN2BV8DW0yzTmQvcPVX7nVoGlK+i6tEZWoqAbHJ734gzLsJ
 8V4mkgCBo/RnH+bE86BCK3MXFROfPeoQLYg20VFVAK+HyRG88I83fHvweF9Aag8ZK4/upnvQFCF
 X0avq40PLschVXGb1IfvgZCuGZFeOEtMzGPVaJFyCVYULI+q0PkqPCcM2qPVZMYyeQSBskcu86Z
 k6L8RPfHJgZTZuAvar3gRdZETTYWfKsJcorj/RD7QQVBH8Gg9tPTOXcuTQzSGJR2XBU+QoXIQly
 U/BUQeu+MdaMt5KXQ1Sm/aB1dcWL0F2YMvL67XVxFNc83PKmaLmvOOySGKoacsHkvKBXxTu0Uik
 08QCMlgEn9MI8OQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22014-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: D0BD05E6959
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_create() calls kfree(cma_xprt) when
svc_rdma_create_listen_id() fails. svc_xprt_init() has already
acquired a net namespace reference via get_net_track(); kfree
bypasses svc_xprt_free() which releases it.

Replace the kfree() with svc_xprt_put() so the kref_init birth
reference drops to zero and svc_xprt_free() dispatches
svc_rdma_free() to clean up properly. sc_cm_id is still NULL
at that point; the preceding patch added the necessary NULL
guard in svc_rdma_free().

svc_xprt_free() also drops the module reference via
module_put(), but the caller _svc_xprt_create() does the same
on xpo_create failure, double-putting the single
try_module_get() it acquired. Take a compensating
__module_get() before the svc_xprt_put() to keep the count
balanced, matching the convention in svc_rdma_accept()'s error
path.

Fixes: 4fb8518bdac8 ("sunrpc: Tag svc_xprt with net")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 55e2ca036584..63dbf16dbe7f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -388,7 +388,13 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 
 	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
-		kfree(cma_xprt);
+		/* _svc_xprt_create() acquired one module reference and
+		 * puts it on xpo_create failure.  svc_xprt_free() puts
+		 * a second one when the kref drops to zero.  Take a
+		 * compensating reference so both puts are balanced.
+		 */
+		__module_get(cma_xprt->sc_xprt.xpt_class->xcl_owner);
+		svc_xprt_put(&cma_xprt->sc_xprt);
 		return ERR_CAST(listen_id);
 	}
 	cma_xprt->sc_cm_id = listen_id;

-- 
2.54.0


