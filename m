Return-Path: <linux-nfs+bounces-5946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481659645B2
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 15:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBB828400A
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AA196DA4;
	Thu, 29 Aug 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAep5L+M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8D22339;
	Thu, 29 Aug 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936621; cv=none; b=Q/TD3pAc0JMXnMCLF8kN3CtFLdOKkyFZ153imr2am4KP/+a+dfJzoGJ0jp8MAUT879Scszq0QlaVIWwSp2fnnTbNrZTtAcUmjItqD33ZCV9iaoT3zQeII0ZcY2Z+R7xkTYK1WLp2kRcBBRDIzwSKEh0M97lBS8KPEh95v49U1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936621; c=relaxed/simple;
	bh=ywBHh/JxTt6YtGlc4uMSl9mEGuK+/Sv7BhGHLqH9AWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7w89MzcB/6Y+Ei2xsDbym6yr8egUyi0aCS+PXiUtCBKb8SqdUHmri9cON/OoZpgs56rM29fShIuLM5k9NlearTYvc24e/PXjuNFF0iX0uc9L1dom9cno/Y+AGW2HmofOu3wRDnCOu9I9XvnZC4Pxxvrdm/HAIbPMM1RruuDoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAep5L+M; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5dfa315ffbdso221593eaf.3;
        Thu, 29 Aug 2024 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724936619; x=1725541419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgPkNNrjHTsfiVhNKwoTvKC+dngWh8S1qXD5HQVi94w=;
        b=JAep5L+Mks8rZEsURm2GZColXYle//QVttVl8ZJ6fp9MTfVfxa4D24tUKNYs7EpDEk
         Jnw5L9JOjwOCVeGov26e1bAwXOwnEksCJ7XH1aTCwOwRhJSGpFbjjRUo3Mk/2GHENk38
         xk2oSnLnig5WbzBfBupFikwTexJftl+yj6pCsJVSy+qhxYW1NyDVtZJPugYXThpKo4jI
         rYsY7toZb65QJx8Bw7XLgrgeMxMnnVu2hny06SlDFGJ3VCWpxeeYI5D4NufyRMjS4GgF
         uus0RAs2MYlyjUqNDnUqSQZYvzmeWfh7fpIafTcWf3ag7kSnN0rXZnQNN3TjUC9m8eaT
         n4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936619; x=1725541419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgPkNNrjHTsfiVhNKwoTvKC+dngWh8S1qXD5HQVi94w=;
        b=YFEGugqxmtkPqT1erEuWtPsijjl0OHQa49ReJo9cE/ihGmkIm7ycu/OQewR8GEQRH0
         z1nYJGBTlkl/gEzmSN4jxO81tkbOdPyZRTUaxISxEckm8QXQmKcID90In+5hPJmyG4rR
         LGvhiyuB24nKBt6A6amh/Rt5VWlfX85HXvdIitjlKamNouEqRnC7YjcgWYveq18m6Yjp
         LA85SAbR3Xmb4FgNLtaqZJZSn0XYnYkShsUruNm/FLc7oEWSzLeeMEa7TUDRI8EQcbJw
         o2o6aJ0W7MdAQleOYMS4/OZ0E1RAmBe+v+JTQI9gxDM4NYxxwDrRo/Xw/m7A33JyXMD3
         FnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsDlcENBvxmvK0G8G56xPMxRH5paKeCpe3H6LQqlYGp4/+H6ypxhdj4AHDBk+wy7PiohWlfHvhmtGI3bxUx7VGzAw2mj/0@vger.kernel.org, AJvYcCVjFK5X4aDPPbXXFBazUKZEA/O3jabG9WgEFabqzmHN9iTcye2J1k1xV2hNsnDru7PAkelDc6ufJg==@vger.kernel.org, AJvYcCXDwPJBfYfo8OcFDE5W6QA6DUS7tH9oGrWAyyI9s49ybThfGJmkB4pFkbkvu1telLkwBQZu6ikgsk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGUH76oMYdSZFYiEW4T683uqlSMFYYCCqa/681wOP0DlFBONC
	eKI4BRwklC0Jz1+QpQ65T4LSR+MClC9gzNZMeG6VZVK3pg25oIHJhhc6IDRN/eG6SKwKmC8fJUC
	biCCFStJTzjZH29pKphk63sIRlAs=
