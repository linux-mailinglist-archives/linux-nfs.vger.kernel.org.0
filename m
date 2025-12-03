Return-Path: <linux-nfs+bounces-16870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E66C9F58C
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1CE23300195D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76C30275E;
	Wed,  3 Dec 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2+k8mJf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CE2FE06B
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773350; cv=none; b=IjcEXkJdvautDG+a2G8g+1KHKSChqT1gJe5xiZIwx/OtDSCIIpOJ/N6jJUv1NSGidMxp314pPzdISH6+7xgy77HuJevB6K3RvGKRxTkCohIPPsxVJi6ArhupuBTPjE89RtaMZO7gHyIlTc/CbBIzWsjhY6yzKe10f/ipiIve2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773350; c=relaxed/simple;
	bh=JaRPysuCFXzWGBTRBgHJI/V/MgZKSEiuytfrRvpxUCQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XenvHwoeyan4i/+Jwvfpc4eqpY71eOufYY5kiTW1Vk5HohxU0wyU8ohpp7vxWVpiIl8qZSBXh+WpeqI1RzgPqRJUvJSafkaYeDSb6jwcBdo38q4y//WKSHEqtQ7U/4xT0UwRi1+DqQAOzc6hQgxhaQuzDdBRBvS0lA/fsVtvEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2+k8mJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E177AC4CEF5
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764773350;
	bh=JaRPysuCFXzWGBTRBgHJI/V/MgZKSEiuytfrRvpxUCQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=D2+k8mJfXdUwIleLRs9FE3rlfbNK3kY2LgBQKvuwd88R3kZ135771Q2w0OZw/oTzH
	 S5Sd19YyY3gBhKl++KZEblVUDGyrL4Q5+3QoIULBhs4RvrDBIuYoiY7HU490fioY8c
	 xkrOoBn45Ig3fW1hzUUGZnLixc5zq5okBHydt/LLIhR4NYjZEdX482+hSZyC2ycGoF
	 x+KPPfiiW2UmAeH/yshWeUsHOnnXUPlLugBJyX+9sTcbk7KCNPN3JcnICTOO7oVcom
	 +AJ+ZQPPyUM1CtPo3s7+VlVZCGIKaMVGoaGnKjxifq0B01gCvk7Mp5gtDAH2fHHfhY
	 6s+U7x7O1iCVQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2089DF4006A;
	Wed,  3 Dec 2025 09:49:09 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 09:49:09 -0500
X-ME-Sender: <xms:5U0wae3FR2pVyQ4A150Bx9MWqNLKmHRVTgYR-ICG0YARzaThFKub0Q>
    <xme:5U0wab4HbZSFtVoCeHHbV-dFACdZbXgWQrSc7zd8h3gqms8waAkvQTCXiHMr_SdZn
    dw5fRrJDKLrZXEBEsiiZQG8cxGUxf5zONOGY21ogkkCvK-k-QHqObCx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghgruhhrrghvrdhgrghnghgrlhifrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrhhonhgumhihsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtg
    homhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehlihhn
    uhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5U0waQf4Aj5OYpbJsPRoRxHyJCxEOu_KH8CBFueE_LK8zM1h4mJllg>
    <xmx:5U0wacRE2xxca_nYGH6Y6GC9SV1HLNMvXxRN1lj4Funfs0Xut3Y1Uw>
    <xmx:5U0waRa7rhkZZ9UN-F51zlBusVoJ_NXoPm_EkdQWpaAo_SB_PI4-jA>
    <xmx:5U0waXdnLAaq5xuksZ2dt3yqVnJKcTRT36cnKNm8_eMrG5mA4Uhk8A>
    <xmx:5U0waaK1Ha3NbHsyMcQcrt843nTQFy77rJsAtsFpF0NV_JtNoNcy1lgG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00CD7780054; Wed,  3 Dec 2025 09:49:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbSDIoz78V8B
