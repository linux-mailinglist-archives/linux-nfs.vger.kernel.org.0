Return-Path: <linux-nfs+bounces-11847-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84AABEF1E
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADED23B363F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D6239585;
	Wed, 21 May 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKVPMKji"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6423906A
	for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818388; cv=none; b=jXYXN4UEVyALyNtPSXcUKqXVVOFsj084SPeGVWBoc4/ggZXzbefeXiGsrULRgu43hDr00zzS3ApA2QFnqK5MJ3vxvKBEmG8PT4o3tRSKF4z2bU9C9d+9D8xlJUD0Ec8pc6kW485s8u+M+2+iqnH0XPOL13ToFQLUyv1eqRWzqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818388; c=relaxed/simple;
	bh=nN+gEO3hhE9zdtPjJn6u/8wIfB2ba7SHhLWxkRpga6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQXaZrooaDMUBhksia7xkdfZ5w1LtPQ78uMMQhra1FO4G9kvof/Fkio8t/Qit0M54wHxhNfDvrqqPNnMpHZKHbrMqt62YjWF3QbJkmBwD0BlUwxXZ1ETjXAAHCmSuftLrHgp/3x9hFQC5551UHcFVXLGf+VsTOSWjuJRe/9wEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKVPMKji; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad574992fcaso551077866b.1
        for <linux-nfs@vger.kernel.org>; Wed, 21 May 2025 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747818385; x=1748423185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN+gEO3hhE9zdtPjJn6u/8wIfB2ba7SHhLWxkRpga6Y=;
        b=QKVPMKjilgZEpPjKKFZGHpa474EemL10+CdUMj3bzvIn+Ov82kZ6ncMU8UwDy90alI
         4uVK3qv6GdcgzLSORBv3WZaY0GfxxGhgex2qXzMRCCo7o8RcyyuSiXMcXuXPv2OHQDlm
         seZGKUkSgxtgcZuX4S1MEqO4HgesGhBwCjKHUUqPMdRspH7luLqFTtpag2B2cYWiu72f
         v42qMIZG/ksQmqbU1v+tMAf1LwMer+hSBgRmBJvOZ3oMua9j0X+fxIfUkwPf8/1wJdvF
         /g6y0/kg3gh34i01rW1GBK8DRDMkTNC3esEi9f1XfEj8KwIm+8DUTMhsMh7n8hM4YVYS
         9iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747818385; x=1748423185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN+gEO3hhE9zdtPjJn6u/8wIfB2ba7SHhLWxkRpga6Y=;
        b=ZOtSf7IU4hV5t18vZAlu0YGAPi6MSx2vfU1Mn0zZo9C+dpo7WkMkQYZF/Mb7vfw/TB
         cklvPeURJP7uvpvHZqJNeqfYgj+Ot1GF4SJxIJCKLQs+Pn41l/E7DaD1LWt1rZ5/w0DL
         wciABecSvbfq8Wy8vRF4wFZyv9gZ7mpEgVS9/s+jRuUi7FulFNRoxQdTpphnsVA4VFfA
         Ig6VF+MbGLe5DhTQEiPLRGlufnFYJsDg6I9LreGHxDXyB97dkSCf/JjWdQ28bQA3y80d
         8cwrel5AL+q4zUoRt6Wht8EtniRxYdwYyl1DeYYpCifh+3vZ7Co3t0Q4fic7Qoh2KsxE
         QDrg==
X-Forwarded-Encrypted: i=1; AJvYcCXgljjzFeaQv1BQtAsdA51yy/HJQumV4FHNBJLPlO9EQCAJCPCHcIM2FEz7kboAfsOQyA+siPnh0bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglqhKThLLDAHjPZ5br6Y1/lsYbG34KRFhoATynGA4S8LyOmgf
	3UaZH4DG22u3dtjO/ctMLWDRkI42zEh5BkG9Ox3/oD7uiEeMR6TQEYVLPCW+rxpZtrVrHOmQ4yJ
	lteckimu7svNV9/l4WS62FGb9ClBkEtI=
X-Gm-Gg: ASbGncvOHYN9XNC0CXyaomaaX2WjoDB+X0WLmBZ2peuXXyliB2StGni56na1oSmosq5
	s6+dUWGsgxCUXQBWTLLZgA2HZk0xeaNtVkyzBGgs8RVFOvd+lLs5P+y2mgM3kNZQortAK1ywfxp
	Mb2u5CK7m5awKRikymYYAJqIV8127tXNA=
X-Google-Smtp-Source: AGHT+IGe89O7esDknbyVPVAkr49zfWLANdukmp1rj/ElsXDq5Vi5O7S7yyndbBkqUUdLq2lhLSNbnLNtDkIY9YMMcQg=
X-Received: by 2002:a17:907:d03:b0:ad2:5499:7599 with SMTP id
 a640c23a62f3a-ad52d4bf410mr1933802466b.18.1747818384592; Wed, 21 May 2025
 02:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-master-v1-1-e845fe412715@kernel.org>
In-Reply-To: <20250513-master-v1-1-e845fe412715@kernel.org>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Wed, 21 May 2025 11:06:00 +0200
X-Gm-Features: AX0GCFsFzDaXw6CgqyjMP7-MfUqL6RUY0913NiA76xmnUBAD6V4cKyUwZZg27OU
Message-ID: <CAHnbEGJJ0YJzyd525e4q6viwXXntz58C5iAGE-RQ2m87175CmQ@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: Jeff Layton <jlayton@kernel.org>
Cc: Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Back in the 80's someone thought it was a good idea to carve out a set
> of ports that only privileged users could use. When NFS was originally
> conceived, Sun made its server require that clients use low ports.
> Since Linux was following suit with Sun in those days, exportfs has
> always defaulted to requiring connections from low ports.
>
> These days, anyone can be root on their laptop, so limiting connections
> to low source ports is of little value.
>
> Make the default be "insecure" when creating exports.

I made a poll webpage for our sysadmins about what they think about this ch=
ange.

Out of 26 people allowed to vote 24 voted "BAD idea, keep the secure
option the default", and two didn't vote.

So this is a change which is virtually 100% hated by the people
primarily affected by such a change.

Sebi
--=20
Sebastian Feld - IT security consultant

