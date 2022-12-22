Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4A653B49
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 05:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiLVE2Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Dec 2022 23:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLVE2Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Dec 2022 23:28:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C42C1;
        Wed, 21 Dec 2022 20:28:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM0xCj1012924;
        Thu, 22 Dec 2022 04:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NNQKihCudOUIhYR491gCeNyLrHlBg+oTrUCBKiPeFfw=;
 b=DCIAjlrfQtuPs9ekeojjchMnRaV7QlSIiNCLmqSz9vBLS+ai8eV4axkRiczqy045v5bu
 iAZ48FEw2Y3jSwme9H3WKTK1mo84VoEUqm2HCpgy+yDlpo7UQ4D9S15UzVgCjhFRaz/a
 G6NhYu90IUbr35epRrd7EGZGoPsRfUWzy6BNQS0xRHz0aP7H3cXhqU/9AUevEd2KohkH
 gLqgEiVubsj8rSX8rw9qz5clEXSg9cFIl6azwp7PO0dLMAAwHAjYQb5I7IKA1U8Z3L/J
 IDUhLb1i0Nj4iKy+ZhgTDF6dBhiysahqmd0J/GxU1ZtSwb3Ld5MbFs6FRDStxc8SNmt2 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmaect-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 04:28:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BM2dDIl009720;
        Thu, 22 Dec 2022 04:28:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47du724-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 04:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqMU2bY154jiTu32ARU+oY/CZ5EuAgR2ESfEDiTB668LseMhKRECyXCK9JvrgvjI2um1O4TjeQdwosUnBV53wUgqOvnljbXX5BSPCW3YGFwARR/12g/sTU+4TvSHlb5gn6i6G0KMKvb3vX68Cpbg+q5ftIIt1X0pxrwx4aeEfb56Bl7XKAdjxYP59Aj4VTMzg3jD1g1tzWsO0lZMIlkdKeQf6GqaBtUf4pZWxnZlpHahO4HeHyclLshWpo+FX1EzcLRusK/0+VObFgL4evpN1S6OLsSJnvAJL2GRx4EJ0XYhU6+VtA/mbwsVfRMGWIurkwW/Pf77OeDhu3jSfH1N4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNQKihCudOUIhYR491gCeNyLrHlBg+oTrUCBKiPeFfw=;
 b=mU3t7ZHJNizR3wVVgydDrkg0BS6nqZXxk+d3ZkrvGMyZjnzIxATi2vWSNXV8NLnntLwjX+S+H5r5g0oI3Cy7AI5thuL6T6yQ093wlJO7GG5SG/bYRcCDzDxqa79Ccg174cQhBUfBmgpeiSoLF/Fcpmz2XN7fPjAFM/RQ6T8z0/Tqik5OwFLo8FicnrdvOgmv1K7/s2p7uYdI07VaXCcz98WW6vXX6IAIKutxbY6SoJp4gyCoNlbd3cBQ1f/fufDyDn9nJoW8y0Mq5f1Q6CBD2rv0cSlktSfxoEOWkReJyRTS9Vjs2GtwWLXd+1tFaex+6LHku8g9VmdXad+QTLN6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNQKihCudOUIhYR491gCeNyLrHlBg+oTrUCBKiPeFfw=;
 b=r8UQ+BLYR59WF9lXTvdCy1U2ZQmSG5vgTzkG1+oR/i7CP5aC5taijPtbrjVFKIyJDAMB5UcOXjOY+DJvfuTL7FlyEe3VqlstzZRwYGNkYKuLarbJwAah+AKDnNil//ACHd+iq0FgBjlWzVRt7nnjgBggRCP2ko4Ut30hQ2pujfw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6072.namprd10.prod.outlook.com (2603:10b6:930:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 04:28:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 04:28:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
Thread-Topic: regression: nfs mount (even idle) eventually hangs server
Thread-Index: AQHZFSMVb1dlHuUkzEyQB2fRdyO/kK55RIoAgAAJEgCAAAO9AA==
Date:   Thu, 22 Dec 2022 04:28:17 +0000
Message-ID: <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
 <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
 <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
 <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
