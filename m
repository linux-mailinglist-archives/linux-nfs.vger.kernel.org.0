Return-Path: <linux-nfs+bounces-2101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E6486A40C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 00:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60981C23131
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D25821B;
	Tue, 27 Feb 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oM8Pu7vk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYgXqFn9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oM8Pu7vk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYgXqFn9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A258124;
	Tue, 27 Feb 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078159; cv=none; b=hLXwEQxnbF7Kqpnn593NJYGkqSdlx0HmpD+dIqSCCP4xfc4sMTsihkxAedN1trVJWsmfNPSuRfyyfffzpWiZDS/RoCzyR/hYOXT238mHdS4GVJ7qmjF79e6YPILNOutX48tfP7Y35euwgklItJdr2DxTn/ep6f8+U7qGOBOF48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078159; c=relaxed/simple;
	bh=pjID9jOH1YDmOs7zFevAPpOPMlUU8CvAoKKqvz9850M=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jZSVq2g/ZD/SmFxhusKYOZMCTLRq6sDWZy4Fs/KmTzohoEhDV85/fn5M7J7EMqGMO+F0nkbG7Yly5BYJ4Hvsl46nNzIhDTs2ml7xyhdhn2XSC6czdjbO1L5AbvumPVfMW8Dq82AXuKFSoTyYKvtxnmW53qco+oWweWfKoC8DNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oM8Pu7vk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYgXqFn9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oM8Pu7vk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYgXqFn9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 624C62281D;
	Tue, 27 Feb 2024 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709078155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo7lOyfhfo/jOi++S8K/sO8jKuWpQF2djN8rS+ChceY=;
	b=oM8Pu7vk5u+K0Cd/cUVeYjlE7Jb/F1ure9DkXUTGc8ZozTSOdU3zgBAS+ByH9MekVXSB+v
	UHUWT6FZlPo2iu33SaitpD6YO16A5/ZYTvC3Ra/cR+o47dgbLiP809ECNL9VUyYmF6I4E0
	fosqzpDqsj//v5jK9cw4YB14c29Lq3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709078155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo7lOyfhfo/jOi++S8K/sO8jKuWpQF2djN8rS+ChceY=;
	b=sYgXqFn9XF/OhKwI9zHc8QtgUSrihhB0Ll9ek6JQTFSajtYOD3zwT9qpj8lfVhzI0R67ox
	N6M9C2H5OUMtPhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709078155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo7lOyfhfo/jOi++S8K/sO8jKuWpQF2djN8rS+ChceY=;
	b=oM8Pu7vk5u+K0Cd/cUVeYjlE7Jb/F1ure9DkXUTGc8ZozTSOdU3zgBAS+ByH9MekVXSB+v
	UHUWT6FZlPo2iu33SaitpD6YO16A5/ZYTvC3Ra/cR+o47dgbLiP809ECNL9VUyYmF6I4E0
	fosqzpDqsj//v5jK9cw4YB14c29Lq3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709078155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo7lOyfhfo/jOi++S8K/sO8jKuWpQF2djN8rS+ChceY=;
	b=sYgXqFn9XF/OhKwI9zHc8QtgUSrihhB0Ll9ek6JQTFSajtYOD3zwT9qpj8lfVhzI0R67ox
	N6M9C2H5OUMtPhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2E861386D;
	Tue, 27 Feb 2024 23:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aHtbIYZ23mWhOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Feb 2024 23:55:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Zhitao Li" <zhitao.li@smartx.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
 "tom@talpey.com" <tom@talpey.com>, "anna@kernel.org" <anna@kernel.org>,
 "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
 "kolga@netapp.com" <kolga@netapp.com>,
 "huangping@smartx.com" <huangping@smartx.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
In-reply-to:
 <CAPKjjnrir1C8YYhhW10Nj6bAOTiz_YwWUOynEwXbjetMAuA1UA@mail.gmail.com>
References:
 <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>,
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>,
 <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>,
 <CAPKjjnrir1C8YYhhW10Nj6bAOTiz_YwWUOynEwXbjetMAuA1UA@mail.gmail.com>
Date: Wed, 28 Feb 2024 10:55:43 +1100
Message-id: <170907814318.24797.17138350642031030344@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oM8Pu7vk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sYgXqFn9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 624C62281D
X-Spam-Flag: NO

