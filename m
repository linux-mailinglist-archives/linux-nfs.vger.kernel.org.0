Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA34AA04C
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiBDTon (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 14:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231869AbiBDTom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 14:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644003882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZtoT9sD/xvWVsp2hkobgBXMR+ezCAmcu6nvaDP1iR2U=;
        b=GlrvZwH5yy2GUsqQouWw3Mnx3Fiiu95sF8w4o6fr1fjAqxN4SvaCsHvo5KxG/7sbD/Yjrl
        ipLzG2zQORGMlQpL7Q5gdczYhrsrJUpZcysWl4BVYSLVZ5ACe8+aqnr94+JeY70GSQ1yop
        A4+fJHoi1qLUVNRzlBhcPpfuAQk099k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-HdPNspP9NQGA0r39nBH6-w-1; Fri, 04 Feb 2022 14:44:41 -0500
X-MC-Unique: HdPNspP9NQGA0r39nBH6-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 347C31091DA3;
        Fri,  4 Feb 2022 19:44:40 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1D404D729;
        Fri,  4 Feb 2022 19:44:39 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Steve Dickson" <steved@redhat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Fri, 04 Feb 2022 14:44:38 -0500
Message-ID: <D4204C55-78E7-4078-852E-FECD38BD3AA9@redhat.com>
In-Reply-To: <26803BBB-4F2C-4EFD-BC8D-A50A5C361E5C@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>
 <32889B9A-1293-4050-8131-726042D1EAD9@redhat.com>
 <26803BBB-4F2C-4EFD-BC8D-A50A5C361E5C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Feb 2022, at 13:45, Chuck Lever III wrote:

>> On Feb 4, 2022, at 10:49 AM, Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>
>> On 4 Feb 2022, at 10:17, Chuck Lever III wrote:
>>
>>> As discussed in earlier threads, we believe that storing multiple 
>>> unique-ids
>>> in one file, especially without locking to prevent tearing of data 
>>> in the
>>> file, is problematic. Now, it might be that the objection to this 
>>> was based
>>> on storing these in a file that can simultaneously be edited by 
>>> humans
>>> (ie, /etc/nfs.conf). But I would prefer to see a separate file used 
>>> for
>>> each uniquifier / network namespace.
>>
>> This tool isn't trying to store uniquifiers for multiple namespaces, 
>> or
>> describe how it ought to be used in relation to namespaces.  It only
>> attempts to create a fairly persistent unique value that can be 
>> generated
>> and consumed from a udev rule.
>>
>> I think the problem of how to create uniquifiers for every net 
>> namespace
>> might easily be solved by bind-mounding /etc/nfs4-id into the
>> namespace-specific filesystem, or a number of other ways.  That would 
>> be an
>> interesting new topic.
>
> I don't think that's a new topic at all. This mechanism needs to
> deal with containers properly from day one. That's why we are
> using a udev rule for this purpose in the first place instead of
> something more obvious.

This isn't a mechanism to deal with containers, its a small helper 
utility
that we'd like to use to solve an existing, non-container problem in a 
way
that's future-proof for containers.

> The problem is that a network namespace (to which the persistent
> uniquifier is attached) and an FS namespace (in which the persistent
> uniquifier is stored) are created and managed independently.
>
> We need to agree on how NFSv4 clients in containers are to be
> supported before the proposed tool can be evaluated fully.

I disagree.  This tool is immediately useful when I have multiple NAT-ed 
NFS
clients with the same hostnames and they end up with identical NFS 
client
identifiers.  That's the problem this little utility helps to solve, and
that's the real-world issue we've been asked to fix.

I don't think we have to solve all the problems at once, and I think 
this is
headed in the right direction.  I can commit to working on the namespace
part.. but there's a number of things that aren't clear to me there:

  - is udev namespace-aware?

  - can we get udev rules to trigger for a namespace (my simple tests 
show
    that my "root" system-udevd doesnt see the creation or entry of 
processes
    into a new network namespace)  Maybe we need to run udevd in every
    network namespace?

  - can uniquifiers be network-namespace uniquified by just using 
information
    available within a udev rule, or do we really need this utility to 
be
    namespace aware?

There's a bunch of stuff to discuss and figure out (unless someone else
already has), maybe we can start a new thread?

Ben

