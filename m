Return-Path: <linux-nfs+bounces-1892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC3850C8A
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Feb 2024 02:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB62B21658
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Feb 2024 01:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA1315A5;
	Mon, 12 Feb 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mu+KjeBJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gcvWfH4r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mu+KjeBJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gcvWfH4r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10DECC
	for <linux-nfs@vger.kernel.org>; Mon, 12 Feb 2024 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707700385; cv=none; b=UDNiv4Td2E/k1+akZ14SWupLpPSAw/NW6Am1amxssBrawneHquK78mr+lF3/wku9e9HxwPwRYYk6NP+Tx00lPorVdRne6uMUMR9N62x/N+V1tNlkfsoLLGg/XZAA45Qcewf9irQYV/zYPO2+CVv50fIRePmTnXRo2tFb1ONBdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707700385; c=relaxed/simple;
	bh=ZEZBWwMRaYq6Z78GbyRl3htOyFwmMwArWyV8Gn5OgRc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=oupQH7t2GcGIOEoU6+vlDPGw2PtKFIZhe1FgqoP+PUT3Q9MdK+6U3lNzQEYapB4vpodN3E7c/YTy0SQ5gF9buzpskXfiwKY/lck5aNPCP7mWCmFEvsGUcEV+ps2Lg84ChRKiWbzF3QHNebA7WepQyui1H76dmx6pF6O3vjNBwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mu+KjeBJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gcvWfH4r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mu+KjeBJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gcvWfH4r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FBE51F365;
	Mon, 12 Feb 2024 01:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707700381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5cfLta4eQBO1dS0Dr1xlfRufZJ+gfoHvSLBTMleI7o=;
	b=mu+KjeBJxaRQ9J4P5IilxtdUa8ybpV9jv8WrEt6580Ecc4ALW2jvqlEc87Q+u87Pb/NXcS
	qHK3sMakbsYeCXXG1aWbGHNAxfkZUJFJ35lpQkl02Li7s7bPvic9attWwJbkuzryUzbL5m
	Q85JliNCyJ94vcrjpZ4BkqY8vu4IH3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707700381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5cfLta4eQBO1dS0Dr1xlfRufZJ+gfoHvSLBTMleI7o=;
	b=gcvWfH4r1zsfbSaKJ0dkLIqMCcbn68VVMdhftEKXAFOBK04T9i+qSO4I5bXR5ekpKRV3wK
	i0UW/zOnpi7ZpuCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707700381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5cfLta4eQBO1dS0Dr1xlfRufZJ+gfoHvSLBTMleI7o=;
	b=mu+KjeBJxaRQ9J4P5IilxtdUa8ybpV9jv8WrEt6580Ecc4ALW2jvqlEc87Q+u87Pb/NXcS
	qHK3sMakbsYeCXXG1aWbGHNAxfkZUJFJ35lpQkl02Li7s7bPvic9attWwJbkuzryUzbL5m
	Q85JliNCyJ94vcrjpZ4BkqY8vu4IH3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707700381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5cfLta4eQBO1dS0Dr1xlfRufZJ+gfoHvSLBTMleI7o=;
	b=gcvWfH4r1zsfbSaKJ0dkLIqMCcbn68VVMdhftEKXAFOBK04T9i+qSO4I5bXR5ekpKRV3wK
	i0UW/zOnpi7ZpuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BDE613985;
	Mon, 12 Feb 2024 01:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RpxQNJtwyWW1EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 12 Feb 2024 01:12:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Infinite loop in pnfs_update_layout()
Date: Mon, 12 Feb 2024 12:12:57 +1100
Message-id: <170770037721.13976.15585299201457800900@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mu+KjeBJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gcvWfH4r
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[37.16%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -5.01
X-Rspamd-Queue-Id: 5FBE51F365
X-Spam-Flag: NO


hi,
 I have evidence from a customer of an infinite loop in
 pnfs_update_layout().  This has only happened once and I suspect it is
 unlikely to recur often.  We don't have a lot of tracing data, but I
 think we have enough...
 The evidence I do have is repeated "BUG: workqueue lockup" errors
 with sufficiently many samples that I can determine the code path of
 the loop (see below), and a message:

  NFSv4: state recovery failed for open file SVC_rapid7_dc33/.bash_history, e=
rror =3D -116

 The loop involves the "lookup_again" label and the "goto" on line 2112.
 This is the code where NFS_LAYOUT_INVALID_STID was found to be true and
 nfs4_select_rw_stateid() returned non-zero.

 I deduce that ctx->state is not a valid open stateid.  This leads to
 nfs4_select_rw_stateid() returned -EIO and
 nfs4_schedule_stateid_recovery() doing nothing.  This "doing nothing"
 is the only explanation I can find for the
 nfs4_client_recover_expired_lease() call at the top of the loop not
 waiting at all (if it did wait, we wouldn't get a workqueue lockup).

 The state being invalid also perfectly matches the "state recovery
 failed" error.

 So it seems likely that we should test
    nfs4_valid_open_stateid(ctx->state)
 somewhere in the loop, and return either NULL or and error.  I'm not
 certain what is best.
 My inclination is

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0c0fed1ecd0b..e702ac518205 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2002,6 +2002,12 @@ pnfs_update_layout(struct inode *ino,
 	lseg =3D ERR_PTR(nfs4_client_recover_expired_lease(clp));
 	if (IS_ERR(lseg))
 		goto out;
+	if (!nfs4_valid_open_stateid(ctx->state)) {
+		lseq =3D ERR_PTR(-EIO);
+		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
+					 PNFS_UPDATE_LAYOUT_INVALID_OPEN);
+		goto out;
+	}
 	first =3D false;
 	spin_lock(&ino->i_lock);
 	lo =3D pnfs_find_alloc_layout(ino, ctx, gfp_flags);


Does that seem reasonable?
Another possibility would be to check the status from
nfs4_select_rw_stateid() and "goto out_unlock" if it is EIO.

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0c0fed1ecd0b..7cc90ee86882 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2106,6 +2106,8 @@ pnfs_update_layout(struct inode *ino,
 			trace_pnfs_update_layout(ino, pos, count,
 					iomode, lo, lseg,
 					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
+			if (status =3D=3D -EIO)
+				goto out_unlock;
 			nfs4_schedule_stateid_recovery(server, ctx->state);
 			pnfs_clear_first_layoutget(lo);
 			pnfs_put_layout_hdr(lo);


Thoughts?

Thanks,
NeilBrown

