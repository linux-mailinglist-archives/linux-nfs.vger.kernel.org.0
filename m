Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67D4895B7
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 10:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiAJJxn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 04:53:43 -0500
Received: from mail-os0jpn01on2130.outbound.protection.outlook.com ([40.107.113.130]:10590
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243319AbiAJJxm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Jan 2022 04:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EbxXoWj5+X85lqMyx2HonpJNipNDWFek9VI+Ig7E9o=;
 b=ehYDfApcuC6zgN9lsX/2beshhtaDE/tyEcogdeAQPTHZS3X6I/mJ5g20UUTPrb9G74qFbHwvjrCknv7wMrbZhxKM6qSa87q6P3x9Fhppdlcqo7vWCLIGwWLf0SmO/CM1aqF4KWI8pSFZQH6ErEC2abD5zTcSw4xvhzeQGFxV+0k=
Received: from TYAPR01CA0118.jpnprd01.prod.outlook.com (2603:1096:404:2a::34)
 by TYYPR01MB7711.jpnprd01.prod.outlook.com (2603:1096:400:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 09:53:40 +0000
Received: from TYCJPN01FT012.eop-JPN01.prod.protection.outlook.com
 (2603:1096:404:2a:cafe::64) by TYAPR01CA0118.outlook.office365.com
 (2603:1096:404:2a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 09:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.101.26.97)
 smtp.mailfrom=renesas.com; dkim=fail (signature did not verify)
 header.d=dialogsemiconductor.onmicrosoft.com;dmarc=pass action=none
 header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 20.101.26.97 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.101.26.97; helo=mailrelay4.diasemi.com;
Received: from mailrelay4.diasemi.com (20.101.26.97) by
 TYCJPN01FT012.mail.protection.outlook.com (10.118.160.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 09:53:40 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (104.47.10.56) by
 AZSRVEX-EDGE2V.diasemi.com (10.6.15.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Mon, 10 Jan 2022 09:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZV/NnpNlMnZtAvO7w/7WBjGTZUWgXTJFxzpxl3sX3awNxeSI5bfAuFv0aND3NWNG4I2CFXvizqQAspl7SVE0eCxV9tV9wCapB/ULY+Py9YQd2Zn4GVsJrYev7Wrs/vqNi3Mpo2ZHkROsq89R964KddzFyi94OWUydivqaanFqYtMHyy3ndjXCiaCwok5OUyBnB1OB+OP2+Sm3c42oc0E4XSflm2J6qpl8eDJs19dkmzL6WVw9nGoJkJebCkh73TRY9IbbGi4ekoKd8U9+wGZlOdyGTLyS1Jt0GZ4h+INckB5ZgEdYwDPO+Arj9ecL9DkG8qTlknHxXyPSr30z5oKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EbxXoWj5+X85lqMyx2HonpJNipNDWFek9VI+Ig7E9o=;
 b=PBRTxOuoTX1fekcYv7MF639OhsYtgvIFDx/uxiF7uHKD+hgZOSOMzRRMVcjKpPTU3zD3T0pfOdWJQO1/unHQwFH4eLvU4kH2Lnd2RBxUFuZ+HAVyo7uiZDVv8MeLTMJeUdK235k1Yn+uZwTc/mys215vc9agSCB7xPbRvZhtJa143HObFO3EfBfgtZgZESWuOMLMCB02M5qJG+OpvBKYT1TSLnBTCtZc6Kn6O+qXQYZkB2Cuj+qbOVFyYgiMumSFrKbwws5MYkAn+KjeAWglDk/8ig2jBWq1NJFVQuLqhic9iMQrvLgOZ/XAkDcLHCJlsZ4CtizzG1wjjp1F7+Ky7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EbxXoWj5+X85lqMyx2HonpJNipNDWFek9VI+Ig7E9o=;
 b=eMomiZjF8H98VdlSXdyI5wOAke2UH9R7HYiy0INtcaSlAahSuz2hqKcAeXqbWV41CNqkU3kJQOt0NcdYWVw/b34OUHylshGz2ltDMQQ4RRc2A3X7zNF1P5QI5y2qUXNXWjb0H9vCUVCFOlI1BWDxv4ieum/bPLELcS8Psdu0XBQ=
Received: from AM9PR10MB5099.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:438::11)
 by AM9PR10MB5083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 09:53:35 +0000
Received: from AM9PR10MB5099.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58df:2419:b7f:d5e0]) by AM9PR10MB5099.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58df:2419:b7f:d5e0%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:53:35 +0000
From:   Ondrej Valousek <ondrej.valousek.xm@renesas.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/1] nfsd: Add support for btime
Thread-Topic: [PATCH 1/1] nfsd: Add support for btime
Thread-Index: AdgGB5B4QwuMm5tYT+mNbyLUFc83Fg==
Date:   Mon, 10 Jan 2022 09:53:35 +0000
Message-ID: <AM9PR10MB5099EBEF0B0EC919065D840AE1509@AM9PR10MB5099.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
X-MS-Office365-Filtering-Correlation-Id: 7de7141d-17a2-4596-55fa-08d9d41f14af
x-ms-traffictypediagnostic: AM9PR10MB5083:EE_|TYCJPN01FT012:EE_|TYYPR01MB7711:EE_
X-Microsoft-Antispam-PRVS: <TYYPR01MB771152417EF3C19B9B03ED02D9509@TYYPR01MB7711.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: dW9VDxY5RhQ/zc2irVD0C496zHWwtvDhx5BaW2PsT5x8vcKMvIp23Odbo3W/d5DGSo03AOx2KoVDlfNXEm5z011lmIcoZWEz71Z03KonoqpSgkl97yVZfKmSl+a+K3Q11GvDOn4eV01rQadTVHu4KeTh02yL0oFv4XWa1R/7HKlxbHMa/n0ZuWELT74HnknHUTzbGMrLsv2ZDVcQjSV/e4PGI2cgXnIOL3lCF7GtTAc85TpKPXNGqjn0QccyH7yBoGWEujaMEKj4KpFkK5xacV27rPVVW8vUwVoXyVhbpVkePywRDhdObT6YS8PHarbTUYUlXCwo4WZca+MbD0Fr6qmF51Sa7aYn65QcMLYClkP8IgSKIWpKi7jpv7bUCD6wWTgLoWCBDWzbeCUhGRXcf3pBaMSfduNDxcq/++lEamzeP7FysV2kV6QdGwLmWDHeCIrK6dmnOJOmxJU0QPxQ442d1iymtCGbLQDguZ2+Hl1kjzIX7os+g1NEpPbtF3+eOuYWR7apq6tdWzNtEw4bLwnZXjpKfY4JxQl+noYLoUeqg8gGkqmWL+dupzChaxh7DtGnBkr68GTEhAzo+DrpkOhvmjIBiLGzrQOljw2CpItMakUdqKtJL2K+jB8gQYebWzDbK7j7faT5IwesZ3vho5QQaN7K7t2fMah2KdVpiz8Zy2qeNEDaVWhcaUPFZKnapC737+41UC8bEKifpZO0DQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB5099.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(8676002)(316002)(52536014)(2906002)(76116006)(86362001)(110136005)(5660300002)(71200400001)(66946007)(64756008)(66556008)(66446008)(66476007)(33656002)(38100700002)(54906003)(4326008)(186003)(122000001)(9686003)(55016003)(6506007)(55236004)(26005)(38070700005)(83380400001)(7696005)(508600001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB5083
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: TYCJPN01FT012.eop-JPN01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9ee1c301-83de-4a14-ddce-08d9d41f11ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqiS9Y5t0pjXDZpbzX0hGRuPI4rnw9uDFfmBAMpY8faGFezPYVzj6pXF3FftfzB+3r1AV12/0/4shEUS5Q8+Gwq1IlH+RtIEAGE3RPqnuxFKLawMypvPs83R8T/oYUBlhHpHiFDnEdlv7c+vkhhV4zepT02c57wqaIhBPiq8BjnrX6G1i5jTN09OuQM2x1KwQNWbrzHacSB8UXZaMFGyHwgEIhhVGCzJ9DUlOuXtpfTrRq400zfnouAPlgkNuIMMLxWDYfpL8/hvYoMlNcJJTX+utSgIjn1osqaYXcci+1d6OviczA5jYaadtauTPd6QBM8kCEysAadOQI6W3CaBDe33EhS1WnJ5kOtn0HMt2JqdeyKGD0/FDRAQSQw1oejUClzPHkIlL+4wvtFYY45SV6HjAIk04CrKaLiIpK2jSsLIJv3C3NiA6Rm79YcAzoYDiU5GHdGHgJlCUJB4ClqG8Mp/w4dY4wI6vld8lFjVH/6sXjqmZG9+Qr0SRrvU/jXEurfcBgq/OF7gJqamW0y6xwK2Zko5LMOn2mml6++adaJHQQBeoa5jQOBG1GI3KWlYI0PQD30B6CXgLqJppS7WR1P7v6NF8iPEwob6BdD6ySep7BXkqSQ8Uf2Xs8CWMyaX3cFcfBS4hrWc/jA3L5Ali8zjs9mOJvfPrXKNrYUFHP7UyRpNzTKamat0aAnKkaS4WDDEXECEU0riGQ6cmyoe3yTIuOaHalv5oZj3B3s1nH6R+roiX8O9lzleL6cAIrHW7OnCjVIHGoyZ7jwqZ0SqZfixv68wZpqMKWJZFtf0MTM=
X-Forefront-Antispam-Report: CIP:20.101.26.97;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay4.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(508600001)(186003)(4326008)(36906005)(7696005)(47076005)(55016003)(40460700001)(52536014)(36860700001)(6506007)(54906003)(8936002)(110136005)(82310400004)(8676002)(316002)(83380400001)(26005)(81166007)(33656002)(70206006)(5660300002)(336012)(9686003)(70586007)(2906002)(86362001)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:53:40.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de7141d-17a2-4596-55fa-08d9d41f14af
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[20.101.26.97];Helo=[mailrelay4.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: TYCJPN01FT012.eop-JPN01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7711
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce/kernel maintainers,

Please help to submit the following patch into kernel.
Legal stuff: It is OK for Renesas to submit this code into kernel - and bes=
ides, it Bruce's patch in fact as he told me what to do.

Signed-off-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
---
Short description:
Adds support for "btime" fattr into nfsd
Long Description:
For filesystems that supports "btime" timestamp (i.e. most modern filesyste=
ms do) we share it via kernel nfsd. Btime support for NFS client has alread=
y been added by Trond recently

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5a93a5db4fb0..876b317a4cae 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2865,6 +2865,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc=
_fh *fhp,
        err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_=
AS_STAT);
        if (err)
                goto out_nfserr;
+       if (!(stat.result_mask & STATX_BTIME))
+               /* underlying FS does not offer btime so we can't share it =
*/
+               bmval1 &=3D ~FATTR4_WORD1_TIME_CREATE;
        if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
                        FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) |=
