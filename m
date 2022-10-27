Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD9610666
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 01:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiJ0X3O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 19:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0X3N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 19:29:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D984E66
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 16:29:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 789101F461;
        Thu, 27 Oct 2022 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666913351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTTAZbHvhHhkABswGdCyVPAFcWeeW/2GRLauayyG2NY=;
        b=uoLWMY44LKx7+zPkesCWqbzcdDfSQ/5hD81JXyotmr+lSBkO75o/rq0/qQhQyMuD+cToB8
        6siwKoTXD7vTGwTl7Z/ZLYrIcAaJ3o1BST+QdKnpijcRc9qVLfYIOjoSinvvk9vTVK1KYy
        1E4wA/TZSi4RujX8AGpI+5QIsCHhMmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666913351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTTAZbHvhHhkABswGdCyVPAFcWeeW/2GRLauayyG2NY=;
        b=3PlVZ8b+GzLZ4WyFLSEV4JAhvaoD/8FxdGInWu+ZDBSA77mef6hm2bjwA457GOR/8j5viE
        GZNFpNF4ZbRmW2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 464AA13357;
        Thu, 27 Oct 2022 23:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AqYqO0UUW2OGEwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Oct 2022 23:29:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, jlayton@redhat.com
Subject: Re: [PATCH v6 00/14] Series short description
In-reply-to: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
References: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>
Date:   Fri, 28 Oct 2022 10:29:07 +1100
Message-id: <166691334702.13915.10147957275207365905@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022, Chuck Lever wrote:
> I'm proposing this series for v6.2 (for-next).
>=20
> For quite some time, we've been encouraged to disable filecache
> garbage collection for NFSv4 files, and I think I found a surgical
> way to do just that. That is presented in "NFSD: Add an NFSD_FILE_GC
> flag to enable nfsd_file garbage collection".
>=20
> The other major change in this set is reworking the file_hashtbl to
> resize itself dynamically. This reduces the average size of its
> bucket chains, greatly speeding up hash insertion, which holds the
> state_lock.
>=20
> This version seems to pass thread-intensive testing so far.
>=20
> Comments and opinions are welcome.

All looks good to me - with the understanding that refcount fixes will
follow.
I cannot comment on the tracepoint changes as I'm not particularly
familiar with that code, but for everything else
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>=20
> Changes since v5:
> - Wrap hash insertion with inode->i_lock
> - Replace hashfn and friends with in-built rhashtable functions
> - Add a tracepoint to report delegation return
>=20
> Changes since v4:
> - Addressed some comments in the GC patch; more to come
> - Split clean-ups out of the rhashtable patch, reordered the series
> - Removed state_lock from the rhashtable helpers
>=20
> Changes since v3:
> - the new filehandle alias check was still not right
>=20
> Changes since v2:
> - Converted nfs4_file_rhashtbl to nfs4_file_rhltable
> - Addressed most or all other review comments
>=20
> Changes since RFC:
> - checking nfs4_files for inode aliases is now done only on hash
>   insertion
> - the nfs4_file reference count is now bumped only while the RCU
>   read lock is held
> - comments and function names have been revised and clarified
>=20
> ---
>=20
> Chuck Lever (14):
>       NFSD: Pass the target nfsd_file to nfsd_commit()
>       NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediate=
ly"
>       NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
>       NFSD: Clean up nfs4_preprocess_stateid_op() call sites
>       NFSD: Trace stateids returned via DELEGRETURN
>       NFSD: Trace delegation revocations
>       NFSD: Use const pointers as parameters to fh_ helpers
>       NFSD: Update file_hashtbl() helpers
>       NFSD: Clean up nfsd4_init_file()
>       NFSD: Add a remove_nfs4_file() helper
>       NFSD: Clean up find_or_add_file()
>       NFSD: Refactor find_file()
>       NFSD: Allocate an rhashtable for nfs4_file objects
>       NFSD: Use rhashtable for managing nfs4_file objects
>=20
>=20
>  fs/nfsd/filecache.c |  81 +++++++++++++++-------
>  fs/nfsd/filecache.h |   4 +-
>  fs/nfsd/nfs3proc.c  |  10 ++-
>  fs/nfsd/nfs4proc.c  |  42 +++++------
>  fs/nfsd/nfs4state.c | 165 ++++++++++++++++++++++++--------------------
>  fs/nfsd/nfsfh.h     |  10 +--
>  fs/nfsd/state.h     |   5 +-
>  fs/nfsd/trace.h     |  59 +++++++++++++++-
>  fs/nfsd/vfs.c       |  19 ++---
>  fs/nfsd/vfs.h       |   3 +-
>  10 files changed, 249 insertions(+), 149 deletions(-)
>=20
> --
> Chuck Lever
>=20
>=20
