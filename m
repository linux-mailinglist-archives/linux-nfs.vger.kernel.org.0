Return-Path: <linux-nfs+bounces-12336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AA3AD6078
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 22:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137A63AAF7C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F71D618A;
	Wed, 11 Jun 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYiK6e0h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423325F989
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675488; cv=none; b=bCp7WG+HcLvhjvuShI56je/N2IoMIfxc5fZO+O5v4OL3o/pAnlATp5hBvODMhEcRE8EbmmUQARC5Hj4CwbOrLlXujODBBmbKa+kRGkLl0W8xlHmmN1HxBRqBaZvE3tj6tsENXsnhDVKTCG3KJdcgISf/xCHuG3yYWFOa71T+PaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675488; c=relaxed/simple;
	bh=+L9abmj7qBHqRc6BHr7/NhWWtRQTr6lnWMv87t4UIZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGaFQxxV9zPlFG0OoBKZ05N1sgUtvxcRoLf4YcEGxFVyPMsmrE/aFwgRgEQG+n5PQgekeFPMrVB69QdzJ00ydrxuE/W9zix/P3GYvHslUgQbKpuiFshq0TAXi/ujCRNTxukSKVbxZRz/RS4U68q8RSo9PjTiNjMlpRJPspYzYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYiK6e0h; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad572ba1347so38736066b.1
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675485; x=1750280285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/+8s5arXloy1/Z/r+/SY3L4/HQD11GjXj0RyDsDz7c=;
        b=MYiK6e0huhbWwixHt3+bmrahAHIN15g9Z8yHIQPmPfK0gbxAUFklhrDHbxjtzgqzHO
         dTD6QXbFA7uXqOIzb1j0D7h+Z7A9V+Iv0GJTFoPYaYHQudv2Mazt2qLMCZGO6MzoKA4z
         yhQU6HFBLmRsPTWwwY7ABTOzYdKlkEoWNMJjlzQSXKVTs0CQRb9yv/ZNyyOyddmpG9D5
         klrwQmFHFHn+nY1u65aX+0zs8yNc6IZjzqXbYGO9qK+XIcWPMESAlTbjzfyVqWOA5DT8
         /GtPYQ9/7EzgqsotvFbQCGm2xrJdoV7bDfxe7HYX56ZqsxCl+qAd1++oFPlmSZBqj2YU
         eirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675485; x=1750280285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/+8s5arXloy1/Z/r+/SY3L4/HQD11GjXj0RyDsDz7c=;
        b=SU4J5iCD0u3ffLwBYzTEd3qbLA1nXEZ0RcW2Vzc2tJFXU7F5hLrgALyg1x988lkhYr
         PE/xXRgXEje+gjR4qQc+d0x1zXcMiOQFzuLyPOpb8ork3HVwYcEpPBpnb/DXvficFllE
         sOfjQUOk3htSPxS8YXEKAmT9Y/yGwMWoELTVtTcbITJdHYUbKXUws26LaD2WlKa5pU86
         bF9M7sRv2FBOXiOWwwTXQYta1rqVxxpchtzXNhJD8iOvhzFcRuaLh9bIp4ecOhjHv2rS
         cBevggvA426kqLQZ0gia968iG3DRxdqUwfznHyNBJSjHyZ0Zf/6y2ByGlCM5ZvS1vI39
         StoA==
X-Forwarded-Encrypted: i=1; AJvYcCUljTRV5s86kn90pfcp2AZfTltNLALVMl0nRGrUgxWHygczYn+msTj9h/f/cfVohym9T+JQBZpLGxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbRC4qzf/A3ncKFIB5beluVKfI8ZRtzUl1UVziDz1agx3+6hA
	biuZkTd83+r6S33h9KYBm8mt7ZKpgkrMgVX/TMydX3a9BcNPlY5I5IkstgH2BOmgkzSk9TQ4s2b
	CapjkN2aLuckR9PIqt1Pn2x6YqZJ0Iw==
X-Gm-Gg: ASbGncvi4WQVlkO9fvoxV1YCIA5AyVCTlTnJMMQp1anliX8IfVV+d08H+eQy73/KCJh
	Ply0uMt2mb1sJcPGPSE4J7uz0OhpA21cqvBxfJAicp9uaBnn0Od7Gw+VQY0yW1Jt0oMCuT5PQCO
	9I3tO/SqlbP3mI9Q7jN7BuQNefb0RdlhQATfnKqpuZ6GjAauqeBIZWMZyQE3d6nHlRH4Sc0jbjT
	hQ=
