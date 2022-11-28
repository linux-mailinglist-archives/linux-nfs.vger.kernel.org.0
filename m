Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729B63AACA
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Nov 2022 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiK1OZV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Nov 2022 09:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiK1OZU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Nov 2022 09:25:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E11C2AEF
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 06:25:19 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASDhgNR008714;
        Mon, 28 Nov 2022 14:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k7bv73beyNWFmZ6LZSq5ved1TPwplhxIhWIWQm21Odg=;
 b=LCAiPehmKKLaTSekzBL24sUxKvnWlP5azfPpDuzvWnz242DQtr8J8jJiFMtj5hcyMuxT
 /I5JwgsvD8FNFhyFZBR39wppOh1DxG6xZJh8M3QKsE9yZbqaWkoYlniDkSH9oY8pHzp8
 ijpN7ln68O1rctPLXHQhbLz8082IyfCyp5wdjfyI2TiNUGjmewrX0GpHD7sN/zi0RJMV
 4HZXsS+j3SLWugNTyxUOw2fYJN9ndsNMgViki5AHFo0D//5OXwgAasfVzepK53qXjJ8a
 ozf1V+tYSqG6o0mdE79aVNXtO35HbCTQcaIZpo1MjqrQn3EhQrKNk81j9uMWgSTYRO2z YA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2kjbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 14:25:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASDUlJe031522;
        Mon, 28 Nov 2022 14:25:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39851ay4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 14:25:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMF++BclqlhWaTKkNXab/UayvKBBUg825iYKV9nrbPqR2W2pux0CCeA6dsgAdOYH6n4TQMnbzcTQCpEZtogevGcoG1BtjEhcHiMKpcxMLgRqOKbKZxffWRSDMrDRzlY+cf6CWuTmAClR2sMHUayDnfZJdYJGCp2198ZCoPSgALJvPaSVUdmKqxPXsi3yLgMRBHPvtgB7v3LwvBIV9Wv/mqGFTc3MjEQA56FG3FuL+NSoA7J0gIl1R6x2/SllTbEKEaawGLCJJnlmoXThrYJna7w3vUHiqberzubq3y+bLTclwaAqtFvALKNcucRO1OJ7hBdjhWCuDIIboL/cn6jWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7bv73beyNWFmZ6LZSq5ved1TPwplhxIhWIWQm21Odg=;
 b=HUTTUQL1sZZCnKkjs4OaxPvIX88TnvqpyMBm33FW5wOfqsjuJr+KPBmulVUY42SoJ2iKFOWl9raSHigWtQvUfyS8S4N0jPycJ29wsxX4tME8VPlA/QJlxS/93VICAcf0K5+36PP0cKg/XY80B6Qq3N5JCEB5UKOAy8OFNKif6537p0TSD/OTf2CT9WSNpPd8HR5CQAz7SSJLSxdBTWduG/GxH5Iq9dOrk3SECNFEcafd8WWhNfaKl2Gvii0THFfaH829kcaDcIfjEZYNsGsT37ZTbHtvyVRQhx+3Sy9DEVsdz/0i/zn1C35D7tUj5tDb69D+0WBI6XVsQMNm8UHAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7bv73beyNWFmZ6LZSq5ved1TPwplhxIhWIWQm21Odg=;
 b=gaeASkk9LK/UOdqDtmSA9Y1rEZvEexbAP/3JfjGpPs7IUvq55F7rp36YP7RqM21AZDl2/cqOYm+f38TBqVNVIFWeULSUc/iBoRSu/EprrEjRCR3xBe5piacQQtJjx+QhHgoU3petIruuQ44GasvIr0CGMooXF+TaSyr3RDlOzPA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:25:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 14:25:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] SUNRPC: Don't leak netobj memory when
 gss_read_proxy_verf() fails
Thread-Topic: [PATCH 1/4] SUNRPC: Don't leak netobj memory when
 gss_read_proxy_verf() fails
