Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00161613BED
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 18:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiJaRKc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiJaRKb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 13:10:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F23812D0E
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:10:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGxIEO001214;
        Mon, 31 Oct 2022 17:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+1GpPHvfTJ98kZYDlhxOBRGxQH5y4YBaW9aG7l+X48I=;
 b=d/xUlJk5Y4MikTE2bW8LefkLl+R8ztsoHTkNa+7J1qumFKKMu3KBS1kovCKpTFzlADmD
 kX1noCIb6HSGkTJD99jLKiIzIwVsRfeLbK4a/pO85sCXbcnhsrlymKtat/VRO22mmkv3
 2g32g0vKeHfAGgPzsBifYAipQ08Z/IZPF7lS235Jft9bfi57zxihpUBfeuTJds6sXokR
 Apw4XmDCvZXtGy6mTgLAzXL1rQ11VMeAtteZ4v1Jv5RznhxhzKmfb+HlScpW2w7Sdr2L
 uA/K03vBaWiMOHjECaFOD4+XmyQJDyfzwH6oEMWEZiCFTWsSuZ/jg9C8tEWfqmBVBDnj aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtca2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 17:10:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VFEQnn030922;
        Mon, 31 Oct 2022 17:10:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9hu8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 17:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUWHyeyaDrybJe51du4MgwxjMxMrAMqqzMY1q/xd5NGiH2WlKOYp7JMAL7wO/d75fh+gEIDV1BitJNeleJQqJ0KbIvxpaBPL1cbu63RNGewvp6pHajw4ebOgLFR4AL2dHqNX/if1yZWUsukeJhi/WQ/xFCI4RGI0t3pNec+1cbaXpbwAcuBR5EV5rYLS6pjYFktL288XUAEDGgtcx01QLpfFV/729hPNVF67fTVrUI7Oxu01I/nNQ1ogZFAJsg1pXK1sksYDQQ+qMysy0cWtcog9O5vHxkirBN95rKCGAe/Q5ZHIhtZN3/mNb9TIykAgkNjx2YzNlJCBKsiUoywHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1GpPHvfTJ98kZYDlhxOBRGxQH5y4YBaW9aG7l+X48I=;
 b=kjJ7rKymQGq5eJE5fJTEg1AaJ1Kt1ZsLRvxXy3AomkhBlYoc7XumtQG7k+fF+H35oyzS4MXoLsvQcVi14m/1Og4EJ3PkIrHB9GiZJFHLblT4NY15J4q+pd6PTFlS+ucL+VsIgJfWnoLIR16hhXRqW/YimPbacnAomnxN3UgKcIaT7f+cHxtqjrxLjONfr+76DS7Spw/q2eQ56oLIqa5QKrTiSGTFlHfiS9mA0WKgPbGiyYqF96AejMsdNUT5H8M4cIDJ5e90DcKfJoRdr+X22KO5ij2ZoCRzb7jF4z+kBVKFhMgE5UF1mfSg6bRN3oWAlKDDOGo9zXoGIF8EAfmHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1GpPHvfTJ98kZYDlhxOBRGxQH5y4YBaW9aG7l+X48I=;
 b=dZQwNYBe5B0AZu23Ze/svjHkCrLav/qgbhGREiXG/GVgNG2U22WxpEFWFZGRltvaNkB+zIcCc+07mKRhmIOYkRmJxULcah1VKDPCAj9IvBHRcgYXi4FbEDDMwODzwnkUudlcgS32InQMD5gFZiac/C5njVFfgIH5S9c/uqgLDws=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 17:10:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 17:10:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Thread-Topic: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Thread-Index: AQHY7UBdjy7EMWQZjE+yKRdZMx04Ya4ovM+A
