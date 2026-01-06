Return-Path: <linux-nfs+bounces-17502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2DCCF99D8
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 18:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 215EA311CB4F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016A33C535;
	Tue,  6 Jan 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoA/zRDM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B531354D
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718999; cv=none; b=kxAeR7cUZTkeyAMXlzS8RBcFnq8FRtULW6tv85jI2vwLYIVZF6+zLonGwC21uLsOBHCG7qaH95Nm9Z4sNSgb3hXkEvxIvT4raQ9fvos2K0U+6gfBWU88a4RtWz+ck9muKwxaHqLBOnSRfvkBkkW53CMkr/TiUoah+J0SOJWFXy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718999; c=relaxed/simple;
	bh=Af2/CsJHV0l9FQgFRuRRGTLWjVmNqXJJBFxtwUocwXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WbYpRdhWokSRZq58T24XgzhPwUUL8vvjMbkINaWM2SInzHhQ/4k20lWQ/gDYImPuwV1iKWeMsct876bGz+ElcCHCy5EV5vsW30uOjeL/tfL0Q7H2cHiwZdUgo5fLqVIFEmwF8m2oZW2cP77fLaeeBmisPK068Zh2WadXPoBpPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoA/zRDM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b736ffc531fso242049666b.1
        for <linux-nfs@vger.kernel.org>; Tue, 06 Jan 2026 09:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767718996; x=1768323796; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njlWX0UzjCMmrv2ulL1OK1alUV5pP7nNAZYNvo+LTUI=;
        b=LoA/zRDM37VO4/dnQtBHVn3Z2EG7OEsOgJpZeDZ5ZHmvFHp4x8bhAxPrTtbPGiJCbv
         tL3ACqhYtt46ruu9WfsblTWqKCzLeioS+HQQLrQy6WWylQybfWbhx751lznP48hpIcJO
         1+P33SStvP5F+z7GCPtBbo1tkvrcPHq/NeMOVJkCEpx64OEXrT6nGwhhiJkVtg3DuHNy
         BeSfj1Rm6MSKAM1Q2u3LXwMIoFBIQKpJeSM000tg865QYMAkcPngFCQv0NaWFdohvhuQ
         WBlVSA2KWgepbfFdarERU65Xb5jWGj7Hn89jkOKMq+w5+e2/mhPtpNvVqQpz+xOV2feG
         MnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767718996; x=1768323796;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=njlWX0UzjCMmrv2ulL1OK1alUV5pP7nNAZYNvo+LTUI=;
        b=eQ/bEn3kiDBMKGJ7sSF6UzimbjWA99aJnsZBuYUYXnB6D2PUHBTOywLp/7NQq0PQZk
         ohdhiHX5eBPJtY48RnX6zPSaqtdCrgkLrqbGaSmJgsEyZaAUXLe04DVvajCGGmOZ9d28
         WpvAuG44iJ0o2r647NynuZADvAMOVOUW7wHn1pt8NhkEi7xF37nrs3lwWpjVk85AZ7Jj
         5SbShrbErgYAw5zHB60ot0k4UUOvVtpjF9tyZPcgAQr0KAAcWW2kacF68nGRuvxu04zt
         r1dAdXz+LsdhnHvRKzPumQJmKR6TnDS6tGG8k5ViE7zzssm+EDltLiHk7Ik0fSt2HieO
         V0JQ==
X-Gm-Message-State: AOJu0YxS+wW4FBPYvyMkQw2kg80hEbBSIfNuxpMWp5hz9PIGEe0Ztnqc
	6NuuduqETfJ1CAfvoeluDN+IjbFa6/MaG9X7A4uYmWgKMm07jRsGGaaAVer8i8sgiIJQHkMGgKq
	woi/WFjkSqUmNNCB5HHWQ77eb6gIq1O1VLEg4
X-Gm-Gg: AY/fxX6GQ1u48blqtCVyYa36vLENjoFVg3X9Qbzg+24RgZuTTPWZEgMAbYXrAqTT1pJ
	SJHCHIUterMdYLOeVQm0cOlTXH9VW2sF2c/8QVTcTXCyE70b+aThbSANXDckO+uBlHIG3V+j4ne
	y9gVHOTkclQ6DpQWWb9SjOHS490iW9P+infWoYm1+Q8qxMC8BqmS0pn0Zo9D84W9dXktdkgoaBe
	ewmsYndhnn6TjymipbJoElhrxQs6fzH4VjToXQm99/hTZlfBq25OwQFFq7a0e+aEuuxQr1CGnpW
	xZbyPX4OaplUqEEaDXacneyVAss=
