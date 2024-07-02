Return-Path: <linux-nfs+bounces-4563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDEC92474A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 20:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8002FB241DE
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4070158DD1;
	Tue,  2 Jul 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Oe7tNoF9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE971BE872
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945038; cv=none; b=nUaHIFyerSH2I7hJKWUwM0jVGTMwfrx26RVGTl0NbnY/lh6gEvi48PVYBZvbNN6TGwODaJRsX0O7hL8tH2IK3wzNAsaU04xhUQID1muhs2TaANvRpy+8KivqKPqWUfWRlRYgaqtv8HN983VHcauWjvKKFksQ7P5Z93pK5e/nhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945038; c=relaxed/simple;
	bh=YmyxewuAfQoYaKudT/e7favm5t7Gn04Zh73P9xcW1Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQaVOWDs4N6VfWlO55WnPyBwwVqNlMd82US8sm4NfFja2Fk+EB1sGQNjFcJ5xMGIMx1YSIMFvcCwwzRD27e+W2RzRc+Beq96mD+mD4qoubtvRfvr117mQGiFP61Qa0NVkCk1RoxGtToa4osvdhuc34roQUCuY9T56iSRDa+tyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Oe7tNoF9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee483284b4so4389021fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1719945035; x=1720549835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9zDSpB5LR8DGaqR0PpuAjUxa78GhNnXyM4ZXat3UD4=;
        b=Oe7tNoF9rXSQHN8lsXs+4wEKUX+tKWM9kRXCzhTYIOcaJDz72SUqyRv17fwid3+WRA
         Oe6FvdffU+yA0vrFls6xBEunVRiEOsYuuZ6wIeXRA/XlBeqpNAdzSxQgy4WieFaEggCa
         AWLgixwCPpmfkZqC6T/n/3uj7qg43QSI6rU+J6dKRRV07ktnjEW9pMATfRneXQZELs1R
         /Ok/tHuISAuFyXtAjEsQNOFpZtGeIbS08EdhsErDDabn4w2ZO6pHaQ5neUyM81er9IYu
         9uPvmGxgTNmV6FJwVvWJiTxLQnOG2d/t5rrrvfPs3Z6/WAMwcgu2yDrZwFWeO4SQuPlD
         FvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945035; x=1720549835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9zDSpB5LR8DGaqR0PpuAjUxa78GhNnXyM4ZXat3UD4=;
        b=p821vpa41p4/KM5t1fHDf7QcWUZoJkWAS3uXYw40FSVl6M3e/PdYppaMWuMQ9MbJu7
         SG6Sl9jhFwO16TwVEFIboLuQjsY8VlQTigbps6nMElIfDWrFx+s/LoiBNSjlgQE7eTKt
         Wl0n0GnY+u1944uLVpedcOkYNrwaVewnE2K+jhooSb0BoUoUbDy2UbQHPhnu0Je305+9
         LWrLxq9TUB5uvtTE4OIrKHjYPQvObJS6GJ01yaMOm71B4n8Ja+gXlyjm5FUoulLh+3Ye
         2/cqu+nWjqIU65+CYWrNews78ryDQcLyPB7ZpyKSU9Uv1bf++/kdmkXMqFZm3M+xuAzY
         /qDw==
X-Gm-Message-State: AOJu0YxuPk9IX8BS9O65k2Oo4r5Wk1eVFSVzqey3wTvWFHMj65wb9zCe
	aI5teQI/G0a5YJaSRtzLoBSgbIfRoWaxnWoBDyB23vv1hoijSeriqrQsxvTkZapptK1RsQ2/2HP
	qQK3Vl2AkOZPy79IzEtHr5CYMOro=
X-Google-Smtp-Source: AGHT+IG8amrL1yyh7NfgryS8xASywBQR7fAR6AJChpaDfqO4SzEnATyZfB7fHEwRTrW9RXL19nzKnYWTOLthD737PTc=
X-Received: by 2002:a2e:7a05:0:b0:2ec:44f9:56ab with SMTP id
 38308e7fff4ca-2ee5e2c6253mr45071251fa.0.1719945034602; Tue, 02 Jul 2024
 11:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702151947.549814-8-cel@kernel.org> <20240702151947.549814-13-cel@kernel.org>
In-Reply-To: <20240702151947.549814-13-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 2 Jul 2024 14:30:22 -0400
Message-ID: <CAN-5tyHKV-DP9FK0s9J+6j2uHMvK_8TKqeMh5=GZ81+424xntw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:21=E2=80=AFAM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> We've found that there are cases where a transport disconnection
> results in the loss of callback RPCs. NFS servers typically do not
> retransmit callback operations after a disconnect.
>
> This can be a problem for the Linux NFS client's current
> implementation of asynchronous COPY, which waits indefinitely for a
> CB_OFFLOAD callback. If a transport disconnect occurs while an async
> COPY is running, there's a good chance the client will never get the
> completing CB_OFFLOAD.
>
> Fix this by implementing the OFFLOAD_STATUS operation so that the
> Linux NFS client can probe the NFS server if it doesn't see a
> CB_OFFLOAD in a reasonable amount of time.
>
> This patch implements a simplistic check. As future work, the client
> might also be able to detect whether there is no forward progress on
> the request asynchronous COPY operation, and CANCEL it.
>
> Suggested-by: Olga Kornievskaia <kolga@netapp.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218735
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index c55247da8e49..246534bfc946 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -175,6 +175,11 @@ int nfs42_proc_deallocate(struct file *filep, loff_t=
 offset, loff_t len)
