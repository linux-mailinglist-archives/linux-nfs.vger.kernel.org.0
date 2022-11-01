Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E061545C
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 22:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiKAVjm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKAVjj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 17:39:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F091C1E73F
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:39:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1LYAbA000458;
        Tue, 1 Nov 2022 21:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E0LqmqPCPfa8OeqNQ15IeO+uJhZ1UZS+3rPFS/9TH0A=;
 b=d2YvP0glk/5MIKv+toOVnfSWZhYIMo/gV1YVKz7zMsYizXK1MFSJrAoIJ6RxuzjiRG6m
 f8Fv7nMqf/FhmpatQVHwix4HMrYYtR620K3nmuZ59P4M0nF3FXSGK4XblAPg7XhWRfDS
 uh1gWdjWH7+ITbrEXwZ5YnVkOoB8rNXXwZE6bnk2pAuTi0DKco4TzOYgnI+s8EK+YpeJ
 scf8PLlq+Ii28h5u1ZoyfrtXvRZ2z4K/i45xhCaJCFEhFqzSFZrlRnHOVrr9K3bPenWS
 XyCNop2UhOkJqgtmKVnFSU+GRIBlvu4G/VoPrRaTmqel2inTNO7tgaGqj26EFuBOpVMI xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts182p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:39:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KbWdV014088;
        Tue, 1 Nov 2022 21:39:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4v2mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:39:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R38oyGWIXUZeU8/ZRzhPbpApR8b3QQB8m8baSEB76DXSSbuQc9MKgRrJUj/X+i5CPbL3TaVIomKctF3V5jWBUFoOrzwMfFTJYo9BDxVGwdGTZxPRmMabs/3mm4aZbhKt/wYevKxtCQ348Kgg8Fw0m9VM4qSecdOJaPw0U71eivFLlRdrwll00optztNraFgCHHtcOm7wXhXE/aQuifKRgKlXd+k0UnBF0/TFhEpVqephbB8zCd1C5ZhA3NGjwp/6CDi4rsCdLcMVZzVVye3zvjM0slHE09I8ED06T2kwySIW24Ca+4y13IM/HvuIW7xE8BR8XKh3pCEwyitnPAO5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0LqmqPCPfa8OeqNQ15IeO+uJhZ1UZS+3rPFS/9TH0A=;
 b=JiF7mhFFBskwk53LQWSdWHBEcjrgviqmW8agkVapdnoV6VXT5KB72TLuyVVE4JDUXfFdLbVlS8v5SfiYQM6LMAgUDuYWZRUmaNh/MA8/GTtL8ErJhhAAV4fQxq20FIfHrSRZURhJwmNwFqt0rOB9uiAlVzTRVjwbelFqY2MmA6kSV/pU9P7nhYCa7ppU2iZ5APS88+vTiqckhyOJiQkJl7u5KRZcobZLVo4+wUOoV07U+nw69otwFI1lNZut+6ig5p0mY4nfURP2DLrtsMS1u5u/LWBCU2YI54suiUEjia4e099KVN4bvG9Fqu/uYaVNFJv63/63WEmhR7MrRFk5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0LqmqPCPfa8OeqNQ15IeO+uJhZ1UZS+3rPFS/9TH0A=;
 b=n9R2kH48szkkQUDUnlZZl08z1rpJgxd0YpI3lem7DSVUcVKSEKeOK7u9HNTJTEMvnebNKRWq5bAvKJPz/8y6GKsx+ST72WVNCZBpoV1vjxtigxs7mYANpP8Gg8tekRyoQxIZiRHYiTaGc4AwxefEX/Z4HyC6X8hINwmD+LNvlqA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 21:39:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 21:39:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Petr Vorel <pvorel@suse.cz>
