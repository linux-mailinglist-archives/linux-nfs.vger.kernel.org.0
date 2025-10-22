Return-Path: <linux-nfs+bounces-15489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D2BBF9D3C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 05:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C4634E241D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 03:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23441233707;
	Wed, 22 Oct 2025 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOegmj1p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48E1EE7B7;
	Wed, 22 Oct 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103597; cv=none; b=SDkzfQYklgED1gkBVf2BTC8mA5dtntIjzwF1s1bDTQyuxUsygMBtzsgOOw4mBg0Tk5uLbYCErcTtrY0yPCaKQw/r0fJg6fqNhqqgd7YOES80wzxoiYCYG3GaatHH96Uq5J0YV2QU5+DjijneI9JsuYVPwRX1L9uW3rvjJ1lCh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103597; c=relaxed/simple;
	bh=/0iv0GDFs+V64hC6yaXQOsAqiE9nT71Fxv6fIP9P6Wk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEf9nm+0QxEUQqr84AHvK8A61OiBLnW/vstx9ce/kQWPDauMi6sTR1s2gMY8Qz4LosVEz4bbA5txp3jntvjT/haMjkliE++Djlpk3HA8+ipF+fPr5HJRNDxKE++BP12fBi3TLBfJEpB9/9PnoSxQ8RzlBsMR0bMTBWhSIKpMfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOegmj1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C037C4CEE7;
	Wed, 22 Oct 2025 03:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761103596;
	bh=/0iv0GDFs+V64hC6yaXQOsAqiE9nT71Fxv6fIP9P6Wk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AOegmj1p3fsnm9PLZ28nADjwnaPx9Aq+fzFF87DrNT9dwHd1z5Ax84hNGOoltnwOP
	 NMoiNTB63nYF/i/T0i3ewkIJrB7aqJ5cSHa9X6kganR5foZzOyufHE9S7E7mP7KXS5
	 eUuFHC5p+Yv1LU7fWrgGorZZeuW1mIOBIHrum8BKemNdtSHgIro1AjWXS9zSbbE9ga
	 n4N0TcS+BeyAfKen50oLuPk1iRH8F6BKBVWAmRPPb0vQ15PXEdK4BuIri1VfNIK6KP
	 QunZtDKmL6XJ10SpETnH4MRZLU/4EH0whxDnzNISThu8/FlmGZnLHjzuviM+6PQnSH
	 xzT5mPoiTCYqQ==
Message-ID: <d2877eb6c54ec197e5102aa78dffd2a6a0f3d1cc.camel@kernel.org>
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
From: Trond Myklebust <trondmy@kernel.org>
To: liubaolin <liubaolin12138@163.com>, anna@kernel.org, Dan Carpenter
	 <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Baolin Liu
	 <liubaolin@kylinos.cn>
Date: Tue, 21 Oct 2025 23:26:33 -0400
In-Reply-To: <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>
References: <20251012083957.532330-1-liubaolin12138@163.com>
		 <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
		 <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
		 <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
		 <b928fe1b-77ba-4189-8f75-56106e9fac19@163.com>
	 <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 23:15 -0400, Trond Myklebust wrote:
> On Wed, 2025-10-22 at 10:44 +0800, liubaolin wrote:
> > > Sorry, I didn=E2=80=99t actually see any case where req->wb_head =3D=
=3D NULL.
> > > I found this through a smatch warning that pointed out a
> > > potential
> > > null pointer dereference.=20
> > > Instead of removing the NULL folio check, I prefer to keep it to
> > > prevent this potential issue. Checking pointer validity before
> > > use
> > > is a good practice.=20
> > > From a maintenance perspective, we can=E2=80=99t rule out the possibi=
lity
> > > that future changes might introduce a req->wb_head =3D=3D NULL case,
> > > so
> > > I suggest keeping the NULL folio check.
> >=20
>=20
> I think you need to look at how smatch works in these situations. It
> is
> not looking at the call chain, but is rather looking at how the
> function is structured.
> Specifically, as I understand it, smatch looks at whether a test for
> a
> NULL pointer exists, and whether it is placed before or after the
> pointer is dereferenced. So it has nothing to say about whether the
> check is needed; all it says is that *if* the check is needed, then
> it
> should be placed differently.
> Dan Carpenter, please correct me if my information above is
> outdated...
>=20
> So in this case, since we've never seen a case where the NULL check
> is
> violated, and an analysis of the call chain doesn't show up any
> (remaining) cases where that NULL pointer test is needed, my
> recommendation is that we just remove the test going forward.
>=20
> We should not need to add a "Tested" or "stable" tag, since this test
> is harmless, and so the change is just an optimisation.

