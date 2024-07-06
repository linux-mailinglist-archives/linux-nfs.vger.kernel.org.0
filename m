Return-Path: <linux-nfs+bounces-4684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63FF929540
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 23:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C01BB20FF5
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9A1CD31;
	Sat,  6 Jul 2024 21:38:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB418C22
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720301938; cv=none; b=jAk9Beou4/FqddEie9hlMH3TI9RKR6dnj887gyM3nkSdNm4fa0Kr/I/sD/wzPfnOtMT1BC8VyWBbhkHpa3NM+saj3kIbcCBxYu0aUjN4z7DzDzgB93Cpo5lMggCNpsh+WZWXD+A1dHo4gxxtGYSY0byNNYrOholFZXV0s7qk6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720301938; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tq+HHV8AdiA1RO8gOVIhNdMyaP13FcSxA9tLRwjYvjPJhIcT/sDLHd/3fsaIfWThCFsgRPba7ezvqlNPVmE+l+6vqjt2iz2cmB+vNcnL3HR3EwYdRF4/m3wBNzDkJmuN5xRa0et1eSUF4TbWxTfGV+pP3EmheQOygRODRsMWV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4212b102935so3085355e9.2
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2024 14:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720301935; x=1720906735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gMAbwaIxvu+UQR2UFo8S2HjdulP24hPb/ztP2P74EekmsKWKdVFmGFRWFh2xM6XfzR
         Rx/oSSPjYs9O0NI15krbttMA48b+gx9P4Y2WiVj4rUzPIxOJa/Y0ZxALYnWfL5IE8Spw
         f1RmfTUVDELsmb2n2p8Iydz38Ug7Uo3EA+4cL1tFe79rTIcD668IYZVPkEme8HU10reR
         fa3vwkgClIGR4XRvs08nd4du3QQkFnEj1snoEPcH+vUwmsLFfR3giJL3wUk4c6DpiFeB
         zxBtuKVbNxtzkkd064t+jW1FZuh5L6rqeVQvBIoF3U7N1J4eRJ1uM1kYAqY8XYtFBU2O
         dbzw==
X-Forwarded-Encrypted: i=1; AJvYcCW+8lxJwqOeTTxkI3wLPQX9ri4SmjBvbOIqcJg1YbNgxMQFMCjYqEtEzPWPS9L4xnPsRPj2lYVUzGVRRKXFhqrxi+rS2NEjm/Jl
X-Gm-Message-State: AOJu0YyzcCpjGC19tQ/WRntOgvoYwJxxilp6GwhfmtB1GPH1Avv/2Ndu
	RU1n1oC9fS2fXZN4d3EENsGvRvuj6ECczBWfkmwNekTUFPtysneu
X-Google-Smtp-Source: AGHT+IFVwjkPnYrmk5ALGfyo2NXR96Of3Gc0DBiPziXssRy+61xYic2pBdOeLdGcXc94TTHXNkBx9A==
X-Received: by 2002:a05:600c:1c9f:b0:425:7ac6:96f7 with SMTP id 5b1f17b1804b1-4264a35297dmr56129215e9.0.1720301934782;
        Sat, 06 Jul 2024 14:38:54 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d165bsm108546225e9.4.2024.07.06.14.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 14:38:54 -0700 (PDT)
Message-ID: <7844890b-1473-4cec-a12b-9ee039979a41@grimberg.me>
Date: Sun, 7 Jul 2024 00:38:52 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: implement ->get_unique_id
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
References: <20240705164640.2247869-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240705164640.2247869-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

