Return-Path: <linux-nfs+bounces-12239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC3AD32F7
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7227B3AD1CA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 09:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A8A288C2F;
	Tue, 10 Jun 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR5384mK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0728B406
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549586; cv=none; b=ts7d6W7OW9X+S7ltHObrg+RDz9EyMm4t5CMiqCLSTywvUBXXis1alZfs76KAkCCmGajgNw3PG3s/GDmYvh+HYc6y9gxTFtPGPIgSU38+RNVxZVbWqY7vRMsMs9QPZVRJqm8EhiLqsp53IGfTLeGmXdHS2y1NE0TOaUpw4P5reuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549586; c=relaxed/simple;
	bh=vsQ/1hBqp9KKc+MK08/O3Z79/1OR+yDftvnLJIQmgTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hZSuSWy84qDZN1Zl5bUwit8LKZDILlwzUsT9SpuFHzm4Owgs5xlJsubdW0BvJXK9d+zo//6oQK5gG0FSWkBh7HLoRxRtwwUMK29AC7Wg3F4YLDqj8Gr1HjyXbUp794QXfEOR0FcwpRi2NEJJk8Zw/s3L+KLXJKCyychIdpAYy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR5384mK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3545304a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749549585; x=1750154385; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zyqF80XpvGRW1w611hOh0DERB+qzKWTaGwTPWvVV+4=;
        b=bR5384mKxRljmE3EsAkpD1x52M/L2CUslvRhJTQl7xGeUE8V6iyigmYVuaToiMXqVs
         FmikLEFSwU8pq6+NmybLOFHvt5/GMTjfjP2qAKHRC8kjGmElm4CriNUEz1YZrpnDJ8ie
         o5nOOADLdAiqF4BYpDIMFv38v6vNpb4rtTl3DIik1JO1VgiVmy6n5CVMikXjBH6SnDvC
         iTbAojO5htC9XY7zfNDH0pBvVZH3ec+pt4GvyDP/zB/yH+8WWL0YtYL6/41MwR5yX2jf
         itEl1nijF2n2lHymfLEB3736iM5FPtKPB3AMk1WKfXgVIQA/r174TmuM3jh+QVOktnEB
         eyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549585; x=1750154385;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zyqF80XpvGRW1w611hOh0DERB+qzKWTaGwTPWvVV+4=;
        b=JWTN29Hv2H4hCGCN13X/47YtevSxD+8kgG25HLoLZIWFbiMbFD1c3g2EHcNLbmsn26
         DXMfHIxvov2B5MKUdqOWuot8soTy+y1G6lKs9QwktGYVmY4vVgi9/oqfY7zqErsGC6wR
         0QTiOyFgW7A8c+g+BbtJzjcb1s3DiW0NtZMHati32EBObMX743PcIchbyJMdeLJeBO3M
         DVzZZzn+QYlTGYbjD/KETen+kJ11UUeE3Wwh4OwyAzqVJ4KJkLF7VwfsgLDGjp6395cU
         IuhvaLivlpmn++X9g+8y2sVvgwogIR9qF0bY4N53+hwEepOdZwz7BAPFziwuCWewc2dG
         ufUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW40Tan9oPZFnoZrzWvgK9C6TPgfQ1+saVD0CRxyd1XbOKkg6y7ewWoL2MORlo/x3T0sXyrRLA/2VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVRP4GC8QtyXfxfR/YbzHyofLVcLHeG3NR50fg6RP4WKP3ms4
	LoffIpQGir2MF7KYGiKt+/Cz3ae/k6b2oaeUCHMXmK6/D65OcI7P37M//k1Y6kg2NRuZpBU51Jm
	CRsRy4zKE6jEaj7Q4egiuzs1Wl+NDX6St0g==
X-Gm-Gg: ASbGncte4CHk4Mg/1fMAInZ0ELsDxBmUw6r2pRLfdIPT6IiGzJC6y9grISrLo50WOCC
	WS93viN7px+zlWOpIWHr1Xsb2RVokDhuf2V8dVYROSWDGcsluOXryPwgNSe2hPqiLmLJk0/kOSo
	JDmP+p8Vj6qy0/HVNE50oFV9CdKa41swB41Rw4CX1dQ18=
