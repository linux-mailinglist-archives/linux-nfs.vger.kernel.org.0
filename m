Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9050C454
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Apr 2022 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiDVW2k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiDVW1d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 18:27:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A53565DA
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 14:58:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MIkiLC019231;
        Fri, 22 Apr 2022 19:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2021-07-09;
 bh=YZJVvRWsGFJBwD0b4XitHY/wabKCOLD78RJ7XmNFJzs=;
 b=CrNC9pESMUJinWC7oBaQDIk8mgmfHVhywMZgS62X1dGtS0ttQeoZ8Zrzfux9WIXSnUS8
 X6tegKckyKYUChQiP7yBgUhewfa+4mkgOQNa1YqzTKIluzQlnCk6QbCvPUnPNGFD+e6X
 q8Kp7NOONixG2Mnk91xJ/s7V7i1RGmjzneGuiY5WyjIY0hLZLwEL0FmVaP0fIS5EsFIf
 zfmODifiIRhDBfqk+elZUcqRsvYRkg/CLAuSd1h4lsZJfWOaUIL+HvH1wfY4Vsyj08/g
 VRBDNhC/yhYsyQazAr4TgQDsa736GGw/3VmNei4CZE+8O8+WUK1ocycJb7VtSu/GGwQc zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2yhfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:02:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MJ1tuQ025253;
        Fri, 22 Apr 2022 19:02:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8b8bup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 19:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUK3uKl7v0DLMS+ZeeZ7z1DO59A7uGn2xsz0Vqm/TJDX17rWlr4edeWBI4jIBHkXb3ETI/mRHoCbPljoepIWDgSd47frWW+6K1rASDF9fF1xGaRNhTe/X3smjXv1xGbA3QtgXXkcOgNcLWMtSYzm2/1mfTv18qpqq2nS2a7/wzTMJ0sKMHpDwRgKe9zQfAEP1ngZtkJbAOaptp6uXBAYGQM/ZH7gfHeGHlsn6PS0sKzxIOBp8FKdKgDPkURmqj0E7Aq1invZ6TjKUX03nfKPoKx1pn2NQbwgVOo4w2T33jfgjt37L0Syw4AvX4rUvygGouKecdN3bTI6lIIsY7j5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZJVvRWsGFJBwD0b4XitHY/wabKCOLD78RJ7XmNFJzs=;
 b=UoKT30mdfferpkdXl6gcdj/Z1g60Ntq2HmtM6kgX+Bft7WsFJdEdPGdfsPP8CRL6QjilgO9qiuKXX6UefD7nBsQnfSgLJwyIkOuRmtJU8sPjbD4//7g4uONmfyt8PoNoshRU7RI3huep98GEMYuBRHG6mbka3filMCc+K9DfSGTchGotrrczq7XDx0JuSya49AA2hYG00iNK+nYnfI049j8Kgohbo29MyPxQheqPIbYdcYBKgZ5FeGr3Eolsk6jp2I4y5R8de31ukmV8YzmVri+kZqIcAJiJHgzcNO9fW98zEcIUFpsHVNauN34HBiJ7nWQ+PCjTfmDpx4uSZXNpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZJVvRWsGFJBwD0b4XitHY/wabKCOLD78RJ7XmNFJzs=;
 b=qL62+thU2dFneeeAkGf0EkQspqs/bDUBGQrBPqCCtohE+AHSG/h8rs6OUM42GrUxQMMngp9p/S1gKxhW7pKe+uUzfjnEDmNdvaQ+KVHADWU+pETmwLYZG+jbd4TOYIMIUehKx8aGXYJJJNhJQXDAvu3RAVJfKb64JUH3++N2NjE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 19:02:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 19:02:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Reminder: Spring 2022 NFS Bake-a-thon
