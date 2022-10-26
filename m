Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BA160E1B9
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Oct 2022 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiJZNPj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 09:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiJZNPh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 09:15:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390DB4363B
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 06:15:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QBEKdQ031795;
        Wed, 26 Oct 2022 13:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vsvGgnpyNVEZR3em9ghzICyE6HZw6WO8LbQdZAdd/QE=;
 b=RblMDcT02WcexC0ILxUFQ1aOzrV78H3I6n6FuJjB3rwPsZGmZ9XxhrJKLNOH3P3lnd5f
 MYx45ttazNo+wTo8z1TbR6uL6HF3i6uh+0aqYwe/bxQo1ftxdNLoOI3djmhxb1ubx/KG
 YoF85QADfAWJ9u67sYgTPtd7cWBMO9IWMHt5HQJC6svZYQf0Bfqlx4VB7x5BAtwo+5uR
 Jzq3TjDHDhfG0NFhQDLIHJAum0ZBNxqMI1iwicWOfwyE2huMKfE4sTdhMPE9XNjgQ66Z
 q2dKt3UCYZvRDj2NfRINyEHwLBWGmxIwsrK5c/y3WICXrITYgdEVAtrBlHeD+EM35b4m Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a36k9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 13:15:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QD1UrM029344;
        Wed, 26 Oct 2022 13:15:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yc1m22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 13:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6eVD16Kn/pi5Y9Tb/BopCs41AihCShAigY1OS+fx7tE987VmPSd+odmSuSvagbHJSsPAK3pFULO+qT66Tkzk0ecs2HjDVvmgiQfa5SDRbp0OKYJAXJDuglv2XKvSFJrwX8u4I2rpuvI0RHIASz0zGNKAFSG9XrmudDIwEbL3njzDiSsko1C9vhTvyBN8WrF9nM+kkj8gPq6ebcHxdKE6LbnYliN9bAYmwpY6SQtLnOe9WMcw2UbLywaJu/6RXvvgPcHcPoN4BSIIuBcuAaR4uzktNCwP2NaO6rr2aaseWVi2RxaLghThEk2LQNimTTbnRkPHZ6cYFZEliO1GrG3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsvGgnpyNVEZR3em9ghzICyE6HZw6WO8LbQdZAdd/QE=;
 b=Aowqjf6n5uhImeV8s3g5EzUpC6twX1wtWwH5faC9Qm9j4zYoaF6MBPB2HWhG80hYk5hPdBwsc6j7nTjyKlwSpUvz9Q385mL3l+VYwL+eO72TwN8Amg4GOzwYIA0s4+x6b7jyo4mvtYQvQbnzkMrUumRhp0c6wb9qMKUmiOG0rb4yWGem8DT7Hpb5lI7va6FXwtHiQ+7Z+nZA4hTkIbEtLbayeZSJldBjhC+5Qr6piZJVAFLwfz4NFbYOdsAEVuGA/Ps9Zn73wJUOGMxrqEwIaHr5L7i/8cE5UeKrWfVUqMaVNujfgFYskTMku+CSZKcfOF+27OZOWDSZevikINqzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsvGgnpyNVEZR3em9ghzICyE6HZw6WO8LbQdZAdd/QE=;
 b=KNHJfe120uFv44MDAyC0+O2IFXNo7o2xWB07xtbTx3h7UvVZhmH6GWnEJ67wM5nlmPfnRNp7569JilIzWnToJlNWZH1tJ1y+zwR4/3pv1gRG+boPjYZXbghW83dHTKuESd7+3bPhMHw9AXSQG4Rj38xx91TynSCx7ixvni9RHxY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4621.namprd10.prod.outlook.com (2603:10b6:a03:2d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 13:15:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 13:15:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfsd: make "gc" parameter a bool
Thread-Topic: [PATCH 1/2] nfsd: make "gc" parameter a bool
Thread-Index: AQHY6RMoUX70ip7+kkShnP1Jo9eKHq4gp9yA
Date:   Wed, 26 Oct 2022 13:15:23 +0000
Message-ID: <EFC738D6-8728-4DAF-839A-3D4565B7BC7F@oracle.com>
References: <20221026081539.219755-1-jlayton@kernel.org>
In-Reply-To: <20221026081539.219755-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4621:EE_
x-ms-office365-filtering-correlation-id: 2353a594-4a8c-4dcc-8c5b-08dab7542425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFB9kUF36dcnTD2Ho3LGTVmYvpL89APt7d1wyvmCxoyT+KUE7FNUSuqQ2fvmcK3zaB4IY0YlIDisSUhXEGDjAuJx8h01CJjoHbjVJ7iiyJTggf38vG8qF1EVJWPS85n1t5DZKC6LsTWB1FHmlRa8B0aBwviofZ/J2xrINOO+8PTgjGY5bYLF7re0U1ePtg8N1FE05MVkOmq/s9enKzMnydQFS8Hkt2QUXQMH06bblKNcXfwwNN9dWlOvbCGbk7/zMhtevMO8rU2iWyF/1C+hFwUkrg5s/616GO8CqY/qdct/HSoKt9o4eAzYax/8BJLKl3v4T0CrHqOBvlUdjl0smWE0/Ofyxu48sBqiICOVaWHUZ2FRHOJlpXPVTmlhAFm9L7U5oNGz56jMMQc4Lv/RGbMLeR/Fm7ajnZ58q+ZBCJudRdxDdb+on6U/RbWYH/XGDtw7GrcKY2pFvfm+b1iZvhhafhVcc61aoTK+u/iE2HNLTy9y9heF5mSeqCZ5ru2+51RkUNCwLamUafiTzgf+moRxf/pk2Q+TFS3kGJwBn9rQjh0B5z0O4i/9WDgXdDfggQf9llVkjWuskcLfxTStGAwdunjIvML/ckMKs1YEeCvdYwiqNbqmiEB3w68hELRqTXhSpE1/VLAB1G7yvOBihYCCbPrRL2g2aSgu2C1azq8K7oU2dv30yquk8yKTfnS5a5iMeH53Zkwo8jLhtBaFeyBWYOHUD3goxhiKkFfrFMiaYMy0V2OIkJJ5YGLcMck6rc32ruow4vNyRlN2w3uk0Opm3FLHDxwzUj8GeEG75wg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(38070700005)(33656002)(83380400001)(66446008)(86362001)(122000001)(38100700002)(5660300002)(8936002)(66946007)(66476007)(76116006)(66556008)(91956017)(4326008)(6486002)(53546011)(6506007)(8676002)(26005)(186003)(2616005)(54906003)(6916009)(41300700001)(2906002)(316002)(64756008)(478600001)(71200400001)(6512007)(36756003)(66899015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wYWo5Zrg4tTDTR4dXpz/Odl859Gb5+oPQFsNgnVyt3TLcxcsZ6dKLmmtJ0vY?=
 =?us-ascii?Q?ljmX1wTxJYUu9gvST1tNHxiBS/SKjl7jWZ34wfWieFG7q79SI6DF9bCmqHbG?=
 =?us-ascii?Q?x11BlRBuykbwY65JoWZgw9MHC9GjGGxWYLNSrM48h5RRCKIj0a38ZetmeaC2?=
 =?us-ascii?Q?dikD0odOIno7nR/9cZcVljyrwyuqmeZytb1OdQIpk0qu08c45Z0He8sfAux1?=
 =?us-ascii?Q?qSN724FV9Rz9NmvOC/Hu7FwCWoxezpOnJ58NQmMr3zyKHwUo+KOuOwCSXeaC?=
 =?us-ascii?Q?T0Or7wDfAYbVPFp7PdxS/7LiZbogV540+ND0hY+llscPBSxyHA1NoMwTlnL/?=
 =?us-ascii?Q?S4/Kra23+vTRMZA/JY7DNxj0SmlayxxSo3WLLT92OiUj1/QOIzEOdHBl3BDN?=
 =?us-ascii?Q?FP4g0CywXINQRBrw/J67h/D09lActA5oULfIk2XwcyyUELbw+C8l4H92WmM/?=
 =?us-ascii?Q?KV8HkunAQANJ/0luQtj6fHvUkN0LBoO0L7Hx5hWGEVl3UFIfKAbPmlvpSaZu?=
 =?us-ascii?Q?Op7f0cDY9QKHGKcW9uZA2nmRyfzQfOhpar2zRMwL1V+IiVuzpxdqHRL7bzyC?=
 =?us-ascii?Q?ib3fv8DoAtv5UsYLKxt3Wg0r3tanxbZ5bp2Gw9NDORHeZg/qLPjhh6tCSiiw?=
 =?us-ascii?Q?TJEKwytVA59VCTfPS1i5m7VAh+P7qwcb8yBO9g94FlXIjTcZ/fUgSDri6Gc9?=
 =?us-ascii?Q?9oCEP9jiNtGDnjfmpMG02QtSxYQRDc7IkVf68Nadzh0VlJ2JGweiQPKZhnmS?=
 =?us-ascii?Q?engB2e82HPaQsBRZVb+FZ9ObNOSBC63JL0Z48OJgX2mN52Fxcw8a2v7dkdWQ?=
 =?us-ascii?Q?WihSd551D+aALPAm71tLmFbPrE59KfXAvckBzM3hZ/lbchrSBxCZuS86xz+z?=
 =?us-ascii?Q?nNutfVQPNuBO+197emux+4Ujlhu2oqK2rTFZCxc8nnrMOyH7AIhNqR7IUnI+?=
 =?us-ascii?Q?xZhqevUyilASMMZ0Hqi3oSeVSW+lKmWyOUKaKLBHxThbCl3rsGpkyJwmf1R2?=
 =?us-ascii?Q?Cy7ZWB3IGzVMuDI643MFXaPszBi8vRjFs9xcuMRiSYy3XfkfMHPj9bDNKVWi?=
 =?us-ascii?Q?1LUdGYUk0OJgT8zfg+lN9N87hmHP8S8dX9/s2RyD2zsayWeGRyz/UyVGZaMw?=
 =?us-ascii?Q?sDIwM8P38fXvTpnc9AKtkuwZe1PE7zfPhreS5YScfucOLi0M0XoyYy9FAYTD?=
 =?us-ascii?Q?MBwnk5tDlM/9r/RnvL3Hyw6T/wFi8EOgXtz4xs+9lh8Uhk/fMWKMG3uden58?=
 =?us-ascii?Q?F+15LgkQC5wT6TLS86IHOfh3Wd0Hks1o9Dow/Sty1lJatiMkfY6gVl5EyoxG?=
 =?us-ascii?Q?oCvCPPDWOZqqLivoe+5gw9di/vjT+XBZ9DxAOpVTZ1CQdgK31HZlTEM2I0OX?=
 =?us-ascii?Q?ls4ZjgQkQc3oQ3KvTTY/sze/3OBfbvI5TxW2cJVt1l22tKBr00MczedkgRM7?=
 =?us-ascii?Q?0hHEYWT7LGrfWQCaCHOLR3E+wRj30qsax+A4xgMdvAPtqq2xHe4Ytoc0QmnV?=
 =?us-ascii?Q?nzn5swWGFri4Loq/7ZNvkXqOB0dn5GqskDr0n1FjrLG7KbiXGE0jbdUBTNtB?=
 =?us-ascii?Q?hQaUqMR88twWPVPpMpKxrK0hdP4balilO/sg+iyVDIPfDCpay3BfBcUNPq6V?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C126525852DD54A8A7EBB3C25239F78@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2353a594-4a8c-4dcc-8c5b-08dab7542425
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 13:15:23.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFJ/F+096zJyQfYCu6LB8WgOP+kyVAug6OgXtXCNpfsASXtnWdoKarMqPUELHJ4IqMQ7nQcpj70KOzkbHxiFBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260075
X-Proofpoint-GUID: E6yHgoHxKGuGSUIWKjDPSIkbOmx3uZMS
X-Proofpoint-ORIG-GUID: E6yHgoHxKGuGSUIWKjDPSIkbOmx3uZMS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 26, 2022, at 4:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> This gets compared to the result of test_bit which may or may not always
> exactly match what the bitfield holds. Bitfields in C can be unintuitive
> to deal with. Make it a bool instead. This doesn't change the size of
> the struct anyway.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've already done this in my tree, thought it was in the repo already!
Thanks for the nudge.


> ---
> fs/nfsd/filecache.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 106e99b24b6f..918d67cec1ad 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -63,7 +63,7 @@ struct nfsd_file_lookup_key {
> 	struct net			*net;
> 	const struct cred		*cred;
> 	unsigned char			need;
> -	unsigned char			gc:1;
> +	bool				gc;
> 	enum nfsd_file_lookup_type	type;
> };
>=20
> @@ -1034,7 +1034,7 @@ nfsd_file_is_cached(struct inode *inode)
> static __be32
> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		     unsigned int may_flags, struct nfsd_file **pnf,
> -		     bool open, int want_gc)
> +		     bool open, bool want_gc)
> {
> 	struct nfsd_file_lookup_key key =3D {
> 		.type	=3D NFSD_FILE_KEY_FULL,
> @@ -1161,7 +1161,7 @@ __be32
> nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		     unsigned int may_flags, struct nfsd_file **pnf)
> {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 1);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
> }
>=20
> /**
> @@ -1182,7 +1182,7 @@ __be32
> nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> 		  unsigned int may_flags, struct nfsd_file **pnf)
> {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 0);
> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
> }
>=20
> /**
> --=20
> 2.37.3
>=20

--
Chuck Lever



