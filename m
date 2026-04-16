Return-Path: <linux-nfs+bounces-20904-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NCMLMIn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20904-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9CB413A72
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF36630CFBB7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5805331230;
	Thu, 16 Apr 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8m1QLjm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDB330B0B
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363301; cv=none; b=R1B7YbrcBwjs20Aejc87xF1ea31N5NIvLawOxOmfuGD0nCF5x2BSqDLVFtY9sPmEsmxD47VpsBG9gJzqlEamhNegy3EvODcwxSzB92/Y03HJyKiUbHgmTUF+ZxlC6dKmOUY7AaBcqJZpYhQzRqvkPpwPgHd8nBlbfU7rL1DhnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363301; c=relaxed/simple;
	bh=Ql3wcT6tk4MsOPkVBZSBJuePbHmFTHW/i0Yh5J5jM9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSCB+rZg6vZKBhOLe+5fKKqoOx5206q/9U5QgfvSp9Mcjd4/3A5zODXvbFfIeIY7OQdYkFW8gITyoTX/vO8oSQQ1KE4wMav3W2/RmsKlU7zpl9Ae+ir82RPOHILkbvJ1fzS4bH/7nFr7+R1zR/+c8djn9QFCt/GDnU5EamBEgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8m1QLjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303F6C2BCB0;
	Thu, 16 Apr 2026 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363301;
	bh=Ql3wcT6tk4MsOPkVBZSBJuePbHmFTHW/i0Yh5J5jM9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P8m1QLjmLtMEnEvtRwLylxnFqVGds1d4Qkg7Za1CZUXnoh1naFoD97ISsvoo4Z6UL
	 pW4rPrFttQnlaN/rwGw+oIqbClAmz96otAquMkTRs5IdoVXhXz5Mg21vRIUsaD7Ys7
	 PReG6WlW0EAPKF9wFx7sdPSVVwvp1VpcRXH3dfSQsdDw7ZXZSqN43zxklTPLgARV+h
	 xg/GQsun5ZKWx48O7CCwMQi4Z59HhOPP98rF/9gIjZxdktJneC8ERBdTkmvsb4/JFM
	 vN1n+K7hBqzPIeX6/UNiCGF+eIK635SYChIP6W6O7fqtTiCmEYB5MocRbijDP05QP4
	 n5h44XS/pOBqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:34 -0700
Subject: [PATCH pynfs v2 02/25] nfs4.1: add a getfh() to the end of
 create_obj() compound
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-2-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ql3wcT6tk4MsOPkVBZSBJuePbHmFTHW/i0Yh5J5jM9w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4SceAJO9+DDEuWfhsAbCjWAf7kLwM5aZblVCC
 puJBi++9LOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnHgAKCRAADmhBGVaC
 FSTIEAC4gLggwfF7Az2Tg/W9TRU5VHj3pZXjd11v5wo/MJNljdi0jg7sjE9N4lNs18oXT5UgRzJ
 kJF2089gvg1FcaQxAkvIm0Rcner8iHJ27+1NumdWH42Q7GixGinwqdt5iiSYuT20Inn9RnWb4Te
 ohfri4CHSelTe+VEbOjFX5sfGt1t/LWQJVIhE+XEgwgU1qqO5KXlj/Cy0Ff+SuZICet6iqTlVGN
 VfLitwv2kHP6I98jvQDwNgIWPbCfPo45gRZhz8hHfFnB0G5FlXfpKeIuR718fZLUkLMmaZH3Hoz
 VF4F2WCxpINYOQageyxwiayHeVjoQ/qAsHUXaAkMGDXsY4wST4pwraZ6g/Dnkz9LDvt1d4Kcp9f
 gklBd3ySdqTqB11sJXJpUg4/U6gnCJobKErbJdrkJcQnYHx9a0FLT6bXNypNcPmZxhmR76JUu4F
 U+8m46ockJZ2HEuefbFl5WXHf8FqHoTN74COegTxCSllFGDsQXnOoIvX0Bjm0PgGTeewgkoFaRH
 EW3q3J2JAAEaRMmJZr6rxc6QtCkD6aFQ5t1j6tQ5KZ7iuG1DCkX9xwNy6cKGPPOm5M5WLaZ98vn
 okHWLojbJjVldUh5mh7AAIGeoS+pAsPfxBmh8XBDER1Mk1Xf4lXuv5SEATmLyaEOiXdBa4rBA9G
 bj9fNpwAtyM20CQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20904-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E9CB413A72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A later patch will use the create_obj() function to create files, but
some of the tests require us to know the filehandle of the created
object. Add a GETFH operation to the end of the create_obj() compound.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/environment.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
index 3c77153631ae..f5b1fea4a64c 100644
--- a/nfs4.1/server41tests/environment.py
+++ b/nfs4.1/server41tests/environment.py
@@ -474,7 +474,7 @@ def create_obj(sess, path, kind=NF4DIR, attrs={FATTR4_MODE:0o755}):
     # Ensure using createtype4
     if not hasattr(kind, "type"):
         kind = createtype4(kind)
-    ops = use_obj(path[:-1]) + [op.create(kind, path[-1], attrs)]
+    ops = use_obj(path[:-1]) + [op.create(kind, path[-1], attrs), op.getfh()]
     return sess.compound(ops)
 
 def open_create_file(sess, owner, path=None, attrs={FATTR4_MODE: 0o644},

-- 
2.53.0


