Return-Path: <linux-nfs+bounces-4942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7969931E8F
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 03:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7CDFB215F5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2024 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F42D322B;
	Tue, 16 Jul 2024 01:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QG8ToTWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ca6li7+F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QG8ToTWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ca6li7+F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E417F7
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2024 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094496; cv=none; b=ij0d/kNEgUNEYosRglfOARnBrD2HhOT/cSM496cn9lMRWnZijUXxIs6R3NpQozFoUQF+c8tcf+SYdUlKT3QMvfqVpO6b7UHnu2QAiScnOXci3Pa/kOxAG9RncGs8tj2HoqMrNXS8axH2ZeCTbOzFK2fvTJucHg5jaGe+jkGSi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094496; c=relaxed/simple;
	bh=zXFccbZIY7ExWWk8FGF38WvRCYFYlFl0EyvbV0nxSiI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SUokU+Jr+3xzZE7bvQio+CVxUzdlTfij7BlJXxYx0NxK7N3AzpuF/BpAy46DLAkigbM7N2ZQMD80UxvuPzIi6RB3N36HjuNXdOsUSO002SeDnM3XGbMjBk+CDQtDh9xdduzNEGpOoWxNl2IPZz84kWENplAw0MGI4jjRsSqB15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QG8ToTWn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ca6li7+F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QG8ToTWn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ca6li7+F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F71D211CB;
	Tue, 16 Jul 2024 01:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721094492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klOv84S9hO5fhm4oWzST67JT+BA8T6xU37H/6zZCkEE=;
	b=QG8ToTWnklWdC6fGv4/9uNukzBIwxPMFm5V4wMwhmBUFlUVFLCVttB/4zM7iUxu3Az7bCL
	uq9YaDB906Sq+WDuucoqV6BJaGMMEzz2TRquZxQ9xj6sztZoHbyExg+8L0DeVh6eAH6HVq
	8kWqhb6ixmyhOAYfY+1kVqVrmoJkz1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721094492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klOv84S9hO5fhm4oWzST67JT+BA8T6xU37H/6zZCkEE=;
	b=ca6li7+Fi4w89z1BxVm4YFPs6J+YKquXrEu+RWdM8cnA56acvMPNPLoTpHjOK+fGWabt+h
	f+92ZJR29ZYtwQDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QG8ToTWn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ca6li7+F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721094492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klOv84S9hO5fhm4oWzST67JT+BA8T6xU37H/6zZCkEE=;
	b=QG8ToTWnklWdC6fGv4/9uNukzBIwxPMFm5V4wMwhmBUFlUVFLCVttB/4zM7iUxu3Az7bCL
	uq9YaDB906Sq+WDuucoqV6BJaGMMEzz2TRquZxQ9xj6sztZoHbyExg+8L0DeVh6eAH6HVq
	8kWqhb6ixmyhOAYfY+1kVqVrmoJkz1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721094492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klOv84S9hO5fhm4oWzST67JT+BA8T6xU37H/6zZCkEE=;
	b=ca6li7+Fi4w89z1BxVm4YFPs6J+YKquXrEu+RWdM8cnA56acvMPNPLoTpHjOK+fGWabt+h
	f+92ZJR29ZYtwQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F07DA13808;
	Tue, 16 Jul 2024 01:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QiOJKFnRlWYXIwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jul 2024 01:48:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Steve Dickson" <steved@redhat.com>
Subject: Re: [PATCH 07/14] Change unshare_fs_struct() to never fail.
In-reply-to: <d48f18e8205ce046f17a3db3591314bf3cc851ea.camel@kernel.org>
References: <>, <d48f18e8205ce046f17a3db3591314bf3cc851ea.camel@kernel.org>
Date: Tue, 16 Jul 2024 11:48:02 +1000
Message-id: <172109448296.15471.2537623256666552616@noble.neil.brown.name>
X-Rspamd-Queue-Id: 5F71D211CB
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Tue, 16 Jul 2024, Jeff Layton wrote:
> On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> > nfsd threads need to not share the init fs_struct as they need to
> > manipulate umask independently.=C2=A0 So they call unshare_fs_struct() and
> > are the only user of that function.
> >=20
> > In the unlikely event that unshare_fs_struct() fails, the thread will
> > exit calling svc_exit_thread() BEFORE svc_thread_should_stop() reports
> > 'true'.
> >=20
> > This is a problem because svc_exit_thread() assumes that
> > svc_stop_threads() is running and consequently (in the nfsd case)
> > nfsd_mutex is held.=C2=A0 This ensures that the list_del_rcu() call in
> > svc_exit_thread() cannot race with any other manipulation of
> > ->sp_all_threads.
> >=20
> > While it would be possible to add some other exclusion, doing so would
> > introduce unnecessary complexity.=C2=A0 unshare_fs_struct() does not fail=
 in
