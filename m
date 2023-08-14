Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1977B962
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjHNNHG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHNNHF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 09:07:05 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 06:07:02 PDT
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A08E62
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 06:07:02 -0700 (PDT)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
        by smtp-o-2.desy.de (Postfix) with ESMTP id E10F61612D2
        for <linux-nfs@vger.kernel.org>; Mon, 14 Aug 2023 14:57:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de E10F61612D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1692017820; bh=h6OQUaU3rx2EsMSrGnTcGuf1q2loQV2sybjxw5L9RKw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Ahy5G11rVldS3Euiu+rczJJOU23MbV/JPDHlVLUstmQRLH/ylRTHstSejNyKsMtQF
         VItckb3fIXMQYYz9aCQzVL8hTzVc55n6AZTcTPROmC4loJGfdI2O8p1ZkGyUP2Rjod
         wcyjW8p1n4bWXVHmyuV3FE8Bf6qV6nywVC0k+CNo=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id C67101A0121;
        Mon, 14 Aug 2023 14:57:00 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
        by smtp-m-2.desy.de (Postfix) with ESMTP id B49BA120042;
        Mon, 14 Aug 2023 14:57:00 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
        by a1722.mx.srv.dfn.de (Postfix) with ESMTP id EA702220043;
        Mon, 14 Aug 2023 14:56:58 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id B3CD8804BA;
        Mon, 14 Aug 2023 14:56:58 +0200 (CEST)
Date:   Mon, 14 Aug 2023 14:56:58 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <cel@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>, netdev@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Message-ID: <1899437526.7296629.1692017818178.JavaMail.zimbra@desy.de>
In-Reply-To: <6410981f7adc45de4f4b1c2455d5b6d398472628.camel@kernel.org>
References: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net> <168935823761.1984.15760913629466718014.stgit@manet.1015granger.net> <6410981f7adc45de4f4b1c2455d5b6d398472628.camel@kernel.org>
Subject: Re: [PATCH v2 1/4] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs
 directly
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_7296634_2133751270.1692017818676"
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF116 (Linux)/9.0.0_GA_4546)
Thread-Topic: SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
Thread-Index: BhOeAKoVu1+Peo7WZKkafpMj3ZyGlA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

------=_Part_7296634_2133751270.1692017818676
Date: Mon, 14 Aug 2023 14:56:58 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>, 
	netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	dhowells@redhat.com
Message-ID: <1899437526.7296629.1692017818178.JavaMail.zimbra@desy.de>
In-Reply-To: <6410981f7adc45de4f4b1c2455d5b6d398472628.camel@kernel.org>
References: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net> <168935823761.1984.15760913629466718014.stgit@manet.1015granger.net> <6410981f7adc45de4f4b1c2455d5b6d398472628.camel@kernel.org>
Subject: Re: [PATCH v2 1/4] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs
 directly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4546 (ZimbraWebClient - FF116 (Linux)/9.0.0_GA_4546)
Thread-Topic: SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
Thread-Index: BhOeAKoVu1+Peo7WZKkafpMj3ZyGlA==



----- Original Message -----
> From: "Jeff Layton" <jlayton@kernel.org>
> To: "Chuck Lever" <cel@kernel.org>, "linux-nfs" <linux-nfs@vger.kernel.org>, netdev@vger.kernel.org
> Cc: "Chuck Lever" <chuck.lever@oracle.com>, dhowells@redhat.com
> Sent: Saturday, 12 August, 2023 14:04:57
> Subject: Re: [PATCH v2 1/4] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly

> On Fri, 2023-07-14 at 14:10 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Add a helper to convert a whole xdr_buf directly into an array of
>> bio_vecs, then send this array instead of iterating piecemeal over
>> the xdr_buf containing the outbound RPC message.
>> 
>> Note that the rules of the RPC protocol mean there can be only one
>> outstanding send at a time on a transport socket. The kernel's
>> SunRPC server enforces this via the transport's xpt_mutex. Thus we
>> can use a per-transport shared array for the xdr_buf conversion
>> rather than allocate one every time or use one that is part of
>> struct svc_rqst.
>> 
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/sunrpc/svcsock.h |    3 ++
>>  include/linux/sunrpc/xdr.h     |    2 +
>>  net/sunrpc/svcsock.c           |   59 ++++++++++++++--------------------------
>>  net/sunrpc/xdr.c               |   50 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 75 insertions(+), 39 deletions(-)
>> 
> 
> I've seen some pynfs test regressions in mainline (v6.5-rc5-ish)
> kernels. Here's one failing test:


