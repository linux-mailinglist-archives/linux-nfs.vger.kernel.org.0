Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E841573C01
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiGMRbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiGMRbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 13:31:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69427175
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 10:31:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DFoisO005814
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 17:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yVQkq629+BemMsJYkj7Fwmb1asUKJQ59RlDhjJItRfE=;
 b=04e+Iqv9b/S3JFRvowohNJww2cmk9WYr5CMnNcTRFQzzpnQMcNeW6GvyX5VrDhVg998N
 zG59ggJVvtjz15YCBiZ2Bwo9Cgv1AlL9rIFUZ8HIIkWrN5q7FNchFMjyRBG0vxCXGxjc
 vedFUGuNWayy8Fviv7uZ80spawnNRaRZXXbiC0ZACkzSlJBQh037IJob2521P+kYX2OP
 qKaosv7nUyQz8vRWQ5RGmLLsuf2YUkMeojUbTpolI6uLhQwX0Wimgv3jkpYouNwLlIgl
 iiB47Eo6H+Pbuu1xPCzk3X7eoZG5ZzN5K6aQBpykLpuUi7tKwOZ14LqErL6Zvp4Q1HV5 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgtby2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 17:31:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DHFcOl020025
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 17:31:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045axt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 17:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmsHutR3B8QnnsG9hY0hD8fPgxsfXwPUznnimetDwuTjoHTD110Hej3J8XnsCPLOkHyWeReBaSRJaEJG94AjCQML+7FgnUfnP1FQFzcNKxtWMYjm/5bszwrZaHp9nqyculPkwPZdvI+XDISqjUtIaePXpyrALg2Rp+VDPpIs1WAHHFjQPVXhrpbtFKKc7o/DBipQb3QqEdTiAFhNFyNZ/ntEOinAlw4MhImTIYzwgmKIm8YjGg7kEvHN/GOr73O92Ov/OtQ/Lw+lU1nkw6U8rZJgRWNaFwmxNa9u+UaQkh3zOt6SUsLym4Ua4erdtYEKg0wWAT3OU77NGNvfxlJ5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVQkq629+BemMsJYkj7Fwmb1asUKJQ59RlDhjJItRfE=;
 b=nHJ59Nk/Q+lsDaeuO/mFgUAKv1HsellihgH9HfZlSeVz7ZfwvFs/bwMt2fT2W0XBgfa5DWZznrkZLjrmGHafMK6DcYROlfbNWeAcFf1aeE5m2WSmtuzcXnfc1AQPI6G9b3qZwF9NCk6Zn/l7QMQd41XWgFrHWhtFlcJlSHt1YoDosLPEXMMKPFmxBygK1EJ3dBg1mBJEpl425yRPK9x92ObqsjAM171WoPlgKU1s3HQ+cgeaQpRsTejdv36E5IHHhJsg6HtuYvXg7GBaAZVnTkeltle91JjBSOHCAXQUy71TPrS1fBPQN0xrl/oWwoKJkjrZ6N9GP4+M6tnEjY8M9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVQkq629+BemMsJYkj7Fwmb1asUKJQ59RlDhjJItRfE=;
 b=I7OCv36KAe6nGSdhAgzPm5WFv/QXrVAJdTr4cFL/DpgaPUImuef+sBN7YaWDzN/OMIpAqAV1YiHMiipVdR5ZpE8hlweYdADyPJxaY5sdFKPYtGv7lR480vy3+2hUzPUomVL+hqHN0op3YlX3oGMktZsr3uqnwIkzfLMM8+nkylM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 17:31:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 17:31:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] NFSD: limit the number of v4 clients to 4096 per 4GB
 of system memory
Thread-Topic: [PATCH 2/2] NFSD: limit the number of v4 clients to 4096 per 4GB
 of system memory
Thread-Index: AQHYliuGQrjuLSRYvkiWuZeoZ0JRFK17R3+AgAAKPoCAAT6kAA==
Date:   Wed, 13 Jul 2022 17:31:18 +0000
Message-ID: <D1DBF449-A596-4B57-8A11-BDF2F4D4E3C8@oracle.com>
References: <1657656660-16647-1-git-send-email-dai.ngo@oracle.com>
 <1657656660-16647-3-git-send-email-dai.ngo@oracle.com>
 <D112EBD0-D062-498C-A15F-65A44097AC6B@oracle.com>
 <49904258-a696-387d-f223-d64908d70287@oracle.com>
