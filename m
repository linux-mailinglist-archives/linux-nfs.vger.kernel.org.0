Return-Path: <linux-nfs+bounces-3563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA768FC6FB
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 10:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CADB283510
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC8F9D9;
	Wed,  5 Jun 2024 08:53:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDD137929
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577580; cv=none; b=KNW5LTu8zwXxWJFw9tn520+B16hqGDtSIiS8vDe55V6CbWYxmwvJAc3K/k04iLtzx5K/EKmLdjhz1hvK12ixSsAf47qGcobpwt1pw7qZbq0yLY/xvHR+0jc2DotDiIjyaht/cwsWbavX7pIgEA39APmHG5/Qo2Jk5Ef5USG/kMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577580; c=relaxed/simple;
	bh=xb7dTBUi/x9EzV8TfWd1zQJXCt5OV/zmf0zC0Db7niA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlW743unGfxJjSpIwOly/rnUXZhxOujwssl1hL599gcLnx9aPDCnNzkrZCD769Ev+wha6sfNhWiFK/9DS/ZnhJmuFyZ5/DGZuKF8gIPaITQt7cjrQ6xyjcZPqt0rnCSyP1tSAPZFq5SyzFbrJWmMBbESMvk/q3v+ZePP+RLuCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35904026d72so273009f8f.3
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2024 01:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577577; x=1718182377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xb7dTBUi/x9EzV8TfWd1zQJXCt5OV/zmf0zC0Db7niA=;
        b=lT3P2trbFbbqc103JXwh52HmBX8ToPLef0ZcWXWKsj6KylCEiqpISdPBJj8ftnUYIN
         zJU5kKOAs2Wd2vZ3SnbbCzBYEjydsv4ixd/tyHTMbInA9iuZ0xAnIyT9J8j2Pz8zTxMB
         CzQLJ2cIahBnjXv0w+MYEE2hzE9tKOc9QLFk8OfzUcXSy7yspa97IKi5vSKzbD8PnJR6
         hUJKjkPGIf0/uhVoGnOJP6nTqhZ80lF1W7KXb+KDh56KFVymmk/sjeP16cgMcbSUquXn
         AlObxa8li9eylKetx1iv3pCPMcSxVaSUpA1QCV01Eyu1EbiAv3BypfvdYcksHhnsjQCZ
         55nQ==
X-Gm-Message-State: AOJu0YxgxxyHOQLNJUafdHnXyUKNuO/aKq4yoQKQJp2qIHf+aIBLuL87
	JmPfTeCJ51SpTpya6rGA5tjw1XRMTgEGrdsSYFbeTboI2n/vLM6+
X-Google-Smtp-Source: AGHT+IETvbEEF9WCFHlcP8I7ltukjnXEUWW1f9nrbp10rL02Whb8U8CjVTHCoBAstVMQOrYaTZzT/Q==
X-Received: by 2002:a5d:6792:0:b0:356:49a8:7e0e with SMTP id ffacd0b85a97d-35e8ef7ef4cmr1124838f8f.6.1717577577115;
        Wed, 05 Jun 2024 01:52:57 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d943esm13695272f8f.47.2024.06.05.01.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:52:56 -0700 (PDT)
Message-ID: <90b3b9f3-ab93-4909-99ab-f2a519a74a7f@grimberg.me>
Date: Wed, 5 Jun 2024 11:52:55 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] xprtrdma: Remove temp allocation of rpcrdma_rep
 objects
To: cel@kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20240604194522.10390-6-cel@kernel.org>
 <20240604194522.10390-10-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240604194522.10390-10-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/06/2024 22:45, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> The original code was designed so that most calls to
> rpcrdma_rep_create() would occur on the NUMA node that the device
> preferred. There are a few cases where that's not possible, so
> those reps are marked as temporary.
>
> However, we have the device (and its preferred node) already in
> rpcrdma_rep_create(), so let's use that to guarantee the memory
> is allocated from the correct node.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

