Return-Path: <linux-nfs+bounces-1173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABD82FF63
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 04:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C01A1C23802
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jan 2024 03:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AB4687;
	Wed, 17 Jan 2024 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="inPcASgN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k5nFZP2w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="inPcASgN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k5nFZP2w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6567C7D
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jan 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463293; cv=none; b=NiQtqy6hUkarRrS+/sUTTg9JHvLBSzKUeGU4zmHUTy2pJZ3TVILx35RKsBx97rUx9J84odr8lp6JRhVUW8vH2+lEcpTTF2i48ORLDnZaF7k62OhdWwfBqxrc+CUKVRi7Wt+YwVMRvBXMX6CNumqoiK+m6kAMhLwrbWUHZL4uP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463293; c=relaxed/simple;
	bh=jbfNK7TMmthbVxmLxcFxVdSVGX40YRE2Is+O8hW+3f4=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From:To:Cc:Subject:Date:
	 Message-id:X-Spam-Level:X-Rspamd-Server:X-Spamd-Result:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=FuspTNODUKdHFRUDylxUIxWn4pESzySE9Q3+8z4Bv8MGejinVJ+hCuvKLO1ltyOIXHU2EEpXe/GfMcnUbxz1jb1MEQAa+9LgIwQAaajQhTaSQXQ2EA1yPqkOoz8oTbd7rVQpiVfGb9nRIaUdR4qunBW4f05CdzohkDlQfSx9sQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=inPcASgN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k5nFZP2w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=inPcASgN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k5nFZP2w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50F4C1FB77;
	Wed, 17 Jan 2024 03:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705463289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tfsvaCOMNvCFUTf0EtjpBgzTHSnB8oQx0CHJF9P66lQ=;
	b=inPcASgNt40hm/DRH5+s/kg2daU6boRFNb0f5WGWmE4v8lpmhw9h8+xp5z46SeLkrTCkiS
	iCm6hmPD6TO1Z/r3TY8W4jHE6M9BEIW4rk04PMbSrUqVeBJE7KJYPhsBQydjO/Gehbuobl
	y9hrZIm7+zcuHLpbAupVuzLJwFxFXyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705463289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tfsvaCOMNvCFUTf0EtjpBgzTHSnB8oQx0CHJF9P66lQ=;
	b=k5nFZP2wjJ6EwdEqUcLTY+IL4xhygfmmKtG33MFehQK4ES8aXpuD44oAh6KjssQKZXGlWM
	w2yIWx13fXf2YPDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705463289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tfsvaCOMNvCFUTf0EtjpBgzTHSnB8oQx0CHJF9P66lQ=;
	b=inPcASgNt40hm/DRH5+s/kg2daU6boRFNb0f5WGWmE4v8lpmhw9h8+xp5z46SeLkrTCkiS
	iCm6hmPD6TO1Z/r3TY8W4jHE6M9BEIW4rk04PMbSrUqVeBJE7KJYPhsBQydjO/Gehbuobl
	y9hrZIm7+zcuHLpbAupVuzLJwFxFXyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705463289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tfsvaCOMNvCFUTf0EtjpBgzTHSnB8oQx0CHJF9P66lQ=;
	b=k5nFZP2wjJ6EwdEqUcLTY+IL4xhygfmmKtG33MFehQK4ES8aXpuD44oAh6KjssQKZXGlWM
	w2yIWx13fXf2YPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF5391372E;
	Wed, 17 Jan 2024 03:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uYmQKPZNp2UpRgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 17 Jan 2024 03:48:06 +0000
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
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: drop st_mutex and rp_mutex before calling
 move_to_close_lru()
Date: Wed, 17 Jan 2024 14:48:04 +1100
Message-id: <170546328406.23031.11217818844350800811@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=inPcASgN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k5nFZP2w
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 50F4C1FB77
X-Spam-Flag: NO


move_to_close_lru() is currently called with ->st_mutex and .rp_mutex held.
This can lead to a deadlock as move_to_close_lru() waits for sc_count to
drop to 2, and some threads holding a reference might be waiting for either
mutex.  These references will never be dropped so sc_count will never
reach 2.

There can be no harm in dropping ->st_mutex to before
move_to_close_lru() because the only place that takes the mutex is
nfsd4_lock_ol_stateid(), and it quickly aborts if sc_type is
NFS4_CLOSED_STID, which it will be before move_to_close_lru() is called.

Similarly dropping .rp_mutex is safe after the state is closed and so
no longer usable.  Another way to look at this is that nothing
significant happens between when nfsd4_close() now calls
nfsd4_cstate_clear_replay(), and where nfsd4_proc_compound calls
nfsd4_cstate_clear_replay() a little later.

See also
 https://lore.kernel.org/lkml/4dd1fe21e11344e5969bb112e954affb@jd.com/T/
where this problem was raised but not successfully resolved.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40415929e2ae..0850191f9920 100644
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
@@ -7114,8 +7115,17 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
 	 */
 	nfs4_inc_and_copy_stateid(&close->cl_stateid, &stp->st_stid);
=20
-	nfsd4_close_open_stateid(stp);
+	need_move_to_close_list =3D nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
+	if (need_move_to_close_list) {
+		/* Drop the replay mutex early as move_to_close_lru()
+		 * can wait for other threads which hold that mutex.
+		 * This call is idempotent, so that fact that it will
+		 * be called twice is harmless.
+		 */
+		nfsd4_cstate_clear_replay(cstate);
+		move_to_close_lru(stp, net);
+	}
=20
 	/* v4.1+ suggests that we send a special stateid in here, since the
 	 * clients should just ignore this anyway. Since this is not useful
--=20
2.43.0