BTW, we have built a container to run pynfs tests as part of your CI process.

podman run -ti --rm dcache/pynfs:0.3 /run-nfs4.0.sh --help
podman run -ti --rm dcache/pynfs:0.3 /run-nfs4.1.sh --help

Maybe others will find it useful as well.

Tigran.




> 
> _text = b'write data' # len=10
> 
> [...]
> 
> def testSimpleWrite2(t, env):
>    """WRITE with stateid=zeros changing size
> 
>    FLAGS: write all
>    DEPEND: MKFILE
>    CODE: WRT1b
>    """
>    c = env.c1
>    c.init_connection()
>    attrs = {FATTR4_SIZE: 32, FATTR4_MODE: 0o644}
>    fh, stateid = c.create_confirm(t.word(), attrs=attrs,
>                                   deny=OPEN4_SHARE_DENY_NONE)
>    res = c.write_file(fh, _text, 30)
>    check(res, msg="WRITE with stateid=zeros changing size")
>    res = c.read_file(fh, 25, 20)
>    _compare(t, res, b'\0'*5 + _text, True)
> 
> This test writes 10 bytes of data (to a file at offset 30, and then does
> a 20 byte read starting at offset 25. The READ reply has NULs where the
> written data should be
> 
> The patch that broke things is this one:
> 
>    5df5dd03a8f7 sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
> 
> This patch fixes the problem and gets the test run "green" again. I
> think we will probably want to send this patch to mainline for v6.5, but
> it'd be good to understand what's broken and how this fixes it.
> 
> Do you (or David) have any insight?
> 
> It'd also be good to understand whether we also need to fix UDP. pynfs
> is tcp-only, so I can't run the same test there as easily.
> 
>> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
>> index a7116048a4d4..a9bfeadf4cbe 100644
>> --- a/include/linux/sunrpc/svcsock.h
>> +++ b/include/linux/sunrpc/svcsock.h
>> @@ -40,6 +40,9 @@ struct svc_sock {
>>  
>>  	struct completion	sk_handshake_done;
>>  
>> +	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
>> +						____cacheline_aligned;
>> +
>>  	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
>>  };
>>  
>> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
>> index f89ec4b5ea16..42f9d7eb9a1a 100644
>> --- a/include/linux/sunrpc/xdr.h
>> +++ b/include/linux/sunrpc/xdr.h
>> @@ -139,6 +139,8 @@ void	xdr_terminate_string(const struct xdr_buf *, const
>> u32);
>>  size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
>>  int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
>>  void	xdr_free_bvec(struct xdr_buf *buf);
>> +unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
>> +			     const struct xdr_buf *xdr);
>>  
>>  static inline __be32 *xdr_encode_array(__be32 *p, const void *s, unsigned int
>>  len)
>>  {
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index e43f26382411..e35e5afe4b81 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -36,6 +36,8 @@
>>  #include <linux/skbuff.h>
>>  #include <linux/file.h>
>>  #include <linux/freezer.h>
>> +#include <linux/bvec.h>
>> +
>>  #include <net/sock.h>
>>  #include <net/checksum.h>
>>  #include <net/ip.h>
>> @@ -1194,72 +1196,52 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
>>  	return 0;	/* record not complete */
>>  }
>>  
>> -static int svc_tcp_send_kvec(struct socket *sock, const struct kvec *vec,
>> -			      int flags)
>> -{
>> -	struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | flags, };
>> -
>> -	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
>> -	return sock_sendmsg(sock, &msg);
>> -}
>> -
>>  /*
>>   * MSG_SPLICE_PAGES is used exclusively to reduce the number of
>>   * copy operations in this path. Therefore the caller must ensure
>>   * that the pages backing @xdr are unchanging.
>>   *
>> - * In addition, the logic assumes that * .bv_len is never larger
>> - * than PAGE_SIZE.
>> + * Note that the send is non-blocking. The caller has incremented
>> + * the reference count on each page backing the RPC message, and
>> + * the network layer will "put" these pages when transmission is
>> + * complete.
>> + *
>> + * This is safe for our RPC services because the memory backing
>> + * the head and tail components is never kmalloc'd. These always
>> + * come from pages in the svc_rqst::rq_pages array.
>>   */
>> -static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
>> +static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
>>  			   rpc_fraghdr marker, unsigned int *sentp)
>>  {
>> -	const struct kvec *head = xdr->head;
>> -	const struct kvec *tail = xdr->tail;
>>  	struct kvec rm = {
>>  		.iov_base	= &marker,
>>  		.iov_len	= sizeof(marker),
>>  	};
>>  	struct msghdr msg = {
>> -		.msg_flags	= 0,
>> +		.msg_flags	= MSG_MORE,
>>  	};
>> +	unsigned int count;
>>  	int ret;
>>  
>>  	*sentp = 0;
>> -	ret = xdr_alloc_bvec(xdr, GFP_KERNEL);
>> -	if (ret < 0)
>> -		return ret;
>>  
>> -	ret = kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
>> +	ret = kernel_sendmsg(svsk->sk_sock, &msg, &rm, 1, rm.iov_len);
>>  	if (ret < 0)
>>  		return ret;
>>  	*sentp += ret;
>>  	if (ret != rm.iov_len)
>>  		return -EAGAIN;
>>  
>> -	ret = svc_tcp_send_kvec(sock, head, 0);
>> -	if (ret < 0)
>> -		return ret;
>> -	*sentp += ret;
>> -	if (ret != head->iov_len)
>> -		goto out;
>> +	count = xdr_buf_to_bvec(svsk->sk_send_bvec,
>> +				ARRAY_SIZE(svsk->sk_send_bvec), xdr);
>>  
>>  	msg.msg_flags = MSG_SPLICE_PAGES;
>> -	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
>> -		      xdr_buf_pagecount(xdr), xdr->page_len);
>> -	ret = sock_sendmsg(sock, &msg);
>> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
>> +		      count, xdr->len);
>> +	ret = sock_sendmsg(svsk->sk_sock, &msg);
>>  	if (ret < 0)
>>  		return ret;
>>  	*sentp += ret;
>> -
>> -	if (tail->iov_len) {
>> -		ret = svc_tcp_send_kvec(sock, tail, 0);
>> -		if (ret < 0)
>> -			return ret;
>> -		*sentp += ret;
>> -	}
>> -
>> -out:
>>  	return 0;
>>  }
>>  
>> @@ -1290,8 +1272,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
>>  	if (svc_xprt_is_dead(xprt))
>>  		goto out_notconn;
>>  	tcp_sock_set_cork(svsk->sk_sk, true);
>> -	err = svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
>> -	xdr_free_bvec(xdr);
>> +	err = svc_tcp_sendmsg(svsk, xdr, marker, &sent);
>>  	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
>>  	if (err < 0 || sent != (xdr->len + sizeof(marker)))
>>  		goto out_close;
>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>> index 2a22e78af116..358e6de91775 100644
>> --- a/net/sunrpc/xdr.c
>> +++ b/net/sunrpc/xdr.c
>> @@ -164,6 +164,56 @@ xdr_free_bvec(struct xdr_buf *buf)
>>  	buf->bvec = NULL;
>>  }
>>  
>> +/**
>> + * xdr_buf_to_bvec - Copy components of an xdr_buf into a bio_vec array
>> + * @bvec: bio_vec array to populate
>> + * @bvec_size: element count of @bio_vec
>> + * @xdr: xdr_buf to be copied
>> + *
>> + * Returns the number of entries consumed in @bvec.
>> + */
>> +unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
>> +			     const struct xdr_buf *xdr)
>> +{
>> +	const struct kvec *head = xdr->head;
>> +	const struct kvec *tail = xdr->tail;
>> +	unsigned int count = 0;
>> +
>> +	if (head->iov_len) {
>> +		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
>> +		++count;
>> +	}
>> +
>> +	if (xdr->page_len) {
>> +		unsigned int offset, len, remaining;
>> +		struct page **pages = xdr->pages;
>> +
>> +		offset = offset_in_page(xdr->page_base);
>> +		remaining = xdr->page_len;
>> +		while (remaining > 0) {
>> +			len = min_t(unsigned int, remaining,
>> +				    PAGE_SIZE - offset);
>> +			bvec_set_page(bvec++, *pages++, len, offset);
>> +			remaining -= len;
>> +			offset = 0;
>> +			if (unlikely(++count > bvec_size))
>> +				goto bvec_overflow;
>> +		}
>> +	}
>> +
>> +	if (tail->iov_len) {
>> +		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
>> +		if (unlikely(++count > bvec_size))
>> +			goto bvec_overflow;
>> +	}
>> +
>> +	return count;
>> +
>> +bvec_overflow:
>> +	pr_warn_once("%s: bio_vec array overflow\n", __func__);
>> +	return count - 1;
>> +}
>> +
>>  /**
>>   * xdr_inline_pages - Prepare receive buffer for a large reply
>>   * @xdr: xdr_buf into which reply will be placed
>> 
>> 
> 
> --
> Jeff Layton <jlayton@kernel.org>

------=_Part_7296634_2133751270.1692017818676
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
vzCCBKegAwIBAgIMJENPm+MXSsxZAQzUMA0GCSqGSIb3DQEBCwUAMIGNMQswCQYDVQQGEwJERTFF
MEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdz
bmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEdsb2Jh
bCBJc3N1aW5nIENBMB4XDTIxMDIxMDEyMzEwOVoXDTI0MDIxMDEyMzEwOVowWDELMAkGA1UEBhMC
REUxLjAsBgNVBAoMJURldXRzY2hlcyBFbGVrdHJvbmVuLVN5bmNocm90cm9uIERFU1kxGTAXBgNV
BAMMEFRpZ3JhbiBNa3J0Y2h5YW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQClVKHU
er1OiIaoo2MFDgCSzcqRCB8qVjjLJyJwzHWkhKniE6dwY8xHciG0HZFpSQqiRsoakD+BzqINXsqI
CkVck5n7cUJ6cHBOM1r4pzEBcuuozPrT2tAfnHkFFGTZffOXgjmEITfSh6SD+DYeZH4Dt8kPZmnD
mzWMDFDyB67WWcWApVC1nPh29yGgJk18UZ+Ut9a+woaovMZlutMbuvLVt/x5rpycMw0z+J1qeK7J
8F3bKb0o2gg+Mnz9LzpLtJp7E9qJUKOTkZGDua9w9xrlo4XGX9Vn72K5wodu6woahdgNG+sXRcJM
RH3aWgfdznoi1ORLJCfTbdfjSBpclvt/AgMBAAGjggJRMIICTTA+BgNVHSAENzA1MA8GDSsGAQQB
ga0hgiwBAQQwEAYOKwYBBAGBrSGCLAEBBAgwEAYOKwYBBAGBrSGCLAIBBAgwCQYDVR0TBAIwADAO
BgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQG
1+t/IHSjHSbbu11uU5Iw7JW92zAfBgNVHSMEGDAWgBRrOpiL+fJTidrgrbIyHgkf6Ko7dDAjBgNV
HREEHDAagRh0aWdyYW4ubWtydGNoeWFuQGRlc3kuZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0
cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+g
PaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNy
bC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZu
LmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUv
ZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6
Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
DQYJKoZIhvcNAQELBQADggEBADaFbcKsjBPbw6aRf5vxlJdehkafMy4JIdduMEGB+IjpBRZGmu0Z
R2FRWNyq0lNRz03holZ8Rew0Ldx58REJmvAEzbwox4LT1wG8gRLEehyasSROajZBFrIHadDja0y4
1JrfqP2umZFE2XWap8pDFpQk4sZOXW1mEamLzFtlgXtCfalmYmbnrq5DnSVKX8LOt5BZvDWin3r4
m5v313d5/l0Qz2IrN6v7qNIyqT4peW90DUJHB1MGN60W2qe+VimWIuLJkQXMOpaUQJUlhkHOnhw8
82g+jWG6kpKBMzIQMMGP0urFlPAia2Iuu2VtCkT7Wr43xyhiVzkZcT6uzR23PLsAADGCApswggKX
AgEBMIGeMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVp
bmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUw
IwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwkQ0+b4xdKzFkBDNQwDQYJYIZI
AWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMw
ODE0MTI1NjU4WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqGSIb3DQEBCwUA
MC8GCSqGSIb3DQEJBDEiBCB2qwWdnxxCSvvS+FZ4e4CquWCeclrj61Zhl+16ApkFqjA0BgkqhkiG
9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBgkqhkiG9w0B
AQsFAASCAQAdiVSvgIkj743lnj1WmAL94RohgWwCE7/9QoeGG6KMT2m2trX/3OVBwaSrEAXQGeAZ
pPruIapyVZ2qn6ifMb5TcbsvDPmSpRVNs8zJpkdAF5FKTfoVR+iWpipQmWzQ4fTAZXBhNfXxCFxB
QlrmvsMCxVDm+w2MNYmPt9m6P5Zx3BdiltLQ4mONUhHr6iQYnCvnJ7zttzdhPJwSmgVcj68+N3Rh
VcBimHIyp0Tk8AnfJDCea6xpwdBAvVfXWriy4iorgJb+l/XeFCFgvPkx4oDNk3/WSIYcv22M1E5u
+x5cqsZdpB+j/rt27R6l+T9RdqIyBHXbIFveE6YB0ZpAfVk3AAAAAAAA
------=_Part_7296634_2133751270.1692017818676--
