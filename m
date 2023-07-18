Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B2C758853
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 00:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjGRWQP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 18:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGRWQO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 18:16:14 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C9198E
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H+0H0hw6W2YgDkTJYzNA75dzqOW/e+1BDAFk4DhZ3dc=; b=Z6F75nbhazeB4rR98ZWON00p2G
        UCBgAY81D/MqXyYwwGTw22cCjSqupC4VxyaPOvUQ6gpf5CvEYnRN1aSAZwNLWnUGx9emjT7XgIqIW
        bm0Sig+BoTinS91JlDpWZ1Fot2+QmM9w6tfPA9vu4JoVsF89dz/xkxpB+BZWmLG9YUj5X2v+v+Elm
        ZMZNUhHqhI+lSFDhSVSKLuCywdUvpPgWxhfHtwf3wlFbZSB7o/Jsk+946jjO5mbV0ZME0oICBIGJg
        cyMGmvDyEsdX2gJxEBlkIZ2AUF3gXOcltJm6Rv0dKTjPKfj0LkerTx8CH7sQs5ZPLsvYezNUSs3Pr
        3cI9HS4g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtps 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qLszG-00HMiE-0H; Wed, 19 Jul 2023 00:16:06 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
        by mail.igalia.com with esmtp (Exim)
        id 1qLszB-000Zvj-5z; Wed, 19 Jul 2023 00:16:05 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.94.2)
        (envelope-from <berto@igalia.com>)
        id 1qLszA-00EeEk-JA; Tue, 18 Jul 2023 22:16:00 +0000
Date:   Tue, 18 Jul 2023 22:16:00 +0000
From:   Alberto Garcia <berto@igalia.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] systemd: Ensure that statdpath exists using
 systemd-tmpfiles
Message-ID: <ZLcPIEUeVKElhqwB@igalia.com>
References: <20230713102531.131072-1-berto@igalia.com>
 <5230337e-b028-0e86-9693-c29f7d1165b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5230337e-b028-0e86-9693-c29f7d1165b2@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jul 15, 2023 at 04:53:02PM -0400, Steve Dickson wrote:
> > This is not the case of rpc-statd: if sm and sm.bak (under
> > $statdpath, which also defaults to /var/lib/nfs) are missing the
> > daemon will refuse to start and will exit with an error.
> Why are they would be missing? They are created on the nfs-utils
> installation.

Hello,

yes, in a traditional Linux system that is indeed the case. The idea
behind this is to add support to factory reset and stateless scenarios
like the ones described here:

   https://0pointer.net/blog/projects/stateless.html

The goal is that a system can boot with an empty /var and
all necessary files and directories are created without user
intervention. In the case of nfs-utils this is already happening
except for rpc-statd.

For projects that use systemd this is generally easy to do without
touching the code because systemd provides directives that can be used
to ensure that /var/lib/foo, /var/log/foo, etc. exist before a service
is started.

In the rpc-statd case this would normally be as simple as adding
something like "StateDirectory=nfs/sm nfs/sm.bak" to the .service
file. However it seems that this one is a bit special because it goes
like this if I'm not mistaken:

1. The configure script determines $statduser (the value of
   --with-statduser, else rpcuser if available, else nobody).

2. 'make install' creates sm / sm.bak followed by chown $statduser

3. rpc.statd starts as root, then does lstat("/var/lib/nfs/sm", &st)
   and finally setgid(st.st_gid) / setuid(st.st_uid). At this point
   uid/gid is not necessarily what was set during configure/make
   install ($statduser/root) because downstreams can create a
   different user/group and change the ownership of those directories.

StateDirectory and similar directives from systemd can only create
directories owned by the user that starts the service, but since here
the service needs to run as root this would not work.

systemd-tmpfiles can be used for cases like this one, and that's why I
chose it for this patch.

> Just curious... how did you test this patch? When I apply it
> I get this error
> 
> Failed to insert: creating /var/lib/nfs/statd/sm/<client>: Permission denied
> STAT_FAIL to <server> for SM_MON of <server_ip>
> 
> Maybe this is packing issue but I'm thinking it is more
> of systemd issue... the permissions on the sm directory
> are
> 283 drwx------. 2 nobody rpcuser 6 Apr 18 20:00 /var/lib/nfs/statd/sm
> instead of
> 283 drwx------. 2 rpcuser rpcuser 6 Apr 18 20:00 /var/lib/nfs/statd/sm

Are you creating a package with the patched sources? If it's something
like the Fedora one then I think that the problem is that since the
configure script does not use --with-statduser then there's a mismatch
between the user that appears in nfs-utils.conf (added by this patch)
and these lines from the .spec file:

%dir %attr(700,rpcuser,rpcuser) %{_sharedstatedir}/nfs/statd
%dir %attr(700,rpcuser,rpcuser) %{_sharedstatedir}/nfs/statd/sm
%dir %attr(700,rpcuser,rpcuser) %{_sharedstatedir}/nfs/statd/sm.bak

So probably /var/lib/nfs/statd/sm is drwx------ nobody but
            /var/lib/nfs/statd    is drwx------ rpcuser ?

Passing --with-statduser=rpcuser to configure should fix this problem.

After having a look at a couple of downstream packages it seems that
they simply don't use --with-statduser at all and change the ownership
to whatever user/group they want in their post-installation scripts.
So they would need to start doing it if this patch is included in
nfs-utils.

I realize that although this should be trivial to handle by downstream
packagers it does require manual intervention so I'm not expecting it
to be completely uncontroversial. But if you like the overall idea I'm
happy to discuss / iterate this patch further. This can of course be
applied only by the downstreams who are interested in this feature,
but since nfs-utils already uses systemd and the change is rather
small I thought it made more sense to have it directly upstream.

Regards,

Berto
