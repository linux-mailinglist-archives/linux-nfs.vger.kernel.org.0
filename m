Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA784D23F5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Mar 2022 23:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbiCHWLH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Mar 2022 17:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350525AbiCHWLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Mar 2022 17:11:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA164A918
        for <linux-nfs@vger.kernel.org>; Tue,  8 Mar 2022 14:10:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 928B364B9; Tue,  8 Mar 2022 17:10:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 928B364B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1646777407;
        bh=KGuOlxQx/cJiuBH6hZZ+GU3SGyzb3eReZxta9DfREIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYLgM9rlUG00XW3W8NTH2z2JkSMBlCK0rIuJsOQ8lB2xTBr5COrG8V7jtN/Ng3V9z
         s++zhgxi3kSKDu/zxn3kb8DQXlPEEbxyqq47u9kNjZ3T4tvGfaMhBNc+iXdyJvhe34
         CxW5U2FFvjMWH357hSG9sCH/WyLCdzEFvYSIE/WY=
Date:   Tue, 8 Mar 2022 17:10:07 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, david@sigma-star.at,
        luis.turcitu@appsbroker.com, david.young@appsbroker.com,
        david.oberhollenzer@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, chris.chilvers@appsbroker.com
Subject: Re: [RFC PATCH 2/6] exports: Implement new export option reexport=
Message-ID: <20220308221007.GC22644@fieldses.org>
References: <20220217131531.2890-1-richard@nod.at>
 <20220217131531.2890-3-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217131531.2890-3-richard@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 17, 2022 at 02:15:27PM +0100, Richard Weinberger wrote:
> When re-exporting a NFS volume it is mandatory to specify
> either a UUID or numerical fsid= option because nfsd is unable
> to derive a identifier on its own.
> 
> For NFS cross mounts this becomes a problem because nfsd also
> needs a identifier for every crossed mount.
> A common workaround is stating every single subvolume in the
> exports list too.
> But this defeats the purpose of the crossmnt option and is tedious.
> 
> This is where the reexport= tries to help.
> It offers various strategies to automatically derive a identifier
> for NFS volumes and sub volumes.
> Each have their pros and cons.
> 
> Currently three modes are implemented:
> 
> 1. auto-fsidnum
>    In this mode mountd/exportd will create a new numerical fsid
>    for a NFS volume and subvolume. The numbers are stored in a database
>    such that the server will always use the same fsid.
>    The entry in the exports file allowed to skip fsid= entiry but
>    stating a UUID is allowed, if needed.
> 
>    This mode has the obvious downside that load balancing is not
>    possible since multiple re-exporting NFS servers would generate
>    different ids.

This is the one I think it makes sense to concentrate on first.  Ideally
it should Just Work without requiring any configuration.

And then eventually my hope is that we could replace sqlite by a
distributed database to get filehandles that are consistent across
multiple servers.

> 
> 2. predefined-fsidnum
>    This mode works just like auto-fsidnum but does not generate ids
>    for you. It helps in the load balancing case. A system administrator
>    has to manually maintain the database and install it on all re-exporting
>    NFS servers. If you have a massive amount of subvolumes this mode
>    will help because you don't have to bloat the exports list.

OK, I can see that being sort of useful but it'd be nice if we could
start with something more automatic.

> 3. remote-devfsid
>    If this mode is selected mountd/exportd will derive an UUID from the
>    re-exported NFS volume's fsid (rfc7530 section-5.8.1.9).

How does the server take a filehandle with a UUID in it and map that
UUID back to the original fsid?

>    No further local state is needed on the re-exporting server.
>    The export list entry still needs a fsid= setting because while
>    parsing the exports file the NFS mounts might be not there yet.

I don't understand that bit.

>    This mode is dangerous, use only of you're absolutely sure that the
>    NFS server you're re-exporting has a stable fsid. Chances are good
>    that it can change.

The fsid should be stable.

The case I'm worried about is the case where we're reexporting exports
from multiple servers.  Then there's nothing preventing the two servers
from accidentally picking the same fsid to represent different exports.

--b.

>    Since an UUID is derived, reexporting from NFSv3 to NFSv3 is not
>    possible. The file handle space is too small.
>    NFSv3 to NFSv4 works, though.
