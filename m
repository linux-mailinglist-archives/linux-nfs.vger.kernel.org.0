Return-Path: <linux-nfs+bounces-11873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBDAC225B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CEDA43A52
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005822B5A3;
	Fri, 23 May 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xpSobNdp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B5I7E2fH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xpSobNdp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B5I7E2fH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DB23535B
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002208; cv=none; b=MsHqLGRbCcNxeSycPKmmNjPNLpiQM/MdGcUQwQh2KaU6Gv32AVRsedbwcJy/q94BlUu70W87D1IoLf0XxqW7Blebs3hclVmj1F0opXmK7QYwt/LA9RxxDQEWIrkHGtZQOJJXP2dPn+Ui/CKKscryJwLhDXRxnlf6ms2NU+fJDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002208; c=relaxed/simple;
	bh=2apjwt/EGa3rwNBeH7T6oHO9deqXpOdNjAIwUVY5+Z4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=go9M/BxXjl7fKa0EA7ZkKg/zPHztSWrCQl5DoAH48uoCnzdKgKhDkDY2lkXRsVGl+Ed2Y8sIGvIVJixvY4uFf2+qQcYYb8e+eApJ3WCBMO7EUWxP5uz96qzUwuti2WguBW8883Ai9D+zwP/bbZ29eq0J1a4Y5VhwlJIXAHTzdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xpSobNdp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B5I7E2fH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xpSobNdp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B5I7E2fH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1929621BFA;
	Fri, 23 May 2025 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748002204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oa0an+Q6U2k/kOogtft4u+KOHqSzjK04aZoqM1uKk3A=;
	b=xpSobNdpeKV2RBw4NmR8g8Zlb0Ay9R6p9XBMqEtD8A7lMN/Gc4tUp6FkaO/QyJUrLqCU+R
	h8G89/Eo/b7o0T06uekONQbhoH6W7mNgRam3LcHHQEg47js6/qMQH3PzNIeRPjm3laRCzW
	9lmth6oq4KPVqh3cV6OknQoptVCPsF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748002204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oa0an+Q6U2k/kOogtft4u+KOHqSzjK04aZoqM1uKk3A=;
	b=B5I7E2fH9XpbCTaejq9BBLwgySksQsBR7TZzjoxZYNOx9yznoBbzo1+Gbs74Sfc4iKAFNW
	yHSB94VvU5TEocDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xpSobNdp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B5I7E2fH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748002204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oa0an+Q6U2k/kOogtft4u+KOHqSzjK04aZoqM1uKk3A=;
	b=xpSobNdpeKV2RBw4NmR8g8Zlb0Ay9R6p9XBMqEtD8A7lMN/Gc4tUp6FkaO/QyJUrLqCU+R
	h8G89/Eo/b7o0T06uekONQbhoH6W7mNgRam3LcHHQEg47js6/qMQH3PzNIeRPjm3laRCzW
	9lmth6oq4KPVqh3cV6OknQoptVCPsF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748002204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oa0an+Q6U2k/kOogtft4u+KOHqSzjK04aZoqM1uKk3A=;
	b=B5I7E2fH9XpbCTaejq9BBLwgySksQsBR7TZzjoxZYNOx9yznoBbzo1+Gbs74Sfc4iKAFNW
	yHSB94VvU5TEocDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA4B71336F;
	Fri, 23 May 2025 12:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2dGgHpplMGgZbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 23 May 2025 12:10:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@suse.de>
To: openembedded-core@lists.openembedded.org
Cc: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH OE-core] nfs-utils: don't use signals to shut down nfs server.
Date: Fri, 23 May 2025 17:41:19 +1000
Message-id: <174800219540.608730.11726448273017682287@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 1929621BFA
X-Spam-Level: 
X-Spam-Flag: NO


Since Linux v2.4 it has been possible to stop all NFS server by running

   rpc.nfsd 0

i.e.  by requesting that zero threads be running.  This is preferred as
it doesn't risk killing some other process which happens to be called
"nfsd".

Since Linux v6.6 - and other stable kernels to which

  Commit: 390390240145 ("nfsd: don't allow nfsd threads to be
  signalled.")

has been backported - sending a signal no longer works to stop nfs server
threads.

This patch changes the nfsserver script to use "rpc.nfsd 0" to stop
server threads.

Signed-off-by: NeilBrown <neil@brown.name>
---
 .../nfs-utils/nfs-utils/nfsserver             | 28 +++----------------
 1 file changed, 4 insertions(+), 24 deletions(-)

Resending with different From: address because first attempt was bounced
as spam

  openembedded-core@lists.openembedded.org
    host lb01.groups.io [45.79.81.153]
    SMTP error from remote mail server after end of data:
    500 This message has been flagged as spam.


diff --git a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver b/meta/r=
ecipes-connectivity/nfs-utils/nfs-utils/nfsserver
index cb6c1b4d08d8..99ec280b3594 100644
--- a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
+++ b/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
@@ -89,34 +89,14 @@ start_nfsd(){
 	start-stop-daemon --start --exec "$NFS_NFSD" -- "$@"
 	echo done
 }
-delay_nfsd(){
-	for delay in 0 1 2 3 4 5 6 7 8 9=20
-	do
-		if pidof nfsd >/dev/null
-		then
-			echo -n .
-			sleep 1
-		else
-			return 0
-		fi
-	done
-	return 1
-}
 stop_nfsd(){
-	# WARNING: this kills any process with the executable
-	# name 'nfsd'.
 	echo -n 'stopping nfsd: '
-	start-stop-daemon --stop --quiet --signal 1 --name nfsd
-	if delay_nfsd || {
-		echo failed
-		echo ' using signal 9: '
-		start-stop-daemon --stop --quiet --signal 9 --name nfsd
-		delay_nfsd
-	}
+	$NFS_NFSD 0
+	if pidof nfsd
 	then
-		echo done
-	else
 		echo failed
+	else
+		echo done
 	fi
 }
=20
--=20
2.49.0


