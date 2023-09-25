Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3A7AD8F8
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjIYNXT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIYNXS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:23:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F5FE
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:23:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PCUrcX025257;
        Mon, 25 Sep 2023 13:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+HrHhcYubi2Hap8Ug4jFjdHEstDQdsse5scWHjESTVQ=;
 b=sLVKAnMqOQuxa+X4WGbRxwHYd4D56smzxnVpAA+PPj+F6iN5ja1rOOT0TsuJS8MqSUxp
 wJLYGyFsnNlHuYowJM/FX3JB9TJ8qHQ83opPc+dKsuEoIJ7Slobz/z44hPkg0m/mWuIl
 z1SoqqSN0nHy1G3hQjat1psGlKIj/Kp9LXbm1MRd77wq+SIQUAnRozJpIt6jZfxkn56O
 aYt8axRxyIJNDKVePDtIx1P+1+ffB/h1rPBXGmdAySozAgZLsLWaLgRdtPg/VJqxvUk7
 BbRvblcMcqZCJhWBQTIEd2yrF4cqgDMxPn92oQ9QipGriDVfX93NZQxwgIi7m+tJp98U gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjubm4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 13:23:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PBeZnR034925;
        Mon, 25 Sep 2023 13:23:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4py26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 13:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmbunoFbJ4ZTcs2E+ADsDvaoYwi9HSlhhqQ2tLOoGUbVBf1srn39jHFKrYeXaNIDp2kVoknI3aJ3xyC4sxzMLTaUOLspVsDcrV2eUwOoPbpqIvfu3dVWc+MWvH+G2YTgnnZxBei8nuEvCm3sUGQwXUq9fpu2V6xAY+g62RnAmy50lrOWAk4sazsoqTMPPnkK7kyXdTLID2NwBj/Jn33WgUl+xDncpYL+kln1iLBYe3/usNwOyGiNOlHzib7SQPo34m7BoCok5ghiPMQC7AU8Qv+t8to/CWXpssbv/Cgs7LhiS3PuB6pcrFMG1rh5tDHUF0mZzoURSTR6HlIX+TIpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HrHhcYubi2Hap8Ug4jFjdHEstDQdsse5scWHjESTVQ=;
 b=DzS3W41tazaj7+3zKHchwNAm9endHntGy3B3XwMIRkBDnHHAmCOOMRtH7PmzzezxwM/TkRR+8HYCvsE7ys3kpwnD2JYAhMYDwV338PElWejN1nfiEP+UOYqBisf39lGPwtKq8RfEdm7+7uxzcCsWvA9CSs1q7w9CtSfgnVhtwf8M4jKmdK7qayFbV2UmEIJJMZ8JeUf3MYJa3sJ+r3iE/L9dY4311raYk6q6bGfv5PNle5ckske3gLWJQMhdG+5tXw7TYPL6yrf2e5x5WASZROQlMkQocqAeRyb/UcOQPQZmOi1aknfLZrrGKu/+d+MQrX8MXfky14g//An3eBKB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HrHhcYubi2Hap8Ug4jFjdHEstDQdsse5scWHjESTVQ=;
 b=spOjXENlBUDeBaD5tvzeuxPaxKM5VL/TQczEHu7RswsNes+ccHbMJe44gc4ALqBX4JkWRPg0UKF0Ol5e3LK70+jMbvpQcoqjNc9vYsk1syCRdTlNCINPeesBIWk81AM1sB4YloEQfGor2ZTRRO/O7JUqcndWDjiJY8e2VIcfrgI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7479.namprd10.prod.outlook.com (2603:10b6:8:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 13:22:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 13:22:59 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC:     Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH nfsd-next] NFSD: simplify error paths in nfsd_svc()
Thread-Topic: [PATCH nfsd-next] NFSD: simplify error paths in nfsd_svc()
Thread-Index: AQHZ719IuF3t9wOXHEu9x5AItDM0DLAra5wAgAAcZgA=
Date:   Mon, 25 Sep 2023 13:22:59 +0000
Message-ID: <0D405E7F-7DD1-427A-B6FA-B44DD8CF55AB@oracle.com>
References: <169561203735.19404.6014131036692240448@noble.neil.brown.name>
 <c31e35b33606211c766a0fae12187b16d67e8a0f.camel@kernel.org>
