Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6254C6FB9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 15:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiB1Onz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 09:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiB1Onz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 09:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BBD1275CE
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646059394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7tgc4VMtwpuNult+JTqGuP27wSvmxkapfHw7Vow5jJk=;
        b=P3G85v8uWRacgel8huXC1BkUM/GupPNGFvHx1UCdNWvs6iGhsHAidJB27iXSjpu2no3N7w
        X0evIbOz3UYER3oVImUfEaw3G8p1dIKQBttrEe4I2KagZvFZB0QbTv5/8tKcq41XizvUOj
        LiwblzQF2yyisMB+MDN70RfxJizhaIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-nn_FKwivO-KnUEzrNENRDg-1; Mon, 28 Feb 2022 09:43:08 -0500
X-MC-Unique: nn_FKwivO-KnUEzrNENRDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 821B0801DDC;
        Mon, 28 Feb 2022 14:43:07 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA5C37D3CB;
        Mon, 28 Feb 2022 14:43:06 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     NeilBrown <neilb@suse.de>,
        "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Date:   Mon, 28 Feb 2022 09:43:05 -0500
Message-ID: <BA04DD0D-4B05-48AD-9E22-AB7524E737C3@redhat.com>
In-Reply-To: <164600585213.15631.6635814364853064416@noble.neil.brown.name>
References: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
 <189aba691b341f64f653817c9cdf018ef34ac257.camel@hammerspace.com>
 <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
 <164600585213.15631.6635814364853064416@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27 Feb 2022, at 18:50, NeilBrown wrote:

> On Wed, 09 Feb 2022, Benjamin Coddington wrote:
>> On 8 Feb 2022, at 15:27, Trond Myklebust wrote:
>>
>>> On Tue, 2022-02-08 at 15:03 -0500, Benjamin Coddington wrote:
>>>> In order to differentiate client state, assign a random uuid to the
>>>> uniquifing portion of the client identifier when a network 
>>>> namespace
>>>> is
>>>> created.  Containers may still override this value if they wish to
>>>> maintain
>>>> stable client identifiers by writing to
>>>> /sys/fs/nfs/net/client/identifier,
>>>> either by udev rules or other means.
>>>>
>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>> ---
>>>>  fs/nfs/sysfs.c | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
>>>> index 8cb70755e3c9..9b811323fd7f 100644
>>>> --- a/fs/nfs/sysfs.c
>>>> +++ b/fs/nfs/sysfs.c
>>>> @@ -167,6 +167,18 @@ static struct nfs_netns_client
>>>> *nfs_netns_client_alloc(struct kobject *parent,
>>>>         return NULL;
>>>>  }
>>>>  
>>>> +static void assign_unique_clientid(struct nfs_netns_client *clp)
>>>> +{
>>>> +       unsigned char client_uuid[16];
>>>> +       char *uuid_str = kmalloc(UUID_STRING_LEN + 1,
>>>> GFP_KERNEL);
>>>> +
>>>> +       if (uuid_str) {
>>>> +               generate_random_uuid(client_uuid);
>>>> +               sprintf(uuid_str, "%pU", 
>>>> client_uuid);
>>>> +               rcu_assign_pointer(clp->identifier,
>>>> uuid_str);
>>>> +       }
>>>> +}
>>>> +
>>>>  void nfs_netns_sysfs_setup(struct nfs_net *netns, struct net 
>>>> *net)
>>>>  {
>>>>         struct nfs_netns_client *clp;
>>>> @@ -174,6 +186,8 @@ void nfs_netns_sysfs_setup(struct nfs_net 
>>>> *netns,
>>>> struct net *net)
>>>>         clp = nfs_netns_client_alloc(nfs_client_kobj, net);
>>>>         if (clp) {
>>>>                 netns->nfs_client = clp;
>>>> +               if (net != &init_net)
>>>> +                       assign_unique_clientid(clp);
>>>
>>> Why shouldn't this go in nfs_netns_client_alloc? At this point 
>>> you've
>>> already published the pointer in netns, so you're prone to races.
>>
>> No reason it shouldn't, I'll put it there if that's what you want.
>>
>> I thought that's why it was RCU-ed, and figured we'd just do it 
>> before
>> the
>> uevent.
>>
>>> Also, why the exclusion of init_net?
>>
>> Because we're unique enough if we're not in a network namespace, and 
>> any
>> additional uniqueness we might need (due to NAT, or cloned VMs) 
>> /should/
>> be
>> getting from udev, as you envisioned.  That way, if we are getting
>> uniquified, its from a source that's likely persistent/deterministic.
>> If we
>> just generate a random uniquifier, its going to be different next 
>> boot
>> if
>> there's no udev rule and userspace helpers.  That's going to make 
>> things
>> a
>> lot worse for simple setups.
>
> I liked this patch at first, but I no longer think it is a good idea.
>
> It is quite possible today for containers to provide sufficient
> uniqueness simply by setting a unique hostname before the first NFS
> mount.
> Quite possibly some containers already do this, and are working
> perfectly.
>
> If we add new randomness, the they will get a different identifier on
> each boot.  This is bad for exactly the same reason that it is bad for
> "net == &init_net".
>
> i.e.  I believe this patch could cause a regression for working sites.
> The regression may not be immediately obvious, but it may still be
> there.
> For this reason, I think this patch should be dropped.

I agree, Trond please drop this patch.

Ben

