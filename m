Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9776DEB7
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 05:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHCDIq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 23:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjHCDIp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 23:08:45 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 175951BD9;
        Wed,  2 Aug 2023 20:08:43 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 374596082CF9F;
        Thu,  3 Aug 2023 11:08:35 +0800 (CST)
Message-ID: <414e987b-df9f-53c9-6455-4a2d10f7fcf5@nfschina.com>
Date:   Thu, 3 Aug 2023 11:08:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs: lockd: avoid possible wrong NULL parameter
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        bfields@fieldses.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <0bd584fd-74ac-4b08-ae03-12e329ab186e@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,RDNS_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/8/2 18:41, Dan Carpenter wrote:
> There was a big fight about memcpy() in 2010.
>
> https://lwn.net/Articles/416821/
>
> It's sort of related but also sort of different.  My understanding is
> that the glibc memcpy() says that memcpy() always does a dereference so
> it can delete all the NULL checks which come after.  The linux kernel
> uses -fno-delete-null-pointer-checks to turn this behavior off.
Really big fight!
This article seems talk about  problem that using memcpy() to copy 
overlapping regions.
I'm not sure glibc memcpy does the check about NULL， but glibc printf 
does this check.
"And GNU libc checks strings passed to printf for a %s placeholder for 
NULL,
when the C standard says this is not allowed."[1]
[1] https://lwn.net/Articles/416821/
>
> regards,
> dan carpenter
