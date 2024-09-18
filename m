Return-Path: <linux-nfs+bounces-6539-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A980697BEA2
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 17:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D5D1C2142D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC90D299;
	Wed, 18 Sep 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnB42hoU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11313635D
	for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673436; cv=none; b=MbD005UMiVddBi5uc9JSDhrrFPHrDeaCfn5tqnHtrTFCnbPQTfK6cpnRJ1Swa9l8ZYirjpkiWpzuOiT4e0JXeNDTbNH6TR+eAgKfJ6G7glDc/SwmR+lA9rGTmi5QlLBfb+XJGDnfcG33V6VlPYrqmktH5MOl8sbijeeq4ueFHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673436; c=relaxed/simple;
	bh=gCFZENW+yVbPVzC8NoooQItDNAXQhaziDQHGdM62miE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=H8C/7XHDJt34oMJ4uc2gODqxWnOY/8lWIGvexD9O1m/KKV7IkJqIBRA1A/NxFKAE77ydR6467Clk8cLG3aRYa1IbzfY0W4kRmsDCKF5RsXN1AdfI9GE2F0NKTvQCI739ow9QEbbs6Veeo3QwZ40FybacQpTHSGFD8F/4ATL5Fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnB42hoU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726673431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ANgYWqh8puQOJc18e8Z2ZXiG2M+jr1aEl46waeS+8jc=;
	b=gnB42hoUMGGhlhldckaVDME/4kJY6MwoHfhjVgQFAHiFDxQYS8XWDGEDodxmZ2Vd/P/Fax
	UJsnqJZZ8e+BYqhAuWKgwiHi8pz/LhYnGutw4AciqGMqwy7MCidapvdwGcONFF5cvBm0fj
	vf3ONPtEXiXI3HouZKWfBjerSh2+UNw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-rrtlgjFPOSu-aYUbvr_fMQ-1; Wed, 18 Sep 2024 11:30:30 -0400
X-MC-Unique: rrtlgjFPOSu-aYUbvr_fMQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-277e5e84a54so6571139fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 08:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726673425; x=1727278225;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANgYWqh8puQOJc18e8Z2ZXiG2M+jr1aEl46waeS+8jc=;
        b=A6ja2eDxJxN+/CF4qbcMlXlzoQhCEBmHIUJL3zSedf2ysazoplmlajvS8fkqSSBORd
         8iMCzJJJG1gATM1lMYKzkpIm6KdT0Tnf6OhZh06oh4J2Iu5FgfNktw+FMznEXDD6uJto
         RC/vdSfhXs75gg/BtCJJIfPA+Uco1lMFw/vtVwHLu0o6HUVJPUWXfj1B6I4CEJKZ6TdF
         yIC4VV6st0RD26SJxjy3MzgU6B/zkPmjl1abpt8qF4JfVDLOhloE/OaTWzesAAQd+ZFY
         PfM6uhQn2FZAzy2y10pTqWx50T4VRxrpZjZvNata722LVD+zvbMpz7lBXa4xD1HhGsNm
         a1Ew==
X-Gm-Message-State: AOJu0YzSmABLZDsE3+UF5LqC/kMV2k+9VNYIDZnAZznJ6Pd+vFWVB+vo
	FGwb4zJqZRoom+/Oe+7fYz1x1nxUZpIknUrBEC0/k6V1yIEnMb4auV8MwmTm99TEGkSYgqW8Bul
	Pg9kIlp4K+awbCQ9WY8fnnUC71ZL6wnSMu9V2+a9dlW2+C5hNbNxTwJ9vFcDd0FteJm0qS58JVy
	MyFoF3fRn/LbzGjRkdc1+Tkez5MEyEU0TT4tT/XJxTbw==
X-Received: by 2002:a05:6871:797:b0:260:eb3a:1be with SMTP id 586e51a60fabf-27c3f61675cmr13176237fac.34.1726673424861;
        Wed, 18 Sep 2024 08:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS/WO7GhBQIDBs0Bq7Hhs8Qtg9wDbTWkaws6H7nMGGJhX5Zy7OH/YN+/ZPgiXi1UcqmniQTg==
X-Received: by 2002:a05:6871:797:b0:260:eb3a:1be with SMTP id 586e51a60fabf-27c3f61675cmr13176190fac.34.1726673424365;
        Wed, 18 Sep 2024 08:30:24 -0700 (PDT)
Received: from [10.193.20.126] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498d9850sm7598278a12.10.2024.09.18.08.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 08:30:23 -0700 (PDT)
Message-ID: <84a68e16-d27b-4edb-b43a-e1ea581dfa66@redhat.com>
Date: Wed, 18 Sep 2024 11:30:16 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: Announcing the Fall 2024 Bakeathon
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>, NFSv4 <nfsv4@ietf.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Just a quick reminder about the upcoming Bake-a-thon]
[Hotel blocks end Fri Sept 20... costs nothing to cancel ]
[The google links are below to sign up locally or remotely ]


Hello,

Red Hat is pleased to announce that we'll be hosting the
Fall 2024 Bakeathon at our Westford office in Massachusetts, US.

The event will be F2F as well as virtual. Hoping to
draw as many participants as possible.

Details, event registration, network info and hotel info are here [1].

Date: Mon Oct 21 to Fri Oct 25
Address: Red Hat, 314 Littleton Rd, Westford, MA
Event Registration: [2]

We have "talks at 2" (EST) [3]  everyday... Please feel
free sign up for a talk if you want to present a topic
the to the community... They are very informal...
Definitely feel free to attended!

Any questions please send them to bakeathon-contact@googlegroups.com

I hope to see you there... One way or the other!

steved.

[1] http://www.nfsv4bat.org/Events/2024/Oct/BAT/index.html

[2] 
https://docs.google.com/spreadsheets/d/1kJfCNeKyQhVRaV8p3X_2THsERegsgTOpkkdgv3X_-Ys/edit?gid=0#gid=0

[3] 
https://docs.google.com/spreadsheets/d/1kJfCNeKyQhVRaV8p3X_2THsERegsgTOpkkdgv3X_-Ys/edit?gid=0#gid=0


