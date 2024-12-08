Return-Path: <linux-nfs+bounces-8420-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C619C9E8327
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 03:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7268164ED0
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B152749C;
	Sun,  8 Dec 2024 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jor3mWqo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330F36B
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625413; cv=none; b=ddYkJAvE71zF8eGrSCSZ9NrWVcAmxPpNwnduh1m6/0f8MNS3N++2hcWjkryspc4m2xWmjRiMu0hJ8a6iiIQkiwv2Jn73ebaAh4KoqAjo38MYtbUxg6ztayHY/Ni2FHAq4goAgJ6PE0Pd8kobJVGxh+CJvEvQGVwSW1/VwFdpnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625413; c=relaxed/simple;
	bh=s1l9d//DGea/jbIeUElobpm5xaJx5ayzhruC1IKI8pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bUUjsYhKAOhSRBcH1+E7r3/ZrFy1imd3rDLpdjIK2y5sYlw3WhNAgNOIyMosblFcqtB1tqSR9CqXh/WOAaNQZKirvM5jFtJikAl7A/i6NNUOvH396W6uZZYmTmrNpWQQ48K89JslRs9b6pHIjxnEBElvpeB93+Mk4SgiFDW1Wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jor3mWqo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so264326066b.0
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2024 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733625409; x=1734230209; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1l9d//DGea/jbIeUElobpm5xaJx5ayzhruC1IKI8pQ=;
        b=Jor3mWqoNAEUYpw12xKs9pYWyfvTigJV/DRV0GViL6rxd56bOjcCAocUBGzzdsp7QY
         A1bJTqlGdiGdtCZF3WsdOf33yvBmPTtT2digBpf+wkGQ6BeOeavEx1ex67y4+oDnjF8F
         LiDWRZ7Kk3i8luU+Atrrv8MKIluOmdkQz5740C1u+Dp3j/c+5FOYJXT2fdGQv9A+Q7AX
         zCpGs3ddpPju9ZDLe6nZXQ6L4Itl5uRarv5pqy3wbhM6LgUYf5QyD3G88mjEUhFOlU+w
         xHr0YdkGspsr31QXipU8rGrLOSFEwqgpAEbqF0X7sLlFqvgUyqBA9jqrXiBXP8c0kQ6x
         0dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733625409; x=1734230209;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1l9d//DGea/jbIeUElobpm5xaJx5ayzhruC1IKI8pQ=;
        b=P9U4DBxu937Ep6ZVAo8dYW7grHI8LZbBblUV7FcwP5aJlVDIDXqroLi0tNdHKJbHka
         TiBqX2kbAJQ4tezSj2oP8sIFGZ6bV/nVzjRQg74ZLNYvtddbo0CJqT9dt5p2Pp6Dgvt/
         bGAC6hUnNVxRsV91t7DUFf3EpDOJZnceFyn5Al5Ulwbzat+WZgrn2yKxN9fwRzIOwC5h
         XyjfQgAHEYoJxEPAAFRGhGO4J5PqtdZ9W7gS9nbr7fyDe9LMEh1aNGyQJsJTtigJDXkk
         qHCaVP2Te8CndOzxZ6qBGmbrdP4BCiUbu/yrU765vCJwesXsNRMceX9F8v8t7n4q3MA2
         ifRQ==
X-Gm-Message-State: AOJu0Yw1QTUx63l5ijynvC6IMw6jK05q3KM1e9+ZIrgaP888Jimn9VRo
	2GazU9f8b9piGoBs3jmH3rJ+9of6/EbDcRKja3b3N6+PAAqRODpdvq6HUVjIHTrehDiwWz/JF8t
	enE8iMPjHC1lC+X1XmxoMFpodR1nD0joq
X-Gm-Gg: ASbGncugZOTXXSVHHsHODjCcPpx0v2VFws2QSbavrAJBOavIxAI0PtJClbNXmtNYZ3s
	zQo4x7re4DJKh+k+EqnsgEc5yp6YxOsF5
X-Google-Smtp-Source: AGHT+IE+d/VH7EP/pvoc/piAJQ51npo4+8c1bXp4ipPNIkvsEdC73EePMEPS3wudVVWjbVPCw21qWcrHJYKm7ycdIA0=
X-Received: by 2002:a17:906:3cb2:b0:aa6:423c:8502 with SMTP id
 a640c23a62f3a-aa6423c885fmr573642766b.60.1733625408843; Sat, 07 Dec 2024
 18:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
 <CALWcw=GHZe4_9BejU8xzNOcMxY42DVChcKysFfYHQns5uH238g@mail.gmail.com> <005d46bf-d017-4419-8f03-8c68cecb1e27@oracle.com>
In-Reply-To: <005d46bf-d017-4419-8f03-8c68cecb1e27@oracle.com>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Sun, 8 Dec 2024 03:36:12 +0100
Message-ID: <CALWcw=HDeNOhtJaT2p+652hwBc_L5gTXbzO7Ls-6H+_=58scPw@mail.gmail.com>
Subject: Re: [patch v2] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 6:49=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com>=
 wrote:
