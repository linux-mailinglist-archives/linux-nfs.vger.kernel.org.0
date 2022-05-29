Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD20A537299
	for <lists+linux-nfs@lfdr.de>; Sun, 29 May 2022 22:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiE2Uqs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 May 2022 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2Uqr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 May 2022 16:46:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523695AF
        for <linux-nfs@vger.kernel.org>; Sun, 29 May 2022 13:46:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T8sAYq003279;
        Sun, 29 May 2022 20:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d6JeQF/zgYzy+LZ66lGPg/L70soj/VGoSn45R2gcfb0=;
 b=f1n2EA75TpBWyd7/FzhQ1AM0+0fl9YuH86LjJEq2xdIjGuktAGi5n1LVudFdRLaFlIEd
 /Dh2HYWHzcebjyMO0P09PvUerc9W3jTwPNKJKQvpDj+rYRvVJlTZ3UxSQfyNbDo6yJxd
 MZMXXmQ3G6BRz0aOCoIRvpGWcb+shecjau5culJBZenkaBYONEsDy0iQuyYhOMPa/YcL
 cAMNBbbZxiSMqDFfkToGqjf0+nWeqyHeMNtFY5/VklzSCWX6SG/4z4yyI+m/3d0i1sFW
 M+f4CvDTNmYy1KWeCbKlMGbh4YNeA4SyIaLX87+Q4ZhbK/Ja03JqsKtdmFvGxwZRb3x4 WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6x1nvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 May 2022 20:46:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24TKjXw3037883;
        Sun, 29 May 2022 20:46:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jvn8uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 May 2022 20:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSExVEabV1D+onw9WaTkkZYw6yJzkU33py3Zdt7qa/MUcfu5ScYWBefVeT5rY76cL1T55WdCDbmRtezxqUXIni/F5q7mFymx5Yi4BCpSK1EqkSsbuDd3jGgswUVVate/TQJPoDcI6udPpmnGWsRvvGN4Ir0op/+s3glgn/IBp+cFU9pNIS2noNP2myUOaEEoBva4tMxJWwanb8ockISTzrv14LAECxxWCTUhTxz4VaA10X2A9TxpwZGXu9xSdVIw812+Zu3Q5j9US8iPxl73yBAxCEH/cFUXLV9qmQTham98+ZTs1xruJvl5EZ1GdR8VM/VeQZc1q2AXCy2/+2OSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6JeQF/zgYzy+LZ66lGPg/L70soj/VGoSn45R2gcfb0=;
 b=RLBL4DkvBVaQKGITrmP3SBNQEIJUneGiOzcd4QhzmF+Pv9nZRKSmZGn5IJPKDFpZXGp/qgDZxKqdjhIrQHNDqZJlCeYSKZDg8bXbtmizGuoY3WJqa7Y2MLboBtMLOOOliM/LFgF7A0rPA1FXC952XR1N/whEDhyI/EkBcagZXThqw2/r9t7j2uAFDH3bHj8mb1FNLOnZ+EwMXeyIENUHPSsex3hVc8HtpmXGNjuODjegY6Ukzpk7zOTpmVVcii+rWx2FDILdRL208Gm6nvAPtF1/M9s+3aKMpNR+mVpS9bcNdCXh/WfZpNStL8ZyXW3fQwqG+WjmXscD9ufB8RO0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6JeQF/zgYzy+LZ66lGPg/L70soj/VGoSn45R2gcfb0=;
 b=OhsNpGnvFgp2S9a8FZg2lUXCvTI2e1+jAtOFUiCj6OUSiKjsOkM/+UdnfVNNMzsUTBz7gG99i8eT/AZWfAIbQ3iRScI6YnogGZ678urCRImqH15InRRhGl5/+OJU6YWcdaiUXh6Mf1Oh3BGhrMNbc6Eai9sdjqxegKdm0EUR024=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sun, 29 May
 2022 20:46:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.019; Sun, 29 May 2022
 20:46:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsv4.0/release-lockowner: Check for proper LOCKS_HELD
 response
Thread-Topic: [PATCH] nfsv4.0/release-lockowner: Check for proper LOCKS_HELD
 response
Thread-Index: AQHYc36bKQ8C/LTfSUqQ/NkGcVaxXa02UuWAgAAAfQA=
Date:   Sun, 29 May 2022 20:46:37 +0000
Message-ID: <C3E727CC-A2F7-413E-BF5E-14DF326AC8E4@oracle.com>
References: <165384405174.3290283.7508180988614656582.stgit@morisot.1015granger.net>
 <20220529204451.GB32262@fieldses.org>
