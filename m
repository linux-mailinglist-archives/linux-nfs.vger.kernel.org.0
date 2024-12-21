Return-Path: <linux-nfs+bounces-8700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A418D9FA103
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0944916650F
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Dec 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD971F2C59;
	Sat, 21 Dec 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Lin6bCD9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF51F190D
	for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734791813; cv=none; b=AN/sCDwC/cM0+48bAj9h5Hlc20x7LVxzsSrSSWgNt+qIOqMkBAjZGzER44kPAZqYecDAK5motWP8L9dHJT4x3apXGR/n3D3QIBsIVytKazmVxjpCefD/67tQRVyAHnq9xbxEyOiVf9+alOpVHt3xtlYpLvAho+FtWcXgT7P94aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734791813; c=relaxed/simple;
	bh=+vwwanT6bLFJ2q55Z0vemHAlJjk6TVFcmHmUF6+ZiA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKnpZsi5vNLMg7mZKWfSsAH1y6UCIB95w48v1vmemXxH/ISsiOiVO7rYEx50E+Bo/VGCv3PWiWyuTnzsF20420HgJjhtv00X0EkGeqU9ZTMfCVYDFRIkaGFaHVUlUMZr/TMHV6uO6Hfet/ZD4J63WQKiKg58mdFeqI7vhkbK6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Lin6bCD9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c68b89eso3279241e87.0
        for <linux-nfs@vger.kernel.org>; Sat, 21 Dec 2024 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1734791809; x=1735396609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NTb02ePEn2pnW3xcQc27mi6YB11X+c08IgcdFqwpc8=;
        b=Lin6bCD9R4wvp2fXubwd+Az36s6V3RzJSv3gvvK6wS0Vpso0gx+ZCQOUyCIyOy0mCe
         4axTs44xeyCYFm+jmgv/tnp+Hj4gaO1sWFn9vHKn4XOO8R7l5fiTXm6hw2tpR64sbb1F
         e/paq5nmyg24Vi8Xe3ZLLHpiXNSp2lKK0J/jPaPderBq9m4C/Ten2T45SQphQ7WX3PIU
         4yepCGvbbNJkyHKy+j7sBsRwhYiKAKk6vi+R1aVvXhQ5mZZGTYV0/Iz+x3fQtgm6NeI0
         qHWlm8Ss+qSQQ7og60Z/ZiSHCr+Ec5plD/1F7H1FSmEmVThKqQe7qyco3lZqyQ0MYkjb
         I0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734791809; x=1735396609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NTb02ePEn2pnW3xcQc27mi6YB11X+c08IgcdFqwpc8=;
        b=KSN6seukxGNhLUjBj3DKUWkLCum5K16MMvRosl/sYtWM73dT2u5FEAlAzy/r88Airz
         OWVygUEU3RW4fJBrQI25uoss86WzIh6TvSG+3pjw5kNgIZV6/Q8eBThC4B8OQRAojwYA
         TGTZ95RHEvjEPSzHQBpUMdZeVCfJVVDHrq1o5mkI6uH84T2JeXozmGf3elBK38qm4A1B
         aBK2EikRqgGd7a69fThUunYP/pH3AeQJ2qdSRgScFwxeDh5vD4yiMJE5wuT6JOzgUBwq
         yRsKT7/BDphgUdAe354mj37L9RlGhLrnAxhRfxKx3q2lf5CMWs34ieMj2oaVesSlr5+z
         BWCw==
X-Forwarded-Encrypted: i=1; AJvYcCWwXNGUjWdo2239uNmNwDVA8NmEuzpKhxsPhUiMHkFlxVpPiZOeBxg6ampaDjXEeAipwlpq7EH4cRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxROQkVFEJXA5BAQO2EOvks0kUV5IwqgcJpjegjDhxqzCcpbqI5
	D/ixSSVxVUM94p1AGFx7YZCfdum8VwH6sBdiqoPxVnchxyjpn46rW0oOKTUzZeL8VWk811Tq2Ed
	ska4cpq8tttZDSs1JH/sPiYktNYQ=
X-Gm-Gg: ASbGncunIPfszdAKR2LC0xvp78TmApO9QHB4gj2iCxOZMS1gRhgurS5YaincAYvaJzH
	P7UmpHvqKTDkH1TQmxBGjUeE+aI61GbG6ETS5HejUd6ZuzZ2PQCAXIdVEzjtEodoDY0pdCnY=
X-Google-Smtp-Source: AGHT+IHOgsPhhp16to0YieDmjBXNZti5D47F2gE4eC3QicYBCI20YtGK9A14TlDZHkjge0oCiesxLDoAr6Hjk05QrD4=
X-Received: by 2002:a05:6512:3a85:b0:542:2193:c11 with SMTP id
 2adb3069b0e04-54221930c19mr3380116e87.1.1734791808581; Sat, 21 Dec 2024
 06:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220154227.16873-9-cel@kernel.org> <20241220154227.16873-15-cel@kernel.org>
In-Reply-To: <20241220154227.16873-15-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Sat, 21 Dec 2024 09:36:37 -0500
Message-ID: <CAN-5tyF=bshFm8FHT+s8mX4SJr1OksH59D05dKY7svtehVueQw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
To: cel@kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 10:46=E2=80=AFAM <cel@kernel.org> wrote:
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
>  fs/nfs/nfs42proc.c | 70 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 11 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 7fd0f2aa42d4..65cfdb5c7b02 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -175,6 +175,25 @@ int nfs42_proc_deallocate(struct file *filep, loff_t=
 offset, loff_t len)
