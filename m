Return-Path: <linux-nfs+bounces-9931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C6A2C0A2
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82B63AB138
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4571DE899;
	Fri,  7 Feb 2025 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmC7cvEs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A151DE2CD
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924308; cv=none; b=O+jynXTs6qED7ww33ASlXjy2s0JAw0egi6sTk1J/2c64jD1c6aNSDLaMq8dqnIcIDfVgIoNXUeWeqauBaEyelWAicR0N9GRHXM5SzR5dEJJQwmZVcWjLV56AjMbmar26km393EgS7pZ/hfkKYzd52vL9mvYHStp8LpBPVjKamgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924308; c=relaxed/simple;
	bh=EimbVFxXz3PXiSA12gLq3C32WS+iYW4Um9zMoqXJGUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KExvdHVscgTArJje1/hVn1xySfHuUDruJyFY0MXTL8f/HxJEK0aJHeThkd3bBoNXki1xeP9Weick7VcAVRzKN8BxkgQLiglwxyTe3posuzUd0lj3AqIgTQru4GXLIaXz2V6YaZC3zU6o8OcZjoneW96YNTwXIPP1YyOfGfL7ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmC7cvEs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738924303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTCfoIluBkd2hmuVQ37KolRiD7UKeIdoxiXw4vJWCJk=;
	b=YmC7cvEsLUunV6vhRHhcaBT+NQR5RCVMaqmP9/lujqiq0eqZZS8zZYJV/NAwj48w1InEjx
	PCgrlYNv0cBls8piAY68TBAW7tuixCBCEEom4lVimhtsGdFCa0Q7KcSPzdRaEeuPXDYPL8
	K0EOPey29J3+LfDQqYbjRIZ+EqxWtQ4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-brY3S5o4NImEK5hprqPoog-1; Fri, 07 Feb 2025 05:31:41 -0500
X-MC-Unique: brY3S5o4NImEK5hprqPoog-1
X-Mimecast-MFC-AGG-ID: brY3S5o4NImEK5hprqPoog
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467a4f0b53bso66519991cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Feb 2025 02:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738924301; x=1739529101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTCfoIluBkd2hmuVQ37KolRiD7UKeIdoxiXw4vJWCJk=;
        b=BAJ2eoZnBesOG0cGy//cIpmp1ySEYaQio0NhTk8UYkBAibXOMv6DIXbC4NJxXcRRU0
         g/x3BawetXAbE7/iE3f7FZmXB6bC+KzhrJ8Wqdkk87cgHT5/vievdDJrhpcuYDWRtXZW
         R08zDejo+HxMQHa+7bYcK94g9QmnPl29tvu60rsv84f4kwQcTOpqFU4aCXgpBqt8hdCX
         NTu/8j1GSoCY7NDV+b9dvebSyjkBwduBPSTvdxfDt9tSnpK4ms1Nr8NeoDQjLgeLOZ0B
         p1rlULj//LYKTXXeI56olxFI2wVZlcXf85WaBTDdeQPxGybQ4n7ojOUkX9RaMPjxxzMK
         AksA==
X-Gm-Message-State: AOJu0Yw/zmiqpcBLIty9g21ZN3NRNNFsKg2e77OtOLRzp8maHAs80Lg4
	3o99o0ceix2rZqlkP0Yb3MiwPXJ/ZoiMYtN8a2CwxjugV7XV3Te13/hEMyoCxkfg4/F68uz6joS
	MlTLj/SI35iJfnuyBYEzSy73fgOJbZUgxFlZaiSWtnvtNBRnvj73oB+m/Rw==
X-Gm-Gg: ASbGncvPEaE0hNUgfMkTRCDu3tDrcI5KStrwDuonDRaGJWc/UJxFek4zIzeajVSd6W4
	lhATzivzKHzLqjArX45A+xz+mgP0plAt9J0OFoxDwRXQi3XumRviLwCQa2e64caJbkMyIfNFTBq
	s62QJ7pEVJrupuBmFXlLKAFyhrHAgJ2hyxsMGPV5RZWC3SfRKAADq/WNHzFvD2ze1F3SYwUEEjy
	WXLoIS0xpjOwBDdvNp5fqoS5XkZOL9/ExJ97S7kB/KgrlzJw6eBJofCi4fBU2974lLdcv1/qVdn
	nQdOWA==
X-Received: by 2002:ac8:57d1:0:b0:465:3a62:a8f9 with SMTP id d75a77b69052e-47167b24a9dmr40160031cf.50.1738924301111;
        Fri, 07 Feb 2025 02:31:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+phjQNDSCHHRmNcLiyvwYpNEpsrlCuRBfkQEnSMlM70811nVbetbleT4hJMMJYeSDAwgcbQ==
X-Received: by 2002:ac8:57d1:0:b0:465:3a62:a8f9 with SMTP id d75a77b69052e-47167b24a9dmr40159801cf.50.1738924300826;
        Fri, 07 Feb 2025 02:31:40 -0800 (PST)
Received: from [172.31.1.150] ([70.105.251.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4714928d06dsm15168341cf.21.2025.02.07.02.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 02:31:39 -0800 (PST)
Message-ID: <74a50d3f-9672-46e3-abe8-aee309e9a84f@redhat.com>
Date: Fri, 7 Feb 2025 05:31:38 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nfs-utils: nfsdctl fixups
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250205154333.58646-1-okorniev@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250205154333.58646-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/5/25 10:43 AM, Olga Kornievskaia wrote:
> Static memory allocations in the path of creating knfsd listeners
> has lead to either buffer over flow errors or failure to start
> the listener when really long hostname are being used.
> 
> Furthermore, when listeners were failed to be created knfsd
> threads were still started (with no working listeners). Also,
> when threads were not started but we still had already added
> they were not cleaned up.
> 
> This patch series attempts to address the said issues.
> 
> (note first patch was set as standalone previous and included
> here without change).
> 
> Olga Kornievskaia (4):
>    nfs-utils: nfsdctl: fix update_listeners
>    nfs-utils: nfsdctl: fix autostart
>    nfs-utils: nfsdctl: cleanup listeners if some failed
>    nfs-utils: nfsdctl: fix host-limited add listener
> 
>   utils/nfsdctl/nfsdctl.c | 68 +++++++++++++++++++++++++++--------------
>   1 file changed, 45 insertions(+), 23 deletions(-)
> 
Committed (tag: nfs-utils-2-8-3-rc6)

steved.


