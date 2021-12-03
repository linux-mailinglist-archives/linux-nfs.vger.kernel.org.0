Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3958467A38
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Dec 2021 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbhLCPbj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Dec 2021 10:31:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47238 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245140AbhLCPbj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Dec 2021 10:31:39 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3EMVou003278;
        Fri, 3 Dec 2021 15:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6eHnM8uJmvyI/25PdrlJ9Lkt0+e2mLZyfdko+e8gHdM=;
 b=eYKyw9JAuJsXOv3CTlRs2d6ZkTbvvoiIKgwx34ItO3EO4QyThyLK/+dliJ6C2HiSbezQ
 m6TeHOCOJNzo56sNr+Y7U423k94+iejcAcG5madXIfFo1N6ERTUUCV+jXeWi7GevBBJZ
 oRvVIAikOXy+tmZhXRCakLb2YITStHjUji6SuZ2uVCm/J6EgmgtIWR/4rGdjBoffVdPE
 pWVXwrUu/GpeeVoz2HSkvCw585DRRYYqTHnEY5/oVSzDYnDsUSwfquT66ojkLQuJrfcu
 zkK6RcO2sRu5sfHpMkQOz6+aOQ0lc/VpszLDBe6KidgsFNP2z1OB/Bv8F3hNCvdfdLkI Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqmxs8cjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:28:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3FO4vf137488;
        Fri, 3 Dec 2021 15:28:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3030.oracle.com with ESMTP id 3ckaqmdar5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 15:28:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMhIK1SDw+NUhNlNfitdCX226doUAR3SHt1fAA3N5eXRc3Oxv21j/l31SoHtRcNLLFDLeMsDUMZxfkSJ+gMoONTtiTt3+3EBPpcJms3YHx4V1gQ/43qX213gMzoUE6v23jcAChGCBj1l1WnknxnE4P3aVSolvkHWcNmgB28qjG2KgPZFtBFh47SStNSYU5ouO6RJq4wfsO37dUC0DffBphBqypHu1Xr9gX1HefPe1SxC76jLBKNQS3KNkZfqCqsqqef6amcUjSBeK3GsqA0vBxAw+2RhpRZ+qCXKLGDzG2fQ6EFbFKAPvlBchwh7evpUXpmQfH5ws7Jqth62EKnH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eHnM8uJmvyI/25PdrlJ9Lkt0+e2mLZyfdko+e8gHdM=;
 b=XaaLrvsEEJQRXbYDshj/eEHHLTFHeL3JbRM6A8RLOHzK38jJqpZR+YkO7S59uPEyywVjw2+Fa8sm6T9h1cu5wSJZTs/Almyl3ELdgMrWZswL/WjhTWWAU2Zho+0MlC/U04M0uunJasgoIn6NCWp8X/qoTAxv+5ryhYCuBCcEp4SfHgtrCYzKhAwDLUNNogCx7ZDp4Ro7oVyZKeio2jcpB53DCbmgajHHCKHL8gKJPIi94l/3FV163nthHDgKidb1I1rNNheM9j7vkYEsn7Jjp/ItC6f+ePY0Wr40n2JyEkHF27iKyv5PyMLWbRov+2n1I7Wx1ErrIiLD9SZPHv8A9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eHnM8uJmvyI/25PdrlJ9Lkt0+e2mLZyfdko+e8gHdM=;
 b=o1c6UA1KF5X4EOrqQHS/tsxSPoSE3KB7fJfMGd0zkJfWt10c5u82ga6OEj40WdD7kJKVrGDJ9vjg6tNVRd+2xogiJcEheL6jJr5qlltIqPzPohGgOhrhaDzB45pcV3sghnYGlJMnu6BHqimwoxtE3PZnIRYwxfMWjdkDEAfVWno=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 15:28:03 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::a4f2:aef4:d02b:9bde%7]) with mapi id 15.20.4734.022; Fri, 3 Dec 2021
 15:28:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Thread-Topic: [PATCH -next] NFSD: make symbol 'nfsd_notifier_lock' static
Thread-Index: AQHX5dx1rd4OTcROt0WbUE7C0kd8rqwcg4MAgAQhm4CAAEDugIAAAK8AgAACRAA=
Date:   Fri, 3 Dec 2021 15:28:03 +0000
Message-ID: <2DF935AD-CBD4-4C31-A08D-1C8127700C77@oracle.com>
References: <20211130113436.1770168-1-weiyongjun1@huawei.com>
 <888F3743-AB98-41A6-9651-EFDE5987AA01@oracle.com>
 <20211203112505.GI9522@kadam>
 <0428D783-49FE-451E-827B-6DB8F03347D1@oracle.com>
 <20211203151956.GA24150@fieldses.org>
