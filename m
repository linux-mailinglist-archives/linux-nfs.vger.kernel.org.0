Return-Path: <linux-nfs+bounces-10779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE79A6E453
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E41166D01
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F019408C;
	Mon, 24 Mar 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSP2f0OU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9141C8611
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848064; cv=none; b=svppHjhbOGmHFBUkwJcxXasPYX45uGXEUQVHvdp7/j2+f/3XbbA5mcrRFJckojfoT76i+6nQBxmTn2co8o5tH+IY7pkMQLF+xfw9lw9rhjf9kknEgAnb09vPoim6mbOme/NOcIH+6wVka0ZkdZd7MNT+xJGAj7jtqPuy0opAHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848064; c=relaxed/simple;
	bh=hsCUW043pp4vxc0KHl9U/0FOYagEbRvP/RbbRpynUZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwEhmtGwmV8y3YtmYu5SkPd1ozi0/eqHkhak7PWxFqkz5fsbrFeV43EBA7wweogQc4/BPFcxIQAnHdNtYsvP/SZIYXK6Y3OVATzKVoda37DBEvySky/ahp+ffRebeWIoqmvr1Whm6EvW39pukW3YCUcnCoiVHe8FBrt66v4hMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSP2f0OU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742848061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ToOU1NR3gGhEsuIre2t/4dAiHV0vCN6UFD9hahlVZ3M=;
	b=eSP2f0OUhcMBAZobr+3Lm3yOEGffjpaf98BTtMUrB4Cy3nULmJL3/B9FVDDaNqlvAEcy3X
	VxxoBaLK4i1SuO9SlP9N2YCWoBt3ishHfq6pc1MaJ6Ai8ouqYpM+VpKWK0Xx/6/Dwe23xX
	QsIrBXzIz4qspCiEdO9Wak2vOGHBAhU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-cQLQ7BaqN1Wy-Vrtbpdlkg-1; Mon, 24 Mar 2025 16:27:40 -0400
X-MC-Unique: cQLQ7BaqN1Wy-Vrtbpdlkg-1
X-Mimecast-MFC-AGG-ID: cQLQ7BaqN1Wy-Vrtbpdlkg_1742848059
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5d608e703so160637685a.3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 13:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742848059; x=1743452859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToOU1NR3gGhEsuIre2t/4dAiHV0vCN6UFD9hahlVZ3M=;
        b=RB9Q5W/ONqE33UnqIzWj2BYnFOKyjKt9pea8PDFIt3QnY7ap/yjAQtczX61UmB+dIO
         yIwWTddljS8WfgjYWmwl4aENAjpnd+i/kAD4wqI+LPf6Tb81DX2wFdMOFk5wMJ3Th0Eo
         XRgno9nPRi3bhM5un5m/bRhgFIc3lpztId09yzfQ2/li99XoS62tfLtyoAjZjYs8gY1g
         4DPJzjVi8VtIiRbf9luMhKbA0ABeIqcbzImgl7j9785+4az/eCSytqvQBNFyJP6jmR0e
         vmqhs2gKZBlby+A8WPYK8ULD989ywIk9DfH+mvL6FusZb5CHbEzXx9u7SYhEc63caDa3
         qLPw==
X-Forwarded-Encrypted: i=1; AJvYcCWWe/eFo+OzGVkxu8v4p2+Ubq2bDg88LISdTybP38ALVvSadCBvSVO1etKaNI8qDBN+r3EQQpcfmn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4MTYqYteL6K1WoVEKWCxlwtYrGhBydK3da+V5g6N5g9DaFkY
	pEUa/hOJfVW04JqkEZl+bn0GHI91b6Ttm4HMJpBUcitofdtxPubnPKnEj/t18KSugDB8GSnT8NV
	EzPSBoXnYiqYKo0m4VFvuBRdyod2bC05cQdH+VYFMI9u2yQDrhwq1j32WOw==
X-Gm-Gg: ASbGncv9YZWqILA0fKHjccCmTns51wHhixS+VJZmsQdq7BHkKE0M0m4b/3KrZwi0iJ1
	a96tYo6Yjz3XnUwhzeGPm3ZqGuXh1dZIyWwTW463KXmf1Vlbou/PZzoTi47ITkWuHpmNtkb+pG9
	2YtmKNxEixHzND01RBAJ4xJBszAez0Whrzas6snVMT8YgSSNIGiqT/mro2ukAmhvpdkigpGi/UK
	vytUzZ5TaeKdeZ7TrQqTCRSQFYcT0kIASBnWeklt0Z+in4WX+uNlsxPlkl7dfuwKhCD+lEK0SFM
	G8hkqcoY+T6PJA4=
X-Received: by 2002:a05:620a:4409:b0:7c5:5003:81c4 with SMTP id af79cd13be357-7c5ba1ea03fmr2109378685a.44.1742848059151;
        Mon, 24 Mar 2025 13:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcq/JcjADh9cEyKFE2euPWy3ui6P91i7XAp+rf+83sgZ3d6r2sjMtef0rJv0y8bHfF10+KAg==
