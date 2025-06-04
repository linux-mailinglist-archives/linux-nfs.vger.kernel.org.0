Return-Path: <linux-nfs+bounces-12102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDDACE426
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DAB3A72C6
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590E189F43;
	Wed,  4 Jun 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cC+qEaCe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2D171A1
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749060249; cv=none; b=F7iWujmpIRvvSUNFHExnc0DF7XZ/qezknqHhOdrcmx72z4uraASam4OC2GLxkZ1KZp6XmB7+LFH0cGE5eJdqASR4QbiPTdQ79XRFal49e314seU6F1vGdPDB7wNhWyHSH40z4ftTB5NGKcIJYwuOsAHJ6NPNsYeFPHErpHlBB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749060249; c=relaxed/simple;
	bh=zuj2XiWRd+6p63Ikzo4xsRdkehCuqFb+jMDbk1GP0Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kn6bUwPZhfE9iaa1k6giK5aLWigQRhp+Ts/JlD4AE4TH4kdiBpyUTSVg9DfPDOZjO7InyhYCHj2WCJXpiuKdfxTROHjow2c+RxTwJBB1lqd5Oid8EHoxTyJjPHVvjHIVse+wtrXfdyqUuWjSLGdSWc7r0GGutmNyxL3jvDP4Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cC+qEaCe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749060246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2cNY8dsHj7q0wO1yReflUiHxSFejPHlj3nPaEf+ZRs=;
	b=cC+qEaCeTLSL5ry52AyeEii+BLAOwpLBsZR6uw1JZ0Nz8IOddleX9yhTVPMo757NWcc75z
	tPbp0Dwtw+W2BZ32Mig4tJxyhq37RA02tTUjBJ+Eqo+k3nkHf7wBL2jCYQnGNhG8ws+aCm
	yjkaeCcCcRLm0bcVrTe2BmP+KXzmXfc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-K7WwieRBPTyTXI3z1OorfA-1; Wed, 04 Jun 2025 14:04:05 -0400
X-MC-Unique: K7WwieRBPTyTXI3z1OorfA-1
X-Mimecast-MFC-AGG-ID: K7WwieRBPTyTXI3z1OorfA_1749060245
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-401c6b8b66fso172754b6e.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 11:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749060244; x=1749665044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2cNY8dsHj7q0wO1yReflUiHxSFejPHlj3nPaEf+ZRs=;
        b=bCuc0ZvSou+JeBzQKxb2K3A7gKRojwqXpcK0ibSEUwVihP8mXkVCUnAxfSsscDE1HP
         1HMnKTz7CwkOYsrpxOyOPSdZJg1EyFyUSmeh5yR06wlemEFZpsz/yeXtvUb4/OrLPmOb
         aCF3SHPk1yWlvD7L71S7ZiFzPOVc6leukG5TFhv6dnD5yHIsfNT75UwLjDIrzNGgXwyH
         CM2aQ9uZ2MbbAdvUq9GzfuDqYIchAyoLbHuteWAPwpi35hXcmi90RyiPS03g21NTp/kT
         ZkE7L1WmThwD9SjXyucL45qTAIVcgPdjW4qy3PEOl/37GsSzJXMJnrREdXUGfNgITlGZ
         O0iA==
X-Forwarded-Encrypted: i=1; AJvYcCXatR2jcXcFhzyxuuMawpicO0DUuhDxWqan5UBIZDqQQmp4FXWl52DfxDPEnqzsiEGUZwiE+pQxscQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrN5qP7egjILx4ljbh3zQDpwnCZ094WknL1997Y4AtEMOADZwQ
	rpujuzNsg9smCJyz6W5O26gXgtRtlx3qC4FqiTeHZDekdHjmzEaZGCjqtbONpbqzt/Jpqms2iaq
	pUmq1RmXYe80hq7RI/E/8zWNYxRWMf6ElWEzZr05Cq3/c+P2cSl5n5ggFSoN6dZyUEgFNAA==
