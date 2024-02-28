Return-Path: <linux-nfs+bounces-2105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9840886A73F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 04:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161151F24AFF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 03:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DB200CD;
	Wed, 28 Feb 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="yCHFhW49"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCC2F24
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091487; cv=none; b=l/F57G93jLDWCSk9B+Q5drlOjugp9n9azJS98InCgC5G18qaBbttoPvYpnJwR5tUcxGtuqzD/321MHttMJuqv2PXqdVmvtVGLEPjTWF7q2U6P9zT614vSVVJbi6ElTG5YLgThebZFTwWb9MdXyyuMaGTUlkcQN5Q20Nc3iY3Bhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091487; c=relaxed/simple;
	bh=U2++s3OeCJGOULSZUUZo8hHVoCQ6BAPgrUnJFwDAvIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BS3UE/XABQs6wUQReVl4H0GAaPkGs+19Qlb8dR/kqgBfN4lfdfYd+jGztzxApY1zOTf5XzR6U3ZzW/mjDjlUi0xRqgP+pxpDrdT1UGDAtZY3tHenQx/i9+s7XYm8GEF8D/8UQ8C71pYSAc5baCqf5IVWuHetwN0E3C31ijOvjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=yCHFhW49; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d220e39907so78538931fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 19:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709091483; x=1709696283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFvziemSaBFHTaih9BhhIY7C9Ip2c7a+1OQjYB8BekQ=;
        b=yCHFhW49rnI6mpSIOkBq2WPD3Wkw/s4P9vx4WcipSkfBq9E5dXzaMd0Ia7xC7iGvff
         MQsmP7teM8bcQzOgntdwoWQRv/jE45+Afzz08PPkcOqx/8b28ccXtxoI3hVf8TGjQj+i
         5zqVIIHJvcqX6PCRhPxM+pxsedCcMYjk0B97LO6l2fqkkmqqEuV2fPJEDJxMeDpqP+bI
         BlCgMJmQ9TkNXT0cYQ+g1NU6JnvOX/VRHW6jvLGvSXQD8oPf3pZ3vgS0fYh6Cr4NOpQa
         +R1UcTpnuT6eViioGG4E7+mSuAMobRL5o4Ja1C/N2Lfbd690eKZDcdm6YyiXcM7XZicX
         HpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709091483; x=1709696283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFvziemSaBFHTaih9BhhIY7C9Ip2c7a+1OQjYB8BekQ=;
        b=q41mPIOIq8BD1rNGWj5czNLQh+pxEUUMNOY+MpreV0N6meDoX7b0v6r5hCVDnvImxu
         V0/pWxqIaUQOR3kCJ/QwlzvW3L4D5ZTjYvQXcvGSu5uQ3Rdy3tAUIHSjUIxW0nIzYoLx
         VFbcJtHWdfagCJvXF/JKmRa7Uk2Xde26/y1ZXeS9oW1y2vaW+gNZ+vq74KFOUJqaK765
         cY6uKz1uMQzVkvJDWlmhpLjRuwkFQUbrQN5eAu7C9rQym00GoX8Dv0O7qqsCsKVD3D/Z
         z0ecTdu2se3qUrS0N48cnVPxYiscIdVpgGyn15mBsh7mQBJm5nVthNQYp55h/4VBa3li
         iF6A==
X-Forwarded-Encrypted: i=1; AJvYcCUzS+yNLb8in13N+ozug//SI/+P7ZIjx9rO5zcxtFoGoUkY14/uY2ZcqwoloHOgeCXJmrr8MA18hQxCbYgXs25PS3f/Ax2PT//+
X-Gm-Message-State: AOJu0YzdLpG9JLyRDIt34bJ298s3xgv43T8xkgxAeM83YfMt8Qiz1tep
	bTZ2UoWt1Ps/tFtvSDX5xp/hHIpkwBHdJOq/ONoqWdh5pM2uc/VXdhh632yTpYguJJZu89PXdBx
	pWcSqEAjgrCS/eighqO8VbURcG8EFqZAAZT+2Pw==
X-Google-Smtp-Source: AGHT+IGuWhMPIZ2sg0pLZLqLPlZdB7C6gQOkXtDFGYhwRqS/xlI5mnTpmFYiIdAmH6iOdLraDOE0T0c5J+jFjERN3iE=
X-Received: by 2002:a05:651c:546:b0:2d2:5057:bbf4 with SMTP id
 q6-20020a05651c054600b002d25057bbf4mr9614633ljp.20.1709091482585; Tue, 27 Feb
 2024 19:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
 <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>
 <CAPKjjnrir1C8YYhhW10Nj6bAOTiz_YwWUOynEwXbjetMAuA1UA@mail.gmail.com> <170907814318.24797.17138350642031030344@noble.neil.brown.name>
In-Reply-To: <170907814318.24797.17138350642031030344@noble.neil.brown.name>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Wed, 28 Feb 2024 11:37:49 +0800
Message-ID: <CAPKjjnpNV9Eq1bxFc3XLjLxFWqJ5_5a_vqC+aUK_t4dGBE7cxw@mail.gmail.com>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "tom@talpey.com" <tom@talpey.com>, 
	"anna@kernel.org" <anna@kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, 
	"kolga@netapp.com" <kolga@netapp.com>, "huangping@smartx.com" <huangping@smartx.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your help.

The fix does work in my cases. "dd" fails with EIO when its mount
point or another mount point with the same export is unmounted with
force.

