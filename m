Return-Path: <linux-nfs+bounces-22697-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lEl5LgiXNWqe0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22697-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F46A77AD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LkAKphp6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22697-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22697-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3852D30088AE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062B343D7B;
	Fri, 19 Jun 2026 19:22:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7B34574B
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896965; cv=none; b=SMCoX79tweEzHaZb6/6ewVpXvVgej4kizIuh9WwNK2bkod44G5OisnpdDQbpMgfynEbAxmk9zBCImzn/NcH7NJKk9Y+Y8r5hr2Iepj+sHvFGvanZi2vh68N2UAccq25Jvlc5eezvL06mMBrNiwrgqrT39W99JGhcZH+GjJpKcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896965; c=relaxed/simple;
	bh=uSbjfrEz1VatDWoPMEOqkp9vlVfRhcVmJAloye57tf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gn4TUTrgUBlnHiqAEpMCEfpMGIaJWnVlFP50sWiLpzXz5d3Cq21U+Rs9gcyfeEB5zGwoj5h4WNr/punfyQN9pvRUp7hGJ7+16WiN7JeACHTSLiW/Q8DO0UsRYkl6Wf37AdPKCY28ErPPg7oXpfBu8t3kl/ARTd3/FP2LoVmejJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkAKphp6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6281F00A3F;
	Fri, 19 Jun 2026 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896962;
	bh=Bs62h+QzpUXT9jYLxRIaE+wx/kTKk+XabO2qHHihxi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LkAKphp6tkzLABhFbVF4Id47r9VxW1ZhmrLlkosXfr1qiGiLix4OdUCJOEhlLp/yP
	 283jwNxVAoLkU4QWus7oPrsDXISdk5Q8lFOsWz4tDOKBnGfv+Ax52DKpVt9vye37Jc
	 EUfsWd+VNMUtuvQkecb9lhLPw5tPVPrUPfsIfq2MLt348P/TdVfrMJNc3Ytjo7AW6R
	 Xfo/n+c0bj1TyC+mJOIV6KmGXJal9lqkZDdvgJvUq3/qCCS42a+iBm0LjVfT62PqLm
	 C3B1H4Vde4mY74NCS48GUXyIZ/UdWMl1Z0oHz4tPG69grmZSIQvKQeglcaDKblH5W5
	 kbW/bnbwJBZGg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:21 -0400
Subject: [PATCH pynfs v3 02/26] nfs4.1: add a getfh() to the end of
 create_obj() compound
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-2-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uSbjfrEz1VatDWoPMEOqkp9vlVfRhcVmJAloye57tf8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb48eVujMTrsV4WKzYW6Ptye998VeEPGr/0E
 4V1qv+PZYSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+AAKCRAADmhBGVaC
 FRaED/9r8vSNMHNPBuMqv8YvztNVhz3DS9CNOvOxTKSqo0XTv0w+4Fjrp87pJVVjK0m353YYJng
 Xh7ZZR6eUh2Suvwgoqh5XLwLKqeWmOmi5cCUZY1/Fli6eQCoKucTP17u7S1HR7Jr8w3fEmWfF6t
 qlI8zcKu2ilSR9vEZcInpDua/2j23RKbWc8otDlc/b3nOlIZxcWShJiba0JbqGp+HePrUbrd3pu
 CjwFyKzMET9LmxIZWde/fBZPEJpALtzt5NODUuna9kBOoDZfW8gJXD1XfFq9D+AYvEAZ58KmN6l
 urLchwgzdpopZYb848RqdPdZrwUREpS1sKD4GISOoZOhRI5gKB+bdyX1+Wbp8vxQkcieepirxzA
 /znEEwdeiFZhXQUJU7lsWKM25tLv48c7foAeKZyWahbsJ2mUN8m3TBkygFp7vKFit4iGf2eplij
 h6lpkZH1dMA0JJDQputYWn8FiUHKrTvEqM/eCeJqfM3sIlatpxD1SjLMhhvdvyK9GseDp8N4+OY
 9Ydt/J35ak/XZ76OMGLwK7O+q81zqERkXnA+tamO0uvAftXBvcOqSkRFXhfRNq9Ke6E3m+epzSq
 uJZ//limn53BbwADH3/Ve9pUzHtk9wzKei3JX5V9MnmmNrrIYo6zOzqrYNVU+kEguG8DcXh7iPn
 mBgg/d60MKL/lXA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22697-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F1F46A77AD

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
2.54.0


