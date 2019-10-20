Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12ACDDEBD
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Oct 2019 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfJTNug (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Oct 2019 09:50:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46651 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfJTNug (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Oct 2019 09:50:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so6637018pfg.13;
        Sun, 20 Oct 2019 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9efnMENP/VJVkPlRfJzxJpy/Qvr8rPVnQoIn87fOb8E=;
        b=L7j1pM2LrLyr78v19iv75LxcO/y4D45ZfSOqxCCX36Dn2h5YoLYNmVWPK1FBI0Xk7i
         b3FJnGZd5S06xuf3M8LwTvR+jYodxY23AnnYV6Wp8Cndbls8MznvaMPrghuZDu570xaB
         +RC3iCM5xAZmtfnHOB63H7x281rz+BGv3fABEpO/mqHwzTYioJQkADpjgHUADYGGuMf7
         y2ZUmc+nqRFljoK7NzJNG0Q+GtASyUwpXydCTVBC+KlUjNX6IoMGZwUWyx9exwsNTxhn
         K2K2taO6IBDsENi+CnjGEDE44KzunHDYTAwbvmzYtXJ2iaiRS7ltNdfJSzd+d0FbwXZJ
         R2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9efnMENP/VJVkPlRfJzxJpy/Qvr8rPVnQoIn87fOb8E=;
        b=sFFLBAbfTVOFMeZdHgh/dfyRkPVPBoWRTWoVd06HfZnY7nck2+ZLUkysSW/DSaCI8i
         DuNzF+MDvEkSpKSf/pt8Mh4VhRNWWJH6Q4sbFuajSwGUtDHfNRmGCjLhyewP01E3m9gG
         hB2x5m4TYuKzb4g/Mwk8DgZGCmeJeXEszk7QT28ZoallA7KJc/XkGX5BZf2kdpFaLluH
         iVDfBG7jAyn1+Fn2rUJ7cYl/0HeGOria9UxIGDAFMdcrRMNYAwsV0WPcYt3HTDrUR67F
         iNr446VheqRDRXl21l4J4cNOCSUewTXBEEORvZUwIfM94ZjXHMoRCLVp7R//SOW+OzhQ
         XA+g==
X-Gm-Message-State: APjAAAVxn5aXK/ya2EXE3LexbMVxiXIXdAQ8y9jFTLucHqNpntfkhjOJ
        sq6lD+wq+iKjLCS7gTpWXaI=
X-Google-Smtp-Source: APXvYqxa+Jn8YcDQAqzGNhOlQ45bBQMN6M730g13TN9diCOGZGFhV7puabK8tK8mkfWsVUSmmQCMWg==
X-Received: by 2002:a63:6f02:: with SMTP id k2mr20797283pgc.163.1571579435452;
        Sun, 20 Oct 2019 06:50:35 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id s18sm12335203pji.30.2019.10.20.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 06:50:34 -0700 (PDT)
Date:   Sun, 20 Oct 2019 21:50:28 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     schumaker.anna@gmail.com
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        Anna.Schumaker@netapp.com
Subject: Re: [PATCH 2/2] generic: 448 shouldn't delete $BASE_TEST_FILE if it
 isn't set yet
Message-ID: <20191020135028.GA2543@desktop>
References: <20191018173343.303032-1-Anna.Schumaker@Netapp.com>
 <20191018173343.303032-2-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018173343.303032-2-Anna.Schumaker@Netapp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 18, 2019 at 01:33:43PM -0400, schumaker.anna@gmail.com wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> NFS v4.2 supports SEEK_DATA and SEEK_HOLE, but earlier versions do not.
> As a result, the test exits and runs the cleanup function without the
> $BASE_TEST_FILE variable set and the shell expands it to "rm -f .*",
> deleting all hidden files in the current directory.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  tests/generic/448 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/448 b/tests/generic/448
> index dada499b..d6cdebbf 100755
> --- a/tests/generic/448
> +++ b/tests/generic/448
> @@ -17,7 +17,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _cleanup()
>  {
> -	rm -f $tmp.* $BASE_TEST_FILE.*
> +	rm -f $tmp.*
> +	[ ! -z $BASE_TEST_FILE ] && rm -f $BASE_TEST_FILE.*
>  }

I'd just define BASE_TEST_FILE before _cleanup (and did it on commit).
Thanks for the fix!

Eryu
>  
>  # get standard environment, filters and checks
> -- 
> 2.23.0
> 
