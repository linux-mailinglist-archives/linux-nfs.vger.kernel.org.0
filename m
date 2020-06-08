Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6724D1F1C7C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 17:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgFHP5f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgFHP5f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 11:57:35 -0400
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Jun 2020 08:57:35 PDT
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07602C08C5C2
        for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2020 08:57:35 -0700 (PDT)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id EFC9B16082E
        for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2020 17:52:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de EFC9B16082E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1591631521; bh=UXb3VLUJ/luez6cuqF99o95vbpPpf7NRQjdWdEF3I1A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hDaEO2bb/xMkrQq4bHfrosqX7difU3yMNKeFu8ko4YxTdHPyPVWwe8MNCBv/Xg1zE
         UFq069RexZh5te5P/32XguvGthM8v0sYr8FmrDBQOs7J/qSk+o1LJL3q9TcuXtBZMj
         +tQhpURDOPBt2ETApN2wIgiZDRrSeXwC5WxMwb4I=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id E92831A00DC;
        Mon,  8 Jun 2020 17:52:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id BD629C008A;
        Mon,  8 Jun 2020 17:52:00 +0200 (CEST)
Date:   Mon, 8 Jun 2020 17:52:00 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Frank van der Linden <fllinden@amazon.com>
Message-ID: <1684380491.969626.1591631520724.JavaMail.zimbra@desy.de>
In-Reply-To: <v2aze7-yqvuvfuc4i30-1xxisr-dr39sbpkxym7-2nbcltx37gs3ezoql-qoc5f45hvih45iurdv-lqtdu9ppbm6i-upakk-2awl3v-em4ktl4ip5gchvuicg-vgnve1-wbqe5p-fw96bj-ct2sjj-wlbpk7.1586002736523@email.android.com>
References: <20200325231051.31652-1-fllinden@amazon.com> <1885904737.8217161.1585249393750.JavaMail.zimbra@desy.de> <20200326231602.GA29187@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <2042449942.8269597.1585295495366.JavaMail.zimbra@desy.de> <v2aze7-yqvuvfuc4i30-1xxisr-dr39sbpkxym7-2nbcltx37gs3ezoql-qoc5f45hvih45iurdv-lqtdu9ppbm6i-upakk-2awl3v-em4ktl4ip5gchvuicg-vgnve1-wbqe5p-fw96bj-ct2sjj-wlbpk7.1586002736523@email.android.com>
Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3895)
Thread-Topic: NFS client user xattr (RFC8276) support
Thread-Index: hhSA8XKfI/Hl5X2qQfaUg5bEL1DJkiB/7rcKCc5iWNw=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Dear maintainers,

are those changes considered for 5.8?

Thanks,
   Tigran. 

----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "Frank van der Linden" <fllinden@amazon.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Anna Schumaker" <anna.schumaker@netapp.com>, "Trond Myklebust"
> <trond.myklebust@hammerspace.com>
> Sent: Saturday, April 4, 2020 2:18:54 PM
> Subject: Re:[PATCH v2 00/13] NFS client user xattr (RFC8276) support

> After adding 'minimal' 4.2 implementation to our server, the patchset works as
> expected.
> Thanks, Tigran.
> 
> -------- Original message --------
> From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
> Date: Fri, Mar 27, 2020, 08:51
> To: Frank van der Linden <fllinden@amazon.com>
> Cc: linux-nfs <linux-nfs@vger.kernel.org>, Anna Schumaker
> <anna.schumaker@netapp.com>, Trond Myklebust <trond.myklebust@hammerspace.com>
> Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
> 
> 
> ----- Original Message -----
>> From: "Frank van der Linden" <fllinden@amazon.com>
>> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Anna Schumaker"
>> <anna.schumaker@netapp.com>, "Trond Myklebust"
>> <trond.myklebust@hammerspace.com>
>> Sent: Friday, March 27, 2020 12:16:02 AM
>> Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
> 
>> On Thu, Mar 26, 2020 at 08:03:13PM +0100, Mkrtchyan, Tigran wrote:
>>> The new patchset looks broken to me.
>>> 
>>> Client quiryes for supported attributes and gets xattr_support bit set:
>>> 
>>> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_supported:
>>> bitmask=fcffbfff:40fdbe3e:00040800
>>> 
>>> However, the attribute never queries, but client makes is decision:
>>> 
>>> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_xattrsupport: XATTR
>>> support=false
>>> 
>>> The packets can be found here: https://sas.desy.de/index.php/s/GEPiBxPg3eR4aGA
>>> 
>>> Can you provide packets of your mount/umount round.
>> 
>> Hi Tigran,
>> 
>> I looked at your packet dump. It seems like your server only supports 4.1,
>> not 4.2. xattr support builds on 4.2 (within the rules laid out in
>> RFC 8178).
> 
> That's right, this is what rfc8276 says:
> 
>   Note that the XDR code contained in this document depends on types
>   from the NFSv4.2 nfs4_prot.x file [RFC7863].  This includes both nfs
>   types that end with a 4, such as nfs_cookie4, count4, etc., as well
>   as more-generic types, such as opaque and bool.
> 
> However, xattr support doesn't relays on any functionality provided by v4.2.
> Moreover,
> all used data structures (nfs_cookie4, component4, change_info4) defined in
> nfsv4.0.
> Thus there are no reasons why even v4.0 server can't support xattrs.
> 
>> 
>> So, the fsinfo client call, which is just a GETATTR, masks out the 4.2
>> fattr bits from server->attr_mask, and just uses the 4.1 bits. Meaning that
>> xattr_support is not included, and defaults to false.
> 
> I was expecting something like this, but was unable to find the place where this
> masking is happening.
> 
> Tigran.
> 
>> 
>> The packet dump also indicates that your server advertises the xattr_support
>> fattr as supported, even though it's in a 4.1 session, which would not
>> be correct.
>> 
> > - Frank
