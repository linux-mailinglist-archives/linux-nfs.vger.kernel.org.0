Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD7619859
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 14:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKDNpA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKDNo7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 09:44:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7237BD2E8;
        Fri,  4 Nov 2022 06:44:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4CXqt5001418;
        Fri, 4 Nov 2022 13:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=o0Igg3rGl2SVRrl7OmsJTyUa4ogq7wbP+2qy4YduxA8=;
 b=CClHP/K/x6TepT/MrRsS5uGfaMR4N1NG3NpchJkKe8Lv+ssofVrqQ98k6vTK+MbKA8u4
 1Esyvz+0mKDnAzAJXcTGs5IUaqJejA3H7zDsg+53g8W7b+zo+PPdK8Rau867chNgDILm
 UIBw/OGiM7dn8gaosPT1P/OGi3zDcowkx9CWsj3ezC5IB96ZCv7zADDLQ5HPaytyZcOQ
 Bm/J/BSkzSR66mEjfGZDLYuH6zujwaFpI0uAzuTxUyuIUQ0Ynkv98tLqEpvC3ueag/Q9
 SXL8R7ag2rjX8+O92hH3RG7ZxJ+tv/672olZWAJyHggSD+xjp6yZOWdg7eRuMiEvOHnJ XQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkdf5ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 13:44:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Bfs4g023061;
        Fri, 4 Nov 2022 13:44:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwnj8hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 13:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz5K5C7RP8hrOJCG7fsOi3nfZtkO++Mpe5etceCJD31IJBJukTYSeuZZZdE5sqHeTfkODka4hXWvnAvKeefr5Fl0eu7FAGHxJ4UbQfro/enMcA+/P5m4EkvXWVEB7OxGeIy9HMgGO+7pOwQE5NplaKqn4nODnymgQTBU8SQfYEnhgVpQn9xLLDix52ey3mobGf4YaPj+1ifrnav3dj0pBLIBi57W8ktnbyoV/PgiOi7612R7uVT2HlZLMpU0vOlidA/GYShDxccxZxLciqt//S9OaxQOCH2T3nvBG9EfNUlP8GLiR8Q3wSYzdUGsqA03iULXgQ/e6hKMMHGlxVTuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Igg3rGl2SVRrl7OmsJTyUa4ogq7wbP+2qy4YduxA8=;
 b=az4T6m0K7wHbCvW0g5zlNa4YXBqoEzIw8kw+7aCL7yYoB5+K5LeyIyddIG+Sd/ZCFWjQp2IKniWcFiOFQ9mq8FZV5GTgzfUegyHb8znrlB3ZP6q01CuOez7X9c/Fje5KF79svHF4lLOXsVCZjBxzDiD5wgOk0QcAFcKp/peVhCS5LJPrcCWcM6RES+VsMY9euyWph6MSj+JtaQSvCxe2MSoDCTAba0EatBEr479lFuL0A/eDVgeW/DYh2GjNkoVgO1/WW7jtWtp17ARtU1YD7s2+M6KLY0H++mSQI8HrcymX2rnXjzDgrjzgrhYGRLgzlhOYeKLiNBHo5czZaKRCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Igg3rGl2SVRrl7OmsJTyUa4ogq7wbP+2qy4YduxA8=;
 b=GVeh2tKMIHzkBUHklFAD6dwfKBCyb9WOqbNrA+Q4DgXJ8Zm4+h5UDyJdaAt/IvrTQT2QOEn28EEfzY2lNAGx4mEzq8HoKvAetdJzoPTSCi4A+co2MBUEQftw+iFeO2MEbWNuR2z/QDCLsqt/2HE32TQotjxLll7WKWv1k5Qceos=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4535.namprd10.prod.outlook.com (2603:10b6:510:31::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 13:44:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 13:44:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Li zeming <zeming@nfschina.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: svc: Remove an unused static function
 svc_ungetu32()
Thread-Topic: [PATCH] sunrpc: svc: Remove an unused static function
 svc_ungetu32()
Thread-Index: AQHY7+7RIkBteehaLUSI+nX8T10Ar64ux1KA
Date:   Fri, 4 Nov 2022 13:44:43 +0000
Message-ID: <A9993DD4-5A7C-42FF-9CAB-6BFD61075981@oracle.com>
References: <20221104014303.3146-1-zeming@nfschina.com>
In-Reply-To: <20221104014303.3146-1-zeming@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4535:EE_
x-ms-office365-filtering-correlation-id: 38cacc22-831f-4eb3-31ad-08dabe6abad6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CzF0ZFcArVYTzlA+PfRbjjUvlpncNbYqiXVz2gVrSPZQfLx7dhN/rs3jJ1zY8rTsR62ZF3RwUPHzk/9mP8yodcZ9fMPDK7okBlm3wiQ9ys5hinAiGDdgkzN6Mz9ovIXKpdJIiddTpJ0VWX8Q/eZMY0WvQo0kWluO7I8cHapcuqV2bvcT67FGhidCUZ849Q2XDL2RR0wD8QoJm9zdnAq58ztX2EbDsAijdoQvdcuDMclTK9p2aFemWiVI8LVRJHXYurk0jQezKPyH9awWj0SHTj0XKdCcnhfJJ733US1Lrd6mEr/iUK/iYwM4//85ryRvrFq/fYi77slfY+UW5pDRJBbpHYYqlHbkfG4nYMWOYi4+eM24VEZp0tf+AikODsL475yB/62A3R+bRCEMNWp5YWwAdStDmbAtdd9LWuML01M6CKFun5eb95NDjk7L0IbpGYIUwWWsVTVQvo91155d73pMuLqrCAO3AkijjhlAnhM2YESFziQaX5c1Os+xa7BkTEzKeyWp3P9kfHRQlBs5asWEnlFHspZ2yVwYUwWWS+GNS5n3IWFLRtSELeorWxJkhX/L0P7FoNMOpFkMzn+i+eLf7ztPyGZv/UcpTcS8qjOjFYfttZ+XsZKF45hMMRU3M8knooVF/seu+Z78r7L7fGhUUIPzkqfgIKP3AQR+xhNq4A+bhIH9rHWrXpduLw8r9AFcrpJ4TAfRPt1+4Y7tEG61KtKWS4Ot4m3wx2NLwhK2BEpQE89L+wsBxV3kw74ibkuRk7r45Dwa1vw2t7+Zppu6zICMjO3P9jxoz5CMC7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(2906002)(66946007)(76116006)(91956017)(26005)(6506007)(66476007)(41300700001)(6512007)(38070700005)(54906003)(53546011)(83380400001)(316002)(33656002)(6916009)(8676002)(8936002)(64756008)(4326008)(4744005)(66556008)(36756003)(66446008)(5660300002)(38100700002)(6486002)(122000001)(478600001)(86362001)(2616005)(186003)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1eTRFB0dqmmrBljO6ZR+ogG7ta5+h+D41jsgRFtbJ8p3BJp1t+5HDnbsZE1Y?=
 =?us-ascii?Q?6O/qhldQQCK8c+YNaHNS0hU8YnVMEZC/y6znFNyhVt3lFP+j0ZCwncRkJw0K?=
 =?us-ascii?Q?3geAhYfZCQ6SO1Z8FkEDEiLdySoq8v8EpJnPZCcTEF97YLUK39RkMbSz8d0T?=
 =?us-ascii?Q?SOFU4LxED5Y2eunL99PKHtpuYrx30UqXXhH1Qa9EjhZLTrNnH/fG11VIfk8J?=
 =?us-ascii?Q?SReti54jjr85CnXwk3sqc1bKOMwtV4pBREyjEOkRZXrZ9TFzqUiua2CbUrSe?=
 =?us-ascii?Q?DQ70LVpjzcPV3Z2DiX/INZjar7gwnQ2+SEn5fM/EA/uNjaiaT1P+0MJKUhvk?=
 =?us-ascii?Q?34+Xi/h/TvwWjNiu34dTKx7Bv+4+0Tas+7dorPWY5k6eDLQ9FbDyv3X9e02I?=
 =?us-ascii?Q?CbfWfXSNBDYJLQvAnl6JaoEl0R5OoseGtJrshKALQdY+rKEgnVS+gU1iF6Ms?=
 =?us-ascii?Q?4hxTm+txrLJr6UNxv+cImxjg5oYg/IDQOcBCuGMQjY6y53JAFovb3agLMByr?=
 =?us-ascii?Q?GO3OMXFaUtXX02B9yNRtuOdmlT8kHMLg0sh2LdZZ+cIT2svcAFzxy5dCqFTo?=
 =?us-ascii?Q?xAZIvJ+TN9CLJN9ggIuuogsT90fW7w/dxfCG9y6+JdbdPvPrsDZP/drFhuD3?=
 =?us-ascii?Q?eyRFuB02G66raRi7Yhto2X09Iafbg2hUnM4htsgdFynJQvsl9aAP3ruE2IKq?=
 =?us-ascii?Q?5hN2PqhmFgcWmwb1zov739fSK0Fex+sgyYVCi/nXE9UIvBK1ydF5UQx/JMdH?=
 =?us-ascii?Q?FGvWYKNn5cGi5fOJCYpzHyCAfs8IFOxjpfjXjzBHJ6vw+F6aeWBpPqxfJ2WZ?=
 =?us-ascii?Q?Ja3oIOwtHKGutr3KSYYS4jmfpkYqtau4QEAV7HD6lffoXSZSEnvZSyjtrP73?=
 =?us-ascii?Q?W1QjRkQb3P5pHTd5lbzyAYeA/bhgxcxw2Osk0MsW0ZLUUjy8LG7GNV5z9/+o?=
 =?us-ascii?Q?QeGmMaKxK5UUYjawG6Bpb9ndCLK8uDoSd3Vy058wOm9tnDXdptmrsmhSeTTv?=
 =?us-ascii?Q?m5OQvNOt6efS/f/MnJKIW6aeGUhSTLLggY1yhrSTvm1RmRBW2PPYsSDz/IBh?=
 =?us-ascii?Q?RtTn0c/9PBlMb9xIgkErSlYQRwRGawOEUNG9OKVQyudKXt4dSZh3UmRkcTA6?=
 =?us-ascii?Q?pM9qvyrFvGona8vQOlLR2p6LnI3LZ+l4/WxtYE/S/Fq0OmYaqvx5W0TGNYq2?=
 =?us-ascii?Q?HEWvDUgos9e1nIDiO5PAV1sd+TMR9V0e2KiSgWmN2sU6L3kxB1MRdDhplMZx?=
 =?us-ascii?Q?zleU/+cKLH7JIhTzb2YXDJ64sbB+pscjGgTb/599CCANiFkcHVed1+sTMYQr?=
 =?us-ascii?Q?uAchT3ulikSYUhFvtGWfZrGflNmUX+ZW0Fff4SsQAkb3nT2C2Y6/ub2mqcyE?=
 =?us-ascii?Q?482ghKMc8vQprf+oI3UmkPGVxV04BKE409RphlWylnDkH/FXcwFRweVApFZJ?=
 =?us-ascii?Q?kgLpIrQAyOXokFzAdrx2feILTrUWlK7o1aEt6CaOfL8aw7bSkyvL2lBup2LA?=
 =?us-ascii?Q?SA1l/yHcrg6sRSaAdEqEMtuZShoPpceysmSqT9x/araPkTH6GRi+UVEdh2rq?=
 =?us-ascii?Q?SoA+gTj5zee4I2d/COvbEMXKgNYleaQROZ/dp5XWdO1IAFKZVlxWW5GbHrz1?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4DF6AED329C0F478774C043AC39ED61@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cacc22-831f-4eb3-31ad-08dabe6abad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 13:44:43.6444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/6NRLhsYSx/yjyK7GVh9/5oR7hLnZeWnkZKub6lPIRDpBUsJbXEiPP3qJckVbHt7A1ULelxZjJzGh03M6KqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=989 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040091
X-Proofpoint-ORIG-GUID: LSjrp4yXN9H16-2dwMifTTHG1qmffoJA
X-Proofpoint-GUID: LSjrp4yXN9H16-2dwMifTTHG1qmffoJA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 3, 2022, at 9:43 PM, Li zeming <zeming@nfschina.com> wrote:
>=20
> The svc_ungetu32 function is not used, you could remove it.
>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>

Applied to nfsd's for-next. Thanks!


> ---
> include/linux/sunrpc/svc.h | 7 -------
> 1 file changed, 7 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index daecb009c05b..6990867470ca 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -220,13 +220,6 @@ static inline __be32 svc_getu32(struct kvec *iov)
> 	return val;
> }
>=20
> -static inline void svc_ungetu32(struct kvec *iov)
> -{
> -	__be32 *vp =3D (__be32 *)iov->iov_base;
> -	iov->iov_base =3D (void *)(vp - 1);
> -	iov->iov_len +=3D sizeof(*vp);
> -}
> -
> static inline void svc_putu32(struct kvec *iov, __be32 val)
> {
> 	__be32 *vp =3D iov->iov_base + iov->iov_len;
> --=20
> 2.18.2
>=20

--
Chuck Lever



