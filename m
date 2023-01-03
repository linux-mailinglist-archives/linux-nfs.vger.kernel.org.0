Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2148465C390
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jan 2023 17:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjACQIs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 11:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjACQIr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 11:08:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC91133
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 08:08:44 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303G3Yr2005345;
        Tue, 3 Jan 2023 16:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wxeFu6p6Autp826Ye8dlqzgKZpKdTaREmkW4xzMRAQY=;
 b=p7y1uZhhUZ2yuKjiDU4ATVentxMZLVtugu+gFfCcUQs788Wz+Ktnbg3kWlSodUo/W6sK
 rZU0/XQAD+dpaDUpMgM22oKUwAb1Kml4bLRRosYtDe/5y77bi5OH51rIpglXb9W0hpBF
 EI3xarjAXPKwUbeAyuUU5dWZKkkpkH/WRjnEBVnfOOTa/fIGJ219E0uJW3MBjn8nLVAG
 l85fagvcx/rqySZ1yRDU5HH/NMW/tNY7lf9i/ddxeCNh8H++Y8UffwPYPAVu9UthLzFR
 tg2NTHEcJRnH0yZJDE658qO2w4eXfrqiimQ0dWw6BK8TPtIqEPEeEfSegfEbp0YFd+li Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c4dd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 16:08:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303ExY9j008910;
        Tue, 3 Jan 2023 16:08:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbhbhk57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 16:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3xDX0HmPNEqAN0xTvedi9uQuohImvCX4X5wHiKRwIzKi5RckNRVS7U7XZ2dDVjOFxnYMWJulji7uV/7pI1h221+1zNb6AZfcuBYO0MKs4lGf+LRs/P/yrDbBkxSAQjcf6zQotpE6VlddghPU2MtsjIIUbcl3yvlwT6hXjZbZ7dGcputJPLZLL5gF+KP6lzsfNtgSDiIaVGSFtoDKQCoq1SNSNUsn5JV9h4qZc8hMpC0DhWKhc+KrlC5ZGRmzavEoV0oJw23C8CIEN8sQfz7okA/+dWn1B/EBseY7DFzMe46IKjzi9DBB9sRBMvat0ctLfYLouATV9L3FlUrc5k5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxeFu6p6Autp826Ye8dlqzgKZpKdTaREmkW4xzMRAQY=;
 b=Tt8vaK69P/rqnifZADQzGCv0RJCWIaZ08fhtiOqWHYZ47IfJYNzlJbHrOFKMPJhXy6aoVJXMafgWNBMIs1v4CuVdRiy+skPzmbzO047WiGpG6tj+qZ4DR0gGpRFF/PAjn2We7ZbVfNvSAppmwAEM+Cv0X531pYeJ9nMCbKVQEYgKnjDHTk6tO1f/a2dGag+FVOXjX68ERm8GxsZDuLCvXXCGWxuKWjIn7N0Vwk5U9WOpV3A/Hy9CPEzrli9TL2brez9AwMTo6VlI55mvKez63vCHomztSiN39lyeu9JGbWCtRDbdL6a80G+HtT3v237mUnPYZkAhQlf3mvr/9E9CDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxeFu6p6Autp826Ye8dlqzgKZpKdTaREmkW4xzMRAQY=;
 b=CdN9o590aUnsX92yvYgyJBgN0leoq2XsWCHQ4+o2awgVLCz/b5PRMwszCcm9Avreqo3KegC8L5C7ETG091+Ux5U4Bqh8rRtq7K0NzfH/iSpTHFevmOZ77bDCXtnHhPgUDzusp3rKnKMTFqc8ihwYXaAXYuHQPlkwTLctou97dyw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:08:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:08:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Thread-Topic: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Thread-Index: AQHZE0St34jtf1Ze5Ey5ptczv+ym966M9LkA
