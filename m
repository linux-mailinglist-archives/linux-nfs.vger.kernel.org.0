Return-Path: <linux-nfs+bounces-8681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9889F8B39
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 05:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9137167071
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 04:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FAE78F4B;
	Fri, 20 Dec 2024 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BC818pkQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/vVPJ7Uq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZJUdv7CY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Os12brrE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86BF2594B5
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734668906; cv=none; b=TEicsxnN49sVyEMU6R2d8SZxRF+pxh6NmyMRcotx0Gs4bTO91LBYHv6+T9grVmGQMP08xHbpchZ7102JyPuOCAbVAnCrKTHWB+sPxJzfZ+63m9Hs/678vNHkz8eddU1oNzeic8WloscGf1s1+QrjQUI4HieRUjXwn+7oy1m/+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734668906; c=relaxed/simple;
	bh=nh+0ZPBXJINUX5Oy8Pc7UR1FdyMbtDlEV4o/k01oUDU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=tbGrzTE5C7U9zzyORxhTkOKUfGz6q1kHVRUBe3vK3mHDSNRY3sxqh6ax6ex1BhxvqU1IgkCYN/68Bhxuymfe1dWTjhIpUBuzXDZ43AzlbOn3jmJ7RAZvsMGY/6+OA9Mj/Nqb5k9nXUrdmbtZEG16BLU5QGeZCI1k2S0UEj+Al7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BC818pkQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/vVPJ7Uq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZJUdv7CY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Os12brrE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7BF91F365;
	Fri, 20 Dec 2024 04:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734668903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jlR0X/euD+zRzQMo0LemkRsI0YB6gqDkBiKgg0qrqDo=;
	b=BC818pkQpdXl6MkfA1DKMAbC97LNrVeiTTQSGpVD3elbodySN14SA2FeZ5b2bTWOjtDVs5
	Hkh3FV1TCuOCXCjzPVLVCAsiE2VfQeLSKXaSIxZUulmnDsCrI2JKUqWD7WXHLNw5YYtvPB
	shrQsf3+P8e1HR6Ps+R3L8lndcAm2yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734668903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jlR0X/euD+zRzQMo0LemkRsI0YB6gqDkBiKgg0qrqDo=;
	b=/vVPJ7UqN0ljZ+DN/7rlGGupttvyZ/4htt2kIoKBn3Ve6zlNMLEwHGgos1IugWaVkMVvcw
	0HUyHVJhgf0CRJBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZJUdv7CY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Os12brrE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734668902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jlR0X/euD+zRzQMo0LemkRsI0YB6gqDkBiKgg0qrqDo=;
	b=ZJUdv7CY2tIo+AF5cBWCULberokYVxRabL/sFUQa45Fplk/umKNdmlBb71Ax9n5NpsEoUd
	Q070PCSj9rizJWthMt/8mhRdwdp9q2WKDZQ9N4fxa66qUMnWF0Lt55s1cWMl+jbm4UQLw5
	srSwhl/U99c4gk8NTnsQG9ioHUF15so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734668902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jlR0X/euD+zRzQMo0LemkRsI0YB6gqDkBiKgg0qrqDo=;
	b=Os12brrEVVafuD8rzJ3gGfpKZr26O6B5LxMFOTgA0KrE/XvqYfuqfZb7NiLFPjz5GkrLoS
	HMzCdBRCErgIFfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F7F81399C;
	Fri, 20 Dec 2024 04:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /66RFGXyZGehKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 04:28:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: restore callback functionality for NFSv4.0
Date: Fri, 20 Dec 2024 15:28:18 +1100
Message-id: <173466889807.11072.9460940011488391036@noble.neil.brown.name>
X-Rspamd-Queue-Id: D7BF91F365
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 


A recent patch inadvertently broke callbacks for NFSv4.0.

In the 4.0 case we do not expect a session to be found but still need to
call setup_callback_client() which will not try to dereference it.

This patch moves the check for failure to find a session into the 4.1+
branch of setup_callback_client()

Fixes: 1e02c641c3a4 ("NFSD: Prevent NULL dereference in nfsd4_process_cb_upda=
te()")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4callback.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4ea99c47cd9d..e4a1d2d9b24a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1135,7 +1135,7 @@ static int setup_callback_client(struct nfs4_client *cl=
p, struct nfs4_cb_conn *c
 		args.authflavor =3D clp->cl_cred.cr_flavor;
 		clp->cl_cb_ident =3D conn->cb_ident;
 	} else {
-		if (!conn->cb_xprt)
+		if (!conn->cb_xprt || !ses)
 			return -EINVAL;
 		clp->cl_cb_session =3D ses;
 		args.bc_xprt =3D conn->cb_xprt;
@@ -1557,8 +1557,6 @@ static void nfsd4_process_cb_update(struct nfsd4_callba=
ck *cb)
 		ses =3D c->cn_session;
 	}
 	spin_unlock(&clp->cl_lock);
-	if (!c)
-		return;
=20
 	err =3D setup_callback_client(clp, &conn, ses);
 	if (err) {

base-commit: 8d5b7358ea7c07b69c44f0af21ebc79a49cf12a3
--=20
2.47.0


