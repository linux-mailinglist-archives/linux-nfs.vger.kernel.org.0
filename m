Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A125A6DB8
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 21:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiH3Tqi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 15:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiH3Tqe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 15:46:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FB07A744
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 12:46:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI3jVA005533;
        Tue, 30 Aug 2022 19:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HxgmQgjdgklxUlS0/MEa1wVb2N6PqNoOResmdKOKQ7I=;
 b=Dyhp5eaUXVHpX0ihAZ0MoBrTdGOczH+33hVY3ZiYXp/Jtu3X0Ncm8QPjLYRZGj1C3elb
 4Lu1yvZ6XL/iUI8zByYTn1evgJ2qBsTO4vWGWQ2/w1w+YiszCp3WPoFVYUxDlE2W/lzr
 QNNyMeXg+ar1ENODjRp09B4aDch1LfJA6UTZHT5jwWmkbqi9Lxju2FHMjsmJVyd2FTPI
 0qB7WsE+FEgrd7fZcEiZV0FzfQE9R7O9b+1qXn7ss4ZOkZ+4r8GQkYNFE6XIHFz1w6pv
 tu+inRhZSwZ4Cc4N5FvBQ3yuZHZ1E5IWY+5SMxnLt4qHfs/vqbhN3Y+CFmfSeTir/cwC iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pby875-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:46:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXbJi027257;
        Tue, 30 Aug 2022 19:46:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4adhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id45gBQ9uEyfvqAJD91lJr7q1aMJGPIFI8ynlP0WhguPsYWRs+HxplcIJlTVjrVtEPgzT5eF5XhXHtAbbUxbtumt8oXq8TaxUIulWrGX179wrMXrOiRBWzHxuVTzkov1sMl02h+DVoGfDRkm6AfwYbxM0+A53Ua1OQA1tY0U8r9ytLjkAaRVWUetHxtrzoP0zHii/kwAEzHubVH+ZYnw0RyVyHEXtl/fA1Lut4ziCkFgFhfPTOsOy4+ncCVFJLFco3aGvc7RU66bnCkqjQSPaYwWloJpDyrx1U1eS8G3wjTTqY7/kNqWOuaDczbWzQ25r2Kh6Hihtfb4XuONdLrNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxgmQgjdgklxUlS0/MEa1wVb2N6PqNoOResmdKOKQ7I=;
 b=Y9D3AMHkYwPWBG4K93uQY0URX03HeIbG4hQ1sVs8iFWMCxCYmSG1egftesdXXuB6k6L+iMq0qNzrs+Zmtpunpveqpzxnk42wMUDR6b01Hs8pUCGrIighZO2PbLuUIwbx8hhSjS2bnn0qWraqPDXa3UVfSWMrz4x9V18YBG29C8bvGern3lXmSD229ngw33hWOkJMWYok6h+xVKfTkCGNy3MmE3Z6vqoWH7fDu7GdU1wRR0osvI3NOZZENx4NFKYXzPL6FhuOyIGJUPZks934+5/sETigof9StylrvfAll1YemTli7Xk3nSwcBHvXp08Fv49fwdaIqhRCd9ifF0jexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxgmQgjdgklxUlS0/MEa1wVb2N6PqNoOResmdKOKQ7I=;
 b=njyn90CHBXjFUCEa95EXS7xVmYJhgfC0ByjjDppzrLk1zLMDKrb/U55JPP69zrbsof3yWaTJ0uGjaXYtCBq/NZeZzGawK6Bp2vvy52CatjV7EzeBIOpJRz6Rgz4EmNibnjF0QW2sfkHS9urClaDWoVUJf4BQsnaA1v38lqTwKb0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6442.namprd10.prod.outlook.com (2603:10b6:930:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 19:46:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 19:46:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] NFSD: keep track of the number of courtesy clients
 in the system
Thread-Topic: [PATCH v3 1/2] NFSD: keep track of the number of courtesy
 clients in the system
