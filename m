Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76795570592
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiGKOaH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 10:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKOaG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 10:30:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686E2357ED;
        Mon, 11 Jul 2022 07:30:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BDoSx9019414;
        Mon, 11 Jul 2022 14:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U6kKzvVLGij4379y08mIE54l182RNTEMX9zven6cHzk=;
 b=QDzL2Y/miFVN9x2oS15CWTT8lWmAPnPhh6x3nMVn1L2liQRUeeNzYz4rSJuTceGc3JE1
 OKUdqwBzPI0d5fBrBHrohdM8N2vi9RkMRNI9/SUSNzi5z98RfdlzQ3wHr9LGyoueXL2C
 4QGBBGYy/fvjdz8twpR/6XZZx2VwlZ/bkmPOojS3N6L2i7R0ayaO2I6aMDRBuvdgC/OH
 XVbUu0vLB81zOuxTH1z6DuRafiynuKbIHhvM+FFeyZV3nZLBIHSvSKUTn9PbF2aQWC/F
 mGHy2eklvW6UC1zDmejeEsovF5LHZjm4dD8HQFMIMiBFAQ3DBzq9h/HNpBSRtx+Ibbl4 LQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrbmk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 14:29:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BENmQ7023289;
        Mon, 11 Jul 2022 14:29:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h704280fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 14:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm8BeF7Zw2tFUnXONkwIufGjFpjInWVqn68vgk/UvizPDqNo0NSDsxyuHFlaDoC/jcTjIjziW0Vs1dcQSSTQLvX0fY3CL8l8FhE354sVjgMCi9tvn54PuoFpnEbs8+Fw4ds618WSK3F4ywJcqAT5B/z9R3wDgoTK3I1SdUsPC6/hnStZkZMOMMoe+Fb9B1rQULYSyQxzR9Wb0axW8zqQKoizwkC6y4Yy4ugXPhKA5bwOxMKjZRsQ7//h+scNUUEYGVB91NuCVko/nHwJnyRWM3sKSSKjxKlWbLYACiDFBDQ7X5Z9WysaHF3lprnFog8SyB205Hk1tQSsdnzVKKJZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6kKzvVLGij4379y08mIE54l182RNTEMX9zven6cHzk=;
 b=UKZ54LTWzCSkRI6REGKfwdUxjWU46mzUop5eqThGUPQGPSc/PanYOV72tN8i0SP2HSATvQNvoyZdj/tWWpyKGSa+A44PmWdfvatPFgZG5B6ikyTQw77cEB36W/aN9OYF09VNRJsrZXOt1nfb1Lik6kMfX0kPKPpqxJyAmEGdpWvBKYR6u8QTbhKsimoSV0Mz/GGuWNtiRmvmOoUU3fBlUx7aH+GBICKVtmuQXh6Lxeddvi0HfRhsjhn2P7r6JTpMl7yyF2cQSy8VwJ6dlgxPd6ialXUIz4zMMXvp3qMiXG5eoX6E1I+DvBaWivFXOV4LxLxzEju4fT5MNqYKhIg0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6kKzvVLGij4379y08mIE54l182RNTEMX9zven6cHzk=;
 b=jnmQn4Xgpmf6bzQG2oyCE9lSdR+SaEKBTEZPalbKV+D32yxTv53gn7iTLzsWnL0S3mTyDqvtTXZ1vBpLwKHh87rwu7yL32Lzzd7WVtycHVfOILt4n38+8yCr291ZsQjrcz5v5QXIcysSHmVhJWTfHxKktmsMUMjSvfDgzEL3tsA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5906.namprd10.prod.outlook.com (2603:10b6:a03:48b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 14:29:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 14:29:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Igor Mammedov <imammedo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Topic: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Index: AQHYlI1Yu1IMkeKgwEG1/w/Jb2AUD615C+wAgAAwWQA=
Date:   Mon, 11 Jul 2022 14:29:55 +0000
Message-ID: <26FF2E45-1463-4923-8B17-CEB4441D774A@oracle.com>
References: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
 <531053e36e291fc5d99bb766e76d52b0333ecc94.camel@kernel.org>
In-Reply-To: <531053e36e291fc5d99bb766e76d52b0333ecc94.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d497b5bd-a760-4b48-9bfc-08da6349d339
x-ms-traffictypediagnostic: SJ1PR10MB5906:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AFP5ofMdHybgUQJDmcgkceUS1hFKy1vLHKby723PLIzstUpx10/AmleyGAEa4gumfEZxCrOpV9tk7dK9lE28oTZA5mwGFpgT23Hy+r6m+lwQCgNgNaDAu1E5LqEQQyFuFY6bMML65K++JqdES7v8PeeOkGkppubOyV6CuGbu8Tr6vxXLJgz8xERusMBxgJ/uxbMQ0WC1UZ+qqDMX0FHEQ8SC5UnepzFZeG3WQ2MgkKqDtXkIbWkcE9PTRZChvvV9Q7a6kfmDxbzqq+1VF6j6xlex+8cij+UT/ulPKmmGQHe5vhtYaoxwSPEK0dUpWZnvEoTQhO/O8+pdm1ueJ/v/VkPp/709Qnyw2Z9PQLi/YI4VWJwVySh8C5Vi1e58tvHHOuHu69vuTItntPmqiJukDiAM4k6JbJFge6xNkLu5d7ouKECaQeuxxGhOEOMmSjN9Bm7C60z4PRipDwUVxsqRPg8B5JYc6CfizzXIBzkNLP8KTOHhjWefwXaqYwym9TTwZPYtUVnLVaM1px/cePOXfDmzYSAOTkWZhu/6lustMo472WcT6u+jVLAF25+gPFlgDk0UmtVuBDgK9FW49ev6ZcfxO8qf8ZP5c+RE996vfCHCuH12yGVuFiBFRXT+bNH6qA3dGMlg8vDK6s4ExmP2vU6QqPbxcOADcdOxpp9r8BzpuF0+ooqFvCoLaUThPHPX3jSMrtwx1SScvUzi1gWmEcG/SwQW04RrMJd5E5AcAkiSS1LG8S+Ne3RZGGilMMxHu8H+/ZpPah25nH6qrBWCbEJVco8tQ1ZbipvbWMawtr4NSPUgLUN979DxMiERIzpnP9zUqH83brmGoSi54kFBpmsX43LFJWb/+84wWztQc2k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(366004)(39860400002)(122000001)(36756003)(86362001)(33656002)(38070700005)(53546011)(316002)(26005)(186003)(38100700002)(6512007)(6916009)(2616005)(54906003)(478600001)(6486002)(8676002)(66556008)(66946007)(64756008)(41300700001)(66446008)(71200400001)(91956017)(4326008)(66476007)(6506007)(8936002)(2906002)(5660300002)(76116006)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BcJrRTf0Bcq0L1QvtIBv8/MwInumGN9I92cShD37C5ZLw3tbU9zUMcVmnv94?=
 =?us-ascii?Q?O4O9MGjSHCbbRgsLPzBz6eGAG1gASsgwtyoQw0JjWIewQMC8nXbuX2Q/M9SB?=
 =?us-ascii?Q?BXhVHeimzAn/wCrSkeEnPnPTf1LShTNorf2EY5x+i6zHyWjIepFQYInNqmX5?=
 =?us-ascii?Q?cOOZUASwwmAZpD/eRe3+KqC6TbWcKkoOdMsj8XP+l3zmn08ok3EoddXRI8xN?=
 =?us-ascii?Q?+NVeUBaiXtKij12c0pmSlis+PNiRbM7TvVBH+HWvE+fRnXgi9ra1hDAe4era?=
 =?us-ascii?Q?5/IY0FwzBcQrFfAPRWxM9/t1BPCg0NG1elnY8Uj2O5B1RnTCV6PFxI2mFKD6?=
 =?us-ascii?Q?d/APPf1o9iTDQTZTvby3ECgy2DlxkgkzPAZC7kbalRS1rM+5Tz4C/dTIqsV/?=
 =?us-ascii?Q?Bca2GIh8sR+crUsK0iQppSkN0CdjfQsU1PaYS/0wevFSept25yfLibuNTn3U?=
 =?us-ascii?Q?ABmV5n58xbiZQcM+byVgo8X3BRs4UUEUdAIO3mYvFdMXY1ng1gJ+gW8Lk61m?=
 =?us-ascii?Q?1s74xkvAyoTfY0ysVPHbTJlKUiyB1c/I9CmmlFD6DLHh6mIFf0sJYOvuHEbB?=
 =?us-ascii?Q?h75O1JOXAW1hZJuFkeMQfmiFnlZxbnhvyMCRreqfiTHnb8DIVJuX2IvwxdYD?=
 =?us-ascii?Q?Qo3aPR0ViK9ZtFe0Yk4FWgUtaCfxPhmy3ApWh3r0brMvcYSjz1cbMFEVjT4A?=
 =?us-ascii?Q?lrV3FBLVSNutvcFdODKgVFkpsi0uS4EPNVABv9eJgLSVM+Kypr8bIFLpBWTx?=
 =?us-ascii?Q?f4i35hm5o1io9+KUO7L1y8SH9dvvPMxCynN4OqP3TZlmlV8bkRIKkGcSHVnB?=
 =?us-ascii?Q?DOVvFh6xFP1ig91zBO0VdQLo5RQo4MaWTiqiRHXsCVHDVMxI35pDsDi0LSdc?=
 =?us-ascii?Q?yeTxCP5ibHI8ysL/uhtA5Zb0w7dUvs6lhh1M7EpUKGpONXB15tyf3VIoI9KO?=
 =?us-ascii?Q?WcbSQQWqJaRJyCd2KZeKmKw46mR48PNcQTXPJsV7eFqKDoQvM0RcJt6pU7tz?=
 =?us-ascii?Q?2yRG5D7YzFBUn5SBvCJ2+IWMDAFhN6DUIAgQlBSukL20zJSFB15ePw2dTp4S?=
 =?us-ascii?Q?C8AoWYv68VRs6hj+CyaObllAMzLpbafWxQVFWUBya0RC9vS0Um7mZtEl2ilT?=
 =?us-ascii?Q?0QpZkY8bZBGMrz52bg09qI3dTvmHw1YDRzgwVuWgm9vIClZDBxZwJYoUfMkp?=
 =?us-ascii?Q?XE8Rb+sEFEQkWCo6e+T2lFl+E/3TrFYcpxwV1ZYmO1g+JHdieDZaq42ViYUo?=
 =?us-ascii?Q?8Ts/+b8TINtkOMCOfykveVWSkdj9vLHJG6wvH812ppqEn+X7ZsA+XIONFmAl?=
 =?us-ascii?Q?QTNO7ghJKYMWOyVjnLBYKhBcFE9bpnFrKAyb55YGai4XTO+NHB3i3pZAmz4n?=
 =?us-ascii?Q?MAgt5xrsRzDIkwA5iLG8aJhv0PAo+5BBmmjODKFMUopSkA2ssyT7vZvdyHvM?=
 =?us-ascii?Q?Q2dH3/wj3hNNgR1f6mDsJzbUbIKEZtvIunFPekp0XVlvqRwRFWmKsDPoDSGU?=
 =?us-ascii?Q?zUPwQf+crKIScUb6XDNAenTuZhQhefdfGVYbduakmatV4InSuZFTYXKQxxSb?=
 =?us-ascii?Q?gZ1iPA/4CO6jbrkjvaX738fKrOXYXHgvsLzRl77p3LXQcBZDZSDm1dqrVeJH?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <532888D07BAF02419FA607D94B427B1E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d497b5bd-a760-4b48-9bfc-08da6349d339
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 14:29:55.3720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SEmHl0Toaj54tREiK9Zj385Z055gkhT2hySkIpczUUNCGRb9Wo9o/VxSB64ha7R0PjVTzgWoT5VMkcOgeWGQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5906
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_19:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110061
X-Proofpoint-GUID: GotJnrQsL6iMREuCLDujcFJZ3m-wjU15
X-Proofpoint-ORIG-GUID: GotJnrQsL6iMREuCLDujcFJZ3m-wjU15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 7:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2022-07-10 at 14:46 -0400, Chuck Lever wrote:
>> NFSD has advertised support for the NFSv4 time_create attribute
>> since commit e377a3e698fb ("nfsd: Add support for the birth time
>> attribute").
>>=20
>> Igor Mammedov reports that Mac OS clients attempt to set the NFSv4
>> birth time attribute via OPEN(CREATE) and SETATTR if the server
>> indicates that it supports it, but since the above commit was
>> merged, those attempts now fail.
>>=20
>> Table 5 in RFC 8881 lists the time_create attribute as one that can
>> be both set and retrieved, but the above commit did not add server
>> support for clients to provide a time_create attribute. IMO that's
>> a bug in our implementation of the NFSv4 protocol, which this commit
>> addresses.
>>=20
>> Whether NFSD silently ignores the new birth time or actually sets it
>> is another matter. I haven't found another filesystem service in the
>> Linux kernel that enables users or clients to modify a file's birth
>> time attribute.
>>=20
>> This commit reflects my (perhaps incorrect) understanding of whether
>> Linux users can set a file's birth time. NFSD will now recognize a
>> time_create attribute but it ignores its value. It clears the
>> time_create bit in the returned attribute bitmask to indicate that
>> the value was not used.
>>=20
>> Reported-by: Igor Mammedov <imammedo@redhat.com>
>> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4xdr.c |    9 +++++++++
>> fs/nfsd/nfsd.h    |    3 ++-
>> 2 files changed, 11 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 61b2aae81abb..2acea7792bb2 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -470,6 +470,15 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp=
, u32 *bmval, u32 bmlen,
>> 			return nfserr_bad_xdr;
>> 		}
>> 	}
>> +	if (bmval[1] & FATTR4_WORD1_TIME_CREATE) {
>> +		struct timespec64 ts;
>> +
>> +		/* No Linux filesystem supports setting this attribute. */
>> +		bmval[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
>> +		status =3D nfsd4_decode_nfstime4(argp, &ts);
>> +		if (status)
>> +			return status;
>> +	}
>> 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
>> 		u32 set_it;
>>=20
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 847b482155ae..9a8b09afc173 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -465,7 +465,8 @@ static inline bool nfsd_attrs_supported(u32 minorver=
sion, const u32 *bmval)
>> 	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
>> #define NFSD_WRITEABLE_ATTRS_WORD1 \
>> 	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
>> -	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET)
>> +	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
>> +	| FATTR4_WORD1_TIME_MODIFY_SET)
>> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>> #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>> 	FATTR4_WORD2_SECURITY_LABEL
>>=20
>>=20
>=20
> RFC5661 lists time_create as being writeable, so silently ignoring it
> seems wrong.

