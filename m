Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105FF4959EE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 07:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348634AbiAUGaU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jan 2022 01:30:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53944 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiAUGaU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jan 2022 01:30:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B922210E2;
        Fri, 21 Jan 2022 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642746619;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JACFRqlC966zZ1PtI0GVzYG9qWesDuNqnrbnJs9CP38=;
        b=n3m9VYgmShXbN86U6M59f+BWTs/pmCe+kyTVBJMekhfleqGSvbn+W3baa0KBRkCI4wTOXJ
        m/KVmYKjgQqXfeQE5vEDfbWgFGigye8IFhEFyNI4KJQ+kxKinW4OUNyku+yMUzeNn/vQmv
        Ha1OynsNBVNH8cZryV7k+nKzaEVFgqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642746619;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JACFRqlC966zZ1PtI0GVzYG9qWesDuNqnrbnJs9CP38=;
        b=j5OYB2cI8+ULYThes0o7QMzfeRPmoWadHus4B7oM03TVZbTd7Rz5MQPUSTZDg1ywtipf+3
        DaCl45bKOTLhBnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3140B13345;
        Fri, 21 Jan 2022 06:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9MB2CvtS6mEYCgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 06:30:19 +0000
Date:   Fri, 21 Jan 2022 07:30:17 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     ltp@lists.linux.it, kernel@openvz.org, linux-nfs@vger.kernel.org,
        Steve Dickson <SteveD@redhat.com>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] rpc_lib.sh: fix portmapper detection in case of socket
 activation
Message-ID: <YepS+Y760GoylOum@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
 <YenNsuS1gcA9tDe3@pevik>
 <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
 <YepE066MwWSf7wAK@pevik>
 <31a29913-11f4-8dfd-6c5c-735673dcd1a2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a29913-11f4-8dfd-6c5c-735673dcd1a2@virtuozzo.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> > > I had to add this patch to make 'runltp -f net.rpc' pass just after
> > > container is started - that happens in container autotests here.
> > Yep, I suspected this. Because on normal linux distro it's working right after
> > boot (tested on rpc01.sh). Can't this be a setup issue?

> This depends on what is installed and how it is configured.

> But definitely the state with rpcbind process not running and systemd is
> listening on rpcbind sockets - is valid.

> In the setup where the issue was caught, the test harness creates a
> container with minimal centos8 setup inside, boots it, and starts ltp
> inside.

> Just reproduced manually:

> [root@vz8 ~]# vzctl start 1000
> Starting Container ...
> ...
> [root@vz8 ~]# vzctl enter 1000
> entered into CT 1000
> CT-1000 /# pidof rpcbind
> CT-1000 /# rpcinfo > /dev/null 2>&1
> CT-1000 /# pidof rpcbind
> 678
> CT-1000 /#

Thanks for info. I'm asking because if it's a setup bug it should not be hidden
by workaround but reported. I suppose normal Centos8 VM works.

Kind regards,
Petr
