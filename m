Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A64A9C3A
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbiBDPtj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 10:49:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359840AbiBDPtj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 10:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643989778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56dip43t/OqFBh1S6yh4ZZoextL4wmvFJxojWieo0qM=;
        b=byC4IxcQyAcBbHJjtvhCs13Fv2E9RcUEITYPn5WG8GsO4QqQI9cZJjjpRBQ8VOGNxyPpoe
        EdAsCyN1Y0itBotVC/yvxoCwU7Dr4hQ5nDnM0kw2ECN3HPWAaA34jeJk5KD1n5U1lYKPDB
        z/H8XvgdiWHADBpb+HxLSMXxiwLgy+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-KDVyAne2NOuXRHH6pTxSnw-1; Fri, 04 Feb 2022 10:49:37 -0500
X-MC-Unique: KDVyAne2NOuXRHH6pTxSnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 393F01898291;
        Fri,  4 Feb 2022 15:49:36 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE08A7D3E8;
        Fri,  4 Feb 2022 15:49:35 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Steve Dickson" <steved@redhat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Fri, 04 Feb 2022 10:49:34 -0500
Message-ID: <32889B9A-1293-4050-8131-726042D1EAD9@redhat.com>
In-Reply-To: <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <87EAC6F6-C450-4642-A11A-55247C791D66@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 Feb 2022, at 10:17, Chuck Lever III wrote:

> Hi Ben-
>
>> On Feb 4, 2022, at 7:56 AM, Benjamin Coddington <bcodding@redhat.com> 
>> wrote:
>>
>> The nfs4id program will either create a new UUID from a random source 
>> or
>> derive it from /etc/machine-id, else it returns a UUID that has 
>> already
>> been written to /etc/nfs4-id.  This small, lightweight tool is 
>> suitable for
>> execution by systemd-udev in rules to populate the nfs4 client 
>> uniquifier.
>
> Glad to see some progress here!
>
> Regarding the generation of these uniquifiers:
>
> If you have a UUID generation mechanism, why bother with machine-id at 
> all?

We'd like to deterministically tie our clients to /etc/machine-id for a 
number
of reasons:

  - it condenses the work of "uniquifying" a machine to a single point 
in
    the distro.

  - the machine-id has a number of ways to handle cases where machines 
are
    PXE-booted, cloned, or used as "golden images" for cloud containers 
(See
    machine-id(5)).

  - the machine-id has good documentation and awareness (See sd-id128(3) 
and
    friends)

> As noted in bugzilla@redhat 1801326, these uniquifiers will appear in 
> the
> clear on open networks (and we all know open network deployments are 
> common
> for NFS). I don't believe that TLS or GSS Kerberos will be available 
> to
> protect every deployment from a network MitM from sniffing these 
> values and
> attempting to make some hay with them. In particular, any deployment 
> of a
> system before we have in-transit NFS encryption implemented will be
> vulnerable.

Yes.

> Some young punk from Tatooine could drop a bomb down our reactor 
> shaft,
> and then where would we be?

This little tool isn't attempting to solve any of those problems.

> Regarding the storage of these uniquifiers:
>
> As discussed in earlier threads, we believe that storing multiple 
> unique-ids
> in one file, especially without locking to prevent tearing of data in 
> the
> file, is problematic. Now, it might be that the objection to this was 
> based
> on storing these in a file that can simultaneously be edited by humans
> (ie, /etc/nfs.conf). But I would prefer to see a separate file used 
> for
> each uniquifier / network namespace.

This tool isn't trying to store uniquifiers for multiple namespaces, or
describe how it ought to be used in relation to namespaces.  It only
attempts to create a fairly persistent unique value that can be 
generated
and consumed from a udev rule.

I think the problem of how to create uniquifiers for every net namespace
might easily be solved by bind-mounding /etc/nfs4-id into the
namespace-specific filesystem, or a number of other ways.  That would be 
an
interesting new topic.  New sources could be added to this tool in the
future that are namespace-aware.

Thanks for the look at this!

Ben

