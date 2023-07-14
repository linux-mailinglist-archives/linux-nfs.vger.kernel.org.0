Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF16753B90
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 15:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjGNNMp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 09:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNNMo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 09:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D11F134
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 06:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E8C61D0C
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 13:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC71C433C8;
        Fri, 14 Jul 2023 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689340362;
        bh=OBNu5KAkUJ2iSijJBGpHkWkHOROb6TeR6FSUMc2cXWo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cS0FXElfkfn1peD3cqV3lTmjLxPiix++0TBshcVgA+lJv0XMXG4DYofcV48P/oesq
         1y31PbtiwVi/vXDNT0IlVKR1c7IfK9u7XSRvIVuEZomRJYQ0Cfisgou8weHSJCia+Z
         QopD6RthsHYGYLjTjMl+N7rFf8J8BFK1/3KeavjlxH+ST3XIyS6OLknbYkj/CJxJ7V
         6atOswKybLQi5nQ9/RRL2I9VNqKRJ+CPxdg4p0vplLxvD/YN31VP6s6tDlbnx2TPJn
         Tm/+5pHJlTcZU6Rtt4PMBzC5rq6xLhB+dqjSO1278Yf5defISPHEt9cBmQaNuSusD2
         e/FSKOc+YXSZQ==
Message-ID: <8f0d34d7c730c24302630517faf96542c43cf0fc.camel@kernel.org>
Subject: Re: [PATCH RFC 1/4] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs
 directly
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Fri, 14 Jul 2023 09:12:40 -0400
In-Reply-To: <168893309913.1949.840437707678733371.stgit@manet.1015granger.net>
References: <168893265677.1949.1632048925203798962.stgit@manet.1015granger.net>
         <168893309913.1949.840437707678733371.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-07-09 at 16:04 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Add a helper to convert a whole xdr_buf directly into an array of
> bio_vecs, then send this array instead of iterating piecemeal over
> the xdr_buf containing the outbound RPC message.
>=20
> Note that the rules of the RPC protocol mean there can be only one
> outstanding send at a time on a transport socket. The kernel's
> SunRPC server enforces this via the transport's xpt_mutex. Thus we
> can use a per-transport shared array for the xdr_buf conversion
> rather than allocate one every time or use one that is part of
> struct svc_rqst.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svcsock.h |    3 +
>  net/sunrpc/svcsock.c           |   93 +++++++++++++++++++++++-----------=
------
>  2 files changed, 56 insertions(+), 40 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsoc=
k.h
> index a7116048a4d4..a9bfeadf4cbe 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -40,6 +40,9 @@ struct svc_sock {
> =20
>  	struct completion	sk_handshake_done;
> =20
> +	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
> +						____cacheline_aligned;
> +
>  	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
>  };
> =20

Hmm ok, so this adds ~4k per socket, but we get rid of allocation in the
send path. I like it!

> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e43f26382411..d3c5f1a07979 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -188,6 +188,42 @@ static int svc_sock_result_payload(struct svc_rqst *=
rqstp, unsigned int offset,
>  	return 0;
>  }
> =20
> +static unsigned int svc_sock_xdr_to_bvecs(struct bio_vec *bvec,
> +					  struct xdr_buf *xdr)
> +{
> +	const struct kvec *head =3D xdr->head;
> +	const struct kvec *tail =3D xdr->tail;
> +	unsigned int count =3D 0;
> +
> +	if (head->iov_len) {
> +		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
> +		count++;
> +	}
> +
> +	if (xdr->page_len) {
> +		unsigned int offset, len, remaining;
> +		struct page **pages =3D xdr->pages;
> +
> +		offset =3D offset_in_page(xdr->page_base);
> +		remaining =3D xdr->page_len;
> +		while (remaining > 0) {
> +			len =3D min_t(unsigned int, remaining,
> +				    PAGE_SIZE - offset);
> +			bvec_set_page(bvec++, *pages++, len, offset);
> +			remaining -=3D len;
> +			offset =3D 0;
> +			count++;
> +		}
> +	}
> +
> +	if (tail->iov_len) {
> +		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
> +		count++;
> +	}
> +
> +	return count;
> +}
> +

