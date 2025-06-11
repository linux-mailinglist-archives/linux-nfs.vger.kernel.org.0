Return-Path: <linux-nfs+bounces-12293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DA3AD4BF1
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 08:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF45D3A534A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A6153BD9;
	Wed, 11 Jun 2025 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8NsB5hc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110BD2576
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624114; cv=none; b=SOTuznhgYsib+UjpfCxnyXBF9EBEjhW/jgYguIR3NTpr2wK6ACRRw4x3MoBKpGNSxD61j539oGZJNYhmLo+7PskB9L/r6nOWYnFO3pSbOZAy/GzOh8HuenyB+3pDHhCQBOzjT5CNhzYF+4pENmHGcAhuYnMDyIUcPQqZz5jqDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624114; c=relaxed/simple;
	bh=4ceUAwn27iCccCwkil9iIYDzThF0jr7HFxPSNsr77jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GTKwfJcg/eJ34v5+i8d12HfNJLEZ4yUn+YZNjnC8MKuNELXfZp/afYKgRpnHPcA5oCXKm+WH32gmjbSCTDaH1wxOnFyYLdngrn75KEtODL1ZMBfcAKb2VSoGbS9IGk3EVc+sadGpkeKfm9QrcckPMGUfHl4d8LxlcLuvo3Y6wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8NsB5hc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so2307061a91.2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749624112; x=1750228912; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zm2helOcE/3CuLBLhPn3/Auu5lcU/zGdJ3ypZXYgEEo=;
        b=Y8NsB5hcEscZ0ErMB8d3Ac1bD9lPnDe2OlMNgsAQVLotngYghdoJPYFX4XbPnxm44n
         TRiqn8R41c/rn/OFLU2j31nniBmgZZ39L5MfaCDeZKbcfINggZ2aq+D3WvNp3mcdKnWT
         G22OzCEsoT1ZYZcuq1Okq2pqZbyflOcTXVAxifPN4munCkAHjyfeh8/gxRvtxXoyH6DN
         ZAR17pNM/yCwNea4SUO1NnYzH95YF3phgVMnmS7B8I8sgaqloYh5ImcF36NFFISpHHlA
         7Z5qhecAJpi/+jqLR8XBZNOsijQh3M9OmdE18Yk2yxLoVvQ6hPDiKnsLPsC5a6ZmQalm
         9NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749624112; x=1750228912;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm2helOcE/3CuLBLhPn3/Auu5lcU/zGdJ3ypZXYgEEo=;
        b=LrXg8uzBu6fer55zySy9RW9p/o4BqN7S9q2rVYJChmEUuUuFr6f8GilNOjI++vz3+q
         8c0NfRsPLsj0F0cjajJwXOPBR6Mpn1iuM0DEcIrCupTZHz2RV6RZtTa8RCUuSg7qJozU
         MIOfaHnirPbnzltzkRGsE2RIfIO6rkNRjEHX6NiU7sJe1uFJocnw4UEH24zw81DAXI7y
         KmQI87tkyAWLHC4LnWqnF4q818EXHum8oesosX8KyVkpagLZm86Qu//ziXXUuEoBzeSC
         jzrXDbrUtRJPGCa+dmkUbqBVA2tQCV5P+6pkW1wI1E41nMi21r3zSDnYbNMe4gGHd584
         0S/g==
X-Gm-Message-State: AOJu0Yz+H+mpg94LVK1kjUKa4pEBq35S7OcT2ccKXPsNbBXeUaWexcUN
	w0M2EuOOMK4NRjIfxPSiqbi4OXKqvwWcjmV14GS+KrN+LIBHfiuCuubdsDMZlvAazU71WrWejG6
	cSx3ek2MYGi1eB3bS1d0u8Lre8pWY54PNsA==
X-Gm-Gg: ASbGncu6+gxq7iEoSQbQEZkJFbIpZ9ihJfA/BFfRPpvr6FFv+kWxkNSDXm3vs9qe8NW
	KjMPLyrQZWvtVwX16euJDSlj7db1uUC4ruwma9Q8NQQehp3UsFApTPnwshdcKZZXTsYigjftRKN
	b6crHKw2qiDdaPk/RxI5z/+7Rkpjt7q096oqDq2FU/g48=
