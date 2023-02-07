Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40C68DF07
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 18:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjBGReY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 12:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjBGReX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 12:34:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2480639CD4
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 09:34:19 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317Go1uE026703;
        Tue, 7 Feb 2023 17:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9xhD3qap7n91dl5wb57+9bv4y8+isTNNJ3xu76brotQ=;
 b=NiUTd6r/cpEM8B24rdG/AClOlyzU+8EGaACT8DnRU/8EAt4MItQPiUXezmnOUy+336m5
 vtnzPhniVoNl4dhTT4XYSIS6ddLHpk/MYJGjQzRJUgMX0guQp9CCaMGkbmVt4pN6EJ5F
 Z1m9b9nY805hTINWp1PR8Ya7FtEjG7c6lNvBRfNnlCP8JYvHS6XVM2XbLXuIA7qBv2Vt
 FnBcRssbX3a0UTcnavhlMBfPwZqIlubzt22pANTLwjAbfvM0Nm9Aj6h89Ks4Cjyg39Wt
 jPcf3k9PCU/gxfxALu2aS7ALJlZAUbaOdyazMo7KFuO447vz13hdAkVyBf3u1Osirsac oA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwu63nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:34:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317Ga0k6028705;
        Tue, 7 Feb 2023 17:34:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtd0b1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhYAHUvkCvUnU97bYrWyf/ETGJJmPQBFmNPvKcLsK27vbLvf4pmLKimilataUrxKgqCPLYAJjt9bKXZR6Qe0RqHeiwqIF67/rzd4tqTeG0XzrYfWyvCbx/OoiKZ9d3DFNNuCMutQJmgndUA1yLDutSyJjGBm1/tHzUL2FULJj+PsV8dWzNpDHRTwe6uNZ9OgCp1ATcuPBcuoHIZ6CCyc6VnkK6WSGLEsrQ/DUM5UpSNFmWvHaxZC9OLsahSb2zBl2Hu0PO4AbRS4Oj4X+71SAw/JuYzNSBTSqWgDXmBCmNhAZLYHDHIREv0oHbkQX/Si8om1kaoXwjQIAjhy0sLb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xhD3qap7n91dl5wb57+9bv4y8+isTNNJ3xu76brotQ=;
 b=HQWMDwAK+L0iwROnGXA26BvOQojxWUghZgK+XKRTcsVWb6rIuTAItNtXmuaxFXS9de0/avapKWaHKMl2uHWOCW+ad67U2K77FTI41qQYK1xKhAqH1rbWAxOhuKKHij2tKJo2bHghziZXc0UqCQZMrBIPypgY2aRKfluuNwJTc/6L3+M9yV7N/yrxk5jIAjQiIvKUymi5UkOvlSXIYa6bAOr0aD9I8247QgYtQP/XNL440nc5KmH4OFMmuvA1WIEoLnoGxvLbf8enIRS8VEP0b29kWFsygVkIvfY6wgHC85sMeZKsRQNjfjNWMMyWkJnWYNuFBH3uo5WiHbU+dkaAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xhD3qap7n91dl5wb57+9bv4y8+isTNNJ3xu76brotQ=;
 b=Gsf1fNifaE8+ia1sxd4hIz2RX4wFV+kLYqe2lD4nLswcjuAjcSuZp83jE0asV9medR5KDOsiRfotbSdLmWq+aJAxNTkJeR0GBdPwFS1lyBhyM6bfkd0axsZtba6JCw+qjzf2hperkAqkKhS2GQ3mTPejFRoRfbH6HyuVdM78SaQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4492.namprd10.prod.outlook.com (2603:10b6:806:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Tue, 7 Feb
 2023 17:34:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6086.015; Tue, 7 Feb 2023
 17:34:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Pierguido Lambri <plambri@redhat.com>
Subject: Re: [PATCH v2] nfsd: don't fsync nfsd_files on last close
Thread-Topic: [PATCH v2] nfsd: don't fsync nfsd_files on last close
Thread-Index: AQHZOxYFyj1pBOKhuU2xk0IafMVef67DvpiA
Date:   Tue, 7 Feb 2023 17:34:09 +0000
Message-ID: <1A627D26-6F51-4901-B39F-B4C51C61BCD9@oracle.com>
References: <20230207170246.198342-1-jlayton@kernel.org>
In-Reply-To: <20230207170246.198342-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4492:EE_
x-ms-office365-filtering-correlation-id: 49dcad4f-f090-436b-7e18-08db0931852b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bvApXHtumNusHzpKDfXoVOMxMH7ScFnSqZt2RYJNqg8/crQiKNbhEUFuqFkslqgh6yl5JxmWVyaAIEpAldXt57IC0yYw9lU+k/DszCqWnQIYyBqg7pLYfQD9JxnxWn6BGeVu51h0ifJYyikw3Dv57oEquysOyhOsm0v7MA0rs25MOfmjVdM/dEbpO2dCHZOH7QejxAUPhPqQjEEetS/p/Fpam13MTjAwfGFcdif47nhruXx05AW655v593vMrYQqLqFMgMBhu8Yt/x8LIRZ/7jrNATjvCC2uU+JWpUjuo8WyZNZWH7eZgiGyjQgwCoQSRA6Uva18ZSGax8EaLC/AJ1YZEyN9L8dG4Syhp2GPdGDbH+Tz+VWcCTqh9qkOMQo+lUxGAzSU11syrAsAKSIbj6S7XOSl/OtzGUz5q5Py2Pld/hL9saeBRiMex6H6joJyGeeokp0pziWHXCDHy+OoLQ1zelwGvVlebciC8pPH5N8Pl1p0hEpqCXFJ5qhnFWFGlhbRSytkGLnWotxFaDoSdCdtEcRRnfGoTq6DH8RxUfAf/eMr3ERsBIqYuGyyF/eQKa8FsQGii0EgMiJs1OSFrp6JZ4274jIRvk/fvg05Eu8hFC711/kNV8LvvI/t12xUOIrOX0ci9RhQ4NSdCpZaNHiiuaMm9ozJDj9R1gWhSWqCZL2izW1tuXXnaN+kkBe84KUsJRtC56+4sqVNaljMIR0Z/rZvwmrelMsbEqCCrGcFh1d3noTEekMZeZ7pJD+FvT3p+4qV0g/hZ/X+BY9Zuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199018)(91956017)(41300700001)(76116006)(66946007)(54906003)(316002)(8676002)(64756008)(6916009)(66476007)(66556008)(66446008)(4326008)(8936002)(5660300002)(122000001)(86362001)(38100700002)(36756003)(33656002)(38070700005)(186003)(6512007)(71200400001)(53546011)(26005)(6506007)(2906002)(2616005)(6486002)(966005)(478600001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?odkQku64NYvVEfj9wfTGEMsACcL+xHmeT+J6AhRgXQmNVQ2s0fEGdUULPq8c?=
 =?us-ascii?Q?oodvqpAQO0FfM94622DtCeYqIPIP0tgDJmhf7GXa6gTt3GqR34q9RxfRycaN?=
 =?us-ascii?Q?R+zSaoK32typ9kWva3uCRKACTtxf+8Hwlu/ElxAdLRWfmmjABRJnhF6+1EZw?=
 =?us-ascii?Q?jIB4+DrpTbqf9r+fzf0862S6umqMc465uJpTwtu0zchCoTac8dAfK6FwoDek?=
 =?us-ascii?Q?lwaZWVrcj7s6yxWCP/L1Jw86VEVmR0uFDdDjE8+F6KzgB/d/A5rggBgufoSV?=
 =?us-ascii?Q?GcLJiEAcWVhozVGhoxBqkmlTviKItJyR67JQ7JnoNRxoj/D2tWsjkhMsm2zM?=
 =?us-ascii?Q?oRtCH5r+7GUITlhTnizITJotbePcJJL3gX3FLhClXpyQ607QSIH8/7w58aZx?=
 =?us-ascii?Q?qBmuI5c3x76ICYlqMsttHzxrIpM0p/X9arbOv/p8XDLfeJoBHsnrO5JgbDm5?=
 =?us-ascii?Q?hwmsaipYmQm5g2vQAShhg+f84Ww6u7uvM0iM9jEQEMBORHa9FgAj70AVymlV?=
 =?us-ascii?Q?/IcZYvMYlDXmHjjZJgN8a7thjRcos+4/wwm0gffZzIZzJKRySqr3/yOpELWK?=
 =?us-ascii?Q?5wNIe0HuITg3phfyEvQpV++VeVyIVpcz4x+zmro/OBdJMIIn3WFTO3Y1zeEu?=
 =?us-ascii?Q?7/j+ZUy9fEul/0XQOncY7IVIt0Xn7mn8JIoH2f1ZJkUido+NfESgfVmzlHIc?=
 =?us-ascii?Q?+AYCcM5vZ7EoTC68dvHIE8Dxnat0AxfPtItu1Wy281s3Mn4ZsxzmGw6cMumw?=
 =?us-ascii?Q?QWhoudup/b8+1qa6c3MpNneDhfz/ljsZU01yAz/G1NMItiYbD6dz9qqYcUUW?=
 =?us-ascii?Q?uNSdCiDZbu1OGt5cguKfIwg6KVol4ioKJdb4DlaWKzkskSPXfvjWdJ4HhLA4?=
 =?us-ascii?Q?GDl4f2oLv7Sav1XSW6x7DHrrvNixaNNlcyc7RFJb7tU3En8EnJk00lmKR/b8?=
 =?us-ascii?Q?vYwNAhc4iROlorNFlomzqel0k6Xf0Y8VOaH6DKtPD1q5Z6mZFLzrUpzArOUE?=
 =?us-ascii?Q?tpg0ZQ1ayfbo1TmO65NJCdFw7ZN2kZJ3uaCKmPUkddL45O3JTxYdj8GWQ8zp?=
 =?us-ascii?Q?v+Q65FEPc0BOlYj9FgPvlIUiEniKWPwzBeablDrwUb0Fs2rNjCsCwvXzhpaS?=
 =?us-ascii?Q?SYTV3lFHtRUL8eDCjzjGsRpSyCBjxm7K3uFkKA9lRXEQ0P0MtBGIYnK3OVcI?=
 =?us-ascii?Q?DXwI0IpnK7YQtuDP4288fQnR7L05xxUXId84QPMJB652pG/OZQWBlFICErdR?=
 =?us-ascii?Q?XZjA3l0cowG6NNbnU2CNuPz8QEkdOceAN8gK8Fm2zN2fO7wFfjlpidZ7p+u/?=
 =?us-ascii?Q?Y0LB//b7Ss5LuPPiMeJbzL/8MAiIpr8u74Wnivp6jgRs5PP00YGi6jj7gjsH?=
 =?us-ascii?Q?nCvE4c9QBs5GhDJg536ZH+q+OryWZ5PBljtZ5rpqICiSrZt600mt5HvmWyrc?=
 =?us-ascii?Q?4xCbD/m5EZYkDtP1zjWAuu1YsCqebLKDTIbssvRaFFKUU2Lql7xtp5Kx8SWZ?=
 =?us-ascii?Q?HU1TzK1fTl4pCy6eRF0FmMHihwEYYj1PJqyMO99i+1Zs4ywGu2x+3kARVIO4?=
 =?us-ascii?Q?qQK4h52qUU7ZGPEUWhsruEXYAKilhtDfWI7kRgKG5V7axgkbA215k4QRPb+R?=
 =?us-ascii?Q?5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F85A9B48277CB64E9017F51323809385@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DY2ZvTQ0oRoi7Ncg9Jk9pXlzu0zYhyyZDCGXJ7nhSD4m2n9yW0vy/yLNUyP7q7NeJimpTudMGYIafMbAAZFpNEBHGONxlMlhWQQB+IYVSDL3k8112Xb1/ReX4z6QX5CT/BFBra3czWLBTm7tZbjBAdjpVFIG5L2bX5e1W7RtB4w6h5diKfnv6xQQ23RewfswQpPdGlVu8+r8lkTSAU7yjHps8BkWgoOMGIMHz9OmbN/KXZVnfGn6Fmd5mnTqDHdT/UtArBUdXJbiK8x5jtt8lj6spBp12tXOYWWCovZaXkkDSD9ckn9wErwLCglCp2OsTLo/DLKqh1vB2mbonf22TsXT5r0qFJt6cOh3CEEmGmvcoaR3P65fVMwHWxCL4DAyG7FaKChyAtSx+cOpPWDS9j7KrKDiWj29UsB2A6ikGxXZt86cJFaP3souSdjiRuB66mcXM2+0Hvy5AAJ73tIV/tIt6E4NfIWojzEB0nBgap5QixW8nmYijZefbXOeLUiJElZ25MdDk42q2Cxz59KIC68AmjnPzd5SJr+/CN1OWefPxfWuxcpiD8jyZUHFn02pdBTCunMxr42Ev3wSp1cTDe58nzFUYIkoGLQwhR4rGc7Ii+JghnkRWnfGWoOHJlacie/wtZere3jMBHk3Am84ChSR0xogx3AAP4/D6l2zSUVDEEMhh9MrMgMlpkQX/EQJ9XWA1s8B4p/QQLojYcpYLDYNHIVs/bbrCY3YSouQHqkOUs7IetWZghAfeU4jzoTNgDAB378LBF0/Zj3xbVxa1paOcRBNng3sTX9wNbhG/80FInOscmiqJwRDRxyq/vG4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dcad4f-f090-436b-7e18-08db0931852b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 17:34:09.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+GB00a4wAtTVUGvuOlCAF90ZWXFekLCECpPJpCnu65UNrdaJ4YZvnsdm90htm+bzNCRHTWy6LmiazER4Ky1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070157
X-Proofpoint-GUID: VcGX6BO-M6wPk7hKe1B5eKPt7BoabTUc
X-Proofpoint-ORIG-GUID: VcGX6BO-M6wPk7hKe1B5eKPt7BoabTUc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 7, 2023, at 12:02 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> Most of the time, NFSv4 clients issue a COMMIT before the final CLOSE of
> an open stateid, so with NFSv4, the fsync in the nfsd_file_free path is
> usually a no-op and doesn't block.
>=20
> We have a customer running knfsd over very slow storage (XFS over Ceph
> RBD). They were using the "async" export option because performance was
> more important than data integrity for this application. That export
> option turns NFSv4 COMMIT calls into no-ops. Due to the fsync in this
> codepath however, their final CLOSE calls would still stall (since a
> CLOSE effectively became a COMMIT).
>=20
> I think this fsync is not strictly necessary. We only use that result to
> reset the write verifier. Instead of fsync'ing all of the data when we
> free an nfsd_file, we can just check for writeback errors when one is
> acquired and when it is freed.
>=20
> If the client never comes back, then it'll never see the error anyway
> and there is no point in resetting it. If an error occurs after the
> nfsd_file is removed from the cache but before the inode is evicted,
> then it will reset the write verifier on the next nfsd_file_acquire,
> (since there will be an unseen error).
>=20
> The only exception here is if something else opens and fsyncs the file
> during that window. Given that local applications work with this
> limitation today, I don't see that as an issue.
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2166658
> Fixes: ac3a2585f018 (nfsd: rework refcounting in filecache)
> Reported-and-Tested-by: Pierguido Lambri <plambri@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 44 ++++++++++++--------------------------------
> fs/nfsd/trace.h     | 31 -------------------------------
> 2 files changed, 12 insertions(+), 63 deletions(-)
>=20
> v2:
> - rebase onto nfsd-next branch
> - add Fixes and Link tags

v2 applied internally for testing. Should make it out to
nfsd-next in a few days, and then appear in the v6.3 NFSD
PR in a couple weeks.


> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ecc32105c3ab..6e8712bd7c99 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -331,37 +331,27 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
> 	return nf;
> }
>=20
> +/**
> + * nfsd_file_check_write_error - check for writeback errors on a file
> + * @nf: nfsd_file to check for writeback errors
> + *
> + * Check whether a nfsd_file has an unseen error. Reset the write
> + * verifier if so.
> + */
> static void
> -nfsd_file_fsync(struct nfsd_file *nf)
> -{
> -	struct file *file =3D nf->nf_file;
> -	int ret;
> -
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return;
> -	ret =3D vfs_fsync(file, 1);
> -	trace_nfsd_file_fsync(nf, ret);
> -	if (ret)
> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> -}
> -
> -static int
> nfsd_file_check_write_error(struct nfsd_file *nf)
> {
> 	struct file *file =3D nf->nf_file;
>=20
> -	if (!file || !(file->f_mode & FMODE_WRITE))
> -		return 0;
> -	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err))=
;
> +	if ((file->f_mode & FMODE_WRITE) &&
> +	    filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)))
> +		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
>=20
> static void
> nfsd_file_hash_remove(struct nfsd_file *nf)
> {
> 	trace_nfsd_file_unhash(nf);
> -
> -	if (nfsd_file_check_write_error(nf))
> -		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> 	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
> 			       nfsd_file_rhash_params);
> }
> @@ -387,23 +377,12 @@ nfsd_file_free(struct nfsd_file *nf)
> 	this_cpu_add(nfsd_file_total_age, age);
>=20
> 	nfsd_file_unhash(nf);
> -
> -	/*
> -	 * We call fsync here in order to catch writeback errors. It's not
> -	 * strictly required by the protocol, but an nfsd_file could get
> -	 * evicted from the cache before a COMMIT comes in. If another
> -	 * task were to open that file in the interim and scrape the error,
> -	 * then the client may never see it. By calling fsync here, we ensure
> -	 * that writeback happens before the entry is freed, and that any
> -	 * errors reported result in the write verifier changing.
> -	 */
> -	nfsd_file_fsync(nf);
> -
> 	if (nf->nf_mark)
> 		nfsd_file_mark_put(nf->nf_mark);
> 	if (nf->nf_file) {
> 		get_file(nf->nf_file);
> 		filp_close(nf->nf_file, NULL);
> +		nfsd_file_check_write_error(nf);
> 		fput(nf->nf_file);
> 	}
>=20
> @@ -1158,6 +1137,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> out:
> 	if (status =3D=3D nfs_ok) {
> 		this_cpu_inc(nfsd_file_acquisitions);
> +		nfsd_file_check_write_error(nf);
> 		*pnf =3D nf;
> 	} else {
> 		if (refcount_dec_and_test(&nf->nf_ref))
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 8f9c82d9e075..4183819ea082 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1202,37 +1202,6 @@ TRACE_EVENT(nfsd_file_close,
> 	)
> );
>=20
> -TRACE_EVENT(nfsd_file_fsync,
> -	TP_PROTO(
> -		const struct nfsd_file *nf,
> -		int ret
> -	),
> -	TP_ARGS(nf, ret),
> -	TP_STRUCT__entry(
> -		__field(void *, nf_inode)
> -		__field(int, nf_ref)
> -		__field(int, ret)
> -		__field(unsigned long, nf_flags)
> -		__field(unsigned char, nf_may)
> -		__field(struct file *, nf_file)
> -	),
> -	TP_fast_assign(
> -		__entry->nf_inode =3D nf->nf_inode;
> -		__entry->nf_ref =3D refcount_read(&nf->nf_ref);
> -		__entry->ret =3D ret;
> -		__entry->nf_flags =3D nf->nf_flags;
> -		__entry->nf_may =3D nf->nf_may;
> -		__entry->nf_file =3D nf->nf_file;
> -	),
> -	TP_printk("inode=3D%p ref=3D%d flags=3D%s may=3D%s nf_file=3D%p ret=3D%=
d",
> -		__entry->nf_inode,
> -		__entry->nf_ref,
> -		show_nf_flags(__entry->nf_flags),
> -		show_nfsd_may_flags(__entry->nf_may),
> -		__entry->nf_file, __entry->ret
> -	)
> -);
> -
> #include "cache.h"
>=20
> TRACE_DEFINE_ENUM(RC_DROPIT);
> --=20
> 2.39.1
>=20

--
Chuck Lever



