Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42720380707
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhENKTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 06:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbhENKTA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 06:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620987469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPjGg0KcvEwbeIE61TMNEmsXTy93OkktoxdUUrVf8UY=;
        b=ZHe+phA/GC8DQC7s+DWY9MF4HtopoXsp8b9kO3xLsdGXcRUBG84uqbcEaqXJ6GxatM09MI
        b7DJqjeJgpIw5ADTlWQq6T2EOMC/4tYw95E0iGaHAUGMlNyaSa6M/ExdCw3s0mDIPb9lcS
        ywNVzIOjiLVix4OFqTMKHkOSRElSXG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-NW8GPJ_sNk2bNGhY8ZidyQ-1; Fri, 14 May 2021 06:17:47 -0400
X-MC-Unique: NW8GPJ_sNk2bNGhY8ZidyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7F45800D62;
        Fri, 14 May 2021 10:17:45 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE6E563BA7;
        Fri, 14 May 2021 10:17:44 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Olga Kornievskaia" <olga.kornievskaia@gmail.com>
Cc:     "Dan Aloni" <dan@kernelim.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Date:   Fri, 14 May 2021 06:17:43 -0400
Message-ID: <E841CE1C-041E-4E9A-B14F-925CC0A08581@redhat.com>
In-Reply-To: <CAN-5tyGe32FEeK0+bnMU16zu5Y6RkVqEey4G3VocEtx8vSQwiw@mail.gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com>
 <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyGe32FEeK0+bnMU16zu5Y6RkVqEey4G3VocEtx8vSQwiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 May 2021, at 17:18, Olga Kornievskaia wrote:
> On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <dan@kernelim.com> wrote:
>> If a client can use a single switch, shouldn't the name of the symlink
>> be just "switch"? This is to be consistent with other symlinks in
>> `sysfs` such as the ones in block layer, for example in my
>> `/sys/block/sda`:
>>
>>     bdi -> ../../../../../../../../../../../virtual/bdi/8:0
>>     device -> ../../../5:0:0:0
>>
>
> Jumping back to this comment because now that I went back to try to
> modify the code I'm having doubts.
>
> We still need numbering of xprt switches because they are different
> for different mounts. So xprt_switches directory would still have
> switch-0 for say a mount to server A and then switch-0 for a mount to
> server B.  While yes I see that for a given rpc client that's making a
> link into a xprt_switches directory will only have 1 link. And "yes"
> the name of the link could be "switch". But isn't it more informative
> to keep this to be the same name as the name of the directory under
> the xprt_switches?

The information isn't lost, as the symlink points to the specific switch.
Not using a number in the symlink name informs that there will only be one
switch for each client and makes it more deterministic for users and
software to navigate.

Ben

