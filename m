Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C064AE379
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386583AbiBHWWv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386286AbiBHUAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 15:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B6B7C0613CB
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 12:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644350433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRkaTGLko6RS0qcQazcY7AMYnvXl1StloiyodCJTRg8=;
        b=R/H+vYwki+X+BXhJjoLu3WXatNg+/pGro2dEFhs061C8ZtniuRrmI8KXd4k0chGmPAW8QO
        A00iEzzhZGFLdiI73ZCs02PdRRPhx88lD2pMgf4x36jAJ0pBiDdjjCrt+42sd4xtS1MqAi
        G0jq6pT33WyXJLjEXGqPxCK2sqnYgDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-Fz5IEP1VOsaOJbh4mvXROg-1; Tue, 08 Feb 2022 15:00:32 -0500
X-MC-Unique: Fz5IEP1VOsaOJbh4mvXROg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 668361124C45
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 20:00:31 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F9995F714;
        Tue,  8 Feb 2022 20:00:30 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Tue, 08 Feb 2022 15:00:29 -0500
Message-ID: <E013276C-7605-4E2B-A650-C61C6FC5BADF@redhat.com>
In-Reply-To: <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Feb 2022, at 14:52, Steve Dickson wrote:

> On 2/8/22 11:22 AM, Benjamin Coddington wrote:
>> On 8 Feb 2022, at 11:04, Steve Dickson wrote:
>>
>>> Hello,
>>>
>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>> The nfs4id program will either create a new UUID from a random 
>>>> source or
>>>> derive it from /etc/machine-id, else it returns a UUID that has 
>>>> already
>>>> been written to /etc/nfs4-id.  This small, lightweight tool is 
>>>> suitable for
>>>> execution by systemd-udev in rules to populate the nfs4 client 
>>>> uniquifier.
>>>>
>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>> ---
>>>>   .gitignore               |   1 +
>>>>   configure.ac             |   4 +
>>>>   tools/Makefile.am        |   1 +
>>>>   tools/nfs4id/Makefile.am |   8 ++
>>>>   tools/nfs4id/nfs4id.c    | 184 
>>>> +++++++++++++++++++++++++++++++++++++++
>>>>   tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>   6 files changed, 227 insertions(+)
>>>>   create mode 100644 tools/nfs4id/Makefile.am
>>>>   create mode 100644 tools/nfs4id/nfs4id.c
>>>>   create mode 100644 tools/nfs4id/nfs4id.man
>>> Just a nit... naming convention... In the past
>>> we never put the protocol version in the name.
>>> Do a ls tools and utils directory and you
>>> see what I mean....
>>>
>>> Would it be a problem to change the name from
>>> nfs4id to nfsid?
>>
>> Not at all..
> Good...

I didn't orginally do that because I thought it might be confusing for 
some
folks who want `nfsid` to display their kerberos identity.  There's a BZ
open for that!

Do you think that's a problem?  I feel like it's a problem.

>> and I think there's a lot of room for naming discussions about
>> the file to store the id too:
>>
>> Trond sent /etc/nfs4_uuid
>> Neil suggests /etc/netns/NAME/nfs.conf.d/identity.conf
>> Ben sent /etc/nfs4-id (to match /etc/machine-id)
> Question... is it kosher to be writing /etc which is
> generally on the root filesystem?

Sure, why not?

> By far Neil suggestion is the most intriguing... but
> on the containers I'm looking at there no /etc/netns
> directory.

Not yet -- you can create it.

> I had to install the iproute package to do the
> "ip netns identify" which returns NULL...
> also adds yet another dependency on nfs-utils.

We don't need the dependency..this little binary is just a helper for a 
udev
rule.  Trond already wrote his version of this.  :)  This one's just 
trying
to be a little lighter (whoa, we don't need all of bash!).

> So if "ip netns identify" does return NULL what directory
> path should be used?

I think thats out of scope..  if udevd is running in a container, and 
has a
rule that uses this tool, then the container either is likely to have
already customized its /etc.  Or perhaps we can make the udev rule 
namespace
aware (I need to look into what's available to udev's rule environment 
when
it runs in a namespace).

> I'm all for making things container friendly but I'm
> also a fan of keeping things simple... So
> how about /etc/nfs.conf.d/identity.conf or
> /etc/nfs.conf.d/nfsid.conf?

Really, because its not a configuration.  Its value persistence, and we 
/really/
don't want people configuring it.

>>
>> Maybe the tool wants an option to specify the file?
> This is probably not a bad idea... It is a common practice

OK, I'll do that.

Ben

