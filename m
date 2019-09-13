Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5789B249A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfIMR3M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 13:29:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbfIMR3M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Sep 2019 13:29:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DHMfk7154701;
        Fri, 13 Sep 2019 17:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=VqPRpxD6n9MKTqyEMyl/LxFPRj0h0wTWhoitklqA400=;
 b=cmtdx7b76S6uhP+gjTqtgSD4c3kwy2B/grSmKEzO7wSFW+HtIarCz24GtUr6n3TzLrdU
 CYMy2nYOWSGxIGq+wm8NJPv9fDYthPWibBPBxfn1KgcLSQsGEUcOdM6KVhbtA0VtUxYT
 fQENXPBF7RSF++pmuE61EijqQHM8hatdEsIVIwc+XXKQX+ukmNZDPmHbVanpbiDUajrq
 1v8wifPOtcrunPOf7ujKxfvlajTnib6FkAkjvjfubTn9Ft+HhJFqGhzFbauIOflDx5Ma
 BrpJPfdwL4d0f1buX2c7apd4yNcfJU+dWCg3lYzJHkQh0dshZNXtETjwhwh6RbNpv2pZ mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uytd364qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 17:28:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DHFGEL050553;
        Fri, 13 Sep 2019 17:28:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2uytdx2x9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 17:28:49 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DHSmql003099;
        Fri, 13 Sep 2019 17:28:48 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 10:28:48 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] SUNRPC: Rename xdr_buf_read_netobj to
 xdr_buf_read_mic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <F0DD032B-D7C0-438F-9334-AA7427BA2215@redhat.com>
Date:   Fri, 13 Sep 2019 13:28:47 -0400
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>, tibbs@math.uh.edu,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>, km@cm4all.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC32C8F9-9D59-4D9E-B3B3-A6E57AA46AD5@oracle.com>
References: <043d2ca649c3d81cdf0b43b149cd43069ad1c1e2.1568307763.git.bcodding@redhat.com>
 <85127ce63248b1f34182dfef21ed30b808bf88fb.1568307763.git.bcodding@redhat.com>
 <71B1AFAE-2081-4FB4-A5AF-440CB2919C64@oracle.com>
 <F0DD032B-D7C0-438F-9334-AA7427BA2215@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130175
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 13, 2019, at 1:26 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> On 13 Sep 2019, at 11:16, Chuck Lever wrote:
>=20
>>> On Sep 12, 2019, at 1:07 PM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>=20
>>> Let the name reflect the single user and purpose.
>>=20
>> And perhaps the assumption that the MIC is always the last item in =
the xdr_buf?
>> I'm still reviewing 1/2, but this function might make that =
assumption.
>=20
> It does.. is that a bad assumption, or maybe you'd like a different =
name?

Just documenting it is enough for now; there is only one user.

In the long run I'd like to see this kind of xdr_buf manipulation =
replaced
with the use of a scratch buffer.


