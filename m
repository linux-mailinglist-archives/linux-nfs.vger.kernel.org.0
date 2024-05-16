Return-Path: <linux-nfs+bounces-3265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81F8C70C0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 05:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14FC281F5E
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2024 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BCE29A9;
	Thu, 16 May 2024 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpJvPQMM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB141C14
	for <linux-nfs@vger.kernel.org>; Thu, 16 May 2024 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715831409; cv=none; b=PE6SJC2oPdfHGDK0Pb7X5D2SP8NwREbBP915i069YqOs+qeEagLgzOru8/jSnJPkYdhjQOPrvT441WNc19QHcZsDXyhSuivmRYsC8/gjnU4zyMBbkyKURUYS9A1ZBntamlYob7kMq3Mjcs6Epo5/pPjvXKn/DhGl0EyEqn5nvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715831409; c=relaxed/simple;
	bh=a2/2b6FDEzUw1rOL8SgMqO/AVqOxWxClxPMIAtDtIlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3EK40yDWMgcc5e021zwoMODP/+foPpo1RwbfH8NHf3idKlpdkz62tAuk9g8EijcAOuOBISYrX2Ao+wpqKq3oZsj0PkRfahfEN47mnha/7RLW+FWI8CsDV3OY/FnB/gcooiVq9PktSelBlFwtSGXtegDuP7hbxsSFVP3RJSZ7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpJvPQMM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715831406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gl60mrDio8jc8u8u6k+Vmdn2yDp+jFT5KdnmnjyNd0U=;
	b=FpJvPQMMmeFnwLBeeG2qe43J62x8kx/3mFD4xrYI/ICDYW+tJgj/NnPcylPyEJfFAa4rwg
	Ze5XdAzniuAb9kSZ/TPNVhtlRy1iz9e4tVoEw+0chexoouJxR/DuD9PapsN2vb6a6+0Yap
	bc174Aev5NWMehQKj6zgvKfkexSdUwQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-Nff5cMaPP0Ki1ugbYtuFmg-1; Wed, 15 May 2024 23:49:59 -0400
X-MC-Unique: Nff5cMaPP0Ki1ugbYtuFmg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ed057cc183so90079525ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 15 May 2024 20:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715831398; x=1716436198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl60mrDio8jc8u8u6k+Vmdn2yDp+jFT5KdnmnjyNd0U=;
        b=XnOQIA6U2Brx3a7RRWR8jWK1ebmowrUAaSf13uefWUmtBH2bbfG3X88VSxe5rvRwkP
         9gYK448LZ0Y87TQZXZsvNUcwz2Wzd/FtrV/U4RqlAOcmr3v4vNgt6Kwy7EI6q+B0Gs64
         NP8zfXf5GpxIbu1+K972Z0VRnnTmJ+Kgy0A7MpyyhPjKzoOGcC1mXr+it8MrbkLag+Pt
         zIJyTs6CGwylsbw/XTjcjB5QCPXn1rKWcgVoT15Q2DgFyRY+A9EChH4KcEm8qrlix1h1
         S0WEWRbfNMnNeDOA4BiQ2GLvU8f+sutN/IQ0Ie/qKDHURY/O/56FzbK4dtZMHQSHka7R
         k27g==
X-Forwarded-Encrypted: i=1; AJvYcCXcTk7YO9fDKAm3AnoHy7iivmNZv0k6T5DdGQaknbMi2J+r4/LPhPFu3Sr/DqGEqrpRSSlXCftvJl+4HSjfAXsueYSBjhCEIFcE
X-Gm-Message-State: AOJu0YwNYfs4Xr3NroJpz3Z7VA212qpCezGCGDlmAenmJIWi6W2Hd4W5
	J64IPB1YllA5HC/pu652nDz182JlR6frrZHnqhPQ6+xec5tTzM4/SRMHBbVZkb+CNKOpWDmY13e
	iZRRhf33DgzcwZNewAZXl/B4ZqVk2j3nK90aEDC5qlu/VGOZGoKzO6Zreyg==
X-Received: by 2002:a17:902:e752:b0:1e4:3320:dbed with SMTP id d9443c01a7336-1ef43f51b8bmr226466745ad.52.1715831398324;
        Wed, 15 May 2024 20:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9iw4BDSqSoydaYv4Kek6dvDiorOM6oI3FuTULeGBeSdab4FpOT10JIC7yt7hYHQs66c/+VQ==
X-Received: by 2002:a17:902:e752:b0:1e4:3320:dbed with SMTP id d9443c01a7336-1ef43f51b8bmr226466605ad.52.1715831397691;
        Wed, 15 May 2024 20:49:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f07dec3fb2sm55858005ad.63.2024.05.15.20.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 20:49:57 -0700 (PDT)
Date: Thu, 16 May 2024 11:49:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH fstests] generic/742: don't run it on NFS
Message-ID: <20240516034953.7im5grlfdr2xzs7e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240515092133.1219-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515092133.1219-1-chenhx.fnst@fujitsu.com>

On Wed, May 15, 2024 at 05:21:33PM +0800, Chen Hanxiao wrote:
> This test requires FIEMAP support.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  tests/generic/742 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/742 b/tests/generic/742
> index 43ebdbc6..aad57f2d 100755
> --- a/tests/generic/742
> +++ b/tests/generic/742
> @@ -30,6 +30,7 @@ _require_test
>  _require_test_program "fiemap-fault"
>  _require_test_program "punch-alternating"
>  _require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fiemap"

Make sense to me. But according the change, I'd like to change the subject
from "don't run it on NFS" to "require fiemap support", due to it's not
only for NFS.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  dst=$TEST_DIR/$seq/fiemap-fault
>  
> -- 
> 2.43.0
> 
> 


