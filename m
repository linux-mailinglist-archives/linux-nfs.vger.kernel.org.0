Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA47CAEA2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjJPQLL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJPQLB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 12:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120721B2;
        Mon, 16 Oct 2023 09:10:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6700C433C9;
        Mon, 16 Oct 2023 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697472652;
        bh=gWHVm67UjtqFw6+7yv4rt62zVL2QbQsf6kz0OqfM+T4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oZSi9Cr46VJvDfJqXMvyt3WZMnh3kWQOGId5Ykf8NhRUkV1JLSq60ZEuW9aLkCetX
         sil+IjGAZbvHruvhuOiI8djrgL/SiaanaZOLMiaQa1tSFyoNb5Nlkh0TjdFGAJiay5
         SfJPKb8r8exJavmsBQGw4TiOA8LZFqvuinK7G3ADrnTpV7Idmg/KlDlaR5SYbA4LeI
         X6h60yT/c0b1f+iN5XqRzmx03D1z5a9WHAS97cpg8XRftJnID1Kr4zsHf46LaSw39s
         Sn6yblOrRc68OCh2l6paV3F2P/vXsQoBQ8A3E/1gLqYl8X+0LyMWIKHZUPKSFQWxv3
         idwbIz0NRNM+g==
Message-ID: <bb0b02b4241da7f486cde28bdc83bb9ce077ee0e.camel@kernel.org>
Subject: Re: [RFC PATCH 11/53] netfs: Add support for DIO buffering
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
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
Date:   Mon, 16 Oct 2023 12:10:49 -0400
In-Reply-To: <20231013160423.2218093-12-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
         <20231013160423.2218093-12-dhowells@redhat.com>
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

On Fri, 2023-10-13 at 17:03 +0100, David Howells wrote:
> Add a bvec array pointer and an iterator to netfs_io_request for either
> holding a copy of a DIO iterator or a list of all the bits of buffer
> pointed to by a DIO iterator.
>=20
> There are two problems:  Firstly, if an iovec-class iov_iter is passed to
> ->read_iter() or ->write_iter(), this cannot be passed directly to
> kernel_sendmsg() or kernel_recvmsg() as that may cause locking recursion =
if
> a fault is generated, so we need to keep track of the pages involved
> separately.
>=20
> Secondly, if the I/O is asynchronous, we must copy the iov_iter describin=
g
> the buffer before returning to the caller as it may be immediately
> deallocated.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/objects.c    | 10 ++++++++++
>  include/linux/netfs.h |  3 +++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 8e92b8401aaa..4396318081bf 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -78,6 +78,7 @@ static void netfs_free_request(struct work_struct *work=
)
>  {
>  	struct netfs_io_request *rreq =3D
>  		container_of(work, struct netfs_io_request, work);
> +	unsigned int i;
> =20
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
>  	netfs_proc_del_rreq(rreq);
> @@ -86,6 +87,15 @@ static void netfs_free_request(struct work_struct *wor=
k)
>  		rreq->netfs_ops->free_request(rreq);
>  	if (rreq->cache_resources.ops)
>  		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> +	if (rreq->direct_bv) {
> +		for (i =3D 0; i < rreq->direct_bv_count; i++) {
> +			if (rreq->direct_bv[i].bv_page) {
> +				if (rreq->direct_bv_unpin)
> +					unpin_user_page(rreq->direct_bv[i].bv_page);
> +			}
> +		}
> +		kvfree(rreq->direct_bv);
> +	}
>  	kfree_rcu(rreq, rcu);
>  	netfs_stat_d(&netfs_n_rh_rreq);
>  }
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index bd0437088f0e..66479a61ad00 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -191,7 +191,9 @@ struct netfs_io_request {
>  	struct list_head	subrequests;	/* Contributory I/O operations */
>  	struct iov_iter		iter;		/* Unencrypted-side iterator */
>  	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
> +	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-ite=
r) */
>  	void			*netfs_priv;	/* Private data for the netfs */
> +	unsigned int		direct_bv_count; /* Number of elements in bv[] */

nit: "number of elements in direct_bv[]"

Also, just for better readability, can you swap direct_bv and
netfs_priv? Then at least the array and count are together.

>  	unsigned int		debug_id;
>  	unsigned int		rsize;		/* Maximum read size (0 for none) */
>  	atomic_t		nr_outstanding;	/* Number of ops in progress */
> @@ -200,6 +202,7 @@ struct netfs_io_request {
>  	size_t			len;		/* Length of the request */
>  	short			error;		/* 0 or error that occurred */
>  	enum netfs_io_origin	origin;		/* Origin of the request */
> +	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
>  	loff_t			i_size;		/* Size of the file */
>  	loff_t			start;		/* Start position */
>  	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
>=20

--=20
Jeff Layton <jlayton@kernel.org>
