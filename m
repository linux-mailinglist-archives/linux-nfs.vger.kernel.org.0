Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864F432A95C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580794AbhCBSU2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:20:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48480 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579484AbhCBQ6a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 11:58:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122GikYe173845;
        Tue, 2 Mar 2021 16:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VMG91BM7RxrPNiTQ4i65nRvfthKJH8gyNc/Pyf0Ojm4=;
 b=CWO9jueQqINvGYbSuhz+SMJXvbxX620svU03ejCSd6Mcic5uP+55J1tQWaFQ1AY3J6FX
 9Vx1yriNlOQ9Zt7rdRfU1rOMoRQbQVOuAMC2WtkoAPpR9gq/f3eqmkZtGRi6KKZo8rA1
 oSyHIcm0+eOeCDtbQVPVjf+OnIApSn6D9xqLcGZqp7Vz9WFd85ASWJCuGPtHcsDC4X+v
 f427xecpU5NrSLBJz3whHGnznuGiPEHQvpsfoBGZTaMAGbxcyHHcDYZTBHq9umAWk+Yb
 clvZO04n87TNEptiz+tvbBiEizMENQ9telgwO5hlvI0B2Ii+jjdFHYAyfIuGb/YD4/i0 Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ye1m8bqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 16:57:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122Gj3Im152085;
        Tue, 2 Mar 2021 16:57:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 370000527y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 16:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G86l+6URJ38C7PFfkR/EmJ35AVhif5j5i8FGh1lcnoK/8CmOnAHU6SKE4nZyUmDUVeYB9Y5xMkQJ0tEVNzG3ndXea1NIub8b/hTrk+tbIrULPquxpF6NtvzqiA593R0bUx/tXfn+NmaIencaHuGo8zmq69KqTwOHbeib5Bs+9oJcFh7dUgB74x493n1xJhQ82zrLkTxg49DXTZWO/sTNmARm7zTyZmAALG9u53uqNb+z0inWEYzjRtZuxiARPsrOdH/fWIxAIwpIBfXL2zo14j3LPtiDtDqgKtzWvMO/9yKtCaET+npjwf04vbe8F2xaiz/WQ5/4u34GbCoE5gqGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMG91BM7RxrPNiTQ4i65nRvfthKJH8gyNc/Pyf0Ojm4=;
 b=TzAV91COW9fGc4nK8FETskfYVcZxTEOOu9WCohdn1Tg3+irtwIc/WBLZuJDZJqaO3YU7h6zAzEn1c+iIKoUZZPw/ILVXZ1JIB8AmqdHXB8ra5LrCaFDWhRfxuf1zAVrq33yO1nwjwdD6EIgVi15SfSl1TTyZbuzHTqsQ4L78yGBD0R9WpVlGYrKN5aC7BaFu978O9ewEPziXp3xgO0Jhq0PifL5jmCQAppG6iMZFsDLroocDW2fOQC6ePrNf/a27xhyL+fJ2ZroMzvQSrlyoKDLqBkEfVxEfKk9qB9ALN1wW4KUcnaTUoRtmBM3oGm10bHmeCf6gOYl3t5wTH5Fx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMG91BM7RxrPNiTQ4i65nRvfthKJH8gyNc/Pyf0Ojm4=;
 b=tIoNI6VaWHsYNmfbqnw+vCBBiGf968LWtz5oFG6hDYTyoHVUeqqn8YK4uixSCia4Ol+n07AgkYOiQx0JtAtrI4nf0GqDSImRL/hAyw1R+4aWMCIqcu6jGBduWRXX1X/vhgOb/XnnoTPqkIz5+iQLiP74zgv5gPtauG4w3mQ3Vh8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3030.namprd10.prod.outlook.com (2603:10b6:a03:92::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 16:57:28 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.030; Tue, 2 Mar 2021
 16:57:28 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 01/42] NFSD: Extract the svcxdr_init_encode() helper
Thread-Topic: [PATCH v1 01/42] NFSD: Extract the svcxdr_init_encode() helper
Thread-Index: AQHXDq46iTwkJHRyYEevA5aYNnyw7Kpw6i+AgAACtIA=
Date:   Tue, 2 Mar 2021 16:57:28 +0000
Message-ID: <C152432E-C7D2-455B-9193-3D020A23E82F@oracle.com>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
 <161461172449.8508.5387365342766187229.stgit@klimt.1015granger.net>
 <20210302164747.GA3400@fieldses.org>
In-Reply-To: <20210302164747.GA3400@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2c9b45a-0ad5-4228-da2d-08d8dd9c4352
x-ms-traffictypediagnostic: BYAPR10MB3030:
x-microsoft-antispam-prvs: <BYAPR10MB3030D02C3049BA6B79A37A7493999@BYAPR10MB3030.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42WegUewgzRD86u8bPgaBFkYL7sx/K9LN/FkUdlfnxpYRDgH9C56ougMoll2OR6ubCHg9HJ0tBkeVqKV0zyDNRdlDr70IibCWlflzE0Kh7S4F9Eus7abHZEVLg75FCi9LfKZIrkK1GubRRDnf9ztufpk1DvM5etzls2aLWR76+CTJArAk7JDMnN+iLG9wCsDRJc+kcxuPOAxi/mqbbfD+6MVk3melyBpphS65XTm5NEYEAsqQ1idPGaCJqDVcKCcWxzyo8UbnM6HIq0qO+izxUxZNBbmuiViMwsQJ9Mt81FXLskRVWc0kbPSHChrewGnDbCz4JUfc98F+IMhBgmRqV90ofwpgJUafzGAN9GzNai1wv0F+qazoRD8npiTNGGZ7oJHdS4mvYYGI9OucdADIMKiAh1xNA1rG3rK+TsM0uM0Ev4e7di2yqxOIx3rFz6Zw+XJV6r3rhQO53oMRExVQgkhJZGV9itn3peZGC19Bv69/Fg5F2xvDkPhgbVQIa3Fpg4umZZs1+utPEk8gDdWBFpJNouOCMz2DN3BsCtHzDrO/cJim11NDPyxfiAEpCcS0Sb7oknezVSbqzBpi3sLjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(33656002)(76116006)(8936002)(2616005)(478600001)(4326008)(66446008)(2906002)(8676002)(64756008)(71200400001)(44832011)(66946007)(66476007)(91956017)(6486002)(6506007)(53546011)(66556008)(86362001)(26005)(316002)(4744005)(6916009)(186003)(6512007)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K/RTNBBYecVmt6vrJc4ZSdsTDH7XjBT7DD8fgy38kGOYME+YRVNqguznxBkk?=
 =?us-ascii?Q?WkFbCngOvgWRW8XEvSaqThn1ZlDygaIm7UFdyuNd9lDsiXn86D32uccVmWu5?=
 =?us-ascii?Q?qRgBQviqgEsY8ab0YbGB9M5phACmz30XEFT9JWa6IOl2dP1D8sxCGjD+rWaG?=
 =?us-ascii?Q?UG3UN95DGj5EmqvYosx4h3ahASSNMjj4qDoG5YBd1KZFaebSmIYmrE/9q1rX?=
 =?us-ascii?Q?50DHfIJEmVfbeQCGthSRcOdKsoPD+dArtexm2wb2IC8O8xMZjdIW4787zwMe?=
 =?us-ascii?Q?nyEV2B7TcmhBURBWiGGe+hBkbjjFuAdKz67v6IEtP1AUQt2jD20HMftxNJhx?=
 =?us-ascii?Q?EBBYSW/uMDbQa2UHqcB8t+HWck/gsw762DMWWFpmXIpi3ottec7nMG+a/+5O?=
 =?us-ascii?Q?HxEcMmfmMlRcr+ya8gpHwEOS/NUgIHtLZn/8xvpjRiBfCwmKpMBxt6hrSbs+?=
 =?us-ascii?Q?rlG7TDqOPEuBErBw/LfX4mttfGxAs6urNRCAkOUtywfuDT3pjyjx4ofa/l1e?=
 =?us-ascii?Q?D0HoSWF8EF/6OZ2gX+IFqGbeAGCMLY7/heQFNepBiHHMOVD3yzy4mPs1pN0Y?=
 =?us-ascii?Q?gj+GCWnKCkowXcCvXoQ9iAojCKwFz75k56MsPXYO4k+652SFlKsel1gzRwsN?=
 =?us-ascii?Q?te8NLC8AMBShqpHav85R+5Zemmj6OLIEmNtl5f44tSJGhxqJTvj7b9vu4j0b?=
 =?us-ascii?Q?I0zkZFmjew2yYNXXzDrvLrQK1heEVvKPc2PtKh7ua+hBc3CInLqk1Uo7O/67?=
 =?us-ascii?Q?XGO1iqRmiZoSCx2MhOfBU7FVU/5fC9WjqZSOY4+uqsmT+nYES80GBSoSkT1w?=
 =?us-ascii?Q?JUpHxkO8Sm7xQRUSbQhTN6EtrQhp2bLDIA3H1Sa56BCyiVMvylaik6U6eXMY?=
 =?us-ascii?Q?HJL1n8ErNqWMPdFvTCEKjyhuEyOy4+p+W2PL5bWnhqo6V/KIfx81Wevt6LhH?=
 =?us-ascii?Q?GzG2+bkvO0MQkG184yAQEeTy3mNHUnt46D2oTLmqrP2AH61cPWYDeg1onin6?=
 =?us-ascii?Q?AWV7Qn+INnw80KvRNU0zelA0ye+wLVtirKNlURanBrFFvSuqRKvXuzr5nsar?=
 =?us-ascii?Q?INwoYbO8nuYFGNvM8+4OfIwb2v07F98ctLeygGKI/B4T2IZT/S1fpYcaq9wp?=
 =?us-ascii?Q?LsU3PDjKPtZLJCJmtefc/ie2vZB1vI7b8VMQEizMvf/LbvQo3BKyGaFcH49N?=
 =?us-ascii?Q?rX5z9uYK0xD2LGubHNXGrhNfXaZzPbqfmf4P5xSYRGAO1rBL38tbfudZcVaY?=
 =?us-ascii?Q?o/aRDUPeZPL1Qg3bDNhimMP0qoEbUYWh9yhR7v0hkcb4ODKJJ2ER5eN+TjUE?=
 =?us-ascii?Q?YE3yR/aem8yDJ/UXwfXSpK6o?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F5F38D7B828B043A87BC04B53E1F86D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c9b45a-0ad5-4228-da2d-08d8dd9c4352
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 16:57:28.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+AAOYR4m5ZoyJqeq6HbUqwLof74RP1kCta/yfaEtF/4KDLFT8J5Sw5EK/bZAH1fDpQ9snZhN+KKqhdslQG3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=922
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020130
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 2, 2021, at 11:47 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Mon, Mar 01, 2021 at 10:15:24AM -0500, Chuck Lever wrote:
>> NFSD initializes an encode xdr_stream only after the RPC layer has
>> already inserted the RPC Reply header.
>=20
> Out of curiosity: does it need to be this way?

The code in svc.c uses the old-school svc_putu32() and friends macros.
I don't think there's another reason.

IMHO they could be replaced, but I didn't have the stones to go that
far.


--
Chuck Lever



