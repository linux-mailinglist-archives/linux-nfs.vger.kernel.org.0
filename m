Return-Path: <linux-nfs+bounces-388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D0B8091A9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 20:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71F328161A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Dec 2023 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066E4F895;
	Thu,  7 Dec 2023 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2b3Jk3u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B611D
	for <linux-nfs@vger.kernel.org>; Thu,  7 Dec 2023 11:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701978168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9wSbpx+M9nfSVkJ8nUm3N4CRnQpMzJcOW4ZgkTJT48=;
	b=U2b3Jk3uWKqwySBcMlpzCShzk/tFGVN4rvhbCb+P8d0CaOWnbhnPOzuAOOk3BzfyC6AY4P
	gfigAqRpj+3RE3yk5Bwa9x2abRHesynOvd5UbKb87mnW/RjxTv7wkxycaFjmVklK7CGz5K
	7LgyCzo23yAz8LeFLRB0d8YyTu4fhLw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-uCkMgoNbOry-hMUV_f4gIw-1; Thu, 07 Dec 2023 14:42:47 -0500
X-MC-Unique: uCkMgoNbOry-hMUV_f4gIw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a06b43afcso4073496d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 07 Dec 2023 11:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978166; x=1702582966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9wSbpx+M9nfSVkJ8nUm3N4CRnQpMzJcOW4ZgkTJT48=;
        b=qBdzPZgKV8KRiv0biMkTU5Jg8LXVvXLL2E5H/MVirWynE/CCdSGAspNE80BBqfBM+G
         xqvC3+6BrUj2aNWhe2KATl9gGT7deivKoA/uqiLJapb1XvCDZ8Kws6S4woNXeiQOxxL3
         /k4iIzjHABokBU1DpXnGve9E8uECc/0AKgoJtgkFabSCFPs8Nj/TpZT5t91THnsmftKL
         +O2I7Jmhx+UPkBZ5ItFevRSvPSAFb0cHf8rbwmB0t+hFEDgsIjGgCuI68bweT9hXMazb
         SVCb1qrlwewd4S2MAcvB8XLg6UgnFW5KnNclyU+M5NXWKcRpUSNV1Lm3gSjpCYkhQNNL
         MYEg==
X-Gm-Message-State: AOJu0YxXZPP4+l87aRvbGZipiv6l9Yw+9BRXSTqxdqDdX/k0eNwKupK+
	IXcAtwkL2twksNTbQeI1T/R5cThlGQCUw/VYwJ2kVcJkbWlvdCMCXC30LjRkKANL+MDg/Mhihe8
	NFsrBtJJKyeQkX8i9aSXL7MS4OYWH
X-Received: by 2002:a05:6214:17cf:b0:67e:a393:742 with SMTP id cu15-20020a05621417cf00b0067ea3930742mr1481737qvb.3.1701978166504;
        Thu, 07 Dec 2023 11:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWpol+vdQMzqu7ivF7Vql2ho+c+y40VOZKUp0dQwYVZnewLeDmihW/gVPS0NpbobEtfPFrgg==
X-Received: by 2002:a05:6214:17cf:b0:67e:a393:742 with SMTP id cu15-20020a05621417cf00b0067ea3930742mr1481723qvb.3.1701978166182;
        Thu, 07 Dec 2023 11:42:46 -0800 (PST)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z25-20020a0c8f19000000b0067a291f473esm156852qvd.68.2023.12.07.11.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:42:45 -0800 (PST)
Message-ID: <2c9be16b-012e-4438-a396-fd1050284310@redhat.com>
Date: Thu, 7 Dec 2023 14:42:45 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] autoconf: don't build nfsdcltrack by default
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20231127-master-v1-1-5786ec1c6d38@kernel.org>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20231127-master-v1-1-5786ec1c6d38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Jeff!

On 11/27/23 10:18 AM, Jeff Layton wrote:
> Now that we've started the process to remove legacy v4 client tracking
> methods, let's stop building nfsdcltrack by default.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   configure.ac | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 93a1202807ea..62c833cc2409 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -248,9 +248,9 @@ AC_ARG_ENABLE(nfsrahead,
>   	fi
>   
>   AC_ARG_ENABLE(nfsdcltrack,
> -	[AS_HELP_STRING([--disable-nfsdcltrack],[disable NFSv4 clientid tracking programs @<:@default=no@:>@])],
> +	[AS_HELP_STRING([--enable-nfsdcltrack],[enable NFSv4 clientid tracking programs @<:@default=no@:>@])],
>   	enable_nfsdcltrack=$enableval,
> -	enable_nfsdcltrack="yes")
> +	enable_nfsdcltrack="no")
>   
>   AC_ARG_ENABLE(nfsv4server,
>   	[AS_HELP_STRING([--enable-nfsv4server],[enable support for NFSv4 only server  @<:@default=no@:>@])],
> 
> ---
> base-commit: cc5cccbb9f24a2324f50a5cb4c29d83fdf6b1f90
> change-id: 20231127-master-5ef1c15da9c4
> 
> Best regards,
Quick Question... Should we remove the code or just
turn off the building as this patch does?

stesved.


