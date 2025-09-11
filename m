Return-Path: <linux-nfs+bounces-14302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE25B53858
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 17:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D0CA010F2
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D41345726;
	Thu, 11 Sep 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihkw953S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E03469E4
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606074; cv=none; b=dIY2TCizhKPGv6nltXrHzP3LeujVZhPlT6HvkJoyK8invR0LTvX9XNvB5gu2yYdvUWQ07IGuWVXjme8ZIUgNY1ZpKb+uJaJ/Lvve9jtsBTH2PYg5KSDLLclLhf9s4JN1m9dt4vasvQWsT5aG05PCl4eJm9/iYr2+Dl4TpT/FhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606074; c=relaxed/simple;
	bh=N6KUVeAYlqCnQ6iBRMc8GsEzZCQ252qPvughTl4WJwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htTfAMAK2ItT7gW+o/OYCrmGiSw9xYFBkmQcrVZ1IMWNlInmAyQHAQb4cmyiayFrQfeHTo4Qx7wTwnwqQhTyqFJWDrFJSIw6LL/2lHuPHLwdfgtgu4Na5EU4FGnGNo8z3e+9sZmEyw2JdMUC99dZ1p72SrupLDnv/2nSeCM2kTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihkw953S; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so113727566b.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757606071; x=1758210871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkqFoXRVAdDE9iMlbog/yo4QKx4apSNAOb6E1ZAEaj0=;
        b=ihkw953Sy52WgLe7B7ReXLwuglgw7EBzY9dwEopvKGXJDCsdTseZRJiq9MAVbIHsm8
         +hgC+WbU877h8jkDZIpLBbsmORODQw+F2vRrpIr2Pjet5M0Fx1M4jvxt9J9OdMD3jQ/Y
         rjhjsfBM/nqFK6MiL7pNTXREVPyj4EK2SbbUlgB5+ftrf0Ht0X0374aXWZlVO79raic7
         c5wMJvmtMHC7ndz+QF+fFvFQI8UJxK7PYifMfHb2s7xpy0de3eYpdGyNecTlPbkprycq
         tFiBzDqrDduKu3c7KYj9JHDks2gkSOsX0PTNaZqojvay965uw/n3Vq9160iR8WV2gRcZ
         o7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606071; x=1758210871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkqFoXRVAdDE9iMlbog/yo4QKx4apSNAOb6E1ZAEaj0=;
        b=EleE4taRpEQ2irUYO17ajCEpQcwSpWDieQnZ2zr8iG+a9CWiiElaB4o0sHow2dl88N
         qgxlvClZJWVWA9D8ECiOWq1seLz0y0HxJSyVUpS0VJHeIL5eqF7idUhCYQoOWauL5VsT
         Ks/d2dF3ZqUIh1esfudMdYnJuBv9/jrYiCcGuto9VCYu/ZlMigaVvwpasHZkIpXQ1cVE
         TyHzJUsU8/UEod9HreU/5wT79iOzI4Hh3halUViS/X8EWrKIAZAhcHdrFMT3UzTbVDSJ
         YKoXwwPkSKi8HWkgHxBEh44r14L0Yj5yjlTOe3bcDI1aZBz5fXcyVs8M4YbiiXQ5dVAJ
         YUXg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Mnswvf5ev7WmC8CnpGI0v+4eiqxlRJehwFIYPw8iVERNdcXm74wUIXjDgW8zyTtJrlhYi0ZDg0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygXi0BJzfztP37gtChw3IF+mVyu9cHptZ9gSf0lu7MfS3XUwK
	AM4oXsaI5aNWbimJ/pSlET3Rr1UDgV+s1hoT5w7jdnr3cfL6O6VvkRcf8COdNrh3vnv69R/lSEJ
	KnImm+D+/C2zb7bgq+P+NRh+nP7FTDZs=
