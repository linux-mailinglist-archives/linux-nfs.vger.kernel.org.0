Return-Path: <linux-nfs+bounces-2851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647508A76B8
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 23:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD55282757
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 21:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC1913C3EB;
	Tue, 16 Apr 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QfIES6f+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZmzTcCLn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uds6SZAR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iKpbVdt7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4413C3E9
	for <linux-nfs@vger.kernel.org>; Tue, 16 Apr 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302594; cv=none; b=Vfc9NbCpZd0u2KZftle6G/8ao/AtGdaLlUki3pjsWC34NQmwh9p3Z7Cu02pI5F3XrIup7jPc9ZzHI4dE2RJTQLEJSIUTUvajen676A+SM01SEv6w3xodsgmiSnfW/qwGEpApONl+6qmFJD38FrJTwvQA5+DRxUzWmHJwPq8zJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302594; c=relaxed/simple;
	bh=rZPHfJgrjLIJ4yhbMgRshV8OEN+exo48ANU0s0EaCao=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=Vl/axpK8H4gFnWJNFZnJSKKTsXSOauWbgCOj2IA8WjXPjMkgAnl+BhaFcpblsMre6B2fPLvuUKjlyI1Cf0yotKrQ0x5gv0djE88Lkr8++y+n3Ed1hGxJ+cBGqrf3I0XanHMuZHTZwlS/4wVb8l8fSJSlUvSt9wTei+xFnzxSx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QfIES6f+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZmzTcCLn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uds6SZAR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iKpbVdt7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C16022674;
	Tue, 16 Apr 2024 21:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713302590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UjX9jqSjUpaT6VB3qdSHfJ1xGSwj2SXxE51SZadxHJ0=;
	b=QfIES6f+Ivmw9p8CdGK62syOhD+Vcx1HXpG0qbcfVXsK9jMceI/uYFboVnYc1aKECYFqJB
	sMkoEoYAMdovs8082nPvpyixuGJeHd9Cw5sI14bx2JYR5cL9HdW1ygZsN+lRf2uINZoLE6
	xb+OruICTF8pt6lrAQQMJvliC25BdNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713302590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UjX9jqSjUpaT6VB3qdSHfJ1xGSwj2SXxE51SZadxHJ0=;
	b=ZmzTcCLnIJXF15pBZfiG/bB41KOn5MdkUJpF9VCY0muAyPYFXVtwrKQy6s1yWQ1dxQLIq9
	ccm6KPLeCAVEzFCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713302589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UjX9jqSjUpaT6VB3qdSHfJ1xGSwj2SXxE51SZadxHJ0=;
	b=Uds6SZARdNPqt1Z67SRF9OK1C7yd8bYG2dPfSqI5EyCs4upRwvz/VabRauj0I6y6ShdrEX
	hRj/OxBsjmNeA/rVLz3UOlhGkU2Cq760aEhnngSG3QFw/Z+qSE/u/EeLmhQUVee1O5ihVc
	3zm8gOxSbxUFlPwocJ9GNZAXgp+f/GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713302589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UjX9jqSjUpaT6VB3qdSHfJ1xGSwj2SXxE51SZadxHJ0=;
	b=iKpbVdt7qQAYraCoo15lWfvDfewc6rAO3R/CeHkIYr3kmmawfjhK1b7wc4vVw60hWSoVdH
	hx5B8z3pfyQO2tDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA2F13432;
	Tue, 16 Apr 2024 21:23:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XkeCDzrsHmafeQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Apr 2024 21:23:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH] nfsd: don't create nfsv4recoverydir in nfsdfs when not used.
Date: Wed, 17 Apr 2024 07:23:02 +1000
Message-id: <171330258224.17212.9790424282163530018@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email]


When CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set, the virtual file
  /proc/fs/nfsd/nfsv4recoverydir
is created but responds EINVAL to any access.
This is not useful, is somewhat surprising, and it causes ltp to
complain.

The only known user of this file is in nfs-utils, which handles
non-existence and read-failure equally well.  So there is nothing to
gain from leaving the file present but inaccessible.

So this patch removes the file when its content is not available - i.e.
when that config option is not selected.

Also remove the #ifdef which hides some of the enum values when
CONFIG_NFSD_V$ not selection.  simple_fill_super() quietly ignores array
entries that are not present, so having slots in the array that don't
get used is perfectly acceptable.  So there is no value in this #ifdef.

Reported-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 93c87587e646..340c5d61f199 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -48,12 +48,10 @@ enum {
 	NFSD_MaxBlkSize,
 	NFSD_MaxConnections,
 	NFSD_Filecache,
-#ifdef CONFIG_NFSD_V4
 	NFSD_Leasetime,
 	NFSD_Gracetime,
 	NFSD_RecoveryDir,
 	NFSD_V4EndGrace,
-#endif
 	NFSD_MaxReserved
 };
=20
@@ -1360,7 +1358,9 @@ static int nfsd_fill_super(struct super_block *sb, stru=
ct fs_context *fc)
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] =3D {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Gracetime] =3D {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 		[NFSD_RecoveryDir] =3D {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IR=
USR},
+#endif
 		[NFSD_V4EndGrace] =3D {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
 #endif
 		/* last one */ {""}
--=20
2.44.0


