Return-Path: <linux-nfs+bounces-2373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723987ED91
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860A11C215D7
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90E54794;
	Mon, 18 Mar 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBlIYWPK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SinawfuG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="INavKFAn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cTnR4Upf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0D54760
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779539; cv=none; b=lDBI+6vrVlepGXtZEqJHB4gdPVLRNu68YNw5zn0QPpxc/5mRIyqFSWK6sVnScgxbnxJXrB89NU7k6jxEAX0OT9nOUJFi87J9LEMDQhPZDxww0ta3CHivaBoDIUVVJYr43N7anW8HDxN9GjczL5mcX410gpUY61CXOO871xb+Ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779539; c=relaxed/simple;
	bh=qTSxGn2XBWiAY/ngw6RIgAMWwnL3a3IakHCi/D0oMkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PzLsK84xuiD0RUybg3m1UZEtMfRn97UpLqb/o+8XZm5O7jocHK86VYkn9rncHcDWJZi8rU8h91P0DXlzWeZoGIwfdfGlVNIBZUOueMC/79BpHEM7c5zFKgtwn+p7IHkcTqnOu0O6GURdWSnpu56GwkXYHtdzQMCzArMkR28XhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBlIYWPK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SinawfuG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=INavKFAn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cTnR4Upf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D962B34C45;
	Mon, 18 Mar 2024 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710779536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w4cK3JEIbSUh6zpLLkLqcl9pa/qPR2N0297Jk5KC0gY=;
	b=RBlIYWPKNTTRL4E/W5qKPiezNJSIM0HYs0M2ugp91ft8/UxQVjAPWukqZpSeoa5hvltut8
	BWGHQgEANehtcTyS5VPRC5/HN69YQSPbJaJcICsq/p1xeMVyi5L5H/o7f3/daCWLan7GEI
	zz5hyAOuo3V8sKIjcfeowlPXsIcErDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710779536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w4cK3JEIbSUh6zpLLkLqcl9pa/qPR2N0297Jk5KC0gY=;
	b=SinawfuG7z4JPPgnVXd3J65c9yyYhcPNzolTwsnfinphRKuX+V1JLY549XzwkilgZHg2rx
	fzz9puno64SbgnCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710779535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w4cK3JEIbSUh6zpLLkLqcl9pa/qPR2N0297Jk5KC0gY=;
	b=INavKFAnxvho+1jZp6+S2kirfAZPDvmEiZMt+EPvCsDEyiXnC1puc+kVDBW1etKHT8qs3s
	AEf2l6V1grnBkEYHuy8vQqZilgtbiYlZwKPAUG8iSGesscv7VoH56zazzanJRtQmI7WEHg
	fvm1lSa85UkDMsEOVxoZ3lOk3PyZSKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710779535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w4cK3JEIbSUh6zpLLkLqcl9pa/qPR2N0297Jk5KC0gY=;
	b=cTnR4UpfWJumc+uXKIA6mhDzL/I7opNGbRzF7lpCGvBy8L2Ro0d2rnjf/3C6QOA+tDTo7w
	hKh8YvZuA4ezAnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFE1A136A5;
	Mon, 18 Mar 2024 16:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1067Mo9s+GWPZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 16:32:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A5B2A07D9; Mon, 18 Mar 2024 17:32:15 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] nfsd: Fix error cleanup path in nfsd_rename()
Date: Mon, 18 Mar 2024 17:32:09 +0100
Message-Id: <20240318163209.26493-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=jack@suse.cz; h=from:subject; bh=qTSxGn2XBWiAY/ngw6RIgAMWwnL3a3IakHCi/D0oMkc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBl+Gx1Kf5WDfHqfgjUaY3hgFmAkDSBOdc2J2UQ0cAp iNGMBgiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZfhsdQAKCRCcnaoHP2RA2XveCA DM1cXwz2HKQ4cgk5YdTEbPsRCmk578sA4qhZLlsZOW6amAAwlrqe080PbMICeX6YFE5bTvmVxIM4Pr nw2a4kagqTymglVQtZpAXwv4PQ0szlRE+ZwP6utZZs+tiu0UkHwLf/G1w/dKK3jjNjVXTTrAB0AQvp F/OWyek0sfF5ZMEGt32Q/ea39BpOm4/j0tmU8dF+pTZ3CgfFa1zcpqASxizJBGsxn6jJ0X0JUUHoar VhXFl49Wk8+Mo3o6lJpGFuRskJ6PfOCDYFqD9HWymVTbq6Fq/idgGc+qdHp/jztywmr17q3HnorCXU wTz0k9i7gwclec81Bw7yNlFzR+CPa7
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.49
X-Spam-Flag: NO
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=INavKFAn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cTnR4Upf
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[26.89%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: ***
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D962B34C45

Commit a8b0026847b8 ("rename(): avoid a deadlock in the case of parents
having no common ancestor") added an error bail out path. However this
path does not drop the remount protection that has been acquired. Fix
the cleanup path to properly drop the remount protection.

Fixes: a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having no common ancestor")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nfsd/vfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6a9464262fae..2e41eb4c3cec 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1852,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	trap = lock_rename(tdentry, fdentry);
 	if (IS_ERR(trap)) {
 		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
-		goto out;
+		goto out_want_write;
 	}
 	err = fh_fill_pre_attrs(ffhp);
 	if (err != nfs_ok)
@@ -1922,6 +1922,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	}
 out_unlock:
 	unlock_rename(tdentry, fdentry);
+out_want_write:
 	fh_drop_write(ffhp);
 
 	/*
-- 
2.35.3


