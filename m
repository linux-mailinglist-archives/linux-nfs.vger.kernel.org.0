Return-Path: <linux-nfs+bounces-22769-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JD4eD86aOWo0vgcAu9opvQ
	(envelope-from <linux-nfs+bounces-22769-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 22:27:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 870676B242B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 22:27:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=medichon.fr header.s=ovhmo3801317-selector1 header.b=K2zHheZG;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22769-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22769-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D190F3038AF1
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 20:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A526334D398;
	Mon, 22 Jun 2026 20:24:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from 3.mo583.mail-out.ovh.net (3.mo583.mail-out.ovh.net [46.105.40.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9634CFDE
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 20:24:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159897; cv=none; b=KM2dGsWwFUci9LJ2UTU9hIKx2mcZ8M/E6t08DdijIaTlemv6ZJsV9B9LnttJMUhDDvUuiFhdrv6Ne/BbAlt3WBHgjpVuEL5YPv6xNjXLhrpb4oOvdEh4ELTNk9TVMakP8ELjmNswerqf/ZPL1G/eYOSPAhyNUIe78PVziNEQgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159897; c=relaxed/simple;
	bh=jjRzVyGeRT0FbdDdfVJT0XsVYWrNvEERcVte4wlwZYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPato+7o11If4Iu6mlQtv9t4q7J/J4Er6kwiNaScQiKjhUPv9bGBtCZJzaBmcZ1ZA2GWhMJMMww1Sg94MlgGTnRaPGPfcSlH8y4P4PR74cm5FHuVwxYvcVlOaab3oxUHtkMLATPrwrYm5BKP5Y7oGBRYpnnqNgj+LRphpUQrvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr; spf=pass smtp.mailfrom=medichon.fr; dkim=pass (2048-bit key) header.d=medichon.fr header.i=@medichon.fr header.b=K2zHheZG; arc=none smtp.client-ip=46.105.40.108
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.231.233])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4gkbVx3Y7Nz5x5P
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 17:56:57 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-ghq26 (unknown [10.110.188.223])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 39E33801D4;
	Mon, 22 Jun 2026 17:56:57 +0000 (UTC)
Received: from medichon.fr ([37.59.142.101])
	by ghost-submission-7d8d68f679-ghq26 with ESMTPSA
	id evTZOl53OWrOIhsAiGv3aQ:T2
	(envelope-from <abo@medichon.fr>); Mon, 22 Jun 2026 17:56:57 +0000
X-OVh-ClientIp:88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	code@agatha.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH 1/2] nfs: replace atomic bitops sequence with clear_and_wake_up_bit helper
Date: Mon, 22 Jun 2026 19:55:10 +0200
Message-ID: <e842cc1d57fac695545d4d32da795d5a4136553e.1782148639.git.abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782148639.git.abo@medichon.fr>
References: <cover.1782148639.git.abo@medichon.fr>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8604408564403691102
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEg5OJE+LVGbM2zhQ7CVlojEpm8YYvx+PQjb7M6SgvAjw4wo7NbhNxbsDyVrDQXK+4QbQdoIp5td98btMR8pN374n8BhvBLXNoXNyDhuYr3gkmxppc9YQx9uvFEaWm4sXSK+c/YL427Z82CqaoYUL+veXT7PpRxbRs55toXw31EBdpcFPKBHkgcGDYtdgmaT26OAFqeJbK115Phc5FSjed0Ac8XaRVQqdpzMS74J9mr9JFgJ0JItfPAzhDplads2M+HP6P9Wuu2X7D7QunByrZkhMF2aboKNKRf2MVZi3U42rhcbJK2G6Cdy4ijTmt/MTicqp5pBFzzj7WK9oFNn4AdMLLFBHY6UybRpPcSaytQs14UO8PGy9myuPDgxS8AUcr8ZpMqBGqETvFEywYkTEbAqwud3A6MZd433Tl5APhHli8EvqD0MlBzU263tsu3812mUlYazR30Ib8QXfFq/7//o3WzPK/TshwQwwCQidIrGPuhrK1RhPVhDNuoiWQ9Ku0K5U89zALf1K9UqswkDAl8v/quXDBV9IPfk3HesaYT+AN3pbGQqEjowvex8W3kw+XZwYnZfN3eUgzr1vtIxjRhNBhkWQLQHuKfpQR12g+Qqvevf+YXGVjJkTkieso9lsTwhDsNsx4KJkJhoZHskTcEcj0YPKhN5FyKsTYnS8QRQQ
DKIM-Signature: a=rsa-sha256; bh=B2QRBvsW4wVYMPc1pyWsb10tM2XdgPNfSTs/fsf6UjM=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1782151017; v=1;
 b=K2zHheZGIVKzd9MKoXcwWH3K6QahE3me1RvB+VRGM7cU5EvnUqNXTn3dPkOapJ1SNAPZtH2i
 NazFlY6GJKQ0mvMWJMx/tS0+XIFK8SWS/6vCKF7wdqmZV0Yj6F/z3STKv9he41ye5sJlNtDI5j0
 fAamawKVcMkrBc4qHy8mkswrAonK8UbKQGQ2VHw49JixvA9y4vvKWlS64Kpomrwu+VpSAZvK+6Z
 dyS7DfN6mBaXXoB9LfOu+WM81S+x9HvBzRORQrqmQ/t7iYXrrW5VLY3ImSoz9XylyUTnT6LI+2V
 oyVXyg3/UbOhqfRbPnRZhc2d30Wy0asyjINOrxZRJEjdA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[medichon.fr:s=ovhmo3801317-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22769-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:code@agatha.dev,m:skhan@linuxfoundation.org,m:me@brighamcampbell.com,m:jkoolstra@xs4all.nl,m:abo@medichon.fr,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[abo@medichon.fr,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,agatha.dev,linuxfoundation.org,brighamcampbell.com,xs4all.nl,medichon.fr];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[medichon.fr];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abo@medichon.fr,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[medichon.fr:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[agatha.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 870676B242B

Commit 8236b0ae31c83 ("bdi: wake up concurrent wb_shutdown() callers.")
introduces the clear_and_wake_up_bit() helper as a wrapper for the
common clear -> barrier -> wake up bitops sequence.

Use the helper in nfs_clear_invalid_mapping as inode.c already relies
on functions from <linux/wait_bit.h> and to homogenize with other
subsystems.

Suggested-by: Agatha Isabelle Moreira <code@agatha.dev>
Link: https://kernelnewbies.org/Beginner%20Cleanup%20and%20Refactor%20Tasks%20by%20Agatha%20Isabelle%20Moreira#task_007
Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
 fs/nfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e26030e73696..9c74de557592 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1542,9 +1542,7 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 	ret = nfs_invalidate_mapping(inode, mapping);
 	trace_nfs_invalidate_mapping_exit(inode, ret);
 
-	clear_bit_unlock(NFS_INO_INVALIDATING, bitlock);
-	smp_mb__after_atomic();
-	wake_up_bit(bitlock, NFS_INO_INVALIDATING);
+	clear_and_wake_up_bit(NFS_INO_INVALIDATING, bitlock);
 out:
 	return ret;
 }
-- 
2.53.0


