Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC35AC0E5
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiICSns (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiICSnh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 14:43:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E958DD9;
        Sat,  3 Sep 2022 11:43:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2839utbR030010;
        Sat, 3 Sep 2022 18:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W3AEQVPADp/NocIgOy4HLuFCxZaCd335mGsAIrauUQs=;
 b=gMWkK8Szxj0TLGmnBFsv7vd3Fy3wA0+z1ypGGEu5ugbRaN25Td4bickpZcPBLz+h0sWt
 UyPFYgwVWCcnVKbftm6be5tE4K2TjY3DCv2UXnuMeIlT8gm9UJJO4YBhYnqnjxWUOBi1
 Iw5y3grWcKG2EKge0m2CbAzTGWBHV1ZIprz+dQpjiB3/zNmkX6gGBC29ST6uToLoL3Fw
 YA2PI+dR6Ir3NFJF1SpSAO5cK8NSd3vBj+ENcoOjpntAwcAJTTD3PgHUb8SvU6jOyaQP
 mQfzg7y65O/jDFuxDdsItf5CkEr9WJ+TLNhk0J8wep1KUYw8u7v4VBVb1LSz4I7u5Hjm vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhsgw4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 18:43:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2839hr4H034906;
        Sat, 3 Sep 2022 18:43:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6ufvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 18:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3HTpSBAAoHEu+gp7+MHiHvQc2DrCKwx1AaXB2M18HmIxIz5Xx/a7BzmBruiwjesdXnDiBemxXPX66N5BfrG9HeFsEZTf18udHjZaYx3FG9Nbdv5zVBwNWFLYphUDDHVcmONvtpCQfnYkN00uDwhis2GjYEw9ZqPcNnhxRHLJ0y9HGUJLbrtOgvRmuJb/WEg/7gESbEr6UsGi4y+sV1R3qyVPOK8lSx7k5//XQBArETmY8PamJk2ZSA8PQP9jpxzAERodmSbHyiDT68pEKr5He1fXbPR6UcUZG9EH1X8byec8Rqb5/6MXk8qk2X6gLxD+jzGzBajhoEhVX/xBj76Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3AEQVPADp/NocIgOy4HLuFCxZaCd335mGsAIrauUQs=;
 b=P7DmelSU6Gr1yUBvLJ7QUTz/k5zV3TxhIm38I/iUYDFXyYMwjp1x7zsLf3GmfmZcPtkd68y/bMWO+2ZDcUSY0IpcxuhuSoRgzIId6iz7TSSVlhHGqlU4KmZmXEkpMYh2ZPs3NeaB+IFtkMeueqdTnhxgsYwyUmN8Ioc3+HdvtQQtH/4e1IzWuA9Em0ZYbVstB2Jv10uGJsGyrPvRSOl9E4QIh9dx6GfDozBOsGNThMH55hDXasiGDl+IwjhQw+m5BWJh056zhEb0LRlpy7hC9SHrCrKsVFwGWQ2lK5cPahjhJs7OS9k1jI0RoIWb0pOjEdcbzYnffOtuVW1kE2nzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3AEQVPADp/NocIgOy4HLuFCxZaCd335mGsAIrauUQs=;
 b=cHb9T/NyY3kxgOIQ6FtEn63nz1MEN6Qnuo+91Wa1Hh3/E7kcnjPcE9fI6QNPIDAgQduC7YZgJ46CZHpq1q18I35OAi8D+0YrnrPTiB5sZe/UgNx2NtfTzipgJwa9eJlsKd45lQ8dM3/CFEq0vREx5ZIl8FhsZTOidiN9BSotL0g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Sat, 3 Sep
 2022 18:43:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Sat, 3 Sep 2022
 18:43:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: generic/650 makes v6.0-rc client unusable
Thread-Topic: generic/650 makes v6.0-rc client unusable
Thread-Index: AQHYv8UPTDI1uHGr8UOM/bcjO7bwcQ==
Date:   Sat, 3 Sep 2022 18:43:29 +0000
Message-ID: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078fbb4c-6b7a-4bf0-4a08-08da8ddc3193
x-ms-traffictypediagnostic: DS7PR10MB5005:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fX1P3E+077XbOjCjH64RlGuNErbiiospUTq2Q4Wc+bKzvV+gblUMMk5gvB8yNzxSIxLco9LvJvlVJU+ThIpVrwsIM4twCpDak+L7R/pv+9GbekWDQGhCnFQ33zEuq1E0nouK6kRSUHxauo/7EmubiunSNMh1r7xgsKo5L9mA6d4IgdyJedffhGqzXOB8baPpYyqi+0RZiN6XUsgxfY6H5OvvmADUaL5xbxACSl+A89kz9vrFKnZyPcl9LujzquVcvMg4Orv4SeGVxmkMboLxpp624zXaTO7W+XqDfxPSbKeTNmKIP2/5t3XiYiVs8uWFB2mT+SBNqHW+SfLygc4vLNyDBknCIf44TJTHzfkQ89qvOJL/mHZTc7h3usWfgSYqSUIb7CPfOmPoJ4SJCS9FjN3Jn8xR/2NuT10LyXDQQ8hK6H7HRAlgBfSoavZVEaJbun11tGKQgfypxyLpWGCJNS83wqd30rRz+boKDSiGzYx85Za1gkMKAkWaoyAaRwGhizzrS52IEVA8DaUU5UGS8ugLo7XU1F7eteUkrnd6nedstq2V/YezTLmB8hiWHCOb5RUVsuqur8d8vT1Uwcwlx4b6UcMNW6ZJmh/rn157rSKCUIkGuz9GCy+jweb99GzkzE1AvXSWT7ZyapQkdgegGhW49+x9O8C7tXkMMjo5j5qOtjC0PG84nT1wGkvPQizBACYLjSu/rONM6T/9JEA4JCJSzFuoIwQb91MjYuxKxiR5ELOcKbpNGExmi7k6HXNltziFDh1eG1X6QAqho5cQgO+l86xpVUb65q+NExLw6at6vGImAjlW0Y+wQQStBWfi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(136003)(346002)(39860400002)(6512007)(26005)(2616005)(83380400001)(2906002)(4744005)(5660300002)(8936002)(33656002)(478600001)(41300700001)(86362001)(36756003)(6486002)(186003)(6506007)(71200400001)(38070700005)(91956017)(64756008)(450100002)(66446008)(66476007)(66556008)(66946007)(6916009)(8676002)(76116006)(316002)(38100700002)(4326008)(122000001)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fg80eFQiw5OynZZ70e2iO3U5Y6hiIjvRVU0g8n1VQuko1VSw19pDQaqo30DI?=
 =?us-ascii?Q?Kg7J8QLFdi5j9+suexra10RT4QRdNlUctKHTobq5ZeAgTsN0PUM8yzOicku1?=
 =?us-ascii?Q?Ah5xv/7JWJhBXbQ3Tj+zWZV11c4y+Y57uuf+XlwP2IDLRV0AprGIMLA58Gwj?=
 =?us-ascii?Q?6/ELiV7AFOBCmue8QfcHiTWbKHnCuG77YVrsIoikrP4JT88B6UdhJlPqfCnV?=
 =?us-ascii?Q?PYtszTyOrxz0f0a8etEKVBHXpIJNeIlU2pKMi7CL/H5nhTlCFaNShOoOwQQ6?=
 =?us-ascii?Q?n00NgaFUUfW4L2Gf/Z8AKZIyna60FRgjplbxMhiqqa2FYb8NVZwG+G0KKjfE?=
 =?us-ascii?Q?noc5/VoYEQNEuv55AD5sdiRA/PSjcr113GAYLdxW2DBAzmCHPe1Ey4lB5MhY?=
 =?us-ascii?Q?Hzu53iZuwYEzGwzTU8/kKdCUoYQjgTueOsmY9WnXzXOfCkHmIpel/kV3ltit?=
 =?us-ascii?Q?kLL2QJSchCshjDAwbWN3Xry3SvJe/XJmVr7mnCV66uR0YvqjuPDKQQO57XCL?=
 =?us-ascii?Q?lJMp2t+sNcQAukwfSUWtT22yxZW9vjiNW3cLkNHCPCv/xh/SMngpokMDr5q9?=
 =?us-ascii?Q?VUGWHRJri07zYBv2y1WkA7bGQVBQq7FsBIyR8IIwgrgjs5efCxgZgUksv+Bx?=
 =?us-ascii?Q?fLK7t0maPQN8Zty8mxnXfnf/XZQ3xe8ex9WESU/aqQoOv0pGNgQIqVqaSL5L?=
 =?us-ascii?Q?/4gVIOasP/GholP7ttoe3GLNPFqtoBmkdvtagS6SlHMHVkmu6xzn6aAuixcq?=
 =?us-ascii?Q?OYJQeWN6MC1GIJ9T2cg8G92Dfk/6CMhB4MXQ3I70rSOYYSXc3xlZeSmelGEH?=
 =?us-ascii?Q?zxzEaZ1nQ5SIrY5hA7VY++aV2LaGjUuRPQhnP97wUwzCWR/OHmXmXHG0u6hQ?=
 =?us-ascii?Q?2P4rmJQ4dxNwQ0kSKyvUWmNA/UAK9ziXL2V9BqZN7xFWJtxwK0Ep7U43w17B?=
 =?us-ascii?Q?wS9LiZ70LcxWoxpFsMzOzYaCN0vLbfISuhH1/H9ey0Ua88tbm/aJibcxojp0?=
 =?us-ascii?Q?3NXjt7NaTfB3WhQg7S9GKcnyfUch52mBpb82gUbWvER64KSMAkeLL5lqPNGH?=
 =?us-ascii?Q?oIHe4DcKZKLOYuUtmCxBW+t6fa4ppGqwOii5ci6+NoO7PXuRKtplhndoH1Je?=
 =?us-ascii?Q?DUyKLrg7jO60SSOS0e6c7cCr2elujHrS1DzYt16V+wOKv4Gs+KQomoKQTuFB?=
 =?us-ascii?Q?ns8COuMao0sWeIkv9i9SwG83Isx5WtM1Zri1mYdtBBWbDdDU0oDQR+cc6S8y?=
 =?us-ascii?Q?kwC+yhdbX8zIHDsDKd6EsZTwOslaNKQCV48giYUVMMvDw8M+03YuDUd+YoOm?=
 =?us-ascii?Q?lApz5yUkw7WresOgEewnX6gl1O1Vac4yNLWqeiVXwtc1ekrijcNrTOiAtn8I?=
 =?us-ascii?Q?gwUfb25j0rZ2zdxIrnFYGySvdJ1TqZUnaL0u8T4iez/iySiFICvDzt/eP12w?=
 =?us-ascii?Q?99Eg1ZG2YFsURLxQErL7xJBioRdgOfvn1MChHZ+/V4ihXNSjHg6/JLoIwJ6k?=
 =?us-ascii?Q?XsQtcSe7l3gEAuRi+EMVTCTZn+wsOld0pWGRai0BW9Uu4lIYGGM3Xg1HGoy8?=
 =?us-ascii?Q?ghGNEaHCIW3+W+oDQ9B8K/30jDDwE6OpGawrsGHw7LW7z4SAiqOvwvQEYUlv?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87258A8D4BCC7542B80554194FD1F15E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078fbb4c-6b7a-4bf0-4a08-08da8ddc3193
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 18:43:29.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AADLGe11Xb130ebksP+Fe2ppuB51O/z+avzLZP2pkuRcvS74klgQsFylTxRVYMXuVE1sbpTF4iewhpBqf3UHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030096
X-Proofpoint-GUID: BFPQ6UK8vZtwEGxPRPgNwcvD08diSBC6
X-Proofpoint-ORIG-GUID: BFPQ6UK8vZtwEGxPRPgNwcvD08diSBC6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While investigating some of the other issues that have been
reported lately, I've found that my v6.0-rc3 NFS/TCP client
goes off the rails often (but not always) during generic/650.

This is the test that runs a workload while offlining and
onlining CPUs. My test client has 12 physical cores.

The test appears to start normally, but then after a bit
the NFS server workload drops to zero and the NFS mount
disappears. I can't run programs (sudo, for example) on
the client. Can't log in, even on the console. The console
has a constant stream of "can't rotate log: Input/Output
error" type messages.

I haven't looked further into this yet. Actually I'm not
quite sure where to start looking.

I recently switched this client from a local /home to an
NFS-mounted one, and that's where the xfstests are built
and run from, fwiw.


--
Chuck Lever



