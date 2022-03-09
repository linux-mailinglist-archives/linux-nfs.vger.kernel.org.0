Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DF4D3163
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiCIPDO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 9 Mar 2022 10:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiCIPDN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 10:03:13 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54215169F
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 07:02:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 161FB609B3C1;
        Wed,  9 Mar 2022 16:02:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zV1rIYi2uQPy; Wed,  9 Mar 2022 16:02:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 73330609B3C4;
        Wed,  9 Mar 2022 16:02:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y_e3iZZCAuIU; Wed,  9 Mar 2022 16:02:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4C00F609B3C1;
        Wed,  9 Mar 2022 16:02:11 +0100 (CET)
Date:   Wed, 9 Mar 2022 16:02:11 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <2098326047.128064.1646838131178.JavaMail.zimbra@nod.at>
In-Reply-To: <20220309141945.GA6633@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at> <20220217131531.2890-2-richard@nod.at> <20220308214437.GB22644@fieldses.org> <692661836.127800.1646819014252.JavaMail.zimbra@nod.at> <20220309141945.GA6633@fieldses.org>
Subject: Re: [RFC PATCH 1/6] Implement reexport helper library
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Implement reexport helper library
Thread-Index: b4YpHepw4J1rk8uBW3KTuZm9XsF0jg==
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
>> Concurrent access to the database is synchronized using a shared rwlock (on
>> shared memory).
>> reexpdb_init.lock is used to make sure that creating and initializing the shared
>> memory/lock
>> happens once.
> 
> Could you point me to sqlite documentation that explains why the user
> would need to do their own locking?

https://www.sqlite.org/rescode.html#busy
 
> I assumed sqlite would do any necessary locking for you.  It seems like
> a core function for a database.

Well, SQLite does locking but no queuing.
So, as soon somebody is writing the data base it is locked and all other
read/writes will fail either with SQLITE_BUSY or SQLITE_LOCKED.
It is up to the user how to react on that.
 
That's why I chose to use a shared rwlock where a task can *wait* upon
conflicting access.

Maybe there is a better way do it, dunno.

>> > What are the two tables used for?  Naively I'd've thought the
>> > "subvolumes" table was redundant.
>> 
>> fsidnums is used to store generated and predefined fsid numbers.
>> It is only used in reexport modes auto-fsidnum and predefined-fsidnum.
>> 
>> subvolumes contains a list of subvolumes which a are likely in use by
>> a client. Up start all these paths will get touched such that they can
>> be exported.
> 
> The fsidnums also contains that same list of paths, right?  So I don't
> understand why we need both.

In the current design generated fsidnums will stay forever while the paths
in subvolumes can get cleaned.
 
> Also, if we're depending on touching all the paths on startup, something
> is wrong.

I think we talked about that already and agreed that it should work without
touching. So far I didn't had a chance to investigate into this.

> What we want to do is touch the path when we get an upcall for the given
> fsid.  That way we don't have to assume, for example, that the system
> will never expire mounts that haven't been used recently.
> 
>> >> +/*
>> >> + * This query is a little tricky. We use SQL to find and claim the smallest
>> >> free fsid number.
>> > 
>> > Yes, that is a little tricky.  Is it necessary?  My SQL Is rusty, but
>> > the database should be able to pick a unique value for us, shouldn't it?
>> 
>> SQLite can generate a unique value, but we cannot select the range.
>> It will give a value between 0 and 2^64.
>> We need an id between 1 and 2^32.
> 
> Surely that CHECK constraint doesn't somehow cause sqlite to generate
> non-unique primary keys?  At worst I'd think it would cause INSERTs to
> fail if the ordinary primary-key-choosing algorithm chooses something
> over 2^32.

The CHECK is just a paranoid check. My SQL INSERT generates ids starting with 1.
Sure, if you run it 2^32 times, it will fail due to the CHECK.

Thanks,
//richard
