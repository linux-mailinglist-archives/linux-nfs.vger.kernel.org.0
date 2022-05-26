Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70EA53566F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiEZXjO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 May 2022 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiEZXjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 May 2022 19:39:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958509CC8E
        for <linux-nfs@vger.kernel.org>; Thu, 26 May 2022 16:39:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QLNqQ4011997;
        Thu, 26 May 2022 23:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aEnjqn0zdeKA9nXgCLI6v4EmjJIn8Y2kN3iYkNBTOfw=;
 b=qOGEKQekBvwKchQhv8XAFWGIbiUW3L1hhgfUAfjYy9dtheZbjR/OTBBfonAPS4IEfV4u
 HkuT6QHUkLUasf1c+Q/WkS26+84lFBSrKPSlLn7aInpYi1S5V1dKHd1jsjtUk0kB8lqg
 JmzXU0zim8SpcaWLKiRKa8xkhZ7VJc0z5Xf+W5uVifpURAOdtmNNvffpqevhJWefPJ3B
 pDvfcsd36zYDNiemVYy9jIUZeMeyXFpT5tbfRVYb6jKTaS4IOCmI0/pVuzeB/OwkAtGC
 S/J33Q1XaD4yAbpj4Ll5FT7/rHB4L94X9tyd9/J36WEb8I6Y6bBXeN8efMnhp2R9wuDy iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc64dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 23:39:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24QNUQTs030880;
        Thu, 26 May 2022 23:39:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wxtubj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 23:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZLs754klTN5yIhqNuLTfyZ+2UbD5ZnmOXygehR92eqN1hWJQCfWhJMW0Po80dZKNFne82qoyF3HoxEsU+euK+Z7b9n+ioKFDxc63ei6mu36h1ijzHEaVBIO5WhrXts+Xyk4MBWdRiQTNznnCBf16wcGyFqiiTFhmZZK6wNjAWl9Lli0VCrGkK9f2x6CpHftGiyc4DLhmRgGbzWuYel92o6KYthu1XM7+mq6Z88PlGinb3TeT6LprtEuVWYymDrun5xGgHZcAJtniMpaFB0p83UUguXfMgGp1kXPB0qxEDKL+8zt3TWMAJ9sp1CUM6FerdQ3NkmPdL2F2p9WxfBmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEnjqn0zdeKA9nXgCLI6v4EmjJIn8Y2kN3iYkNBTOfw=;
 b=GV2Tyg19mAqkrvBBpVCnIU+K+qQHAfz/nc3wc0SEdF/LsVgnyROydOtExdfZzd7WbzUWW2KD606rxzkjabkCTa0rRiXy2abj1ECIAlvMEp/iuLj2/IJ/5Dyt62LVvCa9FBWg5QTvx/4lwfpDb80TFr+YX/tMI4KTZZQJg6DrJO88oiiaRrEVgCh3+cPJJX73RAlDpAR8PsL5qsHR4P0OpoJFv6PCWKYjfucG2DK8emX3gDU7dldiG+2RXWOZ6KGxQaL3KWtOJy3yhYGnnsGaOxCoqY25iLs2KnSAsjKTjw9esXobyYdwzoxEKg91SKZmGKZL8oCX4OjWhTIrld7q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEnjqn0zdeKA9nXgCLI6v4EmjJIn8Y2kN3iYkNBTOfw=;
 b=DkWDnBXbNXmhkjjDE1WsApAcCUvodOiWraxSvR0woXLniRYYeE6uyAdknPGvVhMhSko0sncvHJhjvUvDW30IQSpHNAD9GPbNOn40KRPYbdwZsIhuHbuSZNbOeNK1kBh23WqVZaX3Iz5EsbnmNunwNNVnH7w54ZfBoGjcQOZuUG8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB2677.namprd10.prod.outlook.com (2603:10b6:a02:b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 23:39:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 23:39:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Charles Hedrick <hedrick@rutgers.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>, Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC 0/2] Fix "sleep while locked" in RELEASE_LOCKOWNER
Thread-Topic: [PATCH RFC 0/2] Fix "sleep while locked" in RELEASE_LOCKOWNER
Thread-Index: AQHYZYF+q+AyM5Ko9UyH8L7ZZq5Gca0xn2sAgABJIoA=
Date:   Thu, 26 May 2022 23:39:04 +0000
Message-ID: <0387546F-0850-4BD3-B2DB-FCBEE1242610@oracle.com>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
 <PH0PR14MB549335582C7A4D4F4D2269B2AAD99@PH0PR14MB5493.namprd14.prod.outlook.com>
