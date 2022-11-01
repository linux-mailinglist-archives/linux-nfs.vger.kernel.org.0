Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649A661516F
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 19:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKASWB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKASV7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 14:21:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34972192BF
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 11:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1751B81ED0
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 18:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B090C433C1;
        Tue,  1 Nov 2022 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667326914;
        bh=0YmGguD43vs2ORb9whQkXnzSwacr0y86ziUbpx45s7o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=sc0oMl/LrpK2bE8unPn0+PLOz7ANauWOezBhvf9iPYsK+YwQ03i4GoRvZl6cT6F8M
         Xzzi0Fg64v6k4oPGPXl0kOhr0w8FLADvTM0V8HO0SbNvy2x2Wlb1N94q1f+JrENbdu
         s52E9FoVTRrSNp8sPjT5bPng7Cck1xuRvA2EVrQc4vHQCpgPu6frM/mHFf5cCAHhyT
         VptHzMsjpevFEi4areUMXg9dlrNjVo4xAsLklmS+4QqZpFUezo7JvrdhcZC1GwtanM
         Bn1e+ViJkI4dpLJ6bHLBUCSBLVr+LmklQnRI2hq+GsAK57Zfzi6OWnXZdrpZ54PTvH
         cqiEl7girROcQ==
Message-ID: <3d3925de588eae4da34e53f7cd6648258801d692.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Flesh out a documenting comment for filecache.c
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Tue, 01 Nov 2022 14:21:53 -0400
In-Reply-To: <166732362009.147807.16481897041798638515.stgit@klimt.1015granger.net>
References: <166732362009.147807.16481897041798638515.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-11-01 at 13:30 -0400, Chuck Lever wrote:
> Record what we've learned recently about the NFSD filecache in a
> documenting comment so our future selves don't forget what all this
> is for.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> Here's what I had in mind for the top-of-file comment.
>=20
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 28f91c97e045..02b4871b9ffc 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -2,6 +2,30 @@
>   * Open file cache.
>   *
>   * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
> + *
> + * An nfsd_file object is a per-file collection of open state that binds
> + * together:
> + *   - a struct file *
> + *   - a user credential
> + *   - a network namespace
> + *   - a read-ahead context
> + *   - monitoring for writeback errors
> + *
> + * nfsd_file objects are reference-counted. Consumers acquire a new
> + * object via the nfsd_file_acquire API. They manage their interest in
> + * the acquired object, and hence the object's reference count, via
> + * nfsd_file_get and nfsd_file_put. There are two varieties of nfsd_file
> + * object:
> + *
> + *  * non-garbage-collected: When a consumer wants to precisely control
> + *    the lifetime of a file's open state, it acquires a non-garbage-
> + *    collected nfsd_file. The final nfsd_file_put releases the open
> + *    state immediately.
> + *
> + *  * garbage-collected: When a consumer does not control the lifetime
> + *    of open state, it acquires a garbage-collected nfsd_file. The
> + *    final nfsd_file_put allows the open state to linger for a period
> + *    during which it may be re-used.
>   */
> =20
>  #include <linux/hash.h>
>=20
>=20

Seems reasonable.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
