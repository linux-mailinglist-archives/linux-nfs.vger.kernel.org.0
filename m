Return-Path: <linux-nfs+bounces-16781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BAC92D1B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 18:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95FD3A7BBB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E31FC8;
	Fri, 28 Nov 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9by+G/u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mmIkSFe1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D3248F54
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351650; cv=none; b=smHwMvETf+Y1+/7vJq1eWyNsERjhMSDvPXbC69inV4jTKLVN3K97JrvxcpHKvguMedXkuPxZNX5QN2vmAg0ZKJr++M2qpW1liJLgGeZE/AkfcWWaD7QujBZLt3b0ls2R3SNOVYxKQPX0x+vQFvKi+YbkluXjAgLaUsoyQlFQ07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351650; c=relaxed/simple;
	bh=aePqSOs99Iuf6MsTP4nGkf7pP5MeE5mscYRvThKQDjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJDdNUVCvmq0BFGcB7fH9gHnVLP/JBSZ/HzcSRM5kfelqK5B48f1FxK60DU0mY1MYMAeY8xpVuaJ08jah7JPTxRVGMOPynAUYFqnGy2dmFK12A+8FlZuKsxV2sDiSW/XIm1KYYlXBsQGs0WjbwuEWLI8fJGC8a0+YDVKsYj17iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9by+G/u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mmIkSFe1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764351647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qldbNojuQEMz3aYOlEfESNtBsAKqB347GXKhFK0aE6U=;
	b=d9by+G/ugG/DBFJn6G3OzsmUafABu4W+GEL6IkARI1xqrlqhQFdZr39LDIH8M5xQDRwYuN
	45hYcY9PK0S1cKlv1PRJkXFLI7r8VBCG4xlJ4naWfryoz19ycf6ukjVkPUp9Kr+FWNf1Qu
	GweZpt4gP6dVXaLqXYHY1Lk56SQdfH0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Vy5aQWLFPYuMtfRKLaFJ1g-1; Fri, 28 Nov 2025 12:40:45 -0500
X-MC-Unique: Vy5aQWLFPYuMtfRKLaFJ1g-1
X-Mimecast-MFC-AGG-ID: Vy5aQWLFPYuMtfRKLaFJ1g_1764351645
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso1804332b3a.2
        for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764351644; x=1764956444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qldbNojuQEMz3aYOlEfESNtBsAKqB347GXKhFK0aE6U=;
        b=mmIkSFe1ejPwoo1uobZ97haKhl9eTCZfmIjMA+ZnikIs5pi8KELJzdt6c4uD6ncwfk
         C+bfYrRNrsyoEmEFZfdYxG82acMtFWZG+5LAYwe4WV7uV2PHpnMsB0ykB6iiJ8UwIBM6
         nfGnaog7tDkYRrZzOxIUaFhvHbVuO+fnlwo2DsasUNGCpqLULHw7LnVkv6PrAX0LNRXR
         RDhVjTv0c+5UYNswTtMm3ejHvogfAgD/Laa2Z6CDTNW5IZ2AwNLUqnVw8QBiTkLMx1KO
         DjffuL5IucFqLeqf4WLd0yJ/1VggRgWlOf7GE3Si1VLox4ggDIWNrQ6kkOsv1EiOfm3t
         Vsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764351644; x=1764956444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qldbNojuQEMz3aYOlEfESNtBsAKqB347GXKhFK0aE6U=;
        b=ExSXYyGn/DT1LvmzqL49XoSaBO6M0QAk47TO1EqNk4Y+Ax5PNYlGeezOGfNKKV37qG
         GvoAECmAkR5R3/yyEiS0ltjPROCNQYFD+UNWpSFQXH+oKqvuqXgaPNiz8Fve/dEtaOpP
         v70Ki1bKyaMKmYoXbz6MaXJPCl15NfMXTD614/IP5XD7slp3PeSLZ2tJzRVWmj6olWfO
         A4v0PbIiRLWvZKeO0kezDWvzy+Er/ZbW3tKmmz7PSn+zSDd3poXfnKLDp2PXpqqd425M
         IE6nwjXJV771p03CY41SiJ32GBN4hDhQrdGohTpg68LbKOqrLijeMQPS51OknWPpNS4A
         f5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkqOSd728rfvtNlW6aJgiy+QCa2zVw5NHBjhJLpGTWUbk2FtLaRwDrkZRMlicIoKVbaeka6MqJGdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31ZvE77CNyNlvbMY+hNkH5ykGLGLTmrv/oENXFX6cfkjNeTlb
	SBJq3riI13KZO8HvKvTVZUd3jZDsr0pbAUY3cRjrBipl7CfLOe5jSKQCCvf8C1LCZI6fNh4i0VN
	3jQsb/B4kTOGBhwYp1ajernmJmgXWBpxJTzYKYOeKvUxLz0fUE6YVj/Q+G08MBkrHx5rSqg==
