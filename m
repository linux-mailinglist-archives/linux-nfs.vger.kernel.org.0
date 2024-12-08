Return-Path: <linux-nfs+bounces-8423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A856C9E841C
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 08:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5354F2815A4
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 07:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137B6F06A;
	Sun,  8 Dec 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRhLn9CZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958C1E48A
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733642386; cv=none; b=QsFtdRpq8qxS8U5Wnnypey+hedyaxOQjkGDd21wB+EsDGt0QNiY67ijtE//lMAtUeL7ccZ4vxMIh9dulzr6za3ZVsFkjfhVluiCUPxnFgFkgv+0WHZJtixUOQxzqfM/Fh015fTfFCpEiEsnfDltJW7fZYasuDJK1uF+idrdbemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733642386; c=relaxed/simple;
	bh=UP3dRPBXC6jIYIzz+uvTppYEs+fikwxm/gd4MqXav7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Cmp9oq/fJIPKs1P7Tw0WD+++sZgr6uJ1gPuGLDtvfPyHvjzY1wc0cf/QBdSStLrmY3zwMO70dlu6gxXIkfh0l6ZBPqiUzru5MROzxKFdf97Pt7ShcAbpsVu5Edj/NRMnzwxQa4OoSmAJxnFh7x59ysNlHL5B/FXFvt0sZ7reYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRhLn9CZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso33620031fa.2
        for <linux-nfs@vger.kernel.org>; Sat, 07 Dec 2024 23:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733642382; x=1734247182; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP3dRPBXC6jIYIzz+uvTppYEs+fikwxm/gd4MqXav7g=;
        b=YRhLn9CZhCFy/sWQ2eKzRnheT1758EoYg2IftK9E3n7w4OSARMExRknZ/IUC7tGNQj
         6HWcdrFJp0GdUlGCCdC9fTkJeaCaEk+NFDUp61/yszTutCfTMKMdLCSU3ram1HuhRPHO
         xnWn3sapb0c6MCPBVUeQ1BWtkIUf3wGPSyVnuJytSNRSkEKIOo+7b9LdMi3nGM5b3I/i
         8pWtSLDqgmxVAIH0E6mWE3Q7glqNRIBV1OkTQ0s3tNal3XNtVY+l/meOrkC4GHUdBFKD
         EQ3EGK15m4yT3gfIvvNZG5M0Zyj1UwC9KP8ALpIuQzHWzHLOnjglRf/6P3Fkk2zMNP3U
         aiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733642382; x=1734247182;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UP3dRPBXC6jIYIzz+uvTppYEs+fikwxm/gd4MqXav7g=;
        b=QlPAjLVlpqsjCMh0aopCl3mkQ5heVMitOjEuNvl2XvL6P6pp0NR8ul6H8r5ilPCcJw
         DsqHtY0/dhLZcTT6SLW/2wnpHhNTuqCLIcrOWQalCGKPWGbXwVd55PaAvZM5fzR2UoXj
         97nRfy21pXVQtWDa3RkYOgzRxyzYHaAD+XWTq21M7COD9InYYqM/CXDovUsPdKLbISWc
         XxACIwYbk6lmurdJzBdwdEZSE7UHg/VHJmqz9GTlSPqg+r46QLBJ/ziga6dQ79frLVD0
         gnPtv64mTjIHCMM4iuwRabu2MgH+e9JiVKj5M7kgCv+TKCVjk/G/I+UJv/VoLNstqwdm
         isQA==
X-Gm-Message-State: AOJu0Yy1vnDe+cSayLUzuL+V0v2G1i9hIfaWnWBKOhUlS9V3xQXxw1iF
	CoZo7ny58WWngR9YDaqlJTpAze8++PbGeYfxhMbUsnZgFk3SR5DIeXjb+fBjLIH1a7g5jWXS8bv
	+1401xh4kPkQmnhi5WnfUajDCMI9yQ7wZ42g=
X-Gm-Gg: ASbGnct//TQWE+vT1N4MWiSr3n0c6fADlODXXXo0PUtl5YR3YHUGlSC9XvDWkf6ZTri
	JOTNQdlYfsdKOEjq/77TDUBdF3mGef2w=
X-Google-Smtp-Source: AGHT+IHshWngwVO8IoU46iDPALCBHAmRI+FtNz0SLz/n7Qi6vcr2JWI/cyPp0GNGMb5kGwHqE5/uajm/Er/rSPzwH9s=
X-Received: by 2002:a05:6512:3e06:b0:53e:ca48:776e with SMTP id
 2adb3069b0e04-53eca489015mr1049544e87.36.1733642381852; Sat, 07 Dec 2024
 23:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
In-Reply-To: <CAKAoaQk-T=yBU2jJ=E_WcSmbPPkKk78N_tkTacL7Nu=udUDNFg@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 8 Dec 2024 08:19:00 +0100
Message-ID: <CALXu0UdDBHEizGi0UZ=SXb4Mk+-oOO6M5qM__YATLbTf2wxXjg@mail.gmail.com>
Subject: Re: [patch v2] mount.nfs: Add support for nfs://-URLs ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 22:55, Roland Mainz <roland.mainz@nrubsig.org> wrote:
>
> Hi!
>
> ----
>
> Below (also attached as
> "0001-mount.nfs4-Add-support-for-nfs-URLs_v2.patch" and available at
> https://nrubsig.kpaste.net/e8c5cb) is version 2 of the patch which
> adds support for nfs://-URLs in mount.nfs4, as alternative to the
> traditional hostname:/path+-o port=3D<tcp-port> notation.
>
> * Main advantages are:
> - Single-line notation with the familiar URL syntax, which includes
> hostname, path *AND* TCP port number (last one is a common generator
> of *PAIN* with ISPs) in ONE string
> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
> Japanese, ...) characters, which is typically a big problem if you try
> to transfer such mount point information across email/chat/clipboard
> etc., which tends to mangle such characters to death (e.g.
> transliteration, adding of ZWSP or just '?').
> - URL parameters are supported, providing support for future extensions
>
> * Notes:
> - Similar support for nfs://-URLs exists in other NFSv4.*
> implementations, including Illumos, Windows ms-nfs41-client,
> sahlberg/libnfs, ...
> - This is NOT about WebNFS, this is only to use an URL representation
> to make the life of admins a LOT easier
> - Only absolute paths are supported
> - This feature will not be provided for NFSv3
>
> * Patch version history:
> - v2:
> Added |setlocale()| for libc versions which need it
> - v1:
> Initial patch
>
> ---- snip ----
> From 767e1aa096bacd4dd600d46ccaaefbc47ba863bf Mon Sep 17 00:00:00 2001
> From: Roland Mainz <roland.mainz@nrubsig.org>
> Date: Fri, 6 Dec 2024 15:22:23 +0100
> Subject: [PATCH] mount.nfs4: Add support for nfs://-URLs

Looks good to me.

Tested with French, including circonflexe, tr=C3=A9ma, and EURO symbol ('=
=E2=82=AC')

For English-speaking users, please read
https://www.alt-codes.net/french_alt_codes/
https://en.wikipedia.org/wiki/Circumflex_in_French
https://en.wikipedia.org/wiki/French_orthography

Reviewed-by: Cedric Blancher <cedric.blancher@gmail.com>

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

