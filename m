Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABE030E18E
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 18:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBCR5B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 12:57:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhBCR47 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Feb 2021 12:56:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113HsKMd057204;
        Wed, 3 Feb 2021 17:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=cLzFnW9MVtaVC9eZEIbmZ4aNRay6D65sWSjiMA+ysFk=;
 b=hdEqXrAlrUA12MokznG5EWdgtongm5bYtWXlNE60FGew9hyMCMWX7j/DAFp0KyuEtgCM
 PphyHStWBFnH30K6BiUfpJu6+0JP1dzPk53ILCMC7XWOP0psEhnrBE8n69fvCo2lJNBR
 FOgDDjLzvoJiRS1aSTBJNv4rfbAd/uNRfbHlcHIpR8uawsjuLPPiKi0Y2z+uf84Ws4Dm
 bJuDh5rRPQFk/1rw5NACVldL3yT6MjJhkh34LTBTkQP1k3J/XjAWDmqD7+UGQmTImauD
 VBdJb14LmeqcjmAPbmjqGukwxCqzUcoxkJkKa9Pbkfdnd2l3MuqlcOcJCvuODegQpX4m jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36cxvr44rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 17:56:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113Hp4qF050865;
        Wed, 3 Feb 2021 17:56:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 36dhc1g2rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 17:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJwXvPKR1GX46lohEHhaJ0LxVAhxTgImKKMC4pKeOenbbA5/dLxx5Ju/ZOEDArgN9j+r0nD2vvJ68SwfL1mMa1OAKquU76F2HkMQ2TWyHd33msMiUa6WdsDNvXsq2ILX6ZwAywqd4UkztUknch9R50ecyMpHbjlfPQ7hOU42X9/d9si71wpeQ/zm7FZNhUNzKRpV2ogcBCoccVuAp0tFHa0tsMZuYyHnz2c5iJx0Lv6XLBpMsZeFvIyzSy4Clk1ZoPIJU6FD0+p/iUt9Ods3aEpYUcGdNQXHa3jTNMigNMRVq7EF2jsoopucznba49/5Z8t8lSJk9smOt+7RHyF3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLzFnW9MVtaVC9eZEIbmZ4aNRay6D65sWSjiMA+ysFk=;
 b=C3nGvMQrlST+P4W/nf0b+wDP3gGGRmqJOrCjHkjb3Rxzvp3CSHAZhiWBaNY2w+EM3ArmBG00Mm+8HzwpMgRBp5xmlhtDgJ/L/B8lOUhEzacxruv5EAs0nWsDZYDThBppWNqeM6MlPLXa7FjRidxI+oqzK/Tl1K/uOtpXlRm+ombV6Yy8nFKS6l9q25ee1aN7amOEuEYa4+shERhLExwXorqDa+/Btd/xCejfQ+R74XQN72Mm/8yyAGyrxpuMnjMbhPgE+M0zmkt9UDNmU0WTfnWhbeIgEqmzA2DWllpcKoiizCpuz10L4kOxQ8TUsz+ajeNICkNMUQLQSurlneSQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLzFnW9MVtaVC9eZEIbmZ4aNRay6D65sWSjiMA+ysFk=;
 b=JiuDAH8fq77kam72rOGhF4a6RHUy4ElqdYt07lEvKTMtg2ckw+xrQmj1+xyd8n9d+EctGBBKl5GL3iUHTeBU2fZQNmTdH/vMt6IE71cT47JD+iYN8JJ2kEJowIBN5VpKp3iPSQwGoUvmg3VAyZ2WhlFnqEtEuv3dqyXHcS94+MU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3717.namprd10.prod.outlook.com (2603:10b6:a03:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 17:56:11 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 17:56:11 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: register pernet ops last, unregister first
Thread-Topic: [PATCH] nfsd: register pernet ops last, unregister first
Thread-Index: AQHW+kuPqXx9ogEBD06qHoGJB6Hv2apGo34AgAASnYCAAAEDAA==
Date:   Wed, 3 Feb 2021 17:56:11 +0000
Message-ID: <3BBAF3B3-EB8A-4DBB-9312-2FE14F923F0E@oracle.com>
References: <20210203164213.GA26588@fieldses.org>
 <70729484-C3C8-477F-8FE3-06B6A70510C6@oracle.com>
 <20210203175233.GB26588@fieldses.org>
In-Reply-To: <20210203175233.GB26588@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f23801eb-7285-4cad-1801-08d8c86cfdd3
x-ms-traffictypediagnostic: BYAPR10MB3717:
x-microsoft-antispam-prvs: <BYAPR10MB37170F842ECFD96222AC179893B49@BYAPR10MB3717.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7jbY2sagWV1N800bMcRQn8C5V+XwyxtpMsJpgg319Ksie8MJOhmPaFPSIWKmBXpSigVaUYsPiCSBidPWRhp/Om/Ljr6g5B5D8Q6hlTknYukM6V0ldovPBB9aY2tWdu1FeIIzj0RvokV6hyTxGthn0URqkz3bf3EOC8qEIgK06TeK7+L3G9DFFEwHv4dPdIUSKPshrdzPYOeup1tvde1tBkt99UblIgGgDr3OzrjKou7fcBZp8X3gbabyBqhG9TsxPt4ePdEhC+HLJYwsUjAuvg3mmEJGhcB2gqVrYSmRo48mGi6OdWi20WAUA9ENw9b/ewSPx4G86dFOS2eXPwWg+2j/vCmDgAonCfR2AX+5qzrsPYp2Y26iyLLSTce4nCaXcOEJwwtLSRy1XYUOz2xY1g/KIBi6aRvXlJJT/n9TUc4VmhnPvM93WIIpqVLwGS56jZW3r4WWwnuF1MVVNxYmpylxctNs2WG3uOFWmwkxRt7dZpo0Dse/XcuSfVwjT0yT8ULZ0G8YppueKrgpMQ9hjAzeOwoRLSTlBOejpJ2DipOiBaftYHEs/CEv5ILfq8E0JnvvUoJ33WsOb7a4RLQWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(366004)(39860400002)(26005)(44832011)(4326008)(71200400001)(8936002)(6486002)(33656002)(6506007)(186003)(83380400001)(6512007)(478600001)(6916009)(66946007)(53546011)(2616005)(8676002)(66476007)(66556008)(36756003)(66446008)(2906002)(5660300002)(91956017)(86362001)(64756008)(76116006)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K473L/+SEnQFob8aJFRtBCW3d8QBuaC7PcGepaRoIbdab7cQMuIrBTINA+Fn?=
 =?us-ascii?Q?M0f4ejKaL9Axsa1uOvBn9KZTbd4lJS/DHkVXLQO+Q210grNJabFbcXToCAW/?=
 =?us-ascii?Q?jnu2d1OLdcTzt4dxi6nikjlvMxfHDG8sPy0TLjUdZK9c8bqPsK+wXwXh/9p4?=
 =?us-ascii?Q?zBcHr8dGFgxTDgjh8sfo2UOArBifpdlO+v/2PeG2/uM9Sbb2ikLA6jpDsYeb?=
 =?us-ascii?Q?/XAph/5uavthSo/XDaFIL1Dm5qTMOjOzMi3MqsC04uGlgGLDh2CYHrWXmpm0?=
 =?us-ascii?Q?Tfjy5OD9fWQMMOHBU/DttOXAvcH3LP2NQRcY07Jt6H25dZmgEsoHbR71z5gW?=
 =?us-ascii?Q?FW/j4JZUfCtqFpDMz+0AxF46ZxjkdoxTrxoypfa7wclpzqQeqMMAimVg78Ce?=
 =?us-ascii?Q?IsTpx+J+R/348C5GgNEY+XNquN8/Z+hGUPelvXSfb4igDXjKmLjQ3mD+njku?=
 =?us-ascii?Q?FRqEStrkK8lut/K3DAraIwQH5jmxf1FJinQ64kwz/rt2z8QVnvBWzZ0scZVC?=
 =?us-ascii?Q?3Hfzl9xDmulBsXaFFplbHnscSeTT4yZZIH5a+Eitz1VVUuAAwLa78JxxJN1Y?=
 =?us-ascii?Q?lAzb/08soRXK+BA99CrUnX3wMJg+3PSj0qLri0i+GAI9NowotUH3IWJe+ITg?=
 =?us-ascii?Q?RUN8u91REfTmqwn7Toq772r23jhhjP7WCedbAgW4ZoIMqiZVHauNbIVtp0fE?=
 =?us-ascii?Q?XuHIYR6FjxaTbrZacXcJe0GpZOrbwYTODkitBQYEJhbqoYcjqDBCNV9N585i?=
 =?us-ascii?Q?yve+S1YNX2uNXSvOoCT57Y7+0DpMJS4Ty6eidZRQPgR0RNF56ReA83NHvdQR?=
 =?us-ascii?Q?kTEiSdIcVVHaHoZ7B8WcfpkwCKlrZOhbPw6yGh3obxKFttoWsaU9DZFv2FVN?=
 =?us-ascii?Q?WN4xRJSa8KAk5ehcmpLHRuwWctjyH5mhI8c3Xwvs+C5CZZBiQH76YQd2S0xa?=
 =?us-ascii?Q?brPQ6aiXLog6BDu345+GDKnVrkLJXUtTnxFAzoWeVOBD6WIYAvqpsfSmgXMG?=
 =?us-ascii?Q?62+3U8sH9oe7fOdw3YhR+hD5HzUUNm9kRWg1KT+L46hFwY8rWGsi54xm6BNz?=
 =?us-ascii?Q?qFTykUYCbv8L3gVQPupRMyumpWGbjw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDBF3BDACA0134449E06D25CFD8095C5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23801eb-7285-4cad-1801-08d8c86cfdd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 17:56:11.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uT4CX088nKXJ/UFynSe3e+bg1NoGk3sv/V6ws7t/9nW3y+uwthmrF9VUYsm/ziQBj5E8MG9wolUDM3/NqnvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3717
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=960 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 3, 2021, at 12:52 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Wed, Feb 03, 2021 at 04:45:56PM +0000, Chuck Lever wrote:
>> Hi Bruce-
>>=20
>>=20
>>> On Feb 3, 2021, at 11:42 AM, J. Bruce Fields <bfields@fieldses.org> wro=
te:
>>>=20
>>> From: "J. Bruce Fields" <bfields@redhat.com>
>>>=20
>>> These pernet operations may depend on stuff set up or torn down in the
>>> module init/exit functions.  And they may be called at any time in
>>> between.  So it makes more sense for them to be the last to be
>>> registered in the init function, and the first to be unregistered in th=
e
>>> exit function.
>>>=20
>>> In particular, without this, the drc slab is being destroyed before all
>>> the per-net drcs are shut down, resulting in an "Objects remaining in
>>> nfsd_drc on __kmem_cache_shutdown()" warning in exit_nfsd.
>>>=20
>>> Reported-by: Zhi Li <yieli@redhat.com>
>>> Fixes: 3ba75830ce17 "nfsd4: drc containerization"
>>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>=20
>> I can't tell how urgent this is. Does it belong in 5.11-rc?
>=20
> I dunno, I wonder what happens when you try to write to and then free a
> bunch of objects that were allocated from a slab that no longer exists.
>=20
> But, it's triggered by unloading nfsd, and I find it hard to be super
> concerned about module unloading bugs (does anyone actually *need* to
> unload the nfsd module?).

This doesn't sound urgent, then. My initial 5.12 changeset is closed,
so I'll send this in the first 5.12-rc, unless someone grumbles.


--
Chuck Lever



