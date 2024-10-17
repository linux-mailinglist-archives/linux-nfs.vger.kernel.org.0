Return-Path: <linux-nfs+bounces-7261-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B320D9A30E0
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 00:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAB31C20E1B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732A1D86C9;
	Thu, 17 Oct 2024 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="CyxA4Fqx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C01D5CF9;
	Thu, 17 Oct 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204790; cv=none; b=VQORldjrpBwcaoloocrdexhu2yPb1TIm3b1rdHNEpy0EkE99kBxSVLsaMdvtYjLvsqApcDECZdc4l4MYiazhQQ8DPxJcR6+zH0Oa+ikyCUWt3I7Q1ZHNMrqsn52VOP1Uv+J2BXwigF1I7/42uCY6yhEWwcw0QNe2oIwS2Sv9GqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204790; c=relaxed/simple;
	bh=h2+4a3UXLQvON98T3hAogaptHvNNyQPUQhgDLRuywZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqLfbX9bLALlrc4pf1ozKGBI3cjBb9Sh+ujxMklL4Ho6gXrw695bvzurDLV6bHEcTobSo3SPUJfINiKtQrxmLD+mlZTdHfV1U74vktlXEYNfbQmytsYFN5e3EQqLpjeFqz5EEfcmFEnkIn5bPeSLjpNdHY/FQUh/vwQQS92JgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=CyxA4Fqx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so14507811fa.0;
        Thu, 17 Oct 2024 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1729204786; x=1729809586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku9zKQJqkNLfJWKDPS+TFMCuu0WdteDDH6Fg6pzAIhs=;
        b=CyxA4FqxzKL7SWVx20VJllhD4EaB23dhN5EuLLvAHpx+2tktJz39EwU72hOKORwI4H
         ASKvtRnJxmfe9FKFlsB7Hq0LcwQYLNdDhEIiiLEKTOstTIAygQXDg7628y50mT6ulNSs
         TBX/9xAsR6fhYu6i5vGrvvRHv0ZV0WJyuU8nIJxqAvlM2wB4RoW4MEvXjuSkonCxCZj0
         J7YwBBDyreeBcsxI1kDyKyAIJ37ijmNsDSZQAAt+Tz6Ph8v7F0L022LXisjYkXMJShTc
         HRaDMaRXNA/BSmxaM3Lmej1ZV1JD2lB/+1+Kfie6dPlk+7EUAaKBkIIXR6m28931pRd2
         +XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729204786; x=1729809586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku9zKQJqkNLfJWKDPS+TFMCuu0WdteDDH6Fg6pzAIhs=;
        b=Nei5+MU7YThcAgV/fOCk+iz2wnKYnQ4wlKEo5NsEP7ILLae1bpO9KTAmlpgv33lWFF
         tqJkrQSkM5mIP+uBaooXwa9zwZA1Epuz+kDrae8AG6WolFVpfUjVFM7eMHOPjr0oa/qU
         DkutdQwUvqGUjlDusXk/+t96whMK5kxQsl4scecGJAshqtlUP7N9KpK1Tafbv1gJcREr
         i0G6Y3/iaUrHmHaTizZx4hygAw0U93NckXKV+ndqYFcnP2bJlAq+E3IceqOrp6D8dA5K
         N3AvPLUjXW4lOXwz7A0AkJoGT3jecusqCoDwQtRB825OumXomBLc6KnLwRoiqIlmgXn+
         kuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdwvnok0bdRiOEfgk7AsS0nOBdFrauQ57Y6o9wWgow8ifAXrL0ZbdwDytPvxmlQsMCWpzjgVwuEMKsUJQl@vger.kernel.org, AJvYcCV8gnF4oOhrKwxHnLhWEY8C8iypEt2zQ4HGclSLeIt/uGp82bbcKnGCiqb5/2bIT09GyCejczBCRjFh@vger.kernel.org, AJvYcCXynskxHTFoq7xvS7etRUQyQWD2yIh0YPnsJMBmyXEAwyFiATEsvS/gMp7ypyCe/lhuvUKIVYDAAIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMCycmxLFjRrIoR5+G8qh4lP58wzKX1df1c9KU3Z5viwd/rsx
	Gbv8tx66MXZPgzQ/iVvb2P+U5grlyCSMBOgBKruNM0m54vFn7E4Y+BqKKd9HHdsyMu4UTK6/88N
	5cde17NKJ8hRfL1byCQwR8sVMq/Q=
