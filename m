Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8681D66188A
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 20:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjAHTdn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjAHTdm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 14:33:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB6065EA
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 11:33:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 308Inuv3021407;
        Sun, 8 Jan 2023 19:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=G1GWupgbHtUMVa1rWJb8KydZBcdtikyryM+7iQIFUVk=;
 b=oFBq93d+7nKaq0FnqtvpJvC+hm3+Jvj5j4s7RgY0l0zm/DarTLoSXkjQUOGuYt7CjSqJ
 F6oyFtyf2C7v22xbM33zdO0BibwOA8mFm4YSLqqTq76RLzoHV1cd4SQ582ou/FoFaEaQ
 zDJfgpgP3DLgF3+9VF5WwvO5q7qkxzAodrKsLBvzo4VCZ1Mk2AaLulQx60fD2DXdH++R
 7eKduy6cZ7XtKqtiUgoDiQ5qkUGVuyf/HcB4/9hfayVIucwiBrOCaQdBCu5oP/mlPGmW
 II171iCpGJ3q/aH6m/2byoR6SF+EgFPpv2ZmHR8+eRpcfsx2MZQ18OER7SEMBo1cnpcH zA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mydxm8w3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Jan 2023 19:33:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 308FU3Xs000758;
        Sun, 8 Jan 2023 19:33:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy637u16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 08 Jan 2023 19:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIDMWVYIpF7D3GuJtZlqf+J0lWtKT57X5zaNHCSAFD3fIiOxHpXt/nOqE8vsX/Ooav0UD8ecOHHOLF5F4shCu5/E2MEhA1KssZV7X1Rm2CmWsnATCe5zLcbCBxFXOcI4kQDiZoDFQt75c84cGaUI4Xjr5d5GK02J7WtwRypALrV2j/cVI7iM1NCAZ7P/FT4JYH8lY7LffXkRKpl5nJTCYPESntE/3YogvtCiFLgUbSp6RGNB8odU/exWbL4tOwaOL9h4T8hnaR45+0W2mQQbSbqurraO1z+QCzPAcK6XWtPKN451wGqUFMXrwFpfo8d983pyHjseA/8bsR8IXEtgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1GWupgbHtUMVa1rWJb8KydZBcdtikyryM+7iQIFUVk=;
 b=Ic55CqKYTXhsJ5+mERmJm4jO8EeJYjZSSwPn7pNJXUKOOvyHqrqgBShVsL4y9/Ko7okzRmz0ysGTn+/Gc0z+nNuM2a6HOS/kI8iNTxCY7MPx0mI5YZvtSV6hpMc5/aRFOGyPxz7w7CHac00Emy/puPTOEs8Lg6I5xEo3uHG24H+39f+Xxmx/Zl5Z1oexi/z0BU2qOC/pXkELDddpKqACVkZb0KQs6sYA8O7WgaR97kov0bG4GQLMVxC30EwJtwB3G7FqJnYUlP4ivL888lj5+uNAwsRtJLttW/jfUaQDdCNxb9ZSQl5qXKZEvD5NFGgHxN9HS9Z96m0SzrGDX7UUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1GWupgbHtUMVa1rWJb8KydZBcdtikyryM+7iQIFUVk=;
 b=HvuWghagKQW8SkrTCi8sbF/s2cK/ANZIiL4mg82pop60DstZf6wPV4Al39TaD6pPWUppcKvFQxMr6HtjD8WWTFk0frs85LAaOg5kMrombsXu/ooxhe80uhVDe5NRM0KUi2wt/SptS21Kx/x8a2PU7zVd9s0lXBbIPXADFTe0u1w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Sun, 8 Jan
 2023 19:33:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.6002.010; Sun, 8 Jan 2023
 19:33:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v2 1/2] nfsd: allow nfsd_file_get to sanely handle a NULL
 pointer
Thread-Topic: [PATCH v2 1/2] nfsd: allow nfsd_file_get to sanely handle a NULL
 pointer