X-Gm-Gg: ASbGncsMorLt4QJIQgbPplFaA4lrY0oVx4+HHnqohxPJk5DinrJh+qd3Y/dqPwvL7gh
	IeYLOv73mzMSCZKpzaoSXRL/n/TI8a5/7kxgdI2mf05SJrhH4+g6SIYbW4ArwEdO0gA2ILQn338
	PBfL8M/AmVFDWJ071g9xmFEOPpkqcaoWEgv9sX3PQ3tDZgWlvkB/oiPqkjGNUx5TgrWytrzd/QV
	CtMVNc6cH8iSR1w/QB2BzHa/zXiu1wJiobyLYW+7myLarUB4oTG58cV03DnDxs8rLbMdue5vs4x
	bWxLyVUlDRY=
X-Received: by 2002:a05:6e02:250d:b0:3d8:2023:d057 with SMTP id e9e14a558f8ab-3ddbedb062amr38418665ab.11.1749060232889;
        Wed, 04 Jun 2025 11:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdr2VhoSFAjm3dzuFtggHT1hE0GbYvqnsnlSmgcdz3LDj1sNBVfAjeV5skcxynR+mGqvFuEA==
X-Received: by 2002:ad4:5cc2:0:b0:6fa:b954:2c32 with SMTP id 6a1803df08f44-6faf70095ebmr54978656d6.35.1749060221565;
        Wed, 04 Jun 2025 11:03:41 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4c7d8sm103508626d6.36.2025.06.04.11.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 11:03:40 -0700 (PDT)
Message-ID: <15a51751-2370-4473-a1d3-e4f7cb5e8e6b@redhat.com>
Date: Wed, 4 Jun 2025 14:03:39 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH OE-core] nfs-utils: don't use signals to shut down nfs
 server.
To: NeilBrown <neilb@suse.de>, openembedded-core@lists.openembedded.org
Cc: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <174800219540.608730.11726448273017682287@noble.neil.brown.name>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <174800219540.608730.11726448273017682287@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Neil,

On 5/23/25 3:41 AM, NeilBrown wrote:
> 
> Since Linux v2.4 it has been possible to stop all NFS server by running
> 
>     rpc.nfsd 0
> 
> i.e.  by requesting that zero threads be running.  This is preferred as
> it doesn't risk killing some other process which happens to be called
> "nfsd".
> 
> Since Linux v6.6 - and other stable kernels to which
> 
>    Commit: 390390240145 ("nfsd: don't allow nfsd threads to be
>    signalled.")
> 
> has been backported - sending a signal no longer works to stop nfs server
> threads.
> 
> This patch changes the nfsserver script to use "rpc.nfsd 0" to stop
> server threads.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>   .../nfs-utils/nfs-utils/nfsserver             | 28 +++----------------
>   1 file changed, 4 insertions(+), 24 deletions(-)
> 
> Resending with different From: address because first attempt was bounced
> as spam
> 
>    openembedded-core@lists.openembedded.org
>      host lb01.groups.io [45.79.81.153]
>      SMTP error from remote mail server after end of data:
>      500 This message has been flagged as spam.
> 
> 
> diff --git a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver b/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
> index cb6c1b4d08d8..99ec280b3594 100644
> --- a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
> +++ b/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
> @@ -89,34 +89,14 @@ start_nfsd(){
>   	start-stop-daemon --start --exec "$NFS_NFSD" -- "$@"
>   	echo done
>   }
> -delay_nfsd(){
> -	for delay in 0 1 2 3 4 5 6 7 8 9
> -	do
> -		if pidof nfsd >/dev/null
> -		then
> -			echo -n .
> -			sleep 1
> -		else
> -			return 0
> -		fi
> -	done
> -	return 1
> -}
>   stop_nfsd(){
> -	# WARNING: this kills any process with the executable
> -	# name 'nfsd'.
>   	echo -n 'stopping nfsd: '
> -	start-stop-daemon --stop --quiet --signal 1 --name nfsd
> -	if delay_nfsd || {
> -		echo failed
> -		echo ' using signal 9: '
> -		start-stop-daemon --stop --quiet --signal 9 --name nfsd
> -		delay_nfsd
> -	}
> +	$NFS_NFSD 0
> +	if pidof nfsd
>   	then
> -		echo done
> -	else
>   		echo failed
> +	else
> +		echo done
>   	fi
>   }
>   
Is this suppose to apply to the Linux nfs-utils upstream repo?

A bit confused...

steved.


