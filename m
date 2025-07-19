Return-Path: <linux-nfs+bounces-13158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35BB0ACAC
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Jul 2025 02:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B153B624B
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Jul 2025 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F6A29;
	Sat, 19 Jul 2025 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU/V5fMb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0436B
	for <linux-nfs@vger.kernel.org>; Sat, 19 Jul 2025 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883373; cv=none; b=dk4V4ksBADAnZ6r8cl3N5n+luTB3T98vtSoU7g1JH6r+1zvXf8vJ0+Lv0eKlorAOyyGWMH51P4XHvzWosbcTNk3ba+HDU3Ig1FMaXuzA/Ff0yJYm7Wtgvv4LFWGzP5MRWOpptoYnAbszdmhA6fOkV3gfpr3GXbrA/azrOE8WuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883373; c=relaxed/simple;
	bh=CHXMuDlkX5rN+2cznildjqNjPxnsg+6VQ6WuigzZA7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZ2IU6446I1LAWS3dxOnjEUbbHdq9PdAt7RvBrDENeTKiPZpZV3LjKKcqd01kmKFoQjyj1ty5Fgbe4VgldLy2OikY7dPXNTa2EUmrCcwgfbqn8n2zGfcuiyZAnUyvcxZBQwpNVldSHYLa/Dyg7elQ2M3X/tp9qSKQ5whNNOjfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU/V5fMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E832CC4CEEB;
	Sat, 19 Jul 2025 00:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752883373;
	bh=CHXMuDlkX5rN+2cznildjqNjPxnsg+6VQ6WuigzZA7o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UU/V5fMb/fM5GwMZZdLNFpU+lhU4DVBRFYbQ7lRWBu+SoJgLUeJQ7oQ1VykS59nr3
	 4Dv5wm0YeeQRr6sV/RUxYDkN3DqPhJuCRR0tc+d7wF8Ceq9ON46+Y48k7L2bC9TC4b
	 srULTAjXl2sW5lL0agiZttIkvxzOorSIhwvIdAkKoLFk3beBvssQpKGcFpaETWfzPA
	 EwkoiOnE1G51JH2uv0avTj9zZdneeH7BbCFy7nTMS6AtYxb2AoxyC1M7uMbKewJa7f
	 Nvr/+emSaSUNc+gc2R6WpzAUnk9xsajL7fYSKjnAHlHXj9t0oLJn3GyTFe1OOCoiKa
	 powVexqFY1p7g==
Message-ID: <7f27118fcc39a84400494549274edb78e455d4c2.camel@kernel.org>
Subject: Re: NFS stuck in nfs_lookup_revalidate
From: Trond Myklebust <trondmy@kernel.org>
To: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hejtm=C3=A1nek?= <xhejtman@ics.muni.cz>, 
 Santosh Pradhan <santosh.pradhan@gmail.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
 "salvet@ics.muni.cz"
	 <salvet@ics.muni.cz>
Date: Fri, 18 Jul 2025 17:02:51 -0700
In-Reply-To: <59D374DB-14C8-42F5-956F-C030AF614C69@ics.muni.cz>
References: <18945D18-3EDB-4771-B019-0335CE671077@ics.muni.cz>
	 <CAOuNp5kzbyVfbdumXJF3bb=RKxdE5P8aKJDeSoLtgEV9=9xU+g@mail.gmail.com>
	 <aECaSYGt59HHgi7M@horn.ics.muni.cz>
	 <59D374DB-14C8-42F5-956F-C030AF614C69@ics.muni.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-18 at 22:19 +0000, Luk=C3=A1=C5=A1 Hejtm=C3=A1nek wrote:
> Hello,
>=20
> > On 4. 6. 2025, at 21:11, Zdenek Salvet <salvet@ics.muni.cz> wrote:
> >=20
> > On Thu, Jun 05, 2025 at 12:00:44AM +0530, Santosh Pradhan wrote:
> > > I am not sure but I vaguely remember that there was some similar
> > > issue and
> > > Neil introduced store_release_wake_up() which puts a full
> > > barrier=C2=A0 smp_mb()
> > > before calling wake_up_var().
> > >=20
> > > index d0e0b435a843..e754e3e478a5 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -1830,6 +1830,7 @@ static void unblock_revalidate(struct
> > > dentry *dentry)
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* store_release ensures wait_va=
r_event() sees the update
> > > */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_store_release(&dentry->d_fsd=
ata, NULL);
> > > + smp_mb();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_var(&dentry->d_fsdata);
> > > }
>=20
> any chance to get this into mainline? It seems that the current git
> master does not inlude smb_mb(); in this code.
>=20
>=20
I'm adding a fix that will go in to the next merge window.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

