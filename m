Return-Path: <linux-nfs+bounces-4562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA2924749
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3641C23415
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D11CB32F;
	Tue,  2 Jul 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="a8L5wNg2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4061BC077
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945033; cv=none; b=dRXIG/2BF0kwryBvuCjgsxCfthCGtnHdT4gCl0Ah6l5/RjfRCjmB0NEzMGaX+oX6b6qBp8cxE67XKdGBbS/Q8796k6VhUbVruOVLDCUXOB6ZpeGkozLP1mGf8OqLYvd3AH+X1Unin2diAHb1l86Nn0MgmUhKKxUQXu1WqP9Oe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945033; c=relaxed/simple;
	bh=Qp/3UAeo0alJWUrvMN6aW0mn2cDg+591iTcqoyGkAQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbF4jstPshHeJ5Jj/trwaDu9roWPJUzFva9eHaKsMSH40oG25hg2tPumqL4HTwE70v8yuTIBDyiQVBpAQWmlML4knH9cJfOXhzr7r5FFXV0LXlenSI+hSEr1i1n17IdMCwqMCR/dnXc9Fb98OvCthLu7MmlEnIxYmAH1VXwuOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=a8L5wNg2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ed5af6b214so4253941fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1719945030; x=1720549830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ekP5MdFuz8Cxqw836sFd2fiK717uN1RVRQfTToLWUg=;
        b=a8L5wNg2ytZVv6JE7xTmvp07dW61yyKd8iz02cqYZk9s1NfIDnGAwcxh45E2tvOV3O
         +Pn/+BuyGnIADLm/enp0XmkZU4buSHpUf+0lOHyMo6bYcQv5U/Jb9/Ap6qtg2BXjqODT
         14feM7a1HNzjM9pV/xtbgwuo9TdU81maC4dqy9v07OPH5R2uxXz8E93wdsbAaUSzHA+A
         ds4i+0FSr8q/KMF1VPfblVRd+/7cWibmMrxm89bkj/cA77ldwrbWEclzSf+ud2cgD0UV
         2CmDFR196wn/ytvXeqPGHnAj+ekmbbJhP8fDqRYL2lhGA3xDUAMHjOfs/+TiH0ORC+9T
         vBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945030; x=1720549830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ekP5MdFuz8Cxqw836sFd2fiK717uN1RVRQfTToLWUg=;
        b=iWju+mRl+XiZbtvUcaJ5D3IYTqq/BeaL9JSdjpOPGl230y2M1lcbpeXA2ICLZ0Npp1
         76i2n38Qnuqt4AD+nQc2FiAYtfIhZAg/4gaPIhwCepza4wtEGSUEApoPPf7m1ldJCRxL
         gYe8FclhXJ44aETr8vRbHJlOYfESqxCyq4S/+FrNgTzoQdw5rkB3zyD2YpAhyVL4hQL2
         IMiLfEJvCrNpLZaDLP+faPglGBCUkitJOYKQso3q8Gi47xo4b5vlwFsFxHXmg45YfE7l
         KhWq65qc59KJFJZonxO0DvuLmc2k2p1cOIlCA3G0pLHCW1O+i/xZJQpOhNgzqUAk1lKL
         ifwQ==
X-Gm-Message-State: AOJu0YzH9SkWyW/5ZiO+0dRdUiq5vTPsvJR4muFG0+7wX1hSFT2O+hoA
	35GI7SOWhi8GbgGIoPkbZqcsndR2uuQ+ZiIXqKETQ0cL1dJIT7GnsB1T1JrXEZ8SDXyaE+uLv50
	VCDyFZUD7WogoNRm2rm5amEKDvmY=
X-Google-Smtp-Source: AGHT+IF6mQl1MaBsDYi6Vv+sV8GALjnL59YTvNEM85y49Lh4ri+5R1G1wXr0Q1QFROLLHEWg2cKc+/YtChnEmeXeav0=
X-Received: by 2002:a05:651c:210d:b0:2eb:e6fe:3092 with SMTP id
 38308e7fff4ca-2ee5e6cd8ebmr71486051fa.4.1719945029674; Tue, 02 Jul 2024
 11:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702151947.549814-8-cel@kernel.org> <20240702151947.549814-12-cel@kernel.org>
