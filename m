Return-Path: <linux-nfs+bounces-14371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2FB55007
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19061D60A7B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B223002DE;
	Fri, 12 Sep 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agCZ5FEp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909FD26B769
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685052; cv=none; b=XZwhUHI7omBYcAfpr3lE0zYSGvAO7viJiEHJgUhZMYw6POWiSIwSF7yC+y4rbT9kUgjUQxfRCTcXbVE0zkMofZtcqQSLAoLr4Xyy5QcX25uDnjj4aaAOiEpYmzNLW/TmWCJPwsMloRsHcFyPLSv2SDtOtLzhC+8fGg52yZEPvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685052; c=relaxed/simple;
	bh=azYkLoUNg5as3F90d3LzYtpeQ2wTLvpRXUyHQMDFeQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u0cIHrP9J1EI+Va51h5NRjOm8CvvcBPRacqXOnLRldKta7RVLuwVZauVS+Vdm6gUsE4x+q8J7uj4BOdAtQvv1IG9VpsGrqyzqbwh9iAkuC8yGs1EjfxJXdIROfLnrvImyl3SMsm/7uND+Uj8j5NPZjqU9l1QxmAaFAMML4nI1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agCZ5FEp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757685049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqCTIshRPJXJR3N0RXlaDDGAVW6z2j0NCtgRUBXnARc=;
	b=agCZ5FEpBxbZVzMGKR/S80YVXy9+uJ6OoGM/Mgs+K6OD2dLjZm6EDKn74GHNLZhiu9uiK/
	b4zO5tXDCG8H+fTZc/PztXNnAq5O5Xs9UCqv7lFT+mcNiGV43kQQ4dortekV563V4ksoZV
	9CySD3ShEs7VAXZ1NZ/S6NQGXFYhehA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-ka9K8aqNOemJszqWChGBPw-1; Fri, 12 Sep 2025 09:50:48 -0400
X-MC-Unique: ka9K8aqNOemJszqWChGBPw-1
X-Mimecast-MFC-AGG-ID: ka9K8aqNOemJszqWChGBPw_1757685048
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70ddadde46bso38532656d6.2
        for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 06:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685047; x=1758289847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqCTIshRPJXJR3N0RXlaDDGAVW6z2j0NCtgRUBXnARc=;
        b=Htm44q1nwn0B7sTBJhqQArcC0rzTZcolWvTqadXEfSeWjLVLFjAT9783fXFvoyCAFt
         58ktsq5wOuUWqGkdwyw9zyyIHAAe/HkUTglUyPkplycFsOp3QUsmdkJBYnNpX/cC7Ox6
         hdfT4DToqm0T2So0Kt6RPuPyiZCFi0Cgh2pAx9/xlcwFSvZDEwkBq1AG+j4GvwPRyHkl
         kMEOTbGB5DuSr90hYBBGmcB8OTAmPaqyaB/EiUcsJAb0hiKTXyNW98u2r1vrXFXNvr2Z
         qrInqYB6bSeVXFZqpSzGJIHdcXSuVYZC+4xAamJ3KOXMHzg6Rs4MJTgft0/RohDHy/rC
         PMvw==
X-Forwarded-Encrypted: i=1; AJvYcCV2e3o+SgpU+KzGo+6gTqwi4gG0M1Umxro28M+e0U1zs8brfVxSuL60KI2O+9eUThlIdtThMKp4cN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynoNmT8v3Krl5sqo6RzpUzNhjeUUEeWUw8zGpQYn2EFMMtJ5Du
	Q3KCQLSa3iAhRgNeWrhBasTl2Qc9yK72xRadRAJ2oWYVODkzI4qnrthQToKpt/neUxiqmowkI28
	Q8hEIgtfeDJXESyLyDvO66XlErIDcQlEvf7GRwAegeMQPMOQz6vE0Q1xn7hQMUVm+6VNucA==
X-Gm-Gg: ASbGncuVs/qEoPEYw86HOnk2pqqI2es2ks2MHExG8H+i7uE0cm1sguoVr3pFF3I9z8X
	RaydJtDX3beR5o265Jx/uG/zp9wmK8E4ByyYFHhefYhdD0ImaN2svBi5Fv8Hh3kaUimIL0X1fWk
	L1k0c4BkfDUIkn7ZvAj5GmXeBrEEJsI8SnlC1shc4eM+dBs9iBHliXCrR2tXdonoRRaqBQsfCpp
	qA7fCT93bZA0izDd0rhtSCjDQtUbixf2h2l4lnqjU4d2VFdMUxJzlhQSDhG6WZZQSzFXpXAipb1
	P8hxzZZlqsSv785Xtl7Yj0bqt7gaWi3+AuYj1boGjheDsdDuGeE33x87nXP5rN7j6zj0JQjPbCN
	vzSjXgrc2nrhC
X-Received: by 2002:a05:6214:2428:b0:715:94ad:6add with SMTP id 6a1803df08f44-767c3772553mr41225086d6.47.1757685046966;
        Fri, 12 Sep 2025 06:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfbRiFsTb3QSTgTb0Oa/0nfGVSG11Ixx1YlvudC2CR/Ge/s7fxxFYsV6tKowaWeLeY0pM60Q==
X-Received: by 2002:a05:6214:2428:b0:715:94ad:6add with SMTP id 6a1803df08f44-767c3772553mr41224536d6.47.1757685046406;
        Fri, 12 Sep 2025 06:50:46 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:e99e:d1e3:b6a2:36ac? ([2603:6000:d605:db00:e99e:d1e3:b6a2:36ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bf3424a8sm27014306d6.55.2025.09.12.06.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:50:45 -0700 (PDT)
Message-ID: <cf4a4520-9aa2-457e-a28f-ce9df029eebc@redhat.com>
Date: Fri, 12 Sep 2025 09:50:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Status of nfsometer - Debian - Triston Line
To: Triston Line <tmanaok@gmail.com>,
 Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <CAEgfpGeGgQZsQeyK+YC7eonT8cqWHwD_x6DByNFpbS4McLTYSA@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAEgfpGeGgQZsQeyK+YC7eonT8cqWHwD_x6DByNFpbS4McLTYSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry I just saw this...

nfsometer no longer has a upstream maintainer

steved.

On 9/5/25 7:30 PM, Triston Line wrote:
> Hi NFS Team,
> 
> I am a Debian contributor looking into the status of the nfsometer package.
> The Debian maintainer has filed an intent to orphan it, and the Debian
> source matches the latest release I can see upstream.
> 
> Could you confirm whether nfsometer is still actively maintained,
> or if development has ceased?
> 
> Thank you for your time.
> 
> 
> Triston Line
> 


