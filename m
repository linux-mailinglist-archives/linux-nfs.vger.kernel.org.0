Return-Path: <linux-nfs+bounces-21941-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOw0KJphFWoiUwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21941-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:02:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7595D2E7F
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9165F300D740
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11B2ECD3A;
	Tue, 26 May 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiPct5I3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E687175A76;
	Tue, 26 May 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786066; cv=none; b=piHMSBkO9lRNb/oX3fl7PJaqpzkHnLhYaQvD2ziynxbE/22WLt/Sz59m3SxZx2i/T9wRcVXZ7+cldQZsw+W7QxgZ/7rl3X0xFcj05/yz6nqIttSqipCch6jjkU2H6wlaTI8E95QkwkphcpphdpZO/+wqCmPX2hBevA2KkPLFLGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786066; c=relaxed/simple;
	bh=TJ3N58ATgLYg81u/fkCKyj4q6Ieu6uXB5m2US3IhzKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+BsNrXN3y8gXMqs8KmyBa1bD4wff+tqvuRw6lxlrNxBeKWDT5bpgVCubMOqffv1nlTgZZ+On0nCbhpLMa3LY7ybjhuAoF2xS9OhAbc/nditdoxEbHvc0y1zf6fN4aAKHUYiDA2bI6LQmpGbAfpp7jhlPZ913G+HduvHOeWiqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiPct5I3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D81F000E9;
	Tue, 26 May 2026 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779786064;
	bh=wnrCbM2Qnlfg9PJg0zChR9cS1O62PROxyneyrD/ESZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GiPct5I3RIyKVnUeY4SIiCrdnUqsOgS6mDU9YSBJjHDd0gYwXI7rEld8XueXGIXhn
	 4VMIsiVV2x0xXRM+qlbp8J3K6njuhdYcF9IEpNRbQR5MAI0ZlYW3O878Rhrv1Kyr/Y
	 HK0dpDUzeYEvaGeOszozJUh7pm2LkN07u38CNlv7c+x+aKcYrCbxPF9bQ4mzd4g/Sj
	 Pq4YX7HRGJU+s0ogTWQtOaYeav00GrrtEnqGs1OmV1Shn2PnIK5mzFdBaih/eHYD+n
	 3ATVI0Kp776yWfk86RVYhy8Ar47qbqvpSE3ShiaDY+VAUwFW4LiNMzIG3znk70SwDP
	 Xn7irCtUvdfKg==
Date: Tue, 26 May 2026 11:01:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-mm@kvack.org, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 1/3] tmpfs: simplify constructing "security.foo" xattr
 names
Message-ID: <20260526-ablief-demut-wehen-aef8446ef5c9@brauner>
References: <177945382308.2991556.1256192774754909984.b4-ty@b4>
 <5386153f-9112-4971-98fc-de90d7aae2c6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dyu27gpxlrmawx5e"
Content-Disposition: inline
In-Reply-To: <5386153f-9112-4971-98fc-de90d7aae2c6@oracle.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21941-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: AA7595D2E7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--dyu27gpxlrmawx5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, May 25, 2026 at 04:59:02AM +0100, Calum Mackay wrote:
> hi Christian, Miklos,
> 
> https://lore.kernel.org/all/177945382308.2991556.1256192774754909984.b4-ty@b4/
> 
> > Date: Fri, 22 May 2026 14:43:43 +0200> On Tue, 19 May 2026 10:13:21 +0200, Miklos Szeredi wrote:
> > > tmpfs: simplify constructing "security.foo" xattr names
> > 
> > Thanks, this looks great!
> > 
> > ---
> > 
> > Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.2.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-7.2.misc
> > 
> > [1/3] tmpfs: simplify constructing "security.foo" xattr names
> >       https://git.kernel.org/vfs/vfs/c/aba5853b137b
> > [2/3] simple_xattr: change interface to pass struct simple_xattrs **
> >       https://git.kernel.org/vfs/vfs/c/1cd9d2387c05
> > [3/3] simpe_xattr: use per-sb cache
> >       https://git.kernel.org/vfs/vfs/c/12e9e3cd03b5
> 
> 
> I have been doing some testing of Chuck's nfsd-testing tree, which includes
> some vfs changes.
> 
> The test systems are reliably crashing, in what looks like it might possibly
> be something related to these three patches.