Thread-Index: AQHYvKTIVKcnz2SABUymlSPMPaQmba3H12SAgAABrAA=
Date:   Tue, 30 Aug 2022 19:46:20 +0000
Message-ID: <D11AD125-5623-4DAA-BCF3-5F8BE9BE28F5@oracle.com>
References: <1661886865-30304-1-git-send-email-dai.ngo@oracle.com>
 <1661886865-30304-2-git-send-email-dai.ngo@oracle.com>
 <e32e725974ca5f5f5ee4e16192d4c4cce80e9248.camel@kernel.org>
In-Reply-To: <e32e725974ca5f5f5ee4e16192d4c4cce80e9248.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2473850c-e964-4895-99f2-08da8ac0502e
x-ms-traffictypediagnostic: CY8PR10MB6442:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g23iY4xQMHC0VHAPf09RVE6QxvX4phqCnQxVnzPfnuUpH0osOhL3gl2nn8uwoLxIyepTBwnPmGrhXmZ1IhjQvUZYTfhvjlskIi49jorXXsQAbNS6Uq7u6nm24HDUfUHsdZ4qsUzRXTDKLBqAu9xU6e2kb2nRqixOhtTBdqG7V3uU+4AQ0nPY75OcqTNf6DdBqUEq+ySVw6/HPIVsBNBgxX61/8LGapKfGibGhCidGAtCLP+LsD/1mBxzxajRkjoSiV/+xZBmToHTl67ht3VPI6IPI6ECf7v4SBjdlrJIdVinmHOt8mwnbXaQ8AMKCzZBlcwCVt7OdHCVTZvNnDNwOfXy9p8IQpf7pVyy1sspAAqpOkk2R5i9KAhztLK1i+Ewir+pATUYj0L8D2KK4QrX66lJx4D5SvtFcT5BS5LeS5qkDhOjB4f6y0xWkhEiBMuM5jCGeCo9T2AN3IgexsmbhiiXuon6cuuDdIbuqMh3gvdBkmPyKwI+e8Oa1V+GvBW/0pjDoKFiVeFXViVkBwd+259Aq+uWLIm7nQ7R13GBlhy46lrx5gdGaNEWjeBNvgOksEDZh1oj/JgDLGKdwzDBpzaLfYjxPxhdObEVRx2NEDCI4VTtGAsx+uxjhF7xHgfsD4BJuekwOF5EhS9eSNCY0FsKLITawsX1vnu6BjF5B3nK6WnzPetS5a5TF2iTr4Wh86P8zklBXvWAM2MddGLFdXXOzkPOjwdM9zrb0W/PnWA/8BnbzT1/lxyV5YnfKjlsdhffQVGWdTPYcABUKRtKxwJBZnFUOFNJlpXF4QnCtcI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(39860400002)(376002)(478600001)(6636002)(316002)(41300700001)(53546011)(6486002)(71200400001)(37006003)(54906003)(6506007)(86362001)(38100700002)(122000001)(38070700005)(2616005)(26005)(186003)(83380400001)(66476007)(66446008)(8936002)(6862004)(6512007)(36756003)(91956017)(2906002)(8676002)(33656002)(5660300002)(64756008)(66556008)(66946007)(76116006)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QvZBHMVqlWicPqR/V33nwBDYxr6Z4n6RFpmafNaE4Bzl63UpmBQChDC6X78t?=
 =?us-ascii?Q?SuSZ/6yjycSC8mDamXSvhdRegA9ClZnF6CuZM3Xg3OIVJhbhlqMo77wiYP0j?=
 =?us-ascii?Q?OsQGcXuuK/ZvVVJiBKABRc4aVykBTQ7x3oAqDxFIWeCK8IlmDhyEyRg8AgP5?=
 =?us-ascii?Q?wnckyQ2E/r4SPJZwPge/Zf8IILHQZ+uhgjvHXm3MMj0C4dKf9jG+yaM4KVNo?=
 =?us-ascii?Q?c4XJoduV/M7IC00jRU1xiSho3kLFDOM1HMsinMCbVgVybH+VQsyx/kggs0/c?=
 =?us-ascii?Q?R1FPo2cjIOlpp9WGDnvPtyPChk6R5VrXGEMBr/d2f38DEHnsfI0RbjbJon2w?=
 =?us-ascii?Q?Y0YixoS7tUbl+zkudQ//vH5xuWX4epZarGqrvB8auEz8bP6EVc/ynZ2iJysI?=
 =?us-ascii?Q?mBQGXOnN1kE7Bk+P4gDDITMkQC3KPLBMNSsDBcIltJFJRryu68k4Y1fbPQsn?=
 =?us-ascii?Q?SYBKFElDuDLjKUNE3J1VdcZyROpkR1FsK95fYU5/8qLkOYDve+TPnZTLsctk?=
 =?us-ascii?Q?YYaPo0refgHETNAahjUwvYmE7C3f86oU3nRd7uavKH0Uz/vSJ6CIQPJ2Ynd5?=
 =?us-ascii?Q?618GqeLdJi++Yat5RCkDh9g/P1ta5yAojthFNgn2Cg7JfQVx26stDWtorcx4?=
 =?us-ascii?Q?KHsngu19W74jlmZiKZM/2Dqjm/JFnxbR4skrDkcMAQtNnG3kE7g9BWOpuAQJ?=
 =?us-ascii?Q?QwqyLZVYZdifLGcpOgukw3BbkWH5YWbek5RNMbgHHUcf8du+tMvQ7OlUrHaG?=
 =?us-ascii?Q?5krpoPPr5nJgYe34gJFKkzaKt/+WNnsjpD2Xe0IRVa4eltYEkq3doMktG91T?=
 =?us-ascii?Q?lsweygb5JfLzG+EHCyRnr1nSEJM5K3f0K0E9uB0UhSZtQrIW7qFRwz1kasSb?=
 =?us-ascii?Q?osNz696q6m9NkoEy+sRM1YbQ0YVtU8tpnZcTUczUJ3D1/bDSaW7TgjfcNykz?=
 =?us-ascii?Q?B9BbLfW3LL0xpTIzkF2pfy722BHKkrMNeOyEA+fAiC36Oji7omWhMv+ke1Vm?=
 =?us-ascii?Q?X1cIXL9DTChyAkJ8nFQvgHl0knyT+bbUd1CAQO0tbplDmTs/12NQFTaPFdts?=
 =?us-ascii?Q?MtgLGyxEwqiH7aDXWsuq2vgZwcs3u4jonvvU6tQORHdNX52k7qgFmPAy7Or5?=
 =?us-ascii?Q?SKpLXh1aAEEDGSyPP4Y6DI8HP5gb/6sjprwPMzbbiNA/qypw4Q/RiOJxNd79?=
 =?us-ascii?Q?Gz1X4jjqsK4nF/9na8ftQzObgEs5ClIjdnQ6Azx3CTikOfVTwLM2uSVQtc00?=
 =?us-ascii?Q?wYojibriRUVK97aoy1EkLmcg/aUKGbetFhkLIfivSBpcWoR4IQ7jPha7taAt?=
 =?us-ascii?Q?CGaerqmhLEPd8rJ2qXW7an85wuJWJflvCpiVqwo7PRTK5DmcCH+q4avzAR+a?=
 =?us-ascii?Q?pV69RC7RyLdTa16ZjXKKJv0+Hyokpdhv4fRVkbcSl6QnmKnZYbxV8WEULpQ4?=
 =?us-ascii?Q?mtGhRhTztfGMYxj8I6CUmNP5o5QNdoHtOvAxsZQEbiIeQDGT6K0m1VScVA3T?=
 =?us-ascii?Q?diY79ulnRIR4ttABzYO5kFqf9VxOR0gFZj074j4fV5A6hVXitDpCF7/weatA?=
 =?us-ascii?Q?5AZOiAw+No+HkOUR7irHOlt/RQwGfGLAaKD4A67zHEbnXO5BhEzsagHSCC7D?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC57E8F305D5274BBFF58C4292D9DB89@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2473850c-e964-4895-99f2-08da8ac0502e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 19:46:20.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nur0Ppn9K0zwIBn1jft3yMCBXzDcvK2AjETM8sBckPMkYlwM8vKErp/n72qEa757kJYSISuG9gqiv2YTBRU1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300089
