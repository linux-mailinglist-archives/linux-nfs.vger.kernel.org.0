Return-Path: <linux-nfs+bounces-14130-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA65B49868
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 20:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB51217AAAF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95110315793;
	Mon,  8 Sep 2025 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQTYCF8c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7B314B75
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356616; cv=none; b=Dxu5VbmHs0kvqNoI+J40DWU3mvrsIOXm75WStmmxe6GtRAFtH6oTjAilXCMrPvGXFOqbkgtgp1vQpGb39aU2WubhGpSpUTgC29dbJowdOGqvOqbSbBNa2IXbP+fCH2whYR8gfbky7ci8fLtEJIe2drs4PK3rpKeEt5E/7yFMNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356616; c=relaxed/simple;
	bh=CCCNPFmUlCpoSJCkut0CSBxC70qmpo6aKYKju1PhwXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzE2hEHTsGKXoW668xqbG0EdybDB1d5azqHS4enS/NToQLgcoGt3lOcV4v2yxjNIg5vqzvQo7SFo0dZzFkmI8olbHoH7sH0XFnPFF3Ulz0c2qjRahTCul82yy+L+ehjj1JmiEPal4hekm6qP9VCRx8pkfyFKWjbP8kitGM49GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQTYCF8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FDC4CEF1;
	Mon,  8 Sep 2025 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757356615;
	bh=CCCNPFmUlCpoSJCkut0CSBxC70qmpo6aKYKju1PhwXs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HQTYCF8crZlGrxmBegQcXDWCMaEkBs5GdKpcJvFPn7sdhPJoWyMzMlJm5QiyOOqya
	 9KXqvOUKFb4hdGxRj8iabixx/NL7HgOfCe9ZvFf0yBzbywfP93QmorixmqLC7CdIjc
	 QwhgP/7OW1Ilb6Ga3113IA+XmmaMooG5jHnSzpKZUwh+KZmxsZtu09XsOu2CShbdA9
	 1N2uaaIO7ivSEKmtjCyx5h294nhFwskw1ymZ7EgqHOqF7qL246ugjpCjg9FMDPZ3ZV
	 dUSUdI1snfwqe+dQdtjRbHcsEFPVUAuLkMSURtZtvXOUvNF4bnG0I3rl+MNTB6ESz4
	 U5gYRE0HPVivA==
Message-ID: <7f02383974ed3342c7a7df34b3044820145ff679.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSv4/flexfiles: Fix layout merge mirror check.
From: Trond Myklebust <trondmy@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>, Anna Schumaker
 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 08 Sep 2025 14:36:54 -0400
In-Reply-To: <20250908173516.1178411-2-jcurley@purestorage.com>
References: <20250908173516.1178411-1-jcurley@purestorage.com>
	 <20250908173516.1178411-2-jcurley@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-08 at 17:35 +0000, Jonathan Curley wrote:
> Typo in ff_lseg_match_mirrors makes the diff ineffective. This
> results
> in merge happening all the time. Merge happening all the time is
> problematic because it marks lsegs invalid. Marking lsegs invalid
> causes all outstanding IO to get restarted with EAGAIN and
> connections
> to get closed.
>=20
> Closing connections constantly triggers race conditions in the RDMA
> implementation...
>=20
> Fixes: 660d1eb22301c ("pNFS/flexfile: Don't merge layout segments if
> the mirrors don't match")
> Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
> ---
> =C2=A0fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index 6d9aea16ef44..addf4357610e 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -334,7 +334,7 @@ ff_lseg_match_mirrors(struct pnfs_layout_segment
> *l1,
> =C2=A0		struct pnfs_layout_segment *l2)
> =C2=A0{
> =C2=A0	const struct nfs4_ff_layout_segment *fl1 =3D
> FF_LAYOUT_LSEG(l1);
> -	const struct nfs4_ff_layout_segment *fl2 =3D
> FF_LAYOUT_LSEG(l1);
> +	const struct nfs4_ff_layout_segment *fl2 =3D
> FF_LAYOUT_LSEG(l2);
> =C2=A0	u32 i;
> =C2=A0
> =C2=A0	if (fl1->mirror_array_cnt !=3D fl2->mirror_array_cnt)

D'oh! Well spotted... That definitely deserves a fixes tag.

Thanks!
  Trond

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

