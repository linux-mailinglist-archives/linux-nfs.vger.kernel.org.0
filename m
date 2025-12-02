Return-Path: <linux-nfs+bounces-16846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA6C9B994
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 14:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 001464E174A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7C312820;
	Tue,  2 Dec 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmgN+RSz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4230FF39
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682253; cv=none; b=ZSX0kmcvUS+lv6DBpINrE28e+UXGy6EF6dqzzGUKFyapSEv+zwQnCGfByuyOT/qcs12702e5GUnlgqOW8o/ZW/tUdLQ5b9S8eJQC1AKDqX/N47ppUm/rvITcvxQ+2XwmJQNWKypi/edoMdYUBuQ0mw7HOkEhBiGExmUlxa9H+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682253; c=relaxed/simple;
	bh=uH8Hrj3CxylpoxxMlepAkaZd9o4VmK7o2JSGH7YCt4A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EwZZbWxJ9dQNjpg6DMbdzrwOKZe8ACZ1fxs8K6ORzyIIH5/WEoM8qpSa4n6y2mDnwALodKgGSKM8pOzfmFJQI4ATxE+zADfO44GHxH8LJ7wTDbXaf94QM2rk/ileLVHTfUVakH/cN9nqftlhlJlvZTz2TVg8PrO2p46ASjtvfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmgN+RSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4952AC4AF09;
	Tue,  2 Dec 2025 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764682252;
	bh=uH8Hrj3CxylpoxxMlepAkaZd9o4VmK7o2JSGH7YCt4A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TmgN+RSzTavPFHXxlygDXEgH1Rz01endsX7Ey628WC6unaNTG1zjIVt7zxUQrnQnS
	 rAYwP/UQsU2a4ynFylgAIqGZQWQksKmg6+T7vxaCfBppbrxd5/b1u72txxhqCOZNDf
	 6WpeHSa+mrDMPwa3vQZJBAGBNbSsfoQhyl0LHuONJkMDeYjP6WQcORHchAqMdGpPX+
	 9IWaoA2SnGe0dk9FUkj4pNFaKyT6Le54+qxYtbRCnxJs6f//iLIHRpsnSAVEFjF/9+
	 JXnyJLuHGwWxTRBHQXXh9dO4JWFbStKsEMfOU6/AgPCsY9szeIaPBXI4Vnras8Jjxx
	 oTqBYebU3IdOw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49AACF40083;
	Tue,  2 Dec 2025 08:30:51 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 02 Dec 2025 08:30:51 -0500
X-ME-Sender: <xms:C-ouaTxBgKj5EvSYQEBwYMpl63EXNV8BJAwL7UM_SuutMkgzydeaPA>
    <xme:C-ouaWGCFgCHzjETNjlymi5Goyig2edB-o7o96O3BNCO6X5N0tSB5-c6Jh51iZLlh
    CP4qyiDeHJaXINqkuInMpR6lrffrBhEYmPU8snmQ1-4czhIW9RUsZH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgrghurhgrvhdrghgrnhhgrghlfigrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    grnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hrughmrgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C-ouaZaYe9vdtbcyrGXbnIj-BBKXm6mUJXuCPMOjerybTuBX_KJRVw>
    <xmx:C-ouaacbTI9Mo679Oy_isE3JwZ9YXtJXKGjVE9vDTSgQ6cqoFjrxVA>
    <xmx:C-ouab0rDijFWMCHvx9NwZm9lOC5fhFTHdYjIs-UUIPlPcdhZzDJfg>
    <xmx:C-ouaZJo-Y_4At_vnBAluK14yzb0YgjgP3VDKnYkpCgj8uYe7npMOQ>
    <xmx:C-ouaSFwSfdz2WnfxAH2vojW_A6vIn4IUzCr0eny0TOKqBoEz0Wx4EOU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0023778006C; Tue,  2 Dec 2025 08:30:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbSDIoz78V8B
Date: Tue, 02 Dec 2025 08:30:30 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Gaurav Gangalwar" <gaurav.gangalwar@gmail.com>, trondmy@kernel.org,
 anna@kernel.org, "Tom Talpey" <tom@talpey.com>,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Message-Id: <67ae96f3-efe9-45ee-9924-d50d87bc58a7@app.fastmail.com>
In-Reply-To: <20251202095212.69329-1-gaurav.gangalwar@gmail.com>
References: 
 <CAJiE4OkW6XT71xvv49VN5STPx7dQ6GxV+-Rz1=55JhoFPyM7PQ@mail.gmail.com>
 <20251202095212.69329-1-gaurav.gangalwar@gmail.com>
Subject: Re: [PATCH v2] NFS: inherit parent transport protocol for referral mounts
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 2, 2025, at 4:52 AM, Gaurav Gangalwar wrote:
> When following NFS referrals, the client always attempts RDMA first
> (if compiled in), even when the parent mount uses TCP. This causes
> unnecessary timeouts when the referral server doesn't support RDMA.
>
> Modify nfs4_create_referral_server() to check the parent client's
> transport protocol. Only attempt RDMA if the parent is using RDMA,
> otherwise use the parent's protocol (TCP/TCP-TLS) directly.
>
> This eliminates connection delays for TCP-based referrals in
> environments where RDMA is compiled in but not deployed.
>
> Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
>
> ---
> Changes since v1:
> - Removed module parameter.
> ---
>  fs/nfs/nfs4client.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 3a4baed993c9..39a0424523e5 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1258,12 +1258,19 @@ struct nfs_server 
> *nfs4_create_referral_server(struct fs_context *fc)
>  	nfs_server_copy_userdata(server, parent_server);
> 
>  	/* Get a client representation */
> +	/*
> +	 * Only try RDMA if the parent client is using RDMA. This avoids
> +	 * connection delays when parent uses TCP and referral server doesn't
> +	 * support RDMA.
> +	 */
>  #if IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA)
> -	rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
> -	cl_init.proto = XPRT_TRANSPORT_RDMA;
> -	error = nfs4_set_client(server, &cl_init);
> -	if (!error)
> -		goto init_server;
> +	if (parent_client->cl_proto == XPRT_TRANSPORT_RDMA) {
> +		rpc_set_port(&ctx->nfs_server.address, NFS_RDMA_PORT);
> +		cl_init.proto = XPRT_TRANSPORT_RDMA;
> +		error = nfs4_set_client(server, &cl_init);
> +		if (!error)
> +			goto init_server;
> +	}
>  #endif	/* IS_ENABLED(CONFIG_SUNRPC_XPRT_RDMA) */
> 
>  	cl_init.proto = XPRT_TRANSPORT_TCP;
> -- 
> 2.43.7

The reason it tries RDMA first is because RDMA is supposed to fail
quickly when there's no RDMA-capable path to the remote. If RDMA
is taking a long time to fail, there's a problem elsewhere.


-- 
Chuck Lever

