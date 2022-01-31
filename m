Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0325D4A4C91
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 17:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380672AbiAaQ4Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jan 2022 11:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380670AbiAaQ4V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 11:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643648181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gFlOGrQ0+/V4uPnCD9DruwfragnZ2iJCbNxgm+F1GE=;
        b=SjuRb24TMM2mfGCvcOgD6zhcBVZ5670x/6tJJRzSEUW5CfXJU73dmOegTYRs7hY9KWpEun
        c62yTYN/gWqudx2vOJJoqgBvO181M9it5nCP4SWHJDyL4vW4N4D57xfPVIAtgSFNkapi3w
        p7AqoEgHwLX8oo2hKHTkP+bgT+RNw+8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-4h8sziObPkWlNyM4PVLJjQ-1; Mon, 31 Jan 2022 11:56:19 -0500
X-MC-Unique: 4h8sziObPkWlNyM4PVLJjQ-1
Received: by mail-qv1-f69.google.com with SMTP id d5-20020a0cffa5000000b004257627bf5fso13084729qvv.23
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jan 2022 08:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6gFlOGrQ0+/V4uPnCD9DruwfragnZ2iJCbNxgm+F1GE=;
        b=5bAk4LD3COwMyGvqA07GgqxsfQ+01cB11zcP0s6G+Xnr0tgwtBSYSoD+IYWKJ3O5HD
         qtIamrqJ9qQNQ3nlHjViTQkr4RlcSDEnlXzS4ZR/erCFqWQnr8aS6XOpL88+jtqCeo9K
         tOq0uQWs7SJaG3pr2yEiuhxiw2re4pCgA0Lu1ax/A3DlLAKazLFsKqXwDO3wb281RhtU
         GR8iWRF3+3XVVXSomAMS2LSorK2DqSYoCouw3I6ldUjBkeVOfktNqLsXr5JHhJ/xiWkl
         wLWeyTl4wasOyVzl5BHYEb8CWYT4Nqli/bgANlKAbNAyINwej5IuiNuLB+jiyhV5q3/5
         HyaQ==
X-Gm-Message-State: AOAM533lBWP5ROYcCDNnJ3irrNdHOSr0MTpDSvrxDHbRV1cPgzq7Eo1W
        mNfNtxHCk8z0pyhjUrk3wE1mdQz82B3+sVCF/obbclSvcGWb9uAn0Qx5xW0DyKHfjUKQabRJ+sq
        Zy8vZWrOMyQhEhWpLUbtm
X-Received: by 2002:ac8:5c96:: with SMTP id r22mr10329898qta.228.1643648179335;
        Mon, 31 Jan 2022 08:56:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdFsgzSSF5gzbWdRjil6Lj2XO3rQpRNO3OMM186PlnCjUdmWFwjsZgsq2KaxG7+fNQoL7Ycw==
X-Received: by 2002:ac8:5c96:: with SMTP id r22mr10329882qta.228.1643648179071;
        Mon, 31 Jan 2022 08:56:19 -0800 (PST)
Received: from [172.31.1.6] ([71.161.85.11])
        by smtp.gmail.com with ESMTPSA id x18sm8807916qtw.93.2022.01.31.08.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 08:56:18 -0800 (PST)
Message-ID: <93005ced-1b8d-b769-e30c-b4f8b7375d2e@redhat.com>
Date:   Mon, 31 Jan 2022 11:56:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nfs-utils: tests: Skip test if /dev/log is missing
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Ben Hutchings <benh@debian.org>
References: <20220122194932.118951-1-carnil@debian.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220122194932.118951-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/22/22 14:49, Salvatore Bonaccorso wrote:
> From: Ben Hutchings <benh@debian.org>
> 
> Some build environments don't have a /dev/log, without which
> the daemons will fail to run.
> 
> * Add a check_dev_log function to skip a test if it's missing
> * Call it in t0001-statd-basic-mon-unmon.sh
> 
> Signed-off-by: Ben Hutchings <benh@debian.org>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Committed... (tag: nfs-utils-2-6-2-rc1)

steved.
> ---
>   tests/t0001-statd-basic-mon-unmon.sh | 3 ++-
>   tests/test-lib.sh                    | 9 +++++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/t0001-statd-basic-mon-unmon.sh b/tests/t0001-statd-basic-mon-unmon.sh
> index 92517a144851..e1065e766ccc 100755
> --- a/tests/t0001-statd-basic-mon-unmon.sh
> +++ b/tests/t0001-statd-basic-mon-unmon.sh
> @@ -21,8 +21,9 @@
>   
>   . ./test-lib.sh
>   
> -# This test needs root privileges
> +# This test needs root privileges and /dev/log
>   check_root
> +check_dev_log
>   
>   start_statd
>   if [ $? -ne 0 ]; then
> diff --git a/tests/test-lib.sh b/tests/test-lib.sh
> index e47ad13539ac..b62ac2a6db4d 100644
> --- a/tests/test-lib.sh
> +++ b/tests/test-lib.sh
> @@ -37,6 +37,15 @@ check_root() {
>   	fi
>   }
>   
> +# Most tests require /dev/log. Skip the test if it doesn't exist in this
> +# environment.
> +check_dev_log() {
> +	if ! [ -e /dev/log ]; then
> +		echo "*** Skipping this tests as it requires /dev/log ***"
> +		exit 77
> +	fi
> +}
> +
>   # is lockd registered as a service?
>   lockd_registered() {
>   	rpcinfo -p | grep -q nlockmgr

