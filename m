Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB796551FB5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiFTPFY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbiFTPE4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:04:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BE63D5
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 07:40:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KDDu1D023008;
        Mon, 20 Jun 2022 14:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=59hUfGlT9umltBpJElzTP0SuwXt2wKm4o+nxE6Xf+Bo=;
 b=DoM+AP5f1b6MCbKmjr1ONQKpxgS463ztjXq1HdgDaL+QejLNnqaS2f3whkcHpKphbYMu
 j4XscwyThT50+vzE1IxAA76Q0NzQZOHxXMQNKt7yU8aFcPfyVOfpeqvNIX6dRfwk4orD
 DoH5pQSKtla/Sh1M4XXZfWC58zOFYn257zmUBkvqfA9gfrrJwLXWPnPBLsPTo+KFvevx
 /oXXafaX99y2TTU9iO5XE9Ze9PDgEQGD/KaYVsIZ/9Sp9j6gWNBlyt6lQAdJUAHH4R95
 buK/nuZH3OA/pkISlHOLGLBm8rtuifwnhW8XlcqwCZcB9mzpkXrCDSjXDLGsVGu9aKWJ yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0bf85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 14:40:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25KEaX5O010885;
        Mon, 20 Jun 2022 14:40:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5bhfpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 14:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRqWbnCR3ltYpeoOeNAeUpxpg2EoQw4uRfl/IWGrIaXG/3WIGMsGz4FdxuUTBjDC5HJa3yKTJKHUSrUcPrkB00DBP8YGZwcDkCGTNblGxUDuDwlPkq/m+Q0e1qE41GRrU1PVPTovT31ltJRsKN7CzR4HGXXCQQmO5eZQ+mWn6EMeKMtX7OYqk9ZbrH1ipE4F+24cgpjsVtRa9s5kkn2ZZO3IJ0wIJyLwj2jXHHD6nsLLkl25edYB9w2QjVgpMoi4c+JwxX+4Zyt7vaVZVKdFGaBSKb+haDL/z0TxWWFTJxyX+bgQQvoCjbfOeRUpaJxJQq2968nOikBDg627pPsktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59hUfGlT9umltBpJElzTP0SuwXt2wKm4o+nxE6Xf+Bo=;
 b=HiZ0tOt4Dn0qf1el6vFWhyffKdhQl+WdffKi9SUcxyg28K6i0qtM1qpd1hyH5EqmiXaf4buEdLXMJGbiQzIBvHQPc49lUaTGqu5afp+Lr27faXyfVgyEfY4Iy69J8jZaoJyISlU2dbMxeVP4cSpLvF62bE/TLSLzFuWkXtZEl2NZQEmfc+lavfDdCuhxzeEAY5oiu1fb9S5rcgVV3pY3fiFh7VsiM3dSpv7KT9SP17dnj8pmcTbrIOiF9OZ0JxYlrU+BPrbPbayLOXL0mPBTKf69Ewx0UsmXNnLWADk0xznEJ0bJpZdkjD409bnzkoj6U8EXXwKWP6x8IZ9WggfSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59hUfGlT9umltBpJElzTP0SuwXt2wKm4o+nxE6Xf+Bo=;
 b=NCthrQ9+sRS4lqkaQTy++kTSk5yn2eQJZBsxGfsgUe5jhGofC621VC0R1wUEii7kwM7cHy44Hs+Q0lYLBiLs5WysrSDNX+dejgEQmiv7JwHpvmJi04Wl9OoSn6jyFbRBw8pm6KPqfwaBj1YaPYH3fEbXjnvUy6VRdwmASI4NpL4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 14:40:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 14:40:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4AgAAMfoCAAERPAIAAApwAgAEchwCAAAwEAIAK/HiAgAroagCAABmggIAAGOOAgAYzNACAAAZIgIA1BkCAgABriwCAAAT2gIAAAviA
Date:   Mon, 20 Jun 2022 14:40:01 +0000
Message-ID: <916910EC-4F57-4071-8A4E-FC21ED76839A@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
 <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
 <DA2DB426-6658-43CC-B331-C66B79BE8395@oracle.com>
 <1fa761b5-8083-793c-1249-d84c6ee21872@leemhuis.info>
 <C305FE22-345C-4D88-A03B-D01E326467C8@oracle.com>
 <540c0a10-e2eb-57e9-9a71-22cf64babd8e@leemhuis.info>
