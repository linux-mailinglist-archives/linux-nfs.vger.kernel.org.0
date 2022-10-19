Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CA560497B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJSOkw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJSOkU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 10:40:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA35B52B
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 07:25:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JDQvgW006108;
        Wed, 19 Oct 2022 14:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3dGfieXqouRQa03ioUO+Mx6TEBkFJSHDN7ZNv1RRApA=;
 b=lp4kx0y40R38cy45Ro/g7KTvAOHN41DasLdhRlVZ/CNP5j7xY8VUvVtgKz7BXXhxRhxo
 jwfwHCpHjRfYddhK0/WBguqVVhsrrHTBzcyBXS5/cLMc6rwYw3V4mZgaM6LiT+1K0is5
 zMIqr1iCTUdm2S6Yajd+/Tx/21uANgLEVzjl68Rd0WBss3cy8k3HS/jhqF65SpcmvbtP
 hdpvxdq6JX+VbdBA8/hCHYWZnaK3WMLq4UnWTTXRKGkON5U3seg2aDEbJEDuW9GvTl8k
 hgKHoVd99+4PG+tsLOhCwyZ96XeCQR3iL+SC3kt+JPO8nW9GcGA8xMc9HoyGgTwrjgXL zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3j1hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:25:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JDwWvg029163;
        Wed, 19 Oct 2022 14:25:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu8rh80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdwGCJRmW1iboMcRJyYtwq2k/hIKGgtjUDoSBIjxaSJ/NetLZ9V6nCLjW/9/I93kQYc9KixHCr+7vrOKmz2sCRvKE6tbiDw4xJUFa+6+kKo0Fpa+p5+kTZUbP3xZgKh1TIOl1wE+zUZ0EvOhGjLIdGeSazMOhOiE7GC1HRMmhe6MGqnQ6u6noSYqJqsuxtwlk0Aq1wxrLqd6hEYf0fyRSxY0NKikVm07460pK6c5qh3Dh0EsM91ZACSqXSnzwCcsset7zaZaxsmQ1zZNShIffqBQZX1+cyoXe9N9qJe4qmlHVn7UuEUZeNJC6SW+RCpPJFiOwrg/UsmWjHrs6Q19pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dGfieXqouRQa03ioUO+Mx6TEBkFJSHDN7ZNv1RRApA=;
 b=A4LS41EEwz6O22lcul7MFpBWWmdg8jvOIOOGlaoAqWTBbGMv0K0e5lksiVHJz44vrywMcMfUbRfAxIV7KHn/S0K5vVpNbeZpJSjXVNxU1/UIiO5N/7A4HMvug6QkkE3avKGkwedUSq77iBW78a4OwbYwHj3WAOIF5xP/bm6kC/wt0lDhbxhqeQvKXKsJbwBFk3x6XKF7wbU7Q+zBsmcYAB/ePOEdXYOy+8Inyl1+yeLGyC39Xis/tKltfKp5s6S7UdJT6N3cel/xhhUkA6kmpTtWGj190ag/4mYZw7f2OFWT+8/FbTReXdotz4R+qeW0m6eJEZyIenJT8GSo9HXazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dGfieXqouRQa03ioUO+Mx6TEBkFJSHDN7ZNv1RRApA=;
 b=OUtzMVroeug2VSLb2AzabQ3uvYQ0V7UC9D0T7VKulA2PZ2PNKsHO7Eqx0aUt/rneoL5gcpBXVWjAPF62NHQhgswRVhwol+M1i0v8Q0FC+hI6X334F+agxOMhACbICBLH1MK1d9yeEdQJLTXNiyfLDhfoewgTLd5k85UbCSJ8eNY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5857.namprd10.prod.outlook.com (2603:10b6:a03:3ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 14:25:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%4]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 14:25:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@poochiereds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Topic: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
Thread-Index: AQHY4ywcCv9nfMlOd0+Wa/Y/m9MOsq4VmJcAgAAuS4A=
Date:   Wed, 19 Oct 2022 14:25:19 +0000
Message-ID: <1DE04392-E8C9-4D39-BF23-BD1A59DB4FE3@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
 <cdad5af44b1c62c8e2ceae27cb2b646f7b2ec0bd.camel@poochiereds.net>
