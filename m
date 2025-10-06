Return-Path: <linux-nfs+bounces-15001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE9BBF660
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 22:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40C33C3548
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686DD25CC6C;
	Mon,  6 Oct 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z7YzPFEI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44730256C61
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783940; cv=none; b=RPGggqyr54YO6qWUFsCanFkUb/xhkPN9vqrvBKIMVcTn0wcsoxknZOTThnKNA63reT0PsG8HmnRIy92mp5IYxtTOPBE/YxUwshiMovmBro90kLfAPJoNbQSX6nWuJOAUbqwW8ln5vO7qrJ6zsJtNNvzZqaYnNiOUFrKjqwE+/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783940; c=relaxed/simple;
	bh=eopXqYs610smqpBTTXCyoJ4YSv89N9CU5jwYMQsPmaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTr+XPCgujNzO+scwtM/Qcmm1yCBEbjaRDUzdb1tQsFE1iQhVvoejRf4wS1DNLH/LInVp9o9LlzqVst73Mj75FSXlEuih0tgI9r23HuUw85myZmKJrgRiZ0+3ePnpFOfXBSM8y6EYsfjXaj/oKnJ2kO1FKNwkeKypOP8VKKbzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z7YzPFEI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4736e043f9so966295966b.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 Oct 2025 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759783936; x=1760388736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28uZ8S6zg+lnLWgtyv5+s++GpisVFfNjp0/ZtTqXDf8=;
        b=Z7YzPFEIzjCsNuKsu4O3Q8ZMKzRdcZZnBukseFOCvjI0WPvpiVOYAKxGobiTCOVaDG
         iMlAqQxhmJ7N1ZfssPM60hG9QpoXskjqlRYcaIDQlN7Ljsw4/NkLxkr1KDGnVk7LcqHN
         3zK4bDpNrnwJMXH1O6KBkek2eDC8p9cLPXIoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759783936; x=1760388736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28uZ8S6zg+lnLWgtyv5+s++GpisVFfNjp0/ZtTqXDf8=;
        b=MUNy2DKxK5MiuiN4Gdnky2DI9nkZc1GRmyMXtwg4+HPTdz59ySOWZ0TnBX4TZ5w+tw
         OlbN4xYYIdW97G4ov7c2q9heUXnTR/+zAaoGkr2wBcs7siTNsOV04Igwpx8FebZyURJQ
         ftXMDWJPSYngXvCPFmA+TnDUAJdtdsLNgzcOYTRmRqA8/pbJU9OwfqZy6FUXR1nKkcXA
         dOsniUrtuueo+EM9DgMO1DXHKsszPCg/cANVqBhdSEjKDQAzL9bMPcQPaMI7wetLG84D
         JrRr9XX0qrEaDHiPSluQSih8Q8nfbCHvk+j/Z/O/lwk7UsdpHm8H0yivx94+urHzxATT
         xJdA==
X-Forwarded-Encrypted: i=1; AJvYcCVgC5fXmEhdsqMe/Kj6edtAUBrME0YQIRTS2F0dkeCSMlF8ux1AAHbqbjsJ/ky+JzDDl22a5jzGITc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxhicS0mKrw8zW/5i8uAJLYiJ+Zhrlj14MhRv5dxzDPOsQ1dm
	66cpTy1R+zat0bXS2Vvsi+Hk/n8E+qULLQPpejwKA0VZ0nDCWLIdiGi0wQUlVFl6hQg6HO1oR6W
	3dHmQIvM=
X-Gm-Gg: ASbGnctKQqTiJBkulh/rk6MclvsnsGWcKsqLTQ+37BJOYuOuRY10hwlw41Xl3iTCSZJ
	tZJ8rrVR8iIh0/ZH1cV1b9P0QW8a5XNAsm8tEGk/g0OOgBmbIkLYo7+0FU7KAv2qcrnp+NmVWeO
	sActnAaKRRDoOSAg17y/0e8pBL8xfOfymSycCnPBqXST2jLK7+VOSoCGKBNjwLUZTL4lcRFbJDS
	pHDbRkKZe4xH+MAhj4BLLDrLCU+CT5KBeevdifWVG9ymJIz9U3ZkU5OVMzGNgn0UHfkNo5m/Csi
	NKuC7RKmXWBjAEX8mv/jjyMxy2fnCHcjVlRjI/uV3CdJLhjWPwlIrKwBH26EqTEIybu8WM0vwbn
	Us1koIpDHSNVXmZBhPQmFAlYBCxSQE4wwH38aMqizDme+pcwYUSbgzk+yrxMEWwAKGxYi1oPGls
	dmoBA2cHUVf8f5Ij7FcRGN
X-Google-Smtp-Source: AGHT+IHB10iB61mpvUXphdusNZ628M+ImEloXPQ2R9xpWQa0PFW1QTO5MVtdd0xKrO8Lidr/5WoWww==
X-Received: by 2002:a17:907:868c:b0:b3d:d6be:4cbc with SMTP id a640c23a62f3a-b49c3449f39mr1665526766b.24.1759783936226;
        Mon, 06 Oct 2025 13:52:16 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b222sm1220654666b.55.2025.10.06.13.52.15
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:52:15 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1120265766b.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Oct 2025 13:52:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiwLrpLi0gbFp1QG1ZECg8QXJ32qhJSx0cDXs2ZmNiPwWI60C/h6PRYnjcoCf+BHZXq6AhANTBOEU=@vger.kernel.org
X-Received: by 2002:a17:906:6a02:b0:b45:cd43:8a93 with SMTP id
 a640c23a62f3a-b49c5267f61mr1703004666b.62.1759783935038; Mon, 06 Oct 2025
 13:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org>
In-Reply-To: <20251006135010.2165-1-cel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 13:51:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
X-Gm-Features: AS18NWCdXOOHQdpXutgs_Vd4CxaltjeaTJ7mu_wP84QmQM4uVS7nGJ3EOSnaKFI
Message-ID: <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Chuck Lever <cel@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 06:50, Chuck Lever <cel@kernel.org> wrote:
>
> One potential merge conflict has been reported for nfsd-6.18.

No problem, this is the simple kind of explicit conflict (famous last
words before I mess one of those things up).

Anyway, the reason I'm replying is actually that I notice that you
added that ATTR_CTIME_SET flag in <linux/fs.h> in commit afc5b36e29b9
("vfs: add ATTR_CTIME_SET flag").

No complaints about it, but it looks a bit odd with ATTR_{A,M}TIME_SET
in bits 7 and 8, and then the new ATTR_CTIME_SET is in bit 10 with the
entirely unrelated ATTR_FORCE in between them all.

So I'm thinking it would look cleaner if we just swapped
ATTR_CTIME_SET and ATTR_FORCE around - these are all just our own
kernel-internal bits (and the reason bit 10 was unused is that it used
to contain the odd ATTR_ATTR_FLAG that was never used).

Danger Will Robinson: hostfs has odd duplicate copies of all these, including a

   #define HOSTFS_ATTR_ATTR_FLAG   1024

of that no-longer existing flag.

But hostfs doesn't use ATTR_FORCE (aka HOSTFS_ATTR_FORCE), so
switching those two bits around wouldn't affect it either, even if you
were to have a version mismatch between the client and host when doing
UML (which I don't know

Adding Christian to the participants list, because I did *not* do that
cleanup thing myself, because I'm slightly worried that I'm missing
something. But it would seem to be a good thing to do just to have the
numbering make more sense, and Christian is probably the right person.

And adding Johannes Berg due to the UML connection, just to see that I
haven't misread that odd hostfs situation.

Comments?

            Linus

