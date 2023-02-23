Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF66A0DC7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 17:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBWQVp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 11:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjBWQVo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 11:21:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D317CFC
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 08:21:43 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NAFW6u027952;
        Thu, 23 Feb 2023 16:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Nwv83YfcYLwHQt86vi4bf4iY5PjhbA6hc9e3gtkUuqs=;
 b=ejgWIR1hcX+VYI4l5PA6lMmW+CzlKQ4kfZaicNfmTnAIdwFqoDlykfpRJWJgM7AJCatK
 y2RDUBaSKn3WRafEFYl8CZ9PBlKOylFqumSn7o3fRROw9i93K2wSOn+sRtH3mOPfbKlE
 yWn9RTzG+mA5lhgzTEKP21VBGpp8yPCfFlIXkV78mD8UuYZydadnyP8TArfdOhP7gDUt
 UnIFkhSdeEyjcj3I7fic22WU9lXergngTsYpZYTW58xWM8icpYAazGRxFQjEmop9ufDy
 wEkvYRHphkYBlE0M6ruuWa2RWCLZkl97UJdq2GotzkWAuoVp70pN4kUq5a6rlmWNU/kr MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbtw2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 16:21:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NFAkLi017919;
        Thu, 23 Feb 2023 16:21:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn48gy9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 16:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqcNg2nImF/AIU+cGoNwJJhzNwafO8jsNlrK/AnKdGrEV+Du3wT6kRBk4C3vTH5mB2zh9w1IJ9FYA6KNB1SxN6EExnUdiXsJGB7NGyuQcGkyV2dDIUFTFT0+kDR7nEeP0y/OP56F3gmQha2HwrNk+9WZfqBSM1YxFEL9FmSGc+ESH9xCdXD5jAsQsWKYwv4jJMyxtrFYAbivcOHu+tuq+TD/xyf+jeNjVvTh413Aukv0zaYuF783TLMwzRsBThD2ENFDuygXXX5Vfl00I7QhroklgmRMTmbZWorHJ4a4f56pFSFMgeKEN9/n0y4KvljAf3DX4yvJW8XXDiFs+cXxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nwv83YfcYLwHQt86vi4bf4iY5PjhbA6hc9e3gtkUuqs=;
 b=S5XTeCfA9CaKWWY4qwzS5ptZ47T3IyMp2vbI5ECMC6KP/g3/20RwjzSeMHe17mi1XZxRzxEkElfTKY9kp2sM2hoWg1hLdgJh9UTNI2el+cwByTVh7qkQAAY6Zsgcuf3zJaL1sUjOcFmc82FHURr91gocLJN1eIMrVIb/+h0/V5E9OBviCHs5TPFXAU4VuAMISAfLuLUV+9vuCHnR+SPi2tU5xKi3k7TXNk/1GOMjncDh92O0C4dtJokhhJHk8p0Yb0Mv7bUJlOPh6jBVP6ML4qp0MJfLMjuUebyDAzfCBkhpr2vLB/zBX0LQ0MOc63+DLGnoAkkjccdBbRVuVGWUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwv83YfcYLwHQt86vi4bf4iY5PjhbA6hc9e3gtkUuqs=;
 b=OpZmQM5V2mRAZwTeXVhRIT/TZLQTwTtSjylMHuDLrK+AwKq3adHFu8ATWqqkGfnnQ4ucZ+XnIEsyrCJFRCby5ROVs1d9QrpHGo237Ywgd+E8kxrUBlHwvDOgZMXwowbOeUwOgCyOggpwqM5js7kTz4meW/giyY237AmCW3WJgWI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6385.namprd10.prod.outlook.com (2603:10b6:510:1c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Thu, 23 Feb
 2023 16:21:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 16:21:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Calum Mackay <calum.mackay@oracle.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
Thread-Topic: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
Thread-Index: AQHZRupqLrsW5tLEk0S66PU5K1PKOq7cpsCAgAARNQA=
Date:   Thu, 23 Feb 2023 16:21:34 +0000
Message-ID: <3B034712-F376-4D71-8A72-703B030140F9@oracle.com>
References: <20230222182043.155712-1-jlayton@kernel.org>
 <20230223151959.GC10456@fieldses.org>
In-Reply-To: <20230223151959.GC10456@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6385:EE_
x-ms-office365-filtering-correlation-id: 6eebc336-bc8e-4bb3-e726-08db15ba0826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MT182YuAfykVULDnhlMzvG8VDfSdI2ne4GzECOBWPUpYisNM8WErBPJPlc2yrjapX/nH4VXBU1Eu+xSK1pgTpzw4DeSms+ZvtdC4H/2Xn3wzFUtsWUsCqdhLwUkuD+Fk5PokUj+41yfLgoitgQgdCZPHrQbBy53tYq6T0Wf78UeZI5Szz+qi6l5tqQgdkTRM7tpai8xeWOn8/IL6EaNNkqe9L7tmOId9kd7i9uvs60l64MCSsoooiM9roA8IROEi349AWoFdbCrCJDIWMjLGzzX04tDY65FE2ttqpLzckGCrBi4QNAl0dz53NzCkfv6HHL1YGeCVCb+S98SD0vPohtJUQoSrgoJVQoMlpFdVqv8YQ9swRa8QfR8T7liccqUZjQNxYixY1qKlLeW+ax7AaX2p/OtbYQ5SnVliwmkAzQJnz+ZvqABOfjLGqP4p70Th+PE/LnYxUaYnj9aog+JN0nDaqTikmsTyeKraFkp9TrZJUZ4LeckEwMRWtDE93lGLPHq4XnnqsFg5FWyCosA9KC3QQeMNnNeXP0TRL7RUvO6OH3cwgpSyF3nKsFLcbXdzk1WuK/Gcwtycl4J3eS5+npu6v+/gqf/YgyoG3INsWRo+9MCPzHJMGdEfcpDwo4AiL/qrei9rR18VgY90djR3OZwAY0b1LaHUoCltFGnOnq95FUB04dQi+jHYyAqMkv1TAP78JW6YlxG0TUq82QgwbddBwF4a5J1j/jCEdGmkCEvNIiJqrQ3tB8j9EcpEiyDbP2Fi5lAIF7lbCwN6rpA9WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199018)(36756003)(83380400001)(2616005)(33656002)(122000001)(6506007)(186003)(38100700002)(38070700005)(5660300002)(8936002)(6512007)(71200400001)(41300700001)(2906002)(26005)(53546011)(6486002)(478600001)(66946007)(316002)(86362001)(54906003)(6916009)(91956017)(76116006)(66556008)(66476007)(4326008)(64756008)(8676002)(66446008)(403724002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IIUkpA42o2CLD/NNoO/jJ0lDzWTPZmJaTOAxgtk/dlDEIFI6e/nfbruTkYin?=
 =?us-ascii?Q?FecM4aZCJou+nPGT98bMyGeWKT2SDENJHuZ7gljrvUjCzJ6RG9rSn7PWZz9j?=
 =?us-ascii?Q?6XE0vC68zMGZOjgIPm1sTjeDzzThVjvRNYSoC5cLMaczE1WhvrpoRBri1hDW?=
 =?us-ascii?Q?LE4EoU7LdleJ+0J2yPDVVhE2a1Zh29p5i3yJppCUuAevpGm3OVJCDHv67rPm?=
 =?us-ascii?Q?3u1kdhJ5YJiXcdzLEEYx0bclmx4brdE/YQQjzQ+jBuyrK36HWWxWyaygf9sm?=
 =?us-ascii?Q?9TnL+w8axSp1Iq7O46n5XBBnDl8VYd6FD61578mV1cbP13gPYOP+QmGc8f5l?=
 =?us-ascii?Q?R9SCJw3tbRh9N7lf5JBQSxbIJDeRWmS29RUzsCTRTzSVwllL4l/d55rFpzFK?=
 =?us-ascii?Q?nfjwDO35M2KA2vjbsHYhWIy945R6uW9WpW4+wJx79kfxpaFtdMxU4thF5rPU?=
 =?us-ascii?Q?s8G3aqakHYgq2UroYQrb4wH5zaBNJHZMbAPSpenlcfUb3jjDuO5xXNSbMSry?=
 =?us-ascii?Q?965S+qkJz496RYsPLeGgMFOkTKkM9tE9dtWdEcnPDW2zJkT+tjsL/hpZR40I?=
 =?us-ascii?Q?wzq/xl0OjkgfjYRz9kMNFLULd3+DnYy7tikoKlvIU0oabS4cFI4vwli7+iIp?=
 =?us-ascii?Q?nrjqDgOouDaDN24YChcDV5uiANohEkL8saCuKxuP1LHOEtRs+n8IOvxolf9l?=
 =?us-ascii?Q?ln8XXFLuR4qQ87qBvunHKxz5TJn5dr4lybYHAEUuay63jMK0zRaJuka0ijPd?=
 =?us-ascii?Q?1768UaOhpdyxhHBYKf/fL0m2RD6YkL+5zyvb2Jpv+ZvQjMfLFN/t9ESPQUTq?=
 =?us-ascii?Q?tYxMJrI3uAZCyXaenPbRD3itxkIXj/Q3q5ii08e//aFBk7viWLOb99VhHdey?=
 =?us-ascii?Q?tuYBMBjU8kTLWLUwrThCMhRLSGT59Mjx0gN0hSBwL91lC4zGjI2kb6THL2NG?=
 =?us-ascii?Q?SFwSALvuEIeREi12bcN8haS5l8MQUQm7NrkaoLMyGEEcGa2REL+TAQWOs4CW?=
 =?us-ascii?Q?0Orc8FAPyneUyemzGnYsUTSVgJly50V8rX7TuwK6kp+u0ysdDVSLOmLWcnGa?=
 =?us-ascii?Q?aoZFFiRxAYbpsL7DFi8vDyBJ0oY/ckqMCHbgfilgsB/FGt0EKouDVPS0GIaZ?=
 =?us-ascii?Q?IobO24BnO825Iv476iJCsjxu2r4DhAgd+wjWsKdCF9YwuVVKwMoqoL9THUFN?=
 =?us-ascii?Q?3w4HNK0NwUSa5+JsX6uJoUJPZv2SllSVMA5lPsTSV0C4h3n+i3xpaICMU7SJ?=
 =?us-ascii?Q?4zLLm3m/shyHjsusNGhdpxOd2EOuVQtuX+rojchG7uEcpklEyxpMaqopn59n?=
 =?us-ascii?Q?buiXMWgRQmBzviEfmhJXH2SsdrO1UK71gutBT3xu7jucvCbTBFFszqPzVSzi?=
 =?us-ascii?Q?/AFDmGkz65XzHYoH8jDaJinA3OVLqcH2EyHh5PKqeaUgNrw+93jMRk7ucjeR?=
 =?us-ascii?Q?4yEAnjPLDpQHNA4udzdy777UxTDxUyfqVHdtKLQ4StS3ipRK/jxndII7MK98?=
 =?us-ascii?Q?NAKp6OtQlVUzvsFPvZuaFoFuP5OW0302/7OZa//Ao+gYX0x8sH4lXN5AQirF?=
 =?us-ascii?Q?rG7FRUg1PgAKfQFuksyXlG9sP2S4UtpUsbF+vyDcR/Wq8KrAeArZOgQZfjll?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84DFA3128ED9F04599972B1B01725F1A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5iXRwqCrZi4/+fOsRdvX9P/42uPDB01iPacmkwzks/h424g1jfWCrFnHSDp2EvtL3cLPnMM0cFHCbyRtlFoYJ4xdt5sUCjU4uef7qlXZcLE7R+LUX/B9vQoLCvQMNy+sPq1KB1Nqp36kUCNTacDOONUDv8qgJi/QgyQ8MrSTRvGMC7Lhp3VrqY+fqohmYpEOanPhWhKkcgbfPKH15hI7eYArxrTPXhYXLCnz4kbehDruAM0RpNaPI7D4xecrDxiWAG3jYSOjhKmtexPq4kwvT4jOVe7Kal1xNb3VEYlp5xfYPyBe8TOW9EucHl0jgGOixs1I6fExS0qmnTgWAKOM1kRWR68JgM0/qVPpsdrW7eR8mwy6zg2d5exvFjPS1XSlboejwS8psZmmkw7yI1+CGwK9S/9SbAMO+u/9AlN72q9IfhhjDErZVsVlc7dxY0AaLL3en9Era7t5nhoI2jzoYCXpUxIDSdY994HHo3H/praneL8q/+EzKQWmMgLLPRDOaoNq/hVELZBHELC/nwm4ikpzy8f7zJUmoMPaRJCjDYBWlkhmjvvEGXPDDIceGp6WfKJ5cRvfSf50j3LYAW1++dBCOXmtQqWf80ygfDlqCMD/AaHU560MIdTCsKxWmqyyngI/6Wts9eVjqAdanH/2UCv0XJSMOQBrXWwNovwYQ68buCnzndW20O4cpQlfL6ymUY7iIrmB54TMfaugN0cU/exK2jiEZ0bSRTejAzSg0FZWcxiE/v1a9S1VSbz2l5fin/RzcdtvstYuqdVmq2K+fazNQ22GdstBQlH13FxAvEpJJCgv5WjwYUpuFm0qNuCsa3T1fMnwMwJUouGcm3X0apPJryXg9f6NXCLpeE1ao9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eebc336-bc8e-4bb3-e726-08db15ba0826
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 16:21:34.7299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCPM1HaP5tnjAitSCqgTgmVEtJ/iT+d0Hb/P54Mvb/Y2+iBW9i6NVOpzQZ1+ChYwRFKxXpOHJh/RR41iFWk0BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_10,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230134
X-Proofpoint-GUID: WyoMh673DRYvNEZ11HUmmcNMUc1bskKK
X-Proofpoint-ORIG-GUID: WyoMh673DRYvNEZ11HUmmcNMUc1bskKK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 23, 2023, at 10:19 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> On Wed, Feb 22, 2023 at 01:20:43PM -0500, Jeff Layton wrote:
>> The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the "all"
>> flag is supposed to run all of the "standard" tests. For v4.1 "all" is
>> documented to run all of the tests, but it actually doesn't since not
>> every tests has "all" in its FLAGS: field.
>>=20
>> I move that we change this. If I say that I want to run "all", then I
>> really do want to run _all_ of the tests. Ensure that every test has the
>> "all" flag set.
>=20
> In some (all?) cases where the "all" flag was left off, it was
> intentional.
>=20
> We try not to flag spec-compliant servers as failing, because people are
> sometimes a little careless about "fixing" failures that in their
> particular case really shouldn't be fixed.  But sometimes it's still
> useful to have a test that goes somewhat beyond the spec.
>=20
> There might be other ways to handle that kind of test, but it would need
> some more thought.

We could use a different name for "all" since it doesn't actually
run /all/ tests. Jeff suggested "standard", which seems sensible.

Also, we could add test categories specifically for particular server
implementations, if that's interesting to folks.


> --b.
>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> nfs4.1/testmod.py | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> If this is unacceptable, then an alternative could be to add a new
>> (similarly special-cased) "everything" flag.
>>=20
>> diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
>> index 11e759d673fd..7b3bac543084 100644
>> --- a/nfs4.1/testmod.py
>> +++ b/nfs4.1/testmod.py
>> @@ -386,6 +386,8 @@ def createtests(testdir):
>>     for t in tests:
>> ##         if not t.flags_list:
>> ##             raise RuntimeError("%s has no flags" % t.fullname)
>> +        if "all" not in t.flags_list:
>> +            t.flags_list.append("all")
>>         for f in t.flags_list:
>>             if f not in flag_dict:
>>                 flag_dict[f] =3D bit
>> --=20
>> 2.39.2

--
Chuck Lever



