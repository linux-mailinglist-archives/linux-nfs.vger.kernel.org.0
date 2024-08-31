Return-Path: <linux-nfs+bounces-6073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75EE9672E4
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9529D282E57
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Aug 2024 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23785339A1;
	Sat, 31 Aug 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTPTkOBs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AF10A3D
	for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725126966; cv=none; b=hPw/HzIgK37qdxZ/cLgFf1t3Pvtt5dAZ6vz30sJeYo2urzyAprs6x3KLaFJ0t3VA6kSu9KXEsJuA+KkRw2OJTzEmZpsDL863Xr3QNO9qrok24s4vP3+ZpFLa0uE4+1dsV2v/SRJSnbuMDB+wt8CwGkm+h5a7eVpS4UcTYMLmmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725126966; c=relaxed/simple;
	bh=Im5z1NlQtyI0ERAXTstjADWpeZ7w0LEW/I/ec0eVmwg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U49ixQC/25Lo+1K8cLCbhvMV2BeQLTXust7Q5O3U/0TddhVhEY4O6tt0TlW727yp7dq31jYyVJoApvvV7YW+jVUcpGTek197stAWXv0Z7fxi2dlF2OlAk3y9iQ7W4VVUxn8IRaPpYCffz46ubN81Y22vhtMyFVUBMoMbo/mkj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTPTkOBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725126963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THtXeAKtnFdpEqOhuqfNl/pqNs0tyM0EzKf3w8sXYk8=;
	b=BTPTkOBs6a//aJ6MUEDw88gQBcRLs4tES6t3GACqL6dqSUiBatyKLGePy+G8uJseWegUWk
	0abLfeXtrm1N48J8whmK3Sab4FylSdgG74+k+h7peFw4VUBNtR5DVnZ4tqJnGW9vZMtTzd
	8pnFlrjayBuhO8LxWMI1OqUp4OZnCPY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-toMbXbZpMViXO_YIsN00sw-1; Sat, 31 Aug 2024 13:56:01 -0400
X-MC-Unique: toMbXbZpMViXO_YIsN00sw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-498e2521c72so1329979137.0
        for <linux-nfs@vger.kernel.org>; Sat, 31 Aug 2024 10:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725126960; x=1725731760;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THtXeAKtnFdpEqOhuqfNl/pqNs0tyM0EzKf3w8sXYk8=;
        b=DGxsDs3A6EpGLwLVW02WOhqd5H1dYRiXK/fHBdgV7DcVxhLaa5JnIcOytiLo5ri/Cn
         d8u8hGESv1pH7iO9i2RbhcrrMPsqATSsOE3xl4RERwgSQ+eUm2lGwjD315FG4dddtAP2
         /UFm+hBw2PxrLu7SLi6BIzLDLOAEN8j13Ch9OgmjkjS2Thqf1t7R4aQKu8OwOuUpf+6z
         qRGMACzwv026OxtxE+FwT3HTIFezB4zlZfEIY7HCnHKySHL01m17oddM/euXllbpXPE/
         iJHx7ckkBYjghpm9f83YcTSrYWMS02St2foLIa1yWw7lKINQkFhMy8xPmR9aC6Ms1z25
         NkMQ==
X-Gm-Message-State: AOJu0Yzo65O+X85teqfRvKmZKlqknU3foRD5QuhkAqYoNF18HOtPZWKd
	h62kOB5sdMPb+SqTmAPug6q+tkvbXl1Ye0HjG1yrbJ3IqOU64wZx3zA0rOGjBBA+MkL6shmHsLk
	58+8KXSO2fCcXgsx1i4dUQL/Q+MKJw8EeqK8/hvzfY7c43FMqiO1B8uO5CA==
X-Received: by 2002:a05:6102:1614:b0:498:e406:b25e with SMTP id ada2fe7eead31-49a7783c77cmr3799759137.22.1725126960371;
        Sat, 31 Aug 2024 10:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT01oSPoRyw715fofWaO2L9i7Aaft9JzKZamrbG1CmhMP1Qc8badcVWhVdJnBM+I220/AL0Q==
X-Received: by 2002:a05:6102:1614:b0:498:e406:b25e with SMTP id ada2fe7eead31-49a7783c77cmr3799744137.22.1725126959961;
        Sat, 31 Aug 2024 10:55:59 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c26ebasm259980985a.36.2024.08.31.10.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 10:55:59 -0700 (PDT)
Message-ID: <8596f90a-5013-46bc-9a26-68d4f24143a5@redhat.com>
Date: Sat, 31 Aug 2024 13:55:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Move rpbind's default configuration to /run verses
 /var/run
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20240831154425.59200-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20240831154425.59200-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/24 11:44 AM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: rpcbind-1_2_8-rc1)

steved.
> ---
>   configure.ac     | 4 ++--
>   man/rpcbind-fr.8 | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 8f4cef3..cbbc172 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -32,8 +32,8 @@ AC_ARG_ENABLE([rmtcalls],
>   AM_CONDITIONAL(RMTCALLS, test x$enable_rmtcalls = xyes)
>   
>   AC_ARG_WITH([statedir],
> -  AS_HELP_STRING([--with-statedir=ARG], [use ARG as state dir @<:@default=/var/run/rpcbind@:>@])
> -  ,, [with_statedir=/var/run/rpcbind])
> +  AS_HELP_STRING([--with-statedir=ARG], [use ARG as state dir @<:@default=/run/rpcbind@:>@])
> +  ,, [with_statedir=/run/rpcbind])
>   AC_SUBST([statedir], [$with_statedir])
>   
>   AC_ARG_WITH([rpcuser],
> diff --git a/man/rpcbind-fr.8 b/man/rpcbind-fr.8
> index 7db39e7..711acdd 100644
> --- a/man/rpcbind-fr.8
> +++ b/man/rpcbind-fr.8
> @@ -138,8 +138,8 @@ est red
>   .Xr rpcbind 3 ,
>   .Xr rpcinfo 8
>   .Sh FILES
> -.Bl -tag -width /var/run/rpcbind.sock -compact
> -.It Pa /var/run/rpcbind.sock
> +.Bl -tag -width /run/rpcbind.sock -compact
> +.It Pa /run/rpcbind.sock
>   .Sh TRADUCTION
>   Aurelien CHARBON (Sept 2003)
>   .El