Date: Wed, 03 Dec 2025 09:48:42 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Gaurav Gangalwar" <gaurav.gangalwar@gmail.com>
Cc: trondmy@kernel.org, anna@kernel.org, "Tom Talpey" <tom@talpey.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org
Message-Id: <16323ed1-21d3-4093-b0e1-fa6f5249b194@app.fastmail.com>
In-Reply-To: 
 <CAJiE4O=gK4A8zJVXKGawqb=hx9uwNXNfh1yotVkDDmSfM1DA2A@mail.gmail.com>
References: 
 <CAJiE4OkW6XT71xvv49VN5STPx7dQ6GxV+-Rz1=55JhoFPyM7PQ@mail.gmail.com>
 <20251202095212.69329-1-gaurav.gangalwar@gmail.com>
 <67ae96f3-efe9-45ee-9924-d50d87bc58a7@app.fastmail.com>
 <CAJiE4O=gK4A8zJVXKGawqb=hx9uwNXNfh1yotVkDDmSfM1DA2A@mail.gmail.com>
Subject: Re: [PATCH v2] NFS: inherit parent transport protocol for referral mounts
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Dec 3, 2025, at 3:54 AM, gaurav gangalwar wrote:
> Reply inline
>
> On Tue, Dec 2, 2025 at 7:00=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
>
>>
>>
>> On Tue, Dec 2, 2025, at 4:52 AM, Gaurav Gangalwar wrote:
>> > When following NFS referrals, the client always attempts RDMA first
>> > (if compiled in), even when the parent mount uses TCP. This causes
>> > unnecessary timeouts when the referral server doesn't support RDMA.
>> >
>> > Modify nfs4_create_referral_server() to check the parent client's
>> > transport protocol. Only attempt RDMA if the parent is using RDMA,
>> > otherwise use the parent's protocol (TCP/TCP-TLS) directly.
>> >
>> > This eliminates connection delays for TCP-based referrals in
>> > environments where RDMA is compiled in but not deployed.
>> >
>> > Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
>> >
>> > ---
>> > Changes since v1:
>> > - Removed module parameter.
>> > ---
>> >  fs/nfs/nfs4client.c | 17 ++++++++++++-----
>> >  1 file changed, 12 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
>> > index 3a4baed993c9..39a0424523e5 100644
>> > --- a/fs/nfs/nfs4client.c
>> > +++ b/fs/nfs/nfs4client.c
>> > @@ -1258,12 +1258,19 @@ struct nfs_server
>> > *nfs4_create_referral_server(struct fs_context *fc)
>> >       nfs_server_copy_userdata(server, parent_server);
>> >
>> >       /* Get a client representation */
>> > +     /*
>> > +      * Only try RDMA if the parent client is using RDMA. This avo=
ids
>> > +      * connection delays when parent uses TCP and referral server
>> doesn't
>> > +      * support RDMA.
>> > +      */
>> >  #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
>> > -     rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
>> > -     cl_init.proto =3D XPRT_TRANSPORT_RDMA;
>> > -     error =3D nfs4_set_client(server, &cl_init);
>> > -     if (!error)
>> > -             goto init_server;
>> > +     if (parent_client->cl_proto =3D=3D XPRT_TRANSPORT_RDMA) {
>> > +             rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
>> > +             cl_init.proto =3D XPRT_TRANSPORT_RDMA;
>> > +             error =3D nfs4_set_client(server, &cl_init);
>> > +             if (!error)
>> > +                     goto init_server;
>> > +     }
>> >  #endif       /* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
>> >
>> >       cl_init.proto =3D XPRT_TRANSPORT_TCP;
>> > --
>> > 2.43.7
>>
>> The reason it tries RDMA first is because RDMA is supposed to fail
>> quickly when there's no RDMA-capable path to the remote. If RDMA
>> is taking a long time to fail, there's a problem elsewhere.
>>
> Yes, if client is not  RDMA capable then it fails quickly since transp=
ort
> class won't be registered and xprt_create_transport will fail early wi=
thout
> even trying to connect as we check for xprt_class_find_by_ident.
> But when client is RDMA capable but server is not then it tries to con=
nect
> and times out after 3 mins.

The client should be able to tell quickly that there is not
a complete RDMA-enabled path from client to server. Can you
describe your network?


--=20
Chuck Lever

