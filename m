Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D54587149
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 21:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiHATSb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHATSa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 15:18:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD8F29F
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 12:18:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271Hs4JR010181;
        Mon, 1 Aug 2022 19:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=U7qPTB5P3ZiZla2jxzxqdsew4H28IHP7/SaJbnMROoM=;
 b=CXcqoeSwzvMUgRdk4+K8lwv0kObFtalRLH8YJHZfi3uJdX+VjEzjS1LrP8xD2Ef2Jfuh
 WtEC5ABKuElDqfBHnmCBcN3D6jVgcn2BbBDGCUy6wBCQ7uNSMsrs2svOIhOLTL/jgOsS
 gQQQzFe373f3Ra2nKa7MjyDQFj4ymECJsrBgCGQHlI7pF3actNY08S9sPiPg/YKZ/P7u
 3ZUiCbm4melRJQ3suk5VQGJpUqdqbmlkdgN0c5+CQFS0ZxltsbSdDof2aHip1gMwRtGr
 RiiWqUOOX4k/Be/ygvCCP8et1xK16e4GEpjAaXE3Oy0r+JYmfHQaAxLFxIouv/eQpboX rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2mqmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 19:18:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271HVW7C014312;
        Mon, 1 Aug 2022 19:18:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31ma19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 19:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS9iGLQ5htms3grjsfefWZ3Z3Fr8B7N2UaxGNTVFaARfEzCIoKg+h2+yDJjVhWNd0Wc8kTDlyFswP6bZ8KzgIcinZo/zfJ/mgiTaqI8cCO57daYo53Cjrfi6bAh5ZxrQZH0mVqtlZuJTQnKeoPaxxQ1WJmPxfExHgyxPoueD5lS9iCbEtlO4KeYMKdvxK0P0ckODynubmza/jqhqW82l+SKrlTBfwelCPTeRsp7pPkoMo0rckHbULH+3Mkt+X/QizppRPhU15Ru0EbNbsxb4qzEC5YA7Wxbif49T0KN3amSF2pNXC/82AFvv9Tzgl9wiPtcDCJavZ0QJmpi4Xz4QCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7qPTB5P3ZiZla2jxzxqdsew4H28IHP7/SaJbnMROoM=;
 b=bvSzDAupUI6vMu9c/NlR3H8ZNVs8P2ZJ27OWUpK0Z4CvGU+QrICkA7/6fGSXAaQZsvuanRa8fb41mea2pZr9MQ2iePu83TXAm4WSC7lXLvviF/xmd2Z1xIe0U+L7poCHWF1eaOirAHsYYuqj9yU+YyQe17f5l6XjQjVzgYUESMRc2tyNAxBXIMfHYzYOEFfNGt5evvhLs+Qe8kuKno8rTjAVsfcRoaVU42UOgPMzCLW3OE/LBbVta1WqVoqwh7ceZELGElhqrx9R6Z1vUzzufnG7Rj/9uWdUywe07JPJni+/tzZGnufiKnhLK8fAq/RFrALjVhpScAJut673bs5agQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7qPTB5P3ZiZla2jxzxqdsew4H28IHP7/SaJbnMROoM=;
 b=sNrB9jlreX6XHhXR30Wx+VIUzcGGJwX/BdSloRiLhU094PHaf44K7AmvjORKfG5bblquJq3NEHCqnlgAbvyqeybmB8avnB4WUEJmeeey8f0gKHPkK18fcPZqUap4ZIUrOyoRwlnVc5/RizSKi/Avp7x3grUHj+Xbb7goAdaLjNE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1585.namprd10.prod.outlook.com (2603:10b6:404:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 19:18:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:18:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jan Kasiak <j.kasiak@gmail.com>
Subject: Re: [PATCH] lockd: detect and reject lock arguments that overflow
Thread-Topic: [PATCH] lockd: detect and reject lock arguments that overflow
Thread-Index: AQHYpcq2MEaCGFN5/EyCMrMShco2TK2aa1SA
Date:   Mon, 1 Aug 2022 19:18:20 +0000
Message-ID: <1DB7763E-BE7A-4123-8AC4-E8D154C07DE3@oracle.com>
References: <20220801171819.125532-1-jlayton@kernel.org>
In-Reply-To: <20220801171819.125532-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 416721ef-ee84-4bc0-95ea-08da73f298b2
x-ms-traffictypediagnostic: BN6PR10MB1585:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUmS0ag+Jb7O3vhFiebkT8yXIKZUhsd4gPE2Eg0HnvO5eRn0DiYhH53XHoydVTnfwN7z2tojH095LYPoWlpS8SMshNj4iiVSEvm+iPqFLomQrD0cpfYK3O+pNtEj7gMYUkuJ0Y9aNMGUb6fg0O5/6puZH4dWOrSqc9W/WkmAwt+KBN64zYIXNnkB0OBzw1ICHbPIxxyBBX2da360dDJZzvCDXmddoRBBH6HpRLTBSJxHMaBLEXnBJrEwYfTbHmG5AsXBdyNPXzP9YaGfFnEcOco6Q7ZDeHh26+yEnZ4KDYy8xbZDcozUQdMlpggUD9pkuH3VNUaS677lkZQwfJ942NeKpRtlIgd2ciLhHQb3GlVYBfS4MryVscrF2WWSPVQr5dfBJ7pYkuZJqI1w7V2YaUa9DUSE7vrTZ9v/HCKhtb2v1iI/TMI4Yvkno6M6zbyR6lnEVWbx4CK9pxiohkOzIoMDGEobVEphamVjvXK9gjtdp4hGYw/uRt48prTF3UYQ9/tzLihB17wS1mB6kNlGScEdgaWtVYsw4qreyltNqCLDGLaMQR4jgi79nCTrpZCvQEntWjsdYkNp+TDcRYfyLDkNrfTu2Iue0kmlZIn6aNR1rTWD9TevFBHJG0Dksqz3LHbqeIzfIUARTT8Ni0WUm2BkuYVrEqZ/iTwTCKWcFYl4U3AH28q48wCUzY3qNiIVlyOeyO2YU78Y38Wu1nCp5UUV/eRBno7O1WdnkNx7MZHKjbzQ5uN5yl1dNOW1sBXOpKe7SQRZlVohkhb5cFXp9dR2YRRt+7BsSDI/9HWrKv1JKRUWRZQbxHXNLuAdSta/K6r0g92MXTWEtdaUQj0v1+Bz+ZLIbw8l8NauxAUHY3ND/RKW1/m+wQSyF0kGmM7S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(366004)(346002)(66946007)(66556008)(36756003)(76116006)(316002)(8936002)(33656002)(5660300002)(66476007)(4326008)(64756008)(8676002)(6486002)(54906003)(6916009)(66446008)(2906002)(91956017)(478600001)(122000001)(71200400001)(86362001)(6506007)(26005)(6512007)(53546011)(186003)(38070700005)(83380400001)(2616005)(38100700002)(966005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j3DfiEXifj77Zx6TNRsLm6oiOM2I0LGqdSEaioRpQY17OylfCce6c2FQKl2D?=
 =?us-ascii?Q?qG0eVsamVOG9QR9LccRzVl3uQtYH5zhNm/wguscY7Myc7ORBAzyResIfGjQ9?=
 =?us-ascii?Q?UFitElPZsmLaq3GdCIqXU7tz/mW1YmN4ToiTRf1dlQ/3prESDVxkr5gsQq7U?=
 =?us-ascii?Q?AqLzGK2uX+5sHJYR/0tLNysxpHYRwhSJX/JPYuNRPUl2Lz/mCpI8tJ/thppK?=
 =?us-ascii?Q?o8HWQv6csts16nMnbxONGsazJHKBDkqcd0vX/IQAl2PNxYB90pNaUUSCRO3B?=
 =?us-ascii?Q?w3DATaZjJCi2quYPfJRXSLrLEOSRmmzOxhidjJNtg5Yga7wZBaTNMkDiXiVX?=
 =?us-ascii?Q?rZ0Zvq7lxSS2ypwPYnZmhs2dHc0/bB8aekSlbDrK5wxMD3ktA9OVsCUgqg8f?=
 =?us-ascii?Q?7F5uXIBZQErL3fYn9vkQjiE3Orfk+ZsYJAkuehUAvGuvDf6nN9ywL1+7IG3Q?=
 =?us-ascii?Q?UUg1XVb1tevw5dqxXp8TQg07gG2ihUefjdwws52DZ5bLQeOZBRlyEwslT6Bu?=
 =?us-ascii?Q?fb5Zxcz0k2Weg8075V0TaHx9GzuOv2X4Wtcx75bPoS5awlaXfX5lqH6CB9SS?=
 =?us-ascii?Q?lE+mLEqIk0qlIg49ypPxFDuFMlGWjIwAKOivfqaV5BhfxyyqvDHjPA6MwhhO?=
 =?us-ascii?Q?dokTFtp9vge2oY66yXcvuZASjJDZXtI/JpPe5Pmpk/Y2lia/4aVownxvnoF8?=
 =?us-ascii?Q?uTl714fKmbVv7maiYRP0DuFld1j06gsdqeTgNzHux/6yYLl3RvU9lAT8Dwgf?=
 =?us-ascii?Q?dTH8TjWJfZbzZ2ZzS0FAgrQPEVP7m09Pv3zzXsBUTo4z0VdqInj7qglsYZUP?=
 =?us-ascii?Q?e99MBYAi0tgtplqJ2yivG/H7Ed88gYVK7e/VMvZuwfQBsATowphPd2/zFvUg?=
 =?us-ascii?Q?uXYkmACIGBI/4E8kEvMLAPjWnL4mvRar8Wwb0q2KlXaA0NLxV5hsNGdddPYW?=
 =?us-ascii?Q?U8q2xDW4VDSeXJYL0Fxink8AfgMdFIuxqRP66PsPLIPFPNyxSHnXcg02JPYK?=
 =?us-ascii?Q?PBSD64sdOSO0ZPYAz+6e7We9pmTRBSIunVEc3b7Cc/Xr/sEywgZSmaDx+QPn?=
 =?us-ascii?Q?BYiC5seOXrP7dfVNQZONEeFxo42WxwYH3jbGKbL17IS7SIVSy02uzzGjUZQ9?=
 =?us-ascii?Q?aJ21M1t1ag04ubqSSyavtB21tsrVSiPVBLgwNRcgBhgT+uLKplcoG6e379Xe?=
 =?us-ascii?Q?+dH6ZTQvgimfe7qCZRqUhz8d3psh3L3BIAX0hoJCAQyx4tvULiJVml+4wgBN?=
 =?us-ascii?Q?swvQc6MiJUQp38vp5Wm6O1tjo/FR0j+e27w1p9a+I8tguw02gVGYC+qLBmoF?=
 =?us-ascii?Q?hqjkA7ST07KQ3givhlhjXhhEgAsxsAWCs0RDXJ+/R1DBwYiGSrToMxIjELeA?=
 =?us-ascii?Q?wgbFpkhrdBwSaWwekv8Tm6jEX+ZYLF+EzRiTduYF3A1gLyxOSoWJo0wksMda?=
 =?us-ascii?Q?liFV6YNMfYRY0/sqAH1srOzuU9w/zNDGB0ZYHYRMq5FHYJDhJ8yGGvk3x2B+?=
 =?us-ascii?Q?OiQDlKgDeYSVM5BemXDtSmksIuKMsiIJu8AKss7mkhMfhlcznUjjHxMar53A?=
 =?us-ascii?Q?RdcmkSih0OXN1bI2fmovGWcg3xhwJ/1y/47NPisgr6PicMKqDkfviVcJQi+S?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C666B8AA94C01244A6FB5F60456377AA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416721ef-ee84-4bc0-95ea-08da73f298b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:18:20.7154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VoCxFfyjSdrQXs9plbw6EH3W7PzAQzIcDb9R6+Jp3MrohMbvXTUDXe1zh8l6jcKef930Q4SRmGEg5eoN8XD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010096
X-Proofpoint-ORIG-GUID: LW27RmJRdpqAdPdvf3bFt1DYwOOOnGrb
X-Proofpoint-GUID: LW27RmJRdpqAdPdvf3bFt1DYwOOOnGrb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 1, 2022, at 1:18 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> lockd doesn't currently vet the start and length in nlm4 requests like
> it should, and can end up requesting locks with arguments that overflow
> to the filesystem.
>=20
> The NLM4 protocol unsigned 64-bit arguments for both start and length,
> whereas struct file_lock tracks the start and end as loff_t values. By
> the time we get around to calling nlm4svc_retrieve_args, we've lost the
> information that would allow us to determine if there was an overflow.
>=20
> Track whether the arguments will overflow as a boolean in struct
> nlm_lock, and test for that in nlm4svc_retrieve_args. While we're in
> here, get rid of the useless s64_to_loff_t helper and just directly cast
> the values.
>=20
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D392
> Reported-by: Jan Kasiak <j.kasiak@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks for tracking this down, Jeff!

I've always felt that XDR decoders should be responsible only for
parsing wire data (syntax). Architecturally it feels to me that
the conversion from protocol to local data structures should be
handled in *_retrieve_args() (semantics).

What would you think of moving @start and @len to struct nlm_lock
and handling the conversion in nlm4svc_retrieve_args() ? One
benefit of that would be to make those raw values available for
BPF and systemtap, for instance. I'm guessing it would be about
the same number of lines changed.


> ---
> fs/lockd/svc4proc.c       |  3 +++
> fs/lockd/xdr4.c           | 26 ++++++++++++--------------
> include/linux/lockd/xdr.h |  1 +
> 3 files changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 176b468a61c7..e781ac747961 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -32,6 +32,9 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nl=
m_args *argp,
> 	if (!nlmsvc_ops)
> 		return nlm_lck_denied_nolocks;
>=20
> +	if (lock->overflow)
> +		return nlm4_fbig;
> +
> 	/* Obtain host handle */
> 	if (!(host =3D nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
> 	 || (argp->monitor && nsm_monitor(host) < 0))
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index 856267c0864b..fd5de5481a6f 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -20,13 +20,6 @@
>=20
> #include "svcxdr.h"
>=20
> -static inline loff_t
> -s64_to_loff_t(__s64 offset)
> -{
> -	return (loff_t)offset;
> -}
> -
> -
> static inline s64
> loff_t_to_s64(loff_t offset)
> {
> @@ -71,7 +64,6 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_l=
ock *lock)
> {
> 	struct file_lock *fl =3D &lock->fl;
> 	u64 len, start;
> -	s64 end;
>=20
> 	if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
> 		return false;
> @@ -86,15 +78,21 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm=
_lock *lock)
> 	if (xdr_stream_decode_u64(xdr, &len) < 0)
> 		return false;
>=20
> +	/*
> +	 * We don't preserve the actual arguments in the call, so once
> +	 * the decoding is done, it's too late to detect overflow. Thus,
> +	 * we track it here and check for it later.
> +	 */
> +	if (start > OFFSET_MAX || (len && ((len - 1) > (OFFSET_MAX - start)))) =
{
> +		lock->overflow =3D true;
> +		return true;
> +	}
> +
> 	locks_init_lock(fl);
> 	fl->fl_flags =3D FL_POSIX;
> 	fl->fl_type  =3D F_RDLCK;
> -	end =3D start + len - 1;
> -	fl->fl_start =3D s64_to_loff_t(start);
> -	if (len =3D=3D 0 || end < 0)
> -		fl->fl_end =3D OFFSET_MAX;
> -	else
> -		fl->fl_end =3D s64_to_loff_t(end);
> +	fl->fl_start =3D (loff_t)start;
> +	fl->fl_end =3D len ? (loff_t)(start + len - 1) : OFFSET_MAX;
>=20
> 	return true;
> }
> diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
> index 398f70093cd3..a80112d18658 100644
> --- a/include/linux/lockd/xdr.h
> +++ b/include/linux/lockd/xdr.h
> @@ -39,6 +39,7 @@ struct nlm_lock {
> 	char *			caller;
> 	unsigned int		len; 	/* length of "caller" */
> 	struct nfs_fh		fh;
> +	bool			overflow; /* lock range overflow */
> 	struct xdr_netobj	oh;
> 	u32			svid;
> 	struct file_lock	fl;
> --=20
> 2.37.1
>=20

--
Chuck Lever



