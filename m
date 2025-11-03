Return-Path: <linux-nfs+bounces-15913-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29853C2C164
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 14:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC9FF4F4568
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CFB30E832;
	Mon,  3 Nov 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8KZqbv6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF426F2BB
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176270; cv=none; b=MqfoOF2FHwEXyQB1UNsCQevEC65LMve3WWVsk3jjU30uosodvqF7oGsZA7trl9p06u48s5NQT7eq6IWahoLkgiuneMY5RUE2Sy0vPFcOiEBT4KMzPwe+QL+yG0EKfFOKavgt7KaUfkqiU8e/6JUfw1BqS55PdGcJ3I5USDNmiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176270; c=relaxed/simple;
	bh=O+dRAgI4LPfuYan1hqt3Wh5X/J4xUpMgYGmJUgN4GBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/LyZnT7Seh2XPIiWV+0gbCMVmZxIZpMJqrDVEcnlh/x50AfbLhoaH87dqEHhMQe0Fd6Dndzke9baIhcL5FB6l+ExllHDm6Zpe76GK34Z62FJbdSksRfuf5gZ7s85ezw31Wu/HXy2TU8QTiERlVfdV2NNqI7KLhsfY039ISDvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8KZqbv6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b710601e659so109265566b.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Nov 2025 05:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176265; x=1762781065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S6+1dUVKvqII667r+XW9/GENl1vb5Sqoomw0mlu3RI=;
        b=T8KZqbv6kO/2xrWzX5n2788COipO+Tnz7F384SIxaywjLymb/lsfPxOUz0GOomqB4m
         tSNiR+3flO68a9EtT4yaCs81ULEj8LfOSo8v3ZU97wAF7FdFSJhOJv2ZeicIbfs6vvRl
         1gGjjqDGtjMsAY2i9JFTxfgqyW942vF6Q2vzk65RMl3u/HohDHs+eH1IoKambzK6Rwo0
         /2xTzljrwr5o3ouIWwJ8c92Yk6WGQLDij67OP/z+7tBvBMrLdiEPRX4izLkduDzW/+qd
         HoG9zb4rHzUKP+pIRspQJTBFjtz/T4jk9Y2st713BaUCRGI8wudxyrwpsYCmR3hy/3EE
         pTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176265; x=1762781065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S6+1dUVKvqII667r+XW9/GENl1vb5Sqoomw0mlu3RI=;
        b=m5Az2k2nsGejwwbgV+nIfBUhoKIjxEgi2R3K6m+mCVe4eDHSPy/4Gdq1OUzcmDPjQx
         JTvlHM2QXbuHrwvQ6uNHG1sRGnewIvj639l0RIsUvv6IJSzADrzVggg7D6TiIsAXvyMq
         wXHnUDnhS2l24+VtVk42IImYPrIHhL64Eg/u88l00GOVRcgsABs/Vu45LARNLu6KFIO8
         X1KaeAPr/yEAQqt3DRtq/gWBokQOLi3ReVdnq9HAiOqacIPltpXj9vYvUXPwjf7DoZjz
         rHBywt0oiDHZVejBGGdnOvS/MY3Ax5R+KJiG0CqNUKOIaN6g7TpvRln7aGLoUysDmMpy
         +HEA==
X-Forwarded-Encrypted: i=1; AJvYcCWPh4FNhuS4fK+ucx7vquHlmd6M4JWEY/S9sz39QQK+73je2nh1l1WOVCOJ6dSKVfZehGNMjel9ENU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAp9sXLUx2erpwEUda2BSdDpCNtO6RKaAoRXaepMjT/4BY6z5A
	zz/EDikQEX120zgaLOm2fKSGBj1xQQIDvyOk8pi8dyJw7kjZnCHiR/mHsfXVzdrAxhr09SqRXNf
	hgeZNlGR0jHSoqj62WT3cCtdZHIsjkvI=
X-Gm-Gg: ASbGncuD++jL+cXtA1N+9ML4p2mhNnVqwZhSp6LhPnalwKoAmbt+F+mwVntyd1eoZ2y
	wWDDWdJ5O94B+6BFXkzQysldISOU3yySWHbMhmDljzqvOW8bfOL1PchiK/WkIATglZ6EKeytdD4
	SpENvvmFK11vzJHKdIB4G6ouLLkQUxdeqpFRSpG6+zCPlNjJawfx5J1cBO0ZJ4yx8RZJ9gRuRfI
	C124+ZStIs8Iz5BAdGtY2Wo/O9hBi/txQ4usK7jHX5s/Tujr9C3Mb9oVNt/yfgkXdUc7he7D/S7
	ug+ZEhIDBGrGDHz5zieScsxrxywHhg==
