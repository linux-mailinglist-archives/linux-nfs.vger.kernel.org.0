Return-Path: <linux-nfs+bounces-8536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD39F012D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 01:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD3628147A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 00:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3542383;
	Fri, 13 Dec 2024 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="TvyF81p2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77451854
	for <linux-nfs@vger.kernel.org>; Fri, 13 Dec 2024 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050367; cv=none; b=O0fx9uiMP6g27+ionrs4BCZJqTSk8HemGW3XLLavGV/ev+3gNhlhUcJTw4TlPdjs0N4HquC6tv19k6nbB6blBqsi/fK2H6iDbF5U/JWkp3isO5Fn0JE9hWVQe3kvy+Hh1lrHcqhX6zIAG5pS24Vy860tXWK+4CPQrdUWKNU0Vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050367; c=relaxed/simple;
	bh=w5+4zVvee0iv6wu1kPgVM3sVeUcXg1TUNqQ9TjvlZtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0sGEXYSuMFsTDrS0AMOZDVDKV3jeGHl/iQPq8vTjCACWQ1Hkib7QzPdoqbgVDhxHkZtXTHt8+7LqjcRtHml5QlAXsAtT5blkTLZtugnUE//0uZC/iUR5ITvpOadOSw29Ut3R3FwGTWSyt3E94JoWMelX+GLWrB3PKh2XIg0y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=TvyF81p2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53f22fd6887so1315728e87.2
        for <linux-nfs@vger.kernel.org>; Thu, 12 Dec 2024 16:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1734050364; x=1734655164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ph3XQ9C/6UtL+evRp8sTP1xjM50WQGOZo6uaoMH+yo=;
        b=TvyF81p2va6OzcyVtUdzEXf/qn7mQvwW8Ngxf/h7A7IP9V1/HL5mSbsU2el2cRBue6
         pqkxrCBV065xSJYIuOkCCnTiKgl2adQzeyZxNxLQcMetLgv2QLE1YEPnoJIb+i8hrln9
         BH7RS3zmfg58td9S/jpUCpC+mlcHmQ+GsJ8U2OT19YWgbgijKS2kleg/BQfiDyt/IQs+
         9C2laK6hSFQAtFnsTtHW5Q5UQdo4TJZWA5pBlCnGij1GiuS/X4646bDg8LoCA29wb/vK
         aLf2l1fr+rRK4lpNyTQYGDlt8CR8GhubDUAy5E8/lCefKH/BG6Jv30bOzNPUjFK+6N0p
         t97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050364; x=1734655164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ph3XQ9C/6UtL+evRp8sTP1xjM50WQGOZo6uaoMH+yo=;
        b=Fe33C8G4NcIegXmC7MxgylFYrt8V208cEHoKKibnlihOB8yRTDlQtQnPzeFDU0fAjY
         XllBxrLRr8UrcQQhdTP01DCTwSGeFT976hoYZBss3FV958YiVnTQFPGH3AkOWghB0HLb
         TmMstS/hBtnVKSR4rRrc9pBz/pOBEAPt/jQNDVNQmNGnjLESqsCx0BT8cvG/5kBf+eBJ
         BTVVQsscefxcbHMThINwhLWXN5/hWxy1hhoaFgM72CRN92+UVhCd6nPyksbFTUSxvcYS
         MzcMdODu3JT5wLkJbitnA6T/Aw8wHrv6L3g+x1dZ7OEZhLgp4+92a+1Ixi4fReZNjBKH
         d8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCU4UoNVHfXA1JSGLS95W9B9itrKnas1HxFXpttRYVz2j4/8nfjNBOGTkmu8vQ+8I5mMDFPc9sQMYEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQbIyMpRscdH2yQcK6yP4rDRy8v19+KPAU0vnBLG+ltfgBsikQ
	oY9WikkF1Ypf94WiXl2Whyn5/72crL36S73JlE9HIOHjXU+HcdcnKGTqIfIcDjZhyg8XjAtaJCU
	UtVJN2/Vt+8Z7511VCjOyUdVHLmo=
X-Gm-Gg: ASbGncvx2yFQu/g3lfsI1xzBMtsA0zXl//vw+r1luf+j8pipom9SUTXM97KAY5VsYa4
	+BT8/jHYxlhYVASPyNHgTfwy0EGyz8GZ4GiQStufcuDqf0WREtemOgg8j3CskX0LKt9XB5hZ7
