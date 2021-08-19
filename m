Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83363F1BAB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Aug 2021 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhHSOfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 10:35:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15732 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240508AbhHSOf3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Aug 2021 10:35:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JESwPB008136;
        Thu, 19 Aug 2021 14:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GaOIzHpw/OrgobXXIIX0E8SBslshDRHfacQMglK8ygg=;
 b=hSnQYoSCkNwdZbHYz0cZhgnSvy7Ghf1lhqWKlZL/dn/SRp/ENcsVNEfxyVU+BGfi63yP
 /EoTbf2MgZAtGOPyqvsuSmQgVwZpeNtwy5n2ZefL9ZdnfTQptbF2Rg5m5Q3HOouVA3pI
 NsEutxCtZx3aKgJaqQ21VkksBA6/L/4yUB2V3Fkeglc4BuNAaXrGclCTNO+2hdLZ0+kB
 bZxPdMo30jTxDqq2dWL30mxOS8ShYp7W7IlNyFnnhL1Vg05mjxZRiHapUWmfJoOrsU9c
 WfkY1tQqFrx4I8krU2VkOA9siA5eU9iXBCevzcCSrZjcb2FJlrCk4oxFZdPevfOSIHI2 Pw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GaOIzHpw/OrgobXXIIX0E8SBslshDRHfacQMglK8ygg=;
 b=G4SpADxIPNC4STmwX1lPMqYSTA0L8GhLgLlDgUBap8FU7IXVvwUD+vrjMdWhzN9LM6OA
 /5DF6VYr9OtcgfGmNPtEMSjVkcbDK/TEBQAw8nH1Qrhx/AwlMRBDtzciEnnVcyTGQjiM
 bvQy72NS69j085E7vSHruofjk3FxncnoFaitvz5toV/DF+nS5sfqcowFYkUmiYU/1evR
 lBsieXraVpjBgdhxM5hy/MWXqrDPsRPHQFAwBgR3ALJpN2iwXWaRmefeaOwm4HZM7fGC
 zjM8heWE6ed2hEpIzgXwSlEEsKU7qsXNxjpoz7BswXn+eznSepI9WxZvBO2fEOTMNHeT 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mwjnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 14:34:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JEQtsE087354;
        Thu, 19 Aug 2021 14:34:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3ae5nbmjp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 14:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVqIhJrTScmU+b6R6vjEXCgR/EN+MmLX4XKGPth5CwyLTHAEHKv5f0hmN4G+GM3f26+cKzHgPJo8FhLa0GbBpvmNRjPlFUldEq40ugaUMnxr3umEkrVHvqKwjjl77hNliYSQoQ+PmPTeG0pKx1H91AoITP7QEXM4lK0eMAmy7pqL5f94vPM1Tw4hFQnHVzoOpAE3QM60V+vUlXO0DIzIAF4AgNHVgLYZDc+U6mbm7OaqJCemSaybIf9BSlVFuyHGHU6selbnfL00qRzsa7cq+xuEfQhCr2uq6xCIxGKisGfOVyDa00MH7UYokcZmgBcz61CZcfiq8g1+Bma+QhhuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaOIzHpw/OrgobXXIIX0E8SBslshDRHfacQMglK8ygg=;
 b=KiOkgjKJ+lxJrNja45XaLm+YW9mJciIVeQDfohPV435wfA8/61AqaX9b8UHytqCr9UhDvtgTtGA+wjoam55DAcg0o9WQFiR7QtdEStkC1GcDLTOOPZOv5jWVc758oi9mnGPADyA/CMT6ph0RFWDCZ/k5HlF75RYqA23yHDn6xPSVsSLVpcmfyxmKSKWmizkMz8OHc5qeTtGrAn0HqkVvleC1FMlS03RrroBvxoInb9zR2+PfrrkwDG4YvMwWqqRxbdJ0xhw5LGguEltNqDUwgtjcofYhWlcLoal5Y6i3HADZAAJ0/26Fpc9WNr5lhFsIzE7lNs2w8x4gOLdKo01mvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaOIzHpw/OrgobXXIIX0E8SBslshDRHfacQMglK8ygg=;
 b=t4OQ6HRjv/cuUBPi1Yhq29mrhbWbwJ6CU0O6vnxNPfY89lfT4Uq/pt745g+0EOBz0tSHYeJun6xx+HyJaGUKXX+tvHQGHZ7Au64LtARlcRiKCYLtRmFkSD2WFM98xT9ENQWePhYVOQ2P1kkTBcvQvApoMRvUkicm5wmxA/xR9s0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.23; Thu, 19 Aug
 2021 14:34:49 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 14:34:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Topic: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Index: AQHXlPXcGICcXaW3sESgYQmy74r7pat6ysSAgAAEDgCAABBYAIAABaKA