Thread-Topic: Reminder: Spring 2022 NFS Bake-a-thon
Thread-Index: AQHYVnt4KHskqzCI3Eq+r7mpDT1VGw==
Date:   Fri, 22 Apr 2022 19:02:11 +0000
Message-ID: <ABA3EBD3-05ED-4A92-8233-53C092DEC55E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b878fac-6d14-4778-472a-08da24929b18
x-ms-traffictypediagnostic: SJ0PR10MB4768:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB4768D373B1F9D8396E1C330593F79@SJ0PR10MB4768.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ynfWXNfCr9M5cHB17CY6bbs7VmjNVm+jKKzBq8kiIKMlTic/9rmts7p2K+Tg5RidIZB4xLYKqTBfJKmXnEhVWliX1wt7pmKOqJtjNp5QO+tDLlEJfldTggeO1zY2Xf2hemHN4k02iu15f52yJoshFe/V6+8aUCRXhLQfG5O+YT/tsDcSh6RB23zYylW9TCzus/Dxc3O++rM6wr9yaGzTpA4/kAtwnx/T+XIjvIuOG2GNqp45bp6Oj0fiSQIYLfGfHP9qlDW9FrRJoDt3tUM4OkxcR7PG6QCS0MKm71szroHw/WmHUJ3+T5WjHwFTGKyVvCcddZr/gjTMVoVvF/16DssC/xh6LRxqi7hTYHx6eu1Hx4doTWj4t09CNlaFzRCCR/8ocYGbqPrKTFwzeAHpqibgN5XdDMGAi6m3rMGvEmZQcNzfdajfog473vY/rwnwxjBPp1pkbEVyTRb+bftgjKldhTp1s7dazviTBtPBONMHmA1/v7T0KXToS/OGKXNutkUvZfZ61Sx7/HUqgqvMDi85jqrG6MoyiSLvKeiJTW645YBCxUtqZAOL6XkI48ZmpUFOz/orAOr0GK194ZWvYUJm5YqPwpFuhOHFssAuhm6b128jsBZnYTWg4LhBT1TwylwXWe4ZTIsvfbVHywGf72ipjHABoZcmKzH1OUgoKCJOR+OQ87HIRZ2ZOl/mi+T+2YmQJh5tsvdV/hqn4T/cFHermLbzrnAC5B+iRfht2M9zrTmKS6gxuJmTUQa6ReMgxlWfH8Nck6vHxY5MYa9zerKAVPo3mafm3cDASVIo/iZQM4LSmQIiMqlxazDSC6s18VweVq/StgsBSapMaN3DFbB7tmzd7EbAFhF+K7tt118=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(966005)(508600001)(2906002)(6506007)(122000001)(38070700005)(38100700002)(6486002)(5660300002)(86362001)(2616005)(4744005)(186003)(71200400001)(83380400001)(91956017)(8936002)(37006003)(6200100001)(316002)(6862004)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(36756003)(33656002)(45980500001)(15302535012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X8wIGVBDzQ849sGM4WsgFBUtZJ8feILTnucWp4uWvutOToJ2ha3SCo/IHK2i?=
 =?us-ascii?Q?s3iIIGUTBKEP71GhB0dkxsCTY4Tu423O4v6zDf0C+x1+YIy5VcgTfDMfkF7b?=
 =?us-ascii?Q?s9uGmL5/lOFTp0Vd7Kkyrt9HWH542fsQTkxnz20q26y0B4Uht6+e8eEftI23?=
 =?us-ascii?Q?J065uHOhqOS07RpG0HK+DMkVNui7Idn9HkNZnIPVgnkzS7uRZxOZtvy3f0bC?=
 =?us-ascii?Q?5gt79QCCfA5wwIR9XHiAYNxP0J5hOUMaJiQiGtOB0XPqAEBqFs1eWA9r9EBj?=
 =?us-ascii?Q?j5iUIixiSIw3fJucFXEctub5rpKgs8srGGegpFc0tHmNjV1GA4sa9uExeCTX?=
 =?us-ascii?Q?X37e9Bfy5BhAiAXDw5A8+K/+Gbe7AVj61vpIVJw/Hv1/2AYBTWMxv1hQnw/l?=
 =?us-ascii?Q?/QLKapQ3v5U6ZEncM0MWsCDfPOF32cUPxVdLVxYjGe/4JRFq4NFVQncm9ner?=
 =?us-ascii?Q?PDTBhpBAFDnjChCBBAwwU8dAGI8sQLyTg3LYGBgnoaIjF7kso6eKz/Tx1L5l?=
 =?us-ascii?Q?9I/wYRFaKVPqKBGaNXPsPbgHXJQlYodP7ie2L/cA8yUbr/SH9TZkkzyN/V9w?=
 =?us-ascii?Q?hPjX1FnLtt6ouGDSqXvpMmMMiTr3GBO55UxxERZFNWTnfloDmIwLFd5ctzZR?=
 =?us-ascii?Q?Bn8iqBHs9CaLkEdQmxJjC6eL/8Z2N6E3IxQJgWxEwO99fzayU3jBHiIFRIok?=
 =?us-ascii?Q?KRUZjdh2WyYsL6yMDD2UQ5Hn8VZEVjnf5eRhKXxEDQzqCuuPcNvrS4xormLi?=
 =?us-ascii?Q?yGOrHiuId3gYf8hUCE73QYuJap8BLHymS+owAAbbEkjb7RCIXT6ibSmfysLK?=
 =?us-ascii?Q?sBh3VMgifnRygIG9zBFNBxPnsb5lMcGT4VdMWOEottpOHdd1CvS7I91LoL1r?=
 =?us-ascii?Q?YOqxrGesBrQ13m5EzBp8dEsAhreFMV9YLa5593yzqxPk6JuAzAsabO/4Loo1?=
 =?us-ascii?Q?BfBPP9IepEu8Ak23ay5wmnMc4LrwZQfU3scki/2J9xIYlBwo2q58plxo/lKh?=
 =?us-ascii?Q?5aHDi0cNlLDfbgPUqu1Z0DLObIFoewiShdKzJ/VPzxCFRTFPfQwaHah6yxsu?=
 =?us-ascii?Q?T4P4EVW8LrLHZnOnDc0sfIBc3WC5MLM3QpoxYMsovbO3FPLs5x7+Ft2zlP+q?=
 =?us-ascii?Q?LS/CrL+6iooM+QTtyfbQ1EBg835eHLWpJum1RBUPzMM1sh1uQ8v9dpH7DfQL?=
 =?us-ascii?Q?WfBDPFoHH7uXkl1v5XXRuKisfBLCvforkdribNXtcS/pCVKO6w2qyFoF9EuF?=
 =?us-ascii?Q?U2kqbxh6BqTNvNVp9uMeoSBBnDtO+wDg3k0pIB4xsWlX8DdS/Ai3cdVvxnnf?=
 =?us-ascii?Q?dvR8XMN1trZkbtMF3JV4/dopQFH7SJPFVFTMm91C1Y2IB4V1S1Ie11botbiD?=
 =?us-ascii?Q?qHRFAyuBcNhtcGhWo/ZlGILCYcxb8y+kMpqUwzEKeA1PxfC5aAuBQlN0WmdB?=
 =?us-ascii?Q?PYSJ8cr4NjYrwFgCpMumpbuCMJmw6Dt0hXla0JeoOmRQfC/Gq4rio/DsbTyH?=
 =?us-ascii?Q?NLsI/O84BVSWNUlo9j31T3DVWjWQN/lpMncHaQh1yua7Nxs+F072NT3+YczI?=
 =?us-ascii?Q?zX5MDUX80vbFCfXagJUdqmiUdqJVlCU9y1UgVEY8TvEUiKdMVZ76LYqbwnmt?=
 =?us-ascii?Q?ckJ9iPnThLNLGhVPeemQsCjPbQDQrqCFFvOzah4QgCn9pLGI1qE0u+8THm2b?=
 =?us-ascii?Q?P0WeWFKdn+XuAWefL8nwK7jzK3sF7S3Q6E2Yplo9O/EBYFuXlA+OIqHHU8uj?=
 =?us-ascii?Q?ipeQLNiZXI+GYzNJkYe6XsXh4X3A3jQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5357318232C4242873BF69E6D98FD7A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b878fac-6d14-4778-472a-08da24929b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 19:02:11.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xONq5aAJ9OtnHWmIcrLznwzBw1Fjmn5PUqn1xe2HFS4IsPLuq+ZGmjDhd27hhuY0tpMpeLUbkjJA3g3v74QE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_06:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=775 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220081
X-Proofpoint-GUID: vvX9yDQT3ZXesRS-KDdzL7GNKW6zKIMo
X-Proofpoint-ORIG-GUID: vvX9yDQT3ZXesRS-KDdzL7GNKW6zKIMo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings,

This is a reminder that the Spring 2022 NFS bake-a-thon is
happening next week, April 25 - 29, as a virtual event. More
information about about the event and registration
instructions are here:

   http://www.nfsv4bat.org/Events/2022/Apr/BAT/index.html

Looking forward to seeing you (virtually) next week!

--
Chuck Lever



