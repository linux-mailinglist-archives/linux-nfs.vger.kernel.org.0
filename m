Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607D5EAFF0
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIZSbc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIZSbU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:31:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D622AE3A
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 11:31:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHYQ0F012818;
        Mon, 26 Sep 2022 18:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zQ5nkfhp8n/iON2Oxr76Hn/ROhjeBPKBR/i9949y6js=;
 b=OUXfUm06lX5ZGVvKxSlcwW/z9La7IDBYFLxIOnp0uso3DNJiteKyem07gBmQIThpw8EL
 /n6FFlp4+deoDdmCo96zmCuFPeJOthHO/cmOGLVZLPxzLEgfAqvpuV72bEEusdmf7ROy
 aM10bt7mGCAac6nANBy92BzyraJhpUrfqR9ALn/6YQyWdxHhbkSDmp2JSW/o1yZXR460
 9R1XDfzEMFoinbDf1oijZM1MN6ietFUEAL1XVStil3un0OdLl/sdO3Xjm321fPR65caR
 /xKz00Cr1WeLNMY2uWGlFOMKbG8DhDWzsrazOYIYylkvwxze09yl/Idc9Yw+Rmk2ghch XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssubch2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 18:31:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28QGcB2r023615;
        Mon, 26 Sep 2022 18:31:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpq78frq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 18:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2IvPwIHtwVjcQAJmCanev1npZNQZRSpWho/WsudiMaTA5r5jWnW+Xa121OSXGa9veGCRql+uWWbkNULSKZH69hjUHBZu5ilSYx6WNbWU3mtue+l0zhy9MirNmu/TQGq08bCzRYmTXK0YJF0Lt0Fz3iGGse8GXYlRoduBvQDn/w/cyHsPeHQhw/kgwMLuwZhG0xom+9dvd4rA7Lsm4ke9PgXHBp2JpJjlGF4rZfLrMmVfGe3zW9iLbiuT0S3nNs+ce9/A/MShMkjQsVDtZ72MzqDR1ULixFqIfetkKG2Sd4g0n4RLvnS7fIm0ZVdlOhWGlNlZzKfZbGrEBLyDPZbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ5nkfhp8n/iON2Oxr76Hn/ROhjeBPKBR/i9949y6js=;
 b=oAG56UbHlwBDJ2mRSOJCO7DBO3RS5aMP2FtQsXiv11ejFi8pZjFgHZbvee20v5nrTMz0GrgzJyz/z9X8x++u/sDQ+uPSrP5s+HDBTRlSfcMw5FQQkiqfP+tGjvRBy9fwIjWi2wl24XDFY7V3fhOM9DmYeV8UnO+ckob2DpA2m9wEOowxs7yFHODpXnJCjdGppcE7u5WgCU+HVzvxGhVrE9xXWZeXnnqqK00B5atJE5qQWhljnuuUv3e0qB8qPcdgtqT5lFXnCSG72lRBSUHaCKj5wdolv+N0sp+bO+SPN0lmZ6piuHBWEBdQ6BvnpmXlYuIJipiCMs+eWX9KHieFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ5nkfhp8n/iON2Oxr76Hn/ROhjeBPKBR/i9949y6js=;
 b=VaSnEei4MZcUP2Xo5w+g6bKTYCrB1FcxuOTppglG99weJs74DIPOfgE/mPpXRDXvUH0khycCmPS76KSUYCFwcywHpdgYIfUUKXdKH/tkX5PLbKj57UFiPi/X1AJDBqE/UM1JYM5NmezaQYZlOhWI7HacIhPTGN3NQc1caheTGdI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 18:31:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 18:31:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] nfsd: make nfsd4_run_cb a bool return function
Thread-Topic: [PATCH 3/4] nfsd: make nfsd4_run_cb a bool return function
Thread-Index: AQHY0cZ51eRBkuHk8kWRMF5Zpbx2Nq3x/cEAgAAJLoCAAAHTgA==
Date:   Mon, 26 Sep 2022 18:31:13 +0000
Message-ID: <5D93DF5C-B214-456A-9742-CCC90C8F6802@oracle.com>
References: <20220926163847.47558-1-jlayton@kernel.org>
 <20220926163847.47558-4-jlayton@kernel.org>
 <F3B08B69-F05B-4F83-B407-343884ABC263@oracle.com>
 <a751b036a0a46a42abe8809c340b05c093e3d148.camel@kernel.org>