Date:   Thu, 19 Aug 2021 14:34:49 +0000
Message-ID: <24B4FABF-C6D5-4FF6-89B7-68EFDC3AB415@oracle.com>
References: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
 <ed3fbd005a9a2e3a6217085ebe05e80cd78766ba.camel@hammerspace.com>
 <6D4FFB37-B5CB-410B-A3C9-AAC92F611520@oracle.com>
 <69e8d4c3ae302ba51a92e20c927006ad33b2486c.camel@hammerspace.com>
In-Reply-To: <69e8d4c3ae302ba51a92e20c927006ad33b2486c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a9a560d-5417-4e39-adc0-08d9631e7f9f
x-ms-traffictypediagnostic: SJ0PR10MB4510:
x-microsoft-antispam-prvs: <SJ0PR10MB4510C2E5A99A5701C380A55193C09@SJ0PR10MB4510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/UZXAIioQhWoJHPAds5yejqSox5xZ6s2ll3QfFYn2DlXLGezfpQBFwpI/pGJDNGJFiIzQ3js5jBGBsXnX/64HSTW2YhTj2DjmSyzDEQUqsrWQinvJK4m8Fss+eosjy/3i2tlnCyhpmrlVleQPVfTqCOobvlMXtuCumW34yoCcwpmLq++2XaGVbv+Y7LaH49QXkoXP+juxShoV9MU/z2KcGNpWzQ32LnHIRw2eiSQc3wm+todDU91sInPbEIKCI3oX5BJmV4LV1ykQJ4JpcSezzy8hy8I1HoTy5I7qd/+LNOV8DyEMueOJI40Pc8KBBo5ImukuYRVir89cgTIAcX3NPrYx4zmg/PfnZzc5JXCLxxoa3BuW5dciyDw4kTnO4MZxoFjZsIEJHe+8zVZZng9JneCkX4K0dkRHyK2IYnx8sX62Xy+zxmzq1Ps6gsSrIHikIppRkFIEHWCVYatyxZ0VbMbpWpwveVo5oedegDACj4eOMG/OekIK2G/lnJ6vH5JiTsG0fKaDBJyjFg0fAh/9PTe8x7UoahpgKHXZtj8zZkb5tGKRP3u+7LG+GnWCv3FcpRk/1UJJjw74tJw9E098xlUYJ6/ZZEkmkRmFRudvWv0vrLXtAaDZd4vySPCd9ptvyJhXgqj8wfhXpig5l60RcCejDLa8iA9wkEf6HgiiXAgcq8F5X1Bo2z7GzQQUY1KFV0gOYBe6uzHBWxgtAc+ZVfVNC09otLLDBjw66pjmlSYSqIvAYOuen7MTmMir2Qy2+iW63qHz+rpOKk3DGgZ+FCY0C/+SQk90Vi3zx9KYOKi845K06hDAHXr6pBabfT6pacqzr28QYQtifRF71/r4zcTtep62Ax151NG+CEGM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(136003)(346002)(4326008)(122000001)(2906002)(38100700002)(66476007)(66556008)(966005)(66946007)(91956017)(478600001)(316002)(66446008)(2616005)(64756008)(83380400001)(38070700005)(186003)(5660300002)(76116006)(86362001)(6486002)(6512007)(6506007)(53546011)(8676002)(26005)(6916009)(8936002)(33656002)(36756003)(71200400001)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SibRUL1iNO72mqaegK1t49OG/9Z1lFF7ouoDdcucbniiBikytiI2+GZE0d9y?=
 =?us-ascii?Q?C9Ss9iOl9PcS+atiktmmn6VupQGhRUanKBuTsbt9RwvAAe+xjib4aQjdqGg/?=
 =?us-ascii?Q?uAeNylKDK4MUdv85AZi7MX6zyzQizj3T2psrjCKpnmVcqfuLoBTWpkty1VqC?=
 =?us-ascii?Q?8B8tepVBgCoSUizUGavEVL/T6HfS1b7kPl58y9wn7WREjwOhtJuFxqlbD6QD?=
 =?us-ascii?Q?iaQFl9KsnWQVck+N719B7tUy6EBKp28+FWLBqsWuIXMSqCIzVbzRcIyeItiw?=
 =?us-ascii?Q?W5BTotRdUy5q5+tv3bgvJbdGulYu3j4ItBMb/34AemrSvPzmEjsQ+p3KNM7n?=
 =?us-ascii?Q?XV+wGO7yJX9OwaBb2VGpsw1j2f3IzCvlkiazRXvkyX5FAptPAIwx8ivsuhfR?=
 =?us-ascii?Q?+aiw5mHUYngVFtlrhOYoJ36DWSq35yWqtTj864h2WJMbSsGkI7RxmMm3Ruee?=
 =?us-ascii?Q?JpjIQycpk7mhByWfyNVf0ES8oJbyZkSuV0i2DEyUSVYNnY30XiUpWRNRnFKL?=
 =?us-ascii?Q?hq6OGSckJE5ajOcNGyC+SDb1PRAxTCqIcGbgl8N+Ao9Dfb2DyEJM61kSXfl2?=
 =?us-ascii?Q?Vzx1/gsQIMcnR+Smb6dl6J2uyqfWpfqSqb6kycZL4vSqCpfqb172WptfMo1u?=
 =?us-ascii?Q?QLDSWPtoJrjGpOwlCF5InZUMmUPpl41lMyEYAOX9MzDh/azP6BMW4w4FmyDv?=
 =?us-ascii?Q?bMLklbIN6LqD5JFjTP86zHp9TABDUiK3Xn9x5kbC3YFf7mZy+YRnJQ0wNxME?=
 =?us-ascii?Q?to/EMKhbnkBwsHT3hjS8z5GzzvrnS62kOWaF7J83NokABr0dr0WVS+fAxzbE?=
 =?us-ascii?Q?OpLfACuOsrIVFVdUb8gmitQ7bEAiVka4Y6ewsoKNREI4pmrk3zm1bNA72nhd?=
 =?us-ascii?Q?01tUGpEaGYs0VI9LeZQhZzUMOgXWJmZ0u1lI2cl8FAhcmMLUJY8aZYAfVvoZ?=
 =?us-ascii?Q?XAFdxEyf2KD93nDUXgBljRnuHS7JA3walVPZfjeniA1lkXhQjY+GZluvs145?=
 =?us-ascii?Q?0cAmjaJX1ZEBGJzeQUdMfEBNlvDZB+93U9R15uAzd85/eNtfbIfVcFw3Lg98?=
 =?us-ascii?Q?EDNsjT+h4hm01QzIYK/wJn1Do3cLDe36fiTGvoOmXt0BQPwHXXedjPSprrif?=
 =?us-ascii?Q?eBnQYJPNIuZd04QkAobC9gADPa80bb1GppD+oWE6hA8IjlvWVjJ7JiK7rB8C?=
 =?us-ascii?Q?fp1C7tw4R89e/1grhzichUuK2iBXWSD0yw3xp+U2a33AvS/WZVBGItfcZdYj?=
 =?us-ascii?Q?Mtqrtgd4qLWTyzuX9dE1uwwv108aEg65u64lPFGAoFhSl3NuVUY9QZBtDQGl?=
 =?us-ascii?Q?CLlaJ6UtWNoKTa+1VA+5cTBw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05A0C177ED4BA845BAF0853065298E85@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9a560d-5417-4e39-adc0-08d9631e7f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 14:34:49.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taGj8K9EEJo2A/c/l2H+ipuiL8KsGnA/Hg+lTiBZc6/vkPPP6OUBS2oBsSVHZo6M5GBnGhIhOLLhwafVnfQrsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190084
