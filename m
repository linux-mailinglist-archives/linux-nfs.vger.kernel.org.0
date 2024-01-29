Return-Path: <linux-nfs+bounces-1535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6223840404
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 12:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A72280EF1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A75BAD2;
	Mon, 29 Jan 2024 11:44:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1155A7AF
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528685; cv=none; b=dHI3cKXUD2vFnXsCA27AaooblQUxL3Od4tQlbLwiUPmMJvvI/2Gbw7CY5FhU98gSDiHleoRObn9FEqlkB9myALFznK9QjZHCsTUdgSxzB06HfZBjfdGCC9W8ahKIGOeG56ufaQZfB5kxDkxIRblkY/0kMJIj2XhMj4lMi9EkmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528685; c=relaxed/simple;
	bh=bmJzdUwP6uOKO0kVIbKRjjfZQgAhczJAKvOs9tEp6h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtFrEeE8Q0tE0kNmqdqtKhUjAEsoBjRAsfeKjqBk/ukS43XszKtrrKY/UAH8lBZALTjaMoMZkNBOoX772eDIZZdQTrslFP+Xhz/84ehUSFQTRLnqg/9jQoFHFh2HVjm9UwCXRQLvDiqdu7BksF6mzZTCZxW4ALJUCzk3shNJFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3be50508b4aso291509b6e.1
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528682; x=1707133482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxCKiSj+QF/xHgSfSdKWbm2FMJtwJjMYLN+t3dmUCoo=;
        b=D02zO91XjEpNKcFllKKSI0lLCDa7o2S7t3cVKc4eqT+TGklQXeP313U6F2F9fpLSep
         cOBSXOSC+sqmrjozSZRATvSqJx7v0Y4uZL8CEVZ70ut/bUQdr8zXCtJwhmsZHStDoCY+
         94KzVao28R2OMwRmhrxO22MRc70x/MNYJgXHrS4QkikeJySBdAi3518ih+DIuLjQ77Ba
         fpxuU0vIkNSRXVymAK/4hFpR0iV/CsVqsqYUnLGkY2xhPmPoBi16y6/u747vDg5KpWwH
         R8tCbe+feYd4qPxwDlucoqYTXg1UV+xPcZHdFfBjXA9OGkDcgoCAl0rhCfjjwjDDSeFz
         aZSQ==
X-Gm-Message-State: AOJu0YwgttZ+fCBbVQK8KZO2A2c7fGyor8LyFMKD5gwVIUinPvbF1fBb
	xphM+x+i0VX/nx8PTslVK/2cJT15nry89XLd79LZZ505MOCg3mlo3PCEF/ze8QJBujq93IUTUcC
	CTPiULSB0GCA+MdsY8Wq7s8D5Fhe+r+7a
X-Google-Smtp-Source: AGHT+IEhhmP2WXaj9o+qJIFiJ2i7TMZoIgwWymteu2oYrkDV9IkHMsC1JGEwY3Lus7E7M/EQUJsrSZ9zFUZqEA1/1S8=
X-Received: by 2002:a05:6870:b523:b0:210:ab2a:8e0d with SMTP id
 v35-20020a056870b52300b00210ab2a8e0dmr2790852oap.32.1706528682128; Mon, 29
 Jan 2024 03:44:42 -0800 (PST)
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
In-Reply-To: <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 29 Jan 2024 12:44:28 +0100
Message-ID: <CAKAoaQ=FDdkTW2Vh=_Y08DEWZYaJa6tDSYKnFiZCfQ6+PW_5iQ@mail.gmail.com>
Subject: refer= syntax in /etc/exports for custom non-2049 TCP ports ? / was:
 Re: Change "hostname" to "hostport" in text-based mountd downcall Re: BUG in
 exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Martin Wege <martin.l.wege@gmail.com>, Chuck Lever III <chuck.lever@oracle.com>, 
	Cedric Blancher <cedric.blancher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 2:01=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
> On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
> > > On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com> wr=
ote:
> > > On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.lever@=
oracle.com> wrote:
> > >>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.=
com> wrote:
[snip]
> Yeah, instead of waiting for NetLink you could implement Roland's
> suggestion, and change "hostname" to "hostport" in your test-based
> mount protocol, and technically everywhere else, like /proc/mounts and
> the /sbin/mount output.
> So instead of:
> mount -t nfs -o port=3D4444 10.10.0.10:/backups /var/backups
> you could use
> mount -t nfs 10.10.0.10@4444:/backups /var/backups
>
> The same applies to refer=3D - just change from "hostname" to
> "hostport", and the text-based mountd downcall can stay the same (e.g.
> so "foobarhost" changes to "foobarhost@444" in the mountd download.)
[snip]

What would be the correct syntax to specify a custom (non-2049) TCP
port for refer=3D in /etc/exports ?

Would this work:
---- snip ----
`/ref *(no_root_squash,refer=3D/export/home@134.49.22.111:32049)
---- snip ----

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

