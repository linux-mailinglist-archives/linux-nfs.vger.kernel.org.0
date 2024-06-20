Return-Path: <linux-nfs+bounces-4136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29401910242
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 13:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED7C282316
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9D21A19;
	Thu, 20 Jun 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikiNwTH8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ndJ2/yt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="21XZLflu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5cAfdC5P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11731AAE31
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881898; cv=none; b=DIK+yJ3TmngcaMw0gVJNsOG8TcnVAly0obG/qr/kK407Bvo4ek3w4i1xI6vCBMYH2TtYQVU6FrIK43/t+CYe0BKskwOsprz5D8PkSldjKu9Sic3MJIIEI3+Zlc97Pwu3JJrJ+E8nryRkp3lfAnPDm+8x0uQFUx3wJw6XDi8d1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881898; c=relaxed/simple;
	bh=O7faUuKXWUwMoVsZvzkUpLClsIcPw+RyJ8uyjXWxEwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIHxdzq4PN+w7hBJ7LKibqeHzuAurpimrV8n5xw5RCZxqONmXoggdXhyuTKHZzdteRtuMH0bGELcFyw7kefVTxSYuZ6VmQQvsTwNsxZtKKmzIrQ8pdbd9QSUqL6Mlc+wk+Aa5tXIa5vTkT6PFGcEbSm1RT/9bSwzLY680KFABr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikiNwTH8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ndJ2/yt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=21XZLflu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5cAfdC5P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E26871F894;
	Thu, 20 Jun 2024 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718881894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gxfcs1579drPzz17XV/U3Yz94hD4KGMBVn3nc6LXzug=;
	b=ikiNwTH8HBBJRR+7LCvmxzucecI9zKTxhkordot1MLQ+RpgI7h3p7WAnLRIIeGr+y0Zxf4
	ljcDWR/DMnaQYssRD1T8mi0FMj5mtkKZf07xotzsi7sRxhoagdHfkNuY2HmCfzSlZSoTGs
	tw3Q4uUJRYywg0gLG0k7CKqbaY0wOwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718881894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gxfcs1579drPzz17XV/U3Yz94hD4KGMBVn3nc6LXzug=;
	b=5ndJ2/yt7f+JJ39+crX3KSnAzrBDGg8O3bPKUQlF2VrDseh9K065etjDK6ychUCnabJXZp
	kg0CZyABrqV+8sAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718881893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gxfcs1579drPzz17XV/U3Yz94hD4KGMBVn3nc6LXzug=;
	b=21XZLfluRwiLQCDe5FPjFIcpYADQHi/Fs5GFT5/qpb8PZzvf5DbR+QOWRacZ4sKbTo8dNv
	FuUzzCdDnYA8YM0y4i6lGEQOJ4F1q3LznOdNRPNARJJn8aGfQ7wwlBZNdST6gV7v9UkYgx
	kfqX7YfbTXKUKX+DYff53bckcuhuEeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718881893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gxfcs1579drPzz17XV/U3Yz94hD4KGMBVn3nc6LXzug=;
	b=5cAfdC5P+nJJaqkqYex1o88qvaKpwuVgpkkJtiCIdnl1n3Y4zddmSLG+LkPpq5teSzY7xX
	Oz+POlZ8dU/G5nDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2DF21369F;
	Thu, 20 Jun 2024 11:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AacJmUOdGZEGwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 11:11:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Avinesh Kumar <akumar@suse.de>,
	NeilBrown <neilb@suse.de>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Date: Thu, 20 Jun 2024 13:11:29 +0200
Message-ID: <20240620111129.594449-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

6.9 moved client RPC calls to namespace (likely 1548036ef1204 ("nfs:
make the rpc_stat per net namespace") [1]), thus update test.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1548036ef1204df65ca5a16e8b199c858cb80075

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfsstat01/nfsstat01.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index c2856eff1..a12b80fad 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -15,7 +15,12 @@ get_calls()
 	local calls opt
 
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
-	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
+
+	if tst_net_use_netns; then
+		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"
+	else
+		[ "$nfs_f" != "nfs" ] && type="rhost"
+	fi
 
 	if [ "$type" = "lhost" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
-- 
2.45.1