The appended patch should fix it.

--dyu27gpxlrmawx5e
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-kernfs-link-kn-to-its-parent-before-the-LSM-init-hoo.patch"

From 6358bc199a5be450bd11dd7607918dcad4030b86 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 26 May 2026 10:57:06 +0200
Subject: [PATCH] kernfs: link kn to its parent before the LSM init hook

After commit 12e9e3cd03b5 ("simpe_xattr: use per-sb cache"),
kernfs_xattr_set() and kernfs_xattr_get() compute the cache via
kernfs_root(kn) before any other check.  kernfs_root(kn) walks
kn->__parent first and falls back to kn->dir.root, both of which are
NULL on a freshly kmem_cache_zalloc()'d kn. kn->__parent was being set
in kernfs_new_node() after __kernfs_new_node() returned, and kn->dir.root
is set even later by kernfs_create_dir_ns() / kernfs_create_empty_dir().

The LSM kernfs_init_security hook is invoked from inside
__kernfs_new_node(), before either field has been initialized.
selinux_kernfs_init_security() ends with kernfs_xattr_set(kn,
XATTR_NAME_SELINUX, ...).  kernfs_root(kn) then returns NULL, and
&((struct kernfs_root *)NULL)->xa_cache evaluates to
offsetof(struct kernfs_root, xa_cache) which faults:

  BUG: kernel NULL pointer dereference, address: 00000000000000e0
  RIP: 0010:simple_xattr_set+0x27/0x8b0
  Call Trace:
   kernfs_xattr_set+0x63/0xb0
   selinux_kernfs_init_security+0x13b/0x270
   security_kernfs_init_security+0x36/0xc0
   __kernfs_new_node+0x182/0x290
   kernfs_new_node+0x80/0xc0
   kernfs_create_dir_ns+0x2b/0xa0
   cgroup_create+0x116/0x380
   cgroup_mkdir+0x7c/0x1a0

Reproduces deterministically at PID 1 (systemd) on an SELinux-enabled
distro. The first cgroup mkdir under /sys/fs/cgroup with a labelled
parent panics the kernel.

The LSM hook's contract is that the kn_dir argument is the parent of
the new kn, so kn->__parent should already point at kn_dir when the
hook runs.  Move kernfs_get(parent) and rcu_assign_pointer of
kn->__parent from kernfs_new_node() into __kernfs_new_node() right
before the security hook, and unwind the parent reference on the
err_out4 path.  kernfs_root(kn) then takes its parent branch during
the hook and returns parent->dir.root, which is the correct root.

This also closes the same-shape latent bug in kernfs_xattr_get() (which
today is hidden only by kernfs_iattrs_noalloc() returning NULL on a
fresh kn).

Fixes: 12e9e3cd03b5 ("simpe_xattr: use per-sb cache")
Reported-by: Calum Mackay <calum.mackay@oracle.com>
Closes: https://lore.kernel.org/all/5386153f-9112-4971-98fc-de90d7aae2c6@oracle.com/
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/kernfs/dir.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8ba2f2f3da9e..6d47b8469642 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -698,6 +698,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	}
 
 	if (parent) {
+		kernfs_get(parent);
+		rcu_assign_pointer(kn->__parent, parent);
+
 		ret = security_kernfs_init_security(parent, kn);
 		if (ret)
 			goto err_out4;
@@ -706,6 +709,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out4:
+	RCU_INIT_POINTER(kn->__parent, NULL);
+	kernfs_put(parent);
 	if (kn->iattr) {
 		simple_xattrs_free(&root->xa_cache, &kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
@@ -742,10 +747,6 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
-	if (kn) {
-		kernfs_get(parent);
-		rcu_assign_pointer(kn->__parent, parent);
-	}
 	return kn;
 }
 
-- 
2.47.3


--dyu27gpxlrmawx5e--

