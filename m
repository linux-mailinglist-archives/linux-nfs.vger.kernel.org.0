Return-Path: <linux-nfs+bounces-4817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19CC92EB2B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC98B21FAB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72716A95C;
	Thu, 11 Jul 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5O2h7lm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B711684A8
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709950; cv=none; b=PUzIA72BgkdkQwinYWr9avgGlUJshNkhIwHbhM/UeEJATWdoxUw2RpEcyrHRx2wcSWfi4OpS8zdETJQrd3xRjAWOsXsGTGilwZrbPaq48S52QU4PbL7ky63hKi5/EQ0g56juxvRkxBepaNxiNTAmq+DjZ8FEx0xEnEntHmJZ/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709950; c=relaxed/simple;
	bh=AtOY00bNio+UnfJZO8rqOIIzJcRRTLLH+MfQaJjiHLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRwXlkqTTxkwugdoNkE+2yEC4WlutgyXD3J5+BIF9Fn3W/k4AQc3C1NUjVIIZXgYROMAvhH7AlK7aF8X3aZf82VHz4mWyDldjx8vdt6C6woMfnQsBfxS29VH5bC7wO8+ZNSjy2CQd/GweWRsIXOCaReQ7y2kfkFmm6adDKP8BNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5O2h7lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134B9C116B1;
	Thu, 11 Jul 2024 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720709949;
	bh=AtOY00bNio+UnfJZO8rqOIIzJcRRTLLH+MfQaJjiHLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=l5O2h7lmd3FuQNgt6XAzEYlV+DkZ9cojqJieFtLViJJHH8C8AJy/L6agkObOBfu7T
	 S2q9m8a+ogFJEnG/sS4SKbKuzzpgfA3zYf164A6Hq3cFxVd15TSdDDDaI1idJrIiSP
	 f5EHdiL4wGyiRD3456DdrjkIgt7VJozmb8jurx/A1O3+PnayooJADVcl6382MwY5Ev
	 7V7WPrGqcohHXL763LuQrTp2e5LuG+9ZwuNuNEqocDNDbrfbxzhy0aFXR6vT5lB5Mq
	 WFVzPnCcD5k8Uedk+BRPTuUuPE0/l8Ep9HH7Znz46hs+xGWmQzny+nRS1xfainHfCR
	 MmKThQYUtNU0g==
Message-ID: <8f3624ced0d3848df7ce5c8eb4ebf40a8aefef3b.camel@kernel.org>
Subject: Re: Leaked nfsd_file due to race condition and early unhash
 (fs/nfsd/filecache.c)
From: Jeff Layton <jlayton@kernel.org>
To: Youzhong Yang <youzhong@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Thu, 11 Jul 2024 10:59:07 -0400
In-Reply-To: <CADpNCvYWfkbvabEt8u9Wn2=LWPbFTKUyr8JE_tKuJSyLj-XiFw@mail.gmail.com>
References: 
	<CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
	 <ZoWWis0AgvmiVzBU@tissot.1015granger.net>
	 <CADpNCvbxN5hmORArs+vb5D7nRC4xNf1U4oUSDbkUx8MPV547rA@mail.gmail.com>
	 <0445d64ebcc7185bf48cc05f72ca29b859f45c26.camel@poochiereds.net>
	 <CADpNCvZ-kEc6hOQHsbn7yHtvB-acg_gQwzEjN9zcjw0oM2RgGw@mail.gmail.com>
	 <321ddc16356d75f9eb6e5ab15c4e28fae1466267.camel@kernel.org>
	 <CADpNCvb5kpghbEj+yU1OgKF0BJS9dYDtFgRz3ArfCamCnyn_Ww@mail.gmail.com>
	 <c138dd82bb493abe7b0c34b1e2803437bd163c54.camel@kernel.org>
	 <CADpNCvY-hTbO6OGAHO4N43UZjEtv5eyDmNU-S19ULn1iUOES3A@mail.gmail.com>
	 <e1480c3a6ec15d6df9edd26bdb9e39a2edb51c6a.camel@kernel.org>
	 <CADpNCvbfrDr7WbgKc+-TMHV-C+p9Fzp7vLNz6VB==29EcjqVYg@mail.gmail.com>
	 <3bb40da41e450141a0c91f32f184f465d3c5f203.camel@kernel.org>
	 <CADpNCvZ0wpPqenm-Qydnpki7HgjUMNB+UgcFa9ZrTY4bK+wEFw@mail.gmail.com>
	 <ed0dcff753054e8fe651ce6ecc89d9c8bfc2d38e.camel@kernel.org>
	 <CADpNCvY4p3zdFRAk4vivt35GqUm_x0P10KHUTVjO4gQPN+R4zg@mail.gmail.com>
	 <117c90eecca7bbcf617d6d1c8b6f42df3814690d.camel@kernel.org>
	 <CADpNCvYWfkbvabEt8u9Wn2=LWPbFTKUyr8JE_tKuJSyLj-XiFw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedY
	xp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZQiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/D
	CmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnokkZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Great, thanks for testing them! Can we add a Tested-by: for you to the
patches? Consider posting your testcase as well. Maybe we can add it to
fstests or another testsuite.

Thanks,
Jeff

On Thu, 2024-07-11 at 10:54 -0400, Youzhong Yang wrote:
> I'd like to report that your patches + the "list_head nf_gc" patch
> together have been tested under heavy nfs load generated by machines
> in our testing farm, no leak has been observed.
>=20
> Surely my reproducer can no longer reproduce the issue once the
> patches are applied.
>=20
> FYI here is the reproducer:
> https://github.com/youzhongyang/nfsd-file-leaks
>=20
> On Wed, Jul 10, 2024 at 4:22=E2=80=AFPM Jeff Layton <jlayton@kernel.org>
> wrote:
> >=20
> > Great! If you're able to test the patches I sent earlier today,
> > please
> > let us know if they help with your reproducer.
> >=20
> >=20
> > On Wed, 2024-07-10 at 10:49 -0400, Youzhong Yang wrote:
> > > Thanks Jeff. Just sent out a separate e-mail.
> > >=20
> > > I have a simple reproducer now, it's a C program, I will upload
> > > it to
> > > a github repository together with a readme file and then post the
> > > link
> > > (if allowed) here.
> > >=20
> > > On Wed, Jul 10, 2024 at 9:40=E2=80=AFAM Jeff Layton <jlayton@kernel.o=
rg>
> > > wrote:
> > > >=20
> > > > Can you send it as a separate [PATCH] email? I think your MUA
> > > > is
> > > > mangling the patches as I couldn't apply it earlier. Either use
> > > > git-
> > > > send-email or have a look over this page:
> > > >=20
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0
> > > > https://www.kernel.org/doc/html/latest/process/email-clients.html#e=
mail-clients
> > > >=20
> > > > Thanks!
> > > > Jeff
> > > >=20
> > > > On Wed, 2024-07-10 at 09:33 -0400, Youzhong Yang wrote:
> > > > > Thanks. Here it is again:
> > > > >=20
> > > > > commit c6e69cebc052cb82d91fc81a98aee20749fe8d47
> > > > > Author: Youzhong Yang <youzhong@gmail.com>
> > > > > Date:=C2=A0=C2=A0 Thu Jul 4 11:25:40 2024 -0400
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 nfsd: fix nfsd_file leaking due to mixed use o=
f nf-
> > > > > >nf_lru
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 nfsd_file_put() in one thread can race with an=
other
> > > > > thread doing
> > > > > =C2=A0=C2=A0=C2=A0 garbage collection (running nfsd_file_gc() ->
> > > > > list_lru_walk() ->
> > > > > =C2=A0=C2=A0=C2=A0 nfsd_file_lru_cb()):
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In nfsd_file_put(), nf->nf_ref i=
s 1, so it tries to
> > > > > do
> > > > > nfsd_file_lru_add().
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nfsd_file_lru_add() returns true=
 (with
> > > > > NFSD_FILE_REFERENCED
> > > > > bit set)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * garbage collector kicks in, nfsd=
_file_lru_cb() clears
> > > > > REFERENCED bit and
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 returns LRU_ROTATE.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * garbage collector kicks in again=
, nfsd_file_lru_cb()
> > > > > now
> > > > > decrements nf->nf_ref
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to 0, runs nfsd_file_u=
nhash(), removes it from the
> > > > > LRU and
> > > > > adds to the dispose
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list [list_lru_isolate=
_move(lru, &nf->nf_lru, head)]
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nfsd_file_put() detects NFSD_FIL=
E_HASHED bit is
> > > > > cleared, so
> > > > > it
> > > > > tries to remove
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the 'nf' from the LRU =
[if
> > > > > (!nfsd_file_lru_remove(nf))]. The
> > > > > 'nf' has been added
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to the 'dispose' list =
by nfsd_file_lru_cb(), so
> > > > > nfsd_file_lru_remove(nf) simply
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 treats it as part of t=
he LRU and removes it, which
> > > > > leads to
> > > > > its removal from
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the 'dispose' list.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * At this moment, 'nf' is unhashed=
 with its nf_ref
