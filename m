Return-Path: <linux-nfs+bounces-6359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1D97258C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 01:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777642821F8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052518D634;
	Mon,  9 Sep 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkqQABt5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44A18CC10
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923196; cv=none; b=WmvIs9HH/gNoqVa+8nqwIP3OmPm7lhBwcuLvG6DzhTJ7LLROUuxAxnwxiB5YwK8Mlswe+Y1vSOMDOTKrQU9IDOpS7e2JKzT+IK1uNWVVsmGz24N0u3W3xNegUsPPCrheS9BQ/UBrsV8QV6CaPB/h7uij3D/QDpQYgCwoSeNM11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923196; c=relaxed/simple;
	bh=tA4DWGGXl2wN/3VFbN2IepAYv+ZlqamBVMEW+67Gtp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVNZyhu4FXSrGlFdr0I7Fp4O8Db+OVPi5k1s7W+d2pgC6p7wvNXcW6qL5KFdD7flitv9ZAQHcBVkHCm1TJ0IYhx9eGVJU/IIxUAMAaXb4PC04/RWk0japkBJpgdbjeCwkjq8jtxIdxsgVrWLbuQqhhlAT5me54Yp5bTID2nMWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkqQABt5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206fee0a3d7so71295ad.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2024 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725923194; x=1726527994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aShBmLESaA758ZKF/fFu1kSn26baZ/8Qzf7h76tj0Gg=;
        b=wkqQABt570HHQiPAmy3fxs4uHmc5axYekRsI6+LQjeA3lUVDDccK2QHCZ76Au15d4k
         ly3wjcAIFdF2uKSpiAIfrl8u9QEI8K4eIYkhCjew3KY5a1OvWAeu1mVInys7NlxzAejW
         WscRWf5YqCJ83bAWdrGnBZiRC2TzYRXGNFtC1l2E8RgB3Htz/FflVVuT3SmsN5OYV/5j
         3ADPa54lBXojSse54ZYkDb8ELsWfN31a72ZARkjb0wjbBeHZS6n/nXJ4EVB/XPyiUCMN
         3qSDP4m5GUgg0yTlPryXJVf9cYUlu0SjG62Gp6AV1semDzD5BY5dKORCo60QGmbIydRv
         QZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725923194; x=1726527994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aShBmLESaA758ZKF/fFu1kSn26baZ/8Qzf7h76tj0Gg=;
        b=EVvh44GR5gCTPqGqg3nsgGe8Dv3CSsoFq7XJLR9rk9gF7LHBFoslwgLrHTal3yrgon
         v9xoaVCZ/CA2Mjnq07He9SOGKMT3DdYKfQg0Uji0qVIX6+AmMENOYwQk2OGhbPOYSwdo
         Nqko7/RhZsduwb+J0RoHWVLeiBYObdY8Xc1GPgYqwuXhyqlK0Kfpm+WuIoKUSLple+Yr
         X/7VRvn8Ql6Rw58633cX++JlNJTHNfCnxsi9A+lZ0dBBcVrLt8o2z/G7anDK010agtpj
         5Iu3n0JNmZeZ3BN4QPR0/1DK1kr4EbzokbeRxl7C8XmZx55AiaqLRqoJcKI7UAay2r8l
         jGzw==
X-Forwarded-Encrypted: i=1; AJvYcCXNtYBL4q6IYPewEadkRKpz3dqpI4vqu4NKm7AJkjlD1QfcJWFzjKuLIJAposNZ6Sh9UdF7ah6O/vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdLvjKgt6DsLlnp9gSAokE7FuVz6jg1lL0DXGJvopc+zfeOge
	cDHtSNnI/3jY63RDlO6aQ4+vNKNiXsQbnCUxgE9qgzpKW0zZVgIeKZSA77aVAepGTYCfEmJyz+c
	3K9BCakcLQHnBDXCEL3+WjhyIXV0Bfb9rCs16