Open for debate. The protocol does allow a SETATTR. But the
specification doesn't have much else to say about the semantics
of time_create; contrast that with mtime or ctime.


> It seems like we ought to have nfsd attempt to set the
> btime and then just return an error if it doesn't work...

The usual way the NFSv4 protocol handles this is that the
attribute's bit in the returned bitmask is cleared, so that
the rest of the COMPOUND is able to succeed. There's no
NFS4ERR status code in this case.


> but, I don't
> see a mechanism in the kernel for setting it. ATTR_BTIME doesn't exist,
> for instance.

That's what I observed: there doesn't seem to be a mechanism in
Linux for setting it. Perhaps I should have copied fsdevel.


> Still, since we can't set it, returning an error there seems more
> correct. NFS4ERR_INVAL is probably the wrong one -- maybe
> NFS4ERR_NOTSUPP ? It's a bit weird since we do support querying it, but
> not setting it. Maybe we need to propose a new NFS4ERR_ATTR_RO ?

As I said above, the protocol's way of dealing with it is to
clear the attribute's bit in the returned attribute bitmask.
"You asked me to set this attribute, but I didn't". Clients,
IMO, will be more prepared to deal with that than having
all of their OPENs fail with NFS4ERR_NOTSUPP.

IMO explicitly setting a file's birth time doesn't seem quite
kosher, and it's not a POSIX attribute anyway, so we don't
have a standard to cleave to here (at least one that I'm aware
of). I'm fine with the patch as it stands, but I'm open to
hear more opinions about this.


--
Chuck Lever



