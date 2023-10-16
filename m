Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1137CADF8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjJPPpE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 11:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjJPPo7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 11:44:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3428EE;
        Mon, 16 Oct 2023 08:44:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D9AC433C9;
        Mon, 16 Oct 2023 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697471097;
        bh=9uoP06owwVRPrncswrsWLKQbhdyottu9QKK6JcK20LE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=guJwgvZhq0+Zrw5QhtmZPfW4yFn8mNZ3GKIUOfnH3zVXd6BdPrVmytwdm6n34W6H+
         uih7zQPbYtKSkKjvX12X1J6ek6B8zzyXJmn5eqCg4IwuAOyGQx0jYQm2qMdPvM8/h/
         okldncECKsUqeuslP3yRlKRpYtmuaVcKD5u1KKqN2qwhjDfbBPvqTsK/ImpYNzfBlg
         PwVq3fw8lT9Q+P+Xe/3V3jnUzY1Z8OYfP7nIEisoCu/s7myl43v1Xj0uocnCQRhAOa
         YW7F5nUwox2yNFVjc7qjLqmSSl+50CYdhXz3UikmW97Uk9eWg86Lnbks1taiDu1Lou
         AzOuWKDg8Q4fA==
Message-ID: <a07c64e179e30c0962094eea5d1282977c4a4d90.camel@kernel.org>
Subject: Re: [RFC PATCH 03/53] netfs: Note nonblockingness in the
 netfs_io_request struct
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Date:   Mon, 16 Oct 2023 11:44:54 -0400
In-Reply-To: <20231013155727.2217781-4-dhowells@redhat.com>
References: <20231013155727.2217781-1-dhowells@redhat.com>
         <20231013155727.2217781-4-dhowells@redhat.com>
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

On Fri, 2023-10-13 at 16:56 +0100, David Howells wrote:
> Allow O_NONBLOCK to be noted in the netfs_io_request struct.  Also add a
> flag, NETFS_RREQ_BLOCKED to record if we did block.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/objects.c    | 2 ++
>  include/linux/netfs.h | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 85f428fc52e6..e41f9fc9bdd2 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -37,6 +37,8 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>  	INIT_LIST_HEAD(&rreq->subrequests);
>  	refcount_set(&rreq->ref, 1);
>  	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> +	if (file && file->f_flags & O_NONBLOCK)
> +		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
>  	if (rreq->netfs_ops->init_request) {
>  		ret =3D rreq->netfs_ops->init_request(rreq, file);
>  		if (ret < 0) {
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 282511090ead..b92e982ac4a0 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -205,6 +205,8 @@ struct netfs_io_request {
>  #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on co=
mpletion */
>  #define NETFS_RREQ_FAILED		4	/* The request failed */
>  #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes=
 */
> +#define NETFS_RREQ_NONBLOCK		6	/* Don't block if possible (O_NONBLOCK) *=
/
> +#define NETFS_RREQ_BLOCKED		7	/* We blocked */
>  	const struct netfs_request_ops *netfs_ops;
>  };
> =20
>=20

I'd prefer to see this patch squashed in with the first patches that
actually check for these flags. I can't look at this patch alone and
tell how it'll be used.

--=20
Jeff Layton <jlayton@kernel.org>