X-Gm-Gg: ASbGncvytvojy+KhPusxxgHdUIBx4GnhY89BhMZIhl1rKOKk0Fydzef60Df3NyuzsDJ
	kMTz4omKoWDWHGojQrD6Sfn0oubdvkh7wDKhXKIjKCaDO6Y4+xQVuw3m0eW+6Zu1b6bpWOaAbk4
	HJxeq+hAsTJrhlBYFsj0Sm2o8JVDztrOsrj6Z1PekPLzIYPfx2WkZzLqLvXjg6+yHPhYh6xPSr8
	it67pA=
X-Google-Smtp-Source: AGHT+IFeDzO/UlXZsLPQ3nN/k/PZZgm9LBpW7vo72PhZEuvoWBzlvdz37LXf7rjvckeodtKdJgyArTaBeqMTcNZOSgM=
X-Received: by 2002:a17:907:9483:b0:b04:4786:5dfc with SMTP id
 a640c23a62f3a-b04b14aec52mr2283271566b.27.1757606070566; Thu, 11 Sep 2025
 08:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910214927.480316-1-tahbertschinger@gmail.com>
 <20250910214927.480316-4-tahbertschinger@gmail.com> <CAOQ4uxhkU80A75PVB7bsXs2BGhGqKv0vr8RvLb5TnEiMO__pmw@mail.gmail.com>
 <DCQ2V7HPAAPL.1OIBUT89HV16S@gmail.com>