In-Reply-To: <540c0a10-e2eb-57e9-9a71-22cf64babd8e@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c29cfde-330e-44bb-2ed5-08da52cac217
x-ms-traffictypediagnostic: SJ0PR10MB4624:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB4624127F46429E0284E29CB893B09@SJ0PR10MB4624.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FALixYrzBtKElCUWj93TB+yj7bASOc/7rtY59Rw6VjKpSMHE//x5Oi13SO1rURCr4zRZem8Vx38c2JvSccyiIUXjjvC22H3kxmr2cqr12MSGjQlcyQQQlnGJGSTj0qbWPyAonEzY1xU0tpMTP4t261oDgaceadDkyDV8NNpsW2C8oFeQyb0A6lsiN9BojpHA5peKeH53aWpirUJsi1UIFsEXnOd7Jj/M4bMVyULpOItHXvo/tijaMakjf16ZhHO05E6kto4TXJmuPhl43RDEU4aIHSLDB7MKGYulrstH8EJqUf3qVrUSPR51Sw0iDS67DePVVcQ9vfgJXoCOOzCNnBOy2VqYrqZhZ61X7sZPpglaUCV3J9UEQXv0wr7dtPqEbidHPdrJuDhOEhd5y/GLYNtDLRm1v7/Y4+PS6/tY/A0H/8dIyArReQywfpoextPOIqazPuzrf4y0UkFpdu20R3WqG3F9t8qh+LDCgSxmxzUpZHfQsYJ+v/zYhR5Ei//DmiW8Dwj4wkscWbfmf9B7VYUEztbncYyuYjA/YUKWYch4kNkqX49B8h63VHp4xZVrVaGha77r27u5PVf3UXz486rDrM/AFScCUvatIylu+1+hGs6ov5HAtoqbgXj/FlMu9BVJHRTeTcKZRTXVoDDrOtF9udxFzsQDr1EI5Z9MKRlMUgI7x6Ol5aBdjRcYcu6UCPmyR7mRLA+kpRDb981zBKKhjYYj5Tj7rdNzX+k6dryQ6CXCPcYVydCUKtRQwoX6PZ8nhAFdngNdMLZ5RUjGwz7Ifw5bwf6XXGHCMsVKyTCi7YlOyjAhv0ys30/XKseykrWmSpVQfPyKqh0PfFPI2/ALjerbi21a2enU5MNrvYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(396003)(39860400002)(64756008)(4326008)(8676002)(66446008)(71200400001)(478600001)(41300700001)(186003)(66476007)(66556008)(6486002)(54906003)(38070700005)(122000001)(76116006)(316002)(6916009)(91956017)(966005)(66946007)(83380400001)(6506007)(38100700002)(26005)(6512007)(2616005)(53546011)(5660300002)(36756003)(33656002)(8936002)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BnC5zHH854P2NB3EfW6EYLgP6gJcs/euXUnxgfBlAdfXFhNxiHU41Zd4J/lu?=
 =?us-ascii?Q?NWCceA2Q6kSCYQl+fcF8Jznyvg1S+/V2iLg49+wWJ+WADLrjTKJynd3VFGN4?=
 =?us-ascii?Q?uZuoxz+VIbLDAQ2y39JGowbWZv/2S93atJsTElNkdR/X8hQFvKc3i9CHc5T9?=
 =?us-ascii?Q?NjwpEs+d7BB6al+uCFfrrIQkmta+yYzUGAv3XK7mmeU0d0CSzxl9gT0gILkc?=
 =?us-ascii?Q?C860NDjvlZnIIWkOPjpjHKzKzr9YdnSnOYpi9Z0RnaOE8sdEprfn0L4vbZK9?=
 =?us-ascii?Q?EpY4SvXnM51pAX7PV8RDMSGoSB8bXspk3bsi5KIQhL5xD5VI+12ivAKeqdMG?=
 =?us-ascii?Q?XLQHMrgGmAVVh3d2gzpAIXUmdNsjVep6Ks9J+ET8eW7BgzlBePOudbGCDsGP?=
 =?us-ascii?Q?jg1fFlIghd9HVI8cjcXETecG0GEGb5wGK33ENtuirjvrS3yWTStROJBBFLBd?=
 =?us-ascii?Q?8A2SxJkKvZWyy8pShbjFUh5rI4L/lErnzidoISLsi4W0h8sqofmcKc6WrnuQ?=
 =?us-ascii?Q?B/ee2ssW72OESk3Ag+3QI00nN28yziyb5TsyYRG8vcIrxxHzKU55TWGQL7gi?=
 =?us-ascii?Q?+jiQClJBZ7VwJs+RK5NxTuzx3sWlifH/5EpNeACZLryqvZOBWm06DnIpiFYe?=
 =?us-ascii?Q?uAcxYl1Q/oFT8BGEPA9eRXJZeX+UUldYDt4OdfsGXlNwgXcohF4g1EJFV65L?=
 =?us-ascii?Q?WQrTcrRxVyfVwZHCxFoiv0DAeBguROLPU6crW4t8qEeSl9ij81JXlE4zStMo?=
 =?us-ascii?Q?+d6MjPLA5vVYYsG+4MuaBzXgBFqYP1ZeqU3cu4NkBNMh43y9n7CfpDeESIS5?=
 =?us-ascii?Q?d3euULTI5g7BXBHeiHFRnLbGBG+98LG71m85yPkcde3dDOD1QiPYYrnLtgSP?=
 =?us-ascii?Q?ZtedFAKLNKERJCgGkeGu6QJ87ei4dMYr4/57Ct26fwPMwL6LwJze4/lFQzr7?=
 =?us-ascii?Q?W6QV/jEcGBe+Z9NSXSuz4IkVnsGIaVGoAulh/oxKSq41IdpHG1ZjSd7TW06u?=
 =?us-ascii?Q?tzWyERmOG6xdcQAytx11aWXhlYV7/1HJeYdZIa3Swc7BGauXS+tNVsy862tM?=
 =?us-ascii?Q?LfNDGqVkeC2GehV3tGbOjG9RIrE+iF6QIWt5qHx9wHWe1HO+ZYSTcR5kFcWO?=
 =?us-ascii?Q?yfo/Tst/JjMNwnVGTVKF/ZNckEqB8dw96PukKni4IKrMbiFe6X5gRK8yAteD?=
 =?us-ascii?Q?ViA93gTmptsY8n/LgdWnW8NRHsb2jG7mrv8d9Hq8siEVyHE0hzaYcwaWuOwo?=
 =?us-ascii?Q?4HHw9RgJzxHVNpD5DHu6u1r90IzHGYTVLtmh4UiGRNIS0X2OPRTg4E+e1MRP?=
 =?us-ascii?Q?/TfW1JMkTeoUa3e0xBQPImeV50qUROd2ThpNYzyaQCKqcyp4obcC4MaolTbN?=
 =?us-ascii?Q?0XkUaOs+OY0cm6CiGdgNaEORb0Nx+6RAOJ8tgzNfI4ZSwOr14Mi01HaOtcV/?=
 =?us-ascii?Q?xZXj98DEUp/uIkp4Xg52enI7x8tXpEug5dD36ny1OncPquppGqGnjily3q8Y?=
 =?us-ascii?Q?NGTkWuJxfNaMRW59o9Ax6K3aL2fmdPWGVAqhOStbSpaUyYGiBERpFOAH2cNC?=
 =?us-ascii?Q?DWLH1Qr2mjqGDHB278mt/LLyc8/M20WMdkBYxGRAIhXkOKz4fOBRLYjG9sJR?=
 =?us-ascii?Q?26F28HNY0prru0oMRk6DctN/UFAnZJuyLq9LHgPLTZHm+tVIsbdAHVjKYv9+?=
 =?us-ascii?Q?doOZz9RBqrP6CGRMau46SbuV+KbwpHmbjuTjw7qi1daOYlOgTCiCCAlUcwDO?=
 =?us-ascii?Q?yJCn7T5MQ/cd15TfzlFhk1ZugMS2Qio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3B2328A9C22484584001C052E9D3148@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c29cfde-330e-44bb-2ed5-08da52cac217
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:40:01.9048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rsysx/bJP5+8y/KUmfmhWGs+8hMKSuvkmGCBcYUTwo238lcxQ3F/g8KUSKGhMO08kHN7Im230caNo8QR5vsTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=954 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200068
X-Proofpoint-ORIG-GUID: SCs7gX0ozDkh0f4O_TDgKQysvcJ0wkVu
X-Proofpoint-GUID: SCs7gX0ozDkh0f4O_TDgKQysvcJ0wkVu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Thorsten-

