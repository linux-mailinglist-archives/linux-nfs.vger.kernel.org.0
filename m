Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5850381050
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhENTMf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:12:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53958 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhENTMd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 15:12:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EJA0C9129126;
        Fri, 14 May 2021 19:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AU+vCGiyR+JDYQ1uYUEnbrew8k7nziejoLwhazpSLmY=;
 b=ZpikWUybLyuuxvE0qMNhiA1tr+qxhSHjmSomXxV/tI0LElDTcOvDW+90erbMVOCv4ZIy
 wgey8+xZqT9dAiG/9lgbXLGgsZC5g29xQpIdXnIziUrnPUEJ3Y1sBHijnv9nsPOO/QF0
 SE2mpdHrsIPXppc+Siak5GPsyAHTbIlavxWFyoAWSG6ImY/LxdU5XuctdBtscdvYZbFn
 E1LA6nhU1I2fHgmtIu7L5jhyj7LuoLE35L8F1vWWOoxn/rEIumx0hIz9Zyb5L/dI0Nty
 Pg0qJV0hmoAvS9dqp4tiTAil22op+2tqyyhPCsP6GyS3glqrs+HuSjqM/MEtpeNXLgqT 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38gpnen5ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 19:11:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EJACGt195107;
        Fri, 14 May 2021 19:11:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 38gpphff4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 19:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrb+m50BgKHY5zc7ocd7VR78hwQdapwG+egHYMYhdROAFRfeCZzgjgucp6d6A12lStQdrDUX8emlH47HzZGGZreVNildGhYEqjKDg7eGy1kzBcwYfHdHFtOVXimKpjQVBBQ3aj4TR56z/deE31SmvfoTSxsgOGO3JHspGaELLztE2K9DIF6CAk9UuUMJfKrOqOj8EjltLaImRwGPwVvfSrmrNmkowLXxGDuW+C578TvG0+iAW35PSynTqdXqp3MmFJfCkzS8nP7z89Jwm+iirVmrbI4wbWM7m9uOSimM8U49W+0v2iXYar6xudr3jfoc1Tre9AFUaToQ5CHFISGNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU+vCGiyR+JDYQ1uYUEnbrew8k7nziejoLwhazpSLmY=;
 b=KQRbATEtG8fjnjbjew2P8Ikc4rd1UEUUUa8r2l0by/1RWNCu1f7L3uVWjGGjS6OxMEjPexm5oFMYnnBMH689DIZaZKO78U2nI6WBZ2D4wejPhBu5RoACDoXPiuoggB2qoBQHbn+o5qsUQuLqGYpaIxyvpOryS2XZgDiwkoOFWJ54xqaiAM//HkiG8BYuNrczEOASc4o3zwNlFNBdyJ4wyfObYc6qiHBA7gTy5PYok37Y1mgILy2KfYwAJdx5lpxPZhug0kMyGDuXYT8KgEJ+bnwNvJPIRBqaOX+5D9JINZQRPeROl00gYt5Ovr+AxxsTQWqvMNkrf/qjHDYiXADFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU+vCGiyR+JDYQ1uYUEnbrew8k7nziejoLwhazpSLmY=;
 b=PMIHmnCFaB8Ndqj8Yk/YOv77QvqYjQfsLfBQJtLFi2RJR09++8Kh/a47jzduu8aPUCmkAM+JeB6joLNnNRMtVkrlgaTJrp4GRPMMirGCtJyG4OpPJkljnB/9hibG9xznpTMtlgyY0btLEphBnVJjeCFVLFCRzylijWUerkJSPN8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3112.namprd10.prod.outlook.com (2603:10b6:a03:157::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 19:11:11 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 19:11:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Dave Wysochanski <dwysocha@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 09/21] NFSD: Add an nfsd_cb_offload tracepoint
Thread-Topic: [PATCH RFC 09/21] NFSD: Add an nfsd_cb_offload tracepoint
Thread-Index: AQHXRbSEtnJyBTXRsky2ccds3u8tRqrjUNMAgAANkAA=
Date:   Fri, 14 May 2021 19:11:11 +0000
Message-ID: <95ACA2D4-6196-46AB-9620-3017B6B4BBE0@oracle.com>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066195300.94415.3319200148715325125.stgit@klimt.1015granger.net>
 <CAN-5tyEOW8bgsSsM2euG3JZ7oOd58Ee6hCGHu52SEUoSKRoFdw@mail.gmail.com>
