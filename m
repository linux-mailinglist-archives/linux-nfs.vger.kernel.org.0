Return-Path: <linux-nfs+bounces-7045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF359999A0
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 03:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E621E2859D4
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51910A3E;
	Fri, 11 Oct 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JSCg7dbs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40756EAFA
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610738; cv=none; b=pJ0JzVtOgnzowsoF9T3AMRGKdTmt7QpGbIVr6/Hbo48Fso35j8KxU3x95xqYc5uulZZDR4A5qNdTNRX3dl5bIV4tDk7+EuiutYVMDLyibX8gzMyfKEwPzYwvXb2cNzSgBIRjvml/C3C1pQeRx0iybdcmO3L/rAQZjgRdxgbfOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610738; c=relaxed/simple;
	bh=9tJXSsQ9fSvcpkQGEvBg2L68OGr0KwcdVp0VeMEtExA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOERTNhXKhlqsGp6jWrTDHWJad1YZogAI9QnwHvvivy0fCmf6fFwI1deAnj/qGIP3UrkcEfMJ3I4cqTfHPjUjJkC1vvv9b+b+4E3z5JqZlNVoA7w4bADDHwrzW6aa/tQFjmH5J4o49OEmokxsETUYKAptnMbLHvOy4byPweJCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JSCg7dbs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2921b617beso67076276.1
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 18:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728610735; x=1729215535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=JSCg7dbsLrzz2Z4F7/4WhtnEh8Ni8l0mm6RCMLDgsI2tctqgNbvd5Gl4acrgKk7mtw
         82HqGBD8uC8gf+svvHOMvucERy7YIRytPO1b14sAaDoCjXK4kgUqOi28GftMSHmvQEVx
         HeflE8bxjuuADOiB8wnDYcwZy3JAC0fwyPj819EBeZBpnFFg3Jmc27yIeaikX7o5o4nD
         3bQLiR7XNRBJSMQXJCaqlt0qCkf/B2R1DcErvCqPFedM2i2JoJf+AWSMNcceyPovU3uZ
         kRLskDTU2vvEdO/MVMdQewQNhlpBXqy7PxkUey+1M9gf1as0jxayQ0CeUPG0U1ypTbA/
         VTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728610735; x=1729215535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRcd9cwIZFh48Jk9iJ5FWFlPG9snV80qLzRLo6hXxJo=;
        b=SwnhrxzQ7iUQr/BA9G3vifEYid1UXzmLVEW6gaxEPPbZluG9jG0CpmSISFHzr1ACst
         /BWNd0UARMWiiQwXy37G5d/NzxGZQLLWd5Ke/NYGPzBvxU6nTlmO8YvwsDyESzxBR/d+
         GTT4ALNAsbtNlaDxmoOi5kksjYOR1zVD9iTkXTlDpyS7QUZpWtClPfeqTCtDX1cHwjW7
         antZ394nnDDxCnmVpu2DGulxz+8XpkqE8S2DLGeezFJogaNP7Mc+AWo9EuuIG3n7lM9P
         /o5AjR/t6KUzlCUzAqEqaDtJ8pKL0SJgKlz2UI2lKqKHn930q5g7kK7cSoUUFXOyK+5E
         XPkA==
X-Forwarded-Encrypted: i=1; AJvYcCUNwfgQwbdGa1xKoH8wIISTcZBkLfXmkpzfmzlFqbcEOGpp4iXbhwfB/uHYpk828Ur+pXXHo5L/aMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZiQ79hN5ko6cfBxUG6bAZmmOsYj2QsjwQ99Qkl1WvGzPJ9K2
	ftLl91IgZc0IHviPc1TV4L4x+/RfizbuQKB8+lbfjhkFzhYg/iWhyp4bkcyj/J2tUHiTf/MKEla
	/56l0DJ4HyQEzydW1zwDSZpqHKaZoDvtvhqd8
X-Google-Smtp-Source: AGHT+IFvoAiqQTsFIOJfK+l/01uP1b8r2mlIlEpP49rC76iACwSSk+CMcgg9Ira3XeXkyuN2zyckIivG5f2h/gWZomE=
X-Received: by 2002:a05:6902:124f:b0:e29:6b8:af3 with SMTP id
 3f1490d57ef6-e2919df898fmr992944276.44.1728610735214; Thu, 10 Oct 2024
 18:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-2-mic@digikod.net> <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
In-Reply-To: <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Oct 2024 21:38:44 -0400
Message-ID: <CAHC9VhSJOWD93H0nPTCdKpbM2dDnq65+JVF1khPmEbX_KhHxsQ@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Oct 10, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <mic=
@digikod.net> wrote:
> >
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >  security/lsm_audit.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Acked-by: Paul Moore <paul@paul-moore.com>

It looks like patch 1/7 still needs some revisions, and an ACK from
the NFS/VFS folks, but once that's sorted I can send the patchset up
to Linus marked for stable.

--=20
paul-moore.com

