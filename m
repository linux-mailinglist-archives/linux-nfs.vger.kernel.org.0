Return-Path: <linux-nfs+bounces-3514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C28D6845
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7FFB2526C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012517C223;
	Fri, 31 May 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Pk+kZOVr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4D17C22E
	for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177222; cv=none; b=hRohZaGqO+puBbjZSUcIQHO/RoyZ7aUwyUqeWWnlWuWWouY+tCqMcOnFknse8eiqoOmqVJDENP+Q17+an3/OeKoKC0/NCuOueVS9tynWDu99qqwOLPN2s7rY4kchzdmI/Db/qnLVjlMgO0N4lkWlP57iw7/f6DoT5VRq83r8/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177222; c=relaxed/simple;
	bh=d2NIjwyEyKYJ1an2j8pdMKbPLkGGU2InUcZSwZreu9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQGyXAFTJW50nK2LvoOiT/wvdOF833WYlUbhUMBEh9bvUCvL8aKspYXuqwcXxMINRGmjd4Yz3UCKV/bgifSOfkuyfM38d61LN8jpeJPjY8wk0KuP4WfefHy5BuN+DdgMy8Tk4xo7F9e/iDZOQk/Rwz1fUH6VQZsjkYy1ELLmJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Pk+kZOVr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ea85383b5fso2087661fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1717177218; x=1717782018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2NIjwyEyKYJ1an2j8pdMKbPLkGGU2InUcZSwZreu9c=;
        b=Pk+kZOVrXJBpLYrPh7q3sqbhddHZPqyzkp9wbEFJumU+6OdmXzayQPNPUd70pKGGpW
         FZpJqvIwhoW9oM1VXCDa8sjKNWizHiPk9h7cs4QOsThDwU18BDN/vL2LVgjMa0JRVGRk
         JUtCcUUT6jaKcoGVemAFN4Zgr6dr0kd9U+3B7Kw0po35nWjcno3eckH6ohaXfo94jAcF
         qH1/1921EYIbUzhr07y2xWCz2dcCn527qlRC6wfD9T7ooSd53nJJibYMdta2zs4vQSO3
         yr8UwJYJgJEFMBkxlhQKk2kUvzgYvlJbAw9sCi/fbs5FUTduxlDIqM06B3Njt3sNO6NE
         xU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717177218; x=1717782018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2NIjwyEyKYJ1an2j8pdMKbPLkGGU2InUcZSwZreu9c=;
        b=bYNG+ptc04k7KunQzUa27KskQLJ4EuxQBEuPPoXuFjEQm4DE42kAk0gRJfRzaQEmg+
         mEnnk8wkSDCD5yZSGFgut+oywQQJnz89j7W14ZxVQUh65YIOOtT3HFyUcINxthov4dvH
         3S+jbUCzlD4gP0zA/GJkd8EDtZlI6CJB6xcwOhUPF01/qXelb9pASmmosh9TsD2BFf7K
         rdaHDXiZ4RXAx7ftwemjk28BT/aZA9UJfXYUzjSezVpPGZpWdncMCs0hIQRr2N1m/0JK
         +uwwLrWykeyxBe6m+yOdUCV6383fAEtc1X78hsYgNzi4KDSvMifSfvlGycn7fy8e5MUC
         TR5w==
X-Gm-Message-State: AOJu0YxSACRkEzyKlRq3Pj6p+P2KLqQkfd7JE/QPAovw47/sOasxULbf
	hS2TvLUHBKhxM1cKLT+e35bB6uQWPBmVLzWKikxgxBRG8GAJj0lMxVVGgLoVpRPpx3DYJC8Tsz1
	NL/8QkG+Lxwz70NykLlrJJwLZ2dAazw==
X-Google-Smtp-Source: AGHT+IFE1LDs6tT81i2GNUMNm82s1T6f44VSC5oeknJjqZE6HLMDIDPJBlj4LkB/ir5PKmMaTvZbl32DxLhBliMyR/Y=
X-Received: by 2002:a05:651c:2120:b0:2ea:7e4a:d85b with SMTP id
 38308e7fff4ca-2ea951fb19bmr20259331fa.5.1717177218065; Fri, 31 May 2024
 10:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyENK71L1C=6NwdB4mkxxf1qYZ2-4e-p8FQM=SmA3tMT_g@mail.gmail.com>
 <6A2D93D5-1603-4CB5-95BB-841163E20295@oracle.com>
