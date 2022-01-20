Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64B7494DDB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jan 2022 13:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbiATMYa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jan 2022 07:24:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44108 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbiATMYN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jan 2022 07:24:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D96F521709;
        Thu, 20 Jan 2022 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642681451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TLzZj5p/B0jP9JWghnskbUe3yLhtT75vusRbb/2YDM=;
        b=jJRBTFJQCssCP3ZCi1NoTngd1fq0m3Z2b0TuFJZnAyqln3QBzcNjhSYskqK3FBmFz3iZLC
        2p2TGXB/So77W2Gz28LKux3+k+0MK5/nSAN/EUlJA0nOaXOZ3HJUXiuVTGX0eUk8xjVR0d
        6xdOGjhNT/0qGNtKfxqW521IrgNZPws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642681451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TLzZj5p/B0jP9JWghnskbUe3yLhtT75vusRbb/2YDM=;
        b=xM/jIuRbUc2vXj4quCBjH2f9+8QZ3E2tTnqchcmorOVk1mY3CR4z5xLVXLD/PNzTeFfpLK
        5h7pYfgj+YPQrDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8740B13E9E;
        Thu, 20 Jan 2022 12:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jIpjH2tU6WE7XQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 20 Jan 2022 12:24:11 +0000
Date:   Thu, 20 Jan 2022 13:24:09 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <SteveD@redhat.com>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>,
        ltp@lists.linux.it
Subject: Re: LTP nfslock01 test failing on NFS v3 (lockd: cannot monitor
 10.0.0.2)
Message-ID: <YelUaQHlCp8FHAeQ@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YebcNQg0u5cU1QyQ@pevik>
 <164254391708.24166.6930987548904227011@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164254391708.24166.6930987548904227011@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil, all,

> On Wed, 19 Jan 2022, Petr Vorel wrote:
> > Hi all,

> > this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfslock01
> > looks to be failing on NFS v3:

> > "not unsharing /var makes AF_UNIX socket for host's rpcbind to become available
> > inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd for
> > ltpns, and ports for that instance leak to host's rpcbind and overwrite ports
> > for lockd already active for root namespace. This breaks nfs3 file locking."

> "not unsharing /var" ....  can this be fixed by simply unsharing /var?
> Or is that not simple?

> On could easily argue that RPCBIND_SOCK_PATHNAME in the kernel should be
> changed to "/run/rpcbind.sock".  Does this test suite unshare /run ??

> BTW, your email contains [1], [2], etc which suggests there are links
> somewhere - but there aren't.
I'm sorry, here they are:

[1] https://lore.kernel.org/ltp/590378ee-71af-deb6-6c03-1d2af459ed63@virtuozzo.com/
(the report)

[2] https://lore.kernel.org/ltp/20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com/
(the not yet merged LTP Nikita's patch)

[3] https://github.com/pevik/ltp/commits/nfs_flock/fail-on-error
(my LTP fork with Nikita's patch [2] + strace debugging - with this code I post
the report)

Kind regards,
Petr

> NeilBrown
