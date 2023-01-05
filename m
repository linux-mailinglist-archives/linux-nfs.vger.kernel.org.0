Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ABE65F295
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 18:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjAERZZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 12:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjAERYS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 12:24:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C896C101
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 09:18:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3nlI014078;
        Thu, 5 Jan 2023 17:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dPe52vETVjN0GXHRGkYYzftbGlrSITuzHb9kxxaLBb4=;
 b=c29V8ilY2u+W2dJVKTXvH9KCZtjv946TNGmRT6OPEozharwOltfW4YhcD6oibt4Ix5Jn
 rU/7dlUlFis4ps7vxSS3Xm/Zlsa4Wl8yQd705uicgWGwlPEP3H6rBlsOFV25KMn3gbvy
 vv4wFGroA9AZ957IPueIgQh3ijg0FMvXsSLGn7f+sig67Swci6zJi/WkwGAD/+dDJ1Dr
 vLi1OllvCNKLVDzAwJuOSup/H4Y5/lRArKZxG8gxn0dayH77Mjij+NNxsXvq+BDWOT4K
 OON2BYlfkVh0aiKqYRCdLFKAYLHcmjPmRrxFdvQcOhEBuB8a/o1abwXVWm19/x9Te8ui Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9fhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 17:17:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305GFtaq033807;
        Thu, 5 Jan 2023 17:17:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsddg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 17:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWsHbzWjLLl51Sk30AAAoCqa/vmzV251AtEBUA6apIZ4Q+YJEpUI08A5ZU9MGT9xysT0S1loO3FejCbR7OSB6OfpNs1Zd8YMAvp82ZgG0KOuB4hKbpBmHttLoD5DLFGduYDnVpj9SqZ0ceDgG0/3zU9gkNLvukdFHgPDDMnqfylqwd9UFAhamq/MdeqNyOfooZYDeQwMBji1VsFafvDPJxobEdXk1KnVdWhXDmrT3Cgoodq56VEmt8n8m9Oa5XUN8im2RVXsdEZgk8sH0scUE7QNfYX042W0ozjsUgWH4vjZ/0kCn/MRC+8rzyENZU3puPyESr0OxSu65S+XFfo0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPe52vETVjN0GXHRGkYYzftbGlrSITuzHb9kxxaLBb4=;
 b=NyCC5cf6Ts/MaKbnPxUiN+8vGxBlP2Rd2eIEXYE5g6E7scVqIqFckZH9uwGLm7nU3JNUJowrIQWJsuheWsTaKl7koXNbF1b/YxeJ9VmpUki9Imei9OrTX5B0hXhjTnEbVS9ZAjpevG+DcUErHjrd3/qwipV4FIVR8kqtecSbZL+czH2C+Pwb6Nz+r3P6xIiJeWfLkVwbnc+tLp2R62n5+hOPutwfXvXOcqeKAVf5SZ/9zTCEPAOy98Uqb/KWwzF8sxaG0JDsV1PK0nZ5LfPPLCmwUexOUJ+QHBBxww2cBZDlUA7xfqyhQkBAzRg29cTnfoX9NmUkHlUnbgfvbDK6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPe52vETVjN0GXHRGkYYzftbGlrSITuzHb9kxxaLBb4=;
 b=pL1j6dHh1Jblv9TXFkmWTlEsF4OTEBBATL0C59Opf64zgA2cPfPFGOsP144tt/RNxddBptFBqgrMZXwcB67Cqhh9sv+nCzz/6D2kE614mTzGjvfdltTHvEYvDsoGzC1gqy7aODqizz4L62R4ZWkkCfGImsjkKhMzaNLFswcMrIg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:17:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 17:17:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Thread-Topic: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Thread-Index: AQHZE0St34jtf1Ze5Ey5ptczv+ym966M9LkAgAMlIACAABLngA==
Date:   Thu, 5 Jan 2023 17:17:54 +0000
Message-ID: <667E8EAA-32BB-491F-80FE-B5A37770995E@oracle.com>
References: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
 <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com>
 <CAN-5tyEL1FvvCMgg=NWrHcAvLdXFKZQ_p1T8gRhH9hUoD3jPhA@mail.gmail.com>
