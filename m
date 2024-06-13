Return-Path: <linux-nfs+bounces-3792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EBF907D02
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 21:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C876B24AA6
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6D7829C;
	Thu, 13 Jun 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7f8btcR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800076F073
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308598; cv=none; b=B8f6955ms0ZH+YhFSWBH+7pPkfFPyI4+GZMAUCY5ZBJqDRKbhaL1fbSaFdgQpgblM9wlHR/HuuLrERWiovl3RcmJbYEm1/rKf0rfyEOUMZ480iG2YfWE6KZ6nPqT8y3jN6LmwmS3uvRjTodX+fV17nIzJZL37FpMXccZAEJcGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308598; c=relaxed/simple;
	bh=B/XlHtsKE5gb1PzMYcDy7jVGf9qsvNq4MddXmhlItmU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBVyBjqcNCD9PMD3HAP/mSsbBjeAxXkvFRLWOkhZiCXjTeWXZJyW5qTR/FY7pCJkk6E4GVLXzR8fqKh0KKke0R7gUj+3pnCmmvDF8giPqO6R3NoeklOAsMe9ucXayp+tLNNW7RFAdZumQ+4T5k4GaUEQITt0aHklglyD9n7uu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7f8btcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F39C32786;
	Thu, 13 Jun 2024 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718308598;
	bh=B/XlHtsKE5gb1PzMYcDy7jVGf9qsvNq4MddXmhlItmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=H7f8btcRsv88+z0/3eBxc1wR7TrjG2Lb73Sk273hyzmNcJyca74Mb/G1ZrPFM22gB
	 Eoi/7pQ8LqJ6RlEhkborGIUEik2O+dGNvCYhJ4kuhUSxODRS7cXS9+sPLy6B1M37/A
	 UZCdY9Y5tnO6Hpun9ThLg8faad2voCOYF1IVOEtU8cL7LHbUdy/IsE5bnvqXwlKgfO
	 K6VxDJlUuW8B6hT625tqhX7AAtIbb5W9zbTEYMquN2dJSM28mzkSzmNROuZs+k2RyD
	 Wa++rSCa3fkdL6+LoqLPUY56R7aCMxJ8XhZOZVw1MzFuYXrDVNrgdB/oryyW5Si8ax
	 +xC0E6Or36/gw==
Message-ID: <4ccfb492bd6af24f8bdfd085d369c7c94c1865d1.camel@kernel.org>
Subject: Re: [PATCH 2/3] nfs: Properly initialize server->writeback
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, Trond Myklebust
 <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Date: Thu, 13 Jun 2024 15:56:36 -0400
In-Reply-To: <20240613082821.849-2-jack@suse.cz>
References: <20240612153022.25454-1-jack@suse.cz>
	 <20240613082821.849-2-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 10:28 +0200, Jan Kara wrote:
> Atomic types should better be initialized with atomic_long_set()
> instead
> of relying on zeroing done by kzalloc(). Clean this up.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> =C2=A0fs/nfs/client.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index de77848ae654..3b252dceebf5 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -994,6 +994,8 @@ struct nfs_server *nfs_alloc_server(void)
> =C2=A0
> =C2=A0	server->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
> =C2=A0
> +	atomic_long_set(&server->writeback, 0);
> +
> =C2=A0	ida_init(&server->openowner_id);
> =C2=A0	ida_init(&server->lockowner_id);
> =C2=A0	pnfs_init_server(server);

I'm guilty of doing this, well, all over the place. Is there any
plausible scenario where another task could see this value set to non-
zero after kzalloc()? One would hope not...
--
Jeff Layton <jlayton@kernel.org>

