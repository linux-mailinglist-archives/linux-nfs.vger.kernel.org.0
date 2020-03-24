Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776E7191204
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 14:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCXNv3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 09:51:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgCXNv3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Mar 2020 09:51:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ODiEwq117779;
        Tue, 24 Mar 2020 13:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=TMKn8p2QkdOEEOovsRTfA80kmULbmEVaHscf1Q24bDo=;
 b=m+1neoNm1lpcju8E4I4RI+C9wUbv6umKkpqiQDKUndE80S179Owc4rdhw+g5Hw1M07i8
 Tu+DSpF6HNjCXuenctRDWSNWYdcTA+IVcgvXVvteLPmfgyNWqbm6uA3RMbBh4RFNq399
 rtgQWd2wDNFZyGiWywzXSIHeu31gxdka559XF5iV7KwuWaKfxSGdiF3VzLqJ7GbGQ0N3
 oSV5/xHDPx5c7dIYs2rf6Iwd8ODPtb181aJt/juddZ48Eplm/RxC3QKKqTsyr9uoU9d6
 JUyEopUAZBxnc9F5UxJlANTOU/v/nc+f1SrCJx1zvy2Q3V5jtNsjiMGVS6tIQucNxnqN dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yx8ac1bg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:51:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ODnrNO180558;
        Tue, 24 Mar 2020 13:51:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2yxw92pj6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:51:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ODp05u020554;
        Tue, 24 Mar 2020 13:51:01 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 06:51:00 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: refcount underflow in nfsd41_destroy_cb
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200323160919.021e6c8a.jasiu@belsznica.pl>
Date:   Tue, 24 Mar 2020 09:50:59 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jan Psota <jasiu@belsznica.pl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A4BC0CB-9A2F-405B-A7F7-5BFDA4FAD8CB@oracle.com>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
 <44C9D860-4F51-46B1-88A3-D10DDEF4BD8E@oracle.com>
 <20200322044352.2ff1fbd8.jasiu@belsznica.pl>
 <0C8A86EA-6015-4E9E-9A0E-DAEB4E988269@oracle.com>
 <20200323160919.021e6c8a.jasiu@belsznica.pl>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240074
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond,

> On Mar 23, 2020, at 11:09 AM, Jan Psota <jasiu@belsznica.pl> wrote:
>=20
>> I thought I read in the initial report that you were seeing this
>> problem only on v5.6-rc6. What is the earliest kernel release
>> where you saw refcount UaF warnings from nfsd4_destroy_cb?
>>=20
> I didn't noticed that earlier too, because until connection breakage =
on
> WireGuard I did not have any problems related. But when you are =
asking,
> I found it in my Pentium G2020 system too since 5.5.4 kernel and 5.4.2
> looks not affected (I have logs since 01 Jan and fault begin to appear
> on Feb 21, when I switched from 5.4.2 to 5.5.4 kernel a day before)
>=20
> $ journalctl | grep nfsd41_destroy_cb
> lut 21 01:07:58 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> lut 27 01:01:12 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 03 00:59:01 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 03 23:03:02 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 11 11:52:42 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 13 01:12:02 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 14 14:31:39 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 15 20:56:56 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 17 15:58:32 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
> mar 22 15:24:03 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>=20
> I attach NFS part of my .config and a screen dump of menuconfig.
> <nfs.config><nfs-config.txt>

I'm wondering if

2bbfed98a4d8 ("nfsd: Fix races between nfsd4_cb_release() and =
nfsd4_shutdown_callback()")

or

12357f1b2c8e ("nfsd: minor 4.1 callback cleanup")

might be related to this issue (see down-thread for details and =
backtraces).

--
Chuck Lever



