Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0199A3B7380
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhF2NyU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 09:54:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18836 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234203AbhF2NyT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 09:54:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TDjfxB004482;
        Tue, 29 Jun 2021 13:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ymnq3ceTgHZdpNaxtsjNcx51t6MFXLxKSkWHMiajGH4=;
 b=b0W01nRi+irPCny4SBVdmneCRaPs7cwj1pX2ZQwpdRLh1hRlfnE6yPCFFEl0XxJzx+C+
 Tb8cd4rgQIHdmJPzP4Z1rjcI3pxo92QxOttXz+JmOpmEhp67pyqr8wh6TtrNSAi/cAcU
 7yAsU6AbjWOcR8y7MkK130cqTDn2pNXTF0IHQdeCYh3uxArg9CNV40QujWMcOv1c50FG
 s14AQ4kymzCFKDgYERfSBwTe2oQyTW4vNGR1pGZbB6SrinQVZQGRee1ABVEFSyvQN45v
 IiKBGZgbbjXd452Fmo9xH+fx9dqRZTQUqU/ahlLy5K52F2saN+p0+2gH4T0iuwkp98af IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39fpu2hkd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 13:51:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TDjrZA004818;
        Tue, 29 Jun 2021 13:51:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by aserp3020.oracle.com with ESMTP id 39dv25qfkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 13:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAgMEEA13IHQoJNsK6HpxA/SfW2vCeCgiBD3mUgKuc9afKsUvRZm8m66fcVX/H6oArY1AjuNLJ+CDjHF0hf6PqdM8hZO1Jj+JSFmZdfyeJCQtFa+Wp/hucKz6V/sTDNaTFP0VE3V/PgYt6aWCPYQJ2pyFk/4qxHXNBzGdtGd0qUgNksRyfQnRtcjaG26DxpaNM3AOlcgjikroNMPwpPe+MuJPKWsX82dagiF2U3KmCC8OkqnmRZvmwp9QfYqK3Yhm7orjjhm5wsFiNyvFeg6C3zyBaCSkwLKs283KsVgQeMkWRN1rmbVPS89y34fmwbUnm5/mOYKAzYVaFmWkiS5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymnq3ceTgHZdpNaxtsjNcx51t6MFXLxKSkWHMiajGH4=;
 b=fTu2ud6jYVxCtSmaZS9tHLeZgRiUqlP3aVYjrSdu4JWbwEm7AxpjFeLns9BuTv7JuUEC7imQA/fD3nLAAj/Tli4EYEee9+wJhJxJz4Y4id8ip98H/ClbLYqNGP3+qnsxKMK1btH8AIE9FHuy0tnDHkIw3Cx7LZ3g8X3WfwagRViVozmmmivZOVyNciOim8L6hqcnTXvqKtWdHTJ25FZB5D09Euyun+YuEoSKMlHtMkkXU39s74i6P3RoVIhnNM6Gzuj/c29hP97LHzTiTz/hWu2KerzcTJlY+I1pr0bMtwUQ83syO8TBttifkqjwYQ1myF8jRUoGoHn8dmHjn7XN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymnq3ceTgHZdpNaxtsjNcx51t6MFXLxKSkWHMiajGH4=;
 b=CX9Nq+0aZzKVBjswUj1ybcGJZ48uXGOCfNpXOZsH2UBqFSxn1Pc8mJ0th/EmYcwBIICakUCCccLAJCtdhz28mximwGkZmFdsd1yk2ergF8X5Dq1yVwPMBPB2F37B6hFxL0rwWDjHnFgSrs+T7zIcvA0awDyuLrDgewrQUfJcHvY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 29 Jun
 2021 13:51:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 13:51:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: client's caching of server-side capabilities
Thread-Topic: client's caching of server-side capabilities
Thread-Index: AQHXbFuOOfOdlv3jtEGkiccADhbLQKsp+uwAgAD5LQCAAA38gIAAAPwA
Date:   Tue, 29 Jun 2021 13:51:43 +0000
Message-ID: <607F15BF-89B4-4123-8223-A3893229D219@oracle.com>
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
 <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
 <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com>
 <CAN-5tyE5Y3+ZPrfAR8=UVdNnWxyzO6a_NTeTsMFH_TyyMqK-bQ@mail.gmail.com>