> > practice.=C2=A0 So the simplest solution is to make this explicit.=C2=A0 =
i.e.=C2=A0 use
> > __GFP_NOFAIL which is safe on such a small allocation - about 64 bytes.
> >=20
>=20
> I know some folks are trying hard to get rid of (or minimize the use
> of) __GFP_NOFAIL. This might not be a long term solution.

Other folk are trying to make NOFAIL a standard option.

See
  https://lore.kernel.org/all/22363d0a-71db-4ba7-b5e1-8bb515811d1c@moroto.mou=
ntain/
and surrounding.  In that email Dan suggests GFP_SMALL as a standard
option that is used for smallish allocations and never fails (and warns
in the allocation is bigger than X).

Also
  https://lwn.net/Articles/964793/

>=20
> > Change unshare_fs_struct() to not return any error, and remove the error
> > handling from nfsd().
> >=20
> > An alternate approach would be to create a variant of
> > kthread_create_on_node() which didn't set CLONE_FS.
> >=20
>=20
> This sounds like it might be the better approach. I guess you could
> just add a set of CLONE_* flags to struct kthread_create_info and fix
> up the callers to set that appropriately?

I tried that first.  I didn't like it.  Lots of effort for little gain,
where __GFP_NOFAIL fixed the same problem more cleanly.
For reference (in case I do need it eventually) below is a patch from my
'git stash' history.

NeilBrown


 fs/fs_struct.c             | 23 -----------------------
 fs/nfsd/nfssvc.c           | 14 +++++---------
 include/linux/fs_struct.h  |  1 -
 include/linux/kthread.h    |  8 ++++++++
 include/linux/sunrpc/svc.h |  1 +
 kernel/kthread.c           | 33 +++++++++++++++++++--------------
 net/sunrpc/svc.c           |  6 ++++--
 7 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64c2d0814ed6..a94764084c8c 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -130,29 +130,6 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 	return fs;
 }
