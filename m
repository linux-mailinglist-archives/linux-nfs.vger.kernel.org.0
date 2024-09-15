Return-Path: <linux-nfs+bounces-6496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9297999B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 01:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF61C21A0C
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 23:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA0E8175F;
	Sun, 15 Sep 2024 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C3u3k+2l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Xkuqd+X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C3u3k+2l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9Xkuqd+X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66A75809
	for <linux-nfs@vger.kernel.org>; Sun, 15 Sep 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726444081; cv=none; b=QnqGh+YQ4OSumigunbb1OtQF348y7+qmGtJwVO7/vzsGvtRv6N5Yo2zPZfgwuAiwbys5hrTfZsaAYvO3zkJW3eXuAX4Y6ZuUs3+mzzT7XydYNfpQsrswGVvVb0QoUpvuDPWBg2ccEkKGO01cE6GvYxFDp2ttEooFxNKqH/i8T6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726444081; c=relaxed/simple;
	bh=jLWkGA9kkSymfMSwlAXHYlfrMMLrWKCaP0pf5to2+WU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NsIc60pg7RN/LeCQAv6uyo3MHpGNgwfuPtCv0XdhIcVk5jALljwIUbY3qynngq6i8PG7hIxmWWwvsUTMeZoEX7NkwlWuE0LwxEo+kkuZNMHurdwxAoGsBRNqS9BUmSxnHk1sbiEDeFNR+6kggMQNiki5oo9LFQqqBE3YMHnBtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C3u3k+2l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Xkuqd+X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C3u3k+2l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9Xkuqd+X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B281D1F837;
	Sun, 15 Sep 2024 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726444076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UIW861d/uTGwG80XoNNqeWfeEW1BNCbchYI4JHfSL8=;
	b=C3u3k+2lZmac9E5lVGGgTDGd1W3dGy/U/R020Gi7OOvwgcotmdTw1KU4QwFUoeW+UqJUJN
	Big24cvKqtep8vONwhtS5FTPJnZpQpkkp4GArkhced2FQm30xbnn0GCEDCpQIKRYtz0mCc
	SJJE1uPS9j/vjMk5JZK7s2PGz/174AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726444076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UIW861d/uTGwG80XoNNqeWfeEW1BNCbchYI4JHfSL8=;
	b=9Xkuqd+Xx+9eh/VO2Jcb8c9JNUOxnIJjYm7vpZ/PEd16TIeXLdMQYrzVugzeuRs37hG6eR
	xqcudwSn6ipCWyAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C3u3k+2l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9Xkuqd+X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726444076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UIW861d/uTGwG80XoNNqeWfeEW1BNCbchYI4JHfSL8=;
	b=C3u3k+2lZmac9E5lVGGgTDGd1W3dGy/U/R020Gi7OOvwgcotmdTw1KU4QwFUoeW+UqJUJN
	Big24cvKqtep8vONwhtS5FTPJnZpQpkkp4GArkhced2FQm30xbnn0GCEDCpQIKRYtz0mCc
	SJJE1uPS9j/vjMk5JZK7s2PGz/174AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726444076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UIW861d/uTGwG80XoNNqeWfeEW1BNCbchYI4JHfSL8=;
	b=9Xkuqd+Xx+9eh/VO2Jcb8c9JNUOxnIJjYm7vpZ/PEd16TIeXLdMQYrzVugzeuRs37hG6eR
	xqcudwSn6ipCWyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 585F61351A;
	Sun, 15 Sep 2024 23:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZrsfBCpy52b7NAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 15 Sep 2024 23:47:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 2/2] sunrpc: allow svc threads to fail initialisation cleanly
