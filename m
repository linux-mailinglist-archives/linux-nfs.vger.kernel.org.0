Return-Path: <linux-nfs+bounces-9237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DF4A129E3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 18:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B566F3A3CF9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AD161311;
	Wed, 15 Jan 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxwW0o4S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6F24A7ED
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962382; cv=none; b=QThrRdAO58yrfLpQyvks8uwajbAd2UZQuepWT/3Gncx6mutPoWJuguWyl4nM9g9AFo+W8f/PsN5ZuEMG48fZG1KQ1GawW605vr44Vy6HesgaKiaQ7ohAj/EjYozWDWu85OYWKuKYIzwUNIf8gCTAgbOs7H5xd+wf9oRMrU3HF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962382; c=relaxed/simple;
	bh=llU4UnxPbpoNlSDZZEvy9jyfMW+QVmLKPec/hprSNQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMtNbi6XTley1RqM2zYjR++ksDTBBdlhIVMw6Gw2dA3n9gQvHfAl/ZvLsh957U/B6C2HP0FhKEA3oLdFj7DMS91ho5bFPBe2m4Cw0MLTBcsC2TvB9qkciXNjtahRUqQw/GygXZaSnsoExuRxGtAOyiJBMKLEy58iD6noGI12cvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxwW0o4S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736962379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pL0/CHoCZbKDSmQ8jjEkP3dJz0FVx9LcxtVVe/FnwOg=;
	b=OxwW0o4SBlYAUkIfB9uDgjHenbXlH4bSgUT5vNV7Zp80s28cPvHu25pOIb5b7NU8QaUy4x
	RsK5AeAJG+4wViiFvj6nDSNS/0/uoTrcyqEDMG3AeNuKyAq1UzhBgy0IvsbsPuySEjFZO5
	UMTXfF2PGsRPB1WXASfACr8V7kW3Z1o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-RCInZt6kOI64eHeW5D7KXQ-1; Wed, 15 Jan 2025 12:32:58 -0500
X-MC-Unique: RCInZt6kOI64eHeW5D7KXQ-1
X-Mimecast-MFC-AGG-ID: RCInZt6kOI64eHeW5D7KXQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso110770a91.2
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 09:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962376; x=1737567176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pL0/CHoCZbKDSmQ8jjEkP3dJz0FVx9LcxtVVe/FnwOg=;
        b=nZ/e4ym9IkibCMXW5hAz477Zgm49VRUiJdKofvjemBEgNTYJ/Eitc/8mX4vf91NagL
         o6uobhQqrDJVRvSfzrCAjHCiN3m4B92AJt3eo3KT687oCcqwAEYihh7jpk0wYc9docAZ
         bFvC8SGYYGGEbw6hKwvTBnfYWxULMcZwe+6AiFGpfAqmkqiaYhtpL6kYP98S8hNG82KR
         8YsP5LXgabqkpBXe+n7OnGsMe6WW/mUT+MrTlOEN0DDxfZzOCHahNWlYL/6Ux649deeD
         g8KzfFEeburkDbxICBCRkEpDSsjl4pBjkMDUkDjw29ntas1Q6hJudhr6rozOfn0knOY+
         AgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6FRLySjLXD6D74FSCN2dwnlph5qbRiIj+wp2E1CuP0eZaK+quYpK+RHcgmJOCg44Im4ZBPE73+G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz908MwD/dEe/Z125TjilB8Lvk/Tyd++2aqdZ65NSEXoru516Dx
	EQIH/Vd4ijHrwp0a9tRhPrMCKIRUTSPrynnE7/ykLmaiWvTZcMxNuS4kbvTmEgO/Jme698QCmVk
	n8Xrl6G5pgn7jGmZkCdzY4ktQmdZ+GjOPngxNPtsEbgE9OdnRF6yIaJ/4wI2E7D35GQ==
X-Gm-Gg: ASbGnctyPCdvnRYrTorXmHV44lFQ6z+tFaef0Ta+YYk8mHAPTLlB7NVPOV676HOYxab
	OX/cjOTSXlasJNfOnpki4ZmHynUCDVNnTDCBMRpwd1jJh1SSmR+1dRow40B02NkJjVpPncysMph
	oLXEIYcE+VWcWtog0RjtcxBQPWXHLt1j0lI4qirpaMMh2pki91zm08DitX2HD5LSIPU4UIeRrEH
	4pVlR9noTyg2rmn20bXAGTJ1bIpF+GQdu7nM/D6JmRuMwSba7BtensJ
X-Received: by 2002:a17:90b:4ec8:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-2f548e9a78bmr42651871a91.8.1736962376390;
        Wed, 15 Jan 2025 09:32:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAhhckq7K+KKO4Fyd19XwGf0hj/j8agrpH4bI5VNLl8rXEfRmkSuSRYv9D6Q6ZfcWkwUv9vw==
X-Received: by 2002:a17:90b:4ec8:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-2f548e9a78bmr42651847a91.8.1736962376049;
        Wed, 15 Jan 2025 09:32:56 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c22b474sm1636262a91.44.2025.01.15.09.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 09:32:55 -0800 (PST)
Message-ID: <590522bf-77f6-4e31-a2fb-5613f68c87da@redhat.com>
Date: Wed, 15 Jan 2025 12:32:53 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdctl: debug logging fixups
To: Scott Mayhew <smayhew@redhat.com>
Cc: jlayton@kernel.org, yoyang@redhat.com, linux-nfs@vger.kernel.org
References: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
 <20250115170051.8947-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250115170051.8947-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/25 12:00 PM, Scott Mayhew wrote:
> Move read_nfsd_conf() out of autostart_func() and into main().  Remove
> hard-coded NFSD_FAMILY_NAME in the first error message in
> netlink_msg_alloc() and make the error messages in netlink_msg_alloc()
> more descriptive/unique.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> SteveD - this would go on top of Jeff's "nfsdctl: add support for new
> lockd configuration interface" patches.
Got it...

> 
>   utils/nfsdctl/nfsdctl.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 003daba5..f81c78ae 100644
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
> @@ -1509,8 +1509,6 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>   		}
>   	}
>   
> -	read_nfsd_conf();
> -
>   	grace = conf_get_num("nfsd", "grace-time", 0);
>   	ret = lockd_configure(sock, grace);
>   	if (ret) {
> @@ -1728,6 +1726,8 @@ int main(int argc, char **argv)
>   	xlog_syslog(0);
>   	xlog_stderr(1);
>   
> +	read_nfsd_conf();
> +
>   	/* Parse the preliminary options */
>   	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
>   		switch (opt) {
Ok... at this point we a prettier error message
$ nfsdctl nlm
nfsdctl: failed to resolve lockd generic netlink family

But the point of this argument is:

Get information about NLM (lockd) settings in the current net
namespace. This subcommand takes no arguments.

How is that giving information from the running lockd?

What am I missing??

steved.