In-Reply-To: <CAN-5tyE5Y3+ZPrfAR8=UVdNnWxyzO6a_NTeTsMFH_TyyMqK-bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b89eedd-ddd9-44bf-722b-08d93b0507bc
x-ms-traffictypediagnostic: BY5PR10MB4147:
x-microsoft-antispam-prvs: <BY5PR10MB4147BE41352892309C1C5AB493029@BY5PR10MB4147.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHWnN5oP4J9yU9MYcgLJaTNciqWbw2ePTwQn0+JYX00kQFYnf/Y6IonRdqQXLGj7L3C/BclYHdK3ee0xry7/+ZB9Res7xnWcy9zmjbQ+f2VToG4v913DjQOH31dMFBoEY5gy0gwicaC7l96yn+YULfIz8sqqxTjQMLSUNZjX3ivXNOPgq6nszZx2BH/pZ+zNcA0ICt40tILxExdqziAixMnO/t+J80vR5MokNia+XxwdxOJAiFcZfd57HMQvPlauM8GEaNtk2EVS5y3fUeYUUJn9WwGgejQdN2LjqEP/Z8BqistH0aj6wqqrPqSfuVPwd5OVZJ9inhRTNG49NAzmdsofClzXekRe8RiZmDrgQ0RjH9kxhJsUTOA14BnhaTUx9zZV+DReFJhvhBKmU92OhmAyDuaOJYK01NcsrqFCvYTsAzgGHpz1raTDxRS7YhwGxfLuex721SSW7+59t/tzOzcdrjhCMNSf3b88+oxb85tu9tG0/4MoyaS9EGKFwU4hOiAq2RFb2/xNkxq6LqGk0KjdkSsxvuOawThA3ad4iPntjLdRLUdzrHAs4s8Z7VUXpr3/JKXnMMT/fyxdQ1ZhQRSkHgSHGtMcZD8UYW30lqJIZpk6//MEwugXUKfFEyHKEJ7Zues3m0SDaI0ihE3kbft551y2zhuRCOsIEggYq/EZfub4SNNg/r2Hqv4C8/HOOf0VRW5++ehcPBKRP3l0MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(6916009)(36756003)(86362001)(8936002)(2616005)(6512007)(54906003)(66946007)(66446008)(76116006)(6506007)(53546011)(91956017)(2906002)(33656002)(66556008)(64756008)(66476007)(122000001)(26005)(4326008)(38100700002)(6486002)(316002)(71200400001)(83380400001)(478600001)(8676002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zfW9tSeoIEe3CVcfBAd3rUigtwA1fKsusn02zHFg9Axixx73VWBylmIRvSQq?=
 =?us-ascii?Q?Cx8YVrWtsiQFcAopBMLtEX0b4MkT2j6NlftrR790GHxtmkuCPsbWrKZx8RwT?=
 =?us-ascii?Q?ce0rNMwcZNVLbvqvE44/akN9n7I3TIDlGIGLvOfTcppGhJNCVS+E3XAW8DwY?=
 =?us-ascii?Q?ul/5sZqmPfMvM66iRNP+7zBA4KHsERCHJjF74F3JmspBfeT8gAKe4L/dLjZ7?=
 =?us-ascii?Q?FET+icjOYXz6TuERyIfe19JsUa8pMctiVzypSkN1v0bmySYSFqqBmYs1ay7G?=
 =?us-ascii?Q?MUW5GwLY+Am+DucwwypQMt8hlgAO3FyySJQ3ye2n6xyA3FJpDBHsyRMV/jiQ?=
 =?us-ascii?Q?IwGHhM8w8zzkD2PEbgSpBtZo/psK89ZfTqidM9olnZgoLNL1BvrHHlxztnUj?=
 =?us-ascii?Q?r3+GcI1gzJZ2W+pIhi+OMpFsBDKstjg2/HDKZquQrVA18HeCmBjtTvFTY5jc?=
 =?us-ascii?Q?dNwL1njDJHPqMykkH0vVv0nZzxo69CdDYycwMYOHN2hi7MLIQOU4QL6Jydoy?=
 =?us-ascii?Q?0QC7joGHeYWLOT2/Rs2IT4UiEvXxLGyX77JAVkMlaxWsXP73ttWv/iRJRcKl?=
 =?us-ascii?Q?OKow528OJbcfyWzuG4SUDbtlYdjQ9TlM7o2Ajcu1474l2Wbwp352enwexDBx?=
 =?us-ascii?Q?N6UrDAi87jD3EYDdoUmZ43Bz7p6eB7DcgkhM7NQlNTAq08Q60YPYxLhTloWs?=
 =?us-ascii?Q?/iY0htAcQXOlVX3uaMgcfZBUPz54CGihAH10Fh44ql4IWiC1ct9zaZt/sIYL?=
 =?us-ascii?Q?NxZ6KdgljRKWW5NWVdMuSuC/ro3L9KnVJG+5trEBcx34XVJ3+R3nP6mSjpB+?=
 =?us-ascii?Q?evMKFyFnblFtklEO0Kz5kC7KkIAk0Nrr6ca0VjSL93REGruFTZ2rXzd2EqNO?=
 =?us-ascii?Q?+PSWRJ+jQqpP9ToNnWWSG2Uk9wFtF6hAl90aUqRHvHpJqbJkYwoLtkt/Qe7L?=
 =?us-ascii?Q?mM0aOEu+C/94e6sRUbxiwSh5RDpqbdNi7HwzH/jHDkD42K10j4257F6nJElb?=
 =?us-ascii?Q?Z7bTHUxF78gqCYeKX8bfpWKRnIR0KOolnfHkGsB1GNDUH7Ko1yO2xjR0oiPV?=
 =?us-ascii?Q?htsPH0gCBO7qKuC51R9S7KXdfoWqB4LfqTy1EJagR3VUWFhohDSynZl4JZwS?=
 =?us-ascii?Q?H8AgwwMBjNo3cQEwvu69yNaqDTzP6dhhKncWiiPsq6JbrHqZDuPp4tLVFL9x?=
 =?us-ascii?Q?yuAyczuyDjU0eiNOt1qya1Jli2tRE/z5drqix3O9WksiYYvEpQrC/fq6mCss?=
 =?us-ascii?Q?nL4ljhV2qK6nLNnCCjdQjSX+oNZ+Msqna7N1ozIfq5XRD8s5OaS9F6sS3lYL?=
 =?us-ascii?Q?KQqZU2g9ICSFs6OM4YsgMZxk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15F4BA8DDF6A8D48847BFAFB66F50230@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b89eedd-ddd9-44bf-722b-08d93b0507bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 13:51:43.9435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/eZWHdZiW8jUIsvPmITLrYn2vsEh7k7tH+ypRObXt2XsSGwP3yipDnJLYMheSILzyDpM6q4OVhaA3KXip0dgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290093
