Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79D4D30E8
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiCIOUr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 09:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiCIOUq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 09:20:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21AF4044
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 06:19:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0153348FA; Wed,  9 Mar 2022 09:19:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0153348FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646835586;
        bh=bCImYdsENS3tPMBV2uOd3Z13GABLrRutZzFjwCivDv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/X2XiNQNXPHWpiNpaDBvGPdSxV/rva9GOPIKeYN5YLe0tc8rB/5sUboanwjhCW7Y
         SYnd7ghFp43SQO7hP78ZBAs9O5sXWkG4Q+Yg+RQNH7hUY5u3Tfj2VZhpv0MfhZxEhE
         ho1TgHn9rGwGNTs8KseDX8BI3d7qNhzkO7AH673A=
Date:   Wed, 9 Mar 2022 09:19:45 -0500
From:   bfields <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, david <david@sigma-star.at>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>,
        chris chilvers <chris.chilvers@appsbroker.com>
Subject: Re: [RFC PATCH 1/6] Implement reexport helper library
Message-ID: <20220309141945.GA6633@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217131531.2890-2-richard@nod.at>
 <20220308214437.GB22644@fieldses.org>
 <692661836.127800.1646819014252.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <692661836.127800.1646819014252.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 09, 2022 at 10:43:34AM +0100, Richard Weinberger wrote:
> Bruce,
> 
> ----- Ursprüngliche Mail -----
> > Von: "bfields" <bfields@fieldses.org>
> > On Thu, Feb 17, 2022 at 02:15:26PM +0100, Richard Weinberger wrote:
> >> +#define REEXPDB_SHM_NAME "/nfs_reexport_db_lock"
> >> +#define REEXPDB_SHM_SZ 4096
> >> +#define REEXPDB_INIT_LOCK NFS_STATEDIR "/reexpdb_init.lock"
> >> +#define REEXPDB_DBFILE NFS_STATEDIR "/reexpdb.sqlite3"
> > 
> > I don't know much about sqlite--why do we need to do our own file
> > locking?  If we do need to do it ourself, could we lock the database
> > file instead instead of using a separate lock file?
> 
> Concurrent access to the database is synchronized using a shared rwlock (on shared memory).
> reexpdb_init.lock is used to make sure that creating and initializing the shared memory/lock
> happens once.

Could you point me to sqlite documentation that explains why the user
would need to do their own locking?

I assumed sqlite would do any necessary locking for you.  It seems like
a core function for a database.

> > What are the two tables used for?  Naively I'd've thought the
> > "subvolumes" table was redundant.
> 
> fsidnums is used to store generated and predefined fsid numbers.
> It is only used in reexport modes auto-fsidnum and predefined-fsidnum.
> 
> subvolumes contains a list of subvolumes which a are likely in use by
> a client. Up start all these paths will get touched such that they can
> be exported.

The fsidnums also contains that same list of paths, right?  So I don't
understand why we need both.

Also, if we're depending on touching all the paths on startup, something
is wrong.

What we want to do is touch the path when we get an upcall for the given
fsid.  That way we don't have to assume, for example, that the system
will never expire mounts that haven't been used recently.

> >> +/*
> >> + * This query is a little tricky. We use SQL to find and claim the smallest
> >> free fsid number.
> > 
> > Yes, that is a little tricky.  Is it necessary?  My SQL Is rusty, but
> > the database should be able to pick a unique value for us, shouldn't it?
> 
> SQLite can generate a unique value, but we cannot select the range.
> It will give a value between 0 and 2^64.
> We need an id between 1 and 2^32. 

Surely that CHECK constraint doesn't somehow cause sqlite to generate
non-unique primary keys?  At worst I'd think it would cause INSERTs to
fail if the ordinary primary-key-choosing algorithm chooses something
over 2^32.

--b.
