Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4489FE098
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfKOOzn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 09:55:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44636 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfKOOzm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 09:55:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFEs3pL077815;
        Fri, 15 Nov 2019 14:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Ovl5DbMbzct1Sd8VaRK4t0n3j7ODUKZmqRwlqS5xrqg=;
 b=hHDrPyzhCTQvjc0WFHlWek+sksgvhLj4n/C8jnc0ySOFhXjTAg2+nwIVfaA5d1Vt+IUi
 rYE7TcYTmwWRt28Q0Uxo4BZ5KOIoSdqUJgSz+5DXwcZi0/BXlr7EsCt4cqx0zZHxoZi3
 nrUVeQtumK8gE7sJ9qrWB4LXCalI5TQexVgAZzI5Ro8ScnBrymmtKsepjwL43QGoChGJ
 qH6QrB95RIYhS4C6myZOpgR4xSQvxZvVz5zKpQ4SpCyf8PjlrI7DCzm3Uan/NHteBZrN
 4oFlmzqaIl+KI871oiMkIMp9VXH1pBGrFBhYBbaERUfOJOTkdp7URhXVPAk06Zo64W91 dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w9gxpkr21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 14:55:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFEsA9S193553;
        Fri, 15 Nov 2019 14:55:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w9h0measq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 14:54:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFEsIOk028793;
        Fri, 15 Nov 2019 14:54:18 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 06:54:18 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <123CB75B-F40C-45C4-9754-1C825782E4A3@redhat.com>
Date:   Fri, 15 Nov 2019 09:54:16 -0500
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6ABDC14-512F-4872-8D43-904F9E808AAA@oracle.com>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
 <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
 <F23BF77A-5CB4-455F-8F23-C92EE2AB5212@oracle.com>
 <29A5981F-5109-489E-913E-B80B6252B115@oracle.com>
 <123CB75B-F40C-45C4-9754-1C825782E4A3@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 15, 2019, at 9:51 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> On 15 Nov 2019, at 9:44, Chuck Lever wrote:
>=20
>>> On Nov 15, 2019, at 9:41 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On Nov 15, 2019, at 9:35 AM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>>>>=20
>>>> On 15 Nov 2019, at 8:39, Chuck Lever wrote:
>>>>=20
>>>>> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
>>>>> This can happen when xdr_buf_read_mic() is given an xdr_buf with
>>>>> a small page array (like, only a few bytes).
>>>>=20
>>>> Hi Chuck,
>>>>=20
>>>> Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how =
this can
>>>> happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf =
has bug?
>>>=20
>>> rpc_prepare_reply_pages() sets buf->page_len to the args->count of =
the
>>> NFS READ request. For really small READs, this can be 2, or 12, or
>>> anything smaller than the MIC length.
>>>=20
>>>=20
>>>> I'd prefer to keep the BUG_ON.
>>>=20
>>> Linus would prefer not to. :-)
>=20
> Ahh..
>=20
>>>=20
>>>=20
>>>> How can I reproduce it?
>>>=20
>>> I've been using the git regression suite with NFSv4.1 and krb5i.
>>> I run it with 12 threads.
>>=20
>> And I enable disconnect injection. Yer basic torture test.
>=20
> Thanks.. I'll try.

I'm not sure why the issue doesn't show up without disconnect injection.
Could be that a few of the READs fail, and thus return no data?


--
Chuck Lever



