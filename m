Return-Path: <linux-nfs+bounces-2609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB5896400
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 07:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB7284BA2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161946435;
	Wed,  3 Apr 2024 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a72jZTAw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15946425
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122217; cv=none; b=ra8lhJiszfFlFndC89ridLcbMqTPe2TpmXS8E71mHGqOblYmENiSUqnP4M0ZV6bGRGLoQBEdfcKfDEBc6UmaV3e+kqrW578Icrp8fcHG1J94y+VIjP8eqKsUxG8d/VgcbovRKACHu+BbV4MUHVUoAJqZv5rGDjC2cgSq77PhJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122217; c=relaxed/simple;
	bh=yHyVNMxsKAp75gfI9VYRPpTStwqbrbOdktJDkj1lu70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Rhl5IHRClCnjpoRrMOGhA+i+EGtTgFyauREKUN7I1Fh2QJjM9YIIAeSN3aRzmKPITL468DbqNaHyyhM6OFhSO6OcHAZHxTZ+9clNAamYEouqESfPOJmuhh+TOqqpIrNiWeaNFPzvHnFq3TH1PBdodXUlv9td7qlw4UAJwZBYYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a72jZTAw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so877319a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Apr 2024 22:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712122214; x=1712727014; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkez5Yg+zYroB7JVTi/Ayf/Z3EZLR2gXl0JVx5G2w4k=;
        b=a72jZTAw8YOJspdZ4899grZF5C0RS7NgIZd2flogOnIjk1veeXRuLJobt8Du0c/AhP
         xdsknedaldoQAxqwpK/GSyzLiHPJsQxoSpYs9//Z1iln/X3SN8ToXWhmpDTesioaR/qg
         3ZCCZyGllPqJZT50NtmdYCYg/I+bgy0/+vuBQlQ0dDZi89RWV8NcqqzSR6kEulhOcbQp
         C6xafy3FIoXK0Ofk3WNk7twKxbX5A/kDxQZJWvxqUFXPGJBtXX1gIDibgB/PeA7vo3B2
         htXS/otrPOYwfm6oEEAghuDbffyls8NuBUOAvbi6blmfiWQTaetHFiIxgbc4dMz3lCz6
         /sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712122214; x=1712727014;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkez5Yg+zYroB7JVTi/Ayf/Z3EZLR2gXl0JVx5G2w4k=;
        b=GRxH/QK8vLA+ROc2mgymZjMpeKkhHtwIhfHZAOejwybitCAVH0TURWCUvEW3B2HB4c
         kFLx0GzCDM+kKsMByEBabyzzi8nPXpGTFKPZNV7ShFPucBu0Y48IQQUv6SfGmHuM20ks
         xPG4PQnpdArZ6MFdMUA8u5xrqQpfK8NKdjO89+jkK8LsWV5jgCKi1qEoAZJgLGhJR/kt
         xeJY4XsmBtb4rx1u2J071sP8ngm94+IatFGVSBADH/S8xMh+TT0RsxZ2DDdXneoBCD0u
         R7enUyp+mp7OnFREeHNLVw7kVy28iWNAOc/6V1/Ul4hqier64WNuvvrdMza2lygk//eQ
         7RpQ==
X-Gm-Message-State: AOJu0YyGTpqr3Bzte0LGvHjPkFJVDu8RZvsWKM6f9ryYbfc2Qf8cOTpA
	mO73aIDNP3U6i8/B2IprIIgo4e8tieUEofp1Y/O2O+4JIu86pwf52/s+8t07t3QCcbr5BBBBfKE
	E6ziQZo/5B+qvy8y2WYwAb18YSrNWsrDV
X-Google-Smtp-Source: AGHT+IE1CJg3GmAyeEIn4zS/PW5VUwlGIqT+VRAF2d70Z+xyP/oDqfRcl9A2i5I8p0JKjyYuKtN2KfKqhZa0rf0Djg0=
X-Received: by 2002:a50:9554:0:b0:56d:e74a:2730 with SMTP id
 v20-20020a509554000000b0056de74a2730mr1367257eda.0.1712122213719; Tue, 02 Apr
 2024 22:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171208672277.1654.1052289246945629541.stgit@klimt.1015granger.net>
In-Reply-To: <171208672277.1654.1052289246945629541.stgit@klimt.1015granger.net>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 3 Apr 2024 07:29:00 +0200
Message-ID: <CALXu0Uet83m1hX05vt9qYO+xmDoPfNYZ+r09y9FJS4H=ahyjwg@mail.gmail.com>
Subject: Re: [PATCH RFC] SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 21:38, Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Jan Schunk reports that his small NFS servers suffer from memory
> exhaustion after just a few days. A bisect shows that commit
> e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single
> sock_sendmsg() call") is the first bad commit.
>
> That commit assumed that sock_sendmsg() releases all the pages in
> the underlying bio_vec array, but the reality is that it doesn't.
> svc_xprt_release() releases the rqst's response pages, but the
> record marker page fragment isn't one of those, so it was never
> released.
>
> This is a narrow fix that can be applied to stable kernels. A
> more extensive fix is in the works.
>
> Reported-by: Jan Schunk <scpcom@gmx.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218671
> Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")

Is this bug present in 6.6 LTS?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