>
> On 12/7/24 12:14 PM, Takeshi Nishimura wrote:
> > On Fri, Dec 6, 2024 at 10:55=E2=80=AFPM Roland Mainz <roland.mainz@nrub=
sig.org> wrote:
> >>
> >> Hi!
> >>
> >> ----
> >>
> >> Below (also attached as
> >> "0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch" and available at
> >> https://nrubsig.kpaste.net/e8c5cb) is version 2 of the patch which
> >> adds support for nfs://-URLs in mount.nfs4, as alternative to the
> >> traditional hostname:/path+-o port=3D<tcp-port> notation.
> >>
> >> * Main advantages are:
> >> - Single-line notation with the familiar URL syntax, which includes
> >> hostname, path *AND* TCP port number (last one is a common generator
> >> of *PAIN* with ISPs) in ONE string
> >> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
> >> Japanese, ...) characters, which is typically a big problem if you try
> >> to transfer such mount point information across email/chat/clipboard
> >> etc., which tends to mangle such characters to death (e.g.
> >> transliteration, adding of ZWSP or just '?').
> >
> > - Server
> > mkdir '/nfsroot11/=E3=82=A2=E3=83=BC=E3=82=AB=E3=82=A4=E3=83=96'
> > - Convert path at https://www.urlencoder.org/
> > '/nfsroot11/=E3=82=A2=E3=83=BC=E3=82=AB=E3=82=A4=E3=83=96' ---->
> > '/nfsroot11/%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E3%83%96'
> > - Client
> > mount.nfs -o rw
> > 'nfs://133.1.138.101//nfsroot11//%E3%82%A2%E3%83%BC%E3%82%AB%E3%82%A4%E=
3%83%96'
> > /mnt
> >
> > Works - (=E2=97=95=E2=80=BF=E2=97=95) - =E7=B4=A0=E6=99=B4=E3=82=89=E3=
=81=97=E3=81=84
> >
> > @Roland Mainz Thank you!!
> >
> >> - URL parameters are supported, providing support for future extension=
s
> >> * Notes:
> >> - Similar support for nfs://-URLs exists in other NFSv4.*
> >> implementations, including Illumos, Windows ms-nfs41-client,
> >> sahlberg/libnfs, ...
> >> - This is NOT about WebNFS, this is only to use an URL representation
> >> to make the life of admins a LOT easier
> >> - Only absolute paths are supported
> >> - This feature will not be provided for NFSv3
> >
> > NFSv3 does not do Unicode, so this is not going to work anyway
>
> There are two purposes for adding an NFS URL mechanism to mount.nfs:
> one is having a common way to express a server hostname and export
> path; the other is to add support for percent escape.
>
> We still should consider NFS URLs on NFSv3 with the code points
> that NFSv3 servers can support.

What "code points"? NFSv3 does not use UTF-8. NFSv2/v3 use sequences
of bytes and a length, and the filename encoding is up to the client
and server to set.
There is no protocol to figure that out, and the choices are plentiful, e.g=
.
az_AZ.KOI8-C
be_BY.CP1251
bg_BG.CP1251
bg_BG.KOI8-R
fa_IR.ISIRI-3342
he_IL.CP1255
hi_IN.ISCII-DEV
iu_CA.NUNACOM-8
ja_JP.eucJP
ja_JP.JIS7
ja_JP.SJIS
ka_GE.GEORGIAN-ACADEMY
ka_GE.GEORGIAN-PS
ko_KR.eucKR
lo_LA.IBM-CP1133
lo_LA.MULELAO-1
mk_MK.CP1251
ru_RU.CP1251
ru_RU.KOI8-R
ru_UA.CP1251
ru_UA.KOI8-U
ta_IN.TSCII-0
tg_TJ.KOI8-C
th_TH.TIS620
tt_RU.KOI8-C
tt_RU.TATAR-CYR
uk_UA.CP1251
uk_UA.KOI8-U
ur_PK.CP1256
vi_VN.TCVN
vi_VN.VISCII
yi_US.CP1255
zh_CN.eucCN
zh_CN.gb18030
zh_CN.gb2312
zh_CN.gbk
zh_HK.big5
zh_HK.big5hkscs
zh_TW.big5
zh_TW.eucTW
...

So, which one will you choose? You do have to do that manually, by
hand, at mountall time you just don't have that info.

And it's even WORSE than you can imagine - many of the Asian encodings
are INCOMPATIBLE (!!!) to Unicode, because the morons at the Unicode
consortium did the cursed "Han unifications". This "unification" maps
similar looking characters from different languages(!!) into a single
Unicode code point.
For CJV users it feels like forcing Americans to spell "New York" as
"NEW Y=E5=8D=90RK", because of course uppercase and lowercase looks similar=
,
and "O" can be substituted with the similar looking "=E5=8D=90". That's wha=
t
the Unicode consortium did to my language.

So, you just lose data if you try to do a mapping of older GBK, JIS,
... encodings to Unicode. For filenames encoded in Unicode codepoints,
e.g. a URL (which uses UTF-8) there is NO WAY BACK to GBK, JIS ...
imagine sort of lossy JPEG compression for filenames, you never get
the original back.

So forget that concept that URLs and NFSv3 will play along - that only
works for English speaking users on a whiteboard, but not for Asian
users in real life.

For NFSv4 it works, because the protocol uses - for better or worse -
UTF-8 for everything, and fortunately doesn't even attempt to do case
folding.
So using an URL for NFSv4/4.1/4.2 is safe.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