In-Reply-To: <a751b036a0a46a42abe8809c340b05c093e3d148.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6017:EE_
x-ms-office365-filtering-correlation-id: b06c8f1d-0b11-45bf-08b2-08da9fed4ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nkUX2PnT4MUxTYv5o21zl74+bRerWjc9Zhs6iwgA54MwhYlJ3+0R6SuQP7+0Wc95LRs6GzSjIg/UL0hHckppTWOfVoCgGQEN07BqH1utJ07DHq46x6Q4jrhKYRkrA3zqiPfYXqJq87oLyL6yZ77YiXVVV0Zembk17CEV78hb4cUkmrKW5fw/suksiYjiUujqXXr9d3mWLQJoNxcbWZaQr9WmIbNOJ4X6TBz8E+FDyHCYbk+wt0VjtRxIy9XEjv+2IbRb+3OrJJV2fdh0/riS7txa5sMalGqs5zLMhOSH+06F97tn342xZN+X3gC5kVACvtPYCxgH42mIBcG2SonIo6AIB4szAB+gszgy2rWJxiRaIQgyIz83edW6rfYql+x1I2aWnOd9ZyvKfSnJLiWliI7U5QQMI1AiSBKfAf/8WxVhVNNcJPTh0K5gipOSdnZpSa6svguaBn64atySDgM7AuokKlUSc/5o4ko0FwMD+JX6R4IHMb7yVlg+giT9R9QG8GbP+5BsTrmmeORZlMpMplEWjXP9oof+WWse3a/y0vl+dRObIYLLVWyf9FcHi79xCCx0XHi/oWFut8AXBG9lhs7Wot2QRyUoSD1mNOpswpslOOgsazL+pNuBsV3jO/hwVDptnC0m4WmW7+ZS7mo+qshxyu5tV6RielhhCU8PdicjAJtqTSpvBl/A3AUmepe/aYKFyAF6hdDsbvmlktNArESwOaxVLGTV1xKUNCmiVR78yyrvXXlGC5fAklzYQcf7hAOMS9Ufd3FgbB7E0fNbbH2CuoE+HhCtZv3Exp9Gw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(38100700002)(122000001)(26005)(6512007)(6506007)(38070700005)(83380400001)(2616005)(186003)(53546011)(71200400001)(6486002)(478600001)(316002)(6916009)(36756003)(2906002)(91956017)(33656002)(86362001)(5660300002)(8936002)(4326008)(8676002)(66446008)(41300700001)(64756008)(66476007)(76116006)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AtbHFpXBZGT6DBR8CNcEwSTYlnxu8s7VqOqQ3E0ach+mRYnlHiMQkn3M9tuK?=
 =?us-ascii?Q?gHc6nSJxAygmMr1+zsiCWlYnSwoZ4vUHC5e4DYzxQKru85rXqPUoMSGNinpT?=
 =?us-ascii?Q?qVyyJObGHHfFa/L+62qEbL+OTbdwyhIlYxDH7NJZcBGdP1zVRfnNKF41B25d?=
 =?us-ascii?Q?Gr4eTaHdmaza1+1Q7jJFdGneo7unllxqjVvWIEBxf0MM4LrB81bITzumZEJh?=
 =?us-ascii?Q?ALYNGqZF9+ZL+QVLLKL8uYa1AQAN9jHnAtQLj+13tsjjsFnXuZRHYgZdAPmx?=
 =?us-ascii?Q?Uh8r30LMhg/IzDbsAHjk2z5hiwaocX9FW2OtPH6KxRJBOULQF89Phmz+VW+q?=
 =?us-ascii?Q?iLoG/n6wWd+0u+nEAuiZElMoCoIpTrqgH8HMXfWJntnVpZu3aBvX610cYGwo?=
 =?us-ascii?Q?W7egPMh2kTcRDmkmBbxzAvQysh5sKwWllCbfPFKXYGjlJT/2mqMySo7gBfPh?=
 =?us-ascii?Q?fGZEQ0DmC/zXPCeXMt7Od3M9lrc6AjVyOeegotqJkU83zeJT1yDmlsKAgXcY?=
 =?us-ascii?Q?5yu8VxYcJrvPKoh9kN3OoxcaR6zd39YR3l72UCDe+43/0PPr6/jVF8RRZSc2?=
 =?us-ascii?Q?fzd+nJZFRvpaWs9Zm/3B2PJyAn0EChJNcXVcq8QLg30EhqOwp8461T96iC6Y?=
 =?us-ascii?Q?JEYADnnUcOkRjPwMpnZsWZnT6shIbmYFFeg72mTGR0OJJ2l4M+cqJnqCfYLz?=
 =?us-ascii?Q?VSJsxwf1YVxcuJauJE3pwou+egicUQDphoQ3YLhD96jm4yiwXmhu6EAh5QTY?=
 =?us-ascii?Q?YzENn2KijjgB9XAHt1O9AVLhTYfRqE8V6mPibQMtQ2lHv2uzDNgeBJxrMEsv?=
 =?us-ascii?Q?zRdytT2lsqod4+DQjg5haWRdaXS4pakJsC8TFpakmiZ0gHgnRFV7suPHhT5b?=
 =?us-ascii?Q?HLXNGtwkTA4DH0d1tK6AHVHZuoM6xAJEMoOQuhSpcnBtHnTsBU1AVq1paQGQ?=
 =?us-ascii?Q?qVzKv/oclmvm/xR1Gkbi0Md860S/6SVSm8ooqJvDx/URljkz95UzZxkEd4Jx?=
 =?us-ascii?Q?AWTIn5jsyOJRH0yPRmaM6SS+4k0kRzLdS/0uemtVJP82BaQBeRo+dP9F3+Rl?=
 =?us-ascii?Q?lCW4MRCFrQ+/wtADHvVgI6+m2jGnpyxe/IbCOMomXK2Ak2w83gyyqd+cgjCA?=
 =?us-ascii?Q?fNmu2a8qfpuzxOZfk4suL+h6baeJ3fsZIwBamzI/mF1Xfcutg81HWKuzCANj?=
 =?us-ascii?Q?NJK3V4FVEPPsFmActnXpVMZjoNg4LkTM6p33Z2V5nK6tDtaIbjfSYyUKuszB?=
 =?us-ascii?Q?auMeeSd8pcrUFPXoTO0hu3cu5qfoXckZ6dp6jXsKWvOyH7+/xqGACLR3/chD?=
 =?us-ascii?Q?JXstCCXuSrZ9fxAkHxYmQ8vJJDcqhHqeHp1ugoDERxayQRKMLxmx0I8pfh/M?=
 =?us-ascii?Q?K/V8lkcnudlOevvbL1BvK9vBKxFt/G8BDpPtfydW2DDdhhW2MdDKT8u3yncq?=
 =?us-ascii?Q?6I9wFhYjwQsi3/6fbNK/wWtW/eP8S2q0DKbLkAq6zTlUC1ZbTBAoDuaH9qGi?=
 =?us-ascii?Q?VemiPvWOvQ7J86LQVde5pv37PGgzA6AnCVtwrIQdwT6K9j0guMDcd0IwB6nr?=
 =?us-ascii?Q?+FgbGe1lYpQC9P9o8OjGRJFGwy+80W3S+FwJPQatGToodt3f4e4qp5om7AKI?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA3C64B6CF8EE44C94367D67D347F469@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06c8f1d-0b11-45bf-08b2-08da9fed4ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 18:31:13.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/lC8FUmk9Vtj3bon61BAA/fGbxQk2qFvDZRE0fRdPmU3yZgTnBIPvwXvWzBlQKv1PJKY+UHFQXP5gMe7m3EXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260115
