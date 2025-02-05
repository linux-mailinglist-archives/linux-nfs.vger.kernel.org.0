Return-Path: <linux-nfs+bounces-9888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA50EA29C93
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 23:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD5F3A470C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A86215F4F;
	Wed,  5 Feb 2025 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PALNRIU0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0152214A90
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794222; cv=none; b=NFVNCbUQE/zvevCbs//CdQhytNp/NeZRNx72nwDp31utG15uSuXwED89amb/Qx2XDvqIMEsD6Txz8HFJAheIGXuU7JTvN/nW/3wK+Fu2BmrIqaqJZyZQt9YeS+bhxm6Vro8D3shNFshbEMk9nKww7iDmdKAtMIOwbX470Py+AfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794222; c=relaxed/simple;
	bh=ITw/hM5rXiKqD2UNrdnqTAV3bus/J3GVlkF5oHqTG9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FB8g2NcPOl5r7iGyPP36wAY3uy42BZYU9S5Er48WT4/azLY+UM2BvKNXp5ZX/tZC0xpDb7SmpNV/EzEC9yC2YHo4iRSHL3hR0nBvNd6wl1iGbUF34zFCDw8b0OS0j1reABa6c21Ot8Dw0ktLYVkeGIvy3ugAaIOx1rPhaoVq42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PALNRIU0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738794219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYcJadiCTp/r13P8g5H8biQ+lnyD3q+P02YKEcItr7M=;
	b=PALNRIU0C2onhumJyRyFl3V4GV2j+L4Lrx/1Fsvwi9m82O/mF+yL4leZBQssEH0uic21D5
	3H2ECLJxXaPZXggRECWkWX6t+mCqWTA15XwkFa9nrgQLEVanUQm+JtMb0aOg6MQ+Y1mP/x
	u8oQshZfyFd9b1hqVILaXY0C4FlMbjE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-VieEPuTWMWu-4_bNwWgDIw-1; Wed, 05 Feb 2025 17:23:35 -0500
X-MC-Unique: VieEPuTWMWu-4_bNwWgDIw-1
X-Mimecast-MFC-AGG-ID: VieEPuTWMWu-4_bNwWgDIw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e42459ad81so9193406d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Feb 2025 14:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794214; x=1739399014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYcJadiCTp/r13P8g5H8biQ+lnyD3q+P02YKEcItr7M=;
        b=KORBp91qxr5CRH3z7sA/xWf8Yf9fEVUWs5SHX1jKBuRvjKzvYEj0GgEiN7LspLDLKu
         8q68vJWu50wywDgvXrdBNnDJ8gdfWd7rcMEiXMm58hRjI143GvfFfmQl9WLXY+L6FTc7
         rsUn9SXHXpFAjlf0wPEk93MeoOqlRZAf0oIHOgRKXZ3XQjjp9MvStLt+9cAjOOE/qwRO
         su46bGfE1Dp+J30rMpQ/jXjPHFUfaL7rYlTgaVnmCydUl4ZnvWm7YsUQYO8YCnB1e5pD
         81QsZ0JeQRmxfiOONUy+rsWwlrP9Ab9/yA0n2L67jlnjpoFm32FkSQY9uz67HqY5Ze6e
         b0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIEhe4xMWrtsMNCdFI7+KZ+nszySWffQSPgCdxbtwM5JURJyujyKrxcsFY4a+4NBgcN1g2cMUrBKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrbIp//NLyA0l5jnKjidaZl1ngDAwNqiLa18C3XNNL6/2iM6i
	UOhKjrEtU2IGsmxZiVeH660IlI+X2s+UANhOwIwhwJafIp6pvWoUQX9A6nNKzlJ/NXUtQW9FRKh
	slF+gfqXDwXwdKzYGSJjHsUUc21/JhNQ1NS7NRTDzk4rqLSsDKaYKfs/evaxSbX+5/Q==
X-Gm-Gg: ASbGncs1ktISbj8ISXRvT2W4la24q4UdMXa8vESu+tT8JxnCxUDTAQTkhs27h7m2aUn
	4nufNpgHRNvn9q7l5IyLN9hYesAmeelthBiTNKVo2+zyjwGNkKGIrhGP65uy26C6w3dIQVWUfo8
	+9q1ngstbjAf5Q14iscdvf6ZP1OK3BlTKFzG2PsunXhqeIiqbQtGWP8hNhPU9IGiD6LrI/HxyEy
	ME7r4RDzetuZMSOuccqNp2kW/FpJpgNn8frpf+huRPlgkSf1cNkp9CHcBr0JLraZrym2j14blsF
	GhcRAg==
X-Received: by 2002:a05:620a:3192:b0:7b6:cb3c:d523 with SMTP id af79cd13be357-7c03a036f8cmr666995685a.46.1738794214201;
        Wed, 05 Feb 2025 14:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEHUYHU8b47v3MrSoWxo48iit2k6dGfmXeiiuH6k9W2GynEWPbdC8K9ASIruDQIkRGX4Fh/Q==
X-Received: by 2002:a05:620a:3192:b0:7b6:cb3c:d523 with SMTP id af79cd13be357-7c03a036f8cmr666993985a.46.1738794213908;
        Wed, 05 Feb 2025 14:23:33 -0800 (PST)
Received: from [172.31.1.150] ([70.105.251.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d9442sm794973485a.57.2025.02.05.14.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:23:32 -0800 (PST)
Message-ID: <c6a022dc-b21e-45e6-ae17-b812a40ba038@redhat.com>
Date: Wed, 5 Feb 2025 17:23:32 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 4/4] rpcctl: Add support for `rpcctl switch
 add-xprt`
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250127215056.352658-1-anna@kernel.org>
 <20250127215056.352658-5-anna@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250127215056.352658-5-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/25 4:50 PM, Anna Schumaker wrote:
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
> index 130f245a64e8..29ae7d26f50e 100755
> --- a/tools/rpcctl/rpcctl.py
> +++ b/tools/rpcctl/rpcctl.py
> @@ -213,6 +213,12 @@ class XprtSwitch:
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
> @@ -236,6 +242,11 @@ class XprtSwitch:
>               return [XprtSwitch(xprt_switches / name)]
>           return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
>   
> +    def add_xprt(args):
> +        """Handle the `rpcctl switch add-xprt` command."""
> +        for switch in XprtSwitch.get_by_name(args.switch[0]):
> +            write_sysfs_file(switch.path / "add_xprt", "1")
> +
>       def show(args):
>           """Handle the `rpcctl switch show` command."""
>           for switch in XprtSwitch.get_by_name(args.switch):
Question... is this support needed by a kernel patch? if so is
it in a public kernel?

steved.


