Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F667521D4D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiEJPCj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbiEJPCN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 11:02:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B342321D52
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 07:25:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ACrcdV024483;
        Tue, 10 May 2022 14:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iINMK9dPU/k5dpWE40exS3kwgKfW47pJhrb9b2q0DY8=;
 b=S6XjEhxHU6Ng4EzeLfuc2zZBgWtTElAbj3RlC7dO7Iw7ekaH2G/PqUuNTowcxBuUoT+6
 CLStP0XWtKERO3GC/NxxuW7xCoTYf/0gbdIx/hHXTtErhVcwECn7eucnKx8XTkPyKRzp
 ypAP6t5ys5uYSZ4bfnl7r0tYHlLxOqjZbpr+p6pFQRtUKIsN/0t9Km3n6pWmHqz17Hvu
 GOtJm30a8ZdoEotCvgFdBKW6l94DGR4PxSFAIh57P52OIilzySN/MOBKJCIPtH6Z+HoX
 RgBgt+0Q1NlbnZjDgb6eI7nH4KdxQUFB2yRAZPLZg/kcQnar9qNywMw1srzmvnHPpyc1 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2ex7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 14:24:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AEGH14036288;
        Tue, 10 May 2022 14:24:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf72vnwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 14:24:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrAGnz7gHOWZkEA2sJOfAcfN19wCEExLKHxdv8BG7ruoxUOp/3O0c3BR1SpRbB0MnFQBE6vy39Ho/GGt5BvOZM6HEp0uSyozP3W/kvbJewfr3mCrTfmjZXaZJ0ExG+SuCz0OpfEXNeG2NH6DWWNLmqxqK7DO1OQaomxDDI4qjFHTTJTIj+APxH6EUJyDK8ywHqo1mOhkLEXM+M6gYH40YJD4lrO2047vMzTk2lF1Ovaw/cumMMo+LkIWM/Nj8/Z/opRQTAf3EKGGtH/6mD9xfgNw0ZmPw+Zl1HHCLS85Rh0gYprYi50AYI6pbTVWCUJqT525L13NLkCk7Wu8iAMSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iINMK9dPU/k5dpWE40exS3kwgKfW47pJhrb9b2q0DY8=;
 b=UMmaI88JUMcdLLLpfxSbFZaDzuTnOcAmcP5jalWnvKaFlaQ//cFvQ4wV6Mv32ZclVERqEY4Cf7Vz0OEIroObVaH94nQAvppfrUlnEz46IFwrnUQQXvUItaNmpZbSHLX81kxDBw5dK88XSGTNZVz+T6p/3gHb8CdaNdxm1d7s8iz/OZjA1ZEBIem6OMOW7TiyJQuVYp7CTOHSMzJ5Sx7Zd+WvwfP0qLWZ9CzvERgGv75G1TX9w/QgwhkmcBUkerQ/Yv8xt/jT9hHKVkc70TtcJeRpnSt8n2Is6HQMqrf/Wx6woGwtoRA1Upxi3hkEDVhMtD1LpRq0mnSDHfCY6Ng4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iINMK9dPU/k5dpWE40exS3kwgKfW47pJhrb9b2q0DY8=;
 b=dLsX8yNI7Zl8pF4u1udnqZdjTqIX2E7heAA15wbLOhoK6lQegzXQttuBID7aU8HSVghYvRWl5qFv2InGYmI3g1O4yEwEP2VIdOoZabOGD7jhhLJ+DZROaBf45chwv+63nGBNI7r4U0Ny0ToZzJBiNAQvhIGh88mpsHV7Gn9LhNE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3599.namprd10.prod.outlook.com (2603:10b6:208:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 14:24:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:24:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Topic: [bug report] kernel 5.18.0-rc4 oops with invalid wait context
Thread-Index: AQHYXyGPzdf4A6mimkmk/DpMpv4nPq0YNS4A
Date:   Tue, 10 May 2022 14:24:56 +0000
Message-ID: <ED29F5B7-9839-4BCB-AE97-AAF776D95B28@oracle.com>
References: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
In-Reply-To: <313fcd93-c3dd-35f2-ab59-2f1e913d015f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12415c4e-f5db-4b84-5014-08da3290db8b
x-ms-traffictypediagnostic: MN2PR10MB3599:EE_
x-microsoft-antispam-prvs: <MN2PR10MB35999EDC919614A0B200E03193C99@MN2PR10MB3599.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPF8DeK9jVj6oeefTXZ9FOoY8qhyPNNUrpCE5xbsz9hljrR4CAULKvCCarEhbR1biqewewdMKJ0ZwmtgWsV9LU0JNe+n39xWZopYeXWjEdgVaxM7aM9miIOnHfpKyvhewIUV3INO5L3apgq5NVCrwSGjrqcm5AuG9jHcOU55c+NZVHO64WCWwjXiXM7uiLeBVKFuY+i+hpd7TwQqJm+aMw1oB8u3bRAed2SDNKhmRptYKV7L+cG4vebZrPmtf9ko5ngbNi9fDnJRVcl6kaXa27TKUTbStNZ7QRM0e0blpTaRaE4p4Zkg89UB1MBBvsxw2kRoOzqi7aUe3Ec76rgZz8WXa0eEtvJ6ftQI8XL9OnijZ0PS7rSl1ZiJTvjPZM6qbcrwfC7aXaN+/WH+PZtCxs3KEgB4LTPQBg8nRW4z6rpzZ7/4PyoWFcW+UD0JSck3UqBiHzT7NLhBuPaADQrTWkSMDEQiMBLjXqJkuS0BoSvB7PTR8i2t3KIXRZxKKtaxWPn5Npnq4Dnzg/s+8K2kryNxWB5w2Jxwf74u/I3G6p2lZEEaT/ZJZ84F42W/b2ygnC1IYRMuI8Y+OPpnbLCKXzQHnKOwOiYTakgMy99r3mCUihzHATQzMKOh8KzScbHzAfJnUxjJ5/JNJpDSlIopQ0cQOOYy028giXPz7YtDys0G64kyIEyGPdQo9INa2Y6yBRJMRCLsexEYmgvv+0QA6kF/DDijZ+w4YRep9rPYMoOzSIBLP6tnkNMtZhnNcw91
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(38100700002)(6506007)(53546011)(5660300002)(6512007)(45080400002)(36756003)(8936002)(186003)(2906002)(83380400001)(38070700005)(508600001)(6486002)(33656002)(71200400001)(91956017)(86362001)(4326008)(76116006)(110136005)(2616005)(316002)(8676002)(66556008)(66946007)(122000001)(66476007)(66446008)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WnkrvUcvzNwsz8ore1qq1j/OV0pGdhYjk6JsyDlIu1vCFG1y7CnuVbySs+ZS?=
 =?us-ascii?Q?BCxEuih7QrjOzqs94z90c8TgEZhk8RCv7/yb1BnDisd5NQtS3hiAg9lSeH3J?=
 =?us-ascii?Q?rjWvl84tDzcg1/96jq+yqd3fK7JKQk3F2M1TeBKP7jXu8JcDL8QUZ9/jVUju?=
 =?us-ascii?Q?XkyQf1esPM6sSuIslLdnzwlHy6n+5e1Tls67nGT4+P40djfqILxquFU/qMQw?=
 =?us-ascii?Q?1hI0VaSUA7KNdpOgr5hU2ETnifxQr+jLOB99jPsIoaBFuCvFe7UzOY+54qwZ?=
 =?us-ascii?Q?B3OOqTymxPTgYhFSGcI8akHoXxPFYXBccVZYRFJxaJrNoxjQaM474Sl0PIVt?=
 =?us-ascii?Q?uyZYp9W7pVoAqitAO1JYZkXcvNQ2m/EtcTIXVGmgm7cRedw3s97AE6o6xxqx?=
 =?us-ascii?Q?iXxIYrs14yf3SvhQubQTLDiq6SVSwZL1l8f3YvxI1GsZ3epCpd1YQYaYcfJv?=
 =?us-ascii?Q?9Yz7VJ4rOKOvNnQzG2StkhyDQklyVsr8yUIJq0XbNs+8TLABdf+LFx52b2lL?=
 =?us-ascii?Q?HA2QBVo0kADomwZ8VnBETqvt2HhcRhBIfr2Sznx0HnB0WvSHzTCxdzbB+kSw?=
 =?us-ascii?Q?dThPwFd8uvDSK/99+o9OF/JzQeVXjFeb2BnANJUfpmQitceEf01d35zAyhb4?=
 =?us-ascii?Q?qqRRcswChlVNQq3N5pVQh+kKm1GkaZ2CTDtmHKakZhKQuOafII9Elqq6msg/?=
 =?us-ascii?Q?HIN1M0T6MU7OiwlIqemt4JikSl8WyS1BxTFtf0Vqv1rRsKbjRfl5ZbeyHBSb?=
 =?us-ascii?Q?c7NTe2LpmjS8g4sgev9B+kbiVpzgFoV6zfKa6AQj/+ABHKsXllNmZAV8aniL?=
 =?us-ascii?Q?0l8tqgaHpcHnzUomn3jzNqDim7XdX9gy5U9BxPotNYqq7h0UIUBHV1df4hVD?=
 =?us-ascii?Q?Zwr/WAXlGcdfhKZttzvZTcl8/1MP64tVzcWXoJmMbUS1bKxF5p58ta15Hw+R?=
 =?us-ascii?Q?h9a8W6gTKUsqWmhCMv7yYCJm4hTPy0JNJcWev1owiTwCoJvA6oEz1J3FsBPZ?=
 =?us-ascii?Q?iL9L+KnhqoGS2RX5ztmBmmYQpXD/1nT+1sTiDNCgPvtKhqXgO7YhIdh7xeQL?=
 =?us-ascii?Q?nHSEkGdBNuLg8w3mt4N91y65o4t1mPb15MDiEqV1L3gVCm/MEYQ5OQqLQzZA?=
 =?us-ascii?Q?lkiXKnw+jlXo+Fnf+KI9pDdW1TCeb1YaWGKqoplA8MEVLS1KYOy71O2a1652?=
 =?us-ascii?Q?TmRYl3YMkDOswRajfVn32qFtNF94ODzCYjqrywD9VzLC1tyPh/yLGZQyYU9H?=
 =?us-ascii?Q?jWkFu8HG3E9JzgVY+9w8dsdZSu9hnM7EM9FfNL6YkXVnpjcIiLi5tunaG87p?=
 =?us-ascii?Q?bqJbA+Dl94VPzisQeHYrtTDovWTBtzpbqihnmrl/i/W+lIftkUwVOP2vr4tO?=
 =?us-ascii?Q?vAOUF7xaplD94JAFgRuPxPYlmAKNfNI3Zv+hqxTQod2WEMFps0SmDEiZFoxQ?=
 =?us-ascii?Q?kohhUBTIb2hd0vGrwjFeZoX1FFirDpjlM3IFPhdzMM1rT0jlqFXoTsl/uNRh?=
 =?us-ascii?Q?JVlKz3jKWfUnS3nmlN6UNGkkh94uqclb5i9rgRh+tmTQmRK9ZbMGPQhKCNks?=
 =?us-ascii?Q?7V8PUNKJcKDE0b5axG6A88sHK1Nny2Qb+4pq+DeOVqGiVlkVMDSCnYUXwUV0?=
 =?us-ascii?Q?iFcJt2ZqPtGy7dMgUTmW/h8R8V+tSVFCTDue0pucWdAXT2TEdnDiGaF4zS+l?=
 =?us-ascii?Q?p8YDYxmAWfqkMaMlqFar1s0YtzpqDIBtlnIgwnSkEEMNaJS+EfT19TH2PxFD?=
 =?us-ascii?Q?xsFWdz1e7GCnsZqBEhg3KvRpZAkzAVU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <302E71371BED92458345978DAAD8CDF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12415c4e-f5db-4b84-5014-08da3290db8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 14:24:56.5897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cij16TEMdP73IvZuJIznSBUnJwn7ryc7cLN6ywzOrGUEq725mx9+0OHQ6TCf23tSc+qVjtiuBMlI/t6s2Dsmlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3599
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_03:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100067
X-Proofpoint-ORIG-GUID: J8iQNFJjT2zfi02vVACYGFIzwZu00pFn
X-Proofpoint-GUID: J8iQNFJjT2zfi02vVACYGFIzwZu00pFn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

That seems plausible, given the traces above.

But it begs the question: why was a vfs_fsync() needed by
RELEASE_LOCKOWNER in this case? I've tried to reproduce the
problem, and even added a might_sleep() call in nfsd_file_flush()
but haven't been able to reproduce.

Since this was 5.18-rc4, would you open a bug report on
bugzilla.linux-nfs.org and copy in all this detail?


--
Chuck Lever