> On Jun 20, 2022, at 10:29 AM, Thorsten Leemhuis <regressions@leemhuis.inf=
o> wrote:
>=20
> On 20.06.22 16:11, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jun 20, 2022, at 3:46 AM, Thorsten Leemhuis <regressions@leemhuis.in=
fo> wrote:
>>>=20
>>> Dennis, Chuck, I have below issue on the list of tracked regressions.
>>> What's the status? Has any progress been made? Or is this not really a
>>> regression and can be ignored?
>>>=20
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
>>>=20
>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
>>> reports and sometimes miss something important when writing mails like
>>> this. If that's the case here, don't hesitate to tell me in a public
>>> reply, it's in everyone's interest to set the public record straight.
>>>=20
>>> #regzbot poke
>>> ##regzbot unlink: https://bugzilla.kernel.org/show_bug.cgi?id=3D215890
>>=20
>> The above link points to an Apple trackpad bug.
>=20
> Yeah, I know, sorry, should have mentioned: either I or my bot did
> something stupid and associated that report with this regression, that's
> why I deassociated it with the "unlink" command.

Is there an open bugzilla for the original regression?


>> The bug described all the way at the bottom was the origin problem
>> report. I believe this is an NFS client issue. We are waiting for
>> a response from the NFS client maintainers to help Dennis track
>> this down.
>=20
> Many thx for the status update. Can anything be done to speed things up?
> This is taken quite a long time already -- way longer that outlined in
> "Prioritize work on fixing regressions" here:
> https://docs.kernel.org/process/handling-regressions.html

ENOTMYMONKEYS ;-)

I was involved to help with the ^C issue that happened while
Dennis was troubleshooting. It's not related to the original
regression, which needs to be pursued by the NFS client
maintainers.

The correct people to poke are Trond, Olga (both cc'd) and
Anna Schumaker.


--
Chuck Lever



