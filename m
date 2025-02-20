Return-Path: <linux-nfs+bounces-10231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F288A3E532
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F2B19C448F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9C2641C3;
	Thu, 20 Feb 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF1F4Bs1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD17214203;
	Thu, 20 Feb 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080254; cv=none; b=OBCeJVrLc5UmtENwVtB3bHLe2F2Be6yj14+tuxMDRx1if8hn234lpCbaABgM75CS2twsR3k3Mw4m+EUHI3TD1zM2q4pc7B8ltz8RrRFhtFUW5wGc/SDf9YEv3rQVYckxl3o08BDi2iWccPInMw8Oh/v+mrSzokbJ3fnQfWODHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080254; c=relaxed/simple;
	bh=n9/74d6CBVjudaWDGkORu5hNcxEK3VAuW+zR9g+UojQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYlGbtS15ePGj+bXStuFmKzJsZFFhGw1shB4ac2N85jasLViyCQof28poGdjNan2smFBNhC95cTfOV3vBPkD52rwNKkUkPk+psHcM1jXt/NG8lpo/h3zHJyzuYZWSSjpac6iV2qFAH3DifPzXBfL78QxeSQF+WSHFfe4P87lpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF1F4Bs1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso2172823a91.1;
        Thu, 20 Feb 2025 11:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740080252; x=1740685052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9N0svtuDhebOkPAKKmeCwyMiQ3TBUCHeJ8JAArCKbo=;
        b=DF1F4Bs1PDeUt0IRamWWsQyfgqTd0ZQ8u17zrsBn7yMsBF9ZOXAeBxcOQ/pydm0lk2
         s04kgHqZuGU0N6CNxbTi6lTrEoP8XN4HHjZu1b9OxVQwWXVwBRcp2w7PKqopdVRl4+bN
         WPFNLXzw0aI6LG3ficB7FUoD7bsDxiP66qvUY9O+Mf2cDV+radzCrcYCx920VkhCKI5G
         esqhcLsE8JbxenmG0zHSIQRw8w1wWQ1UCnArixtPi8z8WXg2KXdD52Slz5GmTvBgMSH0
         q/hClLBiKxMUi0jYGDXjk45wAfwRrZyPmqAIiiSBduQOWFs0i4Vc4/Tac5ZZla32g/r+
         AXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080252; x=1740685052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9N0svtuDhebOkPAKKmeCwyMiQ3TBUCHeJ8JAArCKbo=;
        b=uWzcLYCF9w4E/QAow1BekvmNYX5S4fMfHd1/7dYRU4QtZJ16TE7wVr8wv3iO6GWpFg
         WefaKW5X1WUks32zzDayOh9rLv2xfWjpMZBdhuvh3xYKe+7pByf8+DdAHUGVrXDMuLna
         W5Xfoy3ZbqxtgsJEceqAYtxzGzAU2wKl+i1kh35I7vK87jGq6UvyZNk0xRUq5r0NsY2u
         31VgNRX070XtElRjnlHbZ5tdMSJTSY36FgFg2zVwd9h3D3JkDSb37/N/J0xAPRk9RVrF
         3IEpKfUI7PapQCNJAgNjWBOClYnpXv4PaPXf0Ws+xjk+hAqofZgUUI4JLLG8AHqqbmKk
         XD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoohSwAziwMbd4inCAhiZrRpt4EPw6MrZbsMR5VHzk1WLa0ok5ne9eiRAm9VsX3tIDDX8jXi8inA==@vger.kernel.org, AJvYcCVE/kJnJUSFOfp9wBmufV36862J1FBp9DRI/LdTSbkiDnQXieqoPtxFBCT06ezRjIhiR+zIyV4HnNNNoPHO@vger.kernel.org, AJvYcCVrkETnZsGJMnES1/iJUGR5ivZFlt1M1ceYPOcSdZYg6AJB3isOkTfwTBIJDi9MFV58M1N2QjPd0eSm@vger.kernel.org, AJvYcCWkXVFxZeI8bCAJxS4EXQfvqJsZLCBuGU4S8PWOIbgnCCSdWcaRg+GnGlOlp4fHjBjktJZxwq4afdK2@vger.kernel.org, AJvYcCXVBjC9GluU0cG5aw7YRet7kx4jfZumXbw4950rrMhnj/O0frv3bShWs8lYsWiiR/D8byuHbfODvktoZQO77HO3H3JtvZFl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aQPh/yfAweT+N6fpreBCAfC6zAhEBt9bGveCAbAHJ4WL7+0o
	gvZHHgKhkyYuSA498smHuehjuuYIqRg9DKdv2ku0y5JUS2oZ+7Fx7UIRRfwRyhg4kze2ArLfWwh
	3+2dj2Y7+CfSWeu6+RYgQlso0QDekEg==
X-Gm-Gg: ASbGnctDdcXphBfi9im9b5ZKpOwHK0nHky5Uebi1JMxYSXsu7KBtREm3sdRJimxHMgN
	/Kb8MCmlfxJuLVJNwZFE1fjib2yIsGdusXY263pHe4A5scfV4fJzRhGb3bFkoX6ZbMZQHcSj+
