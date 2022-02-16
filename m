Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B925E4B9294
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 21:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiBPUoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Feb 2022 15:44:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiBPUoi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Feb 2022 15:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92D982A4162
        for <linux-nfs@vger.kernel.org>; Wed, 16 Feb 2022 12:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645044264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+oY00Zg9esZIRltZQsjcaKSZv1uaJCVcUEbihr6KkoE=;
        b=BowTD73hm6OY2xb4RFMCpR/PWWA2EJ5+LetAuFMH7aFimazl+nnVu7QGUukcUDN4ShRdJA
        6Q9fZrf3/6IPknSZkIYQ19FasOdb2/IzjIA+IlGA02yHc2V9X6kb8/hsltGwJ+9v7saMl1
        YEzdIZhCBO0vebQ1OkfMHZV9EgZI5ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-aPVwmbYINZmkqoa641bohA-1; Wed, 16 Feb 2022 15:44:23 -0500
X-MC-Unique: aPVwmbYINZmkqoa641bohA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C9BA185302C;
        Wed, 16 Feb 2022 20:44:22 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C08F55ED29;
        Wed, 16 Feb 2022 20:44:21 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Neil Brown" <neilb@suse.de>, "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] nfsuuid: a tool to create and persist nfs4 client
 uniquifiers
Date:   Wed, 16 Feb 2022 15:44:20 -0500
Message-ID: <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>
In-Reply-To: <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
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
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Feb 2022, at 14:35, Chuck Lever III wrote:

> On Feb 16, 2022, at 2:01 PM, Benjamin Coddington <bcodding@redhat.com> 
> wrote:
>> Coming back to this.. so it seems at least part of our disagreement 
>> about
>> the name had to do with a misunderstanding of what the tool did.
>
> I understand what your implementation does. I don't
> understand why it works that way.
>
> The disagreement is that I feel like you're trying to
> abstract the operation of this little tool in ways that
> no-one asked for. It's purpose is very narrow and
> completely related to the NFSv4 client ID.
>
>
>> Just to finally clear the air about it: the tool does not write to 
>> sysfs, it
>> doesn't try to modify the client in any way.  I'm going to leave it 
>> up to
>> the distros.
>
> Seems to me that the distros care only about where the
> persistence file is located. I can't see a problem with
> Neil's suggestion that the tool also write into sysfs.
> The location of the sysfs API is invariant; there should
> be no need to configure it or expose it.
>
> Can you give a reason why the tool should /not/ write
> into sysfs?

So that there is a division of work.  Systemd-udevd handles the event 
and
sets the attribute, not the tool.  Systemd-udevd is already set up to 
have
the appropriate selinux contexts and rights to make these changes.
Systemd-udevd's logging can clearly show the action and result instead
of it being hidden away inside this tool.  Systemd-udevd doesn't expect
programs to make the changes, its designed around the idea that programs
provide information and it makes the changes.

You can see how many issues we got into by imagining what would happen 
if
users ran this tool.  If the tool doesn't modify the client, that's one 
less
worry we have upstream, its the distro's problem.

If the tool writes to sysfs, then someone executing it manually can 
change
the client's id with a live mount.  That's bad.  That's less likely to
happen if its all tucked away in a udev rule.  I know the 
counter-arguement
"you can write to sysfs yourself", but I still think its better this 
way.

There's increased flexibility and utility - if an expert sysadmin wants 
to
distinguish groups of clients, they can customize their udev rule to add
custom strings to the uniquifier using the many additional points of 
data
available in udev rules.

>> Considering this, I think your only remaining objection to "nfsuuid" 
>> is that it
>> might return data other than a uuid if someone points it at a file 
>> that
>> contains data other than a uuid.
>>
>> I can fix that.  And its probably not a bad idea either.  The nfsuuid 
>> tool
>> can ensure that the persisted data is a uuid.
>
> Why is that necessary? I agree that any random string will
> do, as long as it is the same after client reboots and is
> globally unique. It can be a BLAKE2 hash or anything else.
> Is there a hard requirement that the uniquifier is in the
> form of an RFC 4122 UUID? (if there is, the requirement
> should be explained in the man page).
>
> I have no problem with using a UUID. I just don't believe
> there's a hard requirement that it /must/ be a UUID.

There's no hard requirement, as you know.  Its just an extremely useful
datatype for this purpose.  I'm sure we could make a `nfsblake2`, but I
can't imagine why.

>> Maybe I also need to change the man page or description of the patch 
>> to be
>> clearer about what the tool does.  Any suggestions there?
>
> I've made some in previous responses. The rules about
> reboot persistence and global uniqueness are paramount.

Ok, I can re-read the threads and find them and include them.

> So I initially agreed with Trond's statement that the
> client ID uniquifier is not specific to a particular
> mount request, so doesn't belong in mount.nfs.
>
> All still true. But...
>
> If mount.nfs handles it instead, you don't need a
> separate tool (naming problem solved), there's no lag
> between when the uniquifier is set and the first
> SETCLIENTID (race condition solved), no udev rule is
> needed (no additional implementation complexity), and
> no man page and no new module parameters (no
> additional administrative configuration complexity).

Yep.  The race is a problem.

> What's not to like?

Not much.  How can we figure out what we want to do as a community 
before
doing it all the ways?

Ben

