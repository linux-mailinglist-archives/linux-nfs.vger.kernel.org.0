Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09392E9671
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 14:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhADN5O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 08:57:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbhADN5N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 08:57:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104Dsvm9164794;
        Mon, 4 Jan 2021 13:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=UlFPkz4XgtcQ97pNFFgxsVLeC26rPzQnkHkhRRv6Xjg=;
 b=YZVbY2rZQqANTCAW1MisEYL+OVDYOC3FgtlK0y7jDkvQ7sJ8zybusr6ndRiFDJ9Yi/Oc
 FtbIAAhS4uisebniEoT/QezoCZYuesvlAPno08Xo+xddlLFqI2rXf3iNZLr+CgwWsQ8s
 43RB2h1WMiiRoRpWpXGarbhFuNXRaIv/DFfNPk1oS/t7M+bq/Wj0JttO8krD9ZVSRtIF
 5NRz85aLeeSTnVQbDfMbjex2Je/zg0CaEGScIOJGRMw6YA6hPvDx+71ilBrfaSzmsGs0
 wpVmSn2G0LJkBrGUHtam8Srcqf5pznhVwA2NjG8atzGebvljuaSvCDFyyFf5rIqaXDRg fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35tgskmbag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 13:56:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104DuKAq134471;
        Mon, 4 Jan 2021 13:56:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35v23x47y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 13:56:29 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104DuSQH002609;
        Mon, 4 Jan 2021 13:56:28 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 05:56:28 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [nfsv4] virtual/permanent bakeathon infrastructure
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <85C06BBD-2861-4CDE-BCED-ACD974560D3A@redhat.com>
Date:   Mon, 4 Jan 2021 08:56:27 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <72FFA566-311D-4826-9F4A-29AE0F379327@oracle.com>
References: <85C06BBD-2861-4CDE-BCED-ACD974560D3A@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9853 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040090
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 4, 2021, at 8:46 AM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> How are folks feeling about throwing time at a virtual bakeathon?  I =
had
> some ideas about how this might be possible by building out a virtual
> network of OpenVPN clients, and hacked together some infrastructure to =
make
> it happen:
>=20
> https://vpn.nfsv4.dev/

My colleague Bill Baker has suggested we aren't going to get the
rest of the way there until we have an actual event; ie, a moment
in time where we drop our everyday tasks and focus on testing.

So, I'm all for a virtual event.

We could pick a week, say, the traditional week of Connectathon
at the end of February.


> That network exists today, and any systems that are able to join it =
can use
> it to test.  There are a number of problems/complications:
>    - the private network is ipv6-only by design to avoid conflicts =
with
>      overused ipv4 private addresses.
>    - it uses hacked-together PKI to protect the TLS certificates =
encrypting
>      the connections
>    - some implementations of NFS only run on systems that cannot run
>      OpenVPN software, requiring complicated routing/transalations
>    - it needs to be re-written from bash to something..  less bash.
>    - network latencies restrict testing to function; testing =
performance
>      doesn't make sense.

And the only RDMA testing we can do is iWARP, which excludes some
NFS/RDMA implementations.


> With the ongoing work on NFS over TLS, my thought now is that if there =
is
> interest in standing up permanent infrastructure for testing, then =
that's
> probably sustainable way forward.  But until implementations mature, =
its not
> going to help us host a successful testing event in the near future.

The community does need to integrate TLS testing into these events.
However at the moment, there are only a very few implementations. I
don't feel comfortable relying on RPC-over-TLS for general testing
yet.


> So, the second question -- should we instead work towards =
implementations of
> NFS over TLS as a way of creating a more permanent testing =
infrastructure?

Yes, but given how far away that reality is, we shouldn't delay our
regular testing with the infrastructure you've set up already.


> I am aware that I am leaving out a lot of detail here in order to try =
to
> start a conversation and perhaps coalesce momentum.
>=20
> Happy new year!
> Ben
>=20
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4

--
Chuck Lever