X-Proofpoint-ORIG-GUID: pyeEiawpLajgqvkHXMmF4dFgYBeTLS2c
X-Proofpoint-GUID: pyeEiawpLajgqvkHXMmF4dFgYBeTLS2c
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 19, 2021, at 10:14 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Thu, 2021-08-19 at 13:16 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Aug 19, 2021, at 9:01 AM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Thu, 2021-08-19 at 08:29 -0400, Chuck Lever wrote:
>>>> With NFSv4.1+ on RDMA, backchannel recovery appears not to work.
>>>>=20
>>>> xprt_setup_xxx_bc() is invoked by the client's first
>>>> CREATE_SESSION
>>>> operation, and it always marks the rpc_clnt's transport as
>>>> connected.
>>>>=20
>>>> On a subsequent CREATE_SESSION, if rpc_create() is called and
>>>> xpt_bc_xprt is populated, it might not be connected (for
>>>> instance,
>>>> if a backchannel fault has occurred). Ensure that code path
>>>> returns
>>>> a connected xprt also.
>>>>=20
>>>> Reported-by: Timo Rothenpieler <timo@rothenpieler.org>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  net/sunrpc/clnt.c |    1 +
>>>>  1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>> index 8b4de70e8ead..570480a649a3 100644
>>>> --- a/net/sunrpc/clnt.c
>>>> +++ b/net/sunrpc/clnt.c
>>>> @@ -535,6 +535,7 @@ struct rpc_clnt *rpc_create(struct
>>>> rpc_create_args *args)
>>>>                 xprt =3D args->bc_xprt->xpt_bc_xprt;
>>>>                 if (xprt) {
>>>>                         xprt_get(xprt);
>>>> +                       xprt_set_connected(xprt);
>>>>                         return rpc_create_xprt(args, xprt);
>>>>                 }
>>>>         }
>>>>=20
>>>>=20
>>>=20
>>> No. This is wrong. If the connection got disconnected, then the
>>> client
>>> needs to reconnect and build a new connection altogether. We can't
>>> just
>>> make pretend that the old connection still exists.
>>=20
>> The patch description is not clear: the client has not disconnected.
>> The forward channel is functioning properly, and the server has set
>> SEQ4_STATUS_BACKCHANNEL_FAULT.
>>=20
>> To recover, the client sends a DESTROY_SESSION / CREATE_SESSION pair
>> on the existing connection. On the server, setup_callback_client()
>> invokes rpc_create() again -- it's this step that is failing during
>> the second CREATE_SESSION on a connection because the old xprt
>> is returned but it's still marked disconnected.
>=20
> How is that happening?

