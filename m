Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAED518C2DE
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 23:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCSWP3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 18:15:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42770 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgCSWP3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 18:15:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JM9Gk7033728;
        Thu, 19 Mar 2020 22:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=E1FaicFESA4imF///TfvbR91Gf+p3rJfvO3SjUsBAps=;
 b=fE+Xxom/O3bYtmMRbV1oukvUvf/oN3tXZ83eCre4OK8i7c4cgi6/pSdFigOMHc24Umw9
 av9WyMv7nuOoXZdyXl2TkFkp+8m8LqE3EFqnGix7/ech8/iHQ69oltGoY9Xw8/YLKbh8
 SKfw0tDSAwELnkKhJPm7gl6pem95Izo7Xegd3hroIJHEQBvE+2QhzkUKbd6NRCJoEu8A
 py12zmXI8Ci1JDWJosfBF+TuvZRlimG8fmoq9/p0V1ieRMtXGj17rUPjdbs31ZGgP7Ev
 eS/HG1FS/A+uID6N1Sp3szCwKwG+6vY1AabS7/v4kUYxpCm5zzscnSehZ0V29J9eCYa9 Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yrpprjyh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 22:15:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JM2jw9134111;
        Thu, 19 Mar 2020 22:15:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ys9054nb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 22:15:22 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02JMFKjq015571;
        Thu, 19 Mar 2020 22:15:21 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 15:15:20 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding
 logic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200319221350.GA18279@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Thu, 19 Mar 2020 18:15:19 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C99F4A1-4868-43C2-9F36-25FA5D82B92E@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-12-fllinden@amazon.com>
 <17D7709F-2FE0-4B84-A9AF-4D6C2B36A4E7@oracle.com>
 <20200319221350.GA18279@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190090
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 19, 2020, at 6:13 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Thu, Mar 12, 2020 at 12:24:18PM -0400, Chuck Lever wrote:
>>> +static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
>>> +                                    struct nfsd4_op *op)
>>> +{
>>> +     u32 maxcount, rlen;
>>> +
>>> +     maxcount =3D svc_max_payload(rqstp);
>>> +     rlen =3D min_t(u32, XATTR_SIZE_MAX, maxcount);
>>> +
>>> +     return (op_encode_hdr_size + 1 + XDR_QUADLEN(rlen)) * =
sizeof(__be32);
>>=20
>> These should be added in the same patch that adds OP_GETXATTR and =
friends.
>>=20
>> Also, Trond recently added xdr_align_size which I prefer over the
>> use of XDR_QUADLEN in new code.
>=20
> Thanks, I've squashed together those patches for this and the other =
reasons
> you pointed out.
>=20
> As for XDR_QUADLEN: that returns the 32bit-word rounded up lenghth - =
in words.
> xdr_aligned_size returns the 32bit-word rounded up length - in bytes.
>=20
> So, the result would then look something like:
>=20
> 	return xdr_align_size((op_encode_hdr_size * 4) + 4 + rlen);
>=20
> Is that what you're suggesting?

Oops, you're right. When you want words, XDR_QUADLEN is correct. Never =
mind!


--
Chuck Lever



