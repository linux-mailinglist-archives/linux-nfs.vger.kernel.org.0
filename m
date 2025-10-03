Return-Path: <linux-nfs+bounces-14972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A03BB82B3
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A8F19E4EA2
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D8259CB6;
	Fri,  3 Oct 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WnGlquBr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E18260565
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525601; cv=none; b=DFU4Lu4X7UF4FZaOyCpYVUOBFWRw+NUcE6/o7d9FT4XYbjbISBXr2P5b5at5cV84jnFGOYNRxwXevTj7dEOpKT+kqX63pJrXCl875w/CljAUmXYlzt7xol73BnRcUAalMi0ocxErDbzzk9J69DNzjG4pEkcp3mUMlggoGbA1HjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525601; c=relaxed/simple;
	bh=RiwBRAUdCna8tU7SvUhNUFTupTCf6qRBJM1qQVJfmYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLoHb6AnF/4TsOb7YxaIua8Rou+IMk9hx1vekVU44KPpqqjQn5M2xfLbyjFlYN1c4YY7QVgfOgtEXSNEi8+SBAQFBDBXDIehKk0F9cyhoQdXlr230OPt7x6TZVlec5fWbtGLfIlkgA98G9Q6bdVPcbUGOC5XK+EI0f9T8HzM7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WnGlquBr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so512064266b.0
        for <linux-nfs@vger.kernel.org>; Fri, 03 Oct 2025 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759525598; x=1760130398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XwaBs10Ce4nh+pmRtPZeClFuA9N57IgZLYH72MHs3BQ=;
        b=WnGlquBrhKwUyukGN9zXpDYS9oVdil703Usx+61I0/0E6QwONWz9VBWE8TMbHnQ+dj
         MS5JrHQ0c2868dGJA2BY5phTK5dak+6xSVP6miDMbEzTyr7C+fC9+1eI3Vj1N7CxFSqx
         2RpypKxzK5Kg7oLJRQWVazwncrZUFWrdSWmvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759525598; x=1760130398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwaBs10Ce4nh+pmRtPZeClFuA9N57IgZLYH72MHs3BQ=;
        b=qUIu+vhZj4Ib3vivFpcupW7ZeCGTQvytXAnzzhP8SxpFcshe1Hll5tNqADSUpsvcpP
         u80Bjj68WuZuh9bK3b2Vw3Xe3r0ZRHnZyWpgP+9im6xHPCZ7rnhrrdZQk2T0dc2gFboN
         jBIc24YuI6qo92XC+4nFRD8pQX68BalDzLD8bsR2k42diY6KE+IBDfdZBGvM91WaPVx3
         eFBqJQO4PHdwiFg7gL+6wxDXmbZ+G3wYtUiYwR8EtpC/ELDoiSZ+GpboGqzG4gpFBVuT
         dGXTX3eGlxBSGhemnfPM0tMbTvYKqT+ll1gZmdNagF44lmwGJIuZ9TfzbzGUumSFRM5b
         HNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFwHnxvs7tHVdZPR4RmvLiR5v/N14tRCNKFb47zuqxyD+7YCv9PwnIKpExPjqJy5o7G67VEcHNzv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjcdZCcGdkGm0ayUH+1Mr92dWczXYF9sQ4ufHNlVy7HYSTS/e
	w6Q4AC+20my7BzA+0HPNUA/gQc3k9MDklUoVYeu85PijeN0z0j/FLooUua0E7sMmiln4hYnud4M
	bx+RKKcg=
X-Gm-Gg: ASbGncu+6fRZ3Fwae5pq2TtyK1LB0d96xH2Jhqk4nVznwd5PKnppq5iZ8OzVODKsZnt
	TQuWmBrByHbxcdvi8S50Rz1XwTRvIjuXMoLj2peBKBx2jBjDVxrMLIqf4DAYqfO0ul2oyDeIotd
	NmQaEDk8yVWclEyJ1okNs4oEcAeSmXB6VeLFDEcky4BbiMR+dmPHa7I5SLVsUsGviSadyft5BRo
	mWf7IXcGt2LMSOjKeTZ0Wpz6DPKACAfBYi178LsDNMJ8ER6EyfJG/YkdGwmbUaBOF4yv5L81VVS
	qjXFQbihqTWJWnpOTtTcXqIY4zsrl/7zg7aDmaB1eBgj6gvoPR2/MUbwAGjGj2ILFct5OQICnGn
	P3LpjR9VzTATgLpXTgXO4J7MDQxE44xlvL4BdPBkTogs/NBViBn/ALKiEWEnxen1dE4ManTlIbe
	XWpZk8LXvMpteyFIP2BYtac4e1sinbIkQ=
X-Google-Smtp-Source: AGHT+IF0tDX8LmvtYv5aWjN14FsuXiYMgRdCg/aFTcQi7Q5Q45wQI8J+NYoKww58mI6RV3tCnLK4BQ==
X-Received: by 2002:a17:907:97d3:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b49c3d753d4mr576137766b.33.1759525597704;
        Fri, 03 Oct 2025 14:06:37 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a786sm539497266b.46.2025.10.03.14.06.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 14:06:36 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so473794066b.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Oct 2025 14:06:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr3L8nr8vD+FJvJVCQVHSDz6JCDfp3x8BdNGQyHT9kX/GA3gOPloVRRHsSof/1BBie5ykTQQ5NZNA=@vger.kernel.org
X-Received: by 2002:a17:907:d90:b0:b43:2a3c:c74a with SMTP id
 a640c23a62f3a-b49c48a8de0mr541931766b.60.1759525596009; Fri, 03 Oct 2025
 14:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003210107.683479-1-anna@kernel.org> <afb30180-e4a5-48d7-b0ad-7c7231f3533f@oracle.com>
In-Reply-To: <afb30180-e4a5-48d7-b0ad-7c7231f3533f@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 14:06:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkyH_MAingEK125ei+drcnTsEDSF-sOdQgUFVvAdTm-Q@mail.gmail.com>
X-Gm-Features: AS18NWCVAnVx5atrEAf_DiAx0k8-bfOHyes6S76EsnCUiXGGcGlFwVPm306O9OU
Message-ID: <CAHk-=whkyH_MAingEK125ei+drcnTsEDSF-sOdQgUFVvAdTm-Q@mail.gmail.com>
Subject: Re: [GIT PULL] <INSERT SUBJECT HERE>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 14:04, Anna Schumaker <anna.schumaker@oracle.com> wrote:
>
> Looks like I went too quickly and forgot to fill out the subject line
> my script generates. Please let me know if I should resend with a fixed
> subject line: [GIT PULL] Please pull NFS Client Updates for Linux 6.18.

No problem. I understood the gist of the email even with the bad subject line.

           Linus

