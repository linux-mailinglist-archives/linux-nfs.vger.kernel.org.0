Return-Path: <linux-nfs+bounces-198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC017FEEEE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE6FB20E0A
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7FD4655D;
	Thu, 30 Nov 2023 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WPO6CnWv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3DD50
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 04:23:52 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7c45280b1a9so278707241.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 04:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1701347032; x=1701951832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQtWxxCagAD9kulef8UFlDYxoFJEsw7sqYTGkQrTOb8=;
        b=WPO6CnWvIaSqEngxCdljJOX5/SGKIx9YHKPg3XfKgPmz+cgl6t3zY9ZlPzaogPmY9h
         s+12QL/F8zVx/wI/uYlLqP/tt6DNyIXSXlSctGo2fjrdyWx4bLQUdtKhfEFa1MUDy8uj
         ygJ7pDflrxGpOFIAg/HgyXzKoGedCnhBhWdqiJgmoRrAPR63M0sRAfpq0J0BDsfO3b9p
         yFDircD/j6WLqKo4PcNGO/4eWYtDfWNf34iAspEIbeNlgy+g8zJbZ6z4DM2LlU7azt/M
         xvmrU6NaIIVPa1cbJRf5+4JtICAo6ULLSm1fkRqJlWhTddj5bH+e7/P7yxZdzLgMEnWf
         6t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701347032; x=1701951832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQtWxxCagAD9kulef8UFlDYxoFJEsw7sqYTGkQrTOb8=;
        b=ZFfy/1sX1spN5qqG9u3MLpW2XSSY4oqcKwVDcSU9cdpj/dGfRrRlsg/8mZW6R+MTHD
         YZ9BDZpQ5St3Pp6SOqvZUNFnrnCIj9S/beOnquAULC8lWbjdfbjIpX2n7czJWegI/Wm+
         I/7kqjTbCdRgLU6QHLtNzHZCYn4AtsFq7zZWRDOv8CEb7sA5nTPGRy33rt7GZbSGAH+K
         uV0I5aPW6gEUO+FJbQAWW7nq+5nk4bQWLKHKY3R47mXeIWgs7Xq1SO+jOfsEIVsMfl+r
         7qChSZZfl5Ao9UEYDSOvDl98+S9oi1VhKM38bBtcjfuyhJMVFYPOi5aNKYzkjp1w7hzs
         byYQ==
X-Gm-Message-State: AOJu0Yw8T7DpJDK3MMqwDVaJsmqj49ohibDkDOiEAfSigzjKDHrrnvEd
	a0R8djI00aaWD4lErv6VgahZRtp01zuofbmF7xOmZQ==
X-Google-Smtp-Source: AGHT+IGZfEcHmHnyqOLuvFWMZrC4HO7B75BjRjpM3b8Us4GRCoJRrv3HLmmSpp2RpOd4oGrC5J7yRXjVNnPXY5LzKik=
X-Received: by 2002:a05:6122:2224:b0:495:c464:a2fe with SMTP id
 bb36-20020a056122222400b00495c464a2femr24797150vkb.2.1701347031807; Thu, 30
 Nov 2023 04:23:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>
 <ZWg7gGnvVOYjIhx1@archie.me>
