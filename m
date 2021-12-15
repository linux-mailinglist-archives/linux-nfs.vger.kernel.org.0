Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA35476204
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Dec 2021 20:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhLOTmd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Dec 2021 14:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOTmc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Dec 2021 14:42:32 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EAC061574;
        Wed, 15 Dec 2021 11:42:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id p8so34968648ljo.5;
        Wed, 15 Dec 2021 11:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=70I3XKgjVxOnssN3Y7VD9oVCTE00v9aFYw9UJkkTL/8=;
        b=DJXGSRt8E2cwa0ZC2shtObOqEHrMtRABv/9p2t5PnNLPkoeAl4CUkB/RJ1UGcbF62P
         mcRn0z5zYGPZj9D0bwZslGBSgCoSm7cKbzCToML2/WX71GzFiFTfKsCMM9ZGfpOUGHOF
         GpiIWWr1ZDs8HA8n10waFZIU4Z43NDbL/3xmw0HQWs1tjjpxzwqIB8iPXp4BIL0szmnv
         LMBXGtr1eCW7aRMb1pf0OLZSBQkrCEGIuupRaPwj/g2yZiuHUWEXn9diE9rhVlZLBIj6
         Z1XexEQlUmWMyNTO9p5T3Vbf3AH9JsfCJZDi/JNBeFaoM//IsxEMIT1+rGFR6QrfuIr0
         TBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70I3XKgjVxOnssN3Y7VD9oVCTE00v9aFYw9UJkkTL/8=;
        b=b94kkFESjIHkE4N00m1sWQSefQCGnZaMdGa/ScTabMWenQUKIZVWSszQhItjUa9T30
         U85aUtFxDmpirwDZ6Qwgqs0vg7cw4j34vUPzuoivW/56FJ9rnxrYUlOVDMlPmpAGUDJr
         rZOMjNodndeOta0AXNBBHTJY+BzSUxMdcAvnjZU+f2zsv25+2jN+COSZZf/gn48z+i/3
         1yP+ltNapDIveFOcff4mWgY2LCLbRdg7mUfa3FZz8l6g+J7erN3od+t7mtHJirnpQk4T
         I9RpKzplyA76FH5ZYAZtZM17R4oXA0X0ig/0kMAiDyjgtQ0DnCaaYSMDOtv04v++2Xj5
         mzPQ==
X-Gm-Message-State: AOAM532DjkgVNIYUIsg8OaiGGj9OEDa2l2z3ThHJIOkKQeOy11jeXLmo
        DuiZ5AZR35+cvO6oDIWCtr4=
X-Google-Smtp-Source: ABdhPJyeuuVKsuBEw5JonRzmNW6Gb/En127TGwXzeaPtwAjOjS3c4C/2rtl40XGT974UjprJfiIoKA==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr11872791lja.118.1639597350753;
        Wed, 15 Dec 2021 11:42:30 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n7sm465439lfu.116.2021.12.15.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:42:29 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Dec 2021 20:42:27 +0100
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: Re: [PATCH] fs: nfs: sysfs: Switch to kvfree_rcu() API
Message-ID: <YbpFI7c8hSnbPixn@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-4-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 15, 2021 at 12:18:40PM +0100, Uladzislau Rezki (Sony) wrote:
> From: Uladzislau Rezki <uladzislau.rezki@sony.com>
> 
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> TO: Trond Myklebust <trond.myklebust@hammerspace.com>
> TO: linux-nfs@vger.kernel.org
> Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
> ---
>  fs/nfs/sysfs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index 8cb70755e3c9..ff88d5d58e1e 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -113,10 +113,9 @@ static ssize_t nfs_netns_identifier_store(struct kobject *kobj,
>  	if (!p)
>  		return -ENOMEM;
>  	old = rcu_dereference_protected(xchg(&c->identifier, (char __rcu *)p), 1);
> -	if (old) {
> -		synchronize_rcu();
> -		kfree(old);
> -	}
> +	if (old)
> +		kvfree_rcu(old);
> +
>  	return count;
>  }
>  
> -- 
> 2.30.2
> 
+ Trond Myklebust <trond.myklebust@hammerspace.com>                                                                                                                                    
+ linux-nfs@vger.kernel.org  

--
Vlad Rezki