> > > > > being 0, and
> > > > > not on the LRU.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_put() contin=
ues its execution [if
> > > > > (refcount_dec_and_test(&nf->nf_ref))],
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as nf->nf_ref is alrea=
dy 0, nf->nf_ref is set to
> > > > > REFCOUNT_SATURATED, and the 'nf'
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gets no chance of bein=
g freed.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 nfsd_file_put() can also race with
> > > > > nfsd_file_cond_queue():
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In nfsd_file_put(), nf->nf_ref i=
s 1, so it tries to
> > > > > do
> > > > > nfsd_file_lru_add().
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nfsd_file_lru_add() sets REFEREN=
CED bit and returns
> > > > > true.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Some userland application runs '=
exportfs -f' or
> > > > > something
> > > > > like
> > > > > that, which triggers
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __nfsd_file_cache_purg=
e() -> nfsd_file_cond_queue().
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * In nfsd_file_cond_queue(), it ru=
ns [if
> > > > > (!nfsd_file_unhash(nf))], unhash is done
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 successfully.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > (!nfsd_file_get(nf))], now
> > > > > nf->nf_ref goes to 2.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > (nfsd_file_lru_remove(nf))],
> > > > > it succeeds.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > (refcount_sub_and_test(decrement, &nf->nf_ref))]
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (with "decrement" bein=
g 2), so the nf->nf_ref goes to
> > > > > 0, the
> > > > > 'nf' is added to the
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispose list [list_add=
(&nf->nf_lru, dispose)]
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nfsd_file_put() detects NFSD_FIL=
E_HASHED bit is
> > > > > cleared, so
> > > > > it
> > > > > tries to remove
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the 'nf' from the LRU =
[if
> > > > > (!nfsd_file_lru_remove(nf))],
> > > > > although the 'nf' is not
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in the LRU, but it is =
linked in the 'dispose' list,
> > > > > nfsd_file_lru_remove() simply
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 treats it as part of t=
he LRU and removes it. This
> > > > > leads to
> > > > > its
> > > > > removal from
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the 'dispose' list!
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Now nf->ref is 0, unhashed. nfsd=
_file_put() continues
> > > > > its
> > > > > execution and set
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_ref to REFCOUNT=
_SATURATED.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 As shown in the above analysis, using nf_lru f=
or both the
> > > > > LRU
> > > > > list
> > > > > and dispose list
> > > > > =C2=A0=C2=A0=C2=A0 can cause the leaks. This patch adds a new lis=
t_head
> > > > > nf_gc in
> > > > > struct nfsd_file, and uses
> > > > > =C2=A0=C2=A0=C2=A0 it for the dispose list.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Youzhong Yang <youzhong@gmail.c=
om>
> > > > >=20
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index ad9083ca144b..22ebd7fb8639 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct
> > > > > inode
> > > > > *inode, unsigned char need,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&nf->nf=
_lru);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&nf->nf_gc);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_birthtime =3D k=
time_get();
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_file =3D NULL;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_cred =3D get_cu=
rrent_cred();
> > > > > @@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head
> > > > > *dispose)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file *nf;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_empty(dis=
pose)) {
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(dispose, struct
> > > > > nfsd_file,
> > > > > nf_lru);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(dispose, struct
> > > > > nfsd_file,
> > > > > nf_gc);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0}
> > > > > @@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct
> > > > > list_head
> > > > > *dispose)
> > > > > =C2=A0{
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while(!list_empty(disp=
ose)) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file *nf =3D
> > > > > list_first_entry(dispose,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
> > > > > nfsd_file,
> > > > > nf_lru);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
> > > > > nfsd_file,
> > > > > nf_gc);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn =3D net_generic(nf->nf_net,
> > > > > nfsd_net_id);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fcache_disposal *l =3D nn-
> > > > > >fcache_disposal;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&l->lock);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_lru, &l->freeme);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_gc, &l->freeme);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&l->lock);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc_wake_up(nn->nfsd_serv);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > @@ -503,7 +504,8 @@ nfsd_file_lru_cb(struct list_head *item,
> > > > > struct
> > > > > list_lru_one *lru,
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Refcount went to ze=
ro. Unhash it and queue it to
> > > > > the
> > > > > dispose list */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_unhash(nf);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_isolate_move(lru, =
&nf->nf_lru, head);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_isolate(lru, &nf->=
nf_lru);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_gc, head);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_cpu_inc(nfsd_file=
_evictions);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_gc_dis=
posed(nf);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return LRU_REMOVED;
> > > > > @@ -578,7 +580,7 @@ nfsd_file_cond_queue(struct nfsd_file
> > > > > *nf, struct
> > > > > list_head *dispose)
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If refcount goes to=
 0, then put on the dispose
> > > > > list */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount_sub_and_t=
est(decrement, &nf->nf_ref)) {
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_lru, dispose);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_gc, dispose);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_closing(nf);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0}
> > > > > @@ -654,8 +656,8 @@ nfsd_file_close_inode_sync(struct inode
> > > > > *inode)
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_queue_for_cl=
ose(inode, &dispose);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_empty(&di=
spose)) {
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(&dispose, struct
> > > > > nfsd_file,
> > > > > nf_lru);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(&dispose, struct
> > > > > nfsd_file,
> > > > > nf_gc);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0}
> > > > > diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> > > > > index c61884def906..3fbec24eea6c 100644
> > > > > --- a/fs/nfsd/filecache.h
> > > > > +++ b/fs/nfsd/filecache.h
> > > > > @@ -44,6 +44,7 @@ struct nfsd_file {
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file_mark=
=C2=A0=C2=A0 *nf_mark;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_lru;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_gc;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rcu_head=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_rcu;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nf_birthtime;
> > > > > =C2=A0};
> > > > >=20
> > > > > On Wed, Jul 10, 2024 at 8:49=E2=80=AFAM Jeff Layton
> > > > > <jlayton@kernel.org>
> > > > > wrote:
> > > > > >=20
> > > > > > Ok, thanks. I went crawling over the filecache code, and
> > > > > > found a
> > > > > > couple
> > > > > > of potential nfsd_file leaks. I'm testing patches now and
> > > > > > will
> > > > > > likely
> > > > > > send them along later today.
> > > > > >=20
> > > > > > I think we do still want the patch to add nf_gc list_head.
> > > > > > I'm not
> > > > > > certain there is a race there, but it's safer to just use a
> > > > > > separate
> > > > > > list_head and it doesn't represent a lot of memory.
> > > > > >=20
> > > > > > Could you post that one individually so that Chuck can pick
> > > > > > it up?
> > > > > >=20
> > > > > > Thanks,
> > > > > > Jeff
> > > > > >=20
> > > > > > On Tue, 2024-07-09 at 15:13 -0400, Youzhong Yang wrote:
> > > > > > > It's not on the LRU:
> > > > > > >=20
> > > > > > > crash> struct
> > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_gc
> > > > > > > ffff898107b95980
> > > > > > > =C2=A0 nf_flags =3D 12,
> > > > > > > =C2=A0 nf_ref.refs.counter =3D 1
> > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff898107b959c8,
> > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff898107b959c8
> > > > > > > =C2=A0 },
> > > > > > > =C2=A0 nf_gc =3D {
> > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff898107b959d8,
> > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff898107b959d8
> > > > > > > =C2=A0 },
> > > > > > >=20
> > > > > > > I don't have an easy reproducer now as I am having
> > > > > > > difficulty
> > > > > > > generating tons of NFS read/write ops using a limited
> > > > > > > number of
> > > > > > > nfs
> > > > > > > clients. I use our in-house testing farm to test the
> > > > > > > patch.
> > > > > > >=20
> > > > > > > Thanks.
> > > > > > >=20
> > > > > > > On Tue, Jul 9, 2024 at 3:05=E2=80=AFPM Jeff Layton
> > > > > > > <jlayton@kernel.org>
> > > > > > > wrote:
> > > > > > > >=20
> > > > > > > > On Tue, 2024-07-09 at 14:37 -0400, Youzhong Yang wrote:
> > > > > > > > > Thanks Jeff.
> > > > > > > > >=20
> > > > > > > > > Unfortunately the early unhash easily leads to leaks:
> > > > > > > > >=20
> > > > > > > > > crash> kmem -S nfsd_file | grep '\[ffff' | sed -e
> > > > > > > > > 's|\[||' -e
> > > > > > > > > 's|\]||'
> > > > > > > > > > xargs -i echo struct
> > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > > '{}' >
> > > > > > > > > /var/tmp/nfsd_files
> > > > > > > > > crash> !wc -l /var/tmp/nfsd_files
> > > > > > > > > 19 /var/tmp/nfsd_files
> > > > > > > > > crash> < /var/tmp/nfsd_files
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff88865c778900
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 2
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff88865c778cc0
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 3
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff8885d5f35e00
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 1
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff88817443e780
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 3
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff88818b3f0600
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 2
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff88a4490f8300
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 1
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff88a0dab183c0
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 40
> > > > > > > >=20
> > > > > > > > That's a lot of references! Might be interesting to
> > > > > > > > look more
> > > > > > > > closely
> > > > > > > > at that one, but the refcounts are all over the place,
> > > > > > > > so it
> > > > > > > > really
> > > > > > > > does look like we just have a refcount leak somewhere.
> > > > > > > >=20
> > > > > > > > > ...
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff89209535f200
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 2
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff8980e15138c0
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 7
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff898107b95800
> > > > > > > > > =C2=A0 nf_flags =3D 8,
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 3
> > > > > > > > > crash> struct nfsd_file.nf_flags,nf_ref.refs.counter
> > > > > > > > > ffff898107b95980
> > > > > > > > > =C2=A0 nf_flags =3D 12,
> > > > > > > >=20
> > > > > > > > The others are NFSD_FILE_GC. This one is also
> > > > > > > > NFSD_FILE_REFERENCED. Are
> > > > > > > > these objects on the LRU?
> > > > > > > >=20
> > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 1
> > > > > > > > >=20
> > > > > > > > > nfsd_file_do_acquire() -> nfsd_file_lookup_locked()
> > > > > > > > > relies on
> > > > > > > > > the
> > > > > > > > > hash
> > > > > > > > > table to find the nfsd_file,
> > > > > > > > > but I am still scratching my head why and how this
> > > > > > > > > happens.
> > > > > > > > >=20
> > > > > > > > > FYI, here is the patch I applied for testing:
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > The above suggests to me that there is a garden-variety
> > > > > > > > refcount leak
> > > > > > > > somewhere. Whenever some bit of the code takes a
> > > > > > > > reference to
> > > > > > > > an object
> > > > > > > > (like a nfsd_file), it's implicitly required to
> > > > > > > > eventually put
> > > > > > > > that
> > > > > > > > reference. Typically that means that the code needs to
> > > > > > > > maintain
> > > > > > > > a
> > > > > > > > pointer to that object, as it can be unhashed at any
> > > > > > > > time and
> > > > > > > > it can't
> > > > > > > > rely on finding the same object later.
> > > > > > > >=20
> > > > > > > > Do you have a reproducer for this?
> > > > > > > >=20
> > > > > > > > > diff --git a/fs/nfsd/filecache.c
> > > > > > > > > b/fs/nfsd/filecache.c
> > > > > > > > > index ad9083ca144b..22ebd7fb8639 100644
> > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > @@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net,
> > > > > > > > > struct
> > > > > > > > > inode
> > > > > > > > > *inode, unsigned char need,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD=
(&nf->nf_lru);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&nf-=
>nf_gc);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_birthti=
me =3D ktime_get();
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_file =
=3D NULL;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf_cred =
=3D get_current_cred();
> > > > > > > > > @@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct
> > > > > > > > > list_head
> > > > > > > > > *dispose)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fi=
le *nf;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_e=
mpty(dispose)) {
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(dispose, struct
> > > > > > > > > nfsd_file,
> > > > > > > > > nf_lru);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(dispose, struct
> > > > > > > > > nfsd_file,
> > > > > > > > > nf_gc);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > =C2=A0}
> > > > > > > > > @@ -411,12 +412,12 @@
> > > > > > > > > nfsd_file_dispose_list_delayed(struct
> > > > > > > > > list_head
> > > > > > > > > *dispose)
> > > > > > > > > =C2=A0{
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while(!list_em=
pty(dispose)) {
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file *nf =3D
> > > > > > > > > list_first_entry(dispose,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > struct
> > > > > > > > > nfsd_file,
> > > > > > > > > nf_lru);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > struct
> > > > > > > > > nfsd_file,
> > > > > > > > > nf_gc);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn =3D net_generic(nf-
> > > > > > > > > >nf_net,
> > > > > > > > > nfsd_net_id);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fcache_disposal *l =3D nn-
> > > > > > > > > > fcache_disposal;
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&l->lock);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_lru, &l-
> > > > > > > > > >freeme);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_gc, &l-
> > > > > > > > > >freeme);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&l->lock);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc_wake_up(nn->nfsd_serv);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > @@ -503,7 +504,8 @@ nfsd_file_lru_cb(struct list_head
> > > > > > > > > *item,
> > > > > > > > > struct
> > > > > > > > > list_lru_one *lru,
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Refcount we=
nt to zero. Unhash it and queue
> > > > > > > > > it to
> > > > > > > > > the
> > > > > > > > > dispose list */
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_unha=
sh(nf);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_isolate_mo=
ve(lru, &nf->nf_lru,
> > > > > > > > > head);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_isolate(lr=
u, &nf->nf_lru);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_gc=
, head);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_cpu_inc(n=
fsd_file_evictions);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_fil=
e_gc_disposed(nf);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return LRU_REM=
OVED;
> > > > > > > > > @@ -578,7 +580,7 @@ nfsd_file_cond_queue(struct
> > > > > > > > > nfsd_file
> > > > > > > > > *nf, struct
> > > > > > > > > list_head *dispose)
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If refcount=
 goes to 0, then put on the
