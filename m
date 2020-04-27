Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C101BA72F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2020 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgD0PDJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Apr 2020 11:03:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46522 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgD0PDJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Apr 2020 11:03:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RExD51175823;
        Mon, 27 Apr 2020 15:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ta0JDAotsCc+y5uhYw1nEsvstF8FaXwTW/+MeaPAlLk=;
 b=r4WiVilJuowAhq7MjJOlSMWXxFirU5owtw6IU1q3C116Dp7NPtfkBr2XxnxIt4MB/Gql
 wQRNNdIw+hiLskdfkdt773icn+Cq6Dy+u+SKXgHEPj2aNMDDlWlbQT2U0ovIehfVVCDf
 naJUfsvduQTVWrThUdPnyBj3/hOkQEHKwW/J+jQzIRe9gno/fE0g/xEX5A/MbhPUppnB
 Ltp1bMm0dnsK3bbmMUOFBNnk2Cw/FyKdy2AAvGvlDGa5h+YN2QVNHC/8MqPfCxVB0ncs
 kkumdxQ/2jEMghON019mAe58jtI9WOAnVB7jfaFpQtQ0p4ngxD6Sgr0F6UWiF5C+y+6i Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30p01ugnf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 15:02:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03REurIV172123;
        Mon, 27 Apr 2020 15:02:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30my09nuq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 15:02:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03RF2nHJ014129;
        Mon, 27 Apr 2020 15:02:51 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 08:02:49 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 0/3] Potential krb5p fix for 5.7-rc
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200420000639.3416.43270.stgit@klimt.1015granger.net>
Date:   Mon, 27 Apr 2020 11:02:48 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25A69616-3979-4081-B6A2-5B35A392E610@oracle.com>
References: <20200420000639.3416.43270.stgit@klimt.1015granger.net>
To:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270126
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 19, 2020, at 10:17 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> For review:
>=20
> The purpose of this series is to get the Linux NFS server's
> duplicate reply cache working again when the server is mounted via
> krb5p. Thus I would like to send these three commits via an
> nfsd-5.7-rc pull request in a couple of weeks, depending on review
> comments.
>=20
> The second patch is strictly a client-side fix, but it is necessary
> because the third patch causes problems on the client unless the
> first and second patches are applied first. Being a client-side
> change, the second patch needs an Acked-by from Trond or Anna so I
> can send a PR via the NFSD tree.

Wondering if I can get appropriate Reviewed-by and Acked-by for
these patches?


> I've tested this series by running "make -j12 test" in a freshly-
> built git source tree on an NFS mount. The test was run on a
> sequence of mounts using every combination of:
>=20
> - TCP and RDMA
> - NFSv3, NFSv4.0, NFSv4.1, and NFSv4.1
> - krb5p with a kerberos_v1 and kerberos_v2 encryption type
>=20
> For RDMA in particular, frequent GSS sequence number window overruns
> make the transport connection unstable -- typically over 3,000
> disconnects for a test run that takes about 30 minutes. A
> successful test run on an NFSv3 or NFSv4.0 mount point is therefore
> enough to demonstrate that the server's DRC is working properly.
>=20
> NFSv4.1+ is also tested to show that krb5p continues to work
> correctly for NFS minor versions that do not happen to use the
> server's DRC.
>=20
> ---
>=20
> Chuck Lever (3):
>      SUNRPC: Add "@len" parameter to gss_unwrap()
>      SUNRPC: Fix GSS privacy computation of auth->au_ralign
>      SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()")
>=20
>=20
> include/linux/sunrpc/gss_api.h      |  1 +
> include/linux/sunrpc/xdr.h          |  1 +
> net/sunrpc/auth_gss/auth_gss.c      |  8 +++-----
> net/sunrpc/auth_gss/gss_krb5_wrap.c | 26 +++++++++++++++--------
> net/sunrpc/auth_gss/svcauth_gss.c   |  2 +-
> net/sunrpc/xdr.c                    | 41 =
+++++++++++++++++++++++++++++++++++++
> 6 files changed, 65 insertions(+), 14 deletions(-)
>=20
> --
> Chuck Lever

--
Chuck Lever



