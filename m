Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA14349453
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhCYOjw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 10:39:52 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.251]:20982 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhCYOjs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 10:39:48 -0400
X-Greylist: delayed 1278 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 10:39:48 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 0389AA26B
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 09:18:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id PQoWlldsMmJLsPQoWlS4a9; Thu, 25 Mar 2021 09:18:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ftWEDx8v476hGOZEcPFPchsIBVQcBxVefriypsWkOc8=; b=kD/h5OHFeyxFsVx3dDayCG9hzk
        aE2yU+0QElXNw+W4f29/uEglzeoqZyJNjWrcmWlaZujl6IzVIdfgYyzYjBAWdgZUPRGo3LTiSzvtQ
        Au5XKzQJGTpmQ91qKWm0Fv9tX5XFGg1TCiYzSJKreVaeeDxvfa+AxEchFrD26Iy9YYxGqaU0u9p6j
        UvIVOF14+OAO2tWGRKfaJzl72SM+aeszkSOw7VIlvUzm7rYvxlrhRikDKd7xW876xsGVD5zChhgkk
        kKp09cNAczXKzsaggpL9DFtFvjvK+VroFpKHoOKeKl3HG+tHtntCcSChIZtRR1+23/jmNvG20yRqe
        HVn34eNg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:45782 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lPQoW-004LKQ-EH; Thu, 25 Mar 2021 09:18:20 -0500
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
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5331b4e2-eeef-1c27-5efe-bf3986fd6683@embeddedor.com>
Date:   Thu, 25 Mar 2021 08:18:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <629154ce566b4c9c9b7f4124b3260fc3@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lPQoW-004LKQ-EH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:45782
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/25/21 08:45, David Laight wrote:
> From: Gustavo A. R. Silva
>> Sent: 23 March 2021 22:49
>>
>> There is a regular need in the kernel to provide a way to declare having
>> a dynamically sized set of trailing elements in a structure. Kernel code
>> should always use “flexible array members”[1] for these cases. The older
>> style of one-element or zero-length arrays should no longer be used[2].
>>
>> Use an anonymous union with a couple of anonymous structs in order to
>> keep userspace unchanged:
>>
>> $ pahole -C nfs_fhbase_new fs/nfsd/nfsfh.o
>> struct nfs_fhbase_new {
>>         union {
>>                 struct {
>>                         __u8       fb_version_aux;       /*     0     1 */
>>                         __u8       fb_auth_type_aux;     /*     1     1 */
>>                         __u8       fb_fsid_type_aux;     /*     2     1 */
>>                         __u8       fb_fileid_type_aux;   /*     3     1 */
>>                         __u32      fb_auth[1];           /*     4     4 */
>>                 };                                       /*     0     8 */
>>                 struct {
>>                         __u8       fb_version;           /*     0     1 */
>>                         __u8       fb_auth_type;         /*     1     1 */
>>                         __u8       fb_fsid_type;         /*     2     1 */
>>                         __u8       fb_fileid_type;       /*     3     1 */
>>                         __u32      fb_auth_flex[0];      /*     4     0 */
>>                 };                                       /*     0     4 */
>>         };                                               /*     0     8 */
>>
>>         /* size: 8, cachelines: 1, members: 1 */
>>         /* last cacheline: 8 bytes */
>> };
> 
> Could you use the simpler:
>> struct nfs_fhbase_new {
>>          __u8       fb_version;
>>          __u8       fb_auth_type;
>>          __u8       fb_fsid_type;
>>          __u8       fb_fileid_type;
>>          union {
>>                 __u32      fb_auth[1];
>>                 __u32      fb_auth_flex[0];
>>          };
>> };
> 
> Although I'm not certain flexible arrays are supported
> as the last element of a union.

Nope; this is not allowed: https://godbolt.org/z/14vd4o8na

--
Gustavo
