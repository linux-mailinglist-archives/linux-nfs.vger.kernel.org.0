Return-Path: <linux-nfs+bounces-17499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02280CF93CD
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FF1A3008194
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48832EEA8;
	Tue,  6 Jan 2026 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFndV4Tl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CA312807
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715385; cv=none; b=Kgloq145eN1aEgEWmQ/7jZIwNXD/6IY+5O7wO6E9lSFi6mKwet6vxNQ9t+lZDff+l3At++mvQGUEDh4DH7ipkmrvX8nXDJ+kPfNboNEWmw1yhRVZ4lajFqCOKb+/EMZJWZAie/ucmrC2nC9J5loqBucmtC1NVBjffg8S0O3Ayqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715385; c=relaxed/simple;
	bh=Pep7s37Tg5LNJyrfEFPx7639i+MGhTnD7oLDJcjHysA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fH6iRHvTO8vCRPK5WBCK6ejw3DXfUAE9Q+dwI5CQNgouVe/ETANF1YRDbptQ0MZnCYn43j+AbQIm6Hqejg3mzZGKrOgbA4KYm6SExP4lIw/U/Axoprv1n4zHmUMmMgoihxGO52Y9vQ9xhNxeLVlgT1nlqGmprUMeG/WKmYfEEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFndV4Tl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so1691683a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 06 Jan 2026 08:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715382; x=1768320182; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wo4nF/Gh1OQqmVYtsgGI5taF8MCUPW1caFjqh+dEoJc=;
        b=EFndV4TlKRubGyCVxblspBYiZGTxUcvMiF/AA+YaGRhbw88tjRpQPP0bKoiETTaDik
         cBe7rIGIKeTjj5v2Oz8PlRPM/goWharp5RGg/eus8zSqpW+rSGhNP9kTq+mpSFiiMiT/
         hnhi82GU7UUxPCS/iRzltHVmRj4JCH+ZFKb2MC+WDDCUjYkfAfcSY4Z7c5CPZrsoHpoM
         Pc9i0HDZjFWeg8G/Ie+QdmB2aEw/3vXH0RxGI0HIYPexIiewMG4LM4TVf3v7iqVpgN49
         jaN1Nr1kLGUNTu/7ArqyiGPV77adAZvhDFG9/o1zJA0xoxZc1GBPwN8FDpTSBvdK3IB/
         PrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715382; x=1768320182;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo4nF/Gh1OQqmVYtsgGI5taF8MCUPW1caFjqh+dEoJc=;
        b=bE9v9KHEOyWKMA5jJFiMVQtlU6+EUFxmv9TwmmQpkGb1TKKLh/UGLAJQpLXot5sp6S
         XbpJLvJsN0YtJcC0AjS9rYSx0pGsBw2yZhJqZjGUwEMX/yHPMZXl1Uz/w4sCXHy+XPul
         //M7k7vUPkrKQMVc3RQwHqF2bMS18EUx1eXRdPhZkH0JeooXrXfJp4dUSwy1FeurzWcH
         6174mWNg/eW74IbB/KnuSReV0hEFXTCyVf/H7xgPTJzNW5RVV3noiBvXs2Gf1HYCRl8O
         HYG9Ov6r7Avma8GLzFVBigzz6nTPW/RIuEn6XWgZvZZqMe42RwqovQqUSzgFGkkrPL5e
         IghA==
X-Gm-Message-State: AOJu0Yy3c3PWZXQxplhG3c2i7YMhd/9Fo9V5maaAmiRfmbd4VobXO4wi
	SLSGKrpwH59cXxGEEp0X5/HJCaJwL4uyz7fU+HTgo+telF4yFgJjOvCuXiPQ4iBxlnDP7z8VqJQ
	XA8mNoVvUBiqkR/fDwRM9la+m7JiLvZYdPJY=
X-Gm-Gg: AY/fxX7/jFertXXzq+7nS87/niErtKmSZtSSE9bNKiEAEfzSXvQOflY1FXFgUcc+zyc
	UALUZt3AySyan9gv5Oe87mJgUV2+Aqb4ic1qNu50g05LFuTKdDnYkRH4k+1LJxmtnytsG8ujEjq
	1GJkdu2J2T7jq0BwXI9G2l/CYPaDeqeAH9YKJL1JoefgMPrZhnHNLgT5bQU9mF/8jld82dHoAPz
	4qB/AfmmG7WloDZW1Ay/VPh02R6qxA1D9oRaWImcQl8aaUV7f9A+qFLly8oiqvrog83zYhUvJx8
	gleFn7HA+IVoEuVrJTSNNnj09rWH
X-Google-Smtp-Source: AGHT+IHV29t/MyYhQzHy+6iiIDw0E/9CBC2QJhaFJBy/uIn6xhpUHcEiMjIfYnX+3lggMcZp5+S8rNfHVXAc7gQqd64=
X-Received: by 2002:a05:6402:354e:b0:64d:56f9:47e7 with SMTP id
 4fb4d7f45d1cf-6507956b7d4mr2628863a12.21.1767715381842; Tue, 06 Jan 2026
 08:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 6 Jan 2026 08:02:49 -0800
X-Gm-Features: AQt7F2q48bWisHPWpQyza-3I2u_6iWdpLnYi6lldq2fg8d0ii2URruFm7lVce28
Message-ID: <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
Subject: Limit on # of ACEs in a POSIX draft ACL
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

When I did the POSIX draft ACL patches, I mistakenly
thought that NFS_MAX_ACL_ENTRIES was a generic
limit that the code should follow.
Chuck informed me that it is the limit for the NFS_ACL
protocol.

For the server side, the limit seems to be whatever the
server file system can handle, which is detected
later when a setting the ACL is done.
For encoding, there is the generic limit, which is
the maximum size an RPC messages can be (for NFSv4.2).

For the client, the limit is more important, since it sets
the number of pages to allocate for a large ACL which
cannot be encoded inline.

So, I think having a sanity limit is needed, at least for
the client.

If there is a sanity limit, I can see having the same
one as the NFS_ACL protocol will avoid any possible
future confusion where an ACL can be handled by
NFSv4.2, but not NFSv3.
(The counter argument is NFSv4.2 is the newer
protocol and, maybe, shouldn't be limited by the
NFSv3 related NFS_ACL protocol.)

To be honest, NFS_MAX_ACL_ENTRIES is 1024,
which is a pretty generous limit.

So, what do others think w.r.t. a sanity limit on
the # of ACEs.

Thanks in advance for any comments, rick
ps: When wearing my internet draft author hat, I
      lean to "no limit in the draft", since that is what
      the RFCs do w.r.t. NFSv4 ACLs, but that doesn't
      mean implementations will handle any number
      of them. Maybe I'll add a sentence to the draft
      noting that the limit of # of ACEs is server file
      system dependent?

