Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A1577016
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiGPQVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Jul 2022 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGPQVQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 16 Jul 2022 12:21:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DC1583F
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 09:21:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26G67Zo3010594
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 16:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6JDwJyfovNueTOOS/52EJDWN4QF93Q3VCQopWGL5Pfk=;
 b=1A77R2bFYLEBj0A74Epm5Rq15SzwgFP9QmhLKXRUZy5im70IMjG2uGrwt/BKaW352eV1
 rhJmm/GQT9mBdz5YdroUJdpQwvxzlPEv1nnMAdlP05xR50U0/fXsxRFQ411f+sqZkVqD
 YClnTXfTM9mcqoYwTjH+8/7N2oqtrqdybsAnS8znuqCJva4YjkI298RTPMD1H/jBeCTJ
 XXfyuy+wdLXla1SqyHFZuXxuowpWIsODNAMgkNriTGOQFzgnmC34rzGYVt9arFJEaWCf
 GRiNJ6f4ORYU5BeaLxAnnmmVVRnuUk0MtqwZ0MgIe6TsFfCv1ogoUk+4xerynrLHLR/m Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0m5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 16:21:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GGFPPg030280
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 16:21:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc0pk01ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 16 Jul 2022 16:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf31e9rcqPHCcLPZcONJJRvpEUIFsUP6g09/4NnRa+HunQSadwHIxgfG0LQ/Z3lDIg+CFsyaGKQopqFNJ/0465LNGRSZsEvqflWzI0vBhmJpUZkDFUw8ZxCRfc/HEdXVqA52m596QfR6AaILpif1ll/oqZhISjT0TApszPVvn3n7zSNfXZCYlE6D37+U4Vpoc+a7ddZxO/3BRkjsOpOzOw2qe4XcAwidbYcDt2ezp80/SzluZ7azHaiTnBXUS2IBYM+FQ+YYAhysnBflqj08LJRKDcXWEaEsuSghtrzx8NyJnK5MFYRZ8ZQy/WCyQmJVQ1/VDhF8jHgB/DvD65gQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JDwJyfovNueTOOS/52EJDWN4QF93Q3VCQopWGL5Pfk=;
 b=dfeHU5d51R1XUsoMhIGYwFY9igpt+FO+inUB2MONY3l8+sFvEboKaQte23InpZLnS5R2SsAr0VJv/7JPKHw6XRdeP6R9+16kjtARqbTPgNg3uLq1D1uzaFcc5QCfGtFpRuE29Nk8oAjdIFumS+//tJW61qTehFNAWdLHtYM9/C/vQqdXWjYcHaa9ZyCaVl4vAwpshBxROWOqx4UBqHXE+Ugii1dHIWgFugS8PQXsBOj7D+ofR+EdZVFkUdgbKNCaRojEZLPr9T5O30w+btEOZgoVXM/8vD0n66+I3uBh14X9z3SN+J9ZBU4Hwe0xH5pWJr4WwBLXFxZd4ARN6HIUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JDwJyfovNueTOOS/52EJDWN4QF93Q3VCQopWGL5Pfk=;
 b=DL6o+cLc01h9IA+LNVS6V4H46xNj6qCZaEs5b9CrIr2zLLYi2VUfee4HmOY8nslDJoWlQVLeOQ/R8hzvLtX2ER/aPnkuoDkWsIR2cbv5IxwFRdKPTG8oGRRdaeBLrC211WZV8qaSqz/Po5doPFUFxt621D4KE2Wl/JM5voeO+LY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1418.namprd10.prod.outlook.com (2603:10b6:3:e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.20; Sat, 16 Jul 2022 16:21:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 16:21:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] NFSD: limit the number of v4 clients to 1024 per
 1GB of system memory
Thread-Topic: [PATCH v3 0/3] NFSD: limit the number of v4 clients to 1024 per
 1GB of system memory
