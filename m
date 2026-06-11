Return-Path: <linux-nfs+bounces-22450-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dtApCIMWKmo0igMAu9opvQ
	(envelope-from <linux-nfs+bounces-22450-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CF66DBB1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LMjlR638;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22450-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22450-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E64B130BC946
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356118787A;
	Thu, 11 Jun 2026 01:59:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74AFC0A
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 01:59:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143162; cv=none; b=RhhUwDwrJuLRsVrUn3M0PEb4Fa6yeHuE7qXdB6qQUCD8rmX5sVhpq1Cdp8mIA/f0+FPn8YYuwX6GAdc2jkPgl7Q2Mohnben8aG7PAwDk87o7NEVAV5KZy6V2KIwLyVuhrSBeDnUIK3UelhriPkqYQab+zaX8aT1mA/hQqkIsmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143162; c=relaxed/simple;
	bh=hl30GM5W0UudN2edmbVcf0OInusvq2r2Ivaa/gB47FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hx5cG6R3z3uSi6/NIH6YPjYnAuZamAjZ4LfZknsrfG3kjPgCY/ONJtFInLOGJV/KZaC58ELLZXnC3jAqdt7ooAdZ9nP1i0OcuPE4hxaWhGM42OUQEBO9a/barn75okxlgWmWaOgmesAT9u4ppiAkKoaNhWOJfEgDEJ8sIkWILE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMjlR638; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCA51F0089A;
	Thu, 11 Jun 2026 01:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143161;
	bh=LXpxZhSUWGtCSUKQMdmDzUyMxCiN6gE11lxGXTDzFwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LMjlR638bFWhZ57iDnxSMcj7vIbCavTRR5RG4PD/Xk1j96wUV08IucZPmmOXzDI77
	 r3/JNFRmqYZuIcO4nZvRRi9r6M5uxaG4VZudkJNzjkGx3jc50E8jQ8vVdUtuxOUJJw
	 orKt1/4FeBv5UoWUtJg9ZOZfiyuflwFtQsqF6A98aQMAKPKzQu8TJI57i1vQ/Cr4ve
	 Uk2FNSHauPZ/6qh0ugqWdQluNYCwTQ6XLc3EGD9ELQVVK1z/I5pOdf0o1IitEaJxt3
	 8nB8EFrduisOOwnzuksOOkANDb7KT/fgojSW1uKcqLSDge/deC8+2aDKbJhiURCEt/
	 Gw7tCvpXwyJZg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 10 Jun 2026 21:58:55 -0400
Subject: [PATCH 3/5] NFSD: Clean up documenting comment for
 reduce_session_slots()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-nfsd-slot-growth-clamp-v1-3-7b966700df0b@kernel.org>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
In-Reply-To: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
 Jonathan Flynn <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=cel@kernel.org;
 h=from:subject:message-id; bh=hl30GM5W0UudN2edmbVcf0OInusvq2r2Ivaa/gB47FY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqKhZ1zS6umA2wIS+3sUlBTYBUSDebe14IYhuw9
 rIDh4vzHQeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaioWdQAKCRAzarMzb2Z/
 l/MmD/9nqhm9gfqCQb/1Zx7peEiWzbVdu2hOwlUqIdGuGY2rMBmzMKBTKW1BZ0ygDJU/jwKHeTM
 hYFBik4MzFL+UzJet74Cu+qsZ+k8YQa9gkQZuGvhm24rcYYTGkKlpy/lovmrLoLBwDhmPMV7Ir4
 tQg2wm5iHtN4x3Hxli4tfD8IKLSMMiKE5Q4CPArD/R4pulpJm4twgXbzRvJVe2LkXH2u39GTnZA
 dLQdTiHzqJMhVr8kzyv4nzT0WVFA3iMmo0Y8sNv13tiw22VVAdC5kNnt+8rJKK3Ep1MNyzBbA1y
 jEh1eb9H/xclZLGYbarHzZP4XCf40/0rgBXq1/7tQF3yxABt8x/eJaTd2nCsoahr+4IqInRgidi
 cIDuuQ2eW+/ywOCq2lpThlmtPgjMTykZduXwr4xEI9qW22HnrVVytYk9GFEp2tRjcVuiUUKpQ2U
 MOu771Eixqg/mwcGD7oR8e0IrPklVs8hMnKY0TzcdeF80tTMjTdmA7S9/PFR/rnI6i8nfBBVR3i
 eTuhulMcmF/H/Gn0f8XLSNmAUMeETSW3PZj7YQ2F9+nIxjaSXuZ6Ye6RdkZoQ4Bp4l1JhrrrHzq
 rHQZmVbS0COmEXp+4bPxJYSvQIjKn+/14p7fdM4PsUXr1OJlUuhYM9T3ONtQNDT4ECButyZyzFL
 VZfsFZeY/8gNgJQ==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22450-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:bcodding@hammerspace.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC6CF66DBB1

Fix typos. The usual convention is to not use kdoc-style for
internal (static) functions.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfs4state.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f2c92e7eee6a..9735e9a59f0e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1986,20 +1986,13 @@ free_session_slots(struct nfsd4_session *ses, int from)
 	}
 }
 
-/**
- * reduce_session_slots - reduce the target max-slots of a session if possible
- * @ses:  The session to affect
- * @dec:  how much to decrease the target by
- *
+/*
  * This interface can be used by a shrinker to reduce the target max-slots
  * for a session so that some slots can eventually be freed.
  * It uses spin_trylock() as it may be called in a context where another
  * spinlock is held that has a dependency on client_lock.  As shrinkers are
- * best-effort, skiping a session is client_lock is already held has no
- * great coast
- *
- * Return value:
- *   The number of slots that the target was reduced by.
+ * best-effort, skipping a session with the client_lock already held has no
+ * great cost.
  */
 static int
 reduce_session_slots(struct nfsd4_session *ses, int dec)

-- 
2.54.0


