Return-Path: <linux-nfs+bounces-16769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61268C902DD
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14D1F34022A
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Nov 2025 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2A3195EF;
	Thu, 27 Nov 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej40D2G9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30D31DD96
	for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277997; cv=none; b=N/UoEh2ydoo5QvLmkf8FyzdYn1X8Une8qi8Dk2VaAzwPLgfczz+h3E86ymat2DVb4uOllAENuep5TJ8MRvs7wC3ryeQ7AG/KHlOOX1+7AyC6VOTdrH1R7NrzNoIo3KYBTShyUdKk3uom3T8ZzWde7ZmKKfr4nZVU+P6Ue4hvegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277997; c=relaxed/simple;
	bh=3KeKJpB2bti7v9gQYXl0h2I867lfql7RNqqfq54cKqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=POyy9tdIJLONKhN9E+HBW6A9Pftwg8Z/1aePGv78ssf+/5I/RtSjfDkSSPijynKzj7AyZE6ckMR4SEEftoZGftCcSzK4xLXNybIawUQej4fGZB1/vTJ9+Xs3EY0/zR8M88apzkH/mO/nbLjdYhAnUKGmezAd1LK4hdjKxjgF8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej40D2G9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso1927135a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764277994; x=1764882794; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KeKJpB2bti7v9gQYXl0h2I867lfql7RNqqfq54cKqk=;
        b=Ej40D2G9GUSbCIYDhLzAx301igt+P7IKQzG+BYuvEeucNImfVlZhemdBRUJGC3YfiZ
         6G/qPU7F7p1iHVqRdo9fkRq2ETJ36HqWRKo+EbyNfJzOnS2ObVvw1PsS5+TxsVuHVFiA
         KOBszWluFRu9NabpBGVQKHg/PiB2yFqU2Rpq7diXAgH16ts/UA2O95tEnS3j5kLHuvv2
         mAdjqxd+R5bfTrdMCx0WCXkuzwEC1msuF1E05sQ6NSIxyQkt+Oi2svb3p+21avMU/Lc3
         SrYZ1gENhYf2bmCf72biAeZsHtn/CasS2BFdscFXT15duZzYJvewMNestALpOOOEZQFt
         un9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764277994; x=1764882794;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KeKJpB2bti7v9gQYXl0h2I867lfql7RNqqfq54cKqk=;
        b=P4uGFrfDQyHKrbAzffL0e6WMFfQo8SuK+fP2P9CFNv0s0yEcf/6sTm7Sy8ZVwvLDxs
         AXCZ8ML9NAGQbVel117ZkMHnDYPYCPDDuAavCjC1h1ugaQOYIR8wUxBZQ8W2FahU80Dd
         NfoirFqcnHOAs3GtCgGnP6WveH/JvennQk8xjcVsa4UJUix76y5iu5QLuvN2bv7duMdv
         Tx5JbFAjKGlsOnYgel05HbY8GFVcU5GAaGrYhS/nczHmysA8udThl0VtNgr8lQSjWFUH
         n4/HquXgiEy/H+tFyBwhQIo1kvtIMgiVmSDG3eBV5A/ztMD+oQIslnm9h3wtPbvXBZls
         WpAQ==
X-Gm-Message-State: AOJu0YwZIqDEud8hckraF5NCZiz7CQ+Q4gGb/F2R6GBafEN/rZk1Jr6m
	ECKtrKtFkeK1XhE9NJPlQSUF21p5ZKvrkFwoa2bUoHVo7wHH+teACWFh3ZSx/BfL9ci87g2lj69
	pxfeZc5B7S6B5PwLqZHKscWMiM4ReCXIBi6Yu