Thread-Index: AQHYmKZJ4kBZaTAXN0G0yzg6V25QJa2BLsUA
Date:   Sat, 16 Jul 2022 16:21:01 +0000
Message-ID: <847C5989-9251-4CDE-81BE-5C6A16750081@oracle.com>
References: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c434cd1-cdc0-4b7c-1389-08da67472c95
x-ms-traffictypediagnostic: DM5PR10MB1418:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wv7T+OlOJY1CuCjWw4ehZUqqg16UNLi2cTzsao4yVsB2XwOxxXIoDcsHv/HFglmdFz3tiKKGV7QbbVj1BSb8rkbnxD00G2oHZ47T2oqC2zZYtfIc4RbQzK+tCUtv2kkiOkEASdwzokPDvNhJK73PTJ3Nvmqc7dU6U38WSOE2UcW/b1pHZ/SniYlwvlLkiWiI5tXO6/uMymsWT60iaabmWFOjuTgO+sACBXaGovdgUBEYUTUm1OF2v+xIfSaMUN+n6GVPnk3A9z6Vpuw5f2DBW25AU6CVw4AvfKS7244fDnhwtRAxQHZFgHDCISU1BmbJ2FUUQ0DrFtRq2XJ6vw2hRfBSqauOZzptBa3jkB5XndaeD7VR5hWiyv6lbLKC/WDyvT9p+32FSdmB/1CiDfje5MtVMQTlxHNJmey7Xq52ROmybmqqYRTWb/WfyYcrBiySMv6YjZr4Uk4VcR8CwaKQBBsrS6DiVUmLcqm+Qdpy2m2OSGSP+vxBuqwZ7PLez+0vMdKDfgs0L0S4ut8x0jgKI0354G2pih3oj6IH33UtwJxzxGeMzRbSQnF1bmYAvUHBSlQ4jWj7nR3VNC9RQou5AgfnCWOz+vN35FztPV5B3E5Up8WbWW4LiPO65sKrHShkySKXClPpr7MfbXiKbOXL9cnJjpZHt8oykZQlvNoqU9CNG6qUfJBeWxW8/WdizhRiXWt+DsRYGMjtC6ZOjTindjBM1UixLDBSeuJlpePGw7tqbiSaInx+1hZrARfvMdcxE8ck638pVa4AGPKPOxVpm3m2NeQrGF9ys2b2ULcRtoFd06WGm8CIKqh2qXx8jMxQo+xEl5EbT2XAuJkgL8R7rPN5FGIkbZQxxNNzIUj325o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(66556008)(66446008)(64756008)(66476007)(4326008)(478600001)(186003)(8676002)(91956017)(83380400001)(36756003)(66946007)(2616005)(41300700001)(6512007)(6506007)(8936002)(6862004)(53546011)(26005)(6486002)(316002)(33656002)(5660300002)(38070700005)(122000001)(71200400001)(6636002)(2906002)(38100700002)(76116006)(37006003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AeIoGhrcayHZaC7mIP1HbwYFU8/Kgj87Ubjan475mOitqrndxZwAb0pZEQ7x?=
 =?us-ascii?Q?wxZNSf9g6f1nxAU6fpPICsojeu7gVa5fr1bvqBaJYoI6xz6qtdkF0veXG8j/?=
 =?us-ascii?Q?S0s67A7HbkS+8PscLxKWtYwHxiHan/P2lgjIOA9DM0+MFBAMjmTdmhD+tp+y?=
 =?us-ascii?Q?kp/XELd3AAt9eEoewqbLiDGwES0VZRKgc2V7SZzkdAV5dr8GckuwScM26BuD?=
 =?us-ascii?Q?FcUckCslyLQv15Mn5K0HkHeJb+Z9qukrl23/kbJV4f8dhQ7N5UjTw9goSUzu?=
 =?us-ascii?Q?fnJHpfWurURF4+qOOIhpCwrhq4msPXBOCfIG5zxR0c/QkgwvdG41YKk19+dE?=
 =?us-ascii?Q?N9lAggUihc5nP4xLqwfRP0rXAx0V5UyoN+34TcKH6IT8PVy5vuweW9bF9VwW?=
 =?us-ascii?Q?CHcC6iE4jv7mStG0L3EQAfW+Qc5y4rEC5VcsPpOGwpn4BJ6KNXT6Czm8+ZyQ?=
 =?us-ascii?Q?SSTQdE7ruiIzz8JjnwD/FhSxvKhp7Eyb+EJyxHWmAw/SZrSaTdBHGMsJ+RcP?=
 =?us-ascii?Q?Heix4au3zsql6RC8sL4KLaB8FT5+8jaRbeYhpnXiyQigE6Cs7YjBDMFxE0s5?=
 =?us-ascii?Q?HIsQ9KbHjZKcYDGhASTE7YKVli7ojMgpQXsU7omIZRHoYbn5VAAsccW+s9/F?=
 =?us-ascii?Q?uKhAtz4RO7+ChI48zbqRlBw0e6KHmXdguzg8ypVsYmkzzHXvUdqn7n6aC/zk?=
 =?us-ascii?Q?GoNINPIkhOjjgkf0F8bs1rfZDyqCVdnrpqOGWZAqxniU1J6b62QA2o3KHnLw?=
 =?us-ascii?Q?EzHmyp55lSlQuWS26tGW8b12xWjLAFOkCiaoXXpTOq/G6bbWXtQJoZhg0Bab?=
 =?us-ascii?Q?LAS6C6v8ouEwi2gIc5RBBz1hE8A8XRirg+Wk/mbowMUOmzRXTlnyd8OCtv3N?=
 =?us-ascii?Q?E7+4Uk/YQucAByfi7R28J3w622pqt4Tu1QgRleu+TUltYyDuteDb+LGZPUHP?=
 =?us-ascii?Q?WBd9X58GiXgrgC6kYiDwbL5wAdEs4o0atRCH+tdZ7KDH0NyCZc55FcBAkI94?=
 =?us-ascii?Q?2ZBHe9okVki7etMl6jWHtT3yHSc4GuQh5pt0FJKzRN7U5ckhfDXyKskeEbJs?=
 =?us-ascii?Q?dSYLIjUri/ebbrvLA/KvVZcuCFWy6+a6YAtOvQ9+tCD5KXoLL9cRCrTDswr1?=
 =?us-ascii?Q?ZgEMs3kP6u0Pcn5vdVdfH9Dt7UxOrA4wn1d9iFyzMVkqsV4oMzDqn/q5HBaG?=
 =?us-ascii?Q?1em0eRk/NFcU+x3nFe1hXU3cRKqhTRpWoHOmu8bOZzVAOcEKWGiQyoS9+fDh?=
 =?us-ascii?Q?V1RVZFvsVsIIPmoFHi6Kr7I9vC8hq2W8MQPLe1kOeTyrwymp1AYNXk5kXgcl?=
 =?us-ascii?Q?rq0N7iRUC3QWbBtY6LXR7z9L8Pg3NYyzUKPvHVKKgsqfeUR0kkpdQAjjgNEa?=
 =?us-ascii?Q?h+G83JYohxlcITrKidp4sh+XqSLYnpjKKC5/oSpPNvQL8VBovNo2QThhv6Y6?=
 =?us-ascii?Q?RxdZehWv4jShJ4PLwlCQPakqjPfZuIwDjRv5p7fVRRWUL3LvIU7LRalgiRRE?=
 =?us-ascii?Q?LZe/JP4FtxKhBgu5T7qrXBBIEST3D8sXdCoTJjiYifFyLprKyYDdQhyHtwHJ?=
 =?us-ascii?Q?yFJAEK1L+w5r7okWmKPBx5TVEF8TmoedJKY+4a5aNWPkXnqOMENlPu5k14y8?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAFC1A7E78617C42866501A3A2A1A7F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c434cd1-cdc0-4b7c-1389-08da67472c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 16:21:01.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgsyrYF2jIVf7hnBs/26pnLnJQ04mBZHjF8DGR5R1PWi7mFsBTfphZO58DWP1E2DKEvwr7irHZYXe7e57dniQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-16_13,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207160070
X-Proofpoint-GUID: _a9K-VHZ6pLFVghbNgXcCcoQO7Ra8ntX
X-Proofpoint-ORIG-GUID: _a9K-VHZ6pLFVghbNgXcCcoQO7Ra8ntX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 15, 2022, at 7:54 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> This patch series enforces a limit on the number of v4 clients allowed
> in the system. With Courteous server support there are potentially a
> lots courtesy clients exist in the system that use up memory resource
> preventing them to be used by other components in the system. Also
> without a limit on the number of clients, the number of clients can
> grow to a very large number even for system with small memory configurati=
on
> eventually render the system into an unusable state.
>=20
> v2:
> . move all defines to nfsd.h
> . replace unsigned int nfs4_max_client to int
> . kick start laundromat in alloc_client when max client reached.
> . restyle compute of maxreap in nfs4_get_client_reaplist to oneline.
> . redo enforce of maxreap in nfs4_get_client_reaplist for readability
> . use bit-wise interger to compute usable memory in nfsd_init_net.
> . replace NFS4_MAX_CLIENTS_PER_4GB to NFS4_CLIENTS_PER_GB.
> . use all memory, including high mem, to compute max client.
>=20
> v3:
> . refactoring v4 initialization specific code to a helper in nfs4state.c
> . fix kernel test robot issue with NFS4_CLIENTS_PER_GB when
>  CONFIG_NFSD_V4 is not defined by moving v4 specific code
>  to helper nfsd4_init_leases_net in nfs4state.c=20

Hey Dai-

I pulled these and applied them with a couple of cosmetic changes.
I'm going to run some tests over the weekend before pushing them
to for-next.


> ---
>=20
> Dai Ngo (2):
>      NFSD: refactoring v4 specific code to a helper in nfs4state.c
>      NFSD: keep track of the number of v4 clients in the system
>      NFSD: limit the number of v4 clients to 1024 per 1GB of system memor=
y
>=20
> fs/nfsd/netns.h     |  3 +++
> fs/nfsd/nfs4state.c | 49 ++++++++++++++++++++++++++++++++++++++++--------
> fs/nfsd/nfsctl.c    |  9 +--------
> fs/nfsd/nfsd.h      |  6 ++++++
> 4 files changed, 51 insertions(+), 16 deletions(-)
>=20
> --
> Dai Ngo
>=20

--
Chuck Lever



