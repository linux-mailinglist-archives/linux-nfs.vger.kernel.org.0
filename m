Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29A61013D
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiJ0TMR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiJ0TMO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 15:12:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C891380
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 12:12:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmu60030275;
        Thu, 27 Oct 2022 19:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5Ll5zfBALczPIo1wX2mI6h6gSjXh6byEMhik+c11LgY=;
 b=HnvqeIb96fmUwqCiRKi430vfdRfBxE8SnGtAUO0vFNIJn0OxFcX1+O2uVddyBq7sGAh1
 EuPmh2qfXu3wiP4UDn/aaLy+z4GNsWk4VtfwozCLoQjU/oC6xnHWz2fXvXrWTvDM3K0G
 0ZgMWWunlik1gAmVJCra1G6f7zVtbAE2T6BYdM8JyEHC6hqgccLusSRgeVm3H3exjjmK
 qYJ3+innkRwUCBtH3F+Rj9A298POogLYLb8g8RNGQ0GN0Em4gScW7P2FWol4qh4w0Xfn
 moV6q0e02aFfQkV0Nis2x6VPdwH9VrdqQG21oDdJ58NklsOZESeMtWo+tPj7Xa6Eh3p5 xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv375e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:12:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RJ0AHX006671;
        Thu, 27 Oct 2022 19:12:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagh9v1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz303dxCKcwQPUFXxgikGlcAjS0DehJPfO2kN3bjnt1AfiCwW7XY5ob45CPzq44rr/0J8sMvajiF9Q+zo7lCbe8JiUNVVFJWBBIR4LElkNcTqTUv0HiWAVazvWHMGQDOFdeU8UsjiA34Qoq4gEBgAA05vr4CKEVWSyiP8GOvBCXdEr4UeDNkjFQtp7L+Bupfaf/toVcLUGT5MYRQMX4EIn1R28e0HdqKnWFunQkrIQHE3s7h73xGTjFWMRvsZwa5fLHD8+3avDSDDqe26Z36rk3Xo5eNeqLJ92SeSiPA1UU6/vqkxGxsoI7jKhmfOlPrbu+t/9QlgKjwwdsCc3IHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ll5zfBALczPIo1wX2mI6h6gSjXh6byEMhik+c11LgY=;
 b=gRHHmOG7qlI8IocmJNLQ88FtmgGDMI5l66bNrMw1TDybSrzGZ+654rEwkKcWrzZqac9xj7DOKL6FjnON24174ifNahVMbAOyWjYznVMwSkXH+RXOFwvb4BwhjAF0aLfSOU6MTYqp0Z0wtpECDEt0HpQnM90rz6Z0/Ziy1ai4jUvQRvTGfJ67k5Yy38EdLzuQA0qU3bfvBCBh2mELimwoQQ1opM+kwTXOjxh/QM3uYKLj6460giso7cR0QDqgllwU7PuoOc+5geIb1MIAIxiI0fti6Jp2+ULSaVQTPR3/YSfALsIARwN4naG0yKHjvJWyWxQg6MnsWLZ4BLOBGH7Z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ll5zfBALczPIo1wX2mI6h6gSjXh6byEMhik+c11LgY=;
 b=DnV0snepCEXHI5UFVp6tU9gfRyp1TW4uaxRE3CMINjXF7kwq1TY+dsqclGDzmUnAVVuVDpc5XO/yXF57Otc4sH4p8kH+Zx1Ejfs+5xAEDcd2gO2snh3hh2+XJ1lj0eXXPDF34/MiL75fOFvPtn61mZla3N2HZng1DxsWYgAlirs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 19:12:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 19:12:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Fwd: NFS 4 GPF while processing compound with multiple reads
