Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7ED7D6F1D
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbjJYOYK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 10:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbjJYOYI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 10:24:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C4A3;
        Wed, 25 Oct 2023 07:24:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCwv1O007541;
        Wed, 25 Oct 2023 14:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8rtCjundGuO4a3M7+Ty19+jVAF4rXbEZ7st7ntS0W7g=;
 b=evI3lT1sjfdTqIUpbGCtqX3QWuKqW0VN24n1Kf+ye+zq68sejwqHB/DtZHDhgXsWcmiP
 MqkzzxRXRKLazOLE8aW8+MSSuaCQRCAjD62CvpaGdYCW5/AYb9oNQ+qrJeE7MWYfUZp+
 dahVhhF/KXPfy1PEH8V7VpCn3pQ83THtqTn4mE8OA47ook0YOwIW/QAix+HTRefGQ5EP
 ab/Zy/VNWopRTMRUoVC4okRi12OM6aITQcNVeYXHxTNJhEOX7MZCoPx3D5dNsm30JDhX
 hzMON05+8pC4jnhfWZ3fM6YY4t/9CwmFZFasSFkUjmsKpxAJ1vLpSC8EW9P4DBtBx67/ hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dyx5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 14:23:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEFTe5001564;
        Wed, 25 Oct 2023 14:23:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53d78xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 14:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k23urtfCqptyKKaqygIh/pRvjkUcHX0odgyBQLGYWgb58t8NHFpRyTMlyG3GLqOJtdHm4RhzNRfCxisoanLiRG05bFBvl6P/eSKLed6jVcDzciGccZkDVb5v3MvBwH1NhchI6kjHq0yPw7bh2tD/0qi9bQV2r+4wwuv19CxB/tJPlChuBsIBGZmbfe4jvv3Y1oxh3fw0Zg9YGeV3LqiKjZwhkvY+WUDa0MfLc0RTo6IxsMlC6PlTOluxWfXdlagKEjlb1ufa68623hTTBZkZGZ0R/UCXi7jwse8ooCftXz4sGoL0nIglTfB/dFG8EZUsYCqgU9YAArMLF/rh/daCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rtCjundGuO4a3M7+Ty19+jVAF4rXbEZ7st7ntS0W7g=;
 b=Q/tw0ORmF0Ir+0iVywGgaFAepg94AVQWGiLxzOtXqPogzhZhWlbweS97F5kLbWOkn8RzHRG/WkiCh32T/TAplLbuYzXXcwYq5TWLY8zb3VwiXPBNCKvNlOtWX9YDyb7OHLzgD2RHg+tlcDF1+70L/NEhwM6c51VJzrsjrpvRNL/W3TScQTE5PFsh81Ui+BDpwrfNgBDsV07KxUswk2Uy/dIZfNZjaHRqfcTVCvI0aCyYBQpgGYqnC8Xgh2HtztrCTzFzYB7Nj0qZpNzEo1SfOa1N5gyUJSbH5y7pE/fc3WaJS6BxzGKPPZNE9GcCz/zZto1DscBfD8sIZhSkerzxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rtCjundGuO4a3M7+Ty19+jVAF4rXbEZ7st7ntS0W7g=;
 b=Xo+6N0cyFJpDidH9eg8hS0kx2vmZbASBc7RQ2FttNBxGi9cBqE49cuC3QB365pGRhNY8PHChmeDGlYgJl6EkNyw2KjqPhzHBxPAUbobKyCu9RIFOQ8dNwlgmnQMY/A30xo+/7du8pz15zO8xUG7sDiWqjkf7UL5CORJymDZMIYY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5297.namprd10.prod.outlook.com (2603:10b6:208:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 14:23:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 14:23:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] nfsd changes for v6.7 (early)
