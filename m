Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1D67DD763
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjJaUuV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjJaUuU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 16:50:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B799BF9
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 13:50:17 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKWTkS004616;
        Tue, 31 Oct 2023 20:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HWZzXcQ6qnTXSrd0gWoXagj+A8NoUHdJ8c2qCaY4VM8=;
 b=3RkbcEDKXwWK2+f4TfD8tylWBK3MAke/Ghq3GzioTKA2TRDVnSegJCFEw291lrlovJv+
 9fEEIzKQMy5u9OF1UdLM1UolmGzvkRUGw9JXaEKRgSCECOfOJEC5grO3jiXB28RjMHGy
 Fo3aD7ytE5NRi20h4grPY8wKgHyaLlhMlf5wFdG2m5V118NiWygieG/r74hUg7V6jGHs
 RYwgwRkTfl5AI4K87t6TdolZGVWUHc8gCsOYTUzfhhFa1Jo4kuoUQWsCoSrVpZXrLOi+
 GfuF9uQSkbSMPLRwY4AdjrQJMG+NxjOjvtPr+0BtyYn+oJDdwSvTkT5WSwo4OfZVnPnn rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdp5ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 20:50:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VJDLSU022634;
        Tue, 31 Oct 2023 20:50:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr684rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 20:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nny2F9zwfAcKp0Q8f4VQlk2SvSgA+zc4ml7+J+WW66JqYua1v/lwvNJU9zQRgV6SeG5RisYWGPTcddehMN98XeH46dHzpZGa7q80yv8gGUZ6HbbnTlhqepvC1IZNzi6igKVrtyza9KqRiJ9+zjZCFl7D9149u+EcSol7V6btFSuWeNF2VOlwbkNavKmk0NhGyFJhlKQROd0UHHhPoVrVUIzSP1UegogdTCDnNZv0/PajyeugsPWtvMKNCtmYk1aHX0Im6SPKwuPmcBl0lhRAbkpAuWqmUIPCqSI6imJ24/thg/CC1H94FfB+4TVIRtye/qEOzI4V+C4w7sTn4+fyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWZzXcQ6qnTXSrd0gWoXagj+A8NoUHdJ8c2qCaY4VM8=;
 b=Rh7QMOo4+D6vcAonhEgTPYcW6fYFqVxxDCvVe+jL1JNDBc1D24C3iuzIQP8B6xthlca6l6tP/tY26RS+PjPPu3NJxKzBYUpS/3XRc2nX8+ikt23LhxtZXmjRXz6SD6B7c3xH+yX39teIUoVvYDZFZ2/gLYxYkFR8kHcNTQI4mEtBrPiEHUC1OoF1wYqtxP8jMxVlhN9KtBHr3NgoQABlSmUyBK28t7Rfwc2Daa04xp5e0br/hVjDImyVLxJy00WO0R8vTv6sqoTsRhcLf85uU+E58VZQjb/GUMC1+khVZPeCKDT5Y3/7zq6cOfVmEJ4vMo7hxUsHfVD8dMNoAizwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWZzXcQ6qnTXSrd0gWoXagj+A8NoUHdJ8c2qCaY4VM8=;
 b=p0xbO7sLJzN6+JQ0lfvtS5yXyxTGYFcoL9T313pz/SRXQy159pbwNoB3NZZaX6nFCCWuJcJU7GYRLQbNCasTio1Gg594tNTRFDdkcteq1YcBACqNUZAy0F64sbVkVR25qJUtCS0CdRFjL7NKvuJ8xMRsbIO80PmPvz5oEXEv0fI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 20:50:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 20:50:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/5] sunrpc: not refcounting svc_serv