> > > > > > > > > dispose
> > > > > > > > > list */
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount_s=
ub_and_test(decrement, &nf-
> > > > > > > > > >nf_ref)) {
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_lru, dispose);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_gc, dispose);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_closing(nf);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > =C2=A0}
> > > > > > > > > @@ -654,8 +656,8 @@ nfsd_file_close_inode_sync(struct
> > > > > > > > > inode
> > > > > > > > > *inode)
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_queu=
e_for_close(inode, &dispose);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_e=
mpty(&dispose)) {
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(&dispose,
> > > > > > > > > struct
> > > > > > > > > nfsd_file,
> > > > > > > > > nf_lru);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D list_first_entry(&dispose,
> > > > > > > > > struct
> > > > > > > > > nfsd_file,
> > > > > > > > > nf_gc);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > =C2=A0}
> > > > > > > > > diff --git a/fs/nfsd/filecache.h
> > > > > > > > > b/fs/nfsd/filecache.h
> > > > > > > > > index c61884def906..3fbec24eea6c 100644
> > > > > > > > > --- a/fs/nfsd/filecache.h
> > > > > > > > > +++ b/fs/nfsd/filecache.h
> > > > > > > > > @@ -44,6 +44,7 @@ struct nfsd_file {
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fi=
le_mark=C2=A0=C2=A0 *nf_mark;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_he=
ad=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_lru;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_gc;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rcu_hea=
d=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_rcu;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nf_birthtime;
> > > > > > > > > =C2=A0};
> > > > > > > > >=20
> > > > > > > > > On Mon, Jul 8, 2024 at 10:55=E2=80=AFAM Jeff Layton
> > > > > > > > > <jlayton@kernel.org>
> > > > > > > > > wrote:
> > > > > > > > > >=20
> > > > > > > > > > On Mon, 2024-07-08 at 10:23 -0400, Youzhong Yang
> > > > > > > > > > wrote:
> > > > > > > > > > > Thanks Jeff.
> > > > > > > > > > >=20
> > > > > > > > > > > I am ok with reverting the unhash/dispose list
> > > > > > > > > > > reordering
> > > > > > > > > > > in
> > > > > > > > > > > nfsd_file_lru_cb(), as it doesn't make much of a
> > > > > > > > > > > difference,
> > > > > > > > > > > but for nfsd_file_cond_queue(), imagining this:
> > > > > > > > > > >=20
> > > > > > > > > > > - A nfsd_file is hashed
> > > > > > > > > > > - In nfsd_file_cond_queue(), [if
> > > > > > > > > > > (!nfsd_file_unhash(nf))]
> > > > > > > > > > > will
> > > > > > > > > > > get it
> > > > > > > > > > > unhashed, doesn't it?
> > > > > > > > > > > - It continues to get a reference by
> > > > > > > > > > > nfsd_file_get()
> > > > > > > > > > > - It continues to remove itself from LRU by
> > > > > > > > > > > nfsd_file_lru_remove() if
> > > > > > > > > > > it is on the LRU.
> > > > > > > > > > > - Now it runs refcount_sub_and_test(), what
> > > > > > > > > > > happens if
> > > > > > > > > > > the refcnt
> > > > > > > > > > > does
> > > > > > > > > > > not go to 0? How can this nfsd_file be found
> > > > > > > > > > > again?
> > > > > > > > > > > Through the
> > > > > > > > > > > hash
> > > > > > > > > > > table? Through the LRU walk? how?
> > > > > > > > > > >=20
> > > > > > > > > > > Thanks again.
> > > > > > > > > > >=20
> > > > > > > > > > > -Youzhong
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > It won't need to be found again. The holders of the
> > > > > > > > > > extra
> > > > > > > > > > references
> > > > > > > > > > will put those references when they are finished.
> > > > > > > > > > Since the
> > > > > > > > > > object
> > > > > > > > > > is
> > > > > > > > > > no longer HASHED, nfsd_file_put just does this:
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount=
_dec_and_test(&nf->nf_ref))
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > > > > > >=20
> > > > > > > > > > So that should be fine.
> > > > > > > > > >=20
> > > > > > > > > > > On Mon, Jul 8, 2024 at 9:35=E2=80=AFAM Jeff Layton
> > > > > > > > > > > <jlayton@kernel.org>
> > > > > > > > > > > wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Mon, 2024-07-08 at 08:58 -0400, Youzhong
> > > > > > > > > > > > Yang wrote:
> > > > > > > > > > > > > Thank you Jeff for your invaluable insights.
> > > > > > > > > > > > > I was
> > > > > > > > > > > > > leaning
> > > > > > > > > > > > > towards
> > > > > > > > > > > > > adding a new list_head too, and tested this
> > > > > > > > > > > > > approach
> > > > > > > > > > > > > on
> > > > > > > > > > > > > kernel
> > > > > > > > > > > > > 6.6 by
> > > > > > > > > > > > > continuously hammering the server with heavy
> > > > > > > > > > > > > nfs load
> > > > > > > > > > > > > for the
> > > > > > > > > > > > > last few
> > > > > > > > > > > > > days, not a single leak.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Here goes the patch (based on Linux kernel
> > > > > > > > > > > > > master
> > > > > > > > > > > > > branch),
> > > > > > > > > > > > > please
> > > > > > > > > > > > > review:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > From: Youzhong Yang <youzhong@gmail.com>
> > > > > > > > > > > > > Date: Thu, 4 Jul 2024 11:25:40 -0400
> > > > > > > > > > > > > Subject: [PATCH] nfsd: fix nfsd_file leaking
> > > > > > > > > > > > > due to
> > > > > > > > > > > > > mixed use
> > > > > > > > > > > > > of
> > > > > > > > > > > > > nf->nf_lru
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > nfsd_file_put() in one thread can race with
> > > > > > > > > > > > > another
> > > > > > > > > > > > > thread
> > > > > > > > > > > > > doing
> > > > > > > > > > > > > garbage collection (running nfsd_file_gc() ->
> > > > > > > > > > > > > list_lru_walk()
> > > > > > > > > > > > > ->
> > > > > > > > > > > > > nfsd_file_lru_cb()):
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so
> > > > > > > > > > > > > it tries
> > > > > > > > > > > > > to do
> > > > > > > > > > > > > nfsd_file_lru_add().
> > > > > > > > > > > > > =C2=A0 * nfsd_file_lru_add() returns true (with
> > > > > > > > > > > > > NFSD_FILE_REFERENCED
> > > > > > > > > > > > > bit set)
> > > > > > > > > > > > > =C2=A0 * garbage collector kicks in,
> > > > > > > > > > > > > nfsd_file_lru_cb()
> > > > > > > > > > > > > clears
> > > > > > > > > > > > > REFERENCED bit and
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 returns LRU_ROTATE.
> > > > > > > > > > > > > =C2=A0 * garbage collector kicks in again,
> > > > > > > > > > > > > nfsd_file_lru_cb() now
> > > > > > > > > > > > > decrements nf->nf_ref
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 to 0, runs nfsd_file_unhash(),=
 removes it
