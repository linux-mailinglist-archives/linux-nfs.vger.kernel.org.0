Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AA3AA457
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhFPTbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 15:31:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24640 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhFPTbr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 15:31:47 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GJLkRa022864;
        Wed, 16 Jun 2021 19:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gZYpL5xiiuDUmGaMxqf/SLn6PvlXbaM2tW1dtHmopm4=;
 b=e1Vh/VQbZSlvNdfCuBfZDz2JL2zw+YijehIPJFJrQyVKXLRBFoevcevZz1kFrhiv/W6A
 LR8x/5Tv64A6NNBVqc2AnXVki103rGzzDMhJWXIkk875HyGUS5cUCjUjBwwC8oLUKIxi
 brBRWbjJ054P0SXKb8wnOQC8DstLK6ItyKhhuWsQ/+mDsfJdkf+A2bSf7mZ064tJ+oNC
 QGkzlq9SmP9Dyh56bE5AyUi54MZGolFzVvbuYvcQr3scengCZoIntzPf6Aqjm/MrMQYd
 60cPcYa/bqvQgx/y9WzfmrlvYp9wtqMgysDMXx5yhsTSw3I1NpMgCD6UaOtTP4gxhz/y Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 397jnqrnan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:29:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15GJLXFW128381;
        Wed, 16 Jun 2021 19:29:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 396waus0uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 19:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwnsFOduxu3hqMUQp+lhD8Ti7p7jYioLtmboBM3dcuQHaBNSSgiCogUKFcLcQYKOaXlGeC6vrWY0kkMP+3NgmZXpgnfV44Urf+ATmhHy0WSInzsuv+FLl5j67r/WNoYBP5VNNS7388B5tmpZ0JeptEH74FvSxJJ54Q5wK+hF4LP+LCDaTAfj2wgvfH6XONQ0TcLWoC6Y550qkpfKAH6rFOqV5xej7lv5a5SIrLoeKyAlTM9r1pEEk+FdGpJQn45Y5BxOVSAx0vSqzpCIgHhqtk5SuMTIa3kRUnfvztRodPpbkt69DeAcVopQR8Nm83zMgBuLgq9tROhJ5gakzFKW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZYpL5xiiuDUmGaMxqf/SLn6PvlXbaM2tW1dtHmopm4=;
 b=H6tDw51pYBUwd0ntoO1YKD/prtKMFGfW4dxR/19KWnkfOhRtkkwkc8KEgARqpSgJm11ddhIN09Uf+SI2ZMIYJs+Tiffc/J2livIESPdCassiYg8XF79Cc6b4ulhG0ocPG3Ro7aVT3ZDZNJRDh5rWA/xkOdZ1eZ7nB7lyjUW4e/8gvuooL7W+/mPdftMe2NgedFGHd6yrnvPpS4ffSYLc7YKaOtsAdvMbL/ITvPDiE31OBAca+hF/PQIuYLiIDDZ+kG4jQBenut16o/BRWqTAPtp29ptHKmf4ktvtXpaY+62UDHw3D605D066Ie5mLN4/x0UPVb3oaaD/nuFYy5ZG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZYpL5xiiuDUmGaMxqf/SLn6PvlXbaM2tW1dtHmopm4=;
 b=cDWe80kdUiLNJ39UGUyHB77F2qKj0OWMU3t8KRd7Syz4SW8LIBrwekkD9bz2uFbDb6eIJwA3XTHzVdB1/X7HWYRb8iRFBKGPO+wA4BxYiOfvM7cDSJml4T7hW1NVUHgUR57yXjUH1oGrQMLN/eL9S6uZRBM8/JwVldNUAcSwK2s=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3047.namprd10.prod.outlook.com (2603:10b6:a03:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 16 Jun
 2021 19:29:37 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::18fc:cb94:ca3:1f94%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 19:29:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Topic: [PATCH RFC 1/1] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Index: AQHXWKRU4nAovJ01SEuUWcwucjnsZasW4MaAgAAIUoCAADBYgIAAASkA
Date:   Wed, 16 Jun 2021 19:29:37 +0000
Message-ID: <50752B0A-A56A-4A80-81AE-32E20754E31F@oracle.com>
References: <20210603181438.109851-1-dai.ngo@oracle.com>
 <20210616160239.GC4943@fieldses.org>
 <8A44DFA1-683C-4D5F-BE71-0B94865AFA28@oracle.com>
 <5bd3e11c-8749-b9ec-b1ae-5398fff5df4e@oracle.com>
In-Reply-To: <5bd3e11c-8749-b9ec-b1ae-5398fff5df4e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e0d48cf-9908-4d1e-9d43-08d930fd1439
x-ms-traffictypediagnostic: BYAPR10MB3047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB3047EC7BB6E3394B29581A19930F9@BYAPR10MB3047.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcbhiwCgPPzacW+9+wt7sA+L6U55KRt7cmmOfoGXIELAoK+zy4snM9wMh3+XrpiJWvIzPIv5f51VsroPSB0Kkjkrq/NiUi2/mScS437yUzc7mtwNrBY1zf3wEU5R2LeORTbwSR1ehuYFqWJ+d5gORi1Ax+DGo+6OBRxAU/ihg4ifd/RYxxLqHnuKYdsB1J4dkXZZQdoRh3pxeQNGdxncGyK99MUG3FrMganYvjW2ct8rYq65LbErOyk0kxMwvPac6QqvkAdy9mK8G0vym01HLWdTcFRdfPSDiPrdi2cwgdrcyfoHIxGtedyhnB+qvCU2+CAkS/5Xmm9f62Kh5cTInBwTshhYClHcUmQQxkhdjCuTZtz3JYkHrcn72uM8gNwUv37t2NRtSOh33wYGOYXKuX4J4twb6C2B5QkAN907QhHO3Y3GmOH31dFnxrxdSnOwtH+7+JJlqswcZrTJJc9t8kHLxyK0Pz2mi6ffBg3boWtVZJD8mOrpu/h0HpTU9vWcmJ2NFzb1B8fqdLQTuQMoAF8I2A7FSc2lVoHcoyTmIJRF5FsmuaQdgCwDdykZlKik7mjwGqvN82rS02Y+htrJRfQM7S8ZfqD3094gUUyM4AnoGV4v6q2ZA5qIb0qbYAR5AOUKut78+huMxTnPy33+z1kkjkSfvq8Wch9+ABG59FQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(316002)(83380400001)(5660300002)(36756003)(33656002)(54906003)(2616005)(37006003)(53546011)(6862004)(66946007)(6636002)(6506007)(478600001)(6512007)(8676002)(66556008)(71200400001)(91956017)(76116006)(38100700002)(122000001)(2906002)(4326008)(66446008)(8936002)(6486002)(86362001)(26005)(66476007)(186003)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nZboykOYFXzsp16DlcK0i0AYNXkjsdIrpPCi0phrq3VdXfaKi1K9tS+S6L5G?=
 =?us-ascii?Q?28rxTOeYj0kUuD6dAC7lvnZIit0n/jvImZNbwccErYcVNi9whiY1Drxnc8zg?=
 =?us-ascii?Q?Ex5ljnUphiOMYgoz1IpC0n1PPSfVIOvY2HGYLP3FkxC1BLcCAvKAfjZrFrWR?=
 =?us-ascii?Q?YcyuON0NKWcJeBVXc8WkuVTzx404izThoyr9COIwVsPaaaEcZaYsvwj8+697?=
 =?us-ascii?Q?WYnlTX2YCjR4YY+UV0BW0VjQTQJAb8SsQYaAMw+bSc9Tn7gLm/yM3NKWCFfl?=
 =?us-ascii?Q?2DSYZg8ZibqRK9JfdrPLKXQ9lD2Jq3THQAvwdLkH/26wKo13oLdxzLEEVP0M?=
 =?us-ascii?Q?4a6JI3kHjnR+7Adx4ulB479B2oDzlj3Nq0thwfCHAYK8S+/s85OPfk2OqlTz?=
 =?us-ascii?Q?YBIGx1ekV5ZaAXZbypGklH6Cmt3EP4Q61grA+qxNq5sGxHN/bYLnj+oNGp2p?=
 =?us-ascii?Q?i0SrOS8kl+bGKLk0p5qGNnC80EDBftWfjr3inTrOHGuBs/QFWLvQPzwFOWQJ?=
 =?us-ascii?Q?gtnrhiGZo7C275L/xJ0/FAXWsGvS4kN+di7mWSNEdMnSRHmbZNb50d5QzLcK?=
 =?us-ascii?Q?u7OdcEXAF0n5vJAbHuTEH4xgrWTaxFKi2P8Ox2v886hI7aK37GCLAioFhBuO?=
 =?us-ascii?Q?HQtRxBU1Mt5aPoVpTQTb7GQADaezntCGQSCEioUUdc32d65f+D7vpedbQ8fD?=
 =?us-ascii?Q?HJZgQLQc3OqLyswcBzAERZfTR9oxfG7ctQlKqFG1rfPdgu9tCBbs0j4+KBoh?=
 =?us-ascii?Q?pxeUxnAeJhf6Wzu0v2tflO5CCByIaMIKrIxQfPPA5EgaGSr51lPo27IE/a+q?=
 =?us-ascii?Q?yfqh6tlCibzl1wzChXqFmTnF3FXuYCJIu5cZ0bFHe68/MKHPxVyGlhF/ELUa?=
 =?us-ascii?Q?6qsmrNabP3TxpI1zINRRhzQbW1ihMguvCQJfmAl2Kz4vpfXFmjZmX/pCQcoL?=
 =?us-ascii?Q?LPaQHjcwPlo4ALyJo+NZFuKta94kAPwXyiMLFDo513FRFEq2+n1MapglYUvf?=
 =?us-ascii?Q?BaRSsQiWJ0k5wF1sZsvxw1z5AsiNQ6wmG2T7H12lFwW0z5g0LPo1Ohd/v47e?=
 =?us-ascii?Q?DCnsVbQIRku3b78KGjGjiTYkvNO/jUZy73b3HXy4YGdzjRij5bBZ3CgQSwTd?=
 =?us-ascii?Q?0qRl0p8bzKXs7gFoQkJMsJgPl2Fm8Z5Oo89eCbMd2aLInzDBRvyvgun4uGxn?=
 =?us-ascii?Q?OiDBiNDMopT0RokXZ1+CoEghJyZTPczZQ7gpfWeRzBBi9tQu0VnPwZiVp3aQ?=
 =?us-ascii?Q?Mwo7CmEm4CTTs+/cLc0iwk6rDjbgTEkFB1ffSmaqIEqhDmhmmgmHirGUdQIm?=
 =?us-ascii?Q?ExYlWVLKeNxtpOiRPo8kcgCU?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE5F5F3FED25DB40AB1987A35EC76A7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0d48cf-9908-4d1e-9d43-08d930fd1439
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 19:29:37.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5F+Xf9nemDO/4zo9hAPZBxcayERFFg1pj8vkHJx61nu6CEjWspv+citmhAVhtaK2GNAbbCPRM0XLYbhSiVHKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3047
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160109
X-Proofpoint-GUID: vsxJHyupkG5SD2cA-1V7HxNpYQe5DKei
X-Proofpoint-ORIG-GUID: vsxJHyupkG5SD2cA-1V7HxNpYQe5DKei
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 16, 2021, at 3:25 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 6/16/21 9:32 AM, Chuck Lever III wrote:
>>> On Jun 16, 2021, at 12:02 PM, J. Bruce Fields <bfields@fieldses.org> wr=
ote:
>>>=20
>>> On Thu, Jun 03, 2021 at 02:14:38PM -0400, Dai Ngo wrote:
>>>> . instead of destroy the client anf all its state on conflict, only de=
stroy
>>>> the state that is conflicted with the current request.
>>> The other todos I think have to be done before we merge, but this one I
>>> think can wait.
>> I agree on both points: this one can wait, but the others
>> should be done before merge.
>=20
> yes, will do.
>=20
>>=20
>>=20
>>>> . destroy the COURTESY_CLIENT either after a fixed period of time to r=
elease
>>>> resources or as reacting to memory pressure.
>>> I think we need something here, but it can be pretty simple.
>> We should work out a policy now.
>>=20
>> A lower bound is good to have. Keep courtesy clients at least
>> this long. Average network partition length times two as a shot
>> in the dark. Or it could be N times the lease expiry time.
>>=20
>> An upper bound is harder to guess at. Obviously these things
>> will go away when the server reboots. The laundromat could
>> handle this sooner. However using a shrinker might be nicer and
>> more Linux-y, keeping the clients as long as practical, without
>> the need for adding another administrative setting.
>=20
> Can we start out with a simple 12 or 24 hours to accommodate long
> network outages for this phase?

Sure. Let's go with 24 hours.

Bill suggested adding a "clear_locks" like mechanism that could be
used to throw out all courteous clients at once. Maybe another
phase 2 project!


--
Chuck Lever



