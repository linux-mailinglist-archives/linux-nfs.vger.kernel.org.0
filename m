Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2243F3A2E6A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhFJOk0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 10:40:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48320 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230434AbhFJOk0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 10:40:26 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15AEae05020219;
        Thu, 10 Jun 2021 14:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iLn1e78sY3qac9qICmsyCiGTTvRdINM4Gb9+R+NdNgA=;
 b=JyjS5PdoOrhnVy12Vb156FHuaUsLhtIq47y9vXTdTJUTBRRleWWLe8WjLP+/s9CKJvD7
 LFerb1MZuhjOOcNwvNvlIp7cV4SlwOOtKxbXPPKFyjyDnHE9NekAXsNsSLw7MLPmTGNU
 63/fo2+JvsQM2K8H/1dgmvBGxQ2KZpgXgeEKqypvwUKqTxfAhGx8bBSCBgtiA+2ELp5a
 +T8jmaUW5uYJD/yAT/jVf6DovrmTtyXoaEemqrdRzzdsFmDwtiNLMebS/ovDEcbR6x8w
 oBvtYtq7RApCnpxv7+N1cnGC3++jMLsqNtBS/i36u8xqXXGhTihC0veJPkpBK6u7foRX vg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3930d50df3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 14:38:25 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15AEcOAS173862;
        Thu, 10 Jun 2021 14:38:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 38yxcwpjad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 14:38:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPcvcGGcTp+gXCr55TbMCjT1epJ7HIKfFp+XWnzdoCE35SDI9J6hSckKynjNRT8dlB48lWSVxUwFNeuPWMUweFbhW/J8eV+Bft15oNd9TzgDT0zMUZ2kd6t6mP2lWEFHWkPInIZJ8G/S3c0WdPH2XP+vsJnRgaNprD8rDP1PkT1xONjErWmK0xG1UyHd759VW+htj75wScSGk7CBQwTkrju8Ah6UfWBJxXIF0xZmpmfxACn5b7o8CWyfUkMcv2nM0oAeHU7EhdFfbfigqbSt/m54hh/IzgyxI6EJJ/KpKOnnQBpXD6Y28F6tvD+ySkglWLcgihRC97dABhqUc15evQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLn1e78sY3qac9qICmsyCiGTTvRdINM4Gb9+R+NdNgA=;
 b=ZXqAfKTPTnEmUQ4RlXp62MvbtVh5ntMJjHLK9rYxzC12ZoLYYze7nFxYLH+7NAOImMBrt4GNk3R8Chjm1Tkn+f7xH9pJMpxQsa8ypp0uDtjktWFtONTq/z/1be/aPvBwwkZAUxujWLTuMMn3P1CZNH/JGiSB/peeEDd6xorsQbDWEjbdHALQ+yeF6aac314Jxw4/MWX8A+pTuZ1VS+fWiDhD2Ub8gayWfbCeCtyGJ19bdg0nqV3DVwixtXenF6HFjyIX8q41dSK4V+tb/FjWGB+0sdrzxvuR84VG1AhJbF7NPXkYhkHYQw0O/nGNBd1DdT8u2TobnO+UX0gNwEe1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLn1e78sY3qac9qICmsyCiGTTvRdINM4Gb9+R+NdNgA=;
 b=omZ2/H3scdNkqtMPuqHezRRpwHJqWFW1vVVOfQHG/FTITyeYC+DAblmoCt/oIy+DOBmIN1nqrDKgMtV+2F05Rdg4+xbeNao+Gx1C0BYm2xg4ttW+OtdRNQ6Av1t4qSZnXs3MPlf6lu7451pUznfGPGvicmw5oBZP7uMR/8hEp3Q=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR1001MB2141.namprd10.prod.outlook.com (2603:10b6:301:35::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Thu, 10 Jun
 2021 14:38:22 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 14:38:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXoN9xSEM+vT7E6aMlyo/90m26sNPoWAgAABLICAAAY6AIAABLWAgAAG8IA=
Date:   Thu, 10 Jun 2021 14:38:22 +0000
Message-ID: <D78ECF52-E70B-46C5-A5E7-BB0BE6ADB059@oracle.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
 <20210609215319.5518-3-olga.kornievskaia@gmail.com>
 <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
 <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
 <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
 <3658c226b43fb190de38c00e5199ccf35ccc4369.camel@hammerspace.com>
In-Reply-To: <3658c226b43fb190de38c00e5199ccf35ccc4369.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 057cab08-3ba7-4eb9-a8ce-08d92c1d65d2
x-ms-traffictypediagnostic: MWHPR1001MB2141:
x-microsoft-antispam-prvs: <MWHPR1001MB2141A621839732493CB1B17993359@MWHPR1001MB2141.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5aJwFqpLbMLC3MwzVE5wLxLaQu8kEd4NA2bcWsnsI5kxP8vUE8W139vOWGrKnOIDLrAFDP0ZXdxzjsG6H6rJTMOfgXVc2zK2FFZnzYl9ZM1Q/rE9MC0cnt66XxdvInIypmdLAkjPM/piMPpBuij/REVGhf5wffzn5ga7FA5sX0rtmahIvfpzpS3ZvA7lM2BtxZlftHnTjfU4hxw8aGKU8o9hw7Fg8InpSk9BwJdedaj5CFl8ADvAq7FQ4upETV5InEcePLFqlVq/KgFm9Rtzp7ab5XxGgRD7Zo/3bHOuVbNQQBh84Xl49+lgHUf8hC62tmYHTNJJnt7Na3HntC2Ocob4fPYtWv7eETRtlITeFccJamaiaHz1ywHYxlDNTCMxZjX+sUBao6nWhSLlCuteuJLvM8iahd6ohg7y1H7LSyBq+AlpmdCqOXV0oEGPELr+e851zDzpR8zFeu6gm6SR2rTBhyT4j7Wiph9Vn3KnQx61aU3bjaDmF9+hhBqXSx6SwJl7KA+zYyzGl2aYFgXFiUT7vI7hToqxCCHfhRf5EI3uVtX8wuEVJ0SvHidDhaqtsOgk/srsfxJtm726YDNOhNOk1d+wSaeoyU0xEaPjUuJjrO8nd9lvZFb4GD+A5KR8zWccpoYAtR0jW4GNUs2TcRpcmlL6ZiiRancbCSjAGQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39860400002)(396003)(6916009)(66446008)(66556008)(64756008)(33656002)(66946007)(6486002)(66476007)(83380400001)(54906003)(478600001)(86362001)(76116006)(26005)(8676002)(316002)(71200400001)(5660300002)(2616005)(2906002)(6512007)(122000001)(6506007)(4326008)(36756003)(38100700002)(53546011)(8936002)(186003)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Pi6UvJy3U0TDL7h3oyHIANQ+fczvtuNcnYGgKQwYIbUr+FM2kOUnm/MrrO8?=
 =?us-ascii?Q?0vqPlgqMdM0W44cuMzzdBjWabJQ0xw6rLIdk/dG5XSXepF5D47gLTYTCbh/V?=
 =?us-ascii?Q?uw59/jlDOK28iAPKu8BRAq0muwARbGhRWQSxRyXATnFvZLRGBgHYEP97Dj6A?=
 =?us-ascii?Q?hFLbu6djeiZp5m26p8A7JFAwHqpmEXzRTx7vBnJbsdDz5t9sFPaWRLyumST9?=
 =?us-ascii?Q?xzOT0cXdyivC0CZogMPrBwAWlRPCCZNMb4PkUGlRiXZjGKWbxrRhxWjrU/70?=
 =?us-ascii?Q?CC/IpDn5tiubor/3cYeZGzXpQAumtaQHi5wTs7b8OdDgfyzKJNPs3qqFDVJt?=
 =?us-ascii?Q?q4RVDBYiG5g09Wox8V/R3Kl3o6O39PDbba7n4WMrQp1PNUB5dCk+SsXa1+PJ?=
 =?us-ascii?Q?vDzY6yjQBBxvml9P/nj+j6ORfzhKDQQH/WS3qvXSqWx+mvbhmp6Va/k1fNth?=
 =?us-ascii?Q?haA72Iso+YB9XqOZ+L7ZDTaKGRbu2aTE6E7/949fnENFhBribnABfHKyy4HV?=
 =?us-ascii?Q?OM5zY1PZ5JlpxaX3xs2U45v2AOF8dkyW1xZQEDY7XbjHeAZrlUg1s/W/qU+T?=
 =?us-ascii?Q?7k70oNOAvnh8QbD3SSRIhhBT3Iq3+CcIAXsKWi6qrAywZtkqw4W/Av3Pbqu2?=
 =?us-ascii?Q?xg8L5sqWjpLhcq0bGg7hveHtjdjcSRnejsPK+lqkkRlgLaG2f6EMCoj23mio?=
 =?us-ascii?Q?Z+xPtqVifcWgft0cpxZIU8YVfOePF7UarBXb6M5ZosGZzINlrBiawJnc0emJ?=
 =?us-ascii?Q?Pw5uDUZIux2ID912xJeaJ8VVdGGanKT6b1pdibbzaNN0hBcgybqQqszCS5Fa?=
 =?us-ascii?Q?cgvN/DFAHOcOQTHUvv65E6RTrMj/IMoG9X37isTyClwqVz9+KFsIdIjf9GaD?=
 =?us-ascii?Q?icrBsE636ik8efjnOiHEsfI0XQP0PnsYcZcfFPXxKrNZBE0mg3nrgPVQ+Ssm?=
 =?us-ascii?Q?vnqQpLfJpgNMKJt/bLMi/ftqRgfrciQDTANpMW+jI7MrqACxAQmnCTV7kc/5?=
 =?us-ascii?Q?71ds6VhjejW8mQaN37dTOnY06SvcEfASS8hYeuuKP3S9baVB0blGjso8AcZO?=
 =?us-ascii?Q?hKmPZ9EjifovCItfAficOXIuSooqX/6D50jQYU6VkdJ3wLOp5hdm41HmWe9y?=
 =?us-ascii?Q?L24izsZjFfKzDaIJ1nN0k4mNS5MonLf36bxI4m1Y3C/X43j8xSQl2DoYE16r?=
 =?us-ascii?Q?rdKZcYegIRGAIE5yrkTxTC7GyUiuKBHkWUKHOFozOK50hHcD6l0g5WPTPWem?=
 =?us-ascii?Q?cGI5dLsG5taPpWG452ldhWctecvLa9LB99Ayhia9qHcbqiwSXFJ9TDy5Q7rw?=
 =?us-ascii?Q?ohFjIPXQYAh555snFeMA16jp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E967D795CF09045BBAA63B1FD04CEC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057cab08-3ba7-4eb9-a8ce-08d92c1d65d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 14:38:22.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZEk16dA/T9pdjPdBSqsVp6ATfBimutwh0GpSdvLGlgOdBzwDDEYUa5gM1cJ8V/VRTTDDgH9/p+bi/iPJ/1Yaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100094
