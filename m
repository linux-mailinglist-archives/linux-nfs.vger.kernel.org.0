Return-Path: <linux-nfs+bounces-3941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC090BC3F
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BD0B21083
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51A16A94F;
	Mon, 17 Jun 2024 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7m+/RT2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6EC8E1
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656551; cv=none; b=qz0VodZugHbyRPLOV1VhtZE/HAYRNvs0cmxUnp012IPnlqgqVj8pIfSW7ztfcYL9wFfD+sG5dRAJLE7dl+paAbR0+Jn20FoG5FhlSY0fcw1KQFpzrIKoHSakp1sNzezdqru+9k6N1JZgEmRTxhkNJCgFzuHNql5/yc/9fr1pg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656551; c=relaxed/simple;
	bh=YnF5BOHhgrOdWa49DvvDvxQiajYxm2e6lOhbmIxrqww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDEk3XEhs+HZThgc5EHQluImoDB4bOREb7rAP8aQa5bqoZ6AmtPxZhIN/1oDBLapErYGCT1Fl9kg5fVkIanWFCIJoKvPWlqbr7QV2bbRvSGZ10yD+Nrl4HRG261rvXx9JE5MKM1TBw6ZM0Gg1Ht7+3l82ZLH7+1fvb8svYzD+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7m+/RT2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718656548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAQhp+ZpgUXrHiACXHobtKs8EJI5ISTei8oL0TxPUGY=;
	b=a7m+/RT2qMc937tT+Gtjnapqgp3rtGDzCLTo5VRNWA6TN/rRuIU6/R1xc7frZDTKl2FMMX
	iwcQTGRzLs1DxTo3PnOO2/+2/i3bPrAbYK1j2y8uCztWPQvHxC49n4x86+YIJdMjyad8R+
	FFtABvZMBgOmVgmVMfyJayUBwTj0jdQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339--bEY8YYaN0CY1FzsRlQbvw-1; Mon, 17 Jun 2024 16:35:46 -0400
X-MC-Unique: -bEY8YYaN0CY1FzsRlQbvw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4449d9e372eso105061cf.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 13:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656546; x=1719261346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAQhp+ZpgUXrHiACXHobtKs8EJI5ISTei8oL0TxPUGY=;
        b=fleMmp00JzjVpsqO3gcU9EyCdzIc5iNw1HRdKDCQjIr9IJBXBGFe48BWpV3ddqFnAT
         qLtQpM3VnGm0T6RJlxcF6yhtEbS9gLRDA0a9P+N3tNQUdcvAT+UmVadPfeEK1ZC+9AX8
         vtEnwp5HEzgmui/vPEiqo1Ph5f62gAwhTOMBadaqFwKSA09sNevHt4wJJFVB7AuQ3n2h
         iHqVxXV0epl1ucy9zL4wWOXU2rdCnH9unf5YgMzbH5qACBj077rnlx82UiaJ/8JoyG8g
         P0mFLOZNkm5prEzFSp6WWRz/1tIJbIK6ZmsEPgAwpMCXIM6Vf3qtwDemL4VwB8VVYiCm
         WTDA==
X-Gm-Message-State: AOJu0YzVfITuA4qDn1Kxbznq86OHIaxQjJosp5eLqGGxTt8PT1MrUpoi
	PVg8wKT6RVKoZCx3Si9cjDGtYQ6vwb7PxzZ0Mru8bZwat0QvPndxpxdEJa2wl4DSokO+JAZU6nM
	6tv83CmH0H+jw81OK8gej1wXMlxRtLZOeR4B1L/WeM4zdX0TtLsL+pSiz2HiIeXZN3Q==
X-Received: by 2002:a05:6214:238d:b0:6b2:bf2e:b273 with SMTP id 6a1803df08f44-6b2bf2eb3d5mr81664876d6.3.1718656545784;
        Mon, 17 Jun 2024 13:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHClBapHokTs1G7jXH9YuKaCtfm35t8PnseJJ0Tn4pdiUYRhJ8FPtP1NqKGrAEXOzg5xOG8iw==
