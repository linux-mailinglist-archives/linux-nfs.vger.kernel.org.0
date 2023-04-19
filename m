Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BD96E8197
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjDSTBD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSTBC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 15:01:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF030359C
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 12:01:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JESnI3011262;
        Wed, 19 Apr 2023 19:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hEJ45pYyqIVjuIotdG7RrHFpNesrkUYdIcZjbZV6LOw=;
 b=JLkMa+TiwnOhM1HOZ4pZzDAK5en8wGpSjPcXw5zl9EXHHf5TxbCAWviLUiYn/bTdpfIm
 c/zI4qXuJ+8vUQLvF0eYL7ZGe9AktVCS8ZY5sFturRqUzw3ndDPU/SLkRjj5+J83xwNQ
 NT+gW6NcKcop3fxDQvBMFmoRt937N3qvnUhu02z1dyPDdXpeR42xdYNlXYFBVBub6sxH
 MXw+dbKlMK/GS2760/KsnWYMubYGE64kdM27Q6a0OGLskaHr7cMuOltBWndIiwIzcSxx
 CueOoky6d6XrFW/Xbenhd74ZPRXeyiPhgB95+ockQI6l3Zs+kNY9LZuun+i7IQQw3Jnu XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu149p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 19:00:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JJ0ej5037752;
        Wed, 19 Apr 2023 19:00:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcdbvub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 19:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUSQxCdaAgTA1oyl2dn4KLRYeuVsdnw0flEf5SCaW2fgdqtWnXhLcJkf8R1xWKOnAwt4DqKZl1GezlX10F1DDWbA73NfHVxsOpK4KfiQ/l8K39UWUnLDz0Z0m0BB1hvLpBuAX13jAf9pDMTohKZqWFEDAQBgQaLQa1l87X/42wpAv/v1Da+F/eAAhwYTNqXbB22zi8EtfmMp6Ci8Un7jByn06Cwe1P0jCRm0s3FqmY7h0qK+aRiNSANhkYdzSwehklIPrVRZilK+9+D30UdjDTBqN22fhzFPECUx9MTFZZh5j7r+8pZFJ4IVlvtmI8ZFRWHy4VjU5U2HmHaM5cAPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEJ45pYyqIVjuIotdG7RrHFpNesrkUYdIcZjbZV6LOw=;
 b=QVKrUrcC7JDwiaI7oI63GBdwC2gLe29E2JRZRKVth6c1FTWCvhaoPrdQKVlzkGP5te5VgTHK5vxJWPiBpL9sNOTpj+KY5UeqhWlqp/9bn+OnUaKWIx+1hF0dUmFQTYcw7PzLEC0zas/d9wt6cr8xYoPxZrzjwoccvONmrL5kUkl2aUf1jJfLmKuHTvEEZiiQFrNVJd6qCJKZ/qrnzk4eKAHGiQpIPv0WC9nDijH2Y+UOsjFVT2O1SqxU42DGncuWvIMGqG72d9PjpvqPKIE9TVJc4aSA5V/yVZIsDC//4/XcqnPdiKsLvBFIdoHloeMEC1cOgm7Bdh8tJ2HhsHd0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEJ45pYyqIVjuIotdG7RrHFpNesrkUYdIcZjbZV6LOw=;
 b=R2V55bnyim3QeJD9XwzWL7v+VC5KonxTdLnxs8xtCppefiRF8kaVQQh6HHI3U7Qfu8xWtNKwWucuWkWtvnle9BNEaPrQLWd3BsJZflNk5aC+rNGO91gyTkrqlmePFyyRps9aquTQznLJLk588ySZFGFSC3isLh2Esm8I6nqBmBQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 19:00:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 19:00:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in
 infinite loop
Thread-Topic: [PATCH v2] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in
 infinite loop
Thread-Index: AQHZcufaZPKSt4/vs0yxHY08n3/2BK8y7IsAgAAQHAA=
Date:   Wed, 19 Apr 2023 19:00:51 +0000
Message-ID: <9DEF3C9A-9B8B-49C2-83A1-4F3E3E4CB725@oracle.com>
References: <1681926798-13866-1-git-send-email-dai.ngo@oracle.com>
 <b3de8618e1b8d5c06fc1c14cfb4ab687ca63714f.camel@kernel.org>
