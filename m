Return-Path: <linux-nfs+bounces-1579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F384171A
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 00:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA891F21B80
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514732C6B0;
	Mon, 29 Jan 2024 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8GQEtVN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8251C31
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571939; cv=none; b=hoN3dePXIYcK7BWS3hObc5sMO311lCRuo4KC86VygYCjBTKMaBEHnZxhGne83p6NqCjBE7LUVCGX6/8/tOO8vLIxLu4+DOI6QEOfIFUbXd3hLpTT/JO32W+DI2/PXBqaAjsatTWISOpSY2BSNOfxPW9Dl2pinQJnBH81Wiz3N6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571939; c=relaxed/simple;
	bh=66MNbyaDsdfRCnPtoF8smCkun9ORFjCymN6WisGCgXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXTdKuM6KivVIgf8GV0NWsQb4/+e3DIv6DcdQL44vd1ETr+TdJ1x5tT1JOVlWa+kbRdFt8Zv02wFv2hxQ5Zv9Bv0gmReZZpwvkvOaX8C1D9O0gk7s2pTGbC9h5QCdATCWxjiYWs4miTPbireaU3TWb/CKRjOcvhdR8k14kfPahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8GQEtVN; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2144c37f3d3so1198578fac.0
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 15:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706571936; x=1707176736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66MNbyaDsdfRCnPtoF8smCkun9ORFjCymN6WisGCgXk=;
        b=I8GQEtVNyO60ChL2V2PvrQf5AEtguoxfwmN4CtgNd0nIcGEt4teKBUu1CnM+YNp62P
         AForeuYub/yJ5yhPUYiTwcJaQl5F5f+kJaAhVNQrdUqg8sTzkruudcdhx1WWL0tbEeBj
         I4VZtLKOEdQxBXKR628FRnbuxPEnpVm7MGMjrgSPA+vlcf58hmppKDoHDm7a69kbGRv9
         A38/PbnAQlj3Ugt1sCy619CDctrltvsXUs3g0kvL+Oq4RlOwKiTTbBXpLws9xhe+CyR7
         bjWfs6op5medHfIIT1jhz1+jXtIc6lrRlujvTaiDMCcDjys4vmNnSrArWudETURJns3p
         foZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706571936; x=1707176736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66MNbyaDsdfRCnPtoF8smCkun9ORFjCymN6WisGCgXk=;
        b=BegL2javjYu5ykarmYoCQvbs57S0rg+bN19LcQk85TFbn8eAjNr0nPV4HwwqRlNAL/
         EkMU4HXvKaYurdWfkbpwdlVyT76XXQmdqkHT7W6fH4V1yPIht9RcxtFEACgznr5WvQzt
         ixg9Va+gGvagURWiuI+FnigwGfAOhZ+cu/+3UMk+lOOIcbM56e/4/NALddvYM1dNOGHR
         1IsUDB5AqWVYg9rYEJDsAjJc5QtZYJnPb40aFIENtlOrdwZlJslrtJKy87JmdoMPAjx/
         V2hLIc+06jbwVLr0G56rLhrqTXAuGQWNHbkvfVk7kpiafHhpAubv9nJHIPo35DWdq5v0
         K8Sg==
X-Gm-Message-State: AOJu0YxqaLjdQ7Hq6mIwaLNAFVtDPcSbADFAnG41zSk8mNcewzazaov0
	zIpNta+w9ux2fBTaXvB0kKUJzfQ7MI0bjdIuEYQPs+lNiyk5zNaTq1tylkMduQVOCfXRoJUJ/dS
	vE3sxqy6PMHHEUQYyAx5afFAkFsE=
X-Google-Smtp-Source: AGHT+IGpjadiJmkwnOOyspbn7UNYvi/YgNHvKPI4+eEN3dQMeiiOwoaV1wmXrcpabHi1W+NANy/IJ4FG9RDnLl0JfVU=
X-Received: by 2002:a05:6870:9216:b0:214:40d2:fd28 with SMTP id
 e22-20020a056870921600b0021440d2fd28mr3020319oaf.48.1706571935712; Mon, 29
 Jan 2024 15:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com> <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com> <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com> <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
 <CAKAoaQ=FDdkTW2Vh=_Y08DEWZYaJa6tDSYKnFiZCfQ6+PW_5iQ@mail.gmail.com>
 <610FDE39-3094-40EB-B671-F2CA876CA145@oracle.com> <CAKAoaQkdf41emWL-2Uq9_kFjF99Xc7UEK_ur0MmnfFAjJqLM7A@mail.gmail.com>
 <BCB4C051-B76D-4025-A3FB-78B2F2D069BD@oracle.com>