X-Google-Smtp-Source: AGHT+IHRkedCNzHk1SzOj5rBmhqYdKGOT0I311OnLw4q/8F+aYgGM3ek/NMK2rM/T8JieVzKw3abHjwHN6zXGt1AVI8=
X-Received: by 2002:a17:907:7ba3:b0:ad8:a41a:3cbf with SMTP id
 a640c23a62f3a-adea9254a40mr60324066b.13.1749675484835; Wed, 11 Jun 2025
 13:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <CADaq8jd1gH1-f3Dqg+mAV2RTEwqVS-C21Be4QJT24+bNTuycYA@mail.gmail.com>
In-Reply-To: <CADaq8jd1gH1-f3Dqg+mAV2RTEwqVS-C21Be4QJT24+bNTuycYA@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 11 Jun 2025 13:57:52 -0700
X-Gm-Features: AX0GCFsWRMnxP5JwIO0MqY3cYy-Rw0dBhP7PAfQO_VRR9-I_6l6TRPz_ccR_dJ4
Message-ID: <CAM5tNy5MUCAXs_4zWy33xqOJSMk1hW5006OpLoD32KWLbOfNLQ@mail.gmail.com>
Subject: Re: [nfsv4] simple NFSv4.1/4.2 test of remove while holding a delegation
To: David Noveck <davenoveck@gmail.com>
Cc: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 9:28=E2=80=AFAM David Noveck <davenoveck@gmail.com>=
 wrote:
>
>
>
> On Mon, Jun 9, 2025, 7:35=E2=80=AFPM Rick Macklem <rick.macklem@gmail.com=
> wrote:
>>
>> Hi,
>>
>> I hope you don't mind a cross-post, but I thought both groups
>> might find this interesting...
>
>
> I find it interesting, but I can't speak.for either group.
>>
>>
>> I have been creating a compound RPC that does REMOVE and
>> then tries to determine if the file object has been removed and
>> I was surprised to see quite different results from the Linux knfsd
>> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
>> provide FH4_PERSISTENT file handles, although I suppose I
>> should check that?
>>
>> First, the test OPEN/CREATEs a regular file called "foo" (only one
>> hard link) and acquires a write delegation for it.
>> Then a compound does the following:
>> ...
>> REMOVE foo
>> PUTFH fh for foo
>> GETATTR
>>
>> For the Solaris 11.4 server, the server CB_RECALLs the
>> delegation and then replies NFS4ERR_STALE for the PUTFH above.
>> (The FreeBSD server currently does the same.)
>>
>> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
>> with nlinks =3D=3D 0 in the GETATTR reply.
>>
>> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
>> probably missed something) and I cannot find anything that states
>> either of the above behaviours is incorrect.
>> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
>> description of PUTFH only says that it sets the CFH to the fh arg.
>> It does not say anything w.r.t. the fh arg. needing to be for a file
>> that still exists.) Neither of these servers sets
>> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
>>
>> So, it looks like "file object no longer exists" is indicated either
>> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
>> OR
>> by a successful reply, but with nlinks =3D=3D 0 for the GETATTR reply.
>>
>> To be honest, I kinda like the Linux knfsd version, but I am wondering
>> if others think that both of these replies is correct?
>
>
> I think they are both correct.  It seems to me that an attempt to choose =
one of these as preferred and deprecating the other should be rejected sinc=
e it unjustiably imposes a particular design choice on the server.
>>
>>
>> Also, is the CB_RECALL needed when the delegation is held by
>> the same client as the one doing the REMOVE?
>
>
> I think so.
From a practical point of view, I am not convinced it is needed.
The server can determine if the REMOVE actually deleted the
file and, if it did, can throw away any delegation record(s) for the
file object.
The client knows it has a delegation and can either DELEGRETURN
it or throw it away if it knows the file object has been deleted and the
associated file handle is no longer valid (it receives a NFS4ERR_STALE
from the server for it).

Also, wearing my pragmatic practitioner's hat, since the Linux knfsd
does not do a CB_RECALL now and has shipped this way to who
knows how many users, declaring that it must be CB_RECALL'd
does not seem useful?

rick

>
>> (I don't think it is, but there is a discussion in 18.25.4 which says
>> "When the determination above cannot be made definitively because
>> delegations are being held, they MUST be recalled.." but everything
>> above that is a may/MAY, so it is not obvious to me if a server really
>> needs to case?)
>
>
> This should be more clear.  Will be looking at a possible change in the n=
ext rfc5661bis draft.
>>
>>
>> Any comments? Thanks, rick
>> ps: I am amazed when I learn these things about NFSv4.n after all
>>       these years.
>>
>> _______________________________________________
>> nfsv4 mailing list -- nfsv4@ietf.org
>> To unsubscribe send an email to nfsv4-leave@ietf.org

