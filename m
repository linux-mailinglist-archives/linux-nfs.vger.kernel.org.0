Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FAD70EA94
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 03:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjEXBMR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 21:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjEXBMQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 21:12:16 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 18:12:15 PDT
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9205C2
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 18:12:15 -0700 (PDT)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTP
        id 1b1QqJHmJDKaK1d1Yq1DOD; Wed, 24 May 2023 01:10:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 1d1XqqTcCOdlB1d1XqIDx0; Wed, 24 May 2023 01:10:43 +0000
X-Authority-Analysis: v=2.4 cv=RojWkQqK c=1 sm=1 tr=0 ts=646d6413
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=orp-BCEoM74pqhqP2woA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X6Bfs2NirSTuyYKcIwWtn8/xbc1NS51nC8d/9E8h0VU=; b=FqKdLP0bTeiq+gmyk1tAX6im89
        BTBrguqK7dfymPyv5hq8/LvDjl2KzCKGuo3ddtASxvI1zHDZZPwubJonX3wOJpyx2iRTXB2lRxp8f
        jTDdKU2DnxxqUdeAiH5gvSvf85dPABJkfp/DGS5wAzUBYlSMC07at7nB56IdTHVm6F71gxLaCVcCC
        ZRAKk1FrDU/jtrL1dwgGgdPS5zen27pHEmKXtdMwqw6YeB4DIYL5/scKIdkhPi9Q87trwPsPQ66xw
        Be5lshwClKlfO1biv1OA4BxW6+BEevVW3VwCZM0fOT9CQ/l8K1uPwmwYOjK+1g2JGH9pHYLu0m+rN
        ZxHVsz/A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:35220 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1q1d1W-00423O-VT;
        Tue, 23 May 2023 20:10:43 -0500
Message-ID: <4b9c7386-c2b1-2eb7-d248-ddfdc3c2cd1f@embeddedor.com>
Date:   Tue, 23 May 2023 19:11:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] nfsd: Replace one-element array with flexible-array
 member
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZG1d51tGG4c97qqb@work> <ZG1iBLw85MxtysWI@manet.1015granger.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZG1iBLw85MxtysWI@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1q1d1W-00423O-VT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:35220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKMLneWDmAkfYJzr79xwBxOIW7gsjMWFIMccxvzyhaqUaA+9fiSguMSK3zHRufYnc75yduxVBte2eMBueTWVeai+/z0JvwE1OMNqROtdK98JMQFFCGtQ
 Qg9iY7ZPMrmNp8G2Set2YDmsvDdumJfRIsvKmz4pj/vECJEVBPjx3Y6Kc5SCIk6BCUcDXLb2qfCuC8IXwMRe8PFIhqyHZ8dySHQ=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/23/23 19:01, Chuck Lever wrote:
> On Tue, May 23, 2023 at 06:44:23PM -0600, Gustavo A. R. Silva wrote:
>> One-element arrays are deprecated, and we are replacing them with
>> flexible array members instead. So, replace a one-element array
>> with a flexible-arrayº member in struct vbi_anc_data and refactor
> 
> I don't know what "struct vbi_anc_data" is. Is the patch description
> correct?

Oops, copy/paste error. I'll fix it up. :)

> 
> 
>> the rest of the code, accordingly.
>>
>> This results in no differences in binary output.
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/298
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
>> ---
>>   fs/nfsd/nfs4callback.c | 2 +-
>>   fs/nfsd/xdr4.h         | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index 4039ffcf90ba..2c688d51135d 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -353,7 +353,7 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
>>   {
>>   	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>>   	encode_uint32(xdr, ra->ra_keep);
>> -	encode_bitmap4(xdr, ra->ra_bmval, ARRAY_SIZE(ra->ra_bmval));
>> +	encode_bitmap4(xdr, ra->ra_bmval, 1);
> 
> I find the new code less self-documenting.
> 
> 
>>   	hdr->nops++;
>>   }
>>   
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index 510978e602da..68072170eac8 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -899,7 +899,7 @@ struct nfsd4_operation {
>>   struct nfsd4_cb_recall_any {
>>   	struct nfsd4_callback	ra_cb;
>>   	u32			ra_keep;
>> -	u32			ra_bmval[1];
>> +	u32			ra_bmval[];
> 
> This is not a placeholder for "1 or more elements". We actually want
> just a single u32 element in this array. Doesn't this change the
> sizeof(struct nfsd4_cb_recall_any) ?

I see. Yes, it does change the size. Can we replace it with a simple
object of type u32? or do you actually need this to stay an array?

Thanks
--
Gustav

> 
> 
>>   };
>>   
>>   #endif
>> -- 
>> 2.34.1
>>