X-Google-Smtp-Source: AGHT+IEBt4Yvb88T1gAjqaYb1uCYv849WEckHreXDTxpceb4obzrlY7JGG0IVTNOHTKgrLdBGp12XLfGrc9y8px9Y4c=
X-Received: by 2002:a2e:998b:0:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2fb82fb1a44mr791191fa.23.1729204786271; Thu, 17 Oct 2024
 15:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
In-Reply-To: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 17 Oct 2024 18:39:34 -0400
Message-ID: <CAN-5tyF4=JC4gmFvb2tF-k+15=gzB7-gkW6mHuaA_8Gzr4dSrA@mail.gmail.com>
Subject: Re: [PATCH 0/6] nfsd: update the delstid patches for latest draft changes
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Thomas Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Seeing strangeness in a network trace with this patch series where
SETATTR is sent with time_deleg_access and server is returning with
EINVAL. Test is open() with read delegation, triggering a cb_recall
via a local access. I can see that the client has changed from sending
just a delegreturn to sending a setattr+delegreturn. Is there no
server support and this is normal to return EINVAL.

On Mon, Oct 14, 2024 at 3:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> This patchset is an update to the delstid patches that went into Chuck's
> nfsd-next branch recently. The original versions of the spec left out
> OPEN_DELEGATE_READ_ATTRS_DELEG and OPEN_DELEGATE_WRITE_ATTRS_DELEG. This
> set adds proper support for them.
>
> My suggestion is to drop these two patches from nfsd-next:
>
>     544c67cc0f26 nfsd: handle delegated timestamps in SETATTR
>     eee2c04ca5c1 nfsd: add support for delegated timestamps
>
> ...and then apply this set on top of the remaining pile. The resulting
> set is a bit larger than the original, as I took the liberty of adding
> some more symbols to the autogenerated part of the spec.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (6):
>       nfsd: drop inode parameter from nfsd4_change_attribute()
>       nfsd: switch to autogenerated definitions for open_delegation_type4
>       nfsd: rename NFS4_SHARE_WANT_* constants to OPEN4_SHARE_ACCESS_WANT=
_*
>       nfsd: prepare delegation code for handing out *_ATTRS_DELEG delegat=
ions
>       nfsd: add support for delegated timestamps
>       nfsd: handle delegated timestamps in SETATTR
>
>  Documentation/sunrpc/xdr/nfs4_1.x    |  22 ++++-
>  fs/nfsd/nfs4callback.c               |  42 ++++++++-
>  fs/nfsd/nfs4proc.c                   |  26 ++++-
>  fs/nfsd/nfs4state.c                  | 178 ++++++++++++++++++++++++++---=
------
>  fs/nfsd/nfs4xdr.c                    |  57 ++++++++---
>  fs/nfsd/nfs4xdr_gen.c                |  19 +++-
>  fs/nfsd/nfs4xdr_gen.h                |   2 +-
>  fs/nfsd/nfsd.h                       |   2 +
>  fs/nfsd/nfsfh.c                      |  11 +--
>  fs/nfsd/nfsfh.h                      |   3 +-
>  fs/nfsd/state.h                      |  18 ++++
>  fs/nfsd/xdr4cb.h                     |  10 +-
>  include/linux/nfs4.h                 |   2 +-
>  include/linux/sunrpc/xdrgen/nfs4_1.h |  35 ++++++-
>  include/linux/time64.h               |   5 +
>  15 files changed, 348 insertions(+), 84 deletions(-)
> ---
> base-commit: 9f8009c5be9367d01cd1627d6a379b4c642d8a28
> change-id: 20241014-delstid-bf05220ad941
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>
>

