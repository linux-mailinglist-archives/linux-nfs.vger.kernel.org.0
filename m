Return-Path: <linux-nfs+bounces-4042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C290E11E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531FCB215D3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34501C20;
	Wed, 19 Jun 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KOkseiQZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/a1vQO2d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KOkseiQZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/a1vQO2d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DAD304
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759129; cv=none; b=DZWLfo3F7bxj/eFctmcjxzylop7tYaQkZCRBEBOmY/SwLokWXYb5lrOp5WOAt634t9G01N3V1ksvQ4/1CXSp8VtaXoUY9i3awfhXPLpb+gpE77wQlx4dWs8oi8K7uD4TcU4ifnMkq0r0gGb32RW/OwvYwZEeIe7HuhKz014DkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759129; c=relaxed/simple;
	bh=2jsrZGxX+g3wE6OsJhnidw6sFtoa57ANTmEsHfM47rY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=r11QgRLx5cgWQp/1Z1teEWIOwko3DqcAlmq4yecrQOcfZ9EKMrTcgfr2zyuxxE3Hb92bX7iihNZe7s1OPs8Ni6qr/ufbuv8NlouUUe3iyzX1BvSDOz23VCvA/7gu9ytzEhjvbyRZMosAKSmoZP61v/NjB4W4loFdyJkYvw0OVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KOkseiQZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/a1vQO2d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KOkseiQZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/a1vQO2d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 441441F7A9;
	Wed, 19 Jun 2024 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718759126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jpn/M+ssRtFDGPR9TAayS+tIG5JL5qDoAjom9AOjkwU=;
	b=KOkseiQZG1JcA8m+yTJ8xtK/qHswTv/3SrNtaxx1SW2Sy4EqL73InzPUc6/eC1zIN5EKKJ
	YYoPqzy5KQGMSFc9eUuKQhiN1lbdzppfuiW99Q87yr76/bPq5MmwQNrJlU1zBM5OjYp/VD
	jV1Kxwf9PWfrTC7BnUUts3RFPh22gUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718759126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jpn/M+ssRtFDGPR9TAayS+tIG5JL5qDoAjom9AOjkwU=;
	b=/a1vQO2du22A5+lcSKKO9+oXXSnlfFTmkrvdMfQqtcB07Hcbt+N11T60+en4sU3OQx8FZd
	XuGaf2+wRYV1RnAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KOkseiQZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/a1vQO2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718759126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jpn/M+ssRtFDGPR9TAayS+tIG5JL5qDoAjom9AOjkwU=;
	b=KOkseiQZG1JcA8m+yTJ8xtK/qHswTv/3SrNtaxx1SW2Sy4EqL73InzPUc6/eC1zIN5EKKJ
	YYoPqzy5KQGMSFc9eUuKQhiN1lbdzppfuiW99Q87yr76/bPq5MmwQNrJlU1zBM5OjYp/VD
	jV1Kxwf9PWfrTC7BnUUts3RFPh22gUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718759126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jpn/M+ssRtFDGPR9TAayS+tIG5JL5qDoAjom9AOjkwU=;
	b=/a1vQO2du22A5+lcSKKO9+oXXSnlfFTmkrvdMfQqtcB07Hcbt+N11T60+en4sU3OQx8FZd
	XuGaf2+wRYV1RnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD7A91369F;
	Wed, 19 Jun 2024 01:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1CLkF9QucmZyJQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 01:05:24 +0000
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
Subject:
 [PATCH] SUNRPC: avoid soft lockup when transmitting UDP to reachable server.
Date: Wed, 19 Jun 2024 11:05:13 +1000
Message-id: <171875911308.14261.6599280388633355688@noble.neil.brown.name>
X-Spamd-Result: default: False [-6.43 / 50.00];
	BAYES_HAM(-2.92)[99.67%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 441441F7A9
X-Spam-Flag: NO
X-Spam-Score: -6.43
X-Spam-Level: 


Prior to the commit identified below, call_transmit_status() would
handle -EPERM and other errors related to an unreachable server by
falling through to call_status() which added a 3-second delay and
handled the failure as a timeout.

Since that commit, call_transmit_status() falls through to
handle_bind().  For UDP this moves straight on to handle_connect() and
handle_transmit() so we immediately retransmit - and likely get the same
error.

This results in an indefinite loop in __rpc_execute() which triggers a
soft-lockup warning.

For the errors that indicate an unreachable server,
call_transmit_status() should fall back to call_status() as it did
before.  This cannot cause the thundering herd that the previous patch
was avoiding, as the call_status() will insert a delay.

Fixes: ed7dc973bd91 ("SUNRPC: Prevent thundering herd when the socket is not =
connected")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/clnt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cfd1b1bf7e35..09f29a95f2bc 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2326,12 +2326,13 @@ call_transmit_status(struct rpc_task *task)
 		task->tk_action =3D call_transmit;
 		task->tk_status =3D 0;
 		break;
-	case -ECONNREFUSED:
 	case -EHOSTDOWN:
 	case -ENETDOWN:
 	case -EHOSTUNREACH:
 	case -ENETUNREACH:
 	case -EPERM:
+		break;
+	case -ECONNREFUSED:
 		if (RPC_IS_SOFTCONN(task)) {
 			if (!task->tk_msg.rpc_proc->p_proc)
 				trace_xprt_ping(task->tk_xprt,
--=20
2.44.0