X-Gm-Gg: ASbGncvcyDNHzHyMvWH2FItVUohzfFz5+Q/fsV7UDhd8wd0NCHFSkxF4wIWAV8dh04l
	QYppvlYDSFGB9vbUUA+yafd82KDvDNMqSSr/hmCIxDcgHRUKO0SE8TTKXkGj7sJ9wz2rRmIhexo
	QtHK1Wkf9S5jbqVoHya7uipb+B6aSIMsuOWj9ct7BjJeAHOeSwLJOZndjCJ2aIk88BI8tWhPjUe
	hdS3VGCWqpY/oCWLdSvjE0B+/FnYUegHTvl60sETHXEGeeiAqJk+539aPXSjrGMLhE2LkuHNwlp
	43/OjjRb+8qeu7N6nOMtVaTwZ041AgQemZYKUAn8mukEx4RknRAEqBW8d/BqsHQi1JKJHtdiBPF
	68G5MHevH4DyciwN1vSC7raeSVULmDar4z5eQpR7EERxv7Rk1xg==
X-Received: by 2002:a05:6a00:3e0d:b0:7b8:8bfa:5e1e with SMTP id d2e1a72fcca58-7ca8740d6d4mr15779326b3a.4.1764351644188;
        Fri, 28 Nov 2025 09:40:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCAAkQu2eaO/fFi9mDFABm0jJp0jEk4PDSUYKBl1At7Juj0FNjoI4i5YqMH39bfP30zxycRg==
X-Received: by 2002:a05:6a00:3e0d:b0:7b8:8bfa:5e1e with SMTP id d2e1a72fcca58-7ca8740d6d4mr15779297b3a.4.1764351643624;
        Fri, 28 Nov 2025 09:40:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3b8bsm5571876b3a.44.2025.11.28.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:40:42 -0800 (PST)
Date: Sat, 29 Nov 2025 01:40:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [for-v6.18 PATCH v2 0/3] nfs/localio: fix various new issues
Message-ID: <20251128174038.o3gas3rn7puau235@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251126060127.67773-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126060127.67773-1-snitzer@kernel.org>

On Wed, Nov 26, 2025 at 01:01:24AM -0500, Mike Snitzer wrote:
> Hi Anna,
> 
> Here are 3 LOCALIO fixes for issues discovered as a side-effect of
> Zorro's recent bug report:
> https://lore.kernel.org/linux-nfs/20251125144508.rxepvtwrubbuhzxs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

Hi Mike,

I just tested this patchset (base on linux v6.18-rc7 which can reproduce that
cred crash bug). Then the test didn't trigger the crash. So I think this
patchset works for that crash bug. (But the g/751 hang bug is still there.)

> 
> (note that the "generic/751 hang on nfs" still isn't fixed but that
> one is a long-standing issue that can be reproduced against stock
> v6.12.53 -- whereas these 3 fixes address code introduced during
> v6.18-rcX).
> 
> Sorry for the trouble, have a wonderful Thanksgiving!

Have a nice Thanksgiving day!

Thanks,
Zorro

> 
> Mike
> 
> v2 changes:
> - patch 1/3 is the same as was posted here:
>   https://lore.kernel.org/linux-nfs/aSaTC51DkxEqQkrZ@kernel.org/
> - added patches 2/3 and 3/3
> 
> Mike Snitzer (3):
>   nfs/localio: fix regression due to out-of-order __put_cred
>   nfs/localio: remove alignment size checking in nfs_is_local_dio_possible
>   nfs/localio: remove 61 byte hole from needless ____cacheline_aligned
> 
>  fs/nfs/localio.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> -- 
> 2.44.0
> 


