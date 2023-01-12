Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D66668F4
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 03:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjALCh6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 21:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjALCh4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 21:37:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D684086D
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 18:37:56 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C1kkgr019433;
        Thu, 12 Jan 2023 02:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F8g+Pw5cNfTzjxjRv1RwOl5a8xwLuzgz0C5fdvyhb4c=;
 b=Lxp9tqi/zVSnDYhokSweRzBhU0AjrrK7iX7IcPiJcig1oZ1EcmuE8Ut3bedDHY9M6iNn
 BP8k8arG2qHikp/uZqZg8e0U0Qwqwvd7d8pZ5oBLVA5wgZBAG2n8eqk6qxxEe/aBDels
 BELnH5ObIdjABtaT9KvTLumenvWNVrDWRIysWsgVhU8kFQoMKzDk162g6GzvwKNF1mB2
 hZhIIFxO7xB2Um0S8uR++VCZLEEhSZ3I7SCKtTdfMdctjeZkEaVgsd2kb+E6pqAsYDpV
 xmd8pAQ/RBzQ8tky9B7hDLdoBQL8rzQD7TDY9mnv8ksfsPC6o5Ja3/MSXvPnhAbkC0Cv fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n27nr83rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:37:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C0paD1034199;
        Thu, 12 Jan 2023 02:37:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4fuc7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM9sfkjNQLTyf3F4+qQTv/c7aP6smBfW71swEBAWw8YwpQzdy2tHWNr3q9LlkW0k2Gl8ZMu/qMSEQ1P4ZS+Kq5QJRJlFO1+9ajv2kkXEUxyjUgrY/RZppB3eGAZuO7bY/DIXYRpP0Qq8SWxDyQ5MvPlmcF4wRe0DTnuXRibaZpY3WANWzidh6uAt3HWC1ztS0Vossm1B7HeaIXXouC8Lo/0fVhmJ2aHm8X4lYtf1YV+j1p91u04SymAH3TPbtFPztYOyBdTcRyfzW+9clOpkR1sSmh1XA14Rdye+0EnPw4RbrahjcK3VXpdGsj/Ycg2RdUw6z+c4Y5Lf9yJdFgciDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8g+Pw5cNfTzjxjRv1RwOl5a8xwLuzgz0C5fdvyhb4c=;
 b=RReSsvi1IPRWnn5JWrBCmpHjlEAUU94kw6Hx0+0N8GnjdbTlJR4N067XLpJp2sp43C2kJh1+TpYZ1RGQF+y6lkba4zp89yTZ+fHOwhqfTXRxDNt2SXjX+SK7e+XV4BOJlsRQvdNtbyWGX4eDGTwrhprC7uX114mM3nVK9WRhE7cXb/b9CsEWGpxaDkPMl48aSPyPRlscXn+hXPkCCemWExF4Ln6qGl4ckI1qdInekfy4Wr/SQvOtWF+gQbuVwO/UCGbgfwghvEmPorrAmtdjp+IlZU8FBzdsGbYmeXa+Hr35o5WmS7KJrWdHTE1grko4U07gm1rO81eyWnX/us62dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8g+Pw5cNfTzjxjRv1RwOl5a8xwLuzgz0C5fdvyhb4c=;
 b=t2BT2KygUH5tPts2smop1vCck0QGY4CaccOtFP0ePl9+U6H4w1oaVR0PHPqd59avTWusYBcZ8JYOLn84nq0tVvP1YpuIFvaIA6H07bhRC5VG1R0M8raV1oezo6liopMtNFDkj/nIPUDMuvBPu2OjK+6h8h4B6PVJfILLfn2JsOA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7169.namprd10.prod.outlook.com (2603:10b6:930:70::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 02:37:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 02:37:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Xingyuan Mo <hdthky0@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH] NFSD: fix use-after-free in nfsd4_ssc_setup_dul()