In-Reply-To: <49904258-a696-387d-f223-d64908d70287@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a8b1289-3cae-43cc-3d80-08da64f57f32
x-ms-traffictypediagnostic: CO1PR10MB4644:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQX8b5ZnZu8ookEnyyIU4t68SfQFtAi2/ZgCwDXn0aT9vOAAzHIhwbZVZJ0GHQpXf9IYNHzzAVbbP40unHA04WfkEvrw1dYDF0UYAPGqFnRsUwkIhgHdZ4M8vqWRk+aocuOkQxGQojkmpe/3hu3KAZxRiha8kdnq0xka6H2TCBRm2mEKvRfv4GHfYh/TJqA8+8DKhSPR+9HWGyajTiUM5JHIMQMHpeu/ys2aa9GmoQI30QDhdZvoAyST02H/uWXThlS8miWFay7GZzMo3cpp6lDwDy3gU7GJjsNEQLGURWHnrGSz6EpRZkEotoT+AqtARlxV700cUxfZ9YwS19bsbj7HyNySHINs6/7xQHreqnudwk1EIhyzZC2E5HxQPqWW+2TucTlye+CgiFWH+ZVgJACu3cN8rAi08Q/hGgLQi47cRxwB/aGhU7iy81GdT9rdstBGUvVfLZ/ovVgYe6aFGo9FiXuB4ytj4+lkEYnLmbTRmGL4f703SOCS/aI8tFfAItaXxKu5Ipz3L+vAdj6xnIChncHRmWDz+MbQdfNqVCdrSOmKXyommeiv52zJfQfP14ZFA2NarbtMI0ZxqpTMjyqyjQxSnRBqiuXPV20benbPwVgcliWwGwPl4wgfgUx0qhk+3HiiPtXLRN+nuOC9tIy9Fch7BZNCh9z4J5RCsfYZOSAHPPMH8fajCrOhOlc8NUFQBJnF8omCxiI0TLH68wbQ6KrsESmeEFGfdaY6JVQzhSEuQggJOvtMhjj67scM5Y+R2FFAJxOrOyBn9Qo02bI+gqs7bvue53/o4feObG2do9L5Ogg6KL9L3ZbDOvmhbYB8f8JETbrpermCC4OkjMGjpF2HSuht6V/FdB3dIc0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(366004)(376002)(38100700002)(8676002)(64756008)(36756003)(122000001)(6636002)(478600001)(66946007)(91956017)(76116006)(66446008)(4326008)(71200400001)(316002)(66556008)(37006003)(66476007)(53546011)(33656002)(2616005)(6862004)(8936002)(5660300002)(86362001)(41300700001)(6506007)(2906002)(186003)(26005)(6486002)(38070700005)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/rMSasV9Gdfo/uuTmBkrGRnEvns9SWRJQig9J/FsBsvi83gik9Pj9esQA+63?=
 =?us-ascii?Q?Pg+nWChTGboqRMmuesXlx3ft0PY/BT8uJynjYE59KDEN8sDaEC+skSzvrTro?=
 =?us-ascii?Q?kcYYcK/bwguulorzEAPk/7PtdisWd/Unos8O/OjEh7tv3I1+4nMLmlrExhOn?=
 =?us-ascii?Q?t7HEI57lZFNuDzG9ndyNKLidNoLSybyWMIttfNLa98nfStXImnRKa7BwVXUu?=
 =?us-ascii?Q?mA+EI/8fs+T/C5tUFPFYHWqt1uae3MZHII2/HvjjY7qyStGJqNBESve8qhZV?=
 =?us-ascii?Q?2PxEUksB9eBPLy6q8IGXvoVWBK38gkVaGUrV+P7oTHiDWFqnVDxyQNi7/cu2?=
 =?us-ascii?Q?LfDVeGzZuMdg/8gpqhTF1PEGsjRrcHCKuEcjWZ5Iw/FxicLTwhPlFYf/+fqU?=
 =?us-ascii?Q?XXSQU257OQ1bROwL2ZkuH/QlpwfHpaRQ5IZOUu8DkvZ2w6KhAfPrXdglC1bt?=
 =?us-ascii?Q?+BXL4jbKnUeean0dUPtOSL57eBz9al9dmDVLwh6SVxzKFEIPOKfpunu3H9/u?=
 =?us-ascii?Q?yTnKeP8tHVDHljCLzuuaGkp5riRlldtxRYTEe6xGDUQdyAuafw1zqc6IRdvJ?=
 =?us-ascii?Q?0jeu4YQ+y/n7rTXC313dCF0BbBXM+0Zl6GbetKCRsHzyvFLSd5jxeBv5pHkH?=
 =?us-ascii?Q?vQgfZqyrgGCKCnZ7sFqk6fys/Iogyc5/x5cInrEKc5cQy7HPjSWUcPE5uRo5?=
 =?us-ascii?Q?hMpgS3m5yJXZJn13uGtMKAOP1sR8+oamRCH+GTNcfAX4g6LUl1qUzBN/UmGE?=
 =?us-ascii?Q?Mk6BQohE1m4j8XsU1GTqd4oBv7RIl/YJGlmuNb87wf10+n8qn5vxv/kMzHh4?=
 =?us-ascii?Q?c0CzwGxne4X6VVSw9WzLLMwwmRb7d8BSA6vwc83gnlMUG1xGvvAArGvZY7Pl?=
 =?us-ascii?Q?CC4FmX+xAPCR+K3Sp+23ukavq76gKymVbgVj5qi0fzyQKiP4eybQGvUclHy9?=
 =?us-ascii?Q?Os4RPlz/z9NeBEVaraHTlFelFoXLoXEfLyZAH96JsYiaGJ0FuRE2lFkfjFpR?=
 =?us-ascii?Q?0Grc/HlwrBFXhloFV3l7bM4QTYDsEDswL/b96SMHI951n85WJ8PtiZGQLCMj?=
 =?us-ascii?Q?VxQCQ36iId7L3Qu/jvDTudBlFoJarETcYWXj2xrWhMZ1vBbw8QGIV3XH7dUJ?=
 =?us-ascii?Q?WTDwVCREaMQrxRbcSyU/HuxfnqrKdK6d6S0YzZ/xHMo1g1pF7bYdKYt+IE2q?=
 =?us-ascii?Q?RTKjaWqNsOKi8hev8iitLaDOcj/OoD/EGjLvDgc3/E/XLbSDWguYw4c53Ku0?=
 =?us-ascii?Q?Ik0KS8KX+o9OBqrXD6kfeq9DVAgL8mc+krfbfU022lXeOG28cJUARXSRpn4Q?=
 =?us-ascii?Q?FB/9r2t+rtckAZS5hng4IjPaEm19/Lj7+GZjwNVmzasMaBy07jw30v3ZYL1J?=
 =?us-ascii?Q?UKW/NNYV7kX2c/dwf5aX34qZpr1K+bw8rUSA0464XHXc24XcLuoWb/KC4TMR?=
 =?us-ascii?Q?aI2k6cG1JjmFHHgKLGYKNPdnJU03hCsxUvi5wDZZQj6aRYWixpuw3zJBm8Q5?=
 =?us-ascii?Q?jwDX9wCLXmhxasXgttBRvYJ4WZl/Rq72pJjdZ3Pb+LmLBLaj/+dCn6wMLvg3?=
 =?us-ascii?Q?K5wajL/9I1mF1pc0wJaon+bMvvYBlIvy6VHy7U6CJcdCCndEkwPig0XR1GLm?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59E9E7B17F60DB4E98B44AEA52529BC9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8b1289-3cae-43cc-3d80-08da64f57f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 17:31:18.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8hdhLn7B3GJV7ZtMPqZurv1+pB0BkGWecjp5UogDwbaE+EXNd2Gqi3eUU7Vu3UyMnN9uzs7wqjbTiHSJRKzhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_07:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130072
