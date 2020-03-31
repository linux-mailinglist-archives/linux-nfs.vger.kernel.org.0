Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA335199D95
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2020 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgCaSBX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Mar 2020 14:01:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52008 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgCaSBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Mar 2020 14:01:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VHxX6x036173;
        Tue, 31 Mar 2020 18:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VsqCEtjj5Md5wBLezqFiNu+A2Tb4/B73IANBEKHxYrY=;
 b=J9UcvFnEwS6b2fNrGZ5KQ4SuED30C04SgRzGzLcCk6hAQIl+3xyTZRC/Bw5Dqj6cUdK/
 BOJogewY94Xq2+lsUl6Ag3L5KOJKF1RXLK1IVE+LV9k20/zuDyN0RCv129zDlAekoXh3
 Z3HwvWxhrrSDKtscyChKX3jYK7suuf+taexwCXgHj5oTP6mOzdu+kmnyYn4twAnv6J1S
 7uX2d3ZZI38/3Xx2lNb+E3UUhrGFNVWUqbcqxQwY1dDNJRHUNe21YLkAfXE4FM25GoNB
 Tjj8ad5C655wo47iANSVGPo6ijMW0U0yYijscdJVoX3nljqJyR4Mib3NwVL59iXkAuyF lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303cev13r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 18:01:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VHv1sW077057;
        Tue, 31 Mar 2020 17:59:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 302gcd8xjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 17:59:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02VHxCKb010335;
        Tue, 31 Mar 2020 17:59:13 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 10:59:12 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: refcount underflow in nfsd41_destroy_cb
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6A4BC0CB-9A2F-405B-A7F7-5BFDA4FAD8CB@oracle.com>
Date:   Tue, 31 Mar 2020 13:59:10 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jan Psota <jasiu@belsznica.pl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B4E0C1C-58FF-43EB-BF68-E96BB9DCE664@oracle.com>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
 <44C9D860-4F51-46B1-88A3-D10DDEF4BD8E@oracle.com>
 <20200322044352.2ff1fbd8.jasiu@belsznica.pl>
 <0C8A86EA-6015-4E9E-9A0E-DAEB4E988269@oracle.com>
 <20200323160919.021e6c8a.jasiu@belsznica.pl>
 <6A4BC0CB-9A2F-405B-A7F7-5BFDA4FAD8CB@oracle.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=974 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310153
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond, any thoughts?

> On Mar 24, 2020, at 9:50 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Trond,
>=20
>> On Mar 23, 2020, at 11:09 AM, Jan Psota <jasiu@belsznica.pl> wrote:
>>=20
>>> I thought I read in the initial report that you were seeing this
>>> problem only on v5.6-rc6. What is the earliest kernel release
>>> where you saw refcount UaF warnings from nfsd4_destroy_cb?
>>>=20
>> I didn't noticed that earlier too, because until connection breakage =
on
>> WireGuard I did not have any problems related. But when you are =
asking,
>> I found it in my Pentium G2020 system too since 5.5.4 kernel and =
5.4.2
>> looks not affected (I have logs since 01 Jan and fault begin to =
appear
>> on Feb 21, when I switched from 5.4.2 to 5.5.4 kernel a day before)
>>=20
>> $ journalctl | grep nfsd41_destroy_cb
>> lut 21 01:07:58 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> lut 27 01:01:12 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 03 00:59:01 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 03 23:03:02 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 11 11:52:42 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 13 01:12:02 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 14 14:31:39 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 15 20:56:56 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 17 15:58:32 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>> mar 22 15:24:03 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
>>=20
>> I attach NFS part of my .config and a screen dump of menuconfig.
>> <nfs.config><nfs-config.txt>
>=20
> I'm wondering if
>=20
> 2bbfed98a4d8 ("nfsd: Fix races between nfsd4_cb_release() and =
nfsd4_shutdown_callback()")
>=20
> or
>=20
> 12357f1b2c8e ("nfsd: minor 4.1 callback cleanup")
>=20
> might be related to this issue (see down-thread for details and =
backtraces).
>=20
> --
> Chuck Lever

--
Chuck Lever



