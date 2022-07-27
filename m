Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328505829FA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiG0PuI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiG0PuI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 11:50:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D81B43
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 08:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2945B81F66
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 15:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1A9C433D7;
        Wed, 27 Jul 2022 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658937004;
        bh=JLjzYFIS1wdW3/AETbNAw9JKZ8k5KTBb/Om8Gt3blMk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aakLQlW+drHjThroEjq6fNft6TZQDs9o0QRv936VxN29Le28Lt2g6I04G2JregHeD
         WboYHXibt861SLIEMYq58VCS74HvPPKoZ4x7O1I1wepnU9whvjwTcmjpVJoKnCtbb6
         f52s448m0H438qHH3Ei1+d6MutupOAch8ItcPGtekHU7naOIfnLqpK4LRXLfkfWWU7
         CIa8ZmxkyX9bUmRffdJdWTJE3s5jXzJ4b5wAW2FE+h4+nCRKOQbASzxyqQwKAAbvEJ
         USRX1J9ZC8LQlrAwCg/OAtFesHCaJ/abW/4NLnZk+Qh+ZkmSsSyZIoqLIWhhKEhZ9V
         LDMSaC7DMz/wQ==
Message-ID: <9f3fa578841067378e7f5a1c26ecde90e66c90e9.camel@kernel.org>
Subject: Re: [PATCH 00/13] NFSD: clean up locking
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 27 Jul 2022 11:50:02 -0400
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-07-26 at 16:45 +1000, NeilBrown wrote:
> This is the latest version of my series to clean up locking -
> particularly of directories - in preparation for proposed patches which
> change how directory locking works across the VFS.
>=20
> I've included Jeff's patches to validate the dentry after getting a
> delegation.  The second patch has been changed quite a bit to use
> nfsd_lookup_dentry(). I've left Jeff's From: line in place - let me know
> if you'd rather I change it.
>=20

That's fine.

> Setting of ACLs and security labels has been moved from nfs4 code to
> nfsd_setattr() which allows quite a lot of code cleanup.
>=20
> I think I've addressed all the concerns that have been raised, though
> maybe not in the way that was suggested.
>=20
> I've tested this with cthon tests over v2, v3, v4.0, v4.1, and xfstests
> on v3 and v4.1, and pynfs 4.0, 4.1.  No problems appeared.
>=20
> Thanks,
> NeilBrown
>=20
>=20
> ---
>=20
> Jeff Layton (2):
>       NFSD: drop fh argument from alloc_init_deleg
>       NFSD: verify the opened dentry after setting a delegation
>=20
> NeilBrown (11):
>       NFSD: introduce struct nfsd_attrs
>       NFSD: set attributes when creating symlinks
>       NFSD: add security label to struct nfsd_attrs
>       NFSD: add posix ACLs to struct nfsd_attrs
>       NFSD: change nfsd_create()/nfsd_symlink() to unlock directory befor=
e returning.
>       NFSD: always drop directory lock in nfsd_unlink()
>       NFSD: only call fh_unlock() once in nfsd_link()
>       NFSD: reduce locking in nfsd_lookup()
>       NFSD: use explicit lock/unlock for directory ops
>       NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
>       NFSD: discard fh_locked flag and fh_lock/fh_unlock
>=20

It looks like the last 5 patches are missing from the posting
(everything after patch #8).

>=20
>  fs/nfsd/acl.h       |   6 +-
>  fs/nfsd/nfs2acl.c   |   6 +-
>  fs/nfsd/nfs3acl.c   |   4 +-
>  fs/nfsd/nfs3proc.c  |  25 ++---
>  fs/nfsd/nfs4acl.c   |  46 ++-------
>  fs/nfsd/nfs4proc.c  | 153 ++++++++++++-----------------
>  fs/nfsd/nfs4state.c |  71 +++++++++++---
>  fs/nfsd/nfsfh.c     |  22 ++++-
>  fs/nfsd/nfsfh.h     |  58 +----------
>  fs/nfsd/nfsproc.c   |  19 ++--
>  fs/nfsd/vfs.c       | 230 +++++++++++++++++++++-----------------------
>  fs/nfsd/vfs.h       |  31 ++++--
>  fs/nfsd/xdr4.h      |   1 +
>  13 files changed, 314 insertions(+), 358 deletions(-)
>=20
> --
> Signature
>=20

--=20
Jeff Layton <jlayton@kernel.org>
