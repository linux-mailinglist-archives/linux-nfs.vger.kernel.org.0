Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D405A1827
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 19:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiHYRxC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiHYRxB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 13:53:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E282A4B0C;
        Thu, 25 Aug 2022 10:53:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGhaVJ023613;
        Thu, 25 Aug 2022 17:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gB7g6ZFiSSnRWv4WvdZEXnCbtuc/Zl9YEHlF7CoOue8=;
 b=cDlVgc0EJgy07WxFFzWcfE87oRTYqnwTmSj0D/wGDUABRCPeCn+/5uZLqnSYWEw3l84i
 oHexcI2TOiCMPda6Ev0fM4CwR44psYMBRNSrs0hTjWyT8WNSLJZqcK9tokrgXI7m2ElI
 1ggZxaU6x9rrFE5uRq6h/8uldh8aXZygFjg6sDlYvFMnnnCUG+FPTBQEu5ABVh3Z7o49
 zJzoko90+R2F/3xr0TufNJci22cXm8XcTJm3IMc9aLQQjVwH/Wvnkqu8PLXjpCdzOhoN
 2QojU2XhQTABgH4EMwQk2vzugojRc0hWHW3nXOzcxdP4DSbDYnxZ5Z6M4mvpBsLiGpIz zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww4umv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 17:52:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PHdoUU018029;
        Thu, 25 Aug 2022 17:52:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7by4b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 17:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7AZ3DY1ISoHbC6QcW4ZX+1AGCBvrnCKA6eNiGO72vGRShLAS4q90yWwdut8x0589XiLrPRI7CmlGfiq9NqvJ/Mkd955HdcsU1BfFDe2e4YDst1KAYAc0N9Q0BKp/yscI2cS0fIjOTJx1aTUvZ4BWlcglwTOHPeEmGcEw0cO5+qBJrU2qPCZw72Nw7t57TzGeyzX+4ReLzU6vR7JMDDwbDtQZ+TGbDxNKcHnUBkqfjmLkD+fhIK3G9fr6hXm7UnLg+SY9k3xiVvez7FNNf6sDTHWH7ssu1Vzw4zVuxhpcG9muMNP04LFGjmwu0gXRLg/vOE7ORSxlOphjUyCpMyMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB7g6ZFiSSnRWv4WvdZEXnCbtuc/Zl9YEHlF7CoOue8=;
 b=a88Q6vecG8dOa9geuK0P1fskq/zZcrJ33fmhuJp4/jlROvFaNo4qLV3hb8oApsWrLWfu3UovSqgWOyQ8xdgJTUHXzzMaBwwDJ706i6DUgZpzSKOPaudyF2BhjpVmh25lBs9WWagm3q28AgUzg6ZtxXKEbjdcfIpHJAsZRnQ9g04VRvVbDgEq1pR7distnzYD46VYaVq7PJanEhllLjPfs9RaUijazFI/evS+qF4T3FpUaw8omiE/j96J2iNQrahzHFZZgzHNim/aLEEvIO6DrZjCnhIhbeYQnGtJ2+/axbryUlsRvhWx5RjgKq0ZaeVsCXPg+YGOtVpzgT6iXCiYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB7g6ZFiSSnRWv4WvdZEXnCbtuc/Zl9YEHlF7CoOue8=;
 b=u1m03iQ2tUfY0XRnycBLiMOVG8eXL6qR45aOk0KCdMiwnX2mi0K1KfNfrtvy+PWFbA5ranVf6fbIrJLaDN+5rPa1GMWXpBhUJRUx3POsxmePq3Qa1X27jYgKcJhvJJquaCIzCg9wJO/rDmZUi6qkCZ6dI8KwifJStC/AWNzcyLg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB2761.namprd10.prod.outlook.com (2603:10b6:5:b9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 17:52:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 17:52:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Is generic/426 failing on NFS for anyone else?
Thread-Topic: Is generic/426 failing on NFS for anyone else?
Thread-Index: AQHYuKuA2ydD+Urfr0WI0MTJyPLX3A==
Date:   Thu, 25 Aug 2022 17:52:55 +0000
Message-ID: <0A525E6D-8089-4EF5-8FED-506878FD8817@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21aab1c3-e0ec-4407-3ce1-08da86c2a380
x-ms-traffictypediagnostic: DM6PR10MB2761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPQNjcOjfcNndvifuaV8Ok9+UYARgHnryaJ2hg2byb6vBDPkIiZYeG1lgMDJogJKy8p0SeiAbJUHXgqPMe5MR056+t3Me5jYy3FuL5KYgfdd0f2XDS8LnoPjQehxKs7y+95R1L7Lu/gcSSi8/wrHulUM2AZYpKrrsG4Rhdws4gUPkr9JJ3uKJAnvGZofmS+NPcPNZ4K1BmRyo/BNqM8Gfr24c41A8ox/ldJLfHQkA8lzwiBJGTLycMxqYeD1JPlHlAVjQb7qoWdSYpnLmhtdxIOft5fgfZrwLzYeCNsYDz2CVD3qfcb3HYPHAsnhybsJHqyFTDNaHN+FmYa4G1x++NZF+uwPwUeOVgtTjUgXhtSfPrnO9SjUJbs0yQOFOgagWUpSbKXq3rKEiPONYC0KmRt+I2sVrvYQj33zvuo00keVhZaxW7OvZMhTAmkbFyDilUns/1ZV4rYVoIy26zUfardCNn7sRPfrKT8xpI3JUs/cz2IjNcLCMSdllJ2+V5jvvapgKtNvb+HbtX2bQBQWaJhpAsIF8qR3PoYTs5uDBg9NBAWjB24/qfUNld1znWFVK+3X8FdfVaognyEL8w0xWfy4OU0eYMXYMbBGSmy2hirUqehww+VRmmFhAcYC3xQE1xydeIC/dk97iO0smcclhr1AAR3nSGijly5luVciBtzvhZApnQ93of8GwdWCUSvITRTueQPIQLKVX/RgDUcsKd7xVTw/p9RFdR9LMtnzoKyNTh88M9pwQX3Tvg7qpqo2PZ+0XhhYXnUV6sZbsy0E9cOKAfmvGyBiGZU3sSkzss2tvu45uo6ppsATV9Aeium+2udAEXNHakxu32KezqsbWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(2616005)(83380400001)(76116006)(186003)(38100700002)(86362001)(38070700005)(64756008)(66446008)(122000001)(91956017)(66476007)(66556008)(66946007)(316002)(4326008)(36756003)(33656002)(5660300002)(450100002)(8936002)(2906002)(6486002)(6916009)(478600001)(41300700001)(8676002)(6506007)(26005)(71200400001)(6512007)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1QybNBYOfo57l/sOcDp2KXXIfo5TxtXHeagP1gQfLepNzaMrKHEgnxsldNcj?=
 =?us-ascii?Q?dPlBEZr3oGg3FPTcCITyr0ht3foCUpi8F/rzI3xPwVGGBwJd0AlbwRkg8AzG?=
 =?us-ascii?Q?XBQvSEeqU/5T0yxUxMeOfv6kAgyNY8JXZteGwcvGwQJXq7CDL5Qf4E4ORb8v?=
 =?us-ascii?Q?qlE6NpEX4cfcdZ5dU9J55rcXdf6sXcHD4N43IshlIc1mSWuyOdC2Vvkt/d/1?=
 =?us-ascii?Q?O9C4rlZHxya10cI/1E8ukFLQ5B7UwATDNZHaBWKw4zngepoDcELZyAEUjogV?=
 =?us-ascii?Q?LJJ0VDhBduYbXtIjMx0Nc/JyNOOQ1CmrEzq2BCaRwz88U3NwZ3kB1fpLkcWb?=
 =?us-ascii?Q?3406gIoYZIn5lnKt6ET/gdJmMUL/tg0lHIlaImRKdRzkCH9Q/sjbQFp3m/Cf?=
 =?us-ascii?Q?JinIyMTtAUn0gaZ4qfjrRkK+auMrtxpu2c1MNL35qU4Y2b0LQOVK6l7w3DH8?=
 =?us-ascii?Q?6+wJXLa4v6w8C8VDeLlCOs+iRV2kRR+P4yI2Ed8oGxZHfGVinnSUxcZCKQFT?=
 =?us-ascii?Q?Xg5zfczGLuEM05+BlVNBVD8TYzf4sPdt42xNtknqvCC1YZRJwMBmzkqZR+kC?=
 =?us-ascii?Q?rlbdSOtwyNRCfMsDG0NqyS8MiOqJ0QVbz3FZxfbsnZLc/tnJrIc+RuJpOMrP?=
 =?us-ascii?Q?TLPjtediO83Uk5gESCiXKRuR8gxc6nPJpYgjB4a6L1QJKuMdRhGejEXypJoG?=
 =?us-ascii?Q?fgYjhaZ9BbGaiYCvxkeJHAqg9rQxpRDhLO0kyyxDcMuBdsHApVDdgfwDMICF?=
 =?us-ascii?Q?DssTkk8EVXPqNLESSeZJvj+IL2em9a810XqTwlnMEWhYGX4bdp3/Az+TJjcl?=
 =?us-ascii?Q?UWe8ikn0T4kInOVL/RWmOU99edQWfycY/Wk7z++Z4GuyIsFuSDSQ5sqSTEYW?=
 =?us-ascii?Q?biHnYFb21ACKcqOFhdTvH/G6sFu2VHoGVMDwP/d4uc9RAxrn+gedSHIRDu7T?=
 =?us-ascii?Q?//9dpw+0ljr8fUZUiFJShwe4ppEtI6h+eud38WxuJYkvFjTxTt9n46yLomeI?=
 =?us-ascii?Q?LCT36DkJUFpCI3ECszfPDXicI2gM0Zlv+I0TAO6gp1ufeRtLcPR1No3mIZ7q?=
 =?us-ascii?Q?Fe6WK+hIcaf1xSCw75Lil5JRIcaQnZLJkK6JIK9BVp8A4QWkNA/EKdVxmcFx?=
 =?us-ascii?Q?1WVE9cDJxQEVkH2s4c6C9bH0v0g0ggOASSdY/Qnf7AdyUcoFFeFmaoNrK2yy?=
 =?us-ascii?Q?qhPRCT0a3gTVhfObeLdVRCVteYT9+VJzvxI7CTRlPLh/77IQJAGlE6XmsyMB?=
 =?us-ascii?Q?w03iSrvGqodCEE00EPnEAECtzz0hkOnS9WhW9NOCb/Iq3nF3Y7x2M548vFZ5?=
 =?us-ascii?Q?vxOmQYs7pgAAlzzPXHcklqtqhb5HN9h8OlUcjGwwXPqrnLAYF50gAoPYgSSy?=
 =?us-ascii?Q?HrsRE3HASf7LRPkHWOEJOMKgT7BHVomXcNOH44b/LtfHtT2ZPG0csD2SrG8l?=
 =?us-ascii?Q?ULwZi8a+VnKNqwnGl1ijFQXn1B1WuDAwg86tpXgR/2b0kVuRwTZhEC4rW9TR?=
 =?us-ascii?Q?6COtlDGcvOi0uqwdMyL0KtOO0Ql4uoy/Az9gzTk9jfi4GdMCWoSx76OTkZ5E?=
 =?us-ascii?Q?pCH4aT467qw2pQdImvCMpwF07ZS1TaIAesNquRSWjAbe0bzZal7wPDiiAbdR?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C6F42EF7BFEB34886A22E98FBFD827B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aab1c3-e0ec-4407-3ce1-08da86c2a380
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 17:52:55.0902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TziK5IE+Ytyjo57tspbTyZX1S2FX4tXoS+BN6gARQpcdd+VWQHXcsOiOA+QmPrP4dTuLFRGuAy5SVxho8zM5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=882 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250067
X-Proofpoint-GUID: JMdPCTSgN3hb7Ixae6QIsNDbj4hWNG-W
X-Proofpoint-ORIG-GUID: JMdPCTSgN3hb7Ixae6QIsNDbj4hWNG-W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have started to see this failure with some regularity:

[cel@morisot xfstests]$ sudo ./check -nfs generic/426
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 morisot 6.0.0-rc1-00001-g2d8cdadac0d6 #132 SM=
P PREEMPT Sun Aug 21 19:30:12 EDT 2022

generic/426 2s ... - output mismatch (see /home/cel/src/xfstests/results//g=
eneric/426.out.bad)
    --- tests/generic/426.out	2018-03-10 11:11:33.483657919 -0500
    +++ /home/cel/src/xfstests/results//generic/426.out.bad	2022-08-25 13:4=
0:01.174779476 -0400
    @@ -1,5 +1,3077 @@
     QA output created by 426
     test_file_handles TEST_DIR/426-dir -d
     test_file_handles TEST_DIR/426-dir
    +open_by_handle(/mnt/426-dir/file000000) returned 116 incorrectly on a =
linked file!
    +open_by_handle(/mnt/426-dir/file000001) returned 116 incorrectly on a =
linked file!
    +open_by_handle(/mnt/426-dir/file000002) returned 116 incorrectly on a =
linked file!
    +open_by_handle(/mnt/426-dir/file000003) returned 116 incorrectly on a =
linked file!
    ...
    (Run 'diff -u /home/cel/src/xfstests/tests/generic/426.out /home/cel/sr=
c/xfstests/results//generic/426.out.bad'  to see the entire diff)
Ran: generic/426
Failures: generic/426
Failed 1 of 1 tests

[cel@morisot xfstests]$=20

116 is ESTALE.

During this test (on NFSv4.0) the client sends an OPEN(CLAIM_NULL) with
a name of "/" (confirmed via network capture). The Linux NFS server
rejects this OPEN with NFS4ERR_BADNAME due to a check in
fs/nfsd/nfs4xdr.c::check_filename().


--
Chuck Lever



