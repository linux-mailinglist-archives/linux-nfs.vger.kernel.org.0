Return-Path: <linux-nfs+bounces-16973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 264AECAA8A0
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A43393035D25
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9BB2FFDE2;
	Sat,  6 Dec 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmKE1cIz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924B2F261D
	for <linux-nfs@vger.kernel.org>; Sat,  6 Dec 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765031886; cv=none; b=CkloYlB7xNnuSVQA5gKIPDs6MwfV1LvEgj0Zs5Zr4EAI3MD9zmJVtVw9nyBoAy9x9/u3uEDONED7At69s64wfUSX7bX3U/D4ET+yWEIv6TmQzL0nSATU6o7vr3KRucfMSlsZ0uhWDmcV1gvA104xq2jJ1a2SlMZDOGchr7LZf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765031886; c=relaxed/simple;
	bh=r1kaDwMLovXRYSkG9s6VRxQxezI7Zw0GWjAl7S5cIQQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qp3HMoKQejuNWRDcv3gcBa7MKYDFjyLgsmezVo9uhNMQiQ+Ud2a0GD40Gan5pbw5tEGpm6tyiZ60tw2hcwl84tAN/aT0S4EXgF/s9ZUj4wzM1UG4TcsaTGW+OfBak2MUA5dZcBoCDOBMmNRhpmCJdb+8ZXLSXUKGtGBLR3F7x9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmKE1cIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62055C4CEF5;
	Sat,  6 Dec 2025 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765031885;
	bh=r1kaDwMLovXRYSkG9s6VRxQxezI7Zw0GWjAl7S5cIQQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SmKE1cIzOiXizNctUkAfiFqzJZostVOvbsWDRr5/PXOOdMl4DJqK215RIfrJ/rRDY
	 bMTq1Uq+PU8IMGRz4fr6NHxIUB0Xck6TTx+kfzrQCxDF/kmuEvxeWr7kQdWS8Cnkyd
	 6j0f3z36aanr3tk75iu5n647MQg4A0mmmWfPIgngzxaQmMLDkuJL1Hes194POPcRUj
	 4yemntXJN4A501tBZW791HdpWP4GAHk77EBP+e1bvZsXjjyYrPhiApKo2Ubalpha35
	 EVExoNB/LUueg3kF5so5jPbQ2+q4Z1nsjiDxD87Hvuq8f17eSBz8neEsNwOAkL7fy/
	 nLIya1qI/uGLg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6DC18F40076;
	Sat,  6 Dec 2025 09:38:04 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 06 Dec 2025 09:38:04 -0500
X-ME-Sender: <xms:zD80abwByXW_LZESxY_s8cKvvAYwy8FQeZLTU5xgvhZ_VwxwtQ9pyA>
    <xme:zD80aeF4Azvnj3KoskdERSVVzQeiR3BwPl15XrVeQIkIwE8JjAuuIrTjN8g_4f-cF
    wQUJ5RmIEl6caYjUKIg_UX9bOX3O6cHsvqiaQ5MlMHNJ6LYvMq3oWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegsfhhivghlughsse
    hfihgvlhgushgvshdrohhrghdprhgtphhtthhopehlihhhrghogihirghnghesihhsrhgt
    rdhishgtrghsrdgrtgdrtghnpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthht
    oheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhkoh
    hrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:zD80aTrTzL1n64HIlxYJKhTgfC7eS9cqbkBYBemAizq62b2uV6DuiQ>
    <xmx:zD80aVzdcgYTvu3rYScZfIEMnWDZLHTc6ITiRFr0Lm3yaz5s-p3caw>
    <xmx:zD80afv1MZS79T5-ogvB1-dACAb30GJ4BfMMIo5rXuQi0jq8-d9pTg>
    <xmx:zD80aW28E7ylYxVMOFZC3VPzrkWUO04mjpm5UjxubxXRTn8z1jIniQ>
    <xmx:zD80afBJHYeMurzNrH6b0O7QeZRjoqMox7aJ-tGtML-bKg2jCXcels40>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 483A1780054; Sat,  6 Dec 2025 09:38:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARL2P0UxYAB3
Date: Sat, 06 Dec 2025 09:37:44 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Haoxiang Li" <lihaoxiang@isrc.iscas.ac.cn>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 bfields@fieldses.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <0ec5a1be-372b-4a0a-9b64-099b1d8bf710@app.fastmail.com>
In-Reply-To: <20251206073842.196835-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20251206073842.196835-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH] nfsd: Drop the client reference in client_states_open()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Dec 6, 2025, at 2:38 AM, Haoxiang Li wrote:
> In error path, call drop_client() to drop the reference
> obtained by get_nfsdfs_clp().
>
> Fixes: a204f25e372d ("nfsd: create get_nfsdfs_clp helper")

An argument could be made that 78599c42ae3c ("nfsd4: add file
to display list of client's opens") is where the reference
counting was first broken. Would you mind if I updated the
Fixes: tag when I apply this?


> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  fs/nfsd/nfs4state.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 8a6960500217..caa0756b6914 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3097,8 +3097,10 @@ static int client_states_open(struct inode 
> *inode, struct file *file)
>  		return -ENXIO;
> 
>  	ret = seq_open(file, &states_seq_ops);
> -	if (ret)
> +	if (ret) {
> +		drop_client(clp);
>  		return ret;
> +	}
>  	s = file->private_data;
>  	s->private = clp;
>  	return 0;
> -- 
> 2.25.1

-- 
Chuck Lever

