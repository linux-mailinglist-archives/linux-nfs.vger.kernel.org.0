Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19094FC27B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiDKQhn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiDKQhn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 12:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E6F71580D
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649694926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nvFpMZ8s3+v+49wQ1sRdkKXNZbf655+cktIdf1tKyw=;
        b=OX2Y3R+0nIVCYxKctZPrU05g+L1KfLVTwdes6qqFgrTq0xt50f0K8GkDjoaqKMy6sNzc+h
        uqbB5dkKB/JmOBDD0cB8IFDtPbS4Y0tROcKCnp6D1nWwst/lfS90qWHd5T6QkTwPSIoXvH
        0ht08tBFUgFUpb0cq52usmXHiTTFyGk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-GDKG1Z_KPVq5_pVQLw_Z7g-1; Mon, 11 Apr 2022 12:35:25 -0400
X-MC-Unique: GDKG1Z_KPVq5_pVQLw_Z7g-1
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso16136208qvb.15
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 09:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6nvFpMZ8s3+v+49wQ1sRdkKXNZbf655+cktIdf1tKyw=;
        b=HIp5rycJYjppuAKegpaU5e1duucgE7zKaaHLsoQ+e3EQsLTVIqdeCuYFip5SWTLvJ4
         6GQeE+dk9Q0MFU1xkStXxvRkvabgK9Mk6SCMs08V/MKwMao+jGlH8QjVrR8YeRqphIjc
         smwwY07lYP0Jckmm2QlHOrBcXkr4Xt2h+jwK3YlY1oZox5VA6QThrUdU9yIID+jV99GX
         L16rMY9x1Virq3a+xPfdIGAT7mTX9OW4hhuWFasZ2B5/25T0tVJBD5MFAX/FKwfFYaQu
         CS+76v7UtgmWgUPcGMFKWf44fDTse9CCBxw7spYPfxgYlxXyqjY+bvYrVzr4FhPJoXd6
         dvoA==
X-Gm-Message-State: AOAM530M+WydpIB/6cQN6NtFiGt08ZFRBRhIcNabkzjX0WBib1BuBn9e
        85KEg65PJq3tpVt9IfuZfUlnL8aMDzltzc5kO4J9WRVEn8e7+cUU2yVYkGItOFyyOcgitQF5c6X
        cFVyRW6u45eEGqiohy3m3
X-Received: by 2002:ad4:5cc3:0:b0:441:1959:cb51 with SMTP id iu3-20020ad45cc3000000b004411959cb51mr28137431qvb.112.1649694924310;
        Mon, 11 Apr 2022 09:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI9le9jMXocBP05c78SsJTxp69HlF9FLiq1+1c7h71jr6JM6+9h8fXiB0qJaxIciBdY2ok3w==
X-Received: by 2002:ad4:5cc3:0:b0:441:1959:cb51 with SMTP id iu3-20020ad45cc3000000b004411959cb51mr28137399qvb.112.1649694923813;
        Mon, 11 Apr 2022 09:35:23 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.124.94])
        by smtp.gmail.com with ESMTPSA id e7-20020ac85987000000b002e1b7fa2201sm25536480qte.56.2022.04.11.09.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 09:35:23 -0700 (PDT)
Message-ID: <bfb62753-1032-9f79-d9eb-d2e7b583f985@redhat.com>
Date:   Mon, 11 Apr 2022 12:35:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC] man: Add nfs-client-identifier(7)
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <164821972362.2101249.3667415795547016876.stgit@morisot.1015granger.net>
 <c54d9f3a-d6ee-26cd-b136-1b4d90ca591c@redhat.com>
 <DFA7AD32-4B1A-4E37-91B2-90907FDB9587@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <DFA7AD32-4B1A-4E37-91B2-90907FDB9587@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/8/22 3:45 PM, Chuck Lever III wrote:
