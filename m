Return-Path: <linux-nfs+bounces-6495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15BC979999
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 01:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCC5283506
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080973501;
	Sun, 15 Sep 2024 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WSaWbA3f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KO+0elNI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WSaWbA3f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KO+0elNI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F38BFC
	for <linux-nfs@vger.kernel.org>; Sun, 15 Sep 2024 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726443958; cv=none; b=mlVn8oZjK1FTuOYhExGwWG9jxt+N7ROg/gzBdQG2wihbjMHcVQRLnhgMQBznvTkzKpemd7yB7sUSpmFOb6+LZqU1ddK+50oqVjZ70C6g6ezIhNMgr2+ZpSeNFNcNfLbahzHVuXfndixJg5Qo8jVI2nSkTTc/RdgZM38eVdu2xWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726443958; c=relaxed/simple;
	bh=hYVWwqtD6RE1dlr32LvoIfZDjOZFKQT3mPSSJmUSSAE=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-id; b=rVZ1BWYvZrCH/cySR3hNrzi2buC+4nDzCjZ00G9ilkujkOhN9ulF4RJ8KgzKdcQmEa51EHG5PujvcstoK026LpA/jDOItNZNHeq6biJqam9bFZ2eyYY9pybg1pfTsekO6Qx7OLAHZEPaZdUy2H64ariS0RuW3XxKrd7UPa5sm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WSaWbA3f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KO+0elNI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WSaWbA3f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KO+0elNI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E08A21BE1;
	Sun, 15 Sep 2024 23:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726443954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ygXuFCcsp1UjN3WcD1pzB+EyYOf+ehNOQxvoehg9dDc=;
	b=WSaWbA3fSA7Ue7Rz37p4aNbjQ1rt/OTvdZrWOiW1uwvGXjXHV0ZEzmMjNrmA4vpLEGo4gO
	dxBXRvPvFEkyyNqUjsMam7NLuRbzwkGBYVT9tOWikbp2y9UHeunpvY2WJLgiWOBp/nkayU
	QmpWTYsay4I1F2SB9yffHRWyBZPvn78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726443954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ygXuFCcsp1UjN3WcD1pzB+EyYOf+ehNOQxvoehg9dDc=;
	b=KO+0elNIe/DRMKL9UUbz2mb48q98GqcJitxi4LJTs07u/EZMZzExRehRnhBm/xO/5cfZAI
	YqMmJ8I+E+ZVUUAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WSaWbA3f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KO+0elNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726443954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ygXuFCcsp1UjN3WcD1pzB+EyYOf+ehNOQxvoehg9dDc=;
	b=WSaWbA3fSA7Ue7Rz37p4aNbjQ1rt/OTvdZrWOiW1uwvGXjXHV0ZEzmMjNrmA4vpLEGo4gO
	dxBXRvPvFEkyyNqUjsMam7NLuRbzwkGBYVT9tOWikbp2y9UHeunpvY2WJLgiWOBp/nkayU
	QmpWTYsay4I1F2SB9yffHRWyBZPvn78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726443954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ygXuFCcsp1UjN3WcD1pzB+EyYOf+ehNOQxvoehg9dDc=;
	b=KO+0elNIe/DRMKL9UUbz2mb48q98GqcJitxi4LJTs07u/EZMZzExRehRnhBm/xO/5cfZAI
	YqMmJ8I+E+ZVUUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A971351A;
	Sun, 15 Sep 2024 23:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1vXcLa9x52Z6NAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 15 Sep 2024 23:45:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever III <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH nfsd-next] SQUASH sunrpc: allow svc threads to fail
 initialisation cleanly
Date: Mon, 16 Sep 2024 09:45:40 +1000
Message-id: <172644394073.17050.16376953609629336068@noble.neil.brown.name>
X-Rspamd-Queue-Id: 6E08A21BE1
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 


The memory barriers in this patch were all wrong.
smp_store_release / smp_load_acquire ensures that all changes written
before the store_release are equally visible after the acquire.
These are not needed here as the *only* value that
svc_thread_init_status() or its caller sets that is of any interest to
svc_start_kthread() is ->rq_err.  The barrier wold effect writes before
->rq_err is written and reads after ->rq_err is read.

However we DO need a full memory barrier between setting ->rq_err and
before the the waitqueue_active() read in wake_up_var().  This is a
barrier between a write and a read, hence a full barrier: smb_mb().

This addresses a race if wait_var_event() adds itself to the wait queue
and tests ->rq_err such that the read in waitqueue_active() happens
earlier and doesn't see that the task has been added, and the ->rq_err
write is delayed so that the waiting task doesn't see it.  In this case
the wake_up never happens.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h | 7 +++++--
 net/sunrpc/svc.c           | 3 +--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 437672bcaa22..558e5ae03103 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -326,8 +326,11 @@ static inline bool svc_thread_should_stop(struct svc_rqs=
t *rqstp)
  */
 static inline void svc_thread_init_status(struct svc_rqst *rqstp, int err)
 {
-	/* store_release ensures svc_start_kthreads() sees the error */
-	smp_store_release(&rqstp->rq_err, err);
+	rqstp->rq_err =3D err;
+	/* memory barrier ensures assignment to error above is visible before
+	 * waitqueue_active() test below completes.
+	 */
+	smb_mb();
 	wake_up_var(&rqstp->rq_err);
 	if (err)
 		kthread_exit(1);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ff6f3e35b36d..9aff845196ce 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -818,8 +818,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool=
 *pool, int nrservs)
 		svc_sock_update_bufs(serv);
 		wake_up_process(task);
=20
-		/* load_acquire ensures we get value stored in svc_thread_init_status() */
-		wait_var_event(&rqstp->rq_err, smp_load_acquire(&rqstp->rq_err) !=3D -EAGA=
IN);
+		wait_var_event(&rqstp->rq_err, rqstp->rq_err !=3D -EAGAIN);
 		err =3D rqstp->rq_err;
 		if (err) {
 			svc_exit_thread(rqstp);
--=20
2.46.0


