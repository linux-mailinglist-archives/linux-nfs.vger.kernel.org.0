Return-Path: <linux-nfs+bounces-16854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CBBC9CBC9
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 20:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22D74E11CB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBF02D3A6D;
	Tue,  2 Dec 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwoK+2F5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88999279792
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702832; cv=none; b=aCukl+N6/FhwCd7gAZbFuiaDZg0bHoAo1JRC6DypyOOrs6O36ztHcT+zozPHA6bvGXT738bsfdFdNkjMU/5VlLdnZhXEpqAWeCjPuyXhXBLkIKp8VH6HG6pkObXdJsdNlj9ixPbPtQoD1PrIMUBoZYP9t4lDqcrFT3ZXRu7DwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702832; c=relaxed/simple;
	bh=bZKamXTcamSlKF+uD3RgYZSbVrKiVz7V6M0387YCUL0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BedVJxXJ0QWsxC1kcWUKVpWmgUoMMm2mY9pD6e8c0IxHkVpizRWJFPX+3FuXI+srPhdx2seBx4tXLR0OofldgHCVzIPaI+Kccw96jvDojZs+Yc/zWICxGqeeP+93b03/n8VLmFZx7xn1hWCIeQq55PXHTJsqKI+XcwFLlWUqb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwoK+2F5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9F0C4CEF1;
	Tue,  2 Dec 2025 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764702832;
	bh=bZKamXTcamSlKF+uD3RgYZSbVrKiVz7V6M0387YCUL0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HwoK+2F5eDD7MRca0ut1+lZimXc0aZ/aMwOlkQBR1TrxzgkOg5reycVyXLdWIOu63
	 AGiFlTpOgOgkVCFIxiU4dVr2N93FBn4g/PP0F7V0HLoDU+O27FQqOtKQjuXDucvg5E
	 NRUOgSaFDoL/eFuRcGJVnji5M1xMFIw3Zrg2RDDmj93v/j4mYf8z35QJTKs5DlxVh+
	 6QiVrBM1S54aTIRZN3PFndidv27CtrVr/k5J0yoEyqNaTJ0xEpdHp2T852Hnj0kihl
	 t+ZgYxrdylref+AXCZeFzBaI8B50ZyE562E6N4fjjZvIuAwwE15cxoEMvv4DWsQVc7
	 NGs4htQ1Ye7dw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 611D9F40075;
	Tue,  2 Dec 2025 14:13:50 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 02 Dec 2025 14:13:50 -0500
X-ME-Sender: <xms:bjovadW3QVe3ZJFekqLmROQal6rJsiBNQr1p6QcT64iq0oC9j1RpWw>
    <xme:bjovaYZ3Dzzxj_qXCXi2t-7j9et7tEpHgOWZ8uDoTiMdk43x8oIUfUmqgjSpB4uFi
    n6jNUwaRryrbG3BMg9gAeWJWW_axLuROePWKyNcSYy0eLN_UEuEGHKz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepgf
    fhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghl
    phgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:bjovaduet54WuDrA9LsTSkbL7d1dOIr_po6aRb646CQy8v21lqArXA>
    <xmx:bjovaXLTencsROUT2YbZu77yE-CSBJFPC9Q2S9BnWTbgGdDsdEF4yw>
    <xmx:bjovae9HEUrhWAnr8Mw0DC-LYrajhlkVJRTjoa1wVRRHhRpMp1S9cw>
    <xmx:bjovaYy6nfQndECR9EWAzZyep7S0B1-SaisMWc5okgi0JHCY1jZSvw>
    <xmx:bjovaT6RrLGkrdhIHirZ97WRooMyCQ7jqYF9J9HbZ5i-LY4urjhFGNb2>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1CEF5780054; Tue,  2 Dec 2025 14:13:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APbz5urs-Z33
Date: Tue, 02 Dec 2025 14:13:27 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <7f5cd14c-69eb-4254-b4fc-eaf6bf1dc6ce@app.fastmail.com>
In-Reply-To: <8e540b096159a512815fa760a9900ca43b798dfd.camel@kernel.org>
References: <20251201220955.1949-1-cel@kernel.org>
 <928e6aa79ece95012ce26d1341c930c3ffe4f7ae.camel@kernel.org>
 <7c1f87c6-9eb1-4efd-832f-0bd0ec2aff0a@kernel.org>
 <8e540b096159a512815fa760a9900ca43b798dfd.camel@kernel.org>
Subject: Re: [PATCH v1] nfsd: fix nfsd_file reference leak in
 nfsd4_add_rdaccess_to_wrdeleg()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Dec 2, 2025, at 9:53 AM, Jeff Layton wrote:
> On Tue, 2025-12-02 at 08:34 -0500, Chuck Lever wrote:
>> On 12/2/25 7:08 AM, Jeff Layton wrote:
>> > On Mon, 2025-12-01 at 17:09 -0500, Chuck Lever wrote:
>> > > From: Chuck Lever <chuck.lever@oracle.com>
>> > >=20
>> > > nfsd4_add_rdaccess_to_wrdeleg() unconditionally overwrites
>> > > fp->fi_fds[O_RDONLY] with a newly acquired nfsd_file. However, if
>> > > the file already has a READ open from a previous OPEN operation,
>> > > this overwrites the existing pointer without releasing its refere=
nce,
>> > > orphaning the previous reference.
>> > >=20
>> > > Additionally, the function originally stored the same nfsd_file
>> > > pointer in both fp->fi_fds[O_RDONLY] and fp->fi_rdeleg_file with
>> > > only a single reference. When put_deleg_file() runs, it clears
>> > > fi_rdeleg_file and calls nfs4_file_put_access() to release the fi=
le.
>> > >=20
>> > > However, nfs4_file_put_access() only releases fi_fds[O_RDONLY] wh=
en
>> > > the fi_access[O_RDONLY] counter drops to zero. If another READ op=
en
>> > > exists on the file, the counter remains elevated and the nfsd_file
>> > > reference from the delegation is never released. This potentially
>> > > causes open conflicts on that file.
>> > >=20
>> > > But, on server shutdown, these leaks cause __nfsd_file_cache_purg=
e()
>> > > to encounter files with an elevated reference count that cannot be
>> > > cleaned up, ultimately triggering a BUG() in kmem_cache_destroy()
>> > > because there are still nfsd_file objects allocated in that cache.
>> > >=20
>> > > Fixes: e7a8ebc305f2 ("NFSD: Offer write deleg for OPEN4_SHARE_ACC=
ESS_WRITE")
>> > > X-Cc: stable@vger.kernel.org
>> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> > > ---
>> > >  fs/nfsd/nfs4state.c | 14 ++++++++++----
>> > >  1 file changed, 10 insertions(+), 4 deletions(-)
>> > >=20
>> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> > > index 35004568d43e..11877b96dc4c 100644
>> > > --- a/fs/nfsd/nfs4state.c
>> > > +++ b/fs/nfsd/nfs4state.c
>> > > @@ -1218,8 +1218,10 @@ static void put_deleg_file(struct nfs4_fil=
e *fp)
>> > > =20
>> > >  	if (nf)
>> > >  		nfsd_file_put(nf);
>> > > -	if (rnf)
>> > > +	if (rnf) {
>> > > +		nfsd_file_put(rnf);
>> > >  		nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
>> > > +	}
>> > >  }
>> > > =20
>> > >  static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegati=
on *dp, struct file *f)
>> > > @@ -6231,10 +6233,14 @@ nfsd4_add_rdaccess_to_wrdeleg(struct svc_=
rqst *rqstp, struct nfsd4_open *open,
>> > >  		fp =3D stp->st_stid.sc_file;
>> > >  		spin_lock(&fp->fi_lock);
>> > >  		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>> > > -		fp =3D stp->st_stid.sc_file;
>> >=20
>> > Weird. Just noticed the double assignment here.
>> >=20
>> > > -		fp->fi_fds[O_RDONLY] =3D nf;
>> > > -		fp->fi_rdeleg_file =3D nf;
>> > > +		if (!fp->fi_fds[O_RDONLY]) {
>> > > +			fp->fi_fds[O_RDONLY] =3D nf;
>> > > +			nf =3D NULL;
>> > > +		}
>> > > +		fp->fi_rdeleg_file =3D nfsd_file_get(fp->fi_fds[O_RDONLY]);
>> > >  		spin_unlock(&fp->fi_lock);
>> > > +		if (nf)
>> > > +			nfsd_file_put(nf);
>> > >  	}
>> > >  	return true;
>> > >  }
>> >=20
>> > I do so wish this refcounting were easier to get right, but I don't
>> > have any great ideas around it yet.
>> >=20
>> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> Thanks for the R-b. Chris's review-prompts do generic navigation of
>> reference counting, so we have a little more of a back-stop now. I ran
>> the review-prompts against e7a8ebc305f2 on a lark, and they indeed fo=
und
>> this problem.
>>=20
>
> Now that I look again, I'm wondering -- is this problem possible?

It is. The server does crash during shutdown as described above,
and this patch makes the crashes stop.


> nfsd4_add_rdaccess_to_wrdeleg() is called after we have set a write
> lease on the file. There should be no other open files=C2=A0at that po=
int,
> so fi_fds[O_RDONLY] must be NULL already.
>
> Instead of or in addition to doing this, maybe we should be doing a
> WARN_ON_ONCE() if fp->fi_fds[O_RDONLY] is non-NULL here?

A WARN_ON(1) will help me nail down exactly what part of xfstests is
triggering the problem. Stay tuned.


--=20
Chuck Lever

