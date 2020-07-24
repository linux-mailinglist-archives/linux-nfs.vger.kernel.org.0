Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197B022C76D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGXOKT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jul 2020 10:10:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgGXOKT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jul 2020 10:10:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OE7P0Z018161;
        Fri, 24 Jul 2020 14:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=r/jCJ2lBqkTVdFz6qzmuPX4WCaz0peM6Dv/PBrP08Xs=;
 b=vuhT7AXzNGGe8w/vGiRNGkLnsFRKy+Mn7MJSly0XTsb5n4AbgFaUDXbQkX9V1cGNQCp9
 mQiN8TZlj2xMrRMyotdxfS1cQMSKdR6Fnmfmp+cYIM8ZOpyvWpgE038ITHFFeZsRdo+Y
 /ArDPgjUjIM4laQFpcpxjyHiwStTBIEeL1CxKlZMVSVN8M42cdi9ygpSNUiqQ1dwlhVZ
 Pb3jgkmLVMAsBK5GOVlNjzcVUJxko3PlX/VaxV7Qf/6/oHvtTNYW54SgqVAOKa8V/ktt
 4Vxs26TgCWjWHanySTvU9eCxEddV9UJpUAp7X6x8mHiDUdUt0Ez7FHaYY5ng350AFm7I GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32d6kt3jjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 14:10:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OE3DsH073379;
        Fri, 24 Jul 2020 14:10:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32g0s2hs3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 14:10:13 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OEAA7l029234;
        Fri, 24 Jul 2020 14:10:12 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 07:10:10 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: fix_priv_head
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200724011720.GH31487@fieldses.org>
Date:   Fri, 24 Jul 2020 10:10:08 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7557A354-8396-448D-BFC5-CA5512A4516B@oracle.com>
References: <3799C9E0-DFF3-450C-A815-14BAFAC97EA8@oracle.com>
 <20200723193811.GG31487@fieldses.org>
 <94381D74-3563-4071-A0CF-4EC016744FEC@oracle.com>
 <20200724011720.GH31487@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240108
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 23, 2020, at 9:17 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Thu, Jul 23, 2020 at 04:23:05PM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Jul 23, 2020, at 3:38 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Thu, Jul 23, 2020 at 01:46:19PM -0400, Chuck Lever wrote:
>>>> Hi Bruce-
>>>>=20
>>>> I'm trying to figure out if fix_priv_head is still necessary. This
>>>> was introduced by 7c9fdcfb1b64 ("[PATCH] knfsd: svcrpc: gss:
>>>> server-side implementation of rpcsec_gss privacy").
>>>>=20
>>>> static void
>>>> fix_priv_head(struct xdr_buf *buf, int pad)
>>>> {
>>>>       if (buf->page_len =3D=3D 0) {
>>>>               /* We need to adjust head and buf->len in tandem in =
this
>>>>                * case to make svc_defer() work--it finds the =
original
>>>>                * buffer start using buf->len - =
buf->head[0].iov_len. */
>>>>               buf->head[0].iov_len -=3D pad;
>>>>       }
>>>> }
>>>>=20
>>>> It doesn't seem like unwrapping can ever result in a buffer length =
that
>>>> is not quad-aligned. Is that simply a characteristic of modern =
enctypes?
>>=20
>> And: how is it correct to subtract "pad" ? if the length of the =
content
>> is not aligned, this truncates it. Instead, shouldn't the length be
>> extended to the next quad-boundary?
>>=20
>>> This code is before any unwrapping.  We're looking at the length of =
the
>>> encrypted (wrapped) object here, not the unwrapped buffer.
>>=20
>> fix_priv_head() is called twice: once before and once after =
gss_unwrap.
>=20
> OK, sorry, I missed that.
>=20
>> There is also this adjustment, just after the gss_unwrap() call:
>>=20
>>        maj_stat =3D gss_unwrap(ctx, 0, priv_len, buf);
>>        pad =3D priv_len - buf->len;
>>        buf->len -=3D pad;
>>=20
>> This is actually a bug, now that gss_unwrap adjusts buf->len: =
subtracting
>> "pad" can make buf->len go negative.
>=20
> OK.  Looking at the code now....  I'm not sure I follow it, but I'll
> believe you.
>=20
> (But if we've been leaving buf->len too short, why hasn't that been
> causing really obvious test failures?)

Probably it's because the server's receive paths don't rely on buf->len
because they traditionally use svc_getnl() and friends, which change
the size of the head buffer but never update buf->len.

Shortening goes unnoticed until gss_unwrap sets buf->len to a value
that is 32 or more bytes smaller than priv_len. When an RPC message
is smaller than that difference, then "buf->len -=3D pad;" results
in an underflow.

A more accurate but dangerously short buf->len is the result of

=
https://lore.kernel.org/linux-nfs/159554608522.6546.6837849890434723341.st=
git@klimt.1015granger.net/T/#u

So, perhaps those two patches should be combined, since the first one
breaks the server.


>> I'd like to remove this code, but
>> I'd first like to understand how it will effect the code that follows
>> immediately after:
>>=20
>>        offset =3D xdr_pad_size(buf->head[0].iov_len);
>>        if (offset) {
>>                buf->buflen =3D RPCSVC_MAXPAYLOAD;
>>                xdr_shift_buf(buf, offset);
>>                fix_priv_head(buf, pad);
>>        }

So if one of those patches removes "pad =3D priv_len - buf->len;"
then the above code will break.

But I'm trying to see when it is possible for gss_unwrap to
return a head buffer that is not quad-aligned. Not coming up
with any such scenario.


--
Chuck Lever



