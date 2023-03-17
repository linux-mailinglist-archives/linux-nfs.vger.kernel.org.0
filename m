Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD0C6BE9D3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCQNG2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 09:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQNG1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 09:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC298E20C7
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 06:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CC20622A8
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 13:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F681C433EF;
        Fri, 17 Mar 2023 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679058385;
        bh=2NhrvGoNWJ/ADAH7N47NMv95p5ATV6Qx6LQ/dmllofw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q5eiqFM+FISX97jSAi1tLgg9pxUUE+SYv0E1g/mvVEm7AUXdrhB1OewKR88Z6zmnn
         WOdGggEQ8R0QaEKCiqakpMGc1G7TdjNLJnuJ0FLUH2exPlHgc7eOu1XSeV8UckecAm
         blTR6QUyL5QOfbdMkWCwxNnEiYHHX9cVWrbI20K6lvgIEGtCJuTOiq8lvgMki5uTU4
         zt5Bqk3WIs75kJnomRqE4KEHzNucW9/ffyQzW1xi9S5v3qe+le7UaDk8DEfS1sBwu3
         qtWVDAUyj/ooqDp6BoSlM0gco6sNN/Qq3KW4yEtsuXbq3xDd6xpI9Vw0aoZPbbQfhf
         oIvvYzcOnjnwA==
Message-ID: <c57b48f500b859a3daf6f95ccefdfbec72e1c9de.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dcritch@redhat.com, d.lesca@solinos.it
Date:   Fri, 17 Mar 2023 09:06:23 -0400
In-Reply-To: <20230317105608.19393-1-jlayton@kernel.org>
References: <20230317105608.19393-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-03-17 at 06:56 -0400, Jeff Layton wrote:
> The splice read calls nfsd_splice_actor to put the pages containing file
> data into the svc_rqst->rq_pages array. It's possible however to get a
> splice result that only has a partial page at the end, if (e.g.) the
> filesystem hands back a short read that doesn't cover the whole page.
>=20
> nfsd_splice_actor will plop the partial page into its rq_pages array and
> return. Then later, when nfsd_splice_actor is called again, the
> remainder of the page may end up being filled out. At this point,
> nfsd_splice_actor will put the page into the array _again_ corrupting
> the reply. If this is done enough times, rq_next_page will overrun the
> array and corrupt the trailing fields -- the rq_respages and
> rq_next_page pointers themselves.
>=20
> If we've already added the page to the array in the last pass, don't add
> it to the array a second time when dealing with a splice continuation.
> This was originally handled properly in nfsd_splice_actor, but commit
> 91e23b1c3982 removed the check for it, and started universally replacing
> pages.
>=20
> Fixes: 91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()")
> Reported-by: Dario Lesca <d.lesca@solinos.it>
> Tested-by: David Critch <dcritch@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2150630
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 502e1b7742db..3709ef57d96e 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -941,8 +941,11 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, stru=
ct pipe_buffer *buf,
>  	struct page *last_page;
> =20
>  	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
> -	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++)
> -		svc_rqst_replace_page(rqstp, page);
> +	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
> +		/* Only replace page if we haven't already done so */

Note that I think that this was probably the real rationale for the pp[-
1] check that 91e23b1c3982 removed. Given that, maybe we should flesh
this comment out a bit more for posterity?

		/*
		 * When we're splicing from a pipe, it's possible that
		 * we'll get an incomplete page that may be updated on
		 * a later call. Only splice it into rq_pages once.
		 */

> +		if (page !=3D *(rqstp->rq_next_page - 1))
> +			svc_rqst_replace_page(rqstp, page);
> +	}
>  	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
>  		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
>  	rqstp->rq_res.page_len +=3D sd->len;

--=20
Jeff Layton <jlayton@kernel.org>
