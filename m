Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185F558186C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiGZRfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGZRfA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 13:35:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3281C938
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 10:34:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QHYVax023758;
        Tue, 26 Jul 2022 17:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MpZgd7TNV+K5KdR/mGYf1Ph1IKZnrBdu1jT6NWFaocc=;
 b=Bxz2Ha0AHa1wvVxB2HKZOkpgEYSeF5JZ7fBsehCHW9ElfM5JvF0+tXOE/zCbodOiktkH
 ZdO30Xtj2I6UX7zomT4ZHmRwt7QDB31HMmPPhC6kbpUnFdMxkXVK/6uhF3mrJFFJ1yyD
 B8ueLZMFzqON+TpNWK8KWXVZI6DsVixyJl6MmeBRy8W5jeaf6pLMp1Z7kNK+CWLNUMmk
 hyptjUqQefaTk0khezc1t4mm3lMuaE6+BdlKEynuT/qvzhSA8LaWVE5GOmPOScesFf9D
 lz7du3l6MAyYC9cPBpSw6GUaAYMvpY82y1qzEIp6+2kkwZMPSyT93O9nkZRYodvz4PFB lQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9f86u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 17:34:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QG3jRq034496;
        Tue, 26 Jul 2022 17:34:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh6334yq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 17:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5p12tpmHjLZsEusq2YfhHUMyPcTt10pgEDfy61X5dRIZb5JWJ3B3PrNtfiA8ywNjRV0j7G3obOJ7acz/1A3YEx8Pr0d6WxR1RbHErYTPKj6q/nIFqHvF7kb0g+LDv2ytON2E5MC3geNbHLpPbq2yeXrd7xS7/kTQTNOO0KGuBptBK0ryU6ilEEB5a33WHuzhDlkHk7317saJJ4bZGsofV0LWCZ8a+ax3nSnH2ehKrhWdXGJ0sZx4lFQ+EE3tc2ekAQ12AYZRyudcddpQT3NXY+pA7MIOwaHOjsNV+XbhlW/c+CbwfNaOhO3szv696whonoKEEEqAA83CyjDUFOjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpZgd7TNV+K5KdR/mGYf1Ph1IKZnrBdu1jT6NWFaocc=;
 b=HvWmhBOyxNsY8RnUP+1MmUu+3WgKdv8LfwoNZliK6OtOWlMS7ZBAKgp6/ZR6+GgEF8zbQWK9S5vi+GKCzNku8B6KqME9HCiuwDb+GBn9lD64BhjniYyP5fMPEN8/7c8iwCkSkS/FWO8wOjUBEgv1gxaJxUS/OaTGI9NgXgzK4wbtueMg+3yvvvL9btT2VzFOurq3+ktLmNxyeUs/+WHDRdeiH1KHDXNaSvZHxo0LEdrzAIt1UAWnUcWmoEnEdCh5WaQprAiJRjIahH5mXXa6nsRO3KL/jofijEjYFY0a4cQyf3ajhnjuxJUL5vmUD7HdSr7JgxC0tjJHshazh6Bliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpZgd7TNV+K5KdR/mGYf1Ph1IKZnrBdu1jT6NWFaocc=;
 b=moCPPktENdCJUDxIpneNZxpk2jDB4kWjKitB1J6YkiFK8SAfArAi7FhxelvEmXUCErsoO0ItqCG+47gXGc4I6q/xsfnUxVk7tuWk7Pscj59V22Obaz2JDbBHyT9fTj7kRxarW8luUTofHPx298+j5zEL9j9HcpGAPTxvm4RWT18=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 17:34:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 17:34:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jan Kasiak <j.kasiak@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NLM 4 Infinite Loop Bug
Thread-Topic: NLM 4 Infinite Loop Bug
Thread-Index: AQHYnGkqEuWV8f5/AECQUMNmZwRFWa2Hrj0AgAk/5QCAAAUVgA==
Date:   Tue, 26 Jul 2022 17:34:55 +0000
Message-ID: <14F384C7-1900-408F-9289-05173A8C1BC1@oracle.com>
References: <CAD15GZd=sxsXiNmuN-FpRk3E_cKRF_CTLqxd5XJ4KhtON4XkPQ@mail.gmail.com>
 <CAD15GZe1__nJ6SfAr1zs4Vq4za9D=FP__SotyS37RVh=2OWu-g@mail.gmail.com>
 <CAD15GZdCYTr0Xfn1-n-aXf5FxLDR-zrYR2TutHk_4RRbP6+pVA@mail.gmail.com>
