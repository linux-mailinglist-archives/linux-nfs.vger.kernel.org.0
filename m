Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5EE195257
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 08:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgC0Hvh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 03:51:37 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:53109 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgC0Hvh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 27 Mar 2020 03:51:37 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id D27CCE0432
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2020 08:51:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de D27CCE0432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1585295495; bh=RYYh/w8nTzkKATcSd4PjRFC2XTyfWUv+PVs3Lghv9Lo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VmotZZraJ//f2O+UVnbhT3PJgd9J6kvcIlFD58wjb6V2W0WbUjMRpXX+KWF4SSmck
         X8yIAwmTSnF4V8PCI4+ewGXDbl5NB1NUe5qTewoRMCmgZ4Se+lTjarUQrNAs9RfkAz
         x3JOCIhygKdpCV4Via0HuhCTguC4wHOrxQ4JBdUY=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id CB265120262;
        Fri, 27 Mar 2020 08:51:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id A230580005;
        Fri, 27 Mar 2020 08:51:35 +0100 (CET)
Date:   Fri, 27 Mar 2020 08:51:35 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <2042449942.8269597.1585295495366.JavaMail.zimbra@desy.de>
In-Reply-To: <20200326231602.GA29187@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com> <1885904737.8217161.1585249393750.JavaMail.zimbra@desy.de> <20200326231602.GA29187@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Topic: NFS client user xattr (RFC8276) support
Thread-Index: hhSA8XKfI/Hl5X2qQfaUg5bEL1DJkg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



----- Original Message -----
> From: "Frank van der Linden" <fllinden@amazon.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Anna Schumaker" <anna.schumaker@netapp.com>, "Trond Myklebust"
> <trond.myklebust@hammerspace.com>
> Sent: Friday, March 27, 2020 12:16:02 AM
> Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support

> On Thu, Mar 26, 2020 at 08:03:13PM +0100, Mkrtchyan, Tigran wrote:
>> The new patchset looks broken to me.
>> 
>> Client quiryes for supported attributes and gets xattr_support bit set:
>> 
>> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_supported:
>> bitmask=fcffbfff:40fdbe3e:00040800
>> 
>> However, the attribute never queries, but client makes is decision:
>> 
>> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_xattrsupport: XATTR
>> support=false
>> 
>> The packets can be found here: https://sas.desy.de/index.php/s/GEPiBxPg3eR4aGA
>> 
>> Can you provide packets of your mount/umount round.
> 
> Hi Tigran,
> 
> I looked at your packet dump. It seems like your server only supports 4.1,
> not 4.2. xattr support builds on 4.2 (within the rules laid out in
> RFC 8178).

That's right, this is what rfc8276 says:

   Note that the XDR code contained in this document depends on types
   from the NFSv4.2 nfs4_prot.x file [RFC7863].  This includes both nfs
   types that end with a 4, such as nfs_cookie4, count4, etc., as well
   as more-generic types, such as opaque and bool.

However, xattr support doesn't relays on any functionality provided by v4.2. Moreover,
all used data structures (nfs_cookie4, component4, change_info4) defined in nfsv4.0.
Thus there are no reasons why even v4.0 server can't support xattrs.

> 
> So, the fsinfo client call, which is just a GETATTR, masks out the 4.2
> fattr bits from server->attr_mask, and just uses the 4.1 bits. Meaning that
> xattr_support is not included, and defaults to false.

I was expecting something like this, but was unable to find the place where this
masking is happening.

Tigran.

> 
> The packet dump also indicates that your server advertises the xattr_support
> fattr as supported, even though it's in a 4.1 session, which would not
> be correct.
> 
> - Frank