X-Received: by 2002:a05:6214:238d:b0:6b2:bf2e:b273 with SMTP id 6a1803df08f44-6b2bf2eb3d5mr81664656d6.3.1718656545316;
        Mon, 17 Jun 2024 13:35:45 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? ([2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eca9c1sm59470536d6.39.2024.06.17.13.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:35:44 -0700 (PDT)
Message-ID: <301930ea-22c2-4c36-93b1-bd5cd5ae3b55@redhat.com>
Date: Mon, 17 Jun 2024 15:35:43 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exports(5): update and correct information about
 subdirectory exports
To: Philipp Tekeser-Glasz <philipp.tekeser-glasz@hvs-consulting.de>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <FRYP281MB02054A1BF04D3B65241939AFE6C02@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <FRYP281MB02054A1BF04D3B65241939AFE6C02@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/24 10:34 AM, Philipp Tekeser-Glasz wrote:
> Document that the default option is now no_subtree_check and add a
> reference to the Subdirectory Exports section.
> 
> Add a warning to the Subdirectory Exports section that it is possible to
> also access files on other filesystems based on a previous discussion.
> 
> Fix a typo in the Subdirectory Exports section. The correct option to
> prevent access to files outside the subdirectory is subtree_check, not
> no_subtree_check.
> 
> Signed-off-by: Philipp Tekeser-Glasz <philipp.tekeser-glasz@hvs-consulting.de>
Committed....

steved.
> ---
>   utils/exportfs/exports.man | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index c14769e5..39dc30fb 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -302,9 +302,9 @@ option can explicitly disable
>   .I crossmnt
>   if it was previously set.  This is rarely useful.
>   .TP
> -.IR no_subtree_check
> -This option disables subtree checking, which has mild security
> -implications, but can improve reliability in some circumstances.
> +.IR subtree_check
> +This option enables subtree checking, which can have mild security
> +benefits, but can decrease reliability in some circumstances.
>   
>   If a subdirectory of a filesystem is exported, but the whole
>   filesystem isn't then whenever a NFS request arrives, the server must
> @@ -325,6 +325,9 @@ filesystem is exported with
>   .I no_root_squash
>   (see below), even if the file itself allows more general access.
>   
> +For more information about the security implications, refer to the
> +Subdirectory Exports section.
> +
>   As a general guide, a home directory filesystem, which is normally
>   exported at the root and may see lots of file renames, should be
>   exported with subtree checking disabled.  A filesystem which is mostly
> @@ -332,19 +335,21 @@ readonly, and at least doesn't see many file renames (e.g. /usr or
>   /var) and for which subdirectories may be exported, should probably be
>   exported with subtree checks enabled.
>   
> -The default of having subtree checks enabled, can be explicitly
> +The default of having subtree checks disabled, can be explicitly
>   requested with
> -.IR subtree_check .
> +.IR no_subtree_check .
>   
> -From release 1.1.0 of nfs-utils onwards, the default will be
> +Before release 1.1.0 of nfs-utils, the default was
> +.IR subtree_check .
> +Since release 1.1.0, the default is
>   .I no_subtree_check
> -as subtree_checking tends to cause more problems than it is worth.
> +as subtree checking tends to cause more problems than it is worth.
>   If you genuinely require subtree checking, you should explicitly put
>   that option in the
>   .B exports
>   file.  If you put neither option,
>   .B exportfs
> -will warn you that the change is pending.
> +will warn you that the change has occurred.
>   
>   .TP
>   .IR insecure_locks
> @@ -578,8 +583,12 @@ however, this has drawbacks:
>   
>   First, it may be possible for a malicious user to access files on the
>   filesystem outside of the exported subdirectory, by guessing filehandles
> -for those other files.  The only way to prevent this is by using the
> -.IR no_subtree_check
> +for those other files.
> +In some cases a malicious user may also be able to access files on other
> +filesystems that have not been exported by replacing the exported
> +subdirectory with a symbolic link to any other directory.
> +The only way to prevent this is by using the
> +.IR subtree_check
>   option, which can cause other problems.
>   
>   Second, export options may not be enforced in the way that you would


