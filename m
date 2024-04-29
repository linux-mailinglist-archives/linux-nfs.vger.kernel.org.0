Return-Path: <linux-nfs+bounces-3064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD98B5DD0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9807528254E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5DC74400;
	Mon, 29 Apr 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="b0N3HRqQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F58120C
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404936; cv=none; b=LkfU6yedr00urxgYd+sy9USoYappTVbHtK+ilkWuky6fhHGCGqFB7GmIjLuRmwRGIgfmpIJJOJX6o4wpFUvTFBMhMOqWbPhS9VklU/DGSg3u5DWKIDeo7ILBCRiwZ4tJeW9I2KRwWvwBXJlJhnU6NXjy6z+dS/7ajdiYnO/tK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404936; c=relaxed/simple;
	bh=WAMbZxqy97dM+rivxawsbxri+vlFZtOongYrrkLT+YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBBg/FmotVJUDgY5nyV7ntCJbWXbLA0m+dWkB6wjXyiuxDmz1897Cn7EBlZNhZlaEKam3rTS1h/k8bJZnbQPC/RthgVeN3xgDngYjCtjE1612T8CsT+1SR5Z6vuHrz9MZSF5S/CMyjknjMCtkjCs2lPlb50RFqVlRzUJZhkmeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=b0N3HRqQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db239711ebso11633641fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1714404933; x=1715009733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lt3OlBhtMReJgIXyYLBo2dwTEUtw1j+X3X6ldT4F7AI=;
        b=b0N3HRqQHQ9k90/fUbmwwguzPL72NLQdwINhxTQoO2dqQkRZ01tqNMqEUt2+gmte9l
         XZz7Hvj+o5zz8qx9OafvVLKdQXJWmLHkpFzSUfDgpToLYd/74neNE0G/HOMskrZ7m60m
         tTZ8P02+P7nHrIHkH/ybtFG5O62zelEDx8vdQFs5Cnv9DgFTaiYA/gAFk0C/PfrQG8J9
         ix5Hl3IuiGbIFDvIYBCzS1C7pukSViSd5k1mtyeE9jJNzRQar3kxm3xAGD+7pMyCUPem
         mXaoXB4VakOxaOJbX1bTTdUuVbgxlyS0CfSLsBuO9rp3DSauobs4esR6PEDHS0c2pBXt
         ycjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714404933; x=1715009733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt3OlBhtMReJgIXyYLBo2dwTEUtw1j+X3X6ldT4F7AI=;
        b=v/bqYuItkbQNHw02F9yRlDFxY7BVVCj/5SN1vPSHjmh4OqeiDob11y4jffyybUFVdJ
         11Hsb63vllqMJdi6TnCM6/EgeGfzZIoAjnlgtJm74OXafgukmoadIlYD91L5RyfAj2tv
         3/wktAw3Rg3ZS+X0oVmZq2nWYRv5u6jgNCJLUTC3PDh96ehCdq2HGX0KKJUfcCee8gXu
         jJTvff71ewUbXFfhlBhmCiGNH8qgIWakpGnd4yQm8D1ao/Ke2N8uz3CZSVnvbe4aC5rJ
         BgUgLjQUK11l6VM/ERSsCSVrmWtDepikOfOq156jl6MhUBI+oEF85ML/hQcEv4xrNhjW
         g8hA==
X-Forwarded-Encrypted: i=1; AJvYcCVM9Ssw/Iumu6DOwwlNChQEAeeZhNokd7+oMlZWqkVRgjW0pu1zLUekBSpSMNJEeNkicbKEcKRuPu8eT8JUbbZLkAWnJlzm3Tp/
X-Gm-Message-State: AOJu0YzltfnlGgUT17MCLDU/YNrVqqCazdh7RJ7EEZN0PD66NQiwc6Qj
	gI/gjF+DKiOD2wN4jYU8OpMV0JL3vz9XhgdiSlaiQvRDzVkHCvbMIhKaBjXl1uyEOm2s/crydpn
	PXyB2GBlFkNpGRnpkD3nKfjlJFnEQXQ==
X-Google-Smtp-Source: AGHT+IFprqxU+5VGtxA+r9+8wH6n+agf4UYALvGb01hZZoQGD5vPFfdNTFsMwrazyHs/v70CGXG7bIXD68rKWEYfLp4=
X-Received: by 2002:a2e:97d4:0:b0:2df:1e3e:27e8 with SMTP id
 m20-20020a2e97d4000000b002df1e3e27e8mr6102646ljj.0.1714404932291; Mon, 29 Apr
 2024 08:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429151632.212571-6-cel@kernel.org> <20240429151632.212571-10-cel@kernel.org>
In-Reply-To: <20240429151632.212571-10-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 29 Apr 2024 11:35:20 -0400
Message-ID: <CAN-5tyH2e7uR_GN3vYp201h2U83gra=U8a+57Ughk1BfpRGZaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
To: cel@kernel.org
Cc: Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:22=E2=80=AFAM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> We've found that there are cases where a transport disconnection
> results in the loss of callback RPCs. NFS servers typically do not
> retransmit callback operations after a disconnect.
>
> This can be a problem for the Linux NFS client's implementation of
> asynchronous COPY, which waits indefinitely for a CB_OFFLOAD
> callback. If a transport disconnect occurs while an async COPY is
> running, there's a good chance the client will never get the
> matching CB_OFFLOAD.
>
> Fix this by implementing the OFFLOAD_STATUS operation so that the
> Linux NFS client can probe the NFS server if it doesn't see a
> CB_OFFLOAD in a reasonable amount of time.
>
> This patch implements a simplistic check. As future work, the client
> might also be able to detect whether there is no forward progress on
> the request asynchronous COPY operation, and CANCEL it.

