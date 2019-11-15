Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138D3FE207
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfKOPvu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 10:51:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOPvu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 10:51:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFFd8SQ090841;
        Fri, 15 Nov 2019 15:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=pQjwFA2nHq4A9U13qeGbTFwz4gFMS/EPfgS3sp48oIU=;
 b=YIWxztpcNAyw4HFYiwfLVRBAHMkY8I9ZFT6l79BIkXdbcuUXFoNB2lRvi/HUmUBhiSmu
 GB4iV+KHItslpjNdbc5AsUeRM/zoxx4psSVjHmua9dgbfqNFEy5Bb1v/TUvvVScbrQ44
 32ZB5getZu15oJ4fXLtCfPezi+1XYTqYY/IaEsWT071GspcIiZ3IrRL0UFg40DLtoLis
 lCXNGM61J7Qh+lnqoCXr06pQrd3l8GUnudz+YNX8BKj1ypgN7oK8BOBVymntPB2n6dxh
 p5ixkJHMcDpk4PaYjfawGmV4yKgmUdxTYJqzjrF3fDLxcDe+22nzlqysY0LT5VPYt0sV 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w9gxpm1we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 15:51:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFFhktl124348;
        Fri, 15 Nov 2019 15:51:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w9h0mqkf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 15:51:44 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFFphYI027584;
        Fri, 15 Nov 2019 15:51:44 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 07:51:43 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] SUNRPC: Fix another issue with MIC buffer space
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
Date:   Fri, 15 Nov 2019 10:51:42 -0500
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D8E4C6F0-FBEC-46D8-9202-96F9530D445E@oracle.com>
References: <20191115133907.15900.51854.stgit@manet.1015granger.net>
 <5CD994B4-61B0-4C76-BBB5-BE824AE955B4@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150142
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 15, 2019, at 9:35 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> On 15 Nov 2019, at 8:39, Chuck Lever wrote:
>=20
>> xdr_shrink_pagelen() BUG's when @len is larger than buf->page_len.
>> This can happen when xdr_buf_read_mic() is given an xdr_buf with
>> a small page array (like, only a few bytes).
>=20
> Hi Chuck,
>=20
> Seems like a bug in xdr_buf_read_mic to me, but I'm not seeing how =
this can
> happen.. unless perhaps xdr->page_len is 0?  Or maybe xdr_shift_buf =
has bug?
>=20
> I'd prefer to keep the BUG_ON.  How can I reproduce it?
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 14ba9e72a204..71d754fc780e 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1262,6 +1262,8 @@ int xdr_buf_read_mic(struct xdr_buf *buf, struct =
xdr_netobj *mic, unsigned int o
>        if (offset < boundary && (offset + mic->len) > boundary)
>                xdr_shift_buf(buf, boundary - offset);
>=20
> +       trace_printk("boundary %d, offset %d, page_len %d\n", =
boundary, offset, buf->page_len);
> +

Btw, I did some troubleshooting with a printk in here a couple days ago:

xdr_buf_read_mic: offset=3D136 boundary=3D142 buf->page_len=3D2


>        /* Is the mic partially in the pages? */
>        boundary +=3D buf->page_len;
>        if (offset < boundary && (offset + mic->len) > boundary)
>=20
> ^^ that should be enough for me to try to figure out what's doing =
wrong.
>=20
> Ben
>=20

--
Chuck Lever



