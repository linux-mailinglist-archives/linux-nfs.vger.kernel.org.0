Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1845E2C5A70
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 18:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404330AbgKZRVb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 12:21:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40600 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgKZRVb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Nov 2020 12:21:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AQHEaW5077879;
        Thu, 26 Nov 2020 17:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FjUk2p6yoO4TTcl1GyhKhP517h1UhqfFBMAP0o1N4lU=;
 b=Cg1sTOOutRFGixVhGGgkjieMk4j9LZWVM7WqF+6j+5TEnceOsRTzJGZTDP7XlfG65eYW
 DHmVrDqFgPlS0xCGhcRblb+fw4f0Qhz8nP3fBlNS0WEndKbdwXQR0UEHXJNOr7Fjyg1O
 bW4e+zGAWoic4/RfIzst05sCVst7AJhyTKVpZFBUcgnxKGa67Dm4F85cNtLgEi45cMH2
 amHzJCDgyoWLHZWcKtJ0HJ6W8RqHGofjyPW4B5SSJbz9s3Knla6PafGkb4gxwioUu6UA
 OccJ2sBFZh3iHdIrrfIs7dTefEm7Eh+dTskn1hbR49jgDrECG/olDzzAEDughKafg9dy mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 351kwhptcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Nov 2020 17:21:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AQHK1aD168681;
        Thu, 26 Nov 2020 17:21:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 351kwgxw10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 17:21:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AQHLKPl017603;
        Thu, 26 Nov 2020 17:21:20 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Nov 2020 09:21:20 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: NFS v3 soft mount semantics affected by commit ce368536d
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <dc888c162b3a30cd1c617072ae606d9d8c6d42f3.camel@hammerspace.com>
Date:   Thu, 26 Nov 2020 12:21:18 -0500
Cc:     "dan@kernelim.com" <dan@kernelim.com>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA32469D-6897-4444-898B-01E7530E2CE0@oracle.com>
References: <20201126104712.GA4023536@gmail.com>
 <dc888c162b3a30cd1c617072ae606d9d8c6d42f3.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011260107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260106
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 26, 2020, at 8:48 AM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Thu, 2020-11-26 at 12:47 +0200, Dan Aloni wrote:
>> Hi Scott, Trond,
>>=20
>> Commit ce368536dd614452407dc31e2449eb84681a06af ("nfs:
>> nfs_file_write()
>> should check for writeback errors") seems to have affected NFS v3
>> soft
>> mount behavior, causing applications to fail on a slow band
>> connection
>> with a properly functioning server. I checked this with recent Linux
>> 5.10-rc5, and on 5.8.18 to where this commit is backported.
>>=20
>> Question: while the NFS v4 protocol talks about a soft mount timeout
>> behavior at "RFC7530 section 3.1.1" (see reference and patchset
>> addressing it in [1]), is it valid to assume that a similar guarantee
>> for NFS v3 soft mounts is expected?
>>=20
>> The reason why it is important, is because the fulfilment of this
>> guarantee seemed to have changed with this recent patch.
>>=20
>> Details on reproduction - using the following mount option:
>>=20
>>   =20
>> vers=3D3,rsize=3D1048576,wsize=3D1048576,soft,proto=3Dtcp,timeo=3D50,re=
trans=3D16
>=20
> Sorry, but those are completely silly timeo and retrans values for a
> TCP connection. I see no reason why we should try to support them.

Indeed. Is there a reason to allow administrators to set these values?


>> This is done along with rate limiting on the outgoing interface:
>>=20
>>     tc qdisc add dev eth0 root tbf rate 4000kbit latency 1ms burst
>> 1540
>>=20
>> And performing following parallel work on the mountpoint:
>>=20
>>     for i in `seq 1 100` ; do (dd if=3D/dev/zero of=3Dx$i &) ; done
>>=20
>> Result is that EIOs are returned to `dd`, whereas without this commit
>> the IOs simply performed slowly, and no errors observed by dd. It
>> appears in traces that the NFS layer is doing the retries.
>>=20
>> [1] =20
>> =
https://patchwork.kernel.org/project/linux-nfs/cover/20190328205239.29674-=
1-trond.myklebust@hammerspace.com/
>>=20
>=20
> Yes. If you artificially create congestion by telling the client to
> keep resending all your outstanding data every 5 seconds, then it is
> trivial to set up this kind of situation. That has always been the
> case, and the patch you point to has nothing to do with this.
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



