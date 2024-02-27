Return-Path: <linux-nfs+bounces-2090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDED868742
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 03:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435F81C20BA1
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 02:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120261096F;
	Tue, 27 Feb 2024 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="GMk/iD7H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D22FBEA
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001336; cv=none; b=ZeVSPQF4hIDcEfgvvoMuoIOt/z8kPorn7E2ezq+KUYW75nYpRz42M3KU8Z+AxJ63hrulbFkfnT/qft9/mO8zFvC+cb+azO0fbfUkGoPvedSsryZuCu1Fpas4Fl1QvAc1y+fDwCsMdNH1eJ4BkVY0wSXBlYG+G0LRg07XaXxWHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001336; c=relaxed/simple;
	bh=+WfWLLdlNtMxWIq9oOlRKvGDVzmoSPZNFK8huJBz8wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBYXqgsEA07SXRxwvAiWQgneMAIuY7CVlIGNFnDBVV5Sybd7ApOUsy47zlkOsfcMWw2fF0i1p5477nrqwHE4VudVxscXlLQJA3CrPUafL8rzgO75O6rTM9giypG2xkl1bZJQhyG5kHkHl/UngyJYImjD4GaXmHKuOuXVxGFslwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=GMk/iD7H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso4652233e87.3
        for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 18:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709001332; x=1709606132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI97VzBaVCf4+xb5j7PxEbProXaTPOOrgDbZrH3Bdpc=;
        b=GMk/iD7HTgERjfO/cIQnYsn5GI2Ioxh4LoEHIdZ+NpSAr7d8z2cDkdWUHGDbWWIM4l
         pW2/s93zwkH8EmBHKlz8XpehHrXlL2/RjSb96BQnq+ws9dRZdal0u1hCOQzjBe73OWD5
         p5y7ppfzBGbTXk9EkrUJVcHLVYjwAek0MGgss6E7RCm+hfmGRCvLhvFl0U2cGxyZ7wZn
         iKsKrl76lsGzTUAaC71L5S3GQUAe27vxCLyk06PYZW37k3h9JyMMn4ECjoqmmvoBLWsy
         0oCpXk2Ek6lHwwhBGYOQdGpjcTDZZEFUY6bGW3uLQjskDhRClfs8lct2ecmbec3op4od
         ha1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709001332; x=1709606132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI97VzBaVCf4+xb5j7PxEbProXaTPOOrgDbZrH3Bdpc=;
        b=H0Rc5VxZkg8J4u7vwtBBJUTc74FAfDU8XMfR9Mnp9M94sYg+BYo9RC+r5kvg8xfZlQ
         5lWTnOXM6r+HS+TeWp6k7LQKxv+v0KNX41+M7LBuCVfn1foBZ0EUe+ZYq3iwjd+OK+dF
         tkil6+XI5uuZ9VK0Repwgkkew8H2Qd1blEMrgtGKseSzQONyRzPbDj7gcZAl6NqzB6B9
         0/ktxVxHBIolwjf1tgMVGjA+p9MB/25WzZoAagCFZafdmjKPQkGBMo03f2cufdtxNPEo
         K4sGz/ScnAMLHSwL9BgQ72NI+Mpm0QI9vdYdaEljCh7GVopJqy8SImXCKb95s6kJTdrv
         VjqA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8qmvwKL7bPlkBQC5O8HFHwMkDVuja7RR/OoAWQqnVJqadlMKbP/xsq0cJNTDPi9xiwI8Ceff+6diR0M1sSL2cdwM/aHOK1rb
X-Gm-Message-State: AOJu0YyK2K8LCo92AERiZu+j+DkLB82fP0acLxolAGLSJa5lRJyI9sbn
	9AF6FJztBbqMuzmCPtDAV7Ew5lZjYd42r14KHWryD4u6B6IyRUi3tB7J/6mTRoluURmkshhRSxn
	Bf/4dLUltbxkCAT99A7Ox/6JnfDUIOsPFHW8uWQ==
X-Google-Smtp-Source: AGHT+IHJdcA7m7C/cGI4NlpDKJ4xJM64IpsCapG/41px13WYZP3tlzBB7EnOQTt+iHLnJCUSYvpQZ7xxOI1B96jImr0=
X-Received: by 2002:a05:6512:1187:b0:512:bce5:1e0f with SMTP id
 g7-20020a056512118700b00512bce51e0fmr4693783lfr.64.1709001331988; Mon, 26 Feb
 2024 18:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
 <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>
 <16d8c8e88490ee92750b26f2c438e1329dea0061.camel@hammerspace.com> <3754ac34c55dd82a4957967ec0a4e490cdc0d989.camel@kernel.org>
