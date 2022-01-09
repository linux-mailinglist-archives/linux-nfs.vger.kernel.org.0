Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72B8488CE3
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jan 2022 23:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiAIWlZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jan 2022 17:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiAIWlZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jan 2022 17:41:25 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB672C06173F
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jan 2022 14:41:24 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7E55770C2; Sun,  9 Jan 2022 17:41:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7E55770C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641768084;
        bh=n1vCz0iegtMXkMGLa63IkSZ8kZVjQJANJUm2yqYyhwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t85c+Idy3tNE9XxrPfDCH9+cLrMfcRgn2BSfYkTUm9q9rWHIjq4h2RsBevOXhmbUJ
         sdIT6+00wKTiwAkMyTIOGUxsXfLoND2o9yhVJ5DvNWLNK1yR06w8BHJhM8DJheStwx
         mxFqwF8IYPaPxq4gmUVjghYHq1lCXcxBpF+ryrRo=
Date:   Sun, 9 Jan 2022 17:41:24 -0500
From:   "'bfields@fieldses.org'" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Message-ID: <20220109224124.GC1589@fieldses.org>
References: <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
 <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
 <20220104153205.GA7815@fieldses.org>
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
 <20220105220353.GF25384@fieldses.org>
 <164176553564.25899.8328729314072677083@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164176553564.25899.8328729314072677083@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 10, 2022 at 08:58:55AM +1100, NeilBrown wrote:
> On Thu, 06 Jan 2022, 'bfields@fieldses.org' wrote:
> 
> > +Locking can also provide cache consistency:
> >  .P
> > -NLM supports advisory file locks only.
> > -To lock NFS files, use
> > -.BR fcntl (2)
> > -with the F_GETLK and F_SETLK commands.
> > -The NFS client converts file locks obtained via
> > -.BR flock (2)
> > -to advisory locks.
> > +Before acquiring a file lock, the client revalidates its cached data for
> > +the file.  Before releasing a write lock, the client flushes to the
> > +server's stable storage any data in the locked range.
> 
> Surely the client revalidates *after* acquiring the lock on the server. 
> Otherwise the revalidation has now value.

Gah.

@@ -1489,9 +1493,9 @@ locks.
 .P
 Locking can also provide cache consistency:
 .P
-Before acquiring a file lock, the client revalidates its cached data for
-the file.  Before releasing a write lock, the client flushes to the
-server's stable storage any data in the locked range.
+After acquiring a file lock and before using any cached data, the client
+revalidates its cache.  Before releasing a write lock, the client flushes to
+the server's stable storage any data in the locked range.
 .P
 A distributed application running on multiple NFS clients can take a
 read lock for each range that it reads and a write lock for each range that

--b.
