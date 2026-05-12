Return-Path: <linux-nfs+bounces-21568-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGg6ITFuA2rF5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21568-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26493527218
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2682E3066AEB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB51374187;
	Tue, 12 May 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Uf62Es"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B2366831
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609665; cv=none; b=oGVBD9n0bc9yRwnhpO+M4gzWabwON/Ev2hzdRG4QUMkSZWZ8Xy2WUMQ+p3IGNFmvnctzZBF25WKfRg/iF0nW3eat2MIzeQUxHJ1SwO4NpdGaSk+QMe6Wl8UBfKEixkHuDRZQgCU0pzvV9YbDjFAwwByRq85WcUC4W/3Ahalystc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609665; c=relaxed/simple;
	bh=4bvjNwVaSedjAYJU9deSBTasq+F33cL/J+2EnVRqxSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxopYSdyWnf2x0/yEuQfYUUf3KZX7AM3mmvjopCh/AzcXJ1HSXUyvMxAQ57aPGGIGEqVvy0qXql8oSL3Q3HRzQeBXnRblNkqtpMxO1gAVH//RdG6N83Xj6jpIOIda7+WCMklRjUFEyQK94gRzbSnubEJ6NNckYC4ZI2zA+gdRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Uf62Es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E044C2BCB0;
	Tue, 12 May 2026 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609664;
	bh=4bvjNwVaSedjAYJU9deSBTasq+F33cL/J+2EnVRqxSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M7Uf62EsQJlg/L+quWSs3TnsT7NgddxWD2CHQlFTifviIKN8AD9G1SPAMA4mZY+Z1
	 KVCAmjhZabBY9dav3PElkVGKaim6U3hAD4Ic4P0iypkZ5HMOSj+K50vU+8ue6MhJwb
	 aGs/ifGqb2lgA7vJI7QfsoKjogogDjtwkXtnoMsWy8agGmtoocDT3WGe/L4u6cwXJg
	 X3C6M0p5R0WdpE6piS75/a8Zhi3KOaAFfPXdo/GqNzGlMOD6M9GkfJltrFZyMt+YIj
	 /apVmj/OSbWyhnEHFoqHTFjE3MiK9mnl7IGynLNcbaJJNZqHnYWt4MkWLgUR/VFyRv
	 7bizeinRN7i0A==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:03 -0400
Subject: [PATCH 28/38] lockd: Use xdrgen XDR functions for the NLMv3
 UNLOCK_RES procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-28-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+3EJXCnnJ8mKlDQcqvoxfqjeS9Xz/zTAaTuL6lIPNXw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mO6bT61JOUEDOx5Ersnebt3dbYqJeKc1BR
 jlzyUsU2ASJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 lyByD/sGpDSM80XlbrNEHX7XSy/IWB/b+j7sBJoUYrltOiNrp+F+12Ve01Opf0zswBTAgBvxQWN
 9kWSrB3sDYHQBZ5BVldhGssbKRZoSBRiaaKnV6kAboKd83Q89VKSbo2FTnISUaBAqOCz9bGm09r
 WKmqZsjcyB6quu3oCDvv4W82of4PXiG5+5HI2POSlMWAsOsgo2icswNQhgcYcwPz2AUB0iGWH0V
 UoJO1cjouqg1Umc0C9iP3LDGkWgMDZKx8EMIIbC7Ir/c+coiOh/1avSVAjxCbn0Ip9k7xzjazoB
 HFW2Jpax5VwuV0BMFtSUmNdM+qteiiHxcATCZWJ9UYT1CUyz6czbnori1sESb+SFfvzdrc8dAtE
 ZdvjHRNQpsGJPujM8vRsvFXqIeZklEMQXRE4gJGsWmolTHyo6EZplNNOKejp2lHufttZ3ScQdDv
 EpLFgK7UGu912/YzD4y8TIchzXOPFuDq5DJ/HsZRB+0ozhc5f/NqoG0RxU/bijO+hR21SVmV5CO
 zy72+bxQs6AZRZfPG/QV4s9FdHDI/ZOdbw2f4AkHrKTu37HZHAnGpcf9qmfPCO1uVX+GP0nJbjr
 GANEhd70X1FM+lyNJXComjpOqM+TgfFcWRvn5ChgQ9oIw5FmVSNAfY/gbmyZ14fhOR4N15uMO9U
 VgtugnIw61cRFjw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 26493527218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21568-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 UNLOCK_RES,
the callback that a remote NLM uses to return async UNLOCK
results to this lockd.  The procedure now uses
nlm_svc_decode_nlm_res and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification.

Setting pc_argzero to zero is safe because the generated
decoder fills the argp->xdrgen subfields before the procedure
runs, so the zeroing memset performed by the dispatch layer
is no longer needed.

Setting pc_xdrressize to XDR_void reflects that UNLOCK_RES, as
a callback, returns no data; the previous value of St
over-reserved a status word in the reply buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index e7d399afbe83..f17d3f8d85ec 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1300,15 +1300,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "CANCEL_RES",
 	},
-	[NLMPROC_UNLOCK_RES] = {
-		.pc_func = nlmsvc_proc_null,
-		.pc_decode = nlmsvc_decode_void,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_res),
-		.pc_argzero = sizeof(struct lockd_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "UNLOCK_RES",
+	[NLM_UNLOCK_RES] = {
+		.pc_func	= nlmsvc_proc_null,
+		.pc_decode	= nlm_svc_decode_nlm_res,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNLOCK_RES",
 	},
 	[NLMPROC_GRANTED_RES] = {
 		.pc_func = nlmsvc_proc_granted_res,

-- 
2.54.0