Thread-Index: AQHZIeRLNKn8Ix6QSUa8Oo0IIf+ULa6U7F6A
Date:   Sun, 8 Jan 2023 19:33:25 +0000
Message-ID: <77443457-3991-463B-B7F1-0F361183B45B@oracle.com>
References: <20230106153348.104214-1-jlayton@kernel.org>
In-Reply-To: <20230106153348.104214-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7148:EE_
x-ms-office365-filtering-correlation-id: d37ab7db-404a-40eb-13a3-08daf1af3661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ov/WllHmfvkqq8wC0Dxq/rfTS5f5wKtLAad67uPkC9G0GDhGvfhH0zqmdV3bRoCnUvPGPDNHX6KEO+TL4e7AvjnLbO4G9L9KswT8RhGE15DUDEELh1IPtuhP82Cia/ZH2vdBQKTsWB5L3i+frLrXipGmj4rkhM/1rtiBZnrkUOZUcK88xCpcnJcFJlEPXIiNPZrLPC5Na4m2hHQZQhz2Q0tYskrH9GtNgXSHH0ffx7xiEmAT9/L6epW72WkMOO6ITo8uDqbZm1/fnVX9SDGWibTf6rw6upnzPudJR6EukltuJseueX2+2x0C9ICU3ab0fes0+kbUda8qyX86oS2612ytT4hDZ2H2VvVnhtzHqm46x9In4vDbPeGRUuo8GLRxoQ21tUBD2Oi0aWzPoJt6zTjEpeXrbH/NpAZLRXtUJsk9J5WW00G5yQUhFOqM/bRKweS51OUhLdA2MnQ4iOVQEDEzQ7yspULe//3PucpFIaDD0sf6y4PmnSeiMzhTh/Tn6B0/5FIUSdTbuMueB6ZsEZnLAfXx9ZOdWcUA9vkmlKn0dnnJA6N8jUtrTAKFUoBMUM/M+QKzXxSHN0qYu3oSkLmOB4wHWN4BC7cXLSCuYGH0eMlKQcOFrqP2kkHhjR1FwJiZBxF4zE1zB3aFn1/f6gxd31URIu5UbxWxFodUaKDf2Q7ekmsxDVKGVTfkcnJFeAlvCke/6XQyd4Pzanxqi4cTHz815SoBqsDKP213qis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199015)(2906002)(8936002)(5660300002)(36756003)(41300700001)(64756008)(91956017)(8676002)(66446008)(66476007)(66946007)(76116006)(66556008)(316002)(71200400001)(54906003)(4326008)(6486002)(33656002)(26005)(6506007)(478600001)(53546011)(186003)(6512007)(6916009)(2616005)(86362001)(83380400001)(38100700002)(38070700005)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J1NQdbklQcPzcToHx7lnKzNAtkV+aLAdehm925+GZs0Sj11MeZkG1La94ytF?=
 =?us-ascii?Q?inisbMGMstKt2A4KXV79A+HF1X0GBs9cWOMnx89zbPFjlJhipIsRD6lRv5aP?=
 =?us-ascii?Q?z+GB0tp7xB7eEQ1hTMkTmHfyCjUOWdulAgWfcyzvG7FF1/2jyYLcXeVj8X5t?=
 =?us-ascii?Q?A49RtsR/orTGlroJ+zLbCo9Z89Q0nrn/EB0BLqZVSfXmfcTGtadhpGBcObTt?=
 =?us-ascii?Q?/si7F8TavK/kqOaMNpy3Qes5GwiXpkfLSMtviwxyXQRiGg51IsKZGq5ZIFh+?=
 =?us-ascii?Q?RFyL3GvF3xGiAuceFvg4SdDAA1oLCSYC6xojCKvxJ1VnYF2auJ5utagkH3JC?=
 =?us-ascii?Q?8IdByvSl7ubrVJBWPFwmHRjYUand7lkSS9Fo/6JtxUhjwX05bF407/UGjAiX?=
 =?us-ascii?Q?rvS52lp5ZpMD/M0FdyGqUHyQ69Qpxd1stKc1samz117yFGP+AorJ0zF1wsZ3?=
 =?us-ascii?Q?j84rhlg75iZOI5yy344UHJTztCmw86wIEbRdXV1CWMiC1y8/4DTDTc17y0kU?=
 =?us-ascii?Q?5xwROE8as3jjhSUcFSppov+Ipy59x77aODfSMBjKKM/8stocoDsxyLhcBUO9?=
 =?us-ascii?Q?4W0rIvDNhugd+Uadl5uz75G7Kge6IU1XPVnTY6BV0TW7r9YqKiLWBS6HgS6k?=
 =?us-ascii?Q?RZTy8GVrMCmM3Z7MmAbTw6UwTOHPZzPYsA452M+JZJnaPiRlxjviEqL/Mifw?=
 =?us-ascii?Q?XM1OHdychWl2l2Pwb2S7z9/7G1mqitQx5c0b8Z07W32QxGF+U140ZQiyA7cC?=
 =?us-ascii?Q?kzQi+nRESMufrhCGM0IXmmacGYM8ooaMnIvPeTrCbQjwL+HHLOGWFoXeDGlU?=
 =?us-ascii?Q?Cx5UTer0za4G7yArMGJeXGsD/T7Q+oasJSu9217mEV0/3nbogvGjGWXESQwP?=
 =?us-ascii?Q?fcGYW/hzW9NDMGe3dYwGQ+ZXZX+DtGpS0FrabNQaAC2CRk8qwGo1MjwS9LuW?=
 =?us-ascii?Q?2u6pwxXlAdHs6NKdeIfsCPHYenknHrqa/ke7ZtPzGZ4ZDvHNCekCdiaakRVq?=
 =?us-ascii?Q?qSZsR5fncivoPiO1a8MsoIvmvdI2W4GG5rEQCgXPRHptLUjIUoVFGSZLVq9A?=
 =?us-ascii?Q?n8uirkDZcd+erqc03V0jpwhDRgX0IyBtq7zkAXYwE9A/0DadXBrBnjxb6pls?=
 =?us-ascii?Q?OvLZt6x2pPkzZ/HDWDmb7lHZyTLbPRocT0VeNbbsHNWlhpl0IhQVfBwqobRE?=
 =?us-ascii?Q?8bXJM0WhQy0SS/K5MUADevCt4yPI9u/kc54xbg4yFZpI3r8Nhu4GjaeWVigh?=
 =?us-ascii?Q?k8Yeg5oR8dlk+x7mZ7lhNDR/HbyYaHKeRWpQ3d24nklGTWsPwnSRYUtU1pXn?=
 =?us-ascii?Q?tZFfHG3cj5lGKkRZCfJdTPgFKLmPt6qqsxWhNiebTwh5k2DKAknsYUgYUu9T?=
 =?us-ascii?Q?ib2VhE1+4X8Ytr8MC4SPOwbzWqzUA3HCov0URLNfr8Y/84354IqsNOjaXcfo?=
 =?us-ascii?Q?XyqFs5L+H1EOgKbSOf7qfbcIx0WLPm9VoJfQ3EtL2HuliFD1DKJxMalhqmi8?=
 =?us-ascii?Q?GUO/fMhCyOtywW3QVXjBamIN6dPsAaQL6/k9vntMDdPpfZTdTWGu3mB+xT5Y?=
 =?us-ascii?Q?JLmWBAmwj1yQ+qGSu3GtdxYytmEo7682q2AKWskmtVEfVfcjU98MVlIElanT?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BC46BAEF9A31A49ACA423752CDDDCD1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I4tv9jg5NEh5m0+0FvjCcphN86yn3xqOA7oiKew5l+8J1kcqr8CSol6xtjuDdV97ndYLz4gsUnEPJ8e6Hkk/qPE4dA01jmNR5OTGScwprbsbMT6t9uuEY/m82KYE0V1JVW2YhaArdczLPAItf5i19Cn5mSJOMzvNcDrXlerZmfwuBGbvD2SRvBSgV5/BlOWL53yvrf8/q4KbcOtxvEnI5HXQyPAUjGywcn4QIgDWrabkg7HKQikGxiJM+TsWvGVP9/nmWya44DRMiQLv+IW2T+i5gj1cgLVdfi2rFr5Yo5pkwMzEYl9cgum//XFxbJtaMupm88Zz2tHTJYK4gBQ73Gd7s/vxWFKHhEM6eA1jZgkKT2aeBIzeANuGKKOkkkap0iRAHTwCK5FladHFuBRIGc3oG5P+Ac2XXvwZTAd2KF3V9IRQ4PK0WtJWU/o7m1pHhxvjzZ7yvEq6M5DPfQII5lshuVpx71TZpClYqaEOihSEA2c0GXCRMqECOUAi9nUdj/vtWPS2sxOdMqU1eE+wKDxr4ABtVyqzECOmkS+FGyD8/ivICBjOydLaENSrSrwcjzT8+r+XR3cPhwT/ulavMqUdDROyTVOoggQbbX+2jmmf1a9WdpvenEP9fLa7t2ay/kCRvzERHKqLJH+VKFu19t62SqCWNBiT9LWCAcuErJEowrLAqRTN5+q7VQPxzGHzPA04n8QvSh4k86i4vkzGaEzPUz2maFNpjOQ0z6hWoK9o96/owU0zmCmMDettiV6/+t62WdNj14IxvL2WFdXwFNGMyS+eMPPNWFPHXfwlRA4fWB5ZBx7glAtm7ZSWJu0Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37ab7db-404a-40eb-13a3-08daf1af3661
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2023 19:33:25.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YL0zlLrZiIpbF67jdsJCSRK5YnSOaNbP5KXF1Yw7Klbd88Z2TQ/QTvepIUBcZgs7wdFku0zie/RZm79p2lKg4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_15,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=842 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301080145
X-Proofpoint-ORIG-GUID: 92OdTEGbUgItUrTDwwwlj7wW-g__qpDR
X-Proofpoint-GUID: 92OdTEGbUgItUrTDwwwlj7wW-g__qpDR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 6, 2023, at 10:33 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> ...and remove some now-useless NULL pointer checks in its callers.
>=20
> Suggested-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 5 ++---
> fs/nfsd/nfs4state.c | 4 +---
> 2 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 0ef070349014..58ac93e7e680 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -452,7 +452,7 @@ static bool nfsd_file_lru_remove(struct nfsd_file *nf=
)
> struct nfsd_file *
> nfsd_file_get(struct nfsd_file *nf)
> {
> -	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
> +	if (nf && refcount_inc_not_zero(&nf->nf_ref))
> 		return nf;
> 	return NULL;
> }
> @@ -1096,8 +1096,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> 	rcu_read_lock();
> 	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> 			       nfsd_file_rhash_params);
> -	if (nf)
> -		nf =3D nfsd_file_get(nf);
> +	nf =3D nfsd_file_get(nf);
> 	rcu_read_unlock();
>=20
> 	if (nf) {
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4809ae0f0138..655fcfec0ace 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -602,9 +602,7 @@ put_nfs4_file(struct nfs4_file *fi)
> static struct nfsd_file *
> __nfs4_get_fd(struct nfs4_file *f, int oflag)
> {
> -	if (f->fi_fds[oflag])
> -		return nfsd_file_get(f->fi_fds[oflag]);
> -	return NULL;
> +	return nfsd_file_get(f->fi_fds[oflag]);
> }
>=20
> static struct nfsd_file *
> --=20
> 2.39.0

Hi Jeff-

I've applied v2 of 1/2 and 2/2 to nfsd's for-next.

--
Chuck Lever



