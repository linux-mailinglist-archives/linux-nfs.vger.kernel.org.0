Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123B73A2EB2
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJO5Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:57:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24584 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230304AbhFJO5Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 10:57:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15AEm4Tu031465;
        Thu, 10 Jun 2021 14:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=P2H0+S0cC64a5VAPwS09d64SQtdM5nClXuzAupxoE9I=;
 b=m+R0148BD4syPNWAKytoyKI7ZfX/LYS5ucroCLxSPpqO+HCn9sB5WokKdWy9DnquHDpN
 iu30yCpgvvO8f5yuVZtfKqNNIocwt3uqroUe1H7YNouymB+1L0Yf+ruZQ/cbWPgWN9yq
 1CG4fHsfdRWW4AN1VE51sR18L20WY+ew5X6vYccQDRd035qtDlvh9XMRpzEglnzmZV/M
 VUkLsn4UFYDSFZQOL8Mw7exsRK983ez//KjaRIQ4QrnkRo10oMB7KqWvZqHTJBpHmoOR
 D6FZqiu2HTkFvti47hHAeeLTPJrf+Ug5I9N7c7bxfk96PHLgrcZ+Fbnso3q2xaWOiVMe tA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 392ptc8mvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 14:55:24 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15AEtNsR001567;
        Thu, 10 Jun 2021 14:55:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3020.oracle.com with ESMTP id 390k1t1wbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 14:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG3x2kyoDHtIGv1h2oxv9MvMyMOPJKx7zw3L2Pm4FqeDgYXbzzOI50RMCg9UiywKd0z43hsppBBkUKpMc+H2eC35hFgcU7XVBWIPjLRimshSsmTe2d8vgNZOAoAfyJC7fVe+SvS4hcltznd9esQna9S6WpdkZskPl8IvnCdmZB11KKObXo93G8Jen8yKs/03xvrvy14ot0sRUrf7aKT4YCUoN/KWNM9vMQONtxYKapEYKFWLaOkTcLC9iDlmvQ4oOhQq+MWixhxpPPr0hXaFYMMjdFEoBrfbv6I/rWdtaBMvzcoMdSEDJw4+LU0gsAks76LRSzSEQxl6V+SN4Q8qxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2H0+S0cC64a5VAPwS09d64SQtdM5nClXuzAupxoE9I=;
 b=RjIQT+BlD6OblBZlRc00sH8eZTCfiGci6UyCiKX2id9M3biM+tGw5ol6DbIMieEvjUpRPbmewsPnms2JGG0GO1dNdtZKJBA94Rj2Sffu5nxxq2C9/q/LTpPJDdG3QXYx4O3UzecUc9204wA6kCCTTWP1aCc+6ZTZ62CHyefQtfbG9erEniH4xbyNx5AAqQDuFEYe8Ai7XTFL3oZ/nPFPRmukRzPb7rjSokCiV3hrg7C56bEWAN0POax/8hdjXxJtVZFqoKX1NSJoQX1gSyZJQsCblIvPwG3/qTtZemHkp9N/f07Dr60x6T6e01a75dbOYukbe0dRK/U7vclxtSpU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2H0+S0cC64a5VAPwS09d64SQtdM5nClXuzAupxoE9I=;
 b=lPWfv1OnRBu+/pHxXCGzG8sqxuODEv4b+Rs3/PbMyY7bNs/bsiq1Zl+6fC3jPWfpLt7b2wH25Wjqu0TclV2y3SDCPGWRSnBRn4So3rtQiXP8A2aCFrJsuu5L4yMUqcLQ9RLLsIDY7TZxybYF1g2z/qtcH54dFRv//cAXolrrcBA=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 14:55:19 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 14:55:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] SUNRPC query xprt switch for number of active
 transports
Thread-Topic: [PATCH v2 1/3] SUNRPC query xprt switch for number of active
 transports
Thread-Index: AQHXXXnxzB7zpMPkhEi1mNscPMhCzasNP86AgAAVRwCAAAE4AA==
Date:   Thu, 10 Jun 2021 14:55:18 +0000
Message-ID: <9F404CC0-06A3-408D-BD99-4933DCA61B6F@oracle.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-2-olga.kornievskaia@gmail.com>
 <91214898-F21A-4604-9FCB-9E9884F177B3@oracle.com>
 <CAN-5tyHgwnEFWdzLG7b8N6G84cTiHMpdDxLe7V=QD7Jd993QHw@mail.gmail.com>