X-Proofpoint-GUID: HaOB1_yNmjUFB_4yKawCj1aXXSCWTv8o
X-Proofpoint-ORIG-GUID: HaOB1_yNmjUFB_4yKawCj1aXXSCWTv8o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 26, 2022, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-09-26 at 17:51 +0000, Chuck Lever III wrote:
>>=20
>>> On Sep 26, 2022, at 12:38 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> ...and mirror the semantics of queue_work. Also, queueing a delegation
>>> recall should always succeed when queueing, so WARN if one ever doesn't=
.
>>=20
>> The description is not especially clear. It seems like the point
>> of this patch is really the part after the "Also, ..." Otherwise,
>> I'm not getting why this change is really needed?
>>=20
>> Maybe a tracepoint would be less alarming to users/administrators
>> than would a WARN with a full stack trace? The kdoc comment you
>> added (thank you!) suggests there are times when it is OK for the
>> nfsd4_queue_cb() to fail.
>>=20
>>=20
>=20
> Yeah, that's pretty much the case with the "also". There may be some
> other cases where we ought to catch this sort of thing too. We'd likely
> never see a tracepoint for this. We'd just notice that there was a
> refcount leak.
>=20
> queue_work can return false without queueing anything if the work is
> already queued. In this case, we will have taken an extra reference to
> the stid that will never get put. I think this should never happen
> because of the flc_lock, but it'd be good to catch it if it does.

