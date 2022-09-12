Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE55B5E15
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiILQWD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILQWC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 12:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B22A71C
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 09:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FED661234
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 16:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA2C433C1;
        Mon, 12 Sep 2022 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662999721;
        bh=lRNe4DU7UEiXjXaBqYuuE/QLKmwxXJkMPqw0/ffPJxE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=IzPIKk/2liwesZw2qlfRpkEzgyJl4WEfPsgcFilQiSVOwRIpUNKVyMZ9iTj7Ohbqr
         m+AWBp9+8mhsZxSsIIZL9ZVUy3j282F78GeYQofAttnd2VSgQbmROwfO8JNcu1SCbg
         sJmI9smScZjtRhEK60tdg0fLafXvDgLoBuz9VLcgYULAFhltBQvdQWz1ITpyMMPpU9
         v9MJWoko8x2rIzsxBjDzjO8e194T5KS9r3ViCWYYrxmCxLKphvEpAzZP+a1GqArHG4
         ULNWe9g0QfPZkSPk8mQjXzoZlrwq/DLfosQk20sbouTEqMPfarc86GsYQS0BiKFaxT
         85XKXzODIqqqw==
Message-ID: <5a1937b15ae11cba376ce3373ae468d05e65f17f.camel@kernel.org>
Subject: Re: [PATCH v4 0/8] Wait for DELEGRETURN before returning
 NFS4ERR_DELAY
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 12:21:59 -0400
In-Reply-To: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
References: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-09-08 at 18:13 -0400, Chuck Lever wrote:
> This patch series adds logic to the Linux NFS server to make it wait
> a few moments for clients to return a delegation before replying
> with NFS4ERR_DELAY. There are two main benefits:
>=20
> - It improves responsiveness when a delegated file is accessed from
>   another client, and
> - It removes an unnecessary latency if a client has neglected to
>   return a delegation before attempting a RENAME or SETATTR
>=20
> NFS4ERR_DELAY during NFSv4 OPEN is still not handled. However, I'm
> comfortable merging the infrastructure in this series and support
> for using it in SETATTR, RENAME, and REMOVE now, and then handling
> OPEN at a later time.
>=20
> This series applies against v6.0-rc4.
>=20
> Changes since v3:
> - Also handle JUKEBOX when an NFSv3 operation triggers a CB_RECALL
>=20
> Changes since v2:
> - Wake immediately after server receives DELEGRETURN
> - More tracepoint improvements
>=20
> Changes since RFC:
> - Eliminate spurious console messages on the server
> - Wait for DELEGRETURN for RENAME operations
> - Add CB done tracepoints
> - Rework the retry loop
>=20
> ---
>=20
> Chuck Lever (8):
>       NFSD: Replace dprintk() call site in fh_verify()
>       NFSD: Trace NFSv4 COMPOUND tags
>       NFSD: Add tracepoints to report NFSv4 callback completions
>       NFSD: Add a mechanism to wait for a DELEGRETURN
>       NFSD: Refactor nfsd_setattr()
>       NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
>       NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY
>       NFSD: Make nfsd4_remove() wait before returning NFS4ERR_DELAY
>=20
>=20
>  fs/nfsd/nfs4layouts.c |   2 +-
>  fs/nfsd/nfs4proc.c    |   6 +-
>  fs/nfsd/nfs4state.c   |  34 +++++++++++
>  fs/nfsd/nfsd.h        |   7 +++
>  fs/nfsd/nfsfh.c       |   8 +--
>  fs/nfsd/trace.h       | 131 ++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/vfs.c         | 100 ++++++++++++++++++++------------
>  7 files changed, 233 insertions(+), 55 deletions(-)
>=20
> --
> Chuck Lever
>=20

Nice work, Chuck. These all look reasonable to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