> > > > > > > > > > > > > from
> > > > > > > > > > > > > the LRU
> > > > > > > > > > > > > and
> > > > > > > > > > > > > adds to
> > > > > > > > > > > > > the dispose
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 list [list_lru_isolate_move(lr=
u, &nf-
> > > > > > > > > > > > > >nf_lru,
> > > > > > > > > > > > > head)]
> > > > > > > > > > > > > =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED
> > > > > > > > > > > > > bit is
> > > > > > > > > > > > > cleared,
> > > > > > > > > > > > > so
> > > > > > > > > > > > > it
> > > > > > > > > > > > > tries to remove
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 the 'nf' from the LRU [if
> > > > > > > > > > > > > (!nfsd_file_lru_remove(nf))].
> > > > > > > > > > > > > The
> > > > > > > > > > > > > 'nf'
> > > > > > > > > > > > > has been added
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 to the 'dispose' list by
> > > > > > > > > > > > > nfsd_file_lru_cb(), so
> > > > > > > > > > > > > nfsd_file_lru_remove(nf) simply
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 treats it as part of the LRU a=
nd removes
> > > > > > > > > > > > > it,
> > > > > > > > > > > > > which leads
> > > > > > > > > > > > > to
> > > > > > > > > > > > > its removal from
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 the 'dispose' list.
> > > > > > > > > > > > > =C2=A0 * At this moment, 'nf' is unhashed with it=
s
> > > > > > > > > > > > > nf_ref
> > > > > > > > > > > > > being 0,
> > > > > > > > > > > > > and
> > > > > > > > > > > > > not
> > > > > > > > > > > > > on the LRU.
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 nfsd_file_put() continues its =
execution
> > > > > > > > > > > > > [if
> > > > > > > > > > > > > (refcount_dec_and_test(&nf->nf_ref))],
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 as nf->nf_ref is already 0, nf=
->nf_ref is
> > > > > > > > > > > > > set to
> > > > > > > > > > > > > REFCOUNT_SATURATED, and the 'nf'
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 gets no chance of being freed.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > nfsd_file_put() can also race with
> > > > > > > > > > > > > nfsd_file_cond_queue():
> > > > > > > > > > > > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1, so
> > > > > > > > > > > > > it tries
> > > > > > > > > > > > > to do
> > > > > > > > > > > > > nfsd_file_lru_add().
> > > > > > > > > > > > > =C2=A0 * nfsd_file_lru_add() sets REFERENCED bit
> > > > > > > > > > > > > and
> > > > > > > > > > > > > returns true.
> > > > > > > > > > > > > =C2=A0 * Some userland application runs 'exportfs
> > > > > > > > > > > > > -f' or
> > > > > > > > > > > > > something
> > > > > > > > > > > > > like
> > > > > > > > > > > > > that, which triggers
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 __nfsd_file_cache_purge() ->
> > > > > > > > > > > > > nfsd_file_cond_queue().
> > > > > > > > > > > > > =C2=A0 * In nfsd_file_cond_queue(), it runs [if
> > > > > > > > > > > > > (!nfsd_file_unhash(nf))],
> > > > > > > > > > > > > unhash is done
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 successfully.
> > > > > > > > > > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > > > > > > > > > (!nfsd_file_get(nf))],
> > > > > > > > > > > > > now
> > > > > > > > > > > > > nf->nf_ref goes to 2.
> > > > > > > > > > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > > > > > > > > > (nfsd_file_lru_remove(nf))],
> > > > > > > > > > > > > it succeeds.
> > > > > > > > > > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > > > > > > > > > (refcount_sub_and_test(decrement,
> > > > > > > > > > > > > &nf->nf_ref))]
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 (with "decrement" being 2), so=
 the nf-
