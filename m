Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0745CC59
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhKXSqn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 13:46:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242758AbhKXSqm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Nov 2021 13:46:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOHWvSO031496;
        Wed, 24 Nov 2021 18:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nUgNn1rZRupuD4CSFRqo/UfMngLHd4IeHM/GCGTf6ts=;
 b=pwEVAJPs8LDZgu60YPJt8GwNRs4uQM7XOwj4WKCz4CrbpaYhl18cmaQHO/VK9AyDzK8m
 yIO65digcnUvEepASNYnjhxf/3jALGs1iRjQAI+oVLGe7ilHf4Vt2fe0qbkylhNWorUY
 re5KFYHr7aeGvdvBaTrD8uuNKogKOTs/fj3ZUS7Xn5vXHFDloYJMRYzFpWxpqVEKidkW
 5L6AwndPy+fLih3RZPYJiHkYj2ywdG1pgMb09FpS7U7qrhCxFrKY1B4YpBGrsfqrNdqN
 HTlAfbdEBhzWDvkR/uUiGGtpBkltfkBcYjpW97Jxu32dDlz2arkHBqjUmO+l3T4A/GUj qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chpeesrbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 18:43:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AOIf9b6074358;
        Wed, 24 Nov 2021 18:42:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3030.oracle.com with ESMTP id 3cep525jqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 18:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E541jMpXBRmMx8ZmxtWiVpgTcMps/zkTTrbak79q7lHeXniRZUPEux3MtrmX+4Yr1g2P06rqoXGbGRUim3trjx+W0OOo6cDSG8xIOkCRcqfYjV0Sj1lLuDepj5Bg8kOp8qG6GDXnJsdwK/qjNij9q6VLSwjLZIu/lSjhypFc2QlZeGdS1M73ka8JBFV0275ytZvrTTotR/787fRLqpjrc3zsQMDVWlZP461sziAY8Sw/6+/4BQ4egQ7e/lE0ZAlW9H+B3PByZyTelx9SbrIUaJP+5ifhefZx69YEADSOCgB+6hS8kg0avbVqp5fVAkfe6k/UiOzlUI5ZiXoRdaqGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUgNn1rZRupuD4CSFRqo/UfMngLHd4IeHM/GCGTf6ts=;
 b=GauTcXh0ueE16iPFS+PU+0hM+vHMG5xFA5r+gnOF4nFdxgEII9XZNKzwoU3+F7yUtHVKQ2SDDg1j1MA1iZNQ8JTCTrP6CdXLtcrCRzP7EUdxxKWT8cT5VHyXKNCgal7xPYNTX/BF1hlTJcjkQ1qZjwtjQ1bmykRA/xQa+ocoS2562B9yZjmCA8qHR258sOuDyadJgpd9ank9IMYgLQZZI2NBrmFe0+gIb2Jo2vUngEeGwG7vkCoJWL4OGb02ahODPdjDTXA20W9H3y5qo+2Tg3uzK37Povhu9cXO9Mx+pH3Ai5an8Mo0wA3zWvJGR3p88OE8DKAR0fFTF4XmMvsqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUgNn1rZRupuD4CSFRqo/UfMngLHd4IeHM/GCGTf6ts=;
 b=F6cff/nFZ0o5vaKJT13zOLrcBqHV5oxSEq5FgF+Jx7MECQDXBgbVh3NyR+bqyekRRuW8L7tgpzskP38sy4Kh9V5ETz5qQAITKvoA2r6Z7BhdLplIhtx2TjRLRPbDNw9hmXdDERwDts6THDyJudLCfwfq8NiTXDH33vITYrLBBBQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5533.namprd10.prod.outlook.com (2603:10b6:a03:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 18:42:52 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 18:42:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH 00/19 v2] SUNRPC: clean up server thread management
Thread-Topic: [PATCH 00/19 v2] SUNRPC: clean up server thread management
Thread-Index: AQHX4AnGpZ1rZjrB+EqrNrOLDJYL8awRMq8AgAHTaIA=
Date:   Wed, 24 Nov 2021 18:42:52 +0000
Message-ID: <1552D77D-45F9-43F1-B9B7-E2B68AB54A17@oracle.com>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
 <20211123144956.GA8978@fieldses.org>