In-Reply-To: <CAD15GZdCYTr0Xfn1-n-aXf5FxLDR-zrYR2TutHk_4RRbP6+pVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d12885eb-7522-4d5a-5713-08da6f2d27a9
x-ms-traffictypediagnostic: BN0PR10MB5031:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+RxluP89z43+mfkj0FXpT6fJBKHaxgUuKHwdSLksue1iZQx63/SzvMMkK6j0M72b7tPUE1KZKxH99f+DdZy2K21gIg76wJTa+lhjWQaJYbphjox4dypeJNT0leASs+PTYJrzWVynd3yc0AmqHWtxgEqItA+BRqHehTcRQcw2FNFsd0V8o3iUu5mz910asgmZ/8qCN22Agx5uNPIYLMkdJOW98H2TdXW4NzUkX/R87FFirHnZXGNcEkqJ11Of9EfarJO6B7i0p4GHOmaE2y0+piqqDYWilzkI4gazKwUlVbvEJrSxD1uGTQRkQOAK6aahF7YvBP/+Gz5XkqEC7wJR2A2XGXTT/9F+7FK56BKt63o0PfIN/zSbVcy6ygq+ZNRtx/eP5JW24OR/jpA4mz2vV6GcZyzi9GWUSK9fjQCeeZnc6C6mBZrKWdZg5jXFpomudVS4zi1ckjMwYsKzcw+CLrZLtzYLj/8olGuafLWcTIsp4aCpqFdP6Vql1r3iZoTv8RyBJOqMG4XCLJv4AqlEiRYrzMpfvdRCS65xZZ8HrJuTbA2wfIl+iUSbLHBQNrBAaMa2eFobZoqJq8KCO4YldOhcluiqGZW17V+5EbFZ/tI6fyINSTTj/i5dade0tUd7XyVtwqKhbDR7Eug2Jn0EX2l4kgHIJ+QHS1sQpn5uVsWNKRlkIl0OTbFlEhUohxiob5g7YfG45rMyBgujL33zCmEAeHMGHECxdek4nJe4DcopwEICeSWBOP5ZeG0yhmlHZO6zlJXe9IN4eKxfdsfUzDCrLsCDQHXFXyDPcmJ1qeM1hy88Mqn4Ggi8dZ+BaMYR6rbDmjtAQDLxPpG0S5gUuwy6J48pMGCe+9elB14oXiMN5NP53PwEPs8JjxaP/CM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(396003)(136003)(376002)(41300700001)(122000001)(38100700002)(6916009)(36756003)(38070700005)(2616005)(86362001)(83380400001)(186003)(2906002)(316002)(6506007)(6486002)(966005)(91956017)(66556008)(8676002)(66446008)(53546011)(64756008)(76116006)(66946007)(66476007)(4326008)(71200400001)(478600001)(5660300002)(33656002)(8936002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u3oighyaKnuy7VXBLfYll5li7xeJpiHV2vBKhy8BNtaFzfY+VaBgQ3Qwn5Dd?=
 =?us-ascii?Q?w0eBDrwcJS7g06hc0zXIVVaSkvs5EhPw3Ubi2zbW59414VN0jre6/z+q0MxF?=
 =?us-ascii?Q?lZH+WzfxD1ctu8V9s52X4sOcCu3OPM51D92eGE5DLhD3+52+GK8P4DAEOzKm?=
 =?us-ascii?Q?te5hUO77kCm5An8NkW3cLU/tgYqmoz0yADHOqmUhL5xeXgBtUNIGIfafSZvq?=
 =?us-ascii?Q?AtH9iqdGn5EL9+vDRg/sRwNiu14o8jlHc0GAaDvVxkw93tQ5zamvyg2jUPey?=
 =?us-ascii?Q?uP5ua6jWBS0p3XJe2bvR2iplx+6nii9HteJiPtmDXWIQ0hpm25C0+4Wx3lc2?=
 =?us-ascii?Q?GxH4hTlzdNpkt1mWdG6Z9qYoqWheYgPgIh11Q0J19O6XkfnliKUBF6dKiG4F?=
 =?us-ascii?Q?xG2jQcfslpuKNC3EQ0+bTkDNCnH36YWDy15oszb9fghZ7Fu8YRrwMoYSqJcS?=
 =?us-ascii?Q?yXYiB3tfq5+5GUGUoOO8yx3PK9FcS4qjoOzjDTyLt7pKeAZEF9BYgLkxkPp5?=
 =?us-ascii?Q?WlLFuIblx8iGGBiIUHpz9ceF+7Hvjb4hQFqC3HKSOh3xmfcSJTzAcCotnAjg?=
 =?us-ascii?Q?BilRTc1ysIGqo+ouZkN83dOJ5VBhB98tJO4988WAQky6vtd1WYkNtTTTKEg6?=
 =?us-ascii?Q?Uw/NuOlbxMfddkvQVfA8AYyHZ1BDnQTp+stH+MDOuYTRhugIxKr25GA6iD2Z?=
 =?us-ascii?Q?vC/UGTmHv/Pe6ISGsIGHTG+i9NhqomTqUdHkCmRiAQzop+HdFe4UMcGdx61Z?=
 =?us-ascii?Q?qF4yI2Q7oBwDLkVJzBf5q8TICkth+HRQvQ+hZOg/8MPAS6WXaD248V68jjUe?=
 =?us-ascii?Q?yN5glwqBsnJhIQHHpvQkaH0KJuYggC7QmlC71AaGOFxrquFbcXBQS/GuGm+T?=
 =?us-ascii?Q?dslSaJVG6tlczUqpZLMCDQB72OjrWzwKsVkgyayrfYWbzujTPgFbRlHjiV9q?=
 =?us-ascii?Q?uWxMTUSOZGlyrY++8XfHKDTLQER1JJLSXgtqiCAasOsKBqGhzLgPPfsg/6Cf?=
 =?us-ascii?Q?bKvHWKAr199FMkrrh/b/BxI0SLHKINhFN6rsE8bIl32NNau0t6o7en9JKV/I?=
 =?us-ascii?Q?9KmmyII5wYR4bCI/HGyx0Foroa87AqLNkXssnCtUZdOLtum5ZBqGmpBhHoqU?=
 =?us-ascii?Q?9rNQs5gCSOykLR++M8aoQWICP3LQ8QKAzIDkb9KwQR7+SINyNac7ujQJbBX9?=
 =?us-ascii?Q?2rgtQMlUnNo9qQHcVQHtfK8He+5huPy0UnJ0Dpaj9+oT0u3Mm7pKaYiISB05?=
 =?us-ascii?Q?W/aUWELNZYoeJgUj5SoIHAR2ffbGmC39kWU2VJtUzbcYa0oDLJkwP+aOaF4b?=
 =?us-ascii?Q?M5OOeet1Y0mdglGbUi7AdtVN4HMObU7yv1tnY6Jr1oM6w1TVdLSGOaXXvzeo?=
 =?us-ascii?Q?KzvOz49uPU3f6d8OYbP6NjDOPTWTdkseVa/RyDl1uP5VrEqdLP3b3P0/n031?=
 =?us-ascii?Q?YcaehB83eFY+/Lr+u31XEJrtUP9IGSgK4+IK/Kcfluf+KUCVwINRimU8TeU2?=
 =?us-ascii?Q?Zw8tORxQFYDDYqWhOhbGj82ZjytPfT7WCIRQ4oIr3K3sISlAek3jA8i1InOi?=
 =?us-ascii?Q?sb9JVKgdQUm1+i5ImMMZNvMotJcb09XEzYOALVz6sxjgxp5PDdgYbC12VA/i?=
 =?us-ascii?Q?Is/Qt4cHbogFG/i7CJKGN5P3/8sxnOzoreYR/bwu85TJicJuCIT6xJ68vgsx?=
 =?us-ascii?Q?SErFjw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E9C711637DC5D43B85C710E909E25B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12885eb-7522-4d5a-5713-08da6f2d27a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 17:34:55.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K357D7En0olAv5kuZ69EUWL3wOHoQ7Ra9lxT75Dk2gz7qCB6N3klev2P+xI0buicA6eilkpqlyBBEyygnyM5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260068
X-Proofpoint-GUID: 7Jn86KIf93gsarPG7cMsX1mS6DXJf1kM
X-Proofpoint-ORIG-GUID: 7Jn86KIf93gsarPG7cMsX1mS6DXJf1kM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Jan-

> On Jul 26, 2022, at 1:16 PM, Jan Kasiak <j.kasiak@gmail.com> wrote:
>=20
> Hi all,
>=20
> Even after applying the above two patches, I have discovered a new set
> of NLM 4 requests that break lockd.
>=20
> Unfortunately, I don't have enough experience to suggest a fix, but
> would be glad to test anyone's attempt.
>=20
> All requests are non-blocking.
>=20
> Scenario A
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> lock(offset=3DUINT64_MAX, len=3D100) - GRANTED
> free_all() - never finishes and lockd thread is stuck busy looping
>=20
> Scenario B
> =3D=3D=3D=3D=3D=3D=3D=3D
> lock(svid=3D1, offset=3DUINT64_MAX, len=3D100) - GRANTED
>=20
> test(svid=3D2, offset=3DUINT64_MAX, len=3D50) - DENIED
> correct, holder offset, len are (UINT64_MAX, 100)
>=20
> test(svid=3D2, offset=3D75, len=3D10) - DENIED
> wrong, because holder (offset, len) are wrong (UINT64_MAX, 100),
> because the above
> lock overflows during comparison to (49, 50)
>=20
> Scenario C
> =3D=3D=3D=3D=3D=3D=3D=3D
> lock(svid=3D1, offset=3DUINT64_MAX, len=3D100) - GRANTED
>=20
> test(svid=3D2, offset=3DUINT64_MAX, len=3D50) - DENIED
> correct, holder offset, len are (UINT64_MAX, 100)
>=20
> unlock(svid=3D1, offset=3DUINT64_MAX, len=3D50) - GRANTED
> weird, because it has now created a lock at (offset=3DUINT64_MAX + 50, le=
n=3D50)
> not sure what the correct behavior should be here - FBIG error?
>=20
> test(svid=3D2, offset=3D75, len=3D10) - DENIED
> wrong, because holder offset, len are wrong (49, 50), because the above
> unlock has overflowed the offset

Thanks for testing.

May I ask that you file these as three separate bugs here:

https://bugzilla.linux-nfs.org/



--
Chuck Lever



