Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0772F3F47B9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhHWJiA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 05:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20966 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230265AbhHWJhy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 05:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629711432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6rXSu5QQJzFllb66Yw/O0ltWTPA7APno8iU/0zPONY=;
        b=YYvaC/g3DaM4baPNg707zlqmmrJrH+lZ7OIPLwZzTfsHzsHihOrgM1ZjoUvqVb6hSUJJrp
        u6qV60+MxT70d8YFqF6DvIRgrspSCcF+KMRtIiaggx9ERIXhbkZGo77NbEXkDg6qaMVXRl
        BlwidT9mARIuvYsELiPc533Sj+IzkMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-xvLsUcdcNQmUD7fHTq13dw-1; Mon, 23 Aug 2021 05:37:10 -0400
X-MC-Unique: xvLsUcdcNQmUD7fHTq13dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E50187D541;
        Mon, 23 Aug 2021 09:37:09 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.194.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F49860861;
        Mon, 23 Aug 2021 09:37:05 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org,
        libtirpc-devel@lists.sourceforge.net
Subject: Re: [Libtirpc-devel] [PATCH 1/1] Fix DoS vulnerability in statd and
 mountd
References: <20210807170248.68817-1-dai.ngo@oracle.com>
        <5d67875a-05bc-df80-3971-e8bde9b588b8@redhat.com>
Date:   Mon, 23 Aug 2021 11:37:04 +0200
In-Reply-To: <5d67875a-05bc-df80-3971-e8bde9b588b8@redhat.com> (Steve
        Dickson's message of "Sun, 8 Aug 2021 12:56:48 -0400")
Message-ID: <8735r0sdrz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

* Steve Dickson:

> Hello,
>
> On 8/7/21 1:02 PM, Dai Ngo wrote:
>> Currently my_svc_run does not handle poll time allowing idle TCP
>> connections to remain ESTABLISHED indefinitely. When the number
>> of connections reaches the limit the open file descriptors
>> (ulimit -n) then accept(2) fails with EMFILE. Since libtirpc does
>> not handle EMFILE returned from accept(2) this get my_svc_run into
>> a tight loop calling accept(2) resulting in the RPC service being
>> down, it's no longer able to service any requests.
>> Fix by removing idle connections when select(2) times out in
>> my_svc_run
>> and when open(2) returns EMFILE/ENFILE in auth_reload.
>> Signed-off-by: dai.ngo@oracle.com
>> ---
>>   support/export/auth.c  | 12 ++++++++++--
>>   utils/mountd/svc_run.c | 10 ++++++++--
>>   utils/statd/svc_run.c  | 11 ++++++++---
>>   3 files changed, 26 insertions(+), 7 deletions(-)
>> diff --git a/support/export/auth.c b/support/export/auth.c
>> index 03ce4b8a0e1e..0bb189fb4037 100644
>> --- a/support/export/auth.c
>> +++ b/support/export/auth.c
>> @@ -81,6 +81,8 @@ check_useipaddr(void)
>>   		cache_flush();
>>   }
>>   +extern void __svc_destroy_idle(int, bool_t);

> This is adding to the API... Which means mountd
> and statd (the next patch) will not compile without
> this new API...
>
> Does this mean an SONAME change? That is such a pain!

Do you symbol versioning?  For RPM-based distributions, adding the new
symbol under a new symbol version would avoid the need for a SONAME
change.

Debian-based distributions use explicit symbol list files and are more
flexible.

Thanks,
Florian

