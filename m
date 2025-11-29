Return-Path: <linux-nfs+bounces-16791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A395EC93906
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 08:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 075D7347233
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC32144CF;
	Sat, 29 Nov 2025 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlpGW/uE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2991391
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764403008; cv=none; b=igL+oeDqPXhkySmw9gOFf1RAF3+5/ipkaufeXAHFX8A/g5DeJESE6WZCvURoQ55PGHDixtSKdebcH32QS7mrXAdLzSI8oA5M/NMvcR78BFuqgodeSdZDRjPH15V0Tf6z9l3LI19BWkCfW4yarWoanbLueTkm3lVz+W89ZhDKY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764403008; c=relaxed/simple;
	bh=nS75EqJqjLTfmBREdDj+8KZdBxUq17m/xehJOur+DTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F9dOGd9WNAytKWDUHE27Yn1hly3qVAg0vZIAu1n/YclzP6kMUsPHWBAuoGVyULLu2uZoH2np5jgjP+LiFT3ECVmuN4/heQ6QVd5hUV/CcD0pug0po6kkPI0olPPvxb2wtP+Ewu3KrS7owdrXxnfh1L42PNhCEqBBxN6G/ehrBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlpGW/uE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b73a9592fb8so674858566b.1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 23:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764403005; x=1765007805; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS75EqJqjLTfmBREdDj+8KZdBxUq17m/xehJOur+DTs=;
        b=WlpGW/uEexA3qWS3NauwbdbVK0ORUg8cIg2FPdOtqqqOT1olqbiV7sgxX7CJazUyr7
         6Bc4YPSvq8hAfAV0xoeTo7mp8NFxrBtCdBoOsNPrOeByfgef09Si5eVYp3T0DKodczhO
         rE7d8ZQNAxPqkEUQ4fxXz05/W6q/D7sVgLCA9v1z21FPC1cabi6GSGpRgMob3J1ZhjYO
         HCrO3o0opVEhyyVPVjlmyE0yhvKkUfRdQ3ZJLD6B3OvG2HYgslMHRG1q2TyaGJPA4e6v
         pxOPTvgz97pTjTMP2Cnx0OTstFZaAJoLygr2Y4HqGxorW753gr1tLXh8raReg5n2v80d
         gE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764403005; x=1765007805;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nS75EqJqjLTfmBREdDj+8KZdBxUq17m/xehJOur+DTs=;
        b=k8YCcvY5mz+Qs8PHPLeRzePbVMAaVbfP4u2aIKB4tvDva+ILLzY0UFF0hWp2DONgoR
         97AFNlc4UMWnUAlxHKj9sQDn4GN7e5CF59orpjxac2dV6cDsiS3+/r45JAdCLlQoYU4d
         VEC/bPNWUq+C86xVsEs88PrCzWIEGj4yT8pbDncseCox4zPvHwhICU0bb71TcATQhKCI
         zYj7nQ5NeEDz+rTCKhaSoHOj8fYMPeRtou7+qCz+M9J+NX0TD9uHcJRS+Y+UFMV5zMbQ
         yUcISerHnhUwX7c70g8/qRc+RDUmOhxDfQKS6ZgjgO4BFXZoeFuiLQ1NrRffkteviQkY
         q9tQ==
X-Gm-Message-State: AOJu0YwmtoYU10WudEbL7CeXQ7sDw8GadT0Z/Y2c5l9zFFBT8uns/bff
	69d/asEKMyjNRWCAQwr41/xCeZihT8JgDhTKeUl6pwI8npoxgbElbH2bXWVgmDfXZoxjRHES39L
	8AdLEgP05GFkezT78sgrhv0SVMBFFfC+BnJsW
X-Gm-Gg: ASbGncuYUOOg2s7uBVY1jdXk0isq89DGS0ZpTzuT6lS5x4x5SFdE9A4daa//ym0wy54
	LhdjTOHT3Y98g6Y8rFcG625tH5TgSFPU+idpQWSMJQyPBCYARyBEmCcYXMykpDb38HjUVMK+zcJ
	FXdQag41FDp+yBO8LYrWguE+m0mkxSZcKDUmQ7zBPvhITs2g1aks/x4UYuoWaglGft1AQ0m8Upb
	IIS1tnGuZjuOH87EBkYSl/Z8tmHZsDaC9r1nEB1OTKPVtXsZzz0MSprv+VXh5p6srk7WdySBMlz
	Ul03DfZreoaASCB3quI2mezjlA==
