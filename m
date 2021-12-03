Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB153467FFE
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 23:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383436AbhLCWmr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 17:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383433AbhLCWmq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 17:42:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BAAC061751
        for <linux-nfs@vger.kernel.org>; Fri,  3 Dec 2021 14:39:21 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 59E655EE6; Fri,  3 Dec 2021 17:39:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 59E655EE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638571161;
        bh=W+2bzaCWQ40MPa69ZqX4doZWoS93Xp+G4RdLu6KeT4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3MwVjhqYQyyiLX6pe7Yxr96rTvoAboZMY8V0KhQMDZXQfPVMCCnDn0dvHSImsaG5
         RaIA7ftrdBeEjF3xWBhruOML4903YmeWOuYA61UaBcOTs+Kyll0UCWhyF2PaC5AqAV
         alSbsZiT4EQDyQOiPRtOmMTzn1fRqeFtJK4M6WnU=
Date:   Fri, 3 Dec 2021 17:39:21 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Steve Dickson <steved@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsdcld: use WAL journal for faster commits
Message-ID: <20211203223921.GA6151@fieldses.org>
References: <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
 <20211201174205.GB26415@fieldses.org>
 <20211201180339.GC26415@fieldses.org>
 <20211201195050.GE26415@fieldses.org>
 <20211203212200.GB3930@fieldses.org>
 <20211203215531.GC3930@fieldses.org>
 <469DF1ED-C2AB-43CE-AB70-BFD2AFC2A68D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469DF1ED-C2AB-43CE-AB70-BFD2AFC2A68D@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 03, 2021 at 10:07:19PM +0000, Chuck Lever III wrote:
> 
> 
> > On Dec 3, 2021, at 4:55 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > Currently nfsdcld is doing three fdatasyncs for each upcall.  Based on
> > SQLite documentation, WAL mode should also be safe, and I can confirm
> > from an strace that it results in only one fdatasync each.
> > 
> > This may be a bottleneck e.g. when lots of clients are being created or
> > expired at once (e.g. on reboot).
> > 
> > Not bothering with error checking, as this is just an optimization and
> > nfsdcld will still function without.  (Might be better to log something
> > on failure, though.)
> 
> I'm in full philosophical agreement for performance improvements
> in this area. There are some caveats for WAL:
> 
>  - It requires SQLite v3.7.0 (2010). configure.ac may need to be
>    updated.

Makes sense.  But I dug around a bit, and how to do this is a total
mystery to me....

>  - All processes using the DB file have to be on the same system.
>    Not sure if this matters for some DR scenarios that nfs-utils
>    is supposed to support.

I don't think we support that.

>  - WAL mode is persistent; you could set this at database creation
>    time and it should be sti cky.

I wanted to upgrade existing databases too, and figured there's no harm
in calling it on each startup.

>  - Documentation says "synchronous = FULL is the most commonly
>    used synchronous setting when not in WAL mode." Why are both
>    PRAGMAs necessary here?

Maybe they're not; I think I did see that FULL is actually the default
but I can't find that in the documentation right now.

--b.

> 
> I agree that nfsdcld functionality is not affected if the first
> PRAGMA fails.
> 
> 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> > utils/nfsdcld/sqlite.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/utils/nfsdcld/sqlite.c b/utils/nfsdcld/sqlite.c
> > index 03016fb95823..b248eeffa204 100644
> > --- a/utils/nfsdcld/sqlite.c
> > +++ b/utils/nfsdcld/sqlite.c
> > @@ -826,6 +826,9 @@ sqlite_prepare_dbh(const char *topdir)
> > 		goto out_close;
> > 	}
> > 
> > +	sqlite3_exec(dbh, "PRAGMA journal_mode = WAL;", NULL, NULL, NULL);
> > +	sqlite3_exec(dbh, "PRAGMA synchronous = FULL;", NULL, NULL, NULL);
> > +
> > 	ret = sqlite_query_schema_version();
> > 	switch (ret) {
> > 	case CLD_SQLITE_LATEST_SCHEMA_VERSION:
> > -- 
> > 2.33.1
> > 
> 
> --
> Chuck Lever
> 
> 