In-Reply-To: <6A2D93D5-1603-4CB5-95BB-841163E20295@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 31 May 2024 13:40:05 -0400
Message-ID: <CAN-5tyFcqZWEb0-LYvucr1nGho6LN6nUNhO1oZHZzZC4G6W2Ag@mail.gmail.com>
Subject: Re: ktls-utils: question about certificate verification
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:27=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On May 31, 2024, at 1:23=E2=80=AFPM, Olga Kornievskaia <aglo@umich.edu>=
 wrote:
> >
> > Hi Chuck,
> >
> > I've ran into the following problem while trying to mount on RHEL9.4
> > client using xprtsec=3Dtls. After some debugging I have determined that
> > the reason mount by DNS name was failing is because gnutls insisted on
> > having in SubjectAltName=3DDNS:foo.bar.com. Having a certificate that
> > has a DNS name in the "CN" and then had "SubjectAltName=3DIP:x.x.x.x"
> > was failing. But when I created a certificate with
> > "SubjectAltName:IP:x.x.x.x:DNS:x.x.x.x" then I could mount (or just
> > having DNS: works too but in that case mounting by IP doesn't work).
> >
> > Here's the output from tlshd when it fail (with SubjectAltName "IP")::
> >
> > tlshd[260035]: gnutls(3): self-signed cert found: subject
> > `EMAIL=3Dkolga@netapp.com,CN=3Drhel94.nas.lab,OU=3DNFS,O=3DNetapp,L=3DA=
nn
> > Arbor,ST=3DMI,C=3DUS', issuer
> > `EMAIL=3Dkolga@netapp.com,CN=3Drhel94.nas.lab,OU=3DNFS,O=3DNetapp,L=3DA=
nn
> > Arbor,ST=3DMI,C=3DUS', serial 0x751ad911565945cce5d29d1c206450538f496b9=
0,
> > RSA key 2048 bits, signed using RSA-SHA256, activated `2024-05-31
> > 15:07:53 UTC', expires `2024-06-30 15:07:53 UTC',
> > pin-sha256=3D"Efzu7ftve1SHxBVAIwf81jwAasQ0M3j5qWbEVuM8X8I=3D"
> > tlshd[260035]: gnutls(3): ASSERT: x509_ext.c[gnutls_subject_alt_names_g=
et]:111
> > tlshd[260035]: gnutls(3): ASSERT: x509.c[get_alt_name]:2011
> > tlshd[260035]: gnutls(3): ASSERT:
> > verify-high.c[gnutls_x509_trust_list_verify_crt2]:1615
> > tlshd[260035]: gnutls(3): ASSERT: auto-verify.c[auto_verify_cb]:51
> > tlshd[260035]: gnutls(3): ASSERT: handshake.c[_gnutls_run_verify_callba=
ck]:3018
> > tlshd[260035]: gnutls(3): ASSERT:
> > handshake-tls13.c[_gnutls13_handshake_client]:139
> > tlshd[260035]: Certificate owner unexpected.
> >
> > Question: is ktls-utils requirement for IP presence in SubjectAltName
> > now requires both?
>
> I'm not sure I understand.
>
> If you want to mount by DNS name, the certificate has to have
> a matching DNS name in it.
>
> If you want to mount by IP address, the certificate has to have
> a matching IP address in it.
>
> The reason for this is to avoid any potential interaction with
> a DNS server which might be compromised.

DNS name is already present in the CN field. Why should it be
duplicated in the SubjectAltName? The point of the extension is to
have "also known by" alternatives. But now the certificate must have
"CN=3Dfoo.bar.com, SubjectAltName:IP=3D,DNS=3Dfoo.bar.com". That seems
cucumbersome.

Is this requirement new and done by GnuTLS or is this new by ktls-utils?
.
>
> --
> Chuck Lever
>
>

