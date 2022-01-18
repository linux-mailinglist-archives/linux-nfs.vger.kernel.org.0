Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7049305D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiARWMI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 17:12:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54080 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349740AbiARWMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 17:12:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23425212B8;
        Tue, 18 Jan 2022 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642543923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIjGoioz1ktw+V2nDlWEmosZi3TFcipP21grgpN+1V0=;
        b=gaY5uJ1oI+p1+NKVysvm/SE7c0eXXqunxjC+rxHTQHojHvA7zr2W7gHvJOoZS9/2xHSCnR
        rMaR2UlYk8nfdUOWbFbmwKFgK4Rm6H4bRj3KE4SqhEAx77obgtmv5rmtTQStTD9xRRMjgR
        wNsNY2TaJN8wgqvvDz2LjErHKNiYXZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642543923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIjGoioz1ktw+V2nDlWEmosZi3TFcipP21grgpN+1V0=;
        b=p9rAbPEHAH/GkzjdVt4UYmnDTTwJxkP7+H4//IGoW754UKGW8MHbFx8xPdRTBSnNxqzIn5
        w5+6i52UNNI6iLBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64CC713AD9;
        Tue, 18 Jan 2022 22:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xZtaCDA752EeGQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jan 2022 22:12:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Petr Vorel" <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Steve Dickson" <SteveD@redhat.com>,
        "Nikita Yushchenko" <nikita.yushchenko@virtuozzo.com>,
        ltp@lists.linux.it
Subject: Re: LTP nfslock01 test failing on NFS v3 (lockd: cannot monitor 10.0.0.2)
In-reply-to: <YebcNQg0u5cU1QyQ@pevik>
References: <YebcNQg0u5cU1QyQ@pevik>
Date:   Wed, 19 Jan 2022 09:11:57 +1100
Message-id: <164254391708.24166.6930987548904227011@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 19 Jan 2022, Petr Vorel wrote:
> Hi all,
>=20
> this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfsloc=
k01
> looks to be failing on NFS v3:
>=20
> "not unsharing /var makes AF_UNIX socket for host's rpcbind to become avail=
able
> inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd=
 for
> ltpns, and ports for that instance leak to host's rpcbind and overwrite por=
ts
> for lockd already active for root namespace. This breaks nfs3 file locking."

"not unsharing /var" ....  can this be fixed by simply unsharing /var?
Or is that not simple?

On could easily argue that RPCBIND_SOCK_PATHNAME in the kernel should be
changed to "/run/rpcbind.sock".  Does this test suite unshare /run ??

BTW, your email contains [1], [2], etc which suggests there are links
somewhere - but there aren't.

NeilBrown
