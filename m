Return-Path: <linux-nfs+bounces-22535-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GGbkKIpaLGo6PwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22535-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 21:14:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E367BF1B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 21:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mg6BGEcr;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22535-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22535-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C60AF3004D8C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4139B952;
	Fri, 12 Jun 2026 19:14:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA233F59E
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 19:14:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291652; cv=none; b=uiStJWgIeWD8NS+YiWXKPOfd93YlRpgmiK81AHThD1/z67uHsYrnFL2PA5q/U9E4cSrX3Sy5qkX/+u2jvAc7qP6N2eNBKjf7mFqueE8ZtxZ1tfwc6iDh9rBX3JUpZWW14efIH6XdWikJ2asn4JeJoFI1dj76nPYoCFa3O2T4AXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291652; c=relaxed/simple;
	bh=GpsgL42x4woccR9ZI/hZNDf8zixr14xD10XuvH+Uxt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXtXsda9yw+5jIJcT0JdC0wt3tybsbfvjim9aoEzZ6bDHhk5c6oGNQa+LlvpGcVSr6+0oOgKW3q9XwfK4DtYQwNM2887ZTRqQAoxjjEd6usdQNPmQv8wtIPamTQng13ztMQa+dH0ePcnC9AoGqYl3ZTSBB/7csPFxbG1LPw9tUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg6BGEcr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0277C1F000E9;
	Fri, 12 Jun 2026 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781291651;
	bh=50wfDHEeJTRsYtFTTPOhbp+tLr/JhzR0LqmBGp4RRf0=;
	h=From:To:Cc:Subject:Date;
	b=Mg6BGEcrZ3llMZ3NEODKa/YFvbw4viTuLfDk8Yn/DHy4VUgHDhxVT7t87yU9wgDwR
	 vchbCK9UgvFEu+ZvYPpWQBBgwI2yg68GgOHeY9cP6EH1Rr/PA1GCvoRfoNGAdznTZO
	 9IiB3cqhV2q9AdRAM5+w1TqGu6A1vOULvGxyCwzvs2IklK18URchisk9TDxUKK93Gv
	 md8nM7dqzgYhtxblsjNLO2KlodAMnBwya4A9o/gvvNjfGZ67gJNHii2jMmX0bcSXDT
	 amY8g1kaULZazEMnVZmLtKMNxZ/1kSXEPof6piImulcaVJMJCz/fspv/MZJkbfLrtM
	 qq7pyudKuwdJQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check
Date: Fri, 12 Jun 2026 15:14:10 -0400
Message-ID: <20260612191410.50177-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22535-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 950E367BF1B

The header for commit e75b23f9e323 ("nfsd: check d_can_lookup in
fh_verify of directories") details the assumption that justified
adding the WARN_ON_ONCE to nfsd_mode_check(), that assumption is
invalid (in the case of NFS reexport).

When NFSD exports an NFS filesystem it is very possible for
nfsd_mode_check() to encounter a @dentry that doesn't have
i_op->lookup (see nfs_fhget()'s NFS_ATTR_FATTR_MOUNTPOINT and
NFS_ATTR_FATTR_V4_REFERRAL handling, and d_flags_for_inode()).

So remove nfsd_mode_check()'s WARN_ON_ONCE().

Fixes: e75b23f9e323 ("nfsd: check d_can_lookup in fh_verify of directories")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfsfh.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index bce8784aa92e4..ffe7f22693edf 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -70,10 +70,8 @@ nfsd_mode_check(struct dentry *dentry, umode_t requested)
 	if (requested == 0) /* the caller doesn't care */
 		return nfs_ok;
 	if (mode == requested) {
-		if (mode == S_IFDIR && !d_can_lookup(dentry)) {
-			WARN_ON_ONCE(1);
+		if (mode == S_IFDIR && !d_can_lookup(dentry))
 			return nfserr_notdir;
-		}
 		return nfs_ok;
 	}
 	if (mode == S_IFLNK) {
-- 
2.44.0


