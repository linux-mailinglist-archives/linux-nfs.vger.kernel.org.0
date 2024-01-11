Return-Path: <linux-nfs+bounces-1044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34D82B632
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2916A1C23DEB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jan 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888685810E;
	Thu, 11 Jan 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XajBpphL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8A5810A
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705006061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRCVkNCw4vLMHpwPxx+mvEYN8dpRQQC8+r9hAfbuEyc=;
	b=XajBpphLZOKvojMSnoRlbX3qh7xGDKTPbOXifLeUKjnDx2z1ckqh4XETXHVVohA59VA3zr
	9bYqxxDYH/JX0OvYh3JtMXsrz+V8G9hZLi/fhy3hCwmDc7BxRpfnDndzq4Oc0nQCmLHpvN
	+Bp+aM4YDmYAB5Tq5x446kjIWuoyH0U=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-W85Fbe-qO2SD1REcsvVccg-1; Thu, 11 Jan 2024 15:47:39 -0500
X-MC-Unique: W85Fbe-qO2SD1REcsvVccg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d9b09d1afaso6674440b3a.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jan 2024 12:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705006058; x=1705610858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRCVkNCw4vLMHpwPxx+mvEYN8dpRQQC8+r9hAfbuEyc=;
        b=IZV+UPyITwnM6Xoq5Mgi8l7o9+4UNCcszeA4qn9XifCs5aSYBH0/243oZDbROBiA9E
         aEFYklqip9b3hgignpznsetWBL3p5uUbr9ZTnOCH6TsDqGnf5EtXRHiCDZ5jocvu6hT0
         yhVDMohP2CwoVqXZTG3ZHiWCVlzGO0LmvJFTt1JebySnDPgZSssPZTWuUbjASoIntlI4
         uM4D6M4FD5qsWtgJq619ohTik63FlGmnAscmRwjsMZbP2h2iluvS1QHs2KWTwHgqdB8R
         EAjN1UMt0pTN0jYRU0OOWD1rvasEHQmBiQpbOWzGM36CpSR3vGXDLMUSzIEPjFy+ygHe
         AD6Q==
X-Gm-Message-State: AOJu0YymP618Vg1h71k0iS3PNJ2ITbdhKXcB0vFxf7CGUwFfZeLW+0ct
	RJvLTlTnc7ha5UhQYv4GfASX1JhCMAT8RwTzBaR9glc3t8YX7lv3JE3nN99dtxXLW6eiq9PZhq6
	uhxJobuyf+AqZQjUOAUVDcrbQ81FC
X-Received: by 2002:a05:6a00:1414:b0:6d9:8d46:814b with SMTP id l20-20020a056a00141400b006d98d46814bmr420340pfu.20.1705006058732;
        Thu, 11 Jan 2024 12:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGycFcdvIejYNz25UNDT8/rM49uzIyE+kDD9brlIdh9eIg5fXxduMRRM2I7wEZxsJ0bDhuXpw==
X-Received: by 2002:a05:6a00:1414:b0:6d9:8d46:814b with SMTP id l20-20020a056a00141400b006d98d46814bmr420330pfu.20.1705006058430;
        Thu, 11 Jan 2024 12:47:38 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fn21-20020a056a002fd500b006d9ce7d3258sm1614497pfb.204.2024.01.11.12.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:47:38 -0800 (PST)
Date: Fri, 12 Jan 2024 04:47:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH fstests 1/2] generic/465: don't run it on NFS
Message-ID: <20240111204734.kvsuqvxlzntnyrc4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
 <20240110-fixes-v1-1-69f5ddd95656@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110-fixes-v1-1-69f5ddd95656@kernel.org>

On Wed, Jan 10, 2024 at 01:27:27PM -0500, Jeff Layton wrote:
> This test kicks off a thread that issues a read against a file, while
> writing to the file in 1M chunks. It expects that the reader will see
> either the written data or a short read.
> 
> NFS allows DIO reads and writes to run in parallel. That means that it's
> possible for them to race and the reader to see NULLs in the file if
> things get reordered.
> 
> Just skip this test on NFS, since we can't guarantee that it will
> reliably pass.
> 
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Link: https://lore.kernel.org/linux-nfs/2f7f6d4490ac08013ef78481ff5c7840f41b1bb4.camel@kernel.org/
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

I've seen several nfs folks agree to skip it on nfs, and no any objection,
so I'll merge this change.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/465 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/465 b/tests/generic/465
> index 73fdfb5548af..0745d6a1dd3a 100755
> --- a/tests/generic/465
> +++ b/tests/generic/465
> @@ -21,7 +21,7 @@ _cleanup()
>  . ./common/filter
>  
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs ^nfs
>  
>  _require_aiodio aio-dio-append-write-read-race
>  _require_test_program "feature"
> 
> -- 
> 2.43.0
> 
> 


