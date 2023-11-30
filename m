Return-Path: <linux-nfs+bounces-197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61297FEEC6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 13:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA88B20F97
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4A4655C;
	Thu, 30 Nov 2023 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrs6rVEv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F319110D1;
	Thu, 30 Nov 2023 04:17:30 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc2bcffc7so7926515ad.1;
        Thu, 30 Nov 2023 04:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701346650; x=1701951450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cV8e1UvZJ7vVOkngLx8eOhYxgidZX4Pz/fldCBPYaM4=;
        b=Wrs6rVEv0Olr3ZQvEPWoSMe/2ztaPzNvoTzQ7HykR0lOGSTC9EjSkDElq9XXqs1e1+
         S/tV+Xx1Dm6I2O6konHKExInZCZumjZL0zIjGOgRwsg1/gS6/7AksZYhOQsAN5DLFI6z
         8Yl8nuTQVmyJi1YtovA37ae08ntNXjrZE7PloTSdBvcq4/Qzxs0DU8M4+1Tq4+Zmn4fT
         jDqIs9Ljp3tTSVQmK09BCxBhzYMtUT7V8wyBinuBYx3zEuamb5QDjh2V8zjheCiYtzT1
         mbs942xevf08+Q5c5g+W2aZovcbdFUvAzKqVftou0Q8dH9wGNqz9nq5w7ycti5jpwOZ7
         piaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346650; x=1701951450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cV8e1UvZJ7vVOkngLx8eOhYxgidZX4Pz/fldCBPYaM4=;
        b=SnetmFCsK5yP9h3IpanIumLjP4THR8gnzSjldroOuRoT9RIC3hzXLihBFgcOmka2cX
         /LStkH2l2D4LLXn0rpm19LWUxDuIurwrbEyyKRm9Ic8IHVAZfP5NnGi1b/xJ6UBzToED
         vJ5KYEH8a6Ejlsvd42n0AI2aciSA3Sm7VLwjISWDXXUt3b4ZhtlqKJZQrZzMYZ53KTE/
         WB5L5PJ/IcmhMCyDrjTRsIfVBIZpv8gNYTMOowtmaainIzOuTUnRaNWr+QOh5Afh3a/g
         b6+nBh/HNlczFaO7gOGWN2aZwxeLPO8i3ZVZ9GtQNI5rmw0ppkITOTM1foz+5KPq+lRt
         knSg==
X-Gm-Message-State: AOJu0YxoCG4YKeWTn9fWELLTzPotvYIiHxKWulP7USLhqPjU/b9dteWh
	dMftg36pX0JUa4uRdor3xrk=
X-Google-Smtp-Source: AGHT+IHsnIe+it3ftrePzCsv53FcL0tZqQbwsjY1j2i3sxMKwWD8IoypthNtoxTM739SRk9B1Ug2Rw==
X-Received: by 2002:a17:902:d2c6:b0:1cf:cf1f:a4a3 with SMTP id n6-20020a170902d2c600b001cfcf1fa4a3mr16795698plc.0.1701346650285;
        Thu, 30 Nov 2023 04:17:30 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm1206630pls.240.2023.11.30.04.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 04:17:29 -0800 (PST)
Message-ID: <9f53447e-191a-4e95-9f36-33f7eff82ee7@gmail.com>
Date: Thu, 30 Nov 2023 19:17:20 +0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hung task panic as part of NFS RDMA Disconnect due to possible
 bug on 6.2.0-34-generic client
Content-Language: en-US
To: "Sukruth Sridharan (he/him)" <susridharan@purestorage.com>
Cc: Linux Network File System <linux-nfs@vger.kernel.org>,
 Linux RDMA <linux-rdma@vger.kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>
 <ZWg7gGnvVOYjIhx1@archie.me>
 <CAMyEAb9aAMwKByOx38VJP1+N0+d12sDF5FiEx-aCMdOnEF_sww@mail.gmail.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAMyEAb9aAMwKByOx38VJP1+N0+d12sDF5FiEx-aCMdOnEF_sww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 19:15, Sukruth Sridharan (he/him) wrote:
> The issue has been seen once in the past few weeks.
> Unfortunately, we're yet to see a repro of the same.
> We will try to repro it on the latest kernel.
> Curious if there's any improvements gone in that you suspect would
> have resolved the issue?
> 

Please don't top-post; reply inline with appropriate context instead.

Sorry, I don't know about that question.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


