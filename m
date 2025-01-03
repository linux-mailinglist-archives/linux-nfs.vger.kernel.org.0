Return-Path: <linux-nfs+bounces-8900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB0A00FE5
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 22:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454F63A2367
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2025 21:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8660145B3F;
	Fri,  3 Jan 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbxagVFc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E791ABEC7
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jan 2025 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939972; cv=none; b=rRuz2DBp33QPD3Tehd7MN4YBd+isSzFsFEHJLQBF5PU9n8T8TL07ycs+/5CqAXmIvbeffXP7GUAwt9tr1gKitvxARmdzD89xpGdqk4aE8y+sYc8FTJhYEUiOi2mY8K9nmwA7rYNU8ZDLSw1zC+k6nT9zZaE9oVqTHLkFgXtFA58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939972; c=relaxed/simple;
	bh=zM5RAgMBw2oQ2qRiQgHbo052aMe8R3A+InFZDOC58IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twB0nlnid2TgNR2Y0XB/YwN2xmbm5k55TSxfTdxMGS+k7B8Kq8+Vkyoa9i9sDN5U2MvboDe+iH51p8ANztKS06/IvFDErrH3xVPRrpNyCBAbCsre4Mj8nQcY8/Qpd9FXkPllKrkU/078Iu9IuCtaoAHHfIPnZ1thyAlUkf/+80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbxagVFc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735939969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7hSWEQdT0EfPvasBVgX2ieN2ZABRZklcuItGyltKio=;
	b=MbxagVFcV1Kp0Geyj8/o3AggGJ60+ciurPYB1rJlm4y+ImafE0skTK1IVU1/d24W9MctLL
	h5EMd854a84yXjMhQ9JDfD/yBUERcOy1m7zxoK2dw04b4aaaGI0cIPPHE045zIsXZYntbp
	ZRv1csyEnU7A9TcysY5TPjDH2tHvSF8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-eL6PX-ImMBWT41K_u-5_cg-1; Fri, 03 Jan 2025 16:32:48 -0500
X-MC-Unique: eL6PX-ImMBWT41K_u-5_cg-1
X-Mimecast-MFC-AGG-ID: eL6PX-ImMBWT41K_u-5_cg
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6dcf01612f0so110370506d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jan 2025 13:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735939968; x=1736544768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7hSWEQdT0EfPvasBVgX2ieN2ZABRZklcuItGyltKio=;
        b=Rigo0Xw/584ZgJtkYYp6JP+ShrTzx0TDopubPl5+xpergycYnWbIg6hBzzL+W3NMdc
         Tl85J/bFT44/7gx1OXJSIUp9j9UKoDiPLy4NJriGHCQq8Ujjrcv9zmXz7YYScFDMxAhc
         6PYT2QZ50ODzkIkzTbpDxNYnPK33ZWsteWp/9KVw8A55q3bJRKyZ3nrW4YWIWJuvjiH4
         54BwVuWFKx/pfT0hdDcLQD5iIb3n0Vyl6IzJAmc4xeR1q6UVdL7GPgDO7pgKf22IRQzf
         T558rPtqNokyPu5nRTNuxPGSUqaLjp5Oe3zNrm5yDhgkPMIAYR9BtTeKB7wBmXILoRXA
         YA/g==
X-Gm-Message-State: AOJu0Yx4vKnRLK1EJJ1rDmAUYfxzEvCBZ6Xqqp7TvFzeVEsCseyG5N6W
	lLdKvlZ0ISPkXCxZx6MeN4XmwMZInpiyvFVd9SoiBq4pqYZNwJ0aYcsRk0XBdMOMrDo4bRCie6Y
	5yo8BOShj+KswtUxIfr5NmkPpBft3u26bP5rh7QqDAGYqp6bvp6+4PaKgcg==
X-Gm-Gg: ASbGncvLHxg0FQEZ1HH8b4P0f+LTxRe6xvDKpwfyvlsoZQQGwLicyxx8xRMbofEw07g
	iq0ybXpKXRarL4cPTtTND8Y7+NEDaO6HlDhWcooNdJH303nouAFltA3DFHcsFSMwEKvmB8ljJwl
	Z6Wycme9eg/J3CAbWnKz2GfB+Ch7fuKxt+DsforAL0aQ4GghPHB5FB+1HPqP2/tU96wbbBrSMdu
	ZryMujV4JRNGNJCJ9IQZ4hzLInShmQSC9bB9YEsKs9boxDOjYQSPRBs