In-Reply-To: <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6072:EE_
x-ms-office365-filtering-correlation-id: ea12f93d-71db-4d53-25fd-08dae3d4f2d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /P08B3hvK5+qXbplmQ7vgJDR6j272m1WllidPl9RFStoV7jPEbyx4kKo+oyyO0vK57mhW0MvuIw1194Mkfqon2Y3dyicnJc6i3C5pATBb6xWmDrKuTjxGnkdcAv87IJivQh7iSduBDke1lIn4edLpQlBUeQdrD8ZPnf/bsYnFv6Dj8qQquOFQsuPp1uWtj9m/0N2Z/LitQTcN8kFyu34j5BhjAiNeaUQNV8ukRSUoCUQ6REXD0WWNSUPp4l34opR7LrSoDDM9nAHtTFrzL0pItsxFZXyQrnfeK+UmEa5UcKsbKb134uN5DX3Q336j7xNCq/at1VZR7JC0AqOnvAcmuatKMZzYrlUp+AcXf3KhFqI9cxHu1w/6w2/ZujF7Or4Wv99VdfzTraNmVmASBTTPuCBUGG963XtZnox20ZwPWCPFAX46d/WJMXN7i3TcaWsdkiZozRan3srVNxAMtNq3wqkssQhjXc9kciiku/f5O4/efl6cIpIHVXKGehiicgI859MESxGVqBnWMw2dA3PzMp34O1Q6VTVyLq7eefdhe6Omy7s5WubbaOXcYrzO8ZlqM44SDeVrSYofYNcOShMVP7IKLCpBcZ38AmYC2TVV/jkx+vVZk77Vf0xxJGw+fxrajwhXnVFHEzHyXnquXiyN4QbtQOxiPFBeYTL8+5E3DPe9z0KEIbOj13LrCPGYRCzev/at0Lq9ZLe/1kVatG9qcBBAu42LSudALboJP9JcxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(6486002)(478600001)(6506007)(71200400001)(66446008)(26005)(66556008)(64756008)(66476007)(76116006)(2616005)(6512007)(91956017)(6916009)(186003)(86362001)(54906003)(316002)(66946007)(122000001)(38100700002)(83380400001)(38070700005)(8676002)(41300700001)(4326008)(4001150100001)(33656002)(8936002)(2906002)(53546011)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ptAlDpD3F6rmw/zyvtpARUnyyFYXk5wsU/yyquA6cHHnhSeFw/u+dXFT1B+T?=
 =?us-ascii?Q?cI50AjaAZBVzpn0nHBercx4EPdO+q7vp9Ks8Tpf6ICvgTsTKVSTzcYL9jnOU?=
 =?us-ascii?Q?hn9wOrd3ni29BkZnhfZ59Tjr1XYrR3OcYk6Q+9RdhIUdx1pYjUzXyYBCr7o2?=
 =?us-ascii?Q?zKaFk62s6PX4L8Vw2aKYksN8becpr+LLV/AVNe0JYo3KgbyGl7rSrEkOMt19?=
 =?us-ascii?Q?zOnBMMDcxBG0lauUC9PNrmZK51HE0VKPVVOwnq7NWdh+ASElFl2PCvOlJ8o4?=
 =?us-ascii?Q?cqdtAFHZDjr7gAGSJ0wtgq+YfOgt4Fv2599y+RcwyBGgWGl2OeOYu2xfNQWM?=
 =?us-ascii?Q?RYA9WKHSbQ+jb8RGdBhr3NC0oAMolgisiAB4HoyYXD4roAIAk/EyhhGxzbt7?=
 =?us-ascii?Q?X5V3FXx9ACoaRsqvKIBtNBSrztSK7SOFxY2j6MbRzwMqlKyrvMpPPwDXiGhr?=
 =?us-ascii?Q?QhrpIQL2D3AnmJGOEIIzSMW+8DOSkP01f2Ei+SGiBdk0J+b2p0scV3dTPxvi?=
 =?us-ascii?Q?4yeNT2c9MJ5HfvHoLvAU94O8lXHlH3AMVRUD0Momc6aeJCXwWofnPoy1JFEy?=
 =?us-ascii?Q?bYo3iMtkyWbhv1esQgMJcA1LcKmWZg0zKWtLcl/pszU0Gev8v+Mu5bSPf65u?=
 =?us-ascii?Q?bMM6piRohQOtd20v1BOZ2m7H6yCgIjQRF/Usiu2OEEkjnOcX0tX4BWXF7hfw?=
 =?us-ascii?Q?wdk6tGnHRylN/ZJwoLjrBOI2ZvSkVrTq4s/I3SoCGsp0IyD+qfMcyd/6mmCU?=
 =?us-ascii?Q?u8iDQQPpKA/asXp+97gYEA7f2/Yk9MQyShjoalQJ2nru4Jtd+A52oGvGZw2V?=
 =?us-ascii?Q?o9Fd4toR+URs4qmmgEUaVI8o50pWC05/J3dmYZoE9nDBAuAV2gWck2grbqnN?=
 =?us-ascii?Q?VmvEf84p7zAiWkJEsqkUQsG8X6eFOijtF1yKx6q2H6/2ilvhN3FWRs/J2aIP?=
 =?us-ascii?Q?BiprlPaLLiqB2u+QBxYqZwaTefw/cywayBj6Zj6UxwwAnBv5Hlh3+sxnN2Dg?=
 =?us-ascii?Q?29iWwORpA22u0sNQdapz24HqkqgjxBmO8ZkBrKnchIK1WsNI+LQI8v83mgQU?=
 =?us-ascii?Q?phD//Ehcahba6YFrdnA64AM1LfaSUupmpGKClLLfBnI/LlKtynAngx5fSjUA?=
 =?us-ascii?Q?oFDeWdBB2StDmAdFICi/rY81v0mDJzoS5z4HSFMXN6f+sIrIuYJ6a+TI/emY?=
 =?us-ascii?Q?mbzqzzdWjjAgdHfOsJ0oIGEjbofMZjb0sYz3XhASY1qIEseRbeeb4/JGisLW?=
 =?us-ascii?Q?Jse/eVH0KON6SDZ6/s1pey9jx4ZpvrqQq/nZVBWZvbUAX50EhG47sQnwaJco?=
 =?us-ascii?Q?yOnnp7Wj191891HOnMh+ybywibCqm7LgjIck/sRCTjV5xXYa4FyYkpnLODCt?=
 =?us-ascii?Q?59rHCfDye62OXaV28u2VxF6r+lGYm8ogAUaPJIFnbw6pWkkHAPHvrdhaJrZ9?=
 =?us-ascii?Q?HmH6IPswqbczMfSD7yOyf5tTh5xzsbRW5dBAf+bPX2xsZv2eS3I0a2itAMGh?=
 =?us-ascii?Q?ayCRwTuFdSVNr+7unAlNPub5seP5bLpRvMniTCsuiuOJtR7rU1nmkLWi8AXk?=
 =?us-ascii?Q?l4yTbu9Li4vPOqWCL9MXLvH4CIDiGATIvd7GoW8OND1JUiDZRXRjIQhCqeSs?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9802974D1E66B541A6942CB92A30F287@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea12f93d-71db-4d53-25fd-08dae3d4f2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 04:28:17.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKFhFe9wzpWCC6Kc/hnts87RTAmqlY5hTxd9EnFK4OGTrFRGVjhNEURTIn2IE8ORpsyszSBDNm6hyDFKKw8IFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_01,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220038