In-Reply-To: <b3de8618e1b8d5c06fc1c14cfb4ab687ca63714f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5580:EE_
x-ms-office365-filtering-correlation-id: d7e99fc5-ba6f-4086-27ea-08db4108656c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rMd8u9t6MPOMmVQxnmsWXTu6WGREJz0Xclm+CIf34TMFUkgaNLhWqSRle10aGp1ruUs0KUCr1HU1Y+/rsqGdR4fGjBEJxtmuF78Et6WpoOJehySHYuI/aDWpg16qa0n/yXPna6PPWT9CGLpYl7HQ8uqoOsQAGRMh4qCT5R32f8dplWrzSfo08pw3UJ0+ywLQQvaW7LcC31KwCFjwFI5m8371k2IhKTZ67IUKLeYQ6Wk00BO4jejb3472how93BDtX5uLaGPDwLG/udC039/qXJL23cfv/ohwP+rktD9S3kadRLDu8+MCK/9uPpoCHvWuHFYfbQUxpwqTgZmxmkcZNUti+ccg1DyPw3XKx6Cz/cWTmVEassNZVJMFxx9uGOfPLn5DFlQYREFjw8YhCuUxSKRIaQiAfoWj6kxH1QqeCE1s+ZzD7Pt+ftHTbFd9FZKpLuOlM91ixlLrvZWUEXK6MpSumtsHvrN4w9qn3upBsJxqH5Gky0nXUbo/i4E1wWZPaTAesE5YO5xN+koaDsQ0rtuRbEZRW/VNpRM1nu8fn6jJi0JvU1KOegHRIAwCGGOH8gLeuexmIVqvH2e2fdrpNALaWl/9HFuEkTFgvR3ms5fbhUcRva03O/3LX00Bkrjmn7l1zU/O9sYRdQxaAf2MuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(26005)(186003)(110136005)(41300700001)(6506007)(6512007)(66946007)(53546011)(91956017)(86362001)(2616005)(83380400001)(4326008)(316002)(76116006)(64756008)(66446008)(66556008)(66476007)(8936002)(8676002)(2906002)(6486002)(122000001)(33656002)(36756003)(38100700002)(38070700005)(5660300002)(478600001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DggA2SE914ZkL/1tWYq0i5j9LHSMvYSw+2/nknlSv0SirRPFeCJFcs3+ZJ/0?=
 =?us-ascii?Q?UIv8AnPs2uHaO0zrMSgmyMFt/wN556TBngciERhzXr/7b5ZRcdf/yD7FoZAd?=
 =?us-ascii?Q?MBoVH9MgtQ0YRtBdurL8NYnE6YPGhs0F+EARpRpC96+BXidl6uWekbSjqVp0?=
 =?us-ascii?Q?bpTEpYh9eanoKIPCn2NZzQCrUm+Uzi/Vm0SW92IYcozdsry7rV/YRsgRrWLD?=
 =?us-ascii?Q?+vUWuLGPCVBKdlNZPw7/wMd767lV6eppy8ccvsAUdD+4i9vrpFcptUE1UaPT?=
 =?us-ascii?Q?jfTHYX/+uZMHT+L78+nspJ72gfoJNQj/brL7BiRaFur3swIJQCL50JAs/zGD?=
 =?us-ascii?Q?zgImuppuAAfFiGJSYlJGk3nF1JAa1Nvo0VtddwNsDJsqMYKmgu6i8XebLUr9?=
 =?us-ascii?Q?Rv4Z17hX+rl9WwE/VoF5SMZdmkv2eCqFyMGdrpV2txPDmIdkpiWKMeOhX68o?=
 =?us-ascii?Q?AboGQ7Yd2mFBTXH8SfJ7uLdZ2p3GcHHfscn/Nza0MDYiIToTb+6dMyxjms8K?=
 =?us-ascii?Q?sI4v+WZQHId/hwx3Yg9ex+wvFfLXMIC/Jim5Zc962OeIrPDgrOG6YOe9NISw?=
 =?us-ascii?Q?HFe/k0RHG3SkDm/Y7V1+ocaOSlHbNvHMuZhGed1apTzfpO85rcdxpw76FFF4?=
 =?us-ascii?Q?ipVHlwRbSV7xjX2uclBxy8o57krEYE4jp/q/ZwrLrZwIAUFRJPPD5tD/mp/D?=
 =?us-ascii?Q?jpRJxTWe7PqAUckl8n0/V2R2dwSZRSHb5OZZlBZMi9MtpbIRgSsp9bCrqc0z?=
 =?us-ascii?Q?/3top6LITHwwwwzeyKq9eKt6L1QmtlF84I5R91rlXczqT1JNfoZdVbDcMXZ4?=
 =?us-ascii?Q?I/2o7jIeb45/Yh8gZCyT5l85ljh3bvO2yMAaoIOlbBNeLKzCAN2IOUqjedQA?=
 =?us-ascii?Q?4ghpMYkCDC3rlqhDLMJzb+ui8YX8r6eGEzl8XFZjhiWxM0dqoCG2pbn8WzRk?=
 =?us-ascii?Q?HsgUg4QGNjVfDl4vzIIoViuyM8y17TAIDvyZagKYzGRaaOtLT6839CJwePPR?=
 =?us-ascii?Q?2vmNn65VgESNsIeroVHfWe4lZ/cnujubxnUJhAI3RzU0iNiCUYTh3fmNqbOU?=
 =?us-ascii?Q?oZ/S4v94Ztx3uV7FCVEu/R4IFgQ0nlnnQ+wi2JEItOhDM9yAf/Ex77h3uw28?=
 =?us-ascii?Q?G9irwfhu6yHheIU0vaV1Y0ZZiPZfAVN7X0iJ6vpOvtNttdS2oR1TL3kccFY5?=
 =?us-ascii?Q?6VhK96XqcOOyZhla+K5yTqn8ru1Setm7+u8laZlsEBqlHEh2Hv/R+PHNyclj?=
 =?us-ascii?Q?RA5LAJETtNsKMbnuYwy5/nXzJL2whps6U4BMTlK5zh/9ifuzFKfXxeouMVrg?=
 =?us-ascii?Q?8y0VgeDj3nj+QnAsTKwl11186jyieneaN8jJpmHsHwdTu/aQ6+1CwC+Hx40R?=
 =?us-ascii?Q?L+Zfd9XXCaBo4omJ6CTvhWSc1JarG226P/61MWum45rJjXvjYcQ/hdqvYhKL?=
 =?us-ascii?Q?9YHWRW9vvvPZ83f0u4ERGW5Vwc0+8ViLCk9syJ32RLOmwH5azO3u/yzr3D8V?=
 =?us-ascii?Q?OwKQ054ju4Uyoc9BiR26HlC6dY8hIxv67uQcTfBgI1Z128z14WtbDj/JKIpV?=
 =?us-ascii?Q?Giayjw8kYpwXl1+f4msL3qZcyGqWyNbUfaO8M0LF2nzoRxwMXDeCMUnddQ/k?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD4CB74DF324654B99CAE273EBA787D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /OJhjm7OcuvU+BkcDfDMT7HXVc7IsH94aqXu7uvgvDVX4FaTWhfk2zpNTZqHttWcD5Z7P0/SoCe7BIUn7xMzt6P68ipreCO6pCydp8HdTWJUwhTia+cAUqjM6bVGzJnrHDPvy8wqRCiTUkT8p54ypTyXEjMo8hsmBWtHAyaXoeLuWTVBIJPM/a4ULE0zXvo7MSiR+WEk2u6QLG19guQasRC7Ez/XekyAFe5V43MSJGAkgQ+cQ/Hfn1+fAHuPUkv7O81gfvUudms2AQP47bgspji8dWfOqMpjcUCq32E8Ogk4wQu+ngs/fLrKVnbDH3x44bNMMVPqoKhr69lTzEifPij3M+Mnia6I6RqDR9jFxWMzVxwY7VQmBqM409o/1T7mcenU7wb4/4o8h5I4ftzmswpqMQa7hlPV53M/3IBrekTlKDcIoiW0CRf2d5YlGX3tXnrjWIIiGt5m7tcIPZgqEuScCzNsXxSshtXCreKrRuvAq/vsQaP24BQM+Zj8kZdrvYOz5UTLWI3Pfc5b4trS5+P0mrAx/Qc1OdnSsZ0lHoaxYNdVyckIZVP3RHTE6lABsZWJAZfWNobvAdKuhO/H5N3sLqfV2/iA10GlzfYkTdnI1WTURlEI3ifOPDU/EAVEVqrF7171m/7Q1dk+vbVX0qC+Rt7czKJwdfBERfxLwtAv3MIYYffe97rXAqnr67i45eA9uQeQxtMLg8oTQ8UV8JTInAGT9vONvdLUYJi6vZsIe1BuUCslqtcNuU14yE2ptKrpAWdhCNBSyS2h/c7NTTBYqQdEjNu4G38j/EXY5o0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e99fc5-ba6f-4086-27ea-08db4108656c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 19:00:51.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtMhH/Mi6ghy+LuedwLeQ375bHsysscWkuCNBuindUz1SmsxDj9JFMKcQZ2VavmwGgw6w3j07eySl+WHnzFD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190167
X-Proofpoint-GUID: V-QZKVi0bwMnvWwqTA3r6IWsmpP4U2kw
X-Proofpoint-ORIG-GUID: V-QZKVi0bwMnvWwqTA3r6IWsmpP4U2kw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Apr 19, 2023, at 2:03 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-04-19 at 10:53 -0700, Dai Ngo wrote:
>> The following request sequence to the same file causes the NFS client an=
d
>> server getting into an infinite loop with COMMIT and NFS4ERR_DELAY:
>>=20
>> OPEN
>> REMOVE
>> WRITE
>> COMMIT
>>=20
>> Problem reported by recall11, recall12, recall14, recall20, recall22,
>> recall40, recall42, recall48, recall50 of nfstest suite.
>>=20
>> This patch restores the handling of race condition in nfsd_file_do_acqui=
re
>> with unlink to that prior of the regression.
>>=20
>> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/filecache.c | 2 --
>> 1 file changed, 2 deletions(-)
>>=20
>> V2: rebase with nfsd-next
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index f40d8f3b35a4..ee9c923192e0 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -1099,8 +1099,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>>  * then unhash.
>>  */
>> if (status !=3D nfs_ok || inode->i_nlink =3D=3D 0)
>> - status =3D nfserr_jukebox;
>> - if (status !=3D nfs_ok)
>> nfsd_file_unhash(nf);
>> clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>> if (status =3D=3D nfs_ok)
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks, applied to nfsd-next.


--
Chuck Lever


