Return-Path: <linux-nfs+bounces-3535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06D8D877A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 18:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F571F21C61
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53713699A;
	Mon,  3 Jun 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXfI7+N0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A5C4A0A;
	Mon,  3 Jun 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433667; cv=none; b=d65UKEjWerQFQP7kHIol60sj2oxnxQjey8quqrV//VFhqlnIAdgebcWxPJJYvKtFMNUufoodsH/Qh0M726jhOEUChmfkAahOtns6ucf0j2o7fv8dL2XZ+IqmKQKVf6IQ819lqnm6tCGbAP9uRJJLg1FjtBYuBjz2xmQwqVZGV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433667; c=relaxed/simple;
	bh=HAaepxHa9F72g6c4hBnD+/yrkFhlceFX650wgnR1RcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0FjCGhxyePp3IDCv9W4/TF4T1sCa3LexLDEHtn3SDL9P83IaAC23QNbZL1Sd52RcBiSuv+xDy1FMsC0mljTw54JN9UYlmx8K852zfxQtQucXlWO2FHwOl97ovR8LdppRRPV3A/o8eFpMrzcGV7uM8+FelVE5RFBSyFLtTmsDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXfI7+N0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5295e488248so4838838e87.2;
        Mon, 03 Jun 2024 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717433663; x=1718038463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47H0+xvN6UJDfg+bE4PBnpgKUhLHZ/qDT6y/DHtr0pE=;
        b=DXfI7+N0ZNbyF3B38j6wSD2262Lms6pLWRVI3tOrR2tNIoF9tVb8ok9s2boi/FpOL8
         ASurdNDDtpNsE7jBhnSHCCD0oU8EsnoBn/dOkXdDun7iKSKTeHFg2g2Qb3x8/n372E5w
         FEJc35JqEwAU/upLwQS+CrZedsAZhjUhuLm/RuDQKzJaJYLob+Bp5kNfOAtM4aI4iBJa
         QLqk6jtPf75LO2XPixJtLOjd1ryRmhFzgjvG9lsaLXR/KDpnp0a+wLz1b7NbGSv08xod
         24azWP4lnFp54JysRD50lDuPxxg/e9dTU1vdoFI+jEvuUxpW5MsFNYTkDBjyjcxWqjon
         66wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433663; x=1718038463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47H0+xvN6UJDfg+bE4PBnpgKUhLHZ/qDT6y/DHtr0pE=;
        b=TmVOrw8rn2M8stwSR/KLApSRSjK4esZFou96JB7F/TqFOSHn+BuokX90h1b/i1O+zJ
         KFNjvAAidS5O4NAZkJYLQ53isnN6XtgBgLrspbgUeJxTcbVDj0k8k7kjRav0c5DxkWYK
         fsw8VHdCINXBQiy7wfcqwy5VZqTxZQj45YNCM3MVl3Wt6ItnEjV0nNaACNhw2R5+4uE2
         FH4kmEIQ47mVUybAM5iRSBNt9lLv+VXOaIyNDtu06CGT5LDWOFg2BEHC6WzeEz5PnRPe
         tc9HV/C4lumrgrBlph5AdqOICbJ0xPAgaQKXRXpX73gJTLbmYPubLRxeA4Tbu6+JN9cr
         NIMA==
X-Forwarded-Encrypted: i=1; AJvYcCUFkjKDFuxR7UF/e54hzbCeXF+X/RY7B15x82SL31n2HnCzpwthK9Vy5Thof8XyT3P5LsC5aaUFmkouqjDqHrhTde+/LlNZMIyDVw==
X-Gm-Message-State: AOJu0YyDa1tcdX29WR4iXmEEIcjS9+3utTXJki++MUAOyLXv+VEJN4+Y
	eP3CRyIhOkshVUB6XM5HlnbfLmQfEC6jLABYqFLE0CU5hEXyLjRh7FxMT/D6wYJ1qFzQ6hohV3y
	Fk40yQxpcKCJA2QZJwikSI/1xx86IIZhw
X-Google-Smtp-Source: AGHT+IFF/jXw5oN5RTe6AGcsyvsBXFxwbmFlCUtsxGMEmBJ1mY2aGQ8e43THkkmwqY7i+BJEG6i7ECs1As+/xa8DMyc=
X-Received: by 2002:a05:6512:2009:b0:523:bbcd:ed5f with SMTP id
 2adb3069b0e04-52b895a0b0fmr5479842e87.33.1717433662558; Mon, 03 Jun 2024
 09:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152537.212958-6-cel@kernel.org> <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com> <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
 <675A3584-6086-45D4-9B31-F7F572394144@oracle.com> <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
 <F2726F77-06F9-4DB4-B2A8-97F21B045A6F@oracle.com> <CAD=hENdL3v6gMpU7SBdkLjcyuEhzCvTRxt3+N+8m6ybuVKGHwA@mail.gmail.com>
 <953940CF-98DE-4727-8E32-066CC4B3E8B2@oracle.com>