X-Google-Smtp-Source: AGHT+IF4jKn4MQjEhMtCvVVrparVg9fN4wZqaqt0G+6HowoTFKj7KqqllNEJaNiORndR5prsmAXMdy9bV0adaIf1Wqk=
X-Received: by 2002:a17:907:3d4f:b0:b77:1427:bb5e with SMTP id
 a640c23a62f3a-b771427bbc2mr438107666b.1.1764403004573; Fri, 28 Nov 2025
 23:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org> <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net> <CA+1jF5o5tiYfvqPKnf7_teMNOnOwig38epUywfsFLXsXVm=NmQ@mail.gmail.com>
 <49f3ae79-bbe1-470c-a247-68c942fc2f7d@app.fastmail.com>
In-Reply-To: <49f3ae79-bbe1-470c-a247-68c942fc2f7d@app.fastmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sat, 29 Nov 2025 08:55:00 +0100
X-Gm-Features: AWmQ_bks7cvOY9mX8G0MKWDSKnxGhYKvq4ESH7OrBI-AsQtvWpo7NhNXSDwMUXI
Message-ID: <CA+1jF5pSBNUK7GBMcRqzfOB=NfWuVOQs8bxWsTV4_qxb18_3mA@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:44=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Thu, Nov 27, 2025, at 4:12 PM, Aur=C3=A9lien Couderc wrote:
> > On Sun, Nov 23, 2025 at 4:46=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aur=C3=A9lien Couderc wrote:
> >> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org>=
 wrote:
> >> > >
> >> > > From: Chuck Lever <chuck.lever@oracle.com>
> >> > >
> >> > > An NFSv4 client that sets an ACL with a named principal during fil=
e
> >> > > creation retrieves the ACL afterwards, and finds that it is only a
> >> > > default ACL (based on the mode bits) and not the ACL that was
> >> > > requested during file creation. This violates RFC 8881 section
> >> > > 6.4.1.3: "the ACL attribute is set as given".
> >> > >
> >> > > The issue occurs in nfsd_create_setattr(), which calls
> >> > > nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> >> > > However, nfsd_attrs_valid() checks only for iattr changes and
> >> > > security labels, but not POSIX ACLs. When only an ACL is present,
> >> > > the function returns false, nfsd_setattr() is skipped, and the
> >> > > POSIX ACL is never applied to the inode.
> >> > >
> >> > > Subsequently, when the client retrieves the ACL, the server finds
> >> > > no POSIX ACL on the inode and returns one generated from the file'=
s
> >> > > mode bits rather than returning the originally-specified ACL.
> >> > >
> >> > > Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com=
>
> >> > > Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> >> > > Cc: Roland Mainz <roland.mainz@nrubsig.org>
> >> > > X-Cc: stable@vger.kernel.org
> >> > > Signed-off-by: Chuck Lever <cel@kernel.org>
> >> >
> >> > As said the patch works, but are there any tests in the Linux NFS
> >> > testsuite which cover ACLs with multiple users and groups, at OPEN a=
nd
> >> > SETATTR time?
> >>
> >> I developed several new pynfs [1] tests while troubleshooting this
> >> issue. I'll post them soon.
> >
> > Thank you
> >
> > My point however was if pynfs can take a list of users@domain,
> > groups@domain as input parameters, which are then used for
> > FATTR4_OWNER, FATTR4_OWNER_GROUP, FATTR4_ACL and FATTR4_DACL tests.
>
> pynfs tests are not parametrized, but we can choose specific
> combinations of arguments to exercise, and then add a new test
> for each of those cases.

OK. But this is a SEVERE and gaping black hole in the test coverage,
because it prevents pynfs from properly testing FATTR4_OWNER,
FATTR4_OWNER_GROUP, FATTR4_ACL and FATTR4_DACL.

I think there should be parameters like that, and defaults such as
pynfsuser1, pynfsuser2, pynfsgroup1 and pynfsgroup2

>
>
> > Some of the ACL issues only happen for specific ACL combinations, thus
> > such two lists with parameter input would be useful.
>
> I have additional pynfs tests which aren't quite ready yet that
> exercise the relationship between OWNER@, GROUP@, and named
> principals.
>
> There are some complications with the NFSv4 <-> POSIX translation
> adding a DENY ACE when it doesn't recognize that a named principal
> is the same as OWNER@ or GROUP@. In that specific case a user can
> set an ACL that locks the file owner out of the file unintentionally.

Shouldn't OWNER@, GROUP@ priorise going into the uid and gid fields?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