In-Reply-To: <PH0PR14MB549335582C7A4D4F4D2269B2AAD99@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc707a23-3c9a-4805-922e-08da3f70eb42
x-ms-traffictypediagnostic: BYAPR10MB2677:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2677890F0B71B99A2DEDC3FC93D99@BYAPR10MB2677.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gTjX0aFhg3aJzpY4fFUdMgL+Kg9KuMhKsBwSm7LBfV3cyrBpm0kSeohn9Jky6/TuYnxUX6qLq12FvqPvLQRBJFn99DJK+wlspeFSo/K72Z6tGhPpLy6kbZw7qVgk4RUPfdAjzELOTsOfqQO5x7HJHMXhedUSt9mrXh0Dyusmqylez311QxfGALlO4BMcigPk+sweXBdlAdBbmRlTtQx40l0d4dSSm1mUoCiropvP5LOkYTlLZ7MqpjHV82VL7QfZpSIEAvft4xsLBUov65Mu9X2hIu9Yp7UNq3N7x6ny/3sO9i1rmzgrBNW6C0sG9AJ5ckWv6pMyRAhIzsZOii0xmz87xXDxGtutw7v6BWh7fi/WvrDhxu30l26AJja4SBUG3HW5TReXwhJbQrw4novdacLmnwyD1u8HJUGc6a6UzhcRhS2qrfnzCTh60V7xHyujVt7CHIl3K+nOJAxCFLWigVCATi+RKN0mbqGvDPAKyZs+bowco2m+5tD2No+VPIjZA8jOeL7QNarpWVnJAUPnSSJ3t/1dKhMiE0pICwLYB0AhZETpBR8U6KU34ULhImf/tSEQKUyprLHmu/1jZ2eN2/36jzZi1boRo5FJSOrCzX/OKQVoNJuBeXLdAaGQXF6LUTAIZVEk4NG8wVZXw6ymCLnPBYLSUzN/0GsdXYjbpXhVTsuuMjVn2Hd3Z9XjdjWZIXT0N4XQ0tZ2nI1UiQSAFPkaDiukh44XvmbYCDQHVwv3Ti+4CFP5vObgqeJAB4xN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(83380400001)(66946007)(508600001)(8936002)(91956017)(66556008)(66476007)(64756008)(76116006)(86362001)(5660300002)(186003)(33656002)(8676002)(2616005)(107886003)(4326008)(38100700002)(6486002)(36756003)(6916009)(26005)(38070700005)(6512007)(122000001)(316002)(53546011)(71200400001)(2906002)(6506007)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fLvmBXJzOLsCBx4ZZb2LkE4qYWq/JJU9RQSeb+M/oTqgHv0KcwPzcO7vKhfa?=
 =?us-ascii?Q?ADUAjwBq3wMj++7QjTrSx3RvrqCy+4zeVJw7uoBkravquAHdk9ykDiQpJRAQ?=
 =?us-ascii?Q?C1wB1b6dqpJvaAKQNYwcq3OoilOLWNOhpmfv7CInnyghKjC9cCQrgdEuQ2Fb?=
 =?us-ascii?Q?Qi2gqAj30GeRTKiflOf+hWTL47CaciOcr2nq4fnqUQ4OTJThuljnkXE8tJCD?=
 =?us-ascii?Q?FsQFo2rONKK4U/qxZHs52VHzgBj6delSM7Vcz3g+7tarPgO8THnZmhS7KRVR?=
 =?us-ascii?Q?xIgtVuMaAy8d3xWqiJgjDP22G0Zt0oSL1YuNCq3nNZ5IpQTMcTrEixj6WWBm?=
 =?us-ascii?Q?zyR+oxKPusedA+NaSdHzRKk5eGpBwyY1ZQfrfoPYDYMLXasPTc5kDwczLYp0?=
 =?us-ascii?Q?mwJ4T2OdSQO/Hz0s4p52T0Kf7+g41KTCRCBlqJnLe3jyjfhSvWEIvzGWPQit?=
 =?us-ascii?Q?eRo1EN3s9AlMkqTeKmNGIiujuTGSRcZA0wrPgkozxGjqpT9xXH5ykCAOj472?=
 =?us-ascii?Q?dGYPajEv8Vqjj6hcDXjCRzOLQNJXnBW7ngslt4ZH6i2h6ZF9nyju3ReZsKY2?=
 =?us-ascii?Q?OKErHSjrG9xJNgUnc1NqNiDc4hTfMPrdr6mnEG+o8dKMryxa+FiZlKDzl83N?=
 =?us-ascii?Q?xOOsAMHmxopFJlNzqJ8ZWU3n9dkkFDYgxA7SN/BBSvZ118AC5dNW7Z6XomGA?=
 =?us-ascii?Q?6oWrayl4k2jM0nIlPnqCQ+hwiK6O+ces7xZOeNKIKG2yMs/7bQKXLmTMkJPf?=
 =?us-ascii?Q?4fDl4WYxr/J+wxLB6L9UPF2RdxhyQ694X7S1WeJRX9oVz5dWXLHIkQXxQPti?=
 =?us-ascii?Q?brATviNEEiHkKNFG7rOB9J1UEXBTQxxiglg0y5hodIMotMrw1ISbgUC3nzNl?=
 =?us-ascii?Q?Tswk0n24QT7kMFSs1EnwBYHEfAnXMpIPgwHfBYjsMIHZnYlUkC38eSTU2lOC?=
 =?us-ascii?Q?5+0zeKOTHcpqaoxeQsDz6Y7AjOfIi9JZNKsBF2AQ6lBZkZwjIEj4GNwJ80Jf?=
 =?us-ascii?Q?3o+uFSQPw5ZVLPGNuRWw+ZVn3ToKAQP81N/GbjDiarYOS3Mb1rDTLTddSKKO?=
 =?us-ascii?Q?niRm8nz0LnW1qaYKpyuRwox2lbc/wNTcv+b5K9PYlkUVvw3v77MSLap5t5fn?=
 =?us-ascii?Q?SvAiAcWUAQdmEK6pEi1ztR8IVvRB2jflwKn0+kO32Z1A+M5D+CelEh3JhjlU?=
 =?us-ascii?Q?kTuFZL2teSlnottQR3OUUD0XZykS9YNNb4bdGtiQziVm5WCngShghfd2h6gs?=
 =?us-ascii?Q?p23q5qqZXIf7L2laDC4cq96tpCHBixcXy8DnqcLNbyfc3UjaQsoFCccUQar6?=
 =?us-ascii?Q?D0LlrhFR2tEB1iSPEIJWt9FaDaxCo0vhnJFKlvcYk5MIyG13FVvav8WWOdaS?=
 =?us-ascii?Q?jRXxHEvkZSWdOYh5ncyJM8vTVwgOlQlUmVaZloPTC0JrJ5FhhzX60sYTyuIf?=
 =?us-ascii?Q?XZjr2HtiPujAume4Bp0VRkp4GEM4BOzsgiJvRJ83mjT9O/8K2bKFzuSIjIsa?=
 =?us-ascii?Q?Kgub+3Y/ZyI//Wy0OcMgjQA4Zjok+858Fgur1i+PXmG7kO6JQyeiuZlMgc5p?=
 =?us-ascii?Q?Q5zXt7Kflw+KARwOjGjD+PViS9DUbDJO0ToXi9BRmjh3IHAinM7QRU6JSKFq?=
 =?us-ascii?Q?XtCbm/X1dufU7LpyzFl3H3SkI28Nk+6/2GQWhH7UrNMcO5uzd9hDhjxsSO8d?=
 =?us-ascii?Q?tLDA6qL3em5gQd+s7tvKiy8NAKe92dgCaadu6qFQiqgODPxDz2dst/P68pn5?=
 =?us-ascii?Q?EmWPrhCPuktrIFM1o4IhI9HUOKJXILw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53C958B38432664584195A1EAE45BFF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc707a23-3c9a-4805-922e-08da3f70eb42
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 23:39:04.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGuV608g1TixulUyUSaYc3O2z7cj2HOoaJSSln8kOqMBj6Ff72rGq3Cymj8wCSGfrNf3UlfLpdnH8vjELOz19g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2677
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_10:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260108
X-Proofpoint-ORIG-GUID: km6rv1LX0SARmKS6TXMro5NjnOG_WIFL
X-Proofpoint-GUID: km6rv1LX0SARmKS6TXMro5NjnOG_WIFL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 26, 2022, at 3:17 PM, Charles Hedrick <hedrick@rutgers.edu> wrote:
>=20
> We are still stuck on NFS 3 because NFS 4 lock operations hang. Typically=
 with thunderbird, firefox, etc. I had hoped that Ubuntu 22 would fix this,=
 given the patch=20