In-Reply-To: <953940CF-98DE-4727-8E32-066CC4B3E8B2@oracle.com>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Mon, 3 Jun 2024 18:54:11 +0200
Message-ID: <CAD=hENdTMVXB-3w3j3WDMBjUcuE7eRWZ1itZcc8==szWCe4KbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:59=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Jun 2, 2024, at 2:14=E2=80=AFPM, Zhu Yanjun <zyjzyj2000@gmail.com> w=
rote:
> >
> > On Sun, Jun 2, 2024 at 5:40=E2=80=AFPM Chuck Lever III <chuck.lever@ora=
cle.com> wrote:
> >>
> >>
> >>> On Apr 30, 2024, at 10:45=E2=80=AFAM, Zhu Yanjun <zyjzyj2000@gmail.co=
m> wrote:
> >>>
> >>> On 30.04.24 16:13, Chuck Lever III wrote:
> >>>> It is possible to add rxe as a second option in kdevops,
> >>>> but siw has worked for our purposes so far, and the NFS
> >>>> test matrix is already enormous.
> >>>
> >>> Thanks. If rxe can be as a second option in kdevops, I will make test=
s with kdevops to check rxe work well or not in the future kernel version.
> >>
> >> As per our recent discussion, I have added rxe as a second
> >> software RDMA option in kdevops. Proof of concept:
> >
> > Thanks a lot. I am very glad to know that rxe is treated as a second
> > software RDMA option in kdeops.
> > And I also checked the commit related with this feature. It is very
> > complicated and huge.
>
> I split this into four smaller patches, HTH.
>
>
> > I hope rxe can work well in kdeops.
> > So I can also use kdeops to verify rxe and rdma subsystems.  Thanks a
> > lot your efforts.
> >
> >>
> >>  https://github.com/chucklever/kdevops/tree/add-rxe-support
> >>
> >> But basic rping testing is not working (with 6.10-rc1 kernels)
> >> in this set-up. It's missing something...
> >
> > Just now I made tests with the latest rdma-core (rping is included in
> > rdma-core) and 6.10-rc1 kernels. rping can work well.
> >
> > Normally rping works as a basic tool to verify if rxe works well or
> > not.  If rping can not work well, normally I will do the followings:
> > 1. rping -s -a 127.0.0.1
> >    rping -c -a 127.0.0.1 -C 3 -d -v
> >    This will verify whether rxe is configured correctly or not.
>
> I don't have rxe set up on loopback, so I substituted the host's
> configured Ethernet IP.
>
> The tests works on the NFS server, but the rping client hangs
> on the NFS client (both running v6.10-rc1).
>
> I rebooted in to the Fedora 39 stock kernel, and the rping tests
> pass.
>
> However, when I try to run fstests with NFS/RDMA using rxe, the
> client kernel reports a soft CPU lock-up, and top shows this:
>
>     115 root      20   0       0      0      0 R  99.3   0.0   1:03.50 kw=
orker/u8:5+rxe_wq

rxe_wq is introduced in the commit 9b4b7c1f9f54 "RDMA/rxe: Add
workqueue support for rxe tasks".
And this commit is merged into kernel v6.4-rc2-1-g9b4b7c1f9f54.

And the Fedora 39 stock kernel is kernel 6.5. So maybe some commits
between 6.5 and 6.10 introduce this problem.

>
> So I think this is enough to show that the Ansible parts of this
> change are working as expected. I can push this to kdevops now
> if there are no objections, and someone (maybe you, maybe me) can
> sort out the rxe specific issues later.

Thanks. After I can reproduce this problem in my local host, I am very
glad to delve into this problem. Perhaps it will take me a long time
since I do not have a good host to deploy kdeops.

To be honest, perhaps "git bisec" can find the commit that introduce
this problem. If you can find the commit, we can fix this problem very
quickly^_^

Thanks,
Zhu Yanjun

>
>
> > 2. ping -c 3 server_ip on client host.
> >    This will verify whether the client host can connect to the server
> > host or not.
> > 3. rping -s -a server_ip
> >    rping -c -a server_ip -C 3 -d -v
> >    1) shutdown firewall
> >    2) tcpdump -ni xxxx to capture udp packets
> > Normally the above steps can find out the errors in rxe client/server.
> > Hope the above can help to find out the errors.
> >
> > Zhu Yanjun
> >
> >>
> >> --
> >> Chuck Lever
> >>
> >>
>
> --
> Chuck Lever
>
>

