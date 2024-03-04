Return-Path: <linux-nfs+bounces-2156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5B86F956
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 05:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603441F2198E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EE17F3;
	Mon,  4 Mar 2024 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pls0mrOL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="naElsUUv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K7ds3/x4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="McVC9qP3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B57611A
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 04:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527832; cv=none; b=aSq4hZxmu616ch9pJXU7NBdbpgo/GBo2Yru5zEhTU7yZU59dj+Y9BpBqmujbfLbvNCZgHV0QFF+4Pi1EOWqD0435LPLIF4tZMYeWNN1GngQOx7r0mjlqJpeSH2ZOz6/gBNu7uaXqkRkszmUCOIuZqA/0J12JSNY0hK3ODmniMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527832; c=relaxed/simple;
	bh=oanJAxgmJ/ZBAv5jk3mHd0mvMhltP6DrJIUFBhtUSpc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=nw8shZL0hJvARgsjkbho/bjPpBeJtWS8iqa71BYC8AP2wojslpkLoLwksB7JRBU7/aP61msL36IpHjle6PoQIe/Wxpmz0wqjGjtVDpyfoZOji9H144fKtiHh7sn0oFy8XnJvv7mYe3zYcyK9D4e1tmswiyUVgT6BexdtgGjEoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pls0mrOL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=naElsUUv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K7ds3/x4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=McVC9qP3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F04903FE19;
	Mon,  4 Mar 2024 04:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrR17BB9Ud4qq3M/px3oE91HsSdWygr2Scor4mDktQs=;
	b=Pls0mrOLvFXZIvT2ByVTFDyF0KqNrStKrxpb7T//HizIrerXosIUSvHLHT/oddZFvmZSo4
	30xFkS/K/EJKGBP696jbsdwtTAqOkfvt0QkanKCXF+qsCMAjeWoUnza8sSwMIxDskp1zT2
	+WSiu0ZyPa/BvkHTiCE8BCN/S9Ni7Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrR17BB9Ud4qq3M/px3oE91HsSdWygr2Scor4mDktQs=;
	b=naElsUUvZ4hrbsoA+9UpiDMv/ppYnrzKGsS1+uwAMlTOSV20fCjv7XYHOXb2+9VZglxk1E
	3Vk4GveEpFnhApAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709527827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrR17BB9Ud4qq3M/px3oE91HsSdWygr2Scor4mDktQs=;
	b=K7ds3/x4o64qilRboeGiXE3UWOzqLRMogq8YOnvQT2RO9fd+3jbObuFpZC/i4aS37x4ilg
	XlCvHDAY0YX8voUIi1b2xAHyak1IOE2w5KOwP5s5/mrhaIQ+7om+PUsXdiElwCpcKEtgS2
	11cQqGMQTpFCaXj/UUf1l21Bjb5V3I8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709527827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrR17BB9Ud4qq3M/px3oE91HsSdWygr2Scor4mDktQs=;
	b=McVC9qP3PWUft/ehxXwxZC5WsUqagGTXw55004LzM31SGST5qYULibZiuAqoPs1uBnW52F
	KHhQPqq53u3gDNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 189FA13A9F;
	Mon,  4 Mar 2024 04:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VlIgKxFT5WUDOQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 04:50:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
 "zhitao.li@smartx.com" <zhitao.li@smartx.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Restore -EIO as error to return when "umount -f"
 aborts request.
In-reply-to: <81a96f8af0eb1b4d6ddaa44a451d8b2af4e7fa16.camel@hammerspace.com>
References: <170909199843.24797.6320949640369986924@noble.neil.brown.name>,
 <81a96f8af0eb1b4d6ddaa44a451d8b2af4e7fa16.camel@hammerspace.com>
