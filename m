Return-Path: <linux-nfs+bounces-9171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24FA0BD2D
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 17:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844DB18891FB
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D614A4D1;
	Mon, 13 Jan 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuvsPHas"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404814F115
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785396; cv=none; b=QPGreUCbFLXQXzdnGhcRN0THnePh5LnYiAM74s1p1g39PHx6b/MueZ1sIhu4J6N5i6D37HH8HjQQ9Q0nPfaDJyq2q6C2ZTBjaZT+MygoiRdxa3KaQS2z3HZvFPGsb7ZhcIDRhmlrUlNF1cbDaiUzk7vxXMXd9V8vFIOGbCFgOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785396; c=relaxed/simple;
	bh=yMp1XJCl0/XCAdeCTLUMC31lemSnUmSoXfcA85zWj1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jeWRlXfa2kvJ6jeZjrUH1RJGIEYWWWMASGppDXlYfLdTSauh8vMg1+CcLb3rE3BVBpzv2cdRKUasheK3RBqeASq2gK04Up3dyGsqAnVYA+f53XHqnSDiWIY/u6c9ghd47gVmSzxM4dZBpNsiUBvwAx1SvWtKAp6BxMeb+PIigWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuvsPHas; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736785393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrFiIBZe4Dvbi4gXBRnaokjzuIGz9NXd+OJcks+UTC8=;
	b=DuvsPHaswKZ6edJUMBb5C7B7vXi0g8AFbmVU+IJsjDLIfD8bmr30PIpJ4MUIIk7FYarT9h
	7K3Psnp5Y0A8aX2qChq4d9hbmmJzaJMjWtDeiySz45R/mH3Lv03kaclreRmYIH2ZsPnMIq
	OE3OgB0KvYxTeGRpCtjYk7OQiDbmExY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-jgbJhD6vMIW6LbQmm6QohQ-1; Mon, 13 Jan 2025 11:23:12 -0500
X-MC-Unique: jgbJhD6vMIW6LbQmm6QohQ-1
X-Mimecast-MFC-AGG-ID: jgbJhD6vMIW6LbQmm6QohQ
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2166f9f52fbso137486485ad.2
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 08:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785390; x=1737390190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrFiIBZe4Dvbi4gXBRnaokjzuIGz9NXd+OJcks+UTC8=;
        b=I4lVCMBNTfUnPurcVaQJnGS6W43WlKsZmdSmN3zSQDApxab7R8uxeoES4sKMVr3xOn
         qLvT8EaYT2NTvPIx0B37z/hiFq+SgE5QvgjX0u/rfo36SzVFqYSVhJs6/ymxhYWH6YW/
         gW2suN0HAj1yoFOcsnik/0bbzlf5Fbhg4GqDK9OKQDki/Geds90rcVoOcjJq4Br7Nsbr
         IacHNDs+AAxKqxV7SgM/ARbuF59/MBU3LE+yyKdil1GwODZCZbk8+zqUvEYaVXq3iUC5
         mNrDRvKv1qq6kSw8PoVklVpQuWlR24pfrqAzZCSjPI3WuTP6ETuEJsv4ltdxaqv4prE0
         uMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOaCSiCpO0pGsG867e38idj9YNRwC6jcoykOfMY6TAKl/UgPKaARkTpiYPgdvwDea9riFH1ozn9uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvDer1llcd7axTX02e/CI/bWXiOrrnH564n9181ODpG1iWapBy
	hv+B+fDUAijq17W0+v51zwRvrg1APQSqXRqOfaUP6hjwl2mDhkShYJbEW4SW3Xxp3yWQ1/ZSFeE
	RVsxOjsruR0C7yCXDCdoxXErXRhi0wSXVXKrdTinoSQsU4gbcFPWD3gXMh0x2SAImGg==
X-Gm-Gg: ASbGnct3EY2IpxNLvlzT3puC8EZt6cG0NJrSbpOHGUVIn7wrbjdojunkP50ZbdPrp4A
	Cgm1PeUwNt41nzWhsyRBfAMIBmXd1Zrn6YxjqeKh++QfMOK7yGwsLY+LBjqhYT4cK4LtU+b47Dr
	NYq2+aFj/DmPyK3cdO5D6hlBDs6rCvvj40gkAed8bfVBZneL5gnJ3rTvrAK4317FJPNSVELKKgF
	a8LeFject+ayaCqg+QT/VGQWF8wzUmc84kirtdAjVJ+86D/0hGQLsdF
