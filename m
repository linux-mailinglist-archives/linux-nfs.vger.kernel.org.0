Return-Path: <linux-nfs+bounces-22770-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V8rqBB+aOWoUvgcAu9opvQ
	(envelope-from <linux-nfs+bounces-22770-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 22:25:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BD6B23FB
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 22:25:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=medichon.fr header.s=ovhmo3801317-selector1 header.b=BsIS7TxL;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22770-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22770-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17C1230368B6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 20:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250034D3B0;
	Mon, 22 Jun 2026 20:25:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46B34D3B2
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 20:24:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159900; cv=none; b=DYjOEZRNFoLtFNhXEHiwz0jM6/bYXx/l81g0TIRNMLAaNwjwea+bFPz3zTj3taVOVYyrN5xxfAouBaVFW+TQ72paGqw29q2rbs/0sGDwN/b76XfED7QpYa/RYeQ/XbNkBhN466SHqxgUVW6A8IrVWNnh/52WyhYmWtfwfvK+jk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159900; c=relaxed/simple;
	bh=QFVNcbUmf7knt2wDTPFQrIQVeLimzfcml0Z0p5TcKIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnHLKLo4TD/jeBaeAvG1opULW/fKex8qN+ePux0uKs/ppDyXTkI8bOo5KLMxbpxyKKCzXqr2+vEuuJVdKjMEpMxYN9m+7K/tvmt9ZL1bg/u2A4WzxFmXcWlVnqWuX+5HLzkv8nwjOUr9JsS4n7+ZQPi/zaK9rMN+QQObhQgXLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr; spf=pass smtp.mailfrom=medichon.fr; dkim=pass (2048-bit key) header.d=medichon.fr header.i=@medichon.fr header.b=BsIS7TxL; arc=none smtp.client-ip=46.105.75.36
Received: from director6.ghost.mail-out.ovh.net (unknown [10.110.37.251])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4gkbVl58B3z5wR0
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 17:56:47 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-ghq26 (unknown [10.110.188.223])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1A2C58017F;
	Mon, 22 Jun 2026 17:56:47 +0000 (UTC)
Received: from medichon.fr ([37.59.142.101])
	by ghost-submission-7d8d68f679-ghq26 with ESMTPSA
	id evTZOl53OWrOIhsAiGv3aQ
	(envelope-from <abo@medichon.fr>); Mon, 22 Jun 2026 17:56:47 +0000
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
Subject: [PATCH 0/2] nfs: refactor bit operations using clear_and_wake_up_bit
Date: Mon, 22 Jun 2026 19:55:09 +0200
Message-ID: <cover.1782148639.git.abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8601593814169181790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEYiaRYT3r9jlIA0oEG4B6jh3fy9pIW0eb/Th3QyottCtY5waIWuKOMmq16quGabDO2oXzpz1USi008BQP4mzbxJ3kZ5hl29krUeN2bkEXUYNdhne96a4pl7N5NG74aO0TuD1Rl5nrYv9Wme0yAz9i0KzyaUk6cWKoYaLQKTDRzv/hrNhGUtVW1VsPgoaFm9ieK3H/yJo+V1Rw974yQdNkinl/OVG4Z1rYtE/hB/2abuNcJeGMio34EqprhYAf0nqkz70kz2xTyhrwcTqXaJVv7knDnj/mkbzuf2XSeoDP7PRFw8nc4PDO1L4UF/xdE+/7vsoGnT1BEuAgGVCDXLRgqRF818u8eK5as0D/NGJO1tOFiSabKZ96hZ+CF9Tal6dfp6lt42k3alLAvr4cQhij3VPbWFuNvL7sfXKpLANT4FGzZ0r/A/qg00WT5JridXPbM9HUS/2GENJRgeMifCAl+twO1+zHKIy3LBqJTeyHYOdx3Ymf66ldtY6uB8jGobZjhKKmTRCv3IBBE4G0gXginOGyjL0oI06lS3mG8JUK/qwPeYp/04BkRYxBDwkgho00qqstMh28WSYVsxKHk9SiXGJ01CPRbpSAWlRRtHf6kiBUPvBxTB/SzFQxXjFPIRbSTLjCQDYj+Nc+xT9eCOaLTABPjZF3nE3MGCzD6n0yb7Q
DKIM-Signature: a=rsa-sha256; bh=I4XupfxaOi3hDJ4E5xk1CLtm675cjM3xvj6zaVMvTMc=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1782151007; v=1;
 b=BsIS7TxLyn3KoZgs7poe3f9/tHUf1UtY65+qhlFWt9OP2FGFZxjNn4aiRBjBgX6ZiFdVDaOK
 29ghcmcYFb4V4Q8ufkTVqZvFTlj6ZYRJWpXgI+3XePBHQCVFzEoaCU/xsgRwmYigPkF6pt0Hj71
 0Zu01+5ek1L4SkiEljDFY+7Ys32ws9k/cApEpC9Ji67NjR7zHVTcmd4kAaDdYaIroDc8spe7opT
 E9RgX67KURQrRZWSw4dAmTYt293nFkFkJ5/HWGcq+1p8vx88M7qjFH0sN0ONxuavuzdGhs3++82
 CxtWasjEXtZ3w31UVA75OMyoZF5YM50Hb2nGY3+LLyKpA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[medichon.fr:s=ovhmo3801317-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22770-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,agatha.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A09BD6B23FB

Several functions in nfs code use the exact following sequence of calls
when dealing with flags:
	
	clear_bit_unlock();
	smp_mb__after_atomic();
	wake_up_bit();

Since commit 8236b0ae31c8 ("bdi: wake up concurrent wb_shutdown()
callers.") came the helper clear_and_wake_up_bit() for this exact
purpose, and has since been adopted by several subsystems, including
vfs.

This function is already used in files such as nfs4state.c and
pnfs_nfs.c and this serie aims to continue this effort, which also
allows to remove some no longer used code.

Tested on x86 hardware using a loopback pNFS SCSI layout:
* doing image compression/decompression using xz and
* recompiling tinyconfig kernels on the remounted partition
No error reported under sanitizers.

Suggested-by: Agatha Isabelle Moreira <code@agatha.dev>
Link: https://kernelnewbies.org/Beginner%20Cleanup%20and%20Refactor%20Tasks%20by%20Agatha%20Isabelle%20Moreira#task_007
Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---

Arnaud Bonnet (2):
  nfs: replace atomic bitops sequence with clear_and_wake_up_bit helper
  nfs: refactor pNFS functions using clear_and_wake_up_bit

 fs/nfs/inode.c |  4 +---
 fs/nfs/pnfs.c  | 35 ++++++++++-------------------------
 2 files changed, 11 insertions(+), 28 deletions(-)

-- 
2.53.0


