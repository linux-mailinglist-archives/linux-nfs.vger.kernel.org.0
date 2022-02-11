Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54B4B2D8A
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiBKTa6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 14:30:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245212AbiBKTa6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 14:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ACBEBA4
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 11:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644607855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDFU9aZs+BiQVlLRz1Sbiwli8zz6yWfhMHZcxfPvi+I=;
        b=FbY6D4KVhusYqUuuKbYCBN04D36OdmI0fvLU1MCXtQk8ExxYYqRreIViuz747CIFJ/VdnN
        H0Pxv9YU5zbdEGeOnsbORMYZSyOxbBe71lWjunmJtZqzfLDliqVsEW//rBweBLx4t7eGDk
        2qXceZyZyVKDXh3khdM6DAAZ69MzWTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-pBy63RqDPCibErB7WDmziA-1; Fri, 11 Feb 2022 14:30:54 -0500
X-MC-Unique: pBy63RqDPCibErB7WDmziA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26CF21091DA1;
        Fri, 11 Feb 2022 19:30:53 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4986C6AB81;
        Fri, 11 Feb 2022 19:30:52 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Date:   Fri, 11 Feb 2022 14:30:46 -0500
Message-ID: <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>
In-Reply-To: <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>
 <9c046648bfd9c8260ec7bd37e0a93f7821e0842f.1644515977.git.bcodding@redhat.com>
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
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

On 11 Feb 2022, at 14:04, Chuck Lever III wrote:
> Yes. We're not using the output of the tool for anything
> else. At the very least the man page should explain the
> proposed client ID usage as an EXAMPLE with an explanation.
>
> But honestly, I haven't seen any use case that requires
> this exact functionality. Can you explain why you believe
> there needs to be extra generality? (that's been one of
> the main reasons I object to "nfsuuid" -- what else can
> this tool be used for?)

Not yet, no.

>> If we name it nfsmachineid or nfshostid,
>> do you feel like we ought to have it do the much more complicated job 
>> of
>> accurately outputting the actual client id?
>
> It could do that, but the part that the kernel struggles
> with is the uniquifier part. That is the part that _has_
> to be done in user space (because that's the part that
> requires persistence). The rest of the nfs_client_id4
> argument can be formed in the kernel.

Sure we could, but what I was trying to point out is that your names are
just as miserable if you apply your exacting logic to them, and we're 
going
to be hard-pressed to meet the bar unless we name it something 
completely
meaningless.

>> Right now nfsuuid outputs uuids (or whatever was previously stored, 
>> up to 64
>> chars).
>
> Right. It can output anything, not just a UUID. It will
> output whatever is in the special file. If the content
> of that file is a random string, what will nfsuuid output?

64 chars of random string.

> If someone runs nfsuuid expecting a UUID and gets the
> random crap that was previously stored in the persistence
> file, wouldn't that be surprising?

Nothing on stdout surprises me.  After years of sysadmining I'm cold as 
ice.

> Precisely because it has the ability to output whatever
> is in the persistence file, and that file does not have
> to contain a UUID, that makes this tool not "nfsuuid".

Alright.

>> It generates uuids, like uuidgen.  Without something external to
>> itself (a udev rule, for example), it doesn't have any relationship 
>> to an
>> NFS client's id.  It could plausably be used in the future for other 
>> parts
>> of NFS to generate persitent uuids.  The only reason we don't just 
>> use
>> `uuidgen` is that we want to wrap it with some persistence.  A would 
>> a name
>> like stickyuuid be better?
>
> No: a UUID is a data type. Would you call the tool
> nfsunsignedint if we stored the ino of the net namespace
> instead?

I really might, sadly, just to get the job done.

> Do you have any other specific use cases for an nfsuuid
> tool today? If you do, then you have a platform for more
> generality. If not, then there really isn't any other
> purpose for this tool. It is a single-tasker, and we
> shouldn't treat it otherwise.

All the arguments for exacting tolerances on how it should be named 
apply
equally well to anything that implies its output will be used for nfs 
client
ids, or host ids.

So, I've forgotten your other suggestions that don't have anything to do
with NFS or clients or machine IDs.  I'll make more suggestions:

persistychars
mostlyuuids
theuniquifier
randomonce
distroschoice

I like these.  These names are more fun.  :)

In good will,
Ben


