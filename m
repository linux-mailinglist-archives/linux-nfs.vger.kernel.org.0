Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619C64B2F11
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 22:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353692AbiBKVGc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 16:06:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353719AbiBKVGa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 16:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69A7E30F
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 13:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644613585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZE8YWsUm1E1SqyMzPNZiLa4Uk87tqyWpRnTXYxo/5w=;
        b=Qab8mz8Wf6Fb5UPbTZE4I9lgbftmrxG3kusoYugCY2qR2FQT4VdUgI7gwQTKKNnWStPVAu
        eMHOLPQvZtBPkaJ2kd0f634zvPtx9/ZtgYZoKU/F0hEV/DnpltPjnNwKDP2SlLD+6SCJnp
        0Ka7H8ho75EyAZBlR7Dzb+5kuWlr0Xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-iCxZhmgdOcmlBQS8vpo8iQ-1; Fri, 11 Feb 2022 16:06:24 -0500
X-MC-Unique: iCxZhmgdOcmlBQS8vpo8iQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C18A1091DA2;
        Fri, 11 Feb 2022 21:06:23 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B32812E30;
        Fri, 11 Feb 2022 21:06:22 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Date:   Fri, 11 Feb 2022 16:06:20 -0500
Message-ID: <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
In-Reply-To: <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11 Feb 2022, at 15:51, Chuck Lever III wrote:

>> On Feb 11, 2022, at 3:16 PM, Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>
>> On 11 Feb 2022, at 15:00, Chuck Lever III wrote:
>>
>>>> On Feb 11, 2022, at 2:30 PM, Benjamin Coddington 
>>>> <bcodding@redhat.com> wrote:
>>>>
>>>> All the arguments for exacting tolerances on how it should be named 
>>>> apply
>>>> equally well to anything that implies its output will be used for 
>>>> nfs client
>>>> ids, or host ids.
>>>
>>> I completely disagree with this assessment.
>>
>> But how, and in what way?  The tool just generates uuids, and spits 
>> them
>> out, or it spits out whatever's in the file you specify, up to 64 
>> chars.  If
>> we can't have uuid in the name, how can we have NFS or machine-id or
>> host-id?
>
> We don't have a tool called "string" to get and set the DNS name of
> the local host. It's called "hostname".
>
> The purpose of the proposed tool is to persist a unique string to be
> used as part of an NFS client ID. I would like to name the tool based
> on that purpose, not based on the way the content of the persistent
> file happens to be arranged some of the time.
>
> When the tool generates the string, it just happens to be a UUID. It
> doesn't have to be. The tool could generate a digest of the boot time
> or the current time. In fact, one of those is usually part of certain
> types of a UUID anyway. The fact that it is a UUID is totally not
> relevant. We happen to use a UUID because it has certain global
> uniqueness properties. (By the way, perhaps the man page could mention
> that global uniqueness is important for this identifier. Anything with
> similar guaranteed global uniqueness could be used).
>
> You keep admitting that the tool can output something that isn't a
> UUID. Doesn't that make my argument for me: that the tool doesn't
> generate a UUID, it manages a persistent host identifier. Just like
> "hostname." Therefore "nfshostid". I really don't see how nfshostid
> is just as miserable as nfsuuid -- hence, I completely disagree
> that "all arguments ... apply equally well".

Yes - your arguement is a good one.   I wasn't clear enough admitting 
you
were right two emails ago, sorry about that.

However, I still feel the same argument applied to "nfshostid" 
disqualifies
it as well.  It doesn't output the nfshostid.  That, if it even contains 
the
part outputted, is more than what's written out.

In my experience with linux tools, nfshostid sounds like something I can 
use
to set or retrieve the identifier for an NFS host, and this little tool 
does
not do that.

> In fairness, I'm trying to understand why you want to stick with
> "nfsuuid". You originally said you wanted a generic tool. OK, but
> now you say you don't have other uses for the tool after all. You
> said you don't want it to be associated with an NFS client ID. That
> part I still don't grok. Can you help me understand?

I don't want to stick with nfsuuid, I'm just trying to apply everyone's
reasoning to the current list of suggested names and it appears to me
that we've disqualified them all.

>>> I object strongly to the name nfsuuid, and you seem to be 
>>> inflexible. This
>>> is not a hill I want to die on, however I reserve the right to say 
>>> "I told
>>> you so" when it turns out to be a poor choice.
>>
>> How does agreeing with you multiple times in my last response and 
>> making
>> further suggestions for names seem inflexible to you?  This is the 
>> worst
>> part of working over email - I think you're misreading my good humor 
>> in the
>> face of a drudging discussion as sarcasm or ill will.
>
> Nope, not at all. It wasn't apparent that you agreed, as much
> of your reply seemed to be disagreeing with my reply. So maybe
> I am overreacting. Though my reply can also be read with humor,
> even though it is a bit dry.

Sorry about that -- I really just want to move forward.  I can send it 
again
as nfshostid.  I think if we are clear in the man page that it isn't
necessarily part or any of the identifier used by NFS, rather its just
trying to manage the persistent unique portion, it works for me.

Unless we can go with persistychars, because that makes me grin.

Ben

