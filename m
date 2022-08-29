Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79F5A4E69
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH2NoG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiH2NoE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 09:44:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765A94EFF
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 06:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4D32B8107A
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 13:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCBC433B5;
        Mon, 29 Aug 2022 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661780638;
        bh=agLg+fFFSOp+qxWSgmwTQVeeQ5LWY77SDZCyJ7DaFPY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Fv5NfVKf1Qnk2n1bU1tsD1HbRU/UKqSfqjazSdEBJCysYbs/QyttogERaNyHCOqkr
         gVxdwL/IKNshPPi4i6PAoErlpItbk6YgaMBbQ7tCF+NNcueF0Qp1HTtWyzhq+fVuLF
         gfSFj5wulLUodncw4qoCdnwtFUBfen7VpQqZZj6NrPLSwNNfoi+9gyI4KlNynh3DJg
         Rhh8TE2CJ7/VXIWoJ9mzrhMZaMqXcmOxn8YQf/Xmka1Rl1A2X6uDumujYVZgqxwTKi
         OVFwzkiiivODR+IQ8i/Kco2MGBmQPD0jL6A8zS5axjGyeXTgIx/2xZMmWiSUOSOZ3b
         DcK4OJqTt+tpA==
Message-ID: <52a93203dbd9daa02814cc920a61066d6df2749e.camel@kernel.org>
Subject: Re: [PATCH v2 3/7] NFSD: Protect against READDIR send buffer
 overflow
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 09:43:56 -0400
In-Reply-To: <166171263459.21449.18044553311121354704.stgit@manet.1015granger.net>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
         <166171263459.21449.18044553311121354704.stgit@manet.1015granger.net>
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

On Sun, 2022-08-28 at 14:50 -0400, Chuck Lever wrote:
> For many years, NFSD has conserved the number of pages held by
> each nfsd thread by combining the RPC receive and send buffers
> into a single array of pages. The dividing line between the
> receive and send buffer is pointed to by svc_rqst::rq_respages.
>=20

nit: Given that you don't look at rq_respages in the patch below, the
previous sentence is not particularly relevant. It might be better to
just explain that rq_res describes the part of the array that is the
response buffer, so we want to consult it for the max length.

> Thus the send buffer shrinks when the received RPC record
> containing the RPC Call is large.
>=20
> nfsd3_init_dirlist_pages() needs to account for the space in the
> svc_rqst::rq_pages array already consumed by the RPC receive buffer.
> Otherwise READDIR reply encoding can wander off the end of the page
> array.
>=20
> Thanks to Aleksi Illikainen and Kari Hulkko for discovering this
> issue.
>=20
> Reported-by: Ben Ronallo <Benjamin.Ronallo@synopsys.com>
> Fixes: f5dcccd647da ("NFSD: Update the NFSv2 READDIR entry encoder to use=
 struct xdr_stream")
> Fixes: 7f87fc2d34d4 ("NFSD: Update NFSv3 READDIR entry encoders to use st=
ruct xdr_stream")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |    5 ++---
>  fs/nfsd/nfsproc.c  |    5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index a41cca619338..fab87e9e0b20 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -564,12 +564,11 @@ static void nfsd3_init_dirlist_pages(struct svc_rqs=
t *rqstp,
>  	struct xdr_buf *buf =3D &resp->dirlist;
>  	struct xdr_stream *xdr =3D &resp->xdr;
> =20
> -	count =3D clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
> -
>  	memset(buf, 0, sizeof(*buf));
> =20
>  	/* Reserve room for the NULL ptr & eof flag (-2 words) */
> -	buf->buflen =3D count - XDR_UNIT * 2;
> +	buf->buflen =3D clamp(count, (u32)(XDR_UNIT * 2), rqstp->rq_res.buflen)=
;
> +	buf->buflen -=3D XDR_UNIT * 2;
>  	buf->pages =3D rqstp->rq_next_page;
>  	rqstp->rq_next_page +=3D (buf->buflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
> =20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 7381972f1677..23c273cb68a9 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -567,12 +567,11 @@ static void nfsd_init_dirlist_pages(struct svc_rqst=
 *rqstp,
>  	struct xdr_buf *buf =3D &resp->dirlist;
>  	struct xdr_stream *xdr =3D &resp->xdr;
> =20
> -	count =3D clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
> -
>  	memset(buf, 0, sizeof(*buf));
> =20
>  	/* Reserve room for the NULL ptr & eof flag (-2 words) */
> -	buf->buflen =3D count - XDR_UNIT * 2;
> +	buf->buflen =3D clamp(count, (u32)(XDR_UNIT * 2), rqstp->rq_res.buflen)=
;
> +	buf->buflen -=3D XDR_UNIT * 2;
>  	buf->pages =3D rqstp->rq_next_page;
>  	rqstp->rq_next_page++;
> =20
>=20
>=20

I wonder if a better fix would be to make svc_max_payload take the
already-consumed arg space into account? We'd need to fix up the other
callers of course.

In any case, the patch itself looks fine:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