In-Reply-To: <BCB4C051-B76D-4025-A3FB-78B2F2D069BD@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 30 Jan 2024 00:45:24 +0100
Message-ID: <CANH4o6M9UrqJ_T3dneaJjA-674+rRRLpFS7DMo8L1rMXOoFo7g@mail.gmail.com>
Subject: Re: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Roland Mainz <roland.mainz@nrubsig.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Cedric Blancher <cedric.blancher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:51=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
> > On Jan 29, 2024, at 10:07=E2=80=AFAM, Roland Mainz <roland.mainz@nrubsi=
g.org> wrote:
> >
> > On Mon, Jan 29, 2024 at 3:14=E2=80=AFPM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> >>
> >>> On Jan 29, 2024, at 6:44=E2=80=AFAM, Roland Mainz <roland.mainz@nrubs=
ig.org> wrote:
> >>>
> >>> On Mon, Nov 13, 2023 at 2:01=E2=80=AFAM Cedric Blancher
> >>> <cedric.blancher@gmail.com> wrote:
> >>>> On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.co=
m> wrote:
> >>>>>> On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com>=
 wrote:
> >>>>>> On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.lev=
er@oracle.com> wrote:
> >>>>>>>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gma=
il.com> wrote:
> >>> [snip]
> >>>> Yeah, instead of waiting for NetLink you could implement Roland's
> >>>> suggestion, and change "hostname" to "hostport" in your test-based
> >>>> mount protocol, and technically everywhere else, like /proc/mounts a=
nd
> >>>> the /sbin/mount output.
> >>>> So instead of:
> >>>> mount -t nfs -o port=3D4444 10.10.0.10:/backups /var/backups
> >>>> you could use
> >>>> mount -t nfs 10.10.0.10@4444:/backups /var/backups
> >>>>
> >>>> The same applies to refer=3D - just change from "hostname" to
> >>>> "hostport", and the text-based mountd downcall can stay the same (e.=
g.
> >>>> so "foobarhost" changes to "foobarhost@444" in the mountd download.)
> >>> [snip]
> >>>
> >>> What would be the correct syntax to specify a custom (non-2049) TCP
> >>> port for refer=3D in /etc/exports ?
> >>>
> >>> Would this work:
> >>> ---- snip ----
> >>> `/ref *(no_root_squash,refer=3D/export/home@134.49.22.111:32049)
> >>> ---- snip ----
> >>
> >> Hello Roland -
> >>
> >> Although generic NFSv4 referral support has been in NFSD for
> >> many years, NFSD currently does not implement alternate ports
> >> in referrals.
> >
> > I know, but the question is about the syntax in /etc/exports. The idea
> > is to use the same syntax for other NFSv4 server implementations (like
> > nfs4j) ...
>
> We're planning not to support alternate ports via the refer=3D export
> option. Instead, we plan to add the ability to specify an alternate
> port via the "nfsref" command.

But that was NOT Rolands question. The question was which syntax would
work ('Would this work:'), as this is for other NFSv4 server software
such as nfs4j, which tries to be compatible with Linux.

>
> The refer=3D export option (that is, using this UI for setting up NFSv4
> referrals) has been experimental since it was introduced, and has a
> number of limitations that we hope to avoid by using "nfsref" instead.

The problem I see is that - if Linux nfsref gets fixed to include
custom ports - then it will take at least 3-5 years until this version
is readily available in ALL stable versions of all distributions.
Any improvements or fixes to refer=3D is available with the next Linux
kernel patch, and I'd be more than happy to pay $$$$ to customer
support to have such a patch backported to a stable branch.

>
> As an alternative, Solaris, for instance, does not use the /etc/export
> interface mechanism at all, preferring instead the "share" and "nfsref"
> commands. (though as far as I am aware, Solaris does not implement
> support for alternate ports in referrals either).
>
> Solaris has support for reparse points (as does FreeBSD). "nfsref"
> is supposed to be a mechanism for editing those, and theoretically
> reparse points were supposed to handle more than just NFSv4 referrals.

How would a reparse point with a custom NFSv4 port look like?

>
> Unfortunately I was never able to generate a lot of appetite in the
> Linux kernel community for implementing reparse points in our file
> systems. Our "nfsref" command is therefore somewhat limited.

Did you document this somewhere?

Thanks,
Martin

