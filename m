Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1713F7AB728
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 19:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIVRZb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIVRZa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 13:25:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA80F1;
        Fri, 22 Sep 2023 10:25:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGOKxV004047;
        Fri, 22 Sep 2023 17:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+I0Spy5J3pvPOfF6muwITF000aDbKL1zYrOQkUIi1Fo=;
 b=I1CuY5Cz6L2TiZv5VdygA4DZS0TfhamaTifS67vvD52Ng4imp2yPSZHn4DYa3Qa5F5FR
 oKzm3f6xPOW/a7TSPBxjiJWnSFp+2ViZfDwnWkbE+tTnkmzbFxlb2rO1cFIL92Uvguid
 DO0XZc5V44LoSEkvIAv8f8xgAspTEjYxE7krEr9gMXxVR9//CRcQQDuGsYTgR6p8LzUu
 q5KeNdnC470+mXn1PVucGZ+GTpSbsUADhUIOZxvWrcx20TV/meT5oFBZJ6AlcahCeE32
 y+F/kaQzK6HYL1wK6ZDVsn0ciR0b6gOJy/j4NB5+ubLd//3bWqkJoz6gnQTKM7zf9gLn cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvtb7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:25:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MH6jog010704;
        Fri, 22 Sep 2023 17:25:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u1abr4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgF6AM8zLP7jKxBiDcL0qE4iVJIx3lHmbezy7GV8yBLyGS3QBqqdTK6sVvsU92SjWamAdak4iW27DTS/sjE5Wpvo+qBph6B9z9YqeGJgYpL0qjtp3N4cQUh71RiPZoDvXZpSE0YQlJGSfP34Mm95H7Iec5QFhjP5HVC9tRhEGShvs+/JviAvB6rbbxXskDmOQGeHLm6xUXX2kwUb8pPqmHp3iOqPTo82EIMf1wCdUJjd6d8hXSeJQXrnqoX2MmThxnL4VHyb9tlaoGfmiaCfgyVVbdzAYtm9iludmisffI2p7YfvCxkrW22qT1sTHSC9DLI12rycV1/i/moR53wwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I0Spy5J3pvPOfF6muwITF000aDbKL1zYrOQkUIi1Fo=;
 b=DW7fPuzV8PvvhccHbILtk2r5k9NWs/pnurIgIxF8+3pFh5x/lygg6dCvze5zvSMP5iyPlXuVoHZ7cGYHufQaVHdQDmOzbNWRWHkPFQb+ubSAnCfzDrn+nyoSosx0lTBxJBBuKi+OxqKSoZyK2T1KOsKpol6m4ooDPAY2XQU8WtgJvV4W+5xtoTaeqzeG8t6suZf8FqN1TRgc8JIPT33H7NMursUqv3mUBjarUhv5tXNYSWlVMjjGJfE/oaNfHYHUfy2PhtgAEsFadJwIZ21yRpCzH5K0TjEFsb+zyYc6qqyUhCmlF3vNgUvJs+pE0Z8nZ71yMcuGiXX83qpNcuHPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I0Spy5J3pvPOfF6muwITF000aDbKL1zYrOQkUIi1Fo=;
 b=DHz8l7W6ojRxloO9BEH1xmrbGu3ASvfc17TLBlsoE1v7oDxbiDOJIgkKFKxcbA+U+Du4Yhg/LkQkdlOTofKAW2NgzYs3x3X8yEuzgveFuo3KNILdevOxWgk4u2njaa3Nj2oS7cw+xo9JgQ3gRJRnSkXwehxeyVqRW2s7HZ5s2Ko=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34; Fri, 22 Sep
 2023 17:25:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 17:25:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Topic: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Thread-Index: AQHZ7VKfQ7YihRKqAEKLYXScgapUUbAnAk0AgAAEfQCAABH9gA==
Date:   Fri, 22 Sep 2023 17:25:10 +0000
Message-ID: <C6FD2BD6-442D-4F96-82E7-D0F99F700E03@oracle.com>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
 <ZQ2+1NhagxR5bZF+@lore-desk>