|
            (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
@@ -3265,6 +3268,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct sv=
c_fh *fhp,
                p =3D xdr_encode_hyper(p, (s64)stat.mtime.tv_sec);
                *p++ =3D cpu_to_be32(stat.mtime.tv_nsec);
        }
+       /* support for btime here */
+        if (bmval1 & FATTR4_WORD1_TIME_CREATE) {
+                p =3D xdr_reserve_space(xdr, 12);
+                if (!p)
+                        goto out_resource;
+                p =3D xdr_encode_hyper(p, (s64)stat.btime.tv_sec);
+                *p++ =3D cpu_to_be32(stat.btime.tv_nsec);
+        }
        if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
                struct kstat parent_stat;
                u64 ino =3D stat.ino;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 498e5a489826..5ef056ce7591 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -364,7 +364,7 @@ void                nfsd_lockd_shutdown(void);
  | FATTR4_WORD1_OWNER          | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1_=
RAWDEV           \
  | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD1=
_SPACE_TOTAL      \
  | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD1=
_TIME_ACCESS_SET  \
- | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
+ | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA   | FATTR4_WORD1=
_TIME_CREATE      \
  | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WO=
RD1_MOUNTED_ON_FILEID)

 #define NFSD4_SUPPORTED_ATTRS_WORD2 0
Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.
