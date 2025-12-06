Return-Path: <linux-nfs+bounces-16969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5ACA9DE8
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 02:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C840301841F
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1981DD9AD;
	Sat,  6 Dec 2025 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HAC6J1aZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B3154BF5
	for <linux-nfs@vger.kernel.org>; Sat,  6 Dec 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764986172; cv=none; b=uHPH/Vh6rLielDyhuA2JfPsFwGliM9SJk6kzQIM5iixXJGUbLDzc9Hdbte0XYSS2bWIHKig2CIyOE6sVZFB96Kg8LEyyHkxqsYBnE0Sxm5WM7Z1Cdcq8zomwA7qGFvpO/thRPw3XI9oxDUGjdZQBV4ApNi/mIvGQTwxPKJe2vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764986172; c=relaxed/simple;
	bh=83+RRWO7apJfBzROBx4hvA8U2zrlObesJUz5Y/0kEIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luDSYeuVQkt51I2pb8+PEsq6nv3aLrP253E2Jn6rjNhrftokvAKGZIowQGIgxFHxwkZBF+z9agQm6QUZvDGYJvkQ4A3V0d24/a0ohGfY+codi6wyO72VJXZti8MvcsEsFoQRRtRjf+6PHpahHdz5RiEP/Tfv/q0Ag0jaXftTrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HAC6J1aZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so442121466b.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Dec 2025 17:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764986168; x=1765590968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NUraw7tomd1KwHLtqTN15TG5fHqupVd001WTjnTGYvg=;
        b=HAC6J1aZUff654Uz51nBgF0OafKhpUeDwuokOY1rdi21iTpZds5IuEazwM8sXKljG/
         Lek+7rxhR5RGXIN95DBPH5kESZ9QJ/2AyZGNsHi8NDT05I62VxeFKmUNz+pprQi0J4Ow
         JlsSE5ZrNILn18kvKIlgfnpedYlBVZP4N8xUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764986168; x=1765590968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUraw7tomd1KwHLtqTN15TG5fHqupVd001WTjnTGYvg=;
        b=YenjRoADAwIvOijBB2L7lbq7VgvBE5WXCEzQyh/swrE48O8y0ne59m5rsjT3S3I9HP
         tgVqUVC90wpzrwvDDEQGxGT+qsJCld3iwdWkHbbsQKyOxbl4ob/0qegi7VzJLXbKbaU3
         id9UhF1Ivz/dN1RerpYdFOYIU7Bf2wUSp5qdosgeSUeGuy0AUodDOgO7Aa74wVLDcUHw
         xwf2fzsRkZSTUtfoqQ7gLmzkVwaJ2TKWrpJLHylXW7NW0dmlbVc6gag0cBUhfgTZbdSV
         9kOLYBGxMfZCoBjQg7Gi3Fj5sTkbAUpoQCQMDHJDOtJwbVKyll9UUEGJ0vUotRWph0cK
         Pf8w==
X-Forwarded-Encrypted: i=1; AJvYcCV8YhptxfsXXlLZAO6LhYUtW0MpLW99Rw0trGuHuCA/my53ycHybnjI8xtms+UqjuASst5Al9Y51WI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6Ch+rj/SmUWx672UAZ0PonnOoO8EYSBBlItf2ut5srIiEpQP
	DEQr/+3lDZXmXKeI27S4uLVzjYFHnwAabjEIwjDnpHN1XtMBAJ8mO1CgOxFDo0NAOb4ayCF7xA5
	rDBTJW8eijg==
X-Gm-Gg: ASbGnctATWlMeiSUz2sYx1lnUUNxQJHJq465VaZ6gfJlPoBB5WV06bklS8m/tvcKcmA
	aMp6yBHX78iYMgPr1S4WuHWFNLUxHKa9cK0NURK8YHCseOMXIr42Uy2IzFOHDmNmx4p9dBozirv
	PdY1E/9FxwY3D7gKJ0GlKzETUUiV9UWrIFofhu3LLJdMHS82wP5yWkhVqetkYYZZb61marm9gkr
	h79s8liMcllvHazmeaNu54xU8rIJYGUAGeZRYlnXZfI+xRb28N2uJpUZaftxODI6MC2rG4wx0JC
	zQiT2iU+7TTiNw1d5E8K7AY+LKvKcDOn6kADsyP4FxR0WxZ4wkj94hyYo3cHcKMg86bo6LjpLI7
	w85UFy22odQteBtuYLZfnsg9GZdXM+kt+bNscVAz3LoHd/zP6om8vu4+ac8/UQd3wjDs69zCw5m
	Q5uEMn9a5nZnxA5T6ysS8tiJG8eq6436cuymXas+0COnjzHCydeN/CCnmYMsIW6nAeQ3Rx/Po=
X-Google-Smtp-Source: AGHT+IEP3W8sQ0HKeODXurdbqU+OBC9tqZ6OeddlAlXip9dcpRMhUBzy9wKys9MPBMWUikYNcUSRig==
X-Received: by 2002:a17:907:9494:b0:b2b:3481:93c8 with SMTP id a640c23a62f3a-b7a2432d657mr100815066b.19.1764986168362;
        Fri, 05 Dec 2025 17:56:08 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49a897fsm503034366b.51.2025.12.05.17.56.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 17:56:07 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so4192406a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Dec 2025 17:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXW809JpNAgVEHXik1FbPJfHw44XE083sRU5Q7DHGLAmxOOPzpZdt6idh5WrUFXcFw7X27l/dtlw9s=@vger.kernel.org
X-Received: by 2002:a05:6402:3591:b0:640:e78f:f34f with SMTP id
 4fb4d7f45d1cf-6491a3d6986mr760015a12.10.1764986166939; Fri, 05 Dec 2025
 17:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205111942.4150b06f@canb.auug.org.au> <aTIwhhOF847CcQGl@kernel.org>
 <64034c4b052649773272c6fa9c3c929e28ecd40d.camel@kernel.org>
 <aTN6d0Qkh3WKt796@kernel.org> <CAHk-=wh58ZKQTC1iogoMy+Rj+gOuSQM_r2jT3NKD_jiiLyvU8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh58ZKQTC1iogoMy+Rj+gOuSQM_r2jT3NKD_jiiLyvU8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 17:55:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3B1-nZ-4jUP0FsLH4f1bbpO=Q9J88Ziz=wxE-Jm-skw@mail.gmail.com>
X-Gm-Features: AQt7F2r4Tkpag46bSK21rQ-RcZljW4tbOnoIDbARpE-KUFFhl02fOQ06PG8fggM
Message-ID: <CAHk-=wj3B1-nZ-4jUP0FsLH4f1bbpO=Q9J88Ziz=wxE-Jm-skw@mail.gmail.com>
Subject: Re: [6.19 PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred [was: Re: linux-next: manual merge of the nfs tree with Linus' tree]
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 17:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me do that once I finish my "merge various architecture updates".
> I'm almost done with that side - just one more SoC pull to go, I think
> - and can go back to looking at filesystem changes.

Ok, done and pushed out. Can you please verify that the current git
tree looks like you expected?

           Linus