Thread-Topic: [PATCH] NFSD: fix use-after-free in nfsd4_ssc_setup_dul()
Thread-Index: AQHZJdlatWNrD7+9zUSB2GYYLTUZ+q6aEgOA
Date:   Thu, 12 Jan 2023 02:37:48 +0000
Message-ID: <02DC2FDE-D0EB-4793-9840-2D9282E1C7A2@oracle.com>
References: <20230111162453.8295-1-hdthky0@gmail.com>
In-Reply-To: <20230111162453.8295-1-hdthky0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7169:EE_
x-ms-office365-filtering-correlation-id: b89da9fb-8cdb-49d1-8e40-08daf445fe49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsvZIAjVH/5qYpzHuRrmDbvG/uS+hXQB6bANY0Bf8bpw4V85JrP0JVI3TRGyqwDHYKEnJc6FWejNb3Lo9glHXRl+s9EAminkbd8G6btisc/V3c7OnMDhKXIPBGDPxIUzyVd/OfLZXh5M19Xty/wXn4F3/AGPCIL81PrYyruY5u38tfJZHN2th/Obr9O9nMPKkTJNcAuWuw/kIZ4dBA/lxSX5SDh5vznogGWBpriDSf97wfcnX8uQ85FWW2BTXobcOqsrbMj2zaAeiPl05rpjcQqObdbwpCn0Ck+j5F7nAyVoNzFYRbk3rJHuc26w/s6MmporN4Hl3kV3su30fqiF9Mm4MW6YYBeWeSIXYCeSnXe86ItyCbI3dW78JlM87eFprHmwEj29MZFIzDVf+qCmIdexnx1+OyR6+DY0ytA03qTMgzTdyjJXertfLJKwHpE05xROMtFrIjY66nwq0OOM26ugBxdsA2FYUlrUsEzlTB39/P3M96zASMReo+i1EMw0x7IDILJpbC2U4A1duXUFQxP9MnwlliSZajQQiV+HQrYnwjeADpEh/7cpvLX4VZT7SyzxPNDni08fbcDaz9ku0lzwrwcAXDSQ/a+a1Z4ywWP1/FG+5YBHDVKcbGVo61VSs1E8Efjwysz09RoSBp4Oqv6piuoAJjAkKLj5B3AaGQyixjqlrSqp9ahvungGtyi6SvNDdHMbEKOXr+6XAbdEe3hRh196XcgQsutR5EbXf+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(2616005)(54906003)(478600001)(6486002)(107886003)(36756003)(71200400001)(2906002)(38070700005)(66556008)(8676002)(6916009)(6512007)(4326008)(41300700001)(38100700002)(316002)(8936002)(66946007)(5660300002)(33656002)(6506007)(66476007)(86362001)(66446008)(64756008)(122000001)(91956017)(186003)(26005)(53546011)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eaz1JY4otU7A95rb+WGYHsslysIYApQC1BAYkBr5emf4Yi14D+fHGAYFP4HM?=
 =?us-ascii?Q?vUBHFDLG0j9CogYsyLUcPSG9lCBaviYr0iStF6JfJ26hehXsSc9ORNlGg40B?=
 =?us-ascii?Q?4KYK7M2fOLGKZPVQ3cKGV+19g5vM3prrMC1Hyk+/FIFlamOhwjdR+2RrzbGP?=
 =?us-ascii?Q?GcXzywGH9krleLMf5jXKe/NzUgHb/GYRDB7wudZhd96IdANOiLdnBhiYeJaR?=
 =?us-ascii?Q?UAccl1YZ4/2fCm3daCXvB/j9pJ7xF0eNDjRqUARMlo202GNn2KiFaoTm3ECd?=
 =?us-ascii?Q?5GpqRRSuns/Yp8BB82NRzSa/JrUgwb2Q63Aho85L4VNKgwiALINOLI6i2Rtf?=
 =?us-ascii?Q?9uwarF/eGM2ZQQBc1wPMSugVSSTb/Zku+ZHFSFBvKBYOKRBFENFGKSw39CKl?=
 =?us-ascii?Q?/ls8GHn0L59yVLbQ0ZoEg/Ts8bUtArazIJrBhzCBPPRnA7vFLavWM9CgZQP0?=
 =?us-ascii?Q?SfWSt3BvaNfs2V+U89y7CKOixSousQk2xjHxanwpk0eLywqRpIyWnn500mzh?=
 =?us-ascii?Q?YECC44b0TVCq/tlBsYIIkoydXV9GZOn8/Pm8H/EmsX7KypIe0j4xWiJkEsHz?=
 =?us-ascii?Q?5wugEM/FDkcS8762t59GLxvCkkh09AhzCnuzPA83EJQvhX791tMOGVsUifq2?=
 =?us-ascii?Q?GkE+fpKfHWHCKWommsSNig7dEkT+mQgqMO+rxSm8QiNhTK+V6lHjlE5QVv6m?=
 =?us-ascii?Q?j7owLun2C7/npDtqKMXkc+xiKo7+zgvppFsuPIA840Z1NNo1ZIDsGqrvmh5z?=
 =?us-ascii?Q?VmOKvrWXXkn4qeu2uU7MOrcQrxZTV2Dz3QjKp+pwIWBkwN6hajjocbY4IIsg?=
 =?us-ascii?Q?eT4n6izSWLtpAT0VGdNMInE1KzzusatVSjVgCsCM6AlL5DB+OM1gV/73XhcW?=
 =?us-ascii?Q?t9KMH/7b4zYNkmniRZeIWA9YH7KKsDs5OJ68JTf5euvqgamwLzQkETFrtHEn?=
 =?us-ascii?Q?CTz5SpoIYb0dgMxb2s/JTZI1dFqGNLENalrmRRnl2yDmuG5zQIy9Y+JNnRKw?=
 =?us-ascii?Q?JdIBt8ryv7OdoOLea1o0Jz6a9AcV8OyrArPiMpJR0tq9tANul6f1MuIrAucO?=
 =?us-ascii?Q?y3kVxXIgNSm3+/75kzJTf5r9v+n/BczHpWmooMHIdSHDbJXd9XJAw52ybhaK?=
 =?us-ascii?Q?FYTOXx5SXVZPvN3Vm2UpiH++ZBSLUCzAlky3l5BZeV3/2yF/0+dZelIOGGbo?=
 =?us-ascii?Q?RmPzbfufS5NRB7GDEmLlNueBF38jQDAIF1gOemPQxcA+kcwMeGpNoVFjQcIs?=
 =?us-ascii?Q?/70sW10oMJP1WxQl02Z8bJzytaKjqp5ktaxt87LrRtTxnL+y5jcQeb4ZUmRe?=
 =?us-ascii?Q?2tSTMVlbw77g6PlqxQ0YoYOxU0y0vQIjTCQo7l0fSk+AHl8CiY5vfDGpE028?=
 =?us-ascii?Q?dXzEVw86KiEVqrZVwHoDuxjkDYcIt5Ep8qHd4RlHDHIFIVMzMa+6SfmqKA2M?=
 =?us-ascii?Q?ig3Dp53257FsUBuh6+fc8MZy+A9WOSL/4qqLJJgnUYyUB6+39Ka506iZ6mce?=
 =?us-ascii?Q?F14KeYMPpncJ1TYuvKldipMZC6ZTU3ARge553g6CrN8d1knQF6KBplLWa3iq?=
 =?us-ascii?Q?Okj7T3X7MXc9vWDzvKGUG59IZXcLT5addZ6kLmNl49xbFS7s9NiLdb3NyV7F?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <885CFBDB71432746A84D360A4E98527E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P5gQZgGCQXy1pK9jNX7k7nk4vTdFHj2XB1w2UHlZEEvTMGihK5AEWwCErKrFoAfnekpEHbWB8hkU7zX8iKETON8OX5i4xKinmLV+5DigYRrAivzYTH5KEZTZHDoizRWD3obj5Zf76SG1RF8G1xO/gtNL/uejq2fy1tcSsXL/SgK46K6WwUdK1nBz0NsfsLX6jBBign3gL9Z0GAXJA82OOgNvMgfbnUMyXT8hp1Hzd7QYzbP/BffX6oUO9t5CyKX03rv94jmzWgJ5EktFI443rqC28DM0vF7cWJQYvXYfhTvOFKG+A0m3KVGHmupGnxHiUlv2qcZ3xquVa6AMTV8bwso1j1XqroCXZq+7hZRljWSz1PH3hl/QkOhGaP9S9ji71Br782CKtwF1glT40EVp2Y8V7s6kBM5XAzfB/HHRr2UQIGpiZnff1QzkAxn/oKEzgFmoDOWBMzPYDxxNOqvkZK8XVA06KcHl4oOcWuDU3+IlEX84F2GFIuq1GW28zgXachTcrxkNNjrDAMK3FT3vVfc8crQ5kCDgIrgYg8SNGNa3nAcojSLkC78TDCDjxCksN/LadNNFxgsYRuzJjIjpjFZHmjaZiDKZydYt2PLpsLhtq2pSqvygl9cK2wLsKuQL3YkoJbQgEUZM6NJram8mc0I1iW87Uy0SugF0/30pGwKbdLioyA+/7nq9Agi6kJ3yIPis9pwVjs8rHuZTmuYtbqhiCD6wg+LsA3zEbunkRGK9qo8aNGZJjWm9uWnLueC19urPOxoozwadsTyQ6+U9EjJahcY6rx8DzX3+vNuZ2poKMjTgrVaPAi/r0Sxmwr5I
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89da9fb-8cdb-49d1-8e40-08daf445fe49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 02:37:48.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZMUkliuVOcbJMO3MCUXSm4B/7udR7NmRoslVSIp1DvWGBDWoELDiu8hDEtac7qAODgV3cCwI1bQnNgUKvEpbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120015
X-Proofpoint-GUID: scdXJY8wDxMzIGwcEEQakefVC0RIk2t0
X-Proofpoint-ORIG-GUID: scdXJY8wDxMzIGwcEEQakefVC0RIk2t0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 11, 2023, at 11:24 AM, Xingyuan Mo <hdthky0@gmail.com> wrote:
>=20
> If signal_pending() returns true, schedule_timeout() will not be executed=
,
> causing the waiting task to remain in the wait queue.
> Fixed by adding a call to finish_wait(), which ensures that the waiting
> task will always be removed from the wait queue.
>=20
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>

Hello, applied to nfsd's for-rc, thanks! I expect to send a PR for to Linus
in a few days.


> ---
> fs/nfsd/nfs4proc.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index bd880d55f565..3fa819e29b3f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1318,6 +1318,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *=
nn, char *ipaddr,
> 			/* allow 20secs for mount/unmount for now - revisit */
> 			if (signal_pending(current) ||
> 					(schedule_timeout(20*HZ) =3D=3D 0)) {
> +				finish_wait(&nn->nfsd_ssc_waitq, &wait);
> 				kfree(work);
> 				return nfserr_eagain;
> 			}
> --=20
> 2.34.1
>=20

--
Chuck Lever