In-Reply-To: <ZQ2+1NhagxR5bZF+@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6510:EE_
x-ms-office365-filtering-correlation-id: 2e43478f-65c9-4ba0-d482-08dbbb90df75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbiOytEeIkWsLoaBGS/JkQ6llq8tqGVTyhxOAmiupPED1F6jidE7dy19htb5KuN1d5yELoO6p+JM9P+2y/V/H+uitF98OBZeRILIZ4SAJ85bDE3qTtHjoO4tldL9EWGgUfzUt7F2pJzYXoDi9Ah2fCmFo68oRsw+YYRcZnyMjqafBwC7H+tZs+c7CznfzoJ/rJ67VdvtFTk+vEbWLIh3bJR+tU68Fgj32NCinK7a3486tUUl9Jta/+YBFsEcNkG82HAISqWbetW6TaHvGt7bnN7isra/vbPKiANfYcRpDPdLfZguZ+Lc3URy9RSpcmxohV0R2WHNqXaJZQyBW+vP/3g8abhNUyo0McIRFtqd5kfXs5wwT+oglbSidkFWxAmycO5MiL2eri0oL3ELd59pV7AjQisheGLlBzy0A3VY1buxd06d9eSIiFKYdzqzoL+LgRFfOoquWjwzk2xnHpcULa+AmNfTVIIQ/hTAkNdfxrP9jGS8vBuDZPA2l/Zt/DmDT3DFw7CK/BptjgwSUY0PhoqEaVA9hYNdT7TyZrw9mGR95AgQ0uapHhfMhwEhsQiLlu1o0yIKaPhj2ek3W+EYq7CrpfeznK9tBs4lzQyFFE1nUCKBksQn6LDq22eBDc/nrWIvUYn30CsnHANc3Op5ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(6486002)(966005)(71200400001)(478600001)(76116006)(91956017)(6506007)(2616005)(53546011)(6512007)(83380400001)(26005)(33656002)(4326008)(8936002)(8676002)(66556008)(316002)(66446008)(54906003)(64756008)(5660300002)(6916009)(66476007)(41300700001)(2906002)(36756003)(66946007)(86362001)(38070700005)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ebCrO3Kqm+CouHCxi8rgJPBksoVzDKorBx77GzSMz+tp/WHk57rd4SPdvQa3?=
 =?us-ascii?Q?yPdljiHA0QUVFu8/nLupnkmsg+B89T3Xtu0a4f1IrtgJer9fqnSzZrMIY6s/?=
 =?us-ascii?Q?NEigudNgLbFFcfM9/0pbFZ8ANeBNAhZoauOxKNIVNF7fTvp5FwBy85WhMsIh?=
 =?us-ascii?Q?hNKzTE+52a9Oy9gG2nLIRbrURzdb1hQACNNRLgtwTePapIGjThACE+4HJCHe?=
 =?us-ascii?Q?qtPGUxHi9GwmO6BnzLpSRPxYv63U7ZlEUl8WN3yFTXVOSQOs1gKwPE7tocCQ?=
 =?us-ascii?Q?gUE3xSUkdqY5QK9BDHKix0ZgnczHJMwd2BhutEmikRjvAhDazsQzTkAedei4?=
 =?us-ascii?Q?Xv3slVkF1rwt5KkGmV4fFZICqgMtnqivbFFKo8Zn7aZITz5UDlaJW12wbC8F?=
 =?us-ascii?Q?j5PYquG3UeQnVVzJnB7rX3PtELsYSsnR14oqvJK+DgwU22VPwHTSj6wwgjf9?=
 =?us-ascii?Q?LLIjf++vnVCIQjP0tyDf9UT9EOfFla3dHj8oU+O6HQIklpea/Sp56ZWp6nmO?=
 =?us-ascii?Q?cF4aUvoh6NGbtYe5s83m8P3HXlIdmGvIX5iFujcqB0BZgvaG0hq65/S2N+z+?=
 =?us-ascii?Q?yC1HcaMk0zhOu0Di+GiTidlgBG6R+jhsnLTL3RRgyalH0ROOvZAQAaLpA5VD?=
 =?us-ascii?Q?MNQFLD0wHSmvyKsKdGAP9hzuX15hGx0pEJdPL8qyiqvxznPXUKmmXRd7SsvC?=
 =?us-ascii?Q?vIS844QDUp+tPMr7lwkkVVvHySaXQdUSZWX+s3CidLRRYsQl1emx/AwjyNeL?=
 =?us-ascii?Q?fbDq48pIk81H1VOFt9Y0l/TT5smI0+/LywOSiTzJUa5HV1oRN8viUC60sQJG?=
 =?us-ascii?Q?KeS38OD81t7o6OBuFFvga6IdG2GDMVAcZn3F8q1Gtl0gCz0MHtSnTUZSvDei?=
 =?us-ascii?Q?4DhMHGM4MOuLJWtwigFZLtQp21zEtPMUsmVPqL1DsbLV2bXSbqz86tx1SSIE?=
 =?us-ascii?Q?fwN766gDa62lFDCDYUH/lOZj28tc/LKbY1VJpBTZJFEVpZpd1RdbkT9TEclD?=
 =?us-ascii?Q?XPsSppQYnRs5/f7bi+xo/kBkUa/wnl66KJbgu8Sd17XzPL119ckTIcgSMVxj?=
 =?us-ascii?Q?7HG/F+g1C1GchAZ3gaCWdwMEGN9YFU6OxD4gG3NcbIVwobrA/MzHtG2uCBrb?=
 =?us-ascii?Q?5X2+NvfSu8EFqx5CDOe3PS+gNYg5mZt6DVjZnFgkgJSDXKKmubR4uRE5+KEs?=
 =?us-ascii?Q?pE2+mITgE0PIaw5XJYcD7iamTuRePIItmmkVTyc2uRTYWKGq0X+RoZiwgHoK?=
 =?us-ascii?Q?B09md3JySzpm/rsQM6TMJoqFErQY7slCOFBrpoeiK4NnXN9yGfwZpCAu3jwh?=
 =?us-ascii?Q?5+Dfi/o6ESCyyf5+kdEcm0bSGXTRgBE9g7LZYvFRiklYH6CWq7PWPF6sJUE7?=
 =?us-ascii?Q?UIs8SrGMduPME73T/C2ljvZh8BCBTJlvSDTcrSp5GcUqfyaoVzLyQ1u0RuZw?=
 =?us-ascii?Q?aAI3vooQeHNmRKtbpsL3SrES7t3wuvTMICPzeNL9HepfRBeLoGWtn0KeFZcG?=
 =?us-ascii?Q?QQ/Vk9vv8g3VlYno1rUQf+a9jJjHMJnX7Q9XOE7o50LwM4zcy0Yt9PLbzX5f?=
 =?us-ascii?Q?7Mjo670/nRXe+T9rt0RaczgNxbZBCZBFA+FoRJSLQrjzT2r3+Dyw62gN5O0d?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A01F450A23F19646AAA80E8F2876DD76@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r1VGR33CyvyNBEQzKZle5217v15i036YjC1aa0AG5lEC+HfRunwnBWw//d0hwWQtgdlSUaZVJAsAGYkUcB4/c9Lp8jliW+yzk2lhwtAeBPUaiXO/T5hrbEq26utzgdgXX5bb48OsIgxHt8PMdoQXNOdlLaGdcsEcZoLDxGapgIxYCqxW1nryvj1Gv0Ewj+q0TCloI8mHNYg5R7HhEOFRytMpqjT2NZ04ozZ6JJrmFhZAknYG7KbtsvlM401nJAUDTN8Ij8bV1VvqqnrHCIxJ8jq+IIZRbR9JxJrF4SqbEfKS04DKZKngZzE9dGJqYADZBGu/su7I+cKQ/ehse19LNNPbpTTKv6b/foLUdJAhnxhtMV8dV+J8H1nwDHBpbKsrFHPsmv7YJdF98PC+ZN1ylStW1bUrtm1HetZnqQ6WDwbsFrpCac5QSs8xgrddJij/QOeGUARwVjQQ6SsnWlXWjQLavXyYfa9LMgyreOpByGle0hvpNG7aqG3L+lHlZIYv4PE5fvE5/X8YEwFaDnonsXp6PjN5Ws6Frcowz4uOsZgn42OthRXWJ5qXizJrtHB29LRt42DpkIXHwYe0kbkF8TQTz84eAWrYST+0rNmnz999XxQX3R9rFZrgJTnPu5hb5otn0r1F4RUju/qWTP4Bhe1i+XMPrHvPDJH29jcE/ozVQTOMrb0HA/z88mz1DqqQjelu1sedUJoSM03GMnMM7CH6chxV4UJW5x4vgREwFKsC7PQlkW4bEPYtm4Nkv+JIxNPTC785AGRWEpBXjdGCr8qfglFLz1IpjK8/STH4axQ6v6NXFxmNNxttGvxAxcYslM62++HeypbnHWpIuRd70w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e43478f-65c9-4ba0-d482-08dbbb90df75
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 17:25:10.1772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/pDP7x6kJBKLXlNOrjXUEtTQSNl7czqwohGiwPon0admM5zVauHVGGb+2ed1yq3XeGa+LvJ9AT6KlNPLTXs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220150
X-Proofpoint-ORIG-GUID: z6CzucMrFx2eTSUS5XeHB-QOwIGk6L55
X-Proofpoint-GUID: z6CzucMrFx2eTSUS5XeHB-QOwIGk6L55
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 22, 2023, at 12:20 PM, Lorenzo Bianconi <lorenzo.bianconi@redhat.c=
om> wrote:
>=20
>> On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
>>> Introduce write_threads and write_v4_end_grace netlink commands similar
>>> to the ones available through the procfs.
>>> Introduce nfsd_nl_server_status_get_dumpit netlink command in order to
>>> report global server metadata.
>>>=20
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>> This patch can be tested with user-space tool reported below:
>>> https://github.com/LorenzoBianconi/nfsd-netlink.git
>>> ---
>>> Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
>>> fs/nfsd/netlink.c                     | 30 ++++++++
>>> fs/nfsd/netlink.h                     |  5 ++
>>> fs/nfsd/nfsctl.c                      | 98 +++++++++++++++++++++++++++
>>> include/uapi/linux/nfsd_netlink.h     | 11 +++
>>> 5 files changed, 177 insertions(+)
>>>=20
>>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
>>> index 403d3e3a04f3..fa1204892703 100644
>>> --- a/Documentation/netlink/specs/nfsd.yaml
>>> +++ b/Documentation/netlink/specs/nfsd.yaml
>>> @@ -62,6 +62,15 @@ attribute-sets:
>>>         name: compound-ops
>>>         type: u32
>>>         multi-attr: true
>>> +  -
>>> +    name: server-attr
>>> +    attributes:
>>> +      -
>>> +        name: threads
>>> +        type: u16
>>=20
>> 65k threads ought to be enough for anybody!
>=20
> maybe u8 is fine here :)