X-Google-Smtp-Source: AGHT+IELl7DuDv5uo3bD6NZ9q582bvS2bDMma/TtRpWZCxPhIVAv9e4H0npG+fdCye/re4SlhiT2Qy0S3M2gjGw90Ag=
X-Received: by 2002:a17:907:ea7:b0:b6d:2d0b:1ec2 with SMTP id
 a640c23a62f3a-b70708315e8mr1272156366b.54.1762176265161; Mon, 03 Nov 2025
 05:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-4-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-4-a3e156839e7f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Nov 2025 14:24:13 +0100
X-Gm-Features: AWmQ_blW2akq-ipD0fIUUOxTn8zmugUgDmTC0C57BdhrsmFigJmfJvym14MPro0
Message-ID: <CAOQ4uxhW2FiVe6XjQDT_aXhzJDyT5yuna9CVaWOLyzU1J99hFg@mail.gmail.com>
Subject: Re: [PATCH 04/16] backing-file: use credential guards for writes
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 12:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Use credential guards for scoped credential override with automatic
> restoration on scope exit.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/backing-file.c | 74 +++++++++++++++++++++++++++++--------------------=
------
>  1 file changed, 39 insertions(+), 35 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 4cb7276e7ead..9bea737d5bef 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -210,11 +210,47 @@ ssize_t backing_file_read_iter(struct file *file, s=
truct iov_iter *iter,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_read_iter);
>
> +static int do_backing_file_write_iter(struct file *file, struct iov_iter=
 *iter,
> +                                     struct kiocb *iocb, int flags,
> +                                     void (*end_write)(struct kiocb *, s=
size_t))
> +{
> +       struct backing_aio *aio;
> +       int ret;
> +
> +       if (is_sync_kiocb(iocb)) {
> +               rwf_t rwf =3D iocb_to_rw_flags(flags);
> +
> +               ret =3D vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
> +               if (end_write)
> +                       end_write(iocb, ret);
> +               return ret;
> +       }
> +
> +       ret =3D backing_aio_init_wq(iocb);
> +       if (ret)
> +               return ret;
> +
> +       aio =3D kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
> +       if (!aio)
> +               return -ENOMEM;
> +
> +       aio->orig_iocb =3D iocb;
> +       aio->end_write =3D end_write;
> +       kiocb_clone(&aio->iocb, iocb, get_file(file));
> +       aio->iocb.ki_flags =3D flags;
> +       aio->iocb.ki_complete =3D backing_aio_queue_completion;
> +       refcount_set(&aio->ref, 2);
> +       ret =3D vfs_iocb_iter_write(file, &aio->iocb, iter);
> +       backing_aio_put(aio);
> +       if (ret !=3D -EIOCBQUEUED)
> +               backing_aio_cleanup(aio, ret);
> +       return ret;
> +}
> +
>  ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter=
,
>                                 struct kiocb *iocb, int flags,
>                                 struct backing_file_ctx *ctx)
>  {
> -       const struct cred *old_cred;
>         ssize_t ret;
>
>         if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)))
> @@ -237,40 +273,8 @@ ssize_t backing_file_write_iter(struct file *file, s=
truct iov_iter *iter,
>          */
>         flags &=3D ~IOCB_DIO_CALLER_COMP;
>
> -       old_cred =3D override_creds(ctx->cred);
> -       if (is_sync_kiocb(iocb)) {
> -               rwf_t rwf =3D iocb_to_rw_flags(flags);
> -
> -               ret =3D vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
> -               if (ctx->end_write)
> -                       ctx->end_write(iocb, ret);
> -       } else {
> -               struct backing_aio *aio;
> -
> -               ret =3D backing_aio_init_wq(iocb);
> -               if (ret)
> -                       goto out;
> -
> -               ret =3D -ENOMEM;
> -               aio =3D kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL)=
;
> -               if (!aio)
> -                       goto out;
> -
> -               aio->orig_iocb =3D iocb;
> -               aio->end_write =3D ctx->end_write;
> -               kiocb_clone(&aio->iocb, iocb, get_file(file));
> -               aio->iocb.ki_flags =3D flags;
> -               aio->iocb.ki_complete =3D backing_aio_queue_completion;
> -               refcount_set(&aio->ref, 2);
> -               ret =3D vfs_iocb_iter_write(file, &aio->iocb, iter);
> -               backing_aio_put(aio);
> -               if (ret !=3D -EIOCBQUEUED)
> -                       backing_aio_cleanup(aio, ret);
> -       }
> -out:
> -       revert_creds(old_cred);
> -
> -       return ret;
> +       with_creds(ctx->cred);
> +       return do_backing_file_write_iter(file, iter, iocb, flags, ctx->e=
nd_write);
>  }

Pointing out the obvious that do_backing_file_write_iter() feels
unnecessary here.

But I am fine with keeping it for symmetry with
do_backing_file_read_iter() and in case we will want to call the sync
end_write() callback outside of creds override context as we do in the
read case.

Thanks,
Amir.

