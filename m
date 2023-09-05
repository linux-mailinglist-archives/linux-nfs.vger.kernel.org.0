Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E601D79271E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Sep 2023 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbjIEQFg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Sep 2023 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354846AbjIEPBe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Sep 2023 11:01:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482A18D
        for <linux-nfs@vger.kernel.org>; Tue,  5 Sep 2023 08:01:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385ExPZs011898;
        Tue, 5 Sep 2023 15:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tLdpsOFeydSyp070kuhFU//I80cCp9qnTxz3o/wPMGs=;
 b=UVtI/SM2ioTJoQnd54nUtLhG1BxMgbOdh2nJqKs8+nSuBoercQeEDJUMg2l5n7Eo70VG
 v2yAXBMh8i19SJbEHoikqkdv1iNxVIbciz2l9/BpJW2xKP9ZrX7l7UMbOP1x742esF/W
 RDnhUUnILcCum/YE4ib/qWlnYmG2FGnSz4XTJrZ6xF/A2ZyCO6p+IDM2rW0tjK8nHhtB
 fQeIAZZw8en9lfncDeaDv4QstXTv/GNvTr68ZgO0AdSpNEhNqDPILvOqHBTR/uyWI4j4
 JJJ+SFnJWCT/B+HgqxsRu/TS152k2todmUlBqAEKxHcrzrNu59t73d4bjgsunZ3R/fFg fQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suwktwk4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 15:01:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385De9Au010525;
        Tue, 5 Sep 2023 15:01:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugb4dey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 15:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzrt1hJXoVpv2fff+Ro91z7U8VoXvMYtQUkE/loJLQKv82+ufWGR3coZjaLPCuieOh4aNaJjByRqznhlJotyVCoNsSftj9TMh1pQBJLyXNjpJODUKIdvZr2lzcNV833r+n8WpDQgemSWVQKE5Ja0+aILvruFzX2yhwD4smax8D9s478XrCx06Q5SMDwG0CYOVfNWMB9H2PRbc8UXNV3cj8BcscQR+H1NoLNNGNUdEk0bTFbd7lwLwRzWlXvYNxVBEUk2C5ovYoitjJD1aMPuslTH0GkGKDXvJKbb4u/3kBXEdJIfXj6uu72YAuWaXIy67GK5PLPheA4XMppyx1vjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLdpsOFeydSyp070kuhFU//I80cCp9qnTxz3o/wPMGs=;
 b=Lh0HGcfwkO1WH66AtbQYRCHftatIBXBcdHoxAebqZlfu3/XXqUjCc/0qdhDXQrVvbz+m7ojmsqYhM/7Z1lz2PItsVgLu5//dHz/Mr1ucSpWfy8mFaCFrW1XYyh9uGGniDMPa7VXxOluduEtR4wV5bwAPwCQTykETJVvzcojfJdukPEKOIf0aPKP3IYAzY8ugRwC2ybBKHLyNRCUPNVRSIx0R/1pzZhzufhY1gn4ByLwoHMU76t3Ru8OYOau4v0yE73kQyRL/jtNIroaqcOo/z3B7UF/o+ghIpj0QLR9hfY/OmwiJfnLmCTL3OXVs+alEp4O42fvuYwZwxaXqLq+fsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLdpsOFeydSyp070kuhFU//I80cCp9qnTxz3o/wPMGs=;
 b=Fi4Po5M6ILvMfu9ClYGe8t+0AAkuslKcWLTEPsFmPkSI7yf40R2cm23vHSlgcTHNmjI17g5b6BVPf9kVZ31PqpHc5kGC3uRJP8DnKQ68MUTQ9U0PlfScNp3AX3bCxnFeBUwaPIycIGbr/UUeUgicaCjuza9FMS3IJMcifwdgMEc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 15:01:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:01:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG_ON() hit in sunrpc
