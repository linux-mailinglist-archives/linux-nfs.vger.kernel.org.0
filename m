Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81144ADE40
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383106AbiBHQWP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 11:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383140AbiBHQWO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 11:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8347C0612C3
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 08:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644337331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzUXdJGZ1ZNtBfZcehx5qG8OExHf5jgzWnHYUZgIvWI=;
        b=AnRFTgs1IvuHc49uTW+Fm+486zuTaH3PtoAITrIxZ7kujoxSmvfKJ98CB9iJwFyGUG0+Lf
        ypqPzkDZ9VmpPChUr6QLTjjZRatqAUFmyfX1GSjDd4CfszcGmcfLiryWKtPO4J6YTj3Mg6
        +2Ai8L43/GNDwEv4nJf6WyDlURskRAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-o1UQ9rnkNXW9ffejI_L5Hg-1; Tue, 08 Feb 2022 11:22:10 -0500
X-MC-Unique: o1UQ9rnkNXW9ffejI_L5Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D0F83DD24
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 16:22:09 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D9991086486;
        Tue,  8 Feb 2022 16:22:09 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Tue, 08 Feb 2022 11:22:08 -0500
Message-ID: <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
In-Reply-To: <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 11:04, Steve Dickson wrote:

> Hello,
>
> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>> The nfs4id program will either create a new UUID from a random source 
>> or
>> derive it from /etc/machine-id, else it returns a UUID that has 
>> already
>> been written to /etc/nfs4-id.  This small, lightweight tool is 
>> suitable for
>> execution by systemd-udev in rules to populate the nfs4 client 
>> uniquifier.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>   .gitignore               |   1 +
>>   configure.ac             |   4 +
>>   tools/Makefile.am        |   1 +
>>   tools/nfs4id/Makefile.am |   8 ++
>>   tools/nfs4id/nfs4id.c    | 184 
>> +++++++++++++++++++++++++++++++++++++++
>>   tools/nfs4id/nfs4id.man  |  29 ++++++
>>   6 files changed, 227 insertions(+)
>>   create mode 100644 tools/nfs4id/Makefile.am
>>   create mode 100644 tools/nfs4id/nfs4id.c
>>   create mode 100644 tools/nfs4id/nfs4id.man
> Just a nit... naming convention... In the past
> we never put the protocol version in the name.
> Do a ls tools and utils directory and you
> see what I mean....
>
> Would it be a problem to change the name from
> nfs4id to nfsid?

Not at all.. and I think there's a lot of room for naming discussions 
about
the file to store the id too:

Trond sent /etc/nfs4_uuid
Neil suggests /etc/netns/NAME/nfs.conf.d/identity.conf
Ben sent /etc/nfs4-id (to match /etc/machine-id)

Maybe the tool wants an option to specify the file?

Ben

