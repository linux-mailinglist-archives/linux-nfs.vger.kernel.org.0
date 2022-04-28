Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDBF51378F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbiD1PBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 11:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348680AbiD1PB1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 11:01:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B0B1886
        for <linux-nfs@vger.kernel.org>; Thu, 28 Apr 2022 07:58:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SD5a7v003733;
        Thu, 28 Apr 2022 14:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pKPJcrUYae8yp+OAd2ikrzYt88w6jyuN34XzNnhPzY4=;
 b=0gzIyJV+THJ/llzwneb0zJI0cbPZSqwpduaOS77Ll/DeEAIIdqBmQDLINnZ3u6S9gC4a
 tzuRvlpd5rBKEEA5UUmd8pNdx83STbZscXnNk++n25avqEAAljsxwtU1wMMnrcUSlwIT
 KaZC0Y3e01+3bh/uHSa/dBTtKD5KibNCQmOWQhc/z17meAje6pqn5vjCtAADSMRvQDen
 11nEn2+TgLARAaDs6jIe6I5N0K7pQqK1RTNaKlOp2RUoqRG7E7Ehu1gRQTmBxpq0WbPP
 j1NhfDpAjvJpuvXhD48es5o1kJWtboZulmzFpuk3vH8sXKc4ghH4hLQD3K8enLflP2xx /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4uvef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 14:58:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23SEpB1e019688;
        Thu, 28 Apr 2022 14:58:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w6sxts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 14:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CihsiVBlLIMjE+ezYfQt7ynG/FlD96QE39FaaqCABizoy3+JooIEDKw+yurfH96hFuQfjK10mBD/gPLWveePerui2gcUyzCdNEqKRfc9Wwk676HT0yBVniGY7Evxy9Crb/ftQTTU/TVwM9n3UkkTLzQ874GzFNPSw796PM09+K/rufOBiLYjlydX3taKE5prUzsm11C9LtcAVwSrf4PKxw2MxXcUqfBrZkkIeTmW2VAGAcZFvHRi38CpYkKyFE9QtUI8Gt6d3oo9miVGCy1DJkAmPfbxyKcJzKXIAt/hNHvp1fCTSQ0RKsZa/i2xAHIoG/+lLgsWf29jh3zGdob4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKPJcrUYae8yp+OAd2ikrzYt88w6jyuN34XzNnhPzY4=;
 b=BBBrGXIHAdSGyH5CwLkM14Ng+x2qaqKKf5xUiQ3xCrnweuXSBofCwbibm2unVlZaxsGwvK+Kr7NM6/3cRe+behUNrYHPTdBQbYbZbZTItSZ/W4G6VXLMXiXBGzgngDeTAwztxHbRcKHjelJ2L60diI/dOnrns1o+kzYSKh8Q0aAsze64PYwzGxxuko5uyiyrKow/ioobn/WScKJxN+6ESmRxTMOWib06Z/zVNXv1Voipif3JJDOS73AohUSpQvDPMR0U3NUFyXxbUKTJO9XqsboUASADa9ZcjYTKk5Vq7yqod1Nah/IxMLvaKgIfaKNjMkSL48e2XJkeJr1YtIr67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKPJcrUYae8yp+OAd2ikrzYt88w6jyuN34XzNnhPzY4=;
 b=dAVE8Vk/zdxxrkLRtMddd+0tNvhp9KZ/qmJBqT13vDXWVp6kngP9eCmesMjy4tj3GCOyxoAjaD3v4X5+CZNszUy5mpENHkebFgGIvB9uSyU0KJwEnSuUXWWNz6LXsBEoqRDONp0Iv3balKezCscyNc+8zCO6wJJsbWxl9w79gb0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3316.namprd10.prod.outlook.com (2603:10b6:408:cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 14:57:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 14:57:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4A
Date:   Thu, 28 Apr 2022 14:57:56 +0000
Message-ID: <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
In-Reply-To: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a04e504f-378a-4d28-171c-08da29277ad7
x-ms-traffictypediagnostic: BN8PR10MB3316:EE_
x-microsoft-antispam-prvs: <BN8PR10MB33167A9648A97BC95E2671D293FD9@BN8PR10MB3316.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjvrmwOmFYHjciYVYDiFJVWdISj63U47X3J2DLWcr7MO/ME5/kJyVR+WE7pLY7q02MK1odVqLw+pNCyw9d/WnQY/AsexZfZx72XcjlJRDklyXEaNVhX5awqgE9wSulOI3ee9vkP/bTgFuCmq9XMJ2i2/mzFqRoAYOARtpvbqKEdqS4pQ+7Vx1eoH5aW4AQO6Y/XHPm0oewE09CA/Lke+JIDQEm5WvEw+0lpYm5nWDPkWPeWPkGN9CVPcUBgBk2SOVDyGaKL+0ebDMME2Cd/Hg5OtWAz6dlwXkDIEkmXyvfwQQGDyq8y0ZHcFxh3XHwa+ng5X8FJNZlI3jqaIzbpvtDqah3jl9UHvX9WBo/8uPxOs7WGPsGe33d3BG8hQccjbkdQB0VX4t4qEx9hfudZORylnXHqdCXdEv6L1ozrPhba50lEQfSlrC08L6EsIgfUTpBpayb1ZvQOTEjWIN8BNDkr847NRT7g3QB2Q8fvLALZp1PJMs/taAdOWjOWLkamRdIcp6Nveeu54mD65J8Cy65UubbJfszCn7XXQUpT1o/LeybxL7VMRgZZEBUNqt358su4MJcWvnC76AJ+RJSdalzXoM9vRKsMdrOd+iETMcvJaZHC4vaSKqXJxa0Db738uFcnunXZDZ3JBFVG5ENCffdVxDHsUZ901gIFW8mdZ5zOWfeWlOMRJGL67Xoh1w0aDylIFkT+xAq0zjbGhOoGZsrgHWjORmmqJTvWDgCIXMXWUQEyOD4nbLsu8gK47ttTz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(2616005)(53546011)(76116006)(6506007)(26005)(6512007)(5660300002)(8936002)(38070700005)(38100700002)(316002)(83380400001)(36756003)(186003)(8676002)(6916009)(508600001)(4326008)(86362001)(6486002)(71200400001)(91956017)(122000001)(66556008)(66946007)(64756008)(66446008)(2906002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2A9P3q5zFgM4Mxve/mwmeRDT+KhW0ETts3foQs+Zjk3gPvdrBihuHQzezfsE?=
 =?us-ascii?Q?PvUnSqaQD4fw4SEzVvl2hOrjHj4mMUjI2koXx4fP4YHzFHabXNgZ1VDizzVg?=
 =?us-ascii?Q?dCDTp0JBNkY8v0Gtdse3F5oZfWe75Kq/DHa4+X19hQq9hmZFsxkz7Oe0jaRN?=
 =?us-ascii?Q?YEPwKToJiigXYWqQ/fML1LdZQ2QE7SlmT1WgQvtFLL3RJ8tAfSi9hQ1mvTL7?=
 =?us-ascii?Q?N7hngZS9mTVW+q4iR2r8SYN9+1DflSz06XWjJTv0HMWm/R/7VBgni0cc1FMf?=
 =?us-ascii?Q?0Mlq09N7yHetui67VlLTEa3DK1rP22SnlwtMP901yPNbtnDvscW/A0G8QPrZ?=
 =?us-ascii?Q?8HsE6bV6WtrzKv/wxgX+f7DQ0imqkrlvWOPPij8RGS9rrrq+1jiItid9sgo4?=
 =?us-ascii?Q?qbZ2YCWUcomOlydWqgCUA8sEDwNJsIR5YYvIEszaSDwQ4IwY5WuznqPYPjq+?=
 =?us-ascii?Q?Mc/9qkwXpFykIlPPCj8ir2tliPvjyO74hLYSpbNBat+ExlYuKpO0DFlgGkGN?=
 =?us-ascii?Q?X9oaq0oMjVmtWGwQO0GGSlG5pj4WMMopbs/O9QKCDzTGixpwahBECMfwr/ir?=
 =?us-ascii?Q?MhQY+Tu0o1iTYZgu4/Y0tG4vzjOU1QkeINVMg0qJoQU8fGXArXik4RjSIbWI?=
 =?us-ascii?Q?meb3cDdKpbiPUqcq3kpno4XbjHCStpJYvf5rqHTVM4hWUolcVlEEvUiskVwh?=
 =?us-ascii?Q?3X2SEQdAAkhSanqHxg14sLpM98+9YpIt5D0uHAXcthZdgjGKzuu4tKxYJ2Oi?=
 =?us-ascii?Q?BvadsQjWmU1UsaJighpVTyRJYvOkMNGsGW+y3FdoZP5fW0hMsgqqqP9Tq9K3?=
 =?us-ascii?Q?P8pw8+Ref2w2b9E58GWteCbROSR09E+4e1aZYqJwDWoYQrXrbM5RVPzbIqdS?=
 =?us-ascii?Q?gSfbyrTHDb6lewQHFHOge2C28ES85qO9OnRpp4Z2pWFDYLoGVBDytt1znh/F?=
 =?us-ascii?Q?C5CG4VcXPmOs4MlB+ood8e62d6UHWE8stfsZY249lzBtuIF0/3FD8xtD0xdv?=
 =?us-ascii?Q?q2laCuH7sCKFFnlln5se2A/VrI8oySYsgEKrUq2cW4AdsvyNAn1tXkqTcuww?=
 =?us-ascii?Q?6Zzx49UCiMol/nzvgvspadD6DTqHfPZCOPc0wNzJgnfJ1TYVh9ggl5jMKqQm?=
 =?us-ascii?Q?78usfjIQV9htGgOl4MNGnSUTq2q7y0hKc+NkOC+kGPJ7chrG5/O8iYs11o4m?=
 =?us-ascii?Q?DwHiUshssHebvGKzwKPybt8RJ4UHrvYzmPodzn0qk6WTHN/Y84L60s4R0Vgx?=
 =?us-ascii?Q?HpuRVnKA5yq+Mfy6YbIx0JfwRyiHUqLyRPLrpphrOJ3JziN2SQOsEBh5Y2ZZ?=
 =?us-ascii?Q?LpfTPN6jdkDi3dSrcf480d/dvVBCdnsa8L3oEszIkHt5JdihZd0UCHmGaW1s?=
 =?us-ascii?Q?G0rh0JoMT6e/uAYIuxuhNsqxPfTjh/RTd/Y2u8qJR0fJ66arEL3Jn/RCtHvD?=
 =?us-ascii?Q?gjm4hXTGAtMv2lfbs51cH5E/kHjhmYMijraLumjghRmtGym2rvKUNESVqZXj?=
 =?us-ascii?Q?Ds7wTN/jkcS2vj655vC7hNPQyooGprVrHS2vOEn+qrC7sVoCiU0DifPpXDNR?=
 =?us-ascii?Q?kVJ3yam8XqGTjPLzbwxTIZcjSycjDds8QdubV9ukxnOUHXveBnZa6webG1+G?=
 =?us-ascii?Q?4tvj+YR4XWIBLC8+u0AwOnp5Mv9XTIU6ETesSYiASNDfKYPNsrU6Ey20pB+P?=
 =?us-ascii?Q?Gz3FD8v0H5enHqkSNafeMFM9d5zKc0VUcoXgtxautD4prp8MwTh/osDisJ/w?=
 =?us-ascii?Q?iKX6zz7aE2HzFNfWyQZhNCnOB9+yg90=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F09E4DCCF02C04BA60AC5FC64419915@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04e504f-378a-4d28-171c-08da29277ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 14:57:56.7101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgrSKD7d5CvSUFsbZOri5b9tJgQAJI79f9czORpReVKtiCBRLv7Zlg+gfFitdZQWXVdw1C5tEjwxNJCL0IfxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3316
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-28_02:2022-04-28,2022-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=826
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280091
X-Proofpoint-ORIG-GUID: BG30O4lUbyEMCHnRucp8PzNqLKLAxABA
X-Proofpoint-GUID: BG30O4lUbyEMCHnRucp8PzNqLKLAxABA
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro <dennis.dalessandro@corne=
lisnetworks.com> wrote:
>=20
> Hi NFS folks,
>=20
> I've noticed a pretty nasty regression in our NFS capability between 5.17=
 and
> 5.18-rc1. I've tried to bisect but not having any luck. The problem I'm s=
eeing
> is it takes 3 minutes to copy a file from NFS to the local disk. When it =
should
> take less than half a second, which it did up through 5.17.
>=20
> It doesn't seem to be network related, but can't rule that out completely=
.
>=20
> I tried to bisect but the problem can be intermittent. Some runs I'll see=
 a
> problem in 3 out of 100 cycles, sometimes 0 out of 100. Sometimes I'll se=
e it
> 100 out of 100.

It's not clear from your problem report whether the problem appears
when it's the server running v5.18-rc or the client.

It looks vaguely like a recent client issue where it encounters a
memory shortage while preparing an RPC and a delay is needed.


> The latest attempt I have is at 5.18-rc4 and here's what I see when I 1) =
create
> file with dd, 2) copy local disk to NFS mount, 3) copy NFS to local disk.
>=20
> Test 2
> Creating /dev/shm/run_nfs_test.junk...
> 262144+0 records in
> 262144+0 records out
> 268435456 bytes (268 MB, 256 MiB) copied, 1.29037 s, 208 MB/s
> Done
> copy /dev/shm/run_nfs_test.junk to /mnt/nfs_test/run_nfs_test.junk...
>=20
> real    0m0.502s
> user    0m0.001s
> sys     0m0.250s
> Done
> copy /mnt/nfs_test/run_nfs_test.junk to /dev/shm/run_nfs_test.tmp...
>=20
> real    4m11.835s
> user    0m0.001s
> sys     0m0.277s
> Done
> Comparing files...
> Done
> Remove /dev/shm/run_nfs_test.tmp...
>=20
> real    0m0.031s
> user    0m0.000s
> sys     0m0.031s
> Done
> Remove /dev/shm/run_nfs_test.junk...
>=20
> real    0m0.031s
> user    0m0.001s
> sys     0m0.030s
> Done
> Remove /mnt/nfs_test/run_nfs_test.junk...
>=20
> real    0m0.024s
> user    0m0.001s
> sys     0m0.022s
> Done
>=20
> Create the server with a 4G RAM disk:
> mount -t tmpfs -o size=3D4096M tmpfs /mnt/nfs_test
>=20
> exportfs -o fsid=3D0,rw,async,insecure,no_root_squash
> 192.168.254.0/255.255.255.0:/mnt/nfs_test
>=20
> Mount on the client side with:
> mount -o rdma,port=3D20049 192.168.254.1:/mnt/nfs_test /mnt/nfs_test
>=20
> Any advice on tracking this down further would be greatly appreciated.
>=20
> Thanks
>=20
> -Denny
>=20

--
Chuck Lever