In-Reply-To: <CAN-5tyEOW8bgsSsM2euG3JZ7oOd58Ee6hCGHu52SEUoSKRoFdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4dd2c92-ff1f-462e-608d-08d9170c0940
x-ms-traffictypediagnostic: BYAPR10MB3112:
x-microsoft-antispam-prvs: <BYAPR10MB311227EE847575881747491893509@BYAPR10MB3112.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8YGcX364FIeUZxgmysZlqJFXr57vWpURwSgbP490pDTcjKglNBHbj8lNC6EIkJ3Wu1cxkPbhSLi/NgPetaku3hk+RutHZP1UjZ57rJxq9iayM3sHpryzsbgJgsWQZ2LIS0Bdyb/8R5xfrqHni5N1o3BOatU9sOH6ggwySsRTQ6d7NgC+AzqACKHnpMnRxXgB1Bi6QJcRbBUAvhriYHu/O6zLJiYy/lNS4OvkXeLOJMkVGdWawyQRulGumq2rF0WOybhSzTIoRjg0Tv+lfbadYXSaeqrS3869xEOEBYPhQJJ3HqlVhER3T4MXCU64znO4MVXn9qtD0TZtk655Dao7iaSzM1PrlsZq3n4VtGgO/DjbYRx+saXnT61OJ5487e0plsMOxwJ0IdZ6UY+XclRKR1p5npe4S5QjgJfZ2rC+nNiH40eyJYRogr23L1OOP+OKKnDxSPM05b/SwY5Kup7xbgkIp/k+Ve5Bi+leHyQ78E3YHQqKzqPrxql8zqIazhcxfF4JS08qagbcWubfhnA74CpwzX9ZZe0B6qlUIKna6qvxwolUxnMlB7fTSzbijTxbcFo/SZ5semcD5qU92nwwG5h92JdZk6Xc8JCTKMPnF97BfFjwwhzESiNEGusZUYPNzGy1igm/PN2s6+W/JiMFZ2tnyR/htGyj01HLOMM/79E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(396003)(39860400002)(2616005)(6486002)(86362001)(186003)(122000001)(4326008)(6512007)(8936002)(8676002)(66476007)(54906003)(66556008)(71200400001)(316002)(38100700002)(76116006)(64756008)(66946007)(6916009)(5660300002)(66446008)(53546011)(478600001)(6506007)(83380400001)(2906002)(33656002)(36756003)(26005)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gYDEQwc9WYPDA6HoL4E6T4l1geJF49b/DOcY6BuIM3YdQ2fgnZNJwVtRiqj/?=
 =?us-ascii?Q?/F8PivnysZqdqAxggI2426HnUxiKbN1aQKhqe9ZXuqIY/uPnrDJvYSpCJtbP?=
 =?us-ascii?Q?aWNrRFNeFBqq24LSyXJmq0F8rSOiU59CThB6MFSVE/jD8A+RSnBbQazBSG1e?=
 =?us-ascii?Q?uU+sgSrW5dMCqEPgNbo5+eK2yNFRUgtb4bR/o0fJicpAiq6QwANd3n6hChJL?=
 =?us-ascii?Q?vSgjRw/F7oGwpqr0xW2buzvE16fRTyptfJZV1hQML6VHVP3rs2B+hh35ACZx?=
 =?us-ascii?Q?+HevuU6OH70EVbHtjj2OCIsbvcRM1lZgm7H910MJ/Bmgsat5CGopVFNC9y/M?=
 =?us-ascii?Q?Ess0JHLxDOErvO8vNHcRjyUg/pncbkgqtvAPVwNvZ4Fqhg5yrupkfedRjZ4H?=
 =?us-ascii?Q?WOCJNA+MgOFZS2wHzTcA7riELLw/g+GtN1wI2/c5f5/nLzuguZBdYdWkI4M7?=
 =?us-ascii?Q?rmnMk8oJm88G/bQknLcYFakBpKr+CQofNch4+kreJHlsiyzSdIRK5qDe1sXP?=
 =?us-ascii?Q?vmtf02E03oSo5iL/B241d1h49LyTZ1+peU39IS1OrdUm6tlTB1QBIfDOgV1L?=
 =?us-ascii?Q?hpdDn9O/gK7UDPSYNM8gXiL9ZPO3A7B9FUnB6a1/WeFBGZKt+w/hYbm3R8DW?=
 =?us-ascii?Q?BcuxRBOnXtc67VqdvWeuhWPvyfiCrwfJ1IkbYqmuQ+y6FUB88Z7wE6PkaPwZ?=
 =?us-ascii?Q?BIGOPPNtyBppZIHkGYU79m4SEzTa/1Pb7H7JdVqxZLqgt85fDbnk80teE+Pq?=
 =?us-ascii?Q?vmzHLQlKFIIFLZH4+JtQsKBSG21NGSeli6AYQyeFkgIG+CG8EBnl1o0QssYA?=
 =?us-ascii?Q?vmfhE+pw/tdhC/3Y+TIxGQiz34K5Z3J4j6VJ0yC7JZDBb1Uu8MOaYPMfzsq/?=
 =?us-ascii?Q?S8zgDhuicgjt7eP0k+7AWE2wMgX6WWuTO68sxJztmc7BsGe7JWVxM2vZUjdw?=
 =?us-ascii?Q?0eaWO3eJ5UgB+YOOeJ8VSdI0ZTdOU/SAFRP7d4Cw9drUEUjw2/iqg73/arHH?=
 =?us-ascii?Q?V0AWe+fhfGkha4aNI/opmPUiR3HvkWgpdaxDoC9chwgOFpOX0DplgJqTn7rn?=
 =?us-ascii?Q?qU7GK6p0+SqmpNYnB8wtc3eMJP+96kbk+qePgCMsHHTE5flwmIZCaUWZO0iL?=
 =?us-ascii?Q?jppg+zY5nXpPZbtPjfqe++QjLV3yfykPGN5aXcQy5s7O1m9epfMy2ONonnat?=
 =?us-ascii?Q?ys6zMd7H6fI5DD0fTeCBC3KmTdS440hS+gvf6HQg1spA7cg1neXqxbMKqoWV?=
 =?us-ascii?Q?diKIoTdL4FeGoikKbx0vYwp182s7dKmItPPL0DzzpZJS1bTgwA+rVdOTEwFE?=
 =?us-ascii?Q?7+RqIvy9TcV0ktBzA6kdNga2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07FBAACC54C41C49A10C0243B7F18A92@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dd2c92-ff1f-462e-608d-08d9170c0940
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 19:11:11.1049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2/lCIZ0hc5AgWtwYVXM9k4NxBh+kIJJnUJpGwrrxBqyj4JMPY2Tto/9BYjmJvyGUwu1JSPk+tUpdzDEiwAKRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140150
X-Proofpoint-GUID: CFFtNz6J0z-by9ACQh5evb9m4RcUfnnG
X-Proofpoint-ORIG-GUID: CFFtNz6J0z-by9ACQh5evb9m4RcUfnnG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140150
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 14, 2021, at 2:22 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> Hi Chuck,
>=20
> On Mon, May 10, 2021 at 12:05 PM Chuck Lever <chuck.lever@oracle.com> wro=
te:
>>=20
>> Record the arguments of CB_OFFLOAD callbacks so we can better
>> observe asynchronous copy-offload behavior. For example:
>>=20
>>            nfsd-995   [008]  7721.934222: nfsd_cb_offload:      addr=3D1=
92.168.2.51:0 client 6092a47c:35a43fc1 fh_hash=3D0x8739113a
>=20
> I like the idea but can we include copy->nfserr if there is one and/or
> if not then size copied?

