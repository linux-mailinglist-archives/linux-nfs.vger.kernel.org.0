Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D74A4C98
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380683AbiAaQ5S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 11:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380673AbiAaQ45 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 11:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643648216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vz5ju24P3wWvNjFVw0ZZsQrj1PLrbocHGxHkxNRUs7I=;
        b=h3er9XJWBakHx9NvHusQV8as4sMUU6TiX5WeMg8ublA5D+zpDpbbRLMCwc/pTfVi7D85aa
        AONVP3omnNJGZ6nX5nE5+TuzZ26yTEA2d2jvwVJ8FCtXNgIU9ijB1UsAe7bc3IAm0Jqp75
        c0AaPJoALtF707u7NEGGkaVXmMhjyek=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-hm_gaPsROpWWiG5kZrwmHw-1; Mon, 31 Jan 2022 11:56:55 -0500
X-MC-Unique: hm_gaPsROpWWiG5kZrwmHw-1
Received: by mail-qv1-f71.google.com with SMTP id u15-20020a0cec8f000000b00425d89d8be0so10769359qvo.20
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jan 2022 08:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vz5ju24P3wWvNjFVw0ZZsQrj1PLrbocHGxHkxNRUs7I=;
        b=S2p50Qa9GclNopIglFF8+Yppx0KdAUmeCBB/LlAE7OwTGJ1I8eN5JgJrxr9AX7tqRe
         7qQmN/HCChuYfNfrHPgSFD0oxswQiTe07e3gK+h3SUm9DrKpuX0UEyywkN80/DRYYsR3
         2ix0ayTq0jTHxKKwOY0v6MwpMqmf9V1YZNX+WkCEbFGEfeMh/9WZu97xNl5fkT+dLpNc
         bCk0mYDvSt2y/lyIHp6AMQSDkkN0cAXGl3zoKnrS+v6NOiNsutJ54nMa0+Ytc7LOnRjx
         87wsrvs3Glk9doV2ARkvKZbmUW2b1YgzlKeo6q+XjmbVfvnNnk4gPpW5og0u7xXeVqKJ
         Nk2Q==
X-Gm-Message-State: AOAM532P9XOJRi7+uWcDSV204bLiYO329PuTxzJMcoQL6999Juf+9fi9
        VObSHlZS/72Q/cgICZZx1CUGqo9p4gWbsuv0EanC0J+uyUPisSlWhbW9kZAj0hyhQKP5hgreruS
        BIkm4ZSqo181q8B1SeNL8
X-Received: by 2002:a37:6783:: with SMTP id b125mr1044106qkc.730.1643648214821;
        Mon, 31 Jan 2022 08:56:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3TTYj2rwnHCrJLdA6SdlDWDkAkGXoQ6fWT44s9VtlCE3jdmIe1OJs3oddVCLS8zDposXtJQ==
X-Received: by 2002:a37:6783:: with SMTP id b125mr1044091qkc.730.1643648214577;
        Mon, 31 Jan 2022 08:56:54 -0800 (PST)
Received: from [172.31.1.6] ([71.161.85.11])
        by smtp.gmail.com with ESMTPSA id i5sm9287210qkn.19.2022.01.31.08.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 08:56:54 -0800 (PST)
Message-ID: <6c39ba93-8c77-ed4f-5420-56732d582f30@redhat.com>
Date:   Mon, 31 Jan 2022 11:56:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nfs-utils: Fix man page syntax errors
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-nfs@vger.kernel.org, Stefan Walter <walteste@inf.ethz.ch>,
        Ben Hutchings <benh@debian.org>
References: <20220122194537.118609-1-carnil@debian.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220122194537.118609-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/22/22 14:45, Salvatore Bonaccorso wrote:
> From: Ben Hutchings <benh@debian.org>
> 
> In idmapd.conf.5, there is a line of what should be literal text
> beginning with ".", which makes it an (invalid) command.  It can be
> escaped, but then there will be a space before it.  Instead, Move it
> to the previous line and use the .BR macro so there's no space.
> 
> In idmapd.man, the .I (italic) macro is used.  However, this manual
> page uses the mdoc macro package that does not include it.  Use the
> .Em (emphasis) macro instead.
> 
> In nfsmount.conf.man, the first line should be a comment but it is
> actually an invalid command.  Fix it to be a comment.
> 
> Signed-off-by: Ben Hutchings <benh@debian.org>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Committed... (tag: nfs-utils-2-6-2-rc1)

steved.

> ---
>   support/nfsidmap/idmapd.conf.5 | 4 ++--
>   utils/idmapd/idmapd.man        | 4 ++--
>   utils/mount/nfsmount.conf.man  | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/support/nfsidmap/idmapd.conf.5 b/support/nfsidmap/idmapd.conf.5
> index f5b181670ddb..87e39bb41ab1 100644
> --- a/support/nfsidmap/idmapd.conf.5
> +++ b/support/nfsidmap/idmapd.conf.5
> @@ -198,8 +198,8 @@ With this group names of a central directory can be shortened for an isolated or
>   .TP
>   .B Group-Name-No-Prefix-Regex
>   Case-insensitive regular expression to exclude groups from adding and removing the prefix set by
> -.B Group-Name-Prefix
> -. The regular expression must match both the remote and local group names. Multiple expressions may be concatenated with '|'.
> +.BR Group-Name-Prefix .
> +The regular expression must match both the remote and local group names. Multiple expressions may be concatenated with '|'.
>   (Default: none)
>   .\"
>   .\" -------------------------------------------------------------------
> diff --git a/utils/idmapd/idmapd.man b/utils/idmapd/idmapd.man
> index 5f34d2bff860..8215d2594bfa 100644
> --- a/utils/idmapd/idmapd.man
> +++ b/utils/idmapd/idmapd.man
> @@ -24,13 +24,13 @@ the NFSv4 kernel client and server, to which it communicates via
>   upcalls, by translating user and group IDs to names, and vice versa.
>   .Pp
>   The system derives the
> -.I user
> +.Em user
>   part of the string by performing a password or group lookup.
>   The lookup mechanism is configured in
>   .Pa /etc/idmapd.conf
>   .Pp
>   By default, the
> -.I domain
> +.Em domain
>   part of the string is the system's DNS domain name.
>   It can also be specified in
>   .Pa /etc/idmapd.conf
> diff --git a/utils/mount/nfsmount.conf.man b/utils/mount/nfsmount.conf.man
> index 73c3e1188541..34879c8d63c7 100644
> --- a/utils/mount/nfsmount.conf.man
> +++ b/utils/mount/nfsmount.conf.man
> @@ -1,4 +1,4 @@
> -."@(#)nfsmount.conf.5"
> +.\" @(#)nfsmount.conf.5"
>   .TH NFSMOUNT.CONF 5 "16 December 2020"
>   .SH NAME
>   nfsmount.conf - Configuration file for NFS mounts

