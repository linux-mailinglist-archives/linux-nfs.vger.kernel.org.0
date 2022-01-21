Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27013495979
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 06:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348556AbiAUFaH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jan 2022 00:30:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45682 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348719AbiAUF36 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jan 2022 00:29:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CC3B1F395;
        Fri, 21 Jan 2022 05:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642742997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Qrw2tBXZw6BLb51GobWaXyO72dke3+oxt8WFKSSsdI=;
        b=K042C3kcNuCBQxUvzEQgw+gNVNf+M6JJQi9ggO3WMMgOCiiU4TKvKoB3sVeinWbuvlTEqN
        8x8WRrXKetlPU6JEQmsJ1XkRbIZ76PugBlPL07dtMPqlr9d9UdeqAcUepxa+EUrTgH2jcp
        zGGfjDQmC2R6XhVAogCo1f49Vc24+hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642742997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Qrw2tBXZw6BLb51GobWaXyO72dke3+oxt8WFKSSsdI=;
        b=SuSVz97N0JBfHOdVfNxRYhsadDJnh2l2udOIbpj3Ssl0I3jzBzWZhur/xow6N4Cn1LWU8S
        sqlhn+O+iNUG3CCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8255139C3;
        Fri, 21 Jan 2022 05:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SqeuNtRE6mFgdgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 05:29:56 +0000
Date:   Fri, 21 Jan 2022 06:29:55 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     ltp@lists.linux.it, kernel@openvz.org, linux-nfs@vger.kernel.org,
        Steve Dickson <SteveD@redhat.com>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] rpc_lib.sh: fix portmapper detection in case of socket
 activation
Message-ID: <YepE066MwWSf7wAK@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
 <YenNsuS1gcA9tDe3@pevik>
 <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Nikita,

> 21.01.2022 00:01, Petr Vorel wrote:
> > Hi Nikita,

> > [ Cc: Steve as user-space maintainer, also Neil and whole linux-nfs ]

> > > On systemd-based linux hosts, rpcbind service is typically started via
> > > socket activation, when the first client connects. If no client has
> > > connected before LTP rpc test starts, rpcbind process will not be
> > > running at the time of check_portmap_rpcbind() execution, causing
> > > check_portmap_rpcbind() to report TCONF error.

> > > Fix that by adding a quiet invocation of 'rpcinfo' before checking for
> > > rpcbind.

> > Looks reasonable, but I'd prefer to have confirmation from NFS experts.

> NFS is not involved here, this is about sunrpc tests.
Sure. Just tirpc (in libtirpc or the the old SUN-RPC already removed from glibc)
are used in NFS. Steve is the libtirpc maintainer.

> I had to add this patch to make 'runltp -f net.rpc' pass just after
> container is started - that happens in container autotests here.
Yep, I suspected this. Because on normal linux distro it's working right after
boot (tested on rpc01.sh). Can't this be a setup issue?

Kind regards,
Petr

> Nikita
