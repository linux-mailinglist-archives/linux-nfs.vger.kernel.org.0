Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13BB6933AB
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Feb 2023 21:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBKUcG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Feb 2023 15:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUcF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Feb 2023 15:32:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90F1164A
        for <linux-nfs@vger.kernel.org>; Sat, 11 Feb 2023 12:32:03 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B7P1qh031794;
        Sat, 11 Feb 2023 20:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=spBy89SE9IW53wmiJaGLImKzcGRKIBCWmP25ux/4EkU=;
 b=cuy4RJe2QkKJpO6hTOYmSxQHXVlVlMcbFyJXrzidROW8yucmyo3N1/KZJmOiiL9mi2yg
 KLF/gqNLiUqejmZxmNKyoUgU8SDhLjATc+xjAtmNmvAK2iTSHfpw7Bj6v42U1jb0Bq3g
 kkY1YjC9c4P0xsN5j7EAUSWA+cFCoSdMw+3RmiyGqMUbCjOR9yegZoHsLJ1TjjPAxCGh
 QUE9asGwjj/KDtm3gpGe6SNjLNFdMfks0kNb83mMHot12DmV++JjJxlFTgaaj4A4mCVw
 3VT/3rP1o/xwcAh/y0aYQPEQ2si9iL41WkiKWt9hsB4ldMNUH9MSZ4tQYIu57q7/k06W 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jtrmnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 20:31:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31BH1qev028869;
        Sat, 11 Feb 2023 20:31:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f2npm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 20:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EImrPFsDUKS8orRk3dfMpz8ExjyRbjtlv221asv2KzW7uyxabfw3l8WBpdVKRTgUH4YEcztaRSCbbYoH1mZ+Yw+pYrHNC5+QBPWgNDVeaMVeSoH2c4i/T3HGa691DihqWw6G9ObzC+d+JMKXD7Zud3gi7EPhQ+eb8O2C7a9zC81En3j9oEMVB4ood7vHPXYz8rsO+qiIzKh4BazV80sF+m64IQ71sLtRGGuIUavbZHZ6ALGuLkCGHn6yUp4VDoQe8y42zrmV/7teO8k1EAhE+o4eog89yDohRf7QEvxP1tzsihqOWTOWWvhqmO/9MwE5yZZIVA4NzNmsfocXOS4azQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spBy89SE9IW53wmiJaGLImKzcGRKIBCWmP25ux/4EkU=;
 b=WFPqpUaP+t+yQbsN7K6ZQR3APuWFoGJ98Funyd38/y8yCzGcjmCquvsG8JExjC17PS8Zipb4vo9PFofnJOqVdM7evnio/EUd2Z+1+4T0qs9Ejz08+6zxDTIJ2yMU4YJk0uH7h0trNFfvga9xJJARpPPafJFQf206DfUSnBNv8ccMk7oXD93k+JD7OB/tr8UHrcrUnJzkeNBrHWzeoNIJgbuJ+gTOs3E+/0IBfV3gc36dniFxlc+LZL4VIQC4k+mDpYpefGA6VRhhaqgrBf5lipbh0ALBJcDBqBBi8KwYmixogWdC4L0tHQCmUuFoFlg9wvBih6c7hlO60NWmWqmGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spBy89SE9IW53wmiJaGLImKzcGRKIBCWmP25ux/4EkU=;
 b=C/6LP+LC5e5pzKtwyczRC0yBkPJRVN4nX8cQZxUTREYWB2HGynajX6NC/X5jIRm9Bhzfyruko5a9H2iziEF2+E5vwxXSUYLciH//i6pHjqJuuoBZxG94RwPopllxZj3GWg4gcsZ14ix72Jg8PT/RF07Fr6J/0VsnokB3+L57OUI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.8; Sat, 11 Feb
 2023 20:31:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6111.008; Sat, 11 Feb 2023
 20:31:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        JianHong Yin <jiyin@redhat.com>
