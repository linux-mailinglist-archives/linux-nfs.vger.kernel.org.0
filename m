Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB37CAE47
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJPPyt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjJPPyt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 11:54:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C63D9;
        Mon, 16 Oct 2023 08:54:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031F5C433C9;
        Mon, 16 Oct 2023 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697471687;
        bh=XF2Ub1+HsWjMHCZvPLicE8SrXCYQkNv2/+mVm86z2a4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o77yGTKEHFiOMbIKRpvPlQ2bZkbCx09x3z8mNkKZh1NsS3xrrdOLFFR2o7jfizo70
         freHLcVbHxI57o4kN/a2L81UqoIFV0fMa9rbljNXC12+F4jOrFfwCA/0EMeVqPkzA0
         E/KVuHc0ZuW/ySQ+93u31MlUeeldUYbIGOAwHf5+2ZraDUkmxXa/6JbBJgzkF+KHkV
         lDGLHROOwMBeB85NoOmXpFEbSMnqwvOxXfsQUFiXwWwfNTrmpo982jeSl/Twi9wO8G
         zEvV9KZ/l0e0LKmR7egS0uLwwoU91gvu6k+zTMJmpt4DWa7tPrONXdQLx/GPOsQk8q
         d0jO2lIzcVirg==
Message-ID: <be2434a2d51900b9e51d8bf0fe5a8b82e3f1a879.camel@kernel.org>
Subject: Re: [RFC PATCH 08/53] netfs: Add rsize to netfs_io_request
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
Date:   Mon, 16 Oct 2023 11:54:44 -0400
In-Reply-To: <20231013160423.2218093-9-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
         <20231013160423.2218093-9-dhowells@redhat.com>
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
> Add an rsize parameter to netfs_io_request to be filled in by the network
> filesystem when the request is initialised.  This indicates the maximum
> size of a read request that the netfs will honour in that region.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/afs/file.c         | 1 +
>  fs/ceph/addr.c        | 2 ++
>  include/linux/netfs.h | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 3fea5cd8ef13..3d2e1913ea27 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -360,6 +360,7 @@ static int afs_symlink_read_folio(struct file *file, =
struct folio *folio)
>  static int afs_init_request(struct netfs_io_request *rreq, struct file *=
file)
>  {
>  	rreq->netfs_priv =3D key_get(afs_file_key(file));
> +	rreq->rsize =3D 4 * 1024 * 1024;
>  	return 0;
>  }
> =20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index ced19ff08988..92a5ddcd9a76 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -419,6 +419,8 @@ static int ceph_init_request(struct netfs_io_request =
*rreq, struct file *file)
>  	struct ceph_netfs_request_data *priv;
>  	int ret =3D 0;
> =20
> +	rreq->rsize =3D 1024 * 1024;
> +

Holy magic numbers, batman! I think this deserves a comment that
explains how you came up with these values.

Also, do 9p and cifs not need this for some reason?

>  	if (rreq->origin !=3D NETFS_READAHEAD)
>  		return 0;
> =20
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index daa431c4148d..02e888c170da 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -188,6 +188,7 @@ struct netfs_io_request {
>  	struct list_head	subrequests;	/* Contributory I/O operations */
>  	void			*netfs_priv;	/* Private data for the netfs */
>  	unsigned int		debug_id;
> +	unsigned int		rsize;		/* Maximum read size (0 for none) */
>  	atomic_t		nr_outstanding;	/* Number of ops in progress */
>  	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
>  	size_t			submitted;	/* Amount submitted for I/O so far */
>=20

--=20
Jeff Layton <jlayton@kernel.org>
