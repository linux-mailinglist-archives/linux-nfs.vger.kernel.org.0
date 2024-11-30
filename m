Return-Path: <linux-nfs+bounces-8272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B99DF075
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 14:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F4E162FBC
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A1A154456;
	Sat, 30 Nov 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2zRyWkg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805343179
	for <linux-nfs@vger.kernel.org>; Sat, 30 Nov 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732972318; cv=none; b=N4MaLI7T5sInFufEzyWdUsAgvycJvWzMIdT3OySCOqmkn+Pl89yeXFJixQAQHFh4D46Ekcg9tzG4Y4+XOm0IlI164Qy0Q97pm5SKA0aTQfEWtJD3mnG2ikLYLFVDp/eLXV/4rCBT4+QuApZHwE6QKUUM/h1kN8DU6xSXMq7v8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732972318; c=relaxed/simple;
	bh=bjw29JI7RI7l6A2Zgsr7oXARSElEXel+DhAAoyuLjCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkuW49uVBnlFyeAV4jma+fuZ7xxme0KY4QLUC731kgqSpQSnJnz5UKOhn/5IhnAqp7ZLunnIKvljAtJWIAGGZQ/NcuP0uqeGzu2uzRMmUBchzvgoVvbNiCgyBEUuaPr/e0wvCBpatG7Xazqmhyu9RadNmy5ZTvgo9QVAccrLJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2zRyWkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732972315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCmx+q7aMpYGCId7BC8X2LIElyCG80vAFufLhrRoFsQ=;
	b=i2zRyWkgr60KxyG+BMxjOgTXeyI1Pd7+3q11MM+ddD2XowBCnF1U7M3PhLpjwlTAVwzikg
	aiGQh/RRVY8scbmWTF7hCZ0U78ysgM4usPQtJh8FrIKy8qxae340UN9onNAZ+gO0Gbzkyx
	oU6gjclr46ia1YMnqtoAdabudfkZwLc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-4zOHKSN6PROVoIiuTg15AQ-1; Sat, 30 Nov 2024 08:11:53 -0500
X-MC-Unique: 4zOHKSN6PROVoIiuTg15AQ-1
X-Mimecast-MFC-AGG-ID: 4zOHKSN6PROVoIiuTg15AQ
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466ba56bd89so56804731cf.0
        for <linux-nfs@vger.kernel.org>; Sat, 30 Nov 2024 05:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732972312; x=1733577112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCmx+q7aMpYGCId7BC8X2LIElyCG80vAFufLhrRoFsQ=;
        b=RvNnPt6D8RoglL6nsMM7c1SO9YxT7uhHBMTv8L4k41Ig3L5HEW1IgvXgBMb1Q1Jik7
         YS70+tzk9WdLGhO4h3dhzCu1fz+30dsgb2JLRgMgtsxL9VWM72RDnkJoSPfUOaQcW0t7
         NkH5QtgBIN4mreVG9Hj4rse1af10HuLQdodg2g++neOeMxzoT1tEOLsvMbPhc+Zbfu85
         QCNjbn2dtFaugz7lgbAYp7H1bDWBHsEaE4nnyVCS/kYLGfm15TfgAqNbvkbOSjNGM862
         xkZhEe+fg7nz+4nDrwoPgvOvsZxS8LwlbPWYFQlcknWQdIYZpB/g5IQXtIYbw6VWROVO
         zQ+Q==
X-Gm-Message-State: AOJu0Yw/S5NJzGSQAaMAPRQR2p4pePXDBDbuTHOIk0mCWD6ZwWk4OMz+
	pgSX/jSJdmp/U/aXXg64cx58RzNCcEOf+jVhGZ7BD/tuM3fHXt8NXoZm6UmD1Wrhpl1R8Lcca3X
	RiFTxJtWvZDq3izLKlyDjFeFlDTT9Ndj++dAn+Hz8GB+3DRcV7Dux8e/Dcg==
X-Gm-Gg: ASbGncvQMQdbOeVctCemOupL5ljB3NWg0GTaAF+X9zhJTE066+EJ34b1oER5Mz4zfNS
	J6J4nVvRVZDbbe9PfAf39j1g9IpkFriVXVYpg2szsev3pVnVXKG/kc43abVSTC5BfADP+16KpRm
	pm3CiH/6tT7LSWT1tBvi3n3CMe9tmMQaWy+I4qWp5j9WhBw48vDMYtb/iwI5iMNn9oojlu2E6+z
	FSzcKBU3u/NjC39xPQQqcDCfKa65VHNKf0ihxHyoTKX1GRbGw==
X-Received: by 2002:a05:622a:1806:b0:463:5578:4098 with SMTP id d75a77b69052e-466c1c0b17dmr227163711cf.22.1732972312393;
        Sat, 30 Nov 2024 05:11:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWUPT4L336EuNGKZ/PfQL95iZGl0jDXN6z1a9I6OfSxbdE9ACUc1nVpx0SvQEMiqYM8ThhoQ==
X-Received: by 2002:a05:622a:1806:b0:463:5578:4098 with SMTP id d75a77b69052e-466c1c0b17dmr227163391cf.22.1732972312078;
        Sat, 30 Nov 2024 05:11:52 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c421dbe1sm27291111cf.54.2024.11.30.05.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 05:11:50 -0800 (PST)
Message-ID: <d6ea1e14-d3a9-49e1-a106-0cb3916119b6@redhat.com>
Date: Sat, 30 Nov 2024 08:11:49 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libnsm: fix the safer atomic filenames fix
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <7fa1fc7f2a8d72e11e5a468c0ed4bbdefb035830.1732707758.git.bcodding@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <7fa1fc7f2a8d72e11e5a468c0ed4bbdefb035830.1732707758.git.bcodding@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/24 6:44 AM, Benjamin Coddington wrote:
> Commit 9f7a91b51ffc ("libnsm: safer atomic filenames") messed up the length
> arguement to snprintf() in nsm_make_temp_pathname such that the length is
> longer than the computed string.  When compiled with "-O
> -D_FORTIFY_SOURCE=3", __snprintf_chk will fail and abort statd.
> 
> The fix is to correct the original size calculation, then pull one from the
> snprintf length for the final "/".
> 
> Fixes: 9f7a91b51ffc ("libnsm: safer atomic filenames")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reverted and Committed....

steved.

> ---
> v2: ensure we handle paths without '/', simplify.
> 
> ---
>   support/nsm/file.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index e0804136ccbe..de122b0fc5a1 100644
> --- a/support/nsm/file.c
> +++ b/support/nsm/file.c
> @@ -187,7 +187,7 @@ nsm_make_temp_pathname(const char *pathname)
>   	char *path, *base;
>   	int len;
>   
> -	size = strlen(pathname) + sizeof(".new") + 3;
> +	size = strlen(pathname) + sizeof(".new") + 1;
>   	if (size > PATH_MAX)
>   		return NULL;
>   
> @@ -196,15 +196,19 @@ nsm_make_temp_pathname(const char *pathname)
>   		return NULL;
>   
>   	base = strrchr(pathname, '/');
> -	strcpy(path, pathname);
> +	if (base == NULL)
> +		base = pathname;
> +	else
> +		base++;
>   
> +	strcpy(path, pathname);
>   	len = base - pathname;
> -	len += snprintf(path + len + 1, size-len, ".%s.new", base+1);
> +	len += snprintf(path + len, size - len, ".%s.new", base);
> +
>   	if (error_check(len, size)) {
>   		free(path);
>   		return NULL;
>   	}
> -
>   	return path;
>   }
>   
> 
> base-commit: eb5abb5c60ab60f3c2f22518d513ed187f39bd9b


