Return-Path: <linux-nfs+bounces-11291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9099A9DAC9
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FA71BC0AEF
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Apr 2025 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1825661;
	Sat, 26 Apr 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/JuqmrE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149604A1E
	for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745671722; cv=none; b=DpfatRlWKGrvQIVvRf4otrU9IuvlNBZM9LdZ2CkyMzT7qrlvWjyyH7Y3ZVlhQx0Sj4Gb7+rNlqKZ/pvsefvFVjXbHd14PJaJa0aRsqGmi773adIs+oHZ3v2SN2XIFowGex4CfM9BljTAD8mgOba1X3Icw5cuGBvzEGDNLQkkDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745671722; c=relaxed/simple;
	bh=VYqtbLRH/K/iE1LXZ2kNAahJLPEgGpqpa/nRjfps2+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDKS1h/qyRcrTFrPQO2736olXh+aPcPzF6ha1D7seNdb/FBrvOf98ES0mWbLVm8cN8p4dehneojZVcknBKOXWR34h4IGvrc2TAQ6qGpJ9Di9vT99bCTNi0z6A+PSAn7zwj701Kv5bW4oFGA7SqNsNetCjSbQLLCGkA+TPU9Z7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/JuqmrE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745671719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yPzJiUd4vRbO+EoINHayAlTW+OknUYWyhdkX/Y6xRqY=;
	b=M/JuqmrEv72vpcqFZUd2y6MnWOYjHjo/BHIaQAqu3mPjHA8Os/sk3GWPtl7LldmsxbYiw4
	1dHGsacKLP1dUfeQm6UwK0NOB4OPuJfeChGPoTHVklD4j7Rvc/1bEKRCyqa5Zoz1y5Gty9
	F7xv8hAZ15tHgdId1l6f02LzvL2QbGw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-2-RqD99KN3WA5fmHWscsWQ-1; Sat, 26 Apr 2025 08:48:38 -0400
X-MC-Unique: 2-RqD99KN3WA5fmHWscsWQ-1
X-Mimecast-MFC-AGG-ID: 2-RqD99KN3WA5fmHWscsWQ_1745671717
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b16f5365310so1363575a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 26 Apr 2025 05:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745671717; x=1746276517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPzJiUd4vRbO+EoINHayAlTW+OknUYWyhdkX/Y6xRqY=;
        b=VbPCAWp9pjyONFTTUfo2Ji6aWUCC8p5WaAMOPBJBQ5o5dYF9ZTpx2giDIMuAAXY2Sw
         FWk2P56Aqu/HzeyMzf4fNXKQNo/bMbCvxHmt/DA8L1AooVv7GX3BWk3FXumGyFjWEfoY
         0wgBg+cXPtjIf7kpjnELB2ptRxi7YgN0Pu85UnU0aDC2BNMmuWIIMCnBcKFQ//Dk0s2O
         3mt2xtt94FAbgYbvttUa9l79Ef21kjgGYpoIHTjFESfmgglQ+P+d5t4nO227yQXCtUcl
         8AqYn1RYDpmhXPz3UW83dC+MPI1qK4RSwMblO3O1ZYiViKgGZs3SOVFP9UX1vAKUfpU8
         wBtA==
X-Gm-Message-State: AOJu0YylfMDew9M5W1ez7f88vIm+lW+0wlHd9mnUBrWWYA5/QAbxBQJ5
	19KYg0Isbd189FEORwdKqmFpK/Xtb1T81Smc7b/2ZYDMAdOJY0ZGsRkvzieBLTY3WS+/Lutj3ef
	wGUBFw6gwu4gemSLepnnC6OBAwXlJGlZnJe9tmW0qPkmKVO7+Fe6tSewJHA==
X-Gm-Gg: ASbGncu8d4j/oscvAun4vH0epzypQhqRDr7A+mokMvVEpWI+vgPQJAuMydnVDKV0yLH
	nyTfmubeQQfGgO4JRpMEWIy7uhOa8/hg7tapd2IDWt5TYIvShwh96YYwNT7WWaQnTT9SXVovzcP
	qgQKQmgc0HMgRIHXjwg7BcUZcMiiFd9x+pXoHHi3pLnjlbNOClY3V8npYYeFc1t1vHnjFV++NvU
	KOELfWRG3DXv+/oL0sZiB7VM9O0t1DhvdN3uxqc04FLO5xjQGPAI5naOqHqBro2jnvQPdwIJKOU
	Tm5t0a4jL7Xnzrz5fk7uupps9nZR+YMGnUStvz9bP8vhlEC8D42F
X-Received: by 2002:a05:6a21:2d0b:b0:1f5:59e5:8adb with SMTP id adf61e73a8af0-2046a1c0d16mr3957603637.0.1745671717357;
        Sat, 26 Apr 2025 05:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+3tXq3X4/E+08Yc+LbbUeVUjZ13YxvblI7A+3qInc+gOPxUUVstiqoWPgm6VZKUvX1Wg+ag==
X-Received: by 2002:a05:6a21:2d0b:b0:1f5:59e5:8adb with SMTP id adf61e73a8af0-2046a1c0d16mr3957586637.0.1745671717016;
        Sat, 26 Apr 2025 05:48:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a58bsm4912934b3a.143.2025.04.26.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 05:48:36 -0700 (PDT)
Date: Sat, 26 Apr 2025 20:48:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/033: Don't call 'fzero' with the KEEP_SIZE
 flag
Message-ID: <20250426124833.jopyhhzdr6zgal6t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250425152452.105188-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425152452.105188-1-anna@kernel.org>

On Fri, Apr 25, 2025 at 11:24:52AM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> None of the fzero calls in this test end up writing past the end of the
> file, so this flag is unnecessary and can cause the test to fail on
> filesystems that don't implement FALLOC_FL_KEEP_SIZE.
> 
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---

This version is good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>


>  tests/generic/033 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/033 b/tests/generic/033
> index a9a9ff5a3431..b7df56b82619 100755
> --- a/tests/generic/033
> +++ b/tests/generic/033
> @@ -37,12 +37,12 @@ $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file >> $seqres.full 2>&1
>  # delalloc blocks and convert the ranges to unwritten.
>  endoff=$((bytes - 4096))
>  for i in $(seq 0 8192 $endoff); do
> -	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
> +	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
>  done
>  
>  # now zero the opposite set to remove remaining delalloc extents
>  for i in $(seq 4096 8192 $endoff); do
> -	$XFS_IO_PROG -c "fzero -k $i 4k" $file >> $seqres.full 2>&1
> +	$XFS_IO_PROG -c "fzero $i 4k" $file >> $seqres.full 2>&1
>  done
>  
>  _scratch_cycle_mount
> -- 
> 2.49.0
> 
> 


