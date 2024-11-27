Return-Path: <linux-nfs+bounces-8236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056AF9DA6EC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 12:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA96BB210A2
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61D1F8EE1;
	Wed, 27 Nov 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNUDDHR1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2291F8EFB
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707611; cv=none; b=sxRt+7JIJ0+DV9dfGYtW8DHs1lRftFR6usNzPSvQ4J6TXRxBOVae26BMj98u8n4yYQsUT5BgEdJLpMRnhdfqum6qeCMxSes8ID1drZSx1iB8tz2Y6TLpB0wriBypPEfRARSIEFw8u7EQlb1J3GD8aYZgS3VsL+Eg4nX8p/bPzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707611; c=relaxed/simple;
	bh=k8DZz1PJrVLX4m3bJ9RjUsHs+QsI7tvsuxQJBbQrPyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOtGZNKZ+Fjb36nVL7rklbpbG+gbBjsHueEuB/Qpthish5bLqzOjwRiMMQ+6QUezeRRDKa+cFsIDG0ccQUGbfEFYzSQ9vFxUTEuoP3mxtHsUszMF5qNgfeOLpUnhElt1SisNCFsJUCwcX/TqlUR3bOZSUVMs5yj7DBwNY01PFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNUDDHR1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732707607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZowCCb3hCwVNU0IZEfIB0xNIu2b7ldnlssRPFAJZ+AU=;
	b=YNUDDHR1DqJTfYvsvzDfS7LUeR5d9o4VnnPfWWE3ENMeUqc5hZmJnOHY2w63eF29vD1EOk
	9xWnIeigMVVatqqbAPwC7AWPqSX/depMNTege4GjF6+xwjfIGPbhuWD9wQSvePHJgWNqIO
	35feFkorBG1bhHmbs3vLoYPTjxR1M10=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-pP9VFPyoMn292twj9CKo6w-1; Wed, 27 Nov 2024 06:40:06 -0500
X-MC-Unique: pP9VFPyoMn292twj9CKo6w-1
X-Mimecast-MFC-AGG-ID: pP9VFPyoMn292twj9CKo6w
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-843e5314c99so158453739f.0
        for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 03:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732707605; x=1733312405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZowCCb3hCwVNU0IZEfIB0xNIu2b7ldnlssRPFAJZ+AU=;
        b=XnfMkmixFY0yPZJj++4WK+uIzdPSZflnsDWby/C9m4GNj4T07/ByZ0jR6UgItW+YHY
         abkoOEgjjgK9s1852UbvxVGnxbTQ3PYPedLFQmI63XvgqK5bdUigMKIRp6sHOQWr0olj
         1LS/SX1WqmlDtPmbRzHwoUbjEdV1+xxgzJOjoyOec1IDPFfwcWv6KSXlrEQu1/WQcoXq
         dPRRoXLbD/77396Tuftmm9U38IEqYxBJWoNsNEqKbItcd/uQIMn2iSmqzJgMahqT2nvC
         xHkvZwW30082t4+R/yMvM5zmMI6ZXwB+dO72Cxsd9I9IZKFNiO8LtLeXxDK0cKb9KUIa
         bhNw==
X-Gm-Message-State: AOJu0YxMSeGswFKsniZP4gV1Puf7bCTKA0+HnaP/+QNVlGUVmQdtVDL7
	p0Y7tPfacSsjSFFTnn/DCkeadvoLKl2W0CiCMdpZ/5e5M/ioqraAPPYBLEEtnK0wMmYiY96RVtL
	i3Ox2vsZ7tP61DDR6QVa9hyxvZQePrQtJvzmo7j2+bsJyWOMKqJ/QHqRqfyOEBOg1mw==
X-Gm-Gg: ASbGncvg1m8GMNwQVhxv8wWqmvSVWSpZojB76fjBE52Kn527DDeSruAu5pz/+kcMLUG
	xN5uQ2NDgxaHwH3xo/9ECA5IaoySs0sC7Jr589IxmhW6H7fK2Uf/OVE2httnUkNYPMGe8WiE8o9
	1rO6uxAPTZ4oZnHdC89FFgHccV2na03JP4dZLGSiNKBNsVu2KlaczmnjEdcZp1FpnMzHL3x1iHq
	phWfkiQLWxltscVUDTjJY/63oAYwkpb7TnlgnU848RsP/TKgw==
X-Received: by 2002:a05:6602:2cc7:b0:83a:a746:68a6 with SMTP id ca18e2360f4ac-843eced3138mr400672239f.5.1732707605342;
        Wed, 27 Nov 2024 03:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH43gLwlAc2c1IltUAYqQUmW9OSBf175hFlr7Oej3/tt6mjDXRXlhSlyZnWaSZu5MBmhWVE7A==
X-Received: by 2002:a05:6602:2cc7:b0:83a:a746:68a6 with SMTP id ca18e2360f4ac-843eced3138mr400670139f.5.1732707605058;
        Wed, 27 Nov 2024 03:40:05 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e20dedc309sm1098414173.39.2024.11.27.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 03:40:04 -0800 (PST)
Message-ID: <995b5d27-6c34-4c5e-89c7-728da4878c9e@redhat.com>
Date: Wed, 27 Nov 2024 06:40:03 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libnsm: fix the safer atomic filenames fix
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <7463bba8aea785f7614e169e8cdfb3d8f1e1e64a.1732663909.git.bcodding@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <7463bba8aea785f7614e169e8cdfb3d8f1e1e64a.1732663909.git.bcodding@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/26/24 6:32 PM, Benjamin Coddington wrote:
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
Committed...

steved.

> ---
>   support/nsm/file.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/support/nsm/file.c b/support/nsm/file.c
> index e0804136ccbe..6663cac3fb0c 100644
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
> @@ -199,7 +199,7 @@ nsm_make_temp_pathname(const char *pathname)
>   	strcpy(path, pathname);
>   
>   	len = base - pathname;
> -	len += snprintf(path + len + 1, size-len, ".%s.new", base+1);
> +	len += snprintf(path + len + 1, size - len - 1, ".%s.new", base+1);
>   	if (error_check(len, size)) {
>   		free(path);
>   		return NULL;
> 
> base-commit: eb5abb5c60ab60f3c2f22518d513ed187f39bd9b


