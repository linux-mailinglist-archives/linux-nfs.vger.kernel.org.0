Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C832458C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 22:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhBXVCS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 16:02:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhBXVCR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 16:02:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OKwvv8002681;
        Wed, 24 Feb 2021 21:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4KE6T40+YvF/hfLP0nXSTILw6jCx8Tw6RQvSf/VYHow=;
 b=c7+R5uywZduimUNQ51aSARKzltmfd4vVvW1tLHv7jmLHrRw0zGqaeWu2G0ZCrWchyZCo
 3JOQy80pmyFaMsymNLHpYauBrXZrw9VzBquT/JfGf7MshMoxEpGGitnXM9NI9eVT44fj
 lf+Cj/aHVfHci0MeZ3YlhEXOaAwSjjn/L5to07PpCsfyyCln46rjHN+H4OOuDJN0LQHn
 tfwX5WAvcA8g62j/SQQERTC85aWWzTYE5zAtesdS3SSNjRsFB0jIkGh3vho3WoEQR3Z/
 bD2BR95bJ2/dOb7eHVD6U5MVcjC4t4Fo9xf4aVaQfWcf+toZTQMplddTO59jxljj0gsu 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36ugq3k8hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 21:01:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OKscs4172715;
        Wed, 24 Feb 2021 21:01:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 36ucb17pcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 21:01:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzDmdy/tcFj4LiXWwDQvYtnla657kat+flebcUlOcZqnt8QIgPrpDOVv93o2xLGRY9m3l6h378lXTq9dcd7aAymTRT9shH7Ae7hqUxuNviCuoxT9zd4XTNuB6u9eKhjNCYm0Pvyq8eGmWsChvxz1cc/45bKRRmn6N51Duxd1Pfu2Gmm3OPElazlAmBJNq9VAggAY7LVoGeTQ4jwG5gISDxrq8Cb17aEndByrHpJ4N9qyEA00oZckux1Ksf0R7gNvsNeGIc714kZ7SMrx2LGgV+lpUBVjRxPAa6k5Nj+fo79YYUqSGHYs32ImxN2Mm6gAJM5SP6QxPH9H8tzO7eCKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KE6T40+YvF/hfLP0nXSTILw6jCx8Tw6RQvSf/VYHow=;
 b=OJcNazYkylOKoIeg46LeBPMU/sX+5LPzOWgGxyc27j5PfCeC5o39iUXpbaGiJ1Jgur8QoNsY4x3iV/3NEDJ2ApEGDrWpd5PKlkk6gvHMJy3OuAoPcEJQ8WJczbikhzqHTNamVyHTOWSU7SQpDS98n7PTQdw+1q92dEqKK7llfB7uufN+XXR7CFPjUCnc5V0VY9//5VthnIRCUeGdW0H+mnE/mRJ59RzmhnNhAUynJw6VSGqXsJ7+LsmFCp+lLJNkvh/GcjnyfYWu8UW2jaxkD21a/t9dcGMusID6Vt+Gg8Qw4C4igbGnY3PNrSeSyV7x8Cmp2gVaXRC2evU1AW91hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KE6T40+YvF/hfLP0nXSTILw6jCx8Tw6RQvSf/VYHow=;
 b=Elpwreqcip55Nu5Lag55XQzSQKNNUqsqGecAuh4Y/vkmsB2voKGXxSP9MiAisuTtdugLnW0/N48NTgjUyOjEVYUKqYv85nBXeDSAdw1ogzZkX/c9BGKcFoIFSYMLEzcfjzyB49U7Uhu3nMQiwrDj5X/TCRlmpwgd+t2u4H7Grzk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3921.namprd10.prod.outlook.com (2603:10b6:a03:1ff::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 21:01:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 21:01:27 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Don't keep looking up unhashed files in the nfsd
 file cache
Thread-Topic: [PATCH] nfsd: Don't keep looking up unhashed files in the nfsd
 file cache
Thread-Index: AQHXBmM9AsfFb3XoEEuds5U8G7v31qpn0yWAgAAAggA=
Date:   Wed, 24 Feb 2021 21:01:27 +0000
Message-ID: <F0281F96-9D2C-4461-BA5F-37FD1A23A425@oracle.com>
References: <20210219020207.688592-1-trondmy@kernel.org>
 <20210224205937.GH11591@fieldses.org>
In-Reply-To: <20210224205937.GH11591@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef464442-4131-4e39-4b4a-08d8d9075a2e
x-ms-traffictypediagnostic: BY5PR10MB3921:
x-microsoft-antispam-prvs: <BY5PR10MB39218B6C40EF2CB39BB32EEA939F9@BY5PR10MB3921.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uytM39O48+DesPLl1Ko/Uiqv8bxlhVM2hYaJAP5U/mRS8ww1bl7yrjsH76qzYntR8SETW3+mPVLaWF+yJM1tp5aZZgfPNtwVVY6jxydJ6JVoeT45mc8YjghlGQcMlRTyXYwQnJvCh0kfdX56r9ns4OFSzzLDzDvTUxLn8V6+v8GipvPlefPapILXFvyIsj5aA0tYdMKBHg6gRqPNc1xgpbZPPunAFwWUQgYm5OI+l5veWJHZSFGv6cIMaIcGfLPXJvLunOAq7IUZuuA/xw9su7ThOgp2+FHzkSfqzMrEGSSq4KaU9yhycn1O5r2O1BP5VvfRGef6r5Kyy03cv0CNaA3cq3642IusM6Syqfrv8uttfJK/ufjxKMx9ueYr3mRXBdR2TAggKZsHo71SABaw2vjSrN7P6F03MkaHEfjHaE5mys6g9u7Uzu5MSoCOQ5igVznCkxwYjK7AqC+Iep0rsb4TGl7Ygaad1iiKXYlTv4vf0IzGk/OyF3it72QKxVgiwPGwpLEeB0cvwFfJJQHGhb5H44dL6j3hw6uGURj9KJ8H8bDhCwkTYV8ImopF9xSECxMWp89fSm1R33gQtLsp5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(316002)(110136005)(66446008)(44832011)(86362001)(186003)(5660300002)(66476007)(91956017)(66556008)(76116006)(66946007)(54906003)(53546011)(64756008)(36756003)(83380400001)(6512007)(71200400001)(8676002)(8936002)(6486002)(2906002)(33656002)(6506007)(2616005)(4326008)(478600001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ablg04AM0j7eHhZJyZHTi94yMGsLCZOmDiyq+0RvD47eMlVLG9zg2UcluSEL?=
 =?us-ascii?Q?WmMmNwpjHlfKx61E3LdHXIpnA59s7PfxPygCzCWs98oNnsFrB/IkgTV1r4Yh?=
 =?us-ascii?Q?lRwXRzOUxP1CU2l4ttLAMs7ZHTUTQ7psn19HGrAgnJUuMVzHcCG8PydQi1o2?=
 =?us-ascii?Q?e88fQMonzkJYZ2DaRsWXF9lva7rNpquNhTsSYhrY+b9zrjjM/1ajf7EAl3Aq?=
 =?us-ascii?Q?18czIfncF1W/fwLu393Vso7RYsHFyA8FAY7UzhZ3Hl2OdjHyMD48mRpGZgO5?=
 =?us-ascii?Q?i0BCbPM3wzDDeYOVVJ/W2fZldg9jEyD4CAbAvLvdN+HE7D9fmmxCUFtvO7Ob?=
 =?us-ascii?Q?/4NS9SQb63VCEc19bDk6tCy7TFYWOYMRTifFh1niVhI4ugRSodlQ66Q88YNO?=
 =?us-ascii?Q?qALqBu+9gtopcHFANzLCOq4K2yrEfhcd3POkncYk1R2+AQpjYzUZnFawS3t5?=
 =?us-ascii?Q?FTEKlWyUQe5MJEcrhe0zEQYYiYjvqWDWlSuCF79WiULdlHtrdGQX37duZSXB?=
 =?us-ascii?Q?fEV+pMa2+WIKcmpeAVXbUi+/7WbpaIk7IRHrTcRvUQSsm7XzzVp4u/65Ki72?=
 =?us-ascii?Q?cxNFiYoWYDH+wVy70c4h5aE0/QbYSst3EUGSoKFYenEGlk0vmIOTrJulQrBO?=
 =?us-ascii?Q?VpM5j6AYjZKFLAjTfa2h06Xbacvt5BCzbgoVnOV8Crs+WeWcJeE3EwIAPhOf?=
 =?us-ascii?Q?O5XREudGB34Z/YF0/y8CUfZVg7LApsAM2Gy4Na4NwjtwIJGy+OdPwF7Apd5U?=
 =?us-ascii?Q?37ze44BVnoGIgjyjcMPMDuaDISFXvY5cdAkUdAOTll7X1CGacu4OE85IOcd4?=
 =?us-ascii?Q?WSWT4DsrceLHRcqUtyIBpdyw/sv6QJ/5rmFjwQxg6hX4bQeke3WmGWTN31p7?=
 =?us-ascii?Q?ftNnMoHU8ZC5yBSE5ooQBzrqqWdKlIvBhFbS1r3+l7nSf0xubm62TbbodqG9?=
 =?us-ascii?Q?x/f26+76e795Xt54V/xSIPl0/31ENVA7lpDUHUfMgs5lQIDt0Ve4Jfn817W5?=
 =?us-ascii?Q?TWL7vUKjzDnd4uTwTJKkalTuTFgOfKDLwBL0YALCseW5/H7eZn+GxCAjqfOn?=
 =?us-ascii?Q?sJL/X7DoTuHx/14KA/qywO2nL5rP/5a0S0HNTFwzARObS8o4keye9bnKnb65?=
 =?us-ascii?Q?GwoqtHVv3L9qI79Ozx4FjMHBe6EjzjQInnqdZsiVl8gss0E1Gw5YeebcMB2f?=
 =?us-ascii?Q?opg8Zii3/9SMtqT1cABh95sSpYENq8THkmuig/4byJ03aKidO4EVwqAyxZJy?=
 =?us-ascii?Q?fsPG2cVUe0q8M1yTfcyThuMpY+HoCN8wDNQI1XWvAQeFWBvumLXfYm6qGQMB?=
 =?us-ascii?Q?Ud4wHTeMyFgQem8X+5O1WWgGhwJIvTJQJNotnMYLr04cpQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89F86B698940F64FB6573ED0D932EE1C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef464442-4131-4e39-4b4a-08d8d9075a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 21:01:27.3090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypeF/E9lod35Bn2WmI/4YRnfAAUCalgDIzIRFDCiaghSqBC5caG7iVVEmHkM7eBSWXCQqmDQxAFHDWiG7uQFRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3921
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=920 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240163
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240163
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2021, at 3:59 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Thu, Feb 18, 2021 at 09:02:07PM -0500, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>=20
>> If a file is unhashed, then we're going to reject it anyway and retry,
>> so make sure we skip it when we're doing the RCU lockless lookup.
>> This avoids a number of unnecessary nfserr_jukebox returns from
>> nfsd_file_acquire()
>=20
> Looks good to me.--b.

Thanks for the review. This is now included in the for-rc topic branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


>> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nf=
sd")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>> fs/nfsd/filecache.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 53fcbf79bdca..7629248fdd53 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -898,6 +898,8 @@ nfsd_file_find_locked(struct inode *inode, unsigned =
int may_flags,
>> 			continue;
>> 		if (!nfsd_match_cred(nf->nf_cred, current_cred()))
>> 			continue;
>> +		if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
>> +			continue;
>> 		if (nfsd_file_get(nf) !=3D NULL)
>> 			return nf;
>> 	}
>> --=20
>> 2.29.2

--
Chuck Lever



