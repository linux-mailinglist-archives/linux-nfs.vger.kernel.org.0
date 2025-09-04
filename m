Return-Path: <linux-nfs+bounces-14029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21129B4397D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 13:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CD91C81277
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B802D060C;
	Thu,  4 Sep 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ2uc6tc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D52FB626
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983875; cv=none; b=TQLmo6rxgbHbiwDISTrF7cuuUG0JqvWy5LV30rcFiM9FCOKM+hFfmLeWF+1yALPoETLuVBDVKz983ZQclaCsOcgDFX7dfw7L40K2MjS3n1iIvnEjhFq75HP70DAGiS3Bx3OdTPntC5eCsdmt6YtEGu6BhS6UU+d+H/IWz17xr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983875; c=relaxed/simple;
	bh=1/TcrgBjtwS6VxI3wy6BuKu3T19K7RsSi8wqEsgaCA8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XexL/C2VTLLcKbUJjihlN5597gU3qBOsKxhrzR3DbdI1d11jLRb7cH/oHgQzw9gw0+KlidswX/Gjv+P1uAiRyJ7fH1aL0h2ZSj30lZho+M2d48AqWwQ0jL51BkIXXKSbtijD31Ezd1ZBcsNpVXLLlB6V/3vZBAM1gz6BSTjV44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ2uc6tc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756983870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PFMOQQ7QXGbvMMeNjvPTjpCO3+q9ATujcrdUC1uGLg0=;
	b=IZ2uc6tczOAyPSRW6AeUY90LaQB4/sLMgjefQCfbId7C3K2vpBZMpcpcqB/1gpsR1bbbiq
	5mB5yet7jx/XVpqxCcNMJ7wQMg/SFiO/+Y+eCfmtDLs6Sy6CYFzJCQxYXT+yY/0FguBl1N
	qlXpOKnc2WoVo8L9DrWNk0767kb79ro=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-1PW49p0uMIuYXdY_ksbTQA-1; Thu, 04 Sep 2025 07:04:30 -0400
X-MC-Unique: 1PW49p0uMIuYXdY_ksbTQA-1
X-Mimecast-MFC-AGG-ID: 1PW49p0uMIuYXdY_ksbTQA_1756983869
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b34c87dad0so17596281cf.3
        for <linux-nfs@vger.kernel.org>; Thu, 04 Sep 2025 04:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983868; x=1757588668;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PFMOQQ7QXGbvMMeNjvPTjpCO3+q9ATujcrdUC1uGLg0=;
        b=LbVywNAIAJsq0rW/vVP9mn3oL2Ty2gx6DN0XJWvCzXiHjoQsaLZo1fHoOePMlPLjHQ
         vh2mF9P8A9JH7Hwd6uZgZ/CkACE9nMawfY+EY9mb75GSyXne6kxu+9CK+3H17v3+SVGA
         /6eyYqVjrUlUcn3jQIwBJUhhCtNOB3GAPpwe+ZaORonqWOhwOjmgfe56YxAdtfkCQiOS
         5rwpRdnbt0ew6yNdCVSvm31JSpqomaqvL2sTw5F87qPwpbC+VpqO4aEbsx2lawNo71am
         Di4LzzwErMVPls3Ps4FhnOKC4/7hhyBVcg9BsguWX0OLf8vg4P3CgTKaFkkmEJQgJPiM
         HqSg==
X-Gm-Message-State: AOJu0YyTnslfcG3jwlZChkrpN0bZ/XyCRNL5XBHOh40gyQbhaCI3DY2A
	cia1vFxE7cCr66YbxgPKCKY65gwC9LJ2DmwfzBlsZZGLzuEs77W69b39jCCq483kowAcenBeDZ3
	JdjCP1yl2fNCXsc7k2/L8tnL2lfXjUIdMyCPb94Q3POl8BD73DKHqrc6PEYjvXeusJiBuP0K34v
	e6yx6FmATLvCVqG8FaIQ6T+aO41ocNyqbu5z1YxlEmk9s=
X-Gm-Gg: ASbGncsWWeM9S0ctBPcfhA5z59cVnqwJ051keZEIcY7N0SNSc1vIjUX2MUS3HGEC93F
	LpuwGllpVRg5GVSpSMeyAgQGSBJg+jD5oBt8qSFGwxJkvp/InHgOkh8o4tXueS8BCWO+KBQBMu/
	OoAYWrBSDtpnDuPBB9K5pRr5ZtEe7ht52/xkSs4y1x5BtMh7y8r68xCH71fQe7FqzvaqATEPPYA
	/P0cRcuu3e/LL9+7aYpUeuBAS2iG5cl5zeXC4kAOYz6sZ35IdhfCvKUSnuDzMN+1gNFho9HfERT
	4sj2Y1FVdfvEfiqQgvZXqmgUpB9hghXVT8CYE3Khnw==
X-Received: by 2002:ac8:5c91:0:b0:4b4:96e7:6497 with SMTP id d75a77b69052e-4b496e7688fmr43484461cf.37.1756983868104;
        Thu, 04 Sep 2025 04:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiNJwFVyYw6iRPTn2SXgKPEMTFYqOkmqbgIOR3QFD5k0qN58gRvVDpUF+lBje4Qd3SQAHpxg==
X-Received: by 2002:ac8:5c91:0:b0:4b4:96e7:6497 with SMTP id d75a77b69052e-4b496e7688fmr43484111cf.37.1756983867629;
        Thu, 04 Sep 2025 04:04:27 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.247.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f62a861sm26700141cf.8.2025.09.04.04.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 04:04:26 -0700 (PDT)
Message-ID: <25fd2dff-2460-4eba-a25b-bf83c22ff8cb@redhat.com>
Date: Thu, 4 Sep 2025 07:04:25 -0400
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

[ Just another quick reminder the hotel block ]
[ expires next Monday (Mon Sept 8th ]
[ I hope to see there in-person or remotely ]

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


