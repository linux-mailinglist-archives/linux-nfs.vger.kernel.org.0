Return-Path: <linux-nfs+bounces-13101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4989B07362
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 12:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC721885D0A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F122F3C18;
	Wed, 16 Jul 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="n4qD0Ysg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB012F0059
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661733; cv=none; b=caK+NtM3oiWKA8hZJ5Q0XLR+7vWg1Cgs6HTs+ztfnJJriri81kWltQQIZHUUJUA+hnJ33YhOt6UZFNi3i1M1K/sYZPFNZ+JwcsEicXQISSkbLvWYRbWfuGw2f+8IPl0vyR3SZfXYNszM5opg5M891pyx+nisrsOubj7cAFzJrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661733; c=relaxed/simple;
	bh=jcojd6UByMQCIqf2Na3xMr9p1lTpkVR0JODM8ec0oyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhwvBJDRrvmt0J8WjNCO1hQn4n6mkXBzePuKgZLRPA7PXLpEWNDqZju78sNmmqp2CEkiIu1bsJ+Yya1WpNVm6DElJWGdKLsFbyUoe9Fz4T0FO01XX3kfCMHpVc1bGEWh64CKLnHY1YmOdejfOty4BhRMEyThzLOY7PqRv+oOKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=n4qD0Ysg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so12330027a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1752661729; x=1753266529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcojd6UByMQCIqf2Na3xMr9p1lTpkVR0JODM8ec0oyU=;
        b=n4qD0YsgvYrym0slUMuvRS4pZ5A9H5qhA3d7aRZdSnmgnC7N4+p6w3G6sWHzsG5X10
         4H1kpDiPgOg75pLWcCCJjNJ5vj2i/v7UwT2VoG1825RSX/P1qF3c9huLuRGivqLlpKWi
         ecCXl3YS2wKm/z6FAcVKxWSiYV8FtjPwtGXELPE/jDoekiXCicGMjeMfNTS6iWEQGfIx
         2vyiMoPQ7I+RM6X7J8nmJ5TdyQG1IJcDDOphmJf8aeA2oY6DiQLDQ/nOjl+nnI22I+OD
         /YBGQCZ9dDvZ9H6mFgr9BRCF/tL5/Y+ZPQVV3w9u+iYFjjUvUg7rQ5gL6u2UP8iXRpbd
         /NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661729; x=1753266529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcojd6UByMQCIqf2Na3xMr9p1lTpkVR0JODM8ec0oyU=;
        b=t+Voe8A0N09Z1XTLZXLtVHjuf6mHHWGlYXZ6pRbgRB29djNW7yRK8fJpZXONAQjRft
         HAIMvkwC9Dc1t2QvagmiCGpD1p7+jjiTw2wgTbYZ6Seqfyb37IbAeZMi3uO4FQO1e41D
         CFIrzhnoA4A0Xkd+gxcvlQvnr7IVk7PhdcVmPEMEkR7336SZqXbk3X09MWcpjInQLJLF
         jy1EmTMvjDpccpCvFHfVa7lM+5c1p/tgwhQPhNO5nWphdnU1hLGlvxkCHqYlqMhsxWoI
         zUWjRtHxLJ44jpifswA8kVowmJ5YYtD59UQ4GJh1aTksIYju/wIQzIWKXDPf5IHuRTm2
         b2/A==
X-Forwarded-Encrypted: i=1; AJvYcCUGNAnujd6PUeJptrW2MsAFc4m9K6e78fJDELhrQsoytU3a5DJP4gJ92JAWDA8JjFye/zYawTcupz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSxamcliqB2MnUdVYyS65V+eSfz+r9Fu2OOEjw8p1vml7LAff
	txkfbt67NWeG/s07K5IJ6ruO23vPOD9Gm1JbwYfOEds512Pioe3NwhIaEq9DPWK5ADkkoh+OakP
	mryVyr3FVloRvzs4zrL4s85u7nAUJ/RIaaQScFcXYgw==
X-Gm-Gg: ASbGncvnghCbhbICQZISHPrXomCJmDTW9YKqiwqTuwOi2yPx1LKMuCGO0+pUfjx1gwE
	PGS+ZNlb7UlZvZo8mlPLTdr+HR5rqMLNrk2Trh5midaUJnKzQd9xNDRz4TFPliLbhFSZHTWTAEa
	WzhQQR2KRIRmnvh6Kou3mfAmgTTFrANJYLakY77czwKsSc4Faqyuo06z1nSpMM/RShuejGrQZGh
	6X5Tw==
X-Google-Smtp-Source: AGHT+IEomnlkOp1I9eIWkzjKNJSGoJ3UitnJMYTew2/pQBEiZYEn2EoSxbRUeTANbpDpcYbWZBvt6TTf3V0uUXbCuK0=
X-Received: by 2002:a17:906:7308:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-ae9c9996120mr276115966b.21.1752661729256; Wed, 16 Jul 2025
 03:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714224216.14329-1-snitzer@kernel.org> <CAPt2mGOwiXi3U5X3Pq1f425VmsKRJOSn6zA1S6CdoDx_twsv2Q@mail.gmail.com>
 <4947075f-8417-47e6-8712-295500d0a50a@oracle.com>
In-Reply-To: <4947075f-8417-47e6-8712-295500d0a50a@oracle.com>
From: Daire Byrne <daire@dneg.com>
Date: Wed, 16 Jul 2025 11:28:12 +0100
X-Gm-Features: Ac12FXzgn2PW9bcEkoSFD6HjAMJYenkJHu0akwz802VaAnPHYSUWQHokclWm1wc
Message-ID: <CAPt2mGP4Sawu5qfDDyYg+Jf-LickZJyY811CnxKpbU6KiAdpFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 14:31, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 7/15/25 5:24 AM, Daire Byrne wrote:
> > Just a quick note to say that we are one of the examples (batch render
> > farm) where we rely on the NFSD pagecache a lot.
>
> The new O_DIRECT style READs depend on the cache in the underlying block
> devices to keep READs fast. So, there is still some caching happening
> on the NFS server in this mode.

Ah right, of course. I wonder how much we actually use nfsd pagecache
versus the block device pagecache then...

> > We have read heavy workloads where many clients share much of the same
> > input data (e.g. rendering sequential frames).
> >
> > In fact, our 2 x 100gbit servers have 3TB of RAM and serve 70% of all
> > reads from nfsd pagecache. It is not uncommon to max out the 200gbit
> > network in this way even with spinning rust storage.
>
> Can you tell us what persistent storage underlies your data sets? Are
> the hard drives in a hardware or software RAID, for example?

Generally SAS attached external RAID arrays. We often use another
smaller NVMe layer too (dm-cache or opencas) in front of it (LVM +
XFS).

But really, it's the 3TB of RAM per server (1PB disk) that does most
of our heavy lifting. Our read/write ratio is something like 5:1 and
we have a pretty aggressive/short writeback cache (to minimise long
write backlogs). Looking forward to multi-threaded writeback to see
how that helps us.

> Note that Mike's features are enabled via a debugfs switch -- this is
> because they are experimental for the moment. The default setting is
> to continue using the server's page cache.

Yep, all good. Like you said, it may be that we are more reliant on
the block device cache anyway.

Cheers,

Daire

