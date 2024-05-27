Return-Path: <linux-nfs+bounces-3396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3A8CF8A5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 07:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242791C20C90
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 05:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC079F0;
	Mon, 27 May 2024 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwAnCtvi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564252F24
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716786974; cv=none; b=W2govaCnrFeOPbOHsfSd1V8nLg7hhiQH0i2rwwsH/XViMh+y71jktDMb73/kHyCXLJyjTukeSK/gDOmC3MYugcU+cLJAqLZ5d6p7QusYTBobrBh/e9wdf6KXzsvniHIVK15eP5lXx6QCZCDOYQI/sSPO9e8PjbFkc3VX6lc+qDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716786974; c=relaxed/simple;
	bh=eb91lajp8bC4qQhybIaYDq+lFrOicsCW9PfhAmkDF2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nOYH46scCcgALBJastsjCTnSAjJ9IHHCBl3aeCzj2sHXJChcc8dovWhaaP4cOqjrxZxj46XYQEjU0HtmlyGJ6bQHxLTBCsa2ozW409wZl+EC75BR792QjdBVXJgaEZi6gau/f6l3el6vIiMNT+68eQSIgjGOx7grpHaY6kG3uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwAnCtvi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso3051860a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 26 May 2024 22:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716786972; x=1717391772; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCMb0Zy9ZpWBJ4JOXHIrTU4BjPrmbDZu8qFQLBYkJ8Y=;
        b=gwAnCtvi4aSdfUDgyvx+DiSNivYW9ErWoGgAbQfBGKRj2T+xzK4MAQkEIrnPpoFPdD
         sTa+vHneZvfksVyZD3PN1KXIcPoXGpEebEZGXw0QBd2o3f49mYXejJjHhpavsgwBRc8f
         mBFIEdQmCDaIUsGlGHAk9cCmoNJ93mVA50Qe5eIFqW2W12f/uw0LxLi9SnvFs7U4esqs
         f6ePDA+NfKi7xHUDe8KKs42/3O+dQLQCvKqonkEO/oJBdCEdrD1Ez+MBqdZucEe0k+dj
         X/vxFHldCjjnenTeDOyjhbNuvGPHPcdqOtaJkHmLf2CVT5ToaoAqYkQ2mIhE8yAgEm2Q
         4IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716786972; x=1717391772;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCMb0Zy9ZpWBJ4JOXHIrTU4BjPrmbDZu8qFQLBYkJ8Y=;
        b=jTT6UVMHsE73RDU4UBeWE1DMWmX+5opZlm94bwyEaWsOBAP0+sZ20sJ+ML+womHBsu
         S0az6aWCghrTOgYBbZT252DV8qeRFkhgq8ruFVpW9eImT7JO6qfKPzFU+XccPu2mDTYg
         Nez+mHG5sooeqYKcOUcj14DoZ5IjrUZ1TkbpjHxlgeozf1gCybAuUAuamNVM0exbpjFM
         cKXs6bzwUNJAPrieI4c684AyWeZsoW+E64wbKcueb/fU8qWaf6n5sRxbI9E2qFzDrQLW
         Fjfe6vPh/2hu3G7jqqZL+Jvux+XyEQmtdvW2xmKBJfotGRDqfN5BP7OBPhxihuu+HhTk
         a+aw==
X-Forwarded-Encrypted: i=1; AJvYcCXqbzGOCmgfsS2aHCljF4bRVoYFNjSsfXCAAmg1EB+0/tjMqb4+L+l62jZMk7LbPj6GAJRdLH+UC8GJWkMRGReP4LVqY6DU3CxL
X-Gm-Message-State: AOJu0Yz/pugS1dDvHc7dtuTlJGtytMJlVO/ZgqfW07uW2z/YUEAYhT1+
	Jw79icleB0c69UiVcUlTGQexjwTxT/pl6NyQ0iymtJIhxHMdxKj8hOgTJNAgJqusOKrBAs57YGc
	GfYvaXOTAhWAo0EvZg+Zq009RFRszFpoM
X-Google-Smtp-Source: AGHT+IGh3emadAtNLo9FSZT38a1f1IcVqbe0VI0UBp4hBlO5UjfRcc24KFx9LeRV6Y1MItiS1gHdRQBpQbO07uLfJkM=
X-Received: by 2002:a50:f68d:0:b0:578:5f47:145a with SMTP id
 4fb4d7f45d1cf-5785f4715e3mr6533922a12.4.1716786971496; Sun, 26 May 2024
 22:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJiE4OkE5=6Jw3kf+vrfDYsR5ybJDKUffWGXAQd2R2AJO=4Fwg@mail.gmail.com>
 <CAJiE4Okdie0u0YCxHj6XsQOcxTYecqQ=P-R=iuzn-iipphkwHQ@mail.gmail.com>
 <04BECFE4-7BC0-40CE-90DE-9EEF0DB973BF@oracle.com> <CAJiE4Ok5FLgk0Asq92m7HhDwAgbiTuWo57ff=i_zaOxhnV6YvA@mail.gmail.com>
 <CAJiE4Om+HWMCuQYsxsaOCnTAZAuLxA4B+3phqeTJNT81gp_mJw@mail.gmail.com>
 <CAJiE4OnNpnJb7EYfujgcRbaUPqruo2j3hOdmmt3LHNHEJ8bw6g@mail.gmail.com>
 <ZcecJNwQnXPpJ3fT@tissot.1015granger.net> <CAJiE4O=7C=6rAfkzw4dT9bs_VrxLCqYhp1tszn2h62P2ZVuiGg@mail.gmail.com>
 <36C42C4D-E296-41B0-8418-1CFC5AB61107@oracle.com> <CAJiE4Okpwnh4aQvfaVqaSt=vHo6cVuid4w9Xd4_yGEaa3ZkGQQ@mail.gmail.com>
