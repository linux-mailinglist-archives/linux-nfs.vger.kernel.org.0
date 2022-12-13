Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5984F64BC95
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 20:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiLMTAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 14:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbiLMTAn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 14:00:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B52528C
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 11:00:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDIiNn9028714;
        Tue, 13 Dec 2022 19:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F4irU/LyK8zwVigpnxqpxlyIRkZq5zx1GssHolhjLvU=;
 b=M6kNi9yrGqMii7d7x4zkCQ3lt+XjuNRrXWPOcs+U9y4zLY/CvdEOMU1Qmn5aSZuOzDgg
 0ygnQZRGI748xWeBnN0xsSCvap+u2+pl7DfWBb5qRxo6jk8bIdP605Gph1FhVe0fgXBh
 NT/jLS+35DQe/hjxWPwFzSV6ANH1J1KU76YtOPegKYdf0KQVJDbhI0on6WX1/ULC+UjM
 b6S5SQnmcPE9fDd9pNZ57jJSG/GD6na9NvNBpkdfNqFxlxYF3/DVnb3Y0UCyQCaMulVJ
 S4G6gGhydSuK6Q50SMsex8yYFx9E/LkGBfM56ujNWt186Lt+4erFsyXvPq5A70FO5/wQ HQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj096627-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 19:00:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDIB7Ko006601;
        Tue, 13 Dec 2022 19:00:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj69s09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 19:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah4QstL4zExa0TTk2cVfAJhQ51X57vOLFgGKC7QhYX3vsN64xe6Nk69SNCJDdWgyqng+odmeUSOJqkDgcEep/0ZcjKgk7ZkpzapDBHtulm+hdPgkgXP+KAIiyxOlSjqmumqgUyoSPEYNxxrSTzgDKnfMc6q1OUALOXwKal/3Hes3F3SQ78qQbyXadhOwNsNB+kM8KZvNoYX5Qwq9LSQq5MXq/ko1RSI2NtEx2x/VSvZJvwmfx5aV2c/f2s2nT5GWuuS0OlkIWxgEe2ZHCdkmmyarxaho+xs7lg2KzMSZcvvqWSs8N5vOtny2D4Ofrom95jdCtNAjAH4mLorKyqU0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4irU/LyK8zwVigpnxqpxlyIRkZq5zx1GssHolhjLvU=;
 b=gC67GnNo1+ZTCidObgcohLZ+1xtd/u87A4cMUbM0vaDIG74bwvKLjOjestv6cCCLLCjyjO1QRavqjnq0sYViLFnsilkjAh1PDHACDh2+SPMUk0MTsWx6dS8r/4wSnm4QBIwIjKM4+vLNTMMStEEVZfJVUkNxFf+LfFOyxB1/5PVVMU7oQTYaLgMi1P6ac/4CGcCT+y4g1nlNo0cKsIT/md/eTHuisCWpGNhpqx2NuIQXT5PcERwpbuNrNNucWEoidGSV6FJq45+5UfMMuvj/4eUwy8HbinH24ukeuykzz/71WYZahY5fKBZP0yCt7qjsUUNGHrRHHmCs19IX6XHh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4irU/LyK8zwVigpnxqpxlyIRkZq5zx1GssHolhjLvU=;
 b=tl6ABhD532+7RhmiCVogN/gUyKjz632k3smY9SjGOh8CNs+qq+wiG0gUDl5w0m+v1Fvz6YMV/BdW7e/QtDEL/WTCMqyYuJHq8pqxSSLpLyOZ4ZGDm44WYwuRXslcnZZQ8ZVjL8jlQde8RJz39+8o9VjxR8+rGgtUEhkQimQejEQ=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 19:00:25 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 19:00:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>
Subject: Re: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
Thread-Topic: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall
 timeout