In-Reply-To: <20211203151956.GA24150@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4582d136-5f15-4f74-16b4-08d9b6717f51
x-ms-traffictypediagnostic: CH0PR10MB4873:
x-microsoft-antispam-prvs: <CH0PR10MB4873D800B378661DE85731CD936A9@CH0PR10MB4873.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1Wz2qXnfv7FvczaoqZSFM3JFxM6SxPqxfu3siZsG55lj830N+/uMMbXBdG/qWdpfGJAGDsBXmTo4Dg/kWvCivbX/Z7WiQhgkM4GmcJ59WgbreinJNaltnb3NgqVqSb2Ia9DolXPcMUyyuOVZCKF0GA1yrPxtk51fUMCYNLlRNjF6KLDvmBjJkNe5RSQkmezV+DLs9EFSg8sp+jnaWiF35SJueOHsU8V9rOw7WUQ+tNLsYtJRRgBvroy0r5J8J5TsEO0OTfAFursMskzlixl35VBaTmk7zPqW89nDit7/Nd2rAyl50NF0BRz+W/BHEc/H6xA7oXeaSEUIBLheLZk8iDrOqiraWYPu14bXFh8vUBFg0gFE16JI/SztasMWPtrj50nwtE+dJiJA5N0MTT2kFhLRIgvSPCtTzZ+3u1PeaflFHPEsrSQQKgmZhT1hJ6vWC7OJeH4YnP4Vau0b+9oTZhjx+mw2Bve6BE6VaJqYdvbFN7MtXQ+pI2u8J9lvNRrouzgH6uaoyCSNawoWfhVuCK02qUlZkEKXkQChVQcbWXJbF7TETE0mWOl8ecuCkzTzm5wsA4UywlD5tzax3g1b5BGJu0I5qtNkgEvX/MG3tfagC45RSGeNomVxFbaA8Im4PpYxuUEIWFqemKQ35FnNU7gkXWNwSxCeZoe5APwecM2Wf5ANiDjegam01hkH+qpEukUlUP7rf0XMiAKYEOynb9vV24fRK60Sl9LoZmJdKbUweFRU431noisuktubriXr+FstWVS/bq+P3ohrZ+EHRgX9poKqUkr4EtG1xyDh+wONrVhtr/urG3cpPnXylOnFvYp81q2OQA23ZsNm69qew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(86362001)(8676002)(38070700005)(71200400001)(316002)(83380400001)(508600001)(5660300002)(54906003)(36756003)(6512007)(38100700002)(6916009)(186003)(2616005)(33656002)(4326008)(66476007)(66946007)(76116006)(2906002)(6506007)(8936002)(53546011)(122000001)(66556008)(966005)(66446008)(64756008)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kPPbNHGNjg68Q9jZ7n6q8y0jIRCXxrk75wpRm0L3jKn1Z7a0bpfrXjztYjb6?=
 =?us-ascii?Q?Kq6JiwHBjPwAyqIp/nd6HDs+6nE7CqEkSnoyTsp3Tzl98DwZVTWsjN9cMg0m?=
 =?us-ascii?Q?gO0Tt2TAfNr7+TujBP5xnANIosakqqXjYeHkA8N5EDY7EMPC49TbOSpJYECb?=
 =?us-ascii?Q?f2J3Q1lKBx+uxsKRNPfhOS2Yl9Mj48RPxdblaDhrTHsq4HGfApCNkkE5Sr4V?=
 =?us-ascii?Q?iCDwo+Gaei8+PQlILf0OzzwDjn9ly9EQvE1XlNMKKTnj19bk1cf3o75fmENv?=
 =?us-ascii?Q?DbshvLcDr5OImomb4Z/EmkAFgT8vOe5E3qKE1VaLDR+OSDOhAO0tXMuhj+TG?=
 =?us-ascii?Q?qVU8GL8RFIc3w5D+3gq4esN8xustPHZTYF1HN+JfCxMwMwQSUsPxkZqhr76G?=
 =?us-ascii?Q?ZVZiAgNj2P+wTrw/ZZLUgni8invrKRfrzfDh01cDf4kORkFtv4iypoPYMFKE?=
 =?us-ascii?Q?o4raLhmUYrLYlOy3feXDqq29622Yb0uBlk9dTqwEQfC6cYtSOM6PajNdbOCZ?=
 =?us-ascii?Q?jTeKFpdy5pS57HKhSG+Rxzvsoj6cFTyD/292T9GMIiw2XiYcLXOEluDQmRPv?=
 =?us-ascii?Q?Wy/XKnd9t9rnGZOr+OxAKO+bICXRr0FD1u87GRDF/otE57uAh/jzGwZrObw+?=
 =?us-ascii?Q?LLLnE5RdtVGCKiy+x4Pb+wHCP69ZZEoqVZzCNS4DqNonxYqQ+fxt9wF9EgW2?=
 =?us-ascii?Q?qI5J4vY5tSFky0O/ibHZYGbvlHVW+qr4bpV522L4er5QJooipu3SHCXe9Zl0?=
 =?us-ascii?Q?Bh2kxprKiUYqCXAFAxe+vKK3zmy1j8JRgrpgTouZT1NrwvIixhcDUvupOqbj?=
 =?us-ascii?Q?w0T9yWBR8SMn+zYwIs7VJBI1X5AgicCOGPowhMIsgODuPcpazemN8TimCWId?=
 =?us-ascii?Q?g4mYJ7hpxiGvT31Wr37ZtNyQCUQ/6R3rcfRkD8Iltv24LCW7H+VUpaBX9G0m?=
 =?us-ascii?Q?mQZVGzS3OjX6oFNbN4IlskQj4ZG5WXEGQU2RCeZorZTbXkXrAJtPFXI9EFze?=
 =?us-ascii?Q?Qc4rEyBXU0BDS4/V/MvZJ66AZOJriDxJZG69sFqSyfCce3rKBguCTWEguJxo?=
 =?us-ascii?Q?aAZo7qn9i0g2xREMCtPRo9ygNX+rbYPwlz7DTXx0xhD+Kr7AfMsf06MhrjjI?=
 =?us-ascii?Q?IdlPY630tEYjL6ovV+lv8Jsm000TPU5/Ivhl35agtkRQBNyDL/cb6myiuvBN?=
 =?us-ascii?Q?RngN9dCqk8EqAKEVS4WbY+NQv5wJybosoj88Fqqv7CDQaHDvSD1CxE6OJ0Xo?=
 =?us-ascii?Q?Q47SrUnlqYo1BW0m21VtOH6nb9ebRucF5eEBHT9FLctUB+dpMZh6c7gJCi/z?=
 =?us-ascii?Q?UOUoYGZn1o37ywARr2Omy0OtjMUg7GKrxQV4mS1thOgCkH0ch0b9aEsDX9qk?=
 =?us-ascii?Q?00k9MjfcGkHi1C16maOtmMOzmszCYfgA+PytTtx4YX8z/lg58Pxvx8J9u/0C?=
 =?us-ascii?Q?+2YU/MsYr4TX9tFh9zd3HPgdoR++AewwpCNSiPioeXMJqsDmdPoRyZv2Ib7G?=
 =?us-ascii?Q?KzOVSkVavek1PbiaOyggTduATVWqPTicYXIhBaPip96wxhTMMh6WO9tCB4ba?=
 =?us-ascii?Q?9I6eTf1HglDq1u23OOYAUj0BMRLOkAaOal9AfsKLSQ/Od8zGnib78l3WJBic?=
 =?us-ascii?Q?eSDQgz/MNNUh8vllOjuEZPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85936C0AAB1CDB4AB0690168B492652C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4582d136-5f15-4f74-16b4-08d9b6717f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 15:28:03.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPJxDQCNc2SM0SqM7uj2x1xISV0TfbcZ+TqSG3DtAujemODT0cCqaH7UEO3YxrkZ9d3tx9Pm1hKRJi6UuvyLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030097