On Fri, 23 Feb 2024, Zhitao Li wrote:
> Thanks for Jeff's reply.
>=20
> I did see  ERESTARTSYS in userland. As described in the above
> "Reproduction" chapter, "dd" fails with "dd: error writing
> '/mnt/test1/1G': Unknown error 512".
>=20
> After strace "dd", it turns out that syscall WRITE fails with:
> write(1, "4\303\31\211\316\237\333\r-\275g\370\233\374X\277\374Tb\202\24\36=
5\220\320\16\27o3\331q\344\364"...,
> 1048576) =3D ? ERESTARTSYS (To be restarted if SA_RESTART is set)
>=20
> In fact, other syscalls related to file systems can also fail with
> ERESTARTSYS in our cases, for example: mount, open, read, write and so
> on.
>=20
> Maybe the reason is that on forced unmount, rpc_killall_tasks() in
> net/sunrpc/clnt.c will set all inflight IO with ERESTARTSYS, while no
> signal gets involved. So ERESTARTSYS is not handled before entering
> userspace.
>=20
> Best regards,
> Zhitao Li at SmartX.
>=20
> On Thu, Feb 22, 2024 at 7:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> >
> > On Wed, 2024-02-21 at 13:48 +0000, Trond Myklebust wrote:
> > > On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > > > [You don't often get email from zhitao.li@smartx.com. Learn why this
> > > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > Hi, everyone,
> > > >
> > > > - Facts:
> > > > I have a remote NFS export and I mount the same export on two
> > > > different directories in my OS with the same options. There is an
> > > > inflight IO under one mounted directory. And then I unmount another
> > > > mounted directory with force. The inflight IO ends up with "Unknown
> > > > error 512", which is ERESTARTSYS.
> > > >
> > >
> > > All of the above is well known. That's because forced umount affects
> > > the entire filesystem. Why are you using it here in the first place? It
> > > is not intended for casual use.
> > >
> >
> > While I agree Trond's above statement, the kernel is not supposed to
> > leak error codes that high into userland. Are you seeing ERESTARTSYS
> > being returned to system calls? If so, which ones?
> > --
> > Jeff Layton <jlayton@kernel.org>
>=20

I think this bug was introduced by=20
Commit ae67bd3821bb ("SUNRPC: Fix up task signalling")
in Linux v5.2.

Prior to that commit, rpc_killall_tasks set the error to -EIO.
After that commit it calls rpc_signal_task which always uses
-ERESTARTSYS.

This might be an appropriate fix.  Can you please test and confirm?

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 2d61987b3545..ed3a116efd5d 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -222,7 +222,7 @@ void		rpc_put_task(struct rpc_task *);
 void		rpc_put_task_async(struct rpc_task *);
 bool		rpc_task_set_rpc_status(struct rpc_task *task, int rpc_status);
 void		rpc_task_try_cancel(struct rpc_task *task, int error);
-void		rpc_signal_task(struct rpc_task *);
+void		rpc_signal_task(struct rpc_task *, int);
 void		rpc_exit_task(struct rpc_task *);
 void		rpc_exit(struct rpc_task *, int);
 void		rpc_release_calldata(const struct rpc_call_ops *, void *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index cda0935a68c9..cdbdfae13030 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -895,7 +895,7 @@ void rpc_killall_tasks(struct rpc_clnt *clnt)
 	trace_rpc_clnt_killall(clnt);
 	spin_lock(&clnt->cl_lock);
 	list_for_each_entry(rovr, &clnt->cl_tasks, tk_task)
-		rpc_signal_task(rovr);
+		rpc_signal_task(rovr, -EIO);
 	spin_unlock(&clnt->cl_lock);
 }
 EXPORT_SYMBOL_GPL(rpc_killall_tasks);
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 6debf4fd42d4..e88621881036 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -852,14 +852,14 @@ void rpc_exit_task(struct rpc_task *task)
 	}
 }
=20
-void rpc_signal_task(struct rpc_task *task)
+void rpc_signal_task(struct rpc_task *task, int sig)
 {
 	struct rpc_wait_queue *queue;
=20
 	if (!RPC_IS_ACTIVATED(task))
 		return;
=20
-	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
+	if (!rpc_task_set_rpc_status(task, sig))
 		return;
 	trace_rpc_task_signalled(task, task->tk_action);
 	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
@@ -992,7 +992,7 @@ static void __rpc_execute(struct rpc_task *task)
 			 * clean up after sleeping on some queue, we don't
 			 * break the loop here, but go around once more.
 			 */
-			rpc_signal_task(task);
+			rpc_signal_task(task, -ERESTARTSYS);
 		}
 		trace_rpc_task_sync_wake(task, task->tk_action);
 	}

