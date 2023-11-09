Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A737E6CDD
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Nov 2023 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjKIPG3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 10:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjKIPG2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 10:06:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452C35A5
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699542337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMa3MbeipIKhITL0hzKNwXKEpP47LKZ/rjqq/CNb4e8=;
        b=MEarn/Neomx8r9YRxzCc+68+zUvtJ/rRoLDs0v9uP2qnTZrXHJISARC9a77fwRqOVIdM6e
        aqxNvtReuRg+/4RORcbS78K754CF9La6Bc5OAz0LMhN5TdNzUohtt3Mr8RZ70QVEWKxtpO
        Z2szp+gmek3egRInTBfzyW15Q7JOSGg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-SMph6Wv-Pb-pJNbZXrjaOg-1; Thu,
 09 Nov 2023 10:05:33 -0500
X-MC-Unique: SMph6Wv-Pb-pJNbZXrjaOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6237C3C025D9;
        Thu,  9 Nov 2023 15:05:33 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B01381121306;
        Thu,  9 Nov 2023 15:05:32 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] NFS: Fix error handling for O_DIRECT write
 scheduling
Date:   Thu, 09 Nov 2023 10:05:31 -0500
Message-ID: <02FDFFF6-8512-4BBA-845D-72C21864E621@redhat.com>
In-Reply-To: <20230904163441.11950-2-trondmy@kernel.org>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On 4 Sep 2023, at 12:34, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If we fail to schedule a request for transmission, there are 2
> possibilities:
> 1) Either we hit a fatal error, and we just want to drop the remaining
>    requests on the floor.
> 2) We were asked to try again, in which case we should allow the
>    outstanding RPC calls to complete, so that we can recoalesce request=
s
>    and try again.
>
> Fixes: d600ad1f2bdb ("NFS41: pop some layoutget errors to application")=

> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/direct.c | 62 ++++++++++++++++++++++++++++++++++++-------------=

>  1 file changed, 46 insertions(+), 16 deletions(-)
>
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 47d892a1d363..ee88f0a6e7b8 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -528,10 +528,9 @@ nfs_direct_write_scan_commit_list(struct inode *in=
ode,
>  static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
>  {
>  	struct nfs_pageio_descriptor desc;
> -	struct nfs_page *req, *tmp;
> +	struct nfs_page *req;
>  	LIST_HEAD(reqs);
>  	struct nfs_commit_info cinfo;
> -	LIST_HEAD(failed);
>
>  	nfs_init_cinfo_from_dreq(&cinfo, dreq);
>  	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
> @@ -549,27 +548,36 @@ static void nfs_direct_write_reschedule(struct nf=
s_direct_req *dreq)
>  			      &nfs_direct_write_completion_ops);
>  	desc.pg_dreq =3D dreq;
>
> -	list_for_each_entry_safe(req, tmp, &reqs, wb_list) {
> +	while (!list_empty(&reqs)) {
> +		req =3D nfs_list_entry(reqs.next);
>  		/* Bump the transmission count */
>  		req->wb_nio++;
>  		if (!nfs_pageio_add_request(&desc, req)) {
> -			nfs_list_move_request(req, &failed);
>  			spin_lock(&cinfo.inode->i_lock);
> -			dreq->flags =3D 0;
> -			if (desc.pg_error < 0)
> +			if (dreq->error < 0) {
> +				desc.pg_error =3D dreq->error;
> +			} else if (desc.pg_error !=3D -EAGAIN) {
> +				dreq->flags =3D 0;
> +				if (!desc.pg_error)
> +					desc.pg_error =3D -EIO;
>  				dreq->error =3D desc.pg_error;
> -			else
> -				dreq->error =3D -EIO;
> +			} else
> +				dreq->flags =3D NFS_ODIRECT_RESCHED_WRITES;
>  			spin_unlock(&cinfo.inode->i_lock);
> +			break;
>  		}
>  		nfs_release_request(req);
>  	}
>  	nfs_pageio_complete(&desc);
>
> -	while (!list_empty(&failed)) {
> -		req =3D nfs_list_entry(failed.next);
> +	while (!list_empty(&reqs)) {
> +		req =3D nfs_list_entry(reqs.next);
>  		nfs_list_remove_request(req);
>  		nfs_unlock_and_release_request(req);
> +		if (desc.pg_error =3D=3D -EAGAIN)
> +			nfs_mark_request_commit(req, NULL, &cinfo, 0);
> +		else
> +			nfs_release_request(req);
>  	}
>
>  	if (put_dreq(dreq))
> @@ -794,9 +802,11 @@ static ssize_t nfs_direct_write_schedule_iovec(str=
uct nfs_direct_req *dreq,
>  {
>  	struct nfs_pageio_descriptor desc;
>  	struct inode *inode =3D dreq->inode;
> +	struct nfs_commit_info cinfo;
>  	ssize_t result =3D 0;
>  	size_t requested_bytes =3D 0;
>  	size_t wsize =3D max_t(size_t, NFS_SERVER(inode)->wsize, PAGE_SIZE);
> +	bool defer =3D false;
>
>  	trace_nfs_direct_write_schedule_iovec(dreq);
>
> @@ -837,17 +847,37 @@ static ssize_t nfs_direct_write_schedule_iovec(st=
ruct nfs_direct_req *dreq,
>  				break;
>  			}
>
> -			nfs_lock_request(req);
> -			if (!nfs_pageio_add_request(&desc, req)) {
> -				result =3D desc.pg_error;
> -				nfs_unlock_and_release_request(req);
> -				break;
> -			}
>  			pgbase =3D 0;
>  			bytes -=3D req_len;
>  			requested_bytes +=3D req_len;
>  			pos +=3D req_len;
>  			dreq->bytes_left -=3D req_len;
> +
> +			if (defer) {
> +				nfs_mark_request_commit(req, NULL, &cinfo, 0);
> +				continue;
> +			}
> +
> +			nfs_lock_request(req);
> +			if (nfs_pageio_add_request(&desc, req))
> +				continue;

Just a note, we've hit some trouble with this one on pNFS SCSI.

When we re-order the update of dreq->bytes_left and
nfs_pageio_add_request(), the blocklayout driver machinery ends up with b=
ad
calculations for LAYOUTGET on the first req.   What I see is a short
LAYOUTGET, and then a 2nd LAYOUGET for the last req with loga_length 0,
causing some havoc.

Eventually, there's a corruption somewhere - I think because
nfs_pageio_add_request() ends up doing nfs_pageio_do() in the middle of t=
his
thing and then we race to something in completion - I haven't quite been
able to figure that part out yet.

Ben

