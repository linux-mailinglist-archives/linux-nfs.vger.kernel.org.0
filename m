Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430F9683875
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 22:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjAaVPq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 16:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjAaVPq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 16:15:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9734A47408
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 13:15:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIirml006159
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 21:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2022-7-12;
 bh=QnIpKdOenhXMCbUwwwfpTheVijatSEFDGt1YQeoM49g=;
 b=zJBT/IcUqRbgNmxmRJJ24Na2F3YnRDkLhTWdwMH27ObFjPgWlFVKd9kVgPnXlanum71h
 S+TnVX08i4KTTPCrCFVGgyXq9FyAc7oMnwSSgu7IB/zlP1/3NJ9B/k1Pyb68Xo0aPzxv
 MSlpsJH2+XB4q1aJQGmhs9ePnheOhIIquwhnSNp8dR7QVG7ZhwnNtbWsXtOF2/kCHUep
 GVsauAVNhG49l8ay1ETdIz5B//7e1wKEmzg9y09txh7eiIFIilC3vUbRuNB1oRscHu3+
 8G44jzUFC1SFr7AdyyBTCi4lyTq00J8lsHCR27uXnfON7aFlae+UFkJVzYAG99rcOiQA mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvm16txm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 21:15:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VJfDCI031835
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 21:15:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d3muh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 21:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVj7GLEU5tyeEglWjdb2W0iYRQsrEKXiQvzXYVV4tzUYQzoZWxCQRD5/JmW2X0bxLDCJqxzpmZwO72e8YnLptklz2p5VcG3wFuaeiR2x2GKh+nzM6Lhm2YsffYg/IkS1Q/MiczsKVZg8cE9DwAX7m6RCR4YYxz8X/JDdClKTblux8nUY9dly7edmsc5t+lWNZF/95LWu/tKwGx/3kusaFhhS60X/oDlSy7LZmb3SpukjgmnvGdPFlPTbZvFv1WcZ5RdyZxgXBQZMKoglFzvjCoOI5Ewz/G/ODNSSwnHrTSrPeYk8H/24VgH+Y292IGI3FXdfXM/Z7FX0dovRa1FP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnIpKdOenhXMCbUwwwfpTheVijatSEFDGt1YQeoM49g=;
 b=mves/vjkzjy1VR8jfIw8Hm4g3zkDxnwfjm2i5ey68Yq3Z13Ii+U/0qixOb0mg3x9dZhla1PvuGSCcQK6o0H4yg+VYEG91mGRkjbiJuxIhDhQKatKQ3kfMnkuck6bVGbuqtZPEAluZULzsA2FEvRVcNyjEmY/kwH2ArEaRaG2ctKvsr/ZksuX7Fq1Q2lI7/rPVHChMK3VrqaRumYa0iOUA8NS1rgwRUwxsJBk7CuNn34xqf6G20REpPfsyCrfD7UH03QCJesuGFUpwKpLhUNsqsEdeXjnYHhvRDpp+gkDWc30MH+19yIXr8gsdCpm7XO6NLJ0rkzRE3N0gMpRqfGIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnIpKdOenhXMCbUwwwfpTheVijatSEFDGt1YQeoM49g=;
 b=VC2gEvB8PRH+2eqDT9uUT2G+j1M08gbiGMGCWoMmjYBjtFHm7Fcs/UikbNz6DxfVWntXcsJgmdCYnNBsZdjo+rvmzsfwbiTQaTBT9GBRfn14GYTQ616HVgEaZzZ5rT8O+a6JKGVrX0w+lfU3GSlpQoLGYi8M1KnrcWn3ASVKEM0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Tue, 31 Jan
 2023 21:15:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::96a2:2d53:eb8c:b5ed%5]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 21:15:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: git regression failures with v6.2-rc NFS client