In-Reply-To: <20220529204451.GB32262@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c145ee88-4d60-4813-3b03-08da41b45339
x-ms-traffictypediagnostic: SJ0PR10MB4494:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB44941FFEF29654334A492F8293DA9@SJ0PR10MB4494.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cT/PV76VJP5JZif0BmfcUW0Zo02Ax920lnfodRNJhyHV1AHW8M5F5I8+zBTH1a+D7UtomLOBnatsZh77vpT6YUwOYNaZmm1ZhFaxEN3xSKSnuLADaegxMFWBwrW0u34wYe0TUA1yNhmEqQGvgiDSPqjjJrgodLatGqTRxRSEI13/q2yOUiZG9EEV4yUiVjbYK7O3cwqI7UCyrZNT9khIjYO8k9+vgScf/VevO1uqD0xCzYmhZduNJ83rw+3lBWCZM4PSjP9ZgKIrWpEQaxyk94UuwFtlvhn/XdWfghwwri4A/CTRJTsEVMvY8sMEZ2quGaiURb9Ics3X2eKIZM3OFIWpPXVAR7syjxtMiyI4cxfzXubQ0rzAwh4TeAjFiTUEQ5z3YduOJQ3pXNttkP8e6MqLedFqZeqbHD6QXosZSctrXWAmGv7Fpo9/zDBYGRucYRpKuM9hDJfRoaZ2g4hGGXsznN1um4lxpWHU7agjNR1FZZECGzDoOMY7R4mL9bkngGn/yCfsqzRvF5u7+VJ/utBf4ZrGeuW8UwA1wY6jFZI5jDNzKznv9TJHDDHQhJwe6E4PLH3hqQLlEeJNR1FSbUS3J/ODZVCfXmqMGPXi0PDGI0bQIdHiBepUfbPXd3MiyUJNE+zAPUFQ9m+fzEAtjCys8wfKebl8ne0smc3TZ97YAPjANnNoX/4JVBpy8oo8DnIyJsOFaR1RK3USwEVrQYTXEpf4EZGIv771thyGSVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(186003)(86362001)(71200400001)(122000001)(91956017)(76116006)(64756008)(5660300002)(66556008)(4326008)(66946007)(66476007)(66446008)(558084003)(36756003)(83380400001)(8936002)(2616005)(8676002)(2906002)(33656002)(6916009)(316002)(6506007)(6512007)(26005)(53546011)(508600001)(6486002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GRthDtb2VIBwfxI+goIMyP0CM49pc1caEeE9zoaqTlNwDnusYBXwpJ1ok5r1?=
 =?us-ascii?Q?XKmTdiBPR1YKS2JnL+0iOZo0mSngQWkcamp051Z3Bp7O/SZtPb+vmA60oeGx?=
 =?us-ascii?Q?9zdqqKcJ3l3ecSrXAigBCllWDHEd+uu5ItgccLTsddfwQQ5VHxBurMdMjIxC?=
 =?us-ascii?Q?hnq9xWvdepjOpcv4izUV0zhGabKbZQg+t82+FPSePMn6cY3/FJfEKaasiQdS?=
 =?us-ascii?Q?+K6c9VNILnassjOjAesati0D5D75WGPOBUYyrbNlWQKXWEBx+ENCGrAo0vks?=
 =?us-ascii?Q?GNS+my2h8ph0hCmNQzfXM7sphGbyepSj2t8MmbqmUOz64Yj/nWx8kutVc7Nu?=
 =?us-ascii?Q?ynOipksFQbYBRnUX5HZLmSlznCrb3PuPGP18wOB060MpWcewb/GuEAtH/jke?=
 =?us-ascii?Q?a6NVlxYMYc6PYtF9f+PFRVYUNHSEDPlHl5k62JhNZPBVggG1F5SecF70ed7p?=
 =?us-ascii?Q?U4ej1+l5Yn2CfHmGf3G8NOV9NvMf/ih4ZW0x2/GfNI/Nd+DdhnJDksJ8II/+?=
 =?us-ascii?Q?DxcjjK91y8kZWy7UnI72P9vwI2HSKrFC/mhc7mjbaZLQcb/oVCfjD2qf2tJJ?=
 =?us-ascii?Q?9tL4SgeTdR6OZ1+ezCjzU3qgiVTyB6EYcmqLwFX3s2KnbWFD2wZbdJZf3U9p?=
 =?us-ascii?Q?0pI1x1ZpPho4VvaO9eJ8MBju7wqOnvycCLCojS72ED6CoENFkCgVw3uEKz8H?=
 =?us-ascii?Q?uUU89kvqtLltlOPZ1JL/GktKvVE1nQk8/FoumRIOCSYN6Eju3l8oVHevNsdy?=
 =?us-ascii?Q?NX430Mublpjc0DBYSggwekokYzynFhFFBIhEFZfymHMVChj3jcKCjadIO1M0?=
 =?us-ascii?Q?VF8TluRemTIP711kDqICGe+bwjmPiWnB4lOOwcYYfBIGNaeFTGABGpPlDB/L?=
 =?us-ascii?Q?pWJjiJ7fCRij3C4KqO4vwdWACSIPF7cxFD3dDD9y+X273ntSvtgRLL9Nh9r9?=
 =?us-ascii?Q?Bux6Be8yZl59UgIgBjK+JUlatEgOkzwbGirk3GCvheNTL0h9aiMP0w5KTjle?=
 =?us-ascii?Q?bbCwnKOhB62yBGZ2yKsPEobsNsncCxWQzm0SVO9sMqP94U3XY/c9m5r6+4da?=
 =?us-ascii?Q?lzHmrBcW2elaiVqOyMPIP6YqLD9BJTrB0Co9UYHDibxEWAPvgqjqcHGlVYgh?=
 =?us-ascii?Q?PuPDPTIJnCy75stBAVs/bDpZFena9eAN3pPLor14C1YQ2Ez+mFEIMRtnH0Eb?=
 =?us-ascii?Q?NXQnk/6XpUACVBAcGEPCuIH963P0JUqf/5U7HHGgGMnF144ChSnXjpbPtKz+?=
 =?us-ascii?Q?v8ShCaIXsFfQJVAMjtMUMu0tx1ZPePL1soLVxtI+U/IHfcI5LzGl1HZ5EqEj?=
 =?us-ascii?Q?1Uanf177ItcQl2IEgrbwFT1D7L2OMpgyGdkOA93kBbEL8pEJC76pGtnyvbyl?=
 =?us-ascii?Q?j7WU+0OcOFh4+uxiQuTIBRcLWXOxdv6ztOpmZUpHKHyzgFJ6dH8NVEM6TWxp?=
 =?us-ascii?Q?b5lzhRffFJYqLlmbbX/psWLLLyUiapsyFVTfYx4UlOTnrJAh0i8r8xJkop1j?=
 =?us-ascii?Q?MJesIVgyUngeveHZP5cO6EfFnMSJqUahC3+6vvBN+aC1pozvuH+KZ48IOTvj?=
 =?us-ascii?Q?aZjdFnxbDY2hSJE5F8LWVSpFUOFJkJQslsuW2mNy8eu+jKm51AkiLVrq32/g?=
 =?us-ascii?Q?hQdQPvscGAiaMR2JW7kpqOpI9STi0oXIe6pyi4gVuiGhBxDPgWm/lWg0Hz0o?=
 =?us-ascii?Q?rYxshiBDLWAtDx3TUrqarV7kKu9ch4w2cehpjiUgbmH8OvTdWkoJoflw9auM?=
 =?us-ascii?Q?MX0VpEuzqy7BSJE1E8QIVeWcXqYkofo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A613623E316354BAAE55E0C9724CEC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c145ee88-4d60-4813-3b03-08da41b45339
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2022 20:46:37.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukf0hr0oMEzaTjpO1WS7chFeAe62yOaqfCxuW8cOkWtUb5k2a8n6tCNi52G59UXaZJJUaBd2Yx0m2eAM+rTYVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_05:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=890 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205290120
X-Proofpoint-GUID: yHX5b__zXXRIohic77qf7EdtyXcSzV-7
X-Proofpoint-ORIG-GUID: yHX5b__zXXRIohic77qf7EdtyXcSzV-7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 29, 2022, at 4:44 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> Thanks, applied.
>=20
> (Though I'd prefer new tests go under nfs4.1/server41tests/ where
> possible.)

Even tests for NFSv4.0-only operations like RELEASE_LOCKOWNER?


--
Chuck Lever