X-Received: by 2002:a05:620a:40c1:b0:7b6:c473:4ec3 with SMTP id af79cd13be357-7b9ba6efab3mr7019235485a.8.1735939968069;
        Fri, 03 Jan 2025 13:32:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIiiymor1cxLuEmNANA3K/QAGJZ73gYbDS6aI9h1qRtDDZ0M2Y9SRsbsCEUYFV0wsEft4rjg==
X-Received: by 2002:a05:620a:40c1:b0:7b6:c473:4ec3 with SMTP id af79cd13be357-7b9ba6efab3mr7019233985a.8.1735939967803;
        Fri, 03 Jan 2025 13:32:47 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4be3b0sm1302905685a.99.2025.01.03.13.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 13:32:47 -0800 (PST)
Message-ID: <7c42751c-137b-456d-89be-2ec0a46b7c28@redhat.com>
Date: Fri, 3 Jan 2025 16:32:46 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsdctl: manpage fix a few typos
To: Yongcheng Yang <yongcheng.yang@gmail.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20241230094407.442310-1-yongcheng.yang@gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241230094407.442310-1-yongcheng.yang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/30/24 4:43 AM, Yongcheng Yang wrote:
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
Committed... (tag: nfs-utils-2-8-3-rc1)

steved.
> ---
>   utils/nfsdctl/nfsdctl.8    | 10 +++++-----
>   utils/nfsdctl/nfsdctl.adoc |  6 +++---
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> index 38dd1d30..b08fe803 100644
> --- a/utils/nfsdctl/nfsdctl.8
> +++ b/utils/nfsdctl/nfsdctl.8
> @@ -2,12 +2,12 @@
>   .\"     Title: nfsdctl
>   .\"    Author: Jeff Layton
>   .\" Generator: Asciidoctor 2.0.20
> -.\"      Date: 2024-11-18
> +.\"      Date: 2024-12-30
>   .\"    Manual: \ \&
>   .\"    Source: \ \&
>   .\"  Language: English
>   .\"
> -.TH "NFSDCTL" "8" "2024-11-18" "\ \&" "\ \&"
> +.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
>   .ie \n(.g .ds Aq \(aq
>   .el       .ds Aq '
>   .ss \n[.ss] 0
> @@ -163,7 +163,7 @@ The fields are:
>   .fam C
>   + to enable a version, \- to disable
>   MAJOR: the major version integer value
> -MINOR: the minor version integet value
> +MINOR: the minor version integer value
>   .fam
>   .fi
>   .if n .RE
> @@ -291,7 +291,7 @@ Set the pool\-mode to "pernode":
>   .if n .RS 4
>   .nf
>   .fam C
> -nfsctl pool\-mode pernode
> +nfsdctl pool\-mode pernode
>   .fam
>   .fi
>   .if n .RE
> @@ -306,7 +306,7 @@ user, but configuring the server typically requires an account with elevated
>   privileges.
>   .SH "SEE ALSO"
>   .sp
> -nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), nfs.conf(5), rpc.rquotad(8),  nfsstat(8), netconfig(5)
> +nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), rpc.rquotad(8), nfsstat(8), netconfig(5)
>   .SH "AUTHOR"
>   .sp
>   Jeff Layton
> \ No newline at end of file
> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> index 79f07cf0..c5921458 100644
> --- a/utils/nfsdctl/nfsdctl.adoc
> +++ b/utils/nfsdctl/nfsdctl.adoc
> @@ -88,7 +88,7 @@ Each subcommand can also accept its own set of options and arguments. The
>   
>       + to enable a version, - to disable
>       MAJOR: the major version integer value
> -    MINOR: the minor version integet value
> +    MINOR: the minor version integer value
>   
>     The minorversion field is optional. If not given, it will disable or enable
>     all minorversions for that major version.
> @@ -143,7 +143,7 @@ Change the number of running threads in first pool to 256:
>   
>   Set the pool-mode to "pernode":
>   
> -  nfsctl pool-mode pernode
> +  nfsdctl pool-mode pernode
>   
>   == NOTES
>   
> @@ -157,4 +157,4 @@ privileges.
>   
>   == SEE ALSO
>   
> -nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), nfs.conf(5), rpc.rquotad(8),  nfsstat(8), netconfig(5)
> +nfs.conf(5), rpc.nfsd(8), rpc.mountd(8), exports(5), exportfs(8), rpc.rquotad(8), nfsstat(8), netconfig(5)


