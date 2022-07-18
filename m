Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012AF578B44
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiGRTxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiGRTxJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 15:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DB32457
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 12:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE8C61734
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 19:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB2C341C0;
        Mon, 18 Jul 2022 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658173986;
        bh=dJhBnYQUflLf47QaamibBYF2AQKkWbTvGpqMxN+yvzU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HUgz1QPFtLK5oHNMqyGxFTIY9oDTLTYQGsMXTARjKYK7OrAdpUOHCmQDdOPAiizKe
         2f89jYh3JfFV+hslRIxmGkk8n3NvxPrst2to6MJ9IDVXv3NY0NrhveFjb/BaPJQ2lX
         C9Mc47ll5hJbYKOEMz+u97Dp7eGBJQpus+zBscM+w8NGCDV9LhEoGcY2ZVZr3C5AMp
         i1D4X5jDoonZBtiNl7Qil2nmdRuWlWyZQf2v9Cbf2dpxrUION8ievsh4o/uid2R3sF
         0WurfcCTFiknwt1/0rgXP0b9DAJo6N24sJmkYqY98yWYSn6U+QkHS/xCJPG6l+0P3z
         3AQklUACILLfA==
Message-ID: <0a6fdc0c2a60ffaedc970c158f97b16c500d3954.camel@kernel.org>
Subject: Re: [PATCH v2 10/15] SUNRPC: Capture cmsg metadata on client-side
 receive
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 18 Jul 2022 15:53:05 -0400
In-Reply-To: <165452709314.1496.1821426681306661216.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452709314.1496.1821426681306661216.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:51 -0400, Chuck Lever wrote:
> kTLS sockets use cmsg to report decryption errors and the need
> for session re-keying. An "application data" message contains a ULP
> payload, and that is passed along to the RPC client. An "alert"
> message triggers connection reset. Everything else is discarded.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/net/tls.h             |    2 ++
>  include/trace/events/sunrpc.h |   40 +++++++++++++++++++++++++++++++++
>  net/sunrpc/xprtsock.c         |   49 +++++++++++++++++++++++++++++++++++=
++++--
>  3 files changed, 89 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 6b1bf46daa34..54bccb2e4014 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -71,6 +71,8 @@ static inline struct tlsh_sock *tlsh_sk(struct sock *sk=
)
> =20
>  #define TLS_CRYPTO_INFO_READY(info)	((info)->cipher_type)
> =20
> +#define TLS_RECORD_TYPE_ALERT		0x15
> +#define TLS_RECORD_TYPE_HANDSHAKE	0x16
>  #define TLS_RECORD_TYPE_DATA		0x17
> =20
>  #define TLS_AAD_SPACE_SIZE		13
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.=
h
> index 986e135e314f..d7d07f3b850e 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1319,6 +1319,46 @@ TRACE_EVENT(xs_data_ready,
>  	TP_printk("peer=3D[%s]:%s", __get_str(addr), __get_str(port))
>  );
> =20
> +/*
> + * From https://www.iana.org/assignments/tls-parameters/tls-parameters.x=
html
> + *
> + * Captured March 2022. Other values are unassigned or reserved.
> + */
> +#define rpc_show_tls_content_type(type) \
> +	__print_symbolic(type, \
> +		{ 20,		"change cipher spec" }, \
> +		{ 21,		"alert" }, \
> +		{ 22,		"handshake" }, \
> +		{ 23,		"application data" }, \
> +		{ 24,		"heartbeat" }, \
> +		{ 25,		"tls12_cid" }, \
> +		{ 26,		"ACK" })
> +
> +TRACE_EVENT(xs_tls_contenttype,
> +	TP_PROTO(
> +		const struct rpc_xprt *xprt,
> +		unsigned char ctype
> +	),
> +
> +	TP_ARGS(xprt, ctype),
> +
> +	TP_STRUCT__entry(
> +		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
> +		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
> +		__field(unsigned long, ctype)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
> +		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
> +		__entry->ctype =3D ctype;
> +	),
> +
> +	TP_printk("peer=3D[%s]:%s: %s", __get_str(addr), __get_str(port),
> +		rpc_show_tls_content_type(__entry->ctype)
> +	)
> +);
> +
>  TRACE_EVENT(xs_stream_read_data,
>  	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
> =20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 0a521aee0b2f..c73af8f1c3d4 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -47,6 +47,8 @@
>  #include <net/checksum.h>
>  #include <net/udp.h>
>  #include <net/tcp.h>
> +#include <net/tls.h>
> +
>  #include <linux/bvec.h>
>  #include <linux/highmem.h>
>  #include <linux/uio.h>
> @@ -350,13 +352,56 @@ xs_alloc_sparse_pages(struct xdr_buf *buf, size_t w=
ant, gfp_t gfp)
>  	return want;
>  }
> =20
> +static int
> +xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
> +		     struct cmsghdr *cmsg, int ret)
> +{
> +	if (cmsg->cmsg_level =3D=3D SOL_TLS &&
> +	    cmsg->cmsg_type =3D=3D TLS_GET_RECORD_TYPE) {
> +		u8 content_type =3D *((u8 *)CMSG_DATA(cmsg));
> +
> +		trace_xs_tls_contenttype(xprt_from_sock(sock->sk), content_type);
> +		switch (content_type) {
> +		case TLS_RECORD_TYPE_DATA:
> +			/* TLS sets EOR at the end of each application data
> +			 * record, even though there might be more frames
> +			 * waiting to be decrypted. */
> +			msg->msg_flags &=3D ~MSG_EOR;
> +			break;
> +		case TLS_RECORD_TYPE_ALERT:
> +			ret =3D -ENOTCONN;
> +			break;
> +		default:
> +			ret =3D -EAGAIN;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int
> +xs_sock_recv_cmsg(struct socket *sock, struct msghdr *msg, int flags)
> +{
> +	union {
> +		struct cmsghdr	cmsg;
> +		u8		buf[CMSG_SPACE(sizeof(u8))];
> +	} u;
> +	int ret;
> +
> +	msg->msg_control =3D &u;
> +	msg->msg_controllen =3D sizeof(u);
> +	ret =3D sock_recvmsg(sock, msg, flags);
> +	if (msg->msg_controllen !=3D sizeof(u))

Do you also need to check for ret < 0 here? Can msg_controllen be
trusted if sock_recvmsg returns an error?

> +		ret =3D xs_sock_process_cmsg(sock, msg, &u.cmsg, ret);
> +	return ret;
> +}
> +
>  static ssize_t
>  xs_sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags, size=
_t seek)
>  {
>  	ssize_t ret;
>  	if (seek !=3D 0)
>  		iov_iter_advance(&msg->msg_iter, seek);
> -	ret =3D sock_recvmsg(sock, msg, flags);
> +	ret =3D xs_sock_recv_cmsg(sock, msg, flags);
>  	return ret > 0 ? ret + seek : ret;
>  }
> =20
> @@ -382,7 +427,7 @@ xs_read_discard(struct socket *sock, struct msghdr *m=
sg, int flags,
>  		size_t count)
>  {
>  	iov_iter_discard(&msg->msg_iter, READ, count);
> -	return sock_recvmsg(sock, msg, flags);
> +	return xs_sock_recv_cmsg(sock, msg, flags);
>  }
> =20
>  #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