In-reply-to: <C90EF4DC-7A6C-4DE6-998E-E4CB0C3EC2D4@oracle.com>
References: <>, <C90EF4DC-7A6C-4DE6-998E-E4CB0C3EC2D4@oracle.com>
Date: Mon, 16 Sep 2024 09:47:47 +1000
Message-id: <172644406734.17050.6856448467371775791@noble.neil.brown.name>
X-Rspamd-Queue-Id: B281D1F837
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,suse.de:email,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 14 Sep 2024, Chuck Lever III wrote:
>=20
>=20
> > On Sep 11, 2024, at 2:33=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> wro=
te:
> >=20
> > On Tue, 2024-07-30 at 07:19 +1000, NeilBrown wrote:
> >> If an svc thread needs to perform some initialisation that might fail,
> >> it has no good way to handle the failure.
> >>=20
> >> Before the thread can exit it must call svc_exit_thread(), but that
> >> requires the service mutex to be held.  The thread cannot simply take
> >> the mutex as that could deadlock if there is a concurrent attempt to
> >> shut down all threads (which is unlikely, but not impossible).
> >>=20
> >> nfsd currently call svc_exit_thread() unprotected in the unlikely event
> >> that unshare_fs_struct() fails.
> >>=20
> >> We can clean this up by introducing svc_thread_init_status() by which an
> >> svc thread can report whether initialisation has succeeded.  If it has,
> >> it continues normally into the action loop.  If it has not,
> >> svc_thread_init_status() immediately aborts the thread.
> >> svc_start_kthread() waits for either of these to happen, and calls
> >> svc_exit_thread() (under the mutex) if the thread aborted.
> >>=20
> >> Signed-off-by: NeilBrown <neilb@suse.de>
> >> ---
> >> fs/lockd/svc.c             |  2 ++
> >> fs/nfs/callback.c          |  2 ++
> >> fs/nfsd/nfssvc.c           |  9 +++------
> >> include/linux/sunrpc/svc.h | 28 ++++++++++++++++++++++++++++
> >> net/sunrpc/svc.c           | 11 +++++++++++
> >> 5 files changed, 46 insertions(+), 6 deletions(-)
> >>=20
> >> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> >> index 71713309967d..4ec22c2f2ea3 100644
> >> --- a/fs/lockd/svc.c
> >> +++ b/fs/lockd/svc.c
> >> @@ -124,6 +124,8 @@ lockd(void *vrqstp)
> >> struct net *net =3D &init_net;
> >> struct lockd_net *ln =3D net_generic(net, lockd_net_id);
> >>=20
> >> + svc_thread_init_status(rqstp, 0);
> >> +
> >> /* try_to_freeze() is called from svc_recv() */
> >> set_freezable();
> >>=20
> >> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> >> index 8adfcd4c8c1a..6cf92498a5ac 100644
> >> --- a/fs/nfs/callback.c
> >> +++ b/fs/nfs/callback.c
> >> @@ -76,6 +76,8 @@ nfs4_callback_svc(void *vrqstp)
> >> {
> >> struct svc_rqst *rqstp =3D vrqstp;
> >>=20
> >> + svc_thread_init_status(rqstp, 0);
> >> +
> >> set_freezable();
> >>=20
> >> while (!svc_thread_should_stop(rqstp))
> >> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> >> index fca340b3ee91..1cef09a3c78e 100644
> >> --- a/fs/nfsd/nfssvc.c
> >> +++ b/fs/nfsd/nfssvc.c
> >> @@ -875,11 +875,9 @@ nfsd(void *vrqstp)
> >>=20
> >> /* At this point, the thread shares current->fs
> >>  * with the init process. We need to create files with the
> >> -  * umask as defined by the client instead of init's umask. */
> >> - if (unshare_fs_struct() < 0) {
> >> - printk("Unable to start nfsd thread: out of memory\n");
> >> - goto out;
> >> - }
> >> +  * umask as defined by the client instead of init's umask.
> >> +  */
> >> + svc_thread_init_status(rqstp, unshare_fs_struct());
> >>=20
> >> current->fs->umask =3D 0;
> >>=20
> >> @@ -901,7 +899,6 @@ nfsd(void *vrqstp)
> >>=20
> >> atomic_dec(&nfsd_th_cnt);
> >>=20
> >> -out:
> >> /* Release the thread */
> >> svc_exit_thread(rqstp);
> >> return 0;
> >> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> >> index 99e9345d829e..437672bcaa22 100644
> >> --- a/include/linux/sunrpc/svc.h
> >> +++ b/include/linux/sunrpc/svc.h
> >> @@ -21,6 +21,7 @@
> >> #include <linux/wait.h>
> >> #include <linux/mm.h>
> >> #include <linux/pagevec.h>
> >> +#include <linux/kthread.h>
> >>=20
> >> /*
> >>  *
> >> @@ -232,6 +233,11 @@ struct svc_rqst {
> >> struct net *rq_bc_net; /* pointer to backchannel's
> >>  * net namespace
> >>  */
> >> +
> >> + int rq_err; /* Thread sets this to inidicate
> >> +  * initialisation success.
> >> +  */
> >> +
> >> unsigned long bc_to_initval;
> >> unsigned int bc_to_retries;
> >> void ** rq_lease_breaker; /* The v4 client breaking a lease */
> >> @@ -305,6 +311,28 @@ static inline bool svc_thread_should_stop(struct sv=
c_rqst *rqstp)
> >> return test_bit(RQ_VICTIM, &rqstp->rq_flags);
> >> }
> >>=20
> >> +/**
> >> + * svc_thread_init_status - report whether thread has initialised succe=
ssfully
> >> + * @rqstp: the thread in question
> >> + * @err: errno code
> >> + *
> >> + * After performing any initialisation that could fail, and before star=
ting
> >> + * normal work, each sunrpc svc_thread must call svc_thread_init_status=
()
> >> + * with an appropriate error, or zero.
> >> + *
> >> + * If zero is passed, the thread is ready and must continue until
> >> + * svc_thread_should_stop() returns true.  If a non-zero error is passed
> >> + * the call will not return - the thread will exit.
> >> + */
> >> +static inline void svc_thread_init_status(struct svc_rqst *rqstp, int e=
rr)
> >> +{
> >> + /* store_release ensures svc_start_kthreads() sees the error */
> >> + smp_store_release(&rqstp->rq_err, err);
> >> + wake_up_var(&rqstp->rq_err);
> >> + if (err)
> >> + kthread_exit(1);
> >> +}
> >> +
> >> struct svc_deferred_req {
> >> u32 prot; /* protocol (UDP or TCP) */
> >> struct svc_xprt *xprt;
> >> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> >> index ae31ffea7a14..1e80fa67d8b7 100644
> >> --- a/net/sunrpc/svc.c
> >> +++ b/net/sunrpc/svc.c
> >> @@ -706,6 +706,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc=
_pool *pool, int node)
> >> if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
> >> goto out_enomem;
> >>=20
> >> + rqstp->rq_err =3D -EAGAIN; /* No error yet */
> >> +
> >> serv->sv_nrthreads +=3D 1;
> >> pool->sp_nrthreads +=3D 1;
> >>=20
> >> @@ -792,6 +794,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc=
_pool *pool, int nrservs)
> >> struct svc_pool *chosen_pool;
> >> unsigned int state =3D serv->sv_nrthreads-1;
> >> int node;
> >> + int err;
> >>=20
> >> do {
> >> nrservs--;
> >> @@ -814,6 +817,14 @@ svc_start_kthreads(struct svc_serv *serv, struct sv=
c_pool *pool, int nrservs)
> >>=20
> >> svc_sock_update_bufs(serv);
> >> wake_up_process(task);
> >> +
> >> + /* load_acquire ensures we get value stored in svc_thread_init_status(=
) */
> >> + wait_var_event(&rqstp->rq_err, smp_load_acquire(&rqstp->rq_err) !=3D -=
EAGAIN);
> >> + err =3D rqstp->rq_err;
> >> + if (err) {
> >> + svc_exit_thread(rqstp);
> >> + return err;
> >> + }
> >> } while (nrservs > 0);
> >>=20
> >> return 0;
> >=20
> >=20
> > I hit a hang today on the client while running the nfs-interop test
> > under kdevops. The client is stuck in mount syscall, while trying to
> > set up the backchannel:
> >=20
> > [ 1693.653257] INFO: task mount.nfs:13243 blocked for more than 120 secon=
ds.
> > [ 1693.655827]       Not tainted 6.11.0-rc7-gffcadb41b696 #166
> > [ 1693.657858] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> > [ 1693.661442] task:mount.nfs       state:D stack:0     pid:13243 tgid:13=
243 ppid:13242  flags:0x00004002
> > [ 1693.664648] Call Trace:
> > [ 1693.665639]  <TASK>
> > [ 1693.666482]  __schedule+0xc04/0x2750
> > [ 1693.668021]  ? __pfx___schedule+0x10/0x10
> > [ 1693.669562]  ? _raw_spin_lock_irqsave+0x98/0xf0
> > [ 1693.671213]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [ 1693.673109]  ? try_to_wake_up+0x141/0x1210
> > [ 1693.674763]  ? __pfx_try_to_wake_up+0x10/0x10
> > [ 1693.676612]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> > [ 1693.678429]  schedule+0x73/0x2f0
> > [ 1693.679662]  svc_set_num_threads+0xbc8/0xf80 [sunrpc]
> > [ 1693.682007]  ? __pfx_svc_set_num_threads+0x10/0x10 [sunrpc]
> > [ 1693.684163]  ? __pfx_var_wake_function+0x10/0x10
> > [ 1693.685849]  ? __svc_create+0x6c0/0x980 [sunrpc]
> > [ 1693.687777]  nfs_callback_up+0x314/0xae0 [nfsv4]
> > [ 1693.689630]  nfs4_init_client+0x203/0x400 [nfsv4]
> > [ 1693.691468]  ? __pfx_nfs4_init_client+0x10/0x10 [nfsv4]
> > [ 1693.693502]  ? _raw_spin_lock_irqsave+0x98/0xf0
> > [ 1693.695141]  nfs4_set_client+0x2f4/0x520 [nfsv4]
> > [ 1693.696967]  ? __pfx_nfs4_set_client+0x10/0x10 [nfsv4]
> > [ 1693.699230]  nfs4_create_server+0x5f2/0xef0 [nfsv4]
> > [ 1693.701357]  ? _raw_spin_lock+0x85/0xe0
> > [ 1693.702758]  ? __pfx__raw_spin_lock+0x10/0x10
> > [ 1693.704344]  ? nfs_get_tree+0x61f/0x16a0 [nfs]
> > [ 1693.706160]  ? __pfx_nfs4_create_server+0x10/0x10 [nfsv4]
> > [ 1693.707376]  ? __module_get+0x26/0xc0
> > [ 1693.708061]  nfs4_try_get_tree+0xcd/0x250 [nfsv4]
> > [ 1693.708893]  vfs_get_tree+0x83/0x2d0
> > [ 1693.709534]  path_mount+0x88d/0x19a0
> > [ 1693.710100]  ? __pfx_path_mount+0x10/0x10
> > [ 1693.710718]  ? user_path_at+0xa4/0xe0
> > [ 1693.711303]  ? kmem_cache_free+0x143/0x3e0
> > [ 1693.711936]  __x64_sys_mount+0x1fb/0x270
> > [ 1693.712606]  ? __pfx___x64_sys_mount+0x10/0x10
> > [ 1693.713315]  do_syscall_64+0x4b/0x110
> > [ 1693.713889]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [ 1693.714660] RIP: 0033:0x7f05050418fe
> > [ 1693.715233] RSP: 002b:00007fff4e0f5728 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a5
> > [ 1693.716417] RAX: ffffffffffffffda RBX: 00007fff4e0f5900 RCX: 00007f050=
50418fe
> > [ 1693.717492] RDX: 00005559cea3ea70 RSI: 00005559cea3fe60 RDI: 00005559c=
ea40140
> > [ 1693.718558] RBP: 00007fff4e0f5760 R08: 00005559cea41e60 R09: 00007f050=
510cb20
> > [ 1693.719620] R10: 0000000000000000 R11: 0000000000000246 R12: 00005559c=
ea41e60
> > [ 1693.720735] R13: 00007fff4e0f5900 R14: 00005559cea41df0 R15: 000000000=
0000004
> >=20
> >=20
> > Looking at faddr2line:
> >=20
> > $ ./scripts/faddr2line --list net/sunrpc/sunrpc.ko svc_set_num_threads+0x=
bc8/0xf80
> > svc_set_num_threads+0xbc8/0xf80:
> >=20
> > svc_start_kthreads at /home/jlayton/git/kdevops/linux/net/sunrpc/svc.c:82=
2 (discriminator 17)
> > 817=20
> > 818                    svc_sock_update_bufs(serv);
> > 819                    wake_up_process(task);
> > 820=20
> > 821                    /* load_acquire ensures we get value stored in svc=
_thread_init_status() */
> >> 822<                   wait_var_event(&rqstp->rq_err, smp_load_acquire(&=
rqstp->rq_err) !=3D -EAGAIN);
> > 823                    err =3D rqstp->rq_err;
> > 824                    if (err) {
> > 825                            svc_exit_thread(rqstp);
> > 826                            return err;
> > 827                    }
> >=20
> > (inlined by) svc_set_num_threads at /home/jlayton/git/kdevops/linux/net/s=
unrpc/svc.c:877 (discriminator 17)
> > 872                    nrservs -=3D serv->sv_nrthreads;
> > 873            else
> > 874                    nrservs -=3D pool->sp_nrthreads;
> > 875=20
> > 876            if (nrservs > 0)
> >> 877<                   return svc_start_kthreads(serv, pool, nrservs);
> > 878            if (nrservs < 0)
> > 879                    return svc_stop_kthreads(serv, pool, nrservs);
> > 880            return 0;
> > 881    }
> > 882    EXPORT_SYMBOL_GPL(svc_set_num_threads);
> >=20
> > It looks like the callback thread started up properly and is past the svc=
_thread_init_status call.
> >=20
> > $ sudo cat /proc/13246/stack
> > [<0>] svc_recv+0xcef/0x2020 [sunrpc]
> > [<0>] nfs4_callback_svc+0xb0/0x140 [nfsv4]
> > [<0>] kthread+0x29b/0x360
> > [<0>] ret_from_fork+0x30/0x70
> > [<0>] ret_from_fork_asm+0x1a/0x30
> >=20
> > ...so the status should have been updated properly. Barrier problem?
>=20
> Speaking as NFSD release manager: I don't intend to send the
> NFSD v6.12 PR until week of September 23rd.
>=20
> I will either drop these patches before sending my PR, or I
> can squash in a fix if one is found.

When I wrote that patch I thought I understood the barriers needed for
wake/wait but I was wrong.  Quite wrong.

I do now (I believe) and I've been trying to get improved interfaces
upstream so we don't need explicit memory barrier, but no success yet.
I've posted a patch which should fix this problem.

Thanks,
BeilBrown

