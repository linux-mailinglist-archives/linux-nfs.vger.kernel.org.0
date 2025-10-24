Return-Path: <linux-nfs+bounces-15612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D514C07733
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A166B35CEF7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D94331A70;
	Fri, 24 Oct 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UpglEzIA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SniU0pJL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XE2a/q4S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TXQkz3+U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A25342C93
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325430; cv=none; b=jUthWBaI70OmQqap8N3pOwE+fw+SY0TQpwLlyRw0yqVTIMQmO028BJS8F/dCIa81pTsW0dMPo6L7e3akfN1aupVx0UspKGUDIu+ihDuhhmJWWLcnVbErRX2JflV2D3Icy/31SPOAmD5YOzS9RaBukyINCl39RsxcETnHQQ3Gh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325430; c=relaxed/simple;
	bh=kOeZy4XrxX/OQF/NYiLWwv4j3bKFa4VTbOwUAfntGVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZ4RfpOeNABByYpRuFAPd3E7TRANnUG/THhwT3jA/F8YuJ6xovSZWyqc4BKxxQ3E45k4Zm+97Vab7/5dCOtcnGFTjCwNM3YMCGFtV7fWaVrIq7/6IiRFBQGc9ilN+KF34RR28IxTURz+Mz945BWvRSte7who+olXcfsfwez9ETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UpglEzIA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SniU0pJL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XE2a/q4S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TXQkz3+U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F84C1F456;
	Fri, 24 Oct 2025 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761325424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bT/u/s2WzIK0gsvAlZVPPRNwD/KklBMJ7unEXy2mjSw=;
	b=UpglEzIAstFP2sz0UFRm9e7M322wvvuIy4Tvz0MxXiPot/69ZQ2j7oU2u3BrGk1WtF3vEz
	WjFcwf5PN5csC/0tFCHhO5APz2t3uKMws1Y3OZF8QEIdW3SnCz+Xx/PLm4rMjf9Y7fbdUL
	LQOeffDzO/nQFutHFz1kY/f20bZPKg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761325424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bT/u/s2WzIK0gsvAlZVPPRNwD/KklBMJ7unEXy2mjSw=;
	b=SniU0pJLp/er/QixnefFQewIleAkWAfcRUMQg2kFR5CZJNJCC1YjM/3mz0JOn8ssCaGlhd
	oFx374BfM0+m7rBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="XE2a/q4S";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TXQkz3+U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761325423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bT/u/s2WzIK0gsvAlZVPPRNwD/KklBMJ7unEXy2mjSw=;
	b=XE2a/q4S5DnUNUU3NhBIguz2qCuD4PxqmkXDt/AktD4lrlIYPc1j0INDbkQx15OWxDma28
	mxVmDN0BbxpQg0uh8Z8a6eTIFwXgfoYk2NABHsYsK6dfBW8CgY5qjvCqnSJFLg3GhHOQFK
	mZ/93mHLOmgqkPSJs6d4NYotJbxq2zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761325423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bT/u/s2WzIK0gsvAlZVPPRNwD/KklBMJ7unEXy2mjSw=;
	b=TXQkz3+U2mgVeKt3Hw3yZmmy1Ov25tyXZFrDypRChUUhDw8pgvO8GAucP3F9v91ZMwZrb1
	tPIhfYBfbdNgqCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42CA613693;
	Fri, 24 Oct 2025 17:03:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n7dZD2+x+2iMWAAAD6G6ig
	(envelope-from <akumar@suse.de>); Fri, 24 Oct 2025 17:03:43 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Cc: ailiopoulos@suse.com,
	pvorel@suse.cz,
	steved@redhat.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: use nfs version 4.0, including the minorversion
Date: Fri, 24 Oct 2025 19:03:41 +0200
Message-ID: <20251024170342.21084-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4F84C1F456
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

If no specific minorversion is specified, it autonegotiates to highest available
version and test end up executing on v4.2 [1]

$ nfslock01.sh -v 4 -t tcp
results in

/dev/loop2 /tmp/LTP_nfslock01.8VNHIljpxG/mntpoint ext4 rw,seclabel,relatime 0 0
10.0.0.2:/tmp/LTP_nfslock01.8VNHIljpxG/mntpoint/4/tcp /tmp/LTP_nfslock01.8VNHIljpxG/4/0 nfs4 rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,fatal_neterrors=ENETDOWN:ENETUNREACH,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.0.0.1,local_lock=none,addr=10.0.0.2 0 0

