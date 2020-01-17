Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C341410ED
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAQSjn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 13:39:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSjm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 13:39:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HISiWC163311;
        Fri, 17 Jan 2020 18:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=mOHzRcMbrSRJmgt+SxKo3jl2NGzlXvmapW9P2uD6vK8=;
 b=HoMYL2LV2n3+1Ddsr3dwpMiEPTZjE/aL8fIKZTdyhaIM+gokQGKsUvdzNj400Zw14APh
 VDo5O6D0MLrQjKkuxVgMrhCRCrF+tKniiRaUCsQC1d4aoj+uaJh877HyPQzUdO7XCaG0
 AxF6ddYe2c9Mux2FBD18p5Wc4BNSASGsUxoPV4KL4ee7mqs4AG6GzyoPw9f+NDhrJZhL
 lZnUda815qc548ll1a1KulyEHLGdDNG8lSNz0oKE883Mm7Sti66dWQtEYctonq3KU1ZK
 oHUrsOxN2JHvfGqSy4jco6jmbP2rfoIigFt45IrEfIQ86/rubtNK9/Ytkc0HaHRO4Rp4 Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xf73uaa28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 18:39:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HITeG4091824;
        Fri, 17 Jan 2020 18:39:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xjxm9d3ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 18:39:35 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HIdX9q003012;
        Fri, 17 Jan 2020 18:39:34 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 10:39:33 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] nfsd: Fix NFSv4 READ on RDMA when using readv
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200115202647.2172.666.stgit@bazille.1015granger.net>
Date:   Fri, 17 Jan 2020 13:39:32 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC3ADAF8-A08F-46E4-B610-D4AA3D96A27C@oracle.com>
References: <20200115202647.2172.666.stgit@bazille.1015granger.net>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170143
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 15, 2020, at 3:37 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> svcrdma expects that the READ payload falls precisely into the
> xdr_buf's page vector. Adding "xdr->iov =3D NULL" forces
> xdr_reserve_space() to always use pages from xdr->buf->pages when
> calling nfsd_readv.
>=20
> Also, the XDR padding is problematic. For NFS/RDMA Write chunks,
> the padding needs to be in xdr->buf->tail so that the transport can
> skip over it. However for NFS/TCP and the NFS/RDMA Reply chunks,
> the padding has to be retained. Not yet sure how to add this.
>=20
> Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D198053
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> Howdy Bruce-
>=20
> I'm struggling with nfsd4_encode_readv().
>=20
> - for NFS/RDMA Write chunks, the READ payload has to be in
>  buf->pages. I've fixed that.
>=20
> - xdr_reserve_space() calls don't need to explicitly align the
>  @nbytes argument: xdr_reserve_space() already does this?
>=20
> - the while loop probably won't work if a later READ in the COMPOUND
>  doesn't start on a page boundary. This isn't a problem until we
>  run into a Solaris client in forcedirectio mode.
>=20
> - the XDR padding doesn't work for NFS/RDMA Write chunks, which are
>  supposed to skip padding altogether.
>=20
> Do you have suggestions? Thanks in advance.

I'm experimenting with an idea I think has been mentioned on list
a few times:

Having the RPC layer and transports deal with the padding of the
xdr_buf->pages vector, and moving that responsibility out of the
NFSD Reply encoder functions. xdr_buf->tail[0] then always begins
on an XDR-aligned boundary.

This should be straightforward for NFSv3. The only two Reply
encoders that are updated are READ and READLINK. I'm starting
with that.

Not quite sure yet how krb5i/krb5p will deal with this. Obviously
the page list pad needs to be inserted before each Reply is
wrapped.

I'll post more as experimentation progresses.


> fs/nfsd/nfs4xdr.c |   17 +++++++----------
> 1 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index d2dc4c0e22e8..14c68a136b4e 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3519,17 +3519,14 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
> 	u32 zzz =3D 0;
> 	int pad;
>=20
> +	/* Ensure xdr_reserve_space behaves itself */
> +	if (xdr->iov =3D=3D xdr->buf->head) {
> +		xdr->iov =3D NULL;
> +		xdr->end =3D xdr->p;
> +	}
> +
> 	len =3D maxcount;
> 	v =3D 0;
> -
> -	thislen =3D min_t(long, len, ((void *)xdr->end - (void =
*)xdr->p));
> -	p =3D xdr_reserve_space(xdr, (thislen+3)&~3);
> -	WARN_ON_ONCE(!p);
> -	resp->rqstp->rq_vec[v].iov_base =3D p;
> -	resp->rqstp->rq_vec[v].iov_len =3D thislen;
> -	v++;
> -	len -=3D thislen;
> -
> 	while (len) {
> 		thislen =3D min_t(long, len, PAGE_SIZE);
> 		p =3D xdr_reserve_space(xdr, (thislen+3)&~3);
> @@ -3548,7 +3545,7 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
> 	read->rd_length =3D maxcount;
> 	if (nfserr)
> 		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
> +	xdr_truncate_encode(xdr, starting_len + 8 + maxcount);
>=20
> 	tmp =3D htonl(eof);
> 	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
>=20

--
Chuck Lever



