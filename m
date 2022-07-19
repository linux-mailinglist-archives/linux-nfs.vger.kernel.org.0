Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994ED57A902
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 23:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiGSVb6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiGSVb6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 17:31:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C46550703
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 14:31:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JK15Wg003844;
        Tue, 19 Jul 2022 21:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Sf+e4ohBrMz6CR544Kr1Krm1VcADMs2nnqJg2NXD6Dk=;
 b=C+hTACpODe9pDlkyVQz27qKdgutz+c+jXL3aMlPQzqu1KYOmwaLVkIyLonzyJjj986AC
 SkN3LDZFMYoIObLwCntCqNoDy6Luoe9qmKKuPrjrOVLAnHDXBCaX6tNrsW7fco0HDasC
 ITVSpR0lAp5YI+ervpGoVDHNfpEYhupRUteZi0RO0sP/GEtsTqsNz41Bk3fZeOCCFrxi
 zl14tLtgXkZUetjFHK6P9HUswIcg/dX4LxKYhZ3WXEfj9EwiMkx3CISj/h8+h42Xzcth
 27/s1fwqdjZttojNYeX8ynxnllZ5Pvt4/0SZl3dqj0+3KMSr1zSy9ok8y5SY7wHNLW3j aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs7qyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 21:31:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JL6R13002792;
        Tue, 19 Jul 2022 21:31:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbgxh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 21:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKZIme0rNDt8FoeHvZb0/0r4an4g3KIA8SayqCFMAjm2NJNxVm338Ri+MyE2iLQ9qoTGQXlonoD0qr6WrdxwbVfmhu8sxAdG20CkuPDuCQYACsMfLpTyjwrDxBlJJtFEOhrLpZCFEjlfX4tEuex6WSpuucX+qLAEve9bsTzfxJUFtwRwya5c4FlDLhkG04U+wulVWizbioW5ua+kS34GvcIst6i4052+Fja3Qty1zF7d7yXb8gnqBGixTTp5uGBeaTXi3z+V8xg0TtgTDo95asDEXh54udGimpi8WEqQMDW5skiyM087LRDaaBsPsxbry6ktQmAO8tUGFtvaQWWXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf+e4ohBrMz6CR544Kr1Krm1VcADMs2nnqJg2NXD6Dk=;
 b=ff2/5FbhtMhjhctxZG4PHt719UHvog/OyAL6qELGXD1PRXxNXoIm/iTqJtwEY3uL5kOX8Asil8/ORut6vXxAP+V5EPhzgaTezbbbkMRQKzBLak+v9Ngr8BxqNim+PwdKzvEQKTyKZEK4OeK4Mbi+wWR8zOwGVDYyNIRE9tRYZASWTKH6l6ubEQkgIASf1aJFkoiHQwBXu/JZzbqtQOJLytfJzJdnjUkvNv70ondh/yGUOrNLInKK3L8T3deGdTTgvPpMOD6X+CVmIL3FtToB437NMSPUFGvgWPY7dQlpqSunTI27SrXT0GMfL4vZOyCx2W9+UBsuFLuA0x5kenmy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf+e4ohBrMz6CR544Kr1Krm1VcADMs2nnqJg2NXD6Dk=;
 b=hybjBIRvyBy++k761uARhw8L1+aYDVUKDQQuf+fbh5z9xLJ4J+YU+Ak09G38rcCqWORA6CnGE96o4dGd1fKAWjy/zgJ72hTceTlu7Qbc0an4X/28U7jKjhCwgB/6Sz8gc4dMCw9Mg3V8XoOte3uNS1fPIJtlTt3l6TdS3Ik/FIw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3769.namprd10.prod.outlook.com (2603:10b6:5:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 21:31:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 21:31:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2 12/15] SUNRPC: Add RPC-with-TLS support to xprtsock.c