[1] https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=blob;f=utils/mount/stropts.c;h=23f0a8c0e6f277440bae51f9c7b62900d9bdc76c;hb=HEAD#l127

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 runtest/net.nfs | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index fef993da8..5d6adaa70 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -4,126 +4,126 @@
 #
 nfs01_v30_ip4u nfs01.sh -v 3 -t udp
 nfs01_v30_ip4t nfs01.sh -v 3 -t tcp
-nfs01_v40_ip4t nfs01.sh -v 4 -t tcp
+nfs01_v40_ip4t nfs01.sh -v 4.0 -t tcp
 nfs01_v41_ip4t nfs01.sh -v 4.1 -t tcp
 nfs01_v42_ip4t nfs01.sh -v 4.2 -t tcp
 nfs01_v30_ip6u nfs01.sh -6 -v 3 -t udp
 nfs01_v30_ip6t nfs01.sh -6 -v 3 -t tcp
-nfs01_v40_ip6t nfs01.sh -6 -v 4 -t tcp
+nfs01_v40_ip6t nfs01.sh -6 -v 4.0 -t tcp
 nfs01_v41_ip6t nfs01.sh -6 -v 4.1 -t tcp
 nfs01_v42_ip6t nfs01.sh -6 -v 4.2 -t tcp
 
 nfs02_v30_ip4u nfs02.sh -v 3 -t udp
 nfs02_v30_ip4t nfs02.sh -v 3 -t tcp
-nfs02_v40_ip4t nfs02.sh -v 4 -t tcp
+nfs02_v40_ip4t nfs02.sh -v 4.0 -t tcp
 nfs02_v41_ip4t nfs02.sh -v 4.1 -t tcp
 nfs02_v42_ip4t nfs02.sh -v 4.2 -t tcp
 nfs02_v30_ip6u nfs02.sh -6 -v 3 -t udp
 nfs02_v30_ip6t nfs02.sh -6 -v 3 -t tcp
-nfs02_v40_ip6t nfs02.sh -6 -v 4 -t tcp
+nfs02_v40_ip6t nfs02.sh -6 -v 4.0 -t tcp
 nfs02_v41_ip6t nfs02.sh -6 -v 4.1 -t tcp
 nfs02_v42_ip6t nfs02.sh -6 -v 4.2 -t tcp
 
 nfs03_v30_ip4u nfs03.sh -v 3 -t udp
 nfs03_v30_ip4t nfs03.sh -v 3 -t tcp
-nfs03_v40_ip4t nfs03.sh -v 4 -t tcp
+nfs03_v40_ip4t nfs03.sh -v 4.0 -t tcp
 nfs03_v41_ip4t nfs03.sh -v 4.1 -t tcp
 nfs03_v42_ip4t nfs03.sh -v 4.2 -t tcp
 nfs03_v30_ip6u nfs03.sh -6 -v 3 -t udp
 nfs03_v30_ip6t nfs03.sh -6 -v 3 -t tcp
-nfs03_v40_ip6t nfs03.sh -6 -v 4 -t tcp
+nfs03_v40_ip6t nfs03.sh -6 -v 4.0 -t tcp
 nfs03_v41_ip6t nfs03.sh -6 -v 4.1 -t tcp
 nfs03_v42_ip6t nfs03.sh -6 -v 4.2 -t tcp
 
 nfs04_v30_ip4u nfs04.sh -v 3 -t udp
 nfs04_v30_ip4t nfs04.sh -v 3 -t tcp
-nfs04_v40_ip4t nfs04.sh -v 4 -t tcp
+nfs04_v40_ip4t nfs04.sh -v 4.0 -t tcp
 nfs04_v41_ip4t nfs04.sh -v 4.1 -t tcp
 nfs04_v42_ip4t nfs04.sh -v 4.2 -t tcp
 nfs04_v30_ip6u nfs04.sh -6 -v 3 -t udp
 nfs04_v30_ip6t nfs04.sh -6 -v 3 -t tcp
