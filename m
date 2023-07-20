Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7318F75B141
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGTOa7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGTOa6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 10:30:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D51F2704
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 07:30:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDd6O9023425;
        Thu, 20 Jul 2023 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MHO4XF3wZEicC/U8NVm0S5RC+U1Ys5dGZMu2sC8d/Bg=;
 b=NrW8kIX72PUr/gSzFN2xJC1H6v9kinuYb4yYFTg7zCIEwFd8yqhBa2FncjBMuFri50ou
 pbFtbV/inw4T75jmvjpYzhi36ijNwwSW5VMnp33WzGfw6dSigXp6v+DE5MG7Sz9rZX+z
 vtFGCXQGoHgRppbtyFCR7EguDME6XkxLVDw8usj6MABmatlN6oGas3aQsZkIsqTShkZO
 /D49V2cxfBuev63wRPeYCAaEusQe4uYjfH8m4U5R1BmWC9aAtnBPRPk9Ce+sIPwGlAdE
 HBK/Sx9FiPRNZ36v5FIR1LMTuro3MK7fa32hs9tY4ojr08RaWxHiu7uFiGgWK0jhvn/M Mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run789rtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:30:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KEQPJ1019336;
        Thu, 20 Jul 2023 14:30:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw97r1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEjLg2sIui5rPybw0KVNUwR7ObCheiXovYf+PgjwngxIqN6vbOnkbu4pmT0DqTwwRebu3fwkkFj0oUG5932apIxtKGNo72YJ32cn864CzqZYwtwalulVtjAd7XTXdGLnJnp5fH+dwDwelww2AwcEdIt9Uu3R9ro+xPT4JHlrAIyiednmr2HYEaNx9/6uUhgMiXDrQKQAUgEzy+NVk706dsLFHJyiLWUdJ1cubblJuIUvDAMZ1GphXwIeq3Tw/R7MwCnYZryVkdkEJUzVQnzCPHcfaIcjom7O/tFaH92KhLFGZwLFc5KqnM8MQEGFFYDCVpRELEsoIDZItNXNpVQBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHO4XF3wZEicC/U8NVm0S5RC+U1Ys5dGZMu2sC8d/Bg=;
 b=c48AQlDhMEqVz8JKo8QvhHG2T0Knij/ZWwvXmaXOMi3WRqkqnIet0xol8YGQo96cKN4vs5MgScq4rbtgSyCPIDQR5vwhi1PXbZcyaGxcy+1zuX2zLElg3BLLgoR1la7ETf6moyoah0celYGYa2ApoVnfZ2WOp0mvwa9uxBm8qsoPJ7p01Tk2fqpolRELpYY/XKXKQIKO+Ni3InMXbc+Y9fOc8/FpYrJqBBvrjpOiQg4AoYb9flE8A8j2QEwB4AiyxyeI2j4s3aI4BnIvDbnE3YfKibl2yMyQN3/V42lj5p2hJpMcDa9HJ1psQ4x9V2qhzseIgRcPKr2DW52DdA1GnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHO4XF3wZEicC/U8NVm0S5RC+U1Ys5dGZMu2sC8d/Bg=;
 b=To+Wcdw+bbvVg5eyw3Zc+RnUvv066hojxv1kHz5h+pG0b/iMMq2b1bFHt5Mi1KMeJc3MIZgE+hSTsxuSb/ZKLZhu5zbv02xXaLcGHN6G/NuTmdjN26Jvhpj+hZ+CDa7y2YskIOHlpXzAGkNYJHRLsSefODPGrmSHkQy0AFJ5YNs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Thu, 20 Jul
 2023 14:30:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 14:30:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: oops in nfsd-next branch
Thread-Topic: oops in nfsd-next branch
Thread-Index: AQHZuorXdNBxFgcDg0qLkVfZ1Dwbh6/BwUCAgAD3IIA=
Date:   Thu, 20 Jul 2023 14:30:40 +0000
Message-ID: <94EC14A7-F0E4-481F-8309-08BEF4A26075@oracle.com>
References: <554d3bcc05c2e1e3624607c9fa543d6aea4cfadb.camel@kernel.org>
 <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