In-Reply-To: <CAJiE4Okpwnh4aQvfaVqaSt=vHo6cVuid4w9Xd4_yGEaa3ZkGQQ@mail.gmail.com>
From: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Date: Mon, 27 May 2024 10:45:59 +0530
Message-ID: <CAJiE4OnAwurNwF+jRB84H3sfM2VK5+4Ci3a6ovrZk75zmV2Hdw@mail.gmail.com>
Subject: Re: NFS4.0 rdma with referal
To: Chuck Lever III <chuck.lever@oracle.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Facing one more issue while using referrals with RDMA
If RDMA is enabled and supported on both client and server and If we
mount parent with TCP. Then referral/submount mount will be done over
RDMA instead of TCP, since for referral/submount mount the client
tries with RDMA first and then TCP only of RDMA connections fails.

As we can see here parent /home  .160, mounted with tcp, t1 is
referral mount mounted with rdma

> /root/tcp-mnt1 from 10.53.87.160:/home
>  Flags: rw,relatime,vers=3D4.0,rsize=3D1048576,wsize=3D1048576,namlen=3D2=
55,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D10.53.87=
.158,local_lock=3Dnone,addr=3D10.53.87.160
>
> /root/tcp-mnt1/t1 from 10.53.87.157:/:home/t1
>  Flags: rw,relatime,vers=3D4.0,rsize=3D1048576,wsize=3D1048576,namlen=3D2=
55,hard,proto=3Drdma,port=3D20049,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3D10.53.87.158,local_lock=3Dnone,addr=3D10.53.87.157


Code which tries RDMA first, can we get transport type from parent and
use the same?

> #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
>
>         rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
>
>         error =3D nfs4_set_client(server,
>
>                                 ctx->nfs_server.hostname,
>
>                                 &ctx->nfs_server._address,
>
>                                 ctx->nfs_server.addrlen,
>
>                                 parent_client->cl_ipaddr,
>
>                                 XPRT_TRANSPORT_RDMA,
>
>                                 parent_server->client->cl_timeout,
>
>                                 parent_client->cl_mvops->minor_version,
>
>                                 parent_client->cl_nconnect,
>
>                                 parent_client->cl_max_connect,
>
>                                 parent_client->cl_net,
>
>                                 &parent_client->cl_xprtsec);
>
>         if (!error)
>
>                 goto init_server;
>
> #endif  /* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
>
>

Regards,
Gaurav Gangalwar

On Tue, Feb 27, 2024 at 6:22=E2=80=AFPM gaurav gangalwar
<gaurav.gangalwar@gmail.com> wrote:
>
> One more issue with referral code is there is no retry on connection fail=
ure
>
>> Feb 26 01:49:32 rbt-el7-1 kernel: nfs_create_rpc_client: cannot create R=
PC client. Error =3D -111
>> Feb 26 01:49:32 rbt-el7-1 kernel: NFS4: Couldn't follow remote path
>> Feb 26 01:49:32 rbt-el7-1 kernel: <-- nfs4_get_referral_tree() =3D -111 =
[error]
>
>
> I was expecting retries from the client if submount fails if it's a hard =
mount on parent, but it fails submount.
> I can understand we will be stuck in a loop if fs info is not valid, then=
 connection will always fail.
>
> Regards,
> Gaurav Gangalwar
>
> On Mon, Feb 12, 2024 at 7:23=E2=80=AFPM Chuck Lever III <chuck.lever@orac=
le.com> wrote:
>>
>>
>>
>> > On Feb 12, 2024, at 12:51=E2=80=AFAM, gaurav gangalwar <gaurav.gangalw=
ar@gmail.com> wrote:
>> >
>> > I think I was using an older kernel version on a client which doesn't =
have your fix.
>> > I tried with the newer version v5.10, it worked fine.
>> >
>> > The only issue I see is we are not inheriting port from the parent in =
nfs4_create_referral_server, so even if I use port=3D20047 in mount it will=
 try referral submount on 20049 only.
>> >
>> > rpc_set_port(data->addr, NFS_RDMA_PORT);
>> >
>> > We could inherit this also from parent?
>>
>> The client is supposed to use the port number information contained
>> in the referral. There's nothing that mandates that the two servers
>> will use the same alternate port.
>>
>> Using a constant here is probably wrong for both the TCP and RDMA
>> cases, though.
>>
>>
>> --
>> Chuck Lever
>>
>>

