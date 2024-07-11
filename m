Return-Path: <linux-nfs+bounces-4792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357C92E2EC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053F31C2387B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07A14AD3A;
	Thu, 11 Jul 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=truschnigg.info header.i=@truschnigg.info header.b="W4H1pjbM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from truschnigg.info (truschnigg.info [89.163.150.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793984D12;
	Thu, 11 Jul 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.163.150.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688448; cv=none; b=nPz7affMS8XkmqymjcO1T1tl5ZZdmqXc2XiLYsnoxhqcvmqzcU5t5RN0z22rLJf/dQlCtn1jIxlOGbibY8KfQ6RTpI627RO2r9DsDp22xRq+1C+EtUht1GHCrwbycVKHroSnBdWaX76CHd1i9bwmS+HpLb0blEkYvlH9eZzNqTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688448; c=relaxed/simple;
	bh=mRczEEAH6XeYv8BF6ySO7OwPG/kDJ2JRgS0b/aWEgsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgL77lYuaUgfaoSxe1jBVJeDHvBFIjqGqYmvZupckMuCqPYmXWDTwl44h9ZXB+Dqmu8bDkZt6S1z5TVQDrcoW9FRl4KyAhGTCfIcXOoi8doCfSv0NHg5F6NXEzkOgxD6no3McCQ/YUq+U+ofagd3Apa1129BSlJUKcmEo9/uFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=truschnigg.info; spf=pass smtp.mailfrom=truschnigg.info; dkim=pass (2048-bit key) header.d=truschnigg.info header.i=@truschnigg.info header.b=W4H1pjbM; arc=none smtp.client-ip=89.163.150.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=truschnigg.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truschnigg.info
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=truschnigg.info;
	s=m22; t=1720687902;
	bh=mRczEEAH6XeYv8BF6ySO7OwPG/kDJ2JRgS0b/aWEgsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4H1pjbM55ZHcp7dfatkvrIiONYtu4iTWt+hhFUooUlgmfVGxQ5J0TB01mBE88cLs
	 OmbObZ0nprP25rbJQXW1BcbkLS5S8ZDdY7gyZnZWFfx7fgdg/fFW8a0/V0prS7jITE
	 ECHPa5PfNrPqboIlb20vK6is0r4lsnpkBtiOZGQTerGpN6JjRhyyh+3wCyWjNsRHs6
	 hUAp+khV+YpUU0Ii5VNgPC082HSdmkF1ips1MT1l24RP68bMdKl3uGykLf8XPz2cfO
	 7JQQseNiU5go2amrWY54KXzXxeoTIKs0oiWxsI30WOoRavlc+kK+rb9iVqP7wx+vb9
	 BTRkcGVBo3Few==
Received: from vault.lan (unknown [IPv6:2a02:1748:fafe:cf3f:1eb7:2cff:fe02:8261])
	by truschnigg.info (Postfix) with ESMTPSA id 3D6D820435;
	Thu, 11 Jul 2024 08:51:42 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:51:39 +0200
From: Johannes Truschnigg <johannes@truschnigg.info>
To: Dave Chinner <david@fromorbit.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-raid@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
Message-ID: <Zo-dG8EGbfp_ghOB@vault.lan>
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
 <Zo8VXAy5jTavSIO8@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CA/8qHnSry4tIedh"
Content-Disposition: inline
In-Reply-To: <Zo8VXAy5jTavSIO8@dread.disaster.area>


--CA/8qHnSry4tIedh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just wanted to chime in to express a sincere "thank you!" to all of you
involved in this thread, for providing such a terrific example of how to
clearly and exhaustively present a systems problem, and then also how to
methodically determine its root cause.

If there were a textbook on this subject in the IT/CompSci context (if there
is, please let me know!), *this* exchange should make it into the next edit=
ion
on how to get problems analyzed and resolved.

I will keep it in my personal bookmarks right next to [0], which is a short
but great essay about how what you just put into practice is possible in
theory, and which I've used whenever needed to inspire hope in others (and,
truth be told, also in myself :)) in the face of the daunting complexity of
modern computer systems.

[0]: https://blog.nelhage.com/post/computers-can-be-understood/

--=20
with best regards:
- Johannes Truschnigg ( johannes@truschnigg.info )

www:   https://johannes.truschnigg.info/

--CA/8qHnSry4tIedh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEGu9IhkI+7/aKLUWF95W3jMsYfLUFAmaPnRgACgkQ95W3jMsY
fLVRfg//UdNTCBR+P2/nOsG3Si2N6n/AOMKgTJKZBlcUas0eKuuqKvjHTVk6Z5nM
WZgyBY3dUW/vDn6ZhpEZg2NA+uHSEWd3HbSpXEgrJ/JZJN2t3vciwSEzdIoA6qy/
0QCSbdR8PwxpPSWemkfGeQXblT3ZcgrjGaLyEjPkKF3GxOKGsW81F5YIdQyJkrLQ
lGgj/luNdacT7qTbII169+VlBe4QQsRm71mG2oGgnjgl2/rVLLmqmBpGYYrkLJH8
dCZ6jmRQryWsphKWKisWOQD7Je34tRNkAZO36Upb6oRNf5XgsdtPummYZNpxoCJm
ft69lsgeGaYnN5mKjUbA+KMj9UiSqPygEeQXNVlQWGuKVjN8PBKG4GFvkV8p41T9
XvZuAorpiAnEiVr971pmm0q5NoOVBXLM/h5r+5Q6CFTYGGYeX5iVUxUkWtwG8eAV
0xVJ15JSnLQeGHynQs8jgKN49iwmqbJq4l4bs+paLH4hzpx3tCvzl1nH23pYQXof
g9igwMErSWWBNkJPXcomiaFL7tMFT/ensfkRxvSObDIuNZ4zaF/DuyPQZJygyOYi
XoJQqM5umzY7KGTT7kbGNr1mUJiVLunfBiBwuzYX2wW30hKlubnm4m/HOl2HTJGT
EGhRxv8gkYeS/TNBMtqCKNLh93Uz1yIaNm8MTgloCnV7DXrhNYc=
=HCJz
-----END PGP SIGNATURE-----

--CA/8qHnSry4tIedh--

