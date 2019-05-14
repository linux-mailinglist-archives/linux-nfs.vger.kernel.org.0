Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547331C800
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2019 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENLwC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 May 2019 07:52:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENLwC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 May 2019 07:52:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EBhxv1015580;
        Tue, 14 May 2019 11:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=OrRVOy5pLlymRQWYRUNvOhuOL/PUgV3tZthxHBLBOU4=;
 b=liwinhBBQa64+No5kavqnncQYZrorG91GLnxyMhZRrg9mVCuU+e4mCB0h7TFNBf5wrwW
 1ihORKUCdHGgSa1+leOBdIV2/TvGgTrTaB+leb6+pxk/gAZ8OSAXY1TQFgKkgShU8T1g
 bPHvaCtsHGObZxE4xQWNm/SovBcJwz0oBu7s5ecA9+dreMk2I0l+c6XmYuhXLhw+TwuC
 Sc0aOPjwH+tbslW7Nd+8a7DElI5D8cGVJqJCX6HuNd+tH72OknrXYX/Ui1v95pg2sYms
 bECeRN6LOd9T3rK7+wSVbniHuNuhbpQ2wabSErsavl9dqjilV6ngHQE2C4oYROX96jOr HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sdnttnbjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 11:51:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EBoFW5046939;
        Tue, 14 May 2019 11:51:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2sf3cn70xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 11:51:56 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4EBpssG028379;
        Tue, 14 May 2019 11:51:55 GMT
Received: from dhcp-239.nfsv4bat.org (/172.56.10.94)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 04:51:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Bug report: rpc.mountd segv due to commit
 8f459a072f93458fc2198ce1962b279164aa9059 Remove abuse of ai_canonname
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALUOdrwv6RHwFCbPBmsZfY0o_18cP_o-y7Sj_O4OfEKK1MxEfw@mail.gmail.com>
Date:   Tue, 14 May 2019 07:51:56 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B254CB53-1AA8-4A16-BA48-C8E719CB3450@oracle.com>
References: <CALUOdrwv6RHwFCbPBmsZfY0o_18cP_o-y7Sj_O4OfEKK1MxEfw@mail.gmail.com>
To:     Mark Wagner <mark@lanfear.net>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140087
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140087
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2019, at 6:24 PM, Mark Wagner <mark@lanfear.net> wrote:
>=20
> (gdb) run -F
> Starting program: /usr/sbin/rpc.mountd -F
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> rpc.mountd: Version 2.3.4 starting
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000555555564921 in DoMatch (text=3D0x0, p=3D0x5555555af100
> "knode*.lanfear.net") at wildmat.c:75
> 75      wildmat.c: No such file or directory.
> (gdb) bt
> #0  0x0000555555564921 in DoMatch (text=3D0x0, p=3D0x5555555af100
> "knode*.lanfear.net") at wildmat.c:75
> #1  0x0000555555564b69 in wildmat (text=3Dtext@entry=3D0x0,
> p=3Dp@entry=3D0x5555555af100 "knode*.lanfear.net") at wildmat.c:140
> #2  0x000055555555e9ab in check_wildcard (clp=3D<optimized out>,
> ai=3D<optimized out>) at client.c:616
> #3  client_check (ai=3D<optimized out>, clp=3D<optimized out>) at =
client.c:740
> #4  client_check (clp=3D<optimized out>, ai=3D<optimized out>) at =
client.c:732
> #5  0x000055555555edb4 in client_compose (ai=3Dai@entry=3D0x5555555ac830=
)
> at client.c:417
> #6  0x000055555555c0f3 in auth_unix_ip (f=3D3) at cache.c:115
> #7  0x000055555555d95a in cache_process_req
> (readfds=3Dreadfds@entry=3D0x7fffffffdc90) at cache.c:1417
> #8  0x000055555555de28 in my_svc_run () at svc_run.c:118
> #9  0x000055555555941a in main (argc=3D<optimized out>, =
argv=3D<optimized
> out>) at mountd.c:892
>=20
> The commit message says "There is only one caller to
> host_reliable_addrinfo() that actually uses the string in
> ai->ai_canonname, and then only for debugging messages. Change those
> to display the IP address instead."
>=20
> That is not quite right. ./support/export/client.c check_wildcard()
> uses ai_canonname:
>=20
> static int
> check_wildcard(const nfs_client *clp, const struct addrinfo *ai)
> {
>        char *cname =3D clp->m_hostname;
>        char *hname =3D ai->ai_canonname;
> ...
>=20
> Kernel versions:
> server: 5.0.10-gentoo
> client: 5.0.10-200.fc29.x86_64
>=20
> nfs-utils version: 2.3.4
>=20
> "Are you using any of the security options?" No.
>=20
> exportfs -v
> /usr/local/k8s
> =
knode*.lanfear.net(sync,wdelay,hide,no_subtree_check,sec=3Dsys,rw,secure,n=
o_root_squash,no_all_squash)

Hi Mark-

Thanks for the report. Your analysis seems plausible.
I'll have a look at this today.


--
Chuck Lever



