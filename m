Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B217228380
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jul 2020 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgGUPUo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jul 2020 11:20:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56408 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbgGUPUn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jul 2020 11:20:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFHSFn026865;
        Tue, 21 Jul 2020 15:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=/ZcK6I8L04e5efoZhwItrtv1eMer73YzeucF6KYOgDw=;
 b=SCYP1JWDsxldTBpQDhqko4cdS8EPV8aHM7kJnaBhDAMAR7iURxbQAMPWCDCVS7tyeTrY
 oGP1uJiyEx3w8VmKzhJ9742HHLDhr/JcQL2x5oYs6zLMQx1Uvw0hoQ5bFu/HjppItHKG
 1IzZnNPdCTtV63plZXyRS/4z0Z36Lv2RReGF5uew7T6BdSwzp5KRQa5nFxIvVQe4t/GT
 bo3pm0X+1xJ2bKZKSF/D11RoG0kQSyNK6+HAA3rLs6s9fgbrvDW+2OBU96xZtoDgjXcl
 fEBSPVOZt8dPvh8/agvTxBYdi6JXMIwwGU5rRKZ78fPckS9P/fnE5nadEnza2bPfXMzS BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32d6ksj4me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 15:20:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFIIsG075927;
        Tue, 21 Jul 2020 15:18:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32e2s9096u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:18:20 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06LFI2ba028002;
        Tue, 21 Jul 2020 15:18:02 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 08:18:02 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: rmk build: 54 warnings 0 failures
 (rmk/v5.8-rc3-11-g48b8eed3a337d)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200721151417.GU1605@shell.armlinux.org.uk>
Date:   Tue, 21 Jul 2020 11:18:01 -0400
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B976F9BE-F1DA-40B6-99D4-B53D8862433C@oracle.com>
References: <5f16fd81.1c69fb81.6bf0b.4e31@mx.google.com>
 <20200721151417.GU1605@shell.armlinux.org.uk>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210111
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Russell-

> On Jul 21, 2020, at 11:14 AM, Russell King - ARM Linux admin =
<linux@armlinux.org.uk> wrote:
>=20
> A build of my tree by Olof's autobuilder revealed a problem concerning
> a couple of platforms - this is based on v5.8-rc3:
>=20
> On Tue, Jul 21, 2020 at 07:36:48AM -0700, Olof's autobuilder wrote:
>> 	arm.mps2_defconfig:
>> net/sunrpc/svcsock.c:226:5: warning: =
"ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 =
[-Wundef]
>>=20
>> 	arm.xcep_defconfig:
>> net/sunrpc/svcsock.c:226:5: warning: =
"ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 =
[-Wundef]
>> net/sunrpc/svcsock.c:226:5: warning: =
"ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 =
[-Wundef]
>=20
> The issue is that as the #if concerned is used to determine whether
> code that calls flush_dcache_page() (and therefore ensures data
> integrity) is omitted - and in the above cases it will be omitted.
>=20
> On ARM, we define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE to 1 in
> asm/cacheflush.h, but for some reason, it seems that
> net/sunrpc/svcsock.c is not seeing that.
>=20
> Maybe net/sunrpc/svcsock.c needs to include asm/cacheflush.h to
> ensure it picks up the definition of this preprocessor symbol?
>=20
> It looks like this was introduced by:
>=20
> commit ca07eda33e01eafa7a26ec06974f7eacee6a89c8
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Wed May 20 17:30:12 2020 -0400
>=20
>    SUNRPC: Refactor svc_recvfrom()
>=20
> Thanks.

This should be addressed by

becd2014923f ("SUNRPC: Add missing definition of =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE")

which was merged in v5.8-rc4.

--
Chuck Lever