Date:   Mon, 31 Oct 2022 17:10:21 +0000
Message-ID: <BCEEEF05-11E3-4E31-BDE1-DDCA65A5AB6F@oracle.com>
References: <20221031154921.500620-1-jlayton@kernel.org>
In-Reply-To: <20221031154921.500620-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4950:EE_
x-ms-office365-filtering-correlation-id: 68726618-eafa-4bfb-e9ed-08dabb62cb5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6wcM6h3f6DY4t2EuttpqtrkplgRrM3MFDIV/QzpqkmJFQ7UcCgtO/ukF/OJuYIPJ9Cc9PJASGv6zXeyl77y1POarRteFta7PBLj7ASnllCiya75bjISZmieKIM3Fw11TW0nHJNndIfqq+TMsn4MO5ez7W2bmsFAvL1MRBJ9ursQmNvbY6or03e+GB/QY0/Ch3iYX7NY+/+Mne0Fv2xmU8qBU1Jy29MOneG7W0cxZk/1uaG6skBHvRmjHFokVJQr5XqzEu82DWcZIDZC6RGNiNGeVZF15khAPF+6iaxqYYqVBkP1+4b8Ufb00xldZ0du+aehRgSDGbaogVhd2EWWgmFO0gR9zdOA29B0O2Y/B06DHoQECrmobB+kLdrcyGlZd7dvnZRevLKuUhM3jTcYsttgOkr3o2jUnNjQaJNgjmt54FZ11Mm2Rui4n8p7mFiVjrWUitL6XOvJfbTM70lVY+MsJkwHrYY8o+HRTK4XUnQu7jbuYk77u72WsDspYdDWoUTSdvX7QSukLctzaN29Q+k3uun3iMyvfmE5SD8etI0T0G9onYyY5m6Zy1N8jLLoWYUAsHtHDiKQZldxbB/Xr62CPiwFeNfr8T+pI3N/KOIQpaI86zH9qvUbGWPqwMtNMDxQIDrecsXOZd2Ffrhc8dkYeLRwNzgUn0LD7/1MqUZjBazkbGEpadcaV0ZslaQvyR7j5ozO2xBO8I45VKcMlbnJmGbnb3BiZgohh8yC9Lu1gT2vlqX+YUym4ntnQ05yeEA1grXlSZLin7tMfxdA3/xmB7UUiUsC+BkknCa5qHgA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(83380400001)(4326008)(8676002)(64756008)(54906003)(316002)(6916009)(66556008)(66946007)(66446008)(76116006)(91956017)(66476007)(41300700001)(5660300002)(2906002)(26005)(6506007)(478600001)(38070700005)(53546011)(71200400001)(6486002)(186003)(2616005)(33656002)(6512007)(36756003)(8936002)(122000001)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FQXxzb6aEqyE0ELpM6m2fSRzHGymw1zTps0cF8Nz0FF4tefr2V8csNOFKcQw?=
 =?us-ascii?Q?z+IxRlvshnvlkJ7r6zAaSwTFvM78g7PXK2imcLNSg8G1b1dU218a1zxgLbG6?=
 =?us-ascii?Q?bC7lQPCW5LhXf5zWetqn2iMROQo7+o7QJ3DBJUdzuy2Ua7QOcLX5R6yNWkTA?=
 =?us-ascii?Q?ICGiqa7nHBC/4wpTfJ4R9mbuSVR3P+D83uw2EuKqSy/D87m8z+Xz2m3uAl6t?=
 =?us-ascii?Q?WT15G2v+Y+CBnHeXbyvC4ASuKqNQ+hbfe0vO8qSeIdWKpOgKQ7grKjoxhc9s?=
 =?us-ascii?Q?q+OIppHvFcLPm9llMT/w6RccovVoC9BLKKwlEal4jsOgdRb8fPUYKrqpKrvp?=
 =?us-ascii?Q?Wa+c+qEWW7Qdq4rxuwI1RMxycLnAvXcxzNdx1wgR/FwRTiGkMrghemf5iedK?=
 =?us-ascii?Q?oQf1sQL+4nQJj9JW72rWUoHea+J7DqxvjHBY7JoFQfTQKWzrJO8nFEwEkteh?=
 =?us-ascii?Q?kq+01aXm5qJNPvdEE2BLYUFuuCa7MpaViJfgp0BRqXzfzIDx+l1zI4SkMlfy?=
 =?us-ascii?Q?z8z+euvu3qNhMXtog6fF2ZTTNgMD6O3nqd3yASIrpZ2dh/Y3KFBVDgeTQ66x?=
 =?us-ascii?Q?C6dU0NYcp++jlG3+uglJhGKrS4kiJZcbtCZLWScUTljfHU14tdg2jtYUqpl7?=
 =?us-ascii?Q?NnNT8ahUg5OTvNLviLmmAAMlZeQnlqZAVJKlEOceOpbMRTIQm4ShV+2SVZcf?=
 =?us-ascii?Q?9OpqwHFh6PTkzwaVu52NzCf41jtD51192GA0MVG3b59WlPsud+GRBRoLCvf7?=
 =?us-ascii?Q?/tAJFmNoBqiHLzqSoifPFietTCv16JaycTI6rp+GJbH+RtmNHClhqS0y8eBd?=
 =?us-ascii?Q?+ZS82OiB7Y+7JC+F7nXCTrpxqXSxPs/1lOmMXQB/tWO/jfeamicuM4qCx3Bf?=
 =?us-ascii?Q?gIVfAzELXdwNdzQTo+JZC/OQygtrZzHmoXGWOqKZWGmotjnkhFAcglD9JMph?=
 =?us-ascii?Q?32GOa/1AbzdeS4OCTuWC8o0wpa8S4Qpjp6cVWLGBoHJffjHcfc4a+V6x1D6e?=
 =?us-ascii?Q?Z5zSJ9ah1OiLczU7t7KKfIIXmKS1i/btqwqnaooxAoX3JcaMvnpP2JiGPjOX?=
 =?us-ascii?Q?4zDw6JigqUt9wrCOBvW5d5Ny4xdCkX5XTCTve7Qz6Fa1nvRhtiUmxM94LyKe?=
 =?us-ascii?Q?Fm2+xJDjOkRDmwtQnE/eft5v0CO6NziGAy6hpCchWzo2K10QFM5wLYOSG3yf?=
 =?us-ascii?Q?vch9NgcgVDsb3/Bgv+urnEvlw+A6VMhd8omloCMIS8SVm0HZOvoJVXe3+7Tw?=
 =?us-ascii?Q?S+S3d1HligeFFYlUMtvMhdYE523dEWhtYZaqYjKup1icWI5sIF7ckDivK/dD?=
 =?us-ascii?Q?JZ52dvXJDb90+pGeZuJsCLCkso1YlCiiEiy3uFP5QuvidJAEJyNu9oVFNqMP?=
 =?us-ascii?Q?a6HA8xOykP1PR5RowNzCVB0FO4tQUruEPnzdfkKodWyj48A2GTIwemZrkGc3?=
 =?us-ascii?Q?7QbO9s/A6uJOShKu31PXnBQDZv6/9q3x6J2lEAobD0DSIr3CjpWog7TNttzW?=
 =?us-ascii?Q?mATVv+IhMRM58sIw5pmQ2S/KaDR/QW4rZNH8uVX0hSAbUPys9i+/Ip5SU7EA?=
 =?us-ascii?Q?lXyszx4LG0gVfIUAPEWiKSZ/g0tUojER4ApUCi4nZOjwu2ObtEfybPijB97j?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC11F18D102261478DCCB1F2D8E47197@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68726618-eafa-4bfb-e9ed-08dabb62cb5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 17:10:21.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mcpsqDQ2W13I6hSy+uBBwJJ1VuV7znW3KUsob4ubLRVHiPJS7GmDPrXcHShxYZdM1Hq2zC9iYT3aqPGwiftSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_19,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310107