X-Google-Smtp-Source: AGHT+IGP4jRQs+KcqaHrKuRyBpknchLl3SDq4uE0OSI4WF5TGdo50Invw+UYJrE70+lFzsLo3ysuHyFsguXq1VyqXi4=
X-Received: by 2002:a17:90b:2b8e:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-2fce78cbe94mr686477a91.16.1740080251781; Thu, 20 Feb 2025
 11:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-5-casey@schaufler-ca.com> <CAEjxPJ56H_Y-ObgNHrCggDK28NOARZ0CDmLDRvY5qgzu=YgE=A@mail.gmail.com>
 <CAHC9VhSSpLx=ku7ZJ7qVxHHyOZZPQWs_hoxVRZpTfhOJ=T2X9w@mail.gmail.com>
 <CAHC9VhQUUOqh3j9mK5eaVOc6H7JXsjH8vajgrDOoOGOBTszWQw@mail.gmail.com>
 <CAEjxPJ6-jL=h-Djxp5MGRbTexQF1vRDPNcwpxCZwFM22Gja0dg@mail.gmail.com>
 <CAEjxPJ5KTJ1DDaAJ89sSdxUetbP_5nHB5OZ0qL18m4b_5N10-w@mail.gmail.com> <1b6af217-a84e-4445-a856-3c69222bf0ed@schaufler-ca.com>
