Return-Path: <linux-nfs+bounces-9076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5CA085C6
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 04:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7BD188D928
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 03:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891901E25FC;
	Fri, 10 Jan 2025 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fYXrIjBK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8202942A
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478728; cv=none; b=WQqZlkUKbjns/hHbw7VLfOHAsxg9Co+wCRhEWhX+c5UMkvRFhpHR5XiFR8chKE2u77F7Xd6GELXobBuVrq7Cz5AvxPE8RWgcmwPobPaCs4rf4dmRwTehLZUxkPkxSORfgovMlcQth1g8NpS9HuqbIwS3OigXG/zTm5Qrtm6SvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478728; c=relaxed/simple;
	bh=D18utRlVGGzPCuWewtrj5krIU9bJrmplcMeXiRT1+TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcSGNiUQoPSXD0oZgNrkzPPPBvA7G8BulQ4A8Odq4/g/jDG381uvHPU/I+noiLLWmPpOTxM/g3XofX/7FTgSROkOcjHzNHM6Tv5gP7PMf6MpMJh/rvE6UdDg6WA234dhN2HvKLxHE+hGNEWdT+RHHoVWX/q0UGgMRNgpGEiyE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fYXrIjBK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so2427742a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jan 2025 19:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736478724; x=1737083524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1QMtuuDrMek+cqp6TB29HWYKAOWii4BW9zvMrbHJAk=;
        b=fYXrIjBKsEK6Iq5052zyNFpPScdIYczqx8hFhqxyCgExrk60lwZgskCln5f7rk7iej
         OdnIyFZfbZp44nvftUoP9x4xhUAviIfUKKy5t4JmOgqjaU+dnH4uqR/WdKZuoFtXWkkr
         J2wg+/vBt+I31mkU/4qF/NUa5W1HowzmKmldo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736478724; x=1737083524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1QMtuuDrMek+cqp6TB29HWYKAOWii4BW9zvMrbHJAk=;
        b=DkGQt1ComPiDBgyWXMJyespIkn4Jb8Q/HjCyJKNbxmAMouSISB/2k0PDvtzaqFvIsM
         zMlDLc+A0qwmalVO5SCA+HQM8yWlKKkMB3oiCOiOX9CsRM7dG9e2yYqxsBedGMA7S2qa
         JqaYp9ZUFOtRzJUG0FK19qfpdGGNVV2TQaj77DuDe6K5/cNcZYl45TyVll2bc8Q3Bi9G
         tYOq/yWo/Yb4WbA5f6yrpvkqkcWG7GBPD8Coo9Qfusux89EmAGX0KIcLqL62Wc8HMluC
         NBsUD4c98GTJncI2l0x9Y4l+7KlWOXhKyYR0zDjp79opsM+e/ChdIHMrxbM4c+zEiI0d
         3Dqg==
X-Forwarded-Encrypted: i=1; AJvYcCWS5Q25RggP1SnglSn6HiK6lQ+u148KPMsh9yZ6ICFL9BZlGcMc+0poiqaJdLkgYRv78DaGdF+EISE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqyEqQs0DMO7PTM0t+54fMk1Aylcy9PXZ5xsickRBaU3l02KJR
	b0k+T5xvzd7eMNCkhj9x4qT28ocokDgvvBn6RFNrv5zxxiWw8C1i+MDaOhWYxChyTCgdQkM1+RI
	aBfkqMA==
X-Gm-Gg: ASbGncsoa7z2TIEGrx30u78YauOkFKJiCZ8RuhvNYnAaqrDkWE4lISKjDxdDjSsSj0t
	WbPL1O1rITx22obuEf2Opj6bgFmzV2sKMHtjI7nVB6iFN9ZW9abHdO48U1BcSCh9lTjga8GVwcB
	JgmY2s+VXlHU3G+DxRAOb/3mbUWStbghvqlpkj9l7wsOPExV55f+FPLejC+7DdnCGeeKADseunk
	uRgFz7O+IYH9tr+YiKxSSVIawwj+FKnV41kuCjGBk3hcGgB5lfvZCUIiOjHu8rRDsqjATwwpkH2
	VF0ifUserf8O7HOygepntCthsEtg4a0=
X-Google-Smtp-Source: AGHT+IERkT9Yw8ABAR8R9Q85gtavgXRJpa9oOm3hjcaxH+Yg2Tw6BMEB0yR1Pum/Bo3mDJ4X7UvPcg==
X-Received: by 2002:a17:907:948b:b0:aa6:6f92:74b1 with SMTP id a640c23a62f3a-ab2ab6fd565mr777599166b.13.1736478724630;
        Thu, 09 Jan 2025 19:12:04 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d52edsm125124166b.42.2025.01.09.19.12.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 19:12:04 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaeecbb7309so311627066b.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jan 2025 19:12:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBAOGFfpmFJFX3bX1lKx2kY6287u3NEzp33c7epgJ6n7sNIA3JbE6KcpUgllJtIZDKcwg14lB2HLY=@vger.kernel.org
X-Received: by 2002:a17:907:7f24:b0:aa6:5eae:7ece with SMTP id
 a640c23a62f3a-ab2abc93e22mr778679366b.43.1736478723770; Thu, 09 Jan 2025
 19:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110023854.GS1977892@ZenIV> <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-20-viro@zeniv.linux.org.uk>
In-Reply-To: <20250110024303.4157645-20-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jan 2025 19:11:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2i3j3GUYpiTBteS7Ln02endudZCqc9DRz==3p8T__yQ@mail.gmail.com>
X-Gm-Features: AbW1kvZaQx4RZA3DoPNnn7ySYeCUxXnMhPsF3e4Ed8oCi4wmKUNd_tb4o7KrlrQ
Message-ID: <CAHk-=wh2i3j3GUYpiTBteS7Ln02endudZCqc9DRz==3p8T__yQ@mail.gmail.com>
Subject: Re: [PATCH 20/20] 9p: fix ->rename_sem exclusion
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, 
	linux-nfs@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 18:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> However, to reduce dentry_operations bloat, let's add one method instead -
> ->d_want_unalias(alias, true) instead of ->d_unalias_trylock(alias) and
> ->d_want_unalias(alias, false) instead of ->d_unalias_unlock(alias).

Ugh.

So of all the patches, this is the one that I hate.

I absolutely detest interfaces with random true/false arguments, and
when it is about locking, the "detest" becomes something even darker
and more visceral.

I think it would be a lot better as separate ops, considering that

 (a) we'll probably have only one or two actual users, so it's not
like it complicates things on that side

 (b) we don't have *that* many "struct dentry_operations" structures:
I think they are all statically generated constant structures
(typically one or two per filesystem), so it's not like we're saving
memory by merging those pointers into one.

Please?

           Linus