X-Google-Smtp-Source: AGHT+IEkl1RiJp8XN4JioEsMZ2jra1Qgct/x2XpU+RcMxsDsTaY/b2vMZRoRdd8MaezkBBSKSZKew7Xjwwe+1O5GRiE=
X-Received: by 2002:a17:902:dacd:b0:201:e646:4ca with SMTP id
 d9443c01a7336-20744a38838mr1137015ad.14.1725923194141; Mon, 09 Sep 2024
 16:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
 <20240909163610.2148932-1-ovt@google.com> <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
In-Reply-To: <84f2415b4d5bb42dc7e26518983f53a997647130.camel@hammerspace.com>
From: Oleksandr Tymoshenko <ovt@google.com>
Date: Mon, 9 Sep 2024 16:06:21 -0700
Message-ID: <CACGj0ChtssX4hCCEnD9hah+-ioxmAB8SzFjJR3Uk1FEWMizv-A@mail.gmail.com>
Subject: [PATCH] NFSv4: fix a mount deadlock in NFS v4.1 client
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>, "jbongio@google.com" <jbongio@google.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:56=E2=80=AFAM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Mon, 2024-09-09 at 16:36 +0000, Oleksandr Tymoshenko wrote:
> > > > nfs41_init_clientid does not signal a failure condition from
> > > > nfs4_proc_exchange_id and nfs4_proc_create_session to a client
> > > > which
> > > > may
> > > > lead to mount syscall indefinitely blocked in the following stack
> >
> > > NACK. This will break all sorts of recovery scenarios, because it
> > > doesn't distinguish between an initial 'mount' and a server reboot
> > > recovery situation.
> > > Even in the case where we are in the initial mount, it also doesn't
> > > distinguish between transient errors such as NFS4ERR_DELAY or
> > > reboot
> > > errors such as NFS4ERR_STALE_CLIENTID, etc.
> >
> > > Exactly what is the scenario that is causing your hang? Let's try
> > > to
> > > address that with a more targeted fix.
> >
> > The scenario is as follows: there are several NFS servers and several
> > production machines with multiple NFS mounts. This is a containerized
> > multi-tennant workflow so every tennant gets its own NFS mount to
> > access their
> > data. At some point nfs41_init_clientid fails in the initial
> > mount.nfs call
> > and all subsequent mount.nfs calls just hang in
> > nfs_wait_client_init_complete
> > until the original one, where nfs4_proc_exchange_id has failed, is
> > killed.
> >
> > The cause of the nfs41_init_clientid failure in the production case
> > is a timeout.
> > The following error message is observed in logs:
> >   NFS: state manager: lease expired failed on NFSv4 server <ip> with
> > error 110
> >
>
> How about something like the following fix then?
> 8<-----------------------------------------------
> From eb402b489bb0d0ada1a3dd9101d4d7e193402e46 Mon Sep 17 00:00:00 2001
> Message-ID: <eb402b489bb0d0ada1a3dd9101d4d7e193402e46.1725904471.git.tron=
d.myklebust@hammerspace.com>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Mon, 9 Sep 2024 13:47:07 -0400
> Subject: [PATCH] NFSv4: Fail mounts if the lease setup times out
>
> If the server is down when the client is trying to mount, so that the
> calls to exchange_id or create_session fail, then we should allow the
> mount system call to fail rather than hang and block other mount/umount
> calls.
>
> Reported-by: Oleksandr Tymoshenko <ovt@google.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4state.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 30aba1dedaba..59dcdf9bc7b4 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2024,6 +2024,12 @@ static int nfs4_handle_reclaim_lease_error(struct =
nfs_client *clp, int status)
>                 nfs_mark_client_ready(clp, -EPERM);
>                 clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
>                 return -EPERM;
> +       case -ETIMEDOUT:
> +               if (clp->cl_cons_state =3D=3D NFS_CS_SESSION_INITING) {
> +                       nfs_mark_client_ready(clp, -EIO);
> +                       return -EIO;
> +               }
> +               fallthrough;
>         case -EACCES:
>         case -NFS4ERR_DELAY:
>         case -EAGAIN:
> --

This patch fixes the issue in my simulated environment. ETIMEDOUT is
the error code that
was observed in the production env but I guess it's not the only
possible one. Would it make
sense to handle all error conditions in the NFS_CS_SESSION_INITING
state or are there
some others that are recoverable?

