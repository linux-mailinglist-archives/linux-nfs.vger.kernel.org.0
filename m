Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B283A4C79F5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiB1UQK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiB1UQD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:16:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8313D4AA
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:15:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SIJ4HM018798;
        Mon, 28 Feb 2022 20:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WU6Od0457po7EXy/nzLnrn8Wnnpo4bay8PxN4SpF2x0=;
 b=KwlctcHn7LynHBVjD8eKUR9vlDMyzKc4B+V3B2EXNazSSIlzG9agdU0V9Ay420WoxcWR
 E9zvQ7vL9+8f0CnBP4ZdHN18Bd3JKWWq4ULSeCyUJUSw3+ovxqrHjv+v0+t9uBid7Np3
 HU9IH+lC+I2Exlt3z/BpRHqrbJ5N/nENtz6NkfzaTSKF7S3jzUg3wU9VHhASU9bmVoCl
 +LumKApW60QzK0+cJYSYCqFRExP2sI7btsn66msoMfCKUt805gVk2sMQrBhtLeYD7wUB
 kRMP6yv3TzH+FgHZ8kzMlvR5vfmgltozmHNJKnCdrd/gRuN3nSPw4uY9StW73uaxDqt4 Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttddff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 20:15:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SJunJV099554;
        Mon, 28 Feb 2022 20:15:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 3efc13epx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 20:15:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1aptaw0D15ysvZovBoK/Xzau+0ZCaRp4ArlO1B1bQQUl6c9ADVSVx9NIeD7uetpu+ZL2CzDjsAug1gYGfnmSaB92PEljz9j9Mb76m7BMCWhMJ0q9W7VKv9gGj5k2D7m2Vb9rNUxZRS/OVDKXMO5rwVzvH6bWABR91mReWXHuVdHgTqxTYrCGOmNiju9Bd3jLFw9x4jgwSBatrBxndyOfyiqByK4z0YQiTwy1JvJ9wCcTP6gNcXMxKxuHb8IWQ1Mby2XtB+IrH7hRGwEHoauhOzgv0PZR8nLUNeM/Kb/HyvtLzaldZrq4Dr9R72x9D0XL4CkN0RS3NNXrbuvZFL0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU6Od0457po7EXy/nzLnrn8Wnnpo4bay8PxN4SpF2x0=;
 b=aI/klURrZofu3NUnXPbsR1kzhxoE7E/zpo+NKz9kYZkxMNU0KQ9pZmXZm3fRoh2RSmvNg/zDHVVm3N0xF/KswNyArb7E6oE56S+8vFYNeV8pcb6Y/9yWK+iYD1cX/B/aC8be0K8c4/Zz7EzvOmlHUuXBvBeFrmEol3MvF4MlB4Pi5Ihgo38nVjtZQFxrhrkNWbUr4acsr8+cTjymS6iYDWoSxPGeDVOM5c17OhxAUXUV7qmL5cEp/MSoUhSxU3mY+sdttZaqE1mFhFERF2wYT2EphFuW7eFyKD0u3AeWvIeuTZXntFKm/RVdexWwXV/yYbi+3XMl9FoHNzu+XrL0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU6Od0457po7EXy/nzLnrn8Wnnpo4bay8PxN4SpF2x0=;
 b=BN08JTZeKdgfX1s6s0kf5/fiFBLbtCv27/5A8+XLK9wtZ6yA0QVVUTa50eMaGC8ZqA1DzLMZ03khYPxu1VmZAHkxHag2osnzag/6vafbrdzXnQ+bAb8dIhUE2y9bVoHTtWPah5maydmQjwQxTcY1QyhjwbMw6gzYeXO4lj8uxTA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3802.namprd10.prod.outlook.com (2603:10b6:5:1f9::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 20:15:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 20:15:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Topic: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Index: AQHYI1yJP7y4xU9Y+kaLua2/7R9GAqyXsraAgBGBCwCAABW4AIAAG9GAgAARbYCAAAJVAA==
Date:   Mon, 28 Feb 2022 20:15:11 +0000
Message-ID: <5DB9D3E8-2687-4945-9542-C0ECC58C509A@oracle.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
 <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
 <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
 <73b61ba083df0a8954979fed11d6398d336ee1d1.camel@hammerspace.com>
 <F853D68C-C066-470E-BCFC-988C3D46ABA8@oracle.com>
 <01c6aeddf91d0e68d7c497456ea96f4f24145059.camel@hammerspace.com>
In-Reply-To: <01c6aeddf91d0e68d7c497456ea96f4f24145059.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d52989bf-bc04-4f96-6494-08d9faf70626
x-ms-traffictypediagnostic: DM6PR10MB3802:EE_
x-microsoft-antispam-prvs: <DM6PR10MB38022707D7E6423B9A91746393019@DM6PR10MB3802.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WzNfWzZFdHHNmL8Luei8wtVxjjniygQtmhMTZ6ZvVlr/F2gKgmb5LVLYamG2cZSEHHkEdnHmSzP7rTG8nKCt9fw1UVzmJD9HCBlI7dtzCGlcCOBEa8Q61CU+GLOtGpkNS/bgdFj9iSGTP2SVL9mPoTJb8OHmbLDWYWpJobeVNJN8RnER6f6T24R3a3juf15HoEoQz4Kvzubc72n3KZIEJcpD5NadLurnARuqa6ynKyLXAXXYmGb4cy6znAC8USJyJ8a+k9Ye3t+HU33ouy+fr/P2A5BM09AOHTAqAne+GzCfUtj2GzoKeysUTq4v3ZGTnE2JglZN7ao7/N2i/VBno1R+nOVDtqhUnUNpXUS7FJRInwiuUW0S7iw31tHcmAYmETyoQ7iBq5jq7j4L8msTe1Llx1/ViFFnvav7t5fkJKs4UVmKwMMXtqCSRoOV4NgNUeDuvT/C3Rh/QYwe2nLZVpcDQJng2ZWK1KhbizcUXEOY5KXwaXNwgarw9lF0Q2v/dLivpiYczsMrHTRYXRqZ5OD4/0JPHWRk4mYksqQi8Y7INRHBHBrDWb6ZUBuQtp9ujv7YZWw9rrisZBIJOYaS1ipqQaJY7tFsiQDjREVyMzZYLJ9X7GLa7mUs5ec7eJkUApHs6CAP5e1xWOwlfrZ5oEEHCdcW1590YHcQvoUuM1yc5OpBTOdpqMFGLKMdMtZlp0J7HLbk05CBI3CeAmujQO5lfLEP7ySv9PlSQdUE+5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(2906002)(38100700002)(38070700005)(186003)(26005)(6486002)(508600001)(5660300002)(54906003)(6916009)(316002)(71200400001)(66556008)(8676002)(4326008)(86362001)(64756008)(66476007)(66446008)(83380400001)(8936002)(6506007)(53546011)(66946007)(33656002)(122000001)(36756003)(91956017)(6512007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hnmeYfVmyb1mDWPvisprf0QH4z/vku8eMCVNhCYsg4PGOqtVzGQk2Md97bcc?=
 =?us-ascii?Q?0JQIWF8hKseuAzY2NEwmWc3nzQ63a9NpNZGCyT1px9P9JNvcOVCrQpxfLbMM?=
 =?us-ascii?Q?RcOihf87qkXAuGy9NymK/BNvLlM5R1fTFVvTQ6zwTqsMGaV7lm9QIwkLaCg6?=
 =?us-ascii?Q?Ivv/dNmNJb2TTuqTa/7QCd55l5/++MP7Dy29HcnTK8491pFHYPj5z6PYZ7QQ?=
 =?us-ascii?Q?u5kHcyH6tAIGInfTHU+Uig0jjgQffy1fqxNFrBSiQCJJSfagQSh7m6oLFH3u?=
 =?us-ascii?Q?gI8NX2oHscLf3Etm9XvTD2AafA7yLaEQjyXyjoeSQeIN4tTR4B5d2H3Gptws?=
 =?us-ascii?Q?TenKsIbC+P0ZPp+R9W3b3BFdvU2vhwfQfFOUhUFGpfBonuV6lfiADVFBeT95?=
 =?us-ascii?Q?kWx5IFXwr51VLR1X8fDsIqLja8xwcr+U/evPmuno7fFwYtT2kLIlkMXBCgez?=
 =?us-ascii?Q?77tKSSKGYI8yyIwal8An9PLF8Sm1HnVpulU1AMjcAd+41vrcndu2MQyIMN32?=
 =?us-ascii?Q?WfxKXMGgV9AoGsGqs6Du5Jz3XdtCbsWeGHEI6lOw4ZKntU3stAifFKkGewT+?=
 =?us-ascii?Q?5ANtFWlho5qSAHA8VFezP9WYSSGLuWNL4WUUNMzeOgnavNFdQZ7iTwBCKlgS?=
 =?us-ascii?Q?BNACwoqQ7JwQyRanuK1E91hNR4f+3gsFKONvYHIPKcoZK9mmrq9rGgLtlJP7?=
 =?us-ascii?Q?H9ZwjLdqQDQ8uqLPsf6to0q1Mg+UmYEnEmvpwD5962mDYcL1CP/P3Cj0rWaw?=
 =?us-ascii?Q?XecQ++kR2mCzODuPb9bDq5wZkT9nazP1bWG6ZqW84ICzSUGtRvZPqqo+Ec4h?=
 =?us-ascii?Q?Gqh7sI+ZHrT+f8/eea4hm5Dl2UG2rS198jvyouzKhrFthEWzR+/AckJb+yXW?=
 =?us-ascii?Q?zLX12/d3TkoTcQtOR8WMOAVrzQY28JYwXCk8iLPZqXurQCLUsYzLVMyuOoA8?=
 =?us-ascii?Q?NdT1f52r/BKAC4xZBNDoAysQ2WEAPVd9S+VpLV3u5WCWeaxlCcIxtDUkVpVo?=
 =?us-ascii?Q?Hwy8viAs1qDBQvm0pMTRHQz+PveCaeP0ctaw4WHgymWDXnoxZZwGZOfSI1mt?=
 =?us-ascii?Q?v5wcAvb5SlUhIStYCpr7qEbtMBgmRub8XnswjuB+arlQUkKBfsd33EbAks1F?=
 =?us-ascii?Q?vK+ws8yoRJ+9s4v6YN8y4EYSFCGgm9bpCjl5pJZtqZ01MKw8nw/cMjxL7G3w?=
 =?us-ascii?Q?rqk2PfXQ+NsXuyS9/dueHq+Yy/wULG9whKmiju3LzVp2ySzHvaDGYJnnEC6G?=
 =?us-ascii?Q?Vfv2Ogsxltnmhj2hoElv7lVHj3bVAaWDPo2kjqNmn0/UPKBATRDGAybhv2hd?=
 =?us-ascii?Q?veB7O8Ky4aGXCgUWXXQ/qaEBEaZgpI+PkZM4l/HPtCWn+F8dLJOhjTrHq5WZ?=
 =?us-ascii?Q?uzsst5RQijFchzRgsX2Up0aBIc/phF8tmDWvIl3VfNU0jdUXs4D3aNs8p2/1?=
 =?us-ascii?Q?Qnfr/iZjlCD2RpEFx/68nnP45tSBkoazbVaHU5oUcdwHeQnIeHyWCyI0U5uy?=
 =?us-ascii?Q?1nS5KGcpdCWOOvbqHmL3TtBuudSb4cA7+PVnv/PTN5JGVPyizyGcPXthMDx9?=
 =?us-ascii?Q?wpMkQgY3yKWozEeurTBQG6povn+AeJov/vxXvL0zEzQBqZcjmz9ikiD3qYWE?=
 =?us-ascii?Q?eIK8pJkR1tOOmqCsgh84v+I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <396D48C49A54DB41B4446F36B4510084@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52989bf-bc04-4f96-6494-08d9faf70626
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 20:15:11.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tou7nbDlvKRpGrAauhqcOOX26xhhcQb4IfmcltC3KL10BrliNEkN5vC9lJThW50ttZtYeOjP2UP3iagOP3ANlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3802
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280098
X-Proofpoint-GUID: IwT6DVzkXymdTc_zYNkUUpYGOB5valCC
X-Proofpoint-ORIG-GUID: IwT6DVzkXymdTc_zYNkUUpYGOB5valCC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 28, 2022, at 3:06 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-02-28 at 19:04 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Feb 28, 2022, at 12:24 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>>> Attempts to work toward solutions in this area seem to be
>>>> ignored,
>>>> the
>>>> questions still stand.  Until we can sort out and agree on a
>>>> direction,
>>>> self-NACK to this patch.
>>>=20
>>> A new mount option doesn't solve any problems that we can't solve
>>> with
>>> the existing framework.
>>=20
>> I don't think a mount option was proposed. Rather, the mechanics
>> of the udev rule would be done by mount.nfs without any changes
>> to the administrative interface.
>>=20
>=20
> That's not how I read this proposal:
>=20
>> Do you still want us to keep this approach, or will you accept a
> mount
>> option as:
>> - first mount in a namespace sets the identifier
>> - subsequent mounts with conflicting identifiers return an error
>=20
>=20
> Which is why I responded as I did.

Ah! Well, I read "mount option" as "mount alternative", I guess
I was filling in some context from previous dialog on the topic.

I agree with you that an actual mount option -- that is, a new
administrative interface -- is not desirable or necessary.

But I assert that having mount.nfs take care of initializing the
uniquifier for the net namespace is convenient, and can be done
automatically and reliably.

--
Chuck Lever



