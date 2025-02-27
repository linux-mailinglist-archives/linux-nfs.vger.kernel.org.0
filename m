Return-Path: <linux-nfs+bounces-10373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B494A47185
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 02:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E783BC53E
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 01:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0A17A2F9;
	Thu, 27 Feb 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u08A+whY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xl1+cA2X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u08A+whY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xl1+cA2X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D50156F20
	for <linux-nfs@vger.kernel.org>; Thu, 27 Feb 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620409; cv=none; b=LtsEau06I733w5AHyhISxOB8UPqgbCvnTaWxG0ccrooIeAd8y7OEKqj06gzUBj53GekNbRhAYg1lnDkPcjNGwrbP9J9wbpDK0D9PAbRlXP4vxNmfswPrCH07TV5kIY6vbePCDkhO1sGmuQItru0xhow8G8oJ3dfp756S3fpqZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620409; c=relaxed/simple;
	bh=kJrppHPnaUnDAuya/zrtGQ3SFCCFDotFPuNgb5SuoQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeNw8ugNxIHmQraLcQFazuStWEHkHEnea0Z/0+fyt18666pIckoBhcNJFb4waNqBxjlrLvekJUGpGhJH5jDKkv4u1QZDDS7vVD42dIMQe6pxDruzDybUY9sHS9kqHTlPt42Xsq2UzEux8ihTeMCtobDZ97p8VYRByPrWS1CyJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u08A+whY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xl1+cA2X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u08A+whY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xl1+cA2X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C365321186;
	Thu, 27 Feb 2025 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=u08A+whY9HPi82eNKNi6NBpw/0yooU5Rc+wCm6UR5x1aiEZUlD0EhBT6SdYyQRh08/q5D+
	c3Cq1bGZvdRAvEAPiw5nsKK8kRVJrDI3Q8i6itlW/X21el6Vkb3ynKqYVjD6If2fv83cWx
	ouZsX6rTSxBVA4Di+tOia5Rq7RWkLhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=xl1+cA2Xm7ijRyut64mqXOdMKSFclvP/NlOPDbtrmoDh7s1H33qhhw4yM9Vh6Ryzlytlxy
	90+LezvCO0MZF3BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u08A+whY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xl1+cA2X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=u08A+whY9HPi82eNKNi6NBpw/0yooU5Rc+wCm6UR5x1aiEZUlD0EhBT6SdYyQRh08/q5D+
	c3Cq1bGZvdRAvEAPiw5nsKK8kRVJrDI3Q8i6itlW/X21el6Vkb3ynKqYVjD6If2fv83cWx
	ouZsX6rTSxBVA4Di+tOia5Rq7RWkLhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=xl1+cA2Xm7ijRyut64mqXOdMKSFclvP/NlOPDbtrmoDh7s1H33qhhw4yM9Vh6Ryzlytlxy
	90+LezvCO0MZF3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3355134A0;
	Thu, 27 Feb 2025 01:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ccc9HW7Cv2e9EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:39:58 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6 v2] Change ->mkdir() and vfs_mkdir() to return a dentry
Date: Thu, 27 Feb 2025 12:32:52 +1100
Message-ID: <20250227013949.536172-1-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C365321186
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This revised series contains a few clean-ups as requested by various
people but no substantial changes.

It is based on vfs/vfs-6.15.async.dir plus vfs/vfs-6.15.sysv: I dropped the
change to sysv as it seemed pointless preserving them.

I reviewed the mkdir functions in many (all?) filesystems and found a
few that use d_instantiate() on an unlocked inode (after
unlock_new_inode()) and also support export_operations.  These could
potentially call d_instantiate() on a directory inode which is already
attached to an dentry, though making that happen would usually require
guessing the filehandle correctly.  I haven't tried to address those
here, (this patch set doesn't make that situation any worse) but I may
in the future.

Thanks,
NeilBrown


 [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
 [PATCH 2/6] hostfs: store inode in dentry after mkdir if possible.
 [PATCH 3/6] ceph: return the correct dentry on mkdir
 [PATCH 4/6] fuse: return correct dentry for ->mkdir
 [PATCH 5/6] nfs: change mkdir inode_operation to return alternate
 [PATCH 6/6] VFS: Change vfs_mkdir() to return the dentry.