>         return err;
>  }
>
> +/* Wait this long before checking progress on a COPY operation */
> +enum {
> +       NFS42_COPY_TIMEOUT      =3D 3 * HZ,

I'm really not a fan of such a short time out. This make the
OFFLOAD_STATUS a more likely operation rather than a less likely
operation to occur during a copy. OFFLOAD_STATUS and CB_OFFLOAD being
concurrent operations introduce races which we have to try to account
for.

> +};
> +
> +static void nfs4_copy_dequeue_callback(struct nfs_server *dst_server,
> +                                      struct nfs_server *src_server,
> +                                      struct nfs4_copy_state *copy)
> +{
> +       spin_lock(&dst_server->nfs_client->cl_lock);
> +       list_del_init(&copy->copies);
> +       spin_unlock(&dst_server->nfs_client->cl_lock);
> +       if (dst_server !=3D src_server) {
> +               spin_lock(&src_server->nfs_client->cl_lock);
> +               list_del_init(&copy->src_copies);
> +               spin_unlock(&src_server->nfs_client->cl_lock);
> +       }
> +}
> +
>  static int handle_async_copy(struct nfs42_copy_res *res,
>                              struct nfs_server *dst_server,
>                              struct nfs_server *src_server,
> @@ -184,9 +203,10 @@ static int handle_async_copy(struct nfs42_copy_res *=
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
> @@ -224,15 +244,12 @@ static int handle_async_copy(struct nfs42_copy_res =
*res,
>                 spin_unlock(&src_server->nfs_client->cl_lock);
>         }
>
> -       status =3D wait_for_completion_interruptible(&copy->completion);
> -       spin_lock(&dst_server->nfs_client->cl_lock);
> -       list_del_init(&copy->copies);
> -       spin_unlock(&dst_server->nfs_client->cl_lock);
> -       if (dst_server !=3D src_server) {
> -               spin_lock(&src_server->nfs_client->cl_lock);
> -               list_del_init(&copy->src_copies);
> -               spin_unlock(&src_server->nfs_client->cl_lock);
> -       }
> +wait:
> +       status =3D wait_for_completion_interruptible_timeout(&copy->compl=
etion,
> +                                                          NFS42_COPY_TIM=
EOUT);
> +       if (!status)
> +               goto timeout;
> +       nfs4_copy_dequeue_callback(dst_server, src_server, copy);
>         if (status =3D=3D -ERESTARTSYS) {
>                 goto out_cancel;
>         } else if (copy->flags || copy->error =3D=3D NFS4ERR_PARTNER_NO_A=
UTH) {
> @@ -242,6 +259,7 @@ static int handle_async_copy(struct nfs42_copy_res *r=
es,
>         }
>  out:
>         res->write_res.count =3D copy->count;
> +       /* Copy out the updated write verifier provided by CB_OFFLOAD. */
>         memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf))=
;
>         status =3D -copy->error;
>
> @@ -253,6 +271,36 @@ static int handle_async_copy(struct nfs42_copy_res *=
res,
>         if (!nfs42_files_from_same_server(src, dst))
>                 nfs42_do_offload_cancel_async(src, src_stateid);
>         goto out_free;
> +timeout:
> +       status =3D nfs42_proc_offload_status(dst, &copy->stateid, &copied=
);

Regardless of what OFFLOAD_STATUS returned we have to check whether or
not the CB_OFFLOAD had arrived while we were waiting for the reply to
the OFFLOAD_STATUS.

> +       if (status =3D=3D -EINPROGRESS)
> +               goto wait;
> +       nfs4_copy_dequeue_callback(dst_server, src_server, copy);
> +       switch (status) {
> +       case 0:
> +               /* The server recognized the copy stateid, so it hasn't
> +                * rebooted. Don't overwrite the verifier returned in the
> +                * COPY result. */
> +               res->write_res.count =3D copied;
> +               goto out_free;

In case OFFLOAD_STATUS was successful and CB_OFFLOAD was received we
should take the verifier from the CB_OFFLOAD otherwise we are sending
the unneeede and expensive COMMIT because OFFLOAD_STATUS carries the
completion and value of copy it does not carry the "how committed"
value and thus we are forced to use async copy's "how committed"
value.

> +       case -EREMOTEIO:
> +               /* COPY operation failed on the server. */
> +               status =3D -EOPNOTSUPP;
> +               res->write_res.count =3D copied;
> +               goto out_free;
> +       case -EBADF:
> +               /* Server did not recognize the copy stateid. It has
> +                * probably restarted and lost the plot. */
> +               res->write_res.count =3D 0;
> +               status =3D -EOPNOTSUPP;
> +               break;

This is the case of receiving a BAD_STATEID from OFFLOAD_STATUS and
this would lead to copy falling back to read/write operation. IF we
don't check the existence of CB_OFFLOAD reply, then OFFLOAD_STATUS can
and will carry BAD_STATEID as the server is free to delete copy status
after it get CB_OFFLOAD reply (which as i said we have to check). And
If we did then we need take the result of the CB_OFFLOAD and not act
on OFFLOAD_STATUS's error.

> +       case -EOPNOTSUPP:
> +               /* RFC 7862 REQUIREs server to support OFFLOAD_STATUS whe=
n
> +                * it has signed up for an async COPY, so server is not
> +                * spec-compliant. */
> +               res->write_res.count =3D 0;
> +       }
> +       goto out_free;
>  }
>
>  static int process_copy_commit(struct file *dst, loff_t pos_dst,
> @@ -643,7 +691,7 @@ _nfs42_proc_offload_status(struct nfs_server *server,=
 struct file *file,
>   * Other negative errnos indicate the client could not complete the
>   * request.
>   */
> -static int __maybe_unused
> +static int
>  nfs42_proc_offload_status(struct file *dst, nfs4_stateid *stateid, u64 *=
copied)
>  {
>         struct inode *inode =3D file_inode(dst);
> --
> 2.47.0
>
>

