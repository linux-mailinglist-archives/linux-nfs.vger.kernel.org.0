Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097001845B3
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 12:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgCMLLb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 07:11:31 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:50939 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgCMLLa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 07:11:30 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 54746E0941
        for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2020 12:11:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 54746E0941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1584097888; bh=aJUJWo1LZj7GHP6D/xWhGXLmi2ETii+21qgB6BcB77w=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0LbrmegjIZUc9wbJL1EVJfeKD/Je3xGhTU4Yw86beR8fYeBIgdzAJgCfZWtPN3Nwy
         v3imQWopj5V8lvfR38IDVybwc3up5iSVeGrB69GEPsGoW4THUvVv8YtMF1WOciLFhE
         WOsV9m4r5OSTrJHVpUhuEbIC5AjpEMSDCaBRW2f8=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 4C20C120258;
        Fri, 13 Mar 2020 12:11:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 2115FC00A2;
        Fri, 13 Mar 2020 12:11:28 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:11:27 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <948465413.4651196.1584097887947.JavaMail.zimbra@desy.de>
In-Reply-To: <20200312211555.GA5974@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com> <20200311195613.26108-4-fllinden@amazon.com> <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de> <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com> <20200312211555.GA5974@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: NFSv4.2: query the server for extended attribute support
Thread-Index: elNPWdFmL5mjBkO5xQsIXKEvMzg9tg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Frank,

I think the way how you have implemented is almost correct. You query
server for supported attributes. As result client will get all attributes
supported bu the server and if FATTR4_XATTR_SUPPORT is returned, then client
adds xattr capability. This the way how I read rfc8276. Do you have a different
opinion?

Regards,
   Tigran.

----- Original Message -----
> From: "Frank van der Linden" <fllinden@amazon.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "Trond Myklebust" <trond.myklebust@hammerspace.com>, "Anna Schumaker" <anna.schumaker@netapp.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Sent: Thursday, March 12, 2020 10:15:55 PM
> Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute support

> On Thu, Mar 12, 2020 at 08:51:39PM +0000, Frank van der Linden wrote:
>> 1) The xattr_support attribute exists
>> 2) The xattr support attribute exists *and* it's true for the root fh
>> 
>> Currently the code does 2) in one operation. That might not be 100%
>> correct - the RFC does mention that (section 8.2):
>> 
>> "Before interrogating this attribute using GETATTR, a client should
>>  determine whether it is a supported attribute by interrogating the
>>  supported_attrs attribute."
>> 
>> That's a "should", not a "MUST", but it's still waving its finger
>> at you not to do this.
>> 
>> Since 8.2.1 says:
>> 
>> "However, a client may reasonably assume that a server
>>  (or file system) that does not support the xattr_support attribute
>>  does not provide xattr support, and it acts on that basis."
>> 
>> ..I think you're right, and the code should just use the existence
>> of the attribute as a signal that the server knows about xattrs -
>> operations should still error out correctly if it doesn't.
>> 
>> I'll make that change, thanks.
> 
> ..or, alternatively, only query xattr_support in nfs4_server_capabilities,
> and then its actual value, if it exists, in nfs4_fs_info.
> 
> Any opinions on this?
> 
> - Frank
