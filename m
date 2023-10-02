Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFC7B5C11
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjJBU3w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjJBU3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 16:29:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C5D9
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 13:29:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932C1C433C7;
        Mon,  2 Oct 2023 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696278588;
        bh=naQ/y/qKI3wU5gJ4xQwYSxikkTJguhkfVKwnb7t4n8k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Nall0DUE+vd5bbSHWTyauQISJ+V13dLpliXI3ZOffJst3CNu2qiBhZP4bW01O6Ve+
         dUioItRWkv5qI7M8Z0n+2iqpkgmGMoLGRXCbpPd38oW+3m0yxubvSmM1vV7bZGR9Gf
         4K3YyNUSh/R+fkheRIDq9Dgptc/bkF2Y8w6wv13jddL0KM1c3anD0xTIIVfbe81q78
         3uprlU5CZ3AxGMEYqmyCq2g1o4q0KqLAbNDUqNS1ifUo50v1re/C1ssWdDvDVJC4Xb
         c4N2Z/oWH2sXKCYSSeEe2PBox0RJik9sC7uzr5tQ2/m80dmD8XF1PZctlxhRmE9Nsg
         dMHl9/JFiL7wA==
Message-ID: <d362e6fb08acc0ba0e90f01d58b995c364166371.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFS: Fix potential oops in
 nfs_inode_remove_request()
From:   Jeff Layton <jlayton@kernel.org>
To:     Scott Mayhew <smayhew@redhat.com>, trond.myklebust@hammerspace.com,
        anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Oct 2023 16:29:46 -0400
In-Reply-To: <20230725150807.8770-2-smayhew@redhat.com>
References: <20230725150807.8770-1-smayhew@redhat.com>
         <20230725150807.8770-2-smayhew@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-25 at 11:08 -0400, Scott Mayhew wrote:
> Once a folio's private data has been cleared, it's possible for another
> process to clear the folio->mapping (e.g. via invalidate_complete_folio2
> or evict_mapping_folio), so it wouldn't be safe to call
> nfs_page_to_inode() after that.
>=20
> Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfs/write.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index f4cca8f00c0c..489c3f9dae23 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -785,6 +785,8 @@ static void nfs_inode_add_request(struct nfs_page *re=
q)
>   */
>  static void nfs_inode_remove_request(struct nfs_page *req)
>  {
> +	struct nfs_inode *nfsi =3D NFS_I(nfs_page_to_inode(req));
> +
>  	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
>  		struct folio *folio =3D nfs_page_to_folio(req->wb_head);
>  		struct address_space *mapping =3D folio_file_mapping(folio);
> @@ -800,7 +802,7 @@ static void nfs_inode_remove_request(struct nfs_page =
*req)
> =20
>  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
>  		nfs_release_request(req);
> -		atomic_long_dec(&NFS_I(nfs_page_to_inode(req))->nrequests);
> +		atomic_long_dec(&nfsi->nrequests);
>  	}
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
