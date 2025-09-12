Return-Path: <linux-nfs+bounces-14390-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F9B55830
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C8A7B892B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4383375B3;
	Fri, 12 Sep 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfYhH89O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459632F770
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711596; cv=none; b=D0iLMMUeS4uquL7d2R0I1QAjNRFg5jE6Mpktff//yZzkIf+UQy87268/nii9WE/PwqUXbUL5JCP5X8JoaCM0dtkYVCNSVcGdsk3bJq5DVyMLLEsjH7HywmwaRbI8rGwkjD8KHBkndad1a7TMYAwhoJ1IIXaTl19S1boHi4+IbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711596; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gfMTKtoQoRzbI9iAWDitA1V1QITu3t9NEib2Sbh81eR1iRIWM6cvmwuWUXMdD7XpCpC1GkV/1Sn68VprBmsNNXF3s9T3uaUc95JeQcNVrmOj4N9CpRiPOhL+lffiwOuBHppa9iDMTaqfqoDlBWLKJ9WSydSTgPeSHbAAJR/jsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfYhH89O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=NfYhH89OCJJ9xV3YK+X0hGStcpwCW6dgEx1kbuEcNjmMn5RA/OA7mGH8ML5bCINl2kfysG
	Lk4h4sXEg3CO36ZiT3Tgw/m8GHKWbNU/OVyoCj3XD2EH0wDn7i7M3gyYzfInuL1rgLFwo9
	YhK01U54ABsgadSsPFOnWArTY1bAsfI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-oDsUXtAnN0qe_6Qfjzs3dA-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: oDsUXtAnN0qe_6Qfjzs3dA-1
X-Mimecast-MFC-AGG-ID: oDsUXtAnN0qe_6Qfjzs3dA_1757711592
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b60dd9634dso58720381cf.2
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=o4kgsfSfA/j5eNgjQFLqvaEc2V8Nx8jZKip39vbLrE3GjsB++VoPKYMZJ6nAJ2yFU4
         ydnvXWXWZjw8+U9xfjkKywiLlQRwRrSHaMCYFd/VzD0JsTFH4B2rqfgKbNS1eWuAcXcU
         TJHj8C5XdSgNqH0tO8NGzxuiaH3p0meRb143Gf/Ghyz7KBd+GqMlTCJ/SgPXB+FWFrMX
         p8VvbMzHMDXN25hVbemqlDuJeP55FtcmMyT2NSARGc++qePdavMebxVDdJ87uZC5WURj
         1g8J23QmH60vhQfbga2jXa9+RMPUWwNtL7ave43yh5pEjMT7PTQbYe2xbbkc48P98q+u
         OjIw==
X-Forwarded-Encrypted: i=1; AJvYcCVASZojhb3diPQlVmwtNcjLQrEoFzLTv55HnpByl6mORM/sQC114fN3sxnFwBA5qT4RxnSm2l8pGhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4vQxQawbh5GVJuW7VnRgLOJTuDIVqEsIvJkeUYgKQqhXFIAQ
	ALLdJn8/wJEFCEqWX0XA8154q6jP/rWC5DFnawL15jdZTFOLxboqVAmC+RPbpMFy5TZbq4kZWPe
	srG3CdJ+Lzxp2khBuiiUdRSY9qSMi3KlryaT+EHpV0YzS/QsAWZBhNyOnJn3uNQ==
X-Gm-Gg: ASbGncvFvxeuxdVhL4CWs1LXCr9O0cT+vOFma5LqZyoEX6ptgvrGJElN7aYsuuKTshL
	1fDmnlsMwceXD5aOSeQN07BRbQF3hNYOCsXQstnosweKOLxAiEB1TBOoCSs2KvGAdAyhrKkO+6V
	BgJgZm/dG+Gq7eW2t9fip7r53+8qLVTdEHDVAmwYExZsngMAKmA1a8hDA/AUtIL2540HV7vlWMd
	0m0nwXsJ4HWbOQb6k+J7zU7fxxpAt4E9RR2go4L9Vmrwt96DZOK/QX8DIVIJx1b8WWUMBVrIonm
	YfB/vAVGueaaL/Xk6hshHeZjRMe7KH7cx48ZQUjgvKycOOOL7tU0R2leSl65dgsSIRF9ZRNhsoR
	7VUywX6LM4g==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549551cf.25.1757711592216;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman


