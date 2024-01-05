Return-Path: <linux-nfs+bounces-961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CB8258AD
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211551F238F0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jan 2024 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A246131725;
	Fri,  5 Jan 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BarOLeMD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1EB31735
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jan 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704473599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ytd45uO71Rv46mfN3hrVKfHtKcd+ZM6+RPB9wFYdfJc=;
	b=BarOLeMD/WkHtUNJYEnn2ujB1APe+by2ZlfkB+Ipzp2xIyJP/pKlnyTIOyFT5qtaAe/PCJ
	c0cpw3jj5T0kcCXr1U1DBUfLje6px8Q8WGQUouOenz7DJVW9Oeq8TYCxkUU98T3aqLbIEi
	z/d/mM7sfKx1E6xqpvmg50lJGxeZXB4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-xj_BrJRoPvuOWImYXtCe0w-1; Fri, 05 Jan 2024 11:53:17 -0500
X-MC-Unique: xj_BrJRoPvuOWImYXtCe0w-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bbbfe871afso568167b6e.1
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jan 2024 08:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704473597; x=1705078397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytd45uO71Rv46mfN3hrVKfHtKcd+ZM6+RPB9wFYdfJc=;
        b=WMTRy1LDDGR7HSRpCulvKEhTYiaXAlQVySp+kouQWlDeo/uR+Cfitm8divjteOVa/Z
         xTb5ZKqLTBZtBzWbPRslTODqgXbckOEQf1Zzgget5O+tXBRtwS668srwJDW2ljgPEyUY
         zz+pDbbJvSPotXANDsd42L0UJvMdTvMcJmu89SqKvZ8HpqnHV1oHn/Wb++gNO8r6JQFR
         LfqPn9iUNsx1EmYtM0y3LNCZ05ONvgjp+Qxc60Y58+1ZdK4KQS2gH37gTYMAtfHt+INi
         Byhrj5vjtcn8Y5Lbk2egWRgsizWWDnNXQscf5d13iSgk7BCyxqHp0VvYtZFCXMB7/q5e
         477g==
X-Gm-Message-State: AOJu0YywHYpOqEHQFB1yDmkhz9rM5zr6deT0d8MhsrfA8j4t9vHSX0Nc
	B6Qw9/kvM6lWej9RrAkjtMP7nXg+6Rnk8EwkdFkMPOoXTtmBT0DxRedCZE1vCvPp/2kL1dfcnln
	vuP6K8Xn6j7KtI54yExMCkkSlUZC5
X-Received: by 2002:a05:6808:1485:b0:3bc:314f:c5fb with SMTP id e5-20020a056808148500b003bc314fc5fbmr4745594oiw.3.1704473597060;
        Fri, 05 Jan 2024 08:53:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYDi+y9qlMZ9CXppLNNe/I+QYPVw+S5U4c12vqfa9EmvVE8Qky125H6DiiOmAU3Z5RIASWiw==
X-Received: by 2002:a05:6808:1485:b0:3bc:314f:c5fb with SMTP id e5-20020a056808148500b003bc314fc5fbmr4745581oiw.3.1704473596793;
        Fri, 05 Jan 2024 08:53:16 -0800 (PST)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cfb42000000b0067f0d8cf418sm728002qvq.70.2024.01.05.08.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 08:53:16 -0800 (PST)
Message-ID: <eb21b802-a988-44d2-bceb-448fc50496e6@redhat.com>
Date: Fri, 5 Jan 2024 11:53:16 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netconfig: remove tcp6, udp6 on --disable-ipv6
Content-Language: en-US
To: =?UTF-8?Q?J=C3=B6rg_Sommer?= <joerg.sommer@navimatix.de>,
 libtirpc-devel@lists.sourceforge.net
Cc: linux-nfs@vger.kernel.org
References: <077bbd32e8b7474dc5f153997732e1e6aec7fad6.1697120909.git.joerg.sommer@navimatix.de>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <077bbd32e8b7474dc5f153997732e1e6aec7fad6.1697120909.git.joerg.sommer@navimatix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/12/23 10:28 AM, Jörg Sommer wrote:
> If the configuration for IPv6 is disabled, the netconfig should not contain
> settings for tcp6 and udp6.
> 
> The test for the configure option didn't work, because it check the wrong
> variable.
> 
> Signed-off-by: Jörg Sommer <joerg.sommer@navimatix.de>
Committed... (tag: libtirpc-1-3-5-rc2)

steved.
> ---
>   configure.ac    | 2 +-
>   doc/Makefile.am | 5 +++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index fe6c517..b687f8d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -64,7 +64,7 @@ fi
>   AC_ARG_ENABLE(ipv6,
>   	[AC_HELP_STRING([--disable-ipv6], [Disable IPv6 support @<:@default=no@:>@])],
>   	[],[enable_ipv6=yes])
> -AM_CONDITIONAL(INET6, test "x$disable_ipv6" != xno)
> +AM_CONDITIONAL(INET6, test "x$enable_ipv6" != xno)
>   if test "x$enable_ipv6" != xno; then
>   	AC_DEFINE(INET6, 1, [Define to 1 if IPv6 is available])
>   fi
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index d42ab90..b9678f6 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -2,3 +2,8 @@ dist_sysconf_DATA	= netconfig bindresvport.blacklist
>   
>   CLEANFILES	       = cscope.* *~
>   DISTCLEANFILES	       = Makefile.in
> +
> +if ! INET6
> +install-exec-hook:
> +	$(SED) -i '/^tcp6\|^udp6/d' "$(DESTDIR)$(sysconfdir)"/netconfig
> +endif


