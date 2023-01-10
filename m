Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AC66495B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbjAJSUu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjAJSUJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:20:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74368DFD8
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:18:00 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIE5ZP003598;
        Tue, 10 Jan 2023 18:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=81TQIkNzCL/P3u85fVPyH3Rx8tjwnaVrVDHTxfqUyDc=;
 b=ZcfU4rP7zoLLyxocKYfRaIvYSObTjR24jYwFBnBCjg8w2UUhhvq8EcAAHOX33+nUt//J
 o1qtWjh6l9a7QePNvl1TLUjRK+Jp3Vn8PJf6ponqbjUozSC0xVmPPTUfT/y0qdnbzJfx
 5Bw8tXiD6AfcQUyQpU0ylCGziWwW3bHsVtXp6dRMLW8DOWm3IsS/RJfbaqlTzLxtDB2b
 0BI2x/rydu5NTG8mOHnsHTBI18Z+03GbhaVabA6O22zDbBcueSQDWvSVtLK1GZlxcX1n
 CaSdzbceAtGpbEUjTVuKW5wxJxbqQmSBsbhwFW8E+XA9NOfllncwiqmxq29+mOKzq1WC Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n173bh18c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:17:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AI98sZ039812;
        Tue, 10 Jan 2023 18:17:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1d1v0cqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDnEBPft+Mi7bIhZQeLsOee21XKlex9Blra3QsdPt2Vb0+h+awESU50MN/Nw6iypjNXnWhLh9Yk1VVocfqRoHNbZ0YRu3Z2dHWFPkKrLNWmRTVK75SGDJokcxr1Jtz38x32x24T8C50476PMXorxrOHapBPW1jiXI7jiurwxZ0G1wN/ZMUtd8BOMFcnIVlzDbS0khwZStnzibmAN5S6GvSrGVINZ0MINeAzwnCWRVNhRXh3LainEMTmNdJT6IbKsYozjnMAjmO3PH26RGA7aiC3xnZrm8pSpyZKYm+/1NWtj8NhX3TlrFTBPnVXS+ymrEJG3ntMWonQNsyermWLqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81TQIkNzCL/P3u85fVPyH3Rx8tjwnaVrVDHTxfqUyDc=;
 b=gVbDfNVXeGKHY6rKdpMymrqiTIAOFG/djSoDwW134mBqp3dLrwYECWWueIkEQ6LqcGhk7X46qZuZf9tP+LE3wTJW410ynG7+F70x0lpvTF4YKxEZXK4FvvfhsnD7R4vhPZti/NpTt5PtwxmKP6a07cToYhILUo16BbbNmWa51yZxTEe6BLp3X/G05WamF5q1O6vtl5vHzzqCpFhuUrDxMcVYTwrnJoCC3Oqd/Mt77TrlY4MJ5xrqtVRkbAJf3TY/1IA1/n1WuKivkGN4mPhcwO4pRt4QfCtuROgSmgfiozp+vSGb1wx2v29nZj99Mm7N8FgALn2yS3uCy1Y6/TbtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81TQIkNzCL/P3u85fVPyH3Rx8tjwnaVrVDHTxfqUyDc=;
 b=bJiSGIe7g1lK3V2hYA/hbAuJV2vWxDw+XZ1cloLaanBrkckwgdyuTWQ2oF7pRzm9J6XiQsKfA6zek4WZcOpee7pUfQ5eu5rHVexjy5jjs2pUpB3MD8e8CQZbE6CsIpY88ZrrndrP+QjWm3Bb9qI4FpMwVOfUujr54YcwFYDxHYY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7296.namprd10.prod.outlook.com (2603:10b6:8:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 10 Jan
 2023 18:17:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 18:17:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Thread-Topic: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Thread-Index: AQHZJL+WL3xe9S8ATEuPlYmGP9jNkK6Xc6oAgAB2EgCAAAxGgA==
Date:   Tue, 10 Jan 2023 18:17:10 +0000
Message-ID: <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
 <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
 <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
In-Reply-To: <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7296:EE_
x-ms-office365-filtering-correlation-id: 391f2b63-30b7-416f-43fe-08daf336e3e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeXahz8T3ybhRLQ4ou+UQjKjRadoJGH+kBsLIp8FmO4O4okbMcHxYTtufiQ6sl1/w39Gv41wxOhhVQQJM2yi10dZ1o6axHxaMeY5cNMRnfcL0jv5EM4JYpbbYuiLE5a/RgCsacI1+Zf0HMBShNDhtK2cR9QU/9meGkCjOVzK3+hkCWqH4lcO+LbDSJVHOk+IwX9ERGRkhGJYmgGLFhNTFbKkv4AIr4/jItglEcx1AkIF0W+uK79nIm4jboNp6xtYRdHYs/OjuD6tC9cigNUMKzuHzpcMKxzmXify71duwwIFkcUjnkNQioLm/dqRTgBXdbO/dFFEqzzysr3XNUEyE0lXjR9L8YvZ/45gGS/E1c5mQZ0FwU07PKDGJV45ls8YWOG+sHUXmzyH82QzNLzx2mwoWmKdOA9CAzLuA0M2bo4nzBkk7hFLDnxRWr+hL6Y/aT6tYuqGJkMcUz/s0kxIEMxyQVxiScpdcCfsRLhRaiwNtX89Y2Q5k13v/cjh9r2RJbKAcK1pkW7McWRNFlClXLaUw9y6K5ttrFXhRXeP/0oPcY8i3yASQ2ynrbCjQN4Euc89L0iOTHhP62MYkVcd1Q93oQmgWVWzbXVkodXeNRgqasoe0MF7xXKd0KpLJvs6cHU94iVzC/Fgzk5hQlzLr4BHuAyBkhD1FYNL5yHnAS84p94GphNQasxUP6aZfCroj+o5I1tO6xLt490JCHYc9ijkZ3XCtd9SJqMwR+1jKNo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(66446008)(86362001)(8676002)(33656002)(122000001)(91956017)(76116006)(4326008)(38100700002)(41300700001)(66946007)(6636002)(66476007)(38070700005)(66556008)(6506007)(2906002)(6862004)(8936002)(478600001)(316002)(5660300002)(83380400001)(2616005)(6512007)(6486002)(71200400001)(186003)(53546011)(64756008)(37006003)(26005)(54906003)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12fDvp6fLo5gIqLrR2/ODdCHUcu6F9ODMiO5KHvCR9HvggfcNyAeHiwawZsV?=
 =?us-ascii?Q?fWV99fdPoSbHGEUdK5+FsoyCffFCefZ65NoT36x76u2g3P4Z5yYbQ7CQzgfi?=
 =?us-ascii?Q?PsqkqPe4Wo/QaJu4ziXx16dfwQQWsnUdwPLV5Aw/XDVGnOqfmVfciiYQJmRN?=
 =?us-ascii?Q?oMIIVvEGEbdZgLp+qcdaqwFFK7cfKfo+LitCArLDepb5rzS3T/4iHo5XVyt6?=
 =?us-ascii?Q?weNyzg36QN7G03tTOUnNfBUgaAa3/eyWCVYf3pGkE1XxTLkRCOJLGLWD4Onp?=
 =?us-ascii?Q?bIlaJOmCf9sLyXEWmFflyp0OGEHUxz4tPeN6GTIiRKvUuQX1s9qcwMHs9M87?=
 =?us-ascii?Q?uVi6Nc0bc/Whk9Ycxp/yW4Hus8/EPKuAAPEQjNbTcBR59/Ne41zOzNBEkcEV?=
 =?us-ascii?Q?P2MCTo4Kw1sBnyLJb+QU9+kGxpnrGdFxGo+xt2EZgfwr531XOEQdQ1gEpwqb?=
 =?us-ascii?Q?ih8xJTJnGGi2zQRypct/QMoU5XqYBQ1srv3kAv2z/tzdJKNbbj80nc6N2uKG?=
 =?us-ascii?Q?SIkJFNUcyrhUwWK0niogJlRie8ATdBUorNbscAkpI1AUYDttGxUz+cKKGQWd?=
 =?us-ascii?Q?rIcp7QylwHfpKe6ziGF+E7oG6pVh44CZHFVnv3X5zm/hYY5iDgRuVqiYREGs?=
 =?us-ascii?Q?bzHPxEp0SaFhphrFRdIgAb3Mx37gXd4ToQATIFAaHKPVo9YIpI7mTuz3RYbR?=
 =?us-ascii?Q?mEUO6EsPxU0GqflPAhvs/xOEAdEj1AIdWA3UtPWVKlblPm1Z1He3BPlsYPRu?=
 =?us-ascii?Q?Z/jeCy2JXArfPCQcarzsboF2zmeSyA7feLBDAD/zLiXrDhXmpT1qBbD54Xp+?=
 =?us-ascii?Q?C+YRnf0grMDeFPmT8ZbPs0MDbMruCKLeqFYokew5rioUP7RDEfJdXG3kVi9e?=
 =?us-ascii?Q?h4sMpIY6X16nakI638cHrB4vC18VasH+9ot0u39kMIfjBEMpgG0510jV0uwY?=
 =?us-ascii?Q?V8ZlhDSxhkci4FZDcNApGxaVqxgD3cqcFNP77WnpeKFBzcEwR9CM1SO90UTj?=
 =?us-ascii?Q?rgev3pxbdgYMndGBivAFysjvt4jl38QJhMdC+bnRNbSu7eJoWsdJuaVBmrS/?=
 =?us-ascii?Q?cU1RtLcgVGJIafODSvgQeIrVF/fdxhsnaIk/qi+VxbljdFx2I4ZirCX8NmY+?=
 =?us-ascii?Q?/E7D7IUvvtYCxU8F7E9FKo8zzEZVK7Qa7S+GZOJ96GuCcKbrQ2UQVBJ9bqzQ?=
 =?us-ascii?Q?iDKWASizg05pJyBauHgfLg4Nb1ERNAjJXl99RJYbc6xhNqmF3+cEVBzKXiOO?=
 =?us-ascii?Q?kCmEYPO0+zsVhZ9mb7jtoasnkiX5/OwJGyonsYUS8K16eDQXqBSur9YnNNjQ?=
 =?us-ascii?Q?QKmBOEjs6Z3YnFlMamaLpeS58j/IT66WhZ1CdpDYewpNuQKoiSN+u4Kcsbu8?=
 =?us-ascii?Q?e53bELYm75MlClMl4N+K5L0c77JbZ5DZaILLBuzm8o/egoG6mpByBUvXkMhC?=
 =?us-ascii?Q?FSm49nGO1For+Ms8JFcrknhZ4MplcwjGqPy/a8MVbWvcIpd0k2+HgxBcZf/w?=
 =?us-ascii?Q?X+onJui7KUmOSGLJEsr1YPaaiPKXTw9NsRCPJaxUY713m0CsNMgBNOhb3pzM?=
 =?us-ascii?Q?WvflZ8gq9hdvPb28md3mVeNfGVMx1C4yUkykhC6AidkVTt9HuVT4Aq/q50Ai?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6823F7D870166340AC4611D978ACA31A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FBCTznHFIid36nP94LO0gbACcv92+xDhAJY7RAMnCJy62QxGnHG1OyjuSCRxuECCqiM8p57GbxbdQrDi5gRz6HSw2azNJq8hC31CqkWvsxHsSg+CtWzz3wuuZMy7cHkW09F1BKsXg+zGXbKEeXFq1Yv7PbXJfHNai37xrNoDy+kx/W2Mc9wjLTMaKpQ8otAYuSd7pCu3ETj4R+14E0UtSNE6HXln5beQO8uv5M9QBK6rjuVWJePpaUZRUHiw8HtK3aQwampbzzxfe4iGy2TbSiycBHWX6ahh3W3tIw32LuLiLwQhaYxtwjVtg5WBCDstRX5i+vXJBqcbxQKeBsu4v+p12Di6YBdR4h+LHAqbRi5T09d5MUuXnUvaCnucVpfHgshG/6wdPLL7+i1RvJLSJdSonUsHjQpjCDbCQBtON9RNxNKWCctaNPjr1wJqizKBP9qldsy2NDakfrzIEH9VTPlpwkzyT0cFNWgI8NHu7uEEeIGY1XyeqfFcLQSlTq2n99GbQTQ54PxscdRsyk06V2Rhw5IuwkCM6n6RaYjLkLLhlZS7Ud6Gr1r/aXrGp9jv8NVF2OUnChadFoQeWkyW/SytEHSTNNTLf08zpS2sn9Qwqv8WV4ov1cOV387I3fWMZrs25wqrJjJ6LB7xG3RQWBzu4PK0oqiVsHKhBwYHKn/mXiDGpuJ9/cUqzSxs2638BYpEsTxCi2JOMe8VvEklYL4FpGan3+BopdUc58CjGIEHuxuMNQWgeM/B79mZI4shMc48S+zHVNx7u5W6uOZ+dSUhG1uFU7vTFkEbmnmvRPiOY0x/j+DmQdX3egaXiw7s
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391f2b63-30b7-416f-43fe-08daf336e3e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 18:17:10.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OGjgeUfh/5QFShq36kH206gKdXmf/IwX4m05v+chm08z9YGemCVb9ehkQKi25VtcF4iCsicBOw6FOOgYDqdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100117
X-Proofpoint-GUID: BCDpMPklvzCijWBSskY8Eq5qj_NnHoLL
X-Proofpoint-ORIG-GUID: BCDpMPklvzCijWBSskY8Eq5qj_NnHoLL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 10, 2023, at 12:33 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 1/10/23 2:30 AM, Jeff Layton wrote:
>> On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
>>> Currently nfsd4_state_shrinker_worker can be schduled multiple times
>>> from nfsd4_state_shrinker_count when memory is low. This causes
>>> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>>>=20
>>> This patch allows only one instance of nfsd4_state_shrinker_worker
>>> at a time using the nfsd_shrinker_active flag, protected by the
>>> client_lock.
>>>=20
>>> Replace mod_delayed_work with queue_delayed_work since we
>>> don't expect to modify the delay of any pending work.
>>>=20
>>> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memor=
y condition")
>>> Reported-by: Mike Galbraith <efault@gmx.de>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>  fs/nfsd/netns.h     |  1 +
>>>  fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>> index 8c854ba3285b..801d70926442 100644
>>> --- a/fs/nfsd/netns.h
>>> +++ b/fs/nfsd/netns.h
>>> @@ -196,6 +196,7 @@ struct nfsd_net {
>>>  	atomic_t		nfsd_courtesy_clients;
>>>  	struct shrinker		nfsd_client_shrinker;
>>>  	struct delayed_work	nfsd_shrinker_work;
>>> +	bool			nfsd_shrinker_active;
>>>  };
>>>    /* Simple check to find out if a given net was properly initialized =
*/
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index ee56c9466304..e00551af6a11 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shr=
ink, struct shrink_control *sc)
>>>  	struct nfsd_net *nn =3D container_of(shrink,
>>>  			struct nfsd_net, nfsd_client_shrinker);
>>>  +	spin_lock(&nn->client_lock);
>>> +	if (nn->nfsd_shrinker_active) {
>>> +		spin_unlock(&nn->client_lock);
>>> +		return 0;
>>> +	}
>> Is this extra machinery really necessary? The bool and spinlock don't
>> seem to be needed. Typically there is no issue with calling
>> queued_delayed_work when the work is already queued. It just returns
>> false in that case without doing anything.
>=20
> When there are multiple calls to mod_delayed_work/queue_delayed_work
> we hit the WARN_ON_ONCE's in __queue_delayed_work and __queue_work if
> the work is queued but not execute yet.

The delay argument of zero is interesting. If it's set to a value
greater than zero, do you still see a problem?


> This problem was reported by Mike. I initially tried with only the
> bool but that was not enough that was why the spinlock was added.
> Mike verified that the patch fixed the problem.
>=20
> -Dai
>=20
>>=20
>>>  	count =3D atomic_read(&nn->nfsd_courtesy_clients);
>>>  	if (!count)
>>>  		count =3D atomic_long_read(&num_delegations);
>>> -	if (count)
>>> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>> +	if (count) {
>>> +		nn->nfsd_shrinker_active =3D true;
>>> +		spin_unlock(&nn->client_lock);
>>> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
>>> +	} else
>>> +		spin_unlock(&nn->client_lock);
>>>  	return (unsigned long)count;
>>>  }
>>>  @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *=
work)
>>>    	courtesy_client_reaper(nn);
>>>  	deleg_reaper(nn);
>>> +	spin_lock(&nn->client_lock);
>>> +	nn->nfsd_shrinker_active =3D 0;
>>> +	spin_unlock(&nn->client_lock);
>>>  }
>>>    static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_s=
tid *stp)

--
Chuck Lever