In-Reply-To: <3754ac34c55dd82a4957967ec0a4e490cdc0d989.camel@kernel.org>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Tue, 27 Feb 2024 10:35:18 +0800
Message-ID: <CAPKjjnq0=HG5_iC91tjqU_pJp00Q+ffo0m=7Sk-8PbbAPv1+Cw@mail.gmail.com>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: Trond Myklebust <trondmy@hammerspace.com>, Jeff Layton <jlayton@kernel.org>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, "kolga@netapp.com" <kolga@netapp.com>, 
	"anna@kernel.org" <anna@kernel.org>, "tom@talpey.com" <tom@talpey.com>, "neilb@suse.de" <neilb@suse.de>, 
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "huangping@smartx.com" <huangping@smartx.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there any plan for this ERESTARTSYS leak issue?

--
Zhitao Li, at SmartX

On Fri, Feb 23, 2024 at 6:31=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2024-02-22 at 15:20 +0000, Trond Myklebust wrote:
> > On Thu, 2024-02-22 at 06:05 -0500, Jeff Layton wrote:
> > > On Wed, 2024-02-21 at 13:48 +0000, Trond Myklebust wrote:
> > > > On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > > > > [You don't often get email from zhitao.li@smartx.com. Learn why
> > > > > this
> > > > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > >
> > > > > Hi, everyone,
> > > > >
> > > > > - Facts:
> > > > > I have a remote NFS export and I mount the same export on two
> > > > > different directories in my OS with the same options. There is an
> > > > > inflight IO under one mounted directory. And then I unmount
> > > > > another
> > > > > mounted directory with force. The inflight IO ends up with
> > > > > "Unknown
> > > > > error 512", which is ERESTARTSYS.
> > > > >
> > > >
> > > > All of the above is well known. That's because forced umount
> > > > affects
> > > > the entire filesystem. Why are you using it here in the first
> > > > place? It
> > > > is not intended for casual use.
> > > >
> > >
> > > While I agree Trond's above statement, the kernel is not supposed to
> > > leak error codes that high into userland. Are you seeing ERESTARTSYS
> > > being returned to system calls? If so, which ones?
> >
> > The point of forced umount is to kill all RPC calls associated with the
> > filesystem in order to unblock the umount. Basically, it triggers this
> > code before the unmount starts:
> >
> > void nfs_umount_begin(struct super_block *sb)
> > {
> >         struct nfs_server *server;
> >         struct rpc_clnt *rpc;
> >
> >         server =3D NFS_SB(sb);
> >         /* -EIO all pending I/O */
> >         rpc =3D server->client_acl;
> >         if (!IS_ERR(rpc))
> >                 rpc_killall_tasks(rpc);
> >         rpc =3D server->client;
> >         if (!IS_ERR(rpc))
> >                 rpc_killall_tasks(rpc);
> > }
> >
> > So yes, that does signal all the way up to the application level, and
> > it is very much intended to do so.
>
> Returning an error to userland in this situation is fine, but userland
> programs aren't really equipped to deal with error numbers in this
> range.
>
> Emphasis on the first sentence in the comment in include/linux/errno.h:
>
> -------------------8<-----------------------
> /*
>  * These should never be seen by user programs.  To return one of ERESTAR=
T*
>  * codes, signal_pending() MUST be set.  Note that ptrace can observe the=
se
>  * at syscall exit tracing, but they will never be left for the debugged =
user
>  * process to see.
>  */
> #define ERESTARTSYS     512
> #define ERESTARTNOINTR  513
> #define ERESTARTNOHAND  514     /* restart if no handler.. */
> #define ENOIOCTLCMD     515     /* No ioctl command */
> #define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_sysca=
ll */
> #define EPROBE_DEFER    517     /* Driver requests probe retry */
> #define EOPENSTALE      518     /* open found a stale dentry */
> #define ENOPARAM        519     /* Parameter not supported */
> -------------------8<-----------------------
>
> If these values are leaking into userland, then that seems like a bug.
> --
> Jeff Layton <jlayton@kernel.org>

