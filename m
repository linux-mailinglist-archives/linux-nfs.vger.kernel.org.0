Return-Path: <linux-nfs+bounces-10435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB2CA4CB67
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443B41719D6
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC8231C9F;
	Mon,  3 Mar 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgF9rX2p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2E1DE2BF;
	Mon,  3 Mar 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027994; cv=none; b=N85UgJuFdaiP+wbpdz1e8zbnA7Ln6tSSegrfYo5LYgskFuTmWDCO+7n9iTBgGM94mrsNl0NV+3btbERH+KzFZ0hgdXd2Q0CDHKvTixVYV3ecSv1JiXy9kBGR/lA8du9M2zbrztG1NKrcwqZUFbS9pYYwyrzQN6VD7GVGJ4Buhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027994; c=relaxed/simple;
	bh=DxxPgbBerz8iXzf1BZ+vaejS0h/i6g9RPijhV7bWKNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn1F1WADieflojlq6QV51aaADf8C6b95h48AOGdAbYITrTnQXa06tjjImrSQnjiog5rl+cdvwhF06xoqVF3mkU4FWfT31bGOlKQUlAaTNVV8dsHrGO548f9Iqm5c+uZMmGUlueypiXwmwvh7xAF3/V9EN7ScsXYc/0LMGifeNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgF9rX2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DBAC4CEE6;
	Mon,  3 Mar 2025 18:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027993;
	bh=DxxPgbBerz8iXzf1BZ+vaejS0h/i6g9RPijhV7bWKNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgF9rX2pC04P+pMY9TCn3Opbz5AvGAUnFeSTdoiGOI9ZQyfhS4H17yAwXqTfZMy/6
	 VK9UKU0r+1Xly4MRWPFLechDiGyqsw+W1l4RoQKbIekeVz8/laUOBRoSzuLMKuiXFl
	 w/9tszW+KEiHFwNQXGZPwXkbI3pgogeL+QYYKE/3d83IYwiOkOWTeebH4o/12O5bCc
	 FG4aAuT3C+lw06ZgSRNFwk0YsluNbXXDUG6lQchGURwqXfTIo03wEQP+8MmV19qqmO
	 39eGr8BqIPRR+dTM6qsygbu9eS6KtXnH6cYuJAnduvMIQyrrz6Eg/fVa4GlMUoxvOP
	 GECSqJTWSfFdQ==
Date: Mon, 3 Mar 2025 20:53:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
	codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 5/6] sysctl/infiniband: Fixes infiniband sysctl bounds
Message-ID: <20250303185309.GA1955273@unreal>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>
 <20250224134105.GC53094@unreal>
 <6obp2rythrcvlknqsczvxmhenhvxsosobc4cwx36iinyjjj5mr@b227ysqvp5vh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6obp2rythrcvlknqsczvxmhenhvxsosobc4cwx36iinyjjj5mr@b227ysqvp5vh>

On Mon, Mar 03, 2025 at 02:57:29PM +0100, Joel Granados wrote:
> On Mon, Feb 24, 2025 at 03:41:05PM +0200, Leon Romanovsky wrote:
> > On Mon, Feb 24, 2025 at 10:58:20AM +0100, nicolas.bouchinet@clip-os.org=
 wrote:
> > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > >=20
> > > Bound infiniband iwcm and ucma sysctl writings between SYSCTL_ZERO
> > > and SYSCTL_INT_MAX.
> > >=20
> > > The proc_handler has thus been updated to proc_dointvec_minmax.
> > >=20
> > > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > ---
> > >  drivers/infiniband/core/iwcm.c | 4 +++-
> > >  drivers/infiniband/core/ucma.c | 4 +++-
> > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > >=20
> >=20
> > Acked-by: Leon Romanovsky <leon@kernel.org>
> >=20
> > How do you want to proceed from here? Should I take to RDMA repository?
> >=20
> > Thanks
> It would be great if we push this through RDMA. Here are a few comments:
> 1. Having the upper bound be SYSCTL_INT_MAX is not necessary (as it is
>    silently capped by proc_dointvec_minmax, but it is good to have as it
>    gives understanding on what the spread of the values are.
>=20
> 2. Having the lower bound capped by SYSCTL_ZERO is needed as it will
>    prevent ppl trying to assing negative values to the unsigned integers
>=20
> Please let me know if you will push this through RDMA, so I know to
> remove it from sysctl.

Applied to RDMA tree.
https://web.git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=
=3Dwip/leon-for-next&id=3Df33cd9b3fd03a791296ab37550ffd26213a90c4e

>=20
> Best
>=20
> Reviewed-by: Joel Granados <joel.granados@kernel.org>

Thanks

>=20
> --=20
>=20
> Joel Granados

