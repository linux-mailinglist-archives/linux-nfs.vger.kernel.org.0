Return-Path: <linux-nfs+bounces-12584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD4AE1545
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 09:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D370B17F698
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 07:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D670231850;
	Fri, 20 Jun 2025 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2kB9QhR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869D23237C;
	Fri, 20 Jun 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406020; cv=none; b=jI2GplENiOZ5w4+qGsZ7D5YdCmCxqFmkTFEfz8RvqChKJtfPKrsLo1Bww69VxxqqdetojcCO5ZVSLGaximrdF3WPPrHc5/jT2xNZ1ngUNYP4otWX7RBTEHqMoQ1BQ5GNZwCua0wUz60N7VQJ49y9Akfq5ou1c1VbV0oLa9vJ89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406020; c=relaxed/simple;
	bh=qo6h93Fp0cE/qzJ3P2ykpMkRijpnUj/LdPFZGdtJe/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqpqvjvQ84IKY89V6sdJb7YMnYD4v4SIxshiay/uMJyZ+It6HGfJ2d9PlnNqjxEchLuFV5WFareC7RL4FsrHyCBAffljDBXIp5+IbARMKc4Uniz/l5ADE7oHmcnNogeaUEu6bqyi4uyyXb5HTbDxfaQTjMw7MMXrEehdm//uWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2kB9QhR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553644b8f56so1545351e87.1;
        Fri, 20 Jun 2025 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750406017; x=1751010817; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo6h93Fp0cE/qzJ3P2ykpMkRijpnUj/LdPFZGdtJe/U=;
        b=X2kB9QhR0o2cHXFeVkwTipC78zOH4UtuoWFtsMEqW3X51SjZ2msJ8xVUuZ2Vs1tvuv
         ujI04Ke+0FRmSBRoTJq/znkkY248fLiBsauxa2MVZCtnRLVn0+1l1pnXhVzAGIRJ2AJx
         cJSk5UKSLohwNIJApUzyPqDf97OxOtnbKrueCqevST54AJ7ozTAxXdeltnB+fulHPIwc
         sACO+pXCLpQpgsuhmh8vHKdQLjeuzh+9yL0RwhCiPwpe3eeP64gYje20cJW2YklHDjMs
         4Qii8AnrMufocKUgbwIiQUKwZj0sspCMQlY3M+t4/RGOHkvd3LXCENuB8C1Zuc8m69jH
         56xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750406017; x=1751010817;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo6h93Fp0cE/qzJ3P2ykpMkRijpnUj/LdPFZGdtJe/U=;
        b=BgC0bB1BT+Uc//tzgdANYLFvyscN590DBq3rUER2kPM7I1zhuPoGBg4jFWt++RlaAT
         Ih0pwkAlytO0Vzr/RSv69X0zlRzRyllMDA9m4RZplyre6YWL+azBTmv2XpkQNUuYIdxm
         LDbPSVzHhwxa/0shKZp1HtA0FHdc5bWHUqEfNM24cM7Od7NP0UxXvXwKS4Snv8ubz1ai
         ESs6aGzLcUOCz20ldtUO7OthXaMlNBjxZrswZ7LnaynTxQR2oBoCW1PXWabQn9fkFmcU
         /RYZICoC3WT5OyGD5bWl93SoQyWyvTB58Re/5dUJ14jsu9bcZVr3rCTeWjAC/YsKrHLd
         v90Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0Fj7uwnJFQT9ko1aHVHinvC0b+6Layr4TNY68CKjKgM7qkLQHfOTNXkMTS5yK2TYcxxfbHq0QZxSA@vger.kernel.org, AJvYcCWO0QmOkC02t6Gy8d3rRTe+FPcdn44InPcRaWIZuNel+GZvBA3yrH+aJjVy1nOH8fKGsfHF9Tw7IoDlVho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14Lf5dFDX9xniK2rT3NMtsvffJoucHb+IE3+IszwFKSC/qWqK
	8dfoFNADwGg4ICtUyQC4xikCXfHSqqy+qHCVvUpW0O808O1DicBe2/25
X-Gm-Gg: ASbGncv//8EMe9PL0oqhH+ZsyXjmxhO2ETfK/o+QtQSDmIdRX6g/BZ6tHzXBoVpu+qW
	ToVbKQguGqaQPKL0o8kpZKl3yzZfSviz7Ak1EH2qWePZBsW6glCpK/RrVEx2RmtTCRfMVH8zZHo
	Z5jPFSirsN8+jlox8Umm7Uf7FimSL6TiQ60m6uqjdQTfOPsCJ3ZlL+AmptcljUwvzGzzeoiKIDf
	Vn5MRdrQXfCRV7EwEBTL+wNVd5vFdOK76uV3Pv8ewEmoOv+g8I1ZSUFNPgr6nPTuVUOhb8b9sSm
	mF+n0z5zUadEVI2KZpf11nYL0lfuKdsdI/MfJW+zTO9MdUhaOTzNbwMzNWo7E4bBB7XI/YsB6QL
	/Il8kYyNO0i1I1g==
X-Google-Smtp-Source: AGHT+IFn9yg9lrRpDjq+3Zy6jqdiploB1jBXRtx63vokm2wRpQ/WFKyUoVGpZcz2Dx2IrZG36gGX/A==
X-Received: by 2002:a05:6512:10d2:b0:553:3127:b00 with SMTP id 2adb3069b0e04-553e3beb559mr576309e87.32.1750406016571;
        Fri, 20 Jun 2025 00:53:36 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.201.55])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41bbf5asm189618e87.91.2025.06.20.00.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:53:36 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:53:34 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Konstantin Evtushenko <koevtushenko@yandex.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: Implement large extent array support in pNFS
Message-ID: <ehmu66bp4rmhqx4nd7vrn6uimx5eyr55psppgevkbdu2xr7lop@yj6xrr6gyvwb>
References: <20250614155950.116302-1-sergeybashirov@gmail.com>
 <d29f03f4-c06c-42ef-952d-6a7da196d03b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d29f03f4-c06c-42ef-952d-6a7da196d03b@oracle.com>
User-Agent: NeoMutt/20231103

On Tue, Jun 17, 2025 at 04:35:03PM -0400, Chuck Lever wrote:
> Hi Sergey -
>
> Typically we separate the clean-ups from the substantive changes. So
> removing the dprintk call sites would be done in a pre-requisite patch.
> I'm asking you to do it because if I split this patch up, I'm likely to
> get something wrong, and you have a convenient test case.
>
> Also, reposting means your tested version of the series is what gets
> archived on lore.
>
> Would you mind splitting this one up and posting a v4 ?

I agree, this should also make the main patch a bit smaller and easier
to review. I will split the patch.

--
Sergey Bashirov

