Return-Path: <linux-nfs+bounces-5267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BCF94C51A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 21:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F8B1C2176A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122EB12C81F;
	Thu,  8 Aug 2024 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyMf1Tb6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6E1EEE4
	for <linux-nfs@vger.kernel.org>; Thu,  8 Aug 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723144617; cv=none; b=TFHx4W6XaiDLbyRcdq3boVnJCojvWVTI9t27p2X3Ethmoqnf7tdpwREVQRSaoa/pJC1mTf9hr010qkPDiVFZH+GJ802ABkUh7xeFLl5+PsjZiXhI4ChJ/kfRxmVqYKtE4mowDE8XNexJnabhF21gIKE02+hl06XbaLsTtXB5HlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723144617; c=relaxed/simple;
	bh=ugyLFCFlhdk30o5w/HOAgEWE1xSMIqRqi53ZNaImKlE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=QvBtNxBCw6/JmqzGYtPOggCbizMPG05FhG9pDX5ok7xwLoIgG/4g2UB9COchbJyRSeHYuOo8mxErn5k95J2ZqQcqrZ86nJ38SS/KscbvqzKuPkR34nLsb97Lp+fro5bxJaS7JRHnsk8hRc/vGs7eiHmrZUuuJmILZFw5qtr/FQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyMf1Tb6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723144614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gAeYIn2ibBkCHCqEmSw/1JITV58/txNyVwMXGFAlMhY=;
	b=dyMf1Tb6P5SoJ4HRmesfkepfiPaXLVZU3KS4HQSYvrxb5PbY9u7XK0Sw1IbRHdZ2xTnMQN
	QHb54wHbZqvkQgbKexVGDYBKnYJXsu37GFbOLw1s4SESq+d/D7PlrQwys0/gN14AUbSiWv
	ZepYm9CHjadJGuY1D07iANIIR/ljoBM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-ucKC5vJYM0WxFnx2b3NVTQ-1; Thu, 08 Aug 2024 15:16:52 -0400
X-MC-Unique: ucKC5vJYM0WxFnx2b3NVTQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44fe325cd56so2566971cf.1
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2024 12:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723144609; x=1723749409;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gAeYIn2ibBkCHCqEmSw/1JITV58/txNyVwMXGFAlMhY=;
        b=odwVGcRRWMitWXo7WYyrmbKYN6M4m+Jq+VfKQ+Gvd0YwEAwPfpU/uEUS5LTAE2xp0w
         jNVdP2TijlMcCEk4tcFOen7ILV+dzXHzyeFEdN/KOU6lz/o3jesK5YEcNJTW8F+fHP8X
         LEgryUxl9M1Ql1GTFTzORmOVIKnCm5oDA4JVW5U4pY4br0BgtkfBBWcU/Jwk27/oApbc
         VNUZYXrigwVpHdjr20CPJzIjc34gzEboVT6bM/iA9gsAuCihkI5SyI4M5VD4feJiQBrR
         5n9GUbGFwkB1LnaVfEHKkYa9SIBaJJsr2RgCpLG21Wnz9wwi9Lffyn4UQx2ddS4MsGks
         U2aw==
X-Gm-Message-State: AOJu0YyEFcntu6fqB1BSgekTsh/bjtvoILazSEw8AS7wHfxP+VyVt+3M
	Cab6UueR6k9hX3lwvugOy+V2wiUL6DNzMh/+WuKuEeVHwNFCTMLOLoxILprHehl6uM7dIXqgf37
	ydqG0cozD7BkJa4ELlZLXZupHQsogDWBImzCDOp5eGsmbspEgGEfCxp3MTOIk6406UV4T9BXXrb
	AXUUctMCYjIvaTRmzB8lrie19IGvV8Sabx7b5EbwQ=
X-Received: by 2002:a05:622a:5d2:b0:450:2fea:4e91 with SMTP id d75a77b69052e-451d420f3camr20709411cf.4.1723144608945;
        Thu, 08 Aug 2024 12:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbe5g572/soGPe2oNlArzZTSS1eA4YZDys+uK3UmOuxUXGa2ywfRG1sHynDd1FidCFauoMKg==
X-Received: by 2002:a05:622a:5d2:b0:450:2fea:4e91 with SMTP id d75a77b69052e-451d420f3camr20709251cf.4.1723144608423;
        Thu, 08 Aug 2024 12:16:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.249.141])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c8731492sm15514521cf.44.2024.08.08.12.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 12:16:47 -0700 (PDT)
Message-ID: <0cad3141-b5e3-472c-9981-d475b9fbd4e9@redhat.com>
Date: Thu, 8 Aug 2024 15:16:46 -0400
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


