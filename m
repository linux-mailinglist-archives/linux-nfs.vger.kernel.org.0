Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FBF660614
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 18:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjAFR5K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 12:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjAFR5A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 12:57:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A17DE0A
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 09:56:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306H28BY015620;
        Fri, 6 Jan 2023 17:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gL3XDuzYLYN/k+JUlzu00vXETWzUUwCNSOH/OUzHMJA=;
 b=g6e6MF0KcQnn9uIc+oEI+Z+bf20pgm6T6bDN8oULb3eKqm16S9RBJzghvlcvsR7JitOh
 Krjz5EDItWvGhin8NXJA7ydDR8VP6WAMjbfPgAbo655nwmwEM+3wegksJgR4tDCYg4Mb
 gcWBnf+VpuEM/ZSZpqWsIwETB+Nnfb4nx/9W8PCQB0TiM/X3uoOIrRrh60/AhnPvGY05
 vNJpe9rGbdhy7tJ2mFxvd+L+KHb0ZTned5RYmBNOzOiTqSHU4iPrq1dj2QqhEb9uNlz0
 Aw+sfOqzHdhu43KvWgMMVOETafYzfhfTpEyzZuu+xFNAAXOJWeMSD0g8wsAWZYtKMC56 tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtumyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 17:56:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306Gc5Mi021296;
        Fri, 6 Jan 2023 17:56:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevm5jf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 17:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZUkXSvHJtQL2TSaTBCISz+qlSAyTaYlMEdNMFsKb3ULqGsMkXvtzncl1X7XpLSLzmRhgIfQ3TiyeqWtStxAz8TZnKoK4xefWJBjznTDSZ+L0J5rX9tphD1khRvpDtx2iD7WE2oBP2izpB+JVCdYW3ZewlFKZDId+9K9gpczm+nbwHqQ7ccGqO2TK3s3e1tTjwIM506F5X9bKvdwcy3zWv91t3o/0bYOROh8FBHrD1ZCTWZSghnc6G7oVTVW1v3Bw2L1EnfCCNSv9/VN6urZBm13nwk8ri5hQBIyumi5qbUfql9v5AoyvY02DhKP4LtBndLlCgLw1KEaXHsdZ24wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gL3XDuzYLYN/k+JUlzu00vXETWzUUwCNSOH/OUzHMJA=;
 b=RucIUabhZu5RE+ioc2UfBvID5H6OoKnl0mnCxIqZgjHI9f/L95E4kPQkhvJADCnLQirm5ZPdEHUCdqTuitOEh70qdVnv9jOd9vxnoH6a5hziIyUCJBmxAmAA7PjINrWapOXXl1Z00tWCgPGiNqRIFjDKEPu0ZrsAZSc3IxPHSiQ1e2lUNeX+20y6VydhXscA8aQq1hoI+t1UZAlW2h7V+S52xdMbnxJ9RSP2pszuucI2fF3UcPfEbksH/BmM6VPTx/RD+/UQntQELIqoo4TEUlhlmUq15lYTH+8+kuJM70p/PJygCOshBDrgyvrZqFLvuD/G5+8/bqCChQUbZeZyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL3XDuzYLYN/k+JUlzu00vXETWzUUwCNSOH/OUzHMJA=;
 b=Tvv9Sp+e/GWTRp8bZUreLb1teTyuKI0h/ygcGABj01D4y5ufuNZZ22SxnHntlijjFLTvR8T/giV1C2FDSVSjyWCljxEXtq+wT+FsgfCInbP9SphansP5rZeqeDMuTVUu8h94p69G+T5R9fmhlwkMUnpOjPpPdAEJLKnxwLPoIRA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5162.namprd10.prod.outlook.com (2603:10b6:610:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 17:56:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 17:56:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Stanislav Saner <ssaner@redhat.com>
Subject: Re: [PATCH] nfsd: fix handling of cached open files in nfsd4_open
 codepath
Thread-Topic: [PATCH] nfsd: fix handling of cached open files in nfsd4_open
 codepath
Thread-Index: AQHZIT++RVF+9Furhk+vRGFbl1gW8q6RrfcA
Date:   Fri, 6 Jan 2023 17:56:42 +0000
Message-ID: <BC8EF64C-3F08-4E10-B562-344FFD1D37B2@oracle.com>
References: <20230105195556.1557555-1-jlayton@kernel.org>
In-Reply-To: <20230105195556.1557555-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5162:EE_
x-ms-office365-filtering-correlation-id: 788b5252-88fe-44f8-2abd-08daf00f5ea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvE8c5gaFkG7V4S78SX1Wq1Ul+dFdsjDeR0e1srnxQrmePLaj6HZOw0UtF8G6516Elnfy9R+u2Xgx0A0FIkeABfWXk59M2wNPvxpRx17lAwKKBMpiJF2fwA1qg6TUsgC7XSnn2MsKtBVHnBpEE6tBVN5T4bWQEwhahNBL5L9iydZe03GFcJWXQvxkySSdtPZJ1EqBZv0gHPO8tsI/7ei978o57FfOXsM64mUK0nkwXdcEDW5EDFa3YdXUzIB7Oex1G+Yauj/vr3ePgJyXPk6runw8SW8gIyFxeRoJLk1P7VtNW8Zb1xGkHz8JlArApPAia1CnR4nHcJ24ZWNjFRViJpoEwgYAkXl73607oG/S3iIC9xLzPBsm3b7hJ38LWiDIbm5tdH89tAYT/3pKb3Mpo/N9aSTKmICaM5ol4CvqD6VYx20SMCh1kTGL/WU8v9tVBmtKrkgxWf2HwGKDzTe066fo7x3rE++LijwbB6WewdYwnx9ObLGKlZmuDTWaDmNsX28X4kAxT0ak+Ff0L8LnhyUHG1wNvxk1Tw0poyiirWtkM7Tij1Jknrc82WDrKpqA3LdDL5F7nWV26jmVwzkFJukw5PWcCCTCo8QJN7/Sq/2PkgpfKofk4VvKmn15njpttvsLvJXBTcK9GJ7yOe0HHilspEuQuApBvQiWqa04EuL33i+Wbyf3qcOzmSHQd6HN2D4Ul6a+9KLJsi1ONIol4+ForQrTAuqUGNUAWcaowo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(71200400001)(6506007)(6486002)(53546011)(36756003)(122000001)(33656002)(86362001)(38070700005)(38100700002)(6512007)(2616005)(186003)(26005)(478600001)(83380400001)(76116006)(66946007)(64756008)(8936002)(66446008)(66556008)(8676002)(91956017)(4326008)(66476007)(2906002)(316002)(6916009)(54906003)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QXT6HTYEGesfsa5DCRYTAwgeURiJCcQO/R4gxV7NAPuhkGNClzZfjT9TV/Je?=
 =?us-ascii?Q?CjWouRLRH4/Vp4Gfogba8PUrByy3kK1ph3hE9V1Tin60DlSnUwovY/G6ZEre?=
 =?us-ascii?Q?t2uqS2KWz/NjQOZBgcKcfy6UW90293m5JaOqE2ptkd/bF/k9QT/xPUNUarF+?=
 =?us-ascii?Q?VAj/4o02J4nAa98fqQd0J1YFHGb5trQdFWt2mPdizIhhtFVGXbfu7ud8Upck?=
 =?us-ascii?Q?gXTeimLmWckSNaQR0OfTfq0A3cK5hKpGqF/1RifEkXw1yVh0slLBDC5Ta4Gn?=
 =?us-ascii?Q?mYnv3nrKic6meEQMkHouKJq+xnxhUWJGCsbgJhxCCSQ3Rxnaba2mUcBikSi3?=
 =?us-ascii?Q?h9unksMhRg/eWuCOTr46gftTNakdjmTCRKF7ZK3DDcrt+5bNmhJBO4knz8Sw?=
 =?us-ascii?Q?xDyz4jiEyQgeyLAOUA9fyzbk2VUxlKpc7tKXTb6yVvgwLy7sQ5YwPLNH5YqZ?=
 =?us-ascii?Q?+j/KTKbfpBDPQl5HZ0wybROcEnE1CPksGoEe+oDexOPWpSvve1QC0iK6gLD9?=
 =?us-ascii?Q?TSPMeGCkccRXgeTQQdb6qrERy1lLONvvXmx2H0E1fGOdM7Eo3WMcJ5gPe9vo?=
 =?us-ascii?Q?fcO0fk3sib50ASjDhOl7hiepi+QEzb3GGm0AbbulJT5r4Kdyt1vK7Xon6fEi?=
 =?us-ascii?Q?rkRNPOSwGOex85ymy0hbW9kOEpyImI6TbcfqO9VLYe4DYPwuKdxANhWlsPvA?=
 =?us-ascii?Q?yZvE/aCgnZg5Cqxwn1gfcuYSsATtAFCFYkA1fjK7eV3aWTjHDtAzpZexrflO?=
 =?us-ascii?Q?wPENsKLLUp11c4L+QT8T8hr+hbECvBAhvHzYMXyyTAz7FTqWgxf4WoMD/av3?=
 =?us-ascii?Q?QVWIUsi1ecWWrnZRaS0IVqsIsLUxPvEipjvJtcHrt+2cnWR0Pnplo2QR5Btr?=
 =?us-ascii?Q?4UQherOGkyFg6dx7odMczMCw+ltbcSVUcCYQIYrPveFzmScreG+yHLDl+8qA?=
 =?us-ascii?Q?SZ+neChoUn6YeJMbDhUkxdPoQVZJ1onFm7JKuAy8bkENLhGxihS8oXEh5xot?=
 =?us-ascii?Q?1XfiV8S+/KdDcqAfhzmfJQUeS7rBv82UuS2dHJeNpGU2jbFf4SJ71pOlgooD?=
 =?us-ascii?Q?F+y31EpH/yfLegf9qCucTj6Y2gb1fKc0NHnobyArGROu8aKiNDwd9z65yRm6?=
 =?us-ascii?Q?mufj2By2D32ph1d7vszPrNYjLHah8oPgr3u2IAxxdsqVZ/YAv0gPg8rS1Pr4?=
 =?us-ascii?Q?l2eKlBp2F3vVXu82aZFyDTMsZUhCJRQ3W0YzeSUu1eKzmCJg6a2nFg39hhAB?=
 =?us-ascii?Q?tirGQp6Zy8sEJxjqCGL7NzG8HiFAJOf5CDb9OXG0URT9mH0GF+6DtHVxEkIx?=
 =?us-ascii?Q?VIb0qdYyS0uaqy/k3wEzlurB3x7OsUkBubyF3yZWJQiVwIc+nQdLlZWHkbvr?=
 =?us-ascii?Q?+QNtCCkP+Ga5Z4Z6E8k9fh7sMMutZO19pU6bcvW2kkGZ3UJap0QPCP9zIxNS?=
 =?us-ascii?Q?Sli8ImF51WRAunMCkaT0qZtPh8Idvce+CzIcN8+rnhcI85YIJBs0Oykoo6UZ?=
 =?us-ascii?Q?5fkZVFx7FrHUQ1LptfsvKSHHMty8Y80wWHqlvmmUMSlIubpm2WvQSYU8C7kw?=
 =?us-ascii?Q?95GcW5JddmEkoiVrSkuRXmneBPFQKQa28Vk/luM+N2pmSGke+3QpSb/t4FO0?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D262825EDEED284FB3366F2F974C73F9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2+z4/DowWZIFN4cAQ3SDx6cTc+/pc5Z1ODJ6ByOBny8Uuz9pEsf43FmQmE3Y7Lqmj//0AniI3xhqLDAUzGcZ3H5vOvTiAT2fqVZP8dwBqPO2jgEXeha3SArIERmCqNnJg+JKc5IVTtjtSDLeQkJmJYFDWFODVnftGs021WHPX+Sj/wDfOS2N3K/WDT0nFum08gTtG6hfI7rMQakDxm8iVNwp1oFOoibMTCg/AvUYD3+idEu8TjkBSxM6MfaBZav7nzwxKZrQcjecAkxR9MR4IyvCQnyh9pujQzcZ9W8D0TksZo2QmLVVrpEI2HGhqsw4f8xTt0xBac6TjMPRNGNmzTiLAferZr+0MagG1ZNeH/COfHI4k1gpeO6KPr9rOljZ/o2edDGGWN6ukJ2pP3ucI+9r3NG97xZOrKCXm8IVvZBclutJJzCwOjLhca8S235RkdeLclvq7HCF0rRl2W9/7Wmr+7I2PRlEEPQo7QtO4dF7E8lTfXl+VbISRHiYBj4ftsf0ArNPIj2aD3zjYjrW8OsBxSQtCiryv39uwqlhyh436MOZdXWzJWFUDOsqXDGJ6JmrmTrLNpSYlPeD5hA8vGpZ14tIOX8CpAX+mxo8BwvqNI7tWWLA8zwlixS4ljHHr/bd09XDSjSKzp2wKu2uSAaBqhGQEtdJRBWTFzXV+bEEv7GbztjLqSMo+RRxySa91R7PpCPw0tC4raEQPgMhGruSztz2OM43Zf9IbpEjfiZll8JaPjChZjQ03BdNWueZXEuZlO6/VmFBbClTWzh4s7ZpAwUsLoRNdN9wWRxbetfBnGcL3p6KsfMZR2ZYsvfSKtq9P6Im+C/23pBbSPR182z0N64lypqFTcxz+yF/fPN31NkjvAmw+N79iuxPTSHinVqkd0ZLrBT8tL40iJpoYcSicqRkNvq0fKiCOxVCrJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788b5252-88fe-44f8-2abd-08daf00f5ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 17:56:42.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtK8+dGkkX7+bBp6XkXaWDpxkAFI3vXHbxxlQn+kRfL5W/8qt9r7L7LVUMP82x5z0GlZ0pavfhWzIg+l/YkUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_12,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060137
X-Proofpoint-GUID: kpMWzk_v8og3QGLQCCTvYB55EMAcTjnG
X-Proofpoint-ORIG-GUID: kpMWzk_v8og3QGLQCCTvYB55EMAcTjnG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 2:55 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
> regular NFSv4 file") added the ability to cache an open fd over a
> compound. There are a couple of problems with the way this currently
> works:
>=20
> It's racy, as a newly-created nfsd_file can end up with its PENDING bit
> cleared while the nf is hashed, and the nf_file pointer is still zeroed
> out. Other tasks can find it in this state and they expect to see a
> valid nf_file, and can oops if nf_file is NULL.
>=20
> Also, there is no guarantee that we'll end up creating a new nfsd_file
> if one is already in the hash. If an extant entry is in the hash with a
> valid nf_file, nfs4_get_vfs_file will clobber its nf_file pointer with
> the value of op_file and the old nf_file will leak.
>=20
> Fix both issues by making a new nfsd_file_acquirei_opened variant that
> takes an optional file pointer. If one is present when this is called,
> we'll take a new reference to it instead of trying to open the file. If
> the nfsd_file already has a valid nf_file, we'll just ignore the
> optional file and pass the nfsd_file back as-is.
>=20
> Also rework the tracepoints a bit to allow for an "opened" variant and
> don't try to avoid counting acquisitions in the case where we already
> have a cached open file.
>=20
> Fixes: fb70bf124b05 ("NFSD: Instantiate a struct file when creating a reg=
ular NFSv4 file")
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Reported-by: Stanislav Saner <ssaner@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 40 ++++++++++++++++++----------------
> fs/nfsd/filecache.h |  5 +++--
> fs/nfsd/nfs4state.c | 16 ++++----------
> fs/nfsd/trace.h     | 52 ++++++++++++---------------------------------
> 4 files changed, 42 insertions(+), 71 deletions(-)
>=20
> v3: add new nfsd_file_acquire_opened variant instead of changing
>    nfsd_file_acquire prototype

Hi Jeff, v3 applied to nfsd's for-rc.


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 45b2c9e3f636..0ef070349014 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1071,8 +1071,8 @@ nfsd_file_is_cached(struct inode *inode)
>=20
> static __be32
> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		     unsigned int may_flags, struct nfsd_file **pnf,
> -		     bool open, bool want_gc)
> +		     unsigned int may_flags, struct file *file,
> +		     struct nfsd_file **pnf, bool want_gc)
> {
> 	struct nfsd_file_lookup_key key =3D {
> 		.type	=3D NFSD_FILE_KEY_FULL,
> @@ -1147,8 +1147,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_f=
lags));
> out:
> 	if (status =3D=3D nfs_ok) {
> -		if (open)
> -			this_cpu_inc(nfsd_file_acquisitions);
> +		this_cpu_inc(nfsd_file_acquisitions);
> 		*pnf =3D nf;
> 	} else {
> 		if (refcount_dec_and_test(&nf->nf_ref))
> @@ -1158,20 +1157,23 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>=20
> out_status:
> 	put_cred(key.cred);
> -	if (open)
> -		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
> +	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
> 	return status;
>=20
> open_file:
> 	trace_nfsd_file_alloc(nf);
> 	nf->nf_mark =3D nfsd_file_mark_find_or_create(nf, key.inode);
> 	if (nf->nf_mark) {
> -		if (open) {
> +		if (file) {
> +			get_file(file);
> +			nf->nf_file =3D file;
> +			status =3D nfs_ok;
> +			trace_nfsd_file_opened(nf, status);
> +		} else {
> 			status =3D nfsd_open_verified(rqstp, fhp, may_flags,
> 						    &nf->nf_file);
> 			trace_nfsd_file_open(nf, status);
> -		} else
> -			status =3D nfs_ok;
> +		}
> 	} else
> 		status =3D nfserr_jukebox;
> 	/*
> @@ -1207,7 +1209,7 @@ __be32
> nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		     unsigned int may_flags, struct nfsd_file **pnf)
> {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
> }
>=20
> /**
> @@ -1228,28 +1230,30 @@ __be32
> nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		  unsigned int may_flags, struct nfsd_file **pnf)
> {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
> }
>=20
> /**
> - * nfsd_file_create - Get a struct nfsd_file, do not open
> + * nfsd_file_acquire_opened - Get a struct nfsd_file using existing open=
 file
>  * @rqstp: the RPC transaction being executed
>  * @fhp: the NFS filehandle of the file just created
>  * @may_flags: NFSD_MAY_ settings for the file
> + * @file: cached, already-open file (may be NULL)
>  * @pnf: OUT: new or found "struct nfsd_file" object
>  *
> - * The nfsd_file_object returned by this API is reference-counted
> - * but not garbage-collected. The object is released immediately
> - * one RCU grace period after the final nfsd_file_put().
> + * Acquire a nfsd_file object that is not GC'ed. If one doesn't already =
exist,
> + * and @file is non-NULL, use it to instantiate a new nfsd_file instead =
of
> + * opening a new one.
>  *
>  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>  * network byte order is returned.
>  */
> __be32
> -nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		 unsigned int may_flags, struct nfsd_file **pnf)
> +nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +			 unsigned int may_flags, struct file *file,
> +			 struct nfsd_file **pnf)
> {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, false);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
> }
>=20
> /*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index b7efb2c3ddb1..41516a4263ea 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -60,7 +60,8 @@ __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> 		  unsigned int may_flags, struct nfsd_file **nfp);
> __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		  unsigned int may_flags, struct nfsd_file **nfp);
> -__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		  unsigned int may_flags, struct nfsd_file **nfp);
> +__be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> +		  unsigned int may_flags, struct file *file,
> +		  struct nfsd_file **nfp);
> int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
> #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b2ee535ade8..4809ae0f0138 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5262,18 +5262,10 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *=
rqstp, struct nfs4_file *fp,
> 	if (!fp->fi_fds[oflag]) {
> 		spin_unlock(&fp->fi_lock);
>=20
> -		if (!open->op_filp) {
> -			status =3D nfsd_file_acquire(rqstp, cur_fh, access, &nf);
> -			if (status !=3D nfs_ok)
> -				goto out_put_access;
> -		} else {
> -			status =3D nfsd_file_create(rqstp, cur_fh, access, &nf);
> -			if (status !=3D nfs_ok)
> -				goto out_put_access;
> -			nf->nf_file =3D open->op_filp;
> -			open->op_filp =3D NULL;
> -			trace_nfsd_file_create(rqstp, access, nf);
> -		}
> +		status =3D nfsd_file_acquire_opened(rqstp, cur_fh, access,
> +						  open->op_filp, &nf);
> +		if (status !=3D nfs_ok)
> +			goto out_put_access;
>=20
> 		spin_lock(&fp->fi_lock);
> 		if (!fp->fi_fds[oflag]) {
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index c852ae8eaf37..8f9c82d9e075 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -981,43 +981,6 @@ TRACE_EVENT(nfsd_file_acquire,
> 	)
> );
>=20
> -TRACE_EVENT(nfsd_file_create,
> -	TP_PROTO(
> -		const struct svc_rqst *rqstp,
> -		unsigned int may_flags,
> -		const struct nfsd_file *nf
> -	),
> -
> -	TP_ARGS(rqstp, may_flags, nf),
> -
> -	TP_STRUCT__entry(
> -		__field(const void *, nf_inode)
> -		__field(const void *, nf_file)
> -		__field(unsigned long, may_flags)
> -		__field(unsigned long, nf_flags)
> -		__field(unsigned long, nf_may)
> -		__field(unsigned int, nf_ref)
> -		__field(u32, xid)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->nf_inode =3D nf->nf_inode;
> -		__entry->nf_file =3D nf->nf_file;
> -		__entry->may_flags =3D may_flags;
> -		__entry->nf_flags =3D nf->nf_flags;
> -		__entry->nf_may =3D nf->nf_may;
> -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
> -		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> -	),
> -
> -	TP_printk("xid=3D0x%x inode=3D%p may_flags=3D%s ref=3D%u nf_flags=3D%s =
nf_may=3D%s nf_file=3D%p",
> -		__entry->xid, __entry->nf_inode,
> -		show_nfsd_may_flags(__entry->may_flags),
> -		__entry->nf_ref, show_nf_flags(__entry->nf_flags),
> -		show_nfsd_may_flags(__entry->nf_may), __entry->nf_file
> -	)
> -);
> -
> TRACE_EVENT(nfsd_file_insert_err,
> 	TP_PROTO(
> 		const struct svc_rqst *rqstp,
> @@ -1079,8 +1042,8 @@ TRACE_EVENT(nfsd_file_cons_err,
> 	)
> );
>=20
> -TRACE_EVENT(nfsd_file_open,
> -	TP_PROTO(struct nfsd_file *nf, __be32 status),
> +DECLARE_EVENT_CLASS(nfsd_file_open_class,
> +	TP_PROTO(const struct nfsd_file *nf, __be32 status),
> 	TP_ARGS(nf, status),
> 	TP_STRUCT__entry(
> 		__field(void *, nf_inode)	/* cannot be dereferenced */
> @@ -1104,6 +1067,17 @@ TRACE_EVENT(nfsd_file_open,
> 		__entry->nf_file)
> )
>=20
> +#define DEFINE_NFSD_FILE_OPEN_EVENT(name)					\
> +DEFINE_EVENT(nfsd_file_open_class, name,					\
> +	TP_PROTO(							\
> +		const struct nfsd_file *nf,				\
> +		__be32 status						\
> +	),								\
> +	TP_ARGS(nf, status))
> +
> +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open);
> +DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_opened);
> +
> TRACE_EVENT(nfsd_file_is_cached,
> 	TP_PROTO(
> 		const struct inode *inode,
> --=20
> 2.39.0
>=20

--
Chuck Lever



