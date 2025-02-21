Return-Path: <linux-nfs+bounces-10245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DCA3EB63
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 04:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC2419C52AA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 03:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BA1519A2;
	Fri, 21 Feb 2025 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EaSRICvW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9691CAAC
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740108641; cv=none; b=qvtwFrAFxiRm3gNuxN78WKO69jGLn9wtCiIv3ahUz5ghAbW/O5u9Y+P+AhdumsueniMLSV0l3g5AOSCMtbqzVy6CrloaWBl1g1ivTBL+vT+hhVp/tR94x4btRD8OtWdAudKHxv2HQKqZJJjaDrxsxO9CejscBozDN+zq4tjoe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740108641; c=relaxed/simple;
	bh=eNC9ZuejUvdpqu5WNpeuhEOoPI/+DOEicU46P4QdZZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8xNeth8cwvQyapHdDWb2hm6MpeRFR2IWRHw61Eottw2soQWLezxKh6p8H36lRunXFA0J2N5WwFBjt6HciaMlGGicj8I1y0BLieLlzTL/DkXLmOOowY/V8V3yYKFi9MqKR7mWR2DBTM2Ps1H7JkNZBnXZVl9DATc9sfre2PVR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EaSRICvW; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4ba0eb3b0f9so518786137.0
        for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 19:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740108637; x=1740713437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jhxEXkcJolsUqGmM9PW7X2Wli6iSVP3m68cQMuMSGo=;
        b=EaSRICvWkeUTP/1qVNR6CLhbACmm5yumTZEjKWwwitxmMCDltjVPvWcVuRyrhOO8si
         Ot0nL9clV39+Glzpn0Ol8jzWKvDoh569YM5ybl2nnxiAnCfgce9tQE+oUvwTcuVuQbNx
         I5PKWJMNLR5HrJS2wS9rZXkTIqKGJN//MN7D+xH0lZRk8CAxZciYxvxKrJ8wxYoOL53f
         7WzqNmA2P7NZtthAcakS8uLjFAXlRqnNbg1kff53lzvQwtuhrnEiPxtMQxnOUCCanse9
         lKRcHwmvfrJz+vLTljmwiVEKAfFrSV7yc/7+Y6ON5hm2LwFBCuGu9oS8pASPriyGE3HW
         Jq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740108637; x=1740713437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jhxEXkcJolsUqGmM9PW7X2Wli6iSVP3m68cQMuMSGo=;
        b=fqy3FhP0Qmou5chBDZxpEs+4F6Kmmlapw7Ig03wJNrdzHtKPq2BAeKg1aQgwuEpTYW
         9K0cyeOqdxGh7GL/ictth7Mn6fmdkxhbXKMe63xVo/Yg1h/Ns6SbcxjuUfHeGfnznQVn
         s+Sxnq9BbJox0mkDIgnQB8lNysLQucxEuZ/NXf0kHKD8z5GIae+c/CCGpemh7UErfmAh
         cJUz9AdgjEo9EzXOtALqGjdCzgawzQnueukAvBccvhvf2zzGUsUa1ULbqpBlmoJKAtch
         CiSt5UdanpFG2shBT9PRjntgD+BdWa6+23sPsbhzPN+nw4Jdf5O9yFS69iQ0DZePfMKk
         87Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUiX8jOm0YSfWU6CYyd3VGh917wWYzMy+r88NNDWI0ulzGWYCx+kEs6C3jLT6qEEwvROkTf09f0X9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YypeaENqSnJq61meqqrjJVQGPPRVSOmYZcMAIYTYnSTvA3xu8G+
	sXrOq41CPBBAYhTK90G+tdplcKuPYpVuKa/HhgSSZmWvKj5IvGFIuXT6O/qlOsUiRGG3AYIxfkc
	8FudBKoi2h3d7th/stMAeHCJiKanYBeIOwkTXlzEAPBeev7c=
