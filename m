Return-Path: <linux-nfs+bounces-5896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA929963532
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 01:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6946628608E
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A379158DCD;
	Wed, 28 Aug 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LnH1ZQv0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D51AD9D3
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886542; cv=none; b=tfyZ56CHrG+jpexWAsrOFSGiJPkLIhAmJMVkzs0FLKm4ZKG/F9GpX17JifcQPOMetfqZO3QOqXWbKnjLRg+AXUHLjxgUZTedzMY0jUqFY85kR/uhrxXvm5Cb6RQhit70q6P2lvosZaCw5SQ6PFQ/sMYbwy8aGjad9z8fmeIqhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886542; c=relaxed/simple;
	bh=S6khVv2K3zqenjuZaXHlbsGEquUo21R2DNwX+2TYioE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsKpClNmhWI+XV90rXNYuONJr9OOFoLdTYMQuzrW57Wm683M9hMl5fE38T65QnU1meymE89tXtZQm0CjTIQZJIj99dlXuirllQaOtGPUkJKdJF0e4TocIOM7KM7cKXRkBwhIG9wrYM7MTLQ3d4JoMJba2Em56j/PwyV+Ixu3AgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LnH1ZQv0; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso57724276.1
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724886539; x=1725491339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rnWaW1Wi74NhhYke8yxwRLmARuCVrhloji7XbjFHLI=;
        b=LnH1ZQv0ZHuja0G36rmHXCT8JSxeoSsmb2yhdq7+qHPq55Vlgal5H0kmiSZb5MR3K7
         O/UT9AYDEtST5/OTsxlPml2JBUYsKFA5N6/a3KyDT8qwxUKbfkXzsqZJ0Xg6hRjYC0zI
         4wHAovacb9n0+Ya+QlAgN2/4kb9QyrLukXFpseHy6oEVmdT/s6KWxA7C0dVfcmutSh3t
         6sfZMM4IukDUqy43xog9rqOG5fI3ILOv2tyNHJ6/55HyZP3w08oKtAfG+XiRWt/2YvQ9
         lj6aHf7yBuv1kYYESooMUVZhFsZ2J8RYzW8WZ+NqaLJsSDNZrHEiZVlDnxeQ2h91sPFs
         f3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886539; x=1725491339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rnWaW1Wi74NhhYke8yxwRLmARuCVrhloji7XbjFHLI=;
        b=TeD+ub1EInZfkW6dN1W3WhlYBOPV1hPCXBFKjnm2vDeu2PhACMQWoPdtpPexGl7kg4
         D6N248c5iP5FoIpZw29WptxzzDiDfj4F4vy/kiI9wpB1+Xzqb4t8jIXHFvQ4foJXd+kk
         RBY//DE+5iM80Y0QexHm/ihbVOqPneatcn8Cvg6hmhbpXhqpr9B35awPzeJ83jCwiA4J
         yYpADNC/sUMpuTgIlRapV2mekpHLCs+x6zwQ0Q8yDJ7f8nd0lZubEq0XiP3hL/EaEje1
         z2WMbMelIfpk3t/cP2bs6P/qejjFaoJhAzd6H0QVCUQuob5/Ud67HuZ5wbrtYlBQlXHR
         0A0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9QnBp3Q0nOtpOvVGaKtGeDVR2VE43d4JoH8BzciOJ5EnFOZS6ayjgh2wUGnhchEInnTA76RzGyd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNBDhQPZ0po4XC7ybjADidQdFSgc4KkF6ZHZJzrxjfQoTBvLI
	XDI/n4I8k109LZHdlpV7EOWjuJeY4wi1jXGzf2FZrEeh4frZUiwRr+VWXC4wJEWnr1PD/oQEphP
	tF1jxhNhZh/wstsP0nuIqVJMlVyz0JI9f1fkE
X-Google-Smtp-Source: AGHT+IGGXa0V8oGxUH3v22rH7vhuHhw9UfTo9cOdvs7DK/8DvFvDweL505TqKuvwIrMUiZgtV173ulYyn2z+iRorJiU=
X-Received: by 2002:a05:690c:6512:b0:64a:4728:ef8 with SMTP id
 00721157ae682-6d277f51e62mr11216887b3.44.1724886539569; Wed, 28 Aug 2024
 16:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195129.223395-1-smayhew@redhat.com> <20240828195129.223395-2-smayhew@redhat.com>
 <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com> <70639b16-d48c-4465-80f5-4192c9d86b36@schaufler-ca.com>
In-Reply-To: <70639b16-d48c-4465-80f5-4192c9d86b36@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Aug 2024 19:08:48 -0400
Message-ID: <CAHC9VhRDD76EnuXAbK1wPVCP5X-Fu9AytxC2bD3vvApLjzak6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Scott Mayhew <smayhew@redhat.com>, stephen.smalley.work@gmail.com, 
	chuck.lever@oracle.com, marek.gresko@protonmail.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:29=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 8/28/2024 2:05 PM, Paul Moore wrote:
> > On Wed, Aug 28, 2024 at 3:51=E2=80=AFPM Scott Mayhew <smayhew@redhat.co=
m> wrote:
> >> Marek Gresko reports that the root user on an NFS client is able to
> >> change the security labels on files on an NFS filesystem that is
> >> exported with root squashing enabled.
> >>
> >> The end of the kerneldoc comment for __vfs_setxattr_noperm() states:
> >>
> >>  *  This function requires the caller to lock the inode's i_mutex befo=
re it
> >>  *  is executed. It also assumes that the caller will make the appropr=
iate
> >>  *  permission checks.
> >>
> >> nfsd_setattr() does do permissions checking via fh_verify() and
> >> nfsd_permission(), but those don't do all the same permissions checks
> >> that are done by security_inode_setxattr() and its related LSM hooks d=
o.
> >>
> >> Since nfsd_setattr() is the only consumer of security_inode_setsecctx(=
),
> >> simplest solution appears to be to replace the call to
> >> __vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
> >> fixes the above issue and has the added benefit of causing nfsd to
> >> recall conflicting delegations on a file when a client tries to change
> >> its security label.
> >>
> >> Reported-by: Marek Gresko <marek.gresko@protonmail.com>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218809
> >> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> >> ---
> >>  security/selinux/hooks.c   | 4 ++--
> >>  security/smack/smack_lsm.c | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> > Thanks Scott, this looks good to me, but since it touches Smack too
> > I'd also like to get Casey's ACK on this patch;
>
> Testing labeled NFS has always been a challenge for the somewhat
> limited resources available to the Smack project. I'll Ack the patch,
> but won't claim to have tested it.

Understood, thanks for the quick reply.

--=20
paul-moore.com