X-Google-Smtp-Source: AGHT+IG1vnSITTLTWBWc3wxRooCFs4lHV06YUiUPqpAyhP1Y9C94W0GaglTQdv0Axqr9DZzcjm/z6vRkxmLijUONq/M=
X-Received: by 2002:a17:90b:2701:b0:311:b3e7:fb3c with SMTP id
 98e67ed59e1d1-3134769e983mr20493086a91.31.1749549584504; Tue, 10 Jun 2025
 02:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7kfqToA8p4-=LOnhvZuk36vocy32U6kgT+561uOWR_iQ@mail.gmail.com>
 <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
In-Reply-To: <f84bed7e-e96c-4a7e-95e6-2a28a574947c@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 10 Jun 2025 11:59:07 +0200
X-Gm-Features: AX0GCFuVJxLzabo1-gPGn9ED-A3mJfHk9032K_O5wYTJY2NNZgn4kHYgq4SA0aE
Message-ID: <CALXu0UfWN7ahsYQfvHVLViuxfb+oOsjQR8GzCHKwhPnctoV3Nw@mail.gmail.com>
Subject: Re: [nfsv4] Re: simple NFSv4.1/4.2 test of remove while holding a delegation
To: NFSv4 <nfsv4@ietf.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 02:17, Dai Ngo
<dai.ngo=40oracle.com@dmarc.ietf.org> wrote:
>
> On 6/9/25 4:35 PM, Rick Macklem wrote:
> > Hi,
> >
> > I hope you don't mind a cross-post, but I thought both groups
> > might find this interesting...
> >
> > I have been creating a compound RPC that does REMOVE and
> > then tries to determine if the file object has been removed and
> > I was surprised to see quite different results from the Linux knfsd
> > and Solaris 11.4 NFSv4.1/4.2 servers. I think both these servers
> > provide FH4_PERSISTENT file handles, although I suppose I
> > should check that?
> >
> > First, the test OPEN/CREATEs a regular file called "foo" (only one
> > hard link) and acquires a write delegation for it.
> > Then a compound does the following:
> > ...
> > REMOVE foo
> > PUTFH fh for foo
> > GETATTR
> >
> > For the Solaris 11.4 server, the server CB_RECALLs the
> > delegation and then replies NFS4ERR_STALE for the PUTFH above.
> > (The FreeBSD server currently does the same.)
> >
> > For a fairly recent Linux (6.12) knfsd, the above replies NFS_OK
> > with nlinks == 0 in the GETATTR reply.
> >
> > Hmm. So I've looked in RFC8881 (I'm terrible at reading it so I
> > probably missed something) and I cannot find anything that states
> > either of the above behaviours is incorrect.
> > (NFS4ERR_STALE is listed as an error code for PUTFH, but the
> > description of PUTFH only says that it sets the CFH to the fh arg.
> > It does not say anything w.r.t. the fh arg. needing to be for a file
> > that still exists.) Neither of these servers sets
> > OPEN4_RESULT_PRESERVE_UNLINKED in the OPEN reply.
> >
> > So, it looks like "file object no longer exists" is indicated either
> > by a NFS4ERR_STALE reply to either PUTFH or GETATTR
> > OR
> > by a successful reply, but with nlinks == 0 for the GETATTR reply.
> >
> > To be honest, I kinda like the Linux knfsd version, but I am wondering
> > if others think that both of these replies is correct?
> >
> > Also, is the CB_RECALL needed when the delegation is held by
> > the same client as the one doing the REMOVE?
>
> The Linux NFSD detects the delegation belongs to the same client that
> causes the conflict (due to REMOVE) and skips the CB_RECALL. This is
> an optimization based on the assumption that the client would handle
> the conflict locally.

Does Linux nfsd have a setting to turn such optimizations OFF (all of them)?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

