Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D470EC9A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 06:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjEXElU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 May 2023 00:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEXElT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 May 2023 00:41:19 -0400
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 21:41:18 PDT
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA32119
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 21:41:18 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id 1bC1qCvNoQFHR1gHpqcg8T; Wed, 24 May 2023 04:39:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 1gHoq0TjHdNGj1gHpquJr9; Wed, 24 May 2023 04:39:45 +0000
X-Authority-Analysis: v=2.4 cv=XtPphHJ9 c=1 sm=1 tr=0 ts=646d9511
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=2OZTvG03Zy49M_lQ8uoA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vEhgjlTSMZ2idYpm+0XIdDGZ5cANpn8hdQCwS9DpvY8=; b=CDm3BxOJUfFQ0aC3JKbOmtYcoV
        dgmV+IyMAoJveixsNEoU69GqUuzmrcvuic5RgJZfZs70T9AIlVS4CdjXNPMT5A51V95iY6ClY+6at
        7agr55+pBcBVrlGAh6vVvxx5pwK95uiJ21dndNlpiiFwz1dovJVqtahM0es+RCnxfzZVYdVLxYYRo
        1q8z3nVg2umNvWU5ykomtiPrq73S+vC0vU1QCdsd6cSQvf6Sl2ZUXUatbdGywcde79h450ONQAeA+
        /d8pqcDXWJT+uvfJBN7Graj27OLow5sszowfxX10ZGPGXt9QDs4Vn4lS84ZdsN6O++azE8t66ZpQG
        8rvt8WIg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:33692 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1q1dVF-0004pM-GV;
        Tue, 23 May 2023 20:41:25 -0500
Message-ID: <136d72e5-287c-ebaf-c1e1-92b10e68ba8d@embeddedor.com>
Date:   Tue, 23 May 2023 19:42:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] nfsd: Replace one-element array with flexible-array
 member
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dai.ngo@oracle.com
References: <ZG1d51tGG4c97qqb@work> <ZG1iBLw85MxtysWI@manet.1015granger.net>
 <4b9c7386-c2b1-2eb7-d248-ddfdc3c2cd1f@embeddedor.com>
 <ZG1o2LFiRekz/pMy@manet.1015granger.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZG1o2LFiRekz/pMy@manet.1015granger.net>
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
X-Exim-ID: 1q1dVF-0004pM-GV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:33692
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMYhrRmp4dnnAP19+EePrfGSBrtlz7lAQ0qw03vzl+Lj3h+Bwnu6ysUHnQ9AcoKSkbTrFBBd1K4RUjmVG6kuDWhBvpfHM+R0ADi2zROoFjgZA79cWFjU
 /LX7YkdDYbmJ5e4FotYs3bufTkDTrZqx1orbyp/H5C/jo90CtapduUJwoorbfZPFacQ4L9ScbV4/C8DCFpmsI4dHDqPLrMJyNFwzvM6yA7BMaYqc8I6zPpP2
 L7YxHortO1Z/85PrEaa3ha7fCpBdlMTJCTr1J/a7GDkwzUXw0c6+AJst8VjUP5LmnvsJs1j8hDWWbqGqGgYJcg==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/23/23 19:31, Chuck Lever wrote:
> On Tue, May 23, 2023 at 07:11:37PM -0600, Gustavo A. R. Silva wrote:
>>
>> On 5/23/23 19:01, Chuck Lever wrote:
>>> On Tue, May 23, 2023 at 06:44:23PM -0600, Gustavo A. R. Silva wrote:
>>>> One-element arrays are deprecated, and we are replacing them with
>>>> flexible array members instead. So, replace a one-element array
>>>> with a flexible-arrayº member in struct vbi_anc_data and refactor
>>>
>>> I don't know what "struct vbi_anc_data" is. Is the patch description
>>> correct?
>>
>> Oops, copy/paste error. I'll fix it up. :)
>>
>>>
>>>
>>>> the rest of the code, accordingly.
>>>>
>>>> This results in no differences in binary output.
>>>>
>>>> Link: https://github.com/KSPP/linux/issues/79
>>>> Link: https://github.com/KSPP/linux/issues/298
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>
>>>> ---
>>>>    fs/nfsd/nfs4callback.c | 2 +-
>>>>    fs/nfsd/xdr4.h         | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>> index 4039ffcf90ba..2c688d51135d 100644
>>>> --- a/fs/nfsd/nfs4callback.c
>>>> +++ b/fs/nfsd/nfs4callback.c
>>>> @@ -353,7 +353,7 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
>>>>    {
>>>>    	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
>>>>    	encode_uint32(xdr, ra->ra_keep);
>>>> -	encode_bitmap4(xdr, ra->ra_bmval, ARRAY_SIZE(ra->ra_bmval));
>>>> +	encode_bitmap4(xdr, ra->ra_bmval, 1);
>>>
>>> I find the new code less self-documenting.
>>>
>>>
>>>>    	hdr->nops++;
>>>>    }
>>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>>> index 510978e602da..68072170eac8 100644
>>>> --- a/fs/nfsd/xdr4.h
>>>> +++ b/fs/nfsd/xdr4.h
>>>> @@ -899,7 +899,7 @@ struct nfsd4_operation {
>>>>    struct nfsd4_cb_recall_any {
>>>>    	struct nfsd4_callback	ra_cb;
>>>>    	u32			ra_keep;
>>>> -	u32			ra_bmval[1];
>>>> +	u32			ra_bmval[];
>>>
>>> This is not a placeholder for "1 or more elements". We actually want
>>> just a single u32 element in this array. Doesn't this change the
>>> sizeof(struct nfsd4_cb_recall_any) ?
>>
>> I see. Yes, it does change the size. Can we replace it with a simple
>> object of type u32? or do you actually need this to stay an array?
> 
> It's not impossible to make it a scalar u32, however...
> 
> In this area of code, *_bmval is always a bitmap -- an array of u32s.
> Helpers like encode_bitmap4() assume an array. I think it would be
> less confusing overall to human readers if it remained an array.
> 
> In this case, it is a single element array because CB_RECALL_ANY
> doesn't happen to use bits above the first 32-bit word of the
> bitmap.

I see. If this is never going to be treated as a flexible array, then
it can stay as is.

-fstrict-flex-arrays=3 should not warn about this because the array
will never ever be tried to be accessed beyond element 1. :)

Thanks for the feedback!
--
Gustavo

> 
> We could make it a 2-element array, I think, without harm. Send a
> patch for that, and Dai can test it to make sure there are no
> unexpected interoperability consequences.
> 
> I hope that would avoid suspicious-looking array definitions.
> 
> 
>>>>    };
>>>>    #endif
>>>> -- 
>>>> 2.34.1
>>>>
