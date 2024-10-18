Return-Path: <linux-nfs+bounces-7271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326169A3EE8
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 14:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC14D2818BB
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362A1DA3D;
	Fri, 18 Oct 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avHNGCDE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A2F9DF
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256039; cv=none; b=ANHOhxv6D+gbJ9ItCpkC/hKCqaaj5N/cXgvptAyrNOKNBOJ5uus+u0jqscmqrfxMItyqrYyrBZRQJvMwGJgohe/pAYNUeJsm97EIwl93DGkHspciv+iVMRrI+s+cf0gESU4Jgrix79GsXRanfnQO6yyxILz+B6eSM8ri1w1yeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256039; c=relaxed/simple;
	bh=1S/Gx46M2QuDK9FimqVrWZAdEe9Jc9zvatG8nSjVJBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quYInHpj+JXag5RxeDlVvGRkUpvY9wzUJtulSFWrBdB02EnS0smNcKYG7QSRYjaAHGfWRg+eE2sLSwIBgrGuVPhaVOHNuB4qIKtGdCXu7eSews/8IKa2/eT7Lj4XsfzMhKDZ3reS6q10dycOsp1yM64Cx8RXDQkxbf32gwbIosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avHNGCDE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729256036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1qUZ8sx8Ke/Xn9RlfjfwlljgzGUo6bLUSGT74E4MHw=;
	b=avHNGCDEZsOwK9xdkKWOS37iBRAAhrxKOhijQdKOTJLEGmVmBSdK4wzOixNL4xhXjuUY1g
	a6z040kn8220odvYqkI6pWYHUCj9hT0icJUTYPI+bfDrZ5l6mr++CblIQtuR4ZNvDXYU8q
	PzF3jGcDLI8WhDHcyuBPTr2xEvLiG40=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-a8YRgyxjNw6JA4mYns3NaA-1; Fri, 18 Oct 2024 08:53:55 -0400
X-MC-Unique: a8YRgyxjNw6JA4mYns3NaA-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-50d385a8f9fso541335e0c.0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 05:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729256034; x=1729860834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1qUZ8sx8Ke/Xn9RlfjfwlljgzGUo6bLUSGT74E4MHw=;
        b=qMZirBzR+PKCHytnls3MG5L8DRV8PH3WPrhP8Aw+weIT8UF4L/i/mu6nzQm/71ev0x
         8u8g+9R73VrdOYNVMoc8DP0QfHAShXPK6gTDmtACcoDyfmS+McI+kiijXrxbUbYaq8m3
         Cp+M0IHj1W7AQEAPb2txd+x0PWQ6fmp7ktO958fYgJH21c+lAOXbL4DKc4Aq7kqxeDoy
         6GJJse2Gkg08v08r9R5yN0Gp4Oimad/jRuEDa0qB61Pr9chT1cwAuDS9uJ1rTs5P/em4
         Wg8HDsHRr0m/nxehLdgWqlUHJ/Nyz7lkGZgzLmMFF5GFVtgtPKOQLnlZitG0g+tRx+v2
         Ergw==
X-Gm-Message-State: AOJu0YyD72iYIKRElYtzmhQkyehLvWU1eoKgXruYZZ4lO+Jfb+EETI+c
	wXatGfSFjCgMGafITBnX/k5cIkSlXnA64vy+OBTc4+B6pplTOD58hQ5sR/CjkKsqsShqzcTMwtc
	HWajhaQp4jPXFWT8pho17KtOpVsPH/rEBFElbAinzxurDeJfSAseBftGvb7KXctC8EA==
X-Received: by 2002:a05:6122:2209:b0:50d:8248:83bf with SMTP id 71dfb90a1353d-50dda41d9eemr2416230e0c.9.1729256033896;
        Fri, 18 Oct 2024 05:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE44t2wSl4NpengWvgOfWMtVn0tW3jIaeJBoUWpKP25D7qcqHfcTztoiWC3rr3u5ROtK+H/WQ==
X-Received: by 2002:a05:6122:2209:b0:50d:8248:83bf with SMTP id 71dfb90a1353d-50dda41d9eemr2416212e0c.9.1729256033624;
        Fri, 18 Oct 2024 05:53:53 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.130.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fe59c7sm66079985a.84.2024.10.18.05.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 05:53:53 -0700 (PDT)
Message-ID: <be898dc6-f0b3-4c2d-836c-6bf2a1ecb16b@redhat.com>
Date: Fri, 18 Oct 2024 08:53:51 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsdcld: prevent from accessing /var/lib/nfs/nfsdcld in
 read-only file system during boot
To: "Seiichi Ikarashi (Fujitsu)" <s.ikarashi@fujitsu.com>
Cc: "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>
References: <OSZPR01MB7772A2EBF4EE02460E546CDB88402@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <OSZPR01MB7772A2EBF4EE02460E546CDB88402@OSZPR01MB7772.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/24 6:47 AM, Seiichi Ikarashi (Fujitsu) wrote:
> I saw a VMWare guest that hit a rare condition during boot;
> nfsdcld started too early to check access on /var/lib/nfs/nfsdcld which were
> still in read-only file system as follows:
> 
>    nfsdcld[...]: Unexpected error when checking access on /var/lib/nfs/nfsdcld: Read-only file system
>    systemd[1]: nfsdcld.service: Main process exited, code=exited, status=226/NAMESPACE
>    systemd[1]: nfsdcld.service: Failed with result 'exit-code'.
> 
> nfsdcld.service needs to wait the root file system to be remounted at least.
> 
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
Committed...

steved.
> ---
>   systemd/nfsdcld.service | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/systemd/nfsdcld.service b/systemd/nfsdcld.service
> index 3ced565..188123d 100644
> --- a/systemd/nfsdcld.service
> +++ b/systemd/nfsdcld.service
> @@ -4,7 +4,7 @@ Documentation=man:nfsdcld(8)
>   DefaultDependencies=no
>   Conflicts=umount.target
>   Requires=rpc_pipefs.target proc-fs-nfsd.mount
> -After=rpc_pipefs.target proc-fs-nfsd.mount
> +After=rpc_pipefs.target proc-fs-nfsd.mount systemd-remount-fs.service
>   
>   [Service]
>   Type=forking
> 


