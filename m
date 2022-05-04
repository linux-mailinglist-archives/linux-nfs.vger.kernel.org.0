Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05D51A2A1
	for <lists+linux-nfs@lfdr.de>; Wed,  4 May 2022 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiEDO41 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 May 2022 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiEDO4Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 May 2022 10:56:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D3120A9
        for <linux-nfs@vger.kernel.org>; Wed,  4 May 2022 07:52:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244ENiAA013507
        for <linux-nfs@vger.kernel.org>; Wed, 4 May 2022 14:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KC0a+lzZknxvMBOOjbgVtG9IXHXXEGdRGjW7XLcBv+A=;
 b=EOMeIRT37ZMsyu6z/Jf1e9EGR+WDBuO7mG+I3k1sDTnQBk3eWJ53XWVgBaoud+WloR+V
 H90gKOfHZqH1AbQ08t2L4jdO7hllSTUPZPF1U+ZQ2fMSk8Yq9PCiUBP58LESXhbn5Vr3
 a4ZLoz4fQ7rIvM/cGEptdB4JcD6Cc49licXRBfwqDGaU8u3CxK1Lcw6rfq+99y0D96ir
 9qWkBJcU919vN+qoNrvc1+W18oBW9yqwYyGR++wxEmvrR8TlX4XrZH7Dx28OZTkBl8ZW
 4t4yoxNg2nlHxS9/BctZF6UNM/O0SZXaFonsJXq323WZIiThD7cDGf80YZjOqUjLIUlY oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsgqv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 04 May 2022 14:52:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 244Eqfkl028982
        for <linux-nfs@vger.kernel.org>; Wed, 4 May 2022 14:52:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9k9my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 04 May 2022 14:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqcQGgFwsMAV2VxsJSC/Q0W3LFcTkqphMpz4BUnw7LU19NXkpNvCyZGbS+d7i9McfrCxDWJrmxWK6CFvYhc0HjwW1dJSuoCuhCBcwVuDU1diFVHvAdt5wVlHxb5DxE5+iqIkJ62Cg/O8wL1IK8j5G1pDzXb24Qd4RfLQxMkEaM7I1o+zSrx7CLoniOm660AXoSsZp/wb6eMWl8/RuJUaN5AiAxQ/WjbKtFF50eJpGSLNMWxi/j4L82eGXRdyrDMgOEI0wX0bfqRRud1fGKJhcbselH/QME8jfY+qk7WJNmHcYWQMClLpweFRbXjgfWwcZzCNOIc9IvZosut15cbBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC0a+lzZknxvMBOOjbgVtG9IXHXXEGdRGjW7XLcBv+A=;
 b=IUV3MzTHbZc/BLWV7g+yC8U7sacMnVXL5KbqF8vPUfisgKS9xMgDLXDCjvsDT7rSnEhwjQ4ewJ6sqRDLXTfwmEfwUoKMIcrNeGN7gp7O46P2mO2lJ/66QPG+L21RwFSXbJ/NGfR9k4TAdzSuYx/xPYCD6BFmyTR0n7vakQlXz51siYrHH6XbnVlpUHg4FviNmJCGxfGlDjZVKweJBCd8B5IIE6FO6zfbtOPpj2LLCe5eVH9iZhTrUrF29zQaLWD7bMYTS7vB0/LlH13LtEYvIGq7rXXfYMAm+/ncGciwvRRZ2ofmEG8gWDm2Hxio9td4wI5HhbcASJDHktBlo91bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC0a+lzZknxvMBOOjbgVtG9IXHXXEGdRGjW7XLcBv+A=;
 b=B00oQsBAswkeoVjSefyqLGa1BwTFprvP6D33XZzMOg68U7aTCx4xGmBf8WRjwpOYDomFr9JmCy6Bxm7X8IBjPB6ic0qFHnAMxAe0lQ+rbBNjztdc+gARTXbR5L0GcYyuTCjXG4jVIUdKhskpEK94fXSzCRKCGtjwsEoD7nSQRM4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 14:52:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.026; Wed, 4 May 2022
 14:52:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Topic: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Index: AQHYXyGPzdf4A6mimkmk/DpMpv4nPq0OzvUA
