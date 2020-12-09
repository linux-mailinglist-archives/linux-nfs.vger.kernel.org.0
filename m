Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269022D4657
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgLIQID (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 11:08:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35878 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgLIQID (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 11:08:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9G5e0U130697;
        Wed, 9 Dec 2020 16:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ZL8GLIdLZcxI2FettzRrm97O6k9vCAL3fLh43d6Q2xg=;
 b=r+AScEgSDxthnYxW7kwmvx5QlS1hZgBzq6tAvtGsGtC1HUBmU2AwpVnLwH1/A4EDYKYn
 ujxW7zi4pFNs5tN89Tphe4oQiXr1MTcRh33tQzv8Vbj+1NjYv5f+SuiEvvGRZuuCemQ5
 Y6l7OYXsbO6lsfyLalXTnmEfRN9uvi6Ilxq7BFAgCc/wD13vhzs5JhcyyIc7OjFWj4Ha
 TdPQe/o6GhIUqGIPBOrGXU8kJpWO2KePYOZRWUZCWX9KjBvSzEf0R5b6Gz50gktqBWOM
 wCYHxOiWmIOyFodfJCxVRFmj9+43DL6h/cJTz8k3Fi8cgivIPa1BXMOm84J81yflWC1F gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825m8ygg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 16:07:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9G0h2M076508;
        Wed, 9 Dec 2020 16:05:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 358kyuw665-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 16:05:20 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9G5Jqe005048;
        Wed, 9 Dec 2020 16:05:19 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 08:05:19 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 1/2] SUNRPC: Keep buf->len in sync with xdr->nwords
 when expanding holes
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAFX2JfkNO9LL_iaRE_RGjP+BHKiZGk8Eedg88_MKkuZUAysThw@mail.gmail.com>
Date:   Wed, 9 Dec 2020 11:05:18 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AE085D3-7DA3-4CC3-B9F9-F9A5D6A718B2@oracle.com>
References: <20201208202925.597663-1-Anna.Schumaker@Netapp.com>
 <20201208202925.597663-2-Anna.Schumaker@Netapp.com>
 <2A6797DD-246D-4994-B38C-57AA0196D061@oracle.com>
 <CAFX2JfkNO9LL_iaRE_RGjP+BHKiZGk8Eedg88_MKkuZUAysThw@mail.gmail.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090112
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 8, 2020, at 4:11 PM, Anna Schumaker <schumaker.anna@gmail.com> =
wrote:
>=20
> On Tue, Dec 8, 2020 at 3:56 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Dec 8, 2020, at 3:29 PM, schumaker.anna@gmail.com wrote:
>>>=20
>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>=20
>>> Otherwise we could end up placing data a few bytes off from where we
>>> actually want to put it.
>>>=20
>>> Fixes: 84ce182ab85b "SUNRPC: Add the ability to expand holes in data =
pages"
>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>> ---
>>> net/sunrpc/xdr.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
>>> index 71e03b930b70..5b848fe65c81 100644
>>> --- a/net/sunrpc/xdr.c
>>> +++ b/net/sunrpc/xdr.c
>>> @@ -1314,6 +1314,7 @@ uint64_t xdr_expand_hole(struct xdr_stream =
*xdr, uint64_t offset, uint64_t lengt
>>>              unsigned int res =3D _shift_data_right_tail(buf, from + =
bytes - shift, shift);
>>>              truncated =3D shift - res;
>>>              xdr->nwords -=3D XDR_QUADLEN(truncated);
>>> +             buf->len -=3D 4 * XDR_QUADLEN(truncated);
>>=20
>> If I understand what you're doing here correctly, the usual idiom
>> is "XDR_QUADLEN(truncated) << 2" .
>=20
> Oh, that works too. I'll adjust the patch. Thanks for letting me know!
>=20

Urp, sorry. These days, the preferred mechanism is xdr_align_size().
Old habits die hard, I guess.


> Anna
>=20
>>=20
>>=20
>>>              bytes -=3D shift;
>>>      }
>>>=20
>>> @@ -1325,7 +1326,7 @@ uint64_t xdr_expand_hole(struct xdr_stream =
*xdr, uint64_t offset, uint64_t lengt
>>>                                      bytes);
>>>      _zero_pages(buf->pages, buf->page_base + offset, length);
>>>=20
>>> -     buf->len +=3D length - (from - offset) - truncated;
>>> +     buf->len +=3D length - (from - offset);
>>>      xdr_set_page(xdr, offset + length, PAGE_SIZE);
>>>      return length;
>>> }
>>> --
>>> 2.29.2
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



