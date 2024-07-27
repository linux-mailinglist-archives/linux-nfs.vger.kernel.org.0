Return-Path: <linux-nfs+bounces-5096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C993E0B7
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 21:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00F51F217B2
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 19:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67D1EB44;
	Sat, 27 Jul 2024 19:28:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450F11C83
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722108506; cv=none; b=DOSCZsFo5Rdw1X3//+KTeaqyzhX+aKv6bS5hoYCr7XcpgolDpAnxDz7i/LT1w7i+gh0NYRWCg8TFuRPoXxHYehTmdIPZZHSE3EnI4rZlCr+W7/7uQeLDhd3gJsDYpjCKwH7bzTdT97tln0x/xPNT1Lavz7cH9aTlM6PvicEM1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722108506; c=relaxed/simple;
	bh=E72XtJK88nwxCDh+94FXRYrZOJwn3N+l2NdH8uCO6AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4BL0k/Daxl8pco52bXBPwAKOP/7miVDghauQekgFIyG2G7i/HwzcwGAb61RC4y1iq1KACug4Ngvx/B8ylDWiI9uxs+7f3QbC7yMS++7e2NN3AwQLkryHil+ZBKNWsqrEm21k88v/NfJFnonE1vOiuarpMKTKDg2OjMxbuS+Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684e2d0d8bso108905f8f.2
        for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 12:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722108503; x=1722713303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/IijL6z18qjJ0nSdzQyrXQOx6c9BzJq2skaakaSE7c=;
        b=l8dd1rj9+WPfC90ohCasMx9B19mfTM0b21GSibEi6DtPEmBVsKVcKIyFZEsmk1xqfs
         a472mjfLCDtk3uxVf64YnBMWDAviNG/lXIZfwEh2djqndyFpGP50mN6CzhWb71gY925M
         mvE+E/C4de1LcWAs+8rkxceHemiH/RKw6osxoDMfeuFlwmgFtEjequbF3m1cqQSJt2GS
         joEQ9l8qKyCg7RYkvj3DXaE3GqsxYIcro3jFduc2+tGUr1p/NeHPKr5BIKJuQp+6BgrP
         YUaICN0PCfEv8xehdKSH2Qg3M2bDnsGmWyrr5O2D4ZnzpBna+Jt/13S9HiPJDWLQuqPu
         ji/A==
X-Forwarded-Encrypted: i=1; AJvYcCVSm8P25GfsUwJhoXjbfVUwj2SmPZcG05CtcSIjtzpKs0K97pUTBIq9xGFOvDmGKBa1iO6MYXb6Pnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGg7l2EYHw7Gx4LMfZnfGoaeyHvLVhFcx2voVvuNC2YetGo8vt
	uWj8N3Bp01A8BUxlTU+6OUZagxAZ5IuRwqSIvC3RiA62AWRXFHNxwFEl+Q==
X-Google-Smtp-Source: AGHT+IEXhjQA7THquh3E6Yb+D29/G0pZYC+1r6Rbe5a7iq1SCO0Q7KKJw8FKgB4KXUbUAFGiT61jOg==
X-Received: by 2002:a05:600c:4511:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-428053c0936mr40910895e9.0.1722108503210;
        Sat, 27 Jul 2024 12:28:23 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280ca10aa6sm71217365e9.26.2024.07.27.12.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 12:28:22 -0700 (PDT)
Message-ID: <2990acc2-8f07-4f78-87d5-f49364127824@grimberg.me>
Date: Sat, 27 Jul 2024 22:28:21 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <df15b4f4-e325-4ed0-bc94-957113a64915@oracle.com>
 <ZqUl0EyyJYJhsItg@tissot.1015granger.net>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZqUl0EyyJYJhsItg@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I don't see how we can have a delegation conflict here. If a client
>> has a write delegation then there should not be any delegations from
>> other clients.
> A delegation conflict is possible if the client is using an
> anonymous stateid to perform the READ.
>
> One thing we could perhaps do is add support for the use of
> anonymous stateids as a separate patch. Sagi, how necessary is
> support for "READ with anonymous stateid" for supporting WR_ONLY
> write delegation?

Without this in the patch, there is a pynfs tests that breaks (read with 
anon stateid).
I can separate it if you want, but didn't want to introduce a patch that 
causes a regression
on its own.