I think this patch series needs a bit more nuances
(1) if we know that server doesn't support offload_status we might as
well wait uninterrupted perhaps? but I can see how as you mentioned we
might want to measure no forward progress and cancel the copy and
fallback to read/write.
(2) we can't really go back to the "wait" after failing a
offload_status as the cb_offload callback might have already arrived
and I think we need to walk the pending_cb_callbacks to make sure we
haven't received it before waiting again (otherwise, we'd wait
forever).
(3) then also there is the case where we woke up and sent the
offload_status and got a 'copy finished' reply but we also got the
cb_callback reply as well and the copy things need to be cleaned up
now.

>
> Suggested-by: Olga Kornievskaia <kolga@netapp.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218735
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c        | 100 +++++++++++++++++++++++++++++++++++---
>  fs/nfs/nfs4trace.h        |   1 +
>  include/linux/nfs_fs_sb.h |   1 +
>  3 files changed, 96 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 7656d7c103fa..224fb3b8696a 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -21,6 +21,7 @@
>
>  #define NFSDBG_FACILITY NFSDBG_PROC
>  static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid =
*std);
> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *st=
ateid);
>
>  static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *=
naddr)
>  {
> @@ -173,6 +174,9 @@ int nfs42_proc_deallocate(struct file *filep, loff_t =
offset, loff_t len)
>         return err;
>  }
>
> +/* Wait this long before checking progress on a COPY operation */
> +#define NFS42_COPY_TIMEOUT     (7 * HZ)
> +
>  static int handle_async_copy(struct nfs42_copy_res *res,
>                              struct nfs_server *dst_server,
>                              struct nfs_server *src_server,
> @@ -222,7 +226,9 @@ static int handle_async_copy(struct nfs42_copy_res *r=
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
> @@ -231,12 +237,20 @@ static int handle_async_copy(struct nfs42_copy_res =
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
> +               status =3D nfs42_proc_offload_status(src, src_stateid);
> +               if (status && status !=3D -EOPNOTSUPP)
> +                       goto wait;
> +               break;
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
> @@ -582,6 +596,80 @@ static int nfs42_do_offload_cancel_async(struct file=
 *dst,
>         return status;
>  }
>
> +static void nfs42_offload_status_prepare(struct rpc_task *task, void *ca=
lldata)
> +{
> +       struct nfs42_offload_data *data =3D calldata;
> +
> +       nfs4_setup_sequence(data->seq_server->nfs_client,
> +                               &data->args.osa_seq_args,
> +                               &data->res.osr_seq_res, task);
> +}
> +
> +static void nfs42_offload_status_done(struct rpc_task *task, void *calld=
ata)
> +{
> +       struct nfs42_offload_data *data =3D calldata;
> +
> +       trace_nfs4_offload_status(&data->args, task->tk_status);
> +       nfs41_sequence_done(task, &data->res.osr_seq_res);
> +       if (task->tk_status &&
> +               nfs4_async_handle_error(task, data->seq_server, NULL,
> +                       NULL) =3D=3D -EAGAIN)
> +               rpc_restart_call_prepare(task);
> +}
> +
> +static const struct rpc_call_ops nfs42_offload_status_ops =3D {
> +       .rpc_call_prepare =3D nfs42_offload_status_prepare,
> +       .rpc_call_done =3D nfs42_offload_status_done,
> +       .rpc_release =3D nfs42_free_offload_data,
> +};
> +
> +static int nfs42_proc_offload_status(struct file *file, nfs4_stateid *st=
ateid)
> +{
> +       struct nfs_open_context *ctx =3D nfs_file_open_context(file);
> +       struct nfs_server *server =3D NFS_SERVER(file_inode(file));
> +       struct nfs42_offload_data *data =3D NULL;
> +       struct rpc_task *task;
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
> +       };
> +       int status;
> +
> +       if (!(server->caps & NFS_CAP_OFFLOAD_STATUS))
> +               return -EOPNOTSUPP;
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
> +               nfs42_free_offload_data(data);
> +               return PTR_ERR(task);
> +       }
> +       status =3D rpc_wait_for_completion_task(task);
> +       if (status =3D=3D -ENOTSUPP)
> +               server->caps &=3D ~NFS_CAP_OFFLOAD_STATUS;
> +       rpc_put_task(task);
> +       return status;
> +}
> +
>  static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
>                                    struct nfs42_copy_notify_args *args,
>                                    struct nfs42_copy_notify_res *res)
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 8f32dbf9c91d..9bcc525c71d1 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -2564,6 +2564,7 @@ DECLARE_EVENT_CLASS(nfs4_offload_class,
>                         ), \
>                         TP_ARGS(args, error))
>  DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_cancel);
> +DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_status);
>
>  DECLARE_EVENT_CLASS(nfs4_xattr_event,
>                 TP_PROTO(
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 92de074e63b9..0937e73c4767 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -278,6 +278,7 @@ struct nfs_server {
>  #define NFS_CAP_LGOPEN         (1U << 5)
>  #define NFS_CAP_CASE_INSENSITIVE       (1U << 6)
>  #define NFS_CAP_CASE_PRESERVING        (1U << 7)
> +#define NFS_CAP_OFFLOAD_STATUS (1U << 8)
>  #define NFS_CAP_POSIX_LOCK     (1U << 14)
>  #define NFS_CAP_UIDGID_NOMAP   (1U << 15)
>  #define NFS_CAP_STATEID_NFSV41 (1U << 16)
> --
> 2.44.0
>
>

