Return-Path: <linux-nfs+bounces-5347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA09517BB
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B4A288BEF
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA3524B4;
	Wed, 14 Aug 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2eS6Momk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QN1h9ri2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p+MAbl7y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mbarUnHn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734C2901;
	Wed, 14 Aug 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627848; cv=none; b=D4QyWWFa21PTTG3RaA4HzpZEsv/oJJJMPA9hEDZ6ePSCo+1+v3yB2ts7wVDEo9cxOrPlXo6EFiqMS+LEqCgZ1xSfcQ2b1CvaplrS+FXn6CzAi8VkxzFFDCL62qQdrq9hPiWczmLtWu1bB2jdaCL1iB3HVYUuYjuKXPbs++6k6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627848; c=relaxed/simple;
	bh=fp2DiLXDVIBLtdEcoTbUEUC5EL91r8yBBT/D8zigVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGTLS/sehjODjj559WKG0klbjP0QULWUMww+2Z04uXvZl3JrVsEEFdOH/2pYtCBxS5H079ECS//6EGxSR1OHgPwIEUzWDCLkOxPUcfkHrQ1T+liJysQzsOJ9SxIAegKUEXjIaB+16w0b1wCOutsh7hwxFeQvnsvhXLa5gxSQdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2eS6Momk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QN1h9ri2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p+MAbl7y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mbarUnHn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC77D22602;
	Wed, 14 Aug 2024 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723627839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
	b=2eS6MomkNcEHLS3M6CHoYD1Y+zvXCBfm4YPJKOrKBTh8dScxaDE9Zqyx6SW3U5kYx1wtJh
	1usAjrioeCKMW0NU7nG2EaAhdNjflMGKJfVa09MS7iOUe/Gh2NA3UnSIuvx7qafGCHF35d
	BSmAnC8k1O3nB62njKwmwUP1ODfoN7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723627839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
	b=QN1h9ri2Gi/0DEeAFh2lLnXo/ib7lbOqiplbKiYhIw+0pXTQie7JgFpNEy67tM0NXbVgQJ
	CFLET2l4JSAbVNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723627838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
	b=p+MAbl7yIu+yRdOiJX3zkt7KvJjfFj+JG1R1t1mKjj5lcGT4bU7kmcUnrfuzaIHcXwwRos
	F7F43FCZpnqzmDGsN3elbx95/oc9IOKbN1Vm4bXNtxmdotvmUKHrFMvI4XRoHIPbrnra8I
	4Ra9v2JvTel4k6V2lgmS2xFnV+d5HTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723627838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
	b=mbarUnHn2z4Xez2iu4qveIa5m7Th/Ed5ZF7cQGDAWGV7N6K5zGIObDoM51hWIiHrKOrjaw
	c+6b46dJ45P9T9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 600C31348F;
	Wed, 14 Aug 2024 09:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vkRgFT15vGZfdQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 09:30:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Li Wang <liwang@redhat.com>,
	Cyril Hrubis <chrubis@suse.cz>,
	Avinesh Kumar <akumar@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>,
	NeilBrown <neilb@suse.de>,
	stable@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RESEND v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Date: Wed, 14 Aug 2024 11:30:22 +0200
Message-ID: <20240814093022.522534-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -2.80

[ I'm sorry for the noise if you get this patch 2x ]

6.9 moved client RPC calls to namespace in "Make nfs stats visible in
network NS" patchet.

https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Point out whole patchset, not just single commit
* Add a comment about the patchset

Hi all,

could you please ack this so that we have fixed mainline?

FYI Some parts has been backported, e.g.:
d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.

But most of that is not yet (but planned to be backported), e.g.
93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
see Chuck's patchset for 6.6
https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/

Once all kernels up to 5.4 fixed we should update the version.

Kind regards,
Petr

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index c2856eff1f..1beecbec43 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -15,7 +15,14 @@ get_calls()
 	local calls opt
 
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
-	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
+
+	if tst_net_use_netns; then
+		# "Make nfs stats visible in network NS" patchet
+		# https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
+		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"
+	else
+		[ "$nfs_f" != "nfs" ] && type="rhost"
+	fi
 
 	if [ "$type" = "lhost" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
-- 
2.45.2


