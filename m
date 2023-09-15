Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3217A28A7
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 22:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbjIOUu7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 16:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbjIOUu2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 16:50:28 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43271270E
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 13:49:43 -0700 (PDT)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTP
        id hFjkqQMhnWU1chFl0qThII; Fri, 15 Sep 2023 20:49:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFkzq6J9TlWQAhFl0qzW6I; Fri, 15 Sep 2023 20:49:42 +0000
X-Authority-Analysis: v=2.4 cv=INMRtyjG c=1 sm=1 tr=0 ts=6504c366
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=SEtKQCMJAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WPXWF77vQI3mRyN0nqVJHqF477a6uTsaeYOM8/wRXhs=; b=DGpiEzz9moDN7MXFfJ+t+Stxid
        CNygQrCWOzNMLuvdvxd9sCAdK/biMwSTztO9AgmKuDH6hnO3qb1m1sGAy7WBkES6ezICHbz6TD4aw
        m0Piym4aMYV7ZYKWWc7WHnw0ZP7dlEjmPURw/RNwsClAVWa90jWoXQr9AcXq46gW4U6ueMYaabRM3
        ES6TcINf4+GCir7e3KjDDCZurNlTeW5tqCH+l9dQ9cWSILRAQTO2Ajgh+uKm2CwgJAm+TD7YoFTfv
        EA8+qVQexXANmhL/azXEc2ZmBz6ubD4QDTcL6qrTxp2teXPhHGZcisWFiJNmSkq8S4VvQEJvpAa5I
        LZuXJ9dg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36918 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFky-002ewp-2W;
        Fri, 15 Sep 2023 15:49:40 -0500
Message-ID: <c36a8c7f-cb6a-cf32-3898-37159e363382@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:50:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] NFS/flexfiles: Annotate struct nfs4_ff_layout_segment
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201434.never.346-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201434.never.346-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFky-002ewp-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:36918
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 440
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNWurg4/RIxMx2CfdJT213droqBTSM7H5yC2FjGDUMBd5YLapcD6xRmvNX1Ou+zH4hbZh9/Vl99DAKALwK7Cz8jEfBqQbjuLGh8kIDhLA5sRFyHZPAVO
 LLxSTWA8nAAzHeJZNnO+QKZNfvK2VrGV9bu0VJCM2k7mONB33kv11rSCg5QGq/98boM43/miVcseowbIOes3k3KjvT0FoYf1ens=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/15/23 14:14, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfs4_ff_layout_segment.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   fs/nfs/flexfilelayout/flexfilelayout.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
> index 354a031c69b1..f84b3fb0dddd 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> @@ -99,7 +99,7 @@ struct nfs4_ff_layout_segment {
>   	u64				stripe_unit;
>   	u32				flags;
>   	u32				mirror_array_cnt;
> -	struct nfs4_ff_layout_mirror	*mirror_array[];
> +	struct nfs4_ff_layout_mirror	*mirror_array[] __counted_by(mirror_array_cnt);
>   };
>   
>   struct nfs4_flexfile_layout {
