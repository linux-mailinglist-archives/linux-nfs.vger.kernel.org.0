Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9671413A9
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 22:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAQVtd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 16:49:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVtd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 16:49:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HLm1WE120606;
        Fri, 17 Jan 2020 21:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=1DM8lH3/hmljKOnr5y9TmYmW0zIcwFcvk/Co5AtxGW4=;
 b=fj4YCXOn2vhVd3UmqxwYXsgVE9qyXKac8RB3hwLuZY6yUuX+60UmmcpukEmVi9xZW2N1
 TdNT5p/bqhAOsTf/rrGey4NAY94oycFBHa2fZcTNH6p4rw8J4387HmKm4vcK6ndi+h7j
 ITehYBuQqKKsMWbHUdyPyOrvlWSlbLpwCIW1qJu0T2dEDZI0gv0IIRXNTNZsImJzZ++m
 9jCFPiqATLe17H9wMgvsS8EXL6SD/fkdwK7VZ7Uo90Krrt/hR31b4ahbMJ3TJouVJZbE
 b8RjxHnNyw26Hte8Y6t25OtOUdEuF9XTC5Gs4DsOjDhetMCb2th6hiyjyvAqKDLyV6DI Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73ub327-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 21:49:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00HLnL2b072623;
        Fri, 17 Jan 2020 21:49:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xjxp5vbr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 21:49:24 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00HLmbc0008480;
        Fri, 17 Jan 2020 21:48:38 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 13:48:37 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC] nfsd: Fix NFSv4 READ on RDMA when using readv
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200117214614.GC27294@fieldses.org>
Date:   Fri, 17 Jan 2020 16:48:36 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AD54268-CDD2-4011-8EC8-8B259A1C2FB2@oracle.com>
References: <20200115202647.2172.666.stgit@bazille.1015granger.net>
 <20200117214614.GC27294@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170167
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 17, 2020, at 4:46 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Wed, Jan 15, 2020 at 03:37:33PM -0500, Chuck Lever wrote:
>> svcrdma expects that the READ payload falls precisely into the
>> xdr_buf's page vector. Adding "xdr->iov =3D NULL" forces
>> xdr_reserve_space() to always use pages from xdr->buf->pages when
>> calling nfsd_readv.
>>=20
>> Also, the XDR padding is problematic. For NFS/RDMA Write chunks,
>> the padding needs to be in xdr->buf->tail so that the transport can
>> skip over it. However for NFS/TCP and the NFS/RDMA Reply chunks,
>> the padding has to be retained. Not yet sure how to add this.
>>=20
>> Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D198053
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> Howdy Bruce-
>>=20
>> I'm struggling with nfsd4_encode_readv().
>>=20
>> - for NFS/RDMA Write chunks, the READ payload has to be in
>>  buf->pages. I've fixed that.
>>=20
>> - xdr_reserve_space() calls don't need to explicitly align the
>>  @nbytes argument: xdr_reserve_space() already does this?
>>=20
>> - the while loop probably won't work if a later READ in the COMPOUND
>>  doesn't start on a page boundary. This isn't a problem until we
>>  run into a Solaris client in forcedirectio mode.
>=20
> So the Solaris client sends multiple reads per compound in that case?

If the application uses readv() and the mount is in forcedirectio
mode, I'm told Solaris will send an NFSv4 COMPOUND with multiple
READ operations in it.


>> - the XDR padding doesn't work for NFS/RDMA Write chunks, which are
>>  supposed to skip padding altogether.
>=20
> krb5i/p has to treat read data as padded regardless of the transport,
> doesn't it?

Yes. See my reply from earlier today: I think we can get away with
inserting the pad just before wrapping the Reply.


> --b.
>=20
>> Do you have suggestions? Thanks in advance.
>>=20
>>=20
>> fs/nfsd/nfs4xdr.c |   17 +++++++----------
>> 1 file changed, 7 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index d2dc4c0e22e8..14c68a136b4e 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -3519,17 +3519,14 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
>> 	u32 zzz =3D 0;
>> 	int pad;
>>=20
>> +	/* Ensure xdr_reserve_space behaves itself */
>> +	if (xdr->iov =3D=3D xdr->buf->head) {
>> +		xdr->iov =3D NULL;
>> +		xdr->end =3D xdr->p;
>> +	}
>> +
>> 	len =3D maxcount;
>> 	v =3D 0;
>> -
>> -	thislen =3D min_t(long, len, ((void *)xdr->end - (void =
*)xdr->p));
>> -	p =3D xdr_reserve_space(xdr, (thislen+3)&~3);
>> -	WARN_ON_ONCE(!p);
>> -	resp->rqstp->rq_vec[v].iov_base =3D p;
>> -	resp->rqstp->rq_vec[v].iov_len =3D thislen;
>> -	v++;
>> -	len -=3D thislen;
>> -
>> 	while (len) {
>> 		thislen =3D min_t(long, len, PAGE_SIZE);
>> 		p =3D xdr_reserve_space(xdr, (thislen+3)&~3);
>> @@ -3548,7 +3545,7 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
>> 	read->rd_length =3D maxcount;
>> 	if (nfserr)
>> 		return nfserr;
>> -	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
>> +	xdr_truncate_encode(xdr, starting_len + 8 + maxcount);
>>=20
>> 	tmp =3D htonl(eof);
>> 	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);

--
Chuck Lever