X-Google-Smtp-Source: AGHT+IGS245lP9KZgpIxgJhwvHOxjn1YcH7WR7eVns7BHxRAJv4FhnyTZpanlEUZI1VaqEQ1vrmMfq53yo3lxpxdhp8=
X-Received: by 2002:a05:6358:7253:b0:1b1:a803:d9f7 with SMTP id
 e5c5f4694b2df-1b603c2024fmr359532355d.7.1724936618733; Thu, 29 Aug 2024
 06:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195129.223395-1-smayhew@redhat.com> <20240828195129.223395-2-smayhew@redhat.com>
 <3647023f1f4c1326ba3d67ff04c5b84b4896c1bc.camel@kernel.org>
In-Reply-To: <3647023f1f4c1326ba3d67ff04c5b84b4896c1bc.camel@kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 29 Aug 2024 09:03:25 -0400
Message-ID: <CAEjxPJ49pt9QMXt=Ssf83kcJ5r3tF6_Hp4sVn_5OT=uNVkCy3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
To: Jeff Layton <jlayton@kernel.org>
Cc: Scott Mayhew <smayhew@redhat.com>, paul@paul-moore.com, casey@schaufler-ca.com, 
	chuck.lever@oracle.com, marek.gresko@protonmail.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:15=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2024-08-28 at 15:51 -0400, Scott Mayhew wrote:
> > Marek Gresko reports that the root user on an NFS client is able to
> > change the security labels on files on an NFS filesystem that is
> > exported with root squashing enabled.
> >
> > The end of the kerneldoc comment for __vfs_setxattr_noperm() states:
> >
> >  *  This function requires the caller to lock the inode's i_mutex befor=
e it
> >  *  is executed. It also assumes that the caller will make the appropri=
ate
> >  *  permission checks.
> >
> > nfsd_setattr() does do permissions checking via fh_verify() and
> > nfsd_permission(), but those don't do all the same permissions checks
> > that are done by security_inode_setxattr() and its related LSM hooks do=
.
> >
> > Since nfsd_setattr() is the only consumer of security_inode_setsecctx()=
,
> > simplest solution appears to be to replace the call to
> > __vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
> > fixes the above issue and has the added benefit of causing nfsd to
> > recall conflicting delegations on a file when a client tries to change
> > its security label.
> >
> > Reported-by: Marek Gresko <marek.gresko@protonmail.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218809
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  security/selinux/hooks.c   | 4 ++--
> >  security/smack/smack_lsm.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index bfa61e005aac..400eca4ad0fb 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6660,8 +6660,8 @@ static int selinux_inode_notifysecctx(struct inod=
e *inode, void *ctx, u32 ctxlen
> >   */
> >  static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u=
32 ctxlen)
> >  {
> > -     return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_S=
ELINUX,
> > -                                  ctx, ctxlen, 0);
> > +     return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_S=
ELINUX,
> > +                                  ctx, ctxlen, 0, NULL);
> >  }
> >
> >  static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u3=
2 *ctxlen)
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 4164699cd4f6..002a1b9ed83a 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -4880,8 +4880,8 @@ static int smack_inode_notifysecctx(struct inode =
*inode, void *ctx, u32 ctxlen)
> >
> >  static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32=
 ctxlen)
> >  {
> > -     return __vfs_setxattr_noperm(&nop_mnt_idmap, dentry, XATTR_NAME_S=
MACK,
> > -                                  ctx, ctxlen, 0);
> > +     return __vfs_setxattr_locked(&nop_mnt_idmap, dentry, XATTR_NAME_S=
MACK,
> > +                                  ctx, ctxlen, 0, NULL);
> >  }
> >
> >  static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 =
*ctxlen)
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Passes all the NFS tests in the selinux-testsuite, and also correctly
denies root the ability to relabel a file on a root_squash mount but
allows a normal user to do so (as expected).

