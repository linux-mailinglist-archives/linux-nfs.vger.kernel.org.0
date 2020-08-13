Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE10C243F1B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Aug 2020 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMTBs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Aug 2020 15:01:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59010 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMTBs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Aug 2020 15:01:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DIqExj071410;
        Thu, 13 Aug 2020 19:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=P6H1cFDtGn5W0jqxyo/YwbLzXDMgG84xNn5LeUbzAt8=;
 b=zl6FpC51lCOAZs0hyas4xMja14vQrDQYqMNtrdri1zJg8l6fE7eLMPtx94MoVuiquVJJ
 q3RP4Yx3UNvEAiuv6z62yPROL/bb5fuOiMhc57n+oD5689doHmPpA6ZVfIXY0Tn7Bhsv
 P+wUpMklzTwUEk/07mXEbP3VxkCsvDRBvNSOOFcCBi80h3OhaA9Owo1BuImeKc5AOkac
 0+IXIIUhMzhrBL8sFN9iYABNDsNB7sOBnCF9fzTXe1RmtvlFDE0wKHyQmsKX74ugXMoP
 Ya1SyeEWhTkAUSchAhcOhV73n8My6kFk2NM/8ZIhgp5ESE8/KEKg44FkmW6D951Gc8Px PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32t2ye0uxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Aug 2020 19:01:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DIrdII119021;
        Thu, 13 Aug 2020 19:01:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32t5ms5kq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 19:01:38 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07DJ1ZuE024738;
        Thu, 13 Aug 2020 19:01:37 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 19:01:35 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] nfsd: Remove unnecessary assignment in nfs4xdr.c
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200812203631.GA13358@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Thu, 13 Aug 2020 15:01:34 -0400
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <43C14B32-77C7-44E2-9051-0E80AF606CE0@oracle.com>
References: <20200812141252.21059-1-alex.dewar90@gmail.com>
 <20200812203631.GA13358@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130132
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 12, 2020, at 4:36 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Wed, Aug 12, 2020 at 03:12:51PM +0100, Alex Dewar wrote:
>>=20
>> In nfsd4_encode_listxattrs(), the variable p is assigned to at one =
point
>> but this value is never used before p is reassigned. Fix this.
>>=20
>> Addresses-Coverity: ("Unused value")
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>> ---
>> fs/nfsd/nfs4xdr.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 259d5ad0e3f47..1a0341fd80f9a 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -4859,7 +4859,7 @@ nfsd4_encode_listxattrs(struct =
nfsd4_compoundres *resp, __be32 nfserr,
>>                        goto out;
>>                }
>>=20
>> -               p =3D xdr_encode_opaque(p, sp, slen);
>> +               xdr_encode_opaque(p, sp, slen);
>>=20
>>                xdrleft -=3D xdrlen;
>>                count++;
>> --
>> 2.28.0
>>=20
>=20
> Yep, I guess my linting missed that, thanks for the fix.

Bruce, these two don't appear to be urgent, so I'm deferring them
to you for v5.10.


--
Chuck Lever



