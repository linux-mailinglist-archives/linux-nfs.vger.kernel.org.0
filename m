Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EDF4D2C60
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiCIJof convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 9 Mar 2022 04:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCIJof (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 04:44:35 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436811405FF
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 01:43:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DABE0609B3F4;
        Wed,  9 Mar 2022 10:43:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ID8E50-nAbMF; Wed,  9 Mar 2022 10:43:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 69B4860F6B67;
        Wed,  9 Mar 2022 10:43:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1lsuCg5rmKkT; Wed,  9 Mar 2022 10:43:34 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4AA1A609B3F4;
        Wed,  9 Mar 2022 10:43:34 +0100 (CET)
Date:   Wed, 9 Mar 2022 10:43:34 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <692661836.127800.1646819014252.JavaMail.zimbra@nod.at>
In-Reply-To: <20220308214437.GB22644@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at> <20220217131531.2890-2-richard@nod.at> <20220308214437.GB22644@fieldses.org>
Subject: Re: [RFC PATCH 1/6] Implement reexport helper library
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Implement reexport helper library
Thread-Index: SAqI7vRNcOjlIHla7x6oZOmiJcEJIA==
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
> On Thu, Feb 17, 2022 at 02:15:26PM +0100, Richard Weinberger wrote:
>> +#define REEXPDB_SHM_NAME "/nfs_reexport_db_lock"
>> +#define REEXPDB_SHM_SZ 4096
>> +#define REEXPDB_INIT_LOCK NFS_STATEDIR "/reexpdb_init.lock"
>> +#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
> 
> I don't know much about sqlite--why do we need to do our own file
> locking?  If we do need to do it ourself, could we lock the database
> file instead instead of using a separate lock file?

Concurrent access to the database is synchronized using a shared rwlock (on shared memory).
reexpdb_init.lock is used to make sure that creating and initializing the shared memory/lock
happens once.
 
>> +static const char initdb_sql[] = "CREATE TABLE IF NOT EXISTS fsidnums (num
>> INTEGER PRIMARY KEY CHECK (num > 0 AND num < 4294967296), path TEXT UNIQUE);
>> CREATE TABLE IF NOT EXISTS subvolumes (path TEXT PRIMARY KEY); CREATE INDEX IF
>> NOT EXISTS idx_ids_path ON fsidnums (path);";
> 
> I'd personally find it easier to read if these were defined in the place
> where they're used.  (And, honestly, if this is just used once, maybe
> the definition is unnecessary.)

Ok.
 
> What are the two tables used for?  Naively I'd've thought the
> "subvolumes" table was redundant.

fsidnums is used to store generated and predefined fsid numbers.
It is only used in reexport modes auto-fsidnum and predefined-fsidnum.

subvolumes contains a list of subvolumes which a are likely in use by
a client. Up start all these paths will get touched such that they can
be exported.

>> +/*
>> + * This query is a little tricky. We use SQL to find and claim the smallest
>> free fsid number.
> 
> Yes, that is a little tricky.  Is it necessary?  My SQL Is rusty, but
> the database should be able to pick a unique value for us, shouldn't it?

SQLite can generate a unique value, but we cannot select the range.
It will give a value between 0 and 2^64.
We need an id between 1 and 2^32. 
 
>> + * To find a free fsid the fsidnums is left joined to itself but with an offset
>> of 1.
>> + * Everything after the UNION statement is to handle the corner case where
>> fsidnums
>> + * is empty. In this case we want 1 as first fsid number.
>> + */
>> +static const char new_fsidnum_by_path_sql[] = "INSERT INTO fsidnums VALUES
>> ((SELECT ids1.num + 1 FROM fsidnums AS ids1 LEFT JOIN fsidnums AS ids2 ON
>> ids2.num = ids1.num + 1 WHERE ids2.num IS NULL UNION SELECT 1 WHERE NOT EXISTS
>> (SELECT NULL FROM fsidnums WHERE num = 1) LIMIT 1), ?1) RETURNING num;";
>> +static const char fsidnum_by_path_sql[] = "SELECT num FROM fsidnums WHERE path
>> = ?1;";
>> +static const char add_crossed_volume_sql[] = "REPLACE INTO subvolumes
>> VALUES(?1);";
>> +static const char drop_crossed_volume_sql[] = "DELETE FROM subvolumes WHERE
>> path = ?1;";
>> +static const char get_crossed_volumes_sql[] = "SELECT path from subvolumes;";
> ...
>> +/*
>> + * reexpdb_init - Initialize reexport database
>> + *
>> + * Setup shared lock (database is concurrently used by multiple processes),
> 
> So, this should all work when rpc.mountd is run with --num_threads > 1?

Yes, that's why we need the shared rwlock.

Thanks,
//richard
