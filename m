Return-Path: <linux-nfs+bounces-17099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA69CBE0DF
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 14:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E229300658C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B42F25FD;
	Mon, 15 Dec 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKA/X49A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773EE1E32D6
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805116; cv=none; b=dj72IEJOyJ7+oRMew67tol4n9prDoztF9LNLdSQ29cU9S0sne+2mwDzsrSVlU7uf7Qt0olVSDsKAitzpssXTG0513NbnQLPLJfwpR9D8Pcv4fx5b0qt1ioCzVYZYdVX0j+Dv0RqR6ETjgxVYsW5VwzgG34W6ytHJEDWVgdkiOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805116; c=relaxed/simple;
	bh=nxqUpg7tvUoSSPX6RAQBVgKYhcdHs1acMNVHCihOPCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XWuzrbo82TfJ9HJTYHhJTFJUdxjzMzXxXTzY+ImlAyQ15H3xvvXZSFc4xDACmVzhNZ44AhiNdsA8I9gYV8wCyUoYUKxSqJJdeuK9wTxJdoIXuUh+FkXAtsT6ObzCI+kl+O1cVlRLIye1yRnUW72IDm5eWfI5qRuY1PwrsxkvWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKA/X49A; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so15532935ad.3
        for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765805111; x=1766409911; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvH6iLSVBk8Uhji2udOit1YWQrLQoWeZLFlpmQZs7gk=;
        b=UKA/X49AhgHK8bLriarxzdsE2nn5bCuj+RArces7eZZ/dTURia+CAWR94hcY6NDcT6
         Tqcmql7LBwged6fNOaqr2tPKjDGyOThPGywQDP/AxtBadsntDONj3PA4Js/2XVS89gko
         RPIcPP2R3jplWF9SyBlZw9OCScyoDbxIL4GTNRaxNSAphk04v+8A5bIOm0Mmp/SGIoe1
         ORpevj33bTkKiOc5pbXH6S3AhQOMar8DuIOgvL2sHPoMHW+VHrS96yyJDr2JsPHHiwu4
         Gfvo4FhuBhKSlYeffFJ55CsJ5P795t951xRsw44+PkPKHmcN0gQmwyAccUjBvYV6ob3H
         Plyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765805111; x=1766409911;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvH6iLSVBk8Uhji2udOit1YWQrLQoWeZLFlpmQZs7gk=;
        b=YDEzLaHIduaxXIxkTuHZRLAfYuzd/lkmB3wpLnrxZTFmdLR8QCCca3zLTsiw6t5rlf
         9k6HvwSripWaEtBhss0cLqVdmWm5yk8NQWU1z/6mT20+JV+0ILKcIyrrsKT5/1Cw5A74
         ArfwrLwsU1qKKFcqhtVH4GGESn2rVWMqKCYqycVNDVTIecSC1WGre5aOGJNz0i3WWlys
         wuiGx5CGoJxGTfamFtJHP1aNplIl7Scn/1oHIcU6OYoPTCgocBMYkPCLSCLcTdSwtYr7
         UA0PwYbPEzexb0g39oWB2ArLVpTGUVMSznZbeKUfNY31/Cj8vsErxRXUgTLyLWWF+ejB
         sVoQ==
X-Gm-Message-State: AOJu0YyCMHLmoFoUS4b8yJQtQRh0kV1ux1AbH/EimLPHIpjOO7kSGwgb
	i5FzIhwfyBqI7QMBOKL5GNN1Jyamrtb8hKREB9q7ZCoanva9X4Ez3tjQsHpzFFjPpeckVWp9S+2
	B0B43i5UFP95pt0v8wKE7jQUtkaJ+xsF97YVUvhM=
X-Gm-Gg: AY/fxX4Ngani5/dg4Hewf4TuSr89upQgYWwSDTghN10vKsj7ArgWL79U+f1x7MU2d2w
	o19T8tXFdgbRW4YWE7sfHbeWPgXllSB+KKep/I/9aFmjeBqHfyNkVf1Dt59dmuqHeFizNEDdoFr
	moXkmOfm8fYhJPoYNBzvJH0l/3wKefMTGhmi3MPVmfO9mBNu9duk6iXvYjwVk3VBRiyL7tLI8EI
	0OcZSkO8DW6mNaRtSOw7MfLztnZ4N9MlWC8DOa5v6+Nu91TKt4xrIX/Ri3eeLYToGul3jUUN9EP
	9GNG8U4=
X-Google-Smtp-Source: AGHT+IEoEhnQyBzD2mlKiMbtnE/nLJp0p6gZCW6XS1DIabT6NIZqtiBKrapmwd4czOEGbCBXdKI+GeNgbKEv6baFvIo=
X-Received: by 2002:a17:903:fa7:b0:297:ece8:a3cb with SMTP id
 d9443c01a7336-29f23e55212mr106792455ad.25.1765805111433; Mon, 15 Dec 2025
 05:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH=ewnpN0rBh6vNN_Ey0rr5eK4vEz3kyaM5ctp5Ze6FCjxWQ8A@mail.gmail.com>
In-Reply-To: <CAH=ewnpN0rBh6vNN_Ey0rr5eK4vEz3kyaM5ctp5Ze6FCjxWQ8A@mail.gmail.com>
From: krishnanand thommandra <sendtokrishna@gmail.com>
Date: Mon, 15 Dec 2025 18:55:00 +0530
X-Gm-Features: AQt7F2qk0Ii6SQttNka0kgpxBgjl4F94R-28p5D443VZGX8dCNmemjn6OtsBixw
Message-ID: <CAH=ewnpT6dz+X4NjctU7j2TUphRyA+RnO05Y--xAyqchX1vfDw@mail.gmail.com>
Subject: Re: 5s stall during openat
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Additional info

I'm using NFS4.1 with sec=3Dkrb mount

While looking through the serialization mechanisms, I came across
alloc_seqid. I'm not an NFS expert, some googling and LLM-ing
suggested that seqID based client side serialization is not needed in
NFSv4.1

But if I change the alloc_seqid in nfs_v4_1_minor_ops to
nfs_alloc_seqid from nfs_alloc_no_seqid then these stalls don't
happen. Not sure what the the tradeoff is. I'll continue analyzing
this further but wanted to share this info, in case it helps.

On Mon, Dec 15, 2025 at 5:59=E2=80=AFPM krishnanand thommandra
<sendtokrishna@gmail.com> wrote:
>
> I'm hitting this delay
> https://elixir.bootlin.com/linux/v6.18/source/fs/nfs/nfs4proc.c#L1803
> when running "git lfs fsck" where the gitconfig is on NFS.
>
> Based on my limited debugging, different variants of the following
> sequence are happening -
>
> 1) open request1 sent by client
> 2) open request2 sent by client
> The open modes are same and so same nfs4_state is used.
> 3) open reply1 is processed and close request1 is sent out
>
> Since close is async, the nfs_clear_open_stateid_locked  (from close
> reply1) executing in a kworker context races ahead of the open reply2
> processing. The open request2 processing happens in the process
> context (since synchronous). Since the nfs4_state is now closed, it
> can get re-used and the stateid_sequential check in
> nfs_set_open_stateid_locked. keeps failing for open request2.
> Eventually after 5 seconds of sleep, -EAGAIN is returned and things
> return to normal.
>
> I'm not sure if this is expected behavior. This is happening quite
> often in my usecase and so want to confirm if this is some kind of
> trade off for stricter ordered completion processing on the client
> side
>
> The 5s stall was added in c9399f21c215453b414702758b8c4b7d66605eac