In-Reply-To: <1b6af217-a84e-4445-a856-3c69222bf0ed@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 14:37:19 -0500
X-Gm-Features: AWEUYZlmMS7YZ4DHm18PX7FppH1AyRZ-zdw57vHXse-0c1wXMLEZfImxT7nx6Y4
Message-ID: <CAEjxPJ44NNZU7u7vLN_Oj4jeptZ=Mb9RkKvJtL=xGciXOWDmKA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:33=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 2/20/2025 10:16 AM, Stephen Smalley wrote:
> > On Thu, Feb 20, 2025 at 1:02=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Thu, Feb 20, 2025 at 12:54=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>> On Thu, Feb 20, 2025 at 12:40=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> >>>> On Thu, Feb 20, 2025 at 11:43=E2=80=AFAM Stephen Smalley
> >>>> <stephen.smalley.work@gmail.com> wrote:
> >>>>> On Wed, Oct 23, 2024 at 5:23=E2=80=AFPM Casey Schaufler <casey@scha=
ufler-ca.com> wrote:
> >>>>>> Replace the (secctx,seclen) pointer pair with a single lsm_context
> >>>>>> pointer to allow return of the LSM identifier along with the conte=
xt
> >>>>>> and context length. This allows security_release_secctx() to know =
how
> >>>>>> to release the context. Callers have been modified to use or save =
the
> >>>>>> returned data from the new structure.
> >>>>>>
> >>>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>>>> Cc: ceph-devel@vger.kernel.org
> >>>>>> Cc: linux-nfs@vger.kernel.org
> >>>>>> ---
> >>>>>>  fs/ceph/super.h               |  3 +--
> >>>>>>  fs/ceph/xattr.c               | 16 ++++++----------
> >>>>>>  fs/fuse/dir.c                 | 35 ++++++++++++++++++------------=
-----
> >>>>>>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
> >>>>>>  include/linux/lsm_hook_defs.h |  2 +-
> >>>>>>  include/linux/security.h      | 26 +++-----------------------
> >>>>>>  security/security.c           |  9 ++++-----
> >>>>>>  security/selinux/hooks.c      |  9 +++++----
> >>>>>>  8 files changed, 50 insertions(+), 70 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> >>>>>> index 76776d716744..0b116ef3a752 100644
> >>>>>> --- a/fs/nfs/nfs4proc.c
> >>>>>> +++ b/fs/nfs/nfs4proc.c
> >>>>>> @@ -114,6 +114,7 @@ static inline struct nfs4_label *
> >>>>>>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry=
,
> >>>>>>         struct iattr *sattr, struct nfs4_label *label)
> >>>>>>  {
> >>>>>> +       struct lsm_context shim;
> >>>>>>         int err;
> >>>>>>
> >>>>>>         if (label =3D=3D NULL)
> >>>>>> @@ -128,21 +129,24 @@ nfs4_label_init_security(struct inode *dir, =
struct dentry *dentry,
> >>>>>>         label->label =3D NULL;
> >>>>>>
> >>>>>>         err =3D security_dentry_init_security(dentry, sattr->ia_mo=
de,
> >>>>>> -                               &dentry->d_name, NULL,
> >>>>>> -                               (void **)&label->label, &label->le=
n);
> >>>>>> -       if (err =3D=3D 0)
> >>>>>> -               return label;
> >>>>>> +                               &dentry->d_name, NULL, &shim);
> >>>>>> +       if (err)
> >>>>>> +               return NULL;
> >>>>>>
> >>>>>> -       return NULL;
> >>>>>> +       label->label =3D shim.context;
> >>>>>> +       label->len =3D shim.len;
> >>>>>> +       return label;
> >>>>>>  }
> >>>>>>  static inline void
> >>>>>>  nfs4_label_release_security(struct nfs4_label *label)
> >>>>>>  {
> >>>>>> -       struct lsm_context scaff; /* scaffolding */
> >>>>>> +       struct lsm_context shim;
> >>>>>>
> >>>>>>         if (label) {
> >>>>>> -               lsmcontext_init(&scaff, label->label, label->len, =
0);
> >>>>>> -               security_release_secctx(&scaff);
> >>>>>> +               shim.context =3D label->label;
> >>>>>> +               shim.len =3D label->len;
> >>>>>> +               shim.id =3D LSM_ID_UNDEF;
> >>>>> Is there a patch that follows this one to fix this? Otherwise, sett=
ing
> >>>>> this to UNDEF causes SELinux to NOT free the context, which produce=
s a
> >>>>> memory leak for every NFS inode security context. Reported by kmeml=
eak
> >>>>> when running the selinux-testsuite NFS tests.
> >>>> I don't recall seeing anything related to this, but patches are
> >>>> definitely welcome.
> >>> Looking at this quickly, this is an interesting problem as I don't
> >>> believe we have enough context in nfs4_label_release_security() to
> >>> correctly set the shim.id value.  If there is a positive, it is that
> >>> lsm_context is really still just a string wrapped up with some
> >>> metadata, e.g. length/ID, so we kfree()'ing shim.context is going to
> >>> be okay-ish, at least for the foreseeable future.
> >>>
> >>> I can think of two ways to fix this, but I'd love to hear other ideas=
 too.
> >>>
> >>> 1. Handle the LSM_ID_UNDEF case directly in security_release_secctx()
> >>> and skip any individual LSM processing.
> >>>
> >>> 2. Define a new LSM_ID_ANY value and update all of the LSMs to also
> >>> process the ANY case as well as their own.
> >>>
> >>> I'm not finding either option very exciting, but option #2 looks
> >>> particularly ugly, so I think I'd prefer to see someone draft a patch
> >>> for option #1 assuming nothing better is presented.
> >> We could perhaps add a u32 lsmid to struct nfs4_label, save it from
> >> the shim.id obtained in nfs4_label_init_security(), and use it in
> >> nfs4_label_release_security(). Not sure why that wasn't done in the
> >> first place.
> > Something like this (not tested yet). If this looks sane, will submit
> > separately.
> >
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
> I'm not a fan of adding secids into other subsystems, especially in cases
> where they've tried to avoid them in the past.
>
> The better solution, which I'm tracking down the patch for now, is for
> the individual LSMs to always do their release, and for security_release_=
secctx()
> to check the lsm_id and call the appropriate LSM specific hook. Until the=
re
> are multiple LSMs with contexts, LSM_ID_UNDEF is as good as a match.
>
> Please don't use this patch.

It doesn't add a secid; it just saves the LSM id obtained from
lsm_context populated by the security_dentry_init_security() hook call
and passes it back in the lsm_context to the security_release_secctx()
call.

>
> > ---
> >  fs/nfs/nfs4proc.c    | 7 ++++---
> >  include/linux/nfs4.h | 1 +
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index df9669d4ded7..c0caaec7bd20 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct
> > dentry *dentry,
> >   if (err)
> >   return NULL;
> >
> > + label->lsmid =3D shim.id;
> >   label->label =3D shim.context;
> >   label->len =3D shim.len;
> >   return label;
> > @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *labe=
l)
> >   if (label) {
> >   shim.context =3D label->label;
> >   shim.len =3D label->len;
> > - shim.id =3D LSM_ID_UNDEF;
> > + shim.id =3D label->lsmid;
> >   security_release_secctx(&shim);
> >   }
> >  }
> > @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode
> > *inode, void *buf,
> >   size_t buflen)
> >  {
> >   struct nfs_server *server =3D NFS_SERVER(inode);
> > - struct nfs4_label label =3D {0, 0, buflen, buf};
> > + struct nfs4_label label =3D {0, 0, 0, buflen, buf};
> >
> >   u32 bitmask[3] =3D { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
> >   struct nfs_fattr fattr =3D {
> > @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inod=
e *inode,
> >  static int
> >  nfs4_set_security_label(struct inode *inode, const void *buf, size_t b=
uflen)
> >  {
> > - struct nfs4_label ilabel =3D {0, 0, buflen, (char *)buf };
> > + struct nfs4_label ilabel =3D {0, 0, 0, buflen, (char *)buf };
> >   struct nfs_fattr *fattr;
> >   int status;
> >
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 71fbebfa43c7..9ac83ca88326 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -47,6 +47,7 @@ struct nfs4_acl {
> >  struct nfs4_label {
> >   uint32_t lfs;
> >   uint32_t pi;
> > + u32 lsmid;
> >   u32 len;
> >   char *label;
> >  };