Yes. How about recording both copy->nfserr _and_ copy->cp_count ?

Unfortunately struct nfsd4_copy is defined in a header that
cannot be included everywhere, so I have to pass all of these
in as separate arguments. Should be OK, this isn't a
performance-critical path.


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: Olga Kornievskaia <kolga@netapp.com>
>> Cc: Dai Ngo <Dai.Ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4proc.c |    1 +
>> fs/nfsd/trace.h    |   30 ++++++++++++++++++++++++++++++
>> 2 files changed, 31 insertions(+)
>>=20
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index daf43b980d4b..7a13f6c848c6 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1497,6 +1497,7 @@ static int nfsd4_do_async_copy(void *data)
>>        memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
>>        nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
>>                        &nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
>> +       trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid, &c=
opy->fh);
>>        nfsd4_run_cb(&cb_copy->cp_cb);
>> out:
>>        if (!copy->cp_intra)
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 1dce41b3bd4d..15cacbdac411 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -1004,6 +1004,36 @@ TRACE_EVENT(nfsd_cb_notify_lock,
>>                __entry->fh_hash)
>> );
>>=20
>> +TRACE_EVENT(nfsd_cb_offload,
>> +       TP_PROTO(
>> +               const struct nfs4_client *clp,
>> +               const stateid_t *stp,
>> +               const struct knfsd_fh *fh
>> +       ),
>> +       TP_ARGS(clp, stp, fh),
>> +       TP_STRUCT__entry(
>> +               __field(u32, cl_boot)
>> +               __field(u32, cl_id)
>> +               __field(u32, si_id)
>> +               __field(u32, si_generation)
>> +               __field(u32, fh_hash)
>> +               __array(unsigned char, addr, sizeof(struct sockaddr_in6)=
)
>> +       ),
>> +       TP_fast_assign(
>> +               __entry->cl_boot =3D stp->si_opaque.so_clid.cl_boot;
>> +               __entry->cl_id =3D stp->si_opaque.so_clid.cl_id;
>> +               __entry->si_id =3D stp->si_opaque.so_id;
>> +               __entry->si_generation =3D stp->si_generation;
>> +               __entry->fh_hash =3D knfsd_fh_hash(fh);
>> +               memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
>> +                       sizeof(struct sockaddr_in6));
>> +       ),
>> +       TP_printk("addr=3D%pISpc client %08x:%08x stateid %08x:%08x fh_h=
ash=3D0x%08x",
>> +               __entry->addr, __entry->cl_boot, __entry->cl_id,
>> +               __entry->si_id, __entry->si_generation,
>> +               __entry->fh_hash)
>> +);
>> +
>> #endif /* _NFSD_TRACE_H */
>>=20
>> #undef TRACE_INCLUDE_PATH
>>=20
>>=20

--
Chuck Lever