X-Proofpoint-GUID: K8937BROBIlkGV6ZzV7DxC0nQ86giQRh
X-Proofpoint-ORIG-GUID: K8937BROBIlkGV6ZzV7DxC0nQ86giQRh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 11:49 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> If the namespace doesn't match the one in "net", then we'll continue,
> but that doesn't cause another rhashtable_walk_next call, so it will
> loop infinitely.
>=20
> Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
> Reported-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)

Thank you! Applied and pushed to for-rc. I'll send a PR in a few days.


> The v1 patch applies cleanly to v6.0, but not to Chuck's for-next
> branch. This one should be suitable there.
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 98c6b5f51bc8..4a8aa7cd8354 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -890,9 +890,8 @@ __nfsd_file_cache_purge(struct net *net)
>=20
> 		nf =3D rhashtable_walk_next(&iter);
> 		while (!IS_ERR_OR_NULL(nf)) {
> -			if (net && nf->nf_net !=3D net)
> -				continue;
> -			nfsd_file_unhash_and_dispose(nf, &dispose);
> +			if (!net || nf->nf_net =3D=3D net)
> +				nfsd_file_unhash_and_dispose(nf, &dispose);
> 			nf =3D rhashtable_walk_next(&iter);
> 		}
>=20
> --=20
> 2.38.1
>=20

--
Chuck Lever