I've pushed Dai's v3 SSC fix and the first two patches in this series
to the nfsd for-next tree. Can you send me 3/4 and 4/4 again but=20

 - Include the above text in the description of 3/4, and

 - rebase 4/4 on top of the latest nfsd for-next

Thanks!


> That said, I don't feel that strongly about the patch, so if you think
> it's not worthwhile, I'm fine with holding off on it.
>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfs4callback.c | 14 ++++++++++++--
>>> fs/nfsd/nfs4state.c    |  5 ++---
>>> fs/nfsd/state.h        |  2 +-
>>> 3 files changed, 15 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index 4ce328209f61..ba904614ebf5 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1371,11 +1371,21 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, s=
truct nfs4_client *clp,
>>> 	cb->cb_holds_slot =3D false;
>>> }
>>>=20
>>> -void nfsd4_run_cb(struct nfsd4_callback *cb)
>>> +/**
>>> + * nfsd4_run_cb - queue up a callback job to run
>>> + * @cb: callback to queue
>>> + *
>>> + * Kick off a callback to do its thing. Returns false if it was alread=
y
>>> + * queued or running, true otherwise.
>>> + */
>>> +bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>> {
>>> +	bool queued;
>>> 	struct nfs4_client *clp =3D cb->cb_clp;
>>=20
>> Reverse christmas tree, please.
>>=20
>>=20
>>>=20
>>> 	nfsd41_cb_inflight_begin(clp);
>>> -	if (!nfsd4_queue_cb(cb))
>>> +	queued =3D nfsd4_queue_cb(cb);
>>> +	if (!queued)
>>> 		nfsd41_cb_inflight_end(clp);
>>> +	return queued;
>>> }
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 211f1af1cfb3..90533f43fea9 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -4861,14 +4861,13 @@ static void nfsd_break_one_deleg(struct nfs4_de=
legation *dp)
>>> 	 * we know it's safe to take a reference.
>>> 	 */
>>> 	refcount_inc(&dp->dl_stid.sc_count);
>>> -	nfsd4_run_cb(&dp->dl_recall);
>>> +	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>>> }
>>>=20
>>> /* Called from break_lease() with flc_lock held. */
>>> static bool
>>> nfsd_break_deleg_cb(struct file_lock *fl)
>>> {
>>> -	bool ret =3D false;
>>> 	struct nfs4_delegation *dp =3D (struct nfs4_delegation *)fl->fl_owner;
>>> 	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
>>> 	struct nfs4_client *clp =3D dp->dl_stid.sc_client;
>>> @@ -4894,7 +4893,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>>> 	fp->fi_had_conflict =3D true;
>>> 	nfsd_break_one_deleg(dp);
>>> 	spin_unlock(&fp->fi_lock);
>>> -	return ret;
>>> +	return false;
>>> }
>>>=20
>>> /**
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index b3477087a9fc..e2daef3cc003 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -692,7 +692,7 @@ extern void nfsd4_probe_callback_sync(struct nfs4_c=
lient *clp);
>>> extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_=
cb_conn *);
>>> extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client=
 *clp,
>>> 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
>>> -extern void nfsd4_run_cb(struct nfsd4_callback *cb);
>>> +extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
>>> extern int nfsd4_create_callback_queue(void);
>>> extern void nfsd4_destroy_callback_queue(void);
>>> extern void nfsd4_shutdown_callback(struct nfs4_client *);
>>> --=20
>>> 2.37.3
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