In-Reply-To: <c31e35b33606211c766a0fae12187b16d67e8a0f.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7479:EE_
x-ms-office365-filtering-correlation-id: b1ab4665-714a-4e80-329c-08dbbdca89a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcih8GqMyn4sd2nmb4b6HscrHhBO1TcQy1+PO4MbhW/O4SXKDWbr81nyOGitENMhMeAAr2eVaTSNCErar9A7tKRIoNhgf+xDtcoT2bJkdRP1w0fMeOtEdbSa2T8f+enqLf6IMd8u0Fly9w9BNnvpRghlIGdRZ2LEG3vcj35YQ4wH7rIyrShv17o26soNomGDpNpEG8dNdmkZrTFhdVKyIsFjUNh6o1kSiF2of5535iDxIAC/G1NAjZwYL4lE5/7G0wLlTv5zT7JeizG2Be15MnCNMXPmhn0D9UQ8SCotToPjFrd6WwcUjSuSO9ZJ1hVoQhj+DUqwqmEMmx8U3qkwoigLdwXxBS5JXhJEouRZ1kpJcB8IZF10amyj52ATdwPt5NyPKQk/CU99yGMv1BG2tkquS45zBostVzL7kyBvmyGl6TEuGP0FXIxZ0I4WGn0aoi10EbclRa9VYH3anWh8yoe6qwnHY4pNnrUdUZeus9GygWhYeiOZUlPwu62ozLkYu1XSuy/fx6CdrtSEFvvXDqIRECOxFV7eeYELrzjjvMpz7JDD+npNZ7qkzuD2LQnauy7/4r6K94Q3ffnCq4hBgekqjno1mQIanVHpbWl+JWHFGNhifr2OohWqGErWlw9G72DQGk+IT90V9Pc0VUHvdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(6512007)(53546011)(6486002)(6506007)(71200400001)(122000001)(38070700005)(83380400001)(38100700002)(86362001)(33656002)(36756003)(2616005)(110136005)(91956017)(26005)(66446008)(64756008)(41300700001)(76116006)(66476007)(54906003)(66556008)(66946007)(316002)(2906002)(5660300002)(8676002)(4326008)(8936002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?59kI0xUICC/YsoAtM38bEiEpvHgwo0pxse/wlOX4TxMmza+YBxQtfgzz26ji?=
 =?us-ascii?Q?/X1mPJYpnaw54SsI8U1BcxJ82KUyplPKjrvR6CPJHIA3ASwsaTh+eNDTehMT?=
 =?us-ascii?Q?vR+eETE5OKhnGt0OLbVYxL4FmoFHsPDaTeyQdTJr9kkuSVGQexccXfiqM0js?=
 =?us-ascii?Q?44iL+95TDdWVgxPfQtq+iv9wjYJPWe+cdoJ/pamRoS0XcyRxRTAgCzrCIIbz?=
 =?us-ascii?Q?fwN3779NTQ8DtpIhV6b2d0E8vrRFi6mEnvFzKQW0U/Yh8ZLyGYTVVHk4ZJ5c?=
 =?us-ascii?Q?SixsV80UFD8jmF1yjkA9qhH/v7C/JbGP04YBSOimXeLx+Ryg0vcrhGJrMwSA?=
 =?us-ascii?Q?m/xnYN79XMZ7WvHJ74S8UQvOzCwi/1dRpQ80JAvXGfvnVy9w5dUfHStb4Tge?=
 =?us-ascii?Q?ghNtxeZc3DAViDPoNN5YjASJyEf5N2kNzTyOFVXV4HmfXFXWNNqV2gONtW1z?=
 =?us-ascii?Q?YotBWmQ/LrG5xK7OKcajjDFMyCFJRUPm+rD0xWs9JWehmuF0n2/MZd/jUCyh?=
 =?us-ascii?Q?gS9qhOqH7QM3E4JvSPao/irOAlcedGrd61nPcc+O1tdy5mXCOwHhpK9ZooiT?=
 =?us-ascii?Q?cTpD8w9t7Zvu7k81gySx5ok4AgPD0cLphpkSQfegJYhKNBtozCWdYsBxxmHq?=
 =?us-ascii?Q?YqQP9d36WkDFf6rmA7q63NNC01YFAdyDXKkc8ZMjE5bvXQ4o6rPoxTAGzOzd?=
 =?us-ascii?Q?h4Ntu2eEtpNQfPzaone2I4jL4MrMDDzeHezQ8eBpfhvB+Dxz3AEpGL+t21c2?=
 =?us-ascii?Q?AfI+Gca6jzVLn4VJqjebs4G73kp+/SPgQm9ngJOGrtExzoxChqFI2Rfu7aIM?=
 =?us-ascii?Q?MhWukts6I+Q5SU08HQPIzaDhXZv5BvFhQajMn5k4RfIjyW/G/MIqNFRydHPV?=
 =?us-ascii?Q?pcxbivexqjQKw8EHK1wO9pcNdL+NU58Wkc+vF9d1zJ6UXjSWMuG5PhFhWFMB?=
 =?us-ascii?Q?dA8jQkdcExXfymwv0TLeYq84vErWScFp/9/ETmfW0Cw9PGiGYarhp26IjaAK?=
 =?us-ascii?Q?12cLbBOfiEoqDo9L6MzvpfB+JpfojQ/yAaPSpDcZ1m2pDvD+8WwsW4cydtD1?=
 =?us-ascii?Q?ySDqMD7pilmaxpK186ssWD0pohcl0D6ekpHf9WVJNp8fkwaMiYU1W4PHNCOX?=
 =?us-ascii?Q?4b3+mIPsug0S3sPJv55T50cZ0Hm5gM8f4Bfycl/DnVNQyLuyPwL4oSGq/JEm?=
 =?us-ascii?Q?OqCzNBp9LafRVi6n8mMPiOlxLBcgXf9eoqg4abvklq2CPMxv5UT/8iYjTV5C?=
 =?us-ascii?Q?tHGefN2K4uLWg9zuA9dTiexuGQX6qRUh+M7IlFjoznjExOSU8CB0PeT1quYm?=
 =?us-ascii?Q?fPShe41iH0zzbuhFsYApMwKQD88K3nUeDUOCRwYtumigtd2gE0u5UmgJkhEr?=
 =?us-ascii?Q?e83qg+Mq2g30wcyKuWlWSkUJjeb+EV7L5UF8ZyqZFISVGL0CxpZ/ipoR9+pk?=
 =?us-ascii?Q?daX3X4pq0udR63zdqmFEGvJYInd++RBFgCLqR7Y+g1izTXn+7gv1UJ6QEyOI?=
 =?us-ascii?Q?9xe7OP0EU4ufcOPNGhH9BhAWkfvar/0Qp97HpEekKpgKyXAGk1NsH/d3NVir?=
 =?us-ascii?Q?uaGnqEsug3yg6ApARvhQIcjfM2Aj2N7No9S2ciaam04eOFg3T19tBXzxtkP2?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37E24737BDA3464888147A05D39CF51B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FIyF5MbkOSIJ6bgG21aNxlRQ6qvMsDazqmAMq05KYxg/QzE6Xs3nNegB37NRXVM82gUW0KV8RwSoBgtC5wgjEt6m4EH0ccW/PPceBaRH3AVfIduuvAvjBTf3zzQKR4orEahi0Ou2j0xkQfAdzwaMe4l0wTOOUcG+BAHtc/Vu83dA7Qw1HeUENbra2c7zYpzc5KQkQCwuOFcNpTKq98rXEF/a5qbKWQX7xRAVtOfInq4UBXPWRv3zEeKUQrNjXK6PryvGGKrEbYPAmznoJ52oduY/8QbokdDf2fagmTcoB1GIyYoGm7kLa5FFs92jif1ksakrpu76hW27QGAkFWgjKoOLR76VMkw23QBRYqz8o4BQSOjjGtUlI++wFoiwDE7HJuCoOx82AgQ3wRqdhMVCLXjOo65oAemdFjwx3heNkPUy4OqvdNGWtmeJJo1PaqnSdzx/o98Qkev+cZXwqHmMWQeb+FD6q2fn3gw8JiGdHG2G+FX1+fCUlrrVxYrGqTDCLXehg45oIBBJhTKbeLJo8i/QFeYAhpLH0d75NYx92rNBucqjKV2i891YOsqX2byOC4SfCFhmId0I6KK5TyPlhA6hXSY1FKWZuM7TKQKgZaVbIFP+MQt3FWQ3Q8UVCHxTgTZdG/O+IXxJyddVm9du+DTt5+UUgTBPKZfa+P2iGwg9TgSoBkfDv7v6rcpXABfQt+a7GSYt3v43ca5zxePE7PYJuyF2F31n33dfYuGKjN8EQv8B8qgRcl8ZIDPXXI5lcIICoFgtvNuKLmZRjBFrxdR6RiJlQ6/wqgS5Q4Le+8tH4O70ZRtQTvBCVhym4rEW2zrsSOYjg2kX8xTihMVe52TOsoRbaLAtFePPSj2Oyo8MYCpzbKtmGiWJFtChpjkW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab4665-714a-4e80-329c-08dbbdca89a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 13:22:59.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIqnqAXbtUYgzWLnnW0E1FOyj1nEDIq3+Npy9W31MBiftiumMXqZ4LgU4od+Ult2IHExA853JGqylMXgfh6oug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_10,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250100
X-Proofpoint-ORIG-GUID: yjwjstrJuOx-OZ0uJj0e0NjhSqy6QOim
X-Proofpoint-GUID: yjwjstrJuOx-OZ0uJj0e0NjhSqy6QOim
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2023, at 7:41 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-09-25 at 12:06 +1000, NeilBrown wrote:
>> The error paths in nfsd_svc() are needlessly complex and can result in a
>> final call to svc_put() without nfsd_last_thread() being called.  This
>> results in the listening sockets not being closed properly.
>>=20
>> The per-netns setup provided by nfsd_startup_new() and removed by
>> nfsd_shutdown_net() is needed precisely when there are running threads.
>> So we don't need nfsd_up_before.  We don't need to know if it *was* up.
>> We only need to know if any threads are left.  If none are, then we must
>> call nfsd_shutdown_net().  But we don't need to do that explicitly as
>> nfsd_last_thread() does that for us.
>>=20
>> So simply call nfsd_last_thread() before the last svc_put() if there are
>> no running threads.  That will always do the right thing.
>>=20
>> Also discard:
>> pr_info("nfsd: last server has exited, flushing export cache\n");
>> It may not be true if an attempt to start the first server failed, and
>> it isn't particularly helpful and it simply reports normal behaviour.
>>=20
>=20
> Thanks. Removing that is long overdue.
>=20
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>> fs/nfsd/nfssvc.c | 14 ++++----------
>> 1 file changed, 4 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index c5890cdfe97b..d6122bb2d167 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -572,7 +572,6 @@ static void nfsd_last_thread(struct net *net)
>> return;
>>=20
>> nfsd_shutdown_net(net);
>> - pr_info("nfsd: last server has exited, flushing export cache\n");
>> nfsd_export_flush(net);
>> }
>>=20
>> @@ -786,7 +785,6 @@ int
>> nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
>> {
>> int error;
>> - bool nfsd_up_before;
>> struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>> struct svc_serv *serv;
>>=20
>> @@ -806,8 +804,6 @@ nfsd_svc(int nrservs, struct net *net, const struct =
cred *cred)
>> error =3D nfsd_create_serv(net);
>> if (error)
>> goto out;
>> -
>> - nfsd_up_before =3D nn->nfsd_net_up;
>> serv =3D nn->nfsd_serv;
>>=20
>> error =3D nfsd_startup_net(net, cred);
>> @@ -815,17 +811,15 @@ nfsd_svc(int nrservs, struct net *net, const struc=
t cred *cred)
>> goto out_put;
>> error =3D svc_set_num_threads(serv, NULL, nrservs);
>> if (error)
>> - goto out_shutdown;
>> + goto out_put;
>> error =3D serv->sv_nrthreads;
>> - if (error =3D=3D 0)
>> - nfsd_last_thread(net);
>> -out_shutdown:
>> - if (error < 0 && !nfsd_up_before)
>> - nfsd_shutdown_net(net);
>> out_put:
>> /* Threads now hold service active */
>> if (xchg(&nn->keep_active, 0))
>> svc_put(serv);
>> +
>> + if (serv->sv_nrthreads =3D=3D 0)
>> + nfsd_last_thread(net);
>> svc_put(serv);
>> out:
>> mutex_unlock(&nfsd_mutex);
>=20
> Nice cleanup.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Applied to nfsd-next.


--
Chuck Lever