In-Reply-To: <20211123144956.GA8978@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7a07a95-59db-481d-5ec3-08d9af7a38bf
x-ms-traffictypediagnostic: SJ0PR10MB5533:
x-microsoft-antispam-prvs: <SJ0PR10MB5533C2E3091B61470BE174AD93619@SJ0PR10MB5533.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmqulsQ/QvKGNgj0nUyFGqWGGdVof8/oJe6nNRszXaDuLGaQxEaMyNbpoOGxHRar3+Kz5T2l5+v+eHlWV7W8S3+QBIhXnCpl8xmOdPuZufctcAwIiuf1hQsUMsm7Y8b95MyYCSStTnJe66/7KT5KR45u6ERbG2ZQUyk24mGLtpof0MhenFYw87GXUuKBvWTNnrSWosYc57aOd2W1P6uKKhxjcbhC1DJEKIO2SDx1fJpexU/ZqW1g+BOZV+XUO2EDF84qy5Yu9UIbJyAmxUIS/VNW2RpbcXnpiu5zRnPtq9V12WII1qCuCPSZP2oPSvGWHh0Spclip7jxHhqTKYB8DMwsfPRy8eIA08NPjIYnUNWyrcpA464a1X+aROWmq0fOKKxnnCC5igFIX/cG4ccNa0SO9VMfAsJNp86E3SvIf+Rm1ZFbDW9B211KmtUYJTyBczb4MhvmfsLEKhfruadXLNfeSPFapqlcRTs8Ng4ysT5YjXKo9ABh0uU63OGXeTPdAdGAn9WEsnvSIyIH9TnjlhpR7cCAkNMVhQYPcOH2X9Y0MkojT6BQWn9gcdGqkiGIu3G5LU0tZ3cjd2ewWyXIYfNnrRNMveSTz9kbCurGGoG9+iUGc/07wG0wYiRGkeKAQ5A2rFI1rAdb4hf9ljMCfOxkxf2xuh8HtxdGSKSzOfCZMD7m0j3ncmRnSNl/wlt8+BYMuGxRfDIxlWNve8ECtOcKJVo/v+fxVI8PJcL9nf2BNDR1X5B/Yb+UEDICyHqh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(36756003)(8936002)(54906003)(122000001)(2616005)(5660300002)(6512007)(4326008)(6916009)(33656002)(86362001)(66476007)(53546011)(508600001)(64756008)(66446008)(38070700005)(71200400001)(38100700002)(316002)(2906002)(26005)(76116006)(83380400001)(186003)(8676002)(6506007)(91956017)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZeKmP3bRhNHiQjrq1Bm79IsTTYsrwWd7dFz/gNQmsIkwV43l9JbZBh5S7XAj?=
 =?us-ascii?Q?5Sknouka7eQG8V9ZyTQiPX/+r4FPZ0Lmf/J4u34Zqsjk2Mg1VltEKTFJAdTq?=
 =?us-ascii?Q?Kh1OwPLJyQGYSk/z9LgZaTz31TTwlqm8sot5lYf0CJvPq0wrqNH8qI2acqJJ?=
 =?us-ascii?Q?N4TkcvzM7ZrE4eyA3hHEelmHGAbXaSZmegzt8I9LXY9OTcAkWJauuHhDqcf7?=
 =?us-ascii?Q?pu7LwHOOFqG7uOqBu1LAEK6X58V9S13xT6Oi0pNj52AnTxDnaMrwh+2E7oJN?=
 =?us-ascii?Q?D+w7OfKPIjBS348xcq23EoRhH74pPDU1AXuoJBokuucYmAEvqfRirN0uHyLP?=
 =?us-ascii?Q?hoY+CEDoB133Oo0cafor8xRbs6fUVNL84tDfwO0P7sVSTkao0YocIeJQKpZk?=
 =?us-ascii?Q?donq+YFnGxsBsAcve7xze8IuSg+SCKUEWsz3QJiFDhrphuuZHclJEI4M3SCA?=
 =?us-ascii?Q?1qN6OZsJElN7L/8f3nWkP0vmmEZeXqqHva3T159NQkYap/JktYmIsvVR2nqM?=
 =?us-ascii?Q?S9czQzAzscstgrX5XK2A5T8RWSiltixCg6CI+KE/u0VDOqqzS1bQx1+MtVtd?=
 =?us-ascii?Q?G/bxCyRe16j6Ok1gyXrDklF/dvf1N70h1x6Z47zKfRiehIXfbaEErxGsSspk?=
 =?us-ascii?Q?/QcYMMZk571qE40OnWvlrw6NNi7cGKEix9pa6WfoO3rkWDlMVOAgn2tlCOx1?=
 =?us-ascii?Q?VkwEpBCkhCBUBXoFlU7ZpXQHJgAK0TK6aMYSD86jRYLG6+NL5g4l0AZIU93l?=
 =?us-ascii?Q?ZVDWH5/OH+ccsv8pM6f2rTKGGt0ngvZRWiZ3UsKttHLWgdjoMp2OW/SLFlTT?=
 =?us-ascii?Q?81TUmis2ELWSFR8cmAHO/dpga5rVLn57+ZfQLyo5UqMnup4IT5poX143V9aK?=
 =?us-ascii?Q?C7JKKPAxR4CSOOyUfSEWHBA+vyVLYn7vW7YCt+53bmuFHn7hyGl4fPfatpBP?=
 =?us-ascii?Q?rmOLgo9c2N3M+JUrFEHsxhLv3csqilAqWc9uBjumZEyyK3F52wjYWnpLg+NE?=
 =?us-ascii?Q?YN8BM+9Tl7iKJ2lPKmnDoP0OVkVfj263WUZJbslOHjwsmNXj/CgreV9p4E5B?=
 =?us-ascii?Q?yeIudPORIfOXCQp5Jg8eSNGOWylP1MKCqkAbuJEi5efzN+10yXSTcSB3V1vm?=
 =?us-ascii?Q?jg1PykzaAH+YatSoYqNWMlP8WzUx8s3XjU3mO7eqIzhaHjnKya9Ruy+PyVED?=
 =?us-ascii?Q?H0vywCyIgfCdDL73QB6wCEZPs/mVgrqKXQFIkHIHjI/9reXYaN8BD0yRHIsz?=
 =?us-ascii?Q?8ef7lfgS0kSNknlr2Xbb+5u+gYom1fJZf5GlwNxoPdTX+/Ua1B5PPoZw5TYg?=
 =?us-ascii?Q?xwTyoPCBqJiVJGFiqPx7tzICiKVJDt77uQiuygTkcJkVmW5IOZAZTjhqp2uA?=
 =?us-ascii?Q?Uhf1l0TBQmqwg30A34evsBB3bl13nhgLsMPH58xUeoFnXcBEHws5GAzFR5Mb?=
 =?us-ascii?Q?9CugZybDMMDeXYBBB72lpvtfXiZY40xZ3fRw2443JX1ZLh0Mh7pvYDdHhofv?=
 =?us-ascii?Q?nySNPjTnkePP3TaH13yEnqt1N+fpg2rF4FKOL618gxUgYjWDDkytaLUvonNg?=
 =?us-ascii?Q?1FUbpjvcjGRz2s2RS0pgWHVMDQ6MEWWx2Z1ONQVdCdtqR8ak1lkze7A6QWPP?=
 =?us-ascii?Q?2JyJshpcFncxVlKV1C/JVH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3B9CDF6D740BB438983FE4B83384A06@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a07a95-59db-481d-5ec3-08d9af7a38bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 18:42:52.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3dNv+dqNKTkPdCvHucb3rNiJg87qwqb/fSH8b0REis9L9vGWwkXyKtCi7QxRZXPdxDJqijNpA8XH667gXCjIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5533
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240097
X-Proofpoint-GUID: 2lWQcp99AVG_kfAa6p7J9RNyD8xDTHK_
X-Proofpoint-ORIG-GUID: 2lWQcp99AVG_kfAa6p7J9RNyD8xDTHK_
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2021, at 9:49 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Tue, Nov 23, 2021 at 12:29:35PM +1100, NeilBrown wrote:
>> This is a revision of my series for cleaning up server thread
>> management.
>=20
> For what it's worth, this version now passes my usual regression tests.

