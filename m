Return-Path: <linux-nfs+bounces-11834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056FABCC69
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 03:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731371B61CC4
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 01:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4512C254B0F;
	Tue, 20 May 2025 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL5RYHUW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C521ADC7
	for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747705489; cv=none; b=L++4nEDbaGh01pACfnvK9oeQumLDdQzz2EbYK+JvD43kv2XhkIN/V/zFgWEqI9kNhpDRIwrsEL/9VfkuWNu383t88+9wbZBXfd5WqmFl7FFnEcjberjsj7/7mFepZmo/pytpWCS89e6TQ3RrhaL7IXauNHY1Nm4aGCHncJkI/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747705489; c=relaxed/simple;
	bh=zvZJVM42o8pKHKSVwBbm03CaRfA0Te/nqVM1UzIEzak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5EWExXViqsSHAxfZ1iVknfrYj/iUweoejaR5pHQVdBm45U056nD8cftMp24Ufi1gZ1kRygoskxFgHPsmZHFZfTG6u7G9DlDaxj3ABfB058D8RGmfbvsdaOtELmN976btft13Xo6Po6Qyrx7W2tjlWjkfCp+D4rI7iWBKrxhRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL5RYHUW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70cca430085so19551047b3.3
        for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 18:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747705486; x=1748310286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKbKG9MEe1e/SDujZAewHF9KVqxOuQm3PxZRTjpsE98=;
        b=SL5RYHUW68Y98tjDyqR+xMyzTxZ8dDJ1Va36a+fGYdvPH2dGQwHLkKlnzoJY4HzMd2
         ziCPM/mcwWu1XtgO/W2Tvb0O5pzil8e3YIRkMVQme4BwoLohd4CzSD1ard8HbJkUMNru
         hxJPuQv/5UELgymCMo5xDYz+0SZVuPX7bPqayASFo9g7g+y/N1efP7KD7QrgXRNWGg6/
         Z9HX6u+g8DdtQiQlqhX/iDsQSQm34QbaO05skZDjXe5qthIDCxoQACt/u/ykSqT+SGkI
         TT5KTfr83fW3FrD0NQ+mPUbmo6abaSZ16H/BlwzuBe7RUdZ1pdK97VCOw8cBhhZHrg+R
         z5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747705486; x=1748310286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKbKG9MEe1e/SDujZAewHF9KVqxOuQm3PxZRTjpsE98=;
        b=JVl1P7OnbrB/es600JISgCuc+ZjpdUi+1GC/dltRp7eRzgmeyUGCtdDiyXI7wOEWmP
         XXKZqWiM43hdjd3xyPoNIf3g6e00h3GHnUpREGRq572GEtRw2Wy5MOH319lvr/hzIwDx
         d2BpkLw7XUFkxLZCLax6+Z3qWS74s0USGQj1h1GmlERPBMritpu2PTWPvLlK6Dif0HGU
         IMQqYQ1+VicS6DMnCogXYcLKtQh84Zscz8lltMJ9ntUlDT1oCSp6w6XSuA9pFF/AkP0f
         +iQTkKMUZo1yoYpgT2oZUsiu7afuSwjo/grDI35lSSPwImWiXsbLNufyhwFUleR/EM89
         QX1g==
X-Forwarded-Encrypted: i=1; AJvYcCU5s3rY42Ang9adEtf0b0WcXlhR/K07paoPv+8Ovfrtnu01ZnZqDOBy0sRjMmB87OrdddeNqKdpo7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsZGgkppLjvd43hy4eDyUJjmd8h+7KokcAuANxt7ZLJXNGaf0
	Yjd+YNXiOv70LevRPY/oVDiwTc5QZywO2Tk2fPrLJqvv16QUn5y8Chakpn8ruRE2axPxq6xr+pG
	SONva4sCzBzqhwzQIyXiw9xm54X1xkQ==
X-Gm-Gg: ASbGncuRKNdDS4B1fbHRY0AXs9trlcS4KlwGOR9S/02KvOuyhtu8Og6Hhlt5/xfwBF0
	L3UtRscl62kkCsbsbWqlI/C+HSNdFrKsGVstp59xsxzFN8OZXpM6DZTBfMaE+Jnx+eUXZex+E0M
	bD8MVThLv71lG+Ef9BmD8HOukahIEUZio=
X-Google-Smtp-Source: AGHT+IHrTu0HYiqxfd9ddA6UconX9AwGqoNw3WjOW/1Yg1vtWqwKoBWjp4vdhiLoHGaW0bjpsKkPXdE+DKSR9uAv/jk=
X-Received: by 2002:a05:690c:d0d:b0:706:b2f9:1a7d with SMTP id
 00721157ae682-70cab0e7a76mr184302367b3.33.1747705486227; Mon, 19 May 2025
 18:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02da3d46-3b05-4167-8750-121f5e30b7e9@oracle.com>
 <174763456358.62796.11640858259978429069@noble.neil.brown.name> <780a7e7a-b8c4-4ebf-ab79-d1480afb6b6f@oracle.com>
In-Reply-To: <780a7e7a-b8c4-4ebf-ab79-d1480afb6b6f@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 19 May 2025 18:44:00 -0700
X-Gm-Features: AX0GCFttYH35s7UXCi-0J_OYl4bdqKFT3uO6NZIuGrUFD8tBx2oXG8nkIYDuzLg
Message-ID: <CAM5tNy5Utc5NYbEY+E_g91Hsfa6QiZsEo+MEwKHzvryQxe+j7g@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 7:16=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca.
>
>
> On 5/19/25 2:02 AM, NeilBrown wrote:
> > On Fri, 16 May 2025, Chuck Lever wrote:
> >>
> >> Fair enough. We'll focus on improving the man page text for now.
> >>
> >
> > Has anyone volunteered to do that?
>
> Jeff has, but thank you for the text!
>
>
> > I haven't added anything about mtls as I couldn't find out how nfsd
> > interprets the identity presented in the client-side certificate.  If
> > the identity is a "machine identity" then sec=3Dsys would make sense on
> > that connection.  If the identity is for a specific user and can map to
> > a uid, the all_squash,anon=3DUID should be imposed on that connection.
> >
> > Can you point me to any documentation about how the client certificate
> > is interpreted by nfsd?
>
> A TLS handshake is rejected if the server does not recognize the client
> certificate's trust chain, as is standard practice for TLS with other
> upper layer protocols. Therefore, when an export requires mtls, the
> client must present a certificate and the server must recognize the
> granting CA for that cert. In recent nfs-utils, there is a "Transport
> layer security" section in exports(5) that might be updated to include
> that information.
Do you also have some configurable settings for if/how the DNS
field in the client's X.509 cert is checked?
The range is, imho:
- Don't check it at all, so the client can have any IP/DNS name (a mobile
  device). The least secure, but still pretty good, since the ert. verified=
.
- DNS matches a wildcard like *.umich.edu for the reverse DNS name for
   the client's IP host address.
- DNS matches exactly what reverse DNS gets for the client's IP host addres=
s.

Wildcards are discouraged by some RFC, but are still supported by OpenSSL.

rick

>
> According to RFC 9289, client certificates are machine identities. To
> identify a squash user, we plan to adopt the FreeBSD mechanism where
> user squashing instructions can be included in the client certificate as
> part of the Subject Alternate Name. This is not documented because it is
> not yet implemented in Linux (but FreeBSD client and server do currently
> implement this mechanism).
>
>
> --
> Chuck Lever
>