X-Google-Smtp-Source: AGHT+IHqryVfvaMppR36EBnb73Zh/s+HQHLM2pdlkcdRyBztApP6W59/WcvHQIT/QbsfUZvsSy3B8Xlc35fWR2J9zxI=
X-Received: by 2002:a2e:a58e:0:b0:302:3abc:d9e8 with SMTP id
 38308e7fff4ca-3025459d237mr2086981fa.32.1734050363671; Thu, 12 Dec 2024
 16:39:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203162908.302354-9-cel@kernel.org> <20241203162908.302354-14-cel@kernel.org>
In-Reply-To: <20241203162908.302354-14-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 12 Dec 2024 19:39:12 -0500
Message-ID: <CAN-5tyFCRcdJ_SRKfb+79dJ8pxRp=N4vb10FT2eYkhcmEb+uhw@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
To: cel@kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 11:29=E2=80=AFAM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Enable the Linux NFS client to observe the progress of an offloaded
> asynchronous COPY operation. This new operation will be put to use
> in a subsequent patch.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c        | 117 ++++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfs4proc.c         |   3 +-
>  include/linux/nfs_fs_sb.h |   1 +
>  3 files changed, 120 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 9d716907cf30..fa180ce7c803 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -21,6 +21,8 @@
>
>  #define NFSDBG_FACILITY NFSDBG_PROC
>  static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid =
*std);
> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *st=
ateid,
> +                                    u64 *copied);
>
>  static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *=
naddr)
>  {
> @@ -582,6 +584,121 @@ static int nfs42_do_offload_cancel_async(struct fil=
e *dst,
>         return status;
>  }
>
> +static void nfs42_offload_status_done(struct rpc_task *task, void *calld=
ata)
> +{
> +       struct nfs42_offload_data *data =3D calldata;
> +
> +       nfs41_sequence_done(task, &data->res.osr_seq_res);
> +       switch (task->tk_status) {
> +       case 0:
> +               return;
> +       case -NFS4ERR_ADMIN_REVOKED:
> +       case -NFS4ERR_BAD_STATEID:
> +       case -NFS4ERR_OLD_STATEID:
> +               /*
> +                * Server does not recognize the COPY stateid. CB_OFFLOAD
> +                * could have purged it, or server might have rebooted.
> +                * Since COPY stateids don't have an associated inode,
> +                * avoid triggering state recovery.
> +                */
> +               task->tk_status =3D -EBADF;
> +               break;
> +       case -NFS4ERR_NOTSUPP:
> +       case -ENOTSUPP:
> +       case -EOPNOTSUPP:
> +               data->seq_server->caps &=3D ~NFS_CAP_OFFLOAD_STATUS;
> +               task->tk_status =3D -EOPNOTSUPP;
> +               break;
> +       default:
> +               if (nfs4_async_handle_error(task, data->seq_server,
> +                                           NULL, NULL) =3D=3D -EAGAIN)
> +                       rpc_restart_call_prepare(task);
> +               else
> +                       task->tk_status =3D -EIO;
> +       }
> +}
> +
> +static const struct rpc_call_ops nfs42_offload_status_ops =3D {
> +       .rpc_call_prepare =3D nfs42_offload_prepare,
> +       .rpc_call_done =3D nfs42_offload_status_done,
> +       .rpc_release =3D nfs42_offload_release
> +};
> +
> +/**
> + * nfs42_proc_offload_status - Poll completion status of an async copy o=
peration
> + * @file: handle of file being copied
> + * @stateid: copy stateid (from async COPY result)
> + * @copied: OUT: number of bytes copied so far
> + *
> + * Return values:
> + *   %0: Server returned an NFS4_OK completion status
> + *   %-EINPROGRESS: Server returned no completion status
> + *   %-EREMOTEIO: Server returned an error completion status
> + *   %-EBADF: Server did not recognize the copy stateid
> + *   %-EOPNOTSUPP: Server does not support OFFLOAD_STATUS
> + *   %-ERESTARTSYS: Wait interrupted by signal
> + *
> + * Other negative errnos indicate the client could not complete the
> + * request.
> + */
> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *st=
ateid,
> +                                    u64 *copied)
> +{
> +       struct nfs_open_context *ctx =3D nfs_file_open_context(file);
> +       struct nfs_server *server =3D NFS_SERVER(file_inode(file));
> +       struct nfs42_offload_data *data =3D NULL;
> +       struct rpc_message msg =3D {
> +               .rpc_proc       =3D &nfs4_procedures[NFSPROC4_CLNT_OFFLOA=
D_STATUS],
> +               .rpc_cred       =3D ctx->cred,
> +       };
> +       struct rpc_task_setup task_setup_data =3D {
> +               .rpc_client     =3D server->client,
> +               .rpc_message    =3D &msg,
> +               .callback_ops   =3D &nfs42_offload_status_ops,
> +               .workqueue      =3D nfsiod_workqueue,
> +               .flags          =3D RPC_TASK_ASYNC | RPC_TASK_SOFTCONN,

I wonder why we are making status_offload an async task? Copy within
which we are doing copy_offload is/was a sync task.

Why is it a SOFTCONN task?

> +       };
> +       struct rpc_task *task;
> +       int status;
> +
> +       if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
> +               return -EOPNOTSUPP;

Let's not forget to mark tasks RPC_TASK_MOVEABLE. I know other
nfs42proc need review and add that but since I remembered it here,
let's add it. It allows for if ever this transport were to be moved,
then the tasks can migrate to another transport.


> +
> +       data =3D kzalloc(sizeof(struct nfs42_offload_data), GFP_KERNEL);
> +       if (data =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       data->seq_server =3D server;
> +       data->args.osa_src_fh =3D NFS_FH(file_inode(file));
> +       memcpy(&data->args.osa_stateid, stateid,
> +               sizeof(data->args.osa_stateid));
> +       msg.rpc_argp =3D &data->args;
> +       msg.rpc_resp =3D &data->res;
> +       task_setup_data.callback_data =3D data;
> +       nfs4_init_sequence(&data->args.osa_seq_args, &data->res.osr_seq_r=
es,
> +                          1, 0);
> +       task =3D rpc_run_task(&task_setup_data);
> +       if (IS_ERR(task)) {
> +               nfs42_offload_release(data);
> +               return PTR_ERR(task);
> +       }
> +       status =3D rpc_wait_for_completion_task(task);
> +       if (status)
> +               goto out;
> +
> +       *copied =3D data->res.osr_count;
> +       if (task->tk_status)
> +               status =3D task->tk_status;
> +       else if (!data->res.complete_count)
> +               status =3D -EINPROGRESS;
> +       else if (data->res.osr_complete !=3D NFS_OK)
> +               status =3D -EREMOTEIO;
> +
> +out:
> +       rpc_put_task(task);
> +       return status;
> +}
> +
>  static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
>                                    struct nfs42_copy_notify_args *args,
>                                    struct nfs42_copy_notify_res *res)
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 405f17e6e0b4..973b8d8fa98b 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10769,7 +10769,8 @@ static const struct nfs4_minor_version_ops nfs_v4=
_2_minor_ops =3D {
>                 | NFS_CAP_CLONE
>                 | NFS_CAP_LAYOUTERROR
>                 | NFS_CAP_READ_PLUS
> -               | NFS_CAP_MOVEABLE,
> +               | NFS_CAP_MOVEABLE
> +               | NFS_CAP_OFFLOAD_STATUS,
>         .init_client =3D nfs41_init_client,
>         .shutdown_client =3D nfs41_shutdown_client,
>         .match_stateid =3D nfs41_match_stateid,
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index b804346a9741..946ca1c28773 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -290,6 +290,7 @@ struct nfs_server {
>  #define NFS_CAP_CASE_INSENSITIVE       (1U << 6)
>  #define NFS_CAP_CASE_PRESERVING        (1U << 7)
>  #define NFS_CAP_REBOOT_LAYOUTRETURN    (1U << 8)
> +#define NFS_CAP_OFFLOAD_STATUS (1U << 9)
>  #define NFS_CAP_OPEN_XOR       (1U << 12)
>  #define NFS_CAP_DELEGTIME      (1U << 13)
>  #define NFS_CAP_POSIX_LOCK     (1U << 14)
> --
> 2.47.0
>
>

