Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8974D31C1
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 16:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiCIP3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 10:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiCIP3q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 10:29:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75354B10A5
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 07:28:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9D3A01BE1; Wed,  9 Mar 2022 10:28:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9D3A01BE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646839726;
        bh=f5xkWa2EN1kaKA0o8VuAs7oihIdULEHhlZmuSihjjd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MelBq6OYLMUsyn9nrhOuqlCI9w06n6TdMVmVml5gFbol1N/2cdWV2eHzA9m98Oq2T
         q5JYSiMWviyMUaUt5So3BdVKy+cPO3PwTrCPCuNuROFqtgCr+EMqMBJtW/xFikT+9X
         KXXh+LYsYdgH9cXTmn+CYeAzXD0BlCYNNfu8VPMc=
Date:   Wed, 9 Mar 2022 10:28:46 -0500
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
Message-ID: <20220309152846.GC6633@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217131531.2890-2-richard@nod.at>
 <20220308214437.GB22644@fieldses.org>
 <692661836.127800.1646819014252.JavaMail.zimbra@nod.at>
 <20220309141945.GA6633@fieldses.org>
 <2098326047.128064.1646838131178.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2098326047.128064.1646838131178.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 09, 2022 at 04:02:11PM +0100, Richard Weinberger wrote:
> Bruce,
> 
> ----- Ursprüngliche Mail -----
> > Von: "bfields" <bfields@fieldses.org>
> >> Concurrent access to the database is synchronized using a shared rwlock (on
> >> shared memory).
> >> reexpdb_init.lock is used to make sure that creating and initializing the shared
> >> memory/lock
> >> happens once.
> > 
> > Could you point me to sqlite documentation that explains why the user
> > would need to do their own locking?
> 
> https://www.sqlite.org/rescode.html#busy
>  
> > I assumed sqlite would do any necessary locking for you.  It seems like
> > a core function for a database.
> 
> Well, SQLite does locking but no queuing.
> So, as soon somebody is writing the data base it is locked and all other
> read/writes will fail either with SQLITE_BUSY or SQLITE_LOCKED.
> It is up to the user how to react on that.
>  
> That's why I chose to use a shared rwlock where a task can *wait* upon
> conflicting access.
> 
> Maybe there is a better way do it, dunno.

Oh, got it, thanks for the explanation.

Assuming writes are rare, maybe a dumb retry loop would be adequate.
Sounds like that's what we'd need anyway if we were to share the
database between cooperating re-export servers.  (Would we have a
performance problem in that case, if several reexport servers start at
once and all start trying to populate the shared database?  I don't
know.)

Anyway, it's a judgement call, fair enough.  Might be worth a brief
comment, at least.

> >> > What are the two tables used for?  Naively I'd've thought the
> >> > "subvolumes" table was redundant.
> >> 
> >> fsidnums is used to store generated and predefined fsid numbers.
> >> It is only used in reexport modes auto-fsidnum and predefined-fsidnum.
> >> 
> >> subvolumes contains a list of subvolumes which a are likely in use by
> >> a client. Up start all these paths will get touched such that they can
> >> be exported.
> > 
> > The fsidnums also contains that same list of paths, right?  So I don't
> > understand why we need both.
> 
> In the current design generated fsidnums will stay forever while the paths
> in subvolumes can get cleaned.
>  
> > Also, if we're depending on touching all the paths on startup, something
> > is wrong.
> 
> I think we talked about that already and agreed that it should work without
> touching. So far I didn't had a chance to investigate into this.

OK.  Do you think you could look into that, and strip this down to the
one auto-fsidnum case, and then continue the discussion?  I think that'd
clarify things.

As I say, I wouldn't necessarily be opposed to later adding a reexport=
option back in, but for now I'd first like to see if we can find the
simplest patches that will solve the problem in one good-enough way.

> > What we want to do is touch the path when we get an upcall for the given
> > fsid.  That way we don't have to assume, for example, that the system
> > will never expire mounts that haven't been used recently.
> > 
> >> >> +/*
> >> >> + * This query is a little tricky. We use SQL to find and claim the smallest
> >> >> free fsid number.
> >> > 
> >> > Yes, that is a little tricky.  Is it necessary?  My SQL Is rusty, but
> >> > the database should be able to pick a unique value for us, shouldn't it?
> >> 
> >> SQLite can generate a unique value, but we cannot select the range.
> >> It will give a value between 0 and 2^64.
> >> We need an id between 1 and 2^32.
> > 
> > Surely that CHECK constraint doesn't somehow cause sqlite to generate
> > non-unique primary keys?  At worst I'd think it would cause INSERTs to
> > fail if the ordinary primary-key-choosing algorithm chooses something
> > over 2^32.
> 
> The CHECK is just a paranoid check. My SQL INSERT generates ids starting with 1.
> Sure, if you run it 2^32 times, it will fail due to the CHECK.

OK.

--b.
