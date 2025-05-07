Return-Path: <linux-nfs+bounces-11575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80CAAE289
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A1C1890EE8
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748528A3E2;
	Wed,  7 May 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNMxowgs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F300288CB0
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627196; cv=none; b=l7fFnPt7gFytq1fAfgaIZZnxtUFSgo0fO2SckQ7c9W9s0mxtsvg26OLJIujlaYnPuitd/VK1nLA5cceeID5sWVqV1Da91Anmv7baOwTtumAsR1GkQSs+FOshpdVS9z64qnngnfY0GXnLPJaMJXc4jNJqf+oZO2GXzW8mjQNLZ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627196; c=relaxed/simple;
	bh=Jk0qEzDf1GgKYwkfyw7T8SweoARv3jqNsIPTL25Xlvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5vwx1r+KXcPeYvUWvGWx0YjUUHEBRbBVlC9UTTJboOqgIQsS695yZ+GM00FexJLAoz6pJyha1if1zMbzcgWWDLpjE76wUMipfdUCpaE9d/OJ25kFUFZJ4pI2wbzvn9okBG72MLvA28NrK2WzFDJxkWQs8rlN7z23boab/BqIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNMxowgs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746627193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGsxMPNFY/8K6ozV9e5VgY7BfLsaWCsWB2r4xmnleeI=;
	b=VNMxowgseoM5zq5Vcdij9g0T8u2t43Cs5y9BtY945lCFYXneOeMg6mW42a+7SOwfRSCHqH
	q+RVS90G1eKapRRGU9MRR6P99XsZB0S99im04i+1B2rSyPRS1IIrvFAjAIfajBVsjcvNWu
	i8KtDb5S2yt/UgDxo3bkaOH1a5X/fTk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-hzdebZAUM_S6XUnedVENvQ-1; Wed, 07 May 2025 10:13:12 -0400
X-MC-Unique: hzdebZAUM_S6XUnedVENvQ-1
X-Mimecast-MFC-AGG-ID: hzdebZAUM_S6XUnedVENvQ_1746627192
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91d8a7165so116943886d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 07:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746627191; x=1747231991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGsxMPNFY/8K6ozV9e5VgY7BfLsaWCsWB2r4xmnleeI=;
        b=Unmyxu6HsFh5ILcXuTuN5jYBttJ/+ga/t4SJNBZnUcLwfGGHYCYoUDpaoRy0B7O9Kl
         41tUrxpJoo6pyme9X5JdEQ+rJJSPPINW0siK+EFgBue4bMVvozyRyEsQkRN/bfCd1dch
         4YbRpZibOjGnoiPAmlVJiVa0M4EWQmr8XKnIGbkIf4y/tU7ER7cPG1XRBSdWFv7GyrAq
         WGDN6RCLj0zUBArLCSmjCdrCLWmNZ6vXa6F39oSIzN2DoglBG9ZgCsxnqG+5rDUhqnFJ
         1dFKhEFL6HgDO6sDrxcxwc12WVwG40k9hXlAXkIhok/plRdh+YK4vkptc6knRVXBiSWw
         25ww==
X-Forwarded-Encrypted: i=1; AJvYcCUViiKpK8BNU2Xbe650MD7vYuhOomWUrF2SJaI3uUlpwmJw4OLRhbX5JUHtciMOklTIqjytTBn4zaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyShux+7e0cT8jfNoSO8Dm1B6+NI+/CCp00hItV5VXxwvMxIml
	S6KgjwuqoNfsU2pvRcO/1c895eWPC+IuPMAGCdonwLdPJZv+eQy4/OwyhL2ras7vZbuDZhhU7fz
	g8dsfBC5EH+EZa/6BJW0shjWXthfHKiVGfDnTCGmfaMItGP166A2ztXzLyO1TxMxITQ==
X-Gm-Gg: ASbGncupMRozHhMsEfSdCz5DKGjpADe4kAQxDDqahRladenWGGVqPqWMd2VWe9Ls2Do
	MTuLrEusyOEWlaYTIr+qpNCzPVIUb2AGoWMgUFcz+m7JhJ7En6Q/VUQpZZCq0g5zpdkiZaNF6gx
	oyg3BA7rKL8EVrfsvGMUh1fXhZtrlp07zWEBgTY5TFeiARgtnzi0JovGZ8UyHIY4eGd53qgBFZ/
	aHjjuKqsxNpt46Z6fXU6/2VBq8r/s98/hJI4TOukqAYGoveDFGeWIUUnnae36dJNk8hCPOsDVVH
	Pg3PAE7JMQ==
X-Received: by 2002:a05:6214:5283:b0:6f2:d4ed:c549 with SMTP id 6a1803df08f44-6f542a15924mr54532896d6.20.1746627190915;
        Wed, 07 May 2025 07:13:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCJD+DyySP2J4ccHy+95BIdyVandAJJ4iz/BOFnE0bZvCJ9Bk9uic3/aGgL5pMMWaK/QCMuw==
X-Received: by 2002:a05:6214:5283:b0:6f2:d4ed:c549 with SMTP id 6a1803df08f44-6f542a15924mr54532326d6.20.1746627190335;
        Wed, 07 May 2025 07:13:10 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.247.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f54268da00sm14341416d6.56.2025.05.07.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 07:13:09 -0700 (PDT)
Message-ID: <1729e6c6-4299-4cdc-9129-2a848ed8b562@redhat.com>
Date: Wed, 7 May 2025 10:13:07 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH v2] nfsdctl: debug logging fixups
To: Scott Mayhew <smayhew@redhat.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <20250501121543.4181345-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250501121543.4181345-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/1/25 8:15 AM, Scott Mayhew wrote:
> Move read_nfsd_conf() out of autostart_func() and into main() so we
> don't lose any messages.  Remove hard-coded NFSD_FAMILY_NAME in the
> first error message in netlink_msg_alloc() so the error message has the
> correct family and make both error messages in netlink_msg_alloc()
> more descriptive/unique.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> SteveD - the original patch was supposed to go on top of Jeff's
> "nfsdctl: add support for new lockd configuration interface" patches,
> but seems to have gotten lost in the shuffle.  The v2 patch is the same,
> I've just reworded the commit message a bit.
Not sure what you are talking about... Those nlm patches went in
a while ago... What am I missing?

Committed... (tag: nfs-utils-2-8-4-rc1)

steved.

> 
>   utils/nfsdctl/nfsdctl.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 733756a9..1fdbb44d 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -436,7 +436,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>   
>   	id = genl_ctrl_resolve(sock, family);
>   	if (id < 0) {
> -		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
> +		xlog(L_ERROR, "failed to resolve %s generic netlink family", family);
>   		return NULL;
>   	}
>   
> @@ -447,7 +447,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>   	}
>   
>   	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
> -		xlog(L_ERROR, "failed to allocate netlink message");
> +		xlog(L_ERROR, "failed to add generic netlink headers to netlink message");
>   		nlmsg_free(msg);
>   		return NULL;
>   	}
> @@ -1592,8 +1592,6 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>   		}
>   	}
>   
> -	read_nfsd_conf();
> -
>   	grace = conf_get_num("nfsd", "grace-time", 0);
>   	ret = lockd_configure(sock, grace);
>   	if (ret) {
> @@ -1824,6 +1822,8 @@ int main(int argc, char **argv)
>   	xlog_syslog(0);
>   	xlog_stderr(1);
>   
> +	read_nfsd_conf();
> +
>   	/* Parse the preliminary options */
>   	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
>   		switch (opt) {


