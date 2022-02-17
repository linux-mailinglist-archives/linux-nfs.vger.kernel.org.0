Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133C4BA716
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 18:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiBQR1g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 17 Feb 2022 12:27:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiBQR1f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 12:27:35 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C918557A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 09:27:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BC38D608A38A;
        Thu, 17 Feb 2022 18:27:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IQZfVbaGUeUn; Thu, 17 Feb 2022 18:27:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8C3C0608A39E;
        Thu, 17 Feb 2022 18:27:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aM2QqGvezTAK; Thu, 17 Feb 2022 18:27:15 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5C910608A38A;
        Thu, 17 Feb 2022 18:27:15 +0100 (CET)
Date:   Thu, 17 Feb 2022 18:27:15 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <1525788049.60261.1645118835162.JavaMail.zimbra@nod.at>
In-Reply-To: <20220217163332.GA16497@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at> <20220217163332.GA16497@fieldses.org>
Subject: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: nfs-utils: Improving NFS re-exports
Thread-Index: 0rAqgeyS8u7BAZzNcZnevLJFV2o9VQ==
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
> An: "richard" <richard@nod.at>
> CC: "linux-nfs" <linux-nfs@vger.kernel.org>, "david" <david@sigma-star.at>, "luis turcitu"
> <luis.turcitu@appsbroker.com>, "david young" <david.young@appsbroker.com>, "david oberhollenzer"
> <david.oberhollenzer@sigma-star.at>, "trond myklebust" <trond.myklebust@hammerspace.com>, "anna schumaker"
> <anna.schumaker@netapp.com>, "chris chilvers" <chris.chilvers@appsbroker.com>
> Gesendet: Donnerstag, 17. Februar 2022 17:33:32
> Betreff: Re: [RFC PATCH 0/6] nfs-utils: Improving NFS re-exports

> On Thu, Feb 17, 2022 at 02:15:25PM +0100, Richard Weinberger wrote:
>> This is the second iteration of the NFS re-export improvement series for
>> nfs-utils.
>> While the kernel side didn't change at all and is still small,
>> the userspace side saw much more changes.
>> Please note that this is still an RFC, there is room for improvement.
>> 
>> The core idea is adding new export option: reeport=
>> Using reexport= it is possible to mark an export entry in the exports file
>> explicitly as NFS re-export and select a strategy how unique identifiers
>> should be provided.
>> "remote-devfsid" is the strategy I have proposed in my first patch,
>> I understand that this one is dangerous. But I still find it useful in some
>> situations.
>> "auto-fsidnum" and "predefined-fsidnum" are new and use a SQLite database as
>> backend to keep track of generated ids.
>> For a more detailed description see patch "exports: Implement new export option
>> reexport=".
> 
> Thanks, I'll try to take a look.
> 
> Before upstreaming, I would like us to pick just one.  These kind of
> options tend to complicate testing and documentation and debugging.
> 
> For an RFC, though, I think it makes sense, so I'm fine with keeping
> "reexport=" while we're still exploring the different options.  And,
> hey, maybe we end up adding more than one after we've upstreamed the
> first one.

Which one do you prefer?
"predefined-fsidnum" should be the safest one to start.

>> - When re-exporting, fs.nfs.nfs_mountpoint_timeout should be set to 0
>>   to make subvolumes not vanish.
>>   Is this something exportfs should do automatically when it sees an export entry
>>   with a reexport= option?
> 
> Setting the timeout to 0 doesn't help with re-export server reboots.
> After a reboot is another case where we could end up in a situation
> where a client hands us a filehandle for a filesystem that isn't mounted
> yet.
> 
> I think you want to keep a path with each entry in the database.  When
> mountd gets a request for a filesystem it hasn't seen before, it stats
> that path, which should trigger the automounts.

I have implemented that already. This feature is part of this series. :-)
 
> And it'd be good to have a test case with a client (Linux client or
> pynfs) that, say, opens a file several mounts deep, then reboots the
> reexport server, then tries to, say, write to the file descriptor after
> the reboot.  (Or maybe there's a way to force the mounts to expire as a
> shortcut instead of doing a full reboot.)

Okay, I'll test that.

>> - exportd saw only minimal testing so far, I wasn't aware of it yet. :-S
>> - Currently wtere is no way to release the shared memory which contains the
>> database lock.
>>   I guess it could be released via exportfs -f, which is the very last exec in
>>   nfs-server.service
>> - Add a tool to import/export entries from the reexport database which obeys the
>> shared lock.
>> - When doing v4->v4 or v3->v4 re-exports very first read access to a file block
>> a few seconds until
>>   the client does a retransmit.
>>   v3->v3 works fine. More investigation needed.
> 
> Might want to strace mountd and look at the communication over the
> /proc/fs/nfsd/*/channel files, maybe mountd is failing to respond to an
> upcall.

Ahh. The upcall might be the issue. Thanks for the pointer.

Thanks,
//richard