In-Reply-To: <E9A71D57-83DE-4E04-8CB8-073244B88392@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6290:EE_
x-ms-office365-filtering-correlation-id: 69d86e2a-8c63-40cc-a88d-08db892de4d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKWaJIKmpMhQqZeM69YA+ynyjeldMhDle0W+046o2mGVPx1/gq0Wxqxa/t92DbAIIeKEUw+atGqUhVFIveoeoxAKctN2vy0nHukH9Z0dEJPBbt4iYbvFOwgxX5XOq21WkPJfSJ2z5o+eTyH5Sh+KXLetoBrOIUn63qgRaoxRzcBZmHCJcbsGMS8YoebjkWUjl5o6PoHn/5aFfTE1yXDKQmEUzj7XrUTe4mFA/UutYDsLaOLA2ELWq6FDEfL+plKQu1qvEgD91S0MXgEBpsIjBmkXhMq9aOBJEFVbVB9BJrg7DRbbxfzFjRm1JM6P2VlXHwvroKff+9wWFxGzunLtMk7pFiXvEalG7vHgvXTjeFh38/QG11l647iy5yD4J1s2PTzNec0520sMtsc+oI0P1Nm5QcNFBjh9ZYAd/aYCN4Libg5zg/ZpNDwFpT6EJ0Sqc0noicoJygHlKRZ3arFuZ3J1SevzSJTjBOZ7rhQC+9i7mcloonm3C0O2th470TZScXqQKke2ngwd55X/TnkXLFSs4V/jGnaD2+OXWsttVWZcdCfNOfemWMxqy4RnsOdXFrfBmG7uKdJFBOAQq8742ARGSGKFhEDjcdwCyteEn//oOPSacDqACd5vil/twNrXdWeWcushCCqS95ORf6ymag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(71200400001)(122000001)(6486002)(8676002)(6512007)(6916009)(45080400002)(5660300002)(41300700001)(66556008)(66946007)(8936002)(316002)(4326008)(91956017)(76116006)(66446008)(64756008)(66476007)(478600001)(2616005)(186003)(53546011)(3480700007)(38100700002)(6506007)(83380400001)(26005)(86362001)(38070700005)(36756003)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ta7UL3Oea+PxcAv6BJoZ37LzVAy5/h6mxLa8cP4sMPM5bCQxodaCqK5vP5q7?=
 =?us-ascii?Q?RI5drkGec04jY1lf8C94+cCgxUVIEIyu5Vpp4Xk332HroF7eR/8zRsUyr73j?=
 =?us-ascii?Q?KbACY/mo4mEzhiCoSwjOfr3VNEXZ0vt9QwEszngcJD/qmKqiaE9KKB7/mCB8?=
 =?us-ascii?Q?gYl2D9b6eLM6Yy2nNexnVLrt8wVqx9iZcGhaT9ID30II67hw9CsaeiOmopQ9?=
 =?us-ascii?Q?stA35Myv7IrwRJynP4OeWwBVibUivsPmHTlwJZqe7nOqV0sFfX8tpzIM9y02?=
 =?us-ascii?Q?EqYTaeU8LvBCUfM1cj1ZIsYg9f9V1baCd23AyiYUmlTTyD3d2gG4Al0zc1tU?=
 =?us-ascii?Q?gKvGST7tOri79g4BiaEVwlMVzyk8yfRuWu1bmYv2+PvMS7hCvVFmhXC0TsDf?=
 =?us-ascii?Q?PYzFZ6bK3OVWnJ433zh04lTMPp4frlaOPtjwagn04eV35IHglPTlF7QlS2aF?=
 =?us-ascii?Q?SGWoI2ShJfTvu0nzh+GcIE3C/z+Bz6WbWpY94+/u9owbQ59Z699Ttbn/Rfeb?=
 =?us-ascii?Q?tA08oNA83LamrrXkFtUx3ZcvO3LO/fIV/eLT04TZza0stxEUmxei1EjLI0id?=
 =?us-ascii?Q?DvcF8Cbc+LE95D2Yz1U2dzCy+1RoKNg1YSA72PqzXpRh8oGbNcikfG3hh96j?=
 =?us-ascii?Q?GmiueAX4yuYtPPrNFgiOKYT9vX4HZGhzH+LVINDaQvMvjKpZAWOO3kb4sFpW?=
 =?us-ascii?Q?61PBJc9OOdcxxNEH9CJb+BJuXHOxZFdw13srIifeFoX847pJ7+kq+SFPS9OF?=
 =?us-ascii?Q?OtPVEviTsg4EZZqd2oZ/aEjcQ7cB9Ep0sKy2l3mH8olME66QB5q02odRX73L?=
 =?us-ascii?Q?wxHhTT33O1HVYb1q7x2y7iBRWLD2xDyEZ7pZEmwHHtFODIfnbAfF2TnGyiF5?=
 =?us-ascii?Q?Z6g3Oszqj/PpxLqcVg12gQvh7BtxhrdzRZdlVD6T0TJpoVeE0MPpi/ShYLzL?=
 =?us-ascii?Q?N2a2u0JoNUL5QBsRgckzKFiwQCQJ0rfJrVX/0KmxWvCXMWAm9V1OeceiKTC2?=
 =?us-ascii?Q?C8FsNZQ8jEO5RSo5PPszSgRTF6jAEUhn9IOkJMbu9UrGdgGuKLslzlSuCZLq?=
 =?us-ascii?Q?jYCeZNQM3XMU5unE/RE5zmmi7+3YqYuOA1OvrgtggeNIn+TNgnv9n81GXN+u?=
 =?us-ascii?Q?D49zjOyvmyl7sOqtMIrmXLNPct0YBpELbLVeSu5LhJ7Bt3TcslEK8qnY1NeV?=
 =?us-ascii?Q?IOiBod4hy43A6yoIBqdPoJc1qr+gsaMSFWNJUfgFC4V/rCmsufP946ESQ4DQ?=
 =?us-ascii?Q?YwG6Cc/HsIqgcIpCyiadnSK/CuJROd+Ugf2C5s4NLgf9Gv2tZH6O4hUSKc+s?=
 =?us-ascii?Q?liOj/GgMuiQKzI8+Us/jkHaYOnrDDXuayurxGYmfJCimssHuX/2OLyZXYrrn?=
 =?us-ascii?Q?qZdi+EeeQNnruEJlOyWMt74aGpgGc2I7O2N919Aoft/9900Cuey/AC4MZH6G?=
 =?us-ascii?Q?d0mOcas8zLto1TWoAKYVJGHNKBrFVzE9Pl2SSBZKOWoUqJA4rsNXuv3Y3LPS?=
 =?us-ascii?Q?D8iKriSqiUZuLN5mL74E5A6X7/lSRmk10JQmMxV/nMWmJ12ko2B14emUBTR8?=
 =?us-ascii?Q?0Ax0APmYf5qIyhfoAgVkeev7AoWThDa0spe+nIfamrK/dx67ZH6WnYkBpkIY?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80A02ED1B170E943A17FCD983FAE7731@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tiPnBodUGLFN6E7zRNfPT4LUxBUB9ntqM2fz3vacuN8LhthAG9P1K/Y7Bcn5uxedgjID2jOq8R2u3lTWC2lC3ugNkXwADAEHjhM4t/Dqr4CZO1J1GgYqED2AWqNiZPvbI91gy0GTCxTo3Ai0mTQgVk80WpdegmAf6dnDtD4NM1EuHuj3tgnAHiecFBZphciUFLZa2Gd4GzHINQGDtApgGROLBPPiX6PUFuMl48U5+zQdVWxioluc6T8pZUGKMarcSsCRxV32e17BZ1WM6leL42rh5UxWXsVEu14vi2gWah6fDgJjW2TOxkFfgzZO23OWoJ3K/waaZYNg59htLFHDnXruo0MjXrB5GiCyddPNEQmTmRC5rlW39ImKYu4DSjwkKztbksu9xKuK2/Z9LHGLTRZZkfUQ3eqenpYlmBq5qSFPY1r4fY7UQBvtjbviRffuOBcf3jyqPDHBc1uS1GbjRhA6XEu6VgdbMS0UvUMLCkD69LiklDjfsiTRDQlhGD/jfCnYH7zFMy6LTUY/Yb1x3HKrrhziQNQdnNnZqOaoSlr5dn8m4gSEYRkcc9eSFiETJk5YZo0fJVp3VZXeKqSD8a2MmaoXFmSXWdRYg2jND3C9AwCBSArZ37jnu3U5DCVUznacpyZNzczPHu/HmWijPSChJRyHz+Jb4wp/mYxad8t8FL9E4hMty1ACzTSPw42JBcGOB/CFzRXr4FcrR0J3KI7NoVR51NY8C9mxCbJQcOxOzdstEkYdDFsv5ErD0+yksgNTGlzTpTAFGB/+Y2CzsyulQFarli6dBwuejOO7J/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d86e2a-8c63-40cc-a88d-08db892de4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:30:40.8187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrY/1Nrd9qEj/VCiJZBfhBmn1Fhro40m6MvkctdNLSCdeJarbTv9vxdch4OEwttGTVJMrUXHqyTcTQXrmuf3pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200122
