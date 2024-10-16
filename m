Return-Path: <linux-nfs+bounces-7206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CA9A0D6D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 16:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1967F284940
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4120414F114;
	Wed, 16 Oct 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9tCyuUg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A720F5A6
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090439; cv=none; b=qCmYIhVruXJG38ElkhoG32D6YsNwx198E4E7RWheni5gyZ6mKCwYK0x2taIxWVYKIdLlkUds/wXWN9EDGoGNjTE4bznsPsIxAO7AlMAZLwpMfHIBKS7rJGYVHeCqx5O1YVPAJX2BL8LTTJ7Urh6vVwWC+P0C5VAj7WtBkx8OsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090439; c=relaxed/simple;
	bh=HlujZMD545NuzN85ifWwe21kXKBOQA6opq2Qs7TNouc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JwBetQMgqs6E0W8kOs0hnlV01zi2kqkBKYYA+VMSD2bcaD5eHflvFCW3nk3cM/Fn4O9iG3QMHPDHnHsJKnbL4AUhmYARh1vv809sUjvHL/ZctJcpd8eo8Q11j9hVs9JxMRI1TlYUSBeLKJVq2LbEpAIHLphqV/pY+xU6wvdmMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9tCyuUg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729090436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NkGWpUiM86i7zPB+FryaDTo0e22wWuzwrJ/vGyqxwjk=;
	b=B9tCyuUgpOuMSf+EhNA09OIolVYkuKa9M1fK4nwfCQ9YeHYpCbpmA5bPObD/I7Bbsz68ni
	iMOp0McprRbE/xlBsL6Ma1/2BwhgHcjwPzD1jC/FWgjdnFNATCPif00ZjyTGbiJK5pq7S9
	l17pfZuvYnkwztsTyNref7KmcnzWHqA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-iWTf7SYMP-SMKaz78nRMZw-1; Wed, 16 Oct 2024 10:53:54 -0400
X-MC-Unique: iWTf7SYMP-SMKaz78nRMZw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b11c9a9249so596363485a.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 07:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090433; x=1729695233;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkGWpUiM86i7zPB+FryaDTo0e22wWuzwrJ/vGyqxwjk=;
        b=GjaJgEWjk1KkjE9o+bI/SMKWhDyjxtUk/azHNNDEGuxmqev595NuFZBfAKTKmlWqD6
         Sxi+aEdWJPakbYGahb4uAx0Mw6UWx4qhB229wTBKQB4lfVHOlRx7/OHRLxNih+bzOoEd
         kPCdcaJdNzepj4CTWu+uXniHQOPLtmLRdoG+/FqJzdNqz/fs917V7oyS3kKctmth371W
         RefUEfvy0atXtoJxynkQ7I7noeA58OVE66FdFFE85D6B0NN3LAbxgCSiNtgfQwidEG4C
         14YujmTpAHCYLnnY65a1NzCLHtCk8isgk9MXPqM5/WVkLKXGA5k56cbIcB2tLCG/RZ+0
         C8Gw==
X-Gm-Message-State: AOJu0YwI87YBtZ1uPnnLXDFIFS3jdF04KyfEg/MBGtVAYjrEIsXj6xc3
	iOefWHok/4xWmjyjOa2w3UItMZa52eP9XDCBBNzssQKxRLv1AswkzFJEgmPTCPlfZ4aJd5hgkVD
	hEhhl5OJ50ap04NFusAep+o/7c6I8nWFaHqj7QC61vYy3L5iDHGk6nNhEVsLTT3eTDA==
X-Received: by 2002:a05:620a:28cd:b0:7ae:6e4a:c43a with SMTP id af79cd13be357-7b1417b377amr662874785a.6.1729090433367;
        Wed, 16 Oct 2024 07:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCf34fgBzksR/9Pt76R7uYimNtqbd7TJsNhEW+oFYjIPi+2I25PbZH46rsziS7MGl73c9WHg==
X-Received: by 2002:a05:620a:28cd:b0:7ae:6e4a:c43a with SMTP id af79cd13be357-7b1417b377amr662872585a.6.1729090433072;
        Wed, 16 Oct 2024 07:53:53 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363b3f6fsm196611385a.106.2024.10.16.07.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 07:53:52 -0700 (PDT)
Message-ID: <796ef5aa-c031-425c-86fa-24e9a3bde3c0@redhat.com>
Date: Wed, 16 Oct 2024 10:53:51 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Libtirpc-devel] updated macOS support for tirpc [1/7] getpeereid
To: Daria Phoebe Brashear <shadow@gmail.com>,
 libtirpc-devel@lists.sourceforge.net
References: <CAMHoRJhb2JZtv-=018w6mgnzXXn=8JWQuVr9A5UjctzJj44TuQ@mail.gmail.com>
Content-Language: en-US
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAMHoRJhb2JZtv-=018w6mgnzXXn=8JWQuVr9A5UjctzJj44TuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/1/24 4:47 PM, Daria Phoebe Brashear wrote:
>  From 068c57e42a1f6cbc73f2c34259613d48d2fc86ec Mon Sep 17 00:00:00 2001
> From: Daria Phoebe Brashear <shadow@gmail.com>
> Date: Tue, 1 Oct 2024 14:57:38 -0400
> Subject: [PATCH 1/9] check for getpeereid
> 
> macos ships with it, this avoids trying to build a replacement for a defined
> function
> 
> Signed-off-by: Daria Phoebe Brashear <shadow@gmail.com>
All 9 patches are committed (tag: libtirpc-1-3-6-rc3)

steved.
> ---
>   configure.ac     | 2 +-
>   src/getpeereid.c | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 756c958..3d5c914 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -95,7 +95,7 @@ AC_HEADER_DIRENT
>   AC_PREFIX_DEFAULT(/usr)
>   AC_CHECK_HEADERS([arpa/inet.h fcntl.h libintl.h limits.h locale.h
> netdb.h netinet/in.h stddef.h stdint.h stdlib.h string.h sys/ioctl.h
> sys/param.h sys/socket.h sys/time.h syslog.h unistd.h features.h
> gssapi/gssapi_ext.h])
>   AX_PTHREAD
> -AC_CHECK_FUNCS([getrpcbyname getrpcbynumber setrpcent endrpcent getrpcent])
> +AC_CHECK_FUNCS([getpeereid getrpcbyname getrpcbynumber setrpcent
> endrpcent getrpcent])
> 
>   AC_CONFIG_FILES([Makefile src/Makefile man/Makefile doc/Makefile])
>   AC_OUTPUT(libtirpc.pc)
> diff --git a/src/getpeereid.c b/src/getpeereid.c
> index dd85270..e1e551b 100644
> --- a/src/getpeereid.c
> +++ b/src/getpeereid.c
> @@ -24,6 +24,9 @@
>    * SUCH DAMAGE.
>    */
> 
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#endif
> 
>   #include <sys/param.h>
>   #include <sys/socket.h>
> @@ -32,6 +35,8 @@
>   #include <errno.h>
>   #include <unistd.h>
> 
> +#if !HAVE_GETPEEREID
> +
>   int
>   getpeereid(int s, uid_t *euid, gid_t *egid)
>   {
> @@ -49,3 +54,5 @@ getpeereid(int s, uid_t *euid, gid_t *egid)
>       *egid = uc.gid;
>       return (0);
>    }
> +
> +#endif


