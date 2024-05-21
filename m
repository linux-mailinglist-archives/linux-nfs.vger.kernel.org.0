Return-Path: <linux-nfs+bounces-3298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6038CAA02
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF359B222D2
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7D55C33;
	Tue, 21 May 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkIwyEzB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8454BDB
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280362; cv=none; b=kYZHw8Qn2J52n74dAI4jOT3P2qRs3TmVyEXVp97jAf5x8iXLMyTyZHvm9scMvLN41DnPK7jf3Jk+mPmELpPulZ5d32iH9gOLl9A4eqQ3Lj0kNqnIiriCYtbCIjSujKFo/DlYMuazQpjxYwjJ7ILGOLat55e5XCBgKtsRPkoqCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280362; c=relaxed/simple;
	bh=eNAfFiBFtvDkIU46Uzq+Jtfa8NT5UkDWFgGFsS51ULo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sWSd0LR98dgdW6uSIx9r4/OJw5ZCIRVby+Y56lRlBsrvBMnuWFB8BP+uKGXse88Azgi5M7WzzvNmm2+gZvDf+SfJ0cfAEov/6zMZOqPre02LXIxNyvA+aWgfU3gxAO+HZNsT9KycX0XMgh6JKsJlufHOyD19uHrUBUc3CPQOwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkIwyEzB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59e4136010so861325466b.3
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716280359; x=1716885159; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=042N1pbaJOntOFtHt8GAKbOMbErAhqajmACZ9z3KXC0=;
        b=HkIwyEzB0HT1RLWev5sKmE4jWG1g20FMXj3COOoGBS0g+bYC8toOi9k59uuD5QySg9
         HkENQ+NOJddCDY5Qk5rto12rgXUlBi77TjgzNc7a4115WuThPM33h7K6z/MtXtNIJgRh
         mUxRM8sPRJ2/1jSfcdNsG1eVmDsMHxXH9nF/OR4OP8xtmRY5HDCe+yKbv13/AyRA/vRI
         zhvqxpa0+Dv/fREOqi2n0J0qAwMVPPZ687WAR4XEeN+jIQTUWw/7hSg8qFv/mzlmvi1+
         vravJ5EhYiVPNKzcu2gq9c3gFkqB+5/b+wFL3UnWlnma6FxOI1Hcwlni+BcZSGIqS9+W
         6aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280359; x=1716885159;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=042N1pbaJOntOFtHt8GAKbOMbErAhqajmACZ9z3KXC0=;
        b=TRUl+0/CiOltqVQsXxoJqNX78wU4AeBPWcIID1xuHD3AuCOT4+6VqtaKM1eCTC22ME
         d3JiaHal5asQyDQrzdJDehjGoZIKuPlfgGkKre5EmkzaikwelZk1O9YGHDBJC+iH7IN+
         l3UhHXa+3IsZF1HCj2pqgVFkW+OGmefcUJzY0vKFsAeg2qq4eRz/9c+zpUis8RpdiRNP
         C1TvD+6tK0QS5g/YxWXWfqHrt6Gw2Y8sUjwixmHeufZO4icP/suKo/DcxyZYAdEY6lZn
         wd3O3f7LKdLJz6E8oP0Tli+hj+dUjhGd1EqPECu2mzlIe/rjMB/8f4UOiTAKzOeX4c/g
         7oHg==
X-Gm-Message-State: AOJu0YzDYX8mSf34RXZ/4mU7UDlvuI+zLMZ8Fwng2NcE/M2kozdlW312
	Ngohn6bM7k5yxUMVYjw+M7V92K2j7ON021Ne+OOiNb202LSEWcFJkxgwQh7pdU1cU8Q6pfqo0ET
	Ewivw0DNTlRX+7t6smJ//5AyeSeHWgQ==
X-Google-Smtp-Source: AGHT+IH42RsA1cagbb/ONtoylhKGcY51w5YIqzG4yR5cDPflF1eNYMo/k1XD95hLx9ULw9+mdEKXagkba1CruUTinPs=
X-Received: by 2002:a17:906:eb18:b0:a59:c844:beea with SMTP id
 a640c23a62f3a-a5a2d676a37mr2011712166b.73.1716280358957; Tue, 21 May 2024
 01:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com> <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com> <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
 <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com> <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
 <93DA527F-E5D7-49A4-89E6-811CE045DDD3@oracle.com> <c28a3c78daa1845b8a852d910e0ea6c6bf4d63b4.camel@hammerspace.com>
 <DA6AB3E6-F720-4679-A36B-01BEB39720BB@oracle.com>
In-Reply-To: <DA6AB3E6-F720-4679-A36B-01BEB39720BB@oracle.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 21 May 2024 10:32:00 +0200
Message-ID: <CANH4o6NtVdF1p1fkW-uiCkm7RAcwGzhSxt5sFkz45LqbJhZd0Q@mail.gmail.com>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good morning!

What is the status here?

Thanks,
Martin

On Mon, Feb 5, 2024 at 8:53=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Feb 5, 2024, at 11:17=E2=80=AFAM, Trond Myklebust <trondmy@hammerspa=
ce.com> wrote:
> >
> > On Mon, 2024-02-05 at 15:13 +0000, Chuck Lever III wrote:
> >>
> >>
> >> A DNS label is just a hostname (fully-qualified or not). It
> >> never includes a port number.
> >>
> >> According to RFC 8881, fs_location4's server field can contain:
> >>
> >>  - A DNS label (no port number; 2049 is assumed)
> >>
> >>  - An IP presentation address (no port number; 2049 is assumed)
> >>
> >>  - a universal address
> >>
> >> A universal address is an IP address plus a port number. Therefore
> >> a universal address is the only way an alternate port can be
> >> communicated in an NFSv4 referral.
> >
> > That's not strictly true. RFC8881 has little to say about how you are
> > to go about using the DNS hostname provided by fs_locations4. There is
> > just some non-normative and vague language about using DNS to look up
> > the addresses.
> >
> > The use of DNS service records do allow you to look up the full IP
> > address and port number (i.e. the equivalent of a universal address)
> > given a fully qualified hostname and a service. While we do not use the
> > hostname that way in the Linux NFS client today, I see nothing in the
> > spec that would appear to disallow it at some future time.
>
> We absolutely could do that. But first a service name would need to be
> reserved, yes?
>
> https://www.iana.org/assignments/service-names-port-numbers/service-names=
-port-numbers.xhtml?search=3Ddns
>
>
> --
> Chuck Lever
>
>

