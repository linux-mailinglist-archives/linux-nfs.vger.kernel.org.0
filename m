Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20E3F8ECC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 21:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbhHZTji (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 15:39:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6784 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243407AbhHZTji (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 15:39:38 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QIx0UO025203;
        Thu, 26 Aug 2021 19:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Dp2GDUhBYOAFL59GJWgjL/xLM+6I0QF+1wRKfiFMHAs=;
 b=TvqCRiUAVF8eOj2N+PqAJE5AckX1q3GMQvGXsLiDq2zwXAMFIfPJRCIJtsrySXke2HIM
 z3oGozhPhP9iIjN3NH7xQJ4yVRGzbnNMRi5B9uWeQ8vLLnEMtelJQEiYXXOsCTEbbWTK
 0P/r5KzLhe4m1CKVaEcMbU/h+ZLK0Z9r6Mo0ihOyHNEIxS0wJ2ssb8r8UabO2cxlyY+v
 0HJz83Ef5fiBOtjvQ36gTfKt/HnnwHYAUZcTMhH4yE787SSU7wEYUCf+gM0/FqzejmCx
 w3nxgR0fwc3kI7h/l3bDUpbDrF88yA8BhHobpbOX4f2JtzOXDNpF+7idRIv6/D9HD5l7 5w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Dp2GDUhBYOAFL59GJWgjL/xLM+6I0QF+1wRKfiFMHAs=;
 b=qUu7Lv4K6uU5IukPACeZsHkI8fD7q+dpCJ3GSTrSwaTSOllWVne+W3YjQaPyty5XfqlP
 q5LxNN1dmYQUP771AU2UaXXTG+GacoHfBIc58JSzfZ+nN7CqC48BegA5qf4ohwFndVrL
 b8o8J7J1v3m10gzXwwNSL4dEpaelnqvXapNb5bwAvSc7Lhf/OgtdhkCeuSx1GBluYcHk
 crQjlghm6qiJuqnmqycSb7DFgKUpyhpUfKY6BVarpycyuGyf6VuQtW0kLcJfXvbyg90g
 v6xTuPWEV/lGSKaGOXExrTAFHFemVCUcZjiOy6S1j3QcYEBlMcLQIUaRpA6xaCF8npdr Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv1vxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 19:38:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QJTiMu101721;
        Thu, 26 Aug 2021 19:38:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3ajpm37cuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 19:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9IGkppWAPDhHpDnqkmqKpQ+cPz89AmLNv4FP4dcjdloxxRoBIB49TVdnnXNU4OkELM+ORknRmtlAZX3fRI6UvlcmlLIaVnHnDBzBVtgqET62a/xN3AujAMCJBKbEL260gGkumPLuCFLtEEgAZU2EBOpfVq+IWWcdX4HH3GzB0W6kWHjimzDx3hDIVXyIgvenBXViaOmAw5a6+MyVdoPoTYKxh50guRViMbtzfqmeY3w0+dlke/2F58F9/lV1HzondDKp2+vqJldFn0GMDnAf/pILNEBJo4YN11gJPCZ7a7iA4/COsqZgMcbgbQdr0wwBlUzbYXsj1P5eiDkHIdahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp2GDUhBYOAFL59GJWgjL/xLM+6I0QF+1wRKfiFMHAs=;
 b=BIgoXXaTskLJAgRaQm2abVxuwmqNt+WNtI/65BCHmiV+kpZ/ob6DdI6ZzU++EIUky3dyE4qoiuvWuxdyzTz4q21CnArSpV+S3W25xyW9lMJR2bEJePWsti5cdvnKEprPIeqH9bQsgbY2ePmAgreiF+rCjaRUUZCaIc7ioNVRlrahLy/PFenxwoMBsLi6jhHySPhzFncJGKn8Y7sMmYNO+qP8rendwhIRk/8yfnN9rgOatu7pxCh25kq3jW52VT2kGk3nyiCmy/HQdQOdX+3E0wt64jIeqDa3N0Vt+MrHrjDTEWAOf8foribSDI8FQ3IKgqZeBFZzf+rSuqJNd0bQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp2GDUhBYOAFL59GJWgjL/xLM+6I0QF+1wRKfiFMHAs=;
 b=CQe8z76ibDFGLHQzBKmjR+/ZJuONAdbfsg/HP4cG0c98DTpfND6BU2+MIAX+RyDi0ZrUZgSadcBJtqzE7WUlXCFT25YIW5MMGG2+7g2Uoi1Rd6HU7cXD39WH/xbdVXQNVfXDkpC366nQyoemuUjmdbq+oQwqzux4AY/d+EH8x+c=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR10MB1679.namprd10.prod.outlook.com (2603:10b6:301:8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 19:38:42 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::d14b:45fc:ebf2:8a94]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::d14b:45fc:ebf2:8a94%9]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 19:38:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumakeranna@gmail.com>,
        Bruce Fields <bfields@redhat.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Daire Byrne <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] reexport lock fixes v3