1. Another mount point is unmounted with force:
[root@v6 zhitaoli]#   dd if=3D/dev/urandom of=3D/mnt/test/1G bs=3D1M
count=3D1024 oflag=3Ddirect
dd: error writing '/mnt/test/1G': Input/output error
100+0 records in
99+0 records out
103809024 bytes (104 MB, 99 MiB) copied, 5.05276 s, 20.5 MB/s

2. The mount point is unmounted with force:
[root@v6 zhitaoli]#   dd if=3D/dev/urandom of=3D/mnt/test/1G bs=3D1M
count=3D1024 oflag=3Ddirect
dd: error writing '/mnt/test/1G': Input/output error
60+0 records in
59+0 records out
61865984 bytes (62 MB, 59 MiB) copied, 2.13265 s, 29.0 MB/s

Best regards
Zhitao Li, at SmartX

On Wed, Feb 28, 2024 at 7:55=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 23 Feb 2024, Zhitao Li wrote:
> > Thanks for Jeff's reply.
> >
> > I did see  ERESTARTSYS in userland. As described in the above
> > "Reproduction" chapter, "dd" fails with "dd: error writing
> > '/mnt/test1/1G': Unknown error 512".
> >
> > After strace "dd", it turns out that syscall WRITE fails with:
> > write(1, "4\303\31\211\316\237\333\r-\275g\370\233\374X\277\374Tb\202\2=
4\365\220\320\16\27o3\331q\344\364"...,
> > 1048576) =3D ? ERESTARTSYS (To be restarted if SA_RESTART is set)
> >
> > In fact, other syscalls related to file systems can also fail with
> > ERESTARTSYS in our cases, for example: mount, open, read, write and so
> > on.
> >
> > Maybe the reason is that on forced unmount, rpc_killall_tasks() in
> > net/sunrpc/clnt.c will set all inflight IO with ERESTARTSYS, while no
> > signal gets involved. So ERESTARTSYS is not handled before entering
> > userspace.
> >
> > Best regards,
> > Zhitao Li at SmartX.
> >
> > On Thu, Feb 22, 2024 at 7:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Wed, 2024-02-21 at 13:48 +0000, Trond Myklebust wrote:
> > > > On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > > > > [You don't often get email from zhitao.li@smartx.com. Learn why t=
his
> > > > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > Hi, everyone,
> > > > >
> > > > > - Facts:
> > > > > I have a remote NFS export and I mount the same export on two
> > > > > different directories in my OS with the same options. There is an
> > > > > inflight IO under one mounted directory. And then I unmount anoth=
er
> > > > > mounted directory with force. The inflight IO ends up with "Unkno=
wn
> > > > > error 512", which is ERESTARTSYS.
> > > > >
> > > >
> > > > All of the above is well known. That's because forced umount affect=
s
> > > > the entire filesystem. Why are you using it here in the first place=
? It
> > > > is not intended for casual use.
> > > >
> > >
> > > While I agree Trond's above statement, the kernel is not supposed to
> > > leak error codes that high into userland. Are you seeing ERESTARTSYS
> > > being returned to system calls? If so, which ones?
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> >
>
> I think this bug was introduced by
> Commit ae67bd3821bb ("SUNRPC: Fix up task signalling")
> in Linux v5.2.
>
> Prior to that commit, rpc_killall_tasks set the error to -EIO.
> After that commit it calls rpc_signal_task which always uses
> -ERESTARTSYS.
>
> This might be an appropriate fix.  Can you please test and confirm?
>
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index 2d61987b3545..ed3a116efd5d 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -222,7 +222,7 @@ void                rpc_put_task(struct rpc_task *);
>  void           rpc_put_task_async(struct rpc_task *);
>  bool           rpc_task_set_rpc_status(struct rpc_task *task, int rpc_st=
atus);
>  void           rpc_task_try_cancel(struct rpc_task *task, int error);
> -void           rpc_signal_task(struct rpc_task *);
> +void           rpc_signal_task(struct rpc_task *, int);
>  void           rpc_exit_task(struct rpc_task *);
>  void           rpc_exit(struct rpc_task *, int);
>  void           rpc_release_calldata(const struct rpc_call_ops *, void *)=
;
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index cda0935a68c9..cdbdfae13030 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -895,7 +895,7 @@ void rpc_killall_tasks(struct rpc_clnt *clnt)
>         trace_rpc_clnt_killall(clnt);
>         spin_lock(&clnt->cl_lock);
>         list_for_each_entry(rovr, &clnt->cl_tasks, tk_task)
> -               rpc_signal_task(rovr);
> +               rpc_signal_task(rovr, -EIO);
>         spin_unlock(&clnt->cl_lock);
>  }
>  EXPORT_SYMBOL_GPL(rpc_killall_tasks);
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 6debf4fd42d4..e88621881036 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -852,14 +852,14 @@ void rpc_exit_task(struct rpc_task *task)
>         }
>  }
>
> -void rpc_signal_task(struct rpc_task *task)
> +void rpc_signal_task(struct rpc_task *task, int sig)
>  {
>         struct rpc_wait_queue *queue;
>
>         if (!RPC_IS_ACTIVATED(task))
>                 return;
>
> -       if (!rpc_task_set_rpc_status(task, -ERESTARTSYS))
> +       if (!rpc_task_set_rpc_status(task, sig))
>                 return;
>         trace_rpc_task_signalled(task, task->tk_action);
>         set_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
> @@ -992,7 +992,7 @@ static void __rpc_execute(struct rpc_task *task)
>                          * clean up after sleeping on some queue, we don'=
t
>                          * break the loop here, but go around once more.
>                          */
> -                       rpc_signal_task(task);
> +                       rpc_signal_task(task, -ERESTARTSYS);
>                 }
>                 trace_rpc_task_sync_wake(task, task->tk_action);
>         }

