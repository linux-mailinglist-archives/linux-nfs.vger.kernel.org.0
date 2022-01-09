Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39002488CC3
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jan 2022 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiAIV7D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jan 2022 16:59:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47472 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiAIV7C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jan 2022 16:59:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FFF51F396;
        Sun,  9 Jan 2022 21:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641765541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99UIg0rRVsByfRiE9jJXgOCzoMPPZU7FxCfsVahoP/c=;
        b=pNNg2jz5JIIZ9vbCBcqly/bGm0D/VaamWG2bSSdB3rhEbkpKhzSMiwdzYgpSUr1lY4cjn3
        tWFChaFEbLk3rf6MoO/qIUtRkqnOFiPLhGljBnwi29LBK1Rpki7nA2lpKpPS7gaPEaxkKi
        SY66Ezut42yagSsH6ch5dZUkovVcR7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641765541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99UIg0rRVsByfRiE9jJXgOCzoMPPZU7FxCfsVahoP/c=;
        b=gsZUfx0VtolJAjnyU1iuq5ZaDNtPu4NIXm8vvwsuXxOzrB/7Jo8d3Ey2ft7QY6drEP2bjy
        gxKnMXDLrHi5ZSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7074713316;
        Sun,  9 Jan 2022 21:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0JrzCaNa22FLYwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 09 Jan 2022 21:58:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "'bfields@fieldses.org'" <bfields@fieldses.org>
Cc:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: Re: client caching and locks
In-reply-to: <20220105220353.GF25384@fieldses.org>
References: <20201001214749.GK1496@fieldses.org>,
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>,
 <20201006172607.GA32640@fieldses.org>,
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>,
 <20220103162041.GC21514@fieldses.org>, =?utf-8?q?=3COSZPR01MB7050F9737016E8?=
 =?utf-8?q?E3F0FD5255EF4A9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?=
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>,
 <20220104153205.GA7815@fieldses.org>,
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>, 
 =?utf-8?q?=3COSZPR01MB7050C5098D47514FFEC2DA82EF4B9=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <20220105220353.GF25384@fieldses.org>
Date:   Mon, 10 Jan 2022 08:58:55 +1100
Message-id: <164176553564.25899.8328729314072677083@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 06 Jan 2022, 'bfields@fieldses.org' wrote:

> +Locking can also provide cache consistency:
>  .P
> -NLM supports advisory file locks only.
> -To lock NFS files, use
> -.BR fcntl (2)
> -with the F_GETLK and F_SETLK commands.
> -The NFS client converts file locks obtained via
> -.BR flock (2)
> -to advisory locks.
> +Before acquiring a file lock, the client revalidates its cached data for
> +the file.  Before releasing a write lock, the client flushes to the
> +server's stable storage any data in the locked range.

Surely the client revalidates *after* acquiring the lock on the server. 
Otherwise the revalidation has now value.

>  .P
> -When mounting servers that do not support the NLM protocol,
> -or when mounting an NFS server through a firewall
> -that blocks the NLM service port,
> -specify the
> -.B nolock
> -mount option. NLM locking must be disabled with the
> -.B nolock
> -option when using NFS to mount
> -.I /var
> -because
> -.I /var
> -contains files used by the NLM implementation on Linux.
> +A distributed application running on multiple NFS clients can take a
> +read lock for each range that it reads and a write lock for each range that
> +it writes.  On its own, however, that is insufficient to ensure that
> +reads get up-to-date data.
>  .P
> -Specifying the
> -.B nolock
> -option may also be advised to improve the performance
> -of a proprietary application which runs on a single client
> -and uses file locks extensively.
> +When revalidating caches, the client is unable to reliably determine the
> +difference between changes made by other clients and changes it made
> +itself.  Therefore, such an application would also need to prevent
> +concurrent writes from multiple clients, either by taking whole-file
> +locks on every write or by some other method.

This looks like it is documenting a bug - I would much rather the bug be
fixed.

If a client opens/reads/closes a file while no other client has the file
open, then it *must* return current data.  Currently (according to
reports) it does not reliably do this.

If a write from this client races with a write from another client
(whether or not locking is used), the fact that fetching the change attr
is not atomic w.r.t IO means that the client *cannot* trust any cached
data after it has closed a file to which it wrote to - unless it had a
delegation.
Hmm.. that sounds a bit convoluted.

1/ If a client opens a file for write but does not get a delegation, and
   then writes to the file, then when it closes the file it *must*
   invalidate any cached data as there could have been a concurrent
   write from another client which is not visible in the changeid
   information. CTO consistency rules allow the client to keep cached
   data up to the close.
2/ If a client opens a file for write and *does* get a delegation, then
   providing it gets a changeid from the server after final write and
   before returning the delegation, it can keep all cached data (until
   the server reports a new changeid).

Note that the inability to cache in '1' *should* *not* be a performance
problem in practice.
a/ if locking is used, cached data is not trusted anyway, so no loss
b/ if locking is not used, then no concurrency is expected, so
   delegations are to be expected, so case '1' doesn't apply.

NeilBrown