Thread-Topic: [PATCH 0/8] reexport lock fixes v3
Thread-Index: AQHXlgaoPqAOXLoYAUm27mAAkmEGR6uGLp0AgAAJR4A=
Date:   Thu, 26 Aug 2021 19:38:42 +0000
Message-ID: <696BCC7F-C3A2-4D44-9FDB-3668171FDDA8@oracle.com>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <CAFX2JfmB36zQ8dWXCwGmCBWxShXsCyPhR86XT+CRL8ZCZPS0nQ@mail.gmail.com>
In-Reply-To: <CAFX2JfmB36zQ8dWXCwGmCBWxShXsCyPhR86XT+CRL8ZCZPS0nQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bc7bf0e-acfd-46f7-e0a3-08d968c91c4a
x-ms-traffictypediagnostic: MWHPR10MB1679:
x-microsoft-antispam-prvs: <MWHPR10MB167921C8C6F31439F9BCEC8993C79@MWHPR10MB1679.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mizYZGd0Dzn/HPflKkzQheZZxfO7LrR64xpZBpLZdyclmW/ER0xRQXLFHWn1XFzsZWg/skppRZ/l+Cwx6ahxXR4Xlp2tOfqzcQLps5CSCHb8RxnmmDVrE06MQwUo3EuevhQB/X/tQ23L8BfCFn98D4d6ShOGn0k+uBiixJ1uDLxLh4gfuFQRXBEOtM90/sdPpTPNOTQ4+TMsosV5ofOmbWbc6VsEy9/XOUYh3I55zSTw46lzDRaoexQKkAD8gVDpB2yGK1XPxA8hzhP6t3LmewQnu47BAzTM4hHquVHbxdok7d9i9XJz8oeTWBC+fxhMFMXJbMNuM3aDuev/NF3f+M+mN6ci8kA7UYZZti4JciZ57i6yL0lqHrUmZas0sImda1ip+wH064c74qUAx2ghp/VUxLiHnnmqm5qoDMmzHGRB/vWgQUFDodb2oW6+6sH0BPEuaW2HMkI59sfrUmIghg+qlv3JOryFGIrnTO/P+avbBxMiU/lFesuHzsJrWM2T6x0HmzAPRlzJji1e6kAoE3GqMcY5omU273KNo1q8eilRl4/HMDMKeXjcEpKfAeYqiV+w0zCwzI3108D2bWeTjGQPdSlKaLBEb6CClO/tiqliQBgrvYmi+Xi1YlXjZQMfuRtUzE9tMwXmN83DsSOjJC8j0rCTpO3BJUcsvIWyXa5WHgjumiZPrp6hPcKBhmNhdgjyeh8x/0elUtTomeLbUUQHzQNeckd3/RNsZcaWivFxHq5EXEiFPl4NS28pRbj0rbH6+91b9ydkuh/mO4I5bMiKDwokB3H10I+1us6sFRrqp3uJfeC3jzlmNAOy8sd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(26005)(54906003)(6486002)(8936002)(110136005)(86362001)(8676002)(33656002)(5660300002)(186003)(122000001)(966005)(83380400001)(38070700005)(76116006)(2616005)(4326008)(36756003)(2906002)(71200400001)(66476007)(66446008)(66556008)(6506007)(6512007)(316002)(91956017)(66946007)(64756008)(53546011)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fPqIO3xSvIb/5vJm/kolTGLRHNeHS0wUT2rLihpRSxymM/AqkanUSca6iqpS?=
 =?us-ascii?Q?kyW4N9tao7rhXiG+nBlcpDxJvt2VzGyuNG/Hg0/XHjQH6dQ6d5KLPvoiRdHq?=
 =?us-ascii?Q?+L7k3zK30olJuht2oWiFaacsSkJK9bGAlKtQCYzoOxeC4tjeGXPRBP0nDp6H?=
 =?us-ascii?Q?Sni3yIShhe3P65iIkIKCIcQi8ewXA3w2UMyIbdsc0rMA9h1rCPSReDus+4W/?=
 =?us-ascii?Q?mCZoKoxMhblolH/1IM6VLy5DcInvup34f12VedUnpCu/OKkRq7VeTnT7xoPc?=
 =?us-ascii?Q?U7V1zkEmcQj3mBIRwmDL5eJHa8COh14Ys5W6E9TlMZBNw7YHkRCjhtBXTSs9?=
 =?us-ascii?Q?jGZmbRPSu8eWEzWMR1n9pdn3tE5rcLCzflbhGZt09lE4Tj3tsX+dI73SM7d0?=
 =?us-ascii?Q?FuZB7H7fQvOOvtPhviZ/R4gxRDJkFx6VXujPcVCT+fAoySJXDZT1kMl6wX6m?=
 =?us-ascii?Q?DB6Oa7+mtn/GwWPOVPO+oWrgqgh5qZI5JHQEZuRBIHSZ1Zj9tbakbsZ/1Y/Z?=
 =?us-ascii?Q?I03CwzVbA9RFCCpMNiDytA2YEsa9Tyjj4Ers5Ica+PPjNm0ff+PUd4Cic121?=
 =?us-ascii?Q?jtgW121LtmOjKyC11sAFOmog+ZbgZlPvb1o4Jtt1J4vgMZuwKS0EVo12KbcT?=
 =?us-ascii?Q?J2dW7rxAHGQxY4bQBLGYwsHA0ETdXLgMISngLJ7cdGocreB6F3a5durVOo81?=
 =?us-ascii?Q?9ua7cXQ3v/CEMR0aufA239GdgdX7zBSgKBDSg73Au0f1bwygPHOvWv+1+fgH?=
 =?us-ascii?Q?GefRUyi/E4/ga3Sgns+BLKXN/9RdzFC2SL6ImI6bJNpmwtgn9JmueN3Oxfkb?=
 =?us-ascii?Q?DDqJ7Yr+OxZPVazow4IBsDcf4SNLkIFbbPYExSTZF8D/8YW9Gm6ON6VFK/vj?=
 =?us-ascii?Q?9tAcmZaxsLWWVqDi0Mp3IGeZ+VMj7hv5OXfeY4Y6V6TzPYvmUUSD4wYBPn8I?=
 =?us-ascii?Q?JfgHOhL3X38zPibc2fvu6909wNC6krofvECtUJKn9lgUgGsbvxZmNl+BD7ca?=
 =?us-ascii?Q?2fqy4/urQSr/6dtTN4d9flTZDALz4w5LViN29gQCR7uYTLNFbH2gp1Fr4M6e?=
 =?us-ascii?Q?0WharKMgl2K0bZbb3bNM0UGx98W2Kzvg7i+wtwima1CZ337K8EK539WFeL/4?=
 =?us-ascii?Q?2tw254keeG53pOUI5mzS2YLPQ5J+m0dus6Rk6yTzGJG39VhvvVMuR6nDfeEC?=
 =?us-ascii?Q?0ryGUthOS3uBeBL6Qets6lT+wVQbzzTKMnbqPUmQodNuh+iEeB5dFUN8IHXc?=
 =?us-ascii?Q?qWXsvIdX6no8xNAhaVHWN7TD4+ir35vkS1RwqFjz21It7WRZbe8axIHIixxI?=
 =?us-ascii?Q?fTSdshMx6ogKLIBDEGh5xfsN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <810C89A0B620E341837993C755924663@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc7bf0e-acfd-46f7-e0a3-08d968c91c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 19:38:42.1074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyoZ+tIrEt+5bNc+6r5MtSTqEwy58oGLVkhVXF8kmcFsttQwaymBVkZM+dFo/DEiVEBiAdNIC4Uvp95LnmOVuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1679
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260108
X-Proofpoint-ORIG-GUID: i5sF9yhyIsyNZzCT36ZyteLsV2yBY58l
X-Proofpoint-GUID: i5sF9yhyIsyNZzCT36ZyteLsV2yBY58l
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 26, 2021, at 3:05 PM, Anna Schumaker <schumakeranna@gmail.com> wro=
te:
>=20
> On Fri, Aug 20, 2021 at 5:02 PM J. Bruce Fields <bfields@redhat.com> wrot=
e:
>>=20
>> From: "J. Bruce Fields" <bfields@redhat.com>
>>=20
>> The following fix up some problems that can cause crashes or silently
>> broken lock guarantees in the reexport case.
>>=20
>> Note:
>>        - patches 1-5 are server side
>>        - patches 6-7 are client side
>>        - patch 8 affects both
>>=20
>> Simplest might be for Trond or Anna to ACK 6-8, if they look OK, and
>=20
> They look okay to me. You can add:
>        Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> to all three.
>=20
> Anna

