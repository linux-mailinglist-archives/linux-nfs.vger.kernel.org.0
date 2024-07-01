Return-Path: <linux-nfs+bounces-4487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C059791DDC2
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4054E1F20EF0
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C47212CDB0;
	Mon,  1 Jul 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1Nr1Qj/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F0376E7
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833010; cv=none; b=FsQfbgQTOOdxvGq/7ZiwjaXSdV5mWxZgxdi/9oA8OUTTn6TsKTbjg+iM6HSZf6yZYQmlucEMIdRW48qUDeRn6GGS8iIWQlXecIIHNBu8TnXFa3RObUJAmB+eVlUQOpUSVH3DFTANAem0YAarCHQqOMsS+WSXuHli0xsdwWKtDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833010; c=relaxed/simple;
	bh=+pw3lnEp2PXbZ7WDAbf63j03uNDTyh8bzmY6k4ZUul0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aX4SGmn+opsZKlIZk1xumGPnbrgnR5eGnMerOCxeANUtTskwkKXw7mdOP/66kLqeqb7li3oIfMeqcZulTA9OmJ7jAzWkwCe695yAAzSZ6fQuTh6R7VaPcGuDzXaqe+pdkwFX+mpJwPV4MEoNxg0RLbXy4aCwDH/O/OT4iGGDpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1Nr1Qj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3024CC116B1;
	Mon,  1 Jul 2024 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719833009;
	bh=+pw3lnEp2PXbZ7WDAbf63j03uNDTyh8bzmY6k4ZUul0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=F1Nr1Qj/3aWcf7gNRaxDMixCVudQRi+SinCIYVpjkgiQzxE/riI470uc2gxJwrTJP
	 zWk3xoc/etTZNBE8sFYouUR1or/zplKb8eSBQf/72Xltj6KOEnmOxvKk38HWSPnYPO
	 ciahEFgjxf9KAOHm0XJWfn6BqxCUVFVbJt/3a3BTkxL78+KL9DYWcMCJoRT/f7C6pF
	 5c7QJD5/q2FAdcPfjwrxmgmtSr3CERAZkcQ2Y262Lj1Z3+1fFUzXn9hWRGV/PAAcFK
	 /2fBXxZivryvCdtkZ7+vhV5swES5/EBfZ0DVsAN927jkpCgGV+xhUDoIfK9GjX6KN2
	 gVIQTznBc7nZA==
Message-ID: <b5ef328e9b1343f417219de872a2a1b96c16da98.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nfs: Properly initialize server->writeback
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, Sagi
	Grimberg <sagi@grimberg.me>
Date: Mon, 01 Jul 2024 07:23:27 -0400
In-Reply-To: <20240701105056.25535-2-jack@suse.cz>
References: <20240617073525.10666-1-jack@suse.cz>
	 <20240701105056.25535-2-jack@suse.cz>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 12:50 +0200, Jan Kara wrote:
> Atomic types should better be initialized with atomic_long_set()
> instead
> of relying on zeroing done by kzalloc(). Clean this up.
>=20
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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

It seems a little pointless, but ok.

Acked-by: Jeff Layton <jlayton@kernel.org>

