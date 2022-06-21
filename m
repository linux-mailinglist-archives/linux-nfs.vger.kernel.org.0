Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B2355393A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiFURyS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352691AbiFURyP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 13:54:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652331C93E
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 10:54:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LFkd9u011598;
        Tue, 21 Jun 2022 17:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ebltzKo8SxJrwHcCZYJGBoBepRTxD7C1OPUpWUdr4XU=;
 b=S+/cwjQ9n+EL7bQ0BEC57F7a3oedybkhWdYbaQzn2m/lqYjBO20iogW/RgotvsLTil0B
 Jw4lZqwZSp83xKAlXYI+J3fdB3VljOR0ZtkxwvyjnSUdtiVPJJO3peCk6J2v/3AByYjc
 xVdiNE1g9CBL4Exlz3CaZVW0bdQqpV9VdWx1KUzMHsqUYilXQgvO7J5w9zpVORP8YN4D
 c7TzmHKgNTtA2GHasVXbf/RbMXu+VnGA4fktmoxSZUkM/9aJfqNEmJ0XU+9bK+Oqu5AU
 AgSHyTo+AsCW4FjxyqetZxCoKk2l462X/+OCmxrsfNlY2xj07whPOlRjU0hj/xxCnhh/ Bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0ea1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 17:53:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LHdvJV010749;
        Tue, 21 Jun 2022 17:53:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfur7e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 17:53:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5O5EtF/TS/YLVAGhsvTzlEH3Aoha52Exv6D9QHMinKz3jDTCkLbuV2Hc4IOW8YbLyNP0mrw1fcjZCIwApUBaRdPsb6U/fMDK/Ta61jbYU3SSBPPjStORvtXaVCqFne10anzmaVMvxxhZiYZI0Cn9CsEyUS9VsegKyGmXRTHQ6Nl80ztnKnbj9fBrhYu/Xe3MVdp8kumuycMDRxpSnlzHowcmf6B/uW7g90RQw+hlhG+waWL0UtK44nktzjPhEKXkQ4myB0Q4L8PujZpVWU/nHg0L937Ol5sbkYN9S77AY6Z8eUuT1+sBzbHt7dFdwqVhOcCfiulABB+Tne69X7uQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebltzKo8SxJrwHcCZYJGBoBepRTxD7C1OPUpWUdr4XU=;
 b=Hw7IHvcYUNhBiTZZMjo9IO7BK7kJfV6r2Jhyw40Z3l0D6B1FrDJv24kDRlXWGwz533R++jFGSdzLuQTuMdWlUgKGTufTJfBGL+c6plaqG/f+A25kT3luBfCjYflu49ygT27W3LaYV2Vzyoku/RRZgDl8uN4VAuH50cPjEiEspQmVavdGa/2GgLihRDjY2P40UX7zUEALFngra/Y9zk4P0UGHjYuLyy1zbz+YizYzVmKJgVKcXLtniN5OZts0oKR5cTSJNxiOAl99KFag0ZWEmfwsAuSddSnZlbi4So+G7DlqBcQZhYqSb4RsJFvg0bHZ7UuoCZl0G+I0uky/opmGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebltzKo8SxJrwHcCZYJGBoBepRTxD7C1OPUpWUdr4XU=;
 b=qudsf+S9lj0vFvZYQEROFUyk3iatuZ8hcDSLt4UMmmxTRBRG+mmwid47ed84uw+DRYah9wMxNiar/M+vJsnmthrH/8gE8GxQDP/19koXcEKQ8jR/4Ckzu1RqIP1nva37gQnROqjuPPoItHH5vDsoNxiGyVUeqEJblwwK5vLtTDE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4892.namprd10.prod.outlook.com (2603:10b6:610:dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 17:53:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 17:53:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4AgAAMfoCAAERPAIAAApwAgAEchwCAAAwEAIAK/HiAgAroagCAABmggIAAGOOAgAYzNACAAAZIgIA1BkCAgABriwCAAAT2gIAAAviAgAAo14CAAYEiAIAADv6AgAAO5QCAAACiAA==
Date:   Tue, 21 Jun 2022 17:53:52 +0000
Message-ID: <BD468D48-4E07-4E03-BC25-A89191428A5E@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
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
 <916910EC-4F57-4071-8A4E-FC21ED76839A@oracle.com>
 <0faa0fce-52ef-de28-7594-6e93bb47fec6@cornelisnetworks.com>
 <CAN-5tyFWse4YP8dCGtQMDnqm5s+WsK8HqbitD2dAF5PayJMsEw@mail.gmail.com>
 <31af1a7f-51a7-87eb-aba1-ad933a845423@cornelisnetworks.com>
 <CAN-5tyFmpO1yaAUa-0=PGcKDsW58L5beaPCdLqdd4QjrLyUuPA@mail.gmail.com>
In-Reply-To: <CAN-5tyFmpO1yaAUa-0=PGcKDsW58L5beaPCdLqdd4QjrLyUuPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73b982eb-d938-4665-3d5c-08da53af0100
x-ms-traffictypediagnostic: CH0PR10MB4892:EE_
x-microsoft-antispam-prvs: <CH0PR10MB4892F10D96038D2E30F96D3B93B39@CH0PR10MB4892.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pOCuzCSjnQJhfRoj+hFS238e+7ocDnemg++PcJOH2hexERfeGXLlBkBqr+24DPv3C6iSMhkO05llyC29b43Zgtj5yAWwJDHl8Xho3slaS79RNfr62zulnvku72iAbWxptevQbrdKauHKlGDAaljMTgKgcndoqb7E1zUgLIT4kUZMBCRaQ8lnHDbRhqUseGo1eJPq8h+KpBnrTjnBfp3Uq908oA5KVQ8HUvWpd6IQcvKkUbZLsak7SG6l7IiTv9XBsav7ZIyVTZp0kJXdr2pwrDPK98oC6EtHDw8iwhdR9v5KHGDLstMYPJ8zfldwel2wXcFzBEEg65XzZj9wxXfUcFT4oUuTdSs+0/9KWE43nhGABy5yihmZf4O/6Q2BEL6B7tj2AhQIc4ZUcUprtZLIiyC84zVkzkMdjoYBU0Ancdi9/ySBpfnsp2C+JlEi+EbNVvOEeQXiKi2ivlUIFazVA2PJiPlmoxgoIfEH1Q4b93zRTgOWvUBNArnxY5DlXxtZGj5TV0G8EWtnOqdUcn8JXque0S0cLa+s6ysOreg4824hzGqVTH2FpjxIY2u7aMm7zKwbuvXVJ0vVYvl/P4Ze6xwDxF71mszZJzHdqYQeScSlaQzfvC+hrV7OfL0GnmNgbFP1auSDSH2fH4v1T4B1q3ACxiezuO/OQffdH5/0Pi9NH409MEOER69JBtIqAgkQMZKRLHnn9CU98xdIWw9j+MoAYbnk/Xnk3UavOAKnXIPRiH47UEKdslujNTmjwCBu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(396003)(39860400002)(376002)(54906003)(2906002)(4326008)(66556008)(66476007)(6916009)(91956017)(76116006)(86362001)(122000001)(66446008)(53546011)(36756003)(38100700002)(8676002)(316002)(8936002)(478600001)(71200400001)(186003)(66946007)(26005)(2616005)(4744005)(6486002)(5660300002)(6512007)(38070700005)(41300700001)(83380400001)(64756008)(33656002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+8IvtFFnDL9DDa8MnJ5H7IlYJ5lgA206OEBQYX6/SE9zv3t4HAkq7+JfT2XD?=
 =?us-ascii?Q?Q+34aozTtNvpPlsAFyF8u56riYURupU618lRADtirHIdemUhbS1Pi2eoJUQ3?=
 =?us-ascii?Q?njfIaq7EZudm+M9j2NSfvOA7eQifLpaNp0CTI09FFoLLuQKvKxy/XQKnOBuV?=
 =?us-ascii?Q?dItgTfOojckaXCgV1hXhQvYIymfls0bNIbF7+9v4t5596QX8a+ON3cmn0kal?=
 =?us-ascii?Q?+vHqXrtcyzE+csfo+WyLuMGhDCQlQmGGUytXtvMKFClHVKGSctakxCbo3OX+?=
 =?us-ascii?Q?TDs+RiTzL/F1s4xvs5yc2cqV+ks2p5unnsEm6d/fljqgACcQvkV8V/HCNbdq?=
 =?us-ascii?Q?xOheyXXj7bYRUiD7MpY23jOXMGAt5BfZW6/gbGgcal/BVFpbNIbxAS3lwP+4?=
 =?us-ascii?Q?YYbtUVrVbw5sujPXGybMTRrAp5CycP8IBsKwm7+Q2G9coGEvwlMpWjo4LDmk?=
 =?us-ascii?Q?w8Ax/gunMOe9DZBsdhtEG16iFKpPG72t6T2S5Ya2gMou/4wJjlAuseCRK7My?=
 =?us-ascii?Q?PcZ19TLfwXjM6ZZSO33W2SFezUQJN2/3K06QtIAmekhtPYWLlq0WYYt0MRdU?=
 =?us-ascii?Q?rZ9EpTa+aPlYY7Epvpp1OLROAvxJ95t7E6TpXC0ZAIoXqn0Z+qZFp9O5Bqxy?=
 =?us-ascii?Q?svR4haXehWlwyGARBAZ9kA4aP5gDfvuKBjpGxNVB4/AsxWnRngWuDtzp7yPu?=
 =?us-ascii?Q?xGuKyE54Xg4PeHcRf1uZgklVsGuC1ZdHX/d1wRv/WCNhOtLI2AEWztNIkUVw?=
 =?us-ascii?Q?3U6u9MJiLBqiLTd+5uavAknH+0QBnySeoz5ZJ093Z3GFLB2JX/5MXs/BPgJe?=
 =?us-ascii?Q?YqytpwcwCLlK+euIX2bmrDlV6CG/cOTAftmHPREMkfi/8KkrxdSkaFoIqrvc?=
 =?us-ascii?Q?H3yAoyrUmvPgoIZnyvcgLQMf8FaAcMsKbqMBgSGj2oah0GLt+YNMGeCA4/7O?=
 =?us-ascii?Q?v3cO69SO38zGtHZiPQKb/DRJVU0Pq5ICeMBmcaiqn0Z4LuA+P+M6JfT7ZU2a?=
 =?us-ascii?Q?SMlxRuHmUR39txyEwNpw4O+931xOTQBbnnN9YJ4MLO8ZFXFCtQVsM7R5YK52?=
 =?us-ascii?Q?lEpvrT/nXWXEbswWGXzY3uuz5xN8OzTbjl8b/BSPhc+J5xy7TNP1bC1//mBZ?=
 =?us-ascii?Q?CvM0JlIVVfY9jWm+VQF0gKrn5LraQQj+yUzc5rlbXifnT63K32mf4bZGxVef?=
 =?us-ascii?Q?fUAnuyiFtTgefFSCNCImovSPlRy+4T0t0bMkRfKDrNgv2UX2on79+Lcl/leO?=
 =?us-ascii?Q?tWwWbC313OwCglEOrebLZTxV2qSLTIan99+wclnCDo6Tw98e+C8pIRPSXpj+?=
 =?us-ascii?Q?zwNHJJouc9vTRgAnuePC5+B4Lynhi3Wdd9Wep0N+q9c7RjQREA5W6D/iqkLc?=
 =?us-ascii?Q?yhWUWOZkZAqoSBttsbsM/ziFgUj81wjHdDhJkHr3uY4TyCwOwT9zCbitoRLU?=
 =?us-ascii?Q?kMn6rfymViPMcMvNBTJEIE/hZ/XJA7QnTF1waoSBONr5taJHBL+B8NLj+UCF?=
 =?us-ascii?Q?rmlXu8nMYkqIuZeM2BxV7bhIQTbl6YOgkJ5Fd4aS7GN9rXWmL+denP4dQosF?=
 =?us-ascii?Q?L6vKzCt4e8W2nLAoJJR4NdBZsTD/htEY+J/UL2v6If9FA4SsRXyvfdLcsCME?=
 =?us-ascii?Q?FYzUfO2Eryltd/8JfEo8te/P7xvEIxZpS36/ZR6/n5Gal8aJoXOBG3wrWo3O?=
 =?us-ascii?Q?PELZuQfzUTaFDOEec6GQD0O7EybqP5aeFWOTQqZdxh08XnRX72dxbYIrTJim?=
 =?us-ascii?Q?YiGSXPTciMYUZEajeirNhCx55LOjLp4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC9F3A8E45C70641974DF375016715D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b982eb-d938-4665-3d5c-08da53af0100
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 17:53:52.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n06CW+v1K7Ikpj3ktnw0SttNBQMTiy8Ob2eENpGt/Bh0EuvTWE/B9RTPuajanoQXWtnhS0PkC5PTOsvs00hspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4892
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_08:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=871 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210073
X-Proofpoint-ORIG-GUID: AYIixNhAg3H0lrVtsB11uy84OMAnPobo
X-Proofpoint-GUID: AYIixNhAg3H0lrVtsB11uy84OMAnPobo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 21, 2022, at 1:51 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> For #2, I have personally ran into that stack trace while
> investigating a hung using soft iWarp as the rdma provider. It was an
> unpinned request but I think it was due to soft iWarp failure that
> cause it not to do a completion to rdma which led to the request never
> getting unpinned. Thus I would recommend looking into failures in your
> rdma provider for clues on that problem.

#2 is a separate problem entirely, and is a known bug. I plan to
add some fault injection so we can reproduce and track it down.
I think you should prune this issue and focus just on #1 for now.

--
Chuck Lever