Thread-Topic: BUG_ON() hit in sunrpc
Thread-Index: AQHZ4AjglDLFb5i35EOVcVfzT1/0ErAMU4uA
Date:   Tue, 5 Sep 2023 15:01:21 +0000
Message-ID: <615A8DB3-F931-4EFC-A6EC-CC4DA3766D7A@oracle.com>
References: <20230905-netzzugang-kubikmeter-6437d53204a2@brauner>
In-Reply-To: <20230905-netzzugang-kubikmeter-6437d53204a2@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4311:EE_
x-ms-office365-filtering-correlation-id: 84ad609e-50ab-4377-d182-08dbae20f7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1hWHKor3W7OCf4HaK9JP6IuRPdpu80vqaReMN904bp8A/XBlO35Rh9EgBUy1EAQKVTkRDCVpx1ky4jTFszwjzBJlB7/O4uVZ7mP3R3kIeEhC5v8c8xvDQPFfK+WJTQFVBLk1tklmBYNgC+qXttOe8UNlYhHIULnyRWZelBs0pOYZkvEneE4wOuNWxpBotKX7ei0xkO+YunPO1RriYyMGqIKU0QzeYUH/WbEFCKXJdjX+9IE5KDRlNRUQ2MLpBPtmQBT0AhZQPLIvWiCLlF0ViBxSD/ZOHkGxaXvZfCgosOPpAymRjmzJrq4Z/b2VY5tR0sd/26H64ozFjztmGoVE9OuVGZmJ/ACXO8Z8CcAvGzWcXMN09XGlVMWb8gHCCa4rQ9VAkXweir1rDyOtLGrzISj41hOsAyeciwvidNE0l069wcHiF0NvRNsI8PIjwsRj/n6LuuNY1iTpQUmF719oXTdAXr7VgbzflIdTZ1i9X0WDvjB929Nqhf6Gw0//OVpd74A3WZ4bGy1G5z9mwfLWTz8AxMgBUyFr8+sKO/QGGvRVQ1Hlm+nqmKuPAGl/am1QYxvAFnYXEWbcl7KkMnWwQsPl6e9pJ7lwwKV4HSGS7IEqlgmRnra+1Fzuv8/omqahpsk8oc5hB4EtgL00tKiwO442M2KBFAXOZQDoAg4fyreFyZO5FRwEW734EYFirmr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(8936002)(5660300002)(316002)(6916009)(91956017)(54906003)(36756003)(66476007)(66556008)(2906002)(66446008)(64756008)(66946007)(76116006)(8676002)(4326008)(41300700001)(53546011)(6486002)(6506007)(26005)(6512007)(38100700002)(38070700005)(122000001)(71200400001)(478600001)(2616005)(83380400001)(33656002)(86362001)(45980500001)(1758585002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KKNvZm2v3ke3rk8Dm3+rO81uHMG2UFHmAZJgIZDetCOpBkoaG0pu92fcH4jn?=
 =?us-ascii?Q?/VkiMsqNQeLRK6aRgffzEm0kAyrgGR+74eMHGwgDW36DYGWXq+odOGpHYJ9x?=
 =?us-ascii?Q?bbYWlqUefYsrguocGc8Q5SFzgXRaBZuBFKFLzJlPhgJaHkva/Z5ShN9S/jNL?=
 =?us-ascii?Q?Iv74LKXPyUIa6fRtrabm7BnYn2AvndYDP4jV3VFOidlIvDFrQZjiepS9U/+O?=
 =?us-ascii?Q?eAyEJh5ZosiAsh1IxkPVmcgj3ZG6OHDUeAhoH6KvZlO8KxsIXQEsf6vrOFWw?=
 =?us-ascii?Q?e9LssbIeA8x+CrJ9Veqz9GtaNC/vm9u1epAXIdTDpQfEZRVAL4QrgnspJwU2?=
 =?us-ascii?Q?CoRR9Z8mKCyuQ9V01BMqtGZFrOv5wnbD/jmeshEP+CxDzS9x0oc+ktZDnYDc?=
 =?us-ascii?Q?D2L0ZtksJ3hedSjIRl87MqJpNIBkrBMXyy7XteAhy8sLWOoC9MhBlm2AcLAD?=
 =?us-ascii?Q?F7G1V+whNgQ225ayeOZ+DTlry/hKyjvnPqXmqMWRJtdMfRmPwlFU8+p9VKsj?=
 =?us-ascii?Q?gShlKcIOLsLRdjwvzfbP6Z8VXiyMth5gaxy1NG4YyIEFBBhQCUM6IptUypbS?=
 =?us-ascii?Q?Uf1cdWom81H0GK1GQPclHHZ4iURC4dLr+li4Rp1ddi5M++1s99NL8PdrwqGW?=
 =?us-ascii?Q?YD3aotk6yKVb7IFAH7NkLlUEjl+BdgRuw/lwjNWuiqxlqZxZsrTEfYu+ckb6?=
 =?us-ascii?Q?IXufx/WxMxrF9OlU/+F5k1Y0faeoNjIAaFI13CwtGfKe4CB8m2wswLzPMaon?=
 =?us-ascii?Q?ZSMfFreQp85ytTU/RDsm1Rj/5vXes+p4CHhEz7kNus1R4l+UigmSQmZdYaec?=
 =?us-ascii?Q?pcJx4xqnOoF9zgaG5etgR7Vp8QbER3ihw6q8qaUcyUVL2T/YvVZRl4XU2mku?=
 =?us-ascii?Q?qfGM3NaOkjJ76ScyRvbz0OnQbyEE/XEg/TlxeVzbnUUaKokodZupFTrRsZR2?=
 =?us-ascii?Q?OSuJoBtmPCGmWzZ21tBsObCxD4WWYzMaZZwdw+yGRxbyP80i++KUhGOplgX0?=
 =?us-ascii?Q?djmPMJ9LwEFMvbHEWKFXDUVrOlanMSynOMy3XDFRKw1+H2xnHN9q9xr/gKwc?=
 =?us-ascii?Q?FEv/6GgH5hT+S4Jsl2aSZ3AVUvXBtE0LX0wqirWPtHteyaIyt3KCE7KFp9IH?=
 =?us-ascii?Q?k0uCjRWRraGpGw6QQel8+YUYaMHCQaHXD3Rx0d0+w44z5b7JqWT9NEL/nXjm?=
 =?us-ascii?Q?HrNOb6BxsvqaIdvx24/jyd4iUzaikzyw4XoU77PJQ9DzPGi16112rX7NGlgi?=
 =?us-ascii?Q?huLJZMQm+joDIQfAy9C6tXo4XnKTWNFnyDwvpjRDpPsuhSDqkCE+QAT9VGn7?=
 =?us-ascii?Q?de2NTkJSFxOSNLxRHEyQe6wfiXTUo8Wfzia1Pv9rOz1yvxVzoMJ5zUWY0Z0k?=
 =?us-ascii?Q?A/NCXnxuEUX130q1ZM1TZxvGqG6krEykf/ml0WIBKJML7rNdWEoBC0cWzgTx?=
 =?us-ascii?Q?NRc+/apZvU6/I6PQ6tcwlX+9ft3UwykmiXEFNcwI+DyDACpGC7gLt4yYzxhF?=
 =?us-ascii?Q?fnLP/KdCy3TQhjA6wmOZOXFTT6U5HcjOijP59QRKIs20UKRY8xzdhPRnvKiH?=
 =?us-ascii?Q?TnSTFVFg90C3vUHogwTIx9VZuVuIYVhPGw+UR47Zd7Lqzb4AUwtrQntKU4aJ?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DB1F9288DE1284DA34DB3C289F9E0AA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u8EwVDYGIsS3g5XioJSQwJQ8kSLBcd94MhodbUWuC61cwQVprmUi/aqxvy8lCbnvVNvuyWN6hBykTAYTQBSy/P9yIk4GNkVwefUvWyip1uKq+rtDUF20o4WR6nar6gWSlfi4UG7UE7LgGwL7cQEm6gRGnwO5voaKJn18GK6kP1NZMsYb9dmTbSaBWkM94bghBV/EERbCmbCUxKqEJwnQWmvqyZE1ueaGt7K4i2FEieUx11LF4lSrdchg/+jLaNVFZS7uD4nz1Ylf6uTNr7DJciyJ+aF7jIqvQQNKp/SRu9s5YWm1bpqGhPZIlvkKZwPg3kUitG2cCjdhbKi0yNDVHxjlTfn/z6xR1TRE302L6btahTqpfuaDxFzkFQxcUw/CqD6t/dmJzwDOEaijG1ZQy4Lvlh1rpbSHzq7Xy/Pob4cshNtkR5rkUy+a30Iqxd9EmJrpdyDInjWgtgUNd/TNJi1cIziSQfWJGLzxYQmx2EhDtMAWYQYQLZEtMElbk9QXKjBW/8/82pg/3/YdHg9Qm3Pxu1BiNZOtsweYTnXP7HkE8k7JgS4dRbzJncdLb0dSEMiU6srvkJrVz6IWRSosQTWYnc2CYmrJTXyAKzQygMH06UZIyguCwY/zFe9+ljzbHGsL4LMiUyi3mKrr5CqfO/p3NoJlN8hXIkwiJCfIZtG0B6JmwXFZ5u7M7OgS1csEq8FVl2nklFQtBL2h4zgszz9SH8pvL2aecftAOcfVrRwNu+TpsHfCcuvhUFGnYDQhJVE3NPHcsl5MdSJy9eHZKkWzS4/EHCzXaHo4szXH+A4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ad609e-50ab-4377-d182-08dbae20f7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 15:01:22.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwp2qnY2FXmJ0rxLGZHYpyrtKBRiAQcet0XT1Ws296SXOUPRxPio6rN7jPKa1xULXNSf5YCCAd4tB5Ao5z72Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=567 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050131
