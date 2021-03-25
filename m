Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B5349CA4
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Mar 2021 00:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhCYXBx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 19:01:53 -0400
Received: from gateway20.websitewelcome.com ([192.185.44.20]:26919 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231191AbhCYXBa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 19:01:30 -0400
X-Greylist: delayed 1498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 19:01:30 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 756D9400CF499
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 17:02:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id PYDOltgAUMGeEPYDOlZrfD; Thu, 25 Mar 2021 17:12:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7TQTeKIn3sX0KsX2Mb0uRTUpgZvCak4GKsqbc414Wao=; b=pM3ggMFhvLF1rSSPG2yQdv1Gf1
        NxC1t9XwOXj0/2/YYBi+vEA/Ev2EUruApSVMDory3nxcvUjnf8jds2BGwgkqXkDNRRnThzGZX9H/W
        K0PThy6C9tomaK5gJ0yQ8IgIT956p7vP0qQJO7eHH1BXeJmbRbVdDcspBqtxoCskps4+j2Rk5NHdw
        tCdz7LWXpsW8HVYHbKIdRkMVB0HafwSazDaJfsxgD9cZTh6m+wMABD0hldJFHg9ABOcTbjSzKJp+S
        xYApizT15wf8vdktx8+BOO9uJCQ7vMOZBdoV/+pQF2gLCjKhMYwo/ufi73PKmsOwVJg9NVr8qkY0X
        PwBFs7QA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49220 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lPYDO-003hVs-2j; Thu, 25 Mar 2021 17:12:30 -0500
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
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <e2e93993-e64b-ce7d-88cf-4c367b747e40@embeddedor.com>
Date:   Thu, 25 Mar 2021 16:12:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1efa90cc6bc24cfb860084e0b888cd4b@AcuMS.aculab.com>
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
X-Exim-ID: 1lPYDO-003hVs-2j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/25/21 10:29, David Laight wrote:

>>>
>>> Could you use the simpler:
>>>> struct nfs_fhbase_new {
>>>>          __u8       fb_version;
>>>>          __u8       fb_auth_type;
>>>>          __u8       fb_fsid_type;
>>>>          __u8       fb_fileid_type;
>>>>          union {
>>>>                 __u32      fb_auth[1];
>>>>                 __u32      fb_auth_flex[0];
>>>>          };
>>>> };
>>>
>>> Although I'm not certain flexible arrays are supported
>>> as the last element of a union.
>>
>> Nope; this is not allowed: https://godbolt.org/z/14vd4o8na
> 
> Nothing an extra 'struct {__u32 fb_auth_flex[0]; }'; won't solve.

We don't want to introduce zero-length arrays [1].

--
Gustavo

[1] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
