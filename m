Return-Path: <linux-nfs+bounces-7518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D49B20F6
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 23:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC40E1C206A8
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Oct 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5483C17995E;
	Sun, 27 Oct 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VxYWoBt5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DpbB1Zxq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VxYWoBt5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DpbB1Zxq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F327442
	for <linux-nfs@vger.kernel.org>; Sun, 27 Oct 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730066708; cv=none; b=fOQoOP5WN97KIhZu5tRHXaqR8PuJ08GpOREPpCs93gPVm29QXkZvP6aP2PWb667y063OKcP7tvXrThVS6PlX+Iroq9MRikqDWmxWKV9dTOCssx/67h53onalJxNKJSJNWNljRMjiJ7M3lQL0K+ZDbYBKBdSXbT6M8qZEzuKXgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730066708; c=relaxed/simple;
	bh=iXTCgXipkCxKUFFRtWUgDuYZqsUsg1XIpzchdi0f4g8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=rqGt9PSGHT9P6YNlPoIVFKAyfAgleizaqmm8/rpE5sIuJK+SC1nvisGUgVSA2yjqEOs70AKBYolXQSWd9rQtXzXdpQIVi1s8xg4uqAi0rT/DfGNDG6LjpBPF3tTcIH6Y0JYtxHeMf2g0V2ICME691eu/QtbkqQgfje0dZiFP4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VxYWoBt5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DpbB1Zxq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VxYWoBt5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DpbB1Zxq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39E2421EBD;
	Sun, 27 Oct 2024 22:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730066704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wEVJwLZOHLLuSBt/TgbkaSkWaMsNWcrioKSdVcklUto=;
	b=VxYWoBt5A0sUlIZpvsCgQjLRIwTE4CzpycDNOQC9/5Eolh7dj8ghnKRFkSBI3mk8+vWGKn
	fCnIyZEju+EDXTAcVKCzVsaRV6K04j8r0J6EKpEqd5D1x1skdNzIqhZ0VsP95TnZMMWsmi
	PTDd0uhUmT7CALDPmMNs3ImVNzIiEYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730066704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wEVJwLZOHLLuSBt/TgbkaSkWaMsNWcrioKSdVcklUto=;
	b=DpbB1Zxq52yz6caw4fDbMY2ZQNA5PVmoGfXhDWNxB2ndTGY9QB1NvlNtr69cKyDWS5ZcYo
	O6YqUIpf/XIU2RAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730066704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wEVJwLZOHLLuSBt/TgbkaSkWaMsNWcrioKSdVcklUto=;
	b=VxYWoBt5A0sUlIZpvsCgQjLRIwTE4CzpycDNOQC9/5Eolh7dj8ghnKRFkSBI3mk8+vWGKn
	fCnIyZEju+EDXTAcVKCzVsaRV6K04j8r0J6EKpEqd5D1x1skdNzIqhZ0VsP95TnZMMWsmi
	PTDd0uhUmT7CALDPmMNs3ImVNzIiEYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730066704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wEVJwLZOHLLuSBt/TgbkaSkWaMsNWcrioKSdVcklUto=;
	b=DpbB1Zxq52yz6caw4fDbMY2ZQNA5PVmoGfXhDWNxB2ndTGY9QB1NvlNtr69cKyDWS5ZcYo
	O6YqUIpf/XIU2RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D03F6136C7;
	Sun, 27 Oct 2024 22:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1m1LIQ25HmdlBQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 27 Oct 2024 22:05:01 +0000
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
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH] nfsd: make use of warning provided by refcount_t
Date: Mon, 28 Oct 2024 09:04:43 +1100
Message-id: <173006668387.81717.13494809143579612819@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.970];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.29
X-Spam-Flag: NO


refcount_t, by design, checks for unwanted situations and provides
warnings.  It is rarely useful to have explicit warnings with refcount
usage.

In this case we have an explicit warning if a refcount_t reaches zero
when decremented.  Simply using refcount_dec() will provide a similar
warning and also mark the refcount_t as saturated to avoid any possible
use-after-free.

This patch drops the warning and uses refcount_dec() instead of
refcount_dec_and_test().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1408166222c5..c16671135d17 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1050,7 +1050,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net=
 *net,
 		 * the last one however, since we should hold another.
 		 */
 		if (nfsd_file_lru_remove(nf))
-			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
+			refcount_dec(&nf->nf_ref);
 		goto wait_for_construction;
 	}
=20

base-commit: 7fa861d5df402b2327f45e0240c1b842f71fec11
--=20
2.46.0


