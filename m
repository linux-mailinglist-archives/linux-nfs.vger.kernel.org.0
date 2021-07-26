Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8013D63B8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhGZPu4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 11:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239156AbhGZPuy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 11:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627317076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xnBdp+AHghh1wHc/rQPQCXWzyftq+waOM00actVfxc=;
        b=I+ACYLZnqONJbYGpzPnEUfLmSiDQSxOSNenlLWG9en9EtslVemKVqJGkk7QjrMA0V5QS6L
        dU4pCCXMmQbFQiAo0Vn1d3ZH+qjZjRCv3bt/TVa6ZfhBErbAeOMdAmEloWU0Z44gUOsJiX
        g+ePlmkbXXiKZS9JUkrr3SbbGQsuxLQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Nmoc2_7xMcC3engUVGG1SA-1; Mon, 26 Jul 2021 12:31:15 -0400
X-MC-Unique: Nmoc2_7xMcC3engUVGG1SA-1
Received: by mail-qk1-f199.google.com with SMTP id u22-20020ae9c0160000b02903b488f9d348so9360963qkk.20
        for <linux-nfs@vger.kernel.org>; Mon, 26 Jul 2021 09:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xnBdp+AHghh1wHc/rQPQCXWzyftq+waOM00actVfxc=;
        b=cuZXmHTNSQI8BHD/GLqp+awBjAhffrEcR9odRN2sNPJp+oyJgBNwoJHN/OkiNhat9x
         TienLqx7MCLQBxMLy0fJt8FXLqmCSKnCDl3cLXSGr5FNiiu99iZBnKY4rXoILZXB+Ix1
         YjS1ESv8sw2o6DhKb7ycGfSvbM/whgzbixjmVzbl9gQ99xQtPsZPsLuYFlHpcGQW1pXP
         BiHTWJxEplyizbKRdlaSGT2EXlQ4bV7HkSCMCRlPKdNjonyMFnMuc2ao7Exh0RTGF4+e
         LJKvLeVngl3ql+rsBidmUQj+nIwYQtABaaPeWI3Da/fi0aZFUOv+ZZ+jtVBHPuXWm0o4
         6n1Q==
X-Gm-Message-State: AOAM530wJQvw/h4Un6nywhDQTjRXTCKgF8wnXGZdpjuxSCX8LvNN50cp
        IdKGl6pplSCRUDEb/5CgxTDowbEd+8oVWgJLOmv6pWCvbd2sCymBFvOLUerMrpLZEnUqsL/4L18
        Ye5dI6blSxz03EW+Fkl9/MfzKIDsQL9BoHDbkRnQE/YSMZw9nEfXjKsBQDvynV9x9QQBtRw==
X-Received: by 2002:a37:8504:: with SMTP id h4mr18128589qkd.85.1627317074749;
        Mon, 26 Jul 2021 09:31:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrXt8NsgyEGYeGe1T2duAuXlic5Lfr2F16hxbjQdCmFn9Fv5BZtT5IK+fTHaWQq8i/w2mDew==
X-Received: by 2002:a37:8504:: with SMTP id h4mr18128568qkd.85.1627317074543;
        Mon, 26 Jul 2021 09:31:14 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id g1sm230699qkd.89.2021.07.26.09.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:31:14 -0700 (PDT)
Subject: Re: [nfs-utils PATCH 1/2] nfsdcltrack/sqlite: Fix printf format
To:     Petr Vorel <petr.vorel@gmail.com>, linux-nfs@vger.kernel.org
References: <20210722161545.26923-1-petr.vorel@gmail.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <a186a8c6-26d5-e2e9-2950-8d4a743f901b@redhat.com>
Date:   Mon, 26 Jul 2021 12:31:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722161545.26923-1-petr.vorel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/22/21 12:15 PM, Petr Vorel wrote:
> sqlite.c: In function 'sqlite_remove_unreclaimed':
> sqlite.c:547:71: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'time_t' {aka 'long long int'} [-Werror=format=]
>    547 |  ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %ld",
>        |                                                                     ~~^
>        |                                                                       |
>        |                                                                       long int
>        |                                                                     %lld
>    548 |    grace_start);
>        |    ~~~~~~~~~~~
>        |    |
>        |    time_t {aka long long int}
> 
> Found in Buildroot riscv32 build.
> 
> Link: http://autobuild.buildroot.net/results/9bc1d43a588338b7395af7bc97535ee16a6ea2d9/build-end.log
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Both Committed... (tag: nfs-utils-2-5-5-rc1)

steved
> ---
>   utils/nfsdcltrack/sqlite.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
> index f79aebb3..cea4a411 100644
> --- a/utils/nfsdcltrack/sqlite.c
> +++ b/utils/nfsdcltrack/sqlite.c
> @@ -46,6 +46,7 @@
>   #include <sys/stat.h>
>   #include <sys/types.h>
>   #include <fcntl.h>
> +#include <inttypes.h>
>   #include <unistd.h>
>   #include <sqlite3.h>
>   #include <linux/limits.h>
> @@ -544,7 +545,7 @@ sqlite_remove_unreclaimed(time_t grace_start)
>   	int ret;
>   	char *err = NULL;
>   
> -	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %ld",
> +	ret = snprintf(buf, sizeof(buf), "DELETE FROM clients WHERE time < %"PRIu64,
>   			grace_start);
>   	if (ret < 0) {
>   		return ret;
> 

