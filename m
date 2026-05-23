Return-Path: <linux-nfs+bounces-21889-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJTWNMDqEWqzrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21889-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:58:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D92865C0384
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2900F301F4DF
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463434DB56;
	Sat, 23 May 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CveTOEuJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CE348875;
	Sat, 23 May 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558986; cv=none; b=Cc5oZuAvzCoYwXqSDcRB1WWBdsbtp/kHmJtwEq8hi+t71W+5+R7jOUSWovmU13QwhBzPodlvfWL84cG7Za4Di7wwZxn3yOCtpJY31l+d8yfVI4VjWqtMgbqh8YyM5ZPzZnv/yCVmTi6v2LGE7iB3fh6bd9X8NUil7C5q2gAI4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558986; c=relaxed/simple;
	bh=HXrQZpeWN85ojYx7kPWIMvSe3/c5RK1MgAHwTCxVs7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGDFk7XNWf0KEBAgnbG5Pc2EAKnoHJX2CdMrgrBDXgqfwA7JIXGOQN6FGeXWCkzAqouRieUSVfbKyTo5h4Tjx6wJ8HN+p2RdkjUN0OzTjguOoznKhV79geWHIcnAU5a36h6I73HhcXAgdW/pvRnXWebytjOdsInA/CGsUT+uOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CveTOEuJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F91F000E9;
	Sat, 23 May 2026 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558984;
	bh=64moEsVhgfwgI6MhFHgVhfH5MiESSq4cUiaY8/kUbXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CveTOEuJd+8kC+bH8xjZnQAePmub9EwWAVXdLRANzb/MECJO4ML8rsBSy4pLSKa0W
	 FrVbvpSksYISZvH1Z5MZbtgs9CxiG5hrdqrLB5qb0lPXnY4XumgNVts5Zabanhatzt
	 SKf24aQMydc6/9+t12q/leOfbrgBdAYUSXhlUiHVGD/YoGeJL1Jf4asA3Ki526udT+
	 OUho1AaqLkVVrZMX+o13pw+MCa0ch38JG20IOMI7GBteAYKyB1H0hGJ+66+wJQ2oXV
	 6XzMbyLsODlr9wOMo0TqSG+134+nnOMh4L23aLFTHMFEUHc6qs/zEMUbSzSTl5JWtv
	 RScWemXv3O84A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:26 +0300
Subject: [PATCH 14/17] fs/namespace: use __getname() to allocate mntpath
 buffer
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-14-275e36a83f0e@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
In-Reply-To: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
To: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Kees Cook <kees@kernel.org>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21889-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D92865C0384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mnt_warn_timestamp_expiry() allocates memory for a path with
__get_free_page() although there is a dedicated helper for allocation of
file paths: __getname().

Replace __get_free_page() for allocation of a path buffer with __getname().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..2ed9cd846a81 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3303,7 +3303,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf, *mntpath;
 
-		buf = (char *)__get_free_page(GFP_KERNEL);
+		buf = __getname();
 		if (buf)
 			mntpath = d_path(mountpoint, buf, PAGE_SIZE);
 		else
@@ -3319,7 +3319,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
 
 		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
 		if (buf)
-			free_page((unsigned long)buf);
+			__putname(buf);
 	}
 }
 

-- 
2.53.0