In-Reply-To: <CAN-5tyEL1FvvCMgg=NWrHcAvLdXFKZQ_p1T8gRhH9hUoD3jPhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6365:EE_
x-ms-office365-filtering-correlation-id: 8403a960-1d23-46ae-7e06-08daef40c856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VemrcxmCL10RK1zw810CpTc1a49Ok/s/4rvIXlxRdTOTRuCVcSVesBUJb33awTBAnQs1dh3NpTDiFIByS7aVCVqXuGOWlyhFnyti+wtu4O3eMwurcAPBoReP7m/YxKqJppgULbcug7hi5RRBJJUpd0dzSd3L298rPkRGpmI9GMbGCjKiVmHu7bJb3TAnmsErFssLWAYxMKF3dAVZXPeHrr1eWaL7KJAkHpYi8OOE4/Vy+sKnRgMIONVXmd3GTfYZwpj38+IMke4qk+l5gencjXCxtQpnxmMqHeVuilXJJaonDINKt4wwUbKNFFvYAjdwlkxgxEJm4p8WB/Kt8555KFUpSpOQanMnbn7n2hBXWBMDMa3dSt9wsaBLVvXKokL0gFVybudOD67SDPuiit3BSpWRWnS++nw1u+tH3W2HymRogqfd3u9Z9V7+zVdWmAMu8OqZ1IIAudPwHyKlhPaL98TYAVcaXckRFdE7JdEFyh/ej3rcPeaCq7UWKDoWl7+8yp6+XhCe6niSqDGI0an11UK7Aah46mlkKhOdJwhfqmoIR712Q1GmOj0LLqzjHFvfC//tLayJpzo/9tcuGCt0P1RnkB+1qm69gHy6305e91F7kw5I6v2O1AM3U3VnGmtlPLDm+xJfzJALSyG7rdebLT2NM4ZskXuN1lUb2Lb/+jNorqDdGLPrbfjQMj8EikaBl8Fe+OIoWP4rwxUQWGIXrgm9/jgSXEzUbwYUnF96Mfs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(66946007)(316002)(6916009)(6506007)(186003)(76116006)(6512007)(53546011)(4326008)(2906002)(91956017)(54906003)(5660300002)(30864003)(71200400001)(478600001)(26005)(41300700001)(6486002)(86362001)(83380400001)(2616005)(66476007)(38100700002)(64756008)(8676002)(38070700005)(36756003)(66446008)(122000001)(66556008)(8936002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yIPQF2rq+4BuBsUVFz3whP/fYGY+287XCBzPHAZisDxNauBiLh0lVJhrAQ3Z?=
 =?us-ascii?Q?rO6fXHQOik+x2lwvfPADmjgOhuM4Nb7heqYbd70bRm0jipdGQomcktHmmKSb?=
 =?us-ascii?Q?e2YQyRyJ3zAbnzukK3EmXmO/9QBn9Z4hsZO5418ECq2puLRkTU9t+vnNBbrx?=
 =?us-ascii?Q?l+YumZzj5Lwq3R0f1u7qTanqn9IvQvK/O87+Hi2qHyOQAG/W/ZJpwN5aXSrb?=
 =?us-ascii?Q?RX0H0/e6aM+CKUpVqwMfRChtaJfDZwnVjm+wxy0P1kVO3ETdmQc2KCjqnmK9?=
 =?us-ascii?Q?jCrmhiFUFxiNnYiLoa786r7b42cLmMARosKNh5bc1edFVVCXKNhkHarsCgm9?=
 =?us-ascii?Q?ilST/lE2KYC1c3zNQ7GV/dRtSWBgPItZmarikAljkmZ255SvFxGTH029vbPs?=
 =?us-ascii?Q?ii7f42uhH8ItOGzBSsR8IuTofBWon/0+iATCS1UzmKetWPqJug1Is8kVb+CI?=
 =?us-ascii?Q?UfN+GCI32mvDgHVmBU3JtRz9co5zFZWiCJn0A6e1FSz+IAFRQdJDmp+5kMN6?=
 =?us-ascii?Q?jkiB1DNpmNQUq7B0AI+1sMzz/QOkYzJ7ArVMDsdecb2HDackaOW409AOiKRt?=
 =?us-ascii?Q?pKYH3wMNPqOpTXx4TN535d0vx2JDdolOCoRTxRbMX04osHy8L1FAP+3FZAr+?=
 =?us-ascii?Q?0VFI7UlhZrzuevA1sjZK2ZFTm/sB/IRzjMRe6aUeiEtf47AR2wgzEf24yXCC?=
 =?us-ascii?Q?pbDSFklcf0E/Up3aIuzMRSWcdEHllCU2NYCkdF9MP7BAeOsgB2GpvJFMEici?=
 =?us-ascii?Q?GeNLG1b7gItyPvRM7QGSub6gynVhH0kqW+Y99oucdH33RPhrkx/SU8JFsUsu?=
 =?us-ascii?Q?9ma+V2tYkcwNfF0QXQGPj1tdTHdUnH8gJtL7uyYTb6rRkn9qL+LXHQ9aWL9R?=
 =?us-ascii?Q?RPUbSWB5br3qAdd2cSJuFhzIz7qdI2yuCAeLPXl/sO13aOQnCXc+LnTka8Bn?=
 =?us-ascii?Q?XuBN8PDJ5+TrbwH4Hg+JS8kYm0O32l55VlQJDjXXsUCC9R606/utkIOdsQtG?=
 =?us-ascii?Q?vPeBry0bXDleHn285hyZSwQY5L49b0qHoa8vNO4UwMAhI7Ki+i4NQLq8rke/?=
 =?us-ascii?Q?+leBuLMxwJUgEnlwgCdho1+tFpoH70VZchbx7H4HQ6rCtlSeyux6Jl/r0Bxu?=
 =?us-ascii?Q?fTsOu7cvynyw2yoeDaHyD/iBJcNgCXCMRqyNZTZyK/kYLCnMS7mQVtOIgNcP?=
 =?us-ascii?Q?3/lOVzbCZphmDJx+e3Nxgd/euEPCFAbTJt1H6T7lu1a+hKR6/yfkuO3/UgVh?=
 =?us-ascii?Q?mrV6S75t7v9SlDwX4wl+duxXUS6K1ZZ7l8mQKQoyKwNMCl0ebsNkXtTIwdp/?=
 =?us-ascii?Q?P35eJUNqupaMmb8CNOEEyRO51GGlR0LQ4eiQJjtjMIoFjWSOaZaNm0Nf9Faq?=
 =?us-ascii?Q?ow0azDOMb+T/CZvlnoNHI5gQfxtp8Sid7zpC8g43R1YiIY/FBEK5NsxjZUZn?=
 =?us-ascii?Q?fVSm1ehKPT7Tv3PuUZLO3kKqxplyBKFli61AUv51wMg5mryDnB8WxQyXgyYR?=
 =?us-ascii?Q?KVVBoZpPTeZGhEcWThogtSvwlwgZ6+XeK0vX6Kk+MSKdUQGxUL0jx++zDfd1?=
 =?us-ascii?Q?3jC7M/dVskj0feiRor52zd56JCQMpHLTNf7Qv/9FX/oVdno1OCFXffB2JkE7?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5314754B3E1A5F4F817378D8152A026E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SFSvPym2AAuw8FoHCZwM2q8nPTt/MmZyryX7nasiluCGPmyfnbVQDepDVF/i0i37nAQrG7jXBL5v7JGSqtD2mWFMtFuvuspyX1GG8r5ZLkREmT/l+6gtKMNNWZ+iLSAob1u5cYMua0VHsnId+YHoHan78F76oJISBgjvWePej/AAYJgDTIDUjy1cr44vc5y5dDVFSt1iteCAEYXChN6qqi3Nf4n+DCUqV+9xdj2ixp5O5W9xgy5d/m+gaV5FH336frUAnGLeh6hd40r58kvzKSs77NwonewWV7tqX4sAATlMkXVzT19r/NVX38nKD7gYS1iuQ/PUtBOuHqpgWzmJh78YCo1qLHLvmdB3Waxn0Wgr9V9RdopbIGc/Ve4EsdXCVDAG08jM5deV4SpyA+brd2atzMEMExucXMgPB30tMadDQW5y3D0CjOLw6IlE2eJ6ZFBD8w8kEaI2fqUA2dYYm2uBd7ygdsqI1j82Xsf62tH/BuAYohAvc4eud/ti2HIdkDkWmAw9zN0foPg5WvJdqKD4bwgx6Gxl67Xz+sewx3EL7BaTf8TpYchvqV098YQVRSyac2h67jlPRSlvO8Wql5e7yDHhEA9r2OrCcZ00sN2ecAI/pCmKa1f8knmks0YtNNWYpJEAKif5RoYEhXKBlPHnIJrsPbC9i+nL65nHBJi+7su6rGdNbDKBkV4zQAB5DfmptyiQ63GX1/p9+rLtHrVGT84agRv9Lu78J4grY4gCMXSMIcZwJrsg2d6UKlhk60zBZrcL5o8j60SvJJjs7p6A2h6bdFzTCQ7RaUEe/S9VNeqint3wzB9ukNhPQy3xP2OldBEhbXXZTauXp8aagg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8403a960-1d23-46ae-7e06-08daef40c856
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 17:17:54.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/sylv3hQimYHN/VAcabV3PwXAZkAfXUXWj2GWGr0JWTAaqgD6DGpbTGGmQYBjBTJBlRFGKCSHVNPwvp1Jmdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_08,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050137
X-Proofpoint-GUID: ucYMnZgQsKJELUo7cgjylsINeEfQ58H9
X-Proofpoint-ORIG-GUID: ucYMnZgQsKJELUo7cgjylsINeEfQ58H9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 5, 2023, at 11:10 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Jan 3, 2023 at 11:14 AM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
>>> server's export when the mount completes. After the copy is done
>>> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
>>> server and it searches nfsd_ssc_mount_list for a matching entry
>>> to do the clean up.
>>>=20
>>> The problems with this approach are (1) the need to search the
>>> nfsd_ssc_mount_list and (2) the code has to handle the case where
>>> the matching entry is not found which looks ugly.
>>>=20
>>> The enhancement is instead of nfsd4_setup_inter_ssc returning the
>>> vfsmount, it returns the nfsd4_ssc_umount_item which has the
>>> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
>>> it's passed with the nfsd4_ssc_umount_item directly to do the
>>> clean up so no searching is needed and there is no need to handle
>>> the 'not found' case.
>>>=20
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
>>>   Reported by kernel test robot.
>>=20
>> Hello Dai - I've looked at this, nothing to comment on so far. I
>> plan to go over it again sometime this week.
>>=20
>> I'd like to hear from others before applying it.
>=20
> I have looked at it and logically it seems ok to me.