Thread-Topic: [PATCH v2 12/15] SUNRPC: Add RPC-with-TLS support to xprtsock.c
Thread-Index: AQHYebV3Vr5cWhX+5kKTJwpwECEoba2E0WYAgAGo9wA=
Date:   Tue, 19 Jul 2022 21:31:23 +0000
Message-ID: <C8167902-5966-4EEC-BB89-C30DFCD849E4@oracle.com>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <165452710606.1496.14773661487729121787.stgit@oracle-102.nfsv4.dev>
 <83cba112994dce59b6d7c7f7cea28e37b3a22d2c.camel@kernel.org>
In-Reply-To: <83cba112994dce59b6d7c7f7cea28e37b3a22d2c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe594bb0-db12-40f9-f6c2-08da69ce072c
x-ms-traffictypediagnostic: DM6PR10MB3769:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoPgGqyGZNp4oGOVZM94JDcHlRX+oidMArQ+pLWpaSv5MJ/Gb9BlGanQTTpCnjR2997M3Y82Gp+Y10csG28t8c/Xb6dECYwsz+/DMwtEF/kNKC3Uc5zE/ldUuAb0C//314dfh9F/DX/j9aRLWzg9Tjfi+/Aio+lb2whkRWmS1NrgBfONBOEhEyGXPZ9mjXgj9qQAbIm8zMq4OJXKJcqyTpxKi4eyUuYk0yq/K3pcdcH/WOiEHPyp1kPC4wj9Jw9IPZ78e933Bdcmfb7AzJWsCidaobnCM3r+a8vBqXGCbiGiqNcIP+pOsu3rKCNWSXsDrY2NahgMPwyr5kyhaOxhjFSZ86cbL8/ordyQeUk0vYBIvP9fKIYIhb0OEbAsiXrkX+k8VuSWNZShsYF7FuS90mTgXLzlu2xuBRIL8upni/h3ogiz3Rrq9C54DDLRCM/bJZVMrLWibJ9sp52aXmRw76wCDGsemowWcNjL/c4tQc7ucgvN5IRVsnNhmsmbceZwjczVGC02tcfErZ+eRuBsJXhPniYdsXOQb1vHgyVUZKHFv75XpPufXzRcRfpO4rMjgagGqaK9qzL2+lRcrV0u2sz251FuxYqhe27Q7wy35egPCThZdcA2VCNcBFX+U6apzYRnTr4z9I2oGbe2e6Xb68zcPbva6Ph9hUBOKKFaZ/TCyhivnPuCqBPDUd8E+hwm2AR7G4Ycunhh4ofa5aR+F+YCoj67znG8w96sgTBBZdPswdQd5IgrTnpvSnVrNHdIVmlJFbmznpsQ1KG7oZRO80qsKgl5QPehuKtJbf+ujS+U7vEa9lLIYd+fEp5JTQdGyinaaHTTfSeYBPC8EloQ6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(396003)(376002)(2616005)(122000001)(6512007)(41300700001)(186003)(2906002)(6486002)(478600001)(26005)(83380400001)(30864003)(71200400001)(5660300002)(66556008)(64756008)(76116006)(38100700002)(38070700005)(66476007)(8936002)(33656002)(8676002)(66946007)(6916009)(53546011)(66446008)(4326008)(91956017)(86362001)(54906003)(6506007)(316002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QmDkzBuYRoxmKjBwQ2DuEU/shK4zwfEF7svSL+qmruA+zz6f74IcS/8n7u5Q?=
 =?us-ascii?Q?/fZhQZfFLz30TpnIqvC+oyNm+mv5RGmI1Gcwx5X8ScfLvjt8BPjHJe8s4HKo?=
 =?us-ascii?Q?WN+K4WFfeFCYtdggIqmAOiid0BvAgPG/A0dB8gB2PQePhAt0kc4Yxgimx2jD?=
 =?us-ascii?Q?xdduNQmouZqmpRlrQBfZQhM2YxLwRHF4ZfHJsz9cY80+SkU9UWroqIZT6+Lx?=
 =?us-ascii?Q?DUtcTrUK7EVWuJWo3vneqJ+4a+klOXlPvukg4DPtiAx2I7KIC5yh+V06b/lc?=
 =?us-ascii?Q?C0x34ETf60gHcTjoZRbSy46siUSHTPWPGQ9OSMTBBXUspUUvzyZKxM3yXIaz?=
 =?us-ascii?Q?nIo/gA3hzBUhMA4OJWu6+OHYyKlczAEklQv+DKD890YC0X4P3JJAs0VtGpvf?=
 =?us-ascii?Q?CCm4XGa4JT1e4UqUwQiU/vdMhUpcS5i/mgp2qsLC90JvO2DgFaLqH6MRHZ7f?=
 =?us-ascii?Q?JlVrRd0Tdh1d30At2UIRciu498K8NOe5tzG0PRi0iNOA69XRWjf0rU8ALAHM?=
 =?us-ascii?Q?KeV+6B4IyqeSqCA6Ffpto6ksQgHUE+xisAE1iKVveSn5tm+yawgDzDSFoL4W?=
 =?us-ascii?Q?LemRaA+RXIgPG8+vGb0PMAvdFbBMydDn72neWaQI3ynIRtZzbRUyVov3bz46?=
 =?us-ascii?Q?7WB3Jv6pdDGNZKiZEz5kdKMYkDtNxSmwzZ8TrScVvOQ/07SkPEiYBXdOxsfi?=
 =?us-ascii?Q?KOj3iauyCDASv5Iy+fwrK/iIXfWYQgWRj7rZFzhLLVP60I+EPWDfrzA8Rqgf?=
 =?us-ascii?Q?iqwcyM22aUSM+jdHX1y6WEGZz/XlUdYCNkI+wNjoVbXBtLx/xJwm0glCrLwf?=
 =?us-ascii?Q?nUQcMvtY4krBSySqpuwZbS153cFYTk7FGmfdDUK0cs5rJDic2PDHZWWJTmGv?=
 =?us-ascii?Q?4IPYWdsddw5bzSyS+H/Na4idgWpR9evM5x4+WcDTR3cyrn6LQ/QZClXLjAcY?=
 =?us-ascii?Q?tuY9z4tC5smNHPQL0fNrT1RlY/fqe1UMK2PA6xS5ikWAKDJZr+pYbqQVC+ur?=
 =?us-ascii?Q?+BA+GrxgnbeuWmxTEld6s6JTtp8qD3KEEA1R83KD7PTagKXGynMUCVEhKi+U?=
 =?us-ascii?Q?aSu0LlEC6lbdKZCDO95IQimgpJIFBc/zZHcbXX/p+L/qKjD4QRk7FeJrziUa?=
 =?us-ascii?Q?26R9aHHxvrOb3wRKUEnCiqdvcprCwWREA8VxQSOm21kYg65vfOpNRcYH3N87?=
 =?us-ascii?Q?yMB8aCGVicpYLhjbH7q1DvUEJn/oUUVjwotE/xtXeWXW/kskkqbAraNMNC2u?=
 =?us-ascii?Q?WCMVvOVXXgHqp5fAT0mU9yqUdTcy6O3dM/KhMV01IbGF9oeXycV5dYgM76MA?=
 =?us-ascii?Q?WIOSquZXMx+G48WtgtMJPtvgd6HaYsl0PsKWMXyDpcb/KHKYYubjGP7MR4Ph?=
 =?us-ascii?Q?B193+UgKSJyLMfgJZuSRvwm0QlU3lE2i/7U9Igrib5Bpgk5B6+/ANpbCj233?=
 =?us-ascii?Q?pR4JB07UtLAifsU95/SFocQPSIzqDhsdXezuV3sNbvZ3NONELHSgMxRpeKWh?=
 =?us-ascii?Q?gMmV5ouZ13rrQAMArdFZjJT6lJKKkhH+isTPyKzEF+D13E+/IcWOXsZhS2aR?=
 =?us-ascii?Q?cwJ5Ea64sKXwkvWxzQ/Q77A+feaDQ5CnuidzDMHAOz/WrzL8pGw/aOiPbK4w?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0756B1558846A645AFD480B8884C0B78@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe594bb0-db12-40f9-f6c2-08da69ce072c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 21:31:23.0288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYhMi4euRhA/MLGWI3qIf9Ec+0YjeLyxaWtBtDttc3PE2X3II0RpFsELyfCNMExvWv5kL/oOLRaQiZ7WMjNGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190089