In-Reply-To: <CAN-5tyHgwnEFWdzLG7b8N6G84cTiHMpdDxLe7V=QD7Jd993QHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a33570e7-48ad-4b47-0d7e-08d92c1fc3cb
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-microsoft-antispam-prvs: <MWHPR10MB18710236AEA985A73EE1EDFC93359@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMaSXde3VcFKQFq1xpqFRoaOYLQeaxSHR4AJagEXgGHBC/y1wZ+MThI8lC8IfDlrrg70x83tCDsl1Bjgtg9Qg5dgu0MJvsmJiNeveDjRVP3Qj+b2n7IpOczQS648j4KTgVPmjCilDxXA2eccbGywJp/Lt8/AxNF5bBn7QiNAvMZwqCxHxEiSCksyJsSgZoo5s82H+HYIBI4i/nM6Gugh7zCB1dpiz0pV43p6fIdpO7ROI6o+f7CoSXPSkhObuM53sDFzW1UNOrJgYU3OlE+ZGknuNvQSMyb/zC3XmjtATb2ziq+aKxJlJA/MTGh7RU7IJNJBtEIUHzA2C3+57PkX+NpZhh1IyNourWH8oYE/YT93KkhLlbKLFqNywrw2/jYo+NmJoEp6RhdgJtMKTWJQOPrO8B1Cx4oywsLxPmKVdzccE/x+z+cY2BLjcsdbnIh5VMbKIFMEwa1AMcBwn1yuSVn35Crk8OERDJWCVCiJGB8zRO2ld/LctQaA7CRF5caHf05X0Jt3t1dotliftU8zYF53A8efhTI4DG130QHeK5LxoJnB6v6yAInbKOZC7MOX/aSqfLrfgSEHDyRqlsbmfm0pBv2mivos6dQkd+8sA0YRw8PJKcvJwHEeoPxvvvDwuMOJRP2tbwGjiHn9ZQr2O3xcKRdYkiXP71iO95Jui/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(5660300002)(26005)(8936002)(91956017)(86362001)(186003)(36756003)(6506007)(53546011)(2616005)(66556008)(54906003)(38100700002)(122000001)(66476007)(83380400001)(66446008)(8676002)(64756008)(66946007)(4326008)(6916009)(498600001)(2906002)(33656002)(6512007)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RxMg1mGBzoxpsefsYKlYsb+wocGueTQq1jEtCjG8vFLxKo1t2N3SHIifUi58?=
 =?us-ascii?Q?ffECJFv7o3M41BYtyhnyr3OmZDs9VnEltnMn0xWpbYKUeapYFqPB+n6hSGSV?=
 =?us-ascii?Q?8PaFfTsIs5/AJ01UhZQ0acFkLIeMN02MY5/9B0XAHnrBzPlsuXqOsGbXfnfq?=
 =?us-ascii?Q?IqgLJyUdPBFV8KmK1MXy8mm1/55nWNlUXkHitNqiKWaYu0jXosw6Lk7COZJi?=
 =?us-ascii?Q?TIfPTRy7g6ymKqvsr+rnMJtjcXRcsX7sCp2elZYIUfGq80XUvWytU5mPEQ56?=
 =?us-ascii?Q?iKswnLQ1MUzgWlNlUkOLiBHyMkPIYO93UjmQNVuEksc0ZgEPNTq+4cL7j05z?=
 =?us-ascii?Q?WzndteL6BmBoyOXIJS8IZ/SmzPodfmc8vCfdxuDhzIv//5iIAOOpFFENMYaJ?=
 =?us-ascii?Q?l0ZtsCFNqTcJ0KV6zzizVxuJseKdmvMpXN5bKpWbefC0M2x9naSKgduKIiaM?=
 =?us-ascii?Q?/cCaMUmoA4bCfbercPyA3lQ0/hwvednVtKIHTaV1iP5Okgp/bZW5iPWapA18?=
 =?us-ascii?Q?Nhtz41Laom4w2/yHyS1PE5/7Ya8h9Ku0rlIkahHcXbqJfKu9z9fMgkbZbLLh?=
 =?us-ascii?Q?gSuB0DpSH9b7XfLIegEo4NcCSFtbSiX/G4lbP2PbTkIWzmXEHQzSqVJlEUYx?=
 =?us-ascii?Q?eYLTGFU/a3R6r4K3K1A8w3VJ9VASTAc6zwsTPcsKAUEFH982ayo5EROlzQ3v?=
 =?us-ascii?Q?Pg7vnINRRS64WnShkY+wNLtGvqG+P6+CEtvVLVQlJ3l/Ee0q8fp9vEzWCgbh?=
 =?us-ascii?Q?EexFigtdkC8i2C3UOO/sBv2uYOcNy/zWtxd8YSiS4ejrWoCwkEgXPp8VOM1l?=
 =?us-ascii?Q?nKciO2KFdhEWulYh6+WsFHMD9wJkkXYnkB42En5FNXvzqc5gptu39fATbt/L?=
 =?us-ascii?Q?hXMgnxcHvwDS+8K03//h0RV7OoI8WwTHKEnO/cCIN5jDgl6jnLvcicLcHftP?=
 =?us-ascii?Q?TY1OPydCHDeGWFTap3W6T5gD8e0uWw4qEt/KD6++jacRVRDiyQVFjZGAA9xs?=
 =?us-ascii?Q?x/g5+Tl0CGt/MGWT80Oy8y1GqYm02d38RR8/DEo92KpqlA0InyqKV3v8S00i?=
 =?us-ascii?Q?kyeSrdvSHCp44Mx7GNnugKHBZqMDAVisAr9KEKr/3szB1f8iExomeDkGLxln?=
 =?us-ascii?Q?6Fko2ix2a8lRWaI/LlChs2uLODlJ/l4adassVH8d6LfcFQNKfkIBRbwF0stl?=
 =?us-ascii?Q?vf6gY3uxVXS1xc8BG+xB0WNdVtZuu72YzOyQ+GGJ+F0Rky1D/f90LZ9dyLfm?=
 =?us-ascii?Q?bViE6fLe1M4geHXfg7Hylp4rZSHcxaK1xx1btkwnZNkLtXaBAEO4HmRt8nTh?=
 =?us-ascii?Q?znm6p1tH85wnlKO/yw3TpL8R?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A76D3D90B37044E9C262BE72D8E19D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33570e7-48ad-4b47-0d7e-08d92c1fc3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 14:55:18.8714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uq8qajIN7V3c6SgSdBLZ6bhWoP2lnXb3DtG2c47TJx3RdSMNUkMqhAjudNN6PRCh/ga8VoKlOJYVM+9n6le/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100096
