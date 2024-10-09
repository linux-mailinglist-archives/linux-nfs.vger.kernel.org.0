Return-Path: <linux-nfs+bounces-6970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D28995EF4
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 07:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9111F22E7F
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 05:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1883BB48;
	Wed,  9 Oct 2024 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XGd3tDw0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rQKo/g6f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XGd3tDw0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rQKo/g6f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868E39AEB
	for <linux-nfs@vger.kernel.org>; Wed,  9 Oct 2024 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451694; cv=none; b=tu/mIbwAn+iIsATT46RurmUzMnYNgw3JrPvwmW6eaXGumXKiQrN991Njyae7qVzYUOC5rp33QdktTq7L6sfKKlCc7GV/xjQQbTAWXkerkXP9dg8Zp6yy7yxOacVdptRtqxzDuTffglfFaCViXat4EH1n93/3bW9sXXegVG9BLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451694; c=relaxed/simple;
	bh=XUGcMJ2WQFVt9hL6HszaEj324skh//cxl0WdEjdoEv0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=V2ITiRZZg9cViQ4BJqgt2vQOAqV7Nh0XBowTjFIRJOakvpFFJi2aI0zE1eltqaI9+bHobhOlnPTRMj0jOSKQu2z8l6/WYBP2VdhXbCJUDzBi/U8ai2TG6uEJrDA/Uty01MYh9V2e3yuauXmHmrrs5+66rg/RxM00VswVFEhSbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XGd3tDw0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rQKo/g6f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XGd3tDw0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rQKo/g6f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB5CC1FB7F;
	Wed,  9 Oct 2024 05:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728451690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KG8sif21O8kgbsxy9VeFmFjHbp1qMJ9TtkK2sJyaPKg=;
	b=XGd3tDw0KX+8rr96e068NMqREnbEfUwEyjyTizP4SaZd5POrVOaURjB3jRfrnrZed4nCVE
	e2DrpV6jOapYBw9y4nToVyF7fACQ7okTlPPQckH9DhBA8uYc9BuRz+jBXJnaTDnNCSpkv/
	XrZAhhYLfrnMerjOa1ChtNV1+8RPvqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728451690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KG8sif21O8kgbsxy9VeFmFjHbp1qMJ9TtkK2sJyaPKg=;
	b=rQKo/g6f1Z33xnVcQeMPm98uGHY3d0AMe/kUIVlljgjbiAE602d3g0ZRiAm7mOIT3cs2yz
	E46WsSDjpnWDBZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728451690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KG8sif21O8kgbsxy9VeFmFjHbp1qMJ9TtkK2sJyaPKg=;
	b=XGd3tDw0KX+8rr96e068NMqREnbEfUwEyjyTizP4SaZd5POrVOaURjB3jRfrnrZed4nCVE
	e2DrpV6jOapYBw9y4nToVyF7fACQ7okTlPPQckH9DhBA8uYc9BuRz+jBXJnaTDnNCSpkv/
	XrZAhhYLfrnMerjOa1ChtNV1+8RPvqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728451690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KG8sif21O8kgbsxy9VeFmFjHbp1qMJ9TtkK2sJyaPKg=;
	b=rQKo/g6f1Z33xnVcQeMPm98uGHY3d0AMe/kUIVlljgjbiAE602d3g0ZRiAm7mOIT3cs2yz
	E46WsSDjpnWDBZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87D5A132BD;
	Wed,  9 Oct 2024 05:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cocvD2kUBmf6FwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 09 Oct 2024 05:28:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
Date: Wed, 09 Oct 2024 16:28:06 +1100
Message-id: <172845168634.444407.8582369591049332159@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 


xs_tcp_finish_connecting() can return -ENOTCONN but the switch statement
in xs_tcp_setup_socket() treats that as an unhandled error.

If we treat it as a known error it would propagate back to
call_connect_status() which does handle that error code.  This appears
to be the intention of the commit (given below) which added -ENOTCONN as
a return status for xs_tcp_finish_connecting().

So add -ENOTCONN to the switch statement as an error to pass through to
the caller.

Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1231050
Link: https://access.redhat.com/discussions/3434091
Fixes: 01d37c428ae0 ("SUNRPC: xprt_connect() don't abort the task if the tran=
sport isn't bound")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprtsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 0e1691316f42..1326fbf45a34 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2459,6 +2459,7 @@ static void xs_tcp_setup_socket(struct work_struct *wor=
k)
 	case -EHOSTUNREACH:
 	case -EADDRINUSE:
 	case -ENOBUFS:
+	case -ENOTCONN:
 		break;
 	default:
 		printk("%s: connect returned unhandled error %d\n",
--=20
2.46.0


