Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290DB392E53
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhE0Mx0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 08:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235872AbhE0MxW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 08:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622119907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kReLMtA10wz94SJ+BJK20uccxvZmpsnt3NmAhShbr1Y=;
        b=TtBE1XaGJBF+HHYrpe31aQaY7l2eggvcFeu/XEkYzrEEtrfd1d8Ua/TEKhss5Y+YE+UnOB
        Sp8yLXMX3KX9+gaJYBqDgON8pnDF6GwaBRUwk9IjGcVTXRuwfiT4RUC0TH4Lx/40+Jx08A
        wwpTJvs6xueIaHN2bt7WOsvryGduM+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-oR5AeFYkMmicgg_DLeefFg-1; Thu, 27 May 2021 08:51:45 -0400
X-MC-Unique: oR5AeFYkMmicgg_DLeefFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B3988042B7
        for <linux-nfs@vger.kernel.org>; Thu, 27 May 2021 12:51:44 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-214.phx2.redhat.com [10.3.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5607219C66;
        Thu, 27 May 2021 12:51:44 +0000 (UTC)
Subject: Re: [nfs-utils RFC PATCH 2/2] gssd: add timeout for upcall threads
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20210525180033.200404-1-smayhew@redhat.com>
 <20210525180033.200404-3-smayhew@redhat.com>
 <490b45eb-0142-24de-e05f-79751891ddf9@RedHat.com>
 <YK+FH7T/ljFbuIsH@aion.usersys.redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <dbb64855-5ca5-0928-eda4-705a9f45c71b@RedHat.com>
Date:   Thu, 27 May 2021 08:54:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK+FH7T/ljFbuIsH@aion.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/27/21 7:40 AM, Scott Mayhew wrote:
> On Wed, 26 May 2021, Steve Dickson wrote:
>> If people are going to used the -C flag they are saying they want
>> to ignore hung threads so I'm thinking with printerr(0) we would
>> be filling up their logs about messages they don't care about.
>> So I'm thinking we should change this to a printerr(1) 
> 
> Note that message could pop multiple times per thread even without the
> -C flag because cancellation isn't immediate (a thread needs to hit a
> cancellation point, which it won't actually do that until it comes back
> from wherever it's hanging).  My thinking was leaving it with
> printerr(0) would make it blatantly obvious when something was wrong and
> needed to be investigated.  I have no issue with changing it to
> printerr(1) though. 
It would... but I've craft the debugging for a single -v 
is errors only... Maybe I should mention that in the
man page... And looking at what you mention in the
man page for -C, it does say it will cause an error 
to be logged... So I guess it makes sense to leave
it as is.

> 
> Alternatively we could add another flag to struct upcall_thread_info to
> ensure that message only gets logged once per thread.
> 
I think it is good as is... 

>>
>> Overall I think the code is very well written with
>> one exception... The lack of comments. I think it
>> would be very useful to let the reader know what
>> you are doing and why.... But by no means is 
>> that a show stopper. Nice work!
> 
> I can go back and add some comments.
Well there aren't that many comments to 
begin with.... So you are just following 
the format... ;-) 

Don't worry about it... How I will finish my testing
today... and do the commit with what we got.. 

Again... Nice work!!

steved.