X-Proofpoint-ORIG-GUID: TB80g5Ztm8pnmmzQX1UHE0PR-9FEWuAw
X-Proofpoint-GUID: TB80g5Ztm8pnmmzQX1UHE0PR-9FEWuAw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 10, 2021, at 10:50 AM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> On Thu, Jun 10, 2021 at 9:34 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> To keep track of how many transports have already been added, add
>>> ability to query the number.
>>=20
>> Just a random thought: Would it make more sense to plug the
>> maximum allowed transports value into the struct rpc_clnt,
>> and then rpc_clnt_test_and_add_xprt() could prevent the
>> addition of the new xprt if the maximum would be exceeded?
>=20
> Sure that could be done. Then the value of maximum allowed transports
> should be defined at the RPC layer and not NFS?

The limits are defined by the upper layer (NFS) and enforced
by the RPC client.


> I currently check for
> upper bounds during the parsing of the mount option, would I be not
> doing that or exposing the RPC value to the NFS layer?


> Actually I think it might be nice to add some kind of warning in the
> log that a trunking transport wasn't created because the limit was
> reached but if we move things to the RPC, we can't distinguish between
> nconnect and trunking transports.

One or two new tracepoints might help in any case. I wouldn't
say admins need a log message, but someone debugging something
might want one.


>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> include/linux/sunrpc/clnt.h |  2 ++
>>> net/sunrpc/clnt.c           | 13 +++++++++++++
>>> 2 files changed, 15 insertions(+)
>>>=20
>>> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
>>> index 02e7a5863d28..27042f1e581f 100644
>>> --- a/include/linux/sunrpc/clnt.h
>>> +++ b/include/linux/sunrpc/clnt.h
>>> @@ -234,6 +234,8 @@ void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
>>> void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *=
);
>>> bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
>>>                      const struct sockaddr *sap);
>>> +size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *);
>>> +
>>> void rpc_cleanup_clids(void);
>>>=20
>>> static inline int rpc_reply_expected(struct rpc_task *task)
>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>> index 42623d6b8f0e..b46262ffcf72 100644
>>> --- a/net/sunrpc/clnt.c
>>> +++ b/net/sunrpc/clnt.c
>>> @@ -2959,6 +2959,19 @@ bool rpc_clnt_xprt_switch_has_addr(struct rpc_cl=
nt *clnt,
>>> }
>>> EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_has_addr);
>>>=20
>>> +size_t rpc_clnt_xprt_switch_nactive(struct rpc_clnt *clnt)
>>> +{
>>> +     struct rpc_xprt_switch *xps;
>>> +     size_t num;
>>> +
>>> +     rcu_read_lock();
>>> +     xps =3D rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
>>> +     num =3D xps->xps_nactive;
>>> +     rcu_read_unlock();
>>> +     return num;
>>> +}
>>> +EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_nactive);
>>> +
>>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>> static void rpc_show_header(void)
>>> {
>>> --
>>> 2.27.0
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



