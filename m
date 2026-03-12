Return-Path: <linux-nfs+bounces-20059-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM+YGYO2smmYOwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20059-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:50:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD64272018
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 13:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73778300F112
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 12:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DFC2DF151;
	Thu, 12 Mar 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISAbWvAo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYhf8viT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0931716C
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319808; cv=none; b=mQvN6kr21DCXzjuEzGj3MwVLZhm70/hDB2pDqeBK5X3IXd+uLcYg2fO8M3M8wUaYc+b7WJJLeDU21LbA3arFxMTpHJ2Sj6PW7UM/OX9Rvlh5eG+BG+GonedGTpU5PCIhPljm8XBYm/uGMVi5ftgRwqJ9KRMawG/08doKJ2kX4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319808; c=relaxed/simple;
	bh=+cNQjYBSIzMe7SxhmbHyoHm/DRqpVGTg0hxMC/b9coU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVin3aMVf4bU+zEeXUGqWOaz2DKJzPy22NVyppgvkuBHQVUkRWvsTm/3iK6dHzsGi+sjffNACXjyM7ZWNvcrf5Q9WSpfpKKc52B9pRS3JV9TtAjTHzgL2MXvJJsF36FbtrawrIhzs78NOiccZFGsXQ1E6dVkglKPO0lm9uHOWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISAbWvAo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYhf8viT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773319806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLYrmsrjorNW+o7wBDZ2PStl5u18MdB19xBYidZwUik=;
	b=ISAbWvAoOj28Cc6/if9yDK8mRIdMFyF0hzKo4aK/h5BOv+xo1IwGckt1LyjmMbo20vdAmH
	WpgLyu/LzojsGY/n9NgNJzSg905ODkJH1hSoBaOQTNSF5/Fh7t6zneDDH930PvZzKqJeAv
	WPKR+27rUm3sT1iKIs+WPmm28joEBL8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-T5VmofuTN1exFZIylthIIg-1; Thu, 12 Mar 2026 08:50:04 -0400
X-MC-Unique: T5VmofuTN1exFZIylthIIg-1
X-Mimecast-MFC-AGG-ID: T5VmofuTN1exFZIylthIIg_1773319804
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50917afa521so126878161cf.0
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773319804; x=1773924604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLYrmsrjorNW+o7wBDZ2PStl5u18MdB19xBYidZwUik=;
        b=HYhf8viTQ1z15TcfYDd7hMXJFMmpB0riMH398OvkF+zQCd6rIaW6SCDc4D1QtTmSji
         bQElJkMmhuR6Xdzb8xPSfCk91FVFinZ85KSqX+1ibwNThf9ul5HNGQxYQIJ62EvkUt7Q
         0dCio7qgQHDYrWPoRmmprzHhXUwE8ppUwdQK9s9y+jpeQFDrSZZzfhH2GggpGKZ7zgtb
         Z6S0/Q4+4YIi/BD46GXblTwL5vzCJwBiscLqo4mH+dmviW7SmeMK2ZCz/CUG3DTZ61tw
         FCxyjUr9+djxs0Fmp+ojXAYrY+TN4zmDTS0+ikg+Pqax5uv+n7BxQoshRd0bWbhDtG0O
         /6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319804; x=1773924604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLYrmsrjorNW+o7wBDZ2PStl5u18MdB19xBYidZwUik=;
        b=BSQvk6xLw5pk2M14LOiBEs3xS/6j0bZmcADQFmYZDauk5Ix+m/izWTXRWCCV1a7Oy7
         TC/IGobzNWOJN4bkPgaOn9fxYoDl6esiFbZQhlhJtULnn6CZSWlYLfk76b3ctvOL/77j
         Tg6bAkedCoCLIZe/891kMnkwxx/nzP04fvkeAK7Ik1UOmzeTIwP95hCCqYAjhCY8yNYj
         zXtzCcHNXQFITEFsWJinQzpGMI4oIObnUZGflwKoxIi6uzu47lo9np8F+dFY2PVMRepw
         yOzt3yqs5DEPVWWS5rEzwHDg0yHbrSfhcmpCruyCkldpK06UHMtX9MiF4dgTMuEE9Qcq
         Ehmg==
