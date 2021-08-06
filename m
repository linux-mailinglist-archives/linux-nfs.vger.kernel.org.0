Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A873E3066
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhHFUhl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:37:41 -0400
Received: from mail.rptsys.com ([23.155.224.45]:54296 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhHFUhl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Aug 2021 16:37:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id C1C7037B2C9861;
        Fri,  6 Aug 2021 15:37:24 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SXYxxgknChUk; Fri,  6 Aug 2021 15:37:24 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id DEF7737B2C985E;
        Fri,  6 Aug 2021 15:37:23 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com DEF7737B2C985E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1628282243; bh=pQFxXslybWGkCTzAO35JaXt4z4WeC12z4LlGwRRjVds=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XusPhugk7Yy6KbP6LcJ9yvFeweBX2cEJdofNeur6Z3+GeitaE6+SZo5WRXtH+kXg0
         2XcKJm6eTP46XBG5OLOS5K2HQIGJFvRrfP09juVwdJtA00iyrE0u+sqNCkPWLS82X0
         1s7I9o7yyLSyXRNS2ol5gDs0HsluzDDnUjEgvOlc=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4AIci4eC-mfG; Fri,  6 Aug 2021 15:37:23 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id B89CD37B2C985B;
        Fri,  6 Aug 2021 15:37:23 -0500 (CDT)
Date:   Fri, 6 Aug 2021 15:37:22 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <620055521.439700.1628282242689.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <CAN-5tyHmiEE-vw=s6t_7UmWgHo2_U7zJOSwTPESY_NQA27ZsPQ@mail.gmail.com>
References: <985631970.48634.1628121620017.JavaMail.zimbra@raptorengineeringinc.com> <1851673341.49012.1628121856011.JavaMail.zimbra@raptorengineeringinc.com> <361337129.54635.1628123839436.JavaMail.zimbra@raptorengineeringinc.com> <CAN-5tyHmiEE-vw=s6t_7UmWgHo2_U7zJOSwTPESY_NQA27ZsPQ@mail.gmail.com>
Subject: Re: Callback slot table overflowed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC83 (Linux)/8.5.0_GA_3042)
Thread-Topic: Callback slot table overflowed
Thread-Index: diZ7YAPSPH6ZJArLYa5dBpRSeeCQSw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



----- Original Message -----
> From: "Olga Kornievskaia" <aglo@umich.edu>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, August 6, 2021 2:53:19 PM
> Subject: Re: Callback slot table overflowed

> On Thu, Aug 5, 2021 at 12:15 AM Timothy Pearson
> <tpearson@raptorengineering.com> wrote:
>>
>> On further investigation, the working server had already been rolled back to
>> 4.19.0.  Apparently the issue was insurmountable in 5.x.
>>
>> It should be simple enough to set up a test environment out of production for
>> 5.x, if you have any debug tips / would like to see any debug options compiled
>> in.
>>
>> Thanks!
>>
>> ----- Original Message -----
>> > From: "Timothy Pearson" <tpearson@raptorengineering.com>
>> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
>> > Sent: Wednesday, August 4, 2021 7:04:16 PM
>> > Subject: Re: Callback slot table overflowed
>>
>> > Other information that may be helpful:
>> >
>> > All clients are using TCP
>> > arm64 clients are unaffected by the bug
>> > The armel clients use very small (4k) rsize/wsize buffers
>> > Prior to the upgrade from Debian Stretch, everything was working perfectly
>> >
>> > ----- Original Message -----
>> >> From: "Timothy Pearson" <tpearson@raptorengineering.com>
>> >> To: "linux-nfs" <linux-nfs@vger.kernel.org>
>> >> Sent: Wednesday, August 4, 2021 7:00:20 PM
>> >> Subject: Callback slot table overflowed
>> >
>> >> All,
>> >>
>> >> We've hit an odd issue after upgrading a main NFS server from Debian Stretch to
>> >> Debian Buster.  In both cases the 5.13.4 kernel was used, however after the
>> >> upgrade none of our ARM thin clients can mount their root filesystems -- early
>> >> in the boot process I/O errors are returned immediately following "Callback
>> >> slot table overflowed" in the client dmesg.
>> >>
>> >> I am unable to find any useful information on this "Callback slot table
>> >> overflowed" message, and have no idea why it is only impacting our ARM (armel)
>> >> clients.  Both 4.14 and 5.3 on the client side show the issue, other client
>> >> kernel versions were not tested.
>> >>
>> >> Curiously, increasing the rsize/wsize values to 65536 or higher reduces (but
>> >> does not eliminate) the number of callback overflow messages.
>> >>
>> >> The server is a ppc64el 64k page host, and none of our pcc64el or amd64 thin
>> >> clients are experiencing any problems.  Nothing of interest appears in the
>> >> server message log.
>> >>
>> >> Any troubleshooting hints would be most welcome.
> 
> A network trace would be useful.
> 
> 5.3 should have this patch "SUNRPC: Fix up backchannel slot table
> accounting". I believe "callback slot table overflowed" is hit when
> the server sent more reqs than client can handle (ie doesn't have a
> free slot to handle the request). A network trace would show that.
> However you said this happens when the client is trying to mount and
> besides cb_null requests I'm not sure what could be happening.

I'll work to get a network trace out of the test environment once it's set up.  I should however clarify that this is immediately *after* mount, when the diskless ARM device is attempting to run early startup (i.e. reading /etc/init.d and such).

>> >>
> > > > Thank you!
