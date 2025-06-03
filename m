Return-Path: <linux-nfs+bounces-12083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11147ACCEFD
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65487188BA5C
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38321C176;
	Tue,  3 Jun 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwrTPkdr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6A1D54EE;
	Tue,  3 Jun 2025 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748986233; cv=none; b=TzP7IjFLQocmw8eLnxYF1+ifCECuAO92K/f3vuFyjS9Jv4iKmuqYi7oSRH8Subcp76tHaSK8h7aOCKpve1I/MfN9Ec1EjSFB3Bx49BWfKyPoqUYfhoVuGLl5kg8u3aENx2yhVXlPKgoGcYvdgVClS7SycFiSHz7NYm5bNLbFiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748986233; c=relaxed/simple;
	bh=WtXvKVt8VUFg8MytFaKsTYDiNoeFxLn1B0pT71jfpH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKSBEj7j8yp4zvsyfEbe1xAPXstmbZ6W8bS0GEm85T6YFubes9LGoKAjL4xZ0adnp/dfQcVHJjq7WpwpePjcm846zzTKrhUVbboQy0mMjyYmTQmCziq6a5WBWgjJqpLmudB0mkkl+MsMab5q52iWIti8ynrybe7zfGVU2xWb41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwrTPkdr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a361b8a664so5881315f8f.3;
        Tue, 03 Jun 2025 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748986229; x=1749591029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXpXvTT+xQLNA8z5uAwvt4SF8j8NDZCMNmC9o8T6C+4=;
        b=BwrTPkdrAPJyO1MW9+BkDphzeYXCsj3Jx9KdkASUBt5J8O1ZP9rrWKJMaI09/geEVK
         SB48t3nstwg9pwrJ0ozAtLUMxAHPB2adz1+abSgyg5GiJn1YLO8tCo5GnLsS1JBqJ3Uc
         Mb/CP/RhXbblWSC4eKmRCbVE0sgrc7xUqxWhcTMQQSSBqrGnShdlwCwXTHXKyHi9YGTW
         EGuGEdCsY4gbS53qTuepMJ/b/rtvB3HzgPRbapcy5AnFhfPB00Ejjvmg6MPn49vFiVw1
         2HAupibGJZ9pShxwJc+9IbTBGJuGxQ/uR6P9BrPDhTPPBcE0McN69d4ofvwx7N/2P/Rf
         Nd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748986229; x=1749591029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXpXvTT+xQLNA8z5uAwvt4SF8j8NDZCMNmC9o8T6C+4=;
        b=djaAitrXx994ogqIvkfjV38Vywy2sWyIEGOCIeIm0wVeijm0zt0B6boJfAe1zNT80a
         QBY5WVzt5tZP7A9/KfOJu87EccFdm2PLsbcMpauILHFaZGV/bvdUteVYfYocmIZiQ0CW
         hDNkZsl2pNlpNVbFW8bIokCYyzuQIEORL7IX/d9cP4rHdzLejpeblWGMbOyOqStuZ02/
         W2709cvB+7/VLVQ8ZvaIptWtK6nzMD2Eq9G6lrGAJQaz6/kFH2/GakU10bLIHymMXNOz
         SHjyhzXjBgi2qqfJ3TJbOeM43q+FGsqaTHlmnFXWefWmblHeKQ8lOx0Cp1ml8kZJVmhG
         2Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3gwjKkkWoNhPNH5yxabU0gQgrw7JuoCRTHxTtdQ9j5qmgVb2opBPgWyQh7G9HzNMeq20cozNZO0=@vger.kernel.org, AJvYcCWOos1WKROJgUd28GZ1WrsvG/ZgPSxaDob7nMZfVdUSKzHUs69gQQ0FMh/5atUsrsCeYtb61bMQ@vger.kernel.org, AJvYcCWcD2PQQel6NwkU9zKUkyReG7J8p3ZqB700WSJCfv5m2YvtnSdBpIQlmARpHSP6jaRSYxrf9rXzSBkzaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6RxfwQVsGS1FHPAXPar4NtbEx8xdwSkeM/Up+bu7vb051MDXo
	HSpOPYSBy7cEmKTxAgI3MsxWIMAPD4bWZG/WWvnUV8sKv9Dq+jgSMBRg
X-Gm-Gg: ASbGncvjEyzCU5vrxXyYakQpCtb+tOr7fO6C7mrq5NKcLdnuNWFK0i3aq5DwK7JaaPO
	6ZugeO9N6KKfWFX1D3JSk35uEUCI2hswi+hDs5BsCFot8pgHQu37Ub8u87aKMuUH97FOrVy3l+A
	ytdEbJ6GcqDS81r1+TLNYDYZYCckcd264mOM8IAn4z5VMkQzsJVZS/4/ItN6LM5aqLCl/RNBfNC
	rE1pCO9a9qnOJld1mPRqXamU033/RZtO0LQ8Z+ibW8HhgfsI31ie312cGht8ou+eKufTmK1Mlsz
	18bbARoIn6Wl3Ku2Mldm32gErFRkm7d08fLhXSd8LlQ8gKLGX4YDGo6d2v+yhshUK9YwSse/CBu
	ur+EmBSTfFdnbvA==
X-Google-Smtp-Source: AGHT+IH1NNz0bB48MnqJxgA4wHuK4JMchNfQmyjWht3RVt89c59AQFv32k+Eyv977zem0/zoGPmy8g==
X-Received: by 2002:a05:6000:2303:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3a51d92f833mr253946f8f.24.1748986229347;
        Tue, 03 Jun 2025 14:30:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b79asm19084051f8f.2.2025.06.03.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 14:30:28 -0700 (PDT)
Date: Tue, 3 Jun 2025 22:30:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, axboe@kernel.dk,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jaka@linux.ibm.com, jlayton@kernel.org,
 kbusch@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, sfrench@samba.org,
 wenjia@linux.ibm.com, willemb@google.com
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Message-ID: <20250603223020.3344d362@pumpkin>
In-Reply-To: <20250602050817.GA21900@lst.de>
References: <20250526053227.GD11639@lst.de>
	<20250530025401.3211542-1-kuni1840@gmail.com>
	<20250602050817.GA21900@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Jun 2025 07:08:17 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> > In the old days, sock_create_kern() did take a ref to netns,
> > but an implicit change that avoids taking the ref has caused
> > a lot of problems for people who used to the old semantics.

That must have been a long time ago.
Was it even long after the namespace code was added?
(I don't have a system with the git tree up at the moment)

> > 
> > This series rather rolls back the change, so I think using
> > the same name here is better than leaving the catchy
> > sock_create_kern() error-prone.  
> 
> Ok.

Except that you are changing the semantics again.
So you end up with the same problem the other way around.
I can imagine code ending up with an extra reference to the ns.

The obvious name a a function for general driver use would be
kernel_socket() - matching the other functions that were added
when set_fs(KERNEL_DS) was removed.

I definitely aim to end up where the existing code fails to
compile - just to ensure all the code is found.

	David