X-Forwarded-Encrypted: i=1; AJvYcCVgl0R4mOa1Ism6Abj6i+mi/kjW3WbR2qbz8XCZkm+9SqRbxXMQlAhuUfShTb8MfpDP/A6xm1wsq+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzm9Zo6W3UFjB7rZQ/2gsxEfmuMRYtSPWDrHgFCluORJkdvjTt
	TtjnrHzWaRvBKjCG24MEcS2IvhZtzCQF9g+p/pGpcYC3jBQUrYjxhFREubrUcXrYxxVV1aepCGW
	2/iMY34efE7NcOvzmDFplilztBIZnECJIg1T8qQrtIOxiUK6FR22sQMVa9IWXDA==
X-Gm-Gg: ATEYQzyt9YNuvpgpf4tNoPW4CDQ07uQI5Djtg5ez/ymOQoKiUdPF+kxoiFcUTMcP2C7
	WDX2Bb6U+byNQNA4f+im1sA/GBGI5XvMa8FzDwl9VGgaqJmEZ5bidyNiZiKtXqfDxrM0xEYKQKh
	w/Mt2t4BrgwpIhmukNinbs4x+2ckheeoQz5pH0IxgRolaNNuziKsXiDn/BlPVDITYZb1UhG1Ng4
	XzKxg1cpdAxtO5mUxT/2YPrjfSvNT5j61xg4YnaVmRwoL+t8wpV52vTZew+GMHROo19l5+8mHXz
	YRDSnedau07GGI8kalWK1/1Q2eca5nvNRmu0O7xabcuais6Z+/MwvEN2eaJxFxL3k3tkCM26foP
	lTh2667AIVyIhGYiG6cPL1w==
X-Received: by 2002:ac8:5a51:0:b0:509:d0a:5649 with SMTP id d75a77b69052e-509472bb41amr39588311cf.37.1773319804315;
        Thu, 12 Mar 2026 05:50:04 -0700 (PDT)
X-Received: by 2002:ac8:5a51:0:b0:509:d0a:5649 with SMTP id d75a77b69052e-509472bb41amr39588041cf.37.1773319803920;
        Thu, 12 Mar 2026 05:50:03 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a116d86sm31229991cf.23.2026.03.12.05.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:50:03 -0700 (PDT)
Message-ID: <4f92f9b4-5e8e-4ed4-8056-3539b0f19684@redhat.com>
Date: Thu, 12 Mar 2026 08:50:02 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nfsrahead: fix uninitialised memory crash and refine
 fast-path logging
To: Aaron Tomlin <atomlin@atomlin.com>, tbecker@redhat.com
Cc: yi.zhang@redhat.com, linux-nfs@vger.kernel.org
References: <20260309145025.107623-1-atomlin@atomlin.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260309145025.107623-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20059-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DD64272018
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/9/26 10:50 AM, Aaron Tomlin wrote:
> Hi Steve, Yi,
> 
> This series addresses two issues stemming from the recent fast-path
> optimisation used to reject non-NFS block devices, which were caught during
> blktests.
> 
>      1.  [PATCH 1/2] fixes the glibc abort(3) by explicitly
>          zero-initialising the device_info struct. This prevents the cleanup
>          path from attempting to free uninitialised stack memory when the
>          fast-path triggers an early exit.
> 
>      2.  [PATCH 2/2] updates the error handling in main() to log a
>          descriptive debug message rather than a general error when a device
>          is intentionally skipped, preventing misleading udev journal spam.
> 
> Aaron Tomlin (2):
>    nfsrahead: zero-initialise device_info struct
>    nfsrahead: quieten misleading error for non-NFS block devices
> 
>   tools/nfsrahead/main.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
Committed... (tag: nfs-utils-2-8-7-rc1)

steved.


