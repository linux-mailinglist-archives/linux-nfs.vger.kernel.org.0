Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D423712198F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLPS6v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:58:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33972 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfLPS6v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 13:58:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGIsFl9100289;
        Mon, 16 Dec 2019 18:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=NhpTFUpVaSqwOFai7Eue2o+ccU1k68md94uDlBIiv3Q=;
 b=kBQyrl2j5rDFKezPL0afJWZQdA5D6h/PDueWIOAdzRBsu6nH1C+V//2iWhxWsJGIE45q
 yMG2WX1nPuXO5hH3j0X/+x9fCk7iWNoPuCROfuNlcIpzUPpHH8lHOC9l9p7yOd2hPIHx
 Htvz+urgbLvRM/zeVqz+DhNY8qF+mFXVtb+8zCMU9UqoiZkfh6BNWNbuc+45tg/lM2KF
 2vSx50D4DISTRpX9pk2GPBz3QOqFjHOoQmL/gX1gto8+Nz7TdariMF/gYgAbBLw2a0wd
 uhu4WYXWg+d8akf2qYkrYGM2wYGC90F9DTB+6z3d+CFVXVmDYU7CfD1eoUmmV5NifuEx Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wvrcr1gmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 18:58:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBGIsBKJ114480;
        Mon, 16 Dec 2019 18:58:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ww98srks2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Dec 2019 18:58:44 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBGIwg2u022332;
        Mon, 16 Dec 2019 18:58:43 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Dec 2019 10:58:42 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease
 renewals
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <05ea01d5b440$bd9d58d0$38d80a70$@gmail.com>
Date:   Mon, 16 Dec 2019 13:58:41 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF0DEDD8-9930-4E90-B49F-CBC8C759831D@oracle.com>
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com>
 <dea30ea3f0fc31e40b311c4d110c26cf40658dca.camel@hammerspace.com>
 <05ea01d5b440$bd9d58d0$38d80a70$@gmail.com>
To:     Robert Milkowski <rmilkowski@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912160160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912160160
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 16, 2019, at 1:43 PM, Robert Milkowski <rmilkowski@gmail.com> =
wrote:
>=20
>=20
>=20
>> From: Trond Myklebust <trondmy@hammerspace.com>=20
> ...
>> NACK. The above argument only applies to legacy minor version 0 =
setups, and does not apply to NFSv4.1 or newer.
>=20
> Correct. However many sites still use v4.0.

v4.1 and newer actually do renew the lease with the FSINFO COMPOUND,
since the COMPOUND starts with a SEQUENCE operation.

For v4.0, you can get the equivalent behavior by adding a RENEW to
the end of the FSINFO COMPOUND.


--
Chuck Lever