Thanks. I've captured Anna's Acks and included 9/8 (posted a few
days ago). See:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=3Dfor-=
next



>> then submit them all through the server.  But those three sets of
>> patches are all independent if you'd rather split them up.
>>=20
>> Not fixed:
>>        - Attempts to reclaim locks after a reboot of the reexport
>>          server will fail.  This at least seems like an improvement
>>          over the current situation, which is that they'll succeed even
>>          in cases where they shouldn't.  Complete support for reboot
>>          recovery is a bigger job.
>>=20
>>        - NFSv4.1+ lock nofications don't work.  So, clients have to
>>          poll as they do with NFSv4.0, which is suboptimal, but correct
>>          (and an improvement over the current situation, which is a
>>          kernel oops).
>>=20
>> So what we have at this point is a suboptimal lock implementation that
>> doesn't support lock recovery.
>>=20
>> Another alternative might be to turn off file locking entirely in the
>> re-export case.  I'd rather take the incremental improvement and fix the
>> oopses.
>>=20
>> Change since v2:
>>        - keep nlmsvc_file_inode a static inline to address build
>>          failure identified by the kernel test robot
>> Changes since v1:
>>        - Use ENOGRACE instead of returning NFS-specific error from vfs l=
ock
>>          method.
>>        - Take write opens for write locks in the NLM case (as we always
>>          have in the NFSv4 case).
>>        - Don't block NLM threads waiting for blocking locks.
>>=20
>> With those changes I'm passing connecthon tests for NFSv3-4.2 reexports
>> of an NFSv4.0 filesystem.
>>=20
>> --b.
>>=20
>> J. Bruce Fields (8):
>>  lockd: lockd server-side shouldn't set fl_ops
>>  nlm: minor nlm_lookup_file argument change
>>  nlm: minor refactoring
>>  lockd: update nlm_lookup_file reexport comment
>>  Keep read and write fds with each nlm_file
>>  nfs: don't atempt blocking locks on nfs reexports
>>  lockd: don't attempt blocking locks on nfs reexports
>>  nfs: don't allow reexport reclaims
>>=20
>> fs/lockd/svc4proc.c         |   6 +-
>> fs/lockd/svclock.c          |  80 ++++++++++++++----------
>> fs/lockd/svcproc.c          |   6 +-
>> fs/lockd/svcsubs.c          | 117 +++++++++++++++++++++++++-----------
>> fs/nfs/export.c             |   2 +-
>> fs/nfs/file.c               |   3 +
>> fs/nfsd/lockd.c             |   8 ++-
>> fs/nfsd/nfs4state.c         |  11 +++-
>> fs/nfsd/nfsproc.c           |   1 +
>> include/linux/errno.h       |   1 +
>> include/linux/exportfs.h    |   2 +
>> include/linux/fs.h          |   1 +
>> include/linux/lockd/bind.h  |   3 +-
>> include/linux/lockd/lockd.h |  11 +++-
>> 14 files changed, 170 insertions(+), 82 deletions(-)
>>=20
>> --
>> 2.31.1
>>=20

--
Chuck Lever



