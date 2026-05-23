Return-Path: <linux-nfs+bounces-21875-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLapJObpEWqbrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21875-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:54:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ADD5C01DF
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AD07301724E
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD9330662;
	Sat, 23 May 2026 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3/zQq+P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF62C15B0;
	Sat, 23 May 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558881; cv=none; b=HtrvsO3Dxh5LA0w2elt2jud6x/bwAxEuCCfuZSYSXTZyiVxiciMjXC1eZF17yjaHYy12/zkWy0uk4n6Hj6kcEXt5hgLsomerMVGdS8dzTR6Waaa/itrKZyrG5ySIkbQhesb1sEy9mEydrfhyYlDkm6G8k9NQ+64QLtM7T3HSnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558881; c=relaxed/simple;
	bh=6YKw0+ePnyTC6oQSj2mRm9VaB8KlhBNJFxPcPZ9ZjVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SkSN0GdSNTQ94ygWNjI01jUOVFjMeOBX4OyZoG3R0Iij/pOjlcVMPC2a154K6zHrGrSU1vFVTgYvgAt9VhO0MJP4/pIoA4mJhW7SnYL8EVMnqdiEXLHrAC2G/KT6087FavYTO8MzPpCMHCsDCtjhCI3Ipp+YjF8i8pX5tL9ZhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3/zQq+P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF19F1F000E9;
	Sat, 23 May 2026 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558879;
	bh=GvzInyki8MnmX5WWa5of2Y0DpS84K4dK1p7AUcMNwXw=;
	h=From:Subject:Date:To:Cc;
	b=j3/zQq+PxlG0iZSuFKwgwWYoAsK0CHz5cRp6E32xLvTDfBsCGugqN+ZUucB2u3maM
	 N/47G+WnhhEqHtkDEU8M1wLF1+2yXGj4atHqd+Kz8vYI5MMcd1e2SjcjGgTs3C/PPr
	 LNEBfAG6q9WPM8n0ozT5EO+bUdc2Yuja3cB80mDrmrZVSPTkbZZ5Ihx9d90deaNR7S
	 mZ0UqQsRFOZ9T/rtGsYIPziVm9ozSwmVad9D3l0e8qctz4vx7CktQ0xz7qRHVIXmxD
	 XmQnFQch2girJp1oe+UvE8X7jDGD54eiVSox604H8ebdWW+Ut3Qct0j+NhUgEhKIIG
	 QxKtUrZZ+JFJA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 00/17] fs: replace __get_free_pages() call with kmalloc()
Date: Sat, 23 May 2026 20:54:12 +0300
Message-Id: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTpEWoC/yWMQQ7CIBBFr9LM2omUAiZexbhgcLDjAg1TjUnTu
 xd0+X7e+ysoV2GF87BC5Y+oPEuD8TBAmmO5M8qtMVhjg/HWIjnMip59Opk8jSE4aO6rcpbv7+d
 y/bO+6cFp6XE3KCoj1VjS3CdyRymywLbt2e6JaoMAAAA=
X-Change-ID: 20260522-b4-fs-5e5c70f31664
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21875-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9ADD5C01DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/fs

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
Mike Rapoport (Microsoft) (17):
      quota: allocate dquot_hash with kmalloc()
      proc: replace __get_free_page() with kmalloc()
      ocfs2/dlm: replace __get_free_page() with kmalloc()
      nilfs2: replace get_zeroed_page() with kzalloc()
      NFS: replace __get_free_page() with kmalloc() in nfs_show_devname()
      NFS: remove unused page and page2 in nfs4_replace_transport()
      NFSD: replace __get_free_page() with kmalloc() in nfsd_buffered_readdir()
      libfs: simple_transaction_get(): replace get_zeroed_page() with kzalloc()
      jfs: replace __get_free_page() with kmalloc()
      jbd2: replace __get_free_pages() with kmalloc()
      isofs: replace __get_free_page() with kmalloc()
      fuse: replace __get_free_page() with kmalloc()
      fs/select: replace __get_free_page() with kmalloc()
      fs/namespace: use __getname() to allocate mntpath buffer
      configfs: replace __get_free_pages() with kzalloc()
      binfmt_misc: replace __get_free_page() with kmalloc()
      bfs: replace get_zeroed_page() with kzalloc()

 fs/bfs/inode.c             |  4 ++--
 fs/binfmt_misc.c           |  4 ++--
 fs/configfs/file.c         |  7 +++----
 fs/fuse/ioctl.c            |  5 +++--
 fs/isofs/dir.c             |  5 +++--
 fs/jbd2/journal.c          |  7 ++-----
 fs/jfs/jfs_dtree.c         | 16 ++++++++--------
 fs/libfs.c                 |  6 +++---
 fs/namespace.c             |  4 ++--
 fs/nfs/nfs4namespace.c     | 15 +--------------
 fs/nfs/super.c             |  4 ++--
 fs/nfsd/vfs.c              |  4 ++--
 fs/nilfs2/ioctl.c          |  4 ++--
 fs/ocfs2/dlm/dlmdebug.c    | 24 +++++++++---------------
 fs/ocfs2/dlm/dlmdomain.c   |  8 +++++---
 fs/ocfs2/dlm/dlmmaster.c   |  5 ++---
 fs/ocfs2/dlm/dlmrecovery.c |  4 ++--
 fs/proc/base.c             | 16 ++++++++--------
 fs/quota/dquot.c           | 11 +++++------
 fs/select.c                |  4 ++--
 20 files changed, 68 insertions(+), 89 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260522-b4-fs-5e5c70f31664

Best regards,
--  
Sincerely yours,
Mike.


