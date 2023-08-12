Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6A779FE4
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Aug 2023 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjHLMFL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Aug 2023 08:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLME4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Aug 2023 08:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF393
        for <linux-nfs@vger.kernel.org>; Sat, 12 Aug 2023 05:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4725161892
        for <linux-nfs@vger.kernel.org>; Sat, 12 Aug 2023 12:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B222C433C7;
        Sat, 12 Aug 2023 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691841898;
        bh=Tm6DNYHrf0rPVq5h6JOcnhhx37xoD4Q1jsYHtNNZqAY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HxvoLCMTKNaT6pXRAf7a3buppsMD12Bi8XpoSyE3pDVn+vOOo7rG+R6KCKVkehotm
         AsyEFKwQsM+ZwLELQQ0rq5ptMw+jyuNrgYhkSH/Gt+V7vsiTS6htI39mcxjHakkepy
         7yN14sTy2WhAh/gRMGePz84VaqMHC82F0uk7dpPI4sj0wY2GUXLOoX2CfzpwUnNRgg
         WDmSSvpwAGLlEvnjL/4w8qlicWnbX1h8ngUJbzEMLaM6LzHtk9i7nI84FaF1p1W6bg
         /Y19P54JouU3vWYnmPC/6WTYdM+7JbxY2lBlFUoq4Yhb8s6bZqYCgVUhL/FpzP6aN1
         xm0KBzJZWszeQ==
Message-ID: <6410981f7adc45de4f4b1c2455d5b6d398472628.camel@kernel.org>
Subject: Re: [PATCH v2 1/4] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs
 directly
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Sat, 12 Aug 2023 08:04:57 -0400
In-Reply-To: <168935823761.1984.15760913629466718014.stgit@manet.1015granger.net>
References: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
         <168935823761.1984.15760913629466718014.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-07-14 at 14:10 -0400, Chuck Lever wrote:
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
>  include/linux/sunrpc/svcsock.h |    3 ++
>  include/linux/sunrpc/xdr.h     |    2 +
>  net/sunrpc/svcsock.c           |   59 ++++++++++++++--------------------=
------
>  net/sunrpc/xdr.c               |   50 ++++++++++++++++++++++++++++++++++
>  4 files changed, 75 insertions(+), 39 deletions(-)
>=20

I've seen some pynfs test regressions in mainline (v6.5-rc5-ish)
kernels. Here's one failing test:

_text =3D b'write data' # len=3D10

[...]

def testSimpleWrite2(t, env):
    """WRITE with stateid=3Dzeros changing size

    FLAGS: write all
    DEPEND: MKFILE
    CODE: WRT1b
    """
    c =3D env.c1
    c.init_connection()
    attrs =3D {FATTR4_SIZE: 32, FATTR4_MODE: 0o644}
    fh, stateid =3D c.create_confirm(t.word(), attrs=3Dattrs,
                                   deny=3DOPEN4_SHARE_DENY_NONE)
    res =3D c.write_file(fh, _text, 30)
    check(res, msg=3D"WRITE with stateid=3Dzeros changing size")
    res =3D c.read_file(fh, 25, 20)
    _compare(t, res, b'\0'*5 + _text, True)

This test writes 10 bytes of data (to a file at offset 30, and then does
a 20 byte read starting at offset 25. The READ reply has NULs where the
written data should be

The patch that broke things is this one:

    5df5dd03a8f7 sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage

This patch fixes the problem and gets the test run "green" again. I
think we will probably want to send this patch to mainline for v6.5, but
it'd be good to understand what's broken and how this fixes it.

Do you (or David) have any insight?

It'd also be good to understand whether we also need to fix UDP. pynfs
is tcp-only, so I can't run the same test there as easily.

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
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index f89ec4b5ea16..42f9d7eb9a1a 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -139,6 +139,8 @@ void	xdr_terminate_string(const struct xdr_buf *, con=
st u32);
>  size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
>  int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
>  void	xdr_free_bvec(struct xdr_buf *buf);
> +unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_siz=
e,
> +			     const struct xdr_buf *xdr);
> =20
>  static inline __be32 *xdr_encode_array(__be32 *p, const void *s, unsigne=
d int len)
>  {
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index e43f26382411..e35e5afe4b81 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -36,6 +36,8 @@
>  #include <linux/skbuff.h>
>  #include <linux/file.h>
>  #include <linux/freezer.h>
> +#include <linux/bvec.h>
> +
>  #include <net/sock.h>
>  #include <net/checksum.h>
>  #include <net/ip.h>
> @@ -1194,72 +1196,52 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqst=
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
> +	count =3D xdr_buf_to_bvec(svsk->sk_send_bvec,
> +				ARRAY_SIZE(svsk->sk_send_bvec), xdr);
> =20
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
> @@ -1290,8 +1272,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
>  	if (svc_xprt_is_dead(xprt))
>  		goto out_notconn;
>  	tcp_sock_set_cork(svsk->sk_sk, true);
> -	err =3D svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
> -	xdr_free_bvec(xdr);
> +	err =3D svc_tcp_sendmsg(svsk, xdr, marker, &sent);
>  	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
>  	if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
>  		goto out_close;
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 2a22e78af116..358e6de91775 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -164,6 +164,56 @@ xdr_free_bvec(struct xdr_buf *buf)
>  	buf->bvec =3D NULL;
>  }
> =20
> +/**
> + * xdr_buf_to_bvec - Copy components of an xdr_buf into a bio_vec array
> + * @bvec: bio_vec array to populate
> + * @bvec_size: element count of @bio_vec
> + * @xdr: xdr_buf to be copied
> + *
> + * Returns the number of entries consumed in @bvec.
> + */
> +unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_siz=
e,
> +			     const struct xdr_buf *xdr)
> +{
> +	const struct kvec *head =3D xdr->head;
> +	const struct kvec *tail =3D xdr->tail;
> +	unsigned int count =3D 0;
> +
> +	if (head->iov_len) {
> +		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
> +		++count;
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
> +			if (unlikely(++count > bvec_size))
> +				goto bvec_overflow;
> +		}
> +	}
> +
> +	if (tail->iov_len) {
> +		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
> +		if (unlikely(++count > bvec_size))
> +			goto bvec_overflow;
> +	}
> +
> +	return count;
> +
> +bvec_overflow:
> +	pr_warn_once("%s: bio_vec array overflow\n", __func__);
> +	return count - 1;
> +}
> +
>  /**
>   * xdr_inline_pages - Prepare receive buffer for a large reply
>   * @xdr: xdr_buf into which reply will be placed
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
