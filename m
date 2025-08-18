Return-Path: <linux-nfs+bounces-13709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3276B2A007
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 13:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A149118A1795
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855DE2C2363;
	Mon, 18 Aug 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBv0QOij"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE8261B71
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515141; cv=none; b=bFtZzu8YDmTnFV1DaXC19HzOnM5QQuYDaj+evM8ozikLHPy+CnKyc7UFwQsMQ9Juo8iuFXKMQVcu2gBTPggevqi5l5z4KFbnu4oG/GllVfg+PJzO1Ns+gCZQyS6ybQksFqvJ9jw49vdbx0U/J/qerbpMIIH+1byXxUaks6116AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515141; c=relaxed/simple;
	bh=H5kMUpZ1gKWuwoYH9+YjVLVS05jOSj2rXmsZlTg2Zeg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=rt2P1AcEv3T2AKNqLREeLwnG7a9mgXEB8shh9yzOJx5G5qpn+myTAd4vtfGQ08q7IZWtNT4mU8QiWzAvJnfHAAk0FS9fZqIoXXK44voQrZGEoXF5DL6NBiQM3mY8HaPmxyRQt26GjxRshJgooBT+SU8VOV0Vc+Cg19nPcvowNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBv0QOij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755515138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u6wwn+jUlMfOHQGWDNpiwoVYd0AczFDwFLGrIxYoCBg=;
	b=jBv0QOijIOB0sRZhItlttjVuB+aH585t6xRLnYNGJLn8Jh1SAmeQeWb9RGus20XZnGrU/t
	cE3O43sBmBpwXrMHYwcd5NonmtN29p9M89RGpC8Zff1hiNeDn7vyc6M5E2RXMKAeBMT5Ns
	b7hG8UeXH/T63+To1XX8dn07HDXamog=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-gi_w6XMYNqOm6AxIpuuRxg-1; Mon, 18 Aug 2025 07:05:37 -0400
X-MC-Unique: gi_w6XMYNqOm6AxIpuuRxg-1
X-Mimecast-MFC-AGG-ID: gi_w6XMYNqOm6AxIpuuRxg_1755515136
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71d605339dbso47374907b3.2
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 04:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755515136; x=1756119936;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u6wwn+jUlMfOHQGWDNpiwoVYd0AczFDwFLGrIxYoCBg=;
        b=s7XZqL6VIVe5LZahwJd7nYnY36R9YD+YRuhHNc5luCIX0Dqkcyh8utkAAYJT3gBqoZ
         HNbAuCvfinuwBfa7WDgKFgSwmeeIFfHV1I2zjNZ4c7mf3ci1kbu7paLLPylfPQXE/2Sc
         XuD6fW6+Y7SVarEef/TonHyC197+Eg7VzZyMD3JurmEXARj/fRPQFosTD5o/APl1lD32
         qZgtJ5v6xJ0vBkxG1ls7B6znYXL5n9Q10yi/DXM7hKU8g4VKlVDS592iIvBmA6xWCeRJ
         u7w5UML3fwYwESK+DBqbL/MDySWc2/KJOT1W7RQwB7BEII7UWjbAPsADJ1soSPhGejPY
         1dGQ==
X-Gm-Message-State: AOJu0Yx4fr3RkN9jJKjhJEUYdoW3McrXsEv4jpOs5zxtgohfClX4ncbd
	ObMa+4YPi3WMVjZhKjnV1atDWRGyaq/ygHBr9IP/6G99IEVH//HTb9PdgD8ARYoEY7At21owzq3
	aluoxomTnY7/cSOZXa+Uh+Am1/dyqN79pD9aswuXitr7Q5U7A8TGl10UolwkWRJglpmb4bL9hN3
	7vgvIzS/yF0W3OJxde/sKyg9pVfzhXWXbDIW+HUg/Moeg=
X-Gm-Gg: ASbGncsr7mQHNeZo4rovk69ngBdo3GR5jn9NaPm4r2Tv3M9uwPanr7hk5Zlp81ws3fn
	UHMaP5xeFopEwCGRWk+L+iJcrbegioGZ8mmo2llJsL8TpHrYKa8FRqCkAfYz0yjxXI1hiu9xKg7
	9cNNJOGksdHFUkSO2Bu6cdfLfSi+AbkeFHRAiEBFBbvnBYyCBMrxVzIguFwdW26SrsiV73mtjBN
	YcDYktKT/rWWz/81r2qmzdRSaEjSocLzspJtlqswyXUdo72cZgJ3a4LXOGDtzskZiyVqwCX62hX
	NNIi2XvNRz5T6MJgunZLkmignoJIPKj0QMc0KaFK
X-Received: by 2002:a05:690c:6385:b0:71b:6635:df1b with SMTP id 00721157ae682-71e6dead6c2mr137582567b3.27.1755515135829;
        Mon, 18 Aug 2025 04:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ9s+aeaxPeSHmsJ8JFj/iXkUCoRXzN0gK+ubRLJ0XrEL2t6eSqV7XxpPbBWdgalHoWmRnvg==
X-Received: by 2002:a05:690c:6385:b0:71b:6635:df1b with SMTP id 00721157ae682-71e6dead6c2mr137582197b3.27.1755515135283;
        Mon, 18 Aug 2025 04:05:35 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.250.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e058c84sm21740717b3.49.2025.08.18.04.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:05:34 -0700 (PDT)
Message-ID: <3a277d09-0279-4433-886c-f090ebf02010@redhat.com>
Date: Mon, 18 Aug 2025 07:05:33 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: [Reminder] The Fall 2025 NFS Bake-a-thon in Raleigh, North Carolina,
 US
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: bakeathon-announce@googlegroups.com, NFSv4 <nfsv4@ietf.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[ A quick reminder the Fall Bake-a-thon is    ]
[ just under 2 months out. The Sheraton hotel ]
[ room block expires Mon Sep 8th...           ]
[ Both in-person and remote participation     ]
[ See details below                           ]

Hello,

Red Hat is pleased to sponsor the Fall 2025 NFS Bake-a-thon event, to
be held *Mon Oct 6 - Fri Oct 10* in Raleigh, North Carolina, US
at the Red Hat Towers office.

This is an in-person event that includes secure remote access to the 
test network via VPN, enabling virtual participation.

Event registration and network, hotel, and venue info:

http://www.nfsv4bat.org/Events/2025/Oct/BAT/index.html

Questions? Please send them to bakeathon-contact@googlegroups.com

steved.


