Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA1416916
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 02:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbhIXAwx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Sep 2021 20:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXAww (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Sep 2021 20:52:52 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC9C061574;
        Thu, 23 Sep 2021 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Cc:To:From:Date;
        bh=CWVoHnd9YD9j5Yfm2Ruc2Ef0D19E5HElFIQwBIliFRI=; b=1lHliXFsFSgfm1zry+IZ6HB6Xg
        ZSJNdfTICvIWjmQ/Zl8b10WaII6d01xGsSLut7hm/ixypObNm/jZaeHwJY0jSXovqClylEvlGeJF+
        nndX8mtTeg12WWYjT/IbQ7fOsVJdlWv/825t86zLSxkUwLkNArDjiIojUPobHH7Fc6ryuKDpcTSOB
        sXMh9UDM57eVjJXO6CB04Of/yCvhsWDlN7syxgNtKJHR5Deyu7wnDGs6zWg/1i38bIyWAf04ZFXXD
        dDkvlwgBitEn8JTinx3asfrZSoqrS8yYRr9ceWZItn+B3inCRGqXxdWFEH95eTFsH8cfSnF683S/s
        lyrI1SFdkdT/tZwWkrrcD3SrPgMhTq8eFwRVc5ILRXkHX3QdraHdjEPE2MaW3yp8ehpvz4POyepRy
        Ij/uyHHH7DausEvjCDnYEom5+eSkfjouBZp18z+Ww/42Ic4hOph7+Mpf7waxsutEoV3dYdfANVTL/
        pAQ4fkzV5hlZpPrNt6UjOxQ+;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mTZQq-007an9-LO; Fri, 24 Sep 2021 00:51:17 +0000
Date:   Thu, 23 Sep 2021 17:51:13 -0700
From:   Jeremy Allison <jra@samba.org>
To:     dai.ngo@oracle.com
Cc:     Bruce Fields <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Message-ID: <YU0hAYLow+8n8siT@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90a8f89b-e8ac-2187-2926-d723ebbcb839@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 23, 2021 at 03:39:52PM -0700, dai.ngo@oracle.com wrote:
>
>On 9/23/21 2:50 PM, Bruce Fields wrote:
>>On Thu, Jul 15, 2021 at 04:45:22PM -0700, dai.ngo@oracle.com wrote:
>>>Hi Bruce,
>>Oops, sorry for neglecting this.
>>
>>>I'm doing some locking testing between NFSv4 and SMB client and
>>>think there are some issues on the server that allows both clients
>>>to lock the same file at the same time.
>>It's not too surprising to me that getting consistent locks between the
>>two would be hard.
>>
>>Did you get any review from a Samba expert?  I seem to recall it having
>>a lot of options, and I wonder if it's configured correctly for this
>>case.
>
>No, I have not heard from any Samba expert.
>
>>
>>It sounds like Samba may be giving out oplocks without getting a lease
>>from the kernel.
>
>I will have to circle back to this when we're done with the 1st
>phase of courteous server.
>
>-Dai
>
>>
>>--b.
>>
>>>Here is what I did:
>>>
>>>NOTE: lck is a simple program that use lockf(3) to lock a file from
>>>offset 0 to the length specified by '-l'.

What does lockf map to in NFS ?

Samba only uses posix fcntl byte range locks (and only when
told to map SMB locks onto underlying posix locks), we don't use
lockf at all.