The RPC client's autodisconnect is firing. This was fixed in 6820bf77864d
("svcrdma: disable timeouts on rdma backchannel").

However we're still seeing cases where backchannel recovery is not
working. See:

https://lore.kernel.org/linux-nfs/c3e31e57-15fa-8f70-bbb8-af5452c1f5fc@roth=
enpieler.org/T/#t

As an experiment, we've reverted 6820bf77864d to try to provoke the bug.


> As far as I can tell, the only thing that can
> cause the backchannel to be marked as closed is a call to
> svc_delete_xprt(), which explicitly calls xprt->xpt_bc_xprt->ops->close(x=
prt->xpt_bc_xprt).
>=20
> The server shouldn't be reusing anything from that svc_xprt after that.

>> An alternative would be to ensure that setup_callback_client()
>> always puts xpt_bc_xprt before it invokes rpc_create(). But it
>> looked to me like rpc_create() already has a bunch of logic to
>> deal with an existing xpt_bc_xprt.
>=20
> The connection status is managed by the transport layer, not the RPC
> client layer.

If it's a bug to mark a backchannel transport disconnected, then
asserts should be added to capture the problem.

What is the purpose of this code in rpc_create() ?

 533         if (args->bc_xprt) {
 534                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC));
 535                 xprt =3D args->bc_xprt->xpt_bc_xprt;
 536                 if (xprt) {
 537                         xprt_get(xprt);
 538                         return rpc_create_xprt(args, xprt);
 539                 }
 540         }


--
Chuck Lever



