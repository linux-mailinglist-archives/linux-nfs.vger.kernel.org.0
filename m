Return-Path: <linux-nfs+bounces-14624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF2B96034
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991C97A1BDA
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56027326D5F;
	Tue, 23 Sep 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR9UWQ4U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805E318141;
	Tue, 23 Sep 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634167; cv=none; b=iSdMERrCo2T3jw86CbmSEkveV5LtLj4pd9uk6fFGINcHjfbVwsDA2mW3FbSCr6lbKr4JyLuefCCdfRiaMcIy8t3CU8BhZ4Hc0WeAtekIPoagbhHnytRZ6W6jVkbfib4HaSgp4bN1nOVZORZcoca19MMWpSa9+tOsCLosh9lf4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634167; c=relaxed/simple;
	bh=0j/hJUP2UZCn/9qriWV/I8bCZAUO3NzJO4KmyJ2cycU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1AA4SiRaSlkQTAIn3H6QDct1MG8fdKu0BQW6xvZUKjB+cTIkcde5HPeNuPCIX5jyfnLqrqrROGV6cSWKUSy+Y4P+ErSupRXLE7FdN7uI+dD+4muK0jXRr3ezeURDl3637Z97LpjpqnOXlK9ce77bn/QjxTaUl+rmPGbMwBlsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR9UWQ4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C04C113D0;
	Tue, 23 Sep 2025 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758634166;
	bh=0j/hJUP2UZCn/9qriWV/I8bCZAUO3NzJO4KmyJ2cycU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UR9UWQ4Uu0hZTGoPMYiWBRULW5KLRbWyCXO2+ZEqWfg7nzxjWGrAnX+wNNZSdydBP
	 ROHZY74OCVbq7tTexj6HOKA623mro3roHCu8/ppeSidXvoITpr8xUrJcyM++EO2udv
	 pxXXHBA7DgmBhw6WHRukqpGxGaTbrks34aOWY7X0FVP8OVYmivAOAY85KX696A9/j+
	 lmUMXSQPqYInUWJqGLh9crdjSYJTTbzkcyRWlkSNuY2u9Wm+eWrpM99goU9P+Laoey
	 N6RQswH+EuxGhzBm2NC9KiyF8nIu+53vcFg7KIeKmn657e+BLcQq9/IDIc5kzoxGKy
	 Z76pKcj4fU7aA==
Date: Tue, 23 Sep 2025 15:29:23 +0200
From: Mark Brown <broonie@kernel.org>
To: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>,
	NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jonathan Curley <jcurley@purestorage.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the nfs-anna tree
Message-ID: <aNKgs3ey1kXfkdga@finisterre.sirena.org.uk>
References: <aMv8ncNIMJw58v4O@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VEua1RyIK79I+Hyl"
Content-Disposition: inline
In-Reply-To: <aMv8ncNIMJw58v4O@sirena.org.uk>
X-Cookie: Filmed before a live audience.


--VEua1RyIK79I+Hyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 01:35:41PM +0100, Mark Brown wrote:

> After merging the nfs-anna tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:

This issue is still present today.

--VEua1RyIK79I+Hyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjSoLIACgkQJNaLcl1U
h9B/2Af8DslILZEWD7M5LpMlvqaz/ftLHGEanVFdwhYM2+VsLeKPvnkI6CZy3T7V
0sPSJtPF+PvTlRhxMXtVyjCS7RQSe61Y6RIoOWEurT46DniRnzCmw5pk+JNNU8Js
52GHe6lOyGPxpNX6BBIym3UcE6XvQQpNBbqDe+3GkWS0OkDTuu8xQMeXyoMVCYIG
8LZkYJp/qgNWdWjXWGxTAtI2LWiedtjSLtC1wRzhAUfwIdO0s6ormBQmYBN1rKwF
ddAzuqdzBesyOk2L4kODG2gusuzfQ9WqSVXLEMV05+3YfhCvh3cDtpdmI49KDFEe
UZ5hkxh0IrjzdtrG7DPRCuYn2fRKdQ==
=avZE
-----END PGP SIGNATURE-----

--VEua1RyIK79I+Hyl--