Thread-Topic: [PATCH 0/5] sunrpc: not refcounting svc_serv
Thread-Index: AQHaCs5Bx30Sst3AQkeWzWCFyIpqgLBkCzaAgABUNQCAAACLgIAAAScAgAAA4YA=
Date:   Tue, 31 Oct 2023 20:50:05 +0000
Message-ID: <30967C32-F86D-411D-B30B-B4D5C1327CA6@oracle.com>
References: <20231030011247.9794-1-neilb@suse.de>
 <9BA28F70-A3FC-4EC4-A638-A27C1867F221@oracle.com>
 <169878484259.24305.17786556797570881562@noble.neil.brown.name>
 <C869423C-B578-4D5D-B171-444EDF2D0D02@oracle.com>
 <169878520677.24305.4940476987470825179@noble.neil.brown.name>
In-Reply-To: <169878520677.24305.4940476987470825179@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7259:EE_
x-ms-office365-filtering-correlation-id: b6611351-7e5c-4b2c-60e7-08dbda52f677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0UTxCD9XEHRpvs5IPYkYcW6qulLcCqgTNe5TL5n95zk1vXFlrn07UUoYHcSBEspn78hkzCRJU0RU1QYI3THdQay4IlEYiQwpLuiJrrv0BmTBlzH6A3CDt2HcuQ0hh1W6/bB7Qf1kml3h1qjvKVsvpU4iklzLVPdk5OcGsvHfWBu15gJkaddCtjJBThcCufMwSzUB7vQ4ep5V8fVbPjLaqitJDfkLKhfL8zJT+pQgly2l8h80iOMJePooK+duglaM5ubQljddlrvymO09x49rAp8qlzEFJS40a+Lr1cn1CBat6U4GH1ituDoPXLl+n1jQUbd/mIDsTJHCbBaxVri9+rq896/7Yq8uMbZMBpW4puB4ovpYqozU9FLpMcgImZypkJEt/LG3q3empFGbWrWJ/PPgFBveWh/4eqGVhyhboDIun3NuEqsggorXw4xnWP1W/OeA1IabYRjOerwebcytV5JuHkNAuZHqbndMrG0odhHegi3BsWoWlanSBkygKjiwt4saIyfd+1ATwxdbRo7yET00kdDAeJfKnBHwXTTdF+k2p+3WWgAGos9LUTzK5vqM2telajnDxfa17/l/jwQ51mJ19hufbAyzvLjNBsfl2gC6l4uprxz8MW2QsvrTbb8p/jDQptlqvvwwNhnSQhBUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(2906002)(316002)(2616005)(53546011)(6506007)(6512007)(122000001)(33656002)(86362001)(41300700001)(26005)(4326008)(83380400001)(6486002)(71200400001)(66946007)(8936002)(76116006)(6916009)(5660300002)(66446008)(478600001)(91956017)(38100700002)(36756003)(64756008)(54906003)(66556008)(8676002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8QDHAj1Y3tOSuUBBXFIZA1+du9L5fu3XBWAogtd3CXdCqQY+vuwbZYhBepX/?=
 =?us-ascii?Q?poFansJJn6uQIBbbOAVDBHXDVmypw/kwaMN6HAiKH6KP4ejbutYvePtMePc6?=
 =?us-ascii?Q?4s+aWFNH1DwO7tT2hdlzg1ce3JkvVbCIexnCMs9nvc3poYiCU7gG+TES5RsD?=
 =?us-ascii?Q?pOysxVIhGI+nvB0QDkCSwjUi9AmwT79CpeqzeoGJYUj9/ERuN8jkyJwWNh/D?=
 =?us-ascii?Q?4qVVtQ640sJf1Z2E7sFL0c+e79QZJgYaqKLGB9UKYxeXoRLX5B9k+fbVnc7D?=
 =?us-ascii?Q?8NqVpykypSbcu5HbO5o1oKiZZ9Hu5w96uUmvVY1vG/nuzQ/zRt6gBArVSuUz?=
 =?us-ascii?Q?bS0ciKiKZRN/ImdbD1qzxPd3O/pw5lhYdEoIe2zYGcKlyxZoGkZrew8d8RPL?=
 =?us-ascii?Q?MMPkxNehbjDycTR3Ao36a6iuyiXU5f6cdG7O590sAobm/s0xPA7o8qha1zRR?=
 =?us-ascii?Q?Ob5OCydAYSd5JOTD7smA0apqB/NhYuCrkznhxGqJ+rgxIZEa51DsywMMk1Zj?=
 =?us-ascii?Q?dqcCFoUSR4e0GYxLt9VKwkJZZjZ1nrEckVWfj7QRiEWk/IXYXCxl7bvMzNgd?=
 =?us-ascii?Q?TszPTOvRLVFRgZ50u9pwU/mZL92RrV81uv3qQilrST1Y4jlshLti7hX9TMYQ?=
 =?us-ascii?Q?Mhi0KTUrDUCrtIUlvGRhUkVbBoZ9rpPwJ3O07ZzMi3zf5ZUfQ3QU+cS0Q+sX?=
 =?us-ascii?Q?MF/11s3hnEvIVYDS5TajosXZM14lhojnvrJKUrRf+I3iRU80W3v5AA/sIJ7m?=
 =?us-ascii?Q?UL8H7np5maWIwgpBU9W93qG5LkyC8476a69XmgDtRzlLGtqkuSQkei9NNnUn?=
 =?us-ascii?Q?xq3sjDfLMxRi48yCj0jlFxnLfA2hn+qmTjgReiqSgmFcsmXX11vrQXBA6cxt?=
 =?us-ascii?Q?MaKxeon5rTAPdAOMIBiQUUsg/CgNzEVDehOubnkOKcTUgFTpNHMEWwaNge3S?=
 =?us-ascii?Q?GVpj/W4sF7Ko8D0pAUlMZlcVR5aME6gCzCVQfTnJ6gap8dSw/SMUQ13L16f5?=
 =?us-ascii?Q?nOJ0nd4y3mfrL07GAxOwzh6mAwpt2ouq7RKmwoMXoLWIJLbJr5NtPMO03fVU?=
 =?us-ascii?Q?rWWis9hmYz5BaNfCd8QKzOQdLDmNadgCE0ClQMrkA8A2s+GB1f5NBvIYHrrm?=
 =?us-ascii?Q?KSLHy2Efcj14I8IH0kjoBU3zHakfP6HuY1fJqKSUj6eiEo2e+kRNTlA1IYZw?=
 =?us-ascii?Q?RlUM5F6u1JepOT4FVoSXOCgsaja1K2HuDKHKG6sYbxh7JSAZEY0OkPgOT9Du?=
 =?us-ascii?Q?SeIxnz+Y0EeOjSs26MIyTqb3XDKh6tw1MDvqZwBg5jOh8gcGkAK2R+R5FtcG?=
 =?us-ascii?Q?IH7wrolKi/6nXhc88mt/m9/FQUob7R7hWZjIUlxK3dGB7TASLIXiimaV1otH?=
 =?us-ascii?Q?PZdbxII4mUI465ZDWW5wEq9tAwDH9IL5RPLowVRR1qLfHfaVM+ALyPs0944O?=
 =?us-ascii?Q?RGmQH/0RIZ5noSoUbYMogp9e21NjH/g/AlcDEMhnBGAl3IsMfWq3egip4L1Y?=
 =?us-ascii?Q?NVEVA5Bt6KACqHzYWfve+bk72ISEnPBMw9J9DAHltDdRwtAHlEn+sp/Dn2fo?=
 =?us-ascii?Q?jh3i93aSrpSWaViCrIh93LYxkynP+78ndC9duF8ZIY1365shqDkKQq+n8Nk7?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F44520409F5044690C2B1653484DDEE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OTvxzkqc6RdJG/DddTlgBcsQVEn3rlsGTbT8hZtOT/lbo5QuuaAkro9Cz5cOtfXspA5QROVoUyTQXCwyyPD5TpyuOzWqJCYcnBBaq//CmW1bAF6O7yZn/B8mDXwzekd9tn2PDNOcqfTES2XFQ7gBVb4tVsIRtzUKYNqq5ZE1QqqxTy110tenFVT6tLNXJ4bL5T6WFh4la31JZ1TaFJGDgoKjAth+01SvYXViG17cTvEmvPUEP6/t8uWbki10an0M+5e7YyCVurGVRjIz2ICLxQcS7rlZdWeZ0ga2wkB55sZ/2Y6Q5L5imYnBN+IdhMdqUV3Slx5/fH8pnuzBwCqKJxY1VU0GPrF3cq805Ar0RlMMD6cqfuzxYVlQ0I2zi5tAv3/KL0xlLyCPSA+14Rm75Umka+Apznn771zh2g17JgSXnP914feMF+dCmqR3yuB4DiET+0J8a9luOVr3KOR2MDOUMk8mbPBmWzQRcMZ+4tpV20AQLtsL1rPZtRUqAA+KBiPoVlTqQg22EjnsyKdOXY0RjKyigHryoA3T2/3jwJq3U7wXjP1MWilStqHUGPEBN5An+EbW956bia1t/42iziEwgX9auny9ygI+ERE1eaTOw5u8oQy4+u2tQz9BMRaLdC7TGlqQ9tpg/tmrW9VODhnwQ4KDgNWs9of69EjAvj+uywtHK0ugXP/LjTB/jmFVgeA7jVhqcdWmbTvoETaT0ue5wjOTTcWFiSjF3UfGYJdO433WoXo6GygFDaocBHJfm8LiDOVQvLgZvijCU6hlAngUi8KpVYJ57WlSdg1ew9tzv/Mjf1c8fw2aEmS7H7shmPPTTxYyKOkOVEjCdHbhoJfgPTLNxkLhoLmX0ZiQwQ6cfOzhk0oeAwDJ4TvXhDi2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6611351-7e5c-4b2c-60e7-08dbda52f677
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 20:50:05.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KT06PW/DnKJ1wK6UlH8C6vyBE9UDB+leISOop00707+qkKT15Upx2dK7U0MWSYB52CG9TszsTBexiaMXS3bAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_07,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=886 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310170
X-Proofpoint-GUID: 426CO320ssVobixDpNy7VEUeCfiFlkeU
X-Proofpoint-ORIG-GUID: 426CO320ssVobixDpNy7VEUeCfiFlkeU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2023, at 1:46 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>>=20
>>> On Oct 31, 2023, at 1:40 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Wed, 01 Nov 2023, Chuck Lever III wrote:
>>>>=20
>>>>> On Oct 29, 2023, at 6:08 PM, NeilBrown <neilb@suse.de> wrote:
>>>>>=20
>>>>> This patch set continues earlier work of improving how threads and
>>>>> services are managed.  Specifically it drop the refcount.
>>>>>=20
>>>>> The refcount is always changed under the mutex, and almost always is
>>>>> exactly equal to the number of threads.  Those few cases where it is
>>>>> more than the number of threads can usefully be handled other ways as
>>>>> see in the patches.
>>>>>=20
>>>>> The first patches fixes a potential use-after-free when adding a sock=
et
>>>>> fails.  This might be the UAF that Jeff mentioned recently.
>>>>>=20
>>>>> The second patch which removes the use of a refcount in pool_stats
>>>>> handling is more complex than I would have liked, but I think it is
>>>>> worth if for the result seen in 4/5 of substantial simplification.
>>>>=20
>>>> So I need a v2 of this series, then...
>>>>=20
>>>> - Move 4/5 to the beginning of the series (patch 1 or 2, doesn't matte=
r)
>>>=20
>>> I don't understand....  2 and 3 are necessary prerequisites for 4.  The
>>> remove places where the refcount is used.
>>=20
>> Hrm. that's what I was afraid of.
>>=20
>> Isn't there a fix in 4/5 that we want applied to stable kernels,
>> or did I misunderstand the email exchange between you and Jeff?
>>=20
> That is=20
> Commit bf32075256e9 ("NFSD: simplify error paths in nfsd_svc()")
> which is already in nfsd-next.

OK. I'm still confused, but let's just keep the patch ordering
the way it was in v1, then. We'll work out any missing fixes
as they arise.

--
Chuck Lever


