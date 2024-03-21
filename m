Return-Path: <linux-nfs+bounces-2440-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356808863F0
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65A9282F1F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 23:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F222E125BF;
	Thu, 21 Mar 2024 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEl+ORWz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62918F9CE
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063355; cv=none; b=BObTZvbSasjq6dvVv20vonjqnmP+/6vXaT9Ga4XgqoDh4cv0vptj8N9acp3FNK/ZvGQTpYPiiL8ppS4pWgTTeLkP4a4ny6UCFw2eN0wvTIFnFfpWp1+NFZPwu6zFlNUnaGi7ar7Ou1Qq7UTW+RnuaSOEJe2xQSDsAW7wnqnUI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063355; c=relaxed/simple;
	bh=rSrXLjvJXNAdP5+OtiGktg2WPKzse2Fa6QzLzKtcACs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTLYELojfbyyU9Q7t1xbw5VREMAyoNnNCoRbpDwLumNiU+y3cunj39sR76A8jrk5UNrXRcUNpm7ZNJUQcoB4cWpxtCIpCDeWq2rhIhcxfskUFg8J3V5vgZcR5tHSP8PXeGbQsZK4qucniK6GolMVMPg8+t+nM+BwVIJGvaY370o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEl+ORWz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-428405a0205so64681cf.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711063353; x=1711668153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvnQYmZPFjlDoRMaEUvTiEfQCkCBQChb8ZlZ8MBm2m8=;
        b=YEl+ORWziohgs9BuXdxuA8g7I7t/SFVLWxpiKwJIFen5wca068+LS+4a3g8JMcR/sB
         lFJf0TR6bPDsSg7Rhga46EQivRO0FX045ELXvALqpK7VuJKIl7kzzEJsHsW+iC/rumr5
         OMTtNcFoENhgvKj2QF776bi5GCEgvAqp8ZHhuGlbo0x9Kj3i+6H1okg+O0rPpaj19W4H
         6riruwE5L4Y4IvBBrVQyuDD3uG7Z/F+X8phYNbqEn8cjkwkesnISPgAQENHn8nIRL3lH
         mQhKWcLPKaIMWsb4VdLzFrNbGAr7ENM0Ir47xTOihXD/5Gybw8nW9vPtAmKeU8CgeSzb
         iydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711063353; x=1711668153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvnQYmZPFjlDoRMaEUvTiEfQCkCBQChb8ZlZ8MBm2m8=;
        b=KnmDHlPfgwrAFuUH2i3mnb4gdyn2YvimiLsEZlcyA5X2jvmrAJLAfRF156BiiMX3YK
         uB4620ALk+TTLbkVmYDyxdBPTEoDuvOr7S3W/kvwoGd4D7gbBpfCxgHRYLxNecabRZPV
         qksIwPAptVvRfImbmXcYuf9qIpzwiLq1eMFLS1FYHEumbdA0RzNRzDkR81AFJF3rxdF0
         auByBV2U/oNPT9WKmCH0XkYnqEJuVmeA1vpLfl+Gax2Cozm5vmeb5kiy94zpHKVL+Uzr
         F3fDr41eEAG2iA1xNLFK3qw+xUdI1Lcx3NQ3GgiipP+QN3HDVcb2q+Q67/GLU1E/m9Hb
         pwRg==
X-Forwarded-Encrypted: i=1; AJvYcCXinveHkbQdBSyFBIdDwoC04HN8XuDs4ulCmqTeGfomLBdITz23nnERFirMhNu3VvlsiuPFMyQO7V89GrQlPyHrKhpCk6C3LDxW
X-Gm-Message-State: AOJu0YxdERw9jbluXQkHStYrJLq+5mFrLryzVfsr0qawpfGcN0scMnOh
	5b3UidLk3EzKeqGFvLfJDVpw1Qwl7LQlGkz4r1vhCG7KMqp+akJUcSpqdT3nGwcs42SZO5uqIUP
	GPcv2W0wXupDAIjIOwdNgsIDvaWm27Cy2dAOS
X-Google-Smtp-Source: AGHT+IEGX2YvDAlwHw5zhD02VOBMuH0DnYvAIKGloKCdFuiQUNwMPYvJRQMJKpA8tlS+sgFGVQRJjr/2DPuwM0HkCx0=
X-Received: by 2002:a05:622a:102:b0:431:20e1:a28 with SMTP id
 u2-20020a05622a010200b0043120e10a28mr424974qtw.22.1711063353166; Thu, 21 Mar
 2024 16:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA1CXcBqcyXma1kGwvfAQ5T24dmuH_Or9RPrVqxDoVq=N4Se3w@mail.gmail.com>
 <20240321143200.1854489-1-smayhew@redhat.com>
In-Reply-To: <20240321143200.1854489-1-smayhew@redhat.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 21 Mar 2024 19:22:20 -0400
Message-ID: <CA+GJov6XaVHsBD8NjMAUP476uxeup=Gv_2tc2ajUEkcFRZO+ng@mail.gmail.com>
Subject: Re: [PATCH] kunit: bail out early in __kunit_test_suites_init() if
 there are no suites to test
To: Scott Mayhew <smayhew@redhat.com>
Cc: brendanhiggins@google.com, davidgow@google.com, npache@redhat.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:32=E2=80=AFAM Scott Mayhew <smayhew@redhat.com> =
wrote:
>
> Commit c72a870926c2 added a mutex to prevent kunit tests from running
> concurrently.  Unfortunately that mutex gets locked during module load
> regardless of whether the module actually has any kunit tests.  This
> causes a problem for kunit tests that might need to load other kernel
> modules (e.g. gss_krb5_test loading the camellia module).
>
> So check to see if there are actually any tests to run before locking
> the kunit_run_lock mutex.
>
> Fixes: c72a870926c2 ("kunit: add ability to run tests after boot using de=
bugfs")
> Reported-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

Hi!

Sorry about this bug. Thanks for the patch! We should definitely add this c=
heck.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
>  lib/kunit/test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 1d1475578515..b8514dbb337c 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -712,6 +712,9 @@ int __kunit_test_suites_init(struct kunit_suite * con=
st * const suites, int num_
>  {
>         unsigned int i;
>
> +       if (num_suites =3D=3D 0)
> +               return 0;
> +
>         if (!kunit_enabled() && num_suites > 0) {
>                 pr_info("kunit: disabled\n");
>                 return 0;
> --
> 2.43.0
>

