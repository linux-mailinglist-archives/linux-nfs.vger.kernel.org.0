Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48A7A50E0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 19:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIRRXd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIRRXc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 13:23:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7E101
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 10:23:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IA3UWB010136;
        Mon, 18 Sep 2023 13:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tZkr3Ce8AciMFU3OPlNy44EbtyhfQZhCfCrNGsvVl1Q=;
 b=UypktG6hl5b0F+A0kIHpK5IuXvJeYcFUakmvmd7iEmnioJeCMTcaQK3OIlHpu+gxtTP8
 NGJrcVlreoLHDr2H/Vu8ghJrm7BzfH0Q/xs0RBGeNdcwA4UVFKx9JFk2rxowrT6C2vFu
 ukC24hLdCmORUuVfiS4qGocIFuMKbTNW+BKw9CkXhteBlPA2e21LGFzssed4Idn1dPt2
 hOa58juWlecuvMHnF91+FOaB4U3/HrQ0QvFHjK30XstE351t7GPLBjr4IETMhhLZMxS2
 usQkXrRmInb/E0FNYIkuCwbFxyCWJ/L4P9t/URZ0gneR/VwNopE72P7OUFjC1xvO8xAo SQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352tk7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 13:33:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ID708l016052;
        Mon, 18 Sep 2023 13:33:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t40vck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 13:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGzJM3rsyTlqAfgHEUfG4VMOcjbYxwRaOU4ATsCVBNuKb88ArD9o4Ihk36p5TaOaLUPbfpyrjfdDeCPWlX6oWLAXswjmmqlfK5Y28hyTX/1fzOLgTe7ZqS4ZyP1kMhfj+vNCMwEZXE20gxDrhh3fap8uWIwrFsKCnZCSp2+NUQtYVgmAkkmGOcYjYEgIUjgom7FrvzNoU7QYhM2I2XI9eXuvOdW2uFEStpikW6whE9QNgX7hPouXI3+7XGMW0ffxzI7YfCEFvW0ps9dnMz3C1H5crIdjse/lPytRjt26lovDzgqKW35TpGJfb/pFX+PCoC9933RsOe0OLeR5a64kEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZkr3Ce8AciMFU3OPlNy44EbtyhfQZhCfCrNGsvVl1Q=;
 b=PUVbAAOU01IA0Gt1Nd8uEXCDl/jTLFO0rc3kQmWXaezSwEsltmjnK2gMWEb+HLfQ6XF6QnSoDxsRYnvrTHf6ZzPEs4lqAiBfcKmjYo9sHR0fvBWAmsE0Le3m1KX9mcpTikHg/AT24BRSmN9DZ62aYjbTuapOwW3XLKiSqB8yfJCpKIALC84T4gCOrhGOrEFAG57sg2EbqijXZQsdVrYUD2lnh/6frKI/+li7mY88xSVHl79g9ZwM24C7OAPvuutWdcU+HdpZCRtiQzWctlBNcU0QJa5R9wa6D8MkWfOlrFPQJwM4FtixGMmuSfLczCfnbUdyRxLuRIm7jSG9MW4HVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZkr3Ce8AciMFU3OPlNy44EbtyhfQZhCfCrNGsvVl1Q=;
 b=yMH1AX3GBETMoHutYbQt0mjat8oM/pyt6akM9zW72EOVfKGyPzmwl0ZKD/Q2jW4ubjblK8YPLsk7ik32rmzhr/ckgCiCRjT8hkMblDq2ZDyYXImXMCacqW8ogBLEFaLxRtsM3YLyVJGFk4hioWFmbXzXt1zPkapuUwYt/k68H+0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7284.namprd10.prod.outlook.com (2603:10b6:610:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 13:33:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:33:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kinglong Mee <kinglongmee@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix the typo of rfc number about xattr in NFSv4
Thread-Topic: [PATCH] nfs: fix the typo of rfc number about xattr in NFSv4
Thread-Index: AQHZ6f2m4oFJNpn9d0+obGLNXtNVYLAglWiA
Date:   Mon, 18 Sep 2023 13:33:33 +0000
Message-ID: <42EE5389-6CD9-400F-BA88-F423E6F33BE4@oracle.com>
References: <f44e51ae-baca-4091-b6eb-85537a43b752@gmail.com>
In-Reply-To: <f44e51ae-baca-4091-b6eb-85537a43b752@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7284:EE_
x-ms-office365-filtering-correlation-id: 9a135265-4202-4286-26fd-08dbb84bdae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeN3Gd2O3XWShyihaqljH+h3AHU0ZiZ1QtVog5ls6hZ/d1sdmLCP/dbL6ltcBYAG8F+VUnKXbMaxGqsoDsYXoOAlOvB4YpuplOHHoIHDWYPOo8mi679dEdzfh9O8DKs9BnH+tBN3KNuTiK+kQTvT9eWq+PpFz38JoRnznRotZi8jyUWfMMtV3f4pohbgUbWnqIR+Nm1EZSOQ+CxaRSBIb5wfrv7l9yFmX3jynAZMJ32SZkj1Gwomfq7ILm9q3mqVJppYIREFGR9KyaVX5KlfY7wO7iqrgkDbNdoTJrSFYm06l15LhwxU6W/1QuPVGw3zsvQ7kDSInU6x71zJRd9WBkp/EMJLemHccT156meBieP01dHI2jDaSb7DSBTMootbk8tjkFxXOAFehCCWl3Jdj1AD/UhX2J1hWIrOqb55SecApt5OC0ujY+SxkmE6zt1YdVPpEUd7uXXG2EwOB8Da7OXAew5sr70wcF6NNRGPRmBLCLK4MQ3riyIQMBQti8yYua2dLpTnjM+abJlYCr0sWgxdxYaIkwjFsC9u4EQLHM/5fuefFx2T7oOquig8BPhFyPMCXLJ4gsganPtO8pLImgFwVou3tsPlnYtU58BQ1DuunsfWVCPn0bZOA4oohHeiwt4YgXapU4nbPymaINlk+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(1800799009)(186009)(451199024)(6506007)(53546011)(6486002)(6512007)(71200400001)(478600001)(26005)(2616005)(4744005)(2906002)(66446008)(76116006)(66946007)(64756008)(316002)(66476007)(6916009)(66556008)(91956017)(4326008)(8676002)(5660300002)(8936002)(41300700001)(36756003)(86362001)(33656002)(38070700005)(38100700002)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQdY1EvPbxdnK7xR5+rkHxliQq3poQirsLfz7Ju3efRYlyK1+rJIHEwvh0B2?=
 =?us-ascii?Q?ofRl3KI6nz+pV4KVWvvu+fsWBp4dexh1ZE6VJpagwoG9vlGM+QDJV8MLMbkC?=
 =?us-ascii?Q?JVX/IdoLicQEdDjSXTbHK8P+vcKwoIh6Y4oPRTA1N7LrnErM6HVUkMRPKuom?=
 =?us-ascii?Q?dwkqrCkPbNMB99IHMbvHxICQiB8kQ8oVPTcDHyrmKwqTdn+YjTibthVmXbSD?=
 =?us-ascii?Q?SOO4mpNI+y+bE+GE3zdsUQR4GopPSrWWctRitpTor2A3nWIsJL4RaaLqMqW0?=
 =?us-ascii?Q?rY1/hL+mh6701S/O/OdwkFDwDuxUQFBUKvUXUEX1hZxq/tqyh1m8v+66Ifqq?=
 =?us-ascii?Q?H7RwymIG8DdkcNYz+17OiCQVF2cZar4mNS3QXxauiQ59NYo658tILZKTxCBp?=
 =?us-ascii?Q?B2tZFaf58DMUGxHo79GufIo29u6l1V7c0V3VmlNLVF7ebybn724oKx9SnE8i?=
 =?us-ascii?Q?SyYcqNOS7VJm8zAbUTRixbDho0W4g025dom675ei4zkSFnvSIifNfTMtyXBK?=
 =?us-ascii?Q?//mGo6zxYXg60t4zBm0/kFY92F76NPWTjcdmNAQPce+wyC0JcIkn5uCaEnvB?=
 =?us-ascii?Q?1wLZg9z4g0nooZMnWK9ijNPJ2OE2nmxVFQVfgMy8A707ELKBRlvt30IE5lCS?=
 =?us-ascii?Q?a3nivFNWQYHFAd/oi8hTJBEGYEyzprSP7nZAFvy/QYAKav4wSgH/uHyy6dJv?=
 =?us-ascii?Q?ZoF1vV4jBUK3Ln1hQ2lGUdQ6TPjhId6It2nk8gzQO2qaLgE5yVfgZZprcsir?=
 =?us-ascii?Q?H1uHRLO4tzUPyaGQrPzq3MM1QHf/RtfJd9JkEbD1qLEDQpv+9idmnPuQYq0+?=
 =?us-ascii?Q?e8IwsTI38XJb/WucG+Pj5e699EsPbpEDe3SmjcDZW1FoAoE7Jpz/Jw8AaAzi?=
 =?us-ascii?Q?Rr9qM2mEsDDkj9COkxQXMMHE9HXLLqbq2FgBjAMyCOWzdWnWLpXRIony8YDA?=
 =?us-ascii?Q?z2MczSjlgGjIZUqlbcmE5YT/Svvq8r9ZZAJxyXCzuo6se3SA86EIiIurhIld?=
 =?us-ascii?Q?koBFtJ0PHC7aMcugddrAST3VXwi8cxR2WhRzYLeojSSaj0/Kq6vB2CH427f5?=
 =?us-ascii?Q?woBRUgtH+4F+oR9kIjOsK6yLIfyeQ3CS+3OiCpL/56rPQk/esYGXo1Xo6eEp?=
 =?us-ascii?Q?B6Tiag0Lj26feDxHz2u57tgj5AEwct+FLzWj/bJdqTG0MZKhH2Kyt2ceGPly?=
 =?us-ascii?Q?xgSLvvjF0jgDyHa7pYJiKfjlz/Iwy1RNGIa8SUEzbGGV8I9ZntVEJic6H+Q+?=
 =?us-ascii?Q?v42nkBkWIxepdBQwOAaneFUqun+i8v4ofVWY4AFBHgIns8XuHomSMDnilySC?=
 =?us-ascii?Q?uhq14nUDyjhhj3mGc5/UxLcIO3F7bAIYD/383+VhzrmqmvhXn4jxP7IztHY7?=
 =?us-ascii?Q?E+LpeB3mpdm8WG/A9qhsnLngfi26hy1goDq1W3mZtcZ+0X1GD+l1QN067yfG?=
 =?us-ascii?Q?nUjGc7kFmjNm3mwuHwx0ef5iIaHT8FlFGw6vLfxrAF6HwC1LId7gEZesXLZu?=
 =?us-ascii?Q?fI9yRBCySJOTLq00ei1T9YVhrPGRGVgCAYmWR5BYLCapyAd3g66HHIibrQyF?=
 =?us-ascii?Q?66PgEGeL71zD2aRMwtVWdAIfbqMxWcI4CfOg8C+MrMtMzt9uOAPLeEGctbvQ?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA259EA9CB02AF46B913304FBF9CE2D9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oNFrPGpfkYh/yBqbh7W2low85E/ozOUpfFzfA9C86ONpC4SUVkCSrcPCx3IAUZzUwUj/U4r1shugj8318Y0tmCdeW/9bBDUiFZAVfL1E7Xd1K7jbvKwdOfMm6xSjW7fa4t0nU/z6HXzta9ukxJ7bC30Ev0kxRGsWGM7Mv3EKWulOT7Jxg1oknF53ygFCU2ZTsLsz3k39TSYieRYhdlm+vcXjriRvuTIDo5AfNBc97KlekvT81q2r7D9XmwIfTTRpRoNc2EuX+AtT9RQoqL4Bl0A3MqqlobvquUiiaphjeOrAPOlJDmq1v7fTOVJsNJmWP5vTA8PsZn7MWvkSefQj8Ju1MYT2DwAFksdv7lMCD6Uthmnqj6rtw14IkAePnSJzkUv8MERnwKOjOHsqHwSj+lLFsUPy/XhUqLGxzLmDks++mtE9AvnhLPbbmVScDtDd1Z83CHT5nSrnE0CYpPXv3JHHG3Hu1P2WK4IaRzN0N4CPHV4y8FDn3mmjFflglASrFe/xS8nmHRiNRU32f4XGX3WfGWP7Nmt2aDxzXk4R2K/FIEghZ8s9tpgaaWk9mOk7IWbEGNsoXndHUz4vm21odXkQJ/ihjuzgjCMuNhWYe8+VpCEPzV7IGFLvn55VT8wVzwiWnNwh9moc6ifoMxTa+60h7XQuTdvUB0xoKkUOHIJ5z5MRPq6q5ayXAM0SSIbLsG+A97AhNogB/tV+PE2tPFSydYbHHdRU/pockA3N5y0Hb5us/7JBICCE81Y/NOw2n9IdyGbEM6QnPW0iDDLiEi39tZGtl//pT48Y2gEvpIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a135265-4202-4286-26fd-08dbb84bdae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 13:33:33.7544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hg9i3hrOQgifvlVplSRinnjZdaLqp3V3zbjvlYBaarwUb2C8msKzUUrpcHQxeGqAUMxqs6uQ7jfSNzHBgu9enw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_07,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=876
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180119
X-Proofpoint-ORIG-GUID: MjU2f3k7itL5dTtk5l5oucECM2t_TYD_
X-Proofpoint-GUID: MjU2f3k7itL5dTtk5l5oucECM2t_TYD_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 18, 2023, at 2:59 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>=20
>=20
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
> include/linux/nfs4.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 730003c4f4af..b6fa923a3111 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -150,7 +150,7 @@ enum nfs_opnum4 {
> OP_WRITE_SAME =3D 70,
> OP_CLONE =3D 71,
>=20
> - /* xattr support (RFC8726) */
> + /* xattr support (RFC8276) */
> OP_GETXATTR                =3D 72,
> OP_SETXATTR                =3D 73,
> OP_LISTXATTRS              =3D 74,
> --=20
> 2.41.0

Applied, thanks!


--
Chuck Lever


