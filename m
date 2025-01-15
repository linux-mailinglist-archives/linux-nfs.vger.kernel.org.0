Return-Path: <linux-nfs+bounces-9221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5F8A123F9
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 13:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5335C168C8D
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0C2475D6;
	Wed, 15 Jan 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AddfHwwd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12DC2475ED
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736945335; cv=none; b=Zd20YccnMe0K/vb/JVOxWIQu+fooIzM6otxTgaoxaLiYs/fwup+/S+KUHND3S3A7gutpHoHRLBmS9CNPhvxd4JSM4gomWOHLxVsQGIwI4Go3ptmBpGxyMzAnSrcxvuezDiopA9aGsbsX0FoANG21C2cu2OV5Y7Do1QU8D/8H4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736945335; c=relaxed/simple;
	bh=OBBo91up06niEdXQz7Ogryh6u62hMnamKzJUNhCIbU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeVhcdD7X1RnfXrpqn0/G3fgn37SCOjCJLAgmm6YU4TPsyPkMa86NntUgNhVGvRE6FNv2ofY0dL4YGh69UmXc61l5Oe02FKKIC6wY9vgipaKHtTtijVNYlwS+qpMVn1WFBnx1PXi00znw+tG3perBwYbhrAeHDZg3Ct8WK+PhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AddfHwwd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736945333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/vbvkAS9JxlsrDb6kxTEmhM6JZCJMkyb4sGf5DOUww=;
	b=AddfHwwd+NSTKPsf+gsKE5hZIfobECZXQBalLybd5CayYr2TIQsNcJvUYlN+bXoDfkhSgW
	v/N9FLLvpbheVmBTn7CgNxdVdn1DfeIbuQ76tMsTX85sN7EAHfeG1Ipyo4jdd4EDhzKxff
	Vsn4LVlBihnkBg2XveszdE20W/2b4CQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-JGc05pSePKuuEnWyCUg8qQ-1; Wed, 15 Jan 2025 07:48:51 -0500
X-MC-Unique: JGc05pSePKuuEnWyCUg8qQ-1
X-Mimecast-MFC-AGG-ID: JGc05pSePKuuEnWyCUg8qQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso12185242a91.1
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 04:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736945330; x=1737550130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/vbvkAS9JxlsrDb6kxTEmhM6JZCJMkyb4sGf5DOUww=;
        b=h/7QwV4puy03IsRQaaTcw9yJkr9xsu2kxJBiAh7KU7VXG5+LAzzwYQwipt6WHUh8Bn
         oYx9Xf/xAT4vmHGW7n78QWhd+A2opqG+YiHsOhkMwvBG/LOzOQTEDW2F9YDRbYNs3AyN
         NxaHvS1SPsNuSmJ//eRJuqWmc7AnKrfov5V2RuMb3sdPAwX+UYBYunS6mfts2kWWiso5
         uy5v+c/tFzD/EGtFJ6MFTw4LY8GrzsyvH7Y2zNBeHJxfk6M80PCLQ3MmVjqJdu+D1M+4
         Oy7jCLgArz7JnuC3EWr9QApWdIDwmXaaQEhbdDkmx16WtEBcbb6jhAh7bXUAaFTR8Sri
         5mKQ==
X-Gm-Message-State: AOJu0YzwTdTO9zADpEaSLHJ0jgKf0epecD3Q70LHcGRHWSv5+NDkjyfB
	rMVPeGCr0/4E0r9KcBmX9XmGnDrkvw3wwR2/jXh7GE/pxH5EmTY/xhhpkEmnZdt4AMauK7+xcGg
	ugQ0hWr5xOKJ9o9MsFymsFc5xdVDkR6fc+ppryYjkp5cEm+dvelJzQJPNXArGr04srA==
X-Gm-Gg: ASbGncty8nJJenQTbBAlwic7FqfU9cj3VfSRTrF0unI2FS2srQ9+j8xoXkXyJGZ58Bu
	lZDc9Sy79iAJn/Y28jYiFTbVDDj5SzhL+Za+GT0SGQsX2YPPpZ0vd+mONuMGEqQ0iyfVQcoics+
	ER+B+P2vHxnbq+Pl47VMfbHB3/7R/sAjaEctsEHbRiAnCmgpBVz0X8EhuP3AesEFB3iOl44FrS4
	tdf8D9jkq8uamVLg0kw41BeevYkYrBxCM49hr+ihjOKvEcwD8Lme6dN
X-Received: by 2002:a17:90a:d64b:b0:2ee:8aa7:94a0 with SMTP id 98e67ed59e1d1-2f548f42490mr35465340a91.32.1736945329766;
        Wed, 15 Jan 2025 04:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjxTXCBzZGFLE2c9QopBdWskMhg8LVn2kaj54gMSuUryPKpqSFR6iIdC2Lu3ZfrcACeZ8qaQ==
X-Received: by 2002:a17:90a:d64b:b0:2ee:8aa7:94a0 with SMTP id 98e67ed59e1d1-2f548f42490mr35465300a91.32.1736945329311;
        Wed, 15 Jan 2025 04:48:49 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cd5b0sm1306623a91.26.2025.01.15.04.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 04:48:48 -0800 (PST)