> > > > > > > > > > > > > >nf_ref
> > > > > > > > > > > > > goes to 0,
> > > > > > > > > > > > > the
> > > > > > > > > > > > > 'nf'
> > > > > > > > > > > > > is added to the
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 dispose list [list_add(&nf->nf=
_lru,
> > > > > > > > > > > > > dispose)]
> > > > > > > > > > > > > =C2=A0 * nfsd_file_put() detects NFSD_FILE_HASHED
> > > > > > > > > > > > > bit is
> > > > > > > > > > > > > cleared,
> > > > > > > > > > > > > so
> > > > > > > > > > > > > it
> > > > > > > > > > > > > tries to remove
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 the 'nf' from the LRU [if
> > > > > > > > > > > > > (!nfsd_file_lru_remove(nf))],
> > > > > > > > > > > > > although
> > > > > > > > > > > > > the 'nf' is not
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 in the LRU, but it is linked i=
n the
> > > > > > > > > > > > > 'dispose'
> > > > > > > > > > > > > list,
> > > > > > > > > > > > > nfsd_file_lru_remove() simply
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 treats it as part of the LRU a=
nd removes
> > > > > > > > > > > > > it. This
> > > > > > > > > > > > > leads
> > > > > > > > > > > > > to
> > > > > > > > > > > > > its removal from
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 the 'dispose' list!
> > > > > > > > > > > > > =C2=A0 * Now nf->ref is 0, unhashed.
> > > > > > > > > > > > > nfsd_file_put()
> > > > > > > > > > > > > continues its
> > > > > > > > > > > > > execution and set
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 nf->nf_ref to REFCOUNT_SATURAT=
ED.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > As shown in the above analysis, using nf_lru
> > > > > > > > > > > > > for both
> > > > > > > > > > > > > the LRU
> > > > > > > > > > > > > list and
> > > > > > > > > > > > > dispose list
> > > > > > > > > > > > > can cause the leaks. This patch adds a new
> > > > > > > > > > > > > list_head
> > > > > > > > > > > > > nf_gc in
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > nfsd_file, and uses
> > > > > > > > > > > > > it for the dispose list. It's not expected to
> > > > > > > > > > > > > have a
> > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > unhashed but it's not
> > > > > > > > > > > > > added to the dispose list, so in
> > > > > > > > > > > > > nfsd_file_cond_queue() and
> > > > > > > > > > > > > nfsd_file_lru_cb() nfsd_file
> > > > > > > > > > > > > is unhashed after being added to the dispose
> > > > > > > > > > > > > list.
> > > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > I don't see where we require the object to be
> > > > > > > > > > > > either
> > > > > > > > > > > > hashed or
> > > > > > > > > > > > on
> > > > > > > > > > > > the
> > > > > > > > > > > > dispose list.=C2=A0 I think you probably just want
> > > > > > > > > > > > to do a
> > > > > > > > > > > > patch
> > > > > > > > > > > > that
> > > > > > > > > > > > changes the dispose list to use a dedicated
> > > > > > > > > > > > list_head
> > > > > > > > > > > > without
> > > > > > > > > > > > reordering when the these things are unhashed.
> > > > > > > > > > > >=20
> > > > > > > > > > > > > Signed-off-by: Youzhong Yang
> > > > > > > > > > > > > <youzhong@gmail.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > =C2=A0fs/nfsd/filecache.c | 23 ++++++++++++++----=
-
> > > > > > > > > > > > > ----
> > > > > > > > > > > > > =C2=A0fs/nfsd/filecache.h |=C2=A0 1 +
> > > > > > > > > > > > > =C2=A02 files changed, 15 insertions(+), 9
> > > > > > > > > > > > > deletions(-)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > diff --git a/fs/nfsd/filecache.c
> > > > > > > > > > > > > b/fs/nfsd/filecache.c
> > > > > > > > > > > > > index ad9083ca144b..3aef2ddfce94 100644
> > > > > > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > > > > > @@ -216,6 +216,7 @@ nfsd_file_alloc(struct
> > > > > > > > > > > > > net *net,
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > inode
> > > > > > > > > > > > > *inode, unsigned char need,
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_L=
IST_HEAD(&nf->nf_lru);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_H=
EAD(&nf->nf_gc);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf=
_birthtime =3D ktime_get();
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf=
_file =3D NULL;
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf->nf=
_cred =3D get_current_cred();
> > > > > > > > > > > > > @@ -393,8 +394,8 @@
> > > > > > > > > > > > > nfsd_file_dispose_list(struct
> > > > > > > > > > > > > list_head
> > > > > > > > > > > > > *dispose)
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 nfsd_file *nf;
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while =
(!list_empty(dispose)) {
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D
> > > > > > > > > > > > > list_first_entry(dispose, struct
> > > > > > > > > > > > > nfsd_file,
> > > > > > > > > > > > > nf_lru);
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D
> > > > > > > > > > > > > list_first_entry(dispose, struct
> > > > > > > > > > > > > nfsd_file,
> > > > > > > > > > > > > nf_gc);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > =C2=A0}
> > > > > > > > > > > > > @@ -411,12 +412,12 @@
> > > > > > > > > > > > > nfsd_file_dispose_list_delayed(struct
> > > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > > =C2=A0{
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while(=
!list_empty(dispose)) {
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file *nf =3D
> > > > > > > > > > > > > list_first_entry(dispose,
> > > > > > > > > > > > > -
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > nfsd_file,
> > > > > > > > > > > > > nf_lru);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > nfsd_file,
> > > > > > > > > > > > > nf_gc);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn =3D
> > > > > > > > > > > > > net_generic(nf-
> > > > > > > > > > > > > > nf_net,
> > > > > > > > > > > > > nfsd_net_id);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_fcache_disposal
> > > > > > > > > > > > > *l =3D nn-
> > > > > > > > > > > > > > fcache_disposal;
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&l->lock);
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_lru,
> > > > > > > > > > > > > &l-
> > > > > > > > > > > > > > freeme);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&nf->nf_gc,
> > > > > > > > > > > > > &l-
> > > > > > > > > > > > > > freeme);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&l->lock);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc_wake_up(nn->nfsd_serv);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > @@ -502,8 +503,10 @@ nfsd_file_lru_cb(struct
> > > > > > > > > > > > > list_head *item,
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > list_lru_one *lru,
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ref=
count went to zero. Unhash it
> > > > > > > > > > > > > and queue
> > > > > > > > > > > > > it to
> > > > > > > > > > > > > the
> > > > > > > > > > > > > dispose list */
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_is=
olate(lru, &nf->nf_lru);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&n=
f->nf_gc, head);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Unhash a=
fter removing from LRU and
> > > > > > > > > > > > > adding
> > > > > > > > > > > > > to
> > > > > > > > > > > > > dispose
> > > > > > > > > > > > > list */
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_f=
ile_unhash(nf);
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_lru_is=
olate_move(lru, &nf-
> > > > > > > > > > > > > >nf_lru,
> > > > > > > > > > > > > head);
> > > > > > > > > > > >=20
> > > > > > > > > > > > I don't see the point in reordering these
> > > > > > > > > > > > operations.
> > > > > > > > > > > > Hashing
> > > > > > > > > > > > is
> > > > > > > > > > > > all
> > > > > > > > > > > > about making the thing findable by nfsd
> > > > > > > > > > > > operations. The
> > > > > > > > > > > > _last_
> > > > > > > > > > > > thing we
> > > > > > > > > > > > want to do is put it on the dispose list while
> > > > > > > > > > > > the
> > > > > > > > > > > > thing can
> > > > > > > > > > > > still
> > > > > > > > > > > > be
> > > > > > > > > > > > found by nfsd threads doing operations.
> > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this_c=
pu_inc(nfsd_file_evictions);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_=
nfsd_file_gc_disposed(nf);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 LRU_REMOVED;
> > > > > > > > > > > > > @@ -565,7 +568,7 @@
> > > > > > > > > > > > > nfsd_file_cond_queue(struct
> > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > *nf,
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int de=
crement =3D 1;
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If =
we raced with someone else
> > > > > > > > > > > > > unhashing,
> > > > > > > > > > > > > ignore it
> > > > > > > > > > > > > */
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!nfsd_f=
ile_unhash(nf))
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_b=
it(NFSD_FILE_HASHED, &nf-
> > > > > > > > > > > > > > nf_flags))
> > > > > > > > > > > >=20
> > > > > > > > > > > > The above change looks wrong. I don't think we
> > > > > > > > > > > > need to
> > > > > > > > > > > > change
> > > > > > > > > > > > this.
> > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If =
we can't get a reference,
> > > > > > > > > > > > > ignore it */
> > > > > > > > > > > > > @@ -578,7 +581,9 @@
> > > > > > > > > > > > > nfsd_file_cond_queue(struct
> > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > *nf,
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If =
refcount goes to 0, then put on
> > > > > > > > > > > > > the
> > > > > > > > > > > > > dispose
> > > > > > > > > > > > > list */
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (re=
fcount_sub_and_test(decrement,
> > > > > > > > > > > > > &nf-
> > > > > > > > > > > > > > nf_ref)) {
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_lru,
> > > > > > > > > > > > > dispose);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_gc,
> > > > > > > > > > > > > dispose);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Unhash after adding to
> > > > > > > > > > > > > dispose
> > > > > > > > > > > > > list */
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_unhash(nf);
> > > > > > > > > > > >=20
> > > > > > > > > > > > This too looks wrong? Maybe I'm unclear on the
> > > > > > > > > > > > race
> > > > > > > > > > > > you're
> > > > > > > > > > > > trying
> > > > > > > > > > > > to
> > > > > > > > > > > > fix with this? What's the harm in unhashing it
> > > > > > > > > > > > early?
> > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_closing(nf);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > =C2=A0}
> > > > > > > > > > > > > @@ -654,8 +659,8 @@
> > > > > > > > > > > > > nfsd_file_close_inode_sync(struct
> > > > > > > > > > > > > inode
> > > > > > > > > > > > > *inode)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_f=
ile_queue_for_close(inode,
> > > > > > > > > > > > > &dispose);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while =
(!list_empty(&dispose)) {
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D
> > > > > > > > > > > > > list_first_entry(&dispose,
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > nfsd_file,
> > > > > > > > > > > > > nf_lru);
> > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_lru);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf =3D
> > > > > > > > > > > > > list_first_entry(&dispose,
> > > > > > > > > > > > > struct
> > > > > > > > > > > > > nfsd_file,
> > > > > > > > > > > > > nf_gc);
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&nf->nf_gc);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > =C2=A0}
> > > > > > > > > > > > > diff --git a/fs/nfsd/filecache.h
> > > > > > > > > > > > > b/fs/nfsd/filecache.h
> > > > > > > > > > > > > index c61884def906..3fbec24eea6c 100644
> > > > > > > > > > > > > --- a/fs/nfsd/filecache.h
> > > > > > > > > > > > > +++ b/fs/nfsd/filecache.h
> > > > > > > > > > > > > @@ -44,6 +44,7 @@ struct nfsd_file {
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 nfsd_file_mark=C2=A0=C2=A0 *nf_mark;
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 list_head=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_lru;
> > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list=
_head=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_gc;
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 rcu_head=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nf_rcu;
> > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktime_=
t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 nf_birthtime;
> > > > > > > > > > > > > =C2=A0};
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.34.1
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Thu, Jul 4, 2024 at 7:14=E2=80=AFAM Jeff Layto=
n
> > > > > > > > > > > > > <jlayton@poochiereds.net> wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Wed, 2024-07-03 at 16:46 -0400, Youzhong
> > > > > > > > > > > > > > Yang
> > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > Thank you Chuck. Here are my quick
> > > > > > > > > > > > > > > answers to
> > > > > > > > > > > > > > > your
> > > > > > > > > > > > > > > comments:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > - I don't have a quick reproducer. I
> > > > > > > > > > > > > > > reproduced
> > > > > > > > > > > > > > > it by
> > > > > > > > > > > > > > > using
> > > > > > > > > > > > > > > hundreds
> > > > > > > > > > > > > > > of nfs clients generating +600K ops under
> > > > > > > > > > > > > > > our
> > > > > > > > > > > > > > > workload in
> > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > testing
> > > > > > > > > > > > > > > environment. Theoretically it should be
> > > > > > > > > > > > > > > possible
> > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > simplify
> > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > reproduction but I am still working on
> > > > > > > > > > > > > > > it.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > -=C2=A0 I understand zfs is an out-of-tree
> > > > > > > > > > > > > > > file
> > > > > > > > > > > > > > > system. That's
> > > > > > > > > > > > > > > fine. But
> > > > > > > > > > > > > > > this leaking can happen to any file
> > > > > > > > > > > > > > > system, and
> > > > > > > > > > > > > > > leaking
> > > > > > > > > > > > > > > is
> > > > > > > > > > > > > > > not a good
> > > > > > > > > > > > > > > thing no matter what file system it is.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > -=C2=A0 I will try to come up with a
> > > > > > > > > > > > > > > reproducer using
> > > > > > > > > > > > > > > xfs or
> > > > > > > > > > > > > > > btrfs
> > > > > > > > > > > > > > > if possible.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Now back to the problem itself, here are
> > > > > > > > > > > > > > > my
> > > > > > > > > > > > > > > findings:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > - nfsd_file_put() in one thread can race
> > > > > > > > > > > > > > > with
> > > > > > > > > > > > > > > another
> > > > > > > > > > > > > > > thread
> > > > > > > > > > > > > > > doing
> > > > > > > > > > > > > > > garbage collection (running
> > > > > > > > > > > > > > > nfsd_file_gc() ->
> > > > > > > > > > > > > > > list_lru_walk()
> > > > > > > > > > > > > > > ->
> > > > > > > > > > > > > > > nfsd_file_lru_cb()):
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1,
> > > > > > > > > > > > > > > so it
> > > > > > > > > > > > > > > tries to
> > > > > > > > > > > > > > > do
> > > > > > > > > > > > > > > nfsd_file_lru_add().
> > > > > > > > > > > > > > > =C2=A0 * nfsd_file_lru_add() returns true
> > > > > > > > > > > > > > > (thus
> > > > > > > > > > > > > > > NFSD_FILE_REFERENCED bit
> > > > > > > > > > > > > > > set for nf->nf_flags)
> > > > > > > > > > > > > > > =C2=A0 * garbage collector kicks in,
> > > > > > > > > > > > > > > nfsd_file_lru_cb() clears
> > > > > > > > > > > > > > > REFERENCED
> > > > > > > > > > > > > > > bit and returns LRU_ROTATE.
> > > > > > > > > > > > > > > =C2=A0 * garbage collector kicks in again,
> > > > > > > > > > > > > > > nfsd_file_lru_cb()
> > > > > > > > > > > > > > > now
> > > > > > > > > > > > > > > decrements nf->nf_ref to 0, runs
> > > > > > > > > > > > > > > nfsd_file_unhash(),
> > > > > > > > > > > > > > > removes
> > > > > > > > > > > > > > > it from
> > > > > > > > > > > > > > > the LRU and adds to the dispose list
> > > > > > > > > > > > > > > [list_lru_isolate_move(lru,
> > > > > > > > > > > > > > > &nf->nf_lru, head);]
> > > > > > > > > > > > > > > =C2=A0 * nfsd_file_put() detects
> > > > > > > > > > > > > > > NFSD_FILE_HASHED bit
> > > > > > > > > > > > > > > is
> > > > > > > > > > > > > > > cleared,
> > > > > > > > > > > > > > > so it
> > > > > > > > > > > > > > > tries to remove the 'nf' from the LRU [if
> > > > > > > > > > > > > > > (!nfsd_file_lru_remove(nf))]
> > > > > > > > > > > > > > > =C2=A0 * The 'nf' has been added to the
> > > > > > > > > > > > > > > 'dispose' list
> > > > > > > > > > > > > > > by
> > > > > > > > > > > > > > > nfsd_file_lru_cb(), so
> > > > > > > > > > > > > > > nfsd_file_lru_remove(nf)
> > > > > > > > > > > > > > > simply
> > > > > > > > > > > > > > > treats
> > > > > > > > > > > > > > > it as
> > > > > > > > > > > > > > > part of the LRU and removes it, which
> > > > > > > > > > > > > > > leads it to
> > > > > > > > > > > > > > > be
> > > > > > > > > > > > > > > removed
> > > > > > > > > > > > > > > from the
> > > > > > > > > > > > > > > 'dispose' list.
> > > > > > > > > > > > > > > =C2=A0 * At this moment, nf->nf_ref is 0, it'=
s
> > > > > > > > > > > > > > > unhashed, and
> > > > > > > > > > > > > > > not
> > > > > > > > > > > > > > > on the
> > > > > > > > > > > > > > > LRU. nfsd_file_put() continues its
> > > > > > > > > > > > > > > execution [if
> > > > > > > > > > > > > > > (refcount_dec_and_test(&nf->nf_ref))], as
> > > > > > > > > > > > > > > nf-
> > > > > > > > > > > > > > > > nf_ref is
> > > > > > > > > > > > > > > already 0, now
> > > > > > > > > > > > > > > bad thing happens: nf->nf_ref is set to
> > > > > > > > > > > > > > > REFCOUNT_SATURATED,
> > > > > > > > > > > > > > > and the
> > > > > > > > > > > > > > > 'nf' is leaked.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > To make this happen, the right timing is
> > > > > > > > > > > > > > > crucial.
> > > > > > > > > > > > > > > It can
> > > > > > > > > > > > > > > be
> > > > > > > > > > > > > > > reproduced
> > > > > > > > > > > > > > > by adding artifical delays in
> > > > > > > > > > > > > > > filecache.c, or
> > > > > > > > > > > > > > > hammering
> > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > nfsd with
> > > > > > > > > > > > > > > tons of ops.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > - Let's see how nfsd_file_put() can race
> > > > > > > > > > > > > > > with
> > > > > > > > > > > > > > > nfsd_file_cond_queue():
> > > > > > > > > > > > > > > =C2=A0 * In nfsd_file_put(), nf->nf_ref is 1,
> > > > > > > > > > > > > > > so it
> > > > > > > > > > > > > > > tries to
> > > > > > > > > > > > > > > do
> > > > > > > > > > > > > > > nfsd_file_lru_add().
> > > > > > > > > > > > > > > =C2=A0 * nfsd_file_lru_add() sets REFERENCED
> > > > > > > > > > > > > > > bit and
> > > > > > > > > > > > > > > returns
> > > > > > > > > > > > > > > true.
> > > > > > > > > > > > > > > =C2=A0 * 'exportfs -f' or something like that
> > > > > > > > > > > > > > > triggers
> > > > > > > > > > > > > > > __nfsd_file_cache_purge() ->
> > > > > > > > > > > > > > > nfsd_file_cond_queue().
> > > > > > > > > > > > > > > =C2=A0 * In nfsd_file_cond_queue(), it runs
> > > > > > > > > > > > > > > [if
> > > > > > > > > > > > > > > (!nfsd_file_unhash(nf))],
> > > > > > > > > > > > > > > unhash is done successfully.
> > > > > > > > > > > > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > > > > > > > > > > > (!nfsd_file_get(nf))],
> > > > > > > > > > > > > > > now
> > > > > > > > > > > > > > > nf->nf_ref goes to 2.
> > > > > > > > > > > > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > > > > > > > > > > > (nfsd_file_lru_remove(nf))], it succeeds.
> > > > > > > > > > > > > > > =C2=A0 * nfsd_file_cond_queue() runs [if
> > > > > > > > > > > > > > > (refcount_sub_and_test(decrement,
> > > > > > > > > > > > > > > &nf->nf_ref))] (with "decrement" being
> > > > > > > > > > > > > > > 2), so the
> > > > > > > > > > > > > > > nf-
> > > > > > > > > > > > > > > > nf_ref
> > > > > > > > > > > > > > > goes to
> > > > > > > > > > > > > > > 0, the 'nf' is added to the dispost list
> > > > > > > > > > > > > > > [list_add(&nf-
> > > > > > > > > > > > > > > > nf_lru,
> > > > > > > > > > > > > > > dispose)]
> > > > > > > > > > > > > > > =C2=A0 * nfsd_file_put() detects
> > > > > > > > > > > > > > > NFSD_FILE_HASHED bit
> > > > > > > > > > > > > > > is
> > > > > > > > > > > > > > > cleared,
> > > > > > > > > > > > > > > so it
> > > > > > > > > > > > > > > tries to remove the 'nf' from the LRU [if
> > > > > > > > > > > > > > > (!nfsd_file_lru_remove(nf))], although
> > > > > > > > > > > > > > > the 'nf'
> > > > > > > > > > > > > > > is not in
> > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > LRU, but
> > > > > > > > > > > > > > > it is linked in the 'dispose' list,
> > > > > > > > > > > > > > > nfsd_file_lru_remove()
> > > > > > > > > > > > > > > simply
> > > > > > > > > > > > > > > treats it as part of the LRU and removes
> > > > > > > > > > > > > > > it. This
> > > > > > > > > > > > > > > leads
> > > > > > > > > > > > > > > to
> > > > > > > > > > > > > > > its removal
> > > > > > > > > > > > > > > from the 'dispose' list!
> > > > > > > > > > > > > > > =C2=A0 * Now nf->ref is 0, unhashed.
> > > > > > > > > > > > > > > nfsd_file_put()
> > > > > > > > > > > > > > > continues
> > > > > > > > > > > > > > > its
> > > > > > > > > > > > > > > execution and sets nf->nf_ref to
> > > > > > > > > > > > > > > REFCOUNT_SATURATED.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > The purpose of nf->nf_lru is problematic.
> > > > > > > > > > > > > > > As you
> > > > > > > > > > > > > > > can see,
> > > > > > > > > > > > > > > it
> > > > > > > > > > > > > > > is used
> > > > > > > > > > > > > > > for the LRU list, and also the 'dispose'
> > > > > > > > > > > > > > > list.
> > > > > > > > > > > > > > > Adding
> > > > > > > > > > > > > > > another
> > > > > > > > > > > > > > > 'struct
> > > > > > > > > > > > > > > list_head' specifically for the 'dispose'
> > > > > > > > > > > > > > > list
> > > > > > > > > > > > > > > seems to
> > > > > > > > > > > > > > > be a
> > > > > > > > > > > > > > > better
> > > > > > > > > > > > > > > way of fixing this race condition. Either
> > > > > > > > > > > > > > > way
> > > > > > > > > > > > > > > works for
> > > > > > > > > > > > > > > me.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Would you agree my above analysis makes
> > > > > > > > > > > > > > > sense?
> > > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I think so. It's been a while since I've
> > > > > > > > > > > > > > done much
> > > > > > > > > > > > > > work in
> > > > > > > > > > > > > > this
> > > > > > > > > > > > > > code,
> > > > > > > > > > > > > > but it does sound like there is a race in
> > > > > > > > > > > > > > the LRU
> > > > > > > > > > > > > > handling.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Like Chuck said, the nf->nf_lru list should
> > > > > > > > > > > > > > be safe
> > > > > > > > > > > > > > to use
> > > > > > > > > > > > > > for
> > > > > > > > > > > > > > multiple
> > > > > > > > > > > > > > purposes, but that's only the case if we're
> > > > > > > > > > > > > > not
> > > > > > > > > > > > > > using that
> > > > > > > > > > > > > > list
> > > > > > > > > > > > > > as an
> > > > > > > > > > > > > > indicator.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > The list_lru code does check this:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 if (!list_empty(item)) {
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > ...so if we ever check this while it's
> > > > > > > > > > > > > > sitting on
> > > > > > > > > > > > > > the
> > > > > > > > > > > > > > dispose
> > > > > > > > > > > > > > list, it
> > > > > > > > > > > > > > will handle it incorrectly. It sounds like
> > > > > > > > > > > > > > that's
> > > > > > > > > > > > > > the root
> > > > > > > > > > > > > > cause of the
> > > > > > > > > > > > > > problem you're seeing?
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > If so, then maybe a separate list_head for
> > > > > > > > > > > > > > disposal
> > > > > > > > > > > > > > would
> > > > > > > > > > > > > > be
> > > > > > > > > > > > > > better.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Here is my patch with signed-off-by:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > From: Youzhong Yang <youzhong@gmail.com>
> > > > > > > > > > > > > > > Date: Mon, 1 Jul 2024 06:45:22 -0400
> > > > > > > > > > > > > > > Subject: [PATCH] nfsd: fix nfsd_file
> > > > > > > > > > > > > > > leaking due
> > > > > > > > > > > > > > > to race
> > > > > > > > > > > > > > > condition and early
> > > > > > > > > > > > > > > =C2=A0unhash
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Signed-off-by: Youzhong Yang
> > > > > > > > > > > > > > > <youzhong@gmail.com>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > =C2=A0fs/nfsd/filecache.c | 14 +++++++++++++-
> > > > > > > > > > > > > > > =C2=A01 file changed, 13 insertions(+), 1
> > > > > > > > > > > > > > > deletion(-)
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > diff --git a/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > b/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > index 1a6d5d000b85..2323829f7208 100644
> > > > > > > > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > @@ -389,6 +389,17 @@ nfsd_file_put(struct
> > > > > > > > > > > > > > > nfsd_file *nf)
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if
> > > > > > > > > > > > > > > (!nfsd_file_lru_remove(nf))
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Racing with
> > > > > > > > > > > > > > > nfsd_file_cond_queue() or
> > > > > > > > > > > > > > > nfsd_file_lru_cb(),
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it's unhashed but then
> > > > > > > > > > > > > > > removed
> > > > > > > > > > > > > > > from
> > > > > > > > > > > > > > > the
> > > > > > > > > > > > > > > dispose list,
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so we need to free it.
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount_read(&nf-
> > > > > > > > > > > > > > > >nf_ref) =3D=3D
> > > > > > > > > > > > > > > 0 &&
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > A refcount_read in this path is a red flag
> > > > > > > > > > > > > > to me.
> > > > > > > > > > > > > > Anytime
> > > > > > > > > > > > > > you're just
> > > > > > > > > > > > > > looking at the refcount without changing
> > > > > > > > > > > > > > anything
> > > > > > > > > > > > > > just
> > > > > > > > > > > > > > screams
> > > > > > > > > > > > > > out
> > > > > > > > > > > > > > "race condition".
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > In this case, what guarantee is there that
> > > > > > > > > > > > > > this
> > > > > > > > > > > > > > won't run
> > > > > > > > > > > > > > afoul
> > > > > > > > > > > > > > of the
> > > > > > > > > > > > > > timing? We could check this and find out
> > > > > > > > > > > > > > it's 1
> > > > > > > > > > > > > > just before
> > > > > > > > > > > > > > it
> > > > > > > > > > > > > > goes to
> > > > > > > > > > > > > > 0 and you check the other conditions.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Does anything prevent that?
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > > > > !test_bit(NFSD_FILE_HASHED,
> > > > > > > > > > > > > > > &nf-
> > > > > > > > > > > > > > > > nf_flags) &&
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_emp=
ty(&nf-
> > > > > > > > > > > > > > > >nf_lru)) {
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
> > > > > > > > > > > > > > > nfsd_file_free(nf);
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (refcount_dec_and_test(&nf-
> > > > > > > > > > > > > > > >nf_ref))
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > > > > > > > > > > > > @@ -576,7 +587,7 @@
> > > > > > > > > > > > > > > nfsd_file_cond_queue(struct
> > > > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > > > *nf, struct
> > > > > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t decrement =3D 1;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 If we raced with someone else
> > > > > > > > > > > > > > > unhashing,
> > > > > > > > > > > > > > > ignore it
> > > > > > > > > > > > > > > */
> > > > > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!nf=
sd_file_unhash(nf))
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!te=
st_bit(NFSD_FILE_HASHED,
> > > > > > > > > > > > > > > &nf-
> > > > > > > > > > > > > > > > nf_flags))
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Same here: you're just testing for the
> > > > > > > > > > > > > > HASHED bit,
> > > > > > > > > > > > > > but
> > > > > > > > > > > > > > could
> > > > > > > > > > > > > > this also
> > > > > > > > > > > > > > race with someone who is setting it just
> > > > > > > > > > > > > > after you
> > > > > > > > > > > > > > get
> > > > > > > > > > > > > > here.
> > > > > > > > > > > > > > Why is
> > > > > > > > > > > > > > that not a problem?
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 If we can't get a reference,
> > > > > > > > > > > > > > > ignore it
> > > > > > > > > > > > > > > */
> > > > > > > > > > > > > > > @@ -590,6 +601,7 @@
> > > > > > > > > > > > > > > nfsd_file_cond_queue(struct
> > > > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > > > *nf, struct
> > > > > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 If refcount goes to 0, then
> > > > > > > > > > > > > > > put on the
> > > > > > > > > > > > > > > dispose
> > > > > > > > > > > > > > > list */
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if
> > > > > > > > > > > > > > > (refcount_sub_and_test(decrement, &nf-
> > > > > > > > > > > > > > > > nf_ref)) {
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add(&nf->nf_lru,
> > > > > > > > > > > > > > > dispose);
> > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfsd_file_unhash(nf);
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > > > > trace_nfsd_file_closing(nf);
> > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > > > =C2=A0}
> > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > 2.43.0
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > On Wed, Jul 3, 2024 at 2:21=E2=80=AFPM Chuck
> > > > > > > > > > > > > > > Lever
> > > > > > > > > > > > > > > <chuck.lever@oracle.com> wrote:
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > On Wed, Jul 03, 2024 at 10:12:33AM -
> > > > > > > > > > > > > > > > 0400,
> > > > > > > > > > > > > > > > Youzhong Yang
> > > > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > > Hello,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > I'd like to report a nfsd_file
> > > > > > > > > > > > > > > > > leaking issue
> > > > > > > > > > > > > > > > > and
> > > > > > > > > > > > > > > > > propose
> > > > > > > > > > > > > > > > > a fix for it.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > When I tested Linux kernel 6.8 and
> > > > > > > > > > > > > > > > > 6.6, I
> > > > > > > > > > > > > > > > > noticed
> > > > > > > > > > > > > > > > > nfsd_file leaks
> > > > > > > > > > > > > > > > > which led to undestroyable file
> > > > > > > > > > > > > > > > > systems
> > > > > > > > > > > > > > > > > (zfs),
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Thanks for the report. Some initial
> > > > > > > > > > > > > > > > comments:
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > - Do you have a specific reproducer? In
> > > > > > > > > > > > > > > > other
> > > > > > > > > > > > > > > > words,
> > > > > > > > > > > > > > > > what
> > > > > > > > > > > > > > > > is the
> > > > > > > > > > > > > > > > =C2=A0 simplest program that can run on an
> > > > > > > > > > > > > > > > NFS
> > > > > > > > > > > > > > > > client that
> > > > > > > > > > > > > > > > will
> > > > > > > > > > > > > > > > trigger
> > > > > > > > > > > > > > > > =C2=A0 this leak, and can you post it?
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > - "zfs" is an out-of-tree file system,
> > > > > > > > > > > > > > > > so it's
> > > > > > > > > > > > > > > > not
> > > > > > > > > > > > > > > > directly
> > > > > > > > > > > > > > > > =C2=A0 supported for NFSD.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > - The guidelines for patch submission
> > > > > > > > > > > > > > > > require
> > > > > > > > > > > > > > > > us to fix
> > > > > > > > > > > > > > > > issues in
> > > > > > > > > > > > > > > > =C2=A0 upstream Linux first (currently
> > > > > > > > > > > > > > > > that's v6.10-
> > > > > > > > > > > > > > > > rc6).
> > > > > > > > > > > > > > > > Then
> > > > > > > > > > > > > > > > that fix
> > > > > > > > > > > > > > > > =C2=A0 can be backported to older stable
> > > > > > > > > > > > > > > > kernels
> > > > > > > > > > > > > > > > like 6.6.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Can you reproduce the leak with one of
> > > > > > > > > > > > > > > > the in-
> > > > > > > > > > > > > > > > kernel
> > > > > > > > > > > > > > > > filesystems
> > > > > > > > > > > > > > > > (either xfs or btrfs would be great)
> > > > > > > > > > > > > > > > and with
> > > > > > > > > > > > > > > > NFSD in
> > > > > > > > > > > > > > > > 6.10-
> > > > > > > > > > > > > > > > rc6?
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > One more comment below.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > here are some examples:
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > crash> struct nfsd_file -x
> > > > > > > > > > > > > > > > > ffff88e160db0460
> > > > > > > > > > > > > > > > > struct nfsd_file {
> > > > > > > > > > > > > > > > > =C2=A0 nf_rlist =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 rhead =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D 0=
xffff8921fa2392f1
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0x0
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_inode =3D 0xffff8882bc312ef8,
> > > > > > > > > > > > > > > > > =C2=A0 nf_file =3D 0xffff88e2015b1500,
> > > > > > > > > > > > > > > > > =C2=A0 nf_cred =3D 0xffff88e3ab0e7800,
> > > > > > > > > > > > > > > > > =C2=A0 nf_net =3D 0xffffffff83d41600
> > > > > > > > > > > > > > > > > <init_net>,
> > > > > > > > > > > > > > > > > =C2=A0 nf_flags =3D 0x8,
> > > > > > > > > > > > > > > > > =C2=A0 nf_ref =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 refs =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter =
=3D 0xc0000000
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_may =3D 0x4,
> > > > > > > > > > > > > > > > > =C2=A0 nf_mark =3D 0xffff88e1bddfb320,
> > > > > > > > > > > > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88e160d=
b04a8,
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88e160d=
b04a8
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_rcu =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0x10000000000=
,
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 func =3D 0x0
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_birthtime =3D 0x73d22fc1728
> > > > > > > > > > > > > > > > > }
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > crash> struct
> > > > > > > > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counte
> > > > > > > > > > > > > > > > > r,nf_lru
> > > > > > > > > > > > > > > > > ,nf_file
> > > > > > > > > > > > > > > > > -x
> > > > > > > > > > > > > > > > > ffff88839a53d850
> > > > > > > > > > > > > > > > > =C2=A0 nf_flags =3D 0x8,
> > > > > > > > > > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > > > > > > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88839a5=
3d898,
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88839a5=
3d898
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_file =3D 0xffff88810ede8700,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > crash> struct
> > > > > > > > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counte
> > > > > > > > > > > > > > > > > r,nf_lru
> > > > > > > > > > > > > > > > > ,nf_file
> > > > > > > > > > > > > > > > > -x
> > > > > > > > > > > > > > > > > ffff88c32b11e850
> > > > > > > > > > > > > > > > > =C2=A0 nf_flags =3D 0x8,
> > > > > > > > > > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > > > > > > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88c32b1=
1e898,
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88c32b1=
1e898
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_file =3D 0xffff88c20a701c00,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > crash> struct
> > > > > > > > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counte
> > > > > > > > > > > > > > > > > r,nf_lru
> > > > > > > > > > > > > > > > > ,nf_file
> > > > > > > > > > > > > > > > > -x
> > > > > > > > > > > > > > > > > ffff88e372709700
> > > > > > > > > > > > > > > > > =C2=A0 nf_flags =3D 0xc,
> > > > > > > > > > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > > > > > > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff88e3727=
09748,
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff88e3727=
09748
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_file =3D 0xffff88e0725e6400,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > crash> struct
> > > > > > > > > > > > > > > > > nfsd_file.nf_flags,nf_ref.refs.counte
> > > > > > > > > > > > > > > > > r,nf_lru
> > > > > > > > > > > > > > > > > ,nf_file
> > > > > > > > > > > > > > > > > -x
> > > > > > > > > > > > > > > > > ffff8982864944d0
> > > > > > > > > > > > > > > > > =C2=A0 nf_flags =3D 0xc,
> > > > > > > > > > > > > > > > > =C2=A0 nf_ref.refs.counter =3D 0x0
> > > > > > > > > > > > > > > > > =C2=A0 nf_lru =3D {
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 next =3D 0xffff8982864=
94518,
> > > > > > > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 prev =3D 0xffff8982864=
94518
> > > > > > > > > > > > > > > > > =C2=A0 },
> > > > > > > > > > > > > > > > > =C2=A0 nf_file =3D 0xffff89803c0ff700,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > The leak occurs when nfsd_file_put()
> > > > > > > > > > > > > > > > > races
> > > > > > > > > > > > > > > > > with
> > > > > > > > > > > > > > > > > nfsd_file_cond_queue()
> > > > > > > > > > > > > > > > > or nfsd_file_lru_cb(). With the
> > > > > > > > > > > > > > > > > following
> > > > > > > > > > > > > > > > > patch, I
> > > > > > > > > > > > > > > > > haven't observed
> > > > > > > > > > > > > > > > > any leak after a few days heavy nfs
> > > > > > > > > > > > > > > > > load:
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Our patch submission guidelines require
> > > > > > > > > > > > > > > > a
> > > > > > > > > > > > > > > > Signed-off-
> > > > > > > > > > > > > > > > by:
> > > > > > > > > > > > > > > > line at the end of the patch
> > > > > > > > > > > > > > > > description. See
> > > > > > > > > > > > > > > > the "Sign
> > > > > > > > > > > > > > > > your work -
> > > > > > > > > > > > > > > > the Developer's Certificate of Origin"
> > > > > > > > > > > > > > > > section
> > > > > > > > > > > > > > > > of
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=
=3Dv6.10-rc6
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > (Needed here in case your fix is
> > > > > > > > > > > > > > > > acceptable).
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > diff --git a/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > > > b/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > > > index 1a6d5d000b85..2323829f7208
> > > > > > > > > > > > > > > > > 100644
> > > > > > > > > > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > > > > > > > > > @@ -389,6 +389,17 @@
> > > > > > > > > > > > > > > > > nfsd_file_put(struct
> > > > > > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > > > > > *nf)
> > > > > > > > > > > > > > > > > =C2=A0 if (!nfsd_file_lru_remove(nf))
> > > > > > > > > > > > > > > > > =C2=A0 return;
> > > > > > > > > > > > > > > > > =C2=A0 }
> > > > > > > > > > > > > > > > > + /*
> > > > > > > > > > > > > > > > > + * Racing with
> > > > > > > > > > > > > > > > > nfsd_file_cond_queue() or
> > > > > > > > > > > > > > > > > nfsd_file_lru_cb(),
> > > > > > > > > > > > > > > > > + * it's unhashed but then removed
> > > > > > > > > > > > > > > > > from the
> > > > > > > > > > > > > > > > > dispose
> > > > > > > > > > > > > > > > > list,
> > > > > > > > > > > > > > > > > + * so we need to free it.
> > > > > > > > > > > > > > > > > + */
> > > > > > > > > > > > > > > > > + if (refcount_read(&nf->nf_ref) =3D=3D 0
> > > > > > > > > > > > > > > > > &&
> > > > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 !test_bit(NFSD_=
FILE_HASHED,
> > > > > > > > > > > > > > > > > &nf-
> > > > > > > > > > > > > > > > > > nf_flags) &&
> > > > > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 list_empty(&nf-=
>nf_lru)) {
> > > > > > > > > > > > > > > > > + nfsd_file_free(nf);
> > > > > > > > > > > > > > > > > + return;
> > > > > > > > > > > > > > > > > + }
> > > > > > > > > > > > > > > > > =C2=A0 }
> > > > > > > > > > > > > > > > > =C2=A0 if (refcount_dec_and_test(&nf-
> > > > > > > > > > > > > > > > > >nf_ref))
> > > > > > > > > > > > > > > > > =C2=A0 nfsd_file_free(nf);
> > > > > > > > > > > > > > > > > @@ -576,7 +587,7 @@
> > > > > > > > > > > > > > > > > nfsd_file_cond_queue(struct
> > > > > > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > > > > > *nf, struct
> > > > > > > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > > > > > > =C2=A0 int decrement =3D 1;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > =C2=A0 /* If we raced with someone else
> > > > > > > > > > > > > > > > > unhashing,
> > > > > > > > > > > > > > > > > ignore
> > > > > > > > > > > > > > > > > it
> > > > > > > > > > > > > > > > > */
> > > > > > > > > > > > > > > > > - if (!nfsd_file_unhash(nf))
> > > > > > > > > > > > > > > > > + if (!test_bit(NFSD_FILE_HASHED,
> > > > > > > > > > > > > > > > > &nf-
> > > > > > > > > > > > > > > > > > nf_flags))
> > > > > > > > > > > > > > > > > =C2=A0 return;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > =C2=A0 /* If we can't get a reference,
> > > > > > > > > > > > > > > > > ignore it
> > > > > > > > > > > > > > > > > */
> > > > > > > > > > > > > > > > > @@ -590,6 +601,7 @@
> > > > > > > > > > > > > > > > > nfsd_file_cond_queue(struct
> > > > > > > > > > > > > > > > > nfsd_file
> > > > > > > > > > > > > > > > > *nf, struct
> > > > > > > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > > > > > > =C2=A0 /* If refcount goes to 0, then put
> > > > > > > > > > > > > > > > > on the
> > > > > > > > > > > > > > > > > dispose
> > > > > > > > > > > > > > > > > list
> > > > > > > > > > > > > > > > > */
> > > > > > > > > > > > > > > > > =C2=A0 if
> > > > > > > > > > > > > > > > > (refcount_sub_and_test(decrement,
> > > > > > > > > > > > > > > > > &nf-
> > > > > > > > > > > > > > > > > > nf_ref))
> > > > > > > > > > > > > > > > > {
> > > > > > > > > > > > > > > > > =C2=A0 list_add(&nf->nf_lru, dispose);
> > > > > > > > > > > > > > > > > + nfsd_file_unhash(nf);
> > > > > > > > > > > > > > > > > =C2=A0 trace_nfsd_file_closing(nf);
> > > > > > > > > > > > > > > > > =C2=A0 }
> > > > > > > > > > > > > > > > > =C2=A0}
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Please kindly review the patch and
> > > > > > > > > > > > > > > > > let me
> > > > > > > > > > > > > > > > > know if it
> > > > > > > > > > > > > > > > > makes sense.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > -Youzhong
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > > Chuck Lever
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > --
> > > > > > > > > > > > > > Jeff Layton <jlayton@poochiereds.net>
> > > > > > > > > > > >=20
> > > > > > > > > > > > --
> > > > > > > > > > > > Jeff Layton <jlayton@poochiereds.net>
> > > > > > > > > > > >=20
> > > > > > > > > > > > --
> > > > > > > > > > > > Jeff Layton <jlayton@kernel.org>
> > > > > > > > > >=20
> > > > > > > > > > --
> > > > > > > > > > Jeff Layton <jlayton@kernel.org>
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > --
> > > > > > > > Jeff Layton <jlayton@kernel.org>
> > > > > >=20
> > > > > > --
> > > > > > Jeff Layton <jlayton@kernel.org>
> > > >=20
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> > >=20
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

