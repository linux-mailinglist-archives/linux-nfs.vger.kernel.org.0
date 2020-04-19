Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6E1AF8F5
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2020 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDSJcR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgDSJcQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 05:32:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6B7C061BD3
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 02:32:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so6601110ljn.7
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/v/9MZ85W5Ot6ZouiFIXv368NZt8k8Og0OLJDhh34+s=;
        b=NH0bulwrsnvt31tchVdyynbpbLgVBI1HP3Wa6GOh5EZ3Avqvjt8Ws1W0S4skKIE0JE
         uuFvwHnFs3oUQXVFI6Uw/i025gYebahgui03U0O2zWDkm//77OlUL2W1AKMBSb9Ajkej
         pH7FGvf7PIw3hRxqcpxFEFxOgYR/zkwsdko5P7TmbImGk2kTGiNw6chaFyxITHjQVqFY
         uRAVMZmeGktYjCkJxVm65ElzX8WYSVJ2k7Gs01avu1wVrvwPeK6V94oh93DTqReUmhv8
         6bEZuutMc2hlHCS5Rb8vzRuhQ8/sT8T6SFBRcGie5PJZH40vg8BxIcQxKKnbEzWKi12i
         ZLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/v/9MZ85W5Ot6ZouiFIXv368NZt8k8Og0OLJDhh34+s=;
        b=nfsK9D6pnwZhI9LigUjafZUedNRcQBYH8le3UUWNQGFEFkxUgWdr+sAUk+y42QJm4t
         d461SoDRYL3K3152LoCoNcyRs3r7E8HkCG4yBzYkmcfX0RgV2twVIGHymoFtX4FFrWoM
         2ebJJn8c0MZ2xpyGKHoL7Zv5LtcQZj2VF2K890/7peVttGXDWimLOOhrh9V3uKGhQKn/
         q4n2ithQ8p4h5w3LdqDEZNhRsbE2n3Nu1JdvbK6+YdPkI876iXMG5ub5aLPEEQrC1Giu
         3jiOMvd+CHW14mbSxnLVJMzntG1WRLMuXjKW+Qkw3CpspXL3YPq/TDn+GeEpGhCjlpm4
         IICw==
X-Gm-Message-State: AGi0PuaBvjhTzSXt4QTZ3KbsKRwecpR5VUBCpQtVbk84RszCfKL9HcTI
        S4l5uXBgi+keP9MFAvGWXWCmfg==
X-Google-Smtp-Source: APiQypJtvjJEzhQ3IHjsR97nXY/X5+Mcqe2YVVnhcTkS4j8mOhshGgkVFOM17f0YxUmtnPiWj9nvZA==
X-Received: by 2002:a2e:4942:: with SMTP id b2mr7168793ljd.135.1587288733899;
        Sun, 19 Apr 2020 02:32:13 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:2a7:ba19:e1ca:ac28:cceb:53f3? ([2a00:1fa0:2a7:ba19:e1ca:ac28:cceb:53f3])
        by smtp.gmail.com with ESMTPSA id 64sm20404911ljj.41.2020.04.19.02.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 02:32:13 -0700 (PDT)
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <34fe524d-f9f0-ba8a-d5cb-ffbeacf1b5d8@cogentembedded.com>
Date:   Sun, 19 Apr 2020 12:32:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418184111.13401-7-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello!

On 18.04.2020 21:41, Randy Dunlap wrote:

> Fix gcc empty-body warning when -Wextra is used:
> 
> ../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: linux-nfs@vger.kernel.org
> ---
>   fs/nfsd/nfs4state.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-next-20200417.orig/fs/nfsd/nfs4state.c
> +++ linux-next-20200417/fs/nfsd/nfs4state.c
[...]
> @@ -3895,7 +3896,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
>   		copy_clid(new, conf);
>   		gen_confirm(new, nn);
>   	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
> -		;
> +		do_empty();

    In this case explicit {} would probably have been better, as described in 
Documentation/process/coding-style.rst, clause (3).

MBR, Sergei