Thread-Index: AQHZDx3smN/KyreXA0qcwVX6hchw565sLBKA
Date:   Tue, 13 Dec 2022 19:00:24 +0000
Message-ID: <0918676C-124C-417F-B8DE-DA1946EE91CC@oracle.com>
References: <20221213180826.216690-1-jlayton@kernel.org>
In-Reply-To: <20221213180826.216690-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|DM4PR10MB5966:EE_
x-ms-office365-filtering-correlation-id: 0a6a9904-9cad-45b1-d534-08dadd3c4a7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZOv5/3Slq4CCiyKE8F/anUwz5mNISh7AWXfriABKv7C962RJ6wk1jz0P2t+tMNr0bSeujcPpFVWR/DKJtJ5MiQT8y/KStIhJbC7FuCywMSdMwm6Ho/a7RtKx2atvqP7t4lSKHBhsw9v1kVtMIANUPTAnHR+lbl4kKliSFRHZdXAAI2h+fUJXr2hoaHxTwEVzRcgds3FdYoWZdK3iuMWVRjlodThS7AUpy1mTG47aq3SCaxOcrjEFWakFCx+dsy1EK68wzDDUeVQ0dd+9lokS4KlYuAV0df9Y/nDqJjRn+tr0Tpjie+jCu7RImT9Pc6QELGT6eN1MgCTrQAPOm6JeH5qWlAFMd9fiFZzZ2SLDM9uY9bU6xfhOw7iOsJdiyEuQbePFZHXNdYllpkJsw71p9bht7db346kmqkrw6B1XmoXGNnDy0ibgw1CeynAOyzDQKL7J018TZVB0KO65uqxLHCO/fLr7+1g1yWC1cx1Bej6C9H/g2lKeu8sXQDDFLupdJUo40InLgCY57LXvY5Ut3mM7n9vixM8k8KTlmE1YUYfXoMzYvf9vIz3rtagwf1Po/yOOhjnopVf8Vti8i6iNNXX3SxSlov08gfRv7JS6gm20yEeadj5ANeWWDA0LJPLklYGB5IHwE7M6KS8D8GtulhsSFSBWK0q7u2DHwVwB7NDbbPQRtUcQ76XYJ88hFH7St/SOwvzDt1wObbY+12ZLU6KzvK3ci6z9koiPrhLUIzFygAPlr8kFqWVyU68Z4czF2Aqv27WIWBI9xPkryYBFR7R0ZwdUPkQkJtcIGXT41bbXybTvbgonXHXGEOrh8S/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(5660300002)(8936002)(316002)(38070700005)(6916009)(64756008)(6486002)(66556008)(8676002)(66446008)(66946007)(54906003)(66476007)(26005)(36756003)(41300700001)(86362001)(6506007)(4326008)(53546011)(76116006)(6512007)(2616005)(186003)(83380400001)(33656002)(478600001)(966005)(71200400001)(2906002)(122000001)(38100700002)(42413004)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TH5kL1mGhYqg0RzVeLJs4HumZQNmbWtCTgqyWO7SN4RSFoK03gld6LoSRPmU?=
 =?us-ascii?Q?25cwhAvmcEUft+MHDf8N4noO7XPZx3Rj3pvav6G6E1eM7SS+j+saF+NppQMW?=
 =?us-ascii?Q?6Qi5QQ8urcylVWcpeoTAU0R3k7XSaUVjXwxBgS5NiZHSDDNx4ZxBQv4cZj+1?=
 =?us-ascii?Q?pS9dd3RwtxDRKL0a5KOo83IPvu6Uq4SvUTgrjHKpysHFvXGVpJrfxfnscVF4?=
 =?us-ascii?Q?9JTAxzrgKt2d2FznFS55pzcJYmH/8SIVf20npHlC6E8sWbe+br0pkbz5Z48C?=
 =?us-ascii?Q?JxPytdwn58mOpPRaI/PjNFqcohhTUJUqp7/RPNSYX8dG8/7/cn3LAul0XR3T?=
 =?us-ascii?Q?1GgNShg17D66jd0s8dfxp1z06PZsG6KmDPRKyg1zXNLyyH3b11JoL0hTso1H?=
 =?us-ascii?Q?Iu4kpJsOIIYAVI4BI48SKYtj0cdWwk6rsAYClJRU3Yv/Pq2aaTlKJYppMT2/?=
 =?us-ascii?Q?L9FWLzQR/FMmJjUANImtzUQcRwYANhuLUq5r+C2HJjt4iMlsvN+8y65+bV5n?=
 =?us-ascii?Q?r2eU6J4CIG6Vkig3v0h7noqY46cBD2pk8x7YiQQFSHggdb4q+dX4H6lOsaUv?=
 =?us-ascii?Q?NIp8rByTMUGNNiCyfJsWZkZ1/kUxUlRTJ4fLfqIra71lJ/9ddowGT3Sf2PUC?=
 =?us-ascii?Q?Av9YQ9T2V2OFdDyVynPchid8WuQubKSS1kg4muTaGRPyllptH3EAZBF3kasd?=
 =?us-ascii?Q?EfSq6yG2tunoY4AxYgrx65z2pkHA/k6e+1He3kx5MRVG4VV8s3A/60D0Kg4o?=
 =?us-ascii?Q?yumsV/LgjPGntBCs53lFBA6WakkWwBPjzscGspBIple5uzlK5etjPcj7EFEn?=
 =?us-ascii?Q?7/2ICR/deBYItyvp/tor4EwIQUo0h059mVgMpfO8r1y9E4UI+PBFChzkQPQR?=
 =?us-ascii?Q?S0JybtgH3Ot+AL4y5cG5jfCRfUumI2Kjqh+KlwbtPgxdNOpZ5YOkIsiP2O/O?=
 =?us-ascii?Q?Uq2s8Ca801gK02I9XoF5KXE8I0RAb92Pw3jtQCBQKEcdwHUf1pbRHHc0m0Rk?=
 =?us-ascii?Q?aFZ6LATRzTgVETcljgDs0LB9pv+B8C25CPZlTEvV5zHMXOqoPMUk+l+WgTQC?=
 =?us-ascii?Q?KWndPJ0eBFRWDIsYQ6qykQt4TyOC13AEGBPPLKe5VHvxvIM7YYHEQD4CPjXB?=
 =?us-ascii?Q?nbzzeNNZ0dYy0ELBUaCGqmi8l1x0wv75NcQXbJTvPeuKmM2XXxhmqccBx7Af?=
 =?us-ascii?Q?EQZrMXjIRHWQ5GPNHRqMphWKjm0HEYX6bF9sXuJbxnxzp7W14xu4qiA6yrI7?=
 =?us-ascii?Q?Kdp5Oe7pwaNwEzJ/ZpuOY7Hue61g7YeRQ1mubn3JKhWpM6b+2nikeX5Tgs5B?=
 =?us-ascii?Q?iPjoweB1/d6yiLKdAk3KrAQEOzv57583gOUNpU+P+j+KbeRzGKquZ74oQlrG?=
 =?us-ascii?Q?AaX59iPsoAHF6az6YdVQPOBSi3Z8v0EBrURSiquAtRAXaQ2d0mCdKvlKC7wX?=
 =?us-ascii?Q?ctgz7dC5daz795+b+DfBUuDMIKAqjZe4Npppk177V+SJ0b+t+OL9XdGVDtTZ?=
 =?us-ascii?Q?OJC2KE4cXoggFAX+Qyx1QKHBTfNSGthShvU6LWVYqOVNVATIZ/vyIFKMitJs?=
 =?us-ascii?Q?J99AiqA/GGSH/fhJTnLjW1i5LNbgrXcsW4Xx0d1N3NG56Z6tBierg/qR4/0F?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94F117B2EF02CF47963B4CF64093663D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6a9904-9cad-45b1-d534-08dadd3c4a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 19:00:24.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6utBc1Xyn3ISK9UjLT/FwXFapQU1Fk4Ilw03LyyO2pwaI483lnaf4BdMKDjm034HFYGdHYqSIXxXDSgae6BLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130166
