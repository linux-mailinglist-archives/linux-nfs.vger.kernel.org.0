Return-Path: <linux-nfs+bounces-21393-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA2QBjUX+mlRJAMAu9opvQ
	(envelope-from <linux-nfs+bounces-21393-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 18:13:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A181B4D10A2
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D0730FDA83
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D635F39A04A;
	Tue,  5 May 2026 16:05:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54F48A2B5
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997156; cv=none; b=gXDlE43br1dubLOTQhpyBiB2sqYML92CjDnVL+WA1f6GqcHGU03CopWwpz9pUh5ueTixltN84UPbTam+zsPZskmN82Vaiy1XJEgPlAcdI/LvfeZ8ud32ScQkDiq/k7kxGuWSvDgUHnPddqY+yimPyMaE998QctANR7bksBS+osM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997156; c=relaxed/simple;
	bh=tMirGP2li/asiD7k8uiVSj1rAnOZxgr9Df01h/KACj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YXSUXvoCHbtKeBk6dcp7SVYesgTnu+ZYskulGqzvD0tcZGaMKmpn/nvzlB9PWhVuA4zIfgYshbF/EboZ77Vzu++fySlbawWrJbQ7cXIlKoF6yGAQBGCU6Bfjw6fRicpXmqfCLhbbrpztkBViD/qsuAk0B1GX1zDv3pdHCsxbl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso57941975e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 05 May 2026 09:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997154; x=1778601954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMirGP2li/asiD7k8uiVSj1rAnOZxgr9Df01h/KACj4=;
        b=plHDMJH2BUtUj3wAYjebcPmFtIrdz9W7xUrD8qbamFGuG7xCT5Sng7tsAm0CZhJswr
         3AA8Hp3Xd3yUliCZKGl7hGqFAGevYt5UTr2O8qSK//OTqRKkAdIvCgr8FZ2s4UWm7jVm
         Lh/uOVLY5qhUo0hVhalikRMuXPLRo9Z/sb9QJAZsXISDMUfPvxmq4VSL3AFHIvfdJefQ
         qZppuVgxV1pZMzS/X9OHZvl8doFrFYcZ2jJv64eGsTV/Hv/R/kqoEyJ3XjbgYLRwRFxr
         BpbXMd6+Y57XS7yIurTz0/gQTn4CSiAWBJH5iz+wrx7IUzcqyTqbVYIsQmXZwMl7T+Zg
         y5+A==
X-Forwarded-Encrypted: i=1; AFNElJ98Gcc2H4z2nixN51T0K6Zgzk6Gcl7hrvyLWif9jxFjWG/RVueJDVLibcBgjk5tGEep/09YNGxp0Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Or4CWFvNX/jv6CKQsZ/dmU7KV1e75JNNMpVKEYthhL9SnBg5
	SumYNEwzU9IFIYbEv2TrkhXsO0xx67v+WFR+GRGQVViydkAMImHizzjB
X-Gm-Gg: AeBDievGahVQk3ZWGzNqBAyYWzwAsxxldasehOUX5u5sbw77vG8cU2DAAAK8si2OiLM
	KxmIs9ma/rMPu6CEqRhfq5+tPjLNIDKRbAyZtVsiBS2mIhqFCjamdn6A0+ffKnnFTQhTR9INgyd
	SnXzQhusQ1u2Ybt1t0/OO9WV/vWsryX3+5b9yiCL82tRhv5KZO3uJjz9563uQXlyDSoD+mwdnx3
	gNXO30ESV54VKZPOjgmy5KjDIIRNKQ5rcvmja6S6aUDUkqYC53qH+nhQtcD+7EML6702IJJ8RdI
	egVb+kyzLqC0gxFUMWcWy57YHTr0YiDKquUzaah/7b+XbA24E/ffvDum28xSid70SmlBOpDzigF
	RSi+6MxeWfWR2BqW4OD7YuV2ymQvc4QJuWGDk5nAuwKhF3ntlA0Z0oTyUrmKtEb6WYD3IZRbLhC
	zgTNxWsG16qrh7IqainEkYNPo6sfGkq7TzGTwZegREqx5cNsu6aZm3MHIZz3XMekNWsHkl7G5by
	w==
X-Received: by 2002:a05:600c:c094:b0:48a:7772:c26b with SMTP id 5b1f17b1804b1-48e51d6bf50mr292335e9.26.1777997153624;
        Tue, 05 May 2026 09:05:53 -0700 (PDT)
Received: from [10.50.5.21] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm365935445e9.5.2026.05.05.09.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:05:53 -0700 (PDT)
Message-ID: <2934bfbb-c5df-423b-b246-f28da326d70a@grimberg.me>
Date: Tue, 5 May 2026 19:05:52 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs.man: Document mtls mount parameters cert_serial and
 privkey_serial
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>
References: <20260505142038.52921-1-sagi@grimberg.me>
 <de87d03d-a58b-43c0-8be2-997e8180339a@app.fastmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <de87d03d-a58b-43c0-8be2-997e8180339a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A181B4D10A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21393-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[grimberg.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 05/05/2026 17:26, Chuck Lever wrote:
>
> On Tue, May 5, 2026, at 4:20 PM, Sagi Grimberg wrote:
>> Two new mount params for x.509 certificate and private key pair used
>> for mTLS authentication. These have been added a while ago, document
>> them officially.
> NAK
>
> There is a very good reason they have not been added to nfs(5) already.
> As I stated before, these are part of an internal kernel-user space API.
> They are not intended to be user administrative controls.

Ah ok, I guess I misunderstood the thread.
So what do you think the user interface for this if not key serials?