X-Proofpoint-GUID: L5xKoduDpRkngkflXPwbtf8OGIXe059X
X-Proofpoint-ORIG-GUID: L5xKoduDpRkngkflXPwbtf8OGIXe059X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 12, 2022, at 6:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 7/12/22 2:54 PM, Chuck Lever III wrote:
>> Hello Dai, lovely to see this!
>>=20
>>=20
>>> On Jul 12, 2022, at 4:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Currently there is no limit on how many v4 clients are supported
>>> by the system. This can be a problem in systems with small memory
>>> configuration to function properly when a very large number of
>>> clients exist that creates memory shortage conditions.
>>>=20
>>> This patch enforces a limit of 4096 NFSv4 clients, including courtesy
>>> clients, per 4GB of system memory. When the number of the clients
>>> reaches the limit, requests that create new clients are returned
>>> with NFS4ERR_DELAY. The laundromat detects this condition and removes
>>> older courtesy clients. Due to the overhead of the upcall to remove
>>> the client record, the maximun number of clients the laundromat
>>> removes on each run is limited to 128. This is done to ensure the
>>> laundromat can still process other tasks in a timely manner.
>>>=20
>>> Since there is now a limit of the number of clients, the 24-hr
>>> idle time limit of courtesy client is no longer needed and was
>>> removed.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> fs/nfsd/netns.h | 1 +
>>> fs/nfsd/nfs4state.c | 17 +++++++++++++----
>>> fs/nfsd/nfsctl.c | 8 ++++++++
>>> 3 files changed, 22 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>> index ce864f001a3e..8d72b302a49c 100644
>>> --- a/fs/nfsd/netns.h
>>> +++ b/fs/nfsd/netns.h
>>> @@ -191,6 +191,7 @@ struct nfsd_net {
>>> 	siphash_key_t		siphash_key;
>>>=20
>>> 	atomic_t		nfs4_client_count;
>>> +	unsigned int		nfs4_max_clients;

I missed this before.

atomic_read(&nn->nfs4_client_count) returns an int. So
nfs4_max_clients will need to be declared as an int as
well to prevent mixed sign comparisons between the two.


>>> };
>>>=20
>>> /* Simple check to find out if a given net was properly initialized */
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 30e16d9e8657..e54db346dc00 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -126,6 +126,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_rec=
all_ops;
>>> static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>>>=20
>>> static struct workqueue_struct *laundry_wq;
>>> +#define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
>> Let's move these #defines to a header file instead of scattering
>> them in the source code. How about fs/nfsd/nfsd.h ?
>=20
> fix in v2.
>=20
>>=20
>>=20
>>> int nfsd4_create_laundry_wq(void)
>>> {
>>> @@ -2059,6 +2060,8 @@ static struct nfs4_client *alloc_client(struct xd=
r_netobj name,
>>> 	struct nfs4_client *clp;
>>> 	int i;
>>>=20
>>> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients)
>>> +		return NULL;
>> So, NFSD will return NFS4ERR_DELAY if it is asked to establish
>> a new client and we've hit this limit. The next laundromat run
>> should knock a few lingering COURTESY clients out of the LRU
>> to make room for a new client.
>>=20
>> Maybe you want to kick the laundromat here to get that process
>> moving sooner?
>=20
> Yes, good idea. Fix in v2.
>=20
>>=20
>>=20
>>> 	clp =3D kmem_cache_zalloc(client_slab, GFP_KERNEL);
>>> 	if (clp =3D=3D NULL)
>>> 		return NULL;
>>> @@ -5796,9 +5799,12 @@ static void
>>> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplis=
t,
>>> 				struct laundry_time *lt)
>>> {
>>> +	unsigned int maxreap =3D 0, reapcnt =3D 0;
>>> 	struct list_head *pos, *next;
>>> 	struct nfs4_client *clp;
>>>=20
>>> +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients)
>>> +		maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
>> The idea I guess is "don't reap anything until we exceed the
>> maximum number of clients". It took me a bit to figure that
>> out.
>=20
> Not sure how to make it more clear, should I add a comment?