Date:   Tue, 3 Jan 2023 16:08:34 +0000
Message-ID: <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com>
References: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4780:EE_
x-ms-office365-filtering-correlation-id: e80e3972-d737-4682-c57e-08daeda4c424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0qZxA5ClXscWif0AqJdnyxcPtKtpVE4wcxbpiG7EHtrM1/jxxR8w3bMicZsLAefj+r0AUuDICoCwtf2uFWG4v0HbdCsOy2nGrXalk7kuQFICdqr/DsBPw7cC7CsY5B2xXJZTjpWKoGi/1lr6J2yiPfLY4ERTfr5iKWEi9DeduQpEgURZt/3+/8EhKLeZ5aqmof0KtCWPxLPToFdLaIdnW+NlI4yE3jHolOITxSmkO9tX7Omb4IMd/FnXeqKMalym0amC11fPszl63tUk/DXMZdvKizcNa+zfEzofls17Xl00Kq0p29DdYf1FGtgdLZaKBcTClfosDAZlF4fkJnU4yTM4J55XlY++FEnEoJAaJ5PeL3OPwgwHW7x4czTkex+d+6Eb4I0evZYNLI+uJgOIgOyfeMTbwdLhM8rhqA1BCgEnyAkssE+fuJGObEipl/72M2BczzgNkXmIBp/w3CHeijlYYE60CwBl3jxEIjuvEeNUpHoacIx0AQAV9tqqTuqZxwB0F/6uKkl4AItDMvH80uBziiyseez3oumcyyiYXfI1M0Jr+f7MnTjPO+ykH7R+hAA7ktsx6XSD7NhScyqwhEmZtilZOIPEo0LYnOgTmfPZtqQTVpHiHXvLaZffhtQbwj26kWqGBLEQissf0DNuLKAZF1ArnWXSNBamGpkBlWWGY3GLV/5AV2Qmnp2L5G4aZ4qTsZKHD34wZQ2qpZHp+H3DWGhGeBhjB8ljQ7aZsunjIXwFYWSIfAEmrpnTg2T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199015)(83380400001)(5660300002)(38100700002)(86362001)(6862004)(8936002)(122000001)(38070700005)(41300700001)(2906002)(30864003)(6506007)(4326008)(6512007)(478600001)(53546011)(316002)(186003)(64756008)(66446008)(2616005)(8676002)(37006003)(26005)(91956017)(6486002)(66476007)(71200400001)(66556008)(54906003)(76116006)(6636002)(66946007)(36756003)(33656002)(22166006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DWtbx9jLQb3ELyv104VK2G28V00ma7XB+52QvmAO+JMGnI5hIF493f6WYx4X?=
 =?us-ascii?Q?AzYRWirX2hcl9msTtweYuRgjhpAfflo+W/O7jvh+1g1l+hlG3gZqF6mEkVMC?=
 =?us-ascii?Q?tbjjrtGRXkJDrvJ04+ljX/3AD9hQZebAq3PuCZqGGlw9OJgHOUTduZQfgrCv?=
 =?us-ascii?Q?gbpvO10/pm2elZ93klLlUPZlrXv8TutG7wVc/POO+sP8IWTkoka0PE69y9er?=
 =?us-ascii?Q?rVpB9tJn8QkPzpLHP79KF16Sy1kr5/pLJdUKlc0FaXpw/amKP7y7yRSDpdnI?=
 =?us-ascii?Q?7ly8cBBf6Wpvgmbm4Tucu+xCDuPV0G8Ztq6MthnlPQZ51fXAQ3LwDj/YKCNm?=
 =?us-ascii?Q?SUit7d8eXVzB72MuZCMo12rxSwdURJaXmLAxH8w/HEyB4ZSlKSy+O7Z+7yPK?=
 =?us-ascii?Q?DFXidqIEdcMGha+R+y2JC0fBUrisdthC57lD++3nJj8Rrp5Rf6sCus//PTdb?=
 =?us-ascii?Q?gddKsBofj1oyvNl7WLjK49iM0HifcFmiYRyjtZIQuxCtk61+NHHrF33rtxAw?=
 =?us-ascii?Q?H250TIm5VMlu4/4Zxrz8NTbE1fkvUM9BpUF8hCphlgsrji4dZPFp5jC4FgbT?=
 =?us-ascii?Q?BNrd2x4telMIaWhNC00IFrunhGSW6sHfGZl7in3xBEPrZjE+BEF+MBcYvjlP?=
 =?us-ascii?Q?uaPijArA+C9OKh646P2aJTzkf2mn27IdIWJ7DKouGMrNB9dYc+RPP6Gn5cfi?=
 =?us-ascii?Q?0dgdvddM/96wfPZv4XUx2ihYhvt2j9GMEaGbHsCcHW16Ts5CpxxFYXZIDmgB?=
 =?us-ascii?Q?PUsbApt9QAWXH4UYlJCdT017Zlv+odBL2NZscsKmDJ28eoMQyPII/XScM2wy?=
 =?us-ascii?Q?lTHddPO7yxzWl5Z7DhuybbZF0nYBNcE3tMau0zJ1cO3wvys8EuiPHFN8mCVu?=
 =?us-ascii?Q?qJOVrYnrue+aQQV6Aq+ZhzJqhagxQwVn8+8rDx/7/i1V+gLfZTnSNNbpbPuD?=
 =?us-ascii?Q?gfveJAyh0/njc4+SIf8BlTwrYaAKTQGAf40LD51lvzpIwuEJv/quDRkH+4iF?=
 =?us-ascii?Q?uMVro5jRbq8kHMfkB92u94+tevMLkQ7LpV2m0JDvpxoFNCJzbkTF6hMoWNXa?=
 =?us-ascii?Q?wyxfYGBiPKGC8LsYOd5/D1bZD9DDwwqofO/9ZXmCosKhc0JGjCbQUSeW0BbO?=
 =?us-ascii?Q?BBQpOGufjFO0IkE4Isyw1bCLUFItKtQHFnCJqvLbPgDWFkgFCp4QdWVLZqRx?=
 =?us-ascii?Q?QAymUKnPxT4wPF8sZ9d506Qr3TVZxyZv69Q1U3eaitK4gmVYaGwxgc4ozir9?=
 =?us-ascii?Q?eVHOYMOCrtxLBc6XhM6dHFq7/bZGPWvFTh86+pt4fGVl7EKUYvmTpH9r361K?=
 =?us-ascii?Q?Rzgu/t5cX/VORff67ijbnJ0szBx994GTRFethcleVQ+/lcObLwtMKqsybL1x?=
 =?us-ascii?Q?vGXZA+HosBz00dbmXLvP+1kPJxhEO+Dt8uDXghWtinS7pLLje+dnR9REUx8/?=
 =?us-ascii?Q?JjW9ReyyS1+3poStqbOTs8UJBfUAd5ouMbOJ5pA6lAsUGvEza8QOY8uC/BxG?=
 =?us-ascii?Q?0kBkJZwYA8XEjsECxhOnyrm9jA0NacX90nwcZ8Ph6qLtSI1NjJRaJU61u93U?=
 =?us-ascii?Q?QISKSNBmcPVGihJHdpd21r7+xHf0s3jUMH4xXmjy3+RdULjOGV3ZvRTYOllu?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C98B7F936EA8984C97090FB7D598A0F6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 54S5FEWH+oD6ERo1BlgaQOkp+nM0Ye01mR2eXpAjRReCtEVCE9Z7J8SeWAqQLKNdp7iX656PxXlcDnUt/e2joqCTdAehRCYT3iic5eqKP6pBbQ9YOvtQniPvaPT0l4P/RlF+JYy9QoP1R/OT0CR2sOb+BtrL8Svb9kp8C0mrtsvESN4yFXMBHRqHXZoSNQIg+jsRFkc64OgFf9Iy404rfjrkknK7rhfTRV/6Emz5II6xRoPdjDixhW9aldIJkJrDwU0yW5PsW+nyjOl1yxtsKkh6rrK/v0MiTCewmHS1yCroNUQvyzUX17NTRxeV8CF+Eqb0KAoYoeC8BtlZ3LrH+tnjqOxMHN2vbonipg35cHo+S4WEnXa+PtS1dUFiwC9NnBawvO36DGnCvVypbIZW5VtXCEmHuR/O8zE9aSLd8yEigDS6bhUOKjqOFlgY0j0QrS1QwEIZ1FfPei/kaj42yXuQTqto8Z+vDIG/70hFC3RsA2jj6/iTyWtDV+1QEoBWJpY6hP3d8+1FLAtaUEL00RW/A5768KK0B/sRnHZbk1ZnKfvsiKrWStDbPn8pZU8Y/7Fa28fTMJKqHsvkcOgQxZEf74oFBjLlUoy0FNdir11nW22S6VfSTrRjMioyfchVpFguuA6LQ3dq+TB6HjHWUxXJLPPtpk9pVUOzkwhj8BNkHd6CkREeLcGnfpDJAINUS4CpL4ruMIsQx6ntuToZR8wpVh+sWEXMEeyuDhwFWVoANZrechEDVSND3zPbsGJfYHo4utq4jhw0PsJxdYHJlLpXd3GK3A7hm9hUws7R8+AUVWTqn8KKK9qmgQ+6CyWZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80e3972-d737-4682-c57e-08daeda4c424
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 16:08:34.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ie7cRIM9KvBprXaAapoVkUtrnHWEr1hMKjaSbAeza5RDY6swxQQ23ALlpoqwCkyjWXmWjLYWmrrWLrdzlhMb7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030137
X-Proofpoint-GUID: yPPC8z-b52GvTThOi0AFNPZ86x2QDUDG
X-Proofpoint-ORIG-GUID: yPPC8z-b52GvTThOi0AFNPZ86x2QDUDG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
> server's export when the mount completes. After the copy is done
> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
> server and it searches nfsd_ssc_mount_list for a matching entry
> to do the clean up.
>=20
> The problems with this approach are (1) the need to search the
> nfsd_ssc_mount_list and (2) the code has to handle the case where
> the matching entry is not found which looks ugly.
>=20
> The enhancement is instead of nfsd4_setup_inter_ssc returning the
> vfsmount, it returns the nfsd4_ssc_umount_item which has the
> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
> it's passed with the nfsd4_ssc_umount_item directly to do the
> clean up so no searching is needed and there is no need to handle
> the 'not found' case.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
>    Reported by kernel test robot.

Hello Dai - I've looked at this, nothing to comment on so far. I
plan to go over it again sometime this week.

I'd like to hear from others before applying it.


> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++-------------------------=
-----
> fs/nfsd/xdr4.h          |  2 +-
> include/linux/nfs_ssc.h |  2 +-
> 3 files changed, 38 insertions(+), 60 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index b79ee65ae016..6515b00520bc 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *s=
b);
>  * setup a work entry in the ssc delayed unmount list.
>  */
> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
> -		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
> +		struct nfsd4_ssc_umount_item **nsui)
> {
> 	struct nfsd4_ssc_umount_item *ni =3D NULL;
> 	struct nfsd4_ssc_umount_item *work =3D NULL;
> 	struct nfsd4_ssc_umount_item *tmp;
> 	DEFINE_WAIT(wait);
> +	__be32 status =3D 0;
>=20
> -	*ss_mnt =3D NULL;
> -	*retwork =3D NULL;
> +	*nsui =3D NULL;
> 	work =3D kzalloc(sizeof(*work), GFP_KERNEL);
> try_again:
> 	spin_lock(&nn->nfsd_ssc_lock);
> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net=
 *nn, char *ipaddr,
> 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
> 			goto try_again;
> 		}
> -		*ss_mnt =3D ni->nsui_vfsmount;
> +		*nsui =3D ni;
> 		refcount_inc(&ni->nsui_refcnt);
> 		spin_unlock(&nn->nfsd_ssc_lock);
> 		kfree(work);
>=20
> -		/* return vfsmount in ss_mnt */
> +		/* return vfsmount in (*nsui)->nsui_vfsmount */
> 		return 0;
> 	}
> 	if (work) {
> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net=
 *nn, char *ipaddr,
> 		refcount_set(&work->nsui_refcnt, 2);
> 		work->nsui_busy =3D true;
> 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
> -		*retwork =3D work;
> -	}
> +		*nsui =3D work;
> +	} else
> +		status =3D nfserr_resource;
> 	spin_unlock(&nn->nfsd_ssc_lock);
> -	return 0;
> +	return status;
> }
>=20
> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_n=
et *nn,
>  */
> static __be32
> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
> -		       struct vfsmount **mount)
> +			struct nfsd4_ssc_umount_item **nsui)
> {
> 	struct file_system_type *type;
> 	struct vfsmount *ss_mnt;
> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, stru=
ct svc_rqst *rqstp,
> 	char *ipaddr, *dev_name, *raw_data;
> 	int len, raw_len;
> 	__be32 status =3D nfserr_inval;
> -	struct nfsd4_ssc_umount_item *work =3D NULL;
> 	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>=20
> 	naddr =3D &nss->u.nl4_addr;
> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, stru=
ct svc_rqst *rqstp,
> 					 naddr->addr_len,
> 					 (struct sockaddr *)&tmp_addr,
> 					 sizeof(tmp_addr));
> +	*nsui =3D NULL;
> 	if (tmp_addrlen =3D=3D 0)
> 		goto out_err;
>=20
> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, st=
ruct svc_rqst *rqstp,
> 		goto out_free_rawdata;
> 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>=20
> -	status =3D nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
> +	status =3D nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
> 	if (status)
> 		goto out_free_devname;
> -	if (ss_mnt)
> +	if ((*nsui)->nsui_vfsmount)
> 		goto out_done;
>=20
> 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, st=
ruct svc_rqst *rqstp,
> 	module_put(type->owner);
> 	if (IS_ERR(ss_mnt)) {
> 		status =3D nfserr_nodev;
> -		if (work)
> -			nfsd4_ssc_cancel_dul_work(nn, work);
> +		nfsd4_ssc_cancel_dul_work(nn, *nsui);
> 		goto out_free_devname;
> 	}
> -	if (work)
> -		nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
> +	nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
> out_done:
> 	status =3D 0;
> -	*mount =3D ss_mnt;
>=20
> out_free_devname:
> 	kfree(dev_name);
> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, stru=
ct svc_rqst *rqstp,
>  */
> static __be32
> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> -		      struct nfsd4_compound_state *cstate,
> -		      struct nfsd4_copy *copy, struct vfsmount **mount)
> +		struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
> {
> 	struct svc_fh *s_fh =3D NULL;
> 	stateid_t *s_stid =3D &copy->cp_src_stateid;
> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> 	if (status)
> 		goto out;
>=20
> -	status =3D nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
> +	status =3D nfsd4_interssc_connect(copy->cp_src, rqstp,
> +				&copy->ss_nsui);
> 	if (status)
> 		goto out;
>=20
> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> }
>=20
> static void
> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *f=
ilp,
> 			struct nfsd_file *dst)
> {
> -	bool found =3D false;
> 	long timeout;
> -	struct nfsd4_ssc_umount_item *tmp;
> -	struct nfsd4_ssc_umount_item *ni =3D NULL;
> 	struct nfsd_net *nn =3D net_generic(dst->nf_net, nfsd_net_id);
>=20
> 	nfs42_ssc_close(filp);
> 	nfsd_file_put(dst);
> 	fput(filp);
>=20
> -	if (!nn) {
> -		mntput(ss_mnt);
> -		return;
> -	}
> 	spin_lock(&nn->nfsd_ssc_lock);
> 	timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> -	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) =
{
> -		if (ni->nsui_vfsmount->mnt_sb =3D=3D ss_mnt->mnt_sb) {
> -			list_del(&ni->nsui_list);
> -			/*
> -			 * vfsmount can be shared by multiple exports,
> -			 * decrement refcnt. If the count drops to 1 it
> -			 * will be unmounted when nsui_expire expires.
> -			 */
> -			refcount_dec(&ni->nsui_refcnt);
> -			ni->nsui_expire =3D jiffies + timeout;
> -			list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
> -			found =3D true;
> -			break;
> -		}
> -	}
> +	list_del(&ni->nsui_list);
> +	/*
> +	 * vfsmount can be shared by multiple exports,
> +	 * decrement refcnt. If the count drops to 1 it
> +	 * will be unmounted when nsui_expire expires.
> +	 */
> +	refcount_dec(&ni->nsui_refcnt);
> +	ni->nsui_expire =3D jiffies + timeout;
> +	list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
> 	spin_unlock(&nn->nfsd_ssc_lock);
> -	if (!found) {
> -		mntput(ss_mnt);
> -		return;
> -	}
> }
>=20
> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>=20
> static __be32
> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
> -		      struct nfsd4_compound_state *cstate,
> -		      struct nfsd4_copy *copy,
> -		      struct vfsmount **mount)
> +			struct nfsd4_compound_state *cstate,
> +			struct nfsd4_copy *copy)
> {
> -	*mount =3D NULL;
> 	return nfserr_inval;
> }
>=20
> static void
> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *f=
ilp,
> 			struct nfsd_file *dst)
> {
> }
> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *src,=
 struct nfsd4_copy *dst)