In-Reply-To: <ZWg7gGnvVOYjIhx1@archie.me>
From: "Sukruth Sridharan (he/him)" <susridharan@purestorage.com>
Date: Thu, 30 Nov 2023 17:53:40 +0530
Message-ID: <CAMyEAb-D9pe1yAcsiwaPs94sRm=ncLndp--oqPPOGUwuUfdTbA@mail.gmail.com>
Subject: Re: Hung task panic as part of NFS RDMA Disconnect due to possible
 bug on 6.2.0-34-generic client
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Network File System <linux-nfs@vger.kernel.org>, Linux RDMA <linux-rdma@vger.kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 1:06=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Thu, Nov 30, 2023 at 10:52:59AM +0530, Sukruth Sridharan (he/him) wrot=
e:
> > I notice the following hung task panic on 6.2.0-34 kernel during RDMA d=
isconnect
> >
> > [Wed Nov  1 08:03:54 2023] INFO: task kworker/u16:5:2274646 blocked
> > for more than 120 seconds.
> > [Wed Nov  1 08:03:55 2023]       Tainted: G        W  OE
> > 6.2.0-34-generic #34-Ubuntu
> > [Wed Nov  1 08:03:55 2023] "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [Wed Nov  1 08:03:55 2023] task:kworker/u16:5   state:D stack:0
> > pid:2274646 ppid:2      flags:0x00004000
> > [Wed Nov  1 08:03:55 2023] Workqueue: xprtiod xprt_autoclose [sunrpc]
> > [Wed Nov  1 08:03:55 2023] Call Trace:
> > [Wed Nov  1 08:03:55 2023]  <TASK>
> > [Wed Nov  1 08:03:55 2023]  __schedule+0x2aa/0x610
> > [Wed Nov  1 08:03:55 2023]  schedule+0x63/0x110
> > [Wed Nov  1 08:03:55 2023]  schedule_timeout+0x157/0x170
> > [Wed Nov  1 08:03:55 2023]  wait_for_completion+0x88/0x150
> > [Wed Nov  1 08:03:55 2023]  rpcrdma_xprt_disconnect+0x33f/0x350 [rpcrdm=
a]
> > [Wed Nov  1 08:03:55 2023]  xprt_rdma_close+0x12/0x40 [rpcrdma]
> > [Wed Nov  1 08:03:55 2023]  xprt_autoclose+0x5c/0x120 [sunrpc]
> > [Wed Nov  1 08:03:55 2023]  process_one_work+0x225/0x430
> > [Wed Nov  1 08:03:55 2023]  worker_thread+0x50/0x3e0
> > [Wed Nov  1 08:03:55 2023]  ? __pfx_worker_thread+0x10/0x10
> > [Wed Nov  1 08:03:55 2023]  kthread+0xe9/0x110
> > [Wed Nov  1 08:03:55 2023]  ? __pfx_kthread+0x10/0x10
> > [Wed Nov  1 08:03:55 2023]  ret_from_fork+0x2c/0x50
> > [Wed Nov  1 08:03:55 2023]  </TASK>
> >
> > The flow which induced the bug is as follows:
> > 1. Client initiates connection
> > 2. Server hands off the response to the first RPC on the connection to
> > the NIC (Mellanox ConnectX-5)
> > 3. NIC tries to send the response around 6 times and fails the response=
 with RNR
> > 4. Client issues disconnect (possibly because it didn't receive a respo=
nse)
> > 5. Server cleans up the connection state
> > 6. Client runs into the above panic as part of disconnect while drainin=
g the IOs
> >
> > It looks like re_receiving is set only in rpcrdma_post_recvs, and the
> > reason why it wouldn't be reset is if memory-region allocation code
> > fails.
> > That is possible if disconnect on the client somehow blocks allocation.
> >
> > void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool t=
emp)
> > {
> >         // ... (some initialization code)
> >
> >     if (atomic_inc_return(&ep->re_receiving) > 1)
> >         goto out;
> >
> >         // ... (some allocation code)
> >
> >     if (!wr) // <<<<<<<<<<<<<<<<<< PROBLEM HERE >>>>>>>>>>>>>>>>>>>
> >         goto out;
> >
> >         // ... (post recv code, and some error handling)
> >
> >     if (atomic_dec_return(&ep->re_receiving) > 0)
> >         complete(&ep->re_done);
> >
> > out:
> >     trace_xprtrdma_post_recvs(r_xprt, count);
> >     ep->re_receive_count +=3D count;
> >     return;
> > }
> >
> > static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
> > {
> >     struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
> >     struct rdma_cm_id *id =3D ep->re_id;
> >
> >     /* Wait for rpcrdma_post_recvs() to leave its critical
> >      * section.
> >      */
> >     if (atomic_inc_return(&ep->re_receiving) > 1) //
> > <<<<<<<<<<<<<<<<<<< This is not reset, so wait gets stuck
> > >>>>>>>>>>>>>>>>>
> >         wait_for_completion(&ep->re_done);
> >
> >     /* Flush Receives, then wait for deferred Reply work
> >      * to complete.
> >      */
> >     ib_drain_rq(id->qp);
> >
> >     /* Deferred Reply processing might have scheduled
> >      * local invalidations.
> >      */
> >     ib_drain_sq(id->qp);
> >
> >     rpcrdma_ep_put(ep);
> > }
> >
> > Can you help conclude if the above theory around the bug being in the
> > client code is right? If not, can you help with steps/data points
> > required to debug this further?
> >
>
> Can you verify that the bug still occurs with latest vanilla kernel
> (currently v6.7-rc3)?
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

The issue has been seen once in the past few weeks.
Unfortunately, we're yet to see a repro of the same.
We will try to repro it on the latest kernel.
Curious if there's any improvements gone in that you suspect would
have resolved the issue?

(Apologies for the top post earlier)

Thanks,
Sukruth