Thread-Topic: git regression failures with v6.2-rc NFS client
Thread-Index: AQHZNbks6EbZ9+Bo00OYN0rzWVADpw==
Date:   Tue, 31 Jan 2023 21:15:40 +0000
Message-ID: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5548:EE_
x-ms-office365-filtering-correlation-id: a1d9144f-be65-4b8c-d22d-08db03d04e94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PpOSKf7Ur1ClPnnsEXIdGujCf5CxlI1B/Eal67LbEiArVHQhVfo7bmv7Q/KHjBIGfeHFMY1yGE9y7UNyZGHe/4Vl7iLMPz8I6N4/hFfi/vBTeaw+GgQNCYDGOHwU8g+UExSQNLBbmu785LMi6vWIlCnEI3Q0PJ7buDWEmCbTKkzm/acyOrLcYcEa4waxPk9IbQSPpEkaDECsnZ4X6u/wDK+oOcOZjqTjyMF0UxnP08oi5LpG84gSQwDyXCIhYnz4yTfa0QsIgIlxSVJtAPApdJmxG8Y86US8BarB/y9EWZrEecOeuwBJjCBKvnH9oKQeAJ/SW3/lf2lYwtqcJbmsXqIQ8tEs9P1CXveITIV3TmbMElqRt3i+oiQSaWPQliQckMgc0eT/+NJ5oslZw5TKZ97Oysvgkep3J/MiOrXwteIhHXNiAvsISoY8r12Tl6cj8PEsTeHG9H0xaVBoFudUoIRWDUSihpXb6/QqXDaV1japiv9X8Oe4dK2ZSz6nHaj3bDb+RvyhltrZLXlDhuI3y58wza15jo2jy4Hb5bp2aRYNYtjMg9uDryIjLLOdzBArlOnoCNo9x2vrPba+bfL3Jk7evWyWby7llhjDOycRcey39EvAUQfjluokY/G0z36gCbbBK+epq+pcgzhDKg9Kx6x54aF+HyxC71giDqnUdQxQa7fu+lbblFNvi9PKjjD+Ey2eZlDWAscDD4gMRd/MXzruLGH87ToTlwAK2zvMv8hIU5qNRlrn3eyaPmBNGR9NT+hnM2orI8Ic2JwlaXmWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199018)(478600001)(6486002)(966005)(71200400001)(6506007)(2616005)(26005)(186003)(6512007)(83380400001)(316002)(66946007)(41300700001)(66556008)(91956017)(76116006)(122000001)(38100700002)(64756008)(66476007)(66446008)(6916009)(8676002)(5660300002)(36756003)(2906002)(86362001)(38070700005)(33656002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lyaDYGtjUuyEjru+yIATHWIXnk/A7J/znOHiAJoIGmDMOriG2ZRy89Mc7f02?=
 =?us-ascii?Q?dnIaKXyJZLUysU8gft99y9oh7djxpMEgISxcW1/1QkHltPo65GCZnWWjTDHL?=
 =?us-ascii?Q?7JJtc/fU/vunjh3KEo7xhtnZ4IKoKoV1buqVKpr0XL50GoQBbRwDor+3uQIs?=
 =?us-ascii?Q?kwDG2cUmIdY5U5fUCgEW2/A0d7PdEat0IDMxj3GaTPhTh/zh/pPPW011KY6Z?=
 =?us-ascii?Q?e/vRGbFxBmKBwvqdSlSs7sRc/+7hWYqJctczpKCtOHCkQ9ohObkskHT5wyYu?=
 =?us-ascii?Q?j3M1rf9aVXN+YMkGAuqeHJI6JTZtdm5RgbFDiaOoGxqL2kAbmQCH5v367u8J?=
 =?us-ascii?Q?CzzU7aa78JvA1c0tJ5yDRD0xYKQMf4vy55I7gG4cofrm4UDtdP3Vd6eFS+P/?=
 =?us-ascii?Q?aa68O8Fwcu45O2oMxsiCdkHuM7HucqgDM/UVLOv8abn/H880k8bGPzGCCNHj?=
 =?us-ascii?Q?0L/DkV3hCgQCDBx7cfrr67pfQJPcGUYDaOfh4/xAOT3SXIRd975eUWZBabz6?=
 =?us-ascii?Q?Tcgg9U4lt3bhsN3ca3VW1y7d5yaaaUxtTjND9qjFGoUPqBiZR7//knP8nA0C?=
 =?us-ascii?Q?TIDvPYJ6q6NdkGteFLSMK8+zyajOzUcs4vLRjbZfXVnH7DZQOZtECI5BeBaX?=
 =?us-ascii?Q?8lWhAWaKeXuYKMxYq2EN67/Zv1BZae/H0JZsCu6w51zn70K8quAohQ1gsTKf?=
 =?us-ascii?Q?pqKN5lZ8kCafnbzrcH9BAVcq9v0bAM6o+aF5OnaJheWS0YzKdMuv1hSAg3SU?=
 =?us-ascii?Q?Rzd1hjXmGnUYWBp3r1v2lbaL/2SfDUe9BI9aNvGOAbojwGm9bUNQnPL4eL3H?=
 =?us-ascii?Q?T8uxUoShJ/v4LCeoW70O/DlsfSXcOcqx2P/8ytOO1agQDJ8+nhzChGeshSXH?=
 =?us-ascii?Q?8GOwh8LMYgMGUiJ3XI5tYorHmjVQa9gepprhC0zcASxMRbbJCNjtibV5NkPa?=
 =?us-ascii?Q?WMa+Jg4j4c+XqMA6WQ5vQqzWoUOBoPCZGOiGa5MzRaIj6J2pFpRQyjv891rH?=
 =?us-ascii?Q?rpFWnSOy5MEHvOTp52Iz80I3qV8KsdCRybqObqKKduYIhoSb/DIw7Jtzy/z2?=
 =?us-ascii?Q?L3jW9V+JBAIOuQy02oKfQS/zO1Mb/hHWgLngoUDCP4ZZp8xH7G25qJS3A4O3?=
 =?us-ascii?Q?lbS4dt1/Nk9nzzsGF6JcnRNa48hfaNw7b67xNYyVlREIqImLlERGXxcmEw2g?=
 =?us-ascii?Q?wLYOdLoxkNa7GHN4vzWO8yiGQJbtDJqtdJZnh6SvsBXotqP7k1f38YQsp0/A?=
 =?us-ascii?Q?nfaC4FYS2A5Xrm1n20UMcFCcDJxh0+BSPSNOF0+FoMmjnkBMkdl60WZv1q1i?=
 =?us-ascii?Q?KDtoKPZQq4AwG3bcPDMde6XDQxQhMKL2xW0wbQj4ycQIuR/n6hLxGkqeZzJT?=
 =?us-ascii?Q?rZZSEbj3kKHca2+KLevAkdCwJ6auY592LGuuwevb3SUO8JCzF1bChQ5I1dV8?=
 =?us-ascii?Q?NPbGHOD3K6H8kIJC5oWO8WoRDbTqv5DLBDHWzK0hxdDKi8Jxb4VZRPA6uMuL?=
 =?us-ascii?Q?ZjQ0jCFiKeIzvFGaJOq6Oh25RxFsKJJjYKDoktVRDeu7n084hXeRPkphQHzK?=
 =?us-ascii?Q?uSGQ15rnefg6yRY4o9z1Z07AMwBtBdVnwVkJ9X+kKZE4j72pJ/BQNNMdCNIh?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <895D61B6BEB59D4C9C25D1F8E03FD2E6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H5LEH+zwtRHMFP+uZOcPMZte+Dg+h9t9YEouFWItMY0b6iGm8ajLUw73vo2jV4+RsNVukDvE45FgfXI32St3FiOzvBt5bLbhpst96h/B0CI9EAzzMdE2aKjVz6/pSvJddp19QKoieXzDNEs82IUWMWUnoxp+xXiMR7M/od1lvOmqvRykhvQh9zqR2TdxNmPkd3eg72l5QlVEsYoq2B/5d4C9tR+XQuqbQyzShq5cZjaIa2r4u29pfOxB2oBnsGfLjYvIXUJ4lh5r9qd0sOcUS/xFF8O4KvkY5+BN/v2UfxscFDfaE0a+D5xDE/juITALyqxtVnQTBjgh7DtgKceINrzZZ6VO0Wl1gNk8emWKYkmY3VvoNbXrrLekMCHim2sKqmxfKyiGDyOvJwAjvRvqng/t9AEHTLbmIA/wUhMvMCXu1wfeC7nPTn8sLCsJSoD5IE1qTpLDBHhrvkS33hIl7r2k+3ZP7WqZfYQ1tqmiFf4eEooYxPIgEAZmmFhs8NyVrT3UnU2pBl/PA069zHQCW5u4B1awYV2mibJmfz2mYJ2noqSTEGujwKRypt3Kujp+nzyNoN65v444kdDohy300z76qDeKb1Yeew2BpsE375IHMLxQFngCDu+7NavekD566eYz8IOeohyvVDJbRCvEuea+gCz23qriBDJEamzE8Ug6Orgy1TOLbLRK5UXyPdqrG7meWoTKshxaCk03D7cTgzH9inFTbeiCBlQrx2ZxvX1GtBgrsakLYcwNmpl8xS6TE2veD5VD1uoZkw72ewha+A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d9144f-be65-4b8c-d22d-08db03d04e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:15:40.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qlZ65Q7BMHazzNk8XabGUzNkC0Tc0eXy+gvxN7pxHl+FKfbUpkG7jYr5k1S1UCzk07u/fHsRvXbxVnaNLcIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=949
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310184
X-Proofpoint-GUID: 8mVQHqORHk-5_vKmbNyPuuGl6oMEhKs0
X-Proofpoint-ORIG-GUID: 8mVQHqORHk-5_vKmbNyPuuGl6oMEhKs0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

I upgraded my test client's kernel to v6.2-rc5 and now I get
failures during the git regression suite on all NFS versions.
I bisected to:

85aa8ddc3818 ("NFS: Trigger the "ls -l" readdir heuristic sooner")

The failure looks like:

not ok 6 - git am --skip succeeds despite D/F conflict
#      =20
#               test_when_finished "git -C df_plus_edit_edit clean -f" &&
#               test_when_finished "git -C df_plus_edit_edit reset --hard" =
&&
#               (
#                       cd df_plus_edit_edit &&
#      =20
#                       git checkout f-edit^0 &&
#                       git format-patch -1 d-edit &&
#                       test_must_fail git am -3 0001*.patch &&
#      =20
#                       git am --skip &&
#                       test_path_is_missing .git/rebase-apply &&
#                       git ls-files -u >conflicts &&
#                       test_must_be_empty conflicts
#               )
#      =20
# failed 1 among 6 test(s)
1..6
make[2]: *** [Makefile:60: t1015-read-index-unmerged.sh] Error 1
make[2]: *** Waiting for unfinished jobs....

The regression suite is run like this:

RESULTS=3D some random directory under /tmp
RELEASE=3D"git-2.37.1"

rm -f ${RELEASE}.tar.gz
curl --no-progress-meter -O https://mirrors.edge.kernel.org/pub/software/sc=
m/git/${RELEASE}.tar.gz
/usr/bin/time tar zxf ${RELEASE}.tar.gz >> ${RESULTS}/git 2>&1

cd ${RELEASE}
make clean >> ${RESULTS}/git 2>&1
/usr/bin/time make -j${THREADS} all doc >> ${RESULTS}/git 2>&1

/usr/bin/time make -j${THREADS} test >> ${RESULTS}/git 2>&1

On this client, THREADS=3D12. A single-thread run doesn't seem to
trigger a problem. So unfortunately the specific data I have is
going to be noisy.

--
Chuck Lever