X-Proofpoint-ORIG-GUID: arfFHoDMK6PeyiVjLfc6MrT6fNuS7gqq
X-Proofpoint-GUID: arfFHoDMK6PeyiVjLfc6MrT6fNuS7gqq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 30, 2022, at 3:40 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-08-30 at 12:14 -0700, Dai Ngo wrote:
>> Add counter nfs4_courtesy_client_count to nfsd_net to keep track
>> of the number of courtesy clients in the system.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/netns.h     |  2 ++
>> fs/nfsd/nfs4state.c | 14 +++++++++++---
>> 2 files changed, 13 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>> index ffe17743cc74..2695dff1378a 100644
>> --- a/fs/nfsd/netns.h
>> +++ b/fs/nfsd/netns.h
>> @@ -192,6 +192,8 @@ struct nfsd_net {
>>=20
>> 	atomic_t		nfs4_client_count;
>> 	int			nfs4_max_clients;
>> +
>> +	atomic_t		nfsd_courtesy_client_count;
>> };
>>=20
>> /* Simple check to find out if a given net was properly initialized */
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c5d199d7e6b4..9675b5d8f408 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -169,7 +169,8 @@ static __be32 get_client_locked(struct nfs4_client *=
clp)
>> 	if (is_client_expired(clp))
>> 		return nfserr_expired;
>> 	atomic_inc(&clp->cl_rpc_users);
>> -	clp->cl_state =3D NFSD4_ACTIVE;
>> +	if (xchg(&clp->cl_state, NFSD4_ACTIVE) !=3D NFSD4_ACTIVE)
>> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>=20
> I'd prefer this:
>=20
> 	if (clp->cl_state !=3D NFSD4_ACTIVE)
> 		atomic_add_unless(...
> 	clp->cl_state =3D NFSD4_ACTIVE;
>=20
> It's more lines, but it's easier to read. It's may also be more
> efficient since you're protected by a spinlock anyway.
>=20
> I think it's also less deceptive when reading the code. When I see
> xchg() operations being used like that, my immediate thought is that
> they must be needed for synchronization purposes. It's not in this case.

Agree: generally speaking, primitives like xchg() are used only when
hardware-assisted synchronization is needed. These are expensive
operations, to be used sparingly.

Let's replace these with plain vanilla "=3D", as Jeff suggested.

Likewise, I'm not totally convinced that nfsd_courtesy_client_count
has to be an atomic.


>> 	return nfs_ok;
>> }
>>=20
>> @@ -190,7 +191,8 @@ renew_client_locked(struct nfs4_client *clp)
>>=20
>> 	list_move_tail(&clp->cl_lru, &nn->client_lru);
>> 	clp->cl_time =3D ktime_get_boottime_seconds();
>> -	clp->cl_state =3D NFSD4_ACTIVE;
>> +	if (xchg(&clp->cl_state, NFSD4_ACTIVE) !=3D NFSD4_ACTIVE)
>> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>> }
>>=20
>> static void put_client_renew_locked(struct nfs4_client *clp)
>> @@ -2233,6 +2235,8 @@ __destroy_client(struct nfs4_client *clp)
>> 	if (clp->cl_cb_conn.cb_xprt)
>> 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>> 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>> +	if (clp->cl_state !=3D NFSD4_ACTIVE)
>> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>> 	free_client(clp);
>> 	wake_up_all(&expiry_wq);
>> }
>> @@ -4356,6 +4360,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
>> 	max_clients =3D (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
>> 	max_clients *=3D NFS4_CLIENTS_PER_GB;
>> 	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
>> +
>> +	atomic_set(&nn->nfsd_courtesy_client_count, 0);
>> }
>>=20
>> static void init_nfs4_replay(struct nfs4_replay *rp)
>> @@ -5879,7 +5885,9 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, stru=
ct list_head *reaplist,
>> 		if (!state_expired(lt, clp->cl_time))
>> 			break;
>> 		if (!atomic_read(&clp->cl_rpc_users))
>> -			clp->cl_state =3D NFSD4_COURTESY;
>> +			if (xchg(&clp->cl_state, NFSD4_COURTESY) =3D=3D
>> +							NFSD4_ACTIVE)
>> +				atomic_inc(&nn->nfsd_courtesy_client_count);
>> 		if (!client_has_state(clp))
>> 			goto exp_client;
>> 		if (!nfs4_anylock_blockers(clp))
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



