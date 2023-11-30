Return-Path: <linux-nfs+bounces-188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 133627FE9CC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 08:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714C2B20DD6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610391F934;
	Thu, 30 Nov 2023 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7eNMvhm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81B5B9;
	Wed, 29 Nov 2023 23:36:38 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c61d135d74so559563a12.1;
        Wed, 29 Nov 2023 23:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701329798; x=1701934598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HM3L3d4uonNU2AVbKULv9ZZVZaX9Pb4OKKv/DOGQIic=;
        b=W7eNMvhm4u6vKTT5BE/Pz3yRs4aVtjM4vv9aUQdqRx404Aj5iGW6+kcS8X4LfN0lz2
         OqX+qQlcotajMvEHIGgBeMQqso1xtyPp/TnDwsLw64QkbDAJMNRuiRT98J7UQRMY9h+r
         QkjqEYoThH2ab2q7Ohatfq0vLB15zk0jyjVbc8k4zv6LrrKtkEDPlKRfusGtKIGE5PqX
         zQ+thn3dg1XY1jBpXg73Kik4o5jYK12DiDabtkkWQqFTJ9L2yU8isfhLbs73/rWZFkQg
         cc0H77D3Q10c1ywnYFOaU89zU2+Mhn4LVk0fBIlaDFbOlgLE0JJ0lrhCpv7eG3TKoy/8
         EnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329798; x=1701934598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM3L3d4uonNU2AVbKULv9ZZVZaX9Pb4OKKv/DOGQIic=;
        b=LNwoWNKhRaGJGiT/pksRyWiHoGkhfRfpX5mHIdMbP7X6YgG/jus1gAhfiSTUAp6ful
         qw8g0ABQTFnoxujQ32AmUdnG6JF6bCjWQXVk5Hz94rZsx7wLClBfzEzrLLo5gcLD/B2P
         LvfETSfCilPr6SVudE3eiwlYPWhOimZSm2xfHTwi/aqbH6ddGRmpBqiVeBqdT7LAFNth
         KOi/yc1f07RdU6N7bwm/XFyS8KT3YwndxO8hWIdhT6MXBqsRs2c+1ts0n0jlCjrCc4Nu
         hAAVilW4vk6BSl0j/jjAfzXPOFN/cAxge7q8KH62Ef4UvoA/BPavQtKBFT5N56KclSs9
         KwaQ==
X-Gm-Message-State: AOJu0YwvW2nGNSYKq9c9Yelrg3eUYQm5/uTlhKNsKN/fsHXIFXwNmpJQ
	a8okoxwN+6b1wC+0/kE1tZk=
X-Google-Smtp-Source: AGHT+IFxMyt3kyViwLPrfAUE/MZ6AbR0oHhQ4e/bUk7EU2otfLkDAJKxYx/bFHBLQfbx7Nwe8f5BEQ==
X-Received: by 2002:a05:6a20:3d13:b0:18c:177d:2122 with SMTP id y19-20020a056a203d1300b0018c177d2122mr20170491pzi.2.1701329798177;
        Wed, 29 Nov 2023 23:36:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001cfc4d8eddesm623597plg.180.2023.11.29.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:36:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9444D10FB5154; Thu, 30 Nov 2023 14:36:34 +0700 (WIB)
Date: Thu, 30 Nov 2023 14:36:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Sukruth Sridharan (he/him)" <susridharan@purestorage.com>,
	Linux Network File System <linux-nfs@vger.kernel.org>,
	Linux RDMA <linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: Hung task panic as part of NFS RDMA Disconnect due to possible
 bug on 6.2.0-34-generic client
Message-ID: <ZWg7gGnvVOYjIhx1@archie.me>
References: <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bj68ANcoh+ILJN6F"
Content-Disposition: inline
In-Reply-To: <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>