X-Proofpoint-GUID: Xj7_ZmjWzhcKKtRHM3zOCp5nH0TLq_KU
X-Proofpoint-ORIG-GUID: Xj7_ZmjWzhcKKtRHM3zOCp5nH0TLq_KU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 21, 2022, at 11:14 PM, Mike Galbraith <efault@gmx.de> wrote:
>=20
> On Thu, 2022-12-22 at 04:42 +0100, Mike Galbraith wrote:
>> On Wed, 2022-12-21 at 10:56 +0100, Mike Galbraith wrote:
>>>> 6.1 didn't reproduce either, so it would appear to be a merge window b=
ug.
>>=20
>> Ah, not true, turning evolution loose in nfs mounted home and letting
>> it refresh mailboxes while desktop box was kept busy jammed up 6.1.0 in
>> fairly short order. =20
>=20
> Well crap.  That was _not_ virgin 6.1.0 after all, it was 6.1.0 with...
>=20
> 44df6f439a17 NFSD: add delegation reaper to react to low memory condition
> 3959066b697b NFSD: add support for sending CB_RECALL_ANY
> a1049eb47f20 NFSD: refactoring courtesy_client_reaper to a generic low me=
mory shrinker
>=20
> ...applied from poking about yesterday.  I had given up on those as
> culprit, and intended to pop them off and rebuild, but they were in
> fact in the booted kernel.  Oh well, booboo could have a bright side.

Hi Mike-

I'm guessing your client mounts with NFSv4.x.

We've been chasing a similar problem for a few months, but for
lack of a solid reproducer, it has remained elusive.

We believe the problem was introduced between 5.19 and 6.0. If
you have a fairly reliable way to trigger the server hang, then
maybe a bisect would be possible?


--
Chuck Lever



