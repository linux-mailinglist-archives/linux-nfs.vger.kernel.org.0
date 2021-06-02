Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30841399337
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhFBTKg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 15:10:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8954 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhFBTKg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 15:10:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152J8GbA001652;
        Wed, 2 Jun 2021 19:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=82hvR6hIZ7YpXnUvdbrTgQcXvOPW+wOg+sahpM0KpIw=;
 b=MzdaIJFPSBRMBYew8VOCxOPnNhK1J+U7Kx0JgRql2LVlOpdvcLPTBdLUCSMLHSdPHTYp
 Vsq0IjtBIPvMLbi7BoLb0qLlF6Varpg6tv7GDxZvUo+Je88TWF+H8EjvlCPvf9TZRaiN
 pQg+YqN1RewEWAUiDI5f7vrYIDjFdqSW7nKCjwbHWOkpMkVm2SnfcHeXdYCArAR4GcDs
 /q/9xAGtJ3XO/HAnGBhxQBj+s2MzlIXRTSDF89yqZlKKfPKDZJP2OSgegrU/gjewU2ow
 lCiuAuLDNjnWOrtRh82penjq3Thko1exg6ooP9erFdsVrYy1ONowOX/+76Abaf8ji0qn qA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38wqjf0hf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 19:08:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 152J8AYu124866;
        Wed, 2 Jun 2021 19:08:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3030.oracle.com with ESMTP id 38ubne70mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 19:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS82hqB8DAsiKaBSCLyKq0J11Y3faCNXjaC9nxrCpgbfx/wwegQwhdXOGHx57QIRWx7GG+22WZYgLXV7EEPBWoAyW2QRLbdiacMKTv1h49KPYyrg8gk43v/SWQeIQWPvYSdqTGBQCTPq1erZsUGz2aRyFbAr+O3KVnS7NYwS8MHDV0ywp+oUaN/cqlXSadLWdowpPY6GtoCX1fm28NLY/A7z5JUYS8JEEyNulr2LpxdXmngLwTyNmf8JQTxC6UrduMUMCwwuceeKf2Rmta260ybM3nMqyPYhO0L4rbCwBhye5b7CAAFuspaJF1r/bvihUot2lOM5SCYb0ikkEXj0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82hvR6hIZ7YpXnUvdbrTgQcXvOPW+wOg+sahpM0KpIw=;
 b=g1Va+9r8JZ3j/OvxazQT8SS8A3OuB7ltVuhKTZuAF5wGx+Xphi6mlvcuDV68rJ3mTNSPDTEKrOmEpVSYkV82/2DX2o5LwoTptJogAzd0DGzkCvAOR1K+pukWDcbbVrjOoprruqPcUXhjUcmzcxjMPfLDmowe80U8hRmbdEgvaXj7yDLhSXKKo7KjqAe22CBzrt40HPpj/XELG/0++xKdO87wIHIp72itRLFZ4G9AuCfdhk/4YPceibuTkqcAvyqc/uRWLQ+10TNqVvn78JVkO4x5MwmIMbLbjtknCWTSmMHAvv9PVn5eTBePjs71qkQDVg7pBIGZTVYbylo+NV1msg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82hvR6hIZ7YpXnUvdbrTgQcXvOPW+wOg+sahpM0KpIw=;
 b=jx5VPmPNanY20Na1kdlT93qEFMomyUZcShelcte1Bf4AU/4Z6jOpLyRzZifjVeOWV/P/+k/8LvwHOcrBqoj5IOhosyYxiMe8ZwfxNZhpVpPkdS3iG2b4tKlJVZoOQDc0bf0K8H8Bh36ve6ns+uGcd2z0BeDPPVz5Z9gZTsdJqTw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3221.namprd10.prod.outlook.com (2603:10b6:a03:14f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 19:08:46 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 19:08:46 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: Re: [PATCH v2] NFS: Fix use-after-free in nfs4_init_client()
Thread-Topic: [PATCH v2] NFS: Fix use-after-free in nfs4_init_client()
Thread-Index: AQHXV92kqzRlPk8SFkSO0nQlw+cYsqsBETEAgAAEfoA=
Date:   Wed, 2 Jun 2021 19:08:46 +0000
Message-ID: <F84E7E38-B94A-43E9-9CE2-29D277106BA3@oracle.com>
References: <20210602183120.532206-1-Anna.Schumaker@Netapp.com>
 <ed1b9642f6b26f2174c5fd5b88a629a25225b926.camel@hammerspace.com>
In-Reply-To: <ed1b9642f6b26f2174c5fd5b88a629a25225b926.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60df8bad-9539-4cf1-9b41-08d925f9d8b1
x-ms-traffictypediagnostic: BYAPR10MB3221:
x-microsoft-antispam-prvs: <BYAPR10MB322173D936DEE75C985104F0933D9@BYAPR10MB3221.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G2mzf2PCOj5OY5dvtdSvv4l3oeUSI8Cuh1iIXITD4fT/dcPATag8hyEZv5rPyEPc5oji8UtGzoPQk3GDrV0Z/nB7nTpTT8oDP3oOrWAi9wymFGZ28jJk7ecBoGSbqjKdqWr9qq+TtLYTkgA14mpw5CYwnByG4ipuVZH0VKbbGKmuCdRTpFoHhp1ZZq29aw4F1Z69DDDgh7X5kf9pS6vbEysD0ZonbdnrIWG4yqfLjPWpKTpAQTt/XFD8TOpzQHBBJppE0m59fzWeQz2QRjvmrkWOfWbNsAO+j6XNcaGN+trQezXN6AFMDkwhrT9+KpPXEDQxYj5reoEEcBnJ9LryK465+WimhE10LyRf13fxF3gBRqUXi2u44p03zvMvbtYF0WeqFvCnKRU5tf7Kpr63KHLwQZjipdOvvGFlM3tEnKpajPgCHYpfaIiHA7VOsDiZJBjY1S7gNSFOy1oQZfdQM1K+nQ6qKBA99c31TEe5kqq1j/2oGTzRzZQFwaVFjOMpo1lbBfGVM0MphmIqP3CTngYG/txOTN+BHVWC1U8nFZ7mGWiaVPTHCB8d6xvXeLpVzT50QDNefsTICdLE4b/7EyBgP9nDt/F50WIz6puHXAf19l16IqZZPQnnLkvW70bKOSjyIFjeAIrWwNANsMNBpfF10G2JAK4oAPtzTKWDDiM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(136003)(396003)(376002)(66946007)(76116006)(91956017)(2616005)(54906003)(66476007)(4326008)(66556008)(33656002)(186003)(83380400001)(36756003)(122000001)(38100700002)(316002)(5660300002)(64756008)(26005)(53546011)(6506007)(71200400001)(8676002)(2906002)(66446008)(6486002)(6512007)(86362001)(6916009)(8936002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iZjpctYi94Y9jHZsr+aw4LYEy/C8f8nkjZ0NkXn/QhD8s7H4SYQEYOlgQV0v?=
 =?us-ascii?Q?1HgBa3NGGrkHsjaZy/DAioLNC5S/SmRDAAR4cEgFH/TqfMTGi0ybh6mSZ3zs?=
 =?us-ascii?Q?7vnNx9n7e+FBZO/7wQiBmZDGsPcTWmmwe7nSO9t7lW0+DaMHvKCIdJxofvBO?=
 =?us-ascii?Q?riXAbdmPtTSnwsAK+qMq5aECDTWow6osxwR8tcftttCCSV9fe/b8Y/Tp7M1f?=
 =?us-ascii?Q?vo7YD17sW4aWU4W2ZnCpNfi0xIYqRU1+nFUIdrjwEr6eQ/kR8pQqDzyhKZks?=
 =?us-ascii?Q?vtV5Vup/W0sIUbc6xbNB1fnwhVm1jpQGUkX76EQA/jRwCQo7Vs2GXwRGvC0g?=
 =?us-ascii?Q?TRL/yXfQ0j4SJTW3J4T9FTEuOdaHwKaeJapexTmuroLJ/LX2ixk0WNELUNIm?=
 =?us-ascii?Q?3U8VpQM8w9xg1HzrWNikqXFg/3EKq/hwZickvySKieooJsSYJQQi6miJU2EW?=
 =?us-ascii?Q?ymH0sMsSg5WtwlKHZAopVr/aFe1woE6L+HFezK8l2qAOMzIaPAGd6we5P5xk?=
 =?us-ascii?Q?UkviDv77PnMB1+okVihGosijaBdPFQfVNy3zejUrADJQ9ImhrAJdyo5ez8mD?=
 =?us-ascii?Q?/yE93hZV+vxb/lrlkb3b9jR38lbjmzXAfkwlj0y9thiaFncgs491UnvYeqKA?=
 =?us-ascii?Q?7XesgBWT9j9HD1ztHTKGSOQ5WdjD/k9kzGfvx3L90Zk4XFpYHfQzK0R7O+q4?=
 =?us-ascii?Q?HVyrC/6n4hxNueBXUy3x59EAvCQxajRQCdB/NHOr+0VwtTrOVBlMrwwfBs8J?=
 =?us-ascii?Q?8C3yikSyNQQoHoJ+zApgQJj4k6MJhV18ep1WQ4mkzp/HqoZBTy2EYRXsdetv?=
 =?us-ascii?Q?wTPZhtTg8++HCqIR0qGgMAnNAsTkcMVIp/duWvzegUZOZJa88xv/66AXs2I0?=
 =?us-ascii?Q?CFh5u2aK9FzumIhGUXSg1CZMPwcd3X9PuLa5/UflO62S58dLguoN+qMPrEZB?=
 =?us-ascii?Q?0R4yn40WXa7/OMsGpILzmOtBztplTlmg81Fats0DOM2wtS/VSVsabxDit0BZ?=
 =?us-ascii?Q?3QRD6w/0FxC24u75YRFGztudWCCVy1gtkp9mZgO4s21QJtnTMzXgo3J1rBAp?=
 =?us-ascii?Q?4U0je+oGCA+ILTLBePTD3oZ1/jQMAityWiKshxP1MIwnsqeo2a5jYnJgczxy?=
 =?us-ascii?Q?KDbT8iDcVZKgDgwayP0Q+fyFOigIPnryv2RPTGLT5XzL7eLtufyLfWiMlyYD?=
 =?us-ascii?Q?llfo9uHsRuxbJPpvnDUBBqmPATyxA/MU45/+XpQdO1q5vBqeQaIwYWZphFZ6?=
 =?us-ascii?Q?eOHISTih1+ecMQ7jQOC1jqS9PZpKGwCA4UTjk2/ToUHxH+B4OMnQ+ZxwZ3nG?=
 =?us-ascii?Q?NUQKNBKCMqVE7Jq9pGho6H+N?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15E6FD53716AFB4E89D3220CCD59365B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60df8bad-9539-4cf1-9b41-08d925f9d8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 19:08:46.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDvNglyodVe2lSG4y2sZ8TfjW4fLP5U6+IfoMlNWbj3cuXn5X9SKThAp1U5OvUja4xA8CCFB5izp7kJlWeg3ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3221
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106020122
X-Proofpoint-ORIG-GUID: aHvrl_0lkIPJLrnyoq9qL6M_PU37bwbw
X-Proofpoint-GUID: aHvrl_0lkIPJLrnyoq9qL6M_PU37bwbw
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 2, 2021, at 2:52 PM, Trond Myklebust <trondmy@hammerspace.com> wro=
te:
>=20
> On Wed, 2021-06-02 at 14:31 -0400, schumaker.anna@gmail.com wrote:
>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>=20
>> KASAN reports a use-after-free when attempting to mount two different
>> exports through two different NICs that belong to the same server.
>>=20
>> Olga was able to hit this with kernels starting somewhere between 5.7
>> and 5.10, but I traced the patch that introduced the clear_bit() call
>> to
>> 4.13. So something must have changed in the refcounting of the clp
>> pointer to make this call to nfs_put_client() the very last one.
>>=20
>> Fixes: 8dcbec6d20 ("NFSv41: Handle EXCHID4_FLAG_CONFIRMED_R during
>> NFSv4.1 migration")
>> Cc: stable@vger.kernel.org # 4.13+
>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> ---
>> v2: No changes except adding the fixes tag that I initially forgot
>> ---
>>  fs/nfs/nfs4client.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
>> index 889a9f4c0310..42719384e25f 100644
>> --- a/fs/nfs/nfs4client.c
>> +++ b/fs/nfs/nfs4client.c
>> @@ -435,8 +435,8 @@ struct nfs_client *nfs4_init_client(struct
>> nfs_client *clp,
>>                  */
>>                 nfs_mark_client_ready(clp, -EPERM);
>>         }
>> -       nfs_put_client(clp);
>>         clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
>> +       nfs_put_client(clp);
>=20
> OK. I'm reading this, and it is not making sense to me. Why are we
> changing a flag on an object that is about to be destroyed by the
> nfs_put_client() anyway? Let's go back to the author of commit
> 8dcbec6d20 and ask him.
>=20
> Chuck, is it possible that you were actually intending to clear
> NFS_CS_TSM_POSSIBLE on &old->cl_flags (i.e. on the object that is
> actually returned by the call to nfs4_init_client())?

Yes, that's plausible.


>>         return old;
>> =20
>>  error:
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

--
Chuck Lever



