Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9579D65435D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 15:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiLVOtO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 09:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiLVOtN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 09:49:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BF3BE0B
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 06:49:12 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMDNwKE024398;
        Thu, 22 Dec 2022 14:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fKEZYw3fi35tmyl3yhmmtjtky0Kns2UUg9B7mgQ+N34=;
 b=wGRCp+d2iMVecmoACRPKIuAPUm9GojjEkxfkjoMflRVqfMCqjHhgkJHxavERD2gk/Ye2
 Etm2SH8/d4ZGAqYWd3B/90EEjiMbb5BumXVuC0s3sl6Aa6ALyBAtRIZYSRQEptDvSO/n
 EaF8fC2KBfdOXlJ7Am6Pl9lEEzdfKml1AwN/zs0/rWPbko8Mb1NmjuZAGYYZFm2/FaL/
 jYFyhVo8kO3oucsJgX3Q1rO9kYMAZYFRplqLEfX0VaslyjEE+7gi5hkfgj6CUKIaioa8
 jttyMGqLc926uyrpbLKk4T6+0DGdTjFaD8D6ORzBbcQbklhDojy66ZkcK41Fl3/TrT+6 NA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmbkgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 14:49:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMDXdq2031976;
        Thu, 22 Dec 2022 14:49:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47ee41w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 14:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSBzcWR7fr9A+pRWv7LJY2oiX0ofTs574YlWDZ7BvDO5pcTJm7aEYa5vy0R6lwbfrJpLz0JxcpvDNwzdDRw3L/60KDtNDy3to3pSXAcfQ1Ai8D8sM8jzz+dI+wNiRhefJB9a/z3Y7q3L8+HBf2QKh4wHeTix2p7d0yxjD8ioa+XyFe3NINCb3wq2AzqH9Zk3eQLL8l18xfsoV5McLgqJ1h39aogw4ltF41/D8mq/iNPmWt/HhbQSdIfrE4AlOr5h/NPuV3q1DTCJ0rGxpHVdy2NTUfa8m4EuebY3De0hdqgAOWAdS3c8XGCDFdA/BVT+qpjqiX6q7arMb9sUNq7exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKEZYw3fi35tmyl3yhmmtjtky0Kns2UUg9B7mgQ+N34=;
 b=GKeIVkFO/ibFN4bAQBPiSpoBE3Fk1iTVODsix3p/NTcs8SZbcJYVR8VLNeEr9102J4TxVc6vFlrDTcHECZZsVHYccV704XONIStn9JUpfdfRcsEsVHnUzBxW6960w65CEgf5N/BZG7zY+sdeRQjt2tx8dHAi3kNUxiuv7HZ196z18j9RT+x4fWGoryQFST7JM01e31OGA00iNEWP3tgyTj7QbcydGjyIuEoI+ppaFctbYqShipXoJCoblnxuYmIoxIiJkH6RKcW8uP3TZ0lNN7Qs9AkhrBg9RQcdx54+6vo7LyYz7DKsGdvB7TtGN/ytOA33dQUC887KykNZilTVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKEZYw3fi35tmyl3yhmmtjtky0Kns2UUg9B7mgQ+N34=;
 b=H83TikiPTVfVyIzfUSdipEg7BKFJ9A5SVjAmYgxtd1aPRUvuv/vP+2QGsuw/E6uovGULeHN0uwoaezXAN2cwXDRXmqafKpG02hvZ97toZH1gD4O2TbO2Mw6gdUwRAdi9eJLf6XltXEieJKgAowWxVmomcdVTSJX8MdPawAVvaRc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7060.namprd10.prod.outlook.com (2603:10b6:a03:4d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 14:48:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 14:48:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nikos Tsironis <ntsironis@arrikto.com>
CC:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is
 unmounted
Thread-Topic: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs
 is unmounted
Thread-Index: AQHXGE0TeKcnmbpiEkis/ppV016GpK56wZyAgAM21oA=
Date:   Thu, 22 Dec 2022 14:48:59 +0000
Message-ID: <DCF5C3D1-E4D0-4F40-81AA-38B74276B858@oracle.com>
References: <20210313210847.569041-1-trondmy@kernel.org>
 <936effe2-1268-42ab-886e-649b7c501828@arrikto.com>
In-Reply-To: <936effe2-1268-42ab-886e-649b7c501828@arrikto.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7060:EE_
x-ms-office365-filtering-correlation-id: 7c5fb100-48a1-412d-8ac8-08dae42ba917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43WbMql/p3DGeTIvI9lHA/ZzCpkdWbs9pzIjfM3WfZyXKsn+IWg3rFgfvFOpdpXD8LSJyYpLo7jxRUWLff3rdOMKdb59ieQMvjio9VqFUr9TpGMF2ymgWqbnvZfWfsxa2kuuNQ51KhymJuzDqecRo46NDzBxahzYSJEyBG0R9e0G3IXuixQ6eJRCU3v9A1V3k89/yuy8xdCLTEzOopt9l61dCMx5Fa9WwF2gepjgzmlhe2n+Ei1SkDrbZ27/UnwDEET9+POyEFNqEuIc9/nYFPRzkqWz+7Oc9ycT6BGg1keM5bk3oIBh+29zDE4pKK2Pwqh4F8J+14iROa5Hmjhfs8FvBBSIobVCM3Yqsj04M/vTaN1ADAJa+NSrMN52EIOyICpa+RfuQckorAPfF4l9uhTpJU4l7NBcEZUs35XKf1w2aUQfRyDdEpvWRtmPgRV8rYfRK5KHpcGsvjRUyarrx5DY6VS2Tk0BE/o7C1a6qBi2c0LtPSYOxSy8uuesz7ktwbuCZX4BbTtrm290RSRfi08h+qx/Zm9RQA0U1lNlglgBnW15a9oVP65e+np3QyIVZdo0H87T2DxPKbhvWfcPGvUAU8YM6dwEUdCsN+ruDQnI4dAKpr4124aqekJeNiAYku+sz0s9FdYKoeI6+Lf/K19bfY7dgbL2z2dfP/ZC/jNseB7ltzxJM041+DUXi7hJBHwFCOCZP0jaKqn5ScesrorvQY86ZAeE/RUjt76eyQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(38070700005)(6916009)(36756003)(316002)(71200400001)(6486002)(86362001)(26005)(478600001)(54906003)(64756008)(41300700001)(8676002)(2906002)(76116006)(4326008)(8936002)(66556008)(91956017)(66476007)(66946007)(66446008)(5660300002)(122000001)(6512007)(2616005)(6506007)(38100700002)(33656002)(53546011)(83380400001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kc8l+QljeIMptRZDkXiPElLYilLx/l3WcQDy7oSvn7yQk/reH8QSuPDGH/Po?=
 =?us-ascii?Q?iFRnHg0QJataGJYBZS7YKr3ee9nq6MM40BF97xavld2BjQ/55h/AIDN/4BgD?=
 =?us-ascii?Q?OopzBXFLVAFu6XS1fd5nCM/UlTCDkjwTMt6vRCdlKDcQmr9qWX1BMvP7PRe0?=
 =?us-ascii?Q?sOGbyIpEJHTb2ofP7OA/AcCI5blrURFRYK327A5rSnhoZRAve5+JSOcO/JfE?=
 =?us-ascii?Q?XhJJqUX8GeNL7mwPIg9lbQSDtVAc1HFBxrXBXkjN7L3vYMXP9JP76HqKiMBj?=
 =?us-ascii?Q?FuzT/GO07W2oOSIkDwLWbhw0pj5U/oeL4AsUhslmxxFaGwuE2pA4nnzfSMK8?=
 =?us-ascii?Q?tyoPEKzjRIBBBj6Tc5EWAdbvFa++WZPYxxPItywpplUcWWE2bijGFiaYfOfm?=
 =?us-ascii?Q?bq5VUH1AHt2L7dDnXn0TRghWQ0kpGTsG5g9QoUnjQo4Nguomb2OAszELzTiZ?=
 =?us-ascii?Q?V+pcHkzVcpA7RGwmTJtFTPni6uetDNO4ONRB0RA00KXccu0emdrwHjUHVbEX?=
 =?us-ascii?Q?haCHXDEo046j+PgPxX3c+t1MuKZRpOm+nCg7Wbzs+oOrqyT6llnpVKKwZWci?=
 =?us-ascii?Q?263cSogcBghprQ7yuZ1m1fBhoBiZO/hz1F5IADmdUpNwuEE0nc3gYIVQpAr4?=
 =?us-ascii?Q?Jc7Ip8aovEtLcQ32bnCTom4Y82YQBkKsmxWLtvOgCwtknU9Py4DD6JtPEwTx?=
 =?us-ascii?Q?wTIZN2N8tfcKMhNHbdCP4BfuO2WjhRpyEOQ52ssaodd2G4O8fg8vqgRz7APb?=
 =?us-ascii?Q?9kt3iTtlQ/QdFEvyu5iYozqgPaxZInGoMq6XuD31VaRRR/efaC8T7k65OnB1?=
 =?us-ascii?Q?UHCNqNoSKSmhKEBknsPiLwywOPUcG5vzWcKxL6sINmxAtgVcZc8Pfr1OIAN/?=
 =?us-ascii?Q?mFj1IfJAC0g0p4kJIHzEBf+BpzhusQJE4Oh/8WGxOf3hjmysseOlPFT1OPbI?=
 =?us-ascii?Q?taAz3vKxAJ1EMz6lxqJXka98Glx4wVz0n78QjQUQM0w/kK6GFmnm7L3CRLaA?=
 =?us-ascii?Q?yVh0oL5BKmBGbZ0PxOlTTuvoPZqiuhdHpxehCwOQZhhmp1+5sHilXpL7b7jy?=
 =?us-ascii?Q?GPpx/2+6YB+e6sKF047JXmieJz/XeqpbwKmALklo8CcS52zIw1H3QUb/S2Dc?=
 =?us-ascii?Q?xi2WZf5bNKU9wJiMmWLAI5bHxko3aAIFaqXgDCQDVpTsw9zzjxJhjaKCUj7w?=
 =?us-ascii?Q?YHe0Npw0cpspmwPbzinuQ8156RARKqjPs8v5TekD1ZibQRC76XaxTADhjKqQ?=
 =?us-ascii?Q?4dNDK8DwPveizV153XMM7TisEd0m5PWLg+hmSIRqoZeSkm8aREdgraNeEj5z?=
 =?us-ascii?Q?yukjHCO82BJbL00kVUz17NsqQJ25ygPn04EvumZmeqRh/tKFWcyQvrPcqQKo?=
 =?us-ascii?Q?2zA/2n/ZZDB/4WzmxM5bGwGxc0clMTnCk5+lPmywTfci5ZmXdtpFzGkHSn7A?=
 =?us-ascii?Q?nL/PkhqKDB+XoMuJRvPzUj4tRciCzsjTVN6vPVbXIkXQrtJWqsz3XdqyS3KF?=
 =?us-ascii?Q?YHP6UTB4RiAdpSbqUwN0/w81LYXFwf+7vhwdUn4d18JSd0N1pJHEybl1pQm1?=
 =?us-ascii?Q?gV8gHMxUU/mdTfmQtfxjKgpRKj46p/7Nw2PRiqcSv2I+TOgSHpGS+AxjDnEd?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46FF41BD1356DD4380ABB51DEB1A3D1B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5fb100-48a1-412d-8ac8-08dae42ba917
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 14:48:59.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvqw45ktm6Ku2csAisJUvb8uh5D/fFm3DqqdAqb86Fc5aWJsjVou/E0TDcgBuE5kqRwOV9C57KOqUBI4A/HWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_08,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220130
X-Proofpoint-GUID: aH2nNd2ljdDnZVvFEA5swtOcz4rYNtXc
X-Proofpoint-ORIG-GUID: aH2nNd2ljdDnZVvFEA5swtOcz4rYNtXc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[ Cc: Bruce removed because that address no longer works ]

> On Dec 20, 2022, at 8:43 AM, Nikos Tsironis <ntsironis@arrikto.com> wrote=
:
>=20
> On 3/13/21 23:08, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>> In order to ensure that knfsd threads don't linger once the nfsd
>> pseudofs is unmounted (e.g. when the container is killed) we let
>> nfsd_umount() shut down those threads and wait for them to exit.
>> This also should ensure that we don't need to do a kernel mount of
>> the pseudofs, since the thread lifetime is now limited by the
>> lifetime of the filesystem.
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>=20
> Hello,
>=20
> This patch was merged in kernel v5.13, but the issue exists in older
> kernels too.
>=20
> Is there a reason that the patch was never backported to older stable
> kernels?

Hello Nikos-

A probable reason is there is no Fixes: or Cc: stable@vger tag in the
merged commit, so it will not be cherry-picked by AUTOSEL. Another
reason might be that the patch does not apply cleanly to LTS kernels.

You can make a request to stable@ for this patch to be backported, but
I would prefer if you apply the patch and test it on each target kernel
before making such a request. Or, you can pick which LTS kernel(s) are
most relevant to you and ask for backport to only those.

A good test will have three parts:

- Make a positive confirmation the issue exists in that kernel

- Make sure the patch applies cleanly verbatim and causes no regression

- Make sure the patch fixes the issue in that kernel

It's a bit of (albeit mechanical) effort, and the Linux NFS community
doesn't have the resources to manage it for all patches going into
mainline to six different LTS kernels.


--
Chuck Lever



