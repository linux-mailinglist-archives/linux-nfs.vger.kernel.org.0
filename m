Return-Path: <linux-nfs+bounces-2813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BEF8A5908
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 19:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F1E281B93
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Apr 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0E8BEF;
	Mon, 15 Apr 2024 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QljMduAU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0uWZ037";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QljMduAU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0uWZ037"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0D8289E
	for <linux-nfs@vger.kernel.org>; Mon, 15 Apr 2024 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201706; cv=none; b=ki27dlBODDSuLEMRBtJpJKrJDGyBbFTfeqFg/UU+9fiFKkqXuhrJjB9t0LhIYGGihCFN6bp6DYTuHgcSX7JnJpDO8yA7G5cG9D6FPgwlxWcvqr8zD4t/sp/fuaIUhuefMrHJ8c27yojZf9EK+u2D8F5vudy8nyqvolcSJVrXAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201706; c=relaxed/simple;
	bh=kQ9nAnKDX7dlANlaeiWBYBm4lgvJVP8vY1EPkFTe76I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVAZPY9GCGKdnrhA2qPglDHV8gB+BUB3IGJVHxMF+2PHcuiJu3qU1TrEIgOhCwSkYE4WpIZOvAILHrFwI4gWISGpN5HuDtSSQsGmZ02M/ZW111YFR68OEQbYOekxHZ8XZ0xPxJgkVmzdIhLEUDGTNsDFSialvNqFBmRlDl2215c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QljMduAU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0uWZ037; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QljMduAU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0uWZ037; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C367E343E3;
	Mon, 15 Apr 2024 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713201702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DAd9OwUFmnRixsBxYu+oocH797id5OOXdxYRydPak1E=;
	b=QljMduAUaszTS2gzcqDJag1xAidN138mW3LUlbSkaXZRNrteyXWxUfzGby5Hm6iOGUYaEm
	rloCxeGlX93TQwNRgiMMqnjDFI+7OqtP2bUgEsSPfJRfpcXw4xOsrIGtVOKpuaRFdbaXGl
	UPqE6T3OyxHIoMNFX/exCEWxT1ye63E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713201702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DAd9OwUFmnRixsBxYu+oocH797id5OOXdxYRydPak1E=;
	b=k0uWZ037zpxS8FNUJiKf8XZuo9WBOjHg7Cpr31cn1fN72rUREU0+/qU+BZs+MLcy4rA7+c
	CjrbOhmSdxum23DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QljMduAU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k0uWZ037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713201702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DAd9OwUFmnRixsBxYu+oocH797id5OOXdxYRydPak1E=;
	b=QljMduAUaszTS2gzcqDJag1xAidN138mW3LUlbSkaXZRNrteyXWxUfzGby5Hm6iOGUYaEm
	rloCxeGlX93TQwNRgiMMqnjDFI+7OqtP2bUgEsSPfJRfpcXw4xOsrIGtVOKpuaRFdbaXGl
	UPqE6T3OyxHIoMNFX/exCEWxT1ye63E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713201702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DAd9OwUFmnRixsBxYu+oocH797id5OOXdxYRydPak1E=;
	b=k0uWZ037zpxS8FNUJiKf8XZuo9WBOjHg7Cpr31cn1fN72rUREU0+/qU+BZs+MLcy4rA7+c
	CjrbOhmSdxum23DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70FB21368B;
	Mon, 15 Apr 2024 17:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkEhGSZiHWZdYAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 15 Apr 2024 17:21:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	NeilBrown <neilb@suse.de>,
	Cyril Hrubis <chrubis@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] proc01: Whitelist /proc/fs/nfsd/nfsv4recoverydir
Date: Mon, 15 Apr 2024 19:21:33 +0200
Message-ID: <20240415172133.553441-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C367E343E3
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]

/proc/fs/nfsd/nfsv4recoverydir started from kernel 6.8 report EINVAL.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

@ Jeff, Chuck, Neil, NFS devs: The patch itself whitelist reading
/proc/fs/nfsd/nfsv4recoverydir in LTP test. I suspect reading failed
with EINVAL in 6.8 was a deliberate change and expected behavior when
CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set:

$ sudo cat /proc/fs/nfsd/nfsv4recoverydir
cat: /proc/fs/nfsd/nfsv4recoverydir: Invalid argument

I'm asking because It worked fine in kernel 6.7:

$ sudo cat /proc/fs/nfsd/nfsv4recoverydir
/var/lib/nfs/v4recovery

I did not bisect but I suspect suspect 74fd48739d04 ("nfsd: new Kconfig
option for legacy client tracking") from v6.8-rc1. The system I test
(openSUSE Tumbleweed) has not CONFIG_NFSD_LEGACY_CLIENT_TRACKING set and
74fd48739d04 wraps write_recoverydir setup, thus it's not set.

+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
        [NFSD_RecoveryDir] = write_recoverydir,
+#endif

Kind regards,
Petr

 testcases/kernel/fs/proc/proc01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index c90e509a3..08b9bbc75 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -113,6 +113,7 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/fs/nfsd/filehandle", EINVAL},
 	{"read", "/proc/fs/nfsd/.getfs", EINVAL},
 	{"read", "/proc/fs/nfsd/.getfd", EINVAL},
+	{"read", "/proc/fs/nfsd/nfsv4recoverydir", EINVAL},
 	{"read", "/proc/self/net/rpc/use-gss-proxy", EAGAIN},
 	{"read", "/proc/sys/net/ipv6/conf/*/stable_secret", EIO},
 	{"read", "/proc/sys/vm/nr_hugepages", EOPNOTSUPP},
-- 
2.43.0