>=20
> UNRPC: Don't call connect() more than once on a TCP socket
>=20
> If this is part of the problem, that would mean we couldn't use NFS 4 unt=
il Ubuntu 24, i.e. summer of 2025, given delays in release and deployment.
>=20
> Unfortunately I can't reproduce our problem. It doesn't show up until we'=
re halfway into our semester and loads start getting heavier.
>=20
> You say this is a long-standing issue. So are problems with NFS 4 locking=
 (and also NFS 4 delegation). If you have a patch for both of these issues =
that we could put into 5.4.0, I might be willing to test it, assuming the p=
atches are safe. We probably wouldn't know it has really fixed things for a=
t least 6 months.

Charles, this mailing list is an upstream Linux forum. There honestly isn't=
 anything we can do about Ubuntu backporting policies, and we can't help mu=
ch at all with Linux kernels as old as v5.4 unless there are known fixes in=
 later kernels. It's up to you to find those fixes, test them, and then con=
vince the stable kernel folks and your distribution to include the fix in t=
heir kernel. The folks on linux-nfs@ are little more than process observers=
 in those communities.

The RELEASE_LOCKOWNER lock inversion issue has been around forever, but it =
was exposed recently by a performance regression fix in v5.18-rc3. After th=
at point, a client can leverage the existing lock inversion bug to provoke =
a deadlock on the server using normal NFSv4 operations. That makes the RELE=
ASE_LOCKOWNER issue a potential denial-of-service in the latest kernels, wh=
ich is priority one in my book.

I stand by my statement to Linus in this morning's pull request: I currentl=
y know of no other high priority bugs in v5.18's NFS server (I'm not talkin=
g about the NFS client) under active investigation except for the one I men=
tioned in the PR. If you know of /specific/ reports of significant incorrec=
t behavior in the latest upstream Linux NFS client or server, please post l=
inks to them here, or better yet, file bugs and help the assignees to troub=
leshoot the problems.


--
Chuck Lever