I think I would prefer that you don't use a variable initializer
here. That splits the initial value between two separate code
paragraphs, which takes more time to read and understand. The
following is only a suggestion:

	maxreap =3D (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients=
) ?
		NFSD_CLIENT_MAX_TRIM_PER_RUN ? 0;

It's just a nit, though. Optional to fix.


>>> 	INIT_LIST_HEAD(reaplist);
>>> 	spin_lock(&nn->client_lock);
>>> 	list_for_each_safe(pos, next, &nn->client_lru) {
>>> @@ -5809,14 +5815,17 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, s=
truct list_head *reaplist,
>>> 			break;
>>> 		if (!atomic_read(&clp->cl_rpc_users))
>>> 			clp->cl_state =3D NFSD4_COURTESY;
>>> -		if (!client_has_state(clp) ||
>>> -				ktime_get_boottime_seconds() >=3D
>>> -				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
>>> +		if (!client_has_state(clp))
>>> 			goto exp_client;
>>> 		if (nfs4_anylock_blockers(clp)) {
>>> exp_client:
>>> -			if (!mark_client_expired_locked(clp))
>>> +			if (!mark_client_expired_locked(clp)) {
>>> 				list_add(&clp->cl_lru, reaplist);
>>> +				reapcnt++;
>>> +			}
>>> +		} else {
>>> +			if (reapcnt < maxreap)
>>> +				goto exp_client;
>>> 		}
>>> 	}
>> Would something like this be more straightforward? I probably
>> didn't get the logic exactly right.
>>=20
>> 		if (!nfs4_anylock_blockers(clp))
>> 			if (reapcnt > maxreap)
>> 				continue;
>=20
> This would not work. If there is no blocker, the client should become
> courtesy client if reaping client is not needed. With this logic, when
> reapcnt =3D=3D maxreap =3D=3D 0 (no reap needed) we still reap the client=
. If
> we change from (reapcnt > maxreap) to (reapcnt >=3D maxreap) then it
> may work. I have to test it out.
>=20
>> exp_client:
>> 		if (!mark_client_expired_locked(clp)) {
>> 			list_add(&clp->cl_lru, reaplist);
>> 			reapcnt++;
>> 		}
>> 	}
>>=20
>> The idea is: once maxreap has been reached, continue walking the
>> LRU looking for clients to convert from ACTIVE to COURTESY, but
>> do not reap any more COURTESY clients that might be found.
>=20
> Right. I'm ok with either logic as long as it works. The clarity of
> the logic does not seem much different to me.