Subject: Re: [PATCH] nfsd: don't destroy global nfs4_file table in per-net
 shutdown
Thread-Topic: [PATCH] nfsd: don't destroy global nfs4_file table in per-net
 shutdown
Thread-Index: AQHZPhdll4oDbTD8z0CNLVRbctrrVK7KM4kA
Date:   Sat, 11 Feb 2023 20:31:47 +0000
Message-ID: <03EDD716-A995-49A4-B9AF-E1AA13AAD16E@oracle.com>
References: <20230211125008.21145-1-jlayton@kernel.org>
In-Reply-To: <20230211125008.21145-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7120:EE_
x-ms-office365-filtering-correlation-id: 2abb6d62-36a0-45aa-6a70-08db0c6eff6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4i+G2UBsVUo4YmqRrLaEHVxyVmObsPNab2fhZ01TQ+VS/3/4a9XzzrL92Y+BMQd2ToHM4z73mKK/EPGmKUlQYJHW5q77KY8NJRVc//dT5bAn3lsmAg1etrMzDvlH/qawRMtMVjpfnuRWGocjClFfYWg2Fv05+fKxf+0CyTmSBB6A1PoN3SpfJ7NvhdIwqGPr6O+PFnxub7IllKtY+dXYpKTqXVOx4Qphz43JDi/p01V2RwhHQrLf2JHGPgPxxH+BJmJKVlOYIUil1nKcdnCsC2cm9hZHbzrAtPmroBZkNKB4ZFjxh8M6hF+gvMnNd7AGJnhQg7IlbQVk8a8Zz8KL3w7uLEqQ+OaSLx3NNXAdElyKoWjf3nUdkr9+D9bLbQ8tgYGgU7IwzcQSQSNcm0bVKxQII2Xj7YocU2abBonFFy6Hi1t4ylq1Zfdu8uL9ZiXx7QrIcAFDAtxfysH7jfJcI6rCnUAjKs+WKiBeGfa5skCMoC6wKFb8A400pJUALSj4niAOMM+ObCwBVvD5tvrG0p7CziBk5BaoA8Cl32OX02OTg7zYY6iYwaCbxgzbdIEOISz/ra/BVYkiZ6BRAnJRDp2nU0OqMtBLrObQtXcNoBAn2aD9mm4mdN0mGeaJKsGXDbFxmblEWA9Wb7OnDNr8edK/QRh/yN793UT4dsLmJmjco7ezI8BfdnCuhlWVWVDAf5bhvf+RSyDZCsB2h+Ph4QRossJbRV+emBg6gLipK6+Y1eouzQhMDn71Ae0j77j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199018)(38070700005)(186003)(26005)(33656002)(53546011)(6506007)(6512007)(86362001)(478600001)(5660300002)(6486002)(966005)(2616005)(2906002)(122000001)(38100700002)(36756003)(71200400001)(8936002)(66446008)(66946007)(66476007)(66556008)(64756008)(83380400001)(91956017)(4326008)(6916009)(76116006)(8676002)(316002)(54906003)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKoq+KIR1kW6aeBLw9qPIClWwfZbRDDHGWTm2xrFRFxa3ECbF1NOSJ9h7gQv?=
 =?us-ascii?Q?E2oyvc4Lh19sMxrKlTHuGd32RscCoOpgOqVJmr9jWoYh+/LMq62TqRVgaM2K?=
 =?us-ascii?Q?2zNrOaPNMXqqeV7gS4c08tsbKIxLLoN7ElaYpm9G6VCLqOd6lUSJaC01SH+S?=
 =?us-ascii?Q?PGp6JiArIhjhoNn/jfJ+I9IhJSvNVjBmR4Ynn2EyFSX/NyzW+B5enLMaFWTq?=
 =?us-ascii?Q?DoyWykgzjBJ+Px9pFTFpCnzj/7assyGgeufXi/X8WPBU1eLjGqUxHKsvJsPQ?=
 =?us-ascii?Q?sbvkFYsc2c7OUAiXx44CzUjljNfZLUHI4TfRD/J7KdBNQG4YGI7G6lmdTKg4?=
 =?us-ascii?Q?1rnaF0vYNa8l/Yudv8NIR77UXKJ440zO8qDUZbA+G8/6P4vbrxeUD4Ex/qg/?=
 =?us-ascii?Q?oix6LuLQFj+cbELQAviHjyKkJv61t53viv/3mdQn0TRFOo51jx2D2c9f2mGA?=
 =?us-ascii?Q?hnCqIsVXA4h4veiBERS3/xwdcWJfdlgzAPcaXhhxqE7G1iFzI1c69QKyNvTZ?=
 =?us-ascii?Q?qQd82kVtxwUbwnZfuG39k77YwOkbzgJ/EAS1uJsCr0sHaQPTbN2K7mD6Z/jv?=
 =?us-ascii?Q?W4uz9FMRJWpSNEIAR2Zgfs7pUgn4agq5pLNEZ6bstYwGHHA5RMkUIa8gQg1k?=
 =?us-ascii?Q?DJCVXun/jtgZslczgA1+Fbm7If5pM9YpkonVHLWcz+iboyrSFpzB92rSKuNL?=
 =?us-ascii?Q?adCs2ygPYALNId1BjybuVoNVgAosHP7I0Kc8CvwBo9u2nNST+oPlX0XEbwn/?=
 =?us-ascii?Q?DsURnC2EqSZxim+XRSaJlvglBmFrpsXQnlvdyet1raS2/JfQQ4c+K29K20ha?=
 =?us-ascii?Q?wWZ6lppUzW+iouyXLu/eYDCRvgZsw25i0UDb35EbmYA9D5P3IXQPFZwZaBJI?=
 =?us-ascii?Q?gnFBF5z94lUhFX+Lzocu3j+MOARSBBJ6viPZrXG3ftbyh/So9qzcWk5Hc7N6?=
 =?us-ascii?Q?6yWDWN2TqMsxjVr3ybPLWxJzhwRxjNv5pZyHVa7gvBb9hys4ocodKxLcwhdP?=
 =?us-ascii?Q?bQZeg/PGln0eDbcBlzjyA7gpVrxS4enTMs0Tj2wit4aijMwxeW9vpQQpC1i5?=
 =?us-ascii?Q?/sK2qoUpmw06QEuAoor1vLgByrWrQPPP1bEUUFhqRIk8aXzEaXPCQpSHZtC+?=
 =?us-ascii?Q?wDxDYe4Dkwdd8jnpW7c0mw02d9g0Sc3nSADJig+zELU1IZ+LYNjgani/rqOF?=
 =?us-ascii?Q?D3UTLZewubD5VnxR01dkR2YKWxLPzr/zKSSL1O5bjsx/+zx72pFcRW6WjuW4?=
 =?us-ascii?Q?O356dp+NiJIREZnvTR2JtzjZqmTkv0lUjBNkuTZIcZI9Uz1qrz/tka/sjhTm?=
 =?us-ascii?Q?OczPylkkg5ngHKwTDzy7b4dTKAlRBnAuyVlw5+SFw5BGlSoQaPq/kr1yYycT?=
 =?us-ascii?Q?cbAUwaPnUuDv4y213bB3KWWdK91Ebq/WOBPmLLeU9LX88sUSL8aaasc9iMcY?=
 =?us-ascii?Q?xXxL1K1bCX/CU8SCvBcPpg5isIOn6dju0nQ1gNCvcxTAhSx5krtEOoHKSHfv?=
 =?us-ascii?Q?7Ny9odvtHs1msNPvBhD1txybYsi9+uJ1jzpTYj9JFAObbXfWYU67Yf4pjzmx?=
 =?us-ascii?Q?6R9J4LcOSbineJvcxKuQ16G7qaQ1gSbialuWQYnbWF3J5Ag1SyqOtmVjVd7s?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3948AD282F888E40A3E6186F5E802864@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wMQoHrEJBPxvXKkl7/84QmIWxdrS+5PIXhBtj0JrpRVgD71chjWH2br+npcqdi7XHfm7msuNk5nsJNf1pdBDefoF9cmImnBERbll8bd21Q8Hdiw2r/0K+HH3pexJWhYH2fliYK7x6kI25p2v8ksY7u6UlSCShkf8TmI3bkztig20bqTsD28YslxdVlbUJw+SAS6LPa5n1GIC2lyqpGCHDr+qH1d2aTKFtE7k1wz8/wHex9dcIpCdwmGFdMbhyJCGotKcI2s/dFwucyf8RxZ26iPmjtRKZyNuGK0wiPIy7vRU5XmO6BCZekAQl/KUR6sDnpTf0Oy5QBQLMrYi1do5e/TaVUYqrp9YqRwRrgsMpfX7pfNN42HukAtt9j2xCtmSh8GzWDT8LuRxrOPwAK7a4aiSzVyHFRAKx1ZNUIS0xdLkaBQeDBAH/XVMeqmgTNGrPZqVI6rdV/BhgJwUtLsK86rgLo79iUPcM8CZ694YyEUuzvSNzKtcz0AEUVbowZpTa9BPxNJ/7Mvmu0pOqfcjN+1Gz3i43RBVyrk9prbMKHhRvG96SNftjI8wcGZGEJLXhwwynUu4OiGEE5U1/SeYelhRNTz9pCZkXiTUL+viKbxzr+D+t3t2S3mHaVE8d6AmsmIMYDigpbpEpSacUBtzTLQOAelEIXXMJYJWr7PxXvxXV1eh/vNV3QPUaPm8OZjJsKq/CXyFB5g4bBwm3kijFcHXQIYFV8GKa3AS0klVXb7TEC81TsBxiK6RmbUV3aKTDSB2sz+4p5icQAPI8iLXufLh/QM45RVzfmLceu04tV6fMAhhlNxzsi9foeVCZNkk
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abb6d62-36a0-45aa-6a70-08db0c6eff6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 20:31:47.3962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYVSoORp/SW4X6B3EZU5jKZNgGfRgAyRiyHf3NVGswaaJLUl1Xh9MWEKW5PVVZ8BLv+8OORyaimKyc+NiNG1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302110191
X-Proofpoint-ORIG-GUID: UKDMYpWMG18Jk2tnd6M11eQFzneVriGn
X-Proofpoint-GUID: UKDMYpWMG18Jk2tnd6M11eQFzneVriGn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 11, 2023, at 7:50 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The nfs4_file table is global, so shutting it down when a containerized
> nfsd is shut down is wrong and can lead to double-frees. Tear down the
> nfs4_file_rhltable in nfs4_state_shutdown instead of
> nfs4_state_shutdown_net.

D'oh!


> Fixes: d47b295e8d76 (NFSD: Use rhashtable for managing nfs4_file objects)
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2169017
> Reported-by: JianHong Yin <jiyin@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks to you and JianHong. Applied to nfsd-fixes.


> ---
> fs/nfsd/nfs4state.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index af22dfdc6fcc..a202be19f26f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8218,7 +8218,6 @@ nfs4_state_shutdown_net(struct net *net)
>=20
> 	nfsd4_client_tracking_exit(net);
> 	nfs4_state_destroy_net(net);
> -	rhltable_destroy(&nfs4_file_rhltable);
> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> 	nfsd4_ssc_shutdown_umount(nn);
> #endif
> @@ -8228,6 +8227,7 @@ void
> nfs4_state_shutdown(void)
> {
> 	nfsd4_destroy_callback_queue();
> +	rhltable_destroy(&nfs4_file_rhltable);
> }
>=20
> static void
> --=20
> 2.39.1
>=20

--
Chuck Lever