32-bit is the usual for this kind of interface. I don't think we need to go=
 with 16-bit.


>>> +      -
>>> +        name: v4-grace
>>> +        type: u8
>>>=20
>>> operations:
>>>   list:
>>> @@ -72,3 +81,27 @@ operations:
>>>       dump:
>>>         pre: nfsd-nl-rpc-status-get-start
>>>         post: nfsd-nl-rpc-status-get-done
>>> +    -
>>> +      name: threads-set
>>> +      doc: set the number of running threads
>>> +      attribute-set: server-attr
>>> +      flags: [ admin-perm ]
>>> +      do:
>>> +        request:
>>> +          attributes:
>>> +            - threads
>>> +    -
>>> +      name: v4-grace-release
>>> +      doc: release the grace period for nfsd's v4 lock manager
>>> +      attribute-set: server-attr
>>> +      flags: [ admin-perm ]
>>> +      do:
>>> +        request:
>>> +          attributes:
>>> +            - v4-grace
>>> +    -
>>> +      name: server-status-get
>>> +      doc: dump server status info
>>> +      attribute-set: server-attr
>>> +      dump:
>>> +        pre: nfsd-nl-server-status-get-start
>>> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
>>> index 0e1d635ec5f9..783a34e69354 100644
>>> --- a/fs/nfsd/netlink.c
>>> +++ b/fs/nfsd/netlink.c
>>> @@ -10,6 +10,16 @@
>>>=20
>>> #include <uapi/linux/nfsd_netlink.h>
>>>=20
>>> +/* NFSD_CMD_THREADS_SET - do */
>>> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_ATTR_THREADS + 1] =3D {
>>> + [NFSD_A_SERVER_ATTR_THREADS] =3D { .type =3D NLA_U16, },
>>> +};
>>> +
>>> +/* NFSD_CMD_V4_GRACE_RELEASE - do */
>>> +static const struct nla_policy nfsd_v4_grace_release_nl_policy[NFSD_A_=
SERVER_ATTR_V4_GRACE + 1] =3D {
>>> + [NFSD_A_SERVER_ATTR_V4_GRACE] =3D { .type =3D NLA_U8, },
>>> +};
>>> +
>>> /* Ops table for nfsd */
>>> static const struct genl_split_ops nfsd_nl_ops[] =3D {
>>> {
>>> @@ -19,6 +29,26 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
>>> .done =3D nfsd_nl_rpc_status_get_done,
>>> .flags =3D GENL_CMD_CAP_DUMP,
>>> },
>>> + {
>>> + .cmd =3D NFSD_CMD_THREADS_SET,
>>> + .doit =3D nfsd_nl_threads_set_doit,
>>> + .policy =3D nfsd_threads_set_nl_policy,
>>> + .maxattr =3D NFSD_A_SERVER_ATTR_THREADS,
>>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>> + },
>>> + {
>>> + .cmd =3D NFSD_CMD_V4_GRACE_RELEASE,
>>> + .doit =3D nfsd_nl_v4_grace_release_doit,
>>> + .policy =3D nfsd_v4_grace_release_nl_policy,
>>> + .maxattr =3D NFSD_A_SERVER_ATTR_V4_GRACE,
>>> + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>> + },
>>> + {
>>> + .cmd =3D NFSD_CMD_SERVER_STATUS_GET,
>>> + .start =3D nfsd_nl_server_status_get_start,
>>> + .dumpit =3D nfsd_nl_server_status_get_dumpit,
>>> + .flags =3D GENL_CMD_CAP_DUMP,
>>> + },
>>> };
>>>=20
>>> struct genl_family nfsd_nl_family __ro_after_init =3D {
>>> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
>>> index d83dd6bdee92..2e98061fbb0a 100644
>>> --- a/fs/nfsd/netlink.h
>>> +++ b/fs/nfsd/netlink.h
>>> @@ -12,10 +12,15 @@
>>> #include <uapi/linux/nfsd_netlink.h>
>>>=20
>>> int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
>>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb);
>>> int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
>>>=20
>>> int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>>>  struct netlink_callback *cb);
>>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
>>> +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_inf=
o *info);
>>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
>>> +     struct netlink_callback *cb);
>>>=20
>>> extern struct genl_family nfsd_nl_family;
>>>=20
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index b71744e355a8..c631b59b7a4f 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1694,6 +1694,104 @@ int nfsd_nl_rpc_status_get_done(struct netlink_=
callback *cb)
>>> return 0;
>>> }
>>>=20
>>> +/**
>>> + * nfsd_nl_threads_set_doit - set the number of running threads
>>> + * @skb: reply buffer
>>> + * @info: netlink metadata and command arguments
>>> + *
>>> + * Return 0 on success or a negative errno.
>>> + */
>>> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo)
>>> +{
>>> + u16 nthreads;
>>> + int ret;
>>> +
>>> + if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
>>> + return -EINVAL;
>>> +
>>> + nthreads =3D nla_get_u16(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
>>> +
>>> + ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
>>> + return ret =3D=3D nthreads ? 0 : ret;
>>> +}
>>> +
>>> +/**
>>> + * nfsd_nl_v4_grace_release_doit - release the nfs4 grace period
>>> + * @skb: reply buffer
>>> + * @info: netlink metadata and command arguments
>>> + *
>>> + * Return 0 on success or a negative errno.
>>> + */
>>> +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_inf=
o *info)
>>> +{
>>> +#ifdef CONFIG_NFSD_V4
>>> + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id)=
;
>>> +
>>> + if (!info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE])
>>> + return -EINVAL;
>>> +
>>> + if (nla_get_u8(info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE]))
>>> + nfsd4_end_grace(nn);
>>> +
>>=20
>> To be clear here. Issuing this with anything but 0 will end the grace
>> period. A value of 0 is ignored. It might be best to make the value not
>=20
> I tried to be aligned with write_v4_end_grace() here but supporting just =
1 (or
> any other non-zero value) and skipping 'Y/y'. If we send 0 it should skip=
 the