Thread-Index: AQHZAdlxKSse4NQqL0iCXWrGsPU+L65UUiYAgAAOMICAAAMagIAAA0kA
Date:   Mon, 28 Nov 2022 14:25:07 +0000
Message-ID: <7BC323B0-7F7B-455A-B85C-A81E36243F3C@oracle.com>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
 <166949611830.106845.15345645610329421030.stgit@klimt.1015granger.net>
 <3e33c1ba057d39f145bb935b6f92f17dc9cbd207.camel@poochiereds.net>
 <466F83EA-12E1-4C36-8F42-AE4F8578DDEB@oracle.com>
 <3fb9efce2190c0ab511812a95543abb0d886545c.camel@kernel.org>
In-Reply-To: <3fb9efce2190c0ab511812a95543abb0d886545c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5265:EE_
x-ms-office365-filtering-correlation-id: 964fa8da-5db8-4841-1701-08dad14c5954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5bNXf5IvkfJELO92x3u9al7bNlLbC2izpEzyJJeFrSuXZ69pmpdJr6ukNt/f/rq9hUMeCQt05ZSn3uoxAGfv6fV9WIry81E4VNkNM71oai9oeVi3wK1+mhOJyHyWn2EcEo6AUQ7arozRDK/HQ4LDMsntb6Y9OFEVCsz0xXdt61cqHxWnDdy3fo8lV9ROckjwybxpP9eP4j5JsInp1dZnLoY2wBkqFP9VqvX91zrDEVSCjiIkHz9eUy8v7T6+PAfKC0PAOkhY60NQ36wdO6Fm0JsXkrZRFAQ5VVqJRuRP7KsTFqICU1NB2ndVosal8ojiqiV3dP9c+1Zsu1JFHYXHq2H6Q8eaNylVWWXrkcs/aHfX5LfOoKmdcQevFAZl3YPaYosrHFQ5/rGKm42eSqh/KZRYQ6B2yzvwdMmZnfqlSq5UGMOwT15F1zdlZoN0GKRADN/vDABGRmZ6UZ+5EqItL2kTn5DT5VvwkWyhaeASKmrO0kSlrpUcZOZLn3NnXE8wBQ4iWnbWGSamrxp2yPbGm+wymvuyawZLMflW32ckY0zDsJNdRkPHIpZEkSb4K7EszOepe/nQQBdPDFtpst81DsBZQNuoMgCb/A+LNHM44T/YSm7VM0LpUJWXj5X0mtFYXkLYwtoVpW31aI8lyIi+XDbX+tVLdZPy7aXBVvvnags8TE40A0/7jnIxEke4mkjBqD2nzdIlFME7eUdYlVPYLv/yRH1kLeW+GJVjPGjYnQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(33656002)(38070700005)(6506007)(86362001)(66946007)(91956017)(64756008)(53546011)(6512007)(8676002)(41300700001)(26005)(66556008)(186003)(76116006)(8936002)(66446008)(4326008)(66476007)(71200400001)(2616005)(478600001)(6486002)(316002)(6916009)(38100700002)(122000001)(2906002)(4001150100001)(83380400001)(5660300002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a5h67YmJGTO3jCCsSrE1n9ySSUPUmYCh1kIkD+T9JJDOv/vKSIxQuwlyzeg8?=
 =?us-ascii?Q?2b6yLHG56iMsR/8ic2pN9X1SZQXnkVoHP47JieFm8dpZkD+CcodiYEGc0Pdm?=
 =?us-ascii?Q?zkHolf8JjRjr0iHMdkKSVwDoSLK37KUmHLUzGO5IFo29oVskwf7v72OV3YR8?=
 =?us-ascii?Q?UkUbc5IOOtrEP2a7aYL3oR4rkLrncHfHSoWpyOh4kacl4BsX3Ap9h402MpUS?=
 =?us-ascii?Q?GxIvKYIYkl7dHd++iU9398ww9xwJg5wlsl94kXlrgKVQissvG+DxfU1pU9px?=
 =?us-ascii?Q?yR7fvLfBgyzUjq7r1LvxBG+97ocVeIjli9YNsWNqDKz78Hed3xVJTNow4c3t?=
 =?us-ascii?Q?zLRXdxe9MRMpQYsRPeclkZ7N/nmD+NA4f38XGF5MnnHUXjeEjCmnrcju8x+a?=
 =?us-ascii?Q?H+SV/aXlAcLgYiiW2LtRcQQ5pCxCI3KsIXGYjVbFR2r0rtShArjMEkqXkPz/?=
 =?us-ascii?Q?jMxhzeuNpfKSkT/suxXMQaS5QrtvmHBiRIeNXdC9DsJkmRXchjjrF0Px0C0x?=
 =?us-ascii?Q?L7Hcugfe5IQThnYEEi/VxE7ZaO44qOAxNUMf1pJipOo4XNGyjZe057PcwO50?=
 =?us-ascii?Q?RsmgA8g1u9u59Z6UYT0Ao2bXQcycJFbXBidhVlscqFRb3yiCfC84w66PXsxE?=
 =?us-ascii?Q?8I/Y54n64Y3FCAPsxWMX/+VMYZ7Skj5mM7/s/L3W5Bbh7qbAazst0idgNfm1?=
 =?us-ascii?Q?1dpNj5iXZG/gr7DxwNUzB1zpCRCE8BBXAC4EdUMRLpMXEzrlTVT4ZXM3XJHC?=
 =?us-ascii?Q?k4u6GEiFHb0DlNyyaHUWCa7BAvCLSHu+SOkkVWuXXejHtit7ABwa6+il2LjU?=
 =?us-ascii?Q?obEP8lzx9zETuX7XF0aoxQHd3Kg8bAX8uCaGFOqh3igBAobHJspREq8lT8CY?=
 =?us-ascii?Q?IFfZ3dQIrllZFvfMrC4FXB6m6oY3vfqy8kP/lsqmu9QoIFNkGvmbT+XNZa51?=
 =?us-ascii?Q?gOjNfEjQnyjoXk7pFKGqXIotfkKx6n5ee/XTG8qLWb9S4e5HQtLjHQgLIDXL?=
 =?us-ascii?Q?SUB8R/fmDs3Q8t6AgMH1Dmmd2Tk630mUsfY+pJ4TQFYb5Ri/XTbuRakmLMCO?=
 =?us-ascii?Q?HabFTag2+YOHR9FGCOacTqua3nbET4mZe1nyu2xSGvbD/ZxbP5EtYycPn2k9?=
 =?us-ascii?Q?ggu8MNJIaVOfQg4c/n/LlHfZdQ4UH/TmkYqgybS5nbYCQQqcOxHVhP44iIly?=
 =?us-ascii?Q?+/lrDM35FqrJJeqXhBVOGcbjATCSdLVPvSGxuLnNvCoWPhdIrZ3w+SOzLIA3?=
 =?us-ascii?Q?O5loBg1F8OiPNNxvSO3oaeL1HEBS9T1yjFvwPLubv+taqq7NUjr5d97fExzX?=
 =?us-ascii?Q?wPwzZbqSeY0Nl5w6N+5zYGjs4sOAbe1+uh1lZP6D1f6TQ9nqqejIz7B81tEU?=
 =?us-ascii?Q?f/fA+1TJ3GPqDVixSX1eNm+1kGcX2GZmzT12txTh6Hpi/eLyPcknsvkTfenz?=
 =?us-ascii?Q?LBWYPapRjQLzRzio8Cs56MWsKfTGbRo6nT8P2AMx+LLi1UM9Sxr2aZjhhn5t?=
 =?us-ascii?Q?qixH3jqj8RGL7oK8MyZI/4A6Vd5JtgEcB5PfSn81sk2C+5I6ycNTYFLl0BgA?=
 =?us-ascii?Q?fRtXaXQj1ufpihmpqsq0P7pyOP7uJ+QisJygbXT0FqflOrNZX/ahtDCko34Y?=
 =?us-ascii?Q?bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C38FC04FE647148B9E02C1737E1501C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xd8gFGgNXPLEDqYZeB2fC1OuiPRvO4EHs9MBqJRmc0y8uZgYA5QcbMCSVNoAm7awAiBIvnEfw1DJYuUpXWwE43JyEUuYLUP+3J+Kf2vKrNSnD2jZQXawFe8MphdU7ceKWDdnV3u1ADSReRRKAKI8BaPZhYi49HC8BwdKafbErzGEnMBIAddS3Homi1Nq3UpLUdaLVORIjwzkrJU1lI5O0N/KHwSU9B4gBc42ni/BqER+auX6mbulAMCw8NEU7E9jkTm5jSzSFlXx+dJzfwuok2L4LvEiGrxmw9xPfml3y03rPHxneabZYabiD8Il0QbVdJUx9Ga/58D7qOmYiZMPo8EYHxc10hy9PHqJgVwxM2sVN+WfvuqiZzaSQ2MDJ6tbbR1ECllyYAQ5iuDc38DGTquOGw4HO+etJprMKpsZECwdcbLurTiwd+hwjF+zWYpzGvoJah4J8COo7RTO4/kQ0lwywaFNM2N8j+c4RRHwGEcP61TNZop1z6jnnWT0BZEoptnZ2W8wa6wCQyS4Ftx2xkGou0dh+3OBjFJ46NcHh3FyvphWHqufOMZ3mVMgXzkjZDmnKFXTMf7NKPkSk6wWa5vVrIraYL5fAXHF/kPcYZHFQc5+ylKs3Po9BsYzx/dPmOIwjAhaMthS6tLFP8R8F7gAEYPIV9RMx9VSimLAkpY7he5Vc5Jsu8R3gRq+0Wq4S4iOe14l00rUWSJYwxKoEhaDMz5MD6TqlRcO4jVGIHa3A345gzMI7xPzPM5BhKAS0ZGTykNFA6SeyMDmTlVKNfh0Gc2FuTS3wj9Onxdfy7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964fa8da-5db8-4841-1701-08dad14c5954
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 14:25:07.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/I5SRG5WxSCHkHv74twz3ISvC0YirkH5xegl2D2ulHEXRNFIcqo8OjAZWMvPQECTLwCIkzWZlvXCUN7SmDxww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_12,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280108
X-Proofpoint-GUID: -2gPW3HHEaHt3600INk4W78JQ6P_XUzr
X-Proofpoint-ORIG-GUID: -2gPW3HHEaHt3600INk4W78JQ6P_XUzr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 28, 2022, at 9:13 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-11-28 at 14:02 +0000, Chuck Lever III wrote:
>>=20
>>> On Nov 28, 2022, at 8:11 AM, Jeff Layton <jlayton@poochiereds.net> wrot=
e:
>>>=20
>>> On Sat, 2022-11-26 at 15:55 -0500, Chuck Lever wrote:
>>>> Fixes: 030d794bf498 ("SUNRPC: Use gssproxy upcall for server RPCGSS au=
thentication.")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> ---
>>>> net/sunrpc/auth_gss/svcauth_gss.c |    9 +++++++--
>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/s=
vcauth_gss.c
>>>> index bcd74dddbe2d..9a5db285d4ae 100644
>>>> --- a/net/sunrpc/auth_gss/svcauth_gss.c
>>>> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
>>>> @@ -1162,18 +1162,23 @@ static int gss_read_proxy_verf(struct svc_rqst=
 *rqstp,
>>>> 		return res;
>>>>=20
>>>> 	inlen =3D svc_getnl(argv);
>>>> -	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len))
>>>> +	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len)) {
>>>> +		kfree(in_handle->data);
>>>=20
>>> I wish this were more obvious in this code. It's not at all evident to
>>> the casual reader that gss_read_common_verf calls dup_netobj here and
>>> that you need to clean up after it. At a bare minimum, we ought to have
>>> a comment to that effect over gss_read_common_verf. While you're in
>>> there, that function is also pretty big to be marked static inline. Can
>>> you change that too? Ditto for gss_read_verf.
>>=20
>> Agreed: I've done that clean up in subsequent patches that are part
>> of the (yet to be posted) series to replace svc_get/putnl with
>> xdr_stream.
>>=20
>> This seemed like a good fix to apply earlier rather than later. That
>> should enable it to be backported cleanly.
>>=20
>=20
>=20
> Fair enough. You can add my Reviewed-by to the whole series.

Thanks!


> I'll look forward to seeing the full cleanup.

It's several dozen patches, and it's currently based on something
close to what's going into v6.2. So my plan is to rebase it on
v6.2-rc1 when that becomes available and then post the first half
of it (the decode part) at that time.


--
Chuck Lever