Sorry. I meant to say there is no need to add a "Fixes" or a "Cc:
stable" tag...

>=20
> >=20
> > =E5=9C=A8 2025/10/17 23:02, Trond Myklebust =E5=86=99=E9=81=93:
> > > On Fri, 2025-10-17 at 14:57 +0800, liubaolin wrote:
> > > > [You don't often get email from liubaolin12138@163.com. Learn
> > > > why
> > > > this is important at
> > > > https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> > > >=20
> > > > > This modification addresses a potential issue detected by
> > > > > Smatch
> > > > > during a scan of the NFS code. After reviewing the relevant
> > > > > code, I
> > > > > confirmed that the change is required to remove the potential
> > > > > risk.
> > > >=20
> > > >=20
> > >=20
> > > I'm sorry, but I'm still not seeing why we can't just remove the
> > > check
> > > for a NULL folio.
> > >=20
> > > Under what circumstances do you see us calling
> > > nfs_inode_remove_request() with a request that has req->wb_head
> > > =3D=3D
> > > NULL? I'm asking for a concrete example.
> > >=20
> > > >=20
> > > > =E5=9C=A8 2025/10/13 12:47, Trond Myklebust =E5=86=99=E9=81=93:
> > > > > On Sun, 2025-10-12 at 16:39 +0800, Baolin Liu wrote:
> > > > > > [You don't often get email from liubaolin12138@163.com.
> > > > > > Learn
> > > > > > why
> > > > > > this is important at
> > > > > > https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> > > > > >=20
> > > > > > From: Baolin Liu <liubaolin@kylinos.cn>
> > > > > >=20
> > > > > > nfs_page_to_folio(req->wb_head) may return NULL in certain
> > > > > > conditions,
> > > > > > but the function dereferences folio->mapping and calls
> > > > > > folio_end_dropbehind(folio) unconditionally. This may cause
> > > > > > a
> > > > > > NULL
> > > > > > pointer dereference crash.
> > > > > >=20
> > > > > > Fix this by checking folio before using it or calling
> > > > > > folio_end_dropbehind().
> > > > > >=20
> > > > > > Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> > > > > > ---
> > > > > > =C2=A0=C2=A0 fs/nfs/write.c | 11 ++++++-----
> > > > > > =C2=A0=C2=A0 1 file changed, 6 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > > > > > index 0fb6905736d5..e148308c1923 100644
> > > > > > --- a/fs/nfs/write.c
> > > > > > +++ b/fs/nfs/write.c
> > > > > > @@ -739,17 +739,18 @@ static void
> > > > > > nfs_inode_remove_request(struct
> > > > > > nfs_page *req)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_page=
_group_lock(req);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nfs_=
page_group_sync_on_bit_locked(req,
> > > > > > PG_REMOVE)) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct folio *folio =3D
> > > > > > nfs_page_to_folio(req-
> > > > > > > wb_head);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D folio-
> > > > > > > mapping;
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&mapping->i_private_lock);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(folio)) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct address_space *mapping =3D
> > > > > > folio-
> > > > > > > mapping;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=
in_lock(&mapping-
> > > > > > >i_private_lock);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 folio->private =3D NULL;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 folio_clear_private(folio);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 clear_bit(PG_MAPPED, &req-
> > > > > > >wb_head-
> > > > > > > wb_flags);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&mapping->i_private_lock);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=
in_unlock(&mapping-
> > > > > > > i_private_lock);
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 folio_end_dropbehind(folio);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
lio_end_dropbehind(folio);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_page=
_group_unlock(req);
> > > > > >=20
> > > > > > --
> > > > > > 2.39.2
> > > > > >=20
> > > > >=20
> > > > > What reason is there to believe that we can ever call
> > > > > nfs_inode_remove_request() with a NULL value for req-
> > > > > >wb_head-
> > > > > > wb_folio, or even with a NULL value for req->wb_head-
> > > > > > > wb_folio-
> > > > > > mapping?
> > > > >=20
> > > > >=20
> > > >=20
> > >=20