> 
> 
>> On Apr 8, 2022, at 2:44 PM, Steve Dickson <steved@redhat.com> wrote:
>>
>> Hey!
>>
>> Again... My apologizes for the tartness..
>>
>> On 3/25/22 10:48 AM, Chuck Lever wrote:
>>> This is an alternative approach to documenting the needs for
>>> configuring good NFSv4 client identifiers. Instead of adding to
>>> nfs(5), a new man page is created in section 7, since this
>>> information is not tied to a specific command or interface.
>>> Moreover, there is now room for a more expansive discussion:
>>>   - An introductory section links together file open and lock state,
>>>     client leases, and the client's NFSv4 identifier.
>>>   - A discussion of security issues has been added.
>>> Source for the new man page is added under systemd/ because I
>>> couldn't think of a better place. Suggestions welcome.
>> I figure as much with this being under systemd/
>> I don't think it really matters :-)
>>
>> Well I read this a number of times, as well
>> as, Neil's version both will written and
>> similar in a number of places...
>>
>> After reading this version I came a way with the
>> feeling how useful will this be for an admin that
>> simply trying to do a unique NFS mount in a
>> container... I'm concern it will not be.
> 
> As I see it, average admins are not going to ever
> need to read this man page. Rather, it's audience
> is distributors and people who build container
> images. These are not admins of individual systems.
> These will be architects and developers, so they
> will need the detail.
I was thinking you were targeting a different audience,
but I'm going to slightly disagree that admins
will not be building containers.

> 
> So I kind of agree: maybe not useful for an admin,
> but the setting itself is not necessarily meant
> for admins. We would like to enable distributors
> to set it correctly whenever possible.
I still think admins build containers, but I do see
the value of addressing other type of engineer

> 
> 
>> I don't think an admin is really going to care
>> about scope of what the co_ownerid string
>> does or how it works... they just want to set
>> the damn thing :-)
> 
> Exactly. We hope that we can make this setting
> automatic for many normal cases. An admin should
> not normally need to consult it, so this man page
> is not targeted towards admins. It's targeted
> towards the folks who provide the automation for
> setting this value.
> 
> 
>> The section on lease state was very interesting,
>> to me... but an admin is not going to care about
>> something they have no control over. IMHO
> 
>> Again, very well written but I think this is
>> better as a kernel doc than man page trying
>> to help an admin set an unique identifier.
> 
> Neil's purpose, as I understood it, was to write
> down a problem statement and some design choices.
> Very good things to do, but it doesn't scream
> "man page" to me either.
> 
> OTOH it's not yet clear whether we actually need
> admin documentation for this setting. If we can
> indeed settle on some scripting to handle it in
> most cases, then probably an admin doc for this
> setting would not be necessary. It remains to be
> seen.
Since we can't seem to agree on how to set this
maybe we should let the admins comes up with
the setting script... Just a different way to
look at it.

> 
> 
>> So I'm leaning towards Neil's version (once
>> the clean up version is posted) because it
>> is more concise as to needs to happen.
> 
> To be clear, Neil's approach was to add more
> to nfs(5) which is already large, and this
> new stuff is not really about a mount option.
> 
> Also, I'm not sure he is planning to update his
> patch, as he's stepped aside from the discussion:
> 
> https://lore.kernel.org/linux-nfs/164782886934.24302.3305618822276162890@noble.neil.brown.name/
Yeah... I missed that... I can understand his frustration...
> 
> However it would easy enough to convert my
> patch into a new file under Documentation/...
> Then man page(s) could be written later if we
> decide there is still need to do that.Who generally reads those docs? I don't think
admins do but could be wrong... Maybe they
are closer to the your intended audience??

> 
> 
>> Maybe we could talk about this at the
>> upcoming bakeathon?
> 
> We could, but there are folks here on list
> who will not be at the bake-a-thon, and there
> would be no archive of the discussion. I don't
> see that another multi-week delay is helpful
> either.
> 
> IMO continuing to work this out on linux-nfs@
> is better, but I can work either way.
Good point... on list is probably best.

