Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4376832D2
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 17:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjAaQfY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 11:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAaQfN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 11:35:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C3B44B
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 08:34:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEDhJa000765;
        Tue, 31 Jan 2023 16:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1fYFYSQm+r98bd1lEMsaZ9O6tDAPCCyB8C0RBWBoIUU=;
 b=Q1ysHIugbMkDNEDnyh9gIAIu4i+kcsQGrwDzxmHzMWfjFTA88clqzsyDo5LZRwVo9Fmi
 8gN9a643OrPvOk0cpwPLscbwZnvzVYWWAE2LYmoszFQ2TLRlPdzFgR/jfGE6o5a7W+Px
 CmwKhN+KDSOcoiUrqSp0BAMZ6O5u4RHkW5av5tpv9WMv+MAh/6CCOzgdULQwpL7ZAOKc
 /OmaPgbb2LY2s12JVeF3JO4cR6kE6EzFbPUFmfpRFP4r/T0m5wsUVpPfxccp8ciWuwOr
 d07wAO3rHsp+uFUdyS5KsKRz+eRKvBV2T/3XSevXNyx1FWY0BgcSrK0yVIz16gGTNarz Nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9x25s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 16:34:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VGXKpT036072;
        Tue, 31 Jan 2023 16:34:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct56649c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 16:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1LqBOKwKspAtQXYKFOMTVqdZ5FBR4m1wzBx2nOleIMG/+wgInTaZtTh3coyFNiAJqAdle4tPCEDfaT3qy5l96hcM2vciR7QuJmsPECUINfc5Qg3Kh/lwrijs7Du2VH2OzwbZelkbdoD7zLTn/brVhcTmaoJJ1OxW6C0vuX1amUOaUkKoOs2/r6kM17L2lU/7flXrHOYO6bYsQZklBMPvjpFMngbLF7hdDed7R8KH2e9aXmnEzBUq/2lIsolf1H8JnDc1EIlO0RakIJiv0JWvEOvGTP/veReed4eye5QdCs/kJ73C/KD20aSEwzxv3YG0x/clu2x2PzBBFfeDU9qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fYFYSQm+r98bd1lEMsaZ9O6tDAPCCyB8C0RBWBoIUU=;
 b=M0W58E96pQE2QnDdZE/wnzHL9RwXGM7ECimO1WrwKOzYWbre3y0Z1Dw+QKUFI1aWEWZvniuIqsbfsEcfAR8ukOpoiw09Jo5JTpAler6SA1sPv0IIcQt+Tau9HVheYxgFkJJTQ7aCtOcEIN1dX1z0wfBkl/Ii2wLAlC2WiQFW/SlGt+5+trbSv7633kIglblpO9wQoaVIIZkFJywvoIbm83c3ZByw8NDwsSEwdip4YYWX3y1KbeoyY2YtZV4N+L6cx7WDl3vRLQ4aor8Roifx827QIEvh0hqm2j7P8arB/XiqvBim+QScEdFTnSReJjTMAvK1rze/3l2PyO93bByRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fYFYSQm+r98bd1lEMsaZ9O6tDAPCCyB8C0RBWBoIUU=;
 b=wqA1qDlHGHZgpWmkAXX93pAvjf64CirccsjxDPAo6qj3LkZjfH4OQfiNYrvDUQOQFyOD/8aXBclyt0fmXK+a7E/mCr56SQp0VpMMi/h5ZAP6zdFaQ8M6rZXY5ZiqqhlS5DvLPkddV07KTwyk0FRnMZice1AfhOC76h2b3+iDuZE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4410.namprd10.prod.outlook.com (2603:10b6:806:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 16:34:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 16:34:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Andrew J. Romero" <romero@fnal.gov>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Zombie / Orphan open files
Thread-Topic: Zombie / Orphan open files
Thread-Index: AQHZNPfk4CJ0DwDhNkGXE9jEOOJtYK64haaAgAAU2QCAAB9oAA==
Date:   Tue, 31 Jan 2023 16:34:43 +0000
Message-ID: <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4410:EE_
x-ms-office365-filtering-correlation-id: 86363cfe-39ee-4862-52a4-08db03a90ee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6+BJDoMNK6ubO688Oyv2ayRWSk2cchxwpR6DZn81ihC9CvlKwRcl0nuRqCWLIXylZDf5ThWypVMD3sZ3G6Xtogr5b3+lZbiV9A/RIllMVvLpP4e4d/IW+rU4NYk7/ABEdTSuKSgDCLEi3CzwqojjGd6XAjuQFxqqcroY76/MulsBayzo0JZl8grcbhdMWhyU8DERsNwl9Aq9bvzPWW5o3fZ3UJK0dbflY5QB3SEV+9H6BN9zoyFxiqZcHynvLuA+YEMhh40Er2/Y4wciizgL+lVzgnaw1hekjanEoF9rxv58KTAAITUd2G3vYu2xYZc4qzTpBVrBWZFP9d6QWg3Ft9cEyxtcqXpPIJHnoX+KdALDXsxuNs2eYW4tY5WoJiq4ZREBBFt6EjVrLmnF1tAxirF53Y5T/rq+CC4+V5WnSJ6hUUK5B1i+MD3aOvg0k5ZYlz4+SF8VSuqTrm7yIc3bQQzfDackMNICW1DPkJABIGQqtWfcw534U4HF+StMTaPUTdLGwhhvgOCeI8C/ds7oHJZKDjfomXHIg0aWGGi4FZR4v4F3H7OKviZXdRd/lVvJOCO+3TMZZEj220AT6m1f12AFDJCkOITS73aPxTLWx6no1h+wOA99f8eWvga9xDwefv+aALu1nTJDuglA8x7a1AmEHHKPCogp0usKKNYG1S5o0Pd/U6RZl6TA3doZVhrPdcwqGJtflQygVO7uuqD6BUSLaFu/rNp9OCbb2R7bhE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199018)(8936002)(2906002)(64756008)(8676002)(4326008)(6916009)(66446008)(38100700002)(478600001)(36756003)(26005)(33656002)(4744005)(6506007)(5660300002)(6486002)(186003)(53546011)(6512007)(2616005)(38070700005)(86362001)(71200400001)(41300700001)(66556008)(91956017)(66476007)(83380400001)(76116006)(66946007)(122000001)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12Edm2oM66XbesBRpn5dCEPHn+eibNMNgGZSlCfhw/8hJeoZxeiUFujHwUno?=
 =?us-ascii?Q?pEuJ1BBsdZJfriQkTGJJ2bv9S8nC7xMO5S/goygeR7lf5fYtCNz4Itxj9bpT?=
 =?us-ascii?Q?DxMk0Y/c1kpUBLPIgeZagG6oUA8e2lUvTxRciFtZI034jOjAHuYxVWEHulBa?=
 =?us-ascii?Q?J3DbLoAvJP2eq3xeV0PfF1hXMRVDM1Uy4N+TcTAWNTIaUUTNdsEFhcv9j7TF?=
 =?us-ascii?Q?kRdUS/xzkEL9wJ3cFjmbaQsld4KKVY6M1ReLmU4bGMl2mwWpwPI5eMYT8TZ2?=
 =?us-ascii?Q?xaO4X8L9u7WiuVYavtq69wkG5OI65FW1qV9eCNwlXRcxULwYmwzzjatI1K5P?=
 =?us-ascii?Q?MX2fH/bE6a8K2c6ZwL3Vk0doykYfKjxcoswUcD7yTktF2gucZZ88/mUccsCz?=
 =?us-ascii?Q?ClWAa70xDUsEjIeFcS81vsLMQlUUC74rHXGvDyISkl7cRhTbozSKiDtR3c9d?=
 =?us-ascii?Q?tuoG2pD/06ExKtnRKpvukEelvu3lnLCP0PfQLGpJUf9qlN33KbtAA24BkHes?=
 =?us-ascii?Q?YLGPmg+7FNrkHVQxN9ZfshQ0jH9PZs7pUXt6BH82/MFqkjjTQIGoOIZg1xla?=
 =?us-ascii?Q?QZp9OnMQJ1padO5bL+0pfJSNejs+Sdb98ZsW76JpsUqr9svdUM1Lkp/DubW6?=
 =?us-ascii?Q?4QibWaUBFx2JvabmNvkIcwpu4HQG3CoHsn//dndnz7POTNH1pu1e/E8T2le+?=
 =?us-ascii?Q?+0xYVnIx6uqfahyxBoucSTSkBQ/CnnUECyYt3H8fA3AprZYKA1qIvQC0sZ1p?=
 =?us-ascii?Q?yeaVR8nNZbXJDNao71+ChCTTApf44eRbcfO1vfGlJAW6TXa3G86IxdK9PDtj?=
 =?us-ascii?Q?KSxsWItWg7UauierGWZ2PFqXVs727RtAybLbVMMKwi5oHqwzBPaBioTYM09D?=
 =?us-ascii?Q?MRCJveKLxShE7AWU5txtKTA3W/UJSicTGp6SAcKMhGh8vDveYnNbijigpUwK?=
 =?us-ascii?Q?IwC7BFdG7DpqJ6TYchfJQ+OZpBfYfrVJfF+7Rg7/XLi09oNlckOU1bbZ81Lh?=
 =?us-ascii?Q?A3raXpAzTI1RnGUQeWBdL+aJpOh+gdBrZ37QInCAo9QPHhRpFO9mSeCr70rj?=
 =?us-ascii?Q?Kvc0eCM2hI3GAFHgD0JnKSj3kuGwbIOSpm8c/k1zHap98JQb71Ky4oeJ2xJo?=
 =?us-ascii?Q?id/iQP/grc81nPDcUFuzaXlD5Aqo/CiBsbsiDFzdw6QRb2C++7ZHlwbA6210?=
 =?us-ascii?Q?7Y6UM+Oky2Ig+xgL2d15jOeqvBFqyvDt6JqJwhwlcOuzEYDVqA+8lWXUN7Gj?=
 =?us-ascii?Q?08xGthplk4efBDCsDmpyAdIq+zztAC9RNmAMYapZ25ykqeazbzbHYYe7E4WF?=
 =?us-ascii?Q?/YaK4Mev4oXh5gUymAz8+50cG9j9ezAEcHWsRnCEJ/9Wqf50oW6J85ruSXhh?=
 =?us-ascii?Q?VDyR69vL945oNS4DDesaD81pkcoZiwOQ9C4vgTvwvAl9CPyIllrWe2xtI7xL?=
 =?us-ascii?Q?8kATf1SQZSNjEjRRYSeMnGX/28yI0RGBHdEgjZe7ycfWLYU12xekLKJam8LS?=
 =?us-ascii?Q?WVtRt+5HwWzqmfyMDj2BYhTA75axz8hH3TraWa1OZOmzOmn4gzUcz8N3lywF?=
 =?us-ascii?Q?tmuLZHlzB8u0ItwBGAR7VxNnWBeIuXHJwppjKzWh9IuR7NbqUnqk9eE3erEo?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC365877061E2E44B1BB26123ABBE733@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6JopQcNvL499qLzUSBR0QZDoFArzEmm8eKacikzRZZ2JoAsAfFWQ4cwzgve9mcBaTXzfYMLe7skxUo5VbKdFEOE5P7WEEzmUkTo+0J/tIq89etIpykuPyAH7nUNJMXwCJMGlwW9oXAX3/wA92Pq/JPbB9xe3cwo6dmm3mWwR4K1lzPrw2phbzkbziFJMqYzLOGhsLuAdD+qTppoQZluuz6Uu5x8MTddrk2ep/y+rrbw8hwMAH+db04lNy6cFKkVeDw1K27qkGUPMrZY5XbcvFV0vnuQ2R8vXL/T8VU9IZNumOo0+8qFw7xMNWaOTcYQ+3FtwhpYJtOOF/ChwsEaFTxKQtXFh4aQNR3IYx/loJpe3QZxo9cCXqeWgWnOzuP4j94oRu5E1n6j21EEbxu8472jv1vTqyjQDQAOuDQVXmgmnDg2SxvaLv7WtUJMejBN/DWb9jSNjtq6Fjj08+phWHRe0ZY9N+18mnuuZUNTAYP1LgT0Xu36Sy3T8AB+F0rvWHDgbI4cdG7OMYMkuxiL4vuYAE5J9ENDl7heI6ecoNw347VPMlrJIU0GZ0sWaWkXxzrNF1s+LHtpsgFSVg0c2XCnEPocHw/RTYMiq/s6srvGbdqFfWSg5fxyE75R+18a1+P4UO2WSyU+j1haXJ8P/PUD5fANVL84+f21KXeXvIeVFnFUsvpSlxo+e7Qs1AaBCK2c1rJmvFSV/jC2xh5ryjWG4aaWPakOA7YxyIBsoYwq2adn+ycCd46FfNvo2KJEZdVa9DdaOspgFJnNVYYvAHyr2IEHGqq4hKW2SU0w59MJZN8wmae8IF/nogflTLUYl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86363cfe-39ee-4862-52a4-08db03a90ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 16:34:43.7142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdMYnO1vIFjr1LBTip+gzysEzPCKMa1D4N1LDT9CMdlFDuuoZ3tBh22Nvh0i3THm/rdTx3m9W8aV5RFpDcWoGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310146
X-Proofpoint-GUID: byHHANwD0ZV66dzrF-3CgrUEtEcxVQnt
X-Proofpoint-ORIG-GUID: byHHANwD0ZV66dzrF-3CgrUEtEcxVQnt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 31, 2023, at 9:42 AM, Andrew J. Romero <romero@fnal.gov> wrote:
>=20
> In a large campus environment, usage of the relevant memory pool will eve=
ntually get so
> high that a server-side reboot will be needed.

The above is sticking with me a bit.

Rebooting the server should force clients to re-establish state.

Are they not re-establishing open file state for users whose
ticket has expired? I would think each client would re-establish
state for those open files anyway, and the server would be in the
same overcommitted state it was in before it rebooted.

We might not have an accurate root cause analysis yet, or I could
be missing something.

--
Chuck Lever