In-Reply-To: <DCQ2V7HPAAPL.1OIBUT89HV16S@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 17:54:18 +0200
X-Gm-Features: Ac12FXzd-RY7w0Ujox948kT-K1TwvOHhxN_T-smjh3uSYBwO4MDC1q26EJTyW6M
Message-ID: <CAOQ4uxiCAbHGusCYdQ0iRvb35O4CLKJQsWp5C04+Hp0+Q8O2zw@mail.gmail.com>
Subject: Re: [PATCH 03/10] fhandle: helper for allocating, reading struct file_handle
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 5:26=E2=80=AFPM Thomas Bertschinger
<tahbertschinger@gmail.com> wrote:
>
> On Thu Sep 11, 2025 at 6:15 AM MDT, Amir Goldstein wrote:
> > On Wed, Sep 10, 2025 at 11:47=E2=80=AFPM Thomas Bertschinger
> > <tahbertschinger@gmail.com> wrote:
> >>
> >> Pull the code for allocating and copying a struct file_handle from
> >> userspace into a helper function get_user_handle() just for this.
> >>
> >> do_handle_open() is updated to call get_user_handle() prior to calling
> >> handle_to_path(), and the latter now takes a kernel pointer as a
> >> parameter instead of a __user pointer.
> >>
> >> This new helper, as well as handle_to_path(), are also exposed in
> >> fs/internal.h. In a subsequent commit, io_uring will use these helpers
> >> to support open_by_handle_at(2) in io_uring.
> >>
> >> Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
> >> ---
> >>  fs/fhandle.c  | 64 +++++++++++++++++++++++++++++---------------------=
-
> >>  fs/internal.h |  3 +++
> >>  2 files changed, 40 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/fs/fhandle.c b/fs/fhandle.c
> >> index 605ad8e7d93d..36e194dd4cb6 100644
> >> --- a/fs/fhandle.c
> >> +++ b/fs/fhandle.c
> >> @@ -330,25 +330,45 @@ static inline int may_decode_fh(struct handle_to=
_path_ctx *ctx,
> >>         return 0;
> >>  }
> >>
> >> -static int handle_to_path(int mountdirfd, struct file_handle __user *=
ufh,
> >> -                  struct path *path, unsigned int o_flags)
> >> +struct file_handle *get_user_handle(struct file_handle __user *ufh)
> >>  {
> >> -       int retval =3D 0;
> >>         struct file_handle f_handle;
> >> -       struct file_handle *handle __free(kfree) =3D NULL;
> >> -       struct handle_to_path_ctx ctx =3D {};
> >> -       const struct export_operations *eops;
> >> +       struct file_handle *handle;
> >>
> >>         if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))=
)
> >> -               return -EFAULT;
> >> +               return ERR_PTR(-EFAULT);
> >>
> >>         if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
> >>             (f_handle.handle_bytes =3D=3D 0))
> >> -               return -EINVAL;
> >> +               return ERR_PTR(-EINVAL);
> >>
> >>         if (f_handle.handle_type < 0 ||
> >>             FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_US=
ER_FLAGS)
> >> -               return -EINVAL;
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       handle =3D kmalloc(struct_size(handle, f_handle, f_handle.hand=
le_bytes),
> >> +                        GFP_KERNEL);
> >> +       if (!handle) {
> >> +               return ERR_PTR(-ENOMEM);
> >> +       }
> >> +
> >> +       /* copy the full handle */
> >> +       *handle =3D f_handle;
> >> +       if (copy_from_user(&handle->f_handle,
> >> +                          &ufh->f_handle,
> >> +                          f_handle.handle_bytes)) {
> >> +               return ERR_PTR(-EFAULT);
> >> +       }
> >> +
> >> +       return handle;
> >> +}
> >> +
> >> +int handle_to_path(int mountdirfd, struct file_handle *handle,
> >> +                  struct path *path, unsigned int o_flags)
> >> +{
> >> +       int retval =3D 0;
> >> +       struct handle_to_path_ctx ctx =3D {};
> >> +       const struct export_operations *eops;
> >>
> >>         retval =3D get_path_anchor(mountdirfd, &ctx.root);
> >>         if (retval)
> >> @@ -362,31 +382,16 @@ static int handle_to_path(int mountdirfd, struct=
 file_handle __user *ufh,
> >>         if (retval)
> >>                 goto out_path;
> >>
> >> -       handle =3D kmalloc(struct_size(handle, f_handle, f_handle.hand=
le_bytes),
> >> -                        GFP_KERNEL);
> >> -       if (!handle) {
> >> -               retval =3D -ENOMEM;
> >> -               goto out_path;
> >> -       }
> >> -       /* copy the full handle */
> >> -       *handle =3D f_handle;
> >> -       if (copy_from_user(&handle->f_handle,
> >> -                          &ufh->f_handle,
> >> -                          f_handle.handle_bytes)) {
> >> -               retval =3D -EFAULT;
> >> -               goto out_path;
> >> -       }
> >> -
> >>         /*
> >>          * If handle was encoded with AT_HANDLE_CONNECTABLE, verify th=
at we
> >>          * are decoding an fd with connected path, which is accessible=
 from
> >>          * the mount fd path.
> >>          */
> >> -       if (f_handle.handle_type & FILEID_IS_CONNECTABLE) {
> >> +       if (handle->handle_type & FILEID_IS_CONNECTABLE) {
> >>                 ctx.fh_flags |=3D EXPORT_FH_CONNECTABLE;
> >>                 ctx.flags |=3D HANDLE_CHECK_SUBTREE;
> >>         }
> >> -       if (f_handle.handle_type & FILEID_IS_DIR)
> >> +       if (handle->handle_type & FILEID_IS_DIR)
> >>                 ctx.fh_flags |=3D EXPORT_FH_DIR_ONLY;
> >>         /* Filesystem code should not be exposed to user flags */
> >>         handle->handle_type &=3D ~FILEID_USER_FLAGS_MASK;
> >> @@ -400,12 +405,17 @@ static int handle_to_path(int mountdirfd, struct=
 file_handle __user *ufh,
> >>  static long do_handle_open(int mountdirfd, struct file_handle __user =
*ufh,
> >>                            int open_flag)
> >>  {
> >> +       struct file_handle *handle __free(kfree) =3D NULL;
> >>         long retval =3D 0;
> >>         struct path path __free(path_put) =3D {};
> >>         struct file *file;
> >>         const struct export_operations *eops;
> >>
> >> -       retval =3D handle_to_path(mountdirfd, ufh, &path, open_flag);
> >> +       handle =3D get_user_handle(ufh);
> >> +       if (IS_ERR(handle))
> >> +               return PTR_ERR(handle);
> >
> > I don't think you can use __free(kfree) for something that can be an ER=
R_PTR.
> >
> > Thanks,
> > Amir.
>
> It looks like the error pointer is correctly handled?
>
> in include/linux/slab.h:
>
> DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))

Right! feel free to add for v3:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

