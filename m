Return-Path: <linux-nfs+bounces-2910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9B8AC2BA
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 04:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A72FB20CB5
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2011346BA;
	Mon, 22 Apr 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfvtbT4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qj194ZKe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfvtbT4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qj194ZKe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556782595
	for <linux-nfs@vger.kernel.org>; Mon, 22 Apr 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751783; cv=none; b=uZgTZb9eDKmx367kJ3B6ad+P3ED7tkjUBgyDq9ygEWy+MdEsczpzpVXs29LxiXWKE8rekxSffJNEqTLAAYRCFM70UpJ8lfRf4sHkRJxaUWuD0UQIHnskLlK9xiuzmT+pK2MHwW3SKhkqrQaHMtT5NXybYBDHiwDEN+fx21isa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751783; c=relaxed/simple;
	bh=zZJAReRpem0lB6JvCYX7o5JyffqOMWqJRW0YAVHhydQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Date:Subject:Message-id; b=k67Tql7E2tnFMmG5M7IKwR7HcgcW47QvshKoSVZt8dZ/0EaKLdoyuAm5LVvTELV/heuIfE140/2yT+lWGQWkH2XTQbIYBe88k2hKNQQ+G3oVlerJRPiMonIQzugc0OX+nwauH7VD0A006v3SA1MuGvC2moB76UkC4vmpv97r9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfvtbT4u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qj194ZKe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfvtbT4u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qj194ZKe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49B045C6D1;
	Mon, 22 Apr 2024 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713751779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xuOLtAFUSfy3nu4mTJrqwZE6PbGRB9YoRZItXksbW4g=;
	b=lfvtbT4u34HOV76AHRTnSjjH9jR676A1q+7QdRuKhFkfObZz67Om3JzUAlk2oRXqpHFNek
	1lrZobgfvdgAcgHoeyWy6O3UMjQeQx4RCBROByH8doi/2T2X3wGCdyTg9AVq1lDP68PorN
	02mKVcZe9X6IW6Fw8ec1RsF+O9iDzME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713751779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xuOLtAFUSfy3nu4mTJrqwZE6PbGRB9YoRZItXksbW4g=;
	b=Qj194ZKeAO4B8+D74KuK0u5fj3lGcP8WybFwQXpHfppCyrdARpVWJx6nu3IioEWgXSnxEY
	55DIHAXIlnp+VHCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lfvtbT4u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qj194ZKe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713751779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xuOLtAFUSfy3nu4mTJrqwZE6PbGRB9YoRZItXksbW4g=;
	b=lfvtbT4u34HOV76AHRTnSjjH9jR676A1q+7QdRuKhFkfObZz67Om3JzUAlk2oRXqpHFNek
	1lrZobgfvdgAcgHoeyWy6O3UMjQeQx4RCBROByH8doi/2T2X3wGCdyTg9AVq1lDP68PorN
	02mKVcZe9X6IW6Fw8ec1RsF+O9iDzME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713751779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xuOLtAFUSfy3nu4mTJrqwZE6PbGRB9YoRZItXksbW4g=;
	b=Qj194ZKeAO4B8+D74KuK0u5fj3lGcP8WybFwQXpHfppCyrdARpVWJx6nu3IioEWgXSnxEY
	55DIHAXIlnp+VHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D1F213894;
	Mon, 22 Apr 2024 02:09:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8wXzN9/GJWbJFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 22 Apr 2024 02:09:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Date: Mon, 22 Apr 2024 12:09:19 +1000
Subject:
 [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of clients.
Message-id: <171375175915.7600.6526208866216039031@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.89 / 50.00];
	BAYES_HAM(-1.38)[90.73%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49B045C6D1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.89



The calculation of how many clients the nfs server can manage is only an
heuristic.  Triggering the laundromat to clean up old clients when we
have more than the heuristic limit is valid, but refusing to create new
clients is not.  Client creation should only fail if there really isn't
enough memory available.

This is not known to have caused a problem is production use, but
testing of lots of clients reports an error and it is not clear that
this error is justified.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index daf83823ba48..8a40bb6a4a67 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2223,10 +2223,9 @@ static struct nfs4_client *alloc_client(struct xdr_net=
obj name,
 	struct nfs4_client *clp;
 	int i;
=20
-	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients) {
+	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients)
 		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
-		return NULL;
-	}
+
 	clp =3D kmem_cache_zalloc(client_slab, GFP_KERNEL);
 	if (clp =3D=3D NULL)
 		return NULL;
--=20
2.44.0


