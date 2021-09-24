Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF18E4178F4
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Sep 2021 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbhIXQjd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Sep 2021 12:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343566AbhIXQjb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Sep 2021 12:39:31 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510B4C061341;
        Fri, 24 Sep 2021 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Cc:To:From:Date;
        bh=lzUeJ+4kZd7Ayna9U940FUPwzjtpH0TmHUffMOzWM2E=; b=143dSYVJN+2rQkyAn/EwIvWBqS
        bYmcELM90z/VGQxpu3AY3zVAhzAVb/5RuQ8uT5LnuRDkHmF3nECEnjcs0QsrXUY0tKAWqDdUnkYvz
        jUrG+7eY92zLlh3/G5tzvM2RngUmvTvZ24V4qgkCOFsQv+X7ZwnOp/38GAL0LdxiV2A3XBOV/LRWm
        Hc1gS5ZYLJVeheY53a6cguNomdIihReaRoAuNhfLZzPEhyg3idYugqHoiCE5x/8U9eQhXSzW4XAEB
        N6XLicjc8ZF21cZsQcNt6HsCTjtwo53vmnPAygQqVf7XeC5ANKxdVx3MHr/QOiLMCuZVAa6Ji+N2l
        IK2zytkPwDIX+hUWsTsOjCPeELxTS7NejL/4TU8755+jDdWbfDgIBA6WVtqvEEAcAZYW056m6+QvG
        b+Qg6Uou6soWzHP/gw2Jll7FosoCBVCdRTq49TdGAfuKxnp1qllBXq/8QkW1VGPKvdRCqG1KoXdNL
        Ft0Ww8xpjEJpvlJXuk8QskcP;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mToBt-007iMl-Lv; Fri, 24 Sep 2021 16:36:50 +0000
Date:   Fri, 24 Sep 2021 09:36:46 -0700
From:   Jeremy Allison <jra@samba.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "slow@samba.org" <slow@samba.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: Locking issue between NFSv4 and SMB client
Message-ID: <YU3+nhUW+xSzjIhD@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <5b7be2c0-95a6-048c-581f-17e5e3750daa@oracle.com>
 <20210923215056.GH18334@fieldses.org>
 <48b3a41e2dbea7948b0df3fea002208a273409fd.camel@hammerspace.com>
 <f4b9eb02-73e6-f082-6657-87a007b99198@samba.org>
 <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ea40f67038f822d13407becb7e4eedc31e5edbb0.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 24, 2021 at 04:13:23AM +0000, Trond Myklebust wrote:
>On Fri, 2021-09-24 at 05:46 +0200, Ralph Boehme wrote:
>> Am 24.09.21 um 05:35 schrieb Trond Myklebust:
>> > Not if you set the "kernel oplocks" parameter in the smb.conf file.
>> > We
>> > just added support for this in the Linux 5.14 kernel NFSv4 client.
>> >
>> > Now that said, "kernel oplocks" will currently only support basic
>> > level
>> > I oplocks, and cannot support level II or leases. According to the
>> > smb.conf manpage, this is due to some incompleteness in the current
>> > VFS
>> > lease implementation.
>> >
>> > I'd love to get some more info from the Samba team about what is
>> > missing from the kernel lease implementation that prevents us from
>> > implementing these more advanced oplock/lease features. From the
>> > description in Microsoft's docs, I'm pretty sure that NFSv4
>> > delegations
>> > should be able to provide all the guarantees that are required.
>>
>> leases can be shared among file handles. When someone requests a
>> lease
>> he passes a cookie. Then when he opens the same file with the same
>> cookie the lease is not broken.
>
>Right, but that is easily solved in user space by having the cookie act
>as a key that references the file descriptor that holds the lease. This
>is how we typically implement NFSv4 delegations as well.

How does this work in multi-process situations ?
When you say "file descriptor", if the fd was passed
between processes would the lease state transfer ?