> 	memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
> 	memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
> 	memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
> -	dst->ss_mnt =3D src->ss_mnt;
> +	dst->ss_nsui =3D src->ss_nsui;
> }
>=20
> static void cleanup_async_copy(struct nfsd4_copy *copy)
> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
> 	if (nfsd4_ssc_is_inter(copy)) {
> 		struct file *filp;
>=20
> -		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> -				      &copy->stateid);
> +		filp =3D nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
> +				&copy->c_fh, &copy->stateid);
> 		if (IS_ERR(filp)) {
> 			switch (PTR_ERR(filp)) {
> 			case -EBADF:
> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
> 		}
> 		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> 				       false);
> -		nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
> +		nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
> 	} else {
> 		nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> 				       copy->nf_dst->nf_file, false);
> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 			status =3D nfserr_notsupp;
> 			goto out;
> 		}
> -		status =3D nfsd4_setup_inter_ssc(rqstp, cstate, copy,
> -				&copy->ss_mnt);
> +		status =3D nfsd4_setup_inter_ssc(rqstp, cstate, copy);
> 		if (status)
> 			return nfserr_offload_denied;
> 	} else {
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 0eb00105d845..36c3340c1d54 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -571,7 +571,7 @@ struct nfsd4_copy {
> 	struct task_struct	*copy_task;
> 	refcount_t		refcount;
>=20
> -	struct vfsmount		*ss_mnt;
> +	struct nfsd4_ssc_umount_item *ss_nsui;
> 	struct nfs_fh		c_fh;
> 	nfs4_stateid		stateid;
> };
> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
> index 75843c00f326..22265b1ff080 100644
> --- a/include/linux/nfs_ssc.h
> +++ b/include/linux/nfs_ssc.h
> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
> 	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
> 		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
> }
> +#endif
>=20
> struct nfsd4_ssc_umount_item {
> 	struct list_head nsui_list;
> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
> 	struct vfsmount *nsui_vfsmount;
> 	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
> };
> -#endif
>=20
> /*
>  * NFS_FS
> --=20
> 2.9.5
>=20

--
Chuck Lever