X-Google-Smtp-Source: AGHT+IGUY3m/3ROfyYZW7A47VfqGPRb+eWHiUBYANFFgp9bK3LWso3ZXwL6CWvvChnmoZFdJhGnsxmwkfUor/y/gu9U=
X-Received: by 2002:a17:90a:d64f:b0:311:b3e7:fb38 with SMTP id
 98e67ed59e1d1-313af1b269amr3058265a91.19.1749624111970; Tue, 10 Jun 2025
 23:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com> <CALXu0UfWN7ahsYQfvHVLViuxfb+oOsjQR8GzCHKwhPnctoV3Nw@mail.gmail.com>
 <21771602-be31-4d82-9820-7775751ae7e6@oracle.com>
In-Reply-To: <21771602-be31-4d82-9820-7775751ae7e6@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 11 Jun 2025 08:40:00 +0200
X-Gm-Features: AX0GCFuOSpqFWRHkUBEOrdQ6HKTkyDZEyMXGJLkWuYRCgAf51aX3vrWTZUcWdYY
Message-ID: <CALXu0Ueg2KeSO9qL5U8uPitmV4N_zwP6GRVAqAmqODyjks3snQ@mail.gmail.com>
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

IMO there should be a debug setting to turn this off, as it might
cause bugs in production environments. Similar to -O0 for cc, just in
case.

Ced

On Tue, 10 Jun 2025 at 14:03, Dai Ngo <dai.ngo@oracle.com> wrote:
>
>
> On 6/10/25 2:59 AM, Cedric Blancher wrote:
> > On Tue, 10 Jun 2025 at 02:17, Dai Ngo
> > <dai.ngo=40oracle.com@dmarc.ietf.org> wrote:
> >> On 6/9/25 4:35 PM, Rick Macklem wrote:
> >>> Hi,
> >>>
> >>> I hope you don't mind a cross-post, but I thought both groups
> >>> might find this interesting...
> >>>
> >>> I have been creating a compound RPC that does REMOVE and
> >>> then tries to determine if the file object has been removed and
> >>> I was surprised to see quite different results from the Linux knfsd
> >>> and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> >>> provide FH4_PERSISTENT file handles, although I suppose I
> >>> should check that?
> >>>
> >>> First, the test OPEN/CREATEs a regular file called "foo" (only one
> >>> hard link) and acquires a write delegation for it.
> >>> Then a compound does the following:
> >>> ...
> >>> REMOVE foo
> >>> PUTFH fh for foo
> >>> GETATTR
> >>>
> >>> For the Solaris 11.4 server, the server CB_RECALLs the
> >>> delegation and then replies NFS4ERR_STALE for the PUTFH above.
> >>> (The FreeBSD server currently does the same.)
> >>>
> >>> For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> >>> with nlinks == 0 in the GETATTR reply.
> >>>
> >>> Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> >>> probably missed something) and I cannot find anything that states
> >>> either of the above behaviours is incorrect.
> >>> (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> >>> description of PUTFH only says that it sets the CFH to the fh arg.
> >>> It does not say anything w.r.t. the fh arg. needing to be for a file
> >>> that still exists.) Neither of these servers sets
> >>> OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> >>>
> >>> So, it looks like "file object no longer exists" is indicated either
> >>> by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> >>> OR
> >>> by a successful reply, but with nlinks == 0 for the GETATTR reply.
> >>>
> >>> To be honest, I kinda like the Linux knfsd version, but I am wondering
> >>> if others think that both of these replies is correct?
> >>>
> >>> Also, is the CB_RECALL needed when the delegation is held by
> >>> the same client as the one doing the REMOVE?
> >> The Linux NFSD detects the delegation belongs to the same client that
> >> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
> >> an optimization based on the assumption that the client would handle
> >> the conflict locally.
> > Does Linux nfsd have a setting to turn such optimizations OFF (all of them)?
>
> There is no setting to turn off the optimization of delegation recall from
> the same client.
>
> -Dai
>
> >
> > Ced



-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