--Bj68ANcoh+ILJN6F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:52:59AM +0530, Sukruth Sridharan (he/him) wrote:
> I notice the following hung task panic on 6.2.0-34 kernel during RDMA dis=
connect
>=20
> [Wed Nov  1 08:03:54 2023] INFO: task kworker/u16:5:2274646 blocked
> for more than 120 seconds.
> [Wed Nov  1 08:03:55 2023]       Tainted: G        W  OE
> 6.2.0-34-generic #34-Ubuntu
> [Wed Nov  1 08:03:55 2023] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Wed Nov  1 08:03:55 2023] task:kworker/u16:5   state:D stack:0
> pid:2274646 ppid:2      flags:0x00004000
> [Wed Nov  1 08:03:55 2023] Workqueue: xprtiod xprt_autoclose [sunrpc]
> [Wed Nov  1 08:03:55 2023] Call Trace:
> [Wed Nov  1 08:03:55 2023]  <TASK>
> [Wed Nov  1 08:03:55 2023]  __schedule+0x2aa/0x610
> [Wed Nov  1 08:03:55 2023]  schedule+0x63/0x110
> [Wed Nov  1 08:03:55 2023]  schedule_timeout+0x157/0x170
> [Wed Nov  1 08:03:55 2023]  wait_for_completion+0x88/0x150
> [Wed Nov  1 08:03:55 2023]  rpcrdma_xprt_disconnect+0x33f/0x350 [rpcrdma]
> [Wed Nov  1 08:03:55 2023]  xprt_rdma_close+0x12/0x40 [rpcrdma]
> [Wed Nov  1 08:03:55 2023]  xprt_autoclose+0x5c/0x120 [sunrpc]
> [Wed Nov  1 08:03:55 2023]  process_one_work+0x225/0x430
> [Wed Nov  1 08:03:55 2023]  worker_thread+0x50/0x3e0
> [Wed Nov  1 08:03:55 2023]  ? __pfx_worker_thread+0x10/0x10
> [Wed Nov  1 08:03:55 2023]  kthread+0xe9/0x110
> [Wed Nov  1 08:03:55 2023]  ? __pfx_kthread+0x10/0x10
> [Wed Nov  1 08:03:55 2023]  ret_from_fork+0x2c/0x50
> [Wed Nov  1 08:03:55 2023]  </TASK>
>=20
> The flow which induced the bug is as follows:
> 1. Client initiates connection
> 2. Server hands off the response to the first RPC on the connection to
> the NIC (Mellanox ConnectX-5)
> 3. NIC tries to send the response around 6 times and fails the response w=
ith RNR
> 4. Client issues disconnect (possibly because it didn't receive a respons=
e)
> 5. Server cleans up the connection state
> 6. Client runs into the above panic as part of disconnect while draining =
the IOs
>=20
> It looks like re_receiving is set only in rpcrdma_post_recvs, and the
> reason why it wouldn't be reset is if memory-region allocation code
> fails.
> That is possible if disconnect on the client somehow blocks allocation.
>=20
> void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool tem=
p)
> {
>         // ... (some initialization code)
>=20
>     if (atomic_inc_return(&ep->re_receiving) > 1)
>         goto out;
>=20
>         // ... (some allocation code)
>=20
>     if (!wr) // <<<<<<<<<<<<<<<<<< PROBLEM HERE >>>>>>>>>>>>>>>>>>>
>         goto out;
>=20
>         // ... (post recv code, and some error handling)
>=20
>     if (atomic_dec_return(&ep->re_receiving) > 0)
>         complete(&ep->re_done);
>=20
> out:
>     trace_xprtrdma_post_recvs(r_xprt, count);
>     ep->re_receive_count +=3D count;
>     return;
> }
>=20
> static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
> {
>     struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
>     struct rdma_cm_id *id =3D ep->re_id;
>=20
>     /* Wait for rpcrdma_post_recvs() to leave its critical
>      * section.
>      */
>     if (atomic_inc_return(&ep->re_receiving) > 1) //
> <<<<<<<<<<<<<<<<<<< This is not reset, so wait gets stuck
> >>>>>>>>>>>>>>>>>
>         wait_for_completion(&ep->re_done);
>=20
>     /* Flush Receives, then wait for deferred Reply work
>      * to complete.
>      */
>     ib_drain_rq(id->qp);
>=20
>     /* Deferred Reply processing might have scheduled
>      * local invalidations.
>      */
>     ib_drain_sq(id->qp);
>=20
>     rpcrdma_ep_put(ep);
> }
>=20
> Can you help conclude if the above theory around the bug being in the
> client code is right? If not, can you help with steps/data points
> required to debug this further?
>=20

Can you verify that the bug still occurs with latest vanilla kernel
(currently v6.7-rc3)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Bj68ANcoh+ILJN6F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWg7ewAKCRD2uYlJVVFO
o2LoAQD/DycCySM1guMz6DbpdVpzp3oHU+m/0FMWHT5Vu0QIJQEAv1BMp5IzPAne
zyv7DbEj1tZecHdsHzqVgA6taXIhvAU=
=yVp9
-----END PGP SIGNATURE-----

--Bj68ANcoh+ILJN6F--

