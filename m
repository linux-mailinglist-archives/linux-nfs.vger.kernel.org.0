Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADB4D2C61
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiCIJob convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 9 Mar 2022 04:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCIJoa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 04:44:30 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2714D271
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 01:43:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5E97C609B3C4;
        Wed,  9 Mar 2022 10:43:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yB7oMt18cYiz; Wed,  9 Mar 2022 10:43:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 83A2B609B3F4;
        Wed,  9 Mar 2022 10:43:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LjDyjBlVaFDU; Wed,  9 Mar 2022 10:43:27 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5892D609B3C4;
        Wed,  9 Mar 2022 10:43:27 +0100 (CET)
Date:   Wed, 9 Mar 2022 10:43:27 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <401495945.127799.1646819007180.JavaMail.zimbra@nod.at>
In-Reply-To: <20220308221007.GC22644@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at> <20220217131531.2890-3-richard@nod.at> <20220308221007.GC22644@fieldses.org>
Subject: Re: [RFC PATCH 2/6] exports: Implement new export option reexport=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: exports: Implement new export option reexport=
Thread-Index: TQGP/1KiauVYsjgH/rY2iehqUHRF+Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce,

----- Ursprüngliche Mail -----
> Von: "bfields" <bfields@fieldses.org>
>> 1. auto-fsidnum
>>    In this mode mountd/exportd will create a new numerical fsid
>>    for a NFS volume and subvolume. The numbers are stored in a database
>>    such that the server will always use the same fsid.
>>    The entry in the exports file allowed to skip fsid= entiry but
>>    stating a UUID is allowed, if needed.
>> 
>>    This mode has the obvious downside that load balancing is not
>>    possible since multiple re-exporting NFS servers would generate
>>    different ids.
> 
> This is the one I think it makes sense to concentrate on first.  Ideally
> it should Just Work without requiring any configuration.

Agreed.
 
> And then eventually my hope is that we could replace sqlite by a
> distributed database to get filehandles that are consistent across
> multiple servers.

Sure. I see at least two options here:

a. Allow multiple SQL backends in nfs-utils. SQLite by default, but also remote MariaDB
or Postgres...

b. Placing the SQLite database on a shared file system that is capable of file locks.
That way we can use SQlite as-is. We just need to handle the SQLITE_LOCKED case in the code.
Luckily writing happens seldom, so this shouldn't be a big deal.

>> 
>> 2. predefined-fsidnum
>>    This mode works just like auto-fsidnum but does not generate ids
>>    for you. It helps in the load balancing case. A system administrator
>>    has to manually maintain the database and install it on all re-exporting
>>    NFS servers. If you have a massive amount of subvolumes this mode
>>    will help because you don't have to bloat the exports list.
> 
> OK, I can see that being sort of useful but it'd be nice if we could
> start with something more automatic.
> 
>> 3. remote-devfsid
>>    If this mode is selected mountd/exportd will derive an UUID from the
>>    re-exported NFS volume's fsid (rfc7530 section-5.8.1.9).
> 
> How does the server take a filehandle with a UUID in it and map that
> UUID back to the original fsid?

knfsd does not need the original fsid. All it sees is the UUID.
If it needs to know which export belongs to a UUID it asks mountd.
In mountd the regular UUID lookup is used then.

>>    No further local state is needed on the re-exporting server.
>>    The export list entry still needs a fsid= setting because while
>>    parsing the exports file the NFS mounts might be not there yet.
> 
> I don't understand that bit.

I tried to explain that with this mode we don't need to store UUID or
fsids on disk.

>>    This mode is dangerous, use only of you're absolutely sure that the
>>    NFS server you're re-exporting has a stable fsid. Chances are good
>>    that it can change.
> 
> The fsid should be stable.

Didn't you explain me last time that it is not?
By fsid I mean:
https://datatracker.ietf.org/doc/html/rfc7530#section-5.8.1.9
https://datatracker.ietf.org/doc/html/rfc7530#section-2.2.5

So after a reboot the very same filesystem could be on different
disks and the major/minor tuple is different. (If the server uses disk  ids
as is).
 
> The case I'm worried about is the case where we're reexporting exports
> from multiple servers.  Then there's nothing preventing the two servers
> from accidentally picking the same fsid to represent different exports.

That's a good point. Since /proc/fs/nfsfs/volumes shows all that information
we can add sanity checks to mountd.

Thanks,
//richard