>         return err;
>  }
>
> +/* Wait this long before checking progress on a COPY operation */
> +enum {
> +       NFS42_COPY_TIMEOUT      =3D 5 * HZ,
> +};
> +
>  static int handle_async_copy(struct nfs42_copy_res *res,
>                              struct nfs_server *dst_server,
>                              struct nfs_server *src_server,
> @@ -184,9 +189,10 @@ static int handle_async_copy(struct nfs42_copy_res *=
res,
>                              bool *restart)
>  {
>         struct nfs4_copy_state *copy, *tmp_copy =3D NULL, *iter;
> -       int status =3D NFS4_OK;
>         struct nfs_open_context *dst_ctx =3D nfs_file_open_context(dst);
>         struct nfs_open_context *src_ctx =3D nfs_file_open_context(src);
> +       int status =3D NFS4_OK;
> +       u64 copied;
>
>         copy =3D kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
>         if (!copy)
> @@ -224,7 +230,9 @@ static int handle_async_copy(struct nfs42_copy_res *r=
es,
>                 spin_unlock(&src_server->nfs_client->cl_lock);
>         }
>
> -       status =3D wait_for_completion_interruptible(&copy->completion);
> +wait:
> +       status =3D wait_for_completion_interruptible_timeout(&copy->compl=
etion,
> +                                                          NFS42_COPY_TIM=
EOUT);
>         spin_lock(&dst_server->nfs_client->cl_lock);
>         list_del_init(&copy->copies);
>         spin_unlock(&dst_server->nfs_client->cl_lock);
> @@ -233,12 +241,17 @@ static int handle_async_copy(struct nfs42_copy_res =
*res,
>                 list_del_init(&copy->src_copies);
>                 spin_unlock(&src_server->nfs_client->cl_lock);
>         }
> -       if (status =3D=3D -ERESTARTSYS) {
> -               goto out_cancel;
> -       } else if (copy->flags || copy->error =3D=3D NFS4ERR_PARTNER_NO_A=
UTH) {
> -               status =3D -EAGAIN;
> -               *restart =3D true;
> +       switch (status) {
> +       case 0:
> +               goto timeout;
> +       case -ERESTARTSYS:
>                 goto out_cancel;
> +       default:
> +               if (copy->flags || copy->error =3D=3D NFS4ERR_PARTNER_NO_=
AUTH) {
> +                       status =3D -EAGAIN;
> +                       *restart =3D true;
> +                       goto out_cancel;
> +               }
>         }
>  out:
>         res->write_res.count =3D copy->count;
> @@ -253,6 +266,19 @@ static int handle_async_copy(struct nfs42_copy_res *=
res,
>         if (!nfs42_files_from_same_server(src, dst))
>                 nfs42_do_offload_cancel_async(src, src_stateid);
>         goto out_free;
> +timeout:
> +       status =3D nfs42_proc_offload_status(src, src_stateid, &copied);
> +       switch (status) {
> +       case 0:
> +       case -EREMOTEIO:
> +               res->write_res.count =3D copied;
> +               memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy=
->verf));
> +               goto out_free;

Setting aside the grouping these 2cases together, I don't understand
why the assumption that if we received a reply from OFFLOAD_STATUS
with some value back means that we should consider copy done? Say the
copy was for 1M, client queried and got back that 500M done, I don't
think the server by replying to the OFFLOAD_STATUS says it's done with
the copy? I think it replies with how much was done but it might still
be inprogress? So shouldn't we check that everything was done and if
not done go back to waiting again?

Again I don't think this approach is going to work because of how
callback and the copy thread are handled (as of now). In
handle_async_copy() when we come out of
wait_for_completion_interruptible() we know the callback has arrived
and it has signalled the copy thread and thus we remove the copy
request from the list. However, on the timeout, we didn't receive the
wake up and thus if we remove the copy from the list then, when the
callback thread asynchronously receives the callback it won't have the
request to match it too. And in case the server does support an
offload_status query I guess that's ok, but imagine it didn't. So now,
we'd send the offload_status and get not supported and we'd go back to
waiting but we'd already missed the callback because it came and
didn't find the matching request is now just dropped on the floor.

When we wake up from wait_for_completion_interruptible() we need to
know if we timed out or got woken. If we timed out, I think we need to
keep the request in.


> +       case -EINPROGRESS:
> +       case -EOPNOTSUPP:
> +               goto wait;
> +       }
> +       goto out;
>  }
>
>  static int process_copy_commit(struct file *dst, loff_t pos_dst,
> --
> 2.45.2
>
>