X-Gm-Gg: ASbGncsf6iRbNOhn9ilxVvV3aHyj3ORY/XssQr+0wCp7Nf/VzdYXqmrH2UNGnwdOC+5
	eSIe7E385GKKdoqz1cYd4/Y7Dl2fWdLejdlLoIfupOUig7MU+5fwBWHLorzPjVJZ0DClFmIaysK
	OdggBxIMW80xrz8bpkn3NLI1ClJaVl4BNlEect7oGfZkTeH6RSgbZ1zKmIK0aZ/HLWarUfH2Jv8
	bQOOizODiVPzARsIOub3cYiMpUv0uzhFBm2h0hYwrmlV17Tw1grnQDoCUxNrEp7dvpXruJlElN6
	yVdsz1mlYpFJB8f1RGtdk/nwUg==
X-Google-Smtp-Source: AGHT+IE2RF0oQDT+3VP13hIRczHDHgxwVYrrqBYjeV0VTB+MAtkLTFrChG3atIKiVP2tH+cnm7H8egJahcqjUhKqCoU=
X-Received: by 2002:a05:6402:2816:b0:640:93b2:fd1e with SMTP id
 4fb4d7f45d1cf-64555cd8cc4mr23306003a12.17.1764277993906; Thu, 27 Nov 2025
 13:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119005119.5147-1-cel@kernel.org> <CA+1jF5pF+K3s9N4p5mc4cxyzg=r5ow5R_T31Eab=DOW5AjBG-g@mail.gmail.com>
 <aSMsb350kJgqysbz@morisot.1015granger.net>
In-Reply-To: <aSMsb350kJgqysbz@morisot.1015granger.net>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Thu, 27 Nov 2025 22:12:37 +0100
X-Gm-Features: AWmQ_blFhlQY-ZV8Xa30GRPAdjIWMbSQWGVkDdHd0E2uWw49YCOP2xN1EjXoHQY
Message-ID: <CA+1jF5o5tiYfvqPKnf7_teMNOnOwig38epUywfsFLXsXVm=NmQ@mail.gmail.com>
Subject: Re: [PATCH v1] NFSD: NFSv4 file creation neglects setting ACL
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 4:46=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Sun, Nov 23, 2025 at 03:54:48PM +0100, Aur=C3=A9lien Couderc wrote:
> > On Wed, Nov 19, 2025 at 1:51=E2=80=AFAM Chuck Lever <cel@kernel.org> wr=
ote:
> > >
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >
> > > An NFSv4 client that sets an ACL with a named principal during file
> > > creation retrieves the ACL afterwards, and finds that it is only a
> > > default ACL (based on the mode bits) and not the ACL that was
> > > requested during file creation. This violates RFC 8881 section
> > > 6.4.1.3: "the ACL attribute is set as given".
> > >
> > > The issue occurs in nfsd_create_setattr(), which calls
> > > nfsd_attrs_valid() to determine whether to call nfsd_setattr().
> > > However, nfsd_attrs_valid() checks only for iattr changes and
> > > security labels, but not POSIX ACLs. When only an ACL is present,
> > > the function returns false, nfsd_setattr() is skipped, and the
> > > POSIX ACL is never applied to the inode.
> > >
> > > Subsequently, when the client retrieves the ACL, the server finds
> > > no POSIX ACL on the inode and returns one generated from the file's
> > > mode bits rather than returning the originally-specified ACL.
> > >
> > > Reported-by: Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
> > > Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> > > Cc: Roland Mainz <roland.mainz@nrubsig.org>
> > > X-Cc: stable@vger.kernel.org
> > > Signed-off-by: Chuck Lever <cel@kernel.org>
> >
> > As said the patch works, but are there any tests in the Linux NFS
> > testsuite which cover ACLs with multiple users and groups, at OPEN and
> > SETATTR time?
>
> I developed several new pynfs [1] tests while troubleshooting this
> issue. I'll post them soon.

Thank you

My point however was if pynfs can take a list of users@domain,
groups@domain as input parameters, which are then used for
FATTR4_OWNER, FATTR4_OWNER_GROUP, FATTR4_ACL and FATTR4_DACL tests.

Some of the ACL issues only happen for specific ACL combinations, thus
such two lists with parameter input would be useful.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