X-Proofpoint-ORIG-GUID: PkzRArbUxVY6Oyr6RaAjDHzrgR5majEK
X-Proofpoint-GUID: PkzRArbUxVY6Oyr6RaAjDHzrgR5majEK
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 3, 2021, at 10:19 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Fri, Dec 03, 2021 at 03:17:30PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Dec 3, 2021, at 6:25 AM, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>>>=20
>>> On Tue, Nov 30, 2021 at 08:19:47PM +0000, Chuck Lever III wrote:
>>>>>=20
>>>>> -DEFINE_SPINLOCK(nfsd_notifier_lock);
>>>>> +static DEFINE_SPINLOCK(nfsd_notifier_lock);
>>>>> static int nfsd_inetaddr_event(struct notifier_block *this, unsigned =
long event,
>>>>> 	void *ptr)
>>>>> {
>>>>>=20
>>>>=20
>>>> Thanks! This was pushed to the tip of the for-next branch at
>>>>=20
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>>=20
>>>> I removed the Fixes: line because a backport is unnecessary, and
>>>> the commit ID is not yet permanent.
>>>=20
>>> Removing the tag, makes it more complicated for backporters.  Before
>>> they could tell automatically from the Fixes tag that backporting was
>>> not necessary.
>>>=20
>>> On the other hand, does this patch really need a Fixes tag since it's
>>> not a runtime bug?  Different maintainers take different sides in that
>>> argument.
>>>=20
>>> If the patch needed a fixes tag then a lot of maintainers have scripts
>>> to update the tag during a rebase.  There are also automated tool run o=
n
>>> linux-next which emails a warning when the Fixes tags point to an
>>> invalid hash.
>>=20
>> Hi Dan, the patch fixes a bug in my for-next branch, not in mainline.
>> There's really no need for a Fixes: tag.
>=20
> Assuming it doesn't get folded into the fixed patch before going
> upstream, it'd be useful information to have there.

I'm sorry, but I don't see how that information is useful for a
fixing a patch that is in the same merge set. I'll fold it in.


--
Chuck Lever