steved
> 
> 
>> Those are my two cents :-)
>>
>> steved.
>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   systemd/Makefile.am               |    2
>>>   systemd/nfs-client-identifier.man |  261 +++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 262 insertions(+), 1 deletion(-)
>>>   create mode 100644 systemd/nfs-client-identifier.man
>>> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
>>> index e7f5d818a913..b1b203fe9093 100644
>>> --- a/systemd/Makefile.am
>>> +++ b/systemd/Makefile.am
>>> @@ -50,7 +50,7 @@ unit_files += \
>>>   endif
>>>     man5_MANS	= nfs.conf.man
>>> -man7_MANS	= nfs.systemd.man
>>> +man7_MANS	= nfs.systemd.man nfs-client-identifier.man
>>>   EXTRA_DIST = $(unit_files) $(man5_MANS) $(man7_MANS)
>>>     generator_dir = $(unitdir)/../system-generators
>>> diff --git a/systemd/nfs-client-identifier.man b/systemd/nfs-client-identifier.man
>>> new file mode 100644
>>> index 000000000000..fb4937f6597b
>>> --- /dev/null
>>> +++ b/systemd/nfs-client-identifier.man
>>> @@ -0,0 +1,261 @@
>>> +.\"@(#)nfs-client-identifier.7
>>> +.\"
>>> +.\" SPDX-License-Identifier: GPL-2.0-only
>>> +.\"
>>> +.\" Copyright (c) 2022 Oracle and/or its affiliates.
>>> +.\"
>>> +.TH NFS-CLIENT-ID 7 "22 Mar 2022"
>>> +.SH NAME
>>> +nfs-client-identifier \- NFSv4 client identifier
>>> +.SH DESCRIPTION
>>> +The NFSv4 protocol uses "lease-based file locking".
>>> +Leases help NFSv4 servers
>>> +provide file lock guarantees and manage their resources.
>>> +.P
>>> +Simply put,
>>> +an NFSv4 server creates a lease for each NFSv4 client.
>>> +The server collects each client's file open and lock state
>>> +under the lease for that client.
>>> +.P
>>> +The client is responsible for periodically renewing its leases.
>>> +While a lease remains valid, the server holding that lease guarantees
>>> +the file locks the client has created remain in place.
>>> +.P
>>> +If a client stops renewing its lease (for example, if it crashes),
>>> +the NFSv4 protocol allows the server to remove the
>>> +client's open and lock state after a certain period of time.
>>> +When a client restarts, it indicates to servers that
>>> +open and lock state associated with its previous leases is
>>> +no longer valid.
>>> +.P
>>> +In addition, each NFSv4 server manages
>>> +a persistent list of client leases.
>>> +When the server restarts, it uses this list to
>>> +distinguish between requests
>>> +from clients that held state before the server restarted
>>> +and
>>> +from clients that did not.
>>> +This enables file locks to persist safely across server restarts.
>>> +.SS "NFSv4 client identifiers"
>>> +Each NFSv4 client presents an
>>> +identifier to NFSv4 servers so that they can
>>> +associate the client with its lease.
>>> +Each client's identifier consists of two elements:
>>> +.TP
>>> +.B co_ownerid
>>> +An arbitrary but fixed string.
>>> +.TP
>>> +.B "boot verifier"
>>> +A 64-bit incarnation verifier that enables a server
>>> +to distinguish successive boot epochs of the same client.
>>> +.P
>>> +The NFSv4.0 specification refers to these two items as an
>>> +.IR nfs_client_id4 .
>>> +The NFSv4.1 specification refers to these two items as a
>>> +.IR client_owner4 .
>>> +.P
>>> +NFSv4 servers tie this identifier to the principal and
>>> +security flavor that the client used when presenting it.
>>> +Servers use this principal to authorize
>>> +subsequent lease modification operations sent by the client.
>>> +Effectively this principal is a third element of the identifier.
>>> +.P
>>> +As part of the identity presented to servers, a good
>>> +.I co_ownerid
>>> +string has several important properties:
>>> +.IP \- 2
>>> +The
>>> +.I co_ownerid
>>> +string identifies the client during reboot recovery,
>>> +therefore the string is persistent across client reboots.
>>> +.IP \- 2
>>> +The
>>> +.I co_ownerid
>>> +string helps servers distinguish the client from others,
>>> +therefore the string is globally unique.
>>> +Note that there is no central authority that assigns
>>> +.I co_ownerid
>>> +strings.
>>> +.IP \- 2
>>> +Because it often appears on the network in the clear,
>>> +the
>>> +.I co_ownerid
>>> +string does not reveal private information about the client itself.
>>> +.IP \- 2
>>> +The content of the
>>> +.I co_ownerid
>>> +string is set and unchanging before the client attempts NFSv4 mounts after a restart.
>>> +.IP \- 2
>>> +The NFSv4 protocol does not place a limit on the size of the
>>> +.I co_ownerid
>>> +string, but most NFSv4 implementations do not tolerate
>>> +excessively long
>>> +.I co_ownerid
>>> +strings.
>>> +.SS "Protecting NFSv4 lease state"
>>> +NFSv4 servers utilize the
>>> +.I client_owner4
>>> +as described above to assign a unique lease to each client.
>>> +Under this scheme, there are circumstances
>>> +where clients can interfere with each other.
>>> +This is referred to as "lease stealing".
>>> +.P
>>> +If distinct clients present the same
>>> +.I co_ownerid
>>> +string and use the same principal (for example, AUTH_SYS and UID 0),
>>> +a server is unable to tell that the clients are not the same.
>>> +Each distinct client presents a different boot verifier,
>>> +so it appears to the server as if there is one client
>>> +that is rebooting frequently.
>>> +Neither client can maintain open or lock state in this scenario.
>>> +.P
>>> +If distinct clients present the same
>>> +.I co_ownerid
>>> +string and use distinct principals,
>>> +the server is likely to allow the first client to operate
>>> +normally but reject subsequent clients with the same
>>> +.I co_ownerid
>>> +string.
>>> +.P
>>> +If a client's
>>> +.I co_ownerid
>>> +string or principal are not stable,
>>> +state recovery after a server or client reboot is not guaranteed.
>>> +If a client unexpectedly restarts but presents a different
>>> +.I co_ownerid
>>> +string or principal to the server,
>>> +the server orphans the client's previous open and lock state.
>>> +This blocks access to locked files until the server removes the orphaned
>>> +state.
>>> +.P
>>> +If the server restarts and a client presents a changed
>>> +.I co_ownerid
>>> +string or principal to the server,
>>> +the server will not allow the client to reclaim its open
>>> +and lock state, and may give those locks to other clients
>>> +in the mean time.
>>> +This is referred to as "lock stealing".
>>> +.P
>>> +Lease stealing and lock stealing
>>> +increase the potential for denial of service
>>> +and in rare cases even data corruption.
>>> +.SS "Selecting an appropriate client identifier"
>>> +By default, the Linux NFSv4 client implementation constructs its
>>> +.I co_ownerid
>>> +string
>>> +starting with the words "Linux NFS" followed by the client's UTS node name
>>> +(the same node name, incidentally, that is used as the "machine name" in
>>> +an AUTH_SYS credential).
>>> +In small deployments, this construction is usually adequate.
>>> +Often, however, the node name by itself is not adequately unique,
>>> +and can change unexpectedly.
>>> +Problematic situations include:
>>> +.IP \- 2
>>> +NFS-root (diskless) clients, where the local DCHP server (or equivalent) does
>>> +not provide a unique host name.
>>> +.IP \- 2
>>> +"Containers" within a single Linux host.  If each container has a separate
>>> +network namespace, but does not use the UTS namespace to provide a unique
>>> +host name, then there can be multiple NFS client instances with the
>>> +same host name.
>>> +.IP \- 2
>>> +Clients across multiple administrative domains that access a common NFS server.
>>> +If hostnames are not assigned centrally then uniqueness cannot be
>>> +guaranteed unless a domain name is included in the hostname.
>>> +.P
>>> +Linux provides two mechanisms to add uniqueness to its
>>> +.I co_ownerid
>>> +string:
>>> +.TP
>>> +.B nfs.nfs4_unique_id
>>> +This module parameter can set an arbitrary uniquifier string
>>> +via the kernel command line, or when the
>>> +.B nfs
>>> +module is loaded.
>>> +.TP
>>> +.I /sys/fs/nfs/client/net/identifier
>>> +This virtual file, available since Linux 5.3, is local to the network
>>> +namespace in which it is accessed and so can provide distinction between
>>> +network namespaces (containers) when the hostname remains uniform.
>>> +.RS
>>> +.P
>>> +Note that this file is empty on name-space creation.
>>> +If the container system has access to some sort of per-container
>>> +identity then that uniquifier can be used. For example,
>>> +a uniquifier might be formed at boot using the container's internal
>>> +identifier:
>>> +.RS 4
>>> +.br
>>> +sha256sum /etc/machine-id | awk '{print $1}' \\
>>> +.br
>>> +   > /sys/fs/nfs/client/net/identifier
>>> +.RE
>>> +.SS Security considerations
>>> +The use of cryptographic security for lease management operations
>>> +is strongly encouraged.
>>> +.P
>>> +If NFS with Kerberos is not configured, a Linux NFSv4 client
>>> +uses AUTH_SYS and UID 0 as the principal part of its client identity.
>>> +This configuration is not only insecure,
>>> +it increases the risk of lease and lock stealing.
>>> +However, it might be the only choice for client configurations
>>> +that have no local persistent storage.
>>> +.I co_ownerid
>>> +string uniqueness and persistence is critical in this case.
>>> +.P
>>> +When a Kerberos keytab is present on a Linux NFS client,
>>> +the client attempts to use one of the principals in that keytab
>>> +when identifying itself to servers.
>>> +Alternately, a single-user client with a Kerberos principal
>>> +can use that principal in place of the client's host principal.
>>> +.P
>>> +Using Kerberos for this purpose enables the client and server
>>> +to use the same lease for operations covered by all
>>> +.B sec=
>>> +settings.
>>> +Additionally,
>>> +the Linux NFS client uses the RPCSEC_GSS security flavor
>>> +with Kerberos and the integrity QOS
>>> +to prevent in-transit modification of lease modification requests.
>>> +.SS "Additional notes"
>>> +The Linux NFSv4 client establishes a single lease on each NFSv4 server
>>> +it accesses.
>>> +NFSv4 mounts from a Linux NFSv4 client of a particular server then
>>> +share that lease.
>>> +.P
>>> +Once a client establishes open and lock state,
>>> +the NFSv4 protocol enables lease state to transition
>>> +to other servers, following data that has been migrated.
>>> +This hides data migration completely from running applications.
>>> +The Linux NFSv4 client facilitates state migration by presenting the same
>>> +.I client_owner4
>>> +to all servers it encounters.
>>> +.SH FILES
>>> +.sp
>>> +\fI/sys/fs/nfs/client/net/identifier\fP
>>> +.RS 4
>>> +API that adds a unique string to the local NFSv4 client identifier
>>> +.RE
>>> +.sp
>>> +\fI/etc/machine-id\fP
>>> +.RS 4
>>> +Local machine ID configuration file
>>> +.RE
>>> +.sp
>>> +\fI/etc/krb5.keytab\fP
>>> +.RS 4
>>> +Repository of Kerberos host principals
>>> +.RE
>>> +.\" .SH AUTHORS
>>> +.\" This page was written by Neil Brown and Chuck Lever,
>>> +.\" with assistance from Benjamin Coddington.
>>> +.SH SEE ALSO
>>> +.BR nfs (5).
>>> +.PP
>>> +RFC\ 7530 for the NFSv4.0 specification.
>>> +.br
>>> +RFC\ 8881 for the NFSv4.1 specification.
>>> +.SH COLOPHON
>>> +This page is part of the
>>> +.I nfs-utils
>>> +package.
>>
> 
> --
> Chuck Lever
> 
> 
> 

