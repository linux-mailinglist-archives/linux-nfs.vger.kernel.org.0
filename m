Return-Path: <linux-nfs+bounces-16792-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BBC93909
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 08:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EEB3A7C4D
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 07:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AF2144CF;
	Sat, 29 Nov 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHEr8SXU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE01391
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764403042; cv=none; b=K7HfPdZrUGO6sQV2zK21fCL34Imy+jTpkXDESDOiO6pTje/GjgrVAaXDIONZ9+fRomuN4M9Yy7EIkdIyYftY09ApMqEMz3PHTUuy726jVM2LJzBjuW5odE2L/xZQdOgO56u7+nTJt0ftHFO6pDPdQPnQa56jdcTE61GjrdCBVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764403042; c=relaxed/simple;
	bh=Xu/bdNRo9NbEnx+4TDdsh8mhr8caTMrrSNZaxKtcY84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Vjhn8MBLlj8otz2JgTAfEAAtNRKw3EzKEo7v++sf9Z9MeLtym6LFA+xFhfSRykM2pt3+P366B34KRGGLL5FoOOorxEtFsqG5Zd9LlLpW6x93SiRTApwaFJIWmQ2YL0Acr8LC1SAm7J/ZeeoEDg2lp2VapsCVUBAwo6roIHTGy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHEr8SXU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso5000173a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 23:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764403039; x=1765007839; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu/bdNRo9NbEnx+4TDdsh8mhr8caTMrrSNZaxKtcY84=;
        b=nHEr8SXU41sn7a59ye1sGzWaOab3+NAao5AwvbxFSgL9g7R98v7DaX22plr72OsZue
         /hzZLqVpFK0o0TgQHrIkNRGkDIonTzrliQer6dkOtzGCfyZAUNtJtlGLC2TDqf3KNXlO
         K06mn4c8xhcL2sSo3d6NrSSswp1sInECmynG11MHXHeH6lbYmQcBJntmx7J2TJe6iAa0
         +M5NKBpsVGNbyBU1OeuEpO1uhSXV3liwYAuiM8vOwieFokDqWMXfFTBl7d1eCRb0WhMn
         1diQgyWf4k8/E1hZSROWbhHt+viWuz6j635QT+pcNQcmAjx9GqyxPIhuM/zO2MSfWKUX
         rZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764403039; x=1765007839;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xu/bdNRo9NbEnx+4TDdsh8mhr8caTMrrSNZaxKtcY84=;
        b=TJinNcQbaI5xGHFiO29eUf31YPpeo6ZrWa9QG8wr1pNp1Jc+x2cY0vD3QaZwJaYjvR
         24y1hwwTBUHsSHIOOqxIKvdP55jrAypu4APJgoh7u/QAsagVpJ/8hLxiOYdxIZPd9606
         d2qWDECuQ8aUKfDb4dzL5gFHJfURdHaGYGA2Hzre1/kJP8V7V0mS90e8tcvp1Q0pwrSt
         1HLZdBvB16X2/AutGU18RsVGAyfMAujfLrs5el25PvB3ULPHS5WKXlVDQwD4PdHoDH5g
         ouVaFOrN0UaD2XDGsJYi4C1Noh7hZa46bdVAdV1TR7wLCii0crPfXihXILaBshRJa891
         wP0Q==
X-Gm-Message-State: AOJu0YxCyq6h5whaSc903cXXrnMQFxluQPCeswtx+nV9jkeY0Bb9uZAx
	hc50nwZxsbIXGXBh2XlXapnv60Y42/3/FVWU8tBk90NgvZ3qiYVM9UWXBqjM/ibML4b1QDeW4Ur
	A6aJgyug7luDuz844CYPosrUKSj2krXx3w1Gz
X-Gm-Gg: ASbGncvS32cgiazTlDc+2CUy5gX3J5TtzB9FzJOUm2I/LSLdtB6UwhvyJTITnHyjR0i
	JI5MEVA7EA/RtEMbCWC3tx6+IUR4fevYATbJjoIz6ODW02nnN92U69epNPXs9Qr8G7W8o59IewU
	KxC+gGC+D6kYtnqhdBr/eQMV2C1TrbaWdgS3ak9I3Abng3x0sEqk789ZRr6egoj3zIzDZ4XvkyO
	j1DMlcPORFhGp2U8fwcu+wAcTh2xGa+TZP8CvOHYZSeqcU7/uPjwdamZzohWBLnai1A/oogs+6S
	HP+OMHbHq2x0a2guHnQb3lkDxA==
X-Google-Smtp-Source: AGHT+IFeLlhvgtvWNd+9KKHaB7JrecvLToSOT/Wwbsxj2707GRE7PmVosRCDseX71/wPzi73QtvlRoYTVVTt49ttzkc=
X-Received: by 2002:a05:6402:23ca:b0:636:2699:3812 with SMTP id
 4fb4d7f45d1cf-64554817594mr26105831a12.0.1764403039131; Fri, 28 Nov 2025
 23:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org>
In-Reply-To: <20251119005119.5147-1-cel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sat, 29 Nov 2025 08:57:00 +0100
X-Gm-Features: AWmQ_bmk469P8rnzmu_hr0Q9K3glg8l6CbAL9QmOqBhQI-3UazPm9oWf9BSqmQo
Message-ID: <CA+1jF5pTHTh1o1S92s1JVF4Lvx5XT7+tccu=woDSbDUPRsubXA@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> An NFSv4 client that sets an ACL with a named principal during file
> creation retrieves the ACL afterwards, and finds that it is only a
> default ACL (based on the mode bits) and not the ACL that was
> requested during file creation. This violates RFC 8881 section
> 6.4.1.3: "the ACL attribute is set as given".
>
> The issue occurs in nfsd_create_setattr(), which calls
> nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> However, nfsd_attrs_valid() checks only for iattr changes and
> security labels, but not POSIX ACLs. When only an ACL is present,
> the function returns false, nfsd_setattr() is skipped, and the
> POSIX ACL is never applied to the inode.
>
> Subsequently, when the client retrieves the ACL, the server finds
> no POSIX ACL on the inode and returns one generated from the file's
> mode bits rather than returning the originally-specified ACL.
>
> Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> Cc: Roland Mainz <roland.mainz@nrubsig.org>
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <cel@kernel.org>

stable@vger.kernel.org is in CC. When will this patch land in the
Linux 6.6 and 5.10 STABLE branches?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

