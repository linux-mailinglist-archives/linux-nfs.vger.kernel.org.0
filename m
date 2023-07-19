Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6197175A2EA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 01:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjGSXpO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 19:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGSXpN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 19:45:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E711B9
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 16:45:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFONZ9005148;
        Wed, 19 Jul 2023 23:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oF7PJjrBNYOQmW/1mX9Qb36NkvLvbvoGIBkBpzW74So=;
 b=OcDn5kj/xmRowCQ4llj37B3Klc78Wiex2Z6UTxuX/Eq9QkO/RpRNYc34UKPe2vsqSCky
 l2w+o8+QDeP32vQtMwd9pWE8vaIyVU1E7c8HPsLfgzwM92/WsAUlT2M4H4qSRNB2Rati
 fBQKoxSoPyH7r6Ruok0BTVYLzF6Hj3VKxzLIz09tru0NDK5Wtw55I9dqgA1C047BcSG9
 6srJYi+FlEVJTkQ2C92E4BF8/729HXGGnKzmHeuTKiKnOHIr9Pou0/GU6u20WMB9jM5b
 RtBeEEFwCENA49h1XbCT5+RiSpNfB86lTecLOKJBIcPB/GP9miio0SY8eCijof1BzN5t xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a8n9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:45:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMNRUe017456;
        Wed, 19 Jul 2023 23:45:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7nu99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 23:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRaWt4zhfo8cPAmIEUv8z+vvy5OmkuMgg3q7ymOnYvxnMJQHuZSoE4mBMkrjs34I9GHUCVaChBClpIP9QuuxbV0zgFnX74L1IWhC4fAh1xDdl1KS5jfqGd4U4P0L0HdkeLqMLcKwg2fo+fdoCCOMQUG+dTjdRDvFydw/SUe/EAJBF3IMyTxzieunWuTPb3AesPhSEq/6a4PFsFIBKqrtKrc4dDxnESuinBpKyKv2s819RcQ19+Gg9xzU8r6EbR6tdT7ENrV2YJQVYvfBjcdr7SjcQaU0RglplkJ4s1U/EtthtkamXhuXqa+P2eu054jJFEDK4mOPClVd8V1zik80gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF7PJjrBNYOQmW/1mX9Qb36NkvLvbvoGIBkBpzW74So=;
 b=DzSyTH3dg9DI3Nn1/ZhuGQpd7QipzhNl4X1sb83CC67PkC0Wu2xGw2v/t+ZEfuQ9zz6Lpy9W9BbAHjVmiZt3MRSO8cUlpFupwvosU/l049tLlOxHUn1YhyFlmUH6e8CIrcMZpr8yKDMvQNRBCR1Rc1MwlPKiTfKde1hXwbFf2EayIn9Wj9+9S102UqEUdzll8w1BX1qvPogNL4nf+tP3LtbFLessaeXHlUyulN4HgWJGR+zx0lBg214H9h/mJDFyFFyILIP7EA3RiRv1l6i3iQYlPttlJYfiH84Gz3lzHGj++Wr9QuOJVry55geePjwRelLQd3EZpnZ0inCrdUxLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF7PJjrBNYOQmW/1mX9Qb36NkvLvbvoGIBkBpzW74So=;
 b=ue2lO2vVlyhL1rn1Wf3PbWrCJEqaVyKyFJEkJC3KVEW/zOVEfPVBGSA+2xdfvGUqdNYUSk/4rffQyyQlvnd3vUiZMwk0VdW7Zp68u6ym/BhCnOFvy7llxHEPWX7M58sOz4Qe5Eo+IIENZ3Y94VvCHANJxrB9OHsNG3ersp9tArM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6676.namprd10.prod.outlook.com (2603:10b6:510:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 23:44:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.025; Wed, 19 Jul 2023
 23:44:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Topic: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Index: AQHZuUKpaE3Yn0PdG0Ko1CF5yZZwz6+/jVSAgAC9awCAAMgaAIAAqcoAgAAG4AA=
Date:   Wed, 19 Jul 2023 23:44:59 +0000
Message-ID: <E93923C4-080B-4B43-9A3B-28A233BF5DFC@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228866.11075.18415964365983945832.stgit@noble.brown>
 <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>
 <168972938409.11078.8409356274248659649@noble.neil.brown.name>
 <9EEE82A6-6D25-4939-A4F5-BAC8E9986FF3@oracle.com>
 <168980881867.11078.6059884952065090216@noble.neil.brown.name>
In-Reply-To: <168980881867.11078.6059884952065090216@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6676:EE_
x-ms-office365-filtering-correlation-id: 31704d54-7fb6-4586-4d10-08db88b22a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4uSJJaJpaawoLUm7ULZYLYIeLnbUcbnQavfRF5r034HNBzsPjmGMfy+Mj8UpsN5z649wpuVevG5CNHoZg3QpPnEvSndRmY1l4cbkOJhW3jVw+jZhi2NgkdZGW/4dCUmAPgSDAvxlPwmKV+59Fu7AY4evd7AdZ49iXUxkbfGCTr6K7d8nnSCKxXujRh/VB9dhsBlzgCIL9j+N5lnQV5bsxRVpo5xHhFkWJMIfeYqEiUTWQy74NuO2wIuKyIVAE+izQi8UMdlPUCygGepd9bRjksuMd6m6iEK2PyVAuh0PyrP+y684fSaGFfw2+sLWzKUBPUPd+52/0UtGe2EBcgViN1UtSqSIHuNNc0iCASaIF/O3Ctr4efPO2CqKgl7vjYDHfRTMkyE0zYPumOrdDx+NmYM2Vi84S0Dt34R8FQiHpOdAxK5SZDEPwg8fI6x7Yi6fP0qnYzxuxlC4E5UDVQEnrsEu/JIPK5Hgma1bS46ZY1Ssmn/cb3Qfwanzjxh04J/JAeCn7Bwe5BM4+gUcGfJQ/+gI67qD1EqwY5L8ebO1HMZD/VVRpQpc93zttUTEB5csQXLE7Anf5lCVBfqGV1j9RcG2YFbtSV0yts/GYd/88uGy42nVB1GhZhT7ifoRZJupUa0VTB/Zxui/P1kNQzxRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(54906003)(122000001)(91956017)(71200400001)(6486002)(478600001)(33656002)(38070700005)(36756003)(8676002)(5660300002)(8936002)(2906002)(86362001)(6916009)(4326008)(66556008)(38100700002)(64756008)(76116006)(66946007)(66446008)(66476007)(53546011)(41300700001)(2616005)(6506007)(316002)(26005)(186003)(83380400001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rPhzUE5+aZg/QzWH0BGFtDQhiW4fU16QwOnksvvRVcvsB7SLc3Gl/sy+3wD0?=
 =?us-ascii?Q?A5CIjxo+2XrfTyMrfjxAxD8eEyTWF6GXv5DLn309aH9w1nZ2BSQH6QmaTd8z?=
 =?us-ascii?Q?z1FO0ubq3Z5uZ0+0vrBl1EpIy1pYhLY9SlCWo2to+MCo45G+BZ6ClR3fm8b2?=
 =?us-ascii?Q?xKtuFpT3w+gpeHRMDJtA7kJkbawsIp7UfbN6rPxzKvCMv9I65Awj2gqRQl8C?=
 =?us-ascii?Q?Re7+6dDY9tDk8Yg7toNXRPfbXRsDCEQUjioQR9jjLI9o3neZu4gBpr4ZlSqc?=
 =?us-ascii?Q?FHriJ9NXr4hrWT9xX4aDICLNJ4quLxjp/3Gk90bhaQ9e2I2/nqD3EmrfF8IU?=
 =?us-ascii?Q?kfMdSzwOYk0Ry1CNc79dArtbqj21nNbT55uqTTiFzo9QxHbLFsyIg0b4ZvkP?=
 =?us-ascii?Q?6NLhznA6IS9h0uymaPhFJSInHd9VWyTgVcnkbdfHs87zvuRT1FLEOHSOpvHV?=
 =?us-ascii?Q?qDl03yut5xrtuZJyFKaK7w7v7SoMqlXa3LCtic5ku2Iz8SIhQoNuwxJGaq0S?=
 =?us-ascii?Q?vLaocMcYqS2LH015WMZbO6bMj8zTiXhV/spuangJdL4/GnrCtbcudSIAVae8?=
 =?us-ascii?Q?34EvJw4dxtoZ5BwEXrdIiakl/niSlUDF7YrghFF5rZhCPdAcZSf+BpL26PlY?=
 =?us-ascii?Q?X8fgmotLqDq27kJVbXJZRzyJJwILGIY6tOux9n6mdAhjCeDpI5OhnLsldgHV?=
 =?us-ascii?Q?cXte/HLOfCpc4oUPVXdQo7qsSrwn2TV55dmQrt//SBWT6vHJg3cfEvIALJAa?=
 =?us-ascii?Q?GNce+GStEhRTO3eO3D/KkSh7XWEz9ODlJpK0PvQXAgRLTlagCpyVYEFPKRfT?=
 =?us-ascii?Q?Ya4cBnG8DMijW7Px6cgf/8fo1hWkNhc7WkgnqcQq6AM91ws9YFz8P/6yYkov?=
 =?us-ascii?Q?RiP+ApAbehqKHCftjNvGq2O2Uha/iiN7GpUrdLa3zRxfHpWT/BJYd1saBS/F?=
 =?us-ascii?Q?D0WQJg7fAUj9bHFh6RpLiGSEuqBIQlILDvIhR7JtTQ4JJYoywE05+SLPtlQS?=
 =?us-ascii?Q?DPxYM8WyL+HoFi4U7bO9Qh98AWyhLO+Wdm4cdRKkBFgKxa4Jsjdk5oETM0+7?=
 =?us-ascii?Q?FtqGjYpW1PSrlNRI3OgGbnh9uSxAw6fDl3PA8ebDhiX4r7VQ+w4xtogRbr3m?=
 =?us-ascii?Q?jeTkLcpypOUTZ4Gvm/2bMlSVF9nP750lUHk3tocQkSTUyExUl7C43quOeByr?=
 =?us-ascii?Q?h1BFH1rzwuwL0P5bRPG3BEjusnQWHlQoSn6tsRJJvaCQjWe/y6xgm3lt45nu?=
 =?us-ascii?Q?W97SNaUVWnxeONHaxgOBwrYuRXLGNIJ5NHTrwWT6CkDjQbcCvVE3jEIEVYWi?=
 =?us-ascii?Q?q0lDjRruHM2tfxTot8dNVh1tMhdOxzDKR0tiG6Z6rjuawqy3MtKlollud9OV?=
 =?us-ascii?Q?MPWniMvUguW3YPXfr6dRy+GdzneiQ8ZmVdcqPhu+0Fb9Q6MFbcx4Zjj0Zgy5?=
 =?us-ascii?Q?YEcOrh0x0n4X5Jmp6It8msfYjqST4sZ2JG1B7AYvwo5TQVbVB4rvswsgzW9j?=
 =?us-ascii?Q?efovIfw0ZcYmGPa7cQG8nqUh9n901vMTwrsFirEstskiPIlEFXVdOF0PWDis?=
 =?us-ascii?Q?r41RLEBADjmnLDKe3LdIp3w0F88FFY4QPJJb5Rb5frT6/un1JE1pleU4Vqlo?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <760C3D56A9E43E409ECE4CA86F6EC67C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NAzp+6XQRpCMvT+8D8MkS9rm3a40CWhhGi5l13utGHsxicIZ0JVaFFt5tiackY79lqMJkEyhR9xCLGh87O8usCfPjdQiizYzP61xXOa8e5LxgmAodRUtYxbazHsQ4VdJ7ESe+Orozzb/XDPl61VVw+qJLsHpQi3tIwf0FI8i/WM/TTp26iGPQJKvV//csZev6xI19eETQogMawjUTQ9VQJ5hS3/y+8N9uJqQW3XH+q5g1hIe9me9bsAwu1hE+/2cDDxUA1GIc5rSsaQw7Zt20MpWyLmVA3/TYTypX4+IY9FcFqXJW7Fcucd6DW+jULjG5hXcwQQEh0PWvs7bJ03D/9nB6vl/+Szd9qXr84jAH9EXOLIJn74+XQwZjY9K+W92Fzhm/K09ryoa9GhLhdYzwMaBCLWtRzhgzWX47hiTiT9GRbcJrBo5vvkB/mlCi/nUDz1aTh7xwXwNP7nzLKfL4Q0ruX93n3kwDkZ+T+b+s2rG7mmdhl2DoFqCB5VlhH6shEl0+adFqooTXbKqjO5kPA+SYSyasnj4kwpm+u/mlgIbrOVZknkdyn/vscOKC9bZ7HgwPd3st1wcZOlsahu5KAitSllPAdGv7yZ6Qhi6nIE9M3YVp/ir8mwa2kQBwmqJQSajroAIeHntJ7y+WzLGMSbgd15TCSOV/YlUY4F61LxIXp0+f8a7poo+BaJTdO2fKS4GR/URt9OVTjkfH+RXtLPUf7slI7waDldRHBjzSq2XJ6zv5VyRg90o0GtthJusrYxS9M/DCmzsGijliMW5haQziQEmVqZJWnYS+pSw/9fWh9NffAuh43xsbIxX2iax
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31704d54-7fb6-4586-4d10-08db88b22a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 23:44:59.4355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3lVQI9shCWDpBVERCPb2u+OYCbDIPXfYCZh5aep06FgakZELgXKrQWKKEN5UTl44YruDcvKCRGRqprmxQi+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190214
X-Proofpoint-ORIG-GUID: CYfIXo7_IuAU1Nk9GUFVSOyWXYsoaUs6
X-Proofpoint-GUID: CYfIXo7_IuAU1Nk9GUFVSOyWXYsoaUs6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 19, 2023, at 7:20 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 19 Jul 2023, Chuck Lever III wrote:
>>=20
>>> On Jul 18, 2023, at 9:16 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Tue, 18 Jul 2023, Chuck Lever wrote:
>>>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
>>>>> No callers of svc_pool_wake_idle_thread() care which thread was woken=
 -
>>>>> except one that wants to trace the wakeup.  For now we drop that
>>>>> tracepoint.
>>>>=20
>>>> That's an important tracepoint, IMO.
>>>>=20
>>>> It might be better to have svc_pool_wake_idle_thread() return void
>>>> right from it's introduction, and move the tracepoint into that
>>>> function. I can do that and respin if you agree.
>>>=20
>>> Mostly I agree.
>>>=20
>>> It isn't clear to me how you would handle trace_svc_xprt_enqueue(),
>>> as there would be no code that can see both the trigger xprt, and the
>>> woken rqst.
>>>=20
>>> I also wonder if having the trace point when the wake-up is requested
>>> makes any sense, as there is no guarantee that thread with handle that
>>> xprt.
>>>=20
>>> Maybe the trace point should report when the xprt is dequeued.  i.e.
>>> maybe trace_svc_pool_awoken() should report the pid, and we could have
>>> trace_svc_xprt_enqueue() only report the xprt, not the rqst.
>>=20
>> I'll come up with something that rearranges the tracepoints so that
>> svc_pool_wake_idle_thread() can return void.
>=20
> My current draft code has svc_pool_wake_idle_thread() returning bool -
> if it found something to wake up - purely for logging.

This is also where I have ended up. I'll post an update probably tomorrow
my time. Too much other stuff going on to finish it today.


> I think it is worth logging whether an event triggered a wake up or not,
> and which event did that.

Agreed. I have some experimental code that records _RET_IP_ of the caller
of svc_xprt_enqueue(), but again it's questionable whether that is of
long term value.


> I'm less you that the pid is relevant.  But
> as you say - this will probably become clearer as the code settles down.
>=20
> Thanks,
> NeilBrown
>=20
>=20
>>=20
>> svc_pool_wake_idle_thread() can save the waker's PID in svc_rqst
>> somewhere, for example. The dequeue tracepoint can then report that
>> (if it's still interesting when we're all done with this work).
>>=20
>>=20
>> --
>> Chuck Lever


--
Chuck Lever