-nfs04_v40_ip6t nfs04.sh -6 -v 4 -t tcp
+nfs04_v40_ip6t nfs04.sh -6 -v 4.0 -t tcp
 nfs04_v41_ip6t nfs04.sh -6 -v 4.1 -t tcp
 nfs04_v42_ip6t nfs04.sh -6 -v 4.2 -t tcp
 
 nfs05_v30_ip4u nfs05.sh -v 3 -t udp
 nfs05_v30_ip4t nfs05.sh -v 3 -t tcp
-nfs05_v40_ip4t nfs05.sh -v 4 -t tcp
+nfs05_v40_ip4t nfs05.sh -v 4.0 -t tcp
 nfs05_v41_ip4t nfs05.sh -v 4.1 -t tcp
 nfs05_v42_ip4t nfs05.sh -v 4.2 -t tcp
 nfs05_v30_ip6u nfs05.sh -6 -v 3 -t udp
 nfs05_v30_ip6t nfs05.sh -6 -v 3 -t tcp
-nfs05_v40_ip6t nfs05.sh -6 -v 4 -t tcp
+nfs05_v40_ip6t nfs05.sh -6 -v 4.0 -t tcp
 nfs05_v41_ip6t nfs05.sh -6 -v 4.1 -t tcp
 nfs05_v42_ip6t nfs05.sh -6 -v 4.2 -t tcp
 
-nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
+nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4.0,4.0,4.0" -t "udp,udp,tcp,tcp,tcp,tcp"
 nfs06_vall_ip4t nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 nfs06_v4x_ip6t nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
 nfs07_v30_ip4u nfs07.sh -v 3 -t udp
 nfs07_v30_ip4t nfs07.sh -v 3 -t tcp
-nfs07_v40_ip4t nfs07.sh -v 4 -t tcp
+nfs07_v40_ip4t nfs07.sh -v 4.0 -t tcp
 nfs07_v41_ip4t nfs07.sh -v 4.1 -t tcp
 nfs07_v42_ip4t nfs07.sh -v 4.2 -t tcp
 nfs07_v30_ip6u nfs07.sh -6 -v 3 -t udp
 nfs07_v30_ip6t nfs07.sh -6 -v 3 -t tcp
-nfs07_v40_ip6t nfs07.sh -6 -v 4 -t tcp
+nfs07_v40_ip6t nfs07.sh -6 -v 4.0 -t tcp
 nfs07_v41_ip6t nfs07.sh -6 -v 4.1 -t tcp
 nfs07_v42_ip6t nfs07.sh -6 -v 4.2 -t tcp
 
 nfs08_v30_ip4u nfs08.sh -v 3 -t udp
 nfs08_v30_ip4t nfs08.sh -v 3 -t tcp
-nfs08_v40_ip4t nfs08.sh -v 4 -t tcp
+nfs08_v40_ip4t nfs08.sh -v 4.0 -t tcp
 nfs08_v41_ip4t nfs08.sh -v 4.1 -t tcp
 nfs08_v42_ip4t nfs08.sh -v 4.2 -t tcp
 nfs08_v30_ip6u nfs08.sh -6 -v 3 -t udp
 nfs08_v30_ip6t nfs08.sh -6 -v 3 -t tcp
-nfs08_v40_ip6t nfs08.sh -6 -v 4 -t tcp
+nfs08_v40_ip6t nfs08.sh -6 -v 4.0 -t tcp
 nfs08_v41_ip6t nfs08.sh -6 -v 4.1 -t tcp
 nfs08_v42_ip6t nfs08.sh -6 -v 4.2 -t tcp
 
 nfs09_v30_ip4u nfs09.sh -v 3 -t udp
 nfs09_v30_ip4t nfs09.sh -v 3 -t tcp
-nfs09_v40_ip4t nfs09.sh -v 4 -t tcp
+nfs09_v40_ip4t nfs09.sh -v 4.0 -t tcp
 nfs09_v41_ip4t nfs09.sh -v 4.1 -t tcp
 nfs09_v42_ip4t nfs09.sh -v 4.2 -t tcp
 nfs09_v30_ip6u nfs09.sh -6 -v 3 -t udp
 nfs09_v30_ip6t nfs09.sh -6 -v 3 -t tcp