> release action.
>=20
>> matter at all. Do we have to send down a value at all?
>=20
> I am not sure if ynl supports a doit operation with a request with no par=
ameters.
> @Chuck, Jakub: any input here?

I think it does, I might have done something like that for one of the
handshake protocol commands.

But I think Jeff's right, end_grace might be better postponed. Pick any of
the others that you think might be easy to implement instead.


> Regards,
> Lorenzo
>=20
>>=20
>>> + return 0;
>>> +#else
>>> + return -EOPNOTSUPP;
>>> +#endif /* CONFIG_NFSD_V4 */
>>> +}
>>> +
>>> +/**
>>> + * nfsd_nl_server_status_get_start - Prepare server_status_get dumpit
>>> + * @cb: netlink metadata and command arguments
>>> + *
>>> + * Return values:
>>> + *   %0: The server_status_get command may proceed
>>> + *   %-ENODEV: There is no NFSD running in this namespace
>>> + */
>>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
>>> +{
>>> + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_i=
d);
>>> +
>>> + return nn->nfsd_serv ? 0 : -ENODEV;
>>> +}
>>> +
>>> +/**
>>> + * nfsd_nl_server_status_get_dumpit - dump server status info
>>> + * @skb: reply buffer
>>> + * @cb: netlink metadata and command arguments
>>> + *
>>> + * Returns the size of the reply or a negative errno.
>>> + */
>>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
>>> +     struct netlink_callback *cb)
>>> +{
>>> + struct net *net =3D sock_net(skb->sk);
>>> +#ifdef CONFIG_NFSD_V4
>>> + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>>> +#endif /* CONFIG_NFSD_V4 */
>>> + void *hdr;
>>> +
>>> + if (cb->args[0]) /* already consumed */
>>> + return 0;
>>> +
>>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_s=
eq,
>>> +  &nfsd_nl_family, NLM_F_MULTI,
>>> +  NFSD_CMD_SERVER_STATUS_GET);
>>> + if (!hdr)
>>> + return -ENOBUFS;
>>> +
>>> + if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net))=
)
>>> + return -ENOBUFS;
>>> +#ifdef CONFIG_NFSD_V4
>>> + if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
>>> + return -ENOBUFS;
>>> +#endif /* CONFIG_NFSD_V4 */
>>> +
>>> + genlmsg_end(skb, hdr);
>>> + cb->args[0] =3D 1;
>>> +
>>> + return skb->len;
>>> +}
>>> +
>>> /**
>>>  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>>>  * @net: a freshly-created network namespace
>>> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfs=
d_netlink.h
>>> index c8ae72466ee6..b82fbc53d336 100644
>>> --- a/include/uapi/linux/nfsd_netlink.h
>>> +++ b/include/uapi/linux/nfsd_netlink.h
>>> @@ -29,8 +29,19 @@ enum {
>>> NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>>> };
>>>=20
>>> +enum {
>>> + NFSD_A_SERVER_ATTR_THREADS =3D 1,
>>> + NFSD_A_SERVER_ATTR_V4_GRACE,
>>> +
>>> + __NFSD_A_SERVER_ATTR_MAX,
>>> + NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
>>> +};
>>> +
>>> enum {
>>> NFSD_CMD_RPC_STATUS_GET =3D 1,
>>> + NFSD_CMD_THREADS_SET,
>>> + NFSD_CMD_V4_GRACE_RELEASE,
>>> + NFSD_CMD_SERVER_STATUS_GET,
>>>=20
>>> __NFSD_CMD_MAX,
>>> NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
>>=20
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>>=20

--
Chuck Lever