Thanks! May I add Reviewed-by: ?


> I have tested it
> (sorta. i'm rarely able to finish). But I keep running into the other
> problem (nfsd4_state_shrinker_count soft lockup that's been already
> reported). I find it interesting that only my destination server hits
> the problem (but not the source server). I don't believe this patch
> has anything to do with this problem, but I found it interesting that
> ssc testing seems to trigger it 100%.

Good data point. But Mike says you can revert the delegation recall
patches to make things stable enough to test, if you'd like to try.


>>> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++-----------------------=
-------
>>> fs/nfsd/xdr4.h          |  2 +-
>>> include/linux/nfs_ssc.h |  2 +-
>>> 3 files changed, 38 insertions(+), 60 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index b79ee65ae016..6515b00520bc 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block =
*sb);
>>> * setup a work entry in the ssc delayed unmount list.
>>> */
>>> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>>> -             struct nfsd4_ssc_umount_item **retwork, struct vfsmount *=
*ss_mnt)
>>> +             struct nfsd4_ssc_umount_item **nsui)
>>> {
>>>      struct nfsd4_ssc_umount_item *ni =3D NULL;
>>>      struct nfsd4_ssc_umount_item *work =3D NULL;
>>>      struct nfsd4_ssc_umount_item *tmp;
>>>      DEFINE_WAIT(wait);
>>> +     __be32 status =3D 0;
>>>=20
>>> -     *ss_mnt =3D NULL;
>>> -     *retwork =3D NULL;
>>> +     *nsui =3D NULL;
>>>      work =3D kzalloc(sizeof(*work), GFP_KERNEL);
>>> try_again:
>>>      spin_lock(&nn->nfsd_ssc_lock);
>>> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_n=
et *nn, char *ipaddr,
>>>                      finish_wait(&nn->nfsd_ssc_waitq, &wait);
>>>                      goto try_again;
>>>              }
>>> -             *ss_mnt =3D ni->nsui_vfsmount;
>>> +             *nsui =3D ni;
>>>              refcount_inc(&ni->nsui_refcnt);
>>>              spin_unlock(&nn->nfsd_ssc_lock);
>>>              kfree(work);
>>>=20
>>> -             /* return vfsmount in ss_mnt */
>>> +             /* return vfsmount in (*nsui)->nsui_vfsmount */
>>>              return 0;
>>>      }
>>>      if (work) {
>>> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_n=
et *nn, char *ipaddr,
>>>              refcount_set(&work->nsui_refcnt, 2);
>>>              work->nsui_busy =3D true;
>>>              list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
>>> -             *retwork =3D work;
>>> -     }
>>> +             *nsui =3D work;
>>> +     } else
>>> +             status =3D nfserr_resource;
>>>      spin_unlock(&nn->nfsd_ssc_lock);
>>> -     return 0;
>>> +     return status;
>>> }
>>>=20
>>> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
>>> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd=
_net *nn,
>>> */
>>> static __be32
>>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>>> -                    struct vfsmount **mount)
>>> +                     struct nfsd4_ssc_umount_item **nsui)
>>> {
>>>      struct file_system_type *type;
>>>      struct vfsmount *ss_mnt;
>>> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, st=
ruct svc_rqst *rqstp,
>>>      char *ipaddr, *dev_name, *raw_data;
>>>      int len, raw_len;
>>>      __be32 status =3D nfserr_inval;
>>> -     struct nfsd4_ssc_umount_item *work =3D NULL;
>>>      struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>>>=20
>>>      naddr =3D &nss->u.nl4_addr;
>>> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, st=
ruct svc_rqst *rqstp,
>>>                                       naddr->addr_len,
>>>                                       (struct sockaddr *)&tmp_addr,
>>>                                       sizeof(tmp_addr));
>>> +     *nsui =3D NULL;
>>>      if (tmp_addrlen =3D=3D 0)
>>>              goto out_err;
>>>=20
>>> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, =
struct svc_rqst *rqstp,
>>>              goto out_free_rawdata;
>>>      snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>>=20
>>> -     status =3D nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
>>> +     status =3D nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
>>>      if (status)
>>>              goto out_free_devname;
>>> -     if (ss_mnt)
>>> +     if ((*nsui)->nsui_vfsmount)
>>>              goto out_done;
>>>=20
>>>      /* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>>> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, =
struct svc_rqst *rqstp,
>>>      module_put(type->owner);
>>>      if (IS_ERR(ss_mnt)) {
>>>              status =3D nfserr_nodev;
>>> -             if (work)
>>> -                     nfsd4_ssc_cancel_dul_work(nn, work);
>>> +             nfsd4_ssc_cancel_dul_work(nn, *nsui);
>>>              goto out_free_devname;
>>>      }
>>> -     if (work)
>>> -             nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
>>> +     nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
>>> out_done:
>>>      status =3D 0;
>>> -     *mount =3D ss_mnt;
>>>=20
>>> out_free_devname:
>>>      kfree(dev_name);
>>> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, st=
ruct svc_rqst *rqstp,
>>> */
>>> static __be32
>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>> -                   struct nfsd4_compound_state *cstate,
>>> -                   struct nfsd4_copy *copy, struct vfsmount **mount)
>>> +             struct nfsd4_compound_state *cstate, struct nfsd4_copy *c=
opy)
>>> {
>>>      struct svc_fh *s_fh =3D NULL;
>>>      stateid_t *s_stid =3D &copy->cp_src_stateid;
>>> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>>      if (status)
>>>              goto out;
>>>=20
>>> -     status =3D nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
>>> +     status =3D nfsd4_interssc_connect(copy->cp_src, rqstp,
>>> +                             &copy->ss_nsui);
>>>      if (status)
>>>              goto out;
>>>=20
>>> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>> }
>>>=20
>>> static void
>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file =
*filp,
>>>                      struct nfsd_file *dst)
>>> {
>>> -     bool found =3D false;
>>>      long timeout;
>>> -     struct nfsd4_ssc_umount_item *tmp;
>>> -     struct nfsd4_ssc_umount_item *ni =3D NULL;
>>>      struct nfsd_net *nn =3D net_generic(dst->nf_net, nfsd_net_id);
>>>=20
>>>      nfs42_ssc_close(filp);
>>>      nfsd_file_put(dst);
>>>      fput(filp);
>>>=20
>>> -     if (!nn) {
>>> -             mntput(ss_mnt);
>>> -             return;
>>> -     }
>>>      spin_lock(&nn->nfsd_ssc_lock);
>>>      timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>>> -     list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_=
list) {
>>> -             if (ni->nsui_vfsmount->mnt_sb =3D=3D ss_mnt->mnt_sb) {
>>> -                     list_del(&ni->nsui_list);
>>> -                     /*
>>> -                      * vfsmount can be shared by multiple exports,
>>> -                      * decrement refcnt. If the count drops to 1 it
>>> -                      * will be unmounted when nsui_expire expires.
>>> -                      */
>>> -                     refcount_dec(&ni->nsui_refcnt);
>>> -                     ni->nsui_expire =3D jiffies + timeout;
>>> -                     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount=
_list);
>>> -                     found =3D true;
>>> -                     break;
>>> -             }
>>> -     }
>>> +     list_del(&ni->nsui_list);
>>> +     /*
>>> +      * vfsmount can be shared by multiple exports,
>>> +      * decrement refcnt. If the count drops to 1 it
>>> +      * will be unmounted when nsui_expire expires.
>>> +      */
>>> +     refcount_dec(&ni->nsui_refcnt);
>>> +     ni->nsui_expire =3D jiffies + timeout;
>>> +     list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>>>      spin_unlock(&nn->nfsd_ssc_lock);
>>> -     if (!found) {
>>> -             mntput(ss_mnt);
>>> -             return;
>>> -     }
>>> }
>>>=20
>>> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>>>=20
>>> static __be32
>>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>>> -                   struct nfsd4_compound_state *cstate,
>>> -                   struct nfsd4_copy *copy,
>>> -                   struct vfsmount **mount)
>>> +                     struct nfsd4_compound_state *cstate,
>>> +                     struct nfsd4_copy *copy)
>>> {
>>> -     *mount =3D NULL;
>>>      return nfserr_inval;
>>> }
>>>=20
>>> static void
>>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file =
*filp,
>>>                      struct nfsd_file *dst)
>>> {
>>> }
>>> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *sr=
c, struct nfsd4_copy *dst)
>>>      memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
>>>      memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
>>>      memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
>>> -     dst->ss_mnt =3D src->ss_mnt;
>>> +     dst->ss_nsui =3D src->ss_nsui;
>>> }
>>>=20
>>> static void cleanup_async_copy(struct nfsd4_copy *copy)
>>> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
>>>      if (nfsd4_ssc_is_inter(copy)) {
>>>              struct file *filp;
>>>=20
>>> -             filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>> -                                   &copy->stateid);
>>> +             filp =3D nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
>>> +                             &copy->c_fh, &copy->stateid);
>>>              if (IS_ERR(filp)) {
>>>                      switch (PTR_ERR(filp)) {
>>>                      case -EBADF:
>>> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
>>>              }
>>>              nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file=
,
>>>                                     false);
>>> -             nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst)=
;
>>> +             nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst=
);
>>>      } else {
>>>              nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
>>>                                     copy->nf_dst->nf_file, false);
>>> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>>>                      status =3D nfserr_notsupp;
>>>                      goto out;
>>>              }
>>> -             status =3D nfsd4_setup_inter_ssc(rqstp, cstate, copy,
>>> -                             &copy->ss_mnt);
>>> +             status =3D nfsd4_setup_inter_ssc(rqstp, cstate, copy);
>>>              if (status)
>>>                      return nfserr_offload_denied;
>>>      } else {
>>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>>> index 0eb00105d845..36c3340c1d54 100644
>>> --- a/fs/nfsd/xdr4.h
>>> +++ b/fs/nfsd/xdr4.h
>>> @@ -571,7 +571,7 @@ struct nfsd4_copy {
>>>      struct task_struct      *copy_task;
>>>      refcount_t              refcount;
>>>=20
>>> -     struct vfsmount         *ss_mnt;
>>> +     struct nfsd4_ssc_umount_item *ss_nsui;
>>>      struct nfs_fh           c_fh;
>>>      nfs4_stateid            stateid;
>>> };
>>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>>> index 75843c00f326..22265b1ff080 100644
>>> --- a/include/linux/nfs_ssc.h
>>> +++ b/include/linux/nfs_ssc.h
>>> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep=
)
>>>      if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>>>              (*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>>> }
>>> +#endif
>>>=20
>>> struct nfsd4_ssc_umount_item {
>>>      struct list_head nsui_list;
>>> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
>>>      struct vfsmount *nsui_vfsmount;
>>>      char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
>>> };
>>> -#endif
>>>=20
>>> /*
>>> * NFS_FS
>>> --
>>> 2.9.5
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



