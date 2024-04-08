Return-Path: <linux-nfs+bounces-2704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C911789B545
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 03:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A582813CD
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 01:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2FEBB;
	Mon,  8 Apr 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zU6zidt+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uNmwU5kN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dvDuOjuW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eunzIf9z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3FA40
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712539809; cv=none; b=a3QDrnn84s//cwRrc1or28xrydsUKegpNAw6IpwEWn6SUNUWLFdq9uT6Hxj/8TxQMiPa4GCLjV7IKydAyUvM4MxY8PB5gPhDFlJDI+dMtbQPzu2IlJIszTZwW4B7C60QtQDI2rmAxpSozcbVuogF5Rthu935FmYkxBtRhF37v4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712539809; c=relaxed/simple;
	bh=7kTEzQ5w60IEwUpaG+XMSAObFLeg52AXHpnPT6As0ko=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=mLfsBuZLOzQUTzMyqDHGfq6WMmIyLLxC17e6mAM4AfqD3ZBBrsNvfJ2QT+0ZBIVectIqTlDoj67xYbhOc+rZ7JvbSLE+dHDu/FcAlBK1gjBmIKOtto6ShnlxqCKwY/8U2XqpsEDLiwk5VMYoGf4HstniePz/BkWO/cmcspcgaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zU6zidt+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uNmwU5kN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dvDuOjuW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eunzIf9z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6FBD22376;
	Mon,  8 Apr 2024 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712539800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyFQmQ1qRyWFAL3/in35Y8k758Y1us/oIDERyct9plw=;
	b=zU6zidt+eoTNxwjlXxuXtMWUd3QHV8r37v4gd4EADOMDKX3WHV8wIy17vDE3jvCyorj+VC
	6LvpZYGTSDEn+nJaq4cNAcc0YZtzj1YGhSXlWGkODfXz7ct00AopAp6EkqcislyKYH4Rnx
	6ZtjkFLCmA1nwmYAiONvJ55Pl7TCUzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712539800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyFQmQ1qRyWFAL3/in35Y8k758Y1us/oIDERyct9plw=;
	b=uNmwU5kNxAEu3xFxp/ESvIfT/m730Zpkyjt4W0S2vhyLOSeiuDLzpuih7dpcijHziknPUj
	b/7t4QiNIWvO5dAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dvDuOjuW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eunzIf9z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712539798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyFQmQ1qRyWFAL3/in35Y8k758Y1us/oIDERyct9plw=;
	b=dvDuOjuWrbZqBX5DxYw7yRf8vGWrKauvBLfi2rQl5d8I4iYKGS7vQ3g/YlG+iAlObRhIs6
	al53CWX8i/7vw7gzkZLSwXR3hdYk5BEO3N6Px5QUReWxCVSD3wlUQusErQv2FuyzZ7i3ub
	aTbOu6rCMj49choQI+91KKrMSmFG0KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712539798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yyFQmQ1qRyWFAL3/in35Y8k758Y1us/oIDERyct9plw=;
	b=eunzIf9zlf3O87UkNYWJ+nFmPlLTZdOwR/I85nfq01ZXAhU3ntDp2a2Z5cg5dvkVvCql7t
	3CKZUJSXM1kPLqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40A8613796;
	Mon,  8 Apr 2024 01:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZokONZNIE2aQCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 01:29:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: optimise recalculate_deny_mode() for a common case
Date: Mon, 08 Apr 2024 11:29:52 +1000
Message-id: <171253979210.17212.5851835299179227478@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E6FBD22376
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[25.12%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]


recalculate_deny_mode() takes time that is linear in the number of
stateids active on the file.

When called from
  release_openowner -> free_ol_stateid_reaplist ->nfs4_free_ol_stateid
  -> release_all_access

the number of times it is called is linear in the number of stateids.
The net result is that time taken by release_openowner is quadratic in
the number of stateids.

When the nfsd server is shut down while there are many active stateids
this can result in a soft lockup. ("CPU stuck for 302s" seen in one case).

In many cases all the states have the same deny modes and there is no
need to examine the entire list in recalculate_deny_mode().  In
particular, recalculate_deny_mode() will only reduce the deny mode,
never increase it.  So if some prefix of the list causes the original
deny mode to be required, there is no need to examine the remainder of
the list.

So we can improve recalculate_deny_mode() to usually run in constant
time, so release_openowner will typically be only linear in the number
of states.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1824a30e7dd4..a46f5230bc9b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1409,11 +1409,16 @@ static void
 recalculate_deny_mode(struct nfs4_file *fp)
 {
 	struct nfs4_ol_stateid *stp;
+	u32 old_deny;
 
 	spin_lock(&fp->fi_lock);
+	old_deny = fp->fi_share_deny;
 	fp->fi_share_deny = 0;
-	list_for_each_entry(stp, &fp->fi_stateids, st_perfile)
+	list_for_each_entry(stp, &fp->fi_stateids, st_perfile) {
 		fp->fi_share_deny |= bmap_to_share_mode(stp->st_deny_bmap);
+		if (fp->fi_share_deny == old_deny)
+			break;
+	}
 	spin_unlock(&fp->fi_lock);
 }
 
-- 
2.44.0


