Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3D7E8B80
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Nov 2023 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjKKQJp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Nov 2023 11:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQJp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Nov 2023 11:09:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0C3A8D
        for <linux-nfs@vger.kernel.org>; Sat, 11 Nov 2023 08:09:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABCdWV9006815;
        Sat, 11 Nov 2023 16:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Qz0FtKugDQacf5eWJPoRqYd8ftqUWktWjtKZvqeDg50=;
 b=lyP8gR5PhfajUvZ5p3grIcTWcWSplhRYUWFVXdldGWI3Yab6kOaueNdIbpmiDXq5xRSA
 ASeEFSTo8EYO9qPwJH4FKgkdIH6boqPG/rp0InquRvBu9oF3m5Qb/gHuETV6ukeQ2eUF
 SANHbPFaRsmf/J/OXC0THBwu92iCohY9VX8nOba2Sv/wGB8zRtWLrX0nuAFEtChPPTh/
 3vq3FAc/0zJi0mAQQwGcTzju21b7TR4zWHj4w0mRFsRgH1TrbM9sE9B0yx9nIrYhVhdf
 foTJ6otPhawiNBpBWcrmSXtoRhBQpDN1t0MuG8pgi8j5owOQeA4E1fQwQ/a+eOGs1me2 gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjgg2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Nov 2023 16:09:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABFulUX017554;
        Sat, 11 Nov 2023 16:09:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ua022rk9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Nov 2023 16:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJ1RlYePQ2QVplEh9ybUA+r4trX5tMXjrLB9PdpoHgxXZ+AgRSsIf1a1O6kpgp4BthLGHS7K/FNSusvNJFakgijUPL/cltfqcVJq4NaU6juASkQWV5CbGc8D4S7TSzvBOFw38yf2/ka+YKshgrRT6TexaowGeOlCaCVspBiFe/XDsjx0o3OmWFL9wf9wEM6Ij/H60HGpBqu/IJJzFvHqkbnWiMdmvWzID2+l383E0Y6xq/cIcpd7cG+EGgYW/UD7wK0spMXH9IrLNduf/GWyY/Jzavh1jCDUKmiFtlrKK/89WAjfc5p8obZQu+ZJMeiXIiTT0mdA6N+kl2ibqFlQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz0FtKugDQacf5eWJPoRqYd8ftqUWktWjtKZvqeDg50=;
 b=ScfPcwmawitURrSGhIg4/A7BaNSQJw5IL1WURL7HMoQ7qhD5NrJs2IfqQiNXqvfh7g71C4/SZpzKxMYtkhTYRh9vvNevd7AFQ2JrkHSAyyUVp+2OwlPCrWJUBCOF4fN8coahXhZ8zB6D/7Hm3O0PPUOI0rgvnD+1lYr81ciIo9oLUPicvJUyFc/p0bNws189CoGyB0RZF03dV4oq0mLaf6riAWlEvShSzxDMPSxk+Qu6/CKZ067damh9tFAm3V1fqs7j/3Ym5rwwxycOTtqVSGttPGTzqwC+cn/y9KldC9tzxFVNflui3rXdgKSva1KTzPQR4DTCg1zbIDudymEzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz0FtKugDQacf5eWJPoRqYd8ftqUWktWjtKZvqeDg50=;
 b=NEsY9FWIFPrkRYv1LBvjcVZz8fBN91c/OelFVJAMLwVkRMtwd5v7kJ2FXuuvdKfRpooaDyshuEa5zfa9NN3GULmoTr+mn5Bi7nLpXLxEtUJHiK3cDrCblLNjCYhBeNXk3uJxCnKdrKHXn5oZeMhRtaW/iSMetIj0vG00iCItQCI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sat, 11 Nov
 2023 16:09:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.026; Sat, 11 Nov 2023
 16:09:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] NFSD DRC fixes for v6.7-rc
Thread-Topic: [PATCH v2 0/3] NFSD DRC fixes for v6.7-rc
Thread-Index: AQHaFAOMlfa2uh2tO0uAE/+hJNHd17B1EPQAgAA544A=
Date:   Sat, 11 Nov 2023 16:09:34 +0000
Message-ID: <B1438156-445A-434F-B2E1-B9DBF0F25596@oracle.com>
References: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
 <3d6a4bacabe0d79eed87f325e73c33df74298404.camel@kernel.org>
