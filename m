Return-Path: <linux-nfs+bounces-6593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D426897E442
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1E21F211D3
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Sep 2024 23:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F042042;
	Sun, 22 Sep 2024 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t+ZR5Sgk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eumk6Sty";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gm+BMxsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uiBIK3Uh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641277E1
	for <linux-nfs@vger.kernel.org>; Sun, 22 Sep 2024 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727048779; cv=none; b=S5B6YqtWz+bpRLYbnKXB3KRMB1GGgvk6cscrySXYGXhoD8azyIJ+psj+feCk7pQgtBLP9g5qbOt0jbDJPyb6R9cVW58Mfe+dP138Zcl6fYVk4jNsz1n/lq+dQM9Cj/du6fwys5/FqJ9BO66HMF/XLrsv9oITVRHrjZ/CaBOuMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727048779; c=relaxed/simple;
	bh=Mb3XVkt4t+qLFKo/SunBfXiODHiWz4YITrDHiOGjnWI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=fkvEvt7983Ysq5eDdutfLeQFf8PnQeXtP/BEvJHJ7GA1cjeU0ri0kl0rVAf0QugeybrJZ0gs+Vrv8sayyY+QKwyqMh/ymM/nQV7W+P0Ls0z4l+9BCNQOZEl7/3puBYgRZ6R/YNlxjN0/mfve03WYTj3nzvKzInHT0BL3Iapzv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t+ZR5Sgk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eumk6Sty; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gm+BMxsn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uiBIK3Uh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41F732212E;
	Sun, 22 Sep 2024 23:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727048775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+jl6Npstxy6eaRGYDJ60PiO36UWWwKTCsOi9Th5z8yE=;
	b=t+ZR5Sgk7LDQTY3PKDz4TJYZq0/u50yzVBLQUA8nPcihuUCA5+vdRIIU3iUb1yjVlgFGGU
	LWWVlPFeOO50HUu6Gzr1ggvN9xDnEJDjtutKs0EcQqKO8MUe8+IqFqwPy8IQ6zu4UyUY6G
	th0C6xKPCnEQPKLOk3Rz53ztEQG0SHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727048775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+jl6Npstxy6eaRGYDJ60PiO36UWWwKTCsOi9Th5z8yE=;
	b=Eumk6Styy+U1AHEW4qis6w5hA/N3Cp937sgXuldMQSzAt9jEYIud4QQ0kxo9i36FYNHg5i
	iN+V+rVQ8vl/WnDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gm+BMxsn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uiBIK3Uh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727048774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+jl6Npstxy6eaRGYDJ60PiO36UWWwKTCsOi9Th5z8yE=;
	b=gm+BMxsnUQPMxfuQ0MATLGixgkeoupmBCOeiPDJXI2TxMsuw091nG45l7SZF4j902XY+7i
	9k+hqv8KAd0CwSUuaozvqiXjhaKqU7yhM6MQshrdHx4UtbYhDjvBj2CrXk7GI5xVW6j7Wx
	KUgvbHTo3ZnpdDFMJSGf2ISP2eH2LrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727048774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+jl6Npstxy6eaRGYDJ60PiO36UWWwKTCsOi9Th5z8yE=;
	b=uiBIK3UhwnXupZrH6rISFdy+N+YsPjbOE2nYPJuxPLerVg+NM5wGA3u0Ks8A36eXK84F8J
	yupfNBf7oQAIrfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22A581328C;
	Sun, 22 Sep 2024 23:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j/OzMUOs8GY0aAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 22 Sep 2024 23:46:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: nfsd_destroy_serv() must call svc_destroy() even if
 nfsd_startup_net() failed
Date: Mon, 23 Sep 2024 09:46:05 +1000
Message-id: <172704876504.17050.1958700732037877952@noble.neil.brown.name>
X-Rspamd-Queue-Id: 41F732212E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,noble.neil.brown.name:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO


If nfsd_startup_net() fails and so ->nfsd_net_up is false,
nfsd_destroy_serv() doesn't currently call svc_destroy().  It should.

Fixes: 1e3577a4521e ("SUNRPC: discard sv_refcnt, and svc_get/svc_put")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index defc430f912f..5f8637b7a7a4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -385,6 +385,9 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	if (!nn->nfsd_net_up)
+		return;
+	nfsd_export_flush(net);
 	nfs4_state_shutdown_net(net);
 	nfsd_reply_cache_shutdown(nn);
 	nfsd_file_cache_shutdown_net(net);
@@ -492,11 +495,8 @@ void nfsd_destroy_serv(struct net *net)
 	 * other initialization has been done except the rpcb information.
 	 */
 	svc_rpcb_cleanup(serv, net);
-	if (!nn->nfsd_net_up)
-		return;
 
 	nfsd_shutdown_net(net);
-	nfsd_export_flush(net);
 	svc_destroy(&serv);
 }
 

base-commit: 509abfc7a0ba66afa648e8216306acdc55ec54ed
-- 
2.46.0


