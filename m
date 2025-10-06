Return-Path: <linux-nfs+bounces-15005-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA505BBF9E4
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 23:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 202E44F295D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 21:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658925F984;
	Mon,  6 Oct 2025 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hcVP81YW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F31F4615
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787699; cv=none; b=UH5XD+0tw0y7Bf5h5uBR6kpJUjoaMxrAWp2KYHiXr8OObgEgJJA9TKtKTyjPypxM5mPcW5qwTYEnDvN2b6rMVWSpz8CAy9TA6lKqrO2b7evXP9uf+IVXBAQZNfRy25h0XoeqLLWKeQEHyux7Swu+1/M80Pu3Qz951rVL52scu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787699; c=relaxed/simple;
	bh=TWxpUrysf16+ov9dpvsDDDOufpdomI5DiZFLgIza93w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBCyMQ2XxswH9p9LnykXIfIyyz8xDIa8YQmkeY71CNGRZwrs9i6opWPOZ1TS4k/E8Ivku838QWlW+2hulg2KxXkvPhe8hf4uRZIcMyK9UfxXQt8SYJiXdY0MTnLHaxqAPJwiMTa3S5nF58Px8dRDBCSBdN1HFSermvMzWQlQwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hcVP81YW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so9936128a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Oct 2025 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759787695; x=1760392495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDCKn2qbtodUcRBoRw+ujzLtuCdD/rFo1KUv4Z7GG4U=;
        b=hcVP81YWcwMP5v9qflhqYXohel5Sxj8C0QeydzniX3m/wxiqBm1Dvvw4YgCI2yMEQP
         DCBs/0obkzJGMSvQ60zncf6W2AzI+W+f+KsdV2dIAFmug2p+Sus/5QYcYU0qFKqpCevT
         SZAKyLxyCwkPCHU7zhjYZijQuQKvPk6EC5mE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787695; x=1760392495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDCKn2qbtodUcRBoRw+ujzLtuCdD/rFo1KUv4Z7GG4U=;
        b=fza6scqlgW5hraxPO98VtQKwpgfBjDBQ5SDUby/KHpxNW6CQrT3fs6YHqgYAqkuuYD
         gCX/8EXtSO/Mexjd8hpuAXgoQ/nnY42/cThw9Nl03GFqUG9WQlzU9OkxDeO3Z6Afw8Zu
         LNrcpVlD2J16zEi0h65jf73NqcsVJVRC8jpzyjq91NGgctMBvbNAjokUb6B2DZ1MnrU2
         D/g/jePzhxrvVd/OmHuqCKzwvJSR+TTXmXzCCj39A1wCtXRNWGMg4tRzKiKM0grqi7Zb
         /g4HudT181mqR1fbbvCvFX7nk8r02ZFuELryBmlb547w+p4UwVHzuuU4mZGetfsx7gCp
         iHaw==
X-Forwarded-Encrypted: i=1; AJvYcCWXnSpyMP6d6Ze/u/toKojFltv/BEmbciwzPWJjuuSlIEftDtPllfGW/weYvmsfQsmrXNG0JV+kzOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgDUjEB97+za6vqvN0ROC8SCb6Bv+pSwvGTWCc86RivKbRUd2
	OExYu9UJaq5knVsqhBgt0toO0bJGvqVzB6l7SNuaJQP/5CVRyb3Z4F9nXVr5VkYWKQKqC4dW2Fz
	rB8zHcBs=
X-Gm-Gg: ASbGncvf9tg7qkb+hfun7Tzdx9Uj5gUg00D2uu9LYM6ykCIhkUrI63xZ8cgqm+jzjOl
	afOAYarT7Eu+bsjg828DXKNX0ErJiaMhdgi41QaVIJ17IsBAfK7VkQbbNYy//OtN2sLCQf8EMKa
	qMGGK8JuwMcsAS9hFV2mSPMQ+EuUcno69+QNh98flF9EcqKdD/rhu1CmPdfv8kg+B22aJv/S0t3
	9jV4zWNTlSrgo3u+Wg+yFZ7n/L53aneBDvlp4W8VlMw5V0XSqXRxR+dFQCAmXlXKTUud0o65IdJ
	K1g9i+duAbSR0XtcqCI4a+9c+bmq5elLlf44fbuVm7HGGaPXIvUuhOfNGh2mgrq/XtYgeYdAmFw
	ksdopV8nFcePo/PNJSHyEUgDR7NaXunR4hOhQQSSHZzsPs+CquXrSozqM7WdcdX+HyTEGv16213
	1vFLKJdjnufZ8Ni8mT9PPIT4rITXkZLBg=
X-Google-Smtp-Source: AGHT+IFjJ4CCXktWs0L6fTsf/BRGv5/Q4eDFzSiTly+XZ8SmSF/LU4Kj5Dn0/stYMDL4Rl4O37kocg==
X-Received: by 2002:a05:6402:3594:b0:639:4c53:ded6 with SMTP id 4fb4d7f45d1cf-6394c53e118mr13153446a12.37.1759787695546;
        Mon, 06 Oct 2025 14:54:55 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6396f73ae64sm5693243a12.9.2025.10.06.14.54.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 14:54:54 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso8177469a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Oct 2025 14:54:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8lx5ePAUiWTc/DuDdPqhnP4pqZvAsLW5snwLcU4QJ/zLCTcr3d6ky1VlTWNZAqXwjo9xFi33KGww=@vger.kernel.org
X-Received: by 2002:a05:6402:5191:b0:633:7017:fcbc with SMTP id
 4fb4d7f45d1cf-639348f1c5emr14975075a12.15.1759787693294; Mon, 06 Oct 2025
 14:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org> <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
 <9636431303ae3a8b24c84b885cfadcb963124232.camel@sipsolutions.net>
In-Reply-To: <9636431303ae3a8b24c84b885cfadcb963124232.camel@sipsolutions.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 14:54:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDNJjvBc3+nAH9jTd4NHwiCizaw+0ZN9VSCpzT5jRTHQ@mail.gmail.com>
X-Gm-Features: AS18NWAGZxnn0FJ50TTFvawTEJndCY266DQLf5nNwVGofZLyRQSE7F8xjpkpYFs
Message-ID: <CAHk-=wgDNJjvBc3+nAH9jTd4NHwiCizaw+0ZN9VSCpzT5jRTHQ@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Chuck Lever <cel@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 14:20, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> That doesn't mean it's between the host and guest kernels, it's just
> between code built for "userspace" and code built for "kernel", both of
> which go into the UML linux "guest" binary. IOW, it's just for
> communication between hostfs_kern.c and hostfs_user.c, which nobody else
> needs to care about.

I was worried about people having version mismatches between those two parts.

But if that can't happen then that certainly simplifies things.

> However ... it looks like hostfs_kern.c is using ATTR_* in some places,
> and hostfs_user.c is using HOSTFS_ATTR_*, so it looks like right now
> these *do* need to match. Given that, we should just generate them via
> asm-offsets.h, like we do for other constants with the property of being
> needed on both sides but defined in places that cannot be included into
> user-side code, like this:

Sounds good.

> (that passes my usual tests, if you want you can apply it as is, or I
> can resend it as a real patch, or I can also put it into uml-next for
> later...)

None of this is the least critical - the bits I actually reacted to
aren't even used by hostfs so we also don't need to synchronize these
(potential) updates with each other.

So it does look like a good idea to remove the hardcoded "these bits
must match" thing, but clearly this hasn't been causing huge problems
in the many years they've been that way.

IOW - I'll wait for a later pull request from you.

            Linus

