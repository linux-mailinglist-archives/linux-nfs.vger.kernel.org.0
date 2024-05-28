Return-Path: <linux-nfs+bounces-3453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF828D289A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 01:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0281F2253C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D517C6A;
	Tue, 28 May 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g/NYpOVj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f3wWKC1P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g/NYpOVj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f3wWKC1P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD313F439
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937911; cv=none; b=JiOf0esX+Rk3iXbrOwolARkuHgzychmsp/kBxkl8oI2ZjFKx8NzV6rHFrdtOa1q4aMJAu1gQzKBvBNSRKhxSDMDCR+vRPi1ieYR+qTV+Mt/HwXLfO6W30prZlOGR8fmaf1eAbgZdndpilEBbth+Yhp6v64nEYlR1OPm5URXadYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937911; c=relaxed/simple;
	bh=Pr/zuvVfu3WX5N1zSgvQXQLN458F0kD26XwV73Gktl8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=KzvK9jKkdLqxheMCL8bpVlu3v7Q4BlZ5913IqwSVIRx8RzcVwIiVnPgFOiRm4fCQX9K4qznYdZ4+//sTAsCWiAJKQnNwu606LM1d3V7w7tC3FRN7LLhJW+dD9KSGpv3VtrUcDNihE+FkGFEK0vXQ7HpjpBXlG2lqa0A6fSANM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g/NYpOVj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f3wWKC1P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g/NYpOVj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f3wWKC1P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 798962048F;
	Tue, 28 May 2024 23:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716937907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
	b=g/NYpOVjbrdfn4O6dgStOLYbVgetLazT5DM1EJUCgpLbUysPZ7wBW+d4fvBgp+eXq6DNe7
	hFgT8lhXFyYBrJ6kohxi7LLPUjjJr3GhAvl6YE1WHABnyHtbO7pm8nN53Nptbc7LQ5fsc2
	PRvSlFkfGQYu47wbO9bcXTDno1OsKqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716937907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
	b=f3wWKC1PnTSwhP34GDnKLrZunQI2LVxxGgyCJ97xfSjDdR0BJbo25EeGOOZssZFJJMIZ8x
	3y1H3ozSRAWefPAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="g/NYpOVj";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f3wWKC1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716937907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
	b=g/NYpOVjbrdfn4O6dgStOLYbVgetLazT5DM1EJUCgpLbUysPZ7wBW+d4fvBgp+eXq6DNe7
	hFgT8lhXFyYBrJ6kohxi7LLPUjjJr3GhAvl6YE1WHABnyHtbO7pm8nN53Nptbc7LQ5fsc2
	PRvSlFkfGQYu47wbO9bcXTDno1OsKqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716937907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
	b=f3wWKC1PnTSwhP34GDnKLrZunQI2LVxxGgyCJ97xfSjDdR0BJbo25EeGOOZssZFJJMIZ8x
	3y1H3ozSRAWefPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CE4C13A6B;
	Tue, 28 May 2024 23:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bC15CLBkVmZsAgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 May 2024 23:11:44 +0000
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
Cc: james.clark@arm.com, ltp@lists.linux.it, broonie@kernel.org,
 Aishwarya.TCV@arm.com, linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: abort nfs_atomic_open_v23 if name is too long.
Date: Wed, 29 May 2024 09:11:36 +1000
Message-id: <171693789645.27191.13475059024941012614@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 798962048F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]


An attempt to open a file with a name longer than NFS3_MAXNAMLEN will
trigger a WARN_ON_ONCE in encode_filename3() because
nfs_atomic_open_v23() doesn't have the test on ->d_name.len that
nfs_atomic_open() has.

So add that test.

Reported-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/all/20240528105249.69200-1-james.clark@arm.co=
m/
Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correc=
tly.")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 342930996226..2b09b5416ef1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2255,6 +2255,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentr=
y *dentry,
 	 */
 	int error =3D 0;
=20
+	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
+		return -ENAMETOOLONG;
+
 	if (open_flags & O_CREAT) {
 		file->f_mode |=3D FMODE_CREATED;
 		error =3D nfs_do_create(dir, dentry, mode, open_flags);
--=20
2.44.0


