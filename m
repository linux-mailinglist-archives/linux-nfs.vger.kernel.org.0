Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DBC4F6CE9
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiDFVjs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbiDFViG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 17:38:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3218D290
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 13:55:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236JihJs014690;
        Wed, 6 Apr 2022 20:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uAU1ZvAwP7cXZ4oyI1adHlwVEo1BDYu/ZZfRLHyzmSI=;
 b=N/9TVKPTBn+kn7nIOCUCEKyf8siLb04cTkPJZeGDA/ahe2reDR/HuKC3bb8xovcXyAsy
 PK0gPhiaISKeviSMaNiZsUf9B/Dref+1xyuc6+K5W8oarHexT+6IZP4k/sFi0AbYR0Om
 wHiZjRviuAQ6N1rzUqFdIzOMPbTDeuFCgUpb+eO+2VQnpisZx3XNzCjqES+9E/FKrYnt
 oRG7ii+T17NoNKxKB4ZpUB9kmpJJV01IviT4VDgzF2D0zj5tJuyoyB1GDsN1asEdBHLP
 n2CUKaqRz7OKF21ob2U7GeeCwTA0Qc+bGfzB36emB6WxLNmntn2mhH9IBrrU7nfEvoGk FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9swte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:55:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236Kp0gE034040;
        Wed, 6 Apr 2022 20:55:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974dbprv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 20:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIVc8u9mIafgRF1ygfBh/+z9IDXru3OVYJ9MLhZm31w2V7NgB1wfhI+ermBGWAz8PTjXdd1DsSG9OjDld2t7LHMe49lKkfwNBFTy8PUVXvLXsC0cRTQF9rqNTlI0olO2VLPek44qlJ+fJ8ZSrtYIf1448fi1QTWePLiD7BlhQ8PwPVG1h+Ajgm0fUcXsTP/DmX99Q4D9MppNh4AxqkyOuwW+ZKYiBjaq9k9YM9l3xULJt0cq0HBEsZK8CYn/Og7dSteNohU/O+fL5ssZqNcbxx0u9KUxsmmzXG9Jo4gEq+yiLH98dNuycnctj7/mKGrFcJGb95MZtqorr1bzml1mHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAU1ZvAwP7cXZ4oyI1adHlwVEo1BDYu/ZZfRLHyzmSI=;
 b=oG/87MTZV6ZbNFIMKubroJzvalzSmlixJJJxbduUaeo33LZ2s0atnmHpzEwAHGmQ4u1RseKJXNMWrF1rHSbnLytZYi4Dxbqq0bl3tstjU6H9scNl2jnR0bK0Cj2zo0rVkEtoGez8WSluuyqcw5iTZMiE4y54+O9eVKPLxqK+QCkaQwAAkccZpm54vvJZDCnX/xcVAyVmayTGVBYW3GrhbnUkhFIRthTE3KmSRLKHnxW6lN13wbrHlLhMfjvY5BoKNmaxUXO1yFZplpWNteTTlISaTW7AP5iFu49lMXUed9yd/mkIVIFNFnOyDFKY5jdWpY4abckwZlS95oKOGwIIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAU1ZvAwP7cXZ4oyI1adHlwVEo1BDYu/ZZfRLHyzmSI=;
 b=D/U4Py5xYOfh9YNjAMyaiEYF8W1WDbob45ZemEl7mxRzJ5agWj/OjSYeVDxggZg+Egp+J7CugMUBfbLDnO2YxlUznP2eIo60BCUzJZVSMNod8bkKT9yOwM1ct2828U1DYzhkYQzRtRKJiMTiLZ5eaBT5N7CuSymae00Pn14tLyU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2573.namprd10.prod.outlook.com (2603:10b6:805:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 20:55:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 20:55:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Topic: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Index: AQHYSe/bEHUctVBe9E2g94N5iR8qkazjV7AAgAAFsoA=
Date:   Wed, 6 Apr 2022 20:55:22 +0000
Message-ID: <0942D638-0F40-4811-9820-AECAA65D529B@oracle.com>
References: <164926821551.12216.9112595778893638551.stgit@klimt.1015granger.net>
 <164926848846.12216.6872977249610829189.stgit@klimt.1015granger.net>
 <7976abc7a7ea7bbc445256884d0164a1b3ac5bb6.camel@hammerspace.com>
In-Reply-To: <7976abc7a7ea7bbc445256884d0164a1b3ac5bb6.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ca218f9-6d71-4cbb-3b77-08da180fc48d
x-ms-traffictypediagnostic: SN6PR10MB2573:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2573B773B2C574ECAE86001893E79@SN6PR10MB2573.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oga8jq/+ngDwKJo1T5R391tfF8RdIwNq5hmYWfrKetGAPikJiwcqo9cGbnTOrPHXIn8nf21csroEpuOglMu0thScmE88RkEDFwnQc570S+K/+UfKZLQ3gmL8OY6oiZ9t+wpA2BE8QHxAGK+dQXWcn+iUChaU/l12pyPfVcXNqADZqAXvKpKcnBA3N+42utizGKwukcqMocyGoa9rGAgS6e9wh7pXjjEjKUcsRkdpLs1iFIUGr7t3N3c6eAhIjPAjoGyBRhK6TVocqHKKwWU7viiZl5okV7wWZYbydxPcNmtF9uf/LazkOw5eXnV2uBNhvfu/fG7soe9JF14KyqmFyKK3K5oPtug5xfNmf02wdSufmT7d5dt5JzMJ94rOmV32E7iqZ2OAl0bSVZR8+jGs9lWr2Ek/Fbpv6H690oIPvPgDDuQspZPQ4qe5bjiRo4hPxTt9TMyHy6SRfopJBt2z2p6znQkEaP9dqvE3IhhzysF/xbWUze9IJ7mgcPmkxtASvxytplWqQu/4NswKOSER/6JctLxGwSLanQCwyvfRhiFbsVu6xB6vzGr2Qh9RqeU0rToxMWkIXkGSMCkWbs/nQZoFKRLTtEw3VGUmPXLm4Kk/as45RrU6l9+di3U6eoEpQk0uLPAIczbNBbMBqiv3/bpdxP7sAog67L2ZVmDn1JcEYJ3ujA1SI4wxsoEsa6Rgy1fjFWx5WrndIL1vXBud1qfvGyWeT6q8qn62iyMJw3XxKxmbwpCT87XwQJN9egoI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(186003)(26005)(91956017)(66946007)(66476007)(2616005)(4326008)(8676002)(66446008)(64756008)(38070700005)(316002)(76116006)(66556008)(122000001)(6916009)(86362001)(5660300002)(71200400001)(6506007)(33656002)(53546011)(6512007)(83380400001)(2906002)(508600001)(38100700002)(6486002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LFG4YK/ycPCEYsYwDNV9WZ1Oo9IrwusM9KirWZMnuhfBmDbjXBjz9JEWRnEV?=
 =?us-ascii?Q?YoskAVv+a56fUUT3eXC2xbYPN5rntXxrt3wZpWhAb2Dh/ureRoZXOJ6nFyWi?=
 =?us-ascii?Q?tIwUTf0NPvPCrXGAWIx2oD/8IpPXcoIZPQilCS5rb+3uz3BqrOSILSvOiJsm?=
 =?us-ascii?Q?ataee6gfqsA+2ifhFYKTdXCTHqGMWKYCpOj5DeXqBFX8KNDE03ctHkBVBHli?=
 =?us-ascii?Q?dXPDGS1qPcDtuQUdAG+FuHJDC0eYE534m51NOGxWO4BPD062WM3ftk5j0J8B?=
 =?us-ascii?Q?x/cgWOx+9aBXnk521CDn40GSUydCTuHFw54NVUIBjMvrAWUHf+Ak7toHHDHi?=
 =?us-ascii?Q?xoVveTTlZbvFHYrkf9+XEBS1yCwMm/fgwHtWLh/hqSZl16mL7BgZIIQneczA?=
 =?us-ascii?Q?s9DYJOKviWqnMjE88/6N55gHA9wrfSmbwGDgRfLdgYxcS86Qu9dF84bZhVVl?=
 =?us-ascii?Q?69HYFkwKaL0dtGVrI6yZtf+P4U9DxQ4zVWvmJyFds648JGVyBtSoTrkNbgL5?=
 =?us-ascii?Q?lbnpDZNexUV1R1kAl53W30epIUnekXiUr8o9xqFYiLcisXdq9YHMBLRjO0pj?=
 =?us-ascii?Q?82u15097MzlbWBSRCGIUHcAAkhOADeHnYFz5G2PXswLSA7M+Jf5TtZo+iM1h?=
 =?us-ascii?Q?zUJluRFpgguhn2hNnhWq3J5+TjgKcO5+wNYSY6+24FmN4YxGbxcdE3I0IjU1?=
 =?us-ascii?Q?D4ko2ULoWOpClT1zNCPUoe8jSGYeHDNcWUD/Rf8dNZcJTkpRYJdit58MwOUj?=
 =?us-ascii?Q?M/kk9CQUZLeLaNupmWvDOaR45DhIuk1cG3uuzX3CpjQtizbWVWIZaBrE3y+N?=
 =?us-ascii?Q?nGBugtDFQHq8T10xUZaGazPo8//swlr9JX/GpJqinXH/3PejdCwcqT94vsmj?=
 =?us-ascii?Q?DtB4238XgwIS0nFvxJ1no+gS56jTvazmPgB6blmEa2HNVWwpB9v0hg9L169S?=
 =?us-ascii?Q?e412F17HDz3zoVQbJmWjcBDW4qG84/pbapxJGqbob7YSCz3DbXkHfqMOik6C?=
 =?us-ascii?Q?y+AigC8hSVMyUskQoQApzC/1wfcmBPDIU0k2Nw9XLfYYJCQrcfRlnHyC65E2?=
 =?us-ascii?Q?S4HFSpm09A3hJ27zsNrts/NuSOsVPIrys0ov7TLIFgwKufoi6SuMCtLs3KC7?=
 =?us-ascii?Q?7LE7fy0D+zX1P6FAiGW9sYWd+QncMjAocsoHDyxZBTdu6TEq1kjwNY7fQ+9u?=
 =?us-ascii?Q?YzP5p0stY9Rs9B8nWQL2RK84ni124bCUGNx5jnUlysAs40w4f8fEVdIxEgiO?=
 =?us-ascii?Q?+rMmvXJn4YAUpnGy9JzwgLozQfcdVZ/eOWBYdR0rsh2Zo9CvdM9tArkLO7De?=
 =?us-ascii?Q?Lj00KcYkrajl9c7twAhhDcImrgE59LAtRt4lUZM1J5se15IqJR6++VU7uJGe?=
 =?us-ascii?Q?8iiNT4NJRs19EZRv11fi493urGcX/Hg6cklIFPl8kdBbi+ty/gnpGP2eusLq?=
 =?us-ascii?Q?NudpKeKRhRGvuLk4cgdVOlbH7hVi/mOGwKyBMQVspCUtUAep44I2qWpduhIW?=
 =?us-ascii?Q?1fhPspymz5F1INXU04+g4XvWkRRUG2Tj49dpoGTUTHJEEw0o5QMiqFJuQ8aG?=
 =?us-ascii?Q?iUYsV9WE1RdrTNPM6k7Mpdswe54ejmZ+qXL6ek9yHeOyOskxy02/dUT7Aakn?=
 =?us-ascii?Q?HZPXgg8FrcTLPO1Q0jw8K3fZiIDYHdJIjEZUsiEATGzIfbO7MQ7fWakt/Gio?=
 =?us-ascii?Q?4c6AOPl6OvP0BgFWwy9it8ENfrVXHfpqUD6rk08uh/Ld07bAfdUVSU1qIj/T?=
 =?us-ascii?Q?IpnfNBdfoSSJzxboTq/UpQcpkAg1/eo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <022CAAE20515F14BB90D7310DA91F0EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca218f9-6d71-4cbb-3b77-08da180fc48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 20:55:22.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGQWySJOff+SjKkOygmF4xDYoTnK2I8CHjSydKHr1ZRcz08OfFBh1xg2AKLmHDaqbDBaBaSoIQCeEO6Okr2+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2573
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_12:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060104
X-Proofpoint-GUID: LH9QIb0UOFQinfpSWh1HYBCG6PGaGmkG
X-Proofpoint-ORIG-GUID: LH9QIb0UOFQinfpSWh1HYBCG6PGaGmkG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2022, at 4:34 PM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> On Wed, 2022-04-06 at 14:08 -0400, Chuck Lever wrote:
>> Fix a NULL deref crash that occurs when an svc_rqst is deferred
>> while the sunrpc tracing subsystem is enabled. svc_revisit() sets
>> dr->xprt to NULL, so it can't be relied upon in the tracepoint to
>> provide the remote's address.
>>=20
>> Since __sockaddr() and friends are not available before v5.18, this
>> is just a partial revert of commit ece200ddd54b ("sunrpc: Save
>> remote presentation address in svc_xprt for trace events") in order
>> to enable backports of the fix. It can be cleaned up during a
>> future merge window.
>>=20
>> Fixes: ece200ddd54b ("sunrpc: Save remote presentation address in
>> svc_xprt for trace events")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/trace/events/sunrpc.h |    9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/include/trace/events/sunrpc.h
>> b/include/trace/events/sunrpc.h
>> index ab8ae1f6ba84..4abc2fddd3b8 100644
>> --- a/include/trace/events/sunrpc.h
>> +++ b/include/trace/events/sunrpc.h
>> @@ -2017,18 +2017,19 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
>>         TP_STRUCT__entry(
>>                 __field(const void *, dr)
>>                 __field(u32, xid)
>> -               __string(addr, dr->xprt->xpt_remotebuf)
>> +               __dynamic_array(u8, addr, dr->addrlen)
>>         ),
>> =20
>>         TP_fast_assign(
>>                 __entry->dr =3D dr;
>>                 __entry->xid =3D be32_to_cpu(*(__be32 *)(dr->args +
>>                                                        (dr-
>>> xprt_hlen>>2)));
>> -               __assign_str(addr, dr->xprt->xpt_remotebuf);
>> +               memcpy(__get_dynamic_array(addr), &dr->addr, dr-
>>> addrlen);
>>         ),
>> =20
>> -       TP_printk("addr=3D%s dr=3D%p xid=3D0x%08x", __get_str(addr),
>> __entry->dr,
>> -               __entry->xid)
>> +       TP_printk("addr=3D%pISpc dr=3D%p xid=3D0x%08x",
>> +               (struct sockaddr *)__get_dynamic_array(addr),
>> +               __entry->dr, __entry->xid)
>>  );
>>=20
>=20
> Have you tested this? I found myself hitting the warning
>=20
> "event %s has unsafe dereference of argument %d"
>=20
> in test_event_printk() when I tried to use something similar for the
> NFS code.

The warning is fixed by c6ced22997ad ("tracing: Update print
fmt check to handle new __get_sockaddr() macro"). I think
this means that along with the above patch, c6ced22997ad will
need to be backported to some recent stable kernels.

If you're adding dynamically-sized sockaddr fields in trace
records, I invite you to consider __sockaddr/__get_sockaddr(),
added in v5.18.


--
Chuck Lever