In-Reply-To: <3d6a4bacabe0d79eed87f325e73c33df74298404.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4527:EE_
x-ms-office365-filtering-correlation-id: 3572f041-06de-46f5-3ade-08dbe2d098a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KG41/mHsgtgdHzM9KqnyKWAH064KER8uvfGdnBrEPDqE21tx1kJOP6G4cvFB9vrG2Ktxf+gTgI+TjLyWApmDrUJaiwII7oHFYeRrsxBoFMBc5GxQ3oPV4hxbaqrOD/NCaJ/cWjPOX4AnREenQgX6rNJWOgAN8ixzU4BGg81tZPvFN4P7BU/W7SXi0idxOmj0eXWQ1w0HY2Rx8KVcWZ+mPJnOe/Ig5wmgXNwzMmA1mqGFMXUme9s0tie7YMAvRu9GNS2R5C0D6fqxPulrQVVqaj3uoP33uDcFRa+NFw1mqdR44T8UwMzWI38M9+XkbUC4ylq6EhLbYvVcyLllzD2tmpdKv7dvqQ4w8240oSGzuEumf4Zupo21vqo8kmTi/q/Y5WVl7Ih1zQ/9RThf5fkJNWF/lmnT1zvBfDtnDpvU6KK76+6IPnns35EXN+l/EpA6cEckhlcKNBHwl9EOg6aJ0hEKUJccWvVcQqNO5iKIXlga/y4e1q8+Y1E3gUBAH5WNgcFllyjg81mVSPlnxD6Rw/Rl6gn2ra/sPc/Zk9C4St/cn/YFkI3iXHZvkg5J6j2BqsiTmnNgdm1AEPCFCGDlrnmrCUe/AVhCpOKoDUyZXh0FIJd6TqYbNoZ4S6IOCP0AOfZuv3KZWC2tyLhKSPXS9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(4001150100001)(8936002)(2906002)(5660300002)(122000001)(33656002)(8676002)(4326008)(38070700009)(86362001)(41300700001)(26005)(6486002)(6512007)(53546011)(6506007)(478600001)(71200400001)(2616005)(83380400001)(64756008)(66556008)(54906003)(66946007)(66446008)(66476007)(76116006)(38100700002)(6916009)(316002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mrhx/TIefiKZc8XWvJd6NbEjS91HlbmeTdvW6T6mVyLpBb9N1zE2yj/gGD6C?=
 =?us-ascii?Q?4EipxO0xzKcGV47qpGh6NLQQd0WcyPDqKpoVNvZRjfKWWNPd17aONQE4Tocy?=
 =?us-ascii?Q?Jos7ak6MufMaTjQnlSZfUT9PAjC17PuYKZb48QjHvuKhKY/9uFqModKsdqJd?=
 =?us-ascii?Q?Rpj6Si6Um8tlxYOdgKaFNyzC2GTZYZ3Q7APV2/OjbHlnver8fwOULaHGJ9r5?=
 =?us-ascii?Q?6yu1mtLOonbhC4JO5505IwYksvk2ZU3QPn4K/Zw6rSAIuMH/lBNxnTkzTOsO?=
 =?us-ascii?Q?T7R6UXkzgaXQmjTjktCc2nSb77WBEY3IhfQuVxWMIucpn8d6oADwLpTsLzEx?=
 =?us-ascii?Q?0JCxHmdSZO14veNZO9DUFdaQnBcU2GdjEXm8SlCKAAIoXCV5ND5uq/L3X0ZD?=
 =?us-ascii?Q?//VjD7L5YA3H8gTh5QH1PySqDHMUXZpykY1Q8Rfip/Z2B77SHBQIhHAxY5D9?=
 =?us-ascii?Q?uNOWHdJNOpIFgeQzjUIGjWDcKpQDjXaRljBbruy9OcUvxAZRaoAuVeXfpuWL?=
 =?us-ascii?Q?O4SVQ6TDfTdqXWGcS4hjXQ6G6b6zgCug3eh4BZclHXyzEsNms9iUUcuzI2m+?=
 =?us-ascii?Q?OA1IgBwka4qoe+4Zp+EtSBJBAXQkL5ta+2N+nyafC9T6eqFQ9jE1WGEps2g9?=
 =?us-ascii?Q?E7G4wiCPFdgB/tBX4nejy+vf36wx9SEPwQwGUk2M9Fv4/MzBiXQHfKqK/rjb?=
 =?us-ascii?Q?jB4kPqjg7Eh61hX3YQSYPjADa49UitCIYcgOx0MnhMTmVfeV8QOUL98jeAkw?=
 =?us-ascii?Q?rVSozths4jMd1Jsyj4ZLcJ8ENBqeRnWtw4qVVQ9Mp/kBRks0m7vOThQtvAQi?=
 =?us-ascii?Q?7M8hdHx56N+Vpg1EEMDGSxpEcOCKUz9FAkEmONaAaJbWvxb1zbwP5JXtgYy0?=
 =?us-ascii?Q?zv9t5Fhfj8oKH0+v90/faLOkatItgL9BIyZ8ulutcDdwio+MKzY++TmWqUkz?=
 =?us-ascii?Q?t4olq8+u51Uc8t6qSQUYqOilfiXdG68oYO5iM7weaxCoNrgpyCvp8FRi9CWS?=
 =?us-ascii?Q?ariyUpQZ9QorEUWWOY1zJhLwUxnDQmDDz9TG9aPUAw0jM8WuGSy1Uzh03pjN?=
 =?us-ascii?Q?KwyC92hkTI9Mht8UtAugT8BVvX++XAvTuJKULIkVR0c3jMqN1cuyyr/yoWZP?=
 =?us-ascii?Q?uY2RvFiwwqsuojNXtnn68kADfYIYSR78N4zazNH11TMVjqnuCu/cFD3WF0BF?=
 =?us-ascii?Q?esdMm0QQ4INSBqy4WM8k3oO6VG+kPKEctFaArKELL8HF+10sNSurRTXw/tUv?=
 =?us-ascii?Q?DesxIIYhAbSwrsp1pG8V4p5GSW4u8H7B9Z4hmcKc+qpX+S162Rjffyz/Bw3l?=
 =?us-ascii?Q?w1g/z0JdXyfnHU/EhkWPFcEdpQzfIc/GpWAUgofNY66cKhwoqhDqMugIZArv?=
 =?us-ascii?Q?sDBDSEdo6/GLcqw2gzoMDHFHHNl3MZ+vJ6+mbJpDx4dM9uL9Ly9d2hIbXBTb?=
 =?us-ascii?Q?jS/zfQk1rPEjlYPuVvg2UnBwIQF+aeppKcEQ4xhb8Q0AWxnt/QTaeGbIJq1u?=
 =?us-ascii?Q?5rv2Q1LEle2WtIZ0ZBXrom/G4f8LI+aXfCzFvjV7bwPKn3gA/dXnndIFCEIo?=
 =?us-ascii?Q?bPBukA/3xu6iX5KnSrKv8vV5dtqzqVLjMw3v3AIrE3ylvXwTlIuUIoBoZaVY?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD591FAB2970A64989FA5A03AD00BB18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aCnNkskbFXEfFoHgmWf5As3+qcGohBZREofO+vQQU1N+Kq6rXQXn4kT51PMiEgSfGZ+WrCIWpR/oAH2/uf8AmmqACPo5ZVZerbOv3RdsPQbn5AFeTLDRqyhBwETN+9CfBvSckmP/W+gMP/uMz7BorsZsbxAAzIIgmxUBUTr1oN3Nf/FjNuCZNMGlVDLT6INqR10qHiPNWSf9eN64G1sdji/TiIQRvJjgR8I1+n/q+3fFOo3KnG4pgvmpG4SdaiojRDtgYiag5VkX+qON8Sk4xymKc9SMol4mVkNwrAp8+Rsmzq7eGxIYaeEiNMUBVn/loC6VdWf/8GKgosEPQy8uPE8U+PTqFmksFgNi55o0R2ibZpNdVlVYGenUyVt/x6nTOX1tY17T4WM0+5zJTdrxNnUY1esbztTuOIt5v8mehXAN2Ef86lH3j5nS/ULEO5DHW93/RlKe4EFtjvQOsIIfculBPOSeZHtUOxtTmdf7GBE5Ccu+fkAvdnisP3vSRJiOord5Vaot9oJuvLLHvBu3CE9gXH9+lEB6HOg2s9o6vgCHtIylzHePhysxqhO8Q3E6SQdJtkqc/qAcvXeAMbXsfntf+szYJ3xh3vJ7Vy8u4R74eGjaPQHNZ5tNbDC/ZdiBmrLoj6nWgGQm5lRvp0omJa4gKgzJZFj2Nt3FDIYBIXI83UDNWJuX5yR6POhEDL3bTBmKMMOyBHfNMpGLT3qe03zqO0Xaos2mV9kiWD/PwCW46um4fFfHcReJn17x89tnAPRt8BFcI8EI7eAmes1zU04Sjjn1k+06ap9EFbkkiOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3572f041-06de-46f5-3ade-08dbe2d098a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2023 16:09:34.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDzRsqDzUcdfAxqBPglvd4UkQ5f+x2wRz4YpI1iPdeWItauAuoyeVSnI3NjkK45AcGH8bogIfviVCxnJ3aTa1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311110138
X-Proofpoint-GUID: LyCQxJ942yBSCNFm5ZWrxlqLbLNuu-7w
X-Proofpoint-ORIG-GUID: LyCQxJ942yBSCNFm5ZWrxlqLbLNuu-7w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 11, 2023, at 7:42 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-11-10 at 11:28 -0500, Chuck Lever wrote:
>> I've chased down the reported failures with krb5i/p. Essentially
>> the DRC was broken for krb5i/p because of the extra crap those
>> security flavors stick before and after the NFS headers.
>=20
> Huh, so the reported failures were due to retransmissions?

Good question. This cover letter leaves out some of the story.

I noticed test failures when running the git regression suite
with 12 threads on a sec=3Dkrb5i mount point, proto=3Drdma. The
failure was 100% reproducible. I saw some retransmits in the
mountstats error counters.

The initial trigger of the retransmissions is GSS sequence
window underruns, which are rather frequent with this test
set-up. The server is mandated to drop the request and
connection after each detected underrun.

At first I thought that getting rid of the underruns would
fix the issue, but then realized that that's not possible to
do completely. Then I realized that a simple retransmit is not
supposed to result in vastly different application behavior
(at least most of the time) and so dug into that.

The hole I crawled out of at the end was that the DRC was
busted. And not just one bug, but three separate issues.
Once all three are addressed, the test passes on krb5i and
krb5p.


>> These patches do address bugs in stable kernels, but they will need
>> to be massaged, tested, and applied by hand to get there. Voting now
>> open on whether it's worth the trouble for us to do it now, or wait
>> until someone complains about a particular LTS problem.

I haven't been able to successfully build a kernel older
than about v5.18 on my Fedora 38 systems. I'm thinking that,
in general, we could test stable backports using kdevops
with older Fedora vagrant boxes.

But I haven't gotten the full kdevops environment to run
here yet, and thus don't have a git regression workflow. And
I guess we don't have RDMA working in this environment yet
either. (siw might not work well or at all on older kernels).

Maybe the connection losses could be triggered instead with
disconnect injection.


>> ---
>>=20
>> Chuck Lever (3):
>>      NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update(=
)
>>      NFSD: Update nfsd_cache_append() to use xdr_stream
>>      NFSD: Fix checksum mismatches in the duplicate reply cache
>>=20
>>=20
>> fs/nfsd/cache.h    |  4 +--
>> fs/nfsd/nfscache.c | 87 +++++++++++++++++++++++++++-------------------
>> fs/nfsd/nfssvc.c   | 14 ++++++--
>> 3 files changed, 65 insertions(+), 40 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> Wow, nice work tracking those down. I'm sure that wasn't easy!

The hardest part was not giving up.


> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Much appreciated!

--
Chuck Lever


