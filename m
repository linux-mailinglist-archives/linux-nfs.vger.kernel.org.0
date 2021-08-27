Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D93FA1F6
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 01:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhH0Xz4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 19:55:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35586 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhH0Xz4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 19:55:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECF1F1FF4C;
        Fri, 27 Aug 2021 23:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630108505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lov8DgA95JksK5H0PIRfz8cZkSjxcH002shcBDMGsn0=;
        b=wwxrkyu+dTckmEurgJ4MgAeuqGE0nRdb6BDWsJs45BRVOQZCRFRxmE4bNlQ4gUx0XVJWpk
        jJj5hGVrdlhUgVikIv4In/EduMdoadL41bhak/HLg2puJZtQZee36yAHrZpoLT72jkm5bE
        7+gSfgH2Sk3F4810U/ccY8qf7OaBiHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630108505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lov8DgA95JksK5H0PIRfz8cZkSjxcH002shcBDMGsn0=;
        b=O3BKjC0yLg6iFazt6Pmc8EEbO7UwHvolxlh8eZyaZobwWc5DlQb45cjs4EBDYFE14tKHnF
        F+9NhcpYvc3U0JDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E5ED13480;
        Fri, 27 Aug 2021 23:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wj+PB1h7KWF1LgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 23:55:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Frank Filz" <ffilzlnx@mindspring.com>
Cc:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Chuck Lever'" <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, "'Josef Bacik'" <josef@toxicpanda.com>
Subject: RE: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <005801d79b9d$b8437b80$28ca7280$@mindspring.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <20210826201916.GB10730@fieldses.org>,
 <163001583884.7591.13328510041463261313@noble.neil.brown.name>,
 <002901d79b53$41ddba40$c5992ec0$@mindspring.com>,
 <163010502766.7591.10398654528737145909@noble.neil.brown.name>,
 <005801d79b9d$b8437b80$28ca7280$@mindspring.com>
Date:   Sat, 28 Aug 2021 09:55:01 +1000
Message-id: <163010850148.7591.14454473128413118273@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 28 Aug 2021, Frank Filz wrote:

> > On Sat, 28 Aug 2021, Frank Filz wrote:
> > >
> > > Changing the fsid for sub-volumes is Ganesha's solution (before adding
> > > that, we couldn't even export the sub-volumes at all).
> >=20
> > What does Ganesha use for the mounted-on-fileid? There doesn't seem to be=
 an
> > "obvious" answer so I wonder what was chosen.
>=20
> We only make mounted_on_fileid different from fileid on our export
> boundaries, and even then, it's not a terribly correct thing for
> FSAL_VFS (our module for interfacing with kernel filesystems) since
> user space to my knowledge has no way to get any information on an
> inode that serves as a mount point.

It is possible to see the mounted-on inode number by doing a readdir()
of the parent directory and looking at d_ino.  It is a bit round-about.

>=20
> What clients actually do anything with mounted_on_fileid, and what
> sorts of things do they do with it? I know the AIX client was
> interested in it (from having worked on security negotiation back in
> 2006), but I have never been able to test Ganesha with an AIX client.
> For normal Linux client operations, what Ganesha does seems to work
> OK.=20

On the Linux client, if you stat() a directory that is a mountpoint on
the server, you will see a directory with the inode number being the
mounted-on-fileid.  That directory is an automount-point, and when you
access anything in it, the 'real' directory gets mounted and the
mounted-on-fileid disappears.
So if you reported a mounted-on-fileid the same as the fileid, which
would be 256 on btrfs, du and find can get confused.  To be safe, the
mounted-of-fileid needs to be different to all ancestors.

NeilBrown