-nfs09_v40_ip6t nfs09.sh -6 -v 4 -t tcp
+nfs09_v40_ip6t nfs09.sh -6 -v 4.0 -t tcp
 nfs09_v41_ip6t nfs09.sh -6 -v 4.1 -t tcp
 nfs09_v42_ip6t nfs09.sh -6 -v 4.2 -t tcp
 
 nfs10_v30_ip4u nfs10.sh -v 3 -t udp
 nfs10_v30_ip4t nfs10.sh -v 3 -t tcp
-nfs10_v40_ip4t nfs10.sh -v 4 -t tcp
+nfs10_v40_ip4t nfs10.sh -v 4.0 -t tcp
 nfs10_v41_ip4t nfs10.sh -v 4.1 -t tcp
 nfs10_v42_ip4t nfs10.sh -v 4.2 -t tcp
 nfs10_v30_ip6u nfs10.sh -6 -v 3 -t udp
 nfs10_v30_ip6t nfs10.sh -6 -v 3 -t tcp
-nfs10_v40_ip6t nfs10.sh -6 -v 4 -t tcp
+nfs10_v40_ip6t nfs10.sh -6 -v 4.0 -t tcp
 nfs10_v41_ip6t nfs10.sh -6 -v 4.1 -t tcp
 nfs10_v42_ip6t nfs10.sh -6 -v 4.2 -t tcp
 
 nfslock01_v30_ip4u nfslock01.sh -v 3 -t udp
 nfslock01_v30_ip4t nfslock01.sh -v 3 -t tcp
-nfslock01_v40_ip4t nfslock01.sh -v 4 -t tcp
+nfslock01_v40_ip4t nfslock01.sh -v 4.0 -t tcp
 nfslock01_v41_ip4t nfslock01.sh -v 4.1 -t tcp
 nfslock01_v42_ip4t nfslock01.sh -v 4.2 -t tcp
 nfslock01_v30_ip6u nfslock01.sh -6 -v 3 -t udp
 nfslock01_v30_ip6t nfslock01.sh -6 -v 3 -t tcp
-nfslock01_v40_ip6t nfslock01.sh -6 -v 4 -t tcp
+nfslock01_v40_ip6t nfslock01.sh -6 -v 4.0 -t tcp
 nfslock01_v41_ip6t nfslock01.sh -6 -v 4.1 -t tcp
 nfslock01_v42_ip6t nfslock01.sh -6 -v 4.2 -t tcp
 
 nfsstat01_v30_ip4u nfsstat01.sh -v 3 -t udp
 nfsstat01_v30_ip4t nfsstat01.sh -v 3 -t tcp
-nfsstat01_v40_ip4t nfsstat01.sh -v 4 -t tcp
+nfsstat01_v40_ip4t nfsstat01.sh -v 4.0 -t tcp
 nfsstat01_v41_ip4t nfsstat01.sh -v 4.1 -t tcp
 nfsstat01_v42_ip4t nfsstat01.sh -v 4.2 -t tcp
 nfsstat01_v30_ip6u nfsstat01.sh -6 -v 3 -t udp
 nfsstat01_v30_ip6t nfsstat01.sh -6 -v 3 -t tcp
-nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
+nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4.0 -t tcp
 nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
 nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp
 
@@ -131,11 +131,11 @@ nfsstat02 nfsstat02.sh
 
 fsx_v30_ip4u fsx.sh -v 3 -t udp
 fsx_v30_ip4t fsx.sh -v 3 -t tcp
-fsx_v40_ip4t fsx.sh -v 4 -t tcp
+fsx_v40_ip4t fsx.sh -v 4.0 -t tcp
 fsx_v41_ip4t fsx.sh -v 4.1 -t tcp
 fsx_v42_ip4t fsx.sh -v 4.2 -t tcp
 fsx_v30_ip6u fsx.sh -6 -v 3 -t udp
 fsx_v30_ip6t fsx.sh -6 -v 3 -t tcp
-fsx_v40_ip6t fsx.sh -6 -v 4 -t tcp
+fsx_v40_ip6t fsx.sh -6 -v 4.0 -t tcp
 fsx_v41_ip6t fsx.sh -6 -v 4.1 -t tcp
 fsx_v42_ip6t fsx.sh -6 -v 4.2 -t tcp
-- 
2.51.0