The lack of bounds checking in the above function bothers me a bit. I
think we need to ensure that "bvec" doesn't walk off the end of the
array.

>  /*
>   * Report socket names for nfsdfs
>   */
> @@ -1194,72 +1230,50 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqst=
p)
>  	return 0;	/* record not complete */
>  }
> =20
> -static int svc_tcp_send_kvec(struct socket *sock, const struct kvec *vec=
,
> -			      int flags)
> -{
> -	struct msghdr msg =3D { .msg_flags =3D MSG_SPLICE_PAGES | flags, };
> -
> -	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
> -	return sock_sendmsg(sock, &msg);
> -}
> -
>  /*
>   * MSG_SPLICE_PAGES is used exclusively to reduce the number of
>   * copy operations in this path. Therefore the caller must ensure
>   * that the pages backing @xdr are unchanging.
>   *
> - * In addition, the logic assumes that * .bv_len is never larger
> - * than PAGE_SIZE.
> + * Note that the send is non-blocking. The caller has incremented
> + * the reference count on each page backing the RPC message, and
> + * the network layer will "put" these pages when transmission is
> + * complete.
> + *
> + * This is safe for our RPC services because the memory backing
> + * the head and tail components is never kmalloc'd. These always
> + * come from pages in the svc_rqst::rq_pages array.
>   */
> -static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
> +static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
>  			   rpc_fraghdr marker, unsigned int *sentp)
>  {
> -	const struct kvec *head =3D xdr->head;
> -	const struct kvec *tail =3D xdr->tail;
>  	struct kvec rm =3D {
>  		.iov_base	=3D &marker,
>  		.iov_len	=3D sizeof(marker),
>  	};
>  	struct msghdr msg =3D {
> -		.msg_flags	=3D 0,
> +		.msg_flags	=3D MSG_MORE,
>  	};
> +	unsigned int count;
>  	int ret;
> =20
>  	*sentp =3D 0;
> -	ret =3D xdr_alloc_bvec(xdr, GFP_KERNEL);
> -	if (ret < 0)
> -		return ret;
> =20
> -	ret =3D kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
> +	ret =3D kernel_sendmsg(svsk->sk_sock, &msg, &rm, 1, rm.iov_len);
>  	if (ret < 0)
>  		return ret;
>  	*sentp +=3D ret;
>  	if (ret !=3D rm.iov_len)
>  		return -EAGAIN;
> =20
> -	ret =3D svc_tcp_send_kvec(sock, head, 0);
> -	if (ret < 0)
> -		return ret;
> -	*sentp +=3D ret;
> -	if (ret !=3D head->iov_len)
> -		goto out;
> -
> +	count =3D svc_sock_xdr_to_bvecs(svsk->sk_send_bvec, xdr);
>  	msg.msg_flags =3D MSG_SPLICE_PAGES;
> -	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
> -		      xdr_buf_pagecount(xdr), xdr->page_len);
> -	ret =3D sock_sendmsg(sock, &msg);
> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
> +		      count, xdr->len);
> +	ret =3D sock_sendmsg(svsk->sk_sock, &msg);
>  	if (ret < 0)
>  		return ret;
>  	*sentp +=3D ret;
> -
> -	if (tail->iov_len) {
> -		ret =3D svc_tcp_send_kvec(sock, tail, 0);
> -		if (ret < 0)
> -			return ret;
> -		*sentp +=3D ret;
> -	}
> -
> -out:
>  	return 0;
>  }
> =20
> @@ -1290,8 +1304,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
>  	if (svc_xprt_is_dead(xprt))
>  		goto out_notconn;
>  	tcp_sock_set_cork(svsk->sk_sk, true);
> -	err =3D svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
> -	xdr_free_bvec(xdr);
> +	err =3D svc_tcp_sendmsg(svsk, xdr, marker, &sent);
>  	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
>  	if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
>  		goto out_close;
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
