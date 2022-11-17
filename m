Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0B62E284
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 18:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiKQREo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 12:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiKQREn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 12:04:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E76EB52
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 09:04:42 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGmVEG015938;
        Thu, 17 Nov 2022 17:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HOxaavKPyO2uzuouEN6CAt/8qgk/DZdHPXf2whZD9oE=;
 b=F27t3g6AASVdl0x8pm8/1KrTHc9Ud8dA5+ZfJwwvMARRUt/fkuuBLhrneFpOmPOGBC4G
 v4RorWqoCqsmdkRzvEeB5gXGMHac6btJGdcg+PVb9hgsTADLOqjOrc4T/7yE5q1EE6Rh
 TeD4eCMY/SLD6WGEy8iblQ8NrYwfhqLwge5tCeLd4cbQ1+vvhKS53uqTt7TFRx3MmSxu
 Yos5yJxgtgrc1AmiO7INd92OK9kwGcRTJhNPl+q8w3g0cvzkFZYYi8ImUdDv57rxPrIy
 4AEePxqy581Y79yuaDP6yrR2UXUEbA/dJa1r9FCEqdq04U5CttOzzut0u/RtAy9s5wWM QA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kwrt6r24k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 17:04:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHFwmen028830;
        Thu, 17 Nov 2022 17:04:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk206pmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 17:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aopys8KddpbhnM0TAzZLyTTYPG7ESCgXZSSclcoODmPhWm7GfH30KmkU6vO4QTSyXqMc5+7Vzi5gLHSZszVNemL+WX128v58jnyHNvr1TrSLuYO84OKVHcFwavsszc7dFtvWgx+jfGgg5F956Mq3NJHUpJwuGtJT5fziCNfxQnEkxqqkvRmxtOoPz9U03tgbxhUzQz5Koi4XXnAuMF8jYoYRlwzwwWaD9yUhu3T7M2eS49Lpun0T7UKG8sEoD2y5SJdQhHa2DXiEMShNYWNRWC5RlWDfvMSl/P+NkHTXRdt9ayaclrJLZ83qlpKUDz5ZXqRY19UALS4CCiddDGO9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOxaavKPyO2uzuouEN6CAt/8qgk/DZdHPXf2whZD9oE=;
 b=k+un2wEgV7w9tsoyMJcLR+o0LKpRmD/xqj9xRyEgcjwI4cIO1RCRYEC+T8vwZt2eurPAFEomc/kMRQ3xxYphdkxklpK7cZdTshIt1pZwWzPRzzPC2XsWpeE3AJwano4MgPCygg4l83oydZvO/EwbZJR3L6W4PnncmL6UWFu/IB2KBYZ5vxCpP6Im9HdfAS4ADVQ0TmqxwbEztNJSC0AEFmdAfilGm68aNclHruegyt5QD8UfXXv9AsEY1sGsQ5MYUom4NXdg4FOY00zpxvGpbAfCTSxAfaUTVJJOjD5GduqGYlgQibQ7SwfkTcd3m5B8Pv2f+9hQVoAOGsiC0Nn1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOxaavKPyO2uzuouEN6CAt/8qgk/DZdHPXf2whZD9oE=;
 b=EfUmD6WlrOtgRLJcM369Y0hybG2kDKVUZW/5NOOsr5Mnd/kfPZzu+HrqtayzhIYYoqE9BUMmDRVM9VX+BZoAk9cBkhBRY8QdTFLPlGj84mocHH9H3Q0c25nMo0dQln75/zYeXyU0Lzs+AXApAgjbrHNki+RWdUNhkE70RxkATuc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6809.namprd10.prod.outlook.com (2603:10b6:610:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 17:04:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 17:04:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Thread-Topic: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Thread-Index: AQHY+jb3b6PpTwE2G0+HfmxJhBZEiK5DMdoAgAAj2wCAAAMyAA==
Date:   Thu, 17 Nov 2022 17:04:35 +0000
Message-ID: <A5796183-BE7E-4B05-A620-4BC76A2608D1@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
 <8517F18C-9207-4DE4-A217-2A0EA4C4484C@oracle.com>
 <7ee9c36b-b3d8-bb84-36bb-393eaa2369f2@oracle.com>
In-Reply-To: <7ee9c36b-b3d8-bb84-36bb-393eaa2369f2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6809:EE_
x-ms-office365-filtering-correlation-id: 0f2517c5-886e-474c-55bf-08dac8bdcdc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5rJn6LmiEF2zrJpacEKMJDHnM8rC31SJajzrXtvfQOFJsh3sKMCmq/mWGdNXkQtzT/3jrF3rkJb9hw+zoiL1JW8T+yXrMBfKfaTgszw2yKNA3C4vghkUh4d5Dsash3YjfqQIXRYhXJ8ks7UwbFWyp5Hfbv8qY3tSTmiyKpkdKfmw3hWc5/5fgTxBVo1X6KqS44ONlwDCYSpvwqxFFdO3ryPXEK6sgwYIzwMgDa9eZgvtVDVXtgIaAxSqQbXPMofkF4dbdrNPW4Y/4h//8cyUFNor2dMx1+DDfUIvl7SsKF2fjuu6OmHtnAfeCxM9OOjTviBM3atIRm8dAHPlbZ2XVWkr1PNZZ2ZkABrue88gsMb5xxCFb1IPCZ3ttSGUGfgNrC/Yi4EZ95YvsLmAdzLgCgdar4kvtLnyIt54RKnKQonZxv8mWvy+kbYq5R9SIDedg5CPVp9+Os13ir4FSpa39/Hd2EZ+8CYWJFHy7q3VvsoCPIzzHkmm+zXQRqTzOCesQPYGRT0aZc79BA4jcntTylBvRR2Dwj51/yfzpWUyHA+9+twT+4LCNKxhLRPoRAo3dik/FYyUBNId96w2S/LJ4H4v07kbxXpa+G0pyQPS1ZVElpbgO8H2vw7tMWrzD6qi0zsAugWAe3rN0c8bGqaRQjnqawpO46aKYGuyAhTlDC0E25CYGAQoPa5kqgoSrXLBHQ1bo3v7/jHn3ZBq7TAWueXHxM8dIUOhxF3/QHxhyOU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(5660300002)(2906002)(41300700001)(6862004)(8936002)(8676002)(64756008)(66556008)(66476007)(76116006)(66446008)(91956017)(66946007)(4326008)(316002)(36756003)(6506007)(122000001)(38070700005)(53546011)(478600001)(6636002)(33656002)(54906003)(71200400001)(6512007)(6486002)(86362001)(37006003)(38100700002)(26005)(2616005)(83380400001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1VwBI2L9GSlAdwe/H3D//4Gk7XRg+KzldhfR+e2PLEndcJ08zRNs3Kd6vP9m?=
 =?us-ascii?Q?kEeoPj6FyHY8qv554YWRi150gGKuk2CgawzJdv4dAW7V4N1JGlkShW2zNQO4?=
 =?us-ascii?Q?JSkFijW5N1DdvknF996k3pbKsEwd56cHyvtSJaKBw3W3Vqv5DBSDwYfyNXSQ?=
 =?us-ascii?Q?fnD0ji73WSD4g12SbMCp6UyPXfDAkd365N6ki0SRrgm3lIb5YJodWIOeF1gJ?=
 =?us-ascii?Q?tFMPHl+461kHhJF8KuYpy+P5oVhm+0oHT06QRSpwAKMOs+cAI4kSoJPlwHxY?=
 =?us-ascii?Q?Mxm7byNa37i8NbXpXR0qikklA/eV+DiXRapqDVqwyKf1guTbdZG8GRk1pj4Q?=
 =?us-ascii?Q?ypQQ31gE/MHf5pgPf/xqvARpaz2060lPR/i0Mhqoc8Z+kDGCC4EqvihvwNaV?=
 =?us-ascii?Q?wtiwfbbV+oq7SBas67a8Ww3DLCpDLAi3cvS7pcwQHKrKVXsGE4ZXznSQuoGa?=
 =?us-ascii?Q?+ZOyrskDyvDOaFfIJd/YEPtpsgkQBxgMLz6cVXN7aapNP9f7GcKn59zpgyVh?=
 =?us-ascii?Q?DkdiatoDAZZ41MrH+clommCq/4F5u4OqjfugCh1LP9m1ZY+syQnkd0IUcCan?=
 =?us-ascii?Q?T0fEKXb4GJr5GXeWcgZ8Le5qd+bHV4gcLt0fnagt3YUheqZ5FBX154bY4Iv0?=
 =?us-ascii?Q?iCLGaOew6ExLts+hV6AxyUd//q0DkA4GTllaS2V7jNnxLpwhKzj73X+xjx+F?=
 =?us-ascii?Q?pvKv51Nka+/o8TWwvdY4fONhqL+hzcIvNGPeopRateJvse7eY/hJKQRWvpWK?=
 =?us-ascii?Q?cWUR2wihiyrJFn1CqkGgafn7IJ6GsCb2sY6M8Uwrmjj0R1FZPicaywi+ZJHa?=
 =?us-ascii?Q?y8uHzaR9B98AZsQT1g2oTInK/Ka7xlq5FS5/IAT2dloSkjGGZq1/PQh3pw8U?=
 =?us-ascii?Q?D/IhClfzH7Cdy3FrGORaqEcm3WdPRMX1gWB+d+qygSnMkUtn7AzEjUGved4B?=
 =?us-ascii?Q?Ba/P4nUgdMLsg+gZdgR3HZgVSJnW20vaVRHqT68I7OKapxNX1E5zTVcKCooZ?=
 =?us-ascii?Q?3wPHypBs82sEappQOa3QJly1btW3CjDDVU+xt8EYvRbt7vYcjFQK3RD67yff?=
 =?us-ascii?Q?gLYCo55+jWKwd5pJ3NFoEXwNbyZ9sDz3RcC8zaK6aCdKtiW1gg8hV6So3DLt?=
 =?us-ascii?Q?867zOHBn4yYp4to/JQ35ckSMO0j8ndz6ZxI5rVEaLt2FXopxsbXgj3lgaOAD?=
 =?us-ascii?Q?MAKGvTJJa6gyvGY7rOs4+/WZR2fye3d1MCGtIpLuhA9U4QqQyCN8eJXODxRa?=
 =?us-ascii?Q?3iyZW7mhTB236HAOybBFIrs4fN74eMfB40HbXKyObrxU1oGmiwmdeV/0bfDd?=
 =?us-ascii?Q?sygzfChPAYU4UALG5p1pJMeHMctWVv4DmNKyOzZefzDRsDh9SyLsNNNfwrDj?=
 =?us-ascii?Q?89SSkjGQZTWJycLRA6YTH4pA09DnqsLhQfokTu68agTvtOANwungabCCgC9r?=
 =?us-ascii?Q?agfUVgM+f3gQbtgEBj3MJVM16jd1L+ZJxynfi4css5LPncSxSW6FK3TNUD8F?=
 =?us-ascii?Q?pQWckxf184sZZDmOrjEdV6jbZ5PuSkyDIUSJ5OCZc7QO+ECC1AldpFPV4ZSR?=
 =?us-ascii?Q?6pO8oOqRNevJd+8GRK/qvDhQFxtKZppbHDaWswlYpzHamT/4HHfznoAYWMfP?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7672F8A6AEC0F04782EDE9A61DCFCFAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gALaPiYw8/MMynSIqW/oTZbYp6GTzKp6p3/GdwC+7OcfhZWFUICNfImKfwJwn2v13nKRlEJ1ndfcIdHbVNk8B7xDWCHvhuZNPYBmMEo5flCvFStBQYR4DB6KgzDZmD0VAwwya1PrCs/mPSPQv3f3aGSqRBOi8Qo+/YOoTX3LbdATscqsuEcyDjcjKM57pfpItp7106kGomxwe5fs9VAObCldl7gOuHx1FbpplPH0i+Q0rvAd4qmaKNA2oSq453Tu7PSwaPGl27TTCGbobxDP12BW/J/oZUI6YvymL52icjirBogAM1RRgdAFyW3Ywdh5791NCnTRn+74Ke3edh0HBtFyqsLFdWu1uhdKuhlYBwbUDC/BXPsN4srhRVJynFjFLASEG6TGc31s/3Snfxrgo0MAhEpr586ggBsEwc0YJc4Si/Ud/e65V3oNW1IQrfTlm5XvIfFz+AHBmt+jrBMCjVQvXJkehKXL3REbwBDIA3cPbjkgrCjviqEpMRzRW/p2JKBVHEFdQTguWdv8uB96hOzZt9VDQwyaelJBMaLqrwiBEAx9grDaS16yDenkKyAMd9h96NlY1Cs1ppss2OSIn2/GuVPZT0mXdzAZoR84qlfMK+NqK8mbIdhankstmCWCIQhY0EmyV3aKRMa5GIgX3X+FW4GkxkUAY6JHG/6IP9eX390QzymtqhGa+t258rWLAvAiGZwDhboKUoX4ATySTvgzU8aTLnAXOfa4hNUt4kmeghYmlDv5I/repfKfaj+l2nnvTO8ZWs7jUl38DFjULVDZ+5lba3DkE4k6H1GKBC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2517c5-886e-474c-55bf-08dac8bdcdc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 17:04:35.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kn91qyK/03gYQSN+14KEusB41t5/zuICirK6uPUlcW5vgeuc/5KiA7Bxkr+lQf0ycGl+A0XkD2/sNu+Z+bvw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170126
X-Proofpoint-ORIG-GUID: iQnvRuQsleJYS2Ebqh9MKcyQXfMHztqv
X-Proofpoint-GUID: iQnvRuQsleJYS2Ebqh9MKcyQXfMHztqv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 17, 2022, at 11:53 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 11/17/22 6:44 AM, Chuck Lever III wrote:
>>=20
>>> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> This patch series adds:
>>>=20
>>>    . refactor courtesy_client_reaper to a generic low memory
>>>      shrinker.
>>>=20
>>>    . XDR encode and decode function for CB_RECALL_ANY op.
>>>=20
>>>    . the delegation reaper that sends the advisory CB_RECALL_ANY
>>>      to the clients to release unused delegations.
>>>      There is only one nfsd4_callback added for each nfs4_cleint.
>>>      Access to it must be serialized via the client flag
>>>      NFSD4_CLIENT_CB_RECALL_ANY.
>>>=20
>>>    . Add CB_RECALL_ANY tracepoints.
>>>=20
>>> v2:
>>>    . modify deleg_reaper to check and send CB_RECALL_ANY to client
>>>      only once per 5 secs.
>>> v3:
>>>    . modify nfsd4_cb_recall_any_release to use nn->client_lock to
>>>      protect cl_recall_any_busy and call put_client_renew_locked
>>>      to decrement cl_rpc_users.
>>>=20
>>> v4:
>>>    . move changes in nfs4state.c from patch (1/2) to patch(2/2).
>>>    . use xdr_stream_encode_u32 and xdr_stream_encode_uint32_array
>>>      to encode CB_RECALL_ANY arguments.
>>>    . add struct nfsd4_cb_recall_any with embedded nfs4_callback
>>>      and params for CB_RECALL_ANY op.
>>>    . replace cl_recall_any_busy boolean with client flag
>>>      NFSD4_CLIENT_CB_RECALL_ANY
>>>    . add tracepoints for CB_RECALL_ANY
>>>=20
>>> v5:
>>>    . refactor courtesy_client_reaper to a generic low memory
>>>      shrinker
>>>    . merge courtesy client shrinker and delegtion shrinker into
>>>      one.
>>>    . reposition nfsd_cb_recall_any and nfsd_cb_recall_any_done
>>>      in nfsd/trace.h
>>>    . use __get_sockaddr to display server IP address in
>>>      tracepoints.
>>>    . modify encode_cb_recallany4args to replace sizeof with
>>>      ARRAY_SIZE.
>> Hi-
>>=20
>> I'm going to apply this version of the series with some minor
>> changes. I'll reply to the individual patches where we can
>> discuss those.
>=20
> Thank you Chuck!

Changes folded in and pushed to nfsd's for-next. For the trace
point patch, I've rebased your series on top of the patch that
relocates include/trace/events/nfs.h so that the new
show_rca_mask() macro can go in the common nfs.h instead of
the NFSD-specific fs/nfsd/trace.h.

Feel free to pull and test to make sure I didn't do anything
bone-headed.


--
Chuck Lever



