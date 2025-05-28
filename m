Return-Path: <linux-nfs+bounces-11963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1DAC7249
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C679516E159
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969C8F6B;
	Wed, 28 May 2025 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d0C8kYcN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8C20E6E4
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464560; cv=none; b=u8jlWuDpjamPpySad/ngLp1urZP0BSWielK7/1B5Q6+ydY2hzTCX7SEeat7vGH4FEJ2LW5LDwuJBinKwrrpYIx0W37o0hppNonf0jG+hnz079OXNFUuZlRPHLTFfhZ9Pz+appiQcisNPxAZrq1Pdm+EFK9Va1kK8NESwelDYvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464560; c=relaxed/simple;
	bh=rL2WJHK3yK6U8yCpBEsDlHfjp9mdR1IrM81qSsZErHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktHlh+PG7xEBXVOKlilYskX4muaO4VebzkAF/aU3JzGEUgMPiDiTfVY78SkpMDgMfDgD4ttWysZXTfqLzqg2F4WXppPx2q+0GOyezQ5qzieRZ6nLTSy1f+dv/v+OHwZ2r7cMoSe3C69fPYrh3hWQ6p3d9IK+sXYMROPECA6LAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d0C8kYcN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60461fc88d7so477244a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748464556; x=1749069356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SI3go0hstqNJMeRsNvBC/Uwu5IUh2YuAXmhIt3IADQ4=;
        b=d0C8kYcNXVLsHGj1yntNqWW4CrV+1WrfGDmluUnyu2LNNcF04WfdgpXM9g5LZWyG2I
         PUqChEqAZwfHk+8cYY1sN7KCQ5Gash3/V0Bc0RqDVNO3MVi/O2Qm1UPAnvoBdXGIOJTB
         WMoxO8a43gJjFyScm6StS2HPvl7+vL3fvClak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464556; x=1749069356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI3go0hstqNJMeRsNvBC/Uwu5IUh2YuAXmhIt3IADQ4=;
        b=Ynyp2+LMEBCdkh+ptqtpf7V+LtxxG9iZhX2R0wAZEZCBc8q4Q7h7G/ZSIwsx0WNBOS
         l9BMsMR/qXkA7kQ00aTZgvRKKpsMdHaJpHCxJ1s+lhrJv/JqoJcLkm57fnR2mKrcn2jg
         zt4ad1mMaiGqkqqAcG8jS1/7T1w2eKbrhVhSYsglo+O9uZoHk798B6V3SR+iACgVpn7J
         karmTpqM9Lm3rtciGr6Ttwq4SnED1UF/NrCipiC5S/z6gDyb8YbCX3A6AMB9TZidJ1vJ
         t1KqBjriT2yBW9p2O6M8xUPmt1+rWKw/6T8drQ7RELbTmilGKL7fJmPXp5uwPclQnbV/
         UIfg==
X-Forwarded-Encrypted: i=1; AJvYcCVAGlhG94qcVu0pKk8NEBn8y/oPTTlMCozKzWyBKOZ5syNOLrYY3ElsfArM18PrtSZHq0D+iD4B/dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfgWRXWD/boqErJR3Z7/qZnexY9O/8XAfo9mk1WUv/LJ8ARKAB
	oqNx+q8T4kyMlJlORJyiudjbGtQE+Z2jLPPA8uFgX/C3lmRcjTqvgx2FH2OyQKrE3U/LvaAuuUb
	JOb2528w=
X-Gm-Gg: ASbGncv83Two78xNkFqJXfIH++qjMl4Dgmk459e2PrSHKRfwSd/fveTAVl6jAsit0XK
	bleOLsOVtRhCM7pgfVxwoNaYkXWghO8vewvShYnja9VeMraDjHqpQXptcpbuQ3gCgQh9PNIjb+f
	CebrKexfQhUjjieBWMBA1heuDYfJ8W+1k7jQ8U2J1Lyavk9AeNEeK2l61FqnB+X1oc5P9CcPTHp
	T4A2DmYFr8t2LDzpRHfkYB7yV5qUAKi3ybxl1abONH8qDmMlXFWQMxBArMeFQdP9ep3wacxnkbV
	tH6A9cxHj1iuaEo0hf4Es0dOjBJAeNExn2p3nuSjFEOWq0Ol89giQxfk/7LN/LwQx802YzW3RLe
	VaKUyPmcZ7Yj1v4+83wH4DYwF8g==
X-Google-Smtp-Source: AGHT+IFZRz9UfQrS6BNJFqt0Mxm13A3oZEJnZ3vpUGwk7zGazXnGQtXsHgCVJHtFbErZzxQPPNK9Ow==
X-Received: by 2002:a17:907:7eaa:b0:ad8:8b62:7833 with SMTP id a640c23a62f3a-ad8a1f31921mr308515866b.35.1748464556327;
        Wed, 28 May 2025 13:35:56 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b29314sm165628366b.88.2025.05.28.13.35.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 13:35:55 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-604e745b6fbso414761a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 13:35:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMi7cdsoCUZFlwl17/wcZvcPY0GiHdHowUQH9lOWO6W+zVqYS5qruDrGu7IuzGhoQxBmwC4CUT0LM=@vger.kernel.org
X-Received: by 2002:a05:6402:4405:b0:601:834a:e678 with SMTP id
 4fb4d7f45d1cf-6051c391cebmr3066095a12.17.1748464555249; Wed, 28 May 2025
 13:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527141706.388993-1-cel@kernel.org> <CAHk-=wggC6PP9ZNwKY7sEzdsC7h8qySA7pjqAchrYowniADUQg@mail.gmail.com>
 <20250528-wise-platinum-pony-ea6f62@lemur>
In-Reply-To: <20250528-wise-platinum-pony-ea6f62@lemur>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 May 2025 13:35:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzMJBiBboMEWy+cP5ke0otahkzfO-UAjvRh4XrSqrL1Q@mail.gmail.com>
X-Gm-Features: AX0GCFt7MDkczEmwkTnb1VLnT_bDG5bEQpgslWhXYWynZCrj6otp4h35LOxc5RU
Message-ID: <CAHk-=wjzMJBiBboMEWy+cP5ke0otahkzfO-UAjvRh4XrSqrL1Q@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.16
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Chuck Lever <cel@kernel.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 13:18, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> So, if you receive mail from a bunch of people called "Your Name", at least
> you'll know that they are reading the documentation (and still following it a
> bit too slavishly). :)

At that point I suspect they *may* actually be bots, and it's a good
sign that it isn't a real human behind the email ..

            Linus

