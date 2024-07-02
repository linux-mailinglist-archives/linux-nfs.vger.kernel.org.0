Return-Path: <linux-nfs+bounces-4507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1CB91F056
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A6B283A68
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398B12F386;
	Tue,  2 Jul 2024 07:37:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D534CB23
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905873; cv=none; b=qJVtWFCHYQg5Rs3ze0aODkT48p4QuIz9f2LjcGNvbPtyZdQMV/HWyH6C9ciwKQZ8oln1FmHdNmc7fjwQgjpAYfZkvTJtGaSpv9uN7MDLMjlkO2fd8+KjTgcal77ChSLxgzCwbMp6TlHvPn7hwDG5VRcTtRDSihm6jBDhDMfPzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905873; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeZ7Yd32YKuXy9bpIumQ/drIlxoFRPrZSgVxswqyDfiWTA9PUlhUIHn7IbiVjvigCh1hiqYRX8+7xUM8CtvwxPydfygpasU1Z+IqmnJh3LM8o/SXQ3T11R5tpU9DV33h3+zPZFbcaAdursLPtAGU0zRed2bhbatZnA86u8dQg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3660944544eso251989f8f.3
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jul 2024 00:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719905870; x=1720510670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cWaSgTgHqxg1LZKlxRh00+bCIgHMPEmq3sZPBbzVKNg4lG/UStaxKeE61MwFAyXbJG
         zfQ0Cqa+7gjXXFJwzK0zUWjNr7c1Lc0PJWuSa7YYutOs7zbztLFXn9YmZ/mvTk0vaKZZ
         mHnntcKkJD4RsKaukehQUZsjGSFHeY1ZMs5yP4+QG6PnkF+4WnzFKgVs5IetN1yOoLm6
         H8jxcD69PiRvkutiXSCz6tNdjweEAoNVnySnXCG1Lw3G65eERIye4yIwxJZk7Ev5X86f
         l3fTsqnJCfgcN7B8y3xR4qVZVuNawlbf3NCPyXcxkRUbKTJBqp/ky8XL0KEKPyI4OyH2
         TWvA==
X-Gm-Message-State: AOJu0YwPMg9HlP7KlSS1Dsse80b6wSLff9akQOvl9Yl/AZ1ij8nXsHIy
	X1/uanjYWzJod4UvyySajI88YCOhjhxFcr1qyJHb22N9D5XNoe8m
X-Google-Smtp-Source: AGHT+IF27+sxul+BeSP+/QUA211YEghu5mCYLFwO8hD2uBzgaSiGrFJHeNmdNZ1YSJ01Nu3U8xkPqw==
X-Received: by 2002:a05:600c:4848:b0:425:7ac6:96f7 with SMTP id 5b1f17b1804b1-4257ac69876mr51459235e9.0.1719905869955;
        Tue, 02 Jul 2024 00:37:49 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm186147515e9.11.2024.07.02.00.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:37:49 -0700 (PDT)
Message-ID: <062ba269-209f-4d96-b91b-03d0cf7e5ae8@grimberg.me>
Date: Tue, 2 Jul 2024 10:37:48 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] nfs: remove dead code for the old swap over NFS
 implementation
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20240701052707.1246254-1-hch@lst.de>
 <20240701052707.1246254-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701052707.1246254-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

