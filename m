Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2457E184922
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 15:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMOTz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 10:19:55 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:49276 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMOTz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 10:19:55 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 84CEFE0791
        for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2020 15:19:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 84CEFE0791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1584109192; bh=+J7pIhgtVNMBgIJCrYMZg9P3ts/uS8GWixGshrtGQUA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OpO8WdfC79PuH8aruyvQH2gu5FxK6Cbkoy8nKtjxsbqh8arjgiLXn60CAsTdw88IH
         LZ75eSx2pyv1ITt5t8Udl+ZQkWloRv6VVuXFhpgkxxsQ+IHzJxvm+WMa3OwNY1gHEb
         zW9j3hiTcUIu6WBvkti/AxIfbdJ5kDqjd1iH3BuY=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 7D7E5120294;
        Fri, 13 Mar 2020 15:19:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 5432B100076;
        Fri, 13 Mar 2020 15:19:52 +0100 (CET)
Date:   Fri, 13 Mar 2020 15:19:52 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Message-ID: <345401476.4712575.1584109192253.JavaMail.zimbra@desy.de>
In-Reply-To: <6792d6a6012a241b8bd1555eea8c592ff318a444.camel@hammerspace.com>
References: <20200311195613.26108-1-fllinden@amazon.com> <20200311195613.26108-4-fllinden@amazon.com> <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de> <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <20200312211555.GA5974@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <948465413.4651196.1584097887947.JavaMail.zimbra@desy.de> <6792d6a6012a241b8bd1555eea8c592ff318a444.camel@hammerspace.com>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: NFSv4.2: query the server for extended attribute support
Thread-Index: AQHV998vv0PI2kCOxkaGqYUZpy0TZqhFIw8AgABNQICAAAbIgIAA6XKAgAAseIDnRh56DQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



----- Original Message -----
> From: "trondmy" <trondmy@hammerspace.com>
> To: "Frank van der Linden" <fllinden@amazon.com>, "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Anna Schumaker" <anna.schumaker@netapp.com>
> Sent: Friday, March 13, 2020 2:50:38 PM
> Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute support

> On Fri, 2020-03-13 at 12:11 +0100, Mkrtchyan, Tigran wrote:
>> Hi Frank,
>> 
>> I think the way how you have implemented is almost correct. You query
>> server for supported attributes. As result client will get all
>> attributes
>> supported bu the server and if FATTR4_XATTR_SUPPORT is returned, then
>> client
>> adds xattr capability. This the way how I read rfc8276. Do you have a
>> different
>> opinion?
>> 
> 
> 'xattr_support' seems like a protocol hack to allow the client to
> determine whether or not the xattr operations are supported.
> 
> The reason why it is a hack is that 'supported_attrs' is also a per-
> filesystem attribute, and there is no value in advertising
> 'xattr_support' there unless your filesystem also supports xattrs.
> 
> IOW: the protocol forces you to do 2 round trips to the server in order
> to figure out something that really should be obvious with 1 round
> trip.
> 


So you say  that client have to query for xattr_support every time the
fsid is changing?

Tigran.

>> Regards,
>>    Tigran.
>> 
>> ----- Original Message -----
>> > From: "Frank van der Linden" <fllinden@amazon.com>
>> > To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> > Cc: "Trond Myklebust" <trond.myklebust@hammerspace.com>, "Anna
>> > Schumaker" <anna.schumaker@netapp.com>, "linux-nfs"
>> > <linux-nfs@vger.kernel.org>
>> > Sent: Thursday, March 12, 2020 10:15:55 PM
>> > Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended
>> > attribute support
>> > On Thu, Mar 12, 2020 at 08:51:39PM +0000, Frank van der Linden
>> > wrote:
>> > > 1) The xattr_support attribute exists
>> > > 2) The xattr support attribute exists *and* it's true for the
>> > > root fh
>> > > 
>> > > Currently the code does 2) in one operation. That might not be
>> > > 100%
>> > > correct - the RFC does mention that (section 8.2):
>> > > 
>> > > "Before interrogating this attribute using GETATTR, a client
>> > > should
>> > >  determine whether it is a supported attribute by interrogating
>> > > the
>> > >  supported_attrs attribute."
>> > > 
>> > > That's a "should", not a "MUST", but it's still waving its finger
>> > > at you not to do this.
>> > > 
>> > > Since 8.2.1 says:
>> > > 
>> > > "However, a client may reasonably assume that a server
>> > >  (or file system) that does not support the xattr_support
>> > > attribute
>> > >  does not provide xattr support, and it acts on that basis."
>> > > 
>> > > ..I think you're right, and the code should just use the
>> > > existence
>> > > of the attribute as a signal that the server knows about xattrs -
>> > > operations should still error out correctly if it doesn't.
>> > > 
>> > > I'll make that change, thanks.
>> > 
>> > ..or, alternatively, only query xattr_support in
>> > nfs4_server_capabilities,
>> > and then its actual value, if it exists, in nfs4_fs_info.
>> > 
>> > Any opinions on this?
>> > 
>> > - Frank
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