X-Proofpoint-GUID: DKYpEZ-PDMWRhsqS5apWcb2MhbVRYprS
X-Proofpoint-ORIG-GUID: DKYpEZ-PDMWRhsqS5apWcb2MhbVRYprS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 18, 2022, at 4:10 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-06-06 at 10:51 -0400, Chuck Lever wrote:
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/xprtsock.h |    1=20
>> net/sunrpc/xprtsock.c           |  243 ++++++++++++++++++++++++++++++++-=
------
>> 2 files changed, 201 insertions(+), 43 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprt=
sock.h
>> index e0b6009f1f69..eaf3d705f758 100644
>> --- a/include/linux/sunrpc/xprtsock.h
>> +++ b/include/linux/sunrpc/xprtsock.h
>> @@ -57,6 +57,7 @@ struct sock_xprt {
>> 	struct work_struct	error_worker;
>> 	struct work_struct	recv_worker;
>> 	struct mutex		recv_mutex;
>> +	struct completion	handshake_done;
>> 	struct sockaddr_storage	srcaddr;
>> 	unsigned short		srcport;
>> 	int			xprt_err;
>> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
>> index a4fee00412d4..63fe97ede573 100644
>> --- a/net/sunrpc/xprtsock.c
>> +++ b/net/sunrpc/xprtsock.c
>> @@ -48,6 +48,7 @@
>> #include <net/udp.h>
>> #include <net/tcp.h>
>> #include <net/tls.h>
>> +#include <net/tlsh.h>
>>=20
>> #include <linux/bvec.h>
>> #include <linux/highmem.h>
>> @@ -197,6 +198,11 @@ static struct ctl_table sunrpc_table[] =3D {
>>  */
>> #define XS_IDLE_DISC_TO		(5U * 60 * HZ)
>>=20
>> +/*
>> + * TLS handshake timeout.
>> + */
>> +#define XS_TLS_HANDSHAKE_TO    (20U * HZ)
>> +
>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>> # undef  RPC_DEBUG_DATA
>> # define RPCDBG_FACILITY	RPCDBG_TRANS
>> @@ -1254,6 +1260,8 @@ static void xs_reset_transport(struct sock_xprt *t=
ransport)
>> 	if (atomic_read(&transport->xprt.swapper))
>> 		sk_clear_memalloc(sk);
>>=20
>> +	/* TODO: Maybe send a TLS Closure alert */
>> +
>> 	kernel_sock_shutdown(sock, SHUT_RDWR);
>>=20
>> 	mutex_lock(&transport->recv_mutex);
>> @@ -2424,6 +2432,147 @@ static void xs_tcp_setup_socket(struct work_stru=
ct *work)
>>=20
>> #if IS_ENABLED(CONFIG_TLS)
>>=20
>> +/**
>> + * xs_tls_handshake_done - TLS handshake completion handler
>> + * @data: address of xprt to wake
>> + * @status: status of handshake
>> + *
>> + */
>> +static void xs_tls_handshake_done(void *data, int status)
>> +{
>> +	struct rpc_xprt *xprt =3D data;
>> +	struct sock_xprt *transport =3D
>> +				container_of(xprt, struct sock_xprt, xprt);
>> +
>> +	transport->xprt_err =3D status ? -EACCES : 0;
>> +	complete(&transport->handshake_done);
>> +	xprt_put(xprt);
>> +}
>> +
>> +static int xs_tls_handshake_sync(struct rpc_xprt *xprt, unsigned int xp=
rtsec)
>> +{
>> +	struct sock_xprt *transport =3D
>> +				container_of(xprt, struct sock_xprt, xprt);
>> +	int rc;
>> +
>> +	init_completion(&transport->handshake_done);
>> +	set_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state);
>> +
>> +	transport->xprt_err =3D -ETIMEDOUT;
>> +	switch (xprtsec) {
>> +	case RPC_XPRTSEC_TLS_X509:
>> +		rc =3D tls_client_hello_x509(transport->sock,
>> +					   xs_tls_handshake_done, xprt_get(xprt),
>> +					   TLSH_DEFAULT_PRIORITIES, TLSH_NO_PEERID,
>> +					   TLSH_NO_CERT);
>> +		break;
>> +	case RPC_XPRTSEC_TLS_PSK:
>> +		rc =3D tls_client_hello_psk(transport->sock, xs_tls_handshake_done,
>> +					  xprt_get(xprt), TLSH_DEFAULT_PRIORITIES,
>> +					  TLSH_NO_PEERID);
>> +		break;
>> +	default:
>> +		rc =3D -EACCES;
>> +	}
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc =3D wait_for_completion_interruptible_timeout(&transport->handshake=
_done,
>> +						       XS_TLS_HANDSHAKE_TO);
>=20
> Should this be interruptible or killable? I'm not sure we want to give
> up on a non-fatal signal, do we? (e.g. SIGCHLD).
>=20
> Actually...it looks like this function always runs in workqueue context,
> so this should probably just be wait_for_completion...or better yet,
> consider doing this asynchronously so we don't block a workqueue thread.

This code is similar to rpcrdma_create_id(), which IIRC also runs in
a workqueue thread and has been this way for many years.

If one is wrong, the other is too. But I see recently merged code (in
drivers/nvme/rdma/host.c) that does exactly the same.

<shrug> I'm not married to the approach used in the patch, but it
doesn't seem strange to me.


>> +	if (rc < 0)
>> +		goto out;
>> +
>> +	rc =3D transport->xprt_err;
>> +
>> +out:
>> +	xs_stream_reset_connect(transport);
>> +	clear_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state);
>> +	return rc;
>> +}
>> +
>> +/*
>> + * Transfer the connected socket to @dst_transport, then mark that
>> + * xprt CONNECTED.
>> + */
>> +static int xs_tls_finish_connecting(struct rpc_xprt *src_xprt,
>> +				    struct sock_xprt *dst_transport)
>> +{
>> +	struct sock_xprt *src_transport =3D
>> +			container_of(src_xprt, struct sock_xprt, xprt);
>> +	struct rpc_xprt *dst_xprt =3D &dst_transport->xprt;
>> +
>> +	if (!dst_transport->inet) {
>> +		struct socket *sock =3D src_transport->sock;
>> +		struct sock *sk =3D sock->sk;
>> +
>> +		/* Avoid temporary address, they are bad for long-lived
>> +		 * connections such as NFS mounts.
>> +		 * RFC4941, section 3.6 suggests that:
>> +		 *    Individual applications, which have specific
>> +		 *    knowledge about the normal duration of connections,
>> +		 *    MAY override this as appropriate.
>> +		 */
>> +		if (xs_addr(dst_xprt)->sa_family =3D=3D PF_INET6) {
>> +			ip6_sock_set_addr_preferences(sk,
>> +				IPV6_PREFER_SRC_PUBLIC);
>> +		}
>> +
>> +		xs_tcp_set_socket_timeouts(dst_xprt, sock);
>> +		tcp_sock_set_nodelay(sk);
>> +
>> +		lock_sock(sk);
>> +
>> +		/*
>> +		 * @sk is already connected, so it now has the RPC callbacks.
>> +		 * Reach into @src_transport to save the original ones.
>> +		 */
>> +		dst_transport->old_data_ready =3D src_transport->old_data_ready;
>> +		dst_transport->old_state_change =3D src_transport->old_state_change;
>> +		dst_transport->old_write_space =3D src_transport->old_write_space;
>> +		dst_transport->old_error_report =3D src_transport->old_error_report;
>> +		sk->sk_user_data =3D dst_xprt;
>> +
>> +		/* socket options */
>> +		sock_reset_flag(sk, SOCK_LINGER);
>> +
>> +		xprt_clear_connected(dst_xprt);
>> +
>> +		dst_transport->sock =3D sock;
>> +		dst_transport->inet =3D sk;
>> +		dst_transport->file =3D src_transport->file;
>> +
>> +		release_sock(sk);
>> +
>> +		/* Reset src_transport before shutting down its clnt */
>> +		mutex_lock(&src_transport->recv_mutex);
>> +		src_transport->inet =3D NULL;
>> +		src_transport->sock =3D NULL;
>> +		src_transport->file =3D NULL;
>> +
>> +		xprt_clear_connected(src_xprt);
>> +		xs_sock_reset_connection_flags(src_xprt);
>> +		xs_stream_reset_connect(src_transport);
>> +		mutex_unlock(&src_transport->recv_mutex);
>> +	}
>> +
>> +	if (!xprt_bound(dst_xprt))
>> +		return -ENOTCONN;
>> +
>> +	xs_set_memalloc(dst_xprt);
>> +
>> +	if (!xprt_test_and_set_connected(dst_xprt)) {
>> +		dst_xprt->connect_cookie++;
>> +		clear_bit(XPRT_SOCK_CONNECTING, &dst_transport->sock_state);
>> +		xprt_clear_connecting(dst_xprt);
>> +
>> +		dst_xprt->stat.connect_count++;
>> +		dst_xprt->stat.connect_time +=3D (long)jiffies -
>> +					   dst_xprt->stat.connect_start;
>> +		xs_run_error_worker(dst_transport, XPRT_SOCK_WAKE_PENDING);
>> +	}
>> +	return 0;
>> +}
>> +
>> /**
>>  * xs_tls_connect - establish a TLS session on a socket
>>  * @work: queued work item
>> @@ -2433,61 +2582,70 @@ static void xs_tls_connect(struct work_struct *w=
ork)
>> {
>> 	struct sock_xprt *transport =3D
>> 		container_of(work, struct sock_xprt, connect_worker.work);
>> +	struct rpc_create_args args =3D {
>> +		.net		=3D transport->xprt.xprt_net,
>> +		.protocol	=3D transport->xprt.prot,
>> +		.address	=3D (struct sockaddr *)&transport->xprt.addr,
>> +		.addrsize	=3D transport->xprt.addrlen,
>> +		.timeout	=3D transport->xprtsec_clnt->cl_timeout,
>> +		.servername	=3D transport->xprt.servername,
>> +		.nodename	=3D transport->xprtsec_clnt->cl_nodename,
>> +		.program	=3D transport->xprtsec_clnt->cl_program,
>> +		.prognumber	=3D transport->xprtsec_clnt->cl_prog,
>> +		.version	=3D transport->xprtsec_clnt->cl_vers,
>> +		.authflavor	=3D RPC_AUTH_TLS,
>> +		.cred		=3D transport->xprtsec_clnt->cl_cred,
>> +		.xprtsec	=3D RPC_XPRTSEC_NONE,
>> +	};
>> +	unsigned int pflags =3D current->flags;
>> 	struct rpc_clnt *clnt;
>> +	struct rpc_xprt *xprt;
>> +	int status;
>>=20
>> -	clnt =3D transport->xprtsec_clnt;
>> -	transport->xprtsec_clnt =3D NULL;
>> +	if (atomic_read(&transport->xprt.swapper))
>> +		current->flags |=3D PF_MEMALLOC;
>> +
>> +	xs_stream_start_connect(transport);
>> +
>> +	clnt =3D rpc_create(&args);
>> 	if (IS_ERR(clnt))
>> 		goto out_unlock;
>> +	rcu_read_lock();
>> +	xprt =3D xprt_get(rcu_dereference(clnt->cl_xprt));
>> +	rcu_read_unlock();
>>=20
>> -	xs_tcp_setup_socket(work);
>> +	status =3D xs_tls_handshake_sync(xprt, transport->xprt.xprtsec);
>> +	if (status)
>> +		goto out_close;
>>=20
>> +	status =3D xs_tls_finish_connecting(xprt, transport);
>> +	if (status)
>> +		goto out_close;
>> +	trace_rpc_socket_connect(&transport->xprt, transport->sock, 0);
>> +
>> +	xprt_put(xprt);
>> 	rpc_shutdown_client(clnt);
>>=20
>> out_unlock:
>> +	xprt_unlock_connect(&transport->xprt, transport);
>> +	current_restore_flags(pflags, PF_MEMALLOC);
>> +	transport->xprtsec_clnt =3D NULL;
>> 	return;
>> -}
>>=20
>> -static void xs_set_xprtsec_clnt(struct rpc_clnt *clnt, struct rpc_xprt =
*xprt)
>> -{
>> -	struct sock_xprt *transport =3D container_of(xprt, struct sock_xprt, x=
prt);
>> -	struct rpc_create_args args =3D {
>> -		.net		=3D xprt->xprt_net,
>> -		.protocol	=3D xprt->prot,
>> -		.address	=3D (struct sockaddr *)&xprt->addr,
>> -		.addrsize	=3D xprt->addrlen,
>> -		.timeout	=3D clnt->cl_timeout,
>> -		.servername	=3D xprt->servername,
>> -		.nodename	=3D clnt->cl_nodename,
>> -		.program	=3D clnt->cl_program,
>> -		.prognumber	=3D clnt->cl_prog,
>> -		.version	=3D clnt->cl_vers,
>> -		.authflavor	=3D RPC_AUTH_TLS,
>> -		.cred		=3D clnt->cl_cred,
>> -		.xprtsec	=3D RPC_XPRTSEC_NONE,
>> -		.flags		=3D RPC_CLNT_CREATE_NOPING,
>> -	};
>> -
>> -	switch (xprt->xprtsec) {
>> -	case RPC_XPRTSEC_TLS_X509:
>> -	case RPC_XPRTSEC_TLS_PSK:
>> -		transport->xprtsec_clnt =3D rpc_create(&args);
>> -		break;
>> -	default:
>> -		transport->xprtsec_clnt =3D ERR_PTR(-ENOTCONN);
>> -	}
>> -}
>> -
>> -#else
>> -
>> -static void xs_set_xprtsec_clnt(struct rpc_clnt *clnt, struct rpc_xprt =
*xprt)
>> -{
>> -	struct sock_xprt *transport =3D container_of(xprt, struct sock_xprt, x=
prt);
>> +out_close:
>> +	xprt_put(xprt);
>> +	rpc_shutdown_client(clnt);
>>=20
>> -	transport->xprtsec_clnt =3D ERR_PTR(-ENOTCONN);
>> +	/* xprt_force_disconnect() wakes tasks with a fixed tk_status code.
>> +	 * Wake them first here to ensure they get our tk_status code.
>> +	 */
>> +	xprt_wake_pending_tasks(&transport->xprt, status);
>> +	xs_tcp_force_close(&transport->xprt);
>> +	xprt_clear_connecting(&transport->xprt);
>> +	goto out_unlock;
>> }
>>=20
>> -#endif /*CONFIG_TLS */
>> +#endif /* CONFIG_TLS */
>>=20
>> /**
>>  * xs_connect - connect a socket to a remote endpoint
>> @@ -2520,8 +2678,7 @@ static void xs_connect(struct rpc_xprt *xprt, stru=
ct rpc_task *task)
>> 	} else
>> 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
>>=20
>> -	xs_set_xprtsec_clnt(task->tk_client, xprt);
>> -
>> +	transport->xprtsec_clnt =3D task->tk_client;
>> 	queue_delayed_work(xprtiod_workqueue,
>> 			&transport->connect_worker,
>> 			delay);
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



