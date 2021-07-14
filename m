Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63D93C8A3A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jul 2021 19:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhGNR4m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jul 2021 13:56:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3810 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhGNR4l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jul 2021 13:56:41 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EHlKmA002078;
        Wed, 14 Jul 2021 17:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9EccOLq0YxpCFU6nEsA8IiLWyIYIg4sXqB1u/qiO7Z0=;
 b=f9MagMH4eUbBDiadp9ZCNZxZFpI9DNuRImEqSIurAk/6hfwrNom4G4zhjj3VQs5OZ+72
 Ryb0yxatqtpJ90ILIdKQnLs3L55EQl8GB15g+WhgwhjaGDW1GG+0ZJoaI0PEGH81lWwt
 GWWmoOAJ26wtt/hLJ2S6rwaCLXwMhng40zfXxZ35Xwhk/lj+H2GeHD6xuDBAyDYaqsyc
 vqNKJBb3h2CTttIKPUg708r1M/xQfIVhFaHisZZnnEghjE0vE86UzUQlH9DSOI9WAeFH
 i6r81T9vIt1ELnqKvEZU6WKfXvd4I+ZI+Hqfe0uNui28YoazXyTj9wF6fZOqHOD8exrM FQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9EccOLq0YxpCFU6nEsA8IiLWyIYIg4sXqB1u/qiO7Z0=;
 b=KScAiSXrkUA65UVRiITYrTz6t9EmIkW4vb4Od8uIDwsJMyUbKRXN31Vmck7ND55Hx4pd
 kPY1thYZD/dBQftmIHAX3StMVJFYdu1ZP0rvx1ibgOaihZU7kuvdj+AEoHAUQuitQHN5
 /k39+G6kNjDKL/mJvL4K2wCU+8e3/S3EVV9Be580fjKTlPyiP9AjLHh4RZ1tTTVrhtV/
 ZZJ2mMrOmKpBiW64qaSKGIn56IA2jyQvT7hC/UCTejPtbFJRdLARHtOJLyUB8DvI/YGZ
 ybk4CoLc+OPmHxjoLHPj31xeRyW+GSaZmz4H5hEjc3EfjUok17JNtfEEfRrBVcJk24DF qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb5dmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 17:53:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16EHj1vK108339;
        Wed, 14 Jul 2021 17:53:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 39qnb3vh8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 17:53:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgpXOGRGfLSaZ9eUxhyTrdG22ZcmCJC0NBGJmtLxuJZVHaczPVMg7YwTxW55la7UziVa7hcQOrOZy8dK+5gAG5d9jV7xPQD/jyNILiyNjBwmLWF4+8NKjS3605MGEC7THco+UFDn+sgdCOWfR021dNWbRimhDON1mLss8jNU1KsCVpVJWrUnsMBBWAW/r9Htnwtk5yUKcVGd/qCD87EWuzC4w6U3T3cFyF5KN8CqOLfNKAL8AMhRG8+AHdsC683rbYx4qhP8PqrqVJRtJ8Mi82tZOdwc0ZCbq/emiabC2je7yPGB5Zhg5cFv9MJeflxqJepVwhm6KRS0IqbTlag+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EccOLq0YxpCFU6nEsA8IiLWyIYIg4sXqB1u/qiO7Z0=;
 b=LLC270E/ZLlv+3ySiD7y0pB+jwkqTxr8T/kgMAQJhNjkQXNvxH94oOx1VD97t8Z1zv+RPa8uuvvuXcj4jlG5eE+1ozNCmtrktDXWuU1uzbSwDPf0kpuFeZkv1bZ1fBFIDZ9utR8IWGLbsisRziHP7NohQIudD13NGPUDz5OmQKJl7Lmw/hRA70ieSaWs8Z1PWgv2VCk8k2ecpF00CkQUxB9F97oqsOicDqMBbkq02x3YJIaWx20z5MeuojzE2ti9aqff2dTAijMzEMY4/Yr1wSh6xcqZlilVvycDvY3/0hybc1q7TA8rZyZOu1ezcyoe0WI7QR4Vq39XZdVWrjutrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EccOLq0YxpCFU6nEsA8IiLWyIYIg4sXqB1u/qiO7Z0=;
 b=JgoTSxJE8B2XWsEdD9pc02PB9Md8a80s1k/Hv/4ux15nZ4vhuVgnUv8nt8uiF/PKH2IFxB4C26CojDjDglUuO3Q9XwlfV7w5994RKpquUCA5xwJgqKuCjRxm26niTXxgd1QpP09Tu9MsoSDtG9pR3ze3UMtT0b3/F5eIPXtoXD4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2968.namprd10.prod.outlook.com (2603:10b6:a03:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 17:53:44 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 17:53:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for async
 lease renewal
Thread-Topic: [PATCH RFC 1/4] NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for async
 lease renewal
Thread-Index: AQHXeMf61G05eO8qbEGbWIAqZ3VMZqtCoTqAgAAflIA=
Date:   Wed, 14 Jul 2021 17:53:44 +0000
Message-ID: <844DA52F-49E6-4F4E-B7BC-CDDD4620BEFD@oracle.com>
References: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
 <162627781762.1294.17862468684529354297.stgit@manet.1015granger.net>
 <2debf0bf8076dd81d7aa413a31c32fe48ad06961.camel@hammerspace.com>
In-Reply-To: <2debf0bf8076dd81d7aa413a31c32fe48ad06961.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09c76ec8-6d33-45b1-8451-08d946f0530e
x-ms-traffictypediagnostic: BYAPR10MB2968:
x-microsoft-antispam-prvs: <BYAPR10MB29682EB1125093071765B3E093139@BYAPR10MB2968.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLv9d57tGCiY9Z7xcSkG+hmZMWcAvWlbP1JdA8CEUypEScwUyREgddHR1IqHQRKG5kj3A7bYOs58fOzGgIC1arrLSd6IsiIaaQtrjAUiTcYdCJ9rfqhel/ECjsizgMoecydvZk7bdQcc5icUer0R/azk/d4SEnAQXQLaCodnk4zaJIOgApMH3ViigELuidReQ/ECpDpCdGep3vQNrLDH0Bl7fD2myvTg+vddpjR4ieaOxIt3nlczvxo0GVyuIkUAgIF+i7ebLXlaoEH01g6Z1fqmX+TINoRmxpXGs8zgA/p+ESscyxLGL2PqHNflJwe2ulTWN50GZIHL05fh4ASZNYOGG9EmZIu5DClm3sYKLJN3uWU1VVuBkrdiout8lPuMmxbTgYcW8e9gDJpckc2+T2XctGaqyhLwSZDBxowBfcH+raM4uLP/imRyt6jYYCIsLetHYgjOpuvweFCVeqPuCQtIfe2dFvAxA10gQ4ayahTZ4wzd20/4ElgzYcz9Fxsp95Qm6jxJxKj8wAxlPPEyrmdxOR9pJxn66WmU4DwOhzBC9fjokZikmZFOGqH6j6y8XTYLO2uKzXBdhJYu0hfd3l2GmO8gBftqMkxklHF+dP1eiEHv2bFuA6RbVKLZuT+TLDkpU9BvJl7KWlKvna1dDKUAi06qd6AdldnePY4m89Cc+1j8osoHgE14uX7EyCqYyMA4J1ULGuEIuFyA46UlQyqaNrIjg1XiuUwybLSuYQjB7dK2LpBBmamqjgD9Oyf9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(366004)(396003)(8936002)(2906002)(122000001)(91956017)(66476007)(6916009)(6506007)(64756008)(83380400001)(66946007)(38100700002)(66446008)(36756003)(76116006)(66556008)(478600001)(8676002)(71200400001)(4326008)(2616005)(26005)(6486002)(5660300002)(33656002)(6512007)(53546011)(316002)(186003)(86362001)(45980500001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AsFLEjGr+YBi5gjDi/J7bvjpPxfBVHPWiZn+60q5XvVCLPW1dys9xVSOu2g/?=
 =?us-ascii?Q?8wAubMDVVuPACI5HQtSC6r6vbSVEgyWW1gC5ydT39GeLQY92IC3/RWMk0Ize?=
 =?us-ascii?Q?u3b12g22OmRgxisphI9xHWC3KnUfnJMqhHu7RfShg96Ad2lwRrCFEqFNzKlW?=
 =?us-ascii?Q?DDFrd1e0kO0Sv+8iQchUyLJ39E0WokI8sL/tdA32fxvZMAbHEGU/DnBEN6EF?=
 =?us-ascii?Q?voQP5cLCrnnwxL+yAAwU/h8xykiD0ijMgmltXgyFeLqs1dLpZgugjwStjlHt?=
 =?us-ascii?Q?1MyLe8n2wDn2/LfeMGY1MGQE2h14oFjHqc8M+4JM+nCpBLhmIMfMKNk7gv8t?=
 =?us-ascii?Q?7KysnxQ+2BtSXCp4PHfRKUBXeTr5e07CEvbnpW+kac0nH13jwPlLsgek64B0?=
 =?us-ascii?Q?fWi4FwAjlt6o0emv/W0t/ADawQVEZODg6MxkCq90PoShfmRXT7137SG+oMOE?=
 =?us-ascii?Q?NZ2NqZsdUtasSC3T5tEyFn2Wux6YT4GM75BHsV3tzRQ2ObtVFTXU6ckyfm+e?=
 =?us-ascii?Q?RUnakEl36wwxmXxJfwOS8qDc6Wq/qo67W7i0gBKTZQG82srAO5ojHnnYf53r?=
 =?us-ascii?Q?LkkRVXJ3oDenj/7d5dl3tteqtUA6ToEDo559ZQNCHSRp7FtZWWDXCzDVk4/1?=
 =?us-ascii?Q?mm+xubFTTdz8rgFdhW2XkfhDmYqpk/r8lJgnrh+4P6DezCDeR36PpP4aZLvJ?=
 =?us-ascii?Q?Tn0wAqY2stldZZaVbWN1E9NAw5Hxs4YFUcfwQuxCqorYZSpFJP1DH1igq3q9?=
 =?us-ascii?Q?x5NvcCll/xiRkexHNTGeBHIcjUnfI8Ybk4jaqfeRn+vR9WYxYZIPsnXOzlQZ?=
 =?us-ascii?Q?iGKj1DqUetx7y+pEKXnAjmgSpUVN8ws5j21WufZXYWbBqePTra+Lp9fXPsMT?=
 =?us-ascii?Q?IHZATOsI1iqHKKMjzjMq9j/7trr2oNZEJTV/6skNdnwb10Ad7sFr2PPb4d7+?=
 =?us-ascii?Q?wNErzLsGAfMtH8jPdog2YwXo6g4L9UFDBiO5sS3N37mY8uaz3j2vaHIe+sMC?=
 =?us-ascii?Q?aPGSwUZOoXBu1k3GMsmHoXAd/YkAeyVLxZpMjh8zNylIScYROdzBT9VnAh1r?=
 =?us-ascii?Q?egMRh/EohD0Se1R7ThqcinGpNfWjlxyKATIfB7Xy0EvKoHOsyEreLDJfVRmP?=
 =?us-ascii?Q?hrgV0cw7E7b+CRed175DIZ4A0c1bhdGpoyAvS6VvzhV70OGZRvD1d2F2Mftp?=
 =?us-ascii?Q?rP0IO/58sTaYM9eF3yyi/rJ4ZM5L37DSoR+ltpqq25J92P/5e9EBLzmIhmMq?=
 =?us-ascii?Q?l3kkcLtBjy1x5ocV8hP8ibtFZ6jo1AMgHDNvDiUPBEgOpC+0Qku0Rn13Zd/7?=
 =?us-ascii?Q?wAQOo90AS8FTxslP2WfWeYEf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82BBF328E42D6A48A01C25AAF1D33E8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c76ec8-6d33-45b1-8451-08d946f0530e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 17:53:44.8404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fw9ech4HU4SWq3wGf4YaoxpoyDL5gjcbBJ/SVW8T+O1+lfeglKDq0Zguq2rEb+AK3TvuXVDdMuYmfxLIP17IKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2968
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140106
X-Proofpoint-ORIG-GUID: eu2H78HNkLzm4I4tB2O2oaRhf2kcZkCA
X-Proofpoint-GUID: eu2H78HNkLzm4I4tB2O2oaRhf2kcZkCA
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 14, 2021, at 12:00 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Wed, 2021-07-14 at 11:50 -0400, Chuck Lever wrote:
>> In some rare failure modes, the server is actually reading the
>> transport, but then just dropping the requests on the floor.
>> TCP_USER_TIMEOUT cannot detect that case.
>>=20
>> Prevent such a stuck server from pinning client resources
>> indefinitely by ensuring that async lease renewal requests can time
>> out even if the connection is still operational.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfs/nfs4proc.c |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>=20
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index e1214bb6b7ee..346217f6a00b 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -5612,6 +5612,12 @@ struct nfs4_renewdata {
>>   * nfs4_proc_async_renew(): This is not one of the nfs_rpc_ops; it
>> is a special
>>   * standalone procedure for queueing an asynchronous RENEW.
>>   */
>> +static void nfs4_renew_prepare(struct rpc_task *task, void
>> *calldata)
>> +{
>> +       task->tk_flags &=3D ~RPC_TASK_NO_RETRANS_TIMEOUT;
>> +       rpc_call_start(task);
>> +}
>> +
>>  static void nfs4_renew_release(void *calldata)
>>  {
>>         struct nfs4_renewdata *data =3D calldata;
>> @@ -5650,6 +5656,7 @@ static void nfs4_renew_done(struct rpc_task
>> *task, void *calldata)
>>  }
>> =20
>>  static const struct rpc_call_ops nfs4_renew_ops =3D {
>> +       .rpc_call_prepare =3D nfs4_renew_prepare,
>>         .rpc_call_done =3D nfs4_renew_done,
>>         .rpc_release =3D nfs4_renew_release,
>>  };
>> @@ -9219,6 +9226,8 @@ static void nfs41_sequence_prepare(struct
>> rpc_task *task, void *data)
>>         struct nfs4_sequence_args *args;
>>         struct nfs4_sequence_res *res;
>> =20
>> +       task->tk_flags &=3D ~RPC_TASK_NO_RETRANS_TIMEOUT;
>> +
>>         args =3D task->tk_msg.rpc_argp;
>>         res =3D task->tk_msg.rpc_resp;
>=20
> This isn't necessary. The server isn't allowed to drop these calls on
> the floor.

Again, a server bug, a misconfiguration, a dependence on an
inoperative network service (like DNS), a weird crash, or even
a malicious server can pin client resources. This is plainly a
denial of service. Clients cannot depend on "the server is not
allowed to" if they are to be considered secure.

I'm not suggesting that the Linux client should make a heroic
effort to operate normally when a server behaves like this. I
_am_ suggesting that the client should protect itself and its
users by not pinning its own resources when a server is
behaving bizarrely.

I can drop 1/4 & 2/4 for the moment, but I don't agree that
3/4 & 4/4 alone are adequate to resolve the denial of service.

----

Now with regard to the spec requirement, I believe it might
be under-specified. It's at least problematic.

This is from RFC 8881 Section 2.9.2, and is referring in
particular to non-NULL NFSv4 operations:

> A replier MUST NOT silently drop a request, even if the request is a retr=
y. (The silent drop behavior of RPCSEC_GSS [4] does not apply because this =
behavior happens at the RPCSEC_GSS layer, a lower layer in the request proc=
essing.) Instead, the replier SHOULD return an appropriate error (see Secti=
on 2.10.6.1), or it MAY disconnect the connection.


It states that the server cannot drop a request, but the text
does /not/ literally mandate that the only signal for a lost
request is connection loss -- that part is only a MAY.

Further the use of SHOULD suggests that a session error is the
preferred mechanism for signaling such a loss. The use of MAY
indicates that connection termination is permissible but not
preferred.

Moreover, the text is not careful to state that these two options
are exhaustive. It leaves open the possibility for other server
responses in this situation. (I recognize that might not have
been the intent of the authors, but that's certainly how it
reads a decade later).

Let's not even get into the carve-out for RPCSEC_GSS silent drops.

Thus I don't think we can lean on the current spec to ensure that
a server will always signal the loss of a reply by disconnecting,
especially in cases where there is no session. Further down in
ss2.9.2, we have this one-sentence paragraph:

> In addition, as described in Section 2.10.6.2, while a session is active,=
 the NFSv4.1 requester MUST NOT stop waiting for a reply.


So what about when there is no active session? For example, what
about EXCHANGE_ID, CREATE_SESSION, BIND_CONN_TO_SESSION, and
DESTROY_CLIENTID ? I would argue that a high quality client
implementation will not wait indefinitely for the completion of
these operations.


--
Chuck Lever