X-Proofpoint-ORIG-GUID: z80Ei6E9gFuUaQyU5wanrvBvHolcHkhh
X-Proofpoint-GUID: z80Ei6E9gFuUaQyU5wanrvBvHolcHkhh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 13, 2022, at 1:08 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> If v4 READDIR operation hits a mountpoint and gets back an error,
> then it will include that entry in the reply and set RDATTR_ERROR for it
> to the error.
>=20
> That's fine for "normal" exported filesystems, but on the v4root, we
> need to be more careful to only expose the existence of dentries that
> lead to exports.
>=20
> If the mountd upcall times out while checking to see whether a
> mountpoint on the v4root is exported, then we have no recourse other
> than to fail the whole operation.

Thank you for chasing this down!

Failing the whole READDIR when mountd times out might be a bad idea.
If the mountd upcall times out every time, the client can't make
any progress and will continue to emit the failing READDIR request.

Would it be better to skip the unresolvable entry instead and let
the READDIR succeed without that entry?


> Cc: Steve Dickson <steved@redhat.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216777
> Reported-by:  JianHong Yin <yin-jianhong@163.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4xdr.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 2b4ae858c89b..984528ce8d68 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3588,6 +3588,7 @@ nfsd4_encode_dirent(void *ccdv, const char *name, i=
nt namlen,
> 	struct readdir_cd *ccd =3D ccdv;
> 	struct nfsd4_readdir *cd =3D container_of(ccd, struct nfsd4_readdir, com=
mon);
> 	struct xdr_stream *xdr =3D cd->xdr;
> +	struct svc_export *exp =3D cd->rd_fhp->fh_export;
> 	int start_offset =3D xdr->buf->len;
> 	int cookie_offset;
> 	u32 name_and_cookie;
> @@ -3629,6 +3630,17 @@ nfsd4_encode_dirent(void *ccdv, const char *name, =
int namlen,
> 	case nfserr_noent:
> 		xdr_truncate_encode(xdr, start_offset);
> 		goto skip_entry;
> +	case nfserr_jukebox:
> +		/*
> +		 * The pseudoroot should only display dentries that lead to
> +		 * exports. If we get EJUKEBOX here, then we can't tell whether
> +		 * this entry should be included. Just fail the whole READDIR
> +		 * with NFS4ERR_DELAY in that case, and hope that the situation
> +		 * will resolve itself by the client's next attempt.
> +		 */
> +		if (exp->ex_flags & NFSEXP_V4ROOT)
> +			goto fail;
> +		fallthrough;
> 	default:
> 		/*
> 		 * If the client requested the RDATTR_ERROR attribute,
> --=20
> 2.38.1
>=20

--
Chuck Lever



