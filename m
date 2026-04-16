Return-Path: <linux-nfs+bounces-20903-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GAKKb8n4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20903-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B8413A6B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24CA30CDD07
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916DA2F9D85;
	Thu, 16 Apr 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lakBXmLT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EF330324
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363301; cv=none; b=uXcCTuOMq7Rxv+nbBdxFrHbAjBWuPubXM8pU7J/lNo1qnpLxN2F24W0fDyvEQxyYXrwl6i8mBG3s0g3C6nt9X5qZ+TRaitcMXsoY/M/2i7B0QeVVVWGqeb1Q3erhnoW9sjUAe4lLp4N8Uw7pO3LOSmMWWVQHECKKrZbuU862mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363301; c=relaxed/simple;
	bh=x1Z+XzT17sIzRF8aJgdNS1Kc96XEDPPtgEzQsR79HnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TO9G5yYWjdBqdqhCIzOMKqGATjzTMO+HcUVKvkCIm3M8HKfTOgnhoaSVm+or5gh3j3q4jNLggsTCK/Ew9Nn78QG56ghtujLmkSM5638dd02vQpVOXhPb9MXuVH9Y/ie77lAHldTfMDLgXiY5+hqimeOhAHFzs1r1Cm5z7U3OJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lakBXmLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF9FC2BCAF;
	Thu, 16 Apr 2026 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363301;
	bh=x1Z+XzT17sIzRF8aJgdNS1Kc96XEDPPtgEzQsR79HnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lakBXmLT3cTkRQHgJd7cv0PA09Ae30rsIteG1ezZui45S/JAqj8++wXNXe9r/P5O8
	 J3zTRpdjFxcN00RVoSlItpC8SmE+904kaP+Z67wQkcDn7xYWRplTeATHbn8r+bkU6B
	 cgAofFsM8Wjhc+zDEFcEHpSf5puzYUtZn4W0Xmf36DBAKrZb4a2WGDiTsJfFVKRwTl
	 pvxRyKHBbtkJ3581cqh4PGrcHKAlDOSPT+6+/AUS1tW3iQR99OEwPU2qCzRQ9EJYhz
	 FK+Rjag3O+pKvr36dFHwSu/ggwxVkIULH0BzZsPvJXkL35tsfOzuieXoLt2zMj7ShD
	 vgWlMFLhQXRxA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:33 -0700
Subject: [PATCH pynfs v2 01/25] nfs4.1: add proposed NOTIFY4_GFLAG_EXTEND
 flag
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-1-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x1Z+XzT17sIzRF8aJgdNS1Kc96XEDPPtgEzQsR79HnE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4SceXOCOqZz7hOOo6nVzs+GxkHnBjj96C4KE5
 cJh/F1lZjeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnHgAKCRAADmhBGVaC
 FdfvD/93WUqsIKUczOwwW/HW9yx81lhfKe/hPKvEW9vujlDRBgTw068AA4eHK0BpNoDIJk6mQDa
 sR377QEGPr5VknegL/5yUhfzt9Z58N5SCCUp5cm//Nzln82KdifxXcI5qS4ahKFPBOI4CPQwQ3D
 hK+HIC8zlPW4UaZObkp7S+7d/UJKiWYrump6w/amYZ9gRf+xijy1dySdfIYr6j9E3ekN0+81MTG
 po1RhfIMvFO2mqyUD7yMB/kEkVxuDTiQ4PlRxP2cFbtQfFjK9mWqSUxd9g64ie3ssNITW9CRxlV
 7gZ6zZmMyVPanzjhEDiltObkgZjXQCuZGaTzIxk7+1xNYGOqVWvLJ0JssPa/4NleZW4Tb2m3c9v
 nIb2v67Czx8ItWQpBdP2PS7nV9YXqoDbsK3ZZJIDiWbGImnzyXuBagEC7+eNUGxt/JplwWhlFCD
 tpJzgEI2EFchCgIkz7qw0XuCbDLhTHihZla7Ag1DqA8VgzTBvcaGa7C7OahpcURLolP0kbrIhFX
 QDIYQVySXjyl7w9D/C2SwTcrBEL2X/ldS7D71uuri9NGrciMaepqyRvs6ai2pRXOOUhu+YrbEHf
 I44hMbqfwDgKhnZJg0RE8Hw8KlNEKtF1pFDlq82WSYn4tJzTewFrTSLHG6acox9GgGKF+Ih5vjC
 nOcujRAcRSa1tiA==
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
	TAGGED_FROM(0.00)[bounces-20903-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 405B8413A6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This flag has been proposed as part of RFC8881bis. This flag is used to
negotiate extensions to the original directory delegations originally
specified in RFC8881.

In practice, the Linux nfs server requires that the client support this
flag if it's requesting anything other than a recall-only delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/xdrdef/nfs4.x | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nfs4.1/xdrdef/nfs4.x b/nfs4.1/xdrdef/nfs4.x
index ee3da8aa7a34..f03eb538a298 100644
--- a/nfs4.1/xdrdef/nfs4.x
+++ b/nfs4.1/xdrdef/nfs4.x
@@ -3611,7 +3611,8 @@ enum notify_type4 {
         NOTIFY4_REMOVE_ENTRY = 2,
         NOTIFY4_ADD_ENTRY = 3,
         NOTIFY4_RENAME_ENTRY = 4,
-        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+        NOTIFY4_GFLAG_EXTEND = 6 /* proposed in rfc8881bis */
 };
 
 /* Changed entry information.  */

-- 
2.53.0


