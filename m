Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D307276478
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 01:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIWX30 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 19:29:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWX30 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 19:29:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NNTPsB141999
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 content-transfer-encoding : from : mime-version : subject : date :
 message-id : references : cc : in-reply-to : to; s=corp-2020-01-29;
 bh=pKBgUaUSo93EEhbT2s2PSYnKYEtDjOiuJzWa9wc6pps=;
 b=rPBbab0rNsmAZIG2Iyc1WdkehrFIUmf6sSwnVDVWP7DK/hsxJ4a/snzeU0sNyhM5K4mi
 xmH0TTQO8Baqv1lgNol6S0TkWVTQGBD4Hap/BCFIF5eqfTXWMspsIRJqS7u4zLzZQM/7
 qDfGK1imIWhCwqaImgJVd18+v01mvbeQAzlZIZn49WaBLuDjuMINNnoPOFIR2jCcIoa2
 yoKUkMMAlk7qjiF0Co79Gco7DtIIbIda01TKtPkOr8h5lly8SmN3PVlsCbY3oklDIB1I
 6hJ2Fw8pf7Maou7ZyDXlLl+GxtWn0QsLHzWh5x/+SM403Gs0XXWNHqi25swY3WGCn7hJ PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgkmyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:29:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NNPfrp052754
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:29:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33nux1vkfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:29:24 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08NNTNm2009698
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:29:23 GMT
Received: from localhost.localdomain (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 16:29:23 -0700
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Chuck Lever <chuck.lever@oracle.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
Date:   Wed, 23 Sep 2020 19:29:21 -0400
Message-Id: <3DC24A5C-81BB-4F70-B123-3A737DB10F81@oracle.com>
References: <20200923230606.63904-1-dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
In-Reply-To: <20200923230606.63904-1-dai.ngo@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
X-Mailer: iPad Mail (18A373)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230178
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dai, the tables are still backwards! =F0=9F=98=84

--
Chuck Lever

> On Sep 23, 2020, at 7:06 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> =EF=BB=BFThis patch provides a temporarily relief for inter copy to work w=
ith
> some common configs.  For long term solution, I think Trond's suggestion
> of using fs/nfs/nfs_common to store an op table that server can use to
> access the client code is the way to go.
>=20
> fs/nfsd/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20
> Below are the results of my testing of upstream mainline without and with t=
he fix.
>=20
> Upstream version used for testing:  5.9-rc5
>=20
> 1. Upstream mainline (existing code: NFS_FS=3Dy)
>=20
>=20
> |-------------------------------------------------------------------------=
---------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                    =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    y     |    m     | Build errors: nfs42_ssc_open/close       =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    m     |    m     | Build OK, inter server copy failed with N=
FS4ERR_STALE   |
> |        |          |          | See NOTE1.                               =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with N=
FS4ERR_STALE   |
> |        |          |          | See NOTE2.                               =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    y     |    y     | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
>=20
>=20
> |-------------------------------------------------------------------------=
---------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                    =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    y     |    m     | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    m     |    m     | Build OK, inter server copy failed with N=
FS4ERR_STALE   |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    m     |   y (m)  | Build OK, inter server copy failed with N=
FS4ERR_STALE   |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    y     |    y     | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
>=20
> 2. Upstream mainline (with the fix:  !(NFSD=3Dy && (NFS_FS=3Dm || NFS_V4=3D=
m))
>=20
>=20
> |-------------------------------------------------------------------------=
---------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                    =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    y     |    m     | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    m     |    m     | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    m     |   y (m)  | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   m    |    y     |    y     | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
>=20
>=20
> |-------------------------------------------------------------------------=
---------------|
> |  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                    =
               |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    y     |    m     | Build OK, inter server copy failed with N=
FS4ERR_STALE   |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    m     |    m     | Build OK, inter server copy failed with N=
FS4ERR_STALE   |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    m     |   y (m)  | Build OK, inter server copy failed with N=
FS4ERR_STALE   |
> |-------------------------------------------------------------------------=
---------------|
> |   y    |    y     |    y     | Build OK, inter server copy OK           =
               |
> |-------------------------------------------------------------------------=
---------------|
>=20
> NOTE1:
> BUG:  When inter server copy fails with NFS4ERR_STALE, it left the file
> created with size of 0!
>=20
> NOTE2:
> When NFS_V4=3Dy and NFS_FS=3Dm, the build process automatically builds wit=
h NFS_V4=3Dm
> and ignores the setting NFS_V4=3Dy in the config file.=20
>=20
> This probably due to NFS_V4 in fs/nfs/Kconfig is configured to depend on N=
FS_FS.
>=20