Subject: [GIT PULL] Another NFSD fix for v6.1-rc
Thread-Topic: [GIT PULL] Another NFSD fix for v6.1-rc
Thread-Index: AQHY7jpsz7wnyEMxIkCjO+DsAZTBDA==
Date:   Tue, 1 Nov 2022 21:39:29 +0000
Message-ID: <4A2FD32D-3EF6-49F8-80ED-E92F92AA8EEA@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6825:EE_
x-ms-office365-filtering-correlation-id: a25e4659-e56c-4fec-15a6-08dabc518ea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLsVZt0cg66yKIEtKenWtnGYs9e7XksbGrQZuGmefNpYL46JkG+4oFNuV8Ai1x091zlTdROBZbjw53NWfZtdckZMJV15agvYqXprZKggFcuRj15iWFZG/O9+9hjakfDgzKRBbwe86APW3LzecMrgfkdySbUeJF47fziOmYONt8iV4fSr6kXJlAnf9Ud2oeQPo3Jzd6QLRDmBOH40SydUn69wjNsVEcmL5836yQiqtVtR494gmRRsSQ1ooTO3ZW4tLcinxyL1dM9vxMFjZM7o3+HV9NNS12Zd0ZxerKhmavgxURZZy+CVMqK7j1Vho1l1N3xEuvnAqM3DIn5T7PYoGoDYAYRUIz8RlOnxB2CHRqX26M8wUS27PxaRcICKpsbcU1stFYWxOLOzbzdtXFAom9IW5ITP2F9B6hAfaWxZ8Gt4OhjFbLTAtS7bZpHAWeG++Gg3dDV1SBL0lS51+cFWt2gvMUimscFNwCJGwztRxokESg0ANLfnzg0WfqE6dJl6wE0/AA6U7DNnCM9J1qqGjresWLJfNj4SrAHcu8yXZnkAPsBtyHLLkmvcNaSTqVP4YFIoRQvX6QGRi8lC1hEeZJmBn/1AnLgp7HbI4n9f4rqNBBGJ4dclxPulamzSJTkab620W/njaf0hEoAW042hdvj4ZmKGNST6pfL9/A39G25ofHvcQZjV6KeZgr4htKYGEtcq7tBmVkDAeESBycNpAijd8MXYnXIiUfByQS/m3wfp1+FzEjPHVxXq10I1oNyP0G3nYL7Lx8+wLgDis2BfAPApRWEmrtEN2Fr7/DstTHFAySpaCvLzvKZ7R1XIuEORfKsGZRVcBf0lFVcGWDAeQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(122000001)(36756003)(76116006)(2906002)(4326008)(316002)(6916009)(54906003)(2616005)(8936002)(186003)(33656002)(4001150100001)(71200400001)(6486002)(5660300002)(966005)(38100700002)(64756008)(41300700001)(4744005)(66476007)(478600001)(6506007)(26005)(6512007)(66446008)(8676002)(38070700005)(66946007)(66556008)(91956017)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kpUtwd54dFQ6CI07O+fArQk3xib3ixvRi1ep5ZL2HUMinRNwOH6IX3uVKQKx?=
 =?us-ascii?Q?Ro0wzc7CVWJzR+QitQPMBZ8Z7H0Qd38Yj3itMTj1hIqv6G9pHoLDhBCXN3L6?=
 =?us-ascii?Q?NXvDfFQFzlM8Rpq9zgmr+DRTxjHzOZ3ZsMqgceZy9z5dvmLtGEBqfcwKdqJl?=
 =?us-ascii?Q?KVlLoqgerMnNyoKvuW1qwyPMXNnV4grlWuCdTwTod8teMcjXbDQjyaMYH2Ef?=
 =?us-ascii?Q?HWmxt9FX/JYFCH4DJDWOu1+AJKeEplcM5UF9NZVZCqhHFUeYNeVsR9PMIkC1?=
 =?us-ascii?Q?LsNpZHNE75vlKQl0ihpmpScnFhJD2bm1bi3BwU87CAeEPpEVFrcxImgk2NMJ?=
 =?us-ascii?Q?rzzIKGDeP96IDDCwhmP2Mitzj+xg2HOET8sLfkpVVOkFI2FFX50HGWkMfgq9?=
 =?us-ascii?Q?w4A91aGM8K8xkTMyugxPz/kWa01jLHLB/5VHaeTJ2N1sWa1bK/xFuC6J+K4a?=
 =?us-ascii?Q?cAqSwuy/sVfxkrbl9pKSs3RvPCXKX8JXoTWaooh5JHrcErXblJ2BxtCNHzbN?=
 =?us-ascii?Q?V0j+vsINV5++RFYnvv1/h5QBDGZXoVroS2mjf9quB17z1qrMhtAlEhLrKpJM?=
 =?us-ascii?Q?4j1kgfFPkXlrJGKCsI/RJYwHYVqmg61Cki1bkCm6QBA8qVVzeJM5q1ZNmayp?=
 =?us-ascii?Q?HSqTQAjnaLSgyIGnOn4IGQvvA480jl6s3tua83fhNtC1l6M07nVYUWAB2/fl?=
 =?us-ascii?Q?NG3oaNexJGOu7uUTBxXif6OnNzBWVt3JdEp3e0N8CpL3u9HDbSbABs68LAT2?=
 =?us-ascii?Q?8j8l30Whsp/6YlBa7+f8Pxc7nnm2qeLHJ0pw9AsdAwB58C+6BUayzopCZVbJ?=
 =?us-ascii?Q?pgqhFx7hU3r5a+iCgy1ji1PnlEGpbIxx6CO6sAgxvlh9JH+2m58GT+AYDHlg?=
 =?us-ascii?Q?7l8+SADtSi/Uuh3I4Pw4CMwQBwQADEnwjmKh+39He+n9kcC56ix1C6Kw7TM1?=
 =?us-ascii?Q?J+LDX1Ml+lFI4eK9z66fkQbjez0J+fS3sLHkrRs8fL+uqdGMqgbPh04QVgPK?=
 =?us-ascii?Q?f9YT7kz1uFjb2nVY0E9ej7rER/6kaVvNEJoxEuyt23IK5zaGxC+IAr6Ngmwh?=
 =?us-ascii?Q?XPJQBzOISIlFeiKz8JROvQXAvKi4J7jDY7li69LlYOwvpKerhr8dDTz2zV56?=
 =?us-ascii?Q?I2tqrhGUVEVK+bvCF75sjbhZJ1x0b6RvEwjHvKctjM4OmOZgdy8tPe6s2C3s?=
 =?us-ascii?Q?ovftM6PaZTGfAvhsKdRczytkozB6AG2ylFRMBMRUapgNJQyINhPr+O9LGISF?=
 =?us-ascii?Q?R8JEJmv6rdN/9PdTdl6xwqWOOXjxejz13WOGLPd05cg77WjQRxzYes69nT6M?=
 =?us-ascii?Q?oh6/YjRqMHKxxS+/jo78SQSS+QNKLDvE1k7ykj6wiQ3le9feudMnSKwykGqA?=
 =?us-ascii?Q?cF6BsD6YLaW8dQ8E33y52YQfZl6KLl8ZqOgLQcfKEyYC8yBcL5eElEfRJKuC?=
 =?us-ascii?Q?jEUYDw7cPmwpGYllyVhQONINoNYr5Uwz/nGBYjDK6c9gm5xXuMrSAWGSrsLw?=
 =?us-ascii?Q?9CCkoT8JugpwDJjRIxGq0d1Tr0J7hZ2ySrGTBEsAHyvyLEUCrb80CxrjCG6X?=
 =?us-ascii?Q?+MHoA9aKmlb3LTrsRMRy8CIfdHnlM3RlEWT4LTe8kuG+z4VqWm8n2Bb3XF1r?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7CCEE247F72D74F9F389EF77A2AABCB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25e4659-e56c-4fec-15a6-08dabc518ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 21:39:29.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FthzuYSzAAdS9NJLf52KXRyJ9SzbHnWRPqgkhYSrRUZYjW1Vh4Bawh3i8eN4XDWzgxgADRKWSX/BeEqFbqHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010149
X-Proofpoint-GUID: PjrSsNcXrZcJGFlO-vPBF0nZbK9nSzju
X-Proofpoint-ORIG-GUID: PjrSsNcXrZcJGFlO-vPBF0nZbK9nSzju
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Note that the CommitDate is a few minutes ago because my toolchain decided
to re-commit, even though I didn't make any change. The commit has been
in the nfsd tree unchanged for at least a day.


The following changes since commit 93c128e709aec23b10f3a2f78a824080d4085318=
:

  nfsd: ensure we always call fh_verify_error tracepoint (2022-10-13 12:12:=
37 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6=
.1-3

for you to fetch changes up to d3aefd2b29ff5ffdeb5c06a7d3191a027a18cdb8:

  nfsd: fix net-namespace logic in __nfsd_file_cache_purge (2022-11-01 17:2=
7:27 -0400)

----------------------------------------------------------------
Fixes:
- Fix a loop that occurs when using multiple net namespaces

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: fix net-namespace logic in __nfsd_file_cache_purge

 fs/nfsd/filecache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--
Chuck Lever