The style I proposed above is more readable to me.
Please go with that.


>>> 	spin_unlock(&nn->client_lock);
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 547f4c4b9668..223659e15af3 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -96,6 +96,8 @@ static ssize_t (*const write_op[])(struct file *, cha=
r *, size_t) =3D {
>>> #endif
>>> };
>>>=20
>>> +#define	NFS4_MAX_CLIENTS_PER_4GB	4096
>> No need for "MAX" in this name.
>=20
> Fix in v2.
>=20
>>=20
>> And, ditto the above comment: move this to a header file.
>=20
> Fix in v2.
>=20
>>=20
>>=20
>>> +
>>> static ssize_t nfsctl_transaction_write(struct file *file, const char _=
_user *buf, size_t size, loff_t *pos)
>>> {
>>> 	ino_t ino =3D file_inode(file)->i_ino;
>>> @@ -1462,6 +1464,8 @@ unsigned int nfsd_net_id;
>>> static __net_init int nfsd_init_net(struct net *net)
>>> {
>>> 	int retval;
>>> +	unsigned long lowmem;
>>> +	struct sysinfo si;
>>> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> Nit: I prefer the reverse christmas tree style. Can you add
>> the new stack variables after "struct nfsd_net *nn ..." ?
>=20
> FIx in v2.
>=20
>>=20
>>=20
>>> 	retval =3D nfsd_export_init(net);
>>> @@ -1488,6 +1492,10 @@ static __net_init int nfsd_init_net(struct net *=
net)
>>> 	seqlock_init(&nn->writeverf_lock);
>>>=20
>>> 	atomic_set(&nn->nfs4_client_count, 0);
>>> +	si_meminfo(&si);
>>> +	lowmem =3D (si.totalram - si.totalhigh) * si.mem_unit;
>> There's no reason to restrict this to lowmem, since we're not
>> using a struct nfs4_client as the target of I/O.
>=20
> From reading the code, my impression is himem is reserved for some
> specific usages and the actual available memory does not account
> for himem area. Few examples, eventpoll_init, fanotify_user_setup,
> etc. These objects are not used for I/O.

There are only a few users of si.totalram that subtract
totalhigh, and those that do need to strictly avoid the
use of high memory, including the ones you mention here.

I'm looking at ttm_global_init(). In there, both the
total amount of memory is computed, and so is DMA32
memory. The comments explain the difference.

Unless I've misunderstood, it isn't necessary to subtract
si.totalhigh for our purpose, so please remove that.


>>> +	nn->nfs4_max_clients =3D (((lowmem * 100) >> 32) *
>>> +				NFS4_MAX_CLIENTS_PER_4GB) / 100;
>> On a platform where "unsigned long" is a 32-bit type, will
>> the shift-right-by-32 continue to work as you expect?
>=20
> I will try unsigned long long, this would work on 32-bit platform.

Actually, using a type that explicitly specifies its
bit-width is even better.


>> Let's try to simplify this computation, because it isn't
>> especially clear what is going on. The math might work a
>> little better if it were "1024 clients per GB" for example.
>=20
> I'm not sure how to make it simpler, open for suggestions.

How about:

	u64 max_clients;

	max_clients =3D (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
	max_clients *=3D NFS4_CLIENTS_PER_GB;
	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);


> Thanks for your quick review!
>=20
> -Dai
>=20
>>=20
>>=20
>>> 	return 0;
>>>=20
>>> --=20
>>> 2.9.5
>>>=20
>> --
>> Chuck Lever

--
Chuck Lever