Likewise, I tested with both TCP and RDMA.


> --b.
>=20
>> Currently lockd, nfsd, and nfs-callback all manage threads slightly
>> differently.  This series unifies them.
>>=20
>> Changes since first series include:
>>  - minor bug fixes
>>  - kernel-doc comments for new functions
>>  - split first patch into 3, and make the bugfix a separate patch
>>  - fix management of pool_maps so lockd can usse svc_set_num_threads
>>    safely
>>  - switch nfs-callback to not request a 'pooled' service.
>>=20
>> NeilBrown
>>=20
>>=20
>> ---
>>=20
>> NeilBrown (19):
>>      SUNRPC/NFSD: clean up get/put functions.
>>      NFSD: handle error better in write_ports_addfd()
>>      SUNRPC: stop using ->sv_nrthreads as a refcount
>>      nfsd: make nfsd_stats.th_cnt atomic_t
>>      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
>>      NFSD: narrow nfsd_mutex protection in nfsd thread
>>      NFSD: Make it possible to use svc_set_num_threads_sync
>>      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
>>      NFSD: simplify locking for network notifier.
>>      lockd: introduce nlmsvc_serv
>>      lockd: simplify management of network status notifiers
>>      lockd: move lockd_start_svc() call into lockd_create_svc()
>>      lockd: move svc_exit_thread() into the thread
>>      lockd: introduce lockd_put()
>>      lockd: rename lockd_create_svc() to lockd_get()
>>      SUNRPC: move the pool_map definitions (back) into svc.c
>>      SUNRPC: always treat sv_nrpools=3D=3D1 as "not pooled"
>>      lockd: use svc_set_num_threads() for thread start and stop
>>      NFS: switch the callback service back to non-pooled.
>>=20
>>=20
>> fs/lockd/svc.c             | 194 ++++++++++++-------------------------
>> fs/nfs/callback.c          |  12 +--
>> fs/nfsd/netns.h            |  13 +--
>> fs/nfsd/nfsctl.c           |  24 ++---
>> fs/nfsd/nfssvc.c           | 139 +++++++++++++-------------
>> fs/nfsd/stats.c            |   2 +-
>> fs/nfsd/stats.h            |   4 +-
>> include/linux/sunrpc/svc.h |  58 ++++-------
>> net/sunrpc/svc.c           | 166 ++++++++++++++-----------------
>> 9 files changed, 248 insertions(+), 364 deletions(-)
>>=20
>> --
>> Signature

--
Chuck Lever



