Return-Path: <linux-nfs+bounces-11581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E418DAAE386
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19283BDC2E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC40286D7A;
	Wed,  7 May 2025 14:48:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED6288C1F;
	Wed,  7 May 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629324; cv=none; b=FWaaMdnIvTl4roGu/iKsKTRL8+JjB5Ac364cqHAcEsU3d7Bjf1KFEdhrEBcvTbnU/6vRzDp+MEiF8CK1cfxFblgph+kXQ/ADuDaKUfuTn3SWUPLv1AYX6v5V/Bm4IQEb1bwuv4oPN14HjmwqXpu9cbYj9QKNBzN6a+0cT9Ji59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629324; c=relaxed/simple;
	bh=EAKMHUJqzlQgDrepx4CDqYCADzmC7w3H6FiJl08P0iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unsgkKLEVen1UysbxmwqcLrd+rr9A7A0eCLkA2meEuhB4o30XYV1uU/z29vh7gwYvMvtFtY6k2FqhC2zPBtZnQ3WI0dEnPzNge21h7tXM5zDeOm76DReYTgIW+/Lvs6hEYs5tCxPAmb6cwejwqc+wAGBkvOosnu/+bmPaLxVjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441ab63a415so70748095e9.3;
        Wed, 07 May 2025 07:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629321; x=1747234121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAKMHUJqzlQgDrepx4CDqYCADzmC7w3H6FiJl08P0iU=;
        b=QS3E1RQYT3m+fO7cLw/wPtoi1kKxcZ+hkPD6UURJHMSgbAslY0ozwiCcD3rQmJc8i0
         O03wGdqcIkJHZ/LISr+afgFN8xSOPYcmCmKyG038sbI57X6pngG2ZpdkKva3leG5YRxd
         b7raTQcMBP7vMlfk3DYP89TM7LK7+ECCEi2v1NrTzD4sedMud3TB+4pXspTEm13Ns9Aj
         ncnQyUNmqnDDNwqcX0X594IwXyBlD/YX1nRVlltZx2x81E0ElepG7VLC87hgGGuounUm
         +CLjgy6Q/x/s64t1KSddFC9M+eH0lQ8VDlppiGSbwfHbYth2WxRL5WNwIWm3WvRHFKhF
         iTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr2j5POK1HS45iNECISSkyNAcV79DdUE7J15u8LBBR+3X9KL7J9LPeTKOgb8OiKvZbIuEgJ6tkbw==@vger.kernel.org, AJvYcCXbV8o2I0q6aRikq6dIrvYMiSyxJao3CkIJ7b9ec3uO0NBZsIqzXwE5nZ6d2ewde91eiaHWudZ5apwb@vger.kernel.org
X-Gm-Message-State: AOJu0YxoD9qbEwTCoMZpLOuWtP6Bq4ndV9JKjAObhTbWwwLz2MqzUEIY
	Y9fuyBoI6fod7S5ou3AmmgMWWMAVMNEG1DTs3rQYTkeUjFOeSHpb2By0dg==
X-Gm-Gg: ASbGncvpjpvFDWByb6bQmKv4pPei6rTc2SGSB8yJtc0kOV/P6tMI5Zn0kk0loxYrt/3
	MXWWuLg93IiDSVg72CwYxf9GBP0umFr0SSodBO/sPVCaUPDBl67Ag8DivCZWWtsgcI31sLXWM6Y
	6hTrMFoKRzyzjQqU75wxlL3mu1yWz2ybG7NFY6mfnwpZL1G1BtMR+KswJcEtdazJoGKqpuffdur
	d4QPI0mPhbG9kNOPmeMYy/YmPaMcJf7JJHB4kei52mBkZBFM9T/BL2ar6ZT6U9GrR4dtoyzn/c0
	TQXKKSH8/N9C8/zomXP2FKcoKu7cfeCILwlvFyTbJah+1GqN8V3fVfFRGbcbB7RyTrBh0eg39d0
	9pZSG2SgJMUDHe2EB
X-Google-Smtp-Source: AGHT+IF5BTozncU2f8ZOakRdmEUv5uIWg8hax2hMSrXQM17uMKwSEvjMx5Ip07y2lNB42HNCyDZFCQ==
X-Received: by 2002:a05:600c:37c6:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-441d44c321emr32242065e9.9.1746629320547;
        Wed, 07 May 2025 07:48:40 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b6d0e1ebsm1458450f8f.80.2025.05.07.07.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:48:40 -0700 (PDT)
Message-ID: <b56bc2a2-3357-4d50-b53b-e65866ba1e7b@grimberg.me>
Date: Wed, 7 May 2025 17:48:38 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
References: <20250507080944.3947782-1-hch@lst.de>
 <20250507080944.3947782-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250507080944.3947782-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Pretty straight-forward I think.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

