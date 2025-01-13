Return-Path: <linux-nfs+bounces-9173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B40A0BE03
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19B7163ABF
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1A1C5D40;
	Mon, 13 Jan 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCncgapW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1F24023A
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787095; cv=none; b=mpo49lq1pwJK76qhfDyVYsaVO7sFPRcdpzxnoOGw/+KUr+1alat/B7SVCd0JASzhnOO4ve8PCbcnAnD5rMHgb2iPcHtik290LT/LKzVdk7P8gEcjWPIZGC71EwQ4YsAz8hnZR77Z3z2ycBvuJWtJXAuKQon4EaXjhFJBA5LAAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787095; c=relaxed/simple;
	bh=j0z1XQblxZS9lF8GGAMIkTCYty3pQO4Gif4suPCXPVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbCWXIPiWwGQKGLumDmirL//IGupgZ4d+Om49Wd71OV23J7BbbmUOMatLE/vjXNnFG/Egh5mrA8ATanWvr8wKElgKx0yVj4Cq4jucv5CoKiQ/muyoScxs7kmKE3D4BJbBVJ1I6E7mnJPaPIebvPjOLMxgFfVPiQvfCUR3E7t9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCncgapW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736787093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ffaISdzsEp2wiBUVsAms/VZBT7L/Zjl44dMDc9gvto=;
	b=DCncgapWh4I6D3nDWfGxlij8Ltj4zCUWhlpYWJTuT8KzawR9vvw579vsh7+JYLunBgD564
	HD92E8pPOxr0JcBfgaWOrT0yuD5K6bdvMY6R+AFl05R2jmf30pkKYMV4pEBSEl6JRQjFvr
	q9Bx8WmZlD2qIXe0qeQOQfavONhTFak=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-CD3-hyqYPTq7KNef04GB1Q-1; Mon,
 13 Jan 2025 11:51:29 -0500
X-MC-Unique: CD3-hyqYPTq7KNef04GB1Q-1
X-Mimecast-MFC-AGG-ID: CD3-hyqYPTq7KNef04GB1Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBC9619560A3;
	Mon, 13 Jan 2025 16:51:27 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.76.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3B0419560BC;
	Mon, 13 Jan 2025 16:51:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH v3 6/7] NFS: Use NFSv4.2's OFFLOAD_STATUS operation
Date: Mon, 13 Jan 2025 11:51:23 -0500
Message-ID: <9D804462-55EC-4D75-A5A8-28C43AA86AAB@redhat.com>
In-Reply-To: <20250113153235.48706-15-cel@kernel.org>
References: <20250113153235.48706-9-cel@kernel.org>
 <20250113153235.48706-15-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 13 Jan 2025, at 10:32, cel@kernel.org wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> We've found that there are cases where a transport disconnection
> results in the loss of callback RPCs. NFS servers typically do not
> retransmit callback operations after a disconnect.
>
> This can be a problem for the Linux NFS client's current
> implementation of asynchronous COPY, which waits indefinitely for a
> CB_OFFLOAD callback. If a transport disconnect occurs while an async
> COPY is running, there's a good chance the client will never get the
> completing CB_OFFLOAD.
>
> Fix this by implementing the OFFLOAD_STATUS operation so that the
> Linux NFS client can probe the NFS server if it doesn't see a
> CB_OFFLOAD in a reasonable amount of time.
>
> This patch implements a simplistic check. As future work, the client
> might also be able to detect whether there is no forward progress on
> the request asynchronous COPY operation, and CANCEL it.
>
> Suggested-by: Olga Kornievskaia <kolga@netapp.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218735
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs42proc.c | 70 ++++++++++++++++++++++++++++++++++++++--------=

