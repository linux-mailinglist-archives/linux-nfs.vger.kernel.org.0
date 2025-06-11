Return-Path: <linux-nfs+bounces-12322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6BDAD5C07
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD113A559F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451F1E5205;
	Wed, 11 Jun 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKyMGJ4+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF461714AC;
	Wed, 11 Jun 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659072; cv=none; b=Ml1Y3XRP9BZ8SCF0VjLysGbOaCDi5A3GCU1+XFEsbfEJe/Gq0jtHQWKM4QhjNTFhkexvT1gVnU6BOiFDF2C5gGXqByY2zCGfTaIQdRWtqHX21ZrLyBcPDZQEUAk33u/t31pzm+Kg/rLgpXTvguV6pVp3NwXm41jpN9hz5awlfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659072; c=relaxed/simple;
	bh=U4V1yvfFMm5+yP4PtZjqE6qJ4IC5n46Xy8msyeZxs7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plTrJtqPvnCvMQPOCKT7+kk2T7cx5pMDxLw1tEclozyyFher/Bx3ceKu4EyrDivZlW2fs7HnqR0DaadpNhkrTNVJRZHe1c6OEz74WqOcVnCWwjtEWjels/AumbWiEwOG+E2sH9wgDlsvSQ4rg+JMN4ufJrBc0uZk+A6sCIpkJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKyMGJ4+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b2e49b62fso19211fa.1;
        Wed, 11 Jun 2025 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749659068; x=1750263868; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUp5lrwPBRgOR2XCjQjyLScV5EWWrimUfSstox12GXQ=;
        b=FKyMGJ4+e4M8JS4gp+QRgBRkeP36aQlHFeDl9H8vT2DoKwIymDSP9O8hd9Hj8xP6nd
         oJ7RleOCszA/xMWwJ3vJPqJpeVCXeG4a3qIQDh3zF/litzpO2g/hDmcRKvuGXGMiw4AM
         UT8N1y1nUbw8uStWrWbrOrC93/W2B+A/OvgNFqJI/nVavhqqMDCVKlS/NN2IC5VWkoFc
         0zZEITabOli4T2c9ceRzwun6rcYfNJwK0GapL+Skj54Fh9sGbkppE7lA+H64IGf+ZJg9
         E3NuPDETAPsv5jn71uNkGtiPR1qouZ1+aCEa515cLKErmZ0oVZiXST9JhfFCQwm4D6Eh
         nF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749659068; x=1750263868;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUp5lrwPBRgOR2XCjQjyLScV5EWWrimUfSstox12GXQ=;
        b=Xbu2k/3gsjQNCgdX4dzYM6PcBYStiBp6i4NDfTrvX+xSNxcM0GwgZwKgedejHlchAd
         UMeFKmqPYgsZ3Af77JgQlwfXhF9znfLWtnTKEegSD8k5i5wd0jISdsw8xcl52C4EHdBy
         0AT5a/uIsl9F5VEbcS5G+++X9mUitX0wEJ6u79Hu00n/TYnrWVekYF0LmC46iRtB5fkG
         wEn4nXJqavVVmsYGiy0N6lGduYWhaxkFU5bSWqDPClX2/uqLFR+Lz9542Pxz/dQCA9PM
         kZ6jreb4biKa6KAcxj24MQHbsJ+574AAuKhMMwV7Oc6DUJoKraZckUW4Q5aXYiMybs0E
         bgAA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Kyt5JdXK48H4Kbd6vyUhZzafutZqCvYghXfNauRGiXr7z8+Ft4uX/ewasqIdJKCKl0pTO63LUB5N@vger.kernel.org, AJvYcCVhEfUKfAVrQFqytxg9FCCF7g5qJDUnxm0DU3U2hM/gsndesjeJHhmfWvalSuQgh5RcSeLaeHabF4+gnik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHue6JjbGc+yDoZpMN1Us8l6etjughIfiDIn8QdQRyoO6rqf5
	m8aqTCzqwqbIAVSrlWKlRNUhKA7oRkEa2IxMs5K0rO5iD0EWd5gvoUvpXEnasfuP
X-Gm-Gg: ASbGnctFQkimhANkR7hiJS/17FNm3nlO9eN6g9CjArUo9WMSxZKEwQxk4PUrSrNRPPw
	3iG/00RP00UqFDYaBMMN/3IPJZEJSW9Mhv9Qk19GDPrGlSteI+CXHA4UFIpjTpHbfyzfZ+1sJh/
	0dZMLSjVFgMstpN9tQh/zpsCP7aT2zpe5dFJWPeF24VRTvuPInH4oLyBci2vh/6VJMcSF8Ws6Sw
	K70h3L5Q2wvgA3KMYqtQJzI8oDrdUOrAvneGQenmo4ynutRcjKp9IhIvSZu9GSrfd2zWB52iIfL
	yiChLqg2Y8bsB4hGvHPmlJ8iMMk3awYxC0gOU1b2TPCN/DAzxNoFUcQp9reofWM/fBpENCfstAd
	MmJybcYA1mrwrBQ==
X-Google-Smtp-Source: AGHT+IGAUdeAXXaZBEpcyLB8BnKKUw/8CVgXWU/PQrAmrdCfzwp5aeKTUIdwug9osrsacNvwyZXWzQ==
X-Received: by 2002:a05:651c:1a0c:b0:32a:689a:e9c6 with SMTP id 38308e7fff4ca-32b21dc6611mr13864511fa.26.1749659068196;
        Wed, 11 Jun 2025 09:24:28 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1b34742sm18860331fa.32.2025.06.11.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:24:27 -0700 (PDT)
Date: Wed, 11 Jun 2025 19:24:26 +0300
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] nfsd: Use correct error code when decoding extents
Message-ID: <2eq26bzisytieyfvad46uz5lr55msw6fdzs57lp5lcjmguuod2@nr2aryd6qaau>
References: <20250611154445.12214-1-sergeybashirov@gmail.com>
 <5c8c207c-0844-492f-99e0-48b874b5404a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <5c8c207c-0844-492f-99e0-48b874b5404a@oracle.com>
User-Agent: NeoMutt/20231103

I also have some doubts about this code:
if (xdr_stream_decode_u64(&xdr, &bex.len))
         return -NFS4ERR_BADXDR;
if (bex.len & (block_size - 1))
         return -NFS4ERR_BADXDR;

The first error code is clear to me, it is all about decoding. But should
not we return -NFS4ERR_EINVAL in the second check? On one hand, we
encountered an invalid value after successful decoding, but on the other
hand, we stopped decoding the extent array, so we can say that this is
also a decoding error.

--
Sergey Bashirov