X-Proofpoint-GUID: N6R1KJKV55pqHMRyE78aWxvgpQFb2LCa
X-Proofpoint-ORIG-GUID: N6R1KJKV55pqHMRyE78aWxvgpQFb2LCa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 5, 2023, at 10:54 AM, Christian Brauner <brauner@kernel.org> wrote=
:
>=20
> Hey,
>=20
> I just tried to test some changes which had commit
> 99d99825fc07 ("Merge tag 'nfs-for-6.6-1' of git://git.linux-nfs.org/proje=
cts/anna/linux-nfs")
> as base and when I booted with the appended config I saw a splat right at=
 boot:
>=20
> [   92.804377][ T5306] kernel BUG at net/sunrpc/svc.c:581!
> [   92.811194][ T5306] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [   92.821472][ T5306] CPU: 6 PID: 5306 Comm: rpc.nfsd Tainted: G
> [   92.828578][ T5306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)=
/LXD, BIOS unknown 2/2/2022
> [   92.836319][ T5306] RIP: 0010:svc_destroy+0x206/0x270
> [   92.852006][ T5306] Code: 72 49 8b bc 24 a0 00 00 00 e8 a6 a3 5e f8 48=
 8b 3c 24 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8f a3 5e f8 e8 aa df=
 1c f8 <0f> 0b e8 a3 df 1c f8 0f 0b 4c 89 ff e8 39 03 79 f8 e9 ae fe ff ff
> [   92.867075][ T5306] RSP: 0018:ffffc9000a347b60 EFLAGS: 00010293
> [   92.872714][ T5306] RAX: 0000000000000000 RBX: ffff88813abf5c68 RCX: 0=
000000000000000
> [   92.884809][ T5306] RDX: ffff888126c38000 RSI: ffffffff896bcf46 RDI: 0=
000000000000005
> [   92.894190][ T5306] RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0=
000000000000000
> [   92.900512][ T5306] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff88813abf5c50
> [   92.907935][ T5306] R13: ffff88813abf5c50 R14: ffff88813abf5c00 R15: f=
fff8881183c8000
> [   92.917264][ T5306] FS:  00007fabf0bba740(0000) GS:ffff8883a9100000(00=
00) knlGS:0000000000000000
> [   92.924880][ T5306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   92.930358][ T5306] CR2: 00005568a27d60e8 CR3: 00000001737c3000 CR4: 0=
000000000750ee0
> [   92.937465][ T5306] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [   92.943057][ T5306] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [   92.948673][ T5306] PKRU: 55555554
> [   92.953452][ T5306] Call Trace:
> [   92.958082][ T5306]  <TASK>
> [   92.962546][ T5306]  ? show_regs+0x94/0xa0
> [   92.967221][ T5306]  ? die+0x3b/0xb0
> [   92.971702][ T5306]  ? do_trap+0x231/0x410
> [   92.976275][ T5306]  ? svc_destroy+0x206/0x270
> [   92.980717][ T5306]  ? do_error_trap+0xf9/0x230
> [   92.985287][ T5306]  ? svc_destroy+0x206/0x270
> [   92.989693][ T5306]  ? handle_invalid_op+0x34/0x40
> [   92.994044][ T5306]  ? svc_destroy+0x206/0x270
> [   92.998317][ T5306]  ? exc_invalid_op+0x2d/0x40
> [   93.002503][ T5306]  ? asm_exc_invalid_op+0x1a/0x20
> [   93.006701][ T5306]  ? svc_destroy+0x206/0x270
> [   93.010766][ T5306]  ? svc_destroy+0x206/0x270
> [   93.014727][ T5306]  nfsd_svc+0x6d4/0xac0
> [   93.018510][ T5306]  write_threads+0x296/0x4e0
> [   93.022298][ T5306]  ? write_filehandle+0x760/0x760
> [   93.026072][ T5306]  ? simple_transaction_get+0xf8/0x140
> [   93.029819][ T5306]  ? preempt_count_sub+0x150/0x150
> [   93.033456][ T5306]  ? do_raw_spin_lock+0x133/0x2c0
> [   93.037013][ T5306]  ? _copy_from_user+0x5d/0xf0
> [   93.040385][ T5306]  ? write_filehandle+0x760/0x760
> [   93.043610][ T5306]  nfsctl_transaction_write+0x100/0x180
> [   93.046900][ T5306]  vfs_write+0x2a9/0xe40
> [   93.049930][ T5306]  ? export_features_open+0x60/0x60
> [   93.053124][ T5306]  ? kernel_write+0x6c0/0x6c0
> [   93.056116][ T5306]  ? do_sys_openat2+0xb6/0x1e0
> [   93.059167][ T5306]  ? build_open_flags+0x690/0x690
> [   93.062197][ T5306]  ? __fget_light+0x201/0x270
> [   93.065020][ T5306]  ksys_write+0x134/0x260
> [   93.067775][ T5306]  ? __ia32_sys_read+0xb0/0xb0
> [   93.070501][ T5306]  ? rcu_is_watching+0x12/0xb0
> [   93.073073][ T5306]  ? trace_irq_enable.constprop.0+0xd0/0x100
> [   93.075937][ T5306]  do_syscall_64+0x38/0xb0
> [   93.078394][ T5306]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> I haven't spent time debugging this further. Maybe you see the issue righ=
t
> away.

I don't, unfortunately. A bisect would be appropriate.

I will pull today's master branch and see if I can reproduce.


> This problem is only happening after the nfs merges afaict. I'm
> currently using commit 3ef96fcfd50b ("Merge tag 'ext4_for_linus-6.6-rc1'
> of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4") as base
> and that splat doesn't appear.
>=20
> Hopefully this is not a red herring.
> Christian
> <.config.txt>

--
Chuck Lever


