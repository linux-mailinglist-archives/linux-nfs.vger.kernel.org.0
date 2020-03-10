Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3318049F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCJRSd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 13:18:33 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:58752 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJRSd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Mar 2020 13:18:33 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id E3319E0225
        for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2020 18:18:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de E3319E0225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1583860710; bh=1YfmquB9h7V0971TnZT2GOeR4WdLURyXvSHqB1zSZ5c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=y6vLm+U0ngSRwvQA6G167RVeeM4FUVgqRi6rbJsGxcamdAn4ENK7j1y3rMCZq5D1f
         WzjlRAhzuqzRS1XInkwk1EaJJVSLz7LYwXoRnjM3cxGthQR4OR2OPDcXMLAqrk3A8J
         11zWO+56KbscqhD9tf7rhkJIrcrEzVa7TQY/T0BM=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id DF66D120262;
        Tue, 10 Mar 2020 18:18:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id B8813100076;
        Tue, 10 Mar 2020 18:18:30 +0100 (CET)
Date:   Tue, 10 Mar 2020 18:18:30 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <883213303.4100093.1583860710686.JavaMail.zimbra@desy.de>
In-Reply-To: <20200227135925.GA11561@fieldses.org>
References: <20200214204544.GA30533@fieldses.org> <20200227135925.GA11561@fieldses.org>
Subject: Re: pynfs python 3 flag day
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: pynfs python 3 flag day
Thread-Index: xOHmxVQWelB850221gPABxhHdgmlHA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Hi Bruce,

works for me! Thanks for the effort.

Tigran.

----- Original Message -----
> From: "J. Bruce Fields" <bfields@fieldses.org>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Thursday, February 27, 2020 2:59:25 PM
> Subject: Re: pynfs python 3 flag day