=20
-int unshare_fs_struct(void)
-{
-	struct fs_struct *fs =3D current->fs;
-	struct fs_struct *new_fs =3D copy_fs_struct(fs);
-	int kill;
-
-	if (!new_fs)
-		return -ENOMEM;
-
-	task_lock(current);
-	spin_lock(&fs->lock);
-	kill =3D !--fs->users;
-	current->fs =3D new_fs;
-	spin_unlock(&fs->lock);
-	task_unlock(current);
-
-	if (kill)
-		free_fs_struct(fs);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(unshare_fs_struct);
-
 int current_umask(void)
 {
 	return current->fs->umask;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c0d17b92b249..d37b9cbbc250 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -666,6 +666,7 @@ int nfsd_create_serv(struct net *net)
 	if (serv =3D=3D NULL)
 		return -ENOMEM;
=20
+	serv->sv_unshare_fs =3D true;
 	serv->sv_maxconn =3D nn->max_connections;
 	error =3D svc_bind(serv, net);
 	if (error < 0) {
@@ -915,14 +916,10 @@ nfsd(void *vrqstp)
 	struct net *net =3D perm_sock->xpt_net;
 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
=20
-	/* At this point, the thread shares current->fs
-	 * with the init process. We need to create files with the
-	 * umask as defined by the client instead of init's umask. */
-	if (unshare_fs_struct() < 0) {
-		printk("Unable to start nfsd thread: out of memory\n");
-		goto out;
-	}
-
+	/* Thread was created with CLONE_FS disabled so we have
+	 * a private current->fs in which we can control umask
+	 * for file creation.
+	 */
 	current->fs->umask =3D 0;
=20
 	atomic_inc(&nfsd_th_cnt);
@@ -943,7 +940,6 @@ nfsd(void *vrqstp)
=20
 	atomic_dec(&nfsd_th_cnt);
=20
-out:
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 	return 0;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 783b48dedb72..a854bfa4708c 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -22,7 +22,6 @@ extern void set_fs_root(struct fs_struct *, const struct pa=
th *);
 extern void set_fs_pwd(struct fs_struct *, const struct path *);
 extern struct fs_struct *copy_fs_struct(struct fs_struct *);
 extern void free_fs_struct(struct fs_struct *);
-extern int unshare_fs_struct(void);
=20
 static inline void get_fs_root(struct fs_struct *fs, struct path *root)
 {
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index b11f53c1ba2e..222779a40389 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -24,6 +24,8 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(=
void *data),
  * the stopped state.  This is just a helper for kthread_create_on_node();
  * see the documentation there for more details.
  */
+#define kthread_create_on_node(threadfn, data, node, namefmt, arg...) \
+	kthread_create_on_node_flags(threadfn, data, NUMA_NO_NODE, CLONE_FS, namefm=
t, ##arg)
 #define kthread_create(threadfn, data, namefmt, arg...) \
 	kthread_create_on_node(threadfn, data, NUMA_NO_NODE, namefmt, ##arg)
=20
@@ -33,6 +35,12 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(=
void *data),
 					  unsigned int cpu,
 					  const char *namefmt);
=20
+struct task_struct *kthread_create_on_node_flags(int (*threadfn)(void *data),
+						 void *data,
+						 int node,
+						 int flags,
+						 const char *namefmt, ...);
+
 void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk);
 bool set_kthread_struct(struct task_struct *p);
=20
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 23617da0e565..405f8ec8a505 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -87,6 +87,7 @@ struct svc_serv {
 	unsigned int		sv_nrpools;	/* number of thread pools */
 	struct svc_pool *	sv_pools;	/* array of thread pools */
 	int			(*sv_threadfn)(void *data);
+	bool			sv_unshare_fs;	/* Does serv need umask? */
=20
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	struct lwq		sv_cb_list;	/* queue for callback requests
diff --git a/kernel/kthread.c b/kernel/kthread.c
index c5e40830c1f2..e97cbab40034 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -42,6 +42,7 @@ struct kthread_create_info
 	int (*threadfn)(void *data);
 	void *data;
 	int node;
+	int clone_flags;
=20
 	/* Result passed back to kthread_create() from kthreadd. */
 	struct task_struct *result;
@@ -409,7 +410,7 @@ static void create_kthread(struct kthread_create_info *cr=
eate)
 #endif
 	/* We want our own signal handler (we take no signals by default). */
 	pid =3D kernel_thread(kthread, create, create->full_name,
-			    CLONE_FS | CLONE_FILES | SIGCHLD);
+			    create->clone_flags | CLONE_FILES | SIGCHLD);
 	if (pid < 0) {
 		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done =3D xchg(&create->done, NULL);
@@ -424,11 +425,12 @@ static void create_kthread(struct kthread_create_info *=
create)
 	}
 }
=20
-static __printf(4, 0)
-struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
-						    void *data, int node,
-						    const char namefmt[],
-						    va_list args)
+static __printf(5, 0)
+struct task_struct *__kthread_create_on_node_flags(int (*threadfn)(void *dat=
a),
+						   void *data,
+						   int node, int clone_flags,
+						   const char namefmt[],
+						   va_list args)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	struct task_struct *task;
@@ -440,6 +442,7 @@ struct task_struct *__kthread_create_on_node(int (*thread=
fn)(void *data),
 	create->threadfn =3D threadfn;
 	create->data =3D data;
 	create->node =3D node;
+	create->clone_flags =3D clone_flags;
 	create->done =3D &done;
 	create->full_name =3D kvasprintf(GFP_KERNEL, namefmt, args);
 	if (!create->full_name) {
@@ -500,21 +503,23 @@ struct task_struct *__kthread_create_on_node(int (*thre=
adfn)(void *data),
  *
  * Returns a task_struct or ERR_PTR(-ENOMEM) or ERR_PTR(-EINTR).
  */
-struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
-					   void *data, int node,
-					   const char namefmt[],
-					   ...)
+struct task_struct *kthread_create_on_node_flags(int (*threadfn)(void *data),
+						 void *data, int node,
+						 int clone_flags,
+						 const char namefmt[],
+						 ...)
 {
 	struct task_struct *task;
 	va_list args;
=20
 	va_start(args, namefmt);
-	task =3D __kthread_create_on_node(threadfn, data, node, namefmt, args);
+	task =3D __kthread_create_on_node_flags(threadfn, data, node, clone_flags,
+					      namefmt, args);
 	va_end(args);
=20
 	return task;
 }
-EXPORT_SYMBOL(kthread_create_on_node);
+EXPORT_SYMBOL(kthread_create_on_node_flags);
=20
 static void __kthread_bind_mask(struct task_struct *p, const struct cpumask =
*mask, unsigned int state)
 {
@@ -870,8 +875,8 @@ __kthread_create_worker(int cpu, unsigned int flags,
 	if (cpu >=3D 0)
 		node =3D cpu_to_node(cpu);
=20
-	task =3D __kthread_create_on_node(kthread_worker_fn, worker,
-						node, namefmt, args);
+	task =3D __kthread_create_on_node_flags(kthread_worker_fn, worker,
+					      node, CLONE_FS, namefmt, args);
 	if (IS_ERR(task))
 		goto fail_task;
=20
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2b4b1276d4e8..a3c94778b547 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -781,8 +781,10 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_poo=
l *pool, int nrservs)
 		rqstp =3D svc_prepare_thread(serv, chosen_pool, node);
 		if (IS_ERR(rqstp))
 			return PTR_ERR(rqstp);
-		task =3D kthread_create_on_node(serv->sv_threadfn, rqstp,
-					      node, "%s", serv->sv_name);
+		task =3D kthread_create_on_node_flags(serv->sv_threadfn, rqstp,
+						    node,
+						    serv->sv_unshare_fs ? 0 : CLONE_FS,
+						    "%s", serv->sv_name);
 		if (IS_ERR(task)) {
 			svc_exit_thread(rqstp);
 			return PTR_ERR(task);

