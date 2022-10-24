Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F160BD28
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 00:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJXWLS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiJXWKc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 18:10:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CF47A77E
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 13:25:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OI9IBR032293;
        Mon, 24 Oct 2022 18:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Dp+5whhkG4QQVA0if/XWLU/9DJ1mZDaskgoBNDADzK8=;
 b=EfTYkfDsYuXICJYE1S2OixWESgALEeW527Wmqc5htII+ir4e5d9og3BduhMmvLB7nVl/
 eCBfdGCC4sga+93huNy7iTEIuiIWg9a6+an81aHo+89WiLQZGiAY201ZWYSFW7HHgZmx
 AyEt3lv16G+sxanUDWsXo64MLN7V51pyux8zMm9FaDmvJn5U+r3yxAGC6NB3CR6LWEXX
 aLAAiYh84rb/Z7xYAmEZUK7HZm3ZkOyQQcKVnAzdmsWguYUnXh5JMJ7t3VHc3T5gmxpz
 7WD/zCUx3YtzkRKPy/s59CZIr5raFeWI21xfr/AtAYrLyZXLQFW4knouS8ZkPeDD9dWn KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84svhp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 18:43:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGRDbt034042;
        Mon, 24 Oct 2022 18:43:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9ng0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 18:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+dSZzAydkEae1GsDX2MV9gxKCYqj8L/raZhCUZckgyP9Fv3McfWuRbttnHz29CWSaVcsAC6YlwTlj0MBQI0FilNV0YjR4RfHX7oHdziJVuwHwZ3HtDi52zpUoew9V8sxmBdl/A5FLIKavlucVRwVWg+gDksNfcb6ylX86LcSB+ce7Nz91uH5mvVIP+I4F0AtWLjhFwHAxhDGYL5bZamZKWWr2mWuc11KkIJdMoxaKr7HYelet2VR+wn7xDNfEmzy9dg0tenzLipB0SlO6I2Dy1SVX05WhGPG7qPvwH1hX98UOPVyWjcXY46lRa5Wk3PAUYiDiPhFcyPDHMApE56bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp+5whhkG4QQVA0if/XWLU/9DJ1mZDaskgoBNDADzK8=;
 b=aLzGjs7QwtVi1eAgmV1m4Joo9PBP/A5mOuR5ZmpvTJdSxYRauvziGhcFqbFHY8KPuONl+fb7HLAQm0jJ/T6O2I7bDPiSDSHZHzzPynSqDyI2E0ykq+F+1z/AYTvT+v51hkA2gqSGlMqJpQrdwy6etnq18McS9YGU19/AOe3QyOhmEC0oYVUno3VDtz2rpYDYTrQPOjZDxaGwSN9eHz95kaJNg7RyjS403h4NOxITZgLUxRs/f0kM83fVKGqDVHDeMS1Dl8HM65MI0efb2DdHm6zpIufdKFqm32HHx5MCNzfb6K7Jq0DjMW9tuNmiUks9svQlQ2poMczpDP8xAmnitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp+5whhkG4QQVA0if/XWLU/9DJ1mZDaskgoBNDADzK8=;
 b=bmSESLNgdFSPOzdXD0koPNxH+ABf2Rx3QlkY3W0X+eT+NILQ5wc+LDkqMCnBALCorYOfij5nSwfbeMe1lrLp/sRXDqFzZfMZVP6W3Jtaih/tGbJERolLa5UFXkh+aZxV37+5UtjyBATWghBjsaDZFhj9kveDQJlzVpE+oKet4m0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 18:43:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 18:43:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
Thread-Topic: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable
 nfsd_file garbage collection
Thread-Index: AQHY4ywL0+TmiIKEZUCtCfoSHjd9zq4c28YAgAEOzoA=
Date:   Mon, 24 Oct 2022 18:43:10 +0000
Message-ID: <030F4BAB-6042-44C8-AC20-B1503D8A8004@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>
 <166657883468.12462.7206160925496863213@noble.neil.brown.name>
