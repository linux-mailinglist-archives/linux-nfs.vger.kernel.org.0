Return-Path: <linux-nfs+bounces-8165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B99D4348
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 21:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FAA1F21C8B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61A616DED2;
	Wed, 20 Nov 2024 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WebWH4cV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51313C695
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136006; cv=none; b=VbAPrrjXoxkJSkuxijhT3bd7zN8R+G/j8CQTL/+PgMCoGUCV/gxanLbvJ68mNsbMa777e29V0B6qx+/B68u7p63vH6nhuovKbgSs1jCcb4kVF6qFS4DWqWqfkqY+Ydso1jYcltDWfbSbYaKfdwehA15IuFTEnCQRs8o/pTQZfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136006; c=relaxed/simple;
	bh=4Vvf1mE5BES+BiT633JNtUON398QUrd/RQjEbEfVctI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqtfojYnkHoyycc2K3f2PGVsSHvfZW+P6oPtG6YJ9HC9LfRIrCZCtt1dWVgiE33njaYfG2s/NmOQWKGSg47xD/3cngIK24OdZtwhJQ1F4b1bdn1WqevicHU37AVcAicN2F0UNH62Et/EeEO/2sAkbmg8kpDmn+yK0CyxOnFhdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WebWH4cV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732136003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaIXkNgO+VCKQmqrMB7EHzcQ88/6te62tmSMHTcE3Gk=;
	b=WebWH4cVpSVJ0tsN6NEtn54+SJgjrk2y0OQpfnNb/GlNSeCnsnejRfb/0fPNqhYAJhwZ7J
	R1TbJFbYt2Ek40bz2/1Y49xgcer7FTcZ6LQmEQ9unRfv48cMbuCNz1LOCNLGXJPXMLA8Fy
	XD9lTELCor8Wu2G4iAvekEp9d9PaBe8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Gu86SoOFOPaEAqVjatKgNg-1; Wed, 20 Nov 2024 15:53:21 -0500
X-MC-Unique: Gu86SoOFOPaEAqVjatKgNg-1
X-Mimecast-MFC-AGG-ID: Gu86SoOFOPaEAqVjatKgNg
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83acaa1f819so20867439f.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 12:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732136001; x=1732740801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QaIXkNgO+VCKQmqrMB7EHzcQ88/6te62tmSMHTcE3Gk=;
        b=IIEzP6oK98otDKiQw0Dhds6zMF3Vt3ors5jqxV0aU3SCIQ8c8fa2tBYgYF9+iC4oS+
         5v3aKeXBvWxVIOEYM5jJRfwtJQ7xU/ezbvU6MuEV907L4XH8fWwhg0/WHUayObGnW5aH
         rwJFGrGt5H5mvs5PFzDF6lIh2tWvSsjY/74DkwLFrimPYF8jxvD1z+v+Fklfu4Al3iLv
         hunbs83fq+FDAtUGH5iKfg0MFBra7bYRDL5fPrlbhr4ClWPnb2tuKeKuO+sd4bmSsNwk
         1HtxAlnrYilXh5iaD6aoFwn2V7OPD8CfX8QPYI861ygfusOcPfh4gO/CHeOs3UroQcpe
         ONjQ==
X-Gm-Message-State: AOJu0YwPdk0R4L5WsB6okca1SCPCGh401cLyhnvpUFgV8TE811LabztS
	pfNMmpAnH+IjWLBERJ7XbUPj5PcKB3VXhLe+tULmQ0K+fJC9Hx3Hw6kDUKegHhERZVXNQSTiGhw
	sBI+/oC681j5k4ciReDB5ejnAqwDgQrLMOldpY83UG/dbxddQ1QhOowl3Dg==
X-Gm-Gg: ASbGncsK4EF0JLdg4xA94ffEr7Nx4dLkbyqNRLils2iyDcxjItsK6vpsEMkD6/hM4PM
	IGIN7qlBpdCUt/U/O3lOogV9/c329z0p2sYSb3rOX7sLTQUx/8MjaSzWwXD3LrMy66mh/1WZxFF
	sdiFEpqk8HIabL1JNix2qc76dxaAG2r6Yl9clsC84xihL+6ScQeDFfQOm4fdDgakPI11K88NzdN
	j9QBXJoWseYQYcve80iG+uRne5qI2idieag4Z4Vl62pfPw4tw==
X-Received: by 2002:a05:6602:2d83:b0:83a:931a:13a0 with SMTP id ca18e2360f4ac-83eb5fef98amr415949839f.8.1732136001086;
        Wed, 20 Nov 2024 12:53:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz50ti7JHvQ5sw8DEic5vMsR8Yz6yWnIsERgvsO8N2jAmG/GWwb8qwmxDWtupzCV2EgKMsiQ==
X-Received: by 2002:a05:6602:2d83:b0:83a:931a:13a0 with SMTP id ca18e2360f4ac-83eb5fef98amr415948739f.8.1732136000785;
        Wed, 20 Nov 2024 12:53:20 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e0756f54f8sm3463345173.147.2024.11.20.12.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:53:19 -0800 (PST)
Message-ID: <3eef1cfe-7871-4cb8-b9c3-383a65a34873@redhat.com>
Date: Wed, 20 Nov 2024 15:53:18 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 2/2] nfsdctl: clarify when versions can be set
 on the man page
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20241118201902.1115861-1-smayhew@redhat.com>
 <20241118201902.1115861-3-smayhew@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241118201902.1115861-3-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/24 3:19 PM, Scott Mayhew wrote:
> Attempting to make version changes while there are nfsd threads running
> fails with -EBUSY, so make note of it on the man page.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Committed... (tag: nfs-utils-2-8-2-rc2)

steved.
> ---
>   utils/nfsdctl/nfsdctl.8    | 12 ++++++++++--
>   utils/nfsdctl/nfsdctl.adoc |  2 ++
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> index dae1863d..38dd1d30 100644
> --- a/utils/nfsdctl/nfsdctl.8
> +++ b/utils/nfsdctl/nfsdctl.8
> @@ -2,12 +2,12 @@
>   .\"     Title: nfsdctl
>   .\"    Author: Jeff Layton
>   .\" Generator: Asciidoctor 2.0.20
> -.\"      Date: 2024-07-22
> +.\"      Date: 2024-11-18
>   .\"    Manual: \ \&
>   .\"    Source: \ \&
>   .\"  Language: English
>   .\"
> -.TH "NFSDCTL" "8" "2024-07-22" "\ \&" "\ \&"
> +.TH "NFSDCTL" "8" "2024-11-18" "\ \&" "\ \&"
>   .ie \n(.g .ds Aq \(aq
>   .el       .ds Aq '
>   .ss \n[.ss] 0
> @@ -176,6 +176,14 @@ all minorversions for that major version.
>   .fam
>   .fi
>   .if n .RE
> +.sp
> +.if n .RS 4
> +.nf
> +.fam C
> +Note that versions can only be set when there are no nfsd threads running.
> +.fam
> +.fi
> +.if n .RE
>   .RE
>   .sp
>   \fBpool\-mode\fP
> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> index 7119b44d..79f07cf0 100644
> --- a/utils/nfsdctl/nfsdctl.adoc
> +++ b/utils/nfsdctl/nfsdctl.adoc
> @@ -93,6 +93,8 @@ Each subcommand can also accept its own set of options and arguments. The
>     The minorversion field is optional. If not given, it will disable or enable
>     all minorversions for that major version.
>   
> +  Note that versions can only be set when there are no nfsd threads running.
> +
>   *pool-mode*::
>   
>     Get/set the host's pool mode. This will cause the server to start threads