> I've pushed the python 3 changes to the master branch, so pynfs now
> *only* works with python 3:
> 
>	git://linux-nfs.org/~bfields/pynfs.git
> 
> This works for me, but, as I've said, some of the functionality that I
> don't use is probably broken.  Apologies--let me know if you run across
> anything.
> 
> The last hold-up was the gssapi code.  But it turns out pynfs gssapi has
> been broken for a while.  So, I'm still working on it, but I couldn't
> see any reason to hold back the python 3 changes for it.
> 
> --b.
> 
> 
> J. Bruce Fields (21):
>      st_delegations: don't reimplement join()
>      Fix module imports for python 3
>      python 3 has no long type
>      python3: exception scope
>      python3: open results file in binary mode
>      python3: / no longer does integer division
>      showresults: remove unnecessary import code
>      python3: StandardError no longer defined
>      python3: the socket structure has changed
>      python3: machinename should be bytes, not string
>      python 3 map returns iterator not list
>      python3: sort works differently
>      python3: make "path" commandline argument a byte array
>      python3: RPCClient.ipaddress should be bytes
>      python3: tag should be bytes
>      NFS4Client.create_obj() should expect bytes
>      python3: need binary array instead of t.code string
>      python3: make a lot of strings byte arrays
>      python3 has no xrange()
>      python3: loop over dict while removing entries
>      use_obj: expect bytes, not string
> 
> nfs4.0/TODO                                 |   2 +-
> nfs4.0/lib/rpc/rpc.py                       |  35 ++--
> nfs4.0/lib/rpc/rpcsec/base.py               |   2 +-
> nfs4.0/lib/rpc/rpcsec/sec_auth_sys.py       |   7 +-
> nfs4.0/nfs4lib.py                           |  70 ++++----
> nfs4.0/servertests/environment.py           | 121 ++++++-------
> nfs4.0/servertests/st_acl.py                |   8 +-
> nfs4.0/servertests/st_close.py              |  74 ++++----
> nfs4.0/servertests/st_commit.py             |   6 +-
> nfs4.0/servertests/st_compound.py           |   2 +-
> nfs4.0/servertests/st_create.py             |  38 ++--
> nfs4.0/servertests/st_delegation.py         | 159 ++++++++---------
> nfs4.0/servertests/st_fslocations.py        |   2 +-
> nfs4.0/servertests/st_link.py               |  40 ++---
> nfs4.0/servertests/st_lock.py               | 262 ++++++++++++++--------------
> nfs4.0/servertests/st_lockt.py              |  30 ++--
> nfs4.0/servertests/st_locku.py              |  78 ++++-----
> nfs4.0/servertests/st_lookup.py             |  68 ++++----
> nfs4.0/servertests/st_lookupp.py            |   4 +-
> nfs4.0/servertests/st_nverify.py            |   2 +-
> nfs4.0/servertests/st_open.py               | 184 +++++++++----------
> nfs4.0/servertests/st_openconfirm.py        |  16 +-
> nfs4.0/servertests/st_opendowngrade.py      |  44 ++---
> nfs4.0/servertests/st_putfh.py              |   8 +-
> nfs4.0/servertests/st_read.py               |  36 ++--
> nfs4.0/servertests/st_readdir.py            |  48 ++---
> nfs4.0/servertests/st_reboot.py             |  92 +++++-----
> nfs4.0/servertests/st_releaselockowner.py   |   6 +-
> nfs4.0/servertests/st_remove.py             |  78 ++++-----
> nfs4.0/servertests/st_rename.py             | 209 +++++++++++-----------
> nfs4.0/servertests/st_renew.py              |   4 +-
> nfs4.0/servertests/st_replay.py             |  66 +++----
> nfs4.0/servertests/st_secinfo.py            |  16 +-
> nfs4.0/servertests/st_setattr.py            | 122 ++++++-------
> nfs4.0/servertests/st_setclientid.py        |  74 ++++----
> nfs4.0/servertests/st_setclientidconfirm.py |  12 +-
> nfs4.0/servertests/st_spoof.py              |   8 +-
> nfs4.0/servertests/st_verify.py             |   2 +-
> nfs4.0/servertests/st_write.py              |  94 +++++-----
> nfs4.0/testserver.py                        |  22 ++-
> nfs4.1/client41tests/environment.py         |  10 +-
> nfs4.1/nfs4client.py                        |  16 +-
> nfs4.1/nfs4commoncode.py                    |   4 +-
> nfs4.1/nfs4lib.py                           |  44 ++---
> nfs4.1/nfs4server.py                        |   4 +-
> nfs4.1/server41tests/environment.py         | 103 +++++------
> nfs4.1/server41tests/st_compound.py         |   4 +-
> nfs4.1/server41tests/st_create_session.py   |  24 +--
> nfs4.1/server41tests/st_current_stateid.py  |  12 +-
> nfs4.1/server41tests/st_debug.py            |   2 +-
> nfs4.1/server41tests/st_delegation.py       |  24 +--
> nfs4.1/server41tests/st_destroy_clientid.py |   6 +-
> nfs4.1/server41tests/st_destroy_session.py  |   2 +-
> nfs4.1/server41tests/st_exchange_id.py      |  16 +-
> nfs4.1/server41tests/st_open.py             |  24 +--
> nfs4.1/server41tests/st_putfh.py            |   2 +-
> nfs4.1/server41tests/st_reboot.py           |  24 +--
> nfs4.1/server41tests/st_reclaim_complete.py |   6 +-
> nfs4.1/server41tests/st_rename.py           |  92 +++++-----
> nfs4.1/server41tests/st_secinfo.py          |   6 +-
> nfs4.1/server41tests/st_secinfo_no_name.py  |   2 +-
> nfs4.1/server41tests/st_sequence.py         |  32 ++--
> nfs4.1/server41tests/st_sparse.py           |   2 +-
> nfs4.1/testmod.py                           |  14 +-
> nfs4.1/testserver.py                        |  13 +-
> rpc/rpc.py                                  |  30 ++--
> rpc/rpclib.py                               |  12 +-
> rpc/security.py                             |  10 +-
> showresults.py                              |  19 +-
> 69 files changed, 1357 insertions(+), 1353 deletions(-)
> 
> On Fri, Feb 14, 2020 at 03:45:44PM -0500, bfields wrote:
>> I'm hearing more noise about deprecating Python 2, so decided I can't
>> keep ignoring Python 3.
>> 
>> Getting pynfs working on Python 3 is a bigger project than I expected.
>> Keeping it working under Python 2 looks like another project.  So, I'm
>> planning a flag day after which pynfs will require Python 3.
>> 
>> That isn't the way I'd prefer to do it, but there's only so much time I
>> want to spend on this.
>> 
>> I've mostly got the 4.0 server tests working under python 3.  I hope a
>> few more days will be enough to get the 4.1 tests working as well.
>> 
>> When I switch over, I'm afraid a few things will be left broken: any
>> tests that I don't personally run may still have minor python 3 bugs,
>> and I haven't touched the python server code that's used for client
>> testing.
>> 
>> If you stumble across something broken, and you can give me a simple
>> reproducer, feel free to share it with me and I'll take a look.
>> 
>> But for anything complicated, I'll probably need patches.
>> 
>> Again, I apologize for any extra work that creates for anyone, but for
>> now this seems like the best compromise to keep things mostly working
>> without it becoming a bigger time sink for me.
>> 
>> Work so far is in the "python3" branch at
>> 
>> 	git://linux-nfs.org/~bfields/pynfs.git
>> 
>> The history will probably be cleaned up an rewritten before it's done.
>> I'm hoping that'll be in the next week.
>> 
>> It's mostly just a matter of separating out unicode strings and byte
>> arrays.  Protocol data is all the latter (even if the protocol prefers
>> some field to be UTF8, pynfs still needs to be able to handle non-UTF8).
>> But some things have to be unicode strings.
>> 
> > --b.
