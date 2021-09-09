Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052D1405913
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbhIIOcv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 10:32:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24134 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242501AbhIIOci (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 10:32:38 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189Ds5UU023565;
        Thu, 9 Sep 2021 14:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OWkLfMqreRWkf/scRoQkAQTDDipCIauYZj7LIyuF8RE=;
 b=UexqtfsVM4voXjjx5BpFyoeIbW+9mzyh6VI3RzRCz2QR/uiixverdsUP/dVCKB8Kfngx
 sRM1LDBSz8i5uTK9D59oSWyKIh8UflM+/TOimM977TrL6UT6lAyFQzxuNqkM72AkAX9H
 nEmK/4bVPEBR4fD8C78OTE4+KOB8FXoMlidK7GyOwdDHKp3EUDFIVjLxdmQ0BBSfyefs
 QO4+h13u1KrFCNS+KyuHikppsUB19IAN5Gnq9BsCFlodAQA7ShNEaIZxaN+v6+D9EKeH
 2JfAjSMm3pLmob2cOu2mBR5tri81ejOkUuysX40BjnL5cNh5joP6O6uTVGWBNhHnbMRY Mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OWkLfMqreRWkf/scRoQkAQTDDipCIauYZj7LIyuF8RE=;
 b=Fu6nABPb2ILFICcUDmxrZGKJBBC6+WmGzDkjDud6atU0Jexmha4vkrmHiH4gveTkx0JY
 drJIs4Q8ODWiglpyBgQaAJpw81530JiCXXER/QbIJkWECRSm9GvVvLp1Ubn44EWMQSCy
 KkUDDIS7J4GVn3PCWZ9jmKztTlU2ar57JNJihXOM06AUAAU0at+5XHADLHPa2QT1M0np
 OXOA/iPib90YYEG/7/7It3DJh/NbhK8WTF/AchrOuoUDYaqR60cTc/6XlOdi5JqaDWBO
 sM5Z9vQZaGo/wnX2wXjsuJDgUn1j3SMRRCzzJ0jpYi1J5HSnX1xrcDHPrm2jXoLd2EKb Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aydrshbt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 14:31:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189EUsiR192079;
        Thu, 9 Sep 2021 14:31:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3030.oracle.com with ESMTP id 3axcq32f5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 14:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDQMdOPq0unpGAH0DBvNUXnKP1LROAxl0OxAbcutqJer5TW6EEqLsnLf2q35qTrZi1D8BZ/D+XGqO7Zwi3nrevSIrLM70SdarEroHpJgzESGTe/n9ARIwAtcOaWcZUZw6hHXqerySKlQBCX1ClZFL/mDhlGhkBdabQsunv6NCc3/aaHZA3X6MPR9FtQSH2un/PRVTLw24H720eTE1sNuuKIC6p5bIo2LbeHd+5nAj2+E/IXsD1bfj2TtbXkBIUNt3bwu/XKcxzh7ncDHdFoQPhTeT3vedQfBtUBPUrMH2xbBsC3RgVDCUivvT+jiBsraBw/9DVGW8X7SZQiI12KYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OWkLfMqreRWkf/scRoQkAQTDDipCIauYZj7LIyuF8RE=;
 b=Ce/hGxHrcsWz5XLO2QnkVY6+Y+GXLI53GEhAl7rh+TwZZjlNWrtqhnE6MD3zgLfakm+lS3/FQH7/MtpAwmlAXOyOlQDzBSEsGq+CEvQBpJJiFPQi0JscWeQpZrDkmGMHgvrg7tQMkn3Con5v0Pb74wC97u1K5f1KkbN+Yl8+dVHKm1cwPtv0vYkMKZbPosq/ajNqFRCqsK0vr5ZgoY14eVKyHFLCT3KBrJjnGdktKQf7CjJ3c8kdSCnyvEtIz26oDTH/zlvgaYTe14j2jVnEAQBiGPNdQAa8esv2LJBIGwOFhohF2r0bRpc16KJCXP/4AAhxL/PIk2vVwWrgne39uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWkLfMqreRWkf/scRoQkAQTDDipCIauYZj7LIyuF8RE=;
 b=VaY9sQ1HC8aBcwX5cnwWLN6pppVLmlL+9ym+HYzBmN2zHEyIKDE1vO+WjEOezaogbz5wDLftY0sfzusxZWvVmVwJZ7YhwFlrjG6hxJZPTFvP4xClVsHGoHx+vwo4g4WeyYASvzwqu/ozJRcixaO54/z+SxFjcZhe53ZA2y2BtQQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3828.namprd10.prod.outlook.com (2603:10b6:a03:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 14:31:22 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 14:31:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Topic: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Index: AQHXo790A7Wd0tfa/0e3moKXgUhSZquYZ4qAgABDIACAAf4ZgIAAAbgAgADWPACAAEaCAA==
Date:   Thu, 9 Sep 2021 14:31:22 +0000
Message-ID: <57B147B6-FC8F-4E70-A3E1-D449615B8355@oracle.com>
References: <20210907080732.GA20341@kili>
 <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
 <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
 <20210908212605.GF23978@fieldses.org>
 <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
 <b63e52660e39cc7688921f85eadf1958ced6a869.camel@kernel.org>
In-Reply-To: <b63e52660e39cc7688921f85eadf1958ced6a869.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b662fa1b-ba15-4842-684a-08d9739e7f50
x-ms-traffictypediagnostic: BY5PR10MB3828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB382844CAF7E996AA5402678493D59@BY5PR10MB3828.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjnUMLwsTUznxf+u90TeJv/yMSDUd2NgxSiBlFMBBqwViJOet5jr/vrosfbngAQw3cpTWoUZNFAHxRz7Bso0EZ3TGuxBGttWqpQG2fNAJSz8peDDoNtsN0gmDGJNb+qTxm1S3HzkRneJATuqBpTKT73iBaeC8cWamTflWeZfwpocTcFJazwZh524xP1YvcBXQGST+iAVJZBzbvZOtKsbK1XW8dJwpvEFiELiLFzxCqpXa27RGl0dLu1FkbAcJteI9K05w8ezbzza3uWKfF5pr1W3yXuvFxXlK+6INAE7hSWsG4xHhpZRJAVS71eXEiiE7/r81hiNeT5zMQNCB1/+7vVpgRwit4dQF50smzrwHGzhA9RlbSqR7bntC5Q16Xa9vbF5AlryQpbvy8Koqj3Eo7Q0kVoLAtJX3JIQodUMUTP5ZZ2TnLL6gy1YxUBaX7Tzt2WT6lM/5+3y7wbcnWhDZlpk408DF2mq2G5kGinoXqlLySUdCqWnppHGMykZaIL8JwsLZy5lGqhe+RY7exXGtmd3yBypbNWaO5hQku2BFxXc0moggQ6KKv7BNjrsmFdkEeny+UZXuSCix/IFyUWenu8DGwo9gtNQFoQKjc4/oftzuz060w1nhkvPt7pj9hAo0LilPgAfcH73NMVDkzA9RcOLvIVQ7+OqbYl0PxLR3Uog5X7pxYlRlvtjJ3kJBGFlhcGKdclx6at/e0yHqSRB3G7JuhjZMzTKXOHv6WgWZ+59x4lylD+UjSUQm+vqdDeFhAHDJmhr6DCzoAph2gfIeh1aeWLxY5JT5tgxfxFt459hCcx/ugdJZdQ1kNBhDbOqFoPEcnAY/Tmv1WR/Pq1+uYIv5oMoKViRrpPEgDHGv9o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(39860400002)(396003)(71200400001)(76116006)(4326008)(6486002)(5660300002)(66946007)(64756008)(66556008)(66446008)(6916009)(66476007)(2906002)(316002)(122000001)(91956017)(38100700002)(6512007)(186003)(53546011)(26005)(54906003)(6506007)(86362001)(36756003)(33656002)(478600001)(8676002)(8936002)(966005)(83380400001)(2616005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cefp4kyCk5ed4QEJEFw6YU1outDDwD9XBv/OWoIZYC4M9qTawhVXef/t7Pzi?=
 =?us-ascii?Q?6IDflRUSlQaf/VKS3/nxtuvMlkMXWGoYYNmUhQafb46zw5B5lK2M82iKQsZk?=
 =?us-ascii?Q?FpwwQ2YSNZVQFpFvJQTA4bXuygCxLvu5ydC8Aj3vsBAc/KKV2Z3aJs+2nJkD?=
 =?us-ascii?Q?dLUTspAnD6jX1pGPU3PCaVMc5I02Alxf2vSNGanzOFNeVbofh4ji0RmMeIT4?=
 =?us-ascii?Q?0Jj4KepPIyI3VVzUy9j9oTKHmnMk735WSUDwX4dOlq99vFzDlH9Fg9i27ILr?=
 =?us-ascii?Q?kQKcZM2ezNl+J23swxMb89DgiJJrbNoQEKRPV7m7IXAkay3hGzQaCqLEIx/V?=
 =?us-ascii?Q?yWPExkjpOv4T7pzWMRnxXUb15dzc41jqK3z4w9t9O1XurEoXzVd7jffJvHHB?=
 =?us-ascii?Q?btFy+AfNeWdz/sbmRqNfcycBPMywbedrp9auF+SWFR65Q76jnwDCTdr1wHjy?=
 =?us-ascii?Q?+1GHCD109ZyUHMAjczf8XXbYDSgqNMoUK+3PqD869jYMTpgPZ6pICDV5+DJN?=
 =?us-ascii?Q?wIxmNp3sNpu/uzNR/MYw24wN8nouEMXv1JU/eOIu88ZYM2onnVdjawq8KHX/?=
 =?us-ascii?Q?ZcJeLTmASZpor3q9MKCAmLJQvCip9c1OdVQQkugsee/Li/cCJcMeVeVjIvLi?=
 =?us-ascii?Q?2OLYModyKNWh3tm1zp8qsOC0358lILO4C05sWFVEi78HuJsk+4AG9f3rDl6q?=
 =?us-ascii?Q?5Ty5BREMGjSqIFjk+1pp5PK3iymS12URZ+7Zi6sIVRS9GSxQvytwTbVSZSqs?=
 =?us-ascii?Q?aApAPzYrKN6uTEpPGLgUa0YqLYM/Rldu2ksNlZcl91qZNu0WbqUENP6nHj2q?=
 =?us-ascii?Q?PiOIyfLHiC3c++ismpbLnWpjQi76sNQrdov8RV/HLVSGNInEGW3Q17a2BScH?=
 =?us-ascii?Q?87hN24HcOu+1JhFEzWLP4+vyq0VfaCAgNwS+dqB6PYCadcI5Sw15fr8c33hE?=
 =?us-ascii?Q?j49gWYma94YgvhbkGTPLtxEIfSC5KQ5yBfLgV6V/gBhe6zR0trb6ithl/RrP?=
 =?us-ascii?Q?yyWntzrfhzkc8kP4hQm0NtKaJLqWO9Plf+QGvaGORH1k3oW0kIeFcOFhapKl?=
 =?us-ascii?Q?YrGOwjGNUAjwH3DsJL5gn9sWDPdkFuY3Y2R/8xTNG4iDod0/8yuRda4E3li+?=
 =?us-ascii?Q?oIlbebQioo+zBbI32TlUS3KJFOSJCwvnA7k0lnMSniQFGblVcqD8RQjf0p8D?=
 =?us-ascii?Q?Frk6XgkTWLmj9ccv+QXiEUkL4i75OFUXla+FgF7PhcX94osWQi8MbXME/mxb?=
 =?us-ascii?Q?bboME6TAtcNxbRqBzGHqTEwQINy8GoJieqgo6BTBoUAPkrme/P6S/E6qLyMm?=
 =?us-ascii?Q?4ezIaK/cAn7HEWycgF7ukMme?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <719D894AF8E2AD43BACDB8F2D7E18598@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b662fa1b-ba15-4842-684a-08d9739e7f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 14:31:22.5687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ions29ERzjKY4mR59OT3TOsUKJRX8BEMDQgeleXf9o2DxhsrMFtPm3q1XAl2GfCvv2MDHT7xgXhb4uVkQX7SXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3828
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090089
X-Proofpoint-GUID: W1dqTWXKAj0CHzBEpFP2Sb9GWW6PEMDT
X-Proofpoint-ORIG-GUID: W1dqTWXKAj0CHzBEpFP2Sb9GWW6PEMDT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 9, 2021, at 6:19 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2021-09-08 at 21:32 +0000, Chuck Lever III wrote:
>>=20
>>> On Sep 8, 2021, at 5:26 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>>=20
>>> On Tue, Sep 07, 2021 at 03:00:23PM +0000, Chuck Lever III wrote:
>>>> We have IPV6_SCOPE_ID_LEN as a maximum size of the scope ID,
>>>> and it's not a big value. As long as boundary checking is made
>>>> to be sufficient, then a stack residency for the device name
>>>> should be safe.
>>>=20
>>> Something like this?  (Or are you making a patch?
>>=20
>> I thought Jeff was going to handle it? More below.
>>=20
>=20
> No, sorry... I was just suggesting a potential fix. I'd probably rather
> you guys fix it since you're better positioned to test this at the
> moment.
>=20
>>=20
>>> I'm not even sure how to test.)
>>> are
>>> --b.
>>>=20
>>> diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
>>> index 6e4dbd577a39..d435bffc6199 100644
>>> --- a/net/sunrpc/addr.c
>>> +++ b/net/sunrpc/addr.c
>>> @@ -162,8 +162,10 @@ static int rpc_parse_scope_id(struct net *net, con=
st char *buf,
>>> 			      const size_t buflen, const char *delim,
>>> 			      struct sockaddr_in6 *sin6)
>>> {
>>> -	char *p;
>>> +	char p[IPV6_SCOPE_ID_LEN + 1];
>>> 	size_t len;
>>> +	u32 scope_id =3D 0;
>>> +	struct net_device *dev;
>>>=20
>>> 	if ((buf + buflen) =3D=3D delim)
>>> 		return 1;
>>> @@ -175,29 +177,23 @@ static int rpc_parse_scope_id(struct net *net, co=
nst char *buf,
>>> 		return 0;
>>>=20
>>> 	len =3D (buf + buflen) - delim - 1;
>>> -	p =3D kmemdup_nul(delim + 1, len, GFP_KERNEL);
>>> -	if (p) {
>>> -		u32 scope_id =3D 0;
>>> -		struct net_device *dev;
>>> -
>>> -		dev =3D dev_get_by_name(net, p);
>>> -		if (dev !=3D NULL) {
>>> -			scope_id =3D dev->ifindex;
>>> -			dev_put(dev);
>>> -		} else {
>>> -			if (kstrtou32(p, 10, &scope_id) !=3D 0) {
>>> -				kfree(p);
>>> -				return 0;
>>> -			}
>>> -		}
>>> -
>>> -		kfree(p);
>>> -
>>> -		sin6->sin6_scope_id =3D scope_id;
>>> -		return 1;
>>> +	if (len > IPV6_SCOPE_ID_LEN)
>>> +		return 0;
>>> +
>>> +	memcpy(p, delim + 1, len);
>>> +	p[len] =3D 0;
>>=20
>> If I recall correctly, Linus prefers us to use the str*()
>> functions instead of raw memcpy() in cases like this.
>=20
> I hadn't heard that.

I'm paraphrasing these:

https://lore.kernel.org/lkml/CAHk-=3Dwj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZq=
CJK1BZw@mail.gmail.com/

https://lore.kernel.org/lkml/CAHk-=3DwjWosrcv2=3D6m-=3DYgXRKev=3D5cnCg-1Ehq=
DpbRXT5z6eQmg@mail.gmail.com/


> If you already know the length to be copied, then
> strcpy and the like tend to be less efficient since they continually
> have to check for null terminators as they walk the source string.

I'm sure there's one str helper that comes close to what we need.
Here efficiency doesn't really matter, and the size of the device
string is always going to be in the single digits.

The priority is correctness.


>>> +
>>> +	dev =3D dev_get_by_name(net, p);
>>> +	if (dev !=3D NULL) {
>>> +		scope_id =3D dev->ifindex;
>>> +		dev_put(dev);
>>> +	} else {
>>> +		if (kstrtou32(p, 10, &scope_id) !=3D 0)
>>> +			return 0;
>>> 	}
>>>=20
>>> -	return 0;
>>> +	sin6->sin6_scope_id =3D scope_id;
>>> +	return 1;
>>> }
>>>=20
>>> static size_t rpc_pton6(struct net *net, const char *buf, const size_t =
buflen,
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