X-Proofpoint-ORIG-GUID: Bq9Ek4SJtZnJvY1T5_cSBLgxSBs0Xd2I
X-Proofpoint-GUID: Bq9Ek4SJtZnJvY1T5_cSBLgxSBs0Xd2I
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 19, 2023, at 7:46 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jul 19, 2023, at 5:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> Hi Chuck,
>>=20
>> While doing some testing today with pynfs on a branch based on your
>> nfsd-next branch. I'm not sure which test triggers it, but it's one of
>> the v4.0 tests.
>=20
> I've just started running pynfs on nfsd-next, haven't seen any
> crashes so far. I'll take a dive in tomorrow.

I've reproduced this, and kbot also appears to have hit it.


>> It only takes a few mins before it crashes:
>>=20
>> Jul 19 19:22:43 kdevops-nfsd kernel: BUG: unable to handle page fault fo=
r address: ffffd8442d049108
>> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: supervisor read access in kern=
el mode
>> Jul 19 19:22:43 kdevops-nfsd kernel: #PF: error_code(0x0000) - not-prese=
nt page
>> Jul 19 19:22:43 kdevops-nfsd kernel: PGD 0 P4D 0=20
>> Jul 19 19:22:43 kdevops-nfsd kernel: Oops: 0000 [#1] PREEMPT SMP PTI
>> Jul 19 19:22:43 kdevops-nfsd kernel: CPU: 0 PID: 743 Comm: nfsd Not tain=
ted 6.5.0-rc2+ #19
>> Jul 19 19:22:43 kdevops-nfsd kernel: Hardware name: QEMU Standard PC (Q3=
5 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00=
 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06=
 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: =
00010286
>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 00000000=
81244052 RCX: ffff8a665e003008
>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffff=
c0b13a45 RDI: 0000000081244052
>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a66=
5e003008 R09: ffffffff8ebdc4ec
>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 00000000=
0000001b R12: ffff8a6656f20150
>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a66=
56f20100 R15: ffff8a6656f20980
>> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff=
8a67bfc00000(0000) knlGS:0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108 CR3: 00000002=
77e1a001 CR4: 0000000000060ef0
>> Jul 19 19:22:43 kdevops-nfsd kernel: Call Trace:
>> Jul 19 19:22:43 kdevops-nfsd kernel:  <TASK>
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __die+0x1f/0x70
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? page_fault_oops+0x159/0x450
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? fixup_exception+0x22/0x310
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? exc_page_fault+0x157/0x180
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? asm_exc_page_fault+0x22/0x30
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? nfsd_cache_lookup+0x3c5/0x770 [n=
fsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? kfree+0x4b/0x110
>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_cache_lookup+0x3c5/0x770 [nfs=
d]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd_dispatch+0x62/0x1b0 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process_common+0x3cb/0x6c0 [su=
nrpc]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [n=
fsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  svc_process+0x12d/0x170 [sunrpc]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  nfsd+0xd5/0x1a0 [nfsd]
>> Jul 19 19:22:43 kdevops-nfsd kernel:  kthread+0xf3/0x120
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork+0x30/0x50
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ? __pfx_kthread+0x10/0x10
>> Jul 19 19:22:43 kdevops-nfsd kernel:  ret_from_fork_asm+0x1b/0x30
>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0000:0x0
>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: Unable to access opcode bytes=
 at 0xffffffffffffffd6.
>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0000:0000000000000000 EFLAGS: =
00000000 ORIG_RAX: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: 0000000000000000 RBX: 00000000=
00000000 RCX: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000000000000000 RSI: 00000000=
00000000 RDI: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: 0000000000000000 R08: 00000000=
00000000 R09: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 0000000000000000 R11: 00000000=
00000000 R12: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: 0000000000000000 R14: 00000000=
00000000 R15: 0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel:  </TASK>
>> Jul 19 19:22:43 kdevops-nfsd kernel: Modules linked in: 9p netfs nls_iso=
8859_1 nls_cp437 vfat fat kvm_intel joydev kvm cirrus psmouse drm_shmem_hel=
per irqbypass pcspkr virtio_net net_failover failover virtio_balloon >
>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffd8442d049108
>> Jul 19 19:22:43 kdevops-nfsd kernel: ---[ end trace 0000000000000000 ]--=
-
>> Jul 19 19:22:43 kdevops-nfsd kernel: RIP: 0010:kfree+0x4b/0x110
>> Jul 19 19:22:43 kdevops-nfsd kernel: Code: 80 48 01 d8 0f 82 d8 00 00 00=
 48 c7 c2 00 00 00 80 48 2b 15 9f d7 fb 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06=
 48 03 05 7d d7 fb 00 <48> 8b 50 08 48 89 c7 f6 c2 01 0f 85 9f 00 00 >
>> Jul 19 19:22:43 kdevops-nfsd kernel: RSP: 0018:ffffb0858661bdc0 EFLAGS: =
00010286
>> Jul 19 19:22:43 kdevops-nfsd kernel: RAX: ffffd8442d049100 RBX: 00000000=
81244052 RCX: ffff8a665e003008
>> Jul 19 19:22:43 kdevops-nfsd kernel: RDX: 0000759a40000000 RSI: ffffffff=
c0b13a45 RDI: 0000000081244052
>> Jul 19 19:22:43 kdevops-nfsd kernel: RBP: ffffb0858661be40 R08: ffff8a66=
5e003008 R09: ffffffff8ebdc4ec
>> Jul 19 19:22:43 kdevops-nfsd kernel: R10: 000000000000000e R11: 00000000=
0000001b R12: ffff8a6656f20150
>> Jul 19 19:22:43 kdevops-nfsd kernel: R13: ffff8a665e003008 R14: ffff8a66=
56f20100 R15: ffff8a6656f20980
>> Jul 19 19:22:43 kdevops-nfsd kernel: FS:  0000000000000000(0000) GS:ffff=
8a67bfc00000(0000) knlGS:0000000000000000
>> Jul 19 19:22:43 kdevops-nfsd kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
>> Jul 19 19:22:43 kdevops-nfsd kernel: CR2: ffffffffffffffd6 CR3: 00000002=
77e1a001 CR4: 0000000000060ef0
>> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with irqs di=
sabled
>> Jul 19 19:22:43 kdevops-nfsd kernel: note: nfsd[743] exited with preempt=
_count 1
>>=20
>> faddr2line says:
>>=20
>> $ ./scripts/faddr2line --list fs/nfsd/nfsd.ko nfsd_cache_lookup+0x3c5/0x=
770
>> nfsd_cacherep_free at /home/jlayton/git/kdevops/linux/fs/nfsd/nfscache.c=
:116
>> 111 }
>> 112=20
>> 113 static void nfsd_cacherep_free(struct nfsd_cacherep *rp)
>> 114 {
>> 115 kfree(rp->c_replvec.iov_base);
>>> 116< kmem_cache_free(drc_slab, rp);
>> 117 }
>> 118=20
>> 119 static unsigned long
>> 120 nfsd_cacherep_dispose(struct list_head *dispose)
>> 121 {
>>=20
>> (inlined by) nfsd_reply_cache_free_locked at /home/jlayton/git/kdevops/l=
inux/fs/nfsd/nfscache.c:153
>> 148 static void
>> 149 nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct nfsd_=
cacherep *rp,
>> 150 struct nfsd_net *nn)
>> 151 {
>> 152 nfsd_cacherep_unlink_locked(nn, b, rp);
>>> 153< nfsd_cacherep_free(rp);
>> 154 }
>> 155=20
>> 156 static void
>> 157 nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cachere=
p *rp,
>> 158 struct nfsd_net *nn)
>>=20
>> (inlined by) nfsd_cache_lookup at /home/jlayton/git/kdevops/linux/fs/nfs=
d/nfscache.c:527
>> 522 nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
>> 523 goto out;
>> 524=20
>> 525 found_entry:
>> 526 /* We found a matching entry which is either in progress or done. */
>>> 527< nfsd_reply_cache_free_locked(NULL, rp, nn);
>> 528 nfsd_stats_rc_hits_inc();
>> 529 rtn =3D RC_DROPIT;
>> 530 rp =3D found;
>> 531=20
>> 532 /* Request being processed */
>>=20
>>=20
>> ...and a bisect landed here:
>>=20
>>=20
>> 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a is the first bad commit
>> commit 767b1d5badd6eb418e3f91f0cd8fa6d2894ff43a
>> Author: Chuck Lever <chuck.lever@oracle.com>
>> Date:   Sun Jul 9 11:45:16 2023 -0400
>>=20
>>   NFSD: Refactor nfsd_reply_cache_free_locked()
>>=20
>>   To reduce contention on the bucket locks, we must avoid calling
>>   kfree() while each bucket lock is held.
>>=20
>>   Start by refactoring nfsd_reply_cache_free_locked() into a helper
>>   that removes an entry from the bucket (and must therefore run under
>>   the lock) and a second helper that frees the entry (which does not
>>   need to hold the lock).
>>=20
>>   For readability, rename the helpers nfsd_cacherep_<verb>.
>>=20
>>   Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> fs/nfsd/nfscache.c | 26 +++++++++++++++++++-------
>> 1 file changed, 19 insertions(+), 7 deletions(-)
>>=20
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever


--
Chuck Lever


