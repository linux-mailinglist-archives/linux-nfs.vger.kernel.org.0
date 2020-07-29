Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B95232496
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2S1Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 14:27:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2S1Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 14:27:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TIBmvA162266;
        Wed, 29 Jul 2020 18:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=QPS/TUTR+kC6odMIVr0zyAIkY5OmTXomIoGlZP8bw2g=;
 b=uaTtGt6LRvWDvFCP7LPU8wsIKOjvQMoVvnEZr0hpBK054NfVKFyc8iTGjtUYECG//mrW
 rT6lYUcfwFrex5vGzzZpt2Ft4E1WInMp2tOcpucLM67BKvR4U+vDk7FYkoyY7aBkdTo3
 gJ+FFNIxJ1f53oMeXQ6YB4xqGGYwfNQjP8DhfF2O05oPWzAWDA3HZIhVzIvhF+9WTVo7
 FYPrLASuQ6CR1nFOjh94Uo7e/y3aaHbug6YUTKTotbXxsDGf6QdH9CIWYt27cUfzSA9a
 PWBLDbeiDYIW/1LeHNrHb0W85ea/oaj7q6KFgLdUynUddsRz07C//JdJz2VK6VIeX3VE 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32hu1jq9w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 18:27:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TICd2B186422;
        Wed, 29 Jul 2020 18:27:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32hu5vbeqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 18:27:19 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06TIRHvf008918;
        Wed, 29 Jul 2020 18:27:18 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 11:27:17 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Fedora 32 rpc.gssd misbehavior
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
Date:   Wed, 29 Jul 2020 14:27:14 -0400
Cc:     Simo Sorce <simo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290124
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Hi!
>=20
> I recently updated my test systems from EL7 to Fedora 32, and
> NFSv4.0 with Kerberos has stopped working.
>=20
> I mount with "klimt.ib" as before. The client workload stops
> dead when the server tries to perform its first CB_RECALL.
>=20
> I added some client instrumentation:
>=20
>   kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) =
does not match acceptor (nfs@klimt.ib).
>   kernel: NFS: NFSv4 callback contains invalid cred
>=20
> I boosted gssd verbosity, and it says:
>=20
>   rpc.gssd[986]: doing downcall: lifetime_rec=3D72226 =
acceptor=3Dnfs@klimt.ib
>=20
> But it knows the full hostname for the server:
>=20
>   rpc.gssd[986]: Full hostname for 'klimt.ib' is =
'klimt.ib.1015granger.net'
>=20
>=20
> The acceptor appears to come from the Kerberos library. Shouldn't
> it be canonicalized? If so, should the Kerberos library do it, or
> should gssd? Since this behavior appeared after an upgrade, I
> suspect a Kerberos library regression. But it could be config-
> related, since both systems were re-imaged from the ground up.
>=20
> Also noticing some other problems on the server (missing hostname
> strings in debug messages, sssd_kcm infinite loops, and gssd
> sending garbage to the client after the NULL request that
> establishes the callback context).
>=20
> But let's look at the client acceptor problem first.

I believe I found the problem.

8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of gssd =
config
options to /etc/nfs.conf, including "avoid-dns". The default setting of =
avoid-
dns is 1. When I set this option on my client system explicitly to 0, =
NFSv4.0
with Kerberos works again.

Is there a reason the default setting is 1?


--
Chuck Lever