X-Google-Smtp-Source: AGHT+IGMnn4978ywFNrBWRaUyv1UbCRWTvqqm6AK6FkGMrxZbuCg3n6Elhu1SseuZV2+kef68yJg29Wo6sBnNivWMDk=
X-Received: by 2002:a17:907:a4b:b0:b7a:1b9c:ba5a with SMTP id
 a640c23a62f3a-b8426bf04e0mr390824966b.32.1767718995654; Tue, 06 Jan 2026
 09:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
 <679b3c2a-b70c-4364-a362-fa5eefbf3af3@app.fastmail.com>
In-Reply-To: <679b3c2a-b70c-4364-a362-fa5eefbf3af3@app.fastmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 6 Jan 2026 18:02:38 +0100
X-Gm-Features: AQt7F2q-lB5bbl-iwSKk66eHpBvxH_ExdObv8_BfisQ8kK8OfVkgdx2Uh3yMjZE
Message-ID: <CA+1jF5pTWStc-aX8j85=LGjQ+ouZpD-CWqu+GAf8a0Qdjb41xw@mail.gmail.com>
Subject: Re: Limit on # of ACEs in a POSIX draft ACL
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:43=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Jan 6, 2026, at 11:02 AM, Rick Macklem wrote:
> > Hi,
> >
> > When I did the POSIX draft ACL patches, I mistakenly
> > thought that NFS_MAX_ACL_ENTRIES was a generic
> > limit that the code should follow.
> > Chuck informed me that it is the limit for the NFS_ACL
> > protocol.
> >
> > For the server side, the limit seems to be whatever the
> > server file system can handle, which is detected
> > later when a setting the ACL is done.
> > For encoding, there is the generic limit, which is
> > the maximum size an RPC messages can be (for NFSv4.2).
> >
> > For the client, the limit is more important, since it sets
> > the number of pages to allocate for a large ACL which
> > cannot be encoded inline.
> >
> > So, I think having a sanity limit is needed, at least for
> > the client.
>
> The Linux client does something special with ACL operations:
> the transport/XDR layer allocates the pages as the reply is
> read from the transport. It already does this for both
> NFS_ACL and NFSv4.
>
> I don't think there's anything different needed for this case.
>
>
> > If there is a sanity limit, I can see having the same
> > one as the NFS_ACL protocol will avoid any possible
> > future confusion where an ACL can be handled by
> > NFSv4.2, but not NFSv3.
> > (The counter argument is NFSv4.2 is the newer
> > protocol and, maybe, shouldn't be limited by the
> > NFSv3 related NFS_ACL protocol.)
> >
> > To be honest, NFS_MAX_ACL_ENTRIES is 1024,
> > which is a pretty generous limit.
> >
> > So, what do others think w.r.t. a sanity limit on
> > the # of ACEs.
> >
> > Thanks in advance for any comments, rick
> > ps: When wearing my internet draft author hat, I
> >       lean to "no limit in the draft", since that is what
> >       the RFCs do w.r.t. NFSv4 ACLs, but that doesn't
> >       mean implementations will handle any number
> >       of them. Maybe I'll add a sentence to the draft
> >       noting that the limit of # of ACEs is server file
> >       system dependent?
>
> IMHO generally speaking, implementation guidance is reasonable
> to put in an Internet standard, especially if it directs
> implementers to address a subtle security issue such as a
> denial of service.
>
> Something like "Client implementations should be prepared to
> handle ACLs with many ACEs and large 'who' fields."

FYI the Windows limits are:
- for the ACE "who" field is less than 128 (UTF-16) characters
(maximum logon name + maximum domain size). The "who" field is then
translated into a SID value for the Win32 ACE
- 64k of memory for Win32 ACL entries, which roughly fix a maximum of
1024 Win32 ACE entries

Biggest ACL list I could find in-house has 722 ACE entries, funny
enough it is the memo for new Chef de services.

My conclusion is that a maximum of 1024 NFSv4 ACEs in a NFSv4 ACL
should be enough.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

