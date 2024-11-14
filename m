Return-Path: <linux-nfs+bounces-7988-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3622E9C9216
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 20:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8C72813CD
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 19:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041519ABDE;
	Thu, 14 Nov 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFzoGyk2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379D18CBFB;
	Thu, 14 Nov 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611110; cv=none; b=V7IXMGI25kTHN8qJiKPF7ew5WdkAs9XRyqFNmbG+3/duF7IfbqflGwrxLhvct+5OBPNQ8zuJml/eyWP9k/ScCbGblK+K5udCsytGcZ0BvkM+QSno0tJhcfYiHD0Gyk3JAZXKuIABpW/GWcO2J6CzUBF6VWBKnw6cDpLmCKYHEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611110; c=relaxed/simple;
	bh=DbJDRuSLShA200wqj8JWS+Dlqe3CG+CwunFs+VOQlsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k46Wj7tsV3bQRsjJdlBtZ2HHqqINRDe8/odeL0ZOkhvqjzDtdCRIdYPvpNE6sd5v8gi5VF9QpEbEQRvMiVd9QLsGcofOLjcUYv5eemr4HVZAtBB7vl8SXorKuOvDl/V05LWOPNZeH6VNsKeEKtFw5XWRGlclWhZbp8uvoGt2Y9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFzoGyk2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so672501f8f.3;
        Thu, 14 Nov 2024 11:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731611107; x=1732215907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4arVc/lIRR2+wkPS1zfykW4JwiV7UbbXDc1Ect71VoM=;
        b=kFzoGyk2G47PvT9opaRnMYj/rJ7OnEn8vaM3Pv0cyMQctr7E2CQYrNRolorcIJhtXv
         a7cb5e0s2T3spZH4a05KYsjz1gZlSuwcNzdMGkzDOAHVOPJsFh5YhTlC+hgV0n00tnnE
         JDNfJE5QcL1uAKm9Wxh4MSnT4lQ/3zCUK1EGcuctOk1AxNCvnsOjyccK6KZesKQ1vzuh
         DrdjMiD6dYBumUZ5iiXn5FhZqMShl5DHGVa/weQwz2Pins9cOzzyjclMPdsef/b3KFhA
         J+XhE57qkWOE796RenB7SY15t4sXftW6mkjvD6uk/xWDEsaWwNmg8ZMPAoRHZsCZi8P7
         3DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611107; x=1732215907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4arVc/lIRR2+wkPS1zfykW4JwiV7UbbXDc1Ect71VoM=;
        b=ZrFNUbmTlacHpk96fLy7tj8bIKPvSxwN0/aTgbI6kZECRKPsS0iyQ59Z9jjo59jylD
         VxMK4SOTUnUgiEmE6cgh4cwLl8jKbpRMyINBsB8i5fLI0HdB3sbV+JpWianX7Mp2Xuvb
         8u3btR2mJQmpAv7OUg2g0ZaWloHF8dWGV8ihqJM5JMbCv3BtKZGSp4DzNjVvx92lrSV/
         wwsqjK6Xa15f+WRqUkL7jUo66eQ/yEkiK1anWxlS69OOmrU4ZAcJNNfpmSi0MU/MFh/y
         PWzMmfwx2L5Z/jOf3lVtxmvEaKS594BiIfQyX7aJzufT2NjGWn3GG+uwvFb1KGTDpB5P
         Jy9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3n1XZB1DL0IVWxQfCUBDDxqiENIPHqOssqCPBUQ7/aZp26B7Vj6jFE6mB0cEtvvP+vsuyiMEb@vger.kernel.org, AJvYcCVIfBaskYFidjtKwPWpysJH55qfpXdki46fIic39+iXHDq43AM6+HyyUqJt3wa7ZXVkiPmfnLtEgm26Rzo=@vger.kernel.org, AJvYcCVu5jGC0S+iGSDFvcPAeYVGMFK4dtYklLHA6JI/j9yasW95noVar7Qh7luyZm7q3EmSwl+Q1IGNFUg2@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWz0zDuymVXrGpRWlQh1+ZMbVD6e66F3Rv1VjTHWfT6smhxzb
	T5LcMfnulMjiebkGl3Anc5efR6nrDJ+Ke+Ml11mMl7MOn43yLaMH
X-Google-Smtp-Source: AGHT+IEPoxJL3vk12kpIWe7rVi0czNqkBp3WsfV+muenmfpR/vTpuftD0YtGrter6Yzr09NSLeb9uw==
X-Received: by 2002:a05:6000:79b:b0:381:f443:21d8 with SMTP id ffacd0b85a97d-3820dee1531mr6813982f8f.0.1731611106196;
        Thu, 14 Nov 2024 11:05:06 -0800 (PST)
Received: from [172.27.51.98] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad397sm2165526f8f.23.2024.11.14.11.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 11:05:05 -0800 (PST)
Message-ID: <bfeeaccd-dc8f-4f9b-bbae-4b13547bd04d@gmail.com>
Date: Thu, 14 Nov 2024 21:05:00 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>,
 Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Networking <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/08/2024 13:40, Tariq Toukan wrote:
> Hi,
> 
> A recent patch [1] to 'fs' broke the TX TLS device-offloaded flow 
> starting from v6.11-rc1.
> 
> The kernel crashes. Different runs result in different kernel traces.
> See below [2].
> All of them disappear once patch [1] is reverted.
> 
> The issues appears only with "sendfile on and zerocopy on".
> We couldn't repro with "sendfile off", or with "sendfile on and zerocopy 
> off".
> 
> The repro test is as simple as a repeated client/server communication 
> (wrk/nginx), with sendfile on and zc on, and with "tls-hw-tx-offload: on".
> 
> $ for i in `seq 10`; do wrk -b::2:2:2:3 -t10 -c100 -d15 --timeout 5s 
> https://[::2:2:2:2]:20448/16000b.img; done
> 
> We can provide more details if needed, to help with the analysis and debug.
> 
> Regards,
> Tariq
> 
> [1]
> commit 49b29a573da83b65d5f4ecf2db6619bab7aa910c
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon May 27 18:36:09 2024 +0200
> 
>      nfs: add support for large folios
> 
>      NFS already is void of folio size assumption, so just pass the 
> chunk size
>      to __filemap_get_folio and set the large folio address_space flag 
> for all
>      regular files.
> 
>      Signed-off-by: Christoph Hellwig <hch@lst.de>
>      Tested-by: Sagi Grimberg <sagi@grimberg.me>
>      Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
>   fs/nfs/file.c  | 4 +++-
>   fs/nfs/inode.c | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> 

Hi all,

FYI, issue is fixed by:

commit dd6e972cc589 ("net/mlx5e: kTLS, Fix incorrect page refcounting")

https://lore.kernel.org/netdev/20241107183527.676877-5-tariqt@nvidia.com/

Thanks,
Tariq