Thread-Topic: [GIT PULL] nfsd changes for v6.7 (early)
Thread-Index: AQHaB07bR8thZ5/+V0q9Uf2KehgTeQ==
Date:   Wed, 25 Oct 2023 14:23:42 +0000
Message-ID: <34E014FF-351E-4977-B694-060A5DADD35A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5297:EE_
x-ms-office365-filtering-correlation-id: f58c058a-61d4-47cd-f082-08dbd565fda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ge9ki/1c59trctr07ACFFmpIt2pWAR6GI3r2lBV56M/XtPeGGlHKzVywXEUmx76+exmvrHjrnu0NwjQ8yKqspbsO4JtSzvvXwKXenZ84GLk1w0vGbUY8xaMJXUhtrNE6KWz3/25PVE4kZ7NCdmlre8VmyGJ2oS05JCN7eViTPU+nG3b1AU01OAOTCiv6CO9lXOVwgFqFoYnrQNohPgS48kH3sheQaZBUk+C5t9l5fiTmioNSecD6wDYexcgBqgCgO5w4PrDV3gzrxuaXVfWga82BZstDkFCgG3SlKjg5KtzWdkuZknvKpxdrPB+3HIyKrw0BJvR8b5KtQUSRQw7P8rnxKuUPAZGyP1di2x6qjNzHFeLcU8vJlTAfporohl6gud/BzMJA0A2WuGTmoNIZeHwYOXhYg0cMOlNpmPkX+VeijYgL/0eutWqKJfNUsIBkxJww8SCLSGjTTXTor+MPe2LDgghuKAC/aAbI0NZ87jCCX7LmwtzkQZkPjv9Hh3oRnaTovUpAl0tjzULRi3mL9clpa3CM2l6l0If0WXRdfsfLGWd2NApHEXJolnCVaibg0PnZpdfxARyRZ/26QWN5S70BKGr07KQr/Bo98nOSCwBjQ0bQs7DGaL40LtbtCogA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(86362001)(36756003)(2906002)(66446008)(64756008)(66476007)(122000001)(6916009)(66946007)(2616005)(38100700002)(478600001)(6506007)(71200400001)(316002)(6486002)(966005)(6512007)(54906003)(76116006)(91956017)(83380400001)(4326008)(5660300002)(8676002)(41300700001)(33656002)(8936002)(38070700009)(26005)(4001150100001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zaVg+MlSiqPppUgAq05p+22pOX8IHuJCx87UKab+29XNVzV9pjz8BLzfMHdh?=
 =?us-ascii?Q?kBul2Ey65qofoE04GpxagUkb/H4zdfZ/GKRIHwtBl7JZLr4nGAwRYNiXEzic?=
 =?us-ascii?Q?QPvRFVm/SDxLeBo5WBFI/ZVycQPL0AKIXxHcl6MSJtktJ+anxH9QaV9m4ael?=
 =?us-ascii?Q?9wYyhx7I8LsO6ZL7irfoJ5B0dtvvbPuH0AmWdO87xZwBPC60liF0UqcUWgIg?=
 =?us-ascii?Q?evAywXiFcFwJh70NvyOmkWRqrQy7yVG2xRqgb4h9rCl7GLGj+rj3Lm02ahPP?=
 =?us-ascii?Q?iZig3HCBAyUxptevkp/yTyShD1JUnX4A4bu9t/EPSJ/brNcxOOSlWgWCZTZp?=
 =?us-ascii?Q?c6nwWd+HlcpsK1ST0M1bQwM2bxmMoNcuh6aqLBicDcN554s0X6d0HZ9I8OBH?=
 =?us-ascii?Q?kpd6lyGiMZdTrIKl16g9WDNdfpxzChrKhWFmu1n2EUf++2DG4DbP2DwM/Ekn?=
 =?us-ascii?Q?fsue6U+MUfwR/4ZpkLm4YZr0DS//0/FzaVboLyJpqhYA9L/FNT6fENU0xCWg?=
 =?us-ascii?Q?jU5K9ARr58cjLzz8VzD5bifi4hlszD4ofisnxtgpvUiH2WYiwMimpTywV6tT?=
 =?us-ascii?Q?NoxGhuiiyQU6jjyebIBDL/bhG6WZU/nxRXa7YfVVoR7p2Ee1u9peK115h3ge?=
 =?us-ascii?Q?Colt8tZJraGEz1g6avx/adfImNyfveX+Ml/pGBRTLdE+FJrENYwYaTxEc8lj?=
 =?us-ascii?Q?nvNWiwjWefhpQ3QLJW32ySmANwmGHXM5B9Vqdfn7PPffkwPxCSO8Q6YDMPrf?=
 =?us-ascii?Q?B6uOSGoRrn0/UsApLbDTxnn9O14ZexRCF7EhtWwqz9chLxXQCedeSFjXd1EA?=
 =?us-ascii?Q?j18JcwM9f1S6rHBYk1iWn4mAxYOZ0hcSw3Abzk9GgdfsYUxQbJtY3tEWpsu/?=
 =?us-ascii?Q?JJJ/DGyFLIVSaZMgXEdSLl4YwjsTkFEabBrKR/saUfHAgw1sC6S42j6SDt+s?=
 =?us-ascii?Q?mM7JmfXmIU9WagXj6QcyPn+nLicQWV9UcDajCXhJhOy/JSZDxgR1UYlzU6BS?=
 =?us-ascii?Q?5p902lw3+pjmKpxJl4hnigRTjdbuZhKrHcgRXzk+JvdzE9JjSc7PvVck69N+?=
 =?us-ascii?Q?V7QNMC5pbgj29pqrwfOnYF4au8lL84F6uKvgYkFj6nwuTxl0aBJ67YrmkvOq?=
 =?us-ascii?Q?NGfvv6CZVEzI7aGcwaSZVkd+45Es1978jbQitKEg6aqzMyWkgvUInv1tRVk/?=
 =?us-ascii?Q?CQQ4N2syy4Wuq8Qa4Hslguw+HhU+P3hfX92UOVa1tcq+pwSXFD6HqsjCBoKl?=
 =?us-ascii?Q?OktoqWE710gfroSRNKBF6reyDEjiFbuGeVVKD9MrSdWa8eh6aSqd9sK8KKCu?=
 =?us-ascii?Q?IBmi9zB8GEIgNK1JeWuG7TxiODiPv4t8GLTHSesAH4ORv+cC2neLeDvRKpdE?=
 =?us-ascii?Q?Htbea1p9JixRHNPJQuHHq/tHOUltdYX+C1TaB2keFKOnPpceFuUY1ZF+WAhE?=
 =?us-ascii?Q?S6vWo7wAC3HhHsIWtBDxeaiy9ygA5WjaJjhGgvV/kVJCOXpUb9MwbYQOOP+v?=
 =?us-ascii?Q?ZSu+Wsocj2+2X6QlJak8XSwsWfNCturpnk5PJ2/D6Qy49cApoh7fcclvtHlX?=
 =?us-ascii?Q?6nVSfHvG7rAqMh5im+Y0IxF016Cf5WZuY+Ipdb50vCM+OW4mTFs4vLDgjlhY?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D0EDD2534E1504A87E60E74D035341B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pv4zgP+j0VAps0H7h21OaSWFIyWG3iyjnGEWNAPpyaki4pn2iKXEmFSEFlYk9zZXQaDGx5suDuDals4wOEG7SKpPf3/EoC6i32dh4GE/0rXsvcpH0TTWDxoIkDmpscE3BXP0QhfI8LgB4rYGRTpm8l6HWmV9GLSUhdEwrMZAkVaeXeYtLRiLkSBjPHqARjCB48lvia5mR3IWhEWDK6r4XPL9bAyanWfpkz+8lbG/w+oheRQ92Etdf0TM2svhpHjJgc1nC09ToU83cw46LAiQkG+Cryv9JVH6xe2MWfxE5nuBuwq6FW5YbpT4ydN2paxO0ohGIqv5R3b3VDHIZATpDsQkQHYl33/DUC2fRkjMYaNOVGDc4JiPRnlGGCUdx4B/YYGMIFnc2b7IvhSu/Q03X6vO81xVF64he3vXqkLYswb6OueFGbIp4OFWGIAY3Q8mHz0zijMmRLejd7PnSNNZfmnWe+poreuaC7iEk8RF6A7MWmS/Ef3OmXpFN34z/5dp7kaXiolpPnQoUnuYetU2ASIowu+cY41L2U8L+pp9G4Y/BVVn28JMXqWV2LNxYdtpwuA16ddt5CeoVHz1rcMyqskfKVRGc+qqgTNQpZjXv/zkqUnrR2shCHb0XZwDA5z7ma3lVlycjN3uFACHFEYPY0draNb/3m95tB6uZuDYt7ocNd1Dn8MOJplv+PcoMwuieMZHJqE2kV+6DsRonbxgbNmh6kVOnceq3xZYMi9YyejLxx5eIqmdduPrs8ft6VqPd9+6qBtLTtNynNt14cEVVrkf71a8yjX9+PT+WHBJV4gMMI2Wt0Fp4ZQ9D2DY8LfaJjNLXArfqVd3oa56iQjoskeCbMl0PYHI8Ud0zX35WzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58c058a-61d4-47cd-f082-08dbd565fda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 14:23:42.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/zd+KMH/pZgX//LdxIkX5bNWBcp8ExLTuSZZnUb67FLYW3F5Eyv3QQ8t0jRwr2TSzxyhP1nlIdgcrQOkoiAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_03,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=733
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250125
X-Proofpoint-ORIG-GUID: neeC6i7cbYyhfVY69DipQj2aRlJ5j3_0
X-Proofpoint-GUID: neeC6i7cbYyhfVY69DipQj2aRlJ5j3_0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb=
:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.7

for you to fetch changes up to 3fd2ca5be07f6a43211591a45b43df9e7b6eba00:

  svcrdma: Fix tracepoint printk format (2023-10-16 12:44:40 -0400)

----------------------------------------------------------------
NFSD 6.7 Release Notes

This release completes the SunRPC thread scheduler work that was
begun in v6.6. The scheduler can now find an svc thread to wake in
constant time and without a list walk. Thanks again to Neil Brown
for this overhaul.

Lorenzo Bianconi contributed infrastructure for a netlink-based
NFSD control plane. The long-term plan is to provide the same
functionality as found in /proc/fs/nfsd, plus some interesting
additions, and then migrate the NFSD user space utilities to
netlink.

A long series to overhaul NFSD's NFSv4 operation encoding was
applied in this release. The goals are to bring this family of
encoding functions in line with the matching NFSv4 decoding
functions and with the NFSv2 and NFSv3 XDR functions, preparing
the way for better memory safety and maintainability.

A further improvement to NFSD's write delegation support was
contributed by Dai Ngo. This adds a CB_GETATTR callback,
enabling the server to retrieve cached size and mtime data from
clients holding write delegations. If the server can retrieve
this information, it does not have to recall the delegation in
some cases.

The usual panoply of bug fixes and minor improvements round out
this release. As always I am grateful to all contributors,
reviewers, and testers.

----------------------------------------------------------------
Alexander Aring (4):
      lockd: introduce safe async lock op
      lockd: don't call vfs_lock_file() for pending requests
      lockd: fix race in async lock request handling
      lockd: add doc to enable EXPORT_OP_ASYNC_LOCK

Chuck Lever (92):
      SUNRPC: Clean up bc_svc_process()
      tools: ynl: Add source files for nfsd netlink protocol
      SUNRPC: Remove BUG_ON call sites
      NFSD: Add simple u32, u64, and bool encoders
      NFSD: Rename nfsd4_encode_bitmap()
      NFSD: Clean up nfsd4_encode_setattr()
      NFSD: Add struct nfsd4_fattr_args
      NFSD: Add nfsd4_encode_fattr4__true()
      NFSD: Add nfsd4_encode_fattr4__false()
      NFSD: Add nfsd4_encode_fattr4_supported_attrs()
      NFSD: Add nfsd4_encode_fattr4_type()
      NFSD: Add nfsd4_encode_fattr4_fh_expire_type()
      NFSD: Add nfsd4_encode_fattr4_change()
      NFSD: Add nfsd4_encode_fattr4_size()
      NFSD: Add nfsd4_encode_fattr4_fsid()
      NFSD: Add nfsd4_encode_fattr4_lease_time()
      NFSD: Add nfsd4_encode_fattr4_rdattr_error()
      NFSD: Add nfsd4_encode_fattr4_aclsupport()
      NFSD: Add nfsd4_encode_nfsace4()
      NFSD: Add nfsd4_encode_fattr4_acl()
      NFSD: Add nfsd4_encode_fattr4_filehandle()
      NFSD: Add nfsd4_encode_fattr4_fileid()
      NFSD: Add nfsd4_encode_fattr4_files_avail()
      NFSD: Add nfsd4_encode_fattr4_files_free()
      NFSD: Add nfsd4_encode_fattr4_files_total()
      NFSD: Add nfsd4_encode_fattr4_fs_locations()
      NFSD: Add nfsd4_encode_fattr4_maxfilesize()
      NFSD: Add nfsd4_encode_fattr4_maxlink()
      NFSD: Add nfsd4_encode_fattr4_maxname()
      NFSD: Add nfsd4_encode_fattr4_maxread()
      NFSD: Add nfsd4_encode_fattr4_maxwrite()
      NFSD: Add nfsd4_encode_fattr4_mode()
      NFSD: Add nfsd4_encode_fattr4_numlinks()
      NFSD: Add nfsd4_encode_fattr4_owner()
      NFSD: Add nfsd4_encode_fattr4_owner_group()
      NFSD: Add nfsd4_encode_fattr4_rawdev()
      NFSD: Add nfsd4_encode_fattr4_space_avail()
      NFSD: Add nfsd4_encode_fattr4_space_free()
      NFSD: Add nfsd4_encode_fattr4_space_total()
      NFSD: Add nfsd4_encode_fattr4_space_used()
      NFSD: Add nfsd4_encode_fattr4_time_access()
      NFSD: Add nfsd4_encode_fattr4_time_create()
      NFSD: Add nfsd4_encode_fattr4_time_delta()
      NFSD: Add nfsd4_encode_fattr4_time_metadata()
      NFSD: Add nfsd4_encode_fattr4_time_modify()
      NFSD: Add nfsd4_encode_fattr4_mounted_on_fileid()
      NFSD: Add nfsd4_encode_fattr4_fs_layout_types()
      NFSD: Add nfsd4_encode_fattr4_layout_types()
      NFSD: Add nfsd4_encode_fattr4_layout_blksize()
      NFSD: Add nfsd4_encode_fattr4_suppattr_exclcreat()
      NFSD: Add nfsd4_encode_fattr4_sec_label()
      NFSD: Add nfsd4_encode_fattr4_xattr_support()
      NFSD: Copy FATTR4 bit number definitions from RFCs
      NFSD: Use a bitmask loop to encode FATTR4 results
      NFSD: Rename nfsd4_encode_fattr()
      NFSD: Add nfsd4_encode_count4()
      NFSD: Clean up nfsd4_encode_stateid()
      NFSD: Make @lgp parameter of ->encode_layoutget a const pointer
      NFSD: Clean up nfsd4_encode_layoutget()
      NFSD: Clean up nfsd4_encode_layoutcommit()
      NFSD: Clean up nfsd4_encode_layoutreturn()
      NFSD: Make @gdev parameter of ->encode_getdeviceinfo a const pointer
      NFSD: Clean up nfsd4_encode_getdeviceinfo()
      NFSD: Remove a layering violation when encoding lock_denied
      NFSD: Add nfsd4_encode_lock_owner4()
      NFSD: Refactor nfsd4_encode_lock_denied()
      NFSD: Add nfsd4_encode_open_read_delegation4()
      NFSD: Add nfsd4_encode_open_write_delegation4()
      NFSD: Add nfsd4_encode_open_none_delegation4()
      NFSD: Add nfsd4_encode_open_delegation4()
      NFSD: Clean up nfsd4_encode_open()
      NFSD: Add a utility function for encoding sessionid4 objects
      NFSD: Add nfsd4_encode_channel_attr4()
      NFSD: Restructure nfsd4_encode_create_session()
      NFSD: Clean up nfsd4_encode_sequence()
      NFSD: Rename nfsd4_encode_dirent()
      NFSD: Clean up nfsd4_encode_rdattr_error()
      NFSD: Add an nfsd4_encode_nfs_cookie4() helper
      NFSD: Clean up nfsd4_encode_entry4()
      NFSD: Clean up nfsd4_encode_readdir()
      NFSD: Clean up nfsd4_encode_access()
      NFSD: Clean up nfsd4_do_encode_secinfo()
      NFSD: Clean up nfsd4_encode_exchange_id()
      NFSD: Clean up nfsd4_encode_test_stateid()
      NFSD: Clean up nfsd4_encode_copy()
      NFSD: Clean up nfsd4_encode_copy_notify()
      NFSD: Clean up nfsd4_encode_offset_status()
      NFSD: Clean up nfsd4_encode_seek()
      NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
      NFSD: Fix frame size warning in svc_export_parse()
      svcrdma: Drop connection after an RDMA Read error
      svcrdma: Fix tracepoint printk format

Dai Ngo (4):
      NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace po=
int
      NFSD: add trace points to track server copy progress
      NFSD: add support for CB_GETATTR callback
      NFSD: handle GETATTR conflict with write delegation

KaiLong Wang (3):
      NFSD: Clean up errors in stats.c
      nfsd: Clean up errors in nfs4state.c
      nfsd: Clean up errors in nfs3proc.c

Kinglong Mee (1):
      nfs: fix the typo of rfc number about xattr in NFSv4

Lorenzo Bianconi (2):
      NFSD: introduce netlink stubs
      NFSD: add rpc_status netlink support

NeilBrown (18):
      SUNRPC: move all of xprt handling into svc_xprt_handle()
      SUNRPC: rename and refactor svc_get_next_xprt()
      SUNRPC: integrate back-channel processing with svc_recv()
      lockd: hold a reference to nlmsvc_serv while stopping the thread.
      SUNRPC: change how svc threads are asked to exit.
      SUNRPC: add list of idle threads
      SUNRPC: discard SP_CONGESTED
      llist: add interface to check if a node is on a list.
      SUNRPC: change service idle list to be an llist
      llist: add llist_del_first_this()
      lib: add light-weight queuing mechanism.
      SUNRPC: rename some functions from rqst_ to svc_thread_
      SUNRPC: only have one thread waking up at a time
      SUNRPC: use lwq for sp_sockets - renamed to sp_xprts
      SUNRPC: change sp_nrthreads to atomic_t
      SUNRPC: discard sp_lock
      SUNRPC: change the back-channel queue to lwq
      NFSD: simplify error paths in nfsd_svc()

Sicong Huang (1):
      NFSD: clean up alloc_init_deleg()

Trond Myklebust (2):
      nfsd: Handle EOPENSTALE correctly in the filecache
      nfsd: Don't reset the write verifier on a commit EAGAIN

 Documentation/filesystems/nfs/exporting.rst |    7 +
 Documentation/netlink/specs/nfsd.yaml       |   89 +++
 fs/lockd/svc.c                              |    7 +-
 fs/lockd/svclock.c                          |   43 +-
 fs/locks.c                                  |   12 +-
 fs/nfs/callback.c                           |   46 +-
 fs/nfsd/Makefile                            |    3 +-
 fs/nfsd/blocklayoutxdr.c                    |    6 +-
 fs/nfsd/blocklayoutxdr.h                    |    4 +-
 fs/nfsd/export.c                            |   32 +-
 fs/nfsd/export.h                            |    4 +-
 fs/nfsd/filecache.c                         |   27 +-
 fs/nfsd/flexfilelayoutxdr.c                 |    6 +-
 fs/nfsd/flexfilelayoutxdr.h                 |    4 +-
 fs/nfsd/netlink.c                           |   32 ++
 fs/nfsd/netlink.h                           |   22 +
 fs/nfsd/nfs3proc.c                          |    5 +-
 fs/nfsd/nfs4callback.c                      |   97 +++-
 fs/nfsd/nfs4layouts.c                       |    6 +-
 fs/nfsd/nfs4proc.c                          |   32 +-
 fs/nfsd/nfs4state.c                         |  156 +++++-
 fs/nfsd/nfs4xdr.c                           | 2700 +++++++++++++++++++++++=
+++++++++++++++++++++++++++-----------------------------------------
 fs/nfsd/nfsctl.c                            |  203 +++++++
 fs/nfsd/nfsd.h                              |   17 +
 fs/nfsd/nfsfh.c                             |    2 +-
 fs/nfsd/nfsfh.h                             |    3 +-
 fs/nfsd/nfssvc.c                            |   42 +-
 fs/nfsd/pnfs.h                              |    6 +-
 fs/nfsd/state.h                             |   27 +-
 fs/nfsd/stats.c                             |    4 +-
 fs/nfsd/stats.h                             |   18 +-
 fs/nfsd/trace.h                             |   87 +++
 fs/nfsd/vfs.c                               |   61 ++-
 fs/nfsd/vfs.h                               |    4 +-
 fs/nfsd/xdr4.h                              |  154 +++++-
 fs/nfsd/xdr4cb.h                            |   18 +
 include/linux/exportfs.h                    |   14 +
 include/linux/iversion.h                    |    2 +-
 include/linux/llist.h                       |   46 ++
 include/linux/lockd/lockd.h                 |    2 +-
 include/linux/lwq.h                         |  124 +++++
 include/linux/nfs4.h                        |  262 ++++++---
 include/linux/sunrpc/svc.h                  |   45 +-
 include/linux/sunrpc/svc_xprt.h             |    2 +-
 include/linux/sunrpc/xprt.h                 |    3 +-
 include/trace/events/rpcrdma.h              |   10 +-
 include/trace/events/sunrpc.h               |    1 -
 include/uapi/linux/nfsd_netlink.h           |   39 ++
 lib/Kconfig                                 |    5 +
 lib/Makefile                                |    2 +-
 lib/llist.c                                 |   28 +
 lib/lwq.c                                   |  158 ++++++
 net/sunrpc/backchannel_rqst.c               |   13 +-
 net/sunrpc/svc.c                            |  155 +++---
 net/sunrpc/svc_xprt.c                       |  238 ++++----
 net/sunrpc/xprtrdma/backchannel.c           |    6 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c     |    3 +-
 tools/net/ynl/Makefile.deps                 |    1 +
 tools/net/ynl/generated/Makefile            |    2 +-
 tools/net/ynl/generated/nfsd-user.c         |   95 ++++
 tools/net/ynl/generated/nfsd-user.h         |   33 ++
 61 files changed, 3531 insertions(+), 1744 deletions(-)
 create mode 100644 Documentation/netlink/specs/nfsd.yaml
 create mode 100644 fs/nfsd/netlink.c
 create mode 100644 fs/nfsd/netlink.h
 create mode 100644 include/linux/lwq.h
 create mode 100644 include/uapi/linux/nfsd_netlink.h
 create mode 100644 lib/lwq.c
 create mode 100644 tools/net/ynl/generated/nfsd-user.c
 create mode 100644 tools/net/ynl/generated/nfsd-user.h

--
Chuck Lever