X-Proofpoint-ORIG-GUID: z_-0Z5TYCZxMu6KlIvR9uMVQw23NjSjd
X-Proofpoint-GUID: z_-0Z5TYCZxMu6KlIvR9uMVQw23NjSjd
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 10, 2021, at 10:13 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Thu, 2021-06-10 at 13:56 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jun 10, 2021, at 9:34 AM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> On Thu, 2021-06-10 at 13:30 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Jun 9, 2021, at 5:53 PM, Olga Kornievskaia <=20
>>>>> olga.kornievskaia@gmail.com> wrote:
>>>>>=20
>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>=20
>>>>> This option will control up to how many xprts can the client
>>>>> establish to the server. This patch parses the value and sets
>>>>> up structures that keep track of max_connect.
>>>>>=20
>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>> ---
>>>>> fs/nfs/client.c           |  1 +
>>>>> fs/nfs/fs_context.c       |  8 ++++++++
>>>>> fs/nfs/internal.h         |  2 ++
>>>>> fs/nfs/nfs4client.c       | 12 ++++++++++--
>>>>> fs/nfs/super.c            |  2 ++
>>>>> include/linux/nfs_fs_sb.h |  1 +
>>>>> 6 files changed, 24 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>>>>> index 330f65727c45..486dec59972b 100644
>>>>> --- a/fs/nfs/client.c
>>>>> +++ b/fs/nfs/client.c
>>>>> @@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const
>>>>> struct nfs_client_initdata *cl_init)
>>>>>=20
>>>>>         clp->cl_proto =3D cl_init->proto;
>>>>>         clp->cl_nconnect =3D cl_init->nconnect;
>>>>> +       clp->cl_max_connect =3D cl_init->max_connect ? cl_init-
>>>>>> max_connect : 1;
>>>>=20
>>>> So, 1 is the default setting, meaning the "add another transport"
>>>> facility is disabled by default. Would it be less surprising for
>>>> an admin to allow some extra connections by default?
>>>>=20
>>>>=20
>>>>>         clp->cl_net =3D get_net(cl_init->net);
>>>>>=20
>>>>>         clp->cl_principal =3D "*";
>>>>> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
>>>>> index d95c9a39bc70..cfbff7098f8e 100644
>>>>> --- a/fs/nfs/fs_context.c
>>>>> +++ b/fs/nfs/fs_context.c
>>>>> @@ -29,6 +29,7 @@
>>>>> #endif
>>>>>=20
>>>>> #define NFS_MAX_CONNECTIONS 16
>>>>> +#define NFS_MAX_TRANSPORTS 128
>>>>=20
>>>> This maximum seems excessive... again, there are diminishing
>>>> returns to adding more connections to the same server. what's
>>>> wrong with re-using NFS_MAX_CONNECTIONS for the maximum?
>>>>=20
>>>> As always, I'm a little queasy about adding yet another mount
>>>> option. Are there real use cases where a whole-client setting
>>>> (like a sysfs attribute) would be inadequate? Is there a way
>>>> the client could figure out a reasonable maximum without a
>>>> human intervention, say, by counting the number of NICs on
>>>> the system?
>>>=20
>>> Oh, hell no! We're not tying anything to the number of NICs...
>>=20
>> That's a bit of an over-reaction. :-) A little more explanation
>> would be welcome. I mean, don't you expect someone to ask "How
>> do I pick a good value?" and someone might reasonably answer
>> "Well, start with the number of NICs on your client times 3" or
>> something like that.
>>=20
>> IMO we're about to add another admin setting without understanding
>> how it will be used, how to select a good maximum value, or even
>> whether this maximum needs to be adjustable. In a previous e-mail
>> Olga has already demonstrated that it will be difficult to explain
>> how to use this setting with nconnect=3D.
>>=20
>> Thus I would favor a (moderate) soldered-in maximum to start with,
>> and then as real world use cases arise, consider adding a tuning
>> mechanism based on actual requirements.
>=20
> It's not an overreaction.

The "Oh, hell no!" was an overreaction. But thank you for providing
the additional explanation, that helped me understand your position.
I agree that the number of local NICs is frequently unrelated to
the topology of the whole network.


> It's insane to think that counting NICs gives
> you any notion whatsoever about the network topology and connectivity
> between the client and server. It doesn't even tell you how many of
> those NICs might potentially be available to your application.
>=20
> We're not doing any automation based on that kind of layering
> violation.

Fair enough.


--
Chuck Lever