Date:   Wed, 4 May 2022 14:52:45 +0000
Message-ID: <D5903E27-374B-4E59-A018-F5F06ABE376D@oracle.com>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
In-Reply-To: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 420e8cc1-6fbd-4d2e-c258-08da2dddbf94
x-ms-traffictypediagnostic: CY5PR10MB6166:EE_
x-microsoft-antispam-prvs: <CY5PR10MB61661CC2898F2067E496309F93C39@CY5PR10MB6166.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hh/UgFjaYS+phSeubD4ckE7rxpXOsO+aRCYFq/ysMZlZbuDCS1m8gPFfXCLij9vTx81OxxtC5or3Vysh0u7WEgfFhjAog5yJ0YONbq3CYcw5FP7XxUE9iA7dvDdbo1+otEukqTZtAUcKMfJqP4PQ6PqBqWkNSFbnGM6FUKKtqYYxzftf5KHxy8YQeW+hhGa3MlZJwY0gISPfE64ac7B1iFN6wx+QDLOY4wOBqKWb3Zpzlyvfd+Nf1ENtN4Kx1vHQqIwx1VqkUQWNTncNUzYXEH2EVeqZ2p/L5diuttEiuO8YQwvu4S60MWxwwYfgfmoYyPGMtIUTpE37VFZyP7IeH2gEoNg7J2/7LHuG7tTlFVRMzHQHzuwxOD7C1028Qy4XbmpC0l303ux+/uAXwH+W9F5awtArW3zuOiseXU8Md7IWwmBxzFMUcCM1aTLqc1MPG5ATClJV9oPYobU5KXURjPyMTBcuaFMFu6Z80e0p9mqzQcxXl8Azp3kNDdRt8Rcqt0CNgBtRaTmGoJkDMsdCbRFXthmjzVu2uaKr3wPf2Fd1g8xRUnP5r01i6WMl8s2jzlF8GU/6JmYfliglrgNVvCwkzCwKZI2jxyna66/btTha84M3rOvyHHvO19CMfdWbQvjsIFN4q9oKGqNlwC7Rp4LAvSkuJ1mpPWZ+A5/ypB9eov6SKVOUyAdFwstTGZskXDe52P3a3Ok1imp+UDrnT7rqth4f7JctSubq/YiAP0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6636002)(37006003)(5660300002)(26005)(83380400001)(316002)(45080400002)(36756003)(38100700002)(38070700005)(2906002)(186003)(122000001)(2616005)(8676002)(6862004)(33656002)(4326008)(6506007)(66446008)(66476007)(76116006)(66946007)(66556008)(6512007)(53546011)(8936002)(86362001)(64756008)(71200400001)(6486002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w6WyFhFH3TQqbrKRETScbMu9DF/XMTi6LB+22t/vctTrhwsCBdb5+iF4O2yO?=
 =?us-ascii?Q?LKAyYWm6WbLxP6id/gnlVozq3D9L6CDg+ytZ4qqmVUyONpF1dISm0qTHSBz7?=
 =?us-ascii?Q?HVFuVO+aAi3lT5dH6gOzRve4TGWbzlevVDqB8/K+5XWAH9Mck2oTZhBiu3S6?=
 =?us-ascii?Q?T8EGYgssm0vQXMPMLCQ9JPrx4JCYEggHdCk4gl8FtKHfFF+UqBtm5SfwFhCJ?=
 =?us-ascii?Q?8AHGrpahQ2iofbsMRYA4/2LxwY4QqZYOLLIHzBZsOKBelX87mQM+wkNpQ11+?=
 =?us-ascii?Q?XxdbKrveGZfDE0f2Tdi7ylQ0h/MIQ+UjCNPHhOAg3Dt31ly/vw6rf24ogeqr?=
 =?us-ascii?Q?RVC+ArojShVh2YB9bbYHuifyCRzdjToTrVNIBtBSp2CH+ClQDMhEURJzF5Dn?=
 =?us-ascii?Q?jPjcUCdlZsgPtIq2m1y+BmHR1TOwYVEhecuOo6f/YgMtDN5VVVDn0tuKFrkn?=
 =?us-ascii?Q?IpKR1souMVyXSoQcTM7NjPOEO1r6dgKgMVVM9G6JcwIPw/8Fj62h+koDqPPq?=
 =?us-ascii?Q?Ug4RjowPhHI6EL3JuNqeAGlqSgpliyX5NcTEBduBB+owfn1TYAF9bBaJ206N?=
 =?us-ascii?Q?y3zCbqpAcoQkFnfk5bCd0qHzHamVQsK99IvCL/2eq7lsFF0L15RpHKi3NyjS?=
 =?us-ascii?Q?Z7XSuplBQasnTzlEpoyzGEkSM/8D9gbWSePLxCCueKmrOANIc11QQ7EpVwAr?=
 =?us-ascii?Q?ZIMHW11ulTLy+dlY8hbO95+L0qtXbdzxrx4Rpiq9xZoxIiFE2SY2J99Wr2s/?=
 =?us-ascii?Q?yc2/hB4peqGsbpCC8Hn/GJI49r/t1kpKbRyQaUszcPyrkgFqtfPWJz20N4Ia?=
 =?us-ascii?Q?px1tPqLjU1WZdgT0bJYNvni8UW5pKnpaUHHGQzv416BB5CYskakbCrANWgwv?=
 =?us-ascii?Q?0+jP3bQRhTyYZaFXcAKYVo6MByigu+o1t6SCafkY/4zXW4sznKjMvNrrDXtp?=
 =?us-ascii?Q?fJSsPM8XJ2vXzW19WqFsw+E7WF/9L2PbNG43ApfXmuOhfRTZpz8qtcXbyeHI?=
 =?us-ascii?Q?EzytUJnlI/OF3BzurP+4Rblri3lL0xP1zfV2KzNiMLZKN4Mtc9h+qB62E9uT?=
 =?us-ascii?Q?M4yaz5yZVdRru7Gy/Or0S8DV6qzOU/TJsLPW+eTFr/1OL4aluTrkjYYIxHDQ?=
 =?us-ascii?Q?QerScD7pRSDAUYO27HvNXi7oyBCZ3KQtGFgEx8e4SlWfeviN5BxhKzeWFA5K?=
 =?us-ascii?Q?u3SqhWEl3fIwdl1c3DoWqQnL4HMdNKPfXaYezuQBnO/4USkvgcXJ5t6JnSpg?=
 =?us-ascii?Q?rAbe70t5sYCPvyFev9+6GQJ9zgaJbcGIytE2kYW3U8LBuBh2LzPXGBOA1mFp?=
 =?us-ascii?Q?BQMEjFOYDBbPxyHN0Cl9+sKT3FbFMovTo+1oJoo9jVkX60g5YZjp0nee7RYa?=
 =?us-ascii?Q?jEgJGSK27Ahw69VqImiw6dEo+MyKKCwrO3z5BZnH1HWwBy86p6ndmWvhtaqZ?=
 =?us-ascii?Q?YINvKv7pDgV+G6UI2qfMFL0gVkp3ZjZkaHPDL3GxBQEV9qfPM892KUinGqk0?=
 =?us-ascii?Q?sITz1jvLaKXFkDQfRi9CKZSmryx0QZsfRn41xYI9nyWvURRtJ7IAG5gycjt8?=
 =?us-ascii?Q?UwYXMtZociVlf/EtufZU3naDIFFfq2r9BlepznvuuoilNqNx7FyYKjG3AOgu?=
 =?us-ascii?Q?x1nSgVwjijx2c6UDjW4b55Ih5bJjbvFtCfuIAzhqvrLFp3UcRqWgKaS3xuN4?=
 =?us-ascii?Q?WRV+WZipk0kjZbDcTYVkjQCzwA4iYwbHXWi2Gw+ciGVV3q6ddeHW6oWyaJSK?=
 =?us-ascii?Q?/NQFXcTfHFWFwBwhr+02wlLQ9OtQ0Nk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <823D3E1D603F014B8D4B1873C5B44413@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420e8cc1-6fbd-4d2e-c258-08da2dddbf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 14:52:45.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPzjg6Fvir0+uFs1AjWltpq6XJKbTboq75oLvjEpnm5AksLqfkNG1qwB2gDHwDkV9Istwp5dj55GKv/c6aGM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_04:2022-05-04,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040094
X-Proofpoint-GUID: wKOAxH9Kj2g9KMlWNM853DPZtqODkUw-
X-Proofpoint-ORIG-GUID: wKOAxH9Kj2g9KMlWNM853DPZtqODkUw-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 3, 2022, at 3:11 PM, dai.ngo@oracle.com wrote:
>=20
> Hi,
>=20
> I just noticed there were couple of oops in my Oracle6 in nfs4.dev networ=
k.
> I'm not sure who ran which tests (be useful to know) that caused these oo=
ps.
>=20
> Here is the stack traces:
>=20
> [286123.154006] BUG: sleeping function called from invalid context at ker=
nel/locking/rwsem.c:1585
> [286123.155126] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 39=
83, name: nfsd
> [286123.155872] preempt_count: 1, expected: 0
> [286123.156443] RCU nest depth: 0, expected: 0
> [286123.156771] 1 lock held by nfsd/3983:
> [286123.156786]  #0: ffff888006762520 (&clp->cl_lock){+.+.}-{2:2}, at: nf=
sd4_release_lockowner+0x306/0x850 [nfsd]
> [286123.156949] Preemption disabled at:
> [286123.156961] [<0000000000000000>] 0x0
> [286123.157520] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Not tainted 5.1=
8.0-rc4+ #1
> [286123.157539] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS V=
irtualBox 12/01/2006
> [286123.157552] Call Trace:
> [286123.157565]  <TASK>
> [286123.157581]  dump_stack_lvl+0x57/0x7d
> [286123.157609]  __might_resched.cold+0x222/0x26b
> [286123.157644]  down_read_nested+0x68/0x420
> [286123.157671]  ? down_write_nested+0x130/0x130
> [286123.157686]  ? rwlock_bug.part.0+0x90/0x90
> [286123.157705]  ? rcu_read_lock_sched_held+0x81/0xb0
> [286123.157749]  xfs_file_fsync+0x3b9/0x820
> [286123.157776]  ? lock_downgrade+0x680/0x680
> [286123.157798]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
> [286123.157823]  ? nfsd_file_put+0x100/0x100 [nfsd]
> [286123.157921]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
> [286123.158007]  nfsd_file_put+0x79/0x100 [nfsd]
> [286123.158088]  check_for_locks+0x152/0x200 [nfsd]
> [286123.158191]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
> [286123.158393]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
> [286123.158488]  ? rcu_read_lock_bh_held+0x90/0x90
> [286123.158525]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
> [286123.158699]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
> [286123.158974]  ? rcu_read_lock_bh_held+0x90/0x90
> [286123.159010]  svc_process_common+0xd8e/0x1b20 [sunrpc]
> [286123.159043]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
> [286123.159043]  ? nfsd_svc+0xc50/0xc50 [nfsd]
> [286123.159043]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
> [286123.159043]  ? svc_recv+0x1100/0x2390 [sunrpc]
> [286123.159043]  svc_process+0x361/0x4f0 [sunrpc]
> [286123.159043]  nfsd+0x2d6/0x570 [nfsd]
> [286123.159043]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
> [286123.159043]  kthread+0x29f/0x340
> [286123.159043]  ? kthread_complete_and_exit+0x20/0x20
> [286123.159043]  ret_from_fork+0x22/0x30
> [286123.159043]  </TASK>
> [286123.187052] BUG: scheduling while atomic: nfsd/3983/0x00000002
> [286123.187551] INFO: lockdep is turned off.
> [286123.187918] Modules linked in: nfsd auth_rpcgss nfs_acl lockd grace s=
unrpc
> [286123.188527] Preemption disabled at:
> [286123.188535] [<0000000000000000>] 0x0
> [286123.189255] CPU: 1 PID: 3983 Comm: nfsd Kdump: loaded Tainted: G     =
   W         5.18.0-rc4+ #1
> [286123.190233] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS V=
irtualBox 12/01/2006
> [286123.190910] Call Trace:
> [286123.190910]  <TASK>
> [286123.190910]  dump_stack_lvl+0x57/0x7d
> [286123.190910]  __schedule_bug.cold+0x133/0x143
> [286123.190910]  __schedule+0x16c9/0x20a0
> [286123.190910]  ? schedule_timeout+0x314/0x510
> [286123.190910]  ? __sched_text_start+0x8/0x8
> [286123.190910]  ? internal_add_timer+0xa4/0xe0
> [286123.190910]  schedule+0xd7/0x1f0
> [286123.190910]  schedule_timeout+0x319/0x510
> [286123.190910]  ? rcu_read_lock_held_common+0xe/0xa0
> [286123.190910]  ? usleep_range_state+0x150/0x150
> [286123.190910]  ? lock_acquire+0x331/0x490
> [286123.190910]  ? init_timer_on_stack_key+0x50/0x50
> [286123.190910]  ? do_raw_spin_lock+0x116/0x260
> [286123.190910]  ? rwlock_bug.part.0+0x90/0x90
> [286123.190910]  io_schedule_timeout+0x26/0x80
> [286123.190910]  wait_for_completion_io_timeout+0x16a/0x340
> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
> [286123.190910]  ? wait_for_completion+0x330/0x330
> [286123.190910]  submit_bio_wait+0x135/0x1d0
> [286123.190910]  ? submit_bio_wait_endio+0x40/0x40
> [286123.190910]  ? xfs_iunlock+0xd5/0x300
> [286123.190910]  ? bio_init+0x295/0x470
> [286123.190910]  blkdev_issue_flush+0x69/0x80
> [286123.190910]  ? blk_unregister_queue+0x1e0/0x1e0
> [286123.190910]  ? bio_kmalloc+0x90/0x90
> [286123.190910]  ? xfs_iunlock+0x1b4/0x300
> [286123.190910]  xfs_file_fsync+0x354/0x820
> [286123.190910]  ? lock_downgrade+0x680/0x680
> [286123.190910]  ? xfs_filemap_pfn_mkwrite+0x10/0x10
> [286123.190910]  ? nfsd_file_put+0x100/0x100 [nfsd]
> [286123.190910]  nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
> [286123.190910]  nfsd_file_put+0x79/0x100 [nfsd]
> [286123.190910]  check_for_locks+0x152/0x200 [nfsd]
> [286123.190910]  nfsd4_release_lockowner+0x4cf/0x850 [nfsd]
> [286123.190910]  ? nfsd4_locku+0xd10/0xd10 [nfsd]
> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
> [286123.190910]  nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
> [286123.190910]  nfsd_dispatch+0x4ed/0xc30 [nfsd]
> [286123.190910]  ? rcu_read_lock_bh_held+0x90/0x90
> [286123.190910]  svc_process_common+0xd8e/0x1b20 [sunrpc]
> [286123.190910]  ? svc_generic_rpcbind_set+0x450/0x450 [sunrpc]
> [286123.190910]  ? nfsd_svc+0xc50/0xc50 [nfsd]
> [286123.190910]  ? svc_sock_secure_port+0x27/0x40 [sunrpc]
> [286123.190910]  ? svc_recv+0x1100/0x2390 [sunrpc]
> [286123.190910]  svc_process+0x361/0x4f0 [sunrpc]
> [286123.190910]  nfsd+0x2d6/0x570 [nfsd]
> [286123.190910]  ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
> [286123.190910]  kthread+0x29f/0x340
> [286123.190910]  ? kthread_complete_and_exit+0x20/0x20
> [286123.190910]  ret_from_fork+0x22/0x30
> [286123.190910]  </TASK>
>=20
> The problem is the process tries to sleep while holding the
> cl_lock by nfsd4_release_lockowner. I think the problem was
> introduced with the filemap_flush in nfsd_file_put since
> 'b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()'.
> The filemap_flush is later replaced by nfsd_file_flush by
> '6b8a94332ee4f nfsd: Fix a write performance regression'.

Thanks for the report! I'll have a closer look at this in the
next few days, unless someone beats me to it.


--
Chuck Lever



