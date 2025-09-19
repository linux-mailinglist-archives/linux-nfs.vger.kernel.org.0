Return-Path: <linux-nfs+bounces-14595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27391B88878
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 11:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01851C84A06
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424021F790F;
	Fri, 19 Sep 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jIkfBxWS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA201F875A
	for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273396; cv=none; b=d1ktx9EaKLLI1dnyGr8NNffgOsd0fsSCk9puEFlrLmWeGwYvKruh8VZ//pJaXoY9E3Q+av6OpPtTZSZXKwjp2e/z9LbZcXvc8JJhQh/krMLWZrF8xT3QJimDWdPOvUFMopMUgTWrCgkUm0B/ZZAcAn+ocsqjBI+65wp6NZ9eFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273396; c=relaxed/simple;
	bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIITJt9/zXUm21NUwtUmOki3gQMSYAXQ744blzd4EPFcB5sf5lXDsJOETocRTpH0TP0bwSGKgmTWpb1qgoxjYDa1rPOXI37YNqC6F47+lXVBA8YOCbbdJvAuMC/pIiD6k8PSARecSeSG/+Xa9F7BOfsvskg1boJFrY7yoU53Go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jIkfBxWS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b48eabaef3so20213201cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758273393; x=1758878193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
        b=jIkfBxWSlkjW5STzq37DPgVopUzsqLgx+5lZ5mRKt851bD5CPQ0b1Ki7IlmlwQiMYE
         H0xpl3LtCSTR/KGE26rJ4q7NsTw9tNEXpOp8fC4wELhU7PtsLQc8OnrHXMG5PofxzC+m
         GybeLzX+nLQQYDz1fGSuf4OPCRHsRuuf5BOEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273393; x=1758878193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NSAuKg48kDucBl+lQY28yZrJW6O+JKtv/vQq7ZLJw4=;
        b=Sxchy7XAYNnZ6gZF6Pj3bzhpdWQ0aI10LFzLHUOE67HcKtHB1cxvBzYsId1lBnq45g
         /ZJHdMBpxxmvQq+REIcpLF+pTB+C8jXLNTqPNFdHnXvXiudN+ULE70svB7YnuSbbwhMi
         EngRP5vezg385T+9wT/PDARF6/hauE5Y5kODwlmFpMmC/+J7x1pR+Fzd6rl9v8V0Svvs
         U8RpeN7iNgVPYDtYfXASvQlrE6eh/zoc8JSCTBsPME2RrbuuKknZVSZQ9XZDfK/ovpir
         F9D4ghaT3Bn0sDZDq29zZWl5F9gPJomJi/Tmo+mtfh00Dm3EH6y0ShfKu8kFkUPluQrM
         KIVA==
X-Forwarded-Encrypted: i=1; AJvYcCXgN7s0Xb2HFcawQEu9JgEbqotro5vTkc6t+XySiLeOjryzIxousDoPgPNHvT1m2lD+iDUvf/YRI0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKjWXL2NVsWIP4wNvrS0HH4cANmNu8qXXAmLE+BIwUbblflwo
	On9w6siF9My4pvQqfy8VBoCIqdbfhv94slfmlEMxESqerWCRXktXbPJNHNmh1rFgHnjkq7AQOy2
	bBI9s9GLV7h+riWfPxOe3eWVZaq6PW2cRqHB6PMIN6A==
X-Gm-Gg: ASbGncutklJsdemMklAh1Ji+qAIBwxK84k5DJUHWBUENujXu1h99N//K5YwRDgu6/Zx
	aes7pFVHOU6eq4W7KmJByTkPenydCLKBYXWlehxkX3gOUfWWs3UyWrXF1bmeeISW0AwF8mNluNV
	OYSApU8UI0c9+aACidy5D2IEbzxLsRgGsbc6tys//6da3gZ2mpOATHJNqxCzVFHZf0mSunGh7lU
	uTShZ0/GbrMN0wBmADuYqRZMYAoOi2Rmnfkhso=
X-Google-Smtp-Source: AGHT+IEC7DaOiqsDhZ6el+nJAXMCR2LZLpubNGOPgEov0Yiqge6V0MP8FIeK9NIu4a3q26iz/ROtYZA/OmdKQK0CbyY=
X-Received: by 2002:a05:622a:1189:b0:4b5:ee26:5371 with SMTP id
 d75a77b69052e-4c06e7cec5emr25872751cf.26.1758273392530; Fri, 19 Sep 2025
 02:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917232416.GG39973@ZenIV> <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
 <20250917232736.2556586-7-viro@zeniv.linux.org.uk>
In-Reply-To: <20250917232736.2556586-7-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 11:16:21 +0200
X-Gm-Features: AS18NWBdR2wSIkWeUQEoOiuG4V2oEtZ00-2g_l56ym-IbHqMpDho5hZu73hYZtE
Message-ID: <CAJfpegsxUQzZaXKFAOBmThP6e5F=XT=oDn1BDBUO0R35D39P=Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] simplify fuse_atomic_open()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, agruenba@redhat.com, 
	linux-nfs@vger.kernel.org, hansg@kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 01:27, Al Viro <viro@zeniv.linux.org.uk> wrote:

Some explanation about the dput() removal would be useful, e.g.:

Non-null res implies either an error or a positive dentry, hence the
dput(res) cleanup is unnecessary, since at that point res will always
be NULL.

> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

