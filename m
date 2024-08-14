Return-Path: <linux-nfs+bounces-5348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23B9517C1
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F80283E24
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21B14A088;
	Wed, 14 Aug 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EcBNECJk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qV/9a5/T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EcBNECJk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qV/9a5/T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E63149C6E;
	Wed, 14 Aug 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628020; cv=none; b=kx/yf7owjUE/TPxm//oyyWN2z7Hmtqa6shbwT2q/rUt+V+qW/bvnDv1T/EUx2oyYUPuc3KnJpzTr6jY7Su0YsaxAWgSGa7Qwfpj/8SUJUI/rV1WcoHAhbXxXpSkf8gifzJBjqOD9xow9HAZg7DwnFYQDEy/cDvhsCQljLlitQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628020; c=relaxed/simple;
	bh=s7oN0Z48Kg8PWcmO3xdWsXRQV7obhRA8qPW1uEIgD14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqzzfwEFapLAYBkedNXwW1kCaU64Qmp1qor3jxDdAeB+LMu0//8xT7R8yb0nfzLNh/OEKo3EHyCE+S6tItHcD6naB0fnM1XIViMVgCUpIXkYZBEkiGh8zJrmkErEA//cx0uM+FxOMS4+jY6UVnnGdz4306d04O9qcNw6fS4/enU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EcBNECJk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qV/9a5/T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EcBNECJk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qV/9a5/T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE1FF1FE84;
	Wed, 14 Aug 2024 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723628016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
	b=EcBNECJkunPEwB6NgrF64fglWkog6OrjXafUtcT+5xVbmmFEBbzt6KiORVgSsIU7TSykqf
	0ukuJrim9W4uh6F3RvkhZova/76S4tHmKO/jhAQv20JsmpYdBb9Zr00a0NEJepGbo7v+ka
	juMt1+Z4iI5S3mcBZ+KbvtiQ5Argjbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723628016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
	b=qV/9a5/T8nX/rhE8qAQfz7v+ExUmetnwb5TvAT+cx+Ot3wfnN0RmkgyUUVFbkkGXzD6T9X
	tngrNSfBl4wHf7BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723628016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
	b=EcBNECJkunPEwB6NgrF64fglWkog6OrjXafUtcT+5xVbmmFEBbzt6KiORVgSsIU7TSykqf
	0ukuJrim9W4uh6F3RvkhZova/76S4tHmKO/jhAQv20JsmpYdBb9Zr00a0NEJepGbo7v+ka
	juMt1+Z4iI5S3mcBZ+KbvtiQ5Argjbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723628016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
	b=qV/9a5/T8nX/rhE8qAQfz7v+ExUmetnwb5TvAT+cx+Ot3wfnN0RmkgyUUVFbkkGXzD6T9X
	tngrNSfBl4wHf7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11E5013B1A;
	Wed, 14 Aug 2024 08:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9+FTAnlxvGYqagAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 08:57:29 +0000
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
Subject: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Date: Wed, 14 Aug 2024 10:57:21 +0200
Message-ID: <20240814085721.518800-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
	RCVD_TLS_ALL(0.00)[]

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


