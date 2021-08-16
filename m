Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E8A3ED6D8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhHPNYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 09:24:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61882 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240009AbhHPNWT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 09:22:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GDAhWF006941;
        Mon, 16 Aug 2021 13:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BpwWN7la5Aa+AsXxCHlT57y25LJBEKzeivL/g83XDdQ=;
 b=LI0eupyDEQ4SfVNeEArEWMWMLwh9Kk1pKiblamoO8AL55T1SjkfJa8vlNJCEtZjEUVoY
 DzBKLbIJbzFspPXHmS6xaOs70FRTTwH0ndxPE0E9iJNhryWkiLAxCqNmIkxMgl6Gw1Eg
 0DiC62MY1q34vypMDEkEwgmtNsjPXeeeDT9vK3ENvy/1zIpGedilOtvTrnznm0m9pkbO
 39QYZIcIWfQGp/TSeesvT00V5n3Z5so7UBdMLxoftwzeTYAbS0tH8W6INHaUrLirQFlu
 3ypIq/Yheg3A2MlpXBpmkFi6Hj9QubNVIiXqqWSwEnRLE+vB7oE0xc7+u6JEvHDpngDp bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BpwWN7la5Aa+AsXxCHlT57y25LJBEKzeivL/g83XDdQ=;
 b=JfXewFsqkCFC5lGRCQ+lQmJER4pFefekt8uUgDpkqkejcrsqEnkYyKztWQCOtTIUG29g
 WGiN8dTVJIj9zTb3uAIuziquzPjkeR2/n2/EoCcIcQPCcEIURRJXsF+a6KdMUxqqKkdq
 D6TMzmnlegJLoTz1MRNUgYr9aZInFmJphCLgsbdEhX/QLrgCf9C87tVRQV6wduZuN737
 Aq0IRClsdyye9ogZRHM+6/trtmkuVOQaBzIRwt4vFci09WVZjO16Xf86EjZ+SGSBjHVi
 F+eJIoqOy9vmwpX7xGF6LH28N4V8csDnrGTUQnqeSv27HoQKSAkEgLuX62MY63PbF2d2 KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af8301qby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 13:21:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GDAtmh151922;
        Mon, 16 Aug 2021 13:21:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3aeqks5ax6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 13:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFYp5csrbPFfvGevrDVjxWSeyPGzhN4uRSCpQqPomiodf2kYJRYJ+TlOg5a2yIxpzk1UH9UdxjSWmzGjJULbxrPs7X5idWeb8TPRIXMQJ8zg1FkKPucOmkjgEuW9s9oR7C+LmeqiBPjztt/+5/QbnpcxM8UJa0VWuSxbFWvqIH9myrdNbWlBCQZmO0bYacrS4K/VuSrcP46RXQcNxdlnvtu2OqZfYgB9nzNuxNSi4bGpXtl90KRfhpxfXss19iz9IEmFn9FTxUg4IluMyHCu0qhlyvfpqyTNnI2zUr+2e7jh5fo1WQPEr2wvbN+dJAB94FPM80tBsSDeInyzqJ5wMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpwWN7la5Aa+AsXxCHlT57y25LJBEKzeivL/g83XDdQ=;
 b=a9WlWpe9E1/rulPQZc/O5m8lCCoMdLjXoYyC+N7CLdmK4MybNQU7HsKlBNKZLCCAtD2u3iCo/4kQY4g5kTBX2dPfVcP9lywfTfuTybysWsUKVMlNkG8gLoAsWu7cUplvcHesnsyLTvPYDglT+fjFFW5m6IKjjOd7LdPRs0mzPTiI3cCIMKJ2c8KeNXZOoi0oFrdrHqgumaGguHTNA/q1S6DDnpOmMu2fwCoYcXbFOceawHrAMy2DcB2ST9hpGiOLAOqc7lc0CW+xcfkTNmwQgOw6wwPxa6br1zMsgfK9AT+mJ8J7Oxs0Tx88NTlwcoUtBVVwxTqdMkjyNJi6LqCI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpwWN7la5Aa+AsXxCHlT57y25LJBEKzeivL/g83XDdQ=;
 b=N/yjrRLbQQE6XGx48NYK1p2o3odA4PK4q71hYeb1mMttHJxkw+UoXp5nhUHdwJcPFqrKbesR+gFVUOQsnw1CWjIbb73bhQsfpl69FmQKdjOVD8AOrpoZXe5UsLVf2pNfDGtfRj/a2+TpYtDV5ogZ4NZ7MSn+vhwwu7vastov/2A=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2519.namprd10.prod.outlook.com (2603:10b6:a02:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 13:21:34 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 13:21:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Javorski <mike.javorski@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Topic: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
Thread-Index: AQHXjKYRxKTFwD0+C02+ZMVduTdsB6tqSi4AgAAHiwCAAZhPAIAACtMAgAS9YICAAA1rAIAAA7UAgAMLuwCAAZFegIAAyYQA
Date:   Mon, 16 Aug 2021 13:21:34 +0000
Message-ID: <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
In-Reply-To: <162907681945.1695.10796003189432247877@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21ee8dfe-1945-431f-c8a3-08d960b8c536
x-ms-traffictypediagnostic: BYAPR10MB2519:
x-microsoft-antispam-prvs: <BYAPR10MB2519F9106D8D2167E9E13D2993FD9@BYAPR10MB2519.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ewz0XArS64uFxY00n2pP3wKmdqcR5XUiYjrYbSbuJaQzE09YDAaoQ3XrTwBcPRh9fR4IA3KJioMb6CMox8xnoGj9eteUIq6t7qsmkIgUZaOXy/uDpSm3JKSKB60vhtamITxsdf/Y8QgMAPdgsfUvQ8t/Qa33obpqfjMSOZkt6oA5KvFjlsZuknKHNfrrntIXaHZKkm/oGCaQ9tMVsPE3DNbanhHxrcwhUXVYxdoR+YIxIXWhkEAmxp3pRwO9PcpK5X+FginjS9n1pTUNQT22pwfpazRCCzRKXa63oGtw1KMeZdxDk0AhW6oSczZRpoz67wngDc+fXo8/ltG6L0dzhpzcOd9CihAFn3EPPO9WBG6+MkPeucrQ2ETedqPxteNjounHGtivBnpRbiMJt6Sop6BSwOLuJ5c8HdCvuQuzXi7jCAjb956ACBjPFLPe6p/u/7UjEXEmmX6hO58XmPBS/7vUOJ9pfVNh7zYlTa6L/ZjZfPj1R2OAHqEKsipAcpyqGGnBajQ/jj/pTKp1rp4XtWZSWL2sp3O6VoGC1qk3rZoBCcskv9G7SN/bKvoBb4zeg338t/IL3Rrh3diUC/9UQFDarIqXdUDuPn0PxDlNSUFu2bAXrmcynT8CkyylWjDqkplnNeD6i8EQ6tuWZNWhoVRCiVjE8oqFHHG5fJTt9D7NVfX+Tj+iKn1HKYVhm7nXYskLxYccTuebstpDMEmje5t/tqYt1GnObzJ9eEEGn4yUtp5Ds07qfr+hp9XlhqlWQPPq0CAyHTNPbynwjeilMHXHs4J3GcABZcZEDW+WpFoFAI+5r6QqDaMKopJbz3jyG/hfoTbDJnI7CBE+TNqFrdLwpvKB3blZ0fMz8rfrD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(2616005)(76116006)(91956017)(71200400001)(86362001)(54906003)(6486002)(6916009)(478600001)(64756008)(186003)(66556008)(122000001)(66446008)(66946007)(66476007)(6512007)(4326008)(38100700002)(316002)(36756003)(5660300002)(38070700005)(8936002)(33656002)(2906002)(8676002)(966005)(83380400001)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UgtCTFFWoO/08jtEcTsF6Ecj9d2gzhnBq+l3vF4Jc5fAQTYLfShDPaI6+JaO?=
 =?us-ascii?Q?GqVXv/bo+nqauHN+LKzkoAXSdf2AGD6pu3/RxUJ2KRoSZ8zoMerbJ1cuVkyA?=
 =?us-ascii?Q?ZiqAB2RWk50XEVUAmUmJyD1IY83q3zIJ9QH+dqSUYdOjQIt0iEP/nViaga7m?=
 =?us-ascii?Q?oD5zZUoGE+zo7H/Ge3R7HY4WtZcnIkNgktlUns10K/eM+60juzcdWHqHbaW5?=
 =?us-ascii?Q?JrV/++uPYqcc3gHyznoFlTAP+C4z2OWVwN8PWiayLf8fUj3MpjmiaXS7IoC1?=
 =?us-ascii?Q?ruE9lB4Rg24r5FC+NIps406z1Jp2vFB4MXc6e9Ju5OqN57jo7CgwIfEMFeNT?=
 =?us-ascii?Q?mfTUwREAQr55ZSaRpl/af3kHEcqQPAfUDFcCg9x/ZRwrbAn0skoOQ6s28OD/?=
 =?us-ascii?Q?HxVr5r5UwHyScD1cQS4KevxDXDyGYgSXY49U7iA7E4yrlGFHRNu64GBhvk9Y?=
 =?us-ascii?Q?vJqW6baPCYjOHF2k+4vldMrv6DINALUnYk3nTDfUC5zi4oAs1ZXz0aS8Q9aH?=
 =?us-ascii?Q?QmKZyW5NDNWOfQupqjxaAylED+XXx5GxYIOABjzHVdvLsbEdAxrD0uAfDm+6?=
 =?us-ascii?Q?h9g5naGk1BYtdpRlORFOAsvoyyVrl3R5Sw31jDf2q0L65kOWNoVb2uiQhFQG?=
 =?us-ascii?Q?gRA/Tda+uAmifbUUs95ky3Jk7zN3Ch/Y3BaurM7Xk3DW2JFgqONhnsIwZc1j?=
 =?us-ascii?Q?Q2aDwTbchdO0LXCnMVDVoCxM3/J5N2/8dpgSXiFip4c8w5+HZLapN/Vvvjhs?=
 =?us-ascii?Q?E556IOK5Ta3KiN5cwAoNIa9G6QyxqIN5eHp7EbJOfemWAynv5nw6clHCCT/m?=
 =?us-ascii?Q?qSovCVEjg7nP52OR0teglrVJnJnB1FzEzHt5HboahmATfSzTtUMH2Qpo1gyj?=
 =?us-ascii?Q?0Xj2VwAe8xr+mFSWW72bCij6JWlTWw6XO0iADJXn6YnsOsZoA0QWySWRsYGw?=
 =?us-ascii?Q?8yrAsBf65AqfwgLI3a8hJNF11gcPScFo66mxcUo4rOLY3E3rXg9HO619CXn3?=
 =?us-ascii?Q?WzvYinozfnXowPicfUweaO+7TxW8/WnHtnecTlbhhg32M0f8pfhEz76tP4eh?=
 =?us-ascii?Q?dkXZ688U2/j1FkVJ8dMwkAWVhfaG2zN1l1JWtNHjLi/lIUW5OGITCoUaLzwX?=
 =?us-ascii?Q?8wIiU4SKKBy1kjcy9k2OYsBmKJ9ZaCik597GSye2PQaiwtwxrYDPBjLpCnDE?=
 =?us-ascii?Q?KxsD4rFCiAkkT39t6Y/eFb5rBeTU+SsHh1sNJvd2IiIuv5cuN1kXA7PfhV+l?=
 =?us-ascii?Q?RFr0JompbQUUAvdpaHMr1zfXlu9wky75kfNiwlgKNCjHTpul8rtXc2mGBESG?=
 =?us-ascii?Q?ro7gjCukcBQFHPBP6ffaG9VwSbGZHOZo2NPuIwY1/6jXoyDQJxOWtucrrE2j?=
 =?us-ascii?Q?IlGZVAx+ndjjrKVoG4Hgmqj6FQqJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07361B05A1275146AC1AD276DC874068@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ee8dfe-1945-431f-c8a3-08d960b8c536
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 13:21:34.7282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnkRPo0OStqYwis/e+MHHCwrMlHDnFP7yr2FkhpCTM6HRANX7PAYe0Y/kqKRS48hpCpdYb+CKZh+eHCjOtMfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2519
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160084
X-Proofpoint-ORIG-GUID: SG7hpDOZvxTqQucBNhhvPUFcl0ByRiG_
X-Proofpoint-GUID: SG7hpDOZvxTqQucBNhhvPUFcl0ByRiG_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 15, 2021, at 9:20 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Sun, 15 Aug 2021, Mike Javorski wrote:
>> I managed to get a cap with several discreet freezes in it, and I
>> included a chunk with 5 of them in the span of ~3000 frames. I added
>> packet comments at each frame that the tshark command reported as > 1
>> sec RPC wait. Just search for "Freeze" in (wire|t)shark in packet
>> details. This is with kernel 5.13.10 provided by Arch (See
>> https://github.com/archlinux/linux/compare/a37da2be8e6c85...v5.13.10-arc=
h1
>> for diff vs mainline, nothing NFS/RPC related I can identify).
>>=20
>> I tried unsuccessfully to get any failures with the 5.12.15 kernel.
>>=20
>> https://drive.google.com/file/d/1T42iX9xCdF9Oe4f7JXsnWqD8oJPrpMqV/view?u=
sp=3Dsharing
>>=20
>> File should be downloadable anonymously.
>=20
> Got it, thanks.
>=20
> There are 3 RPC replies that are more than 1 second after the request.
> The replies are in frames 983, 1005, 1777 These roughly correspond to
> where you added the "Freeze" annotation (I didn't know you could do that!=
).
>=20
> 983:
>  This is the (Start of the) reply to a READ Request in frame 980.
>  It is a 128K read.  The whole reply has arrived by frame 1004, 2ms
>  later.
>  The request (Frame 980) is followed 13ms later by a TCP retransmit
>  of the request and the (20usec later) a TCP ACK from the server.
>=20
>  The fact that the client needed to retransmit seems a little odd
>  but as it is the only retransmit in the whole capture, I don't think
>  we can read much into it.
>=20
> 1005:
>  This is the reply to a 128K READ request in frame 793 - earlier than
>  previous one.
>  So there were two READ requests, then a 2 second delay then both
>  replies in reverse order.
>=20
> 1777:
>  This is a similar READ reply - to 1761.
>  There were READs in 1760, 1761, and 1775
>  1760 is replied to almost immediately
>  1761 gets a reply in 4 seconds (1777)
>  1775 never gets a reply (in the available packet capture).
>=20
> Looking at other delays ... most READs get a reply in under a millisec.
> There are about 20 where the reply is more than 1ms - the longest delay
> not already mentioned is 90ms with reply 1857.
> The pattern here is=20
>   READ req (1)
>   GETATTR req
>   GETATTR reply
>   READ req (2)
>   READ reply (1)
>  pause
>   READ reply (2)
>=20
> I suspect this is the same problem occurring, but it isn't so
> noticeable.
>=20
> My first thought was that the reply might be getting stuck in the TCP
> transmit queue on the server, but checking the TSval in the TCP
> timestamp option shows that - for frame 983 which shows a 2second delay
> - the TSval is also 2seconds later than the previous packet.  So the
> delay happens before the TCP-level decision to create the packet.
>=20
> So I cannot see any real evidence to suggest a TCP-level problem.
> The time of 2 or 4 seconds - and maybe even 90ms - seem unlikely to be
> caused by an NFSd problem.
>=20
> So my guess is that the delay comes from the filesystem.  Maybe.
> What filesystem are you exporting?
>=20
> How can we check this? Probably by turning on nfsd tracing.
> There are a bunch of tracepoints that related to reading:
>=20
> 	trace_nfsd_read_start
> 	trace_nfsd_read_done
> 	trace_nfsd_read_io_done
> 	trace_nfsd_read_err
> 	trace_nfsd_read_splice
> 	trace_nfsd_read_vector
> 	trace_nfsd_read_start
> 	trace_nfsd_read_done
>=20
> Maybe enabling them might be useful as you should be able to see if the
> delay was within one read request, or between two read requests.
> But I don't have much (if any) experience in enabling trace points.  I
> really should try that some day.  Maybe you can find guidance on using
> these tracepoint somewhere ... or maybe you already know how :-)

Try something like:

# trace-cmd record -e nfsd:nfsd_read_\*

When the test is done, ^C the trace-cmd program. The trace records
are stored in a file called trace.dat. You can view them with:

# trace-cmd report | less

The trace.dat file is portable. It carries the format specifiers
for all records events, so the trace records can be viewed on=20
other systems.


--
Chuck Lever



