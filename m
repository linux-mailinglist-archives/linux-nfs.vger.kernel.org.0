Return-Path: <linux-nfs+bounces-6183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C7696BF32
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DB928A2AE
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD61DC058;
	Wed,  4 Sep 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYw1hGW1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072F1DC075
	for <linux-nfs@vger.kernel.org>; Wed,  4 Sep 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458117; cv=none; b=SMokh9mCFue3Tz2TfgiZw699VW4XwbL8IMSpSvj9g0aJhTRLqF6xtnJw9NGLj53sPf/uw61t5jhQxwgByNieD/DNDyUlddhyV9UA6HgBj5gDNFETtL2txoijflhnGALKImBnTu3lBHw/97vq94zzemTB/pOp470QNyWDKBzZeyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458117; c=relaxed/simple;
	bh=kL+oSNbawhN1uaOgkJHyKBpLHPJmx3ltEBm69ARHHaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGUjj3l5nEh6hDLHMFb1pMfvEQ6muCku0U5PAE9ehVkc8GW9fW5ln8Bpu+MOiBpArfMuF3Zcvv9q2zcK2UXSYY/81UeY3TJ2rG0rTqvd/E9zLTCwWWVN+OvCUE3xWaVlcocY57xGBtRztkMA7NapoFVKvT4UVJAcxI0PSqLxRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYw1hGW1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725458114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2v0kkQWkHh+Uia/RzmeC+1VwFwArheO/Ts3rSI2s2RY=;
	b=TYw1hGW1MFbRYFCtDxX2NI9gWdN3s1/+2PIQoS+rg/W3krnISmiI0oiV7dyQ3U5P6MxPye
	/s8MtslMF8BD2oJ7IJ0xPQVe9fkO7zGq3o8c5q0NkW88YkRF90vOEdQ7CKthDp61sOnKHS
	SDiofDKHPquV4AwrYPC+4tErMxoaH5s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-9pkCQyrgNNmq0EMRYAGDGA-1; Wed, 04 Sep 2024 09:55:11 -0400
X-MC-Unique: 9pkCQyrgNNmq0EMRYAGDGA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d882c11ce4so4434760a91.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Sep 2024 06:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458111; x=1726062911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v0kkQWkHh+Uia/RzmeC+1VwFwArheO/Ts3rSI2s2RY=;
        b=FmaEFtggTPVvX7XRI0S0gsx6/LL9cN5/MZN8SS6AIaClRtWidTq/7JcEDIpj/8wH7R
         43DE60TBpkEaPDY9yY9bF4PoxIS70UiICRJgB/UpnABVMTkq/JkPkGtgf2tpZGrow7mN
         sgT47mmYdt710UQPi6typ75L71lnkgCkJT1ASlZI+g/AmUUcH1Iqd27Ko/zGSSdZOUL1
         YiHZ8AJIJqqFAeyoIK9kPI+y7KWanO2O6k5RHpvM4g3ntJunySYgx8+ECecvwDgdHyMO
         hSzVuxAZKlof8k6Nw0oL2exJm6QIVsbGJsHZYXdYcoR9plTyGqrQq6geNrDq2JzazlUp
         Dbdg==
X-Forwarded-Encrypted: i=1; AJvYcCWN/ovivB/+cMgtDUjnlHmBhCK5372JduD8KCBHh7lZKN7WNk2Kqeh6jKHdF32VirEmiEVK1ZtvMqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tnZdRXaqIn5eJPSJWVbSGxLUcvfKUHVgM2NWguLfccfhoT4G
	mJF6vrP9295IvkKF8uNWN1/J5jp/YfHX+wI1wX2rlRqBU+FPW48Px1DoC71D5FV+oEBiUgud7cL
	4nf8k97UzMFs01Rcn2IxhU/z1TB2zD0ZMuL0S8iByAzadcczq91/vLTiIMA==
X-Received: by 2002:a05:6a20:2d22:b0:1cc:d5af:aefc with SMTP id adf61e73a8af0-1cece4d6de8mr16025284637.6.1725458110890;
        Wed, 04 Sep 2024 06:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFflJ/1YHHfSMrGXAW3NEuPnx65gyWfFLrq0OHLK8efIiPKyPDI/yURRHEXrvyc52IJbLnvAA==
X-Received: by 2002:a05:6a20:2d22:b0:1cc:d5af:aefc with SMTP id adf61e73a8af0-1cece4d6de8mr16025199637.6.1725458110094;
        Wed, 04 Sep 2024 06:55:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778595181sm1679642b3a.142.2024.09.04.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:55:09 -0700 (PDT)
Date: Wed, 4 Sep 2024 21:55:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [xfstests PATCH] generic/362: skip test on NFS mount
Message-ID: <20240904135506.meawnw7xtdinzi5n@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240903021918.2491-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903021918.2491-1-chenhx.fnst@fujitsu.com>

On Tue, Sep 03, 2024 at 10:18:09AM +0800, Chen Hanxiao wrote:
> xfstests complains:
> 
> # ./check -d generic/362
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 r95b-1 5.14.0-496.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Aug 12 18:50:44 EDT 2024
> MKFS_OPTIONS  -- 192.168.122.42:/nfsscratch
> MOUNT_OPTIONS -- -o vers=4.2 192.168.122.42:/nfsscratch /mnt/scratch
> 
> generic/362       QA output created by 362
> Failed to open/create file: Invalid argument
> Silence is golden
> - output mismatch (see /var/lib/xfstests/results//generic/362.out.bad)
>     --- tests/generic/362.out   2024-09-02 14:27:09.162636093 -0400
>     +++ /var/lib/xfstests/results//generic/362.out.bad  2024-09-02 14:33:36.167636093 -0400
>     @@ -1,2 +1,3 @@
>      QA output created by 362
>     +Failed to open/create file: Invalid argument
>      Silence is golden
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/generic/362.out /var/lib/xfstests/results//generic/362.out.bad'  to see the entire diff)
> Ran: generic/362
> Failures: generic/362
> Failed 1 of 1 tests
> 
> NFS commit 9597c13b forbade open with O_APPEND|O_DIRECT

OK, thanks for pointing this out.

> 
> strace show that dio-append-buf-fault use (O_APPEND|O_DIRECT):
> 
>  mount -o vers=4.2 192.168.122.42:/nfstest /mnt/scratch/
>  strace ./src/dio-append-buf-fault /mnt/scratch/111
> ..
>   openat(AT_FDCWD, "/mnt/scratch/111", O_WRONLY|O_CREAT|O_TRUNC|O_APPEND|O_DIRECT, 0666) = 3
> 
> So skip generic/362 on NFS
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  tests/generic/362 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/362 b/tests/generic/362
> index f5b4ed06..d7bb0125 100755
> --- a/tests/generic/362
> +++ b/tests/generic/362
> @@ -18,6 +18,8 @@ _require_test_program dio-append-buf-fault
>  	_fixed_by_kernel_commit 939b656bc8ab \
>  	"btrfs: fix corruption after buffer fault in during direct IO append write"
>  
> +test $FSTYP == "nfs"  && _notrun "NFS forbade open with O_APPEND|O_DIRECT"

To skip nfs, you can add this line:

  # NFS forbade open with O_APPEND|O_DIRECT
  _supported_fs ^nfs

before _require_test.

I think that's simple enough, I can help to do this change when I merge it, if
there's not more review points from nfs list.

Thanks,
Zorro

> +
>  # On error the test program writes messages to stderr, causing a golden output
>  # mismatch and making the test fail.
>  $here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
> -- 
> 2.43.5
> 
> 