Date: Mon, 04 Mar 2024 15:50:22 +1100
Message-id: <170952782221.24797.9882801008066120476@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.997];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.987];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,hammerspace.com:email,smartx.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu, 29 Feb 2024, Trond Myklebust wrote:
> On Wed, 2024-02-28 at 14:46 +1100, NeilBrown wrote:
> >=20
> > When "umount -f" is used to abort all outstanding requests on an NFS
> > mount, some pending systemcalls can be expected to return an error.
> > Currently this error is ERESTARTSYS which should never be exposed to
> > applications (it should only be returned due to a signal).
> >=20
> > Prior to Linux v5.2 EIO would be returned in these cases, which it is
> > more likely that applications will handle.
> >=20
> > This patch restores that behaviour so EIO is returned.
> >=20
> > Reported-and-tested-by: Zhitao Li <zhitao.li@smartx.com>
> > Closes:
> > https://lore.kernel.org/linux-nfs/CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6i=
NgwZpHqYUjWw@mail.gmail.com/
> > Fixes: ae67bd3821bb ("SUNRPC: Fix up task signalling")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > =C2=A0include/linux/sunrpc/sched.h | 2 +-
> > =C2=A0net/sunrpc/clnt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0net/sunrpc/sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 6 +++---
> > =C2=A03 files changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/sunrpc/sched.h
> > b/include/linux/sunrpc/sched.h
> > index 2d61987b3545..ed3a116efd5d 100644
> > --- a/include/linux/sunrpc/sched.h
> > +++ b/include/linux/sunrpc/sched.h
> > @@ -222,7 +222,7 @@ void		rpc_put_task(struct rpc_task
> > *);
> > =C2=A0void		rpc_put_task_async(struct rpc_task *);
> > =C2=A0bool		rpc_task_set_rpc_status(struct rpc_task *task, int
> > rpc_status);
> > =C2=A0void		rpc_task_try_cancel(struct rpc_task *task, int
> > error);
> > -void		rpc_signal_task(struct rpc_task *);
> > +void		rpc_signal_task(struct rpc_task *, int);
> > =C2=A0void		rpc_exit_task(struct rpc_task *);
> > =C2=A0void		rpc_exit(struct rpc_task *, int);
> > =C2=A0void		rpc_release_calldata(const struct rpc_call_ops *,
> > void *);
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index cda0935a68c9..cdbdfae13030 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -895,7 +895,7 @@ void rpc_killall_tasks(struct rpc_clnt *clnt)
> > =C2=A0	trace_rpc_clnt_killall(clnt);
> > =C2=A0	spin_lock(&clnt->cl_lock);
> > =C2=A0	list_for_each_entry(rovr, &clnt->cl_tasks, tk_task)
> > -		rpc_signal_task(rovr);
> > +		rpc_signal_task(rovr, -EIO);
>=20
> rpc_killall_tasks() is called by rpc_shutdown_client(). It is not
> obvious to me that EIO is an appropriate return value in all the cases
> where that is being called.
>=20
> If we're going to replace ERESTARTSYS, then why would we not want to go
> for EINTR?

I have no particular opinion on which error code is correct, though I am
confident that ERESTARTSYS is not.  I do see the attraction of EINTR,
though "man 3 errno" suggests that is appropriate when a signal is
received, which is not the case here.

With this patch I was primarily reverting what appeared to be an
unintentional change in a previous patch.  Such a reversion can then be
used in -stable kernels if that seems appropriate.

If this exercise suggests to you that a different error code might be
more appropriate, then I think any such change should be in a separate
patch which only goes to mainline.

Thanks,
NeilBrown


>=20
> > =C2=A0	spin_unlock(&clnt->cl_lock);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(rpc_killall_tasks);
> > diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> > index 6debf4fd42d4..e4f36fe16808 100644
> > --- a/net/sunrpc/sched.c
> > +++ b/net/sunrpc/sched.c
> > @@ -852,14 +852,14 @@ void rpc_exit_task(struct rpc_task *task)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > -void rpc_signal_task(struct rpc_task *task)
> > +void rpc_signal_task(struct rpc_task *task, int err)
> > =C2=A0{
> > =C2=A0	struct rpc_wait_queue *queue;
> > =C2=A0
> > =C2=A0	if (!RPC_IS_ACTIVATED(task))
> > =C2=A0		return;
> > =C2=A0
> > -	if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
> > +	if (!rpc_task_set_rpc_status(task, err))
> > =C2=A0		return;
> > =C2=A0	trace_rpc_task_signalled(task, task->tk_action);
> > =C2=A0	set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
> > @@ -992,7 +992,7 @@ static void __rpc_execute(struct rpc_task *task)
> > =C2=A0			 * clean up after sleeping on some queue, we
> > don't
> > =C2=A0			 * break the loop here, but go around once
> > more.
> > =C2=A0			 */
> > -			rpc_signal_task(task);
> > +			rpc_signal_task(task, -ERESTARTSYS);
> > =C2=A0		}
> > =C2=A0		trace_rpc_task_sync_wake(task, task->tk_action);
> > =C2=A0	}
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20


