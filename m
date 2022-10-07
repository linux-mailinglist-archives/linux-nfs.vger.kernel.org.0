Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88FA5F78C6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Oct 2022 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJGNT1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Oct 2022 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJGNTX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Oct 2022 09:19:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A1D01A6
        for <linux-nfs@vger.kernel.org>; Fri,  7 Oct 2022 06:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E166EB80C8D
        for <linux-nfs@vger.kernel.org>; Fri,  7 Oct 2022 13:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676D4C433D6;
        Fri,  7 Oct 2022 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148759;
        bh=HFyzY5egj8J/05b8eTIJfnyd4tuefR1oBrDEqqR9x+Y=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=UTJ7Yw56ySCH3xzj3I7dOVHYxF+5h/dEecrcWJ8q+N+q8d/LAVooH5eA2xZwQhC9B
         Z2IeM81JTQRhpkQjgwyg6f+hEygqJFj7LMAWMOjhilORZg4cDW5P/baNSfwIJx2yPV
         P/LaAf7w2fo0Ps8GOCPtD4QWidhH/3JJkLqLQ7PtpyvaUbTcGhOl1vL1TSNZKzWtP8
         ZQ7KzL0T5qok3dcgkApPycLVUuaM3EOAXro5mumCh7YJWYh7lMVpdMOach0FKJ4wZM
         NzrSwIQ8ikGEdm8ukEnxPXi5bPM0FmPDNLnsOlX7+syANy9LjMvDpMfOLjAGEzTe0q
         INo04mCIgQiZQ==
Message-ID: <3376ba7410b6211899c12872195a97219230823c.camel@kernel.org>
Subject: Re: [PATCH v2 0/9] A course adjustment, maybe...
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 07 Oct 2022 09:19:18 -0400
In-Reply-To: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-10-06 at 12:20 -0400, Chuck Lever wrote:
> I'm proposing this series as the first NFSD-related patchset to go
> into v6.2 (for-next), though I haven't opened that yet.
>=20
> For quite some time, we've been encouraged to disable filecache
> garbage collection for NFSv4 files, and I think I found a surgical
> way to do just that. That is presented in "NFSD: Add an NFSD_FILE_GC
> flag to enable nfsd_file garbage collection".
>=20
> Comments and opinions are welcome.
>=20
> Changes since RFC:
> - checking nfs4_files for inode aliases is now done only on hash
>   insertion
> - the nfs4_file reference count is now bumped only while the RCU
>   read lock is held
> - comments and function names have been revised and clarified
>=20
> I haven't updated the new @want_gc parameter... jury is still out.
>=20

It was just a nit I noticed since it looked like it was being used as a
bool. If you think it needs to be an int, then so be it.


> ---
>=20
> Chuck Lever (7):
>       NFSD: Pass the target nfsd_file to nfsd_commit()
>       NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immedia=
tely"
>       NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collecti=
on
>       NFSD: Use const pointers as parameters to fh_ helpers.
>       NFSD: Use rhashtable for managing nfs4_file objects
>       NFSD: Clean up nfs4_preprocess_stateid_op() call sites
>       NFSD: Trace delegation revocations
>=20
> Jeff Layton (2):
>       nfsd: fix nfsd_file_unhash_and_dispose
>       nfsd: rework hashtable handling in nfsd_do_file_acquire
>=20
>=20
>  fs/nfsd/filecache.c | 165 +++++++++++++++---------------
>  fs/nfsd/filecache.h |   4 +-
>  fs/nfsd/nfs3proc.c  |  10 +-
>  fs/nfsd/nfs4proc.c  |  42 ++++----
>  fs/nfsd/nfs4state.c | 241 ++++++++++++++++++++++++++++++--------------
>  fs/nfsd/nfsfh.h     |  10 +-
>  fs/nfsd/state.h     |   5 +-
>  fs/nfsd/trace.h     |  58 ++++++++++-
>  fs/nfsd/vfs.c       |  19 ++--
>  fs/nfsd/vfs.h       |   3 +-
>  10 files changed, 351 insertions(+), 206 deletions(-)


I been doing some testing with this and it seems to be working well. You
can add:

Tested-by: Jeff Layton <jlayton@kernel.org>
