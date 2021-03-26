Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7865634AB91
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Mar 2021 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCZPdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Mar 2021 11:33:39 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.122]:13310 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbhCZPd0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Mar 2021 11:33:26 -0400
X-Greylist: delayed 1370 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 11:33:26 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0F863A4A6
        for <linux-nfs@vger.kernel.org>; Fri, 26 Mar 2021 10:10:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Po6MlMdL81cHePo6Nlnzf1; Fri, 26 Mar 2021 10:10:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=js4fUDxJZ+1hiSlK8YxajbpFu59Q14OV5p4s8fmb3TU=; b=jVuz05LKRIVx3o+AlLL6Z8MH80
        hLFm9BUeqA2NXF2jjSE8Spj64p6YYMAsEOxVKNEJZhgfWlr2oYAcpra5FdwZBDNVsYQ+r5hCZ0Wgo
        voCY9zCGp8kxirFh3Yuq7TdyGl4KaUGxZQKsEDOjqQjqoDAfaR78N2MmXKtlJZNEvlgVO763QpJxb
        gIKY94VV1XYesYeXRlHZbyTQVWUvxYVuNMcAPBRPzJaSWKyce7lUkhtcWAa2qY6WgI8S+Ksg0j+aG
        rpZcJWL5lM3GYT/+Z244hK2wuXt+m/vrVLFuAErFIBbjKHsIga+kFmqUyN++o8uExWqLy1XLO2++N
        64vei9BA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33932 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lPo6L-00359B-EE; Fri, 26 Mar 2021 10:10:17 -0500
Subject: Re: [PATCH][next] UAPI: nfsfh.h: Replace one-element array with
 flexible-array member
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Gustavo A. R. Silva'" <gustavoars@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20210323224858.GA293698@embeddedor>
 <629154ce566b4c9c9b7f4124b3260fc3@AcuMS.aculab.com>
 <5331b4e2-eeef-1c27-5efe-bf3986fd6683@embeddedor.com>
 <1efa90cc6bc24cfb860084e0b888cd4b@AcuMS.aculab.com>
 <e2e93993-e64b-ce7d-88cf-4c367b747e40@embeddedor.com>
 <e516146427db45439c02afe57ce06e97@AcuMS.aculab.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <7a93d5da-04da-f283-3882-bc130e38e8eb@embeddedor.com>
Date:   Fri, 26 Mar 2021 09:10:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e516146427db45439c02afe57ce06e97@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lPo6L-00359B-EE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:33932
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/26/21 03:17, David Laight wrote:
> From: Gustavo A. R. Silva
>> Sent: 25 March 2021 21:12
>>
>> On 3/25/21 10:29, David Laight wrote:
>>
>>>>>
>>>>> Could you use the simpler:
>>>>>> struct nfs_fhbase_new {
>>>>>>          __u8       fb_version;
>>>>>>          __u8       fb_auth_type;
>>>>>>          __u8       fb_fsid_type;
>>>>>>          __u8       fb_fileid_type;
>>>>>>          union {
>>>>>>                 __u32      fb_auth[1];
>>>>>>                 __u32      fb_auth_flex[0];
>>>>>>          };
>>>>>> };
>>>>>
>>>>> Although I'm not certain flexible arrays are supported
>>>>> as the last element of a union.
>>>>
>>>> Nope; this is not allowed: https://godbolt.org/z/14vd4o8na
>>>
>>> Nothing an extra 'struct {__u32 fb_auth_flex[0]; }'; won't solve.
>>
>> We don't want to introduce zero-length arrays [1].
> 
> I probably meant to write [] not [0] - doesn't affect the idea.
> 
> The real problem is that the compiler is likely to start rejecting
> references to a flex array that go beyond the end of the outer
> structure.
> 
> Thinking back, isn't fb_auth[] at least one entry long?
> So it could be:
> 
> struct nfs_fhbase_new {
>          __u8       fb_version;
>          __u8       fb_auth_type;
>          __u8       fb_fsid_type;
>          __u8       fb_fileid_type;
>          __u32      fb_auth[1];
>          __u32      fb_auth_extra[];
> };

I don't think this is a great idea because, contrary to the change I'm
proposing, in this case memory regions for fb_auth and fb_auth_extra
don't actually overlap.

--
Gustavo
