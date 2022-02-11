Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F84B2CF7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiBKS2b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 13:28:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiBKS2a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 13:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46DA6184
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 10:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644604108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5S+rjG7tdU8Apt4E4h3CLt4KaTYjTfeukO8xDuEGqMU=;
        b=Kf+w9tvyHKQQacTWFsjr8Kp3sMbTOt6IbIDBMRyW6YipRc2YMj1cs3mybW7ilP3mmq9Unl
        1f0xmsInmJcL9ykJRzsyiqklQmspMnJN/yZvkpdjGgcLWVf82OJivPtT88cpT3uM6mRpB1
        U3QozhL1yKPrdYg13gJmg69S0LqDBB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-gswUaO7yOgOl8axrxjG2Ww-1; Fri, 11 Feb 2022 13:28:27 -0500
X-MC-Unique: gswUaO7yOgOl8axrxjG2Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787788DEB01;
        Fri, 11 Feb 2022 18:28:18 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A3B25E248;
        Fri, 11 Feb 2022 18:28:18 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Date:   Fri, 11 Feb 2022 13:28:16 -0500
Message-ID: <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
In-Reply-To: <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11 Feb 2022, at 10:48, Chuck Lever III wrote:

>> On Feb 11, 2022, at 8:44 AM, Steve Dickson <SteveD@RedHat.com> wrote:
>>
>> On 2/10/22 1:15 PM, Chuck Lever III wrote:
>>>> On Feb 10, 2022, at 1:01 PM, Benjamin Coddington 
>>>> <bcodding@redhat.com> wrote:
>>>>
>>>> The nfsuuid program will either create a new UUID from a random 
>>>> source or
>>>> derive it from /etc/machine-id, else it returns a UUID that has 
>>>> already
>>>> been written to /etc/nfsuuid or the file specified.  This small,
>>>> lightweight tool is suitable for execution by systemd-udev in rules 
>>>> to
>>>> populate the nfs4 client uniquifier.
>>> I like everything but the name. Without context, even if
>>> I read NFS protocol specifications, I have no idea what
>>> "nfsuuid" does.
>> man nfsuuid :-)
>
> Any time an administrator has to stop to read documentation
> is an unnecessary interruption in their flow of attention.
> It wastes their time.
>
>
>>> Possible alternatives:
>>> nfshostuniquifier
>>> nfsuniquehost
>>> nfshostuuid
>> I'm good with the name... short sweet and easy to type.
>
> I'll happily keep it short so it is readable and does not
> unnecessarily inflate the length of a line in a bash script.
> But almost no-one will ever type this command. Especially
> if they don't have to find its man page ;-p
>
> My last serious offers: nfsmachineid nfshostid
>
> I strongly prefer not having uuid in the name. A UUID is
> essentially a data type, it does not explain the purpose of
> the content.

How do you feel about these suggestions being misleading since the 
output is
not the nfs client's id?  Should we put that information in the man 
page?
Do sysadmins need to know that the output of this command is (if it is 
even
used at all) merely possibility of being a part of the client's id, the
other parts come from other places in the system: the hostname and 
possibly
the ip address?  That's my worry.  If we name it nfsmachineid or 
nfshostid,
do you feel like we ought to have it do the much more complicated job of
accurately outputting the actual client id?

Right now nfsuuid outputs uuids (or whatever was previously stored, up 
to 64
chars).  It generates uuids, like uuidgen.  Without something external 
to
itself (a udev rule, for example), it doesn't have any relationship to 
an
NFS client's id.  It could plausably be used in the future for other 
parts
of NFS to generate persitent uuids.  The only reason we don't just use
`uuidgen` is that we want to wrap it with some persistence.  A would a 
name
like stickyuuid be better?

Ben