In-Reply-To: <20240702151947.549814-12-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 2 Jul 2024 14:30:17 -0400
Message-ID: <CAN-5tyFC0O9FMKvQxXd6L9cJgzUO8-Z5-eSAguxUFfr=fVdfng@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:21=E2=80=AFAM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Enable the Linux NFS client to observe the progress of an offloaded
> asynchronous COPY operation. This new operation will be put to use
> in a subsequent patch.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c        | 113 ++++++++++++++++++++++++++++++++++++++
>  include/linux/nfs_fs_sb.h |   1 +
>  2 files changed, 114 insertions(+)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 869605a0a9d5..c55247da8e49 100644
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
> @@ -582,6 +584,117 @@ static int nfs42_do_offload_cancel_async(struct fil=
e *dst,
>         return status;
>  }
>
> +static void nfs42_offload_status_done(struct rpc_task *task, void *calld=
ata)
> +{
> +       struct nfs42_offload_data *data =3D calldata;
> +
> +       if (!nfs4_sequence_done(task, &data->res.osr_seq_res))
> +               return;
> +
> +       switch (task->tk_status) {
> +       case 0:
> +               return;
> +       case -NFS4ERR_DELAY:
> +       case -NFS4ERR_GRACE:
> +               if (nfs4_async_handle_error(task, data->seq_server,
> +                                           NULL, NULL) =3D=3D -EAGAIN)
> +                       rpc_restart_call_prepare(task);
> +               else
> +                       task->tk_status =3D -EIO;
> +               break;
> +       case -NFS4ERR_ADMIN_REVOKED:
> +       case -NFS4ERR_BAD_STATEID:
> +       case -NFS4ERR_OLD_STATEID:
> +               task->tk_status =3D -EBADF;
> +               break;

Hm. Shouldn't we be attempting to do state recovery here?


> +       case -NFS4ERR_NOTSUPP:
> +       case -ENOTSUPP:
> +       case -EOPNOTSUPP:
> +               data->seq_server->caps &=3D ~NFS_CAP_OFFLOAD_STATUS;
> +               task->tk_status =3D -EOPNOTSUPP;
> +               break;
> +       default:
> +               task->tk_status =3D -EIO;
> +       }
> +}
> +
> +static const struct rpc_call_ops nfs42_offload_status_ops =3D {
> +       .rpc_call_prepare =3D nfs42_offload_prepare,
> +       .rpc_call_done =3D nfs42_offload_status_done,
> +       .rpc_release =3D nfs42_offload_release
> +};
> +
> +/*
> + * Return values:
> + *   %0: Server returned an NFS4_OK completion status
> + *   %-EINPROGRESS: Server returned no completion status
> + *   %-EREMOTEIO: Server returned an error completion status
> + *   %-EBADF: Server did not recognize the copy stateid
> + *   %-EOPNOTSUPP: Server does not support OFFLOAD_STATUS
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
> +       };
> +       struct rpc_task *task;
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
> +               nfs42_offload_release(data);
> +               return PTR_ERR(task);
> +       }
> +       status =3D rpc_wait_for_completion_task(task);
> +       if (status)
> +               goto out;
> +
> +       *copied =3D data->res.osr_count;
> +       if (!data->res.complete_count) {
> +               status =3D -EINPROGRESS;
> +               goto out;
> +       }
> +       if (data->res.osr_complete[0] !=3D NFS_OK) {
> +               status =3D -EREMOTEIO;
> +               goto out;
> +       }
> +
> +out:
> +       rpc_put_task(task);
> +       return status;
> +}
> +
>  static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
>                                    struct nfs42_copy_notify_args *args,
>                                    struct nfs42_copy_notify_res *res)
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
> 2.45.2
>
>

