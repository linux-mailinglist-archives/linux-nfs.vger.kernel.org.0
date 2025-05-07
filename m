Return-Path: <linux-nfs+bounces-11568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D872AAE28F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C019A7082
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2E28CF75;
	Wed,  7 May 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gds4s7Vq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6228A72F
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626704; cv=none; b=aJzG3r09b11jnlPOBBPcZhVpQzM5StlCh7hct2EjGQsTouvmsSGIk+I5Vm8tI9t+udbeLsKL8S5Q+lvzYcA40d1Al8dupX8sWFBAwsG1Drj7TL2ZXMBN3sfP0JxisnGXuSTCBZM0QC7KzEotKOEDdeVV+rvtvXRB6FADzJOcjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626704; c=relaxed/simple;
	bh=QX/DcuyLW1jdyp8YK6M/8uNlqkGahyYxWYCi59h3oeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O6uMCdZIWkt6CvaK4UzImWe6qYxZmtZCaIIwCnu95iDhUbU/LlQWbTPG8oIJfJba2W30P6u66x3qfyM0aCQ7PMsBXbX82J5CYW6vxurF+Wn8l0Sgf77ZdNFa9hi0mDXAObX1LS6Ei3F7wbawnZ9Vl/+WNfpn2pvaHe/9JlCT4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gds4s7Vq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746626701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZVpfhx0qFQV6MKm5gZkvpq+FSwp2G7s/TopZy7thp4=;
	b=Gds4s7Vqy9Ts2yM2vQjYo8aQzPix6ylNPKmUkYmPsS46cJCSu4yWomzZoJIrtbAFjYziZg
	GrfpoOUhwjmqRV4oNZGza4Na4w0OWvHal/qLrza3SBvPyXHmRMHChvxuIu4ni3OqIBu2LA
	WqvIS9uLoKW9qJlMY8rn9ycBAd/Eunw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-txZxL7hkMY6nWgOV_4an3Q-1; Wed, 07 May 2025 10:04:58 -0400
X-MC-Unique: txZxL7hkMY6nWgOV_4an3Q-1
X-Mimecast-MFC-AGG-ID: txZxL7hkMY6nWgOV_4an3Q_1746626697
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c7c30d8986so1474569985a.2
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 07:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626697; x=1747231497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZVpfhx0qFQV6MKm5gZkvpq+FSwp2G7s/TopZy7thp4=;
        b=lrhLBKpl4cXhmcpzP/9U1JvgUNNgRKVdMKVs8LkYg7pSjKdo+yqGTcHDUBoPokEiT9
         YXyZ3HaJJJcY/cyPVvadteYrq+vAx9GU8xT8ZcDCUksUnULnarcIfYD6ZeWa2pjo5FeT
         k0z6o5CfjLxKu5d3tTFaR9RO3rELgNxInU/udOkk/kJMWKNLYCWkMs4xbijWTQpNBsll
         LFBTn5x7Og9dGkvyQJO0JNoooOdi3lqWOkjwAYa97J2j/CWAxo6zieI0EmuFLsS+DzOI
         wJoRNvYb46jLDEb+S4mao8sFExzgmKunrojFuoFFjxUeTFX2xJsKnGLFJbvnkCHjKc92
         hrtg==
X-Forwarded-Encrypted: i=1; AJvYcCWsYmnY0O9vZnaGmNSuz1oGLbnnxzyHgFxHdETXP0aueYcoQJJyYrN4vgYlBSjlp6LXvlNPw5pAwZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Wk9nDipE8/1ago+zcEL3OazNYy4dVjb2Pkpm7ee6Q4886FiQ
	cVMk9LzBe7TmI7X6ZrgS906OziOQA3N5nPL+J93xQK4ItwLeAC4A8vSji3cjEvInHlRaMWuOsXk
	Hj9kMZOktuVeMd2Aq8MD+hPi63gQzNFErEmPBVvhmkxwOzfu7/a8sbtlQ/WGoKOK4Dw==
X-Gm-Gg: ASbGnct2uoihGDX98dPtfswdQo8H/q/a1vkLl5xULku0Vy0cJ4DOAkNbRIHU2w7p7CO
	/UiZreUD8SuzAOsfi92l70oQukvJA9qZccz7m4O3jVRpE1CnXR6dK2FGm9jVPmSw6hYe/bf6K7O
	6bRK4Ru2H54QOtkzVKaPEvbB6+YmEfNqu2VeEwZd/3rtSdHE9AZ7oi3JRRufXdWK6vIoVUZgidA
	7QYleKSVtQX5PEgIiyAg3zbQcPUOGuQRD9xtKGauMXz7UtkPzXcigT0Gf/iPjgGm/q09l+3OyHJ
	NLjoZ6PB9Q==
X-Received: by 2002:a05:620a:4726:b0:7c5:6140:734f with SMTP id af79cd13be357-7caf73a0912mr600169285a.18.1746626697019;
        Wed, 07 May 2025 07:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSSIvrp/G1jeD4Sikywo+8ckXVRBLK53aKWaR2uDH5awakgFUopNlk3Vc6aB4JLkMpKKVdCw==
X-Received: by 2002:a05:620a:4726:b0:7c5:6140:734f with SMTP id af79cd13be357-7caf73a0912mr600166685a.18.1746626696768;
        Wed, 07 May 2025 07:04:56 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.247.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf75b5444sm152364185a.66.2025.05.07.07.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:04:56 -0700 (PDT)
Message-ID: <72f9f268-07f7-4d05-965d-53704b0d3e16@redhat.com>
Date: Wed, 7 May 2025 10:04:55 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] rpcctl: Various Improvements
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250429183315.254059-1-anna@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250429183315.254059-1-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/25 2:33 PM, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> These patches depend on kernel patches that have been included in
> v6.15. They update the rpcctl tool to use the new sunrpc sysfs features,
> in a backwards compatible way that won't crash on older kernels.
> 
> v3:
>   * Rebase on top of the 2.8.3 release.
All patches have been committed... (tag: nfs-utils-2-8-4-rc1)

steved.

> 
> Thanks,
> Anna
> 
> Anna Schumaker (4):
>    rpcctl: Rename {read,write}_addr_file()
>    rpcctl: Add support for the xprtsec sysfs attribute
>    rpcctl: Display new rpc_clnt sysfs attributes
>    rpcctl: Add support for `rpcctl switch add-xprt`
> 
>   tools/rpcctl/rpcctl.man |  4 ++++
>   tools/rpcctl/rpcctl.py  | 50 ++++++++++++++++++++++++++++-------------
>   2 files changed, 38 insertions(+), 16 deletions(-)
> 


