Return-Path: <linux-nfs+bounces-4608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053259268DA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 21:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38F828393F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC61822DE;
	Wed,  3 Jul 2024 19:10:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029641A81
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033804; cv=none; b=WG7VUvAfqDSJ0vjxJWRaz3NfSAAs3XQoj/fEf0VPXXLmhAveSxjw08V/Yd6EAvB3CuUAcqDvT2fqblnJ/EDmToCBRopea/+eEno4J4Ssals8ekVCUXt7YQnompCso4LE7WRI5rc62/trytl5DxbRrJIuh6DPXpOlFgevwhOzOkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033804; c=relaxed/simple;
	bh=1L7IRHUIAVglGiXuq/4Em/vNFNSoTG36tMaWnKYsdMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R5CvegEYlPcbH5D+i8+tJBTkrl6186FcRo/oYVsFkiZxoQzh+w4G21PkkAfemNfN6ezttIx5ENJXNIBE17ikwHe+LXLOEnxRxRtez73j47vW8J2Os3KjHUQIsJGvlAbVGVEutkp+ZUczLv/Ww5xt2fOlpm2rqZkgRQGXVedvpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3660944544eso322026f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jul 2024 12:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033801; x=1720638601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L7IRHUIAVglGiXuq/4Em/vNFNSoTG36tMaWnKYsdMI=;
        b=xHSKXVZjZFNqLBW2pAKMuSj74f6keWVP+ek2Paw5e/7jirh7qNcmvJ/rVEha18Vcg2
         9AXJyjnT3I8B5U0YmRTWxJhKR9yRJlnvduVvKM6Lk2vIKA9FaHIkWNhpQfrnLUCSlorK
         LV5/al32Tls//l1Z9fdT1hRPskhvc0C1GgwJrjOgVU5gj3NJa/KQUqEl03uZvPpw+MEV
         IPQhmcJZhLrm9ChVimc8VuwgL2rCX88NklFWqp5JndZW1hBg0NaIdfVsBwf0xpOBGZkF
         qieeM1ldhN+gvJEh5BYnNjSQYFIFSpZw+Cm+0SXcE90G7nfvM9dmQ+lVCpPxLBmcb6vC
         PFmw==
X-Forwarded-Encrypted: i=1; AJvYcCUbJ1TuDMHgm0pegW6VAGZoL2arsdvd2fGSelCvuiVEl0AWTO+a2eXWLQTC9T+qYU164O8rct5gW+QMokl77kiQd5SBQI09rw0s
X-Gm-Message-State: AOJu0Yy5xJ6NaD7ZLWc4m+3AwuRIcBVZiN4Mpv0niaBhOhUW5AcrlhPq
	G6pfwO0DvqOC9/Cpb+e1CASnMVSPXfZ5hd4Lf4tOYIwhXbGUOaRfB3FC0/zm
X-Google-Smtp-Source: AGHT+IFRLH1H76r6wtOVvvE/MCRzd3Tt/ic9epnLXkqx8lZ6nYC3Dnb83X90KXvUEjGiwZbPs6+9wA==
X-Received: by 2002:a5d:6d81:0:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-3677572e888mr8832049f8f.6.1720033800508;
        Wed, 03 Jul 2024 12:10:00 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36797718618sm1279605f8f.31.2024.07.03.12.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:10:00 -0700 (PDT)
Message-ID: <1e66a583-f18f-41ed-b87c-9e7b4045e009@grimberg.me>
Date: Wed, 3 Jul 2024 22:09:58 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: add 'noalignwrite' option for lock-less 'lost
 writes' prevention
To: Dan Aloni <dan.aloni@vastdata.com>, linux-nfs@vger.kernel.org
References: <20240627100129.2482408-1-dan.aloni@vastdata.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240627100129.2482408-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/06/2024 13:01, Dan Aloni wrote:
> There are some applications that write to predefined non-overlapping
> file offsets from multiple clients and therefore don't need to rely on
> file locking. However, if these applications want non-aligned offsets
> and sizes they need to either use locks or risk data corruption, as the
> NFS client defaults to extending writes to whole pages.
>
> This commit adds a new mount option `noalignwrite`, which allows to turn
> that off and avoid the need of locking, as long as these applications
> don't overlap on offsets.
>
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>

The new name seems a better choice.
I'm also on Christoph's camp that having this behavior be the default makes
sense given that we have large folios.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


Trond, Anna,
What are your thoughts on this?