In-Reply-To: <166657883468.12462.7206160925496863213@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4835:EE_
x-ms-office365-filtering-correlation-id: 3eae7eae-d116-42b7-6d3f-08dab5ef9987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSByRCLj2tikzH4yl2zNkJMmyS0Jjf9RPykjLYwvmqK4mIkmgJ1t+2YAgwB29cosb/L0hk01bvjeZmtYO10ZXcHm7WRDZ63CGKtx6iZt9xA+a4Mor+C+2k4uIxLOymR+H92c35E3wDtJ2huGhHvulPT/SmXTXUdECUEvb7Bm1ZRjhyXiqnIT3fKmRTTCezY98tctcyBbVbfiuRZLLU0uy2IgplXEBmB9lUu9cRp/W3SkejLdgypI3DgTfnmueJ3eLzWC1q69xpXiYYT9nnFFAiCj3tr8QS7bOGc255CjHCpwny2Klma5cpSTdKl+OIww9dyBm9XZqkZSKBdqwg1M65Y1bmF6Y5APED9t6BBkLtopIMEdf9FwMOYEz/ZWUkSzX40uq3B6lpsH4Pf+gKd71Sx+M0MjmlFuhJy7MoGnMC6qzENKeDGjRAw9NgxxUW0cVIYmN5ncCNDBEvUs3eKSSTIrRDenEmhpA9cyc69i5Wupn4aLSbOrcb3F16SImQME73KgCAxnBVNl6XsKq7IhjPyypuQioKdyLfKJk3tYU+MlMVb7jCsNY0aFWaLPjbqbd9IXRjPrFeYhiKCeR2fZBE4JdCY3q8UJgQFaq3imZd+UKc3oPpPMQSQfxwzqDSgt2mtL/zDAxlcyWnKUGzfQ6qoTAKkGa9nkRT+oWO629FbUbOhPOSQuZG2DYYWswr5wYSNzwABR9vYd3efaoZCjj7dIbFQijpbcPqOv5okIry//YcXaipUv5NnkrRYqE6kfVE4dXGXSKlQlGX8jM/PPM+sLdV9kcoq+K7FEqMOz38oQh+msc5J5ReJjw8UjG/bzB5qz9KVE2O2TCKWzHHl2OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(66476007)(86362001)(66946007)(66446008)(64756008)(76116006)(8676002)(91956017)(4326008)(6916009)(316002)(8936002)(5660300002)(36756003)(83380400001)(66556008)(33656002)(53546011)(41300700001)(966005)(71200400001)(122000001)(6486002)(26005)(38100700002)(478600001)(6506007)(186003)(38070700005)(6512007)(2616005)(2906002)(66899015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F+K2v4h9+O3EiIDC+hOOfeUYrAnSVxMOFB+Jf8a6tEJ4qw8sn3X9nnx451pB?=
 =?us-ascii?Q?gzbFxbGbuS1MChymy6TtmRk8bqq2ZfPZm1H00ftKz+45Kf+Ir+Q8nuk07dwv?=
 =?us-ascii?Q?lr2/U8lJv96MOVqotScO7VXosH+NdC2Df2AcqEsaZVzDGbiDKt3/4z1p/G1+?=
 =?us-ascii?Q?bdIZsF0A4UVBfXyq6DbwOx2WQ6NniBTQNVyjfMGu1SPvEuINquW/0Au8EgEp?=
 =?us-ascii?Q?lOi7frYrqk6wBzlAaJO0b9kPV7ThWPjQ0j7VGlXC2mCS3MqINhMW+tLVo9Fy?=
 =?us-ascii?Q?p9Lgq5vmemui31U/jLiaI2nSuUA0pOspw6TxUeFlbQk/PZLIRUqLkpGdQjPi?=
 =?us-ascii?Q?nZRccDdwYaiwMdaPY7fGzN7B7GqITH/Vdd9XzqIckGFwW7WfeuzASLwPwfXQ?=
 =?us-ascii?Q?KQxEhMzM0sBA/RAPVDkHrMg2+QCdYwBVXZ0naVaeP6KpSru0U1W6KSLEhsmA?=
 =?us-ascii?Q?Wvy9sxPQFac4k4VerOPBGTe35uzsPtGOnAn0CFxM+9z2r/dbNofM6HlKPAsk?=
 =?us-ascii?Q?h2TGuG/YOcdMCv/EUAzBS3wOone4/ch3Cpv3VcVGzDc6MVyWMFBzRkF95OBm?=
 =?us-ascii?Q?NW1/wLiGS03l4nXLHQh9BPJOXP21m6DsjTP3CuVdAQgh4UeN8gAQBvNMOA/m?=
 =?us-ascii?Q?pCmM8ktuf1P+BoSziioJXei+OT+BDBA0NcelF3fQJoXpeiMjhia2UwZNEzt9?=
 =?us-ascii?Q?4KlKZjuzSPJBvbxBOpcgG7PZpQsZN/tdn/7+IhcQ0a+F363pDRx0IolN2OET?=
 =?us-ascii?Q?53ONVc0kWAjak9Ua8xayE9k8to9lMIE/hkUlZCGxnPztqeKppAoGiXiyIU1q?=
 =?us-ascii?Q?RRJNMiJJmqunsr4U7VgkVeUU31RvA5TaV9xwedylCNU5YbBVU2uE77oDCFBb?=
 =?us-ascii?Q?Q7tvpA7Tp9YSifgUk/PaFmyC2y8jTzCeB5iUH0uNm9RUeuz0a2l0AGyIKq4R?=
 =?us-ascii?Q?dfLGAhJuFGoRmG0vc06VzVELqzfP/Zuk5V3D333MlfChR+p3eKPWPwDdw6VS?=
 =?us-ascii?Q?JwSO9x/jarnbKSCVR42Tg2yjedK/fGmUI8BOZ8aMuBzpOHR9Ioz/ZKM8jz4m?=
 =?us-ascii?Q?bEYxotldxKXdcXQZ4r2JtI+B+oLhm05oO+9B5XPqi0ZzVFOwNeqbi9gnRsO0?=
 =?us-ascii?Q?WB7mnqtRuMjGTOv4BKSr4mFrncWwJY9xE+GDk1dIx3+6HcECiPROXRtVkte7?=
 =?us-ascii?Q?rtJBQR/THd2YOP7i00BAcV60JY5i77bnYJ2+D8/nuAcUrcrotUv0d9Q/sKuw?=
 =?us-ascii?Q?u1RKVb9zpnuhAhukAFM5MsxD4MOYcl6/rD9iajbmSNVnna2RlA5f8fnGdf/u?=
 =?us-ascii?Q?uIJwQk0mGsk/gfDHGGL2NGlKg9yXDZAtgYSRHgLiTxFHgPnc58uNrB9SORuU?=
 =?us-ascii?Q?tZ2gLmYqzT5k9UmagUYq77a23bGE5dx9eRshlwyaYvmvcB2EvNqxDnIjpuIZ?=
 =?us-ascii?Q?janmHBNdeS7tmQki7CfXxgRzE7QbgJuws5mLzAZF/YkVLErSGA742/vzV9vQ?=
 =?us-ascii?Q?54wMbdrdy5nUUIZ4kbvbOu32t+Dp62nhquCiaAK8NE4IJSWbaF5jf4yK1Ogi?=
 =?us-ascii?Q?7TzwhyeuzBHANw0Wid0oSIUgfmAanKXfqYv+mUZrRHJEhPacjQbRyWItdS6e?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5880BFCBDAA5C4094F0DF82E70C02C5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eae7eae-d116-42b7-6d3f-08dab5ef9987
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 18:43:10.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCd1F6k4pD5Ku4RdE+rqEVWOfyh2o+sITVMAiSDezP77AX2wz/ZNM+mdQxAQ5fmkoiyNQwGPqZ5oaakxWdf6hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240112
X-Proofpoint-ORIG-GUID: LmNJLbD0OFaIrh8PobBCwRgbA8-5azQJ
X-Proofpoint-GUID: LmNJLbD0OFaIrh8PobBCwRgbA8-5azQJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 23, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 19 Oct 2022, Chuck Lever wrote:
>> NFSv4 operations manage the lifetime of nfsd_file items they use by
>> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
>> garbage collected.
>>=20
>> Introduce a mechanism to enable garbage collection for nfsd_file
>> items used only by NFSv2/3 callers.
>>=20
>> Note that the change in nfsd_file_put() ensures that both CLOSE and
>> DELEGRETURN will actually close out and free an nfsd_file on last
>> reference of a non-garbage-collected file.
>>=20
>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
>> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Tested-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++=
------
>> fs/nfsd/filecache.h |    3 +++
>> fs/nfsd/nfs3proc.c  |    4 ++-
>> fs/nfsd/trace.h     |    3 ++-
>> fs/nfsd/vfs.c       |    4 ++-
>> 5 files changed, 63 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index b7aa523c2010..87fce5c95726 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
>> 	struct net			*net;
>> 	const struct cred		*cred;
>> 	unsigned char			need;
>> +	unsigned char			gc:1;
>> 	enum nfsd_file_lookup_type	type;
>> };
>>=20
>> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_com=
pare_arg *arg,
>> 			return 1;
>> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>> 			return 1;
>> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>> +			return 1;
>> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>> 			return 1;
>> 		break;
>> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, un=
signed int may)
>> 		nf->nf_flags =3D 0;
>> 		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>> 		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>> +		if (key->gc)
>> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>> 		nf->nf_inode =3D key->inode;
>> 		/* nf_ref is pre-incremented for hash table */
>> 		refcount_set(&nf->nf_ref, 2);
>> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>> 	}
>> }
>>=20
>> +static void
>> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
>> +{
>> +	if (nfsd_file_unhash(nf))
>> +		nfsd_file_put_noref(nf);
>> +}
>> +
>> void
>> nfsd_file_put(struct nfsd_file *nf)
>> {
>> 	might_sleep();
>>=20
>> -	nfsd_file_lru_add(nf);
>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
>=20
> Clearly this is a style choice on which sensible people might disagree,
> but I much prefer to leave out the "=3D=3D 1" That is what most callers i=
n
> fs/nfsd/ do - only exceptions are here in filecache.c.
> Even "!=3D 0" would be better than "=3D=3D 1".
> I think test_bit() is declared as a bool, but it is hard to be certain.

The definitions of test_bit() I've seen return "int" which is why
I wrote it this way.


>> @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
>>=20
>> static __be32
>> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
>> +		     unsigned int may_flags, struct nfsd_file **pnf,
>> +		     bool open, int want_gc)
>=20
> I too would prefer "bool" for all intstance of gc and want_gc.

OK. I think I've figured out a way to do that and still deal
safely with the test_bit() return type silliness.

v5 coming soon.


--
Chuck Lever



