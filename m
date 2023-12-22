Return-Path: <linux-nfs+bounces-772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD0981C2DC
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 02:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B081F1C216E5
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Dec 2023 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE66259D;
	Fri, 22 Dec 2023 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yXab42xs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7P/a0d7X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yXab42xs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7P/a0d7X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC74258F
	for <linux-nfs@vger.kernel.org>; Fri, 22 Dec 2023 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B438921DB7;
	Fri, 22 Dec 2023 01:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703209265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEAuWxJjHddksJ9CJG3TbgUOIN928djmbyokaZTRZMQ=;
	b=yXab42xsyPrVFMLurPSP14QFhtsOoTLiG20GXtBtcj4T45MSrr1GOqZO3Lak3/uWoA5c31
	gq1pe3oQCWtAcBQsPqhYTvbdhLASOQSKdyrV3MoEYkZ6viF1xiGp0EJVDHqj/Fvy7w/WEg
	16JWynhfFausL1uwx0rwGIk9lD1vmB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703209265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEAuWxJjHddksJ9CJG3TbgUOIN928djmbyokaZTRZMQ=;
	b=7P/a0d7XTwcTZZfX5Uuvwge/8AbRCH9SxYUdwSeawIYGFhyA/sHmdNc0cf1F9xD0r9S3wl
	L8LI8MEcAdd4v5CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703209265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEAuWxJjHddksJ9CJG3TbgUOIN928djmbyokaZTRZMQ=;
	b=yXab42xsyPrVFMLurPSP14QFhtsOoTLiG20GXtBtcj4T45MSrr1GOqZO3Lak3/uWoA5c31
	gq1pe3oQCWtAcBQsPqhYTvbdhLASOQSKdyrV3MoEYkZ6viF1xiGp0EJVDHqj/Fvy7w/WEg
	16JWynhfFausL1uwx0rwGIk9lD1vmB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703209265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YEAuWxJjHddksJ9CJG3TbgUOIN928djmbyokaZTRZMQ=;
	b=7P/a0d7XTwcTZZfX5Uuvwge/8AbRCH9SxYUdwSeawIYGFhyA/sHmdNc0cf1F9xD0r9S3wl
	L8LI8MEcAdd4v5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EF3613AA6;
	Fri, 22 Dec 2023 01:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4FFiBS/phGWzRwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 22 Dec 2023 01:41:03 +0000
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
 "J. Bruce Fields" <bfields@fieldses.org>
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,Tom
 Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: drop st_mutex before calling move_to_close_lru()
Date: Fri, 22 Dec 2023 12:41:00 +1100
Message-id: <170320926037.11005.9834662167645370066@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.28
X-Spamd-Result: default: False [-1.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.18)[-0.902];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.89%]
X-Spam-Flag: NO


move_to_close_lru() is currently called with ->st_mutex held.
This can lead to a deadlock as move_to_close_lru() waits for sc_count to
drop to 2, and some threads holding a reference might be waiting for the
mutex.  These references will never be dropped so sc_count will never
reach 2.

There can be no harm in dropping ->st_mutex to before
move_to_close_lru() because the only place that takes the mutex is
nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.

See also
 https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
where this problem was raised but not successfully resolved.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40415929e2ae..1fd0c8a59cc4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7055,7 +7055,7 @@ nfsd4_open_downgrade(struct svc_rqst *rqstp,
 	return status;
 }
=20
-static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
+static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 {
 	struct nfs4_client *clp =3D s->st_stid.sc_client;
 	bool unhashed;
@@ -7072,11 +7072,11 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_s=
tateid *s)
 		list_for_each_entry(stp, &reaplist, st_locks)
 			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
 		free_ol_stateid_reaplist(&reaplist);
+		return false;
 	} else {
 		spin_unlock(&clp->cl_lock);
 		free_ol_stateid_reaplist(&reaplist);
-		if (unhashed)
-			move_to_close_lru(s, clp->net);
+		return unhashed;
 	}
 }
=20
@@ -7092,6 +7092,7 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compou=
nd_state *cstate,
 	struct nfs4_ol_stateid *stp;
 	struct net *net =3D SVC_NET(rqstp);
 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
+	bool need_move_to_close_list;
=20
 	dprintk("NFSD: nfsd4_close on file %pd\n",=20
 			cstate->current_fh.fh_dentry);
@@ -7114,8 +7115,10 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
 	 */
 	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
=20
-	nfsd4_close_open_stateid(stp);
+	need_move_to_close_list =3D nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
+	if (need_move_to_close_list)
+		move_to_close_lru(stp, net);
=20
 	/* v4.1+ suggests that we send a special stateid in here, since the
 	 * clients should just ignore this anyway. Since this is not useful
--=20
2.43.0