X-Gm-Gg: ASbGncv8dV5/FaCOzIOQGSAPIRa67zOUk4BFDg41uvwRJMUD+aLOt+c42DMqwVkcaqa
	CGyeJWvjHHbjooEcn35T3zsKkPsjVp4zRIBxBYq6L21hBFDvsKBAmaSfw3qxZTT6j9/FrtlFk1l
	cX7wyBCqw=
X-Google-Smtp-Source: AGHT+IElmufFPlRhN6WUP6xsl2j3aSKliL509oOsAP2BM3ztinN4sZ7IjqPpc6kdwKkEtT/lAxOMSlL/ROY6KYO1KR8=
X-Received: by 2002:a05:6102:3710:b0:4bb:e1c9:80c6 with SMTP id
 ada2fe7eead31-4bfbfd6a86emr1520102137.0.1740108637514; Thu, 20 Feb 2025
 19:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com> <6bf60899-fbc2-404f-b6e9-378fd828f303@schaufler-ca.com>
In-Reply-To: <6bf60899-fbc2-404f-b6e9-378fd828f303@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 22:30:26 -0500
X-Gm-Features: AWEUYZmWL9Qf57mUu_KeL1_WsMAja84czDYkD32q68uwNEjULQl6e3slofEC6z4
Message-ID: <CAHC9VhS4WcoOhrCsxP=ea6XD1f6pu2uCi7=TH=BBvSkW6SyYiA@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:35=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 2/20/2025 11:29 AM, Stephen Smalley wrote:
> > commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security=
")
> > did not preserve the lsm id for subsequent release calls, which results
> > in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> > providing it on the subsequent release call.
> >
> > Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security=
")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Please don't accept this. I will have a better, simpler, more appropriate
> fix promptly.

We're still only at -rc3 so if you need another couple of days to get
an alternate solution out for review/discussion I think that's okay.
However, the solution proposed here is rather small and easy to
understand, which has a lot of value for an -rcX fix.  If the
alternative is notably larger and/or more complex, the patch here may
be preferable for v6.14 with the alternative/"proper-fix" being
something we can queue up for the next merge window.

Regardless, let's see Casey's fix before we worry too much about this.

> > ---
> >  fs/nfs/nfs4proc.c    | 7 ++++---
> >  include/linux/nfs4.h | 1 +
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index df9669d4ded7..c0caaec7bd20 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct =
dentry *dentry,
> >       if (err)
> >               return NULL;
> >
> > +     label->lsmid =3D shim.id;
> >       label->label =3D shim.context;
> >       label->len =3D shim.len;
> >       return label;
> > @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *labe=
l)
> >       if (label) {
> >               shim.context =3D label->label;
> >               shim.len =3D label->len;
> > -             shim.id =3D LSM_ID_UNDEF;
> > +             shim.id =3D label->lsmid;
> >               security_release_secctx(&shim);
> >       }
> >  }
> > @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode =
*inode, void *buf,
> >                                       size_t buflen)
> >  {
> >       struct nfs_server *server =3D NFS_SERVER(inode);
> > -     struct nfs4_label label =3D {0, 0, buflen, buf};
> > +     struct nfs4_label label =3D {0, 0, 0, buflen, buf};
> >
> >       u32 bitmask[3] =3D { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
> >       struct nfs_fattr fattr =3D {
> > @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inod=
e *inode,
> >  static int
> >  nfs4_set_security_label(struct inode *inode, const void *buf, size_t b=
uflen)
> >  {
> > -     struct nfs4_label ilabel =3D {0, 0, buflen, (char *)buf };
> > +     struct nfs4_label ilabel =3D {0, 0, 0, buflen, (char *)buf };
> >       struct nfs_fattr *fattr;
> >       int status;
> >
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 71fbebfa43c7..9ac83ca88326 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -47,6 +47,7 @@ struct nfs4_acl {
> >  struct nfs4_label {
> >       uint32_t        lfs;
> >       uint32_t        pi;
> > +     u32             lsmid;
> >       u32             len;
> >       char    *label;
> >  };

--=20
paul-moore.com