Thread-Topic: NFS 4 GPF while processing compound with multiple reads
Thread-Index: AQHY6jBUh8WIuUYo8kCKGh0YW87X4A==
Date:   Thu, 27 Oct 2022 19:12:07 +0000
Message-ID: <54463F56-C3EE-431B-9BEE-8B805AD011B9@oracle.com>
References: <CAD15GZfmZYKmGs7GfaUwM1V65uLirgwYBwrvBj7VrUpmFUjOTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4654:EE_
x-ms-office365-filtering-correlation-id: 75392be2-8471-4ee4-95b9-08dab84f2411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GEEIvikdEhXBq+t6qnfWjE6s/n4EIbP6BFHswfov3HTTUI9DosBRdiJRf1h6ePt6Ott98LDdS2vk29tng8pbR2pfAvK4o4u7FdbAaWNT8ek4PH0GcFUdU0a9BDnx98jm0p+cX+QJt3KfVctpAL2mpSaGs/ubiPlrtohssTmHR8kP5Y68/ov4LfjIYtV9kRwPWmI9Xun8AisNVoOyRl2TqePubaSPAWSi4nI1c0P4MsOd11+gbS551dk1e3oESXLrCCaPcscm6TmNPY2rzFf9grVoJLX/3aWD3Qg+uFOWgj6KNFrOF1ohsrviuYoNAeuNyuxKWgoqayGFjk9vXm+OzbBteBaKF25zZ2hz4naegi3Bg/TOFNZo25u60k1xxw1w3eZ8PlY6+OQq0TH7xaHyQFt02nOBzw6t1mJZRqCIv2pjgMD+j3dpYG5iRKYTvw+YZ7XlwmZZSJ3ATtBEwg04HhZzNu1lliw00ZRU6l5OfJxISXX1vROWlMv+cYWZUwnWCWM88Gmg9C6E2B/R/eA1JZJyl+eSWIDE+H2ibZQFAmxfe1GUnzYkz2pgznkbYjztDSQ+7SQw/q7GFJDOsBNKL26VpIigbdBMy7tjJZ7dnc+NEKz3CBPfXNOYsd++OsZjWPIP3QfSrDhZWBHAWfX5V1+TCs4RxYpUtIHPAn3Zy9eNMe29d+3Nbfypll6iMS4m6FYfWjZfT7nPdk//6yPEHMK+RpCtSdhIfnJbc3Kz/VYO1Nu9cjdbLFD0dJPjsu60luWD18o8UsR4DdvMz8Y0EkJvx4NWzcs28rQDJYIiJYTa0CzNimlG83mfAEwVCQDcUPgUzCuWSA9cta6may052shFcBTIgrTxStneP80YokU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(38100700002)(122000001)(33656002)(38070700005)(6916009)(36756003)(316002)(478600001)(966005)(4326008)(6486002)(91956017)(71200400001)(76116006)(8936002)(4744005)(2906002)(41300700001)(66446008)(8676002)(5660300002)(66556008)(64756008)(26005)(83380400001)(66476007)(6512007)(6506007)(66946007)(86362001)(186003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+A4LHsAYSM6KW2bmMNGNK3xHwuwJ0CMRWmBy8lnOpv+ar4dKb2nPEPBQZFru?=
 =?us-ascii?Q?4ERi4KgKE8glbPFB81nglrvb5n7jtVE36PHUykWS0eTjm487u1AVDFLG9Kix?=
 =?us-ascii?Q?eRVAFRbJOkV5G+5C5r82TUn4zXKeGRhWS+BvqSJoPEpoTH88gGLttj63mvor?=
 =?us-ascii?Q?pQjh0KdTCH2P7OS9lZyb2/1bInZXLfN58KLDXxrq+ibVHLXu5FAg/LDokhAR?=
 =?us-ascii?Q?4VS5Hy3qUSm4h+lMzGjXRqqj1KyencoBuyBqCKfHR+6ZFT7/EK83EzZyUFNu?=
 =?us-ascii?Q?WaEX4kY0RDcv4H8122sZ3iwQVcrz219dF9HJgZNtLN1zNDW2ddGr1eXt58/+?=
 =?us-ascii?Q?+Si0yaOTf3efd1pCiNhfuOlOfEMgF8yMyanaXMXzwCUSWJSw+ZuYWo8NImVr?=
 =?us-ascii?Q?b55R7jK4fGNfiflhJpcuyzI5Lk1bkMtfbX/gj+lvL+fzL/wSWY1gTv+870h3?=
 =?us-ascii?Q?dCNhK17R4GWfhih9ZoyNBsK+jARq4GbllgK9EA2HmF5eEACPOwbQWRup9Jj9?=
 =?us-ascii?Q?IslbsXuk949qSea20PJAafyFMCsJraROFzCaV/ijGpY0M+lF/bMK1vbpliPL?=
 =?us-ascii?Q?YeM1tp2UGJSWm30ctLqbzp4CYXV9NVW+77g4kUf2zOUqjaCQz/srsTtqbmM2?=
 =?us-ascii?Q?VjZlmSsyg4Sck/xtYFdrwc6Wk/fS/8qRnCwuUdZbSQA4H+0RD0/i2UFX+iCd?=
 =?us-ascii?Q?h7TUIPEniWvn1KL20bj9RpAx+zu40k3x6GphjNhRsgrktQGFFG+9S51oFO2s?=
 =?us-ascii?Q?9ktrr2PKZOVBZIDbA1ApmDNizQ14NnQX+PvO7vJen32N8SIn0iXIfnx+Nteu?=
 =?us-ascii?Q?PHMyEgjiBSKEMJD+8gt8uZqkxRRgP6OvWHhoe3mPchClx0rPci10kvSJivUC?=
 =?us-ascii?Q?PTmsLUYm77knRcb3u3ijyhU7HrmM7jQSVdTcUItONCAIkqVhMqSuXMYiksbT?=
 =?us-ascii?Q?8QkwmFHe2NQ8hiOpL8GPirXpQwStnYVTlaN57WUm8v9UoWwQNpj8OhUFkkMN?=
 =?us-ascii?Q?MGKmWAaT0NAK96hlfC9H28HsU5F0MKVEAtAbZlO3jWdEbaDzjv7nzNDsT174?=
 =?us-ascii?Q?7Azx7nZFZAbP5BbKsFH1cK35ub++FmHbF/mTraPY7A2blHdP8P+6KNhY72yi?=
 =?us-ascii?Q?03Cjz+d7s2US9gTnnNNmZ4oGDnDt4+g1MIuCgDbzmzfRVECM+NzxOorpRzya?=
 =?us-ascii?Q?VNIkkwsc2Urif+HMGx+v5EfVfB1oyj2u/+858dZPb1AhG3wM0C9//cz4TjuR?=
 =?us-ascii?Q?MnbhKQetJ1PHMOeFxdX4vxz9m8fedoDyixtERxHCdhzcR/W3qVwCygwV63qM?=
 =?us-ascii?Q?yyhK7MAvGmXWR08jSXjfO74hVwilUtolcbsqAdD6tLzTOGr5PRo5X8y1tZTs?=
 =?us-ascii?Q?UA+X+x19NUBrVXrMjXePBrTBXjC/u/5LsVq7nHogNeCrqaF7zQBJCIdhOqWP?=
 =?us-ascii?Q?TMHd9ijCEcDa51jJj7KgOYC1zILltxDwZG1McGrJzp9jgmk9OQsf1ylcz5DD?=
 =?us-ascii?Q?oMD3w48Io5sNP4m3V/0wy4KbiiOvwG2eBVx1WF2fPevgxaFL2qlsIJecJSmB?=
 =?us-ascii?Q?15+vtbbSOF12+RctGuAZLNKoUQ/nXX4XKHXH46QFXD7VaYHAvX9TW2LBCMlt?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E17EDB380845042BF985C134FA40EB6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75392be2-8471-4ee4-95b9-08dab84f2411
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 19:12:07.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HW+MgRnRCSqCgANsv73Wam9s89uXisbEaZwft9E2YaUfZSvSRbroFb//2z18zzKbYsJGsQaOFOkmuUA3QSHsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270109
X-Proofpoint-ORIG-GUID: lk_-4fcta0j4BdlIkiiLhKiQOHANyl1i
X-Proofpoint-GUID: lk_-4fcta0j4BdlIkiiLhKiQOHANyl1i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> Begin forwarded message:
>=20
> From: Jan Kasiak <j.kasiak@gmail.com>
> Subject: NFS 4 GPF while processing compound with multiple reads
> Date: October 27, 2022 at 2:16:36 PM EDT
> To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
>=20
> Hi all,
>=20
> While writing my own NFS client, I have found a simple test case that
> triggers a general protection fault on the NFS server.
>=20
> The NFS 4 compound is: PUT_FH, READ, READ
> The second read causes the fault.
>=20
> More information, including how to reproduce the bug is available in
> the bug tracker: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D402

Bruce, are you interested in applying:

https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D402#c2

?


--
Chuck Lever