X-Received: by 2002:a17:903:2452:b0:215:63a0:b58c with SMTP id d9443c01a7336-21a83fdecffmr330362195ad.46.1736785390336;
        Mon, 13 Jan 2025 08:23:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFEa4PFqk1EpJ5l34jheTSjXXJC/t0aewM/GP4p08IU6s8zZuglSjDKFoZjRlmmkn1WD65Qw==
X-Received: by 2002:a17:903:2452:b0:215:63a0:b58c with SMTP id d9443c01a7336-21a83fdecffmr330361845ad.46.1736785389965;
        Mon, 13 Jan 2025 08:23:09 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25cc1esm54771215ad.213.2025.01.13.08.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:23:08 -0800 (PST)
Message-ID: <2ac43d80-3623-4be6-8d3f-b2dffa485b12@redhat.com>
Date: Mon, 13 Jan 2025 11:23:06 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH NFS-UTILS 10/10] rpcctl: Add support for `rpcctl switch
 add-xprt`
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250108213726.260664-1-anna@kernel.org>
 <20250108213726.260664-11-anna@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250108213726.260664-11-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Anna,

On 1/8/25 4:37 PM, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> This is used to add an xprt to the switch at runtime.
> 
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
> ---
>   tools/rpcctl/rpcctl.man |  4 ++++
>   tools/rpcctl/rpcctl.py  | 11 +++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
> index b87ba0df41c0..2ee168c8f3c5 100644
> --- a/tools/rpcctl/rpcctl.man
> +++ b/tools/rpcctl/rpcctl.man
> @@ -12,6 +12,7 @@ rpcctl \- Displays SunRPC connection information
>   .BR "rpcctl client show " "\fR[ \fB\-h \f| \fB\-\-help \fR] [ \fIXPRT \fR]"
>   .P
>   .BR "rpcctl switch" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBset \fR| \fBshow \fR}"
> +.BR "rpcctl switch add-xprt" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>   .BR "rpcctl switch set" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fISWITCH \fBdstaddr \fINEWADDR"
>   .BR "rpcctl switch show" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>   .P
> @@ -29,6 +30,9 @@ Show detailed information about the RPC clients on this system.
>   If \fICLIENT \fRwas provided, then only show information about a single RPC client.
>   .P
>   .SS rpcctl switch \fR- \fBCommands operating on groups of transports
> +.IP "\fBadd-xprt \fISWITCH"
> +Add an aditional transport to the \fISWITCH\fR.
> +Note that the new transport will take its values from the "main" transport.
>   .IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
>   Change the destination address of all transports in the \fISWITCH \fRto \fINEWADDR\fR.
>   \fINEWADDR \fRcan be an IP address, DNS name, or anything else resolvable by \fBgethostbyname\fR(3).
> diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
> index 20f90d6ca796..8722c259e909 100755
> --- a/tools/rpcctl/rpcctl.py
> +++ b/tools/rpcctl/rpcctl.py
> @@ -223,6 +223,12 @@ class XprtSwitch:
>           parser.set_defaults(func=XprtSwitch.show, switch=None)
>           subparser = parser.add_subparsers()
>   
> +        add = subparser.add_parser("add-xprt",
> +                                   help="Add an xprt to the switch")
> +        add.add_argument("switch", metavar="SWITCH", nargs=1,
> +                         help="Name of a specific xprt switch to modify")
> +        add.set_defaults(func=XprtSwitch.add_xprt)
> +
>           show = subparser.add_parser("show", help="Show xprt switches")
>           show.add_argument("switch", metavar="SWITCH", nargs='?',
>                             help="Name of a specific switch to show")
> @@ -246,6 +252,11 @@ class XprtSwitch:
>               return [XprtSwitch(xprt_switches / name)]
>           return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
>   
> +    def add_xprt(args):
> +        """Handle the `rpcctl switch add-xprt` command."""
> +        for switch in XprtSwitch.get_by_name(args.switch[0]):
> +            write_sysfs_file(switch.path / "xprt_switch_add_xprt", "1")
> +
>       def show(args):
>           """Handle the `rpcctl switch show` command."""
>           for switch in XprtSwitch.get_by_name(args.switch):

Quick Question... Is this patch dependent on the previous
posted kernel patches (aka NFS & SUNRPC Sysfs Improvements)

steved.