>  1 file changed, 59 insertions(+), 11 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 23508669d051..4baa66cd966a 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -175,6 +175,20 @@ int nfs42_proc_deallocate(struct file *filep, loff=
_t offset, loff_t len)
>  	return err;
>  }
>
> +static void nfs4_copy_dequeue_callback(struct nfs_server *dst_server,
> +				       struct nfs_server *src_server,
> +				       struct nfs4_copy_state *copy)
> +{
> +	spin_lock(&dst_server->nfs_client->cl_lock);
> +	list_del_init(&copy->copies);
> +	spin_unlock(&dst_server->nfs_client->cl_lock);
> +	if (dst_server !=3D src_server) {
> +		spin_lock(&src_server->nfs_client->cl_lock);
> +		list_del_init(&copy->src_copies);
> +		spin_unlock(&src_server->nfs_client->cl_lock);
> +	}
> +}
> +
>  static int handle_async_copy(struct nfs42_copy_res *res,
>  			     struct nfs_server *dst_server,
>  			     struct nfs_server *src_server,
> @@ -184,9 +198,12 @@ static int handle_async_copy(struct nfs42_copy_res=
 *res,
>  			     bool *restart)
>  {
>  	struct nfs4_copy_state *copy, *tmp_copy =3D NULL, *iter;
> -	int status =3D NFS4_OK;
>  	struct nfs_open_context *dst_ctx =3D nfs_file_open_context(dst);
>  	struct nfs_open_context *src_ctx =3D nfs_file_open_context(src);
> +	struct nfs_client *clp =3D dst_server->nfs_client;
> +	unsigned long timeout =3D 3 * HZ;
> +	int status =3D NFS4_OK;
> +	u64 copied;
>
>  	copy =3D kzalloc(sizeof(struct nfs4_copy_state), GFP_KERNEL);
>  	if (!copy)
> @@ -224,15 +241,12 @@ static int handle_async_copy(struct nfs42_copy_re=
s *res,
>  		spin_unlock(&src_server->nfs_client->cl_lock);
>  	}
>
> -	status =3D wait_for_completion_interruptible(&copy->completion);
> -	spin_lock(&dst_server->nfs_client->cl_lock);
> -	list_del_init(&copy->copies);
> -	spin_unlock(&dst_server->nfs_client->cl_lock);
> -	if (dst_server !=3D src_server) {
> -		spin_lock(&src_server->nfs_client->cl_lock);
> -		list_del_init(&copy->src_copies);
> -		spin_unlock(&src_server->nfs_client->cl_lock);
> -	}
> +wait:
> +	status =3D wait_for_completion_interruptible_timeout(&copy->completio=
n,
> +							   timeout);
> +	if (!status)
> +		goto timeout;
> +	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
>  	if (status =3D=3D -ERESTARTSYS) {
>  		goto out_cancel;
>  	} else if (copy->flags || copy->error =3D=3D NFS4ERR_PARTNER_NO_AUTH)=
 {
> @@ -242,6 +256,7 @@ static int handle_async_copy(struct nfs42_copy_res =
*res,
>  	}
>  out:
>  	res->write_res.count =3D copy->count;
> +	/* Copy out the updated write verifier provided by CB_OFFLOAD. */
>  	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
>  	status =3D -copy->error;
>
> @@ -253,6 +268,39 @@ static int handle_async_copy(struct nfs42_copy_res=
 *res,
>  	if (!nfs42_files_from_same_server(src, dst))
>  		nfs42_do_offload_cancel_async(src, src_stateid);
>  	goto out_free;
> +timeout:
> +	timeout <<=3D 1;
> +	if (timeout > (clp->cl_lease_time >> 1))
> +		timeout =3D clp->cl_lease_time >> 1;
> +	status =3D nfs42_proc_offload_status(dst, &copy->stateid, &copied);
> +	if (status =3D=3D -EINPROGRESS)
> +		goto wait;
> +	nfs4_copy_dequeue_callback(dst_server, src_server, copy);
> +	switch (status) {
> +	case 0:
> +		/* The server recognized the copy stateid, so it hasn't
> +		 * rebooted. Don't overwrite the verifier returned in the
> +		 * COPY result. */
> +		res->write_res.count =3D copied;
> +		goto out_free;
> +	case -EREMOTEIO:
> +		/* COPY operation failed on the server. */
> +		status =3D -EOPNOTSUPP;
> +		res->write_res.count =3D copied;

I think "copied" can be the original uninitialized stack var in this path=
,
is that a problem?

Ben

> +		goto out_free;
> +	case -EBADF:
> +		/* Server did not recognize the copy stateid. It has
> +		 * probably restarted and lost the plot. */
> +		res->write_res.count =3D 0;
> +		status =3D -EOPNOTSUPP;
> +		break;
> +	case -EOPNOTSUPP:
> +		/* RFC 7862 REQUIREs server to support OFFLOAD_STATUS when
> +		 * it has signed up for an async COPY, so server is not
> +		 * spec-compliant. */
> +		res->write_res.count =3D 0;
> +	}
> +	goto out_free;
>  }
>
>  static int process_copy_commit(struct file *dst, loff_t pos_dst,
> @@ -643,7 +691,7 @@ _nfs42_proc_offload_status(struct nfs_server *serve=
r, struct file *file,
>   * Other negative errnos indicate the client could not complete the
>   * request.
>   */
> -static int __maybe_unused
> +static int
>  nfs42_proc_offload_status(struct file *dst, nfs4_stateid *stateid, u64=
 *copied)
>  {
>  	struct inode *inode =3D file_inode(dst);
> -- =

> 2.47.0