>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> ---
>>> include/linux/sunrpc/xdr.h     |  2 +-
>>> net/sunrpc/auth_gss/auth_gss.c |  2 +-
>>> net/sunrpc/xdr.c               | 42 =
+++++++++++++++++-----------------
>>> 3 files changed, 23 insertions(+), 23 deletions(-)
>>>=20
>>> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
>>> index 9ee3970ba59c..a6b63e47a79b 100644
>>> --- a/include/linux/sunrpc/xdr.h
>>> +++ b/include/linux/sunrpc/xdr.h
>>> @@ -179,7 +179,7 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
>>> extern void xdr_shift_buf(struct xdr_buf *, size_t);
>>> extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
>>> extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, =
unsigned int, unsigned int);
>>> -extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj =
*, unsigned int);
>>> +extern int xdr_buf_read_mic(struct xdr_buf *, struct xdr_netobj *, =
unsigned int);
>>> extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, =
void *, unsigned int);
>>> extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, =
void *, unsigned int);
>>>=20
>>> diff --git a/net/sunrpc/auth_gss/auth_gss.c =
b/net/sunrpc/auth_gss/auth_gss.c
>>> index 4ce42c62458e..d75fddca44c9 100644
>>> --- a/net/sunrpc/auth_gss/auth_gss.c
>>> +++ b/net/sunrpc/auth_gss/auth_gss.c
>>> @@ -1960,7 +1960,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, =
struct rpc_cred *cred,
>>>=20
>>> 	if (xdr_buf_subsegment(rcv_buf, &integ_buf, data_offset, =
integ_len))
>>> 		goto unwrap_failed;
>>> -	if (xdr_buf_read_netobj(rcv_buf, &mic, mic_offset))
>>> +	if (xdr_buf_read_mic(rcv_buf, &mic, mic_offset))
>>> 		goto unwrap_failed;
>>> 	maj_stat =3D gss_verify_mic(ctx->gc_gss_ctx, &integ_buf, &mic);
>>> 	if (maj_stat =3D=3D GSS_S_CONTEXT_EXPIRED)
>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>> index 6e05a9693568..90dfde50f0ef 100644
>>> --- a/net/sunrpc/xdr.c
>>> +++ b/net/sunrpc/xdr.c
>>> @@ -1236,52 +1236,52 @@ xdr_encode_word(struct xdr_buf *buf, =
unsigned int base, u32 obj)
>>> }
>>> EXPORT_SYMBOL_GPL(xdr_encode_word);
>>>=20
>>> -/* If the netobj starting offset bytes from the start of xdr_buf is =
contained
>>> - * entirely in the head, pages, or tail, set object to point to it; =
otherwise
>>> - * shift the buffer until it is contained entirely within the pages =
or tail.
>>> +/* If the mic starting offset bytes from the start of xdr_buf is =
contained
>>> + * entirely in the head, pages, or tail, set mic to point to it; =
otherwise
>>> + * shift the buf until it is contained entirely within the pages or =
tail.
>>> */
>>=20
>> Nit: Could the patch convert this into a kernel Doxygen style =
comment?
>=20
> Yes, can do that.
>=20
> Ben
>=20
>>> -int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj =
*obj, unsigned int offset)
>>> +int xdr_buf_read_mic(struct xdr_buf *buf, struct xdr_netobj *mic, =
unsigned int offset)
>>> {
>>> 	struct xdr_buf subbuf;
>>> 	unsigned int len_to_boundary;
>>>=20
>>> -	if (xdr_decode_word(buf, offset, &obj->len))
>>> +	if (xdr_decode_word(buf, offset, &mic->len))
>>> 		return -EFAULT;
>>>=20
>>> 	offset +=3D 4;
>>>=20
>>> -	/* Is the obj partially in the head? */
>>> +	/* Is the mic partially in the head? */
>>> 	len_to_boundary =3D buf->head->iov_len - offset;
>>> -	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>>> +	if (len_to_boundary > 0 && len_to_boundary < mic->len)
>>> 		xdr_shift_buf(buf, len_to_boundary);
>>>=20
>>> -	/* Is the obj partially in the pages? */
>>> +	/* Is the mic partially in the pages? */
>>> 	len_to_boundary =3D buf->head->iov_len + buf->page_len - offset;
>>> -	if (len_to_boundary > 0 && len_to_boundary < obj->len)
>>> +	if (len_to_boundary > 0 && len_to_boundary < mic->len)
>>> 		xdr_shrink_pagelen(buf, len_to_boundary);
>>>=20
>>> -	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
>>> +	if (xdr_buf_subsegment(buf, &subbuf, offset, mic->len))
>>> 		return -EFAULT;
>>>=20
>>> -	/* Most likely: is the obj contained entirely in the tail? */
>>> -	obj->data =3D subbuf.tail[0].iov_base;
>>> -	if (subbuf.tail[0].iov_len =3D=3D obj->len)
>>> +	/* Most likely: is the mic contained entirely in the tail? */
>>> +	mic->data =3D subbuf.tail[0].iov_base;
>>> +	if (subbuf.tail[0].iov_len =3D=3D mic->len)
>>> 		return 0;
>>>=20
>>> -	/* ..or is the obj contained entirely in the head? */
>>> -	obj->data =3D subbuf.head[0].iov_base;
>>> -	if (subbuf.head[0].iov_len =3D=3D obj->len)
>>> +	/* ..or is the mic contained entirely in the head? */
>>> +	mic->data =3D subbuf.head[0].iov_base;
>>> +	if (subbuf.head[0].iov_len =3D=3D mic->len)
>>> 		return 0;
>>>=20
>>> -	/* obj is in the pages: move to tail */
>>> -	if (obj->len > buf->buflen - buf->len)
>>> +	/* mic is in the pages: move to tail */
>>> +	if (mic->len > buf->buflen - buf->len)
>>> 		return -ENOMEM;
>>> -	obj->data =3D buf->head[0].iov_base + buf->head[0].iov_len;
>>> -	__read_bytes_from_xdr_buf(&subbuf, obj->data, obj->len);
>>> +	mic->data =3D buf->head[0].iov_base + buf->head[0].iov_len;
>>> +	__read_bytes_from_xdr_buf(&subbuf, mic->data, mic->len);
>>>=20
>>> 	return 0;
>>> }
>>> -EXPORT_SYMBOL_GPL(xdr_buf_read_netobj);
>>> +EXPORT_SYMBOL_GPL(xdr_buf_read_mic);
>>>=20
>>> /* Returns 0 on success, or else a negative error code. */
>>> static int
>>> --=20
>>> 2.20.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