Message-ID: <62c6a307-e17a-4c1a-a66f-1068bd4c2daf@redhat.com>
Date: Wed, 15 Jan 2025 07:48:46 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdctl: tweak the version subcommand behavior
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250108225439.814872-1-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250108225439.814872-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/8/25 5:54 PM, Scott Mayhew wrote:
> The section for the 'nfsdctl version' subcommand on the man page states
> that the minorversion is optional, and if omitted it will cause all
> minorversions to be enabled/disabled, but it currently doesn't work that
> way.
> 
> Make it work that way, with one exception.  If v4.0 is disabled, then
> 'nfsdctl version +4' will not re-enable it; instead it must be
> explicitly re-enabled via 'nfsdctl version +4.0'.  This mirrors the way
> /proc/fs/nfsd/versions works.
> 
> Link: https://issues.redhat.com/browse/RHEL-72477
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>   utils/nfsdctl/nfsdctl.8    |  9 ++++--
>   utils/nfsdctl/nfsdctl.adoc |  5 +++-
>   utils/nfsdctl/nfsdctl.c    | 58 +++++++++++++++++++++++++++++++++++---
>   3 files changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> index b08fe803..835d60b4 100644
> --- a/utils/nfsdctl/nfsdctl.8
> +++ b/utils/nfsdctl/nfsdctl.8
> @@ -2,12 +2,12 @@
>   .\"     Title: nfsdctl
>   .\"    Author: Jeff Layton
>   .\" Generator: Asciidoctor 2.0.20
> -.\"      Date: 2024-12-30
> +.\"      Date: 2025-01-08
>   .\"    Manual: \ \&
>   .\"    Source: \ \&
>   .\"  Language: English
>   .\"
> -.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
> +.TH "NFSDCTL" "8" "2025-01-08" "\ \&" "\ \&"
>   .ie \n(.g .ds Aq \(aq
>   .el       .ds Aq '
>   .ss \n[.ss] 0
> @@ -172,7 +172,10 @@ MINOR: the minor version integer value
>   .nf
>   .fam C
>   The minorversion field is optional. If not given, it will disable or enable
> -all minorversions for that major version.
> +all minorversions for that major version.  Note however that if NFSv4.0 was
> +previously disabled, it can only be re\-enabled by explicitly specifying the
> +minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
> +interface).
>   .fam
>   .fi
>   .if n .RE
> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> index c5921458..20e9bf8e 100644
> --- a/utils/nfsdctl/nfsdctl.adoc
> +++ b/utils/nfsdctl/nfsdctl.adoc
> @@ -91,7 +91,10 @@ Each subcommand can also accept its own set of options and arguments. The
>       MINOR: the minor version integer value
>   
>     The minorversion field is optional. If not given, it will disable or enable
> -  all minorversions for that major version.
> +  all minorversions for that major version.  Note however that if NFSv4.0 was
> +  previously disabled, it can only be re-enabled by explicitly specifying the
> +  minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
> +  interface).
>   
>     Note that versions can only be set when there are no nfsd threads running.
>   
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index 722bf4a0..d86ff80e 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -761,6 +761,32 @@ static int update_nfsd_version(int major, int minor, bool enabled)
>   	return -EINVAL;
>   }
>   
> +static bool v40_is_disabled(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
> +		if (nfsd_versions[i].major == 0)
> +			break;
> +		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor == 0)
> +			return !nfsd_versions[i].enabled;
> +	}
> +	return false;
> +}
> +
> +static int get_max_minorversion(void)
> +{
> +	int i, max = 0;
> +
> +	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
> +		if (nfsd_versions[i].major == 0)
> +			break;
> +		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor > max)
> +			max = nfsd_versions[i].minor;
> +	}
> +	return max;
> +}
> +
>   static void version_usage(void)
>   {
>   	printf("Usage: %s version { {+,-}major.minor } ...\n", taskname);
> @@ -778,7 +804,8 @@ static void version_usage(void)
>   
>   static int version_func(struct nl_sock *sock, int argc, char ** argv)
>   {
> -	int ret, i;
> +	int ret, i, j, max_minor;
> +	bool v40_disabled;
>   
>   	/* help is only valid as first argument after command */
>   	if (argc > 1 &&
> @@ -792,6 +819,9 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
>   		return ret;
>   
>   	if (argc > 1) {
> +		v40_disabled = v40_is_disabled();
> +		max_minor = get_max_minorversion();
> +
>   		for (i = 1; i < argc; ++i) {
>   			int ret, major, minor = 0;
>   			char sign = '\0', *str = argv[i];
> @@ -815,9 +845,29 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
>   				return -EINVAL;
>   			}
>   
> -			ret = update_nfsd_version(major, minor, enabled);
> -			if (ret)
> -				return ret;
> +			/*
> +			 * The minorversion field is optional. If omitted, it should
> +			 * cause all the minor versions for that major version to be
> +			 * enabled/disabled.
> +			 *
> +			 * HOWEVER, we do not enable v4.0 in this manner if it was
> +			 * previously disabled - it has to be explicitly enabled
> +			 * instead.  This is to retain the behavior of the old
> +			 * /proc/fs/nfsd/versions interface.
> +			 */
> +			if (major == 4 && ret == 2) {
> +				for (j = 0; j <= max_minor; ++j) {
> +					if (j == 0 && enabled && v40_disabled)
> +						continue;
> +					ret = update_nfsd_version(major, j, enabled);
> +					if (ret)
> +						return ret;
> +				}
> +			} else {
> +				ret = update_nfsd_version(major, minor, enabled);
> +				if (ret)
> +					return ret;
> +			}
>   		}
>   		return set_nfsd_versions(sock);
>   	}
So nfsdctl version -4 turns of all v4 versions
and nfsdctl version +4 only turns on +4.1 +4.2.
nfsdctl version +4.0 is needed to turn on 4.0
leaving the rest of the minor versions on

Is this intended?

steved.