X-Received: by 2002:a05:620a:4409:b0:7c5:5003:81c4 with SMTP id af79cd13be357-7c5ba1ea03fmr2109374785a.44.1742848058710;
        Mon, 24 Mar 2025 13:27:38 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92cfe65sm551696085a.28.2025.03.24.13.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:27:38 -0700 (PDT)
Message-ID: <9fbd3385-1011-4a50-9def-8f367400abc7@redhat.com>
Date: Mon, 24 Mar 2025 16:27:36 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] nfsdcld: fix cld pipe read size
To: zhangjian <zhangjian496@huawei.com>, sorenson@redhat.com,
 s.ikarashi@fujitsu.com, jlayton@kernel.org, smayhew@redhat.com
Cc: lilingfeng3@huawei.com, linux-nfs@vger.kernel.org
References: <20250306000008.721274-1-zhangjian496@huawei.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250306000008.721274-1-zhangjian496@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/25 7:00 PM, zhangjian wrote:
> When nfsd inits failed for detecting cld version in
> nfsd4_client_tracking_init, kernel may assume nfsdcld support version 1
> message format and try to upcall with v1 message size to nfsdcld.
> There exists one error case in the following process, causeing nfsd
> hunging for nfsdcld replay:
> 
> kernel write to pipe->msgs (v1 msg length)
>      |--------- first msg --------|-------- second message -------|
> 
> nfsdcld read from pipe->msgs (v2 msg length)
>      |------------ first msg --------------|---second message-----|
>      |  valid message             | ignore |     wrong message    |
> 
> When two nfsd kernel thread add two upcall messages to cld pipe with v1
> version cld_msg (size == 1034) concurrently，but nfsdcld reads with v2
> version size(size == 1067), 33 bytes of the second message will be read
> and merged with first message. The 33 bytes in second message will be
> ignored. Nfsdcld will then read 1001 bytes in second message, which cause
> FATAL in cld_messaged_size checking. Nfsd kernel thread will hang for
> it forever until nfs server restarts.
> 
> Signed-off-by: zhangjian <zhangjian496@huawei.com>
> Reviewed-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-3-rc8)

steved.
> ---
>   utils/nfsdcld/nfsdcld.c | 65 ++++++++++++++++++++++++++++-------------
>   1 file changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
> index dbc7a57..f7737d9 100644
> --- a/utils/nfsdcld/nfsdcld.c
> +++ b/utils/nfsdcld/nfsdcld.c
> @@ -716,35 +716,60 @@ reply:
>   	}
>   }
>   
> -static void
> -cldcb(int UNUSED(fd), short which, void *data)
> +static int
> +cld_pipe_read_msg(struct cld_client *clnt)
>   {
> -	ssize_t len;
> -	struct cld_client *clnt = data;
> -#if UPCALL_VERSION >= 2
> -	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
> -#else
> -	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
> -#endif
> +	ssize_t len, left_len;
> +	ssize_t hdr_len = sizeof(struct cld_msg_hdr);
> +	struct cld_msg_hdr *hdr = (struct cld_msg_hdr *)&clnt->cl_u;
>   
> -	if (which != EV_READ)
> -		goto out;
> +	len = atomicio(read, clnt->cl_fd, hdr, hdr_len);
>   
> -	len = atomicio(read, clnt->cl_fd, cmsg, sizeof(*cmsg));
>   	if (len <= 0) {
>   		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
> -		cld_pipe_open(clnt);
> -		goto out;
> +		goto fail_read;
>   	}
>   
> -	if (cmsg->cm_vers > UPCALL_VERSION) {
> +	switch (hdr->cm_vers) {
> +	case 1:
> +		left_len = sizeof(struct cld_msg) - hdr_len;
> +		break;
> +	case 2:
> +		left_len = sizeof(struct cld_msg_v2) - hdr_len;
> +		break;
> +	default:
>   		xlog(L_ERROR, "%s: unsupported upcall version: %hu",
> -				__func__, cmsg->cm_vers);
> -		cld_pipe_open(clnt);
> -		goto out;
> +			__func__, hdr->cm_vers);
> +		goto fail_read;
>   	}
>   
> -	switch(cmsg->cm_cmd) {
> +	len = atomicio(read, clnt->cl_fd, hdr + 1, left_len);
> +
> +	if (len <= 0) {
> +		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
> +		goto fail_read;
> +	}
> +
> +	return 0;
> +
> +fail_read:
> +	cld_pipe_open(clnt);
> +	return -1;
> +}
> +
> +static void
> +cldcb(int UNUSED(fd), short which, void *data)
> +{
> +	struct cld_client *clnt = data;
> +	struct cld_msg_hdr *hdr = (struct cld_msg_hdr *)&clnt->cl_u;
> +
> +	if (which != EV_READ)
> +		goto out;
> +
> +	if (cld_pipe_read_msg(clnt) < 0)
> +		goto out;
> +
> +	switch (hdr->cm_cmd) {
>   	case Cld_Create:
>   		cld_create(clnt);
>   		break;
> @@ -765,7 +790,7 @@ cldcb(int UNUSED(fd), short which, void *data)
>   		break;
>   	default:
>   		xlog(L_WARNING, "%s: command %u is not yet implemented",
> -				__func__, cmsg->cm_cmd);
> +				__func__, hdr->cm_cmd);
>   		cld_not_implemented(clnt);
>   	}
>   out:


