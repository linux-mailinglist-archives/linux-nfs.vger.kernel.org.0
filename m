Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8249E6AC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 16:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbiA0PwJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 10:52:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22698 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243227AbiA0PwJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 10:52:09 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RDqEkv003607
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 15:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=33uX0LjF9VORbqpbsYnN60iA3Ff9DRCpGJAgIlCHu/A=;
 b=JNXiAPbnxUegY7eev2Ej2P5pO0Yy9Y92Y5S35T12xHqdLI6s+U8uQG4zpauMy+SoV5kq
 yHZElB9zILWVJO7uEe3hgg/tNWCxR8fZEI/9wJk291vNsmbOEXj72ZMzus/f1xlwSwt+
 GMsZyyb+ieH1l8DEUI93M4RXykrW5aVJqAgJ4naHB2t3IwQQU23QfoLWCyJtcg+sPF8A
 F2PtjZjlbx5STTJpn4/GGkkkXUXGN82elmEf9SVq1Q4a3fjQBNyITca4ZDg4E/740Src
 qTaaMbmfSg/IJSEUW3iqqJDMlrAEcvKhVb+Zlt3tqoN2ijCThdWMQv4oXlqcH+UXqbOi Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnk8bfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 15:52:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RFp5jc007644
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 15:51:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3030.oracle.com with ESMTP id 3dr723qauh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 15:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDdlns0Cue1j3C5DZ5ZtTe6DQ+Us3QhvXOWNV3LU968UA6Jr4BBhsCQJHWsVdprw68RnJ6yq05Im5zaDbP4CEr5OiwWlUcFBhWUTvBbGOrkonqQryfZDBMyOitziyjtjgB1HodBOoMYWqDkyAAKvD1Ht/8vN7u5QCze3+Dv9ISiYaXPawsReSFuIg/pnwewPZuXjno6JTiKwnJd/kYWWVreQZbNpu3kjUDOt2jyV4D++ky+hF8uJdRUKALL326NphkRANL6QVtO17ENHVFPMywFrlpHDNAdHSiU6HhNk7engHhgVnwcXxf33YVrHfv1xwece+Xd21NohgXK7Bob2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33uX0LjF9VORbqpbsYnN60iA3Ff9DRCpGJAgIlCHu/A=;
 b=H4tbH5UUbss1ozD8wTCSOBYySQ8AnlOt3829QApmx+0uXOPubfE70rGjXKZx29Mb1JDFOjWmtNrYvk9lGe27i/GiqrlqImyoVNIpLgFWHY148ytLV2dImr9CR7Teszem6IKwnmAgcq29PxKA6YX0JefGJw0sRw9r0mVEESzKFoblR9TdVlZOXnUGhT0MM2koGR65bK5koDnO3sF9AM/IQ+TDnSvxKwk+9ccCHcyNG8GijeVoxrT2xf0yvwfsygnX5LWFelE46pABrkTxNW22CD7xsJaMVolA5dD2CETKkKdGc7Qngifm4CpafwhDkOp/urtEslMbubvfTe7IU6Y2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33uX0LjF9VORbqpbsYnN60iA3Ff9DRCpGJAgIlCHu/A=;
 b=k426Klzv6K/mEO9HqG+r+FmzM53alRsshahFNVuoPIROnPu+J+aPXquJyELrxt3fF/8VrEUBjuM3tlMzqjhqGGh2PZlUNzK9pnXaR1JbVkJYFLN5a3foppTSMNqgIEW6aD3L3zKpoATEkpLs9tpdbrfjuV6FN2fSt0fue4PljcY=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 BLAPR10MB4850.namprd10.prod.outlook.com (2603:10b6:208:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 15:51:54 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::16d:ecf0:1ab6:7401%2]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 15:51:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: nfsd4_setclientid_confirm mistakenly expires
 confirmed client.
Thread-Topic: [PATCH 1/1] nfsd: nfsd4_setclientid_confirm mistakenly expires
 confirmed client.
Thread-Index: AQHYEvmbADEY/zrdTE+MH1u87Jmysax3BaiA
Date:   Thu, 27 Jan 2022 15:51:54 +0000
Message-ID: <5D07AA4C-D6ED-4E53-AFFE-D0B91B11622C@oracle.com>
References: <1643231618-24342-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1643231618-24342-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16388962-63b5-4391-40d6-08d9e1acf0f0
x-ms-traffictypediagnostic: BLAPR10MB4850:EE_
x-microsoft-antispam-prvs: <BLAPR10MB485020DDF041F70232DE02F993219@BLAPR10MB4850.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qx7S4X1Q5VxZleV1mVY+3IX3D3q5XUxmKLI3lq3NocW7hURcl3DSu4H5kui+9p2ioEwdeR4iaRWAdLsSHY6Rw1m/XFsp2mbQtfwEufTn+tr6ZecGZ15ZweTenkW8Hr0mdLVIWXxXNmktC0kOkwD2Ilr5u+kKENl7zlEM0vTgFbpZMXTEAVlBP8OpbONm/xPMYUs5f+eb2BcPTlKyPrB5NbMwJB6AIqJWukO7Nee/THb6I0VYSARPkCRUDMg+VaMfrHbPKk2mC3mjiKbmMR4cdAPKwNOcku0WrvRz6vau+hEy3YhGXBZtBk+mz1QBTgI2MY7jnfl6lJNjXNiGCKsP8YGMxHcyYfxazzZWpDen88DVTKYZ4xRXZB4eCDcLX/k/c5/SUs1WJmcQW/r6uQ1ab4qpGYznQCjfRilBAJGKv9PMizRM6ESMB8ytEZ4oW1SGx4sbK7FbopjzVmgen8NIizSKA7YyBz7zIktBTIItSd6T73ElvMUWpb3FWGqD0+zhD2nJZ0ZE519jJASQkAXAQVArODx2TjMl2KxK9VjyZ0kid64sLFw6mAZeIJ8LfNNEDBfUd9pVT0xTIKCILARRwY9YLEUywrchQPOcQ1VjCxjTv92Fy4dbabuCpD9s8xJBvd6xVpo6d9QkK+HWURqhWcGLba3kQ/o2KD45CpkuQGCio2TY5Enh5Haq7fLG9B/6s7+XK4XjobC7S611kxOlA9MYJLYNkxqffzr7nCLE4DY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(36756003)(38070700005)(83380400001)(33656002)(186003)(53546011)(6512007)(26005)(6486002)(2616005)(6636002)(37006003)(316002)(86362001)(508600001)(2906002)(71200400001)(6862004)(4326008)(8936002)(8676002)(122000001)(66476007)(66446008)(38100700002)(66946007)(64756008)(76116006)(91956017)(66556008)(5660300002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KbGKUkuDuKN0aeAMJ3jhKgECcIFoYrjGRR/4CzPjov5YxW/pwTUYlwkjPrz0?=
 =?us-ascii?Q?oHMUot5Ckrt3FNhNUaBAXK5VZvbC4UMOR7sJOUXSj1BpxbSlldJEK+NSWLFw?=
 =?us-ascii?Q?PkJpY/sZINSIH4hk2cS0qMpeqR5S7dmhUjMWFT37nU1yv+zsV/oSBqwRwXDq?=
 =?us-ascii?Q?MbQzAoqsMteTqTIT5A43nJJdv0UwKN997634kL1ci7QPAYCooVT3d4hDhgL4?=
 =?us-ascii?Q?tEJBLQkDAyjjiS4LhJit7aduhk0A46TUGnGmxqubKZm3TO78NO0o4VHOA104?=
 =?us-ascii?Q?gtLkhMC6du6nYygssufXSR/vvh1DwYA3LmNaOTobl4Zfl3C+/7YCWmj5cP9b?=
 =?us-ascii?Q?xGVyHiICdZ5h1Wu2PKX0wCp/Wnc50n+jtmHUCnDvRtd3xRLbo0z8WaWSoCpd?=
 =?us-ascii?Q?9HtlysDeHq9Vu9Nj0Qf7JEATRDhoLdnLHtdaPaHjwq+9n68BEXbJjjdZSlaB?=
 =?us-ascii?Q?YUiurqSiU8fjJi4WhRaSndlfgW5t++6qPNyx5Q+rChJL5TihaZVsxyJQuMg9?=
 =?us-ascii?Q?ANEYYkZG/in46KJPa76TybqMfvYsUok0XX4JqO/nTg1bfIFq7RKB2ZOy7eWc?=
 =?us-ascii?Q?EkApota5BDoYz8pGw+SXFti0W+Q4nrgunP/E4m0RgP1n4thJw+an2UZmli6W?=
 =?us-ascii?Q?TjJvOIRqajPRx63TfMOxoZ/MZK2UBF2YRPRv19dllNwOign6Fnn7WGYEwb9H?=
 =?us-ascii?Q?uYfModE9SBaD64hy6buVc3BRuzBwWmPZVcYENZsy75qmmKv/BcELu/BHzjWO?=
 =?us-ascii?Q?8m4dCl3A6FBolGZMarAAvd157doNRzjkLtNlHh6wwLLaBzjoZ1PCQ3zuNCo6?=
 =?us-ascii?Q?D6+KNIdpHuf/jO2rUkOCJ9ugNmZVE2t1IHq7eiuIgvbiQjDSt8x5i14T99hB?=
 =?us-ascii?Q?Eh2C6r/lthoBtdMSBscoS8FhY6VMMHU3sIkQFNJ+PljpCltvmuQ23tsIqnGY?=
 =?us-ascii?Q?D6SI3sKxrfsa34SxG3OPW704stVsLTWiUd72UMsa6Q6cey4hDE/QC6l1bJwA?=
 =?us-ascii?Q?2Ue02bVKKVxCiNNb7cMF9A8pypyLf8eAM0ZD3AnxEl3qcUlo8ACS453/r3XS?=
 =?us-ascii?Q?ALfvWaBLNPzfO6v2Mvva3TK1JZsGlD5XCKVbwHtMFxOakjIfxDFQxj7PlTTF?=
 =?us-ascii?Q?nLAwX6qYmRaua/qLu0/SW16HWzeXeo8Z1hrHnMJfBlHcP8i/a+xeiT/gZ8Lz?=
 =?us-ascii?Q?+RckBsdpuFjxeMnoWTm29LkvQD44SR91Y4iD9sPYXym5h7kId6+p4KXuePzP?=
 =?us-ascii?Q?3mhfmgnJljM9nFhUeBO44t+AcqA9oA9xOSiVx5A23ybqL/FgWrn6rTBtVqWO?=
 =?us-ascii?Q?/yfNnOh3345RiP15e1AhA0J52LoSCj2CtzuUZ85ByG/AZgypFkLjx6LR373K?=
 =?us-ascii?Q?mt0WtjF8cIoZ083N/9NjUKxaVq/h5C+3UF/33aMR2ak1sB5fMl086nj8odFL?=
 =?us-ascii?Q?igduczF+h/9PL6uB+zR9YsbymP8LZRuqx24vVVofW1ahGKwnrT4p15hi65Jo?=
 =?us-ascii?Q?GMZqJvRn22L/RGpqB46nytWrp5qFOQmQNK+dsnlhBe9vKa6nkE2kYsLffHTq?=
 =?us-ascii?Q?iSdxnVtH1+aiMHYBKscaHOU+jTpHSv2Kl5ndE5lHa0Ivq4/sjhjq9/AcfoFC?=
 =?us-ascii?Q?uHEIAHrBYVPmULMl63f12/0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62C0C68A48484F46A2EAB514E70C989D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16388962-63b5-4391-40d6-08d9e1acf0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 15:51:54.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlcGeSO74PlNj0UTdkj1oS3r/yphGn08lr9gXTPmYPUszIUL+RSvS+ENxnbfAMSYpkJo7+2h+tMaLWaOshchKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4850
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270096
X-Proofpoint-GUID: eO-7A4JfupRrCfn6mV2wSctRJ6up9gXj
X-Proofpoint-ORIG-GUID: eO-7A4JfupRrCfn6mV2wSctRJ6up9gXj
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai-

> On Jan 26, 2022, at 4:13 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> From RFC 7530 Section 16.34.5:
>=20
> o  The server has not recorded an unconfirmed { v, x, c, *, * } and
>   has recorded a confirmed { v, x, c, *, s }.  If the principals of
>   the record and of SETCLIENTID_CONFIRM do not match, the server
>   returns NFS4ERR_CLID_INUSE without removing any relevant leased
>   client state, and without changing recorded callback and
>   callback_ident values for client { x }.
>=20
> The current code intents to do what the spec describes above but
> it forgot to set 'old' to NULL resulting to the confirmed client
> to be expired.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

On it's face, this seems like the correct thing to do.

I believe the issue was introduced in commit 2b63482185e6 ("nfsd:
fix clid_inuse on mount with security change") in 2015. I can
add a Fixes: tag and apply this for 5.17-rc.


> ---
> fs/nfsd/nfs4state.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 72900b89cf84..32063733443d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4130,8 +4130,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
> 			status =3D nfserr_clid_inuse;
> 			if (client_has_state(old)
> 					&& !same_creds(&unconf->cl_cred,
> -							&old->cl_cred))
> +							&old->cl_cred)) {
> +				old =3D NULL;
> 				goto out;
> +			}
> 			status =3D mark_client_expired_locked(old);
> 			if (status) {
> 				old =3D NULL;
> --=20
> 2.9.5
>=20

--
Chuck Lever



