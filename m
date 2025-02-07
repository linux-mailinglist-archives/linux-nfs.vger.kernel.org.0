Return-Path: <linux-nfs+bounces-9932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD920A2C0A7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AC53A11FB
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4AF194A60;
	Fri,  7 Feb 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+kbsGb+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB886AA7
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924404; cv=none; b=LLDAhqlnupGQ/xypcmCD3wInaOYvOPNxJUMwTCz0NjJR34K6S//VlySku4dIntutbklccLPyp7ccqqP4d6xAVkKdaWOXrjCoysIWNlFUhrv5uCiVufN/6EzxaHFDjdYio1N3LS0aTSgtYwQi+C/5YYJcsIyl0Y1SvLPlf1CkVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924404; c=relaxed/simple;
	bh=Z79al1v6JuXMC0BZBk8asvpjtAY06H/Mvl6tanbNnwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xa1vHqxJKnkFxl+YBxP65rTjCb8qiSBl4f/59miCeKVFLgfoK0EC0zulH2Pq6FWZ7Dj/CYc4r+xIImthUqC2H4/eBVAwN7vcihPsTT227Xco1RNtP5k1y4dd5X6jhlyV+AOnZgwqKLWkf3+3K0wloBcFncUPRBGywDdnruxCGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+kbsGb+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738924401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3VR6IEbz7voG5Sw4g6V3jHstJ0SbvvwjTAf3lO/DH8=;
	b=A+kbsGb+d75HptcoIXd10Aaeg8DwvjGEs25+h0cdmRHvqu1Qak3RipbWLhlX5FgsfNWPbO
	y+DbmjYludJteFQuEmgHF4D3Ur7FLr0gG8d5npJSMKxTPb2zGQjMpWRt7xIw0n1Y3G1vvq
	EkRWj4PHymeIUZsuKeNsIATxCb+jNSY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-7SfcSiNXPKm8bAPJCUqtjQ-1; Fri, 07 Feb 2025 05:33:19 -0500
X-MC-Unique: 7SfcSiNXPKm8bAPJCUqtjQ-1
X-Mimecast-MFC-AGG-ID: 7SfcSiNXPKm8bAPJCUqtjQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f274f1f9so301113885a.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Feb 2025 02:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738924399; x=1739529199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3VR6IEbz7voG5Sw4g6V3jHstJ0SbvvwjTAf3lO/DH8=;
        b=E76bOhuN0RpEQrjhJCJUeVBP4SP0LMTorfgxKg0/wj1Lq2ua0EGZ/i0og2qs5LLDka
         ltIz+2+WcS7HPd17XqnwWtCX4zf/zdo3HuYT0uGePuZAjvfgpBzETw7CpU9B3j1GQIgH
         qNLRkT0HqCAJwlJjja1j1+/oTcAh0CYNrNZ7YmRruvQcyXa/gs3an3RJXXNSWdx+5sNu
         kmgnXCAdQKIHfqh8UjMjxzvfYeQG1Sk+r5Gy6QqIag87IKn9PLwdMBHvHcUeG5XiUuyK
         Rta+2zWyrQlryEivlRQWj0f3DN30YB55b2+U3IeAAfpdmz5FoUz33Z8U15+lAU1G4vGI
         c/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVMPJ4nRLHL/4xveTFrNAP4bwosnKDkjVB1HLJip62UIQoD8krmO/PBETKPwpDazbiP9c7yoOLkxF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCVeVs3TZGISaxKEznD3/mFBDIDw1ZLQ0dxKYdbnYTApUEC6s
	bzl8kyVDMGr33Z8LNM+oSqFU1OeHG+SeqpdvbNcXW2FQ+4j+m98bMTKyEPhqKXbxsKixfhLFpmI
	OFVGZL0q/pHirZ4S4hhxcoytPFkKS/b9/JRkCVgf3f63UveEshAssiBaOLg==
X-Gm-Gg: ASbGnctoyKUrtpLP9XR2QKVBK18mWkOPOMynbgPkCUkZedHVtFHsKauI9ZXFihso/Ht
	0qDMkGs/mBxrw1QInaKtCFYlygahtQ4cCOx9w8VXv8gM3Wm8I7VUuxabUCXycuN/KslXI6+ohfV
	jWzfyd2KsP/8u87KI3JpC5vxZMZhB9S6NyQN4wR7PW5HxeqBPB5a7TxJhcTly1FpXYHQLXaO2pt
	cPuofepOKjfk8HBJf69xXmRkvAvussfjCAwlODmW0YThcIAKVyjOrqm4n2SxbTZOlLLiluprGoH
	OrRExQ==
X-Received: by 2002:a05:620a:28c1:b0:7b6:eed4:694e with SMTP id af79cd13be357-7c047c211e6mr451104185a.37.1738924399356;
        Fri, 07 Feb 2025 02:33:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzBvNNMRbK/qz3vmo1wU3FsEHx47vhVwyI9NfB1iMLZprgNQRWtlm13AAhMa6IYyuy2ffVyw==
X-Received: by 2002:a05:620a:28c1:b0:7b6:eed4:694e with SMTP id af79cd13be357-7c047c211e6mr451101885a.37.1738924399115;
        Fri, 07 Feb 2025 02:33:19 -0800 (PST)
Received: from [172.31.1.150] ([70.105.251.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dedc7esm171504685a.24.2025.02.07.02.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 02:33:17 -0800 (PST)
Message-ID: <ad6dab09-7520-4215-867b-6b9009fc2791@redhat.com>
Date: Fri, 7 Feb 2025 05:33:17 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] systemd: mount nfsd after load kernel module
To: Andrej Kozemcak <andrej.kozemcak@siemens.com>, linux-nfs@vger.kernel.org
References: <20250130113234.885998-1-andrej.kozemcak@siemens.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250130113234.885998-1-andrej.kozemcak@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/30/25 6:32 AM, Andrej Kozemcak wrote:
> Systemd should load nfs kernel module before it try mount nfsd file systemd.
> In some systems systemd try mount nfsd file system before the nfs
> kernel module was loaded, which end with error.
> 
> Signed-off-by: Andrej Kozemcak <andrej.kozemcak@siemens.com>
> ---
>   systemd/proc-fs-nfsd.mount | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/systemd/proc-fs-nfsd.mount b/systemd/proc-fs-nfsd.mount
> index 931a5cee..630801b3 100644
> --- a/systemd/proc-fs-nfsd.mount
> +++ b/systemd/proc-fs-nfsd.mount
> @@ -1,5 +1,6 @@
>   [Unit]
>   Description=NFSD configuration filesystem
> +After=systemd-modules-load.service
>   
>   [Mount]
>   What=nfsd
Committed... (tag: nfs-utils-2-8-3-rc6)

steved.