X-Proofpoint-GUID: hJwSm_klAlHL3NaSvkP5F1bvVPiF3n2Y
X-Proofpoint-ORIG-GUID: hJwSm_klAlHL3NaSvkP5F1bvVPiF3n2Y
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 29, 2021, at 9:48 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Jun 29, 2021 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jun 28, 2021, at 6:06 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>>>=20
>>> On Mon, 2021-06-28 at 16:23 -0400, Olga Kornievskaia wrote:
>>>> Hi folks,
>>>>=20
>>>> I have a general question of why the client doesn't throw away the
>>>> cached server's capabilities on server reboot. Say a client mounted a
>>>> server when the server didn't support security_labels, then the
>>>> server
>>>> was rebooted and support was enabled. Client re-establishes its
>>>> clientid/session, recovers state, but assumes all the old
>>>> capabilities
>>>> apply. A remount is required to clear old/find new capabilities. The
>>>> opposite is true that a capability could be removed (but I'm assuming
>>>> that's a less practical example).
>>>>=20
>>>> I'm curious what are the problems of clearing server capabilities and
>>>> rediscovering them on reboot? Is it because a local filesystem could
>>>> never have its attributes changed and thus a network file system
>>>> can't
>>>> either?
>>>>=20
>>>> Thank you.
>>>=20
>>> In my opinion, the client should aim for the absolute minimum overhead
>>> on a server reboot. The goal should be to recover state and get I/O
>>> started again as quickly as possible.
>>=20
>> I 100% agree with the above. However...
>>=20
>>=20
>>> Detection of new features, etc
>>> can wait until the client needs to restart.
>>=20
>> A server reboot can be part of a failover to a different server. I
>> think capability discovery needs to happen as part of server reboot
>> recovery, it can't be optimized away.
>=20
> Can you clarify what you mean by a "failover to a different server"?

IP-based failover means that a server can crash, and its partner can
detect that and take over the IP address and exports of the failed
server. The replacement server doesn't have to have exactly the same
set of capabilities.


> To do reboot recovery it has to be the "same" server (by the
> definitions of the RFC). My use case I was thinking of was a reboot of
> the "same" server (major, minor, scope same) but with new features but
> of course one could argue if it has new features it's no longer the
> "same" server. I think you are probably thinking about migration or
> are you thinking of telling a difference between session trunkable
> servers which are considered to be the same but since it's a different
> IP it might have different capabilities?
>=20
> Thank you for the feedback!
>=20
>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