In-Reply-To: <cdad5af44b1c62c8e2ceae27cb2b646f7b2ec0bd.camel@poochiereds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5857:EE_
x-ms-office365-filtering-correlation-id: 8d8b0cfe-a56e-42df-ed49-08dab1ddc06b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IMKJY6bgjjKLh8HTUyjAPb/wzuLiP0Fq0r8y6iQ7+aZbcOCyqdwVF2EtiOJvY6o6odKsxQbYq0nD0h8ocU4jaKLHz3YzeO1Q9t751FCBdK31C++ZRAGhTLSlAKbC7eg7PtRO1k2vMEhJP7CqrE99sZCPOUpBiMfXga3p8L7+3rdqDq6MqGHu1H+enQCXFXiF3TjN/PpB5IZ/4QgkXUSPCdVH7J6eVzyxLyGNo/LWqqnMkIRImptmXEiqbmxR5VbTiITB4YAZboHMnXfY/5xltnh+iGDYFU/0jvirpiGnuUW1+7NR8erfAAyuM7PQWMjI8UPCv6j7gi0MexPIItNwhbWzmgrtiQKgDuoZISTU+8TbQP2MPB72IA1FBNWmbLn8XHvsf0Qgynv6MbiO/BGFmF0ZmJkI+OUh6DKhFQl8YJRB/eMDfTUYb8gfyzAzm4ElFr4QDTMy88dtHhbdpXv3Nm5qoX0Vt6YpE4emjSOInNbCauowkaSVszpYoxzg52m2JXVCZjUDoJI9/67pltLXcELRWDnseEdo+b9eh/FHQ6OdaEXHUd2bHgdfeWVxXgN/EvH1mlwUJtwRPCAF7coJn7pJapsF8ADqzl04acvYgAfV3vtYkRBwyQouqAjh/zZnkSGajilT9x6JNdxmEVAmZIHq50IyymNFbBBftI1/43GmtLi3qKV8j6Cx/JLS0gLK4xUW40lD07cKAhMH7MvwHPh8QBV67Zf9XRR9q4ZhwH9ix9AqWHyZk5QQ0F35IdMFllXafMnKd/xxbx4tmxy+3+6GvymrhCLLVksNLgc3hR55mjoyOlNHidOIP25ztluWMJ5dG2nkeVBzipiEE4U4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(66899015)(6486002)(6916009)(316002)(71200400001)(91956017)(478600001)(54906003)(76116006)(66556008)(66446008)(186003)(2906002)(4001150100001)(4326008)(66946007)(64756008)(66476007)(8676002)(6512007)(6506007)(8936002)(53546011)(41300700001)(26005)(30864003)(5660300002)(2616005)(36756003)(33656002)(86362001)(83380400001)(38100700002)(38070700005)(122000001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?svTaP3LpnMRc6DrH5+SEEGeSuKYMbaflryalr2prtD1rqIzWUc3b4o/gMqO7?=
 =?us-ascii?Q?w2aLpxdFkEYV5dva1/W0SYkbJtoydRrYiHXmTCIsVU/DTbUFC5owULGiMWPJ?=
 =?us-ascii?Q?t2blCm3aPcMH72o9p7gxSglvPzhiBs+wytIoRpESPL/U75NiovVPT+wCtkdY?=
 =?us-ascii?Q?1Z26xMT4cjO2NfnV2ly7zirK1mCvAnZXPdy8gPCz7Ci6V6IMKUfP/jW9qVr8?=
 =?us-ascii?Q?Twaw6gTgnUyfOQ6qAoD9fYc26n1SyoddKhuMgafVsCJW1U2RD8orBKY9J9VX?=
 =?us-ascii?Q?QU679xtN1j11bd0RvKA2+JSPNqLF2KQoqazFNPFXEc4eHH7LgT7I7PWwY47P?=
 =?us-ascii?Q?Kffu2x0+LpcxtLjtcCiUifTV/yQQ5Lfq/tU/Z24Cu75mWxHkcm+clWjHO/4+?=
 =?us-ascii?Q?tFl+fHPFzZSGihuwR6bj0KvI0x0A1kI5wPFfW/54r+oY9FvZrf9H4C3DCl9H?=
 =?us-ascii?Q?P7gOnFzvyQ+2GKLHsKKv9eWsIcr/J55dbP+oEOv177DiuC+bhNK4ae0Z+Oq4?=
 =?us-ascii?Q?ELQUYvY8vryUXQq6wLtKycaIxyJcKFT40yonz5WASNl4fwS89/DcVq2DghKW?=
 =?us-ascii?Q?weL3D/qohhck+y43DndWxRKVE8HSm+4pwdIb1gribAptiM6q7SY1vMAn+kDx?=
 =?us-ascii?Q?8BxVqB43Rl6kqPDeN9SEGYrV2TO/eyf4VOksuXeoPK2SI5RlSOvXZ+vQPslt?=
 =?us-ascii?Q?sBvqGt3pGms40tvO7llCHVbLjnjDVnFPzOYwNnszEjsqMJyB0xnkLZIwK9g7?=
 =?us-ascii?Q?qzDAbEDMiR2qYah2Fo2PpEenX3bbxfNbSiASPtc3rFJWG1/DvYgHlEF5T2gJ?=
 =?us-ascii?Q?oqkgEZRrwoAfPoGYUNUc7LpB0cyqBTCGC1Ss/GFVZn4GgO7k7/kJSRZKQSNn?=
 =?us-ascii?Q?3x2eppQCtpLsRcZTXN8WFSX5PqJwA9l10+InE5TyzhqMiQhs4hmBKnx9TeL1?=
 =?us-ascii?Q?vvqs22nLmoZr9SBhvdl0Dq0vzfoMGOvcDdazSi2HI6yub/DqMYNuDBbjDHzw?=
 =?us-ascii?Q?FdoR3Jjg7ke8wtsDgMZoBk3RGJSEnwZAN4nbog5jDLrci/jRUqiNEkNSAL4o?=
 =?us-ascii?Q?a1PdvyQIxfK0DTH2VRQE1E8ykn2KqM1y03rqqwo3y7nUs+z4ZjfJOx5mW+mR?=
 =?us-ascii?Q?7+skNgbPF2qK6NZNWykjma3QsTDcMIaAiIIgDRtTw4pmolpCJEdRaUQvKv1L?=
 =?us-ascii?Q?mkFTlF8LTPOzr+uuPjaL59V2G7eyFNQ5YdhOL1XZN/aBIWtaP56hKb/vJzRA?=
 =?us-ascii?Q?H3Qaa1YIpxalIvYAa60PdVl1pVdUK/wyoMhI8NK1KpVu9Na18Yq2stQ+0gU9?=
 =?us-ascii?Q?JNNP5V/QZ+pYQaGR+wvri5RO1lj/OFKPqhm5vFk1i5Ca/xtBNYnoR6IZd61V?=
 =?us-ascii?Q?mKiiMqaCJdSTt7bzBgvfGR9gUZr+WZoAmBZs/RpFUm0YtjmbQW7+XqEiqvE4?=
 =?us-ascii?Q?6KHWiciOcyWiPWBuiaWGvA5SnjYtsd0+KI+M8rA5+4OzzLAgPHOyH0IExR+B?=
 =?us-ascii?Q?sxLqz1NXgn12H2kjuAEt7oDBRPtfRLjuSLIeAXmlvD1uGu4y8zork1/6ePCi?=
 =?us-ascii?Q?MW5HOPJN5zvwOz2qqOMyRO38WCMAdppENne5O70TXLJKE9CDozZBjlrPg8yX?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13E6DEAA9474394D9DE667B2BF4D5DAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b0cfe-a56e-42df-ed49-08dab1ddc06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 14:25:19.9908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvh9ByqOF0dDfcZcerjebk8QVanpVDu13KuQhNFc6gJJwF4dPsM1ALLf1TSW6ANVBIRuS49XrmIp+Pq9/laFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190081
X-Proofpoint-ORIG-GUID: hYbWMkpfFLaGGHddwJE9F-HG4YzrJW_a
X-Proofpoint-GUID: hYbWMkpfFLaGGHddwJE9F-HG4YzrJW_a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 19, 2022, at 7:39 AM, Jeff Layton <jlayton@poochiereds.net> wrote:
>=20
> On Tue, 2022-10-18 at 15:58 -0400, Chuck Lever wrote:
>> fh_match() is costly, especially when filehandles are large (as is
>> the case for NFSv4). It needs to be used sparingly when searching
>> data structures. Unfortunately, with common workloads, I see
>> multiple thousands of objects stored in file_hashtbl[], which always
>> has only 256 buckets, which makes the hash chains quite lengthy.
>>=20
>> Walking long hash chains with the state_lock held blocks other
>> activity that needs that lock.
>>=20
>> To help mitigate the cost of searching with fh_match(), replace the
>> nfs4_file hash table with an rhashtable, which can dynamically
>> resize its bucket array to minimize hash chain length. The ideal for
>> this use case is one bucket per inode.
>>=20
>> The result is an improvement in the latency of NFSv4 operations
>> and the reduction of nfsd CPU utilization due to the cost of
>> fh_match() and the CPU cache misses incurred while walking long
>> hash chains in the nfs4_file hash table.
>>=20
>> Note that hash removal is no longer protected by the state_lock.
>> This is because insert_nfs4_file() takes the RCU read lock then the
>> state_lock. rhltable_remove() takes the RCU read lock internally;
>> if remove_nfs4_file() took the state_lock before calling
>> rhltable_remove(), that would result in a lock inversion.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |  215 +++++++++++++++++++++++++++++++++++----------=
------
>> fs/nfsd/state.h     |    5 -
>> 2 files changed, 147 insertions(+), 73 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 2b850de288cf..a63334ad61f6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -44,7 +44,9 @@
>> #include <linux/jhash.h>
>> #include <linux/string_helpers.h>
>> #include <linux/fsnotify.h>
>> +#include <linux/rhashtable.h>
>> #include <linux/nfs_ssc.h>
>> +
>> #include "xdr4.h"
>> #include "xdr4cb.h"
>> #include "vfs.h"
>> @@ -84,6 +86,7 @@ static bool check_for_locks(struct nfs4_file *fp, stru=
ct nfs4_lockowner *lowner)
>> static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
>> void nfsd4_end_grace(struct nfsd_net *nn);
>> static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cp=
ntf_state *cps);
>> +static void remove_nfs4_file(struct nfs4_file *fi);
>>=20
>> /* Locking: */
>>=20
>> @@ -577,11 +580,8 @@ static void nfsd4_free_file_rcu(struct rcu_head *rc=
u)
>> void
>> put_nfs4_file(struct nfs4_file *fi)
>> {
>> -	might_lock(&state_lock);
>> -
>> -	if (refcount_dec_and_lock(&fi->fi_ref, &state_lock)) {
>> -		hlist_del_rcu(&fi->fi_hash);
>> -		spin_unlock(&state_lock);
>> +	if (refcount_dec_and_test(&fi->fi_ref)) {
>> +		remove_nfs4_file(fi);
>> 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>> 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
>> 		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
>> @@ -695,19 +695,82 @@ static unsigned int ownerstr_hashval(struct xdr_ne=
tobj *ownername)
>> 	return ret & OWNER_HASH_MASK;
>> }
>>=20
>> -/* hash table for nfs4_file */
>> -#define FILE_HASH_BITS                   8
>> -#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
>> +static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
>> +
>> +/*
>> + * The returned hash value is based solely on the address of an in-code
>> + * inode, a pointer to a slab-allocated object. The entropy in such a
>> + * pointer is concentrated in its middle bits.
>> + */
>> +static u32 nfs4_file_inode_hash(const struct inode *inode, u32 seed)
>> +{
>> +	u32 k;
>> +
>> +	k =3D ((unsigned long)inode) >> L1_CACHE_SHIFT;
>> +	return jhash2(&k, 1, seed);
>> +}
>>=20
>> -static unsigned int file_hashval(struct svc_fh *fh)
>> +/**
>> + * nfs4_file_key_hashfn - Compute the hash value of a lookup key
>> + * @data: key on which to compute the hash value
>> + * @len: rhash table's key_len parameter (unused)
>> + * @seed: rhash table's random seed of the day
>> + *
>> + * Return value:
>> + *   Computed 32-bit hash value
>> + */
>> +static u32 nfs4_file_key_hashfn(const void *data, u32 len, u32 seed)
>> {
>> -	struct inode *inode =3D d_inode(fh->fh_dentry);
>> +	const struct svc_fh *fhp =3D data;
>>=20
>> -	/* XXX: why not (here & in file cache) use inode? */
>> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
>> +	return nfs4_file_inode_hash(d_inode(fhp->fh_dentry), seed);
>> }
>>=20
>> -static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>> +/**
>> + * nfs4_file_obj_hashfn - Compute the hash value of an nfs4_file object
>> + * @data: object on which to compute the hash value
>> + * @len: rhash table's key_len parameter (unused)
>> + * @seed: rhash table's random seed of the day
>> + *
>> + * Return value:
>> + *   Computed 32-bit hash value
>> + */
>> +static u32 nfs4_file_obj_hashfn(const void *data, u32 len, u32 seed)
>> +{
>> +	const struct nfs4_file *fi =3D data;
>> +
>> +	return nfs4_file_inode_hash(fi->fi_inode, seed);
>> +}
>> +
>> +/**
>> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
>> + * @arg: search criteria
>> + * @ptr: cache item to check
>> + *
>> + * Return values:
>> + *   %0 - Success; item matches search criteria
>> + */
>> +static int nfs4_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
>> +			       const void *ptr)
>> +{
>> +	const struct svc_fh *fhp =3D arg->key;
>> +	const struct nfs4_file *fi =3D ptr;
>> +
>> +	return fh_match(&fi->fi_fhandle, &fhp->fh_handle) ? 0 : 1;
>> +}
>> +
>> +static const struct rhashtable_params nfs4_file_rhash_params =3D {
>> +	.key_len		=3D sizeof_field(struct nfs4_file, fi_inode),
>> +	.key_offset		=3D offsetof(struct nfs4_file, fi_inode),
>> +	.head_offset		=3D offsetof(struct nfs4_file, fi_rhash),
>> +	.hashfn			=3D nfs4_file_key_hashfn,
>> +	.obj_hashfn		=3D nfs4_file_obj_hashfn,
>> +	.obj_cmpfn		=3D nfs4_file_obj_cmpfn,
>> +
>> +	/* Reduce resizing churn on light workloads */
>> +	.min_size		=3D 512,		/* buckets */
>> +	.automatic_shrinking	=3D true,
>> +};
>>=20
>> /*
>>  * Check if courtesy clients have conflicting access and resolve it if p=
ossible
>> @@ -4251,11 +4314,8 @@ static struct nfs4_file *nfsd4_alloc_file(void)
>> }
>>=20
>> /* OPEN Share state helper functions */
>> -static void nfsd4_init_file(struct svc_fh *fh, unsigned int hashval,
>> -				struct nfs4_file *fp)
>> +static void init_nfs4_file(const struct svc_fh *fh, struct nfs4_file *f=
p)
>> {
>> -	lockdep_assert_held(&state_lock);
>> -
>> 	refcount_set(&fp->fi_ref, 1);
>> 	spin_lock_init(&fp->fi_lock);
>> 	INIT_LIST_HEAD(&fp->fi_stateids);
>> @@ -4273,7 +4333,6 @@ static void nfsd4_init_file(struct svc_fh *fh, uns=
igned int hashval,
>> 	INIT_LIST_HEAD(&fp->fi_lo_states);
>> 	atomic_set(&fp->fi_lo_recalls, 0);
>> #endif
>> -	hlist_add_head_rcu(&fp->fi_hash, &file_hashtbl[hashval]);
>> }
>>=20
>> void
>> @@ -4626,71 +4685,75 @@ move_to_close_lru(struct nfs4_ol_stateid *s, str=
uct net *net)
>> 		nfs4_put_stid(&last->st_stid);
>> }
>>=20
>> -/* search file_hashtbl[] for file */
>> -static struct nfs4_file *
>> -find_file_locked(struct svc_fh *fh, unsigned int hashval)
>> +static struct nfs4_file *find_nfs4_file(const struct svc_fh *fhp)
>> {
>> -	struct nfs4_file *fp;
>> +	struct rhlist_head *tmp, *list;
>> +	struct nfs4_file *fi =3D NULL;
>>=20
>> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
>> -				lockdep_is_held(&state_lock)) {
>> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
>> -			if (refcount_inc_not_zero(&fp->fi_ref))
>> -				return fp;
>> +	list =3D rhltable_lookup(&nfs4_file_rhltable, fhp,
>> +			       nfs4_file_rhash_params);
>> +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rhash)
>> +		if (fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>> +			if (!refcount_inc_not_zero(&fi->fi_ref))
>> +				fi =3D NULL;
>> +			break;
>> 		}
>> -	}
>> -	return NULL;
>> +	return fi;
>> }
>>=20
>> -static struct nfs4_file *insert_file(struct nfs4_file *new, struct svc_=
fh *fh,
>> -				     unsigned int hashval)
>> +/*
>> + * On hash insertion, identify entries with the same inode but
>> + * distinct filehandles. They will all be in the same hash bucket
>> + * because we hash by the address of the nfs4_file's struct inode.
>> + */
>> +static struct nfs4_file *insert_file(struct nfs4_file *new,
>> +				     const struct svc_fh *fhp)
>> {
>> -	struct nfs4_file *fp;
>> -	struct nfs4_file *ret =3D NULL;
>> -	bool alias_found =3D false;
>> +	struct rhlist_head *tmp, *list;
>> +	struct nfs4_file *fi;
>> +	int err;
>>=20
>> 	spin_lock(&state_lock);
>> -	hlist_for_each_entry_rcu(fp, &file_hashtbl[hashval], fi_hash,
>> -				 lockdep_is_held(&state_lock)) {
>> -		if (fh_match(&fp->fi_fhandle, &fh->fh_handle)) {
>> -			if (refcount_inc_not_zero(&fp->fi_ref))
>> -				ret =3D fp;
>> -		} else if (d_inode(fh->fh_dentry) =3D=3D fp->fi_inode)
>> -			fp->fi_aliased =3D alias_found =3D true;
>> -	}
>> -	if (likely(ret =3D=3D NULL)) {
>> -		nfsd4_init_file(fh, hashval, new);
>> -		new->fi_aliased =3D alias_found;
>> -		ret =3D new;
>> +
>> +	err =3D rhltable_insert_key(&nfs4_file_rhltable, fhp,
>> +				  &new->fi_rhash,
>> +				  nfs4_file_rhash_params);
>> +	if (err) {
>> +		spin_unlock(&state_lock);
>> +		return NULL;
>> 	}
>> +
>> +	list =3D rhltable_lookup(&nfs4_file_rhltable, fhp,
>> +			       nfs4_file_rhash_params);
>> +	rhl_for_each_entry_rcu(fi, tmp, list, fi_rhash)
>> +		if (fi->fi_inode =3D=3D d_inode(fhp->fh_dentry) &&
>> +		    !fh_match(&fi->fi_fhandle, &fhp->fh_handle)) {
>> +			fi->fi_aliased =3D true;
>> +			new->fi_aliased =3D true;
>> +		}
>> +
>> 	spin_unlock(&state_lock);
>> -	return ret;
>> +	return new;
>> }
>>=20
>> -static struct nfs4_file * find_file(struct svc_fh *fh)
>> +static noinline struct nfs4_file *
>> +insert_nfs4_file(struct nfs4_file *new, const struct svc_fh *fhp)
>> {
>> -	struct nfs4_file *fp;
>> -	unsigned int hashval =3D file_hashval(fh);
>> +	struct nfs4_file *fi;
>>=20
>> -	rcu_read_lock();
>> -	fp =3D find_file_locked(fh, hashval);
>> -	rcu_read_unlock();
>> -	return fp;
>> +	/* Do not hash the same filehandle more than once */
>> +	fi =3D find_nfs4_file(fhp);
>> +	if (unlikely(fi))
>> +		return fi;
>> +
>> +	init_nfs4_file(fhp, new);
>> +	return insert_file(new, fhp);
>> }
>>=20
>> -static struct nfs4_file *
>> -find_or_add_file(struct nfs4_file *new, struct svc_fh *fh)
>> +static noinline void remove_nfs4_file(struct nfs4_file *fi)
>> {
>> -	struct nfs4_file *fp;
>> -	unsigned int hashval =3D file_hashval(fh);
>> -
>> -	rcu_read_lock();
>> -	fp =3D find_file_locked(fh, hashval);
>> -	rcu_read_unlock();
>> -	if (fp)
>> -		return fp;
>> -
>> -	return insert_file(new, fh, hashval);
>> +	rhltable_remove(&nfs4_file_rhltable, &fi->fi_rhash,
>> +			nfs4_file_rhash_params);
>> }
>>=20
>> /*
>> @@ -4703,9 +4766,12 @@ nfs4_share_conflict(struct svc_fh *current_fh, un=
signed int deny_type)
>> 	struct nfs4_file *fp;
>> 	__be32 ret =3D nfs_ok;
>>=20
>> -	fp =3D find_file(current_fh);
>> +	rcu_read_lock();
>> +	fp =3D find_nfs4_file(current_fh);
>> +	rcu_read_unlock();
>> 	if (!fp)
>> 		return ret;
>> +
>> 	/* Check for conflicting share reservations */
>> 	spin_lock(&fp->fi_lock);
>> 	if (fp->fi_share_deny & deny_type)
>> @@ -5548,7 +5614,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struc=
t svc_fh *current_fh, struct nf
>> 	 * and check for delegations in the process of being recalled.
>> 	 * If not found, create the nfs4_file struct
>> 	 */
>> -	fp =3D find_or_add_file(open->op_file, current_fh);
>> +	rcu_read_lock();
>> +	fp =3D insert_nfs4_file(open->op_file, current_fh);
>> +	rcu_read_unlock();
>=20
> It'd probably be better to push this rcu_read_lock down into
> insert_nfs4_file. You don't need to hold it over the actual insertion,
> since that requires the state_lock.

I used this arrangement because:

insert_nfs4_file() invokes only find_nfs4_file() and the
insert_file() helper. Both find_nfs4_file() and the
insert_file() helper invoke rhltable_lookup(), which
must be called with the RCU read lock held.

And this is the reason why put_nfs4_file() no longer takes
the state_lock: it would take the state_lock first and
then the RCU read lock (which is implicitly taken in
rhltable_remove()), which results in a lock inversion
relative to insert_nfs4_file(), which takes the RCU read
lock first, then the state_lock.


I'm certainly not an expert, so I'm willing to listen to
alternative approaches. Can we rely on only the RCU read
lock for exclusion on hash insertion?


>> +	if (unlikely(!fp))
>> +		return nfserr_jukebox;
>> 	if (fp !=3D open->op_file) {
>> 		status =3D nfs4_check_deleg(cl, open, &dp);
>> 		if (status)
>> @@ -7905,10 +7975,16 @@ nfs4_state_start(void)
>> {
>> 	int ret;
>>=20
>> -	ret =3D nfsd4_create_callback_queue();
>> +	ret =3D rhltable_init(&nfs4_file_rhltable, &nfs4_file_rhash_params);
>> 	if (ret)
>> 		return ret;
>>=20
>> +	ret =3D nfsd4_create_callback_queue();
>> +	if (ret) {
>> +		rhltable_destroy(&nfs4_file_rhltable);
>> +		return ret;
>> +	}
>> +
>> 	set_max_delegations();
>> 	return 0;
>> }
>> @@ -7939,6 +8015,7 @@ nfs4_state_shutdown_net(struct net *net)
>>=20
>> 	nfsd4_client_tracking_exit(net);
>> 	nfs4_state_destroy_net(net);
>> +	rhltable_destroy(&nfs4_file_rhltable);
>> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>> 	nfsd4_ssc_shutdown_umount(nn);
>> #endif
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index ae596dbf8667..ad20467c9dee 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -536,16 +536,13 @@ struct nfs4_clnt_odstate {
>>  * inode can have multiple filehandles associated with it, so there is
>>  * (potentially) a many to one relationship between this struct and stru=
ct
>>  * inode.
>> - *
>> - * These are hashed by filehandle in the file_hashtbl, which is protect=
ed by
>> - * the global state_lock spinlock.
>>  */
>> struct nfs4_file {
>> 	refcount_t		fi_ref;
>> 	struct inode *		fi_inode;
>> 	bool			fi_aliased;
>> 	spinlock_t		fi_lock;
>> -	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
>> +	struct rhlist_head	fi_rhash;
>> 	struct list_head        fi_stateids;
>> 	union {
>> 		struct list_head	fi_delegations;
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@poochiereds.net>

--
Chuck Lever



