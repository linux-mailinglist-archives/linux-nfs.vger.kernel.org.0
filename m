Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD99677E5A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjAWOs6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 09:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjAWOs4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 09:48:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6687EEF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 06:48:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NEhbmY002604;
        Mon, 23 Jan 2023 14:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tbkg0O+7McdqCFHiWQjx8oJSOoJnb/x08OrJ4vnkTM4=;
 b=xM70yKqBCTPpj/c7bio7pt1OJJ9WqG49M3FYGbg2cOpapVSmm48XyoJ1vp2E1Ohj2Xyx
 Q2jAf2MqnAvKFxuuxSeznObLnmzGAQnbkcSboqn6WGlTDQ7ML9wHbMNanq5UqUVBOHE3
 rJ1KsiPaqvZnnzADPrKT0DKhP9bBrTtIylr8tnjscJ9DR6diGiULi3LWlXG6d2RU2mCh
 paD93zGrGqA61t7f3iCyUcaJwvPAZ+QwOc2cnP5TYgwI8nEnq5rP2HqrZBmMh3FVS2gb
 z0FRiqF53EiyBjBIxeHp0bjRWN9R7ffrC8WkeiRaaOnAROYDraiLYK+Miz7QCNjCyZnM tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fcay4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 14:48:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NElZRp006431;
        Mon, 23 Jan 2023 14:48:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g3kvr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 14:48:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6qFvi5vFwoqu3MD3Nb624m0how4/M5yWoulaaaf0RC58nEd9wtZAwLb/5UEDRTG48p/kr5uoa8dnrg5nd0PH2YC8FgWaE5KWCjybpfEc4Z4mv9yHgNqPoJbnnTYbrAKtxFXZiKkkxbnPIDqzMvNQNx/Yt1+TpV2Q/RZ2h2IitAMdQPniG/nDPl32fzmrbLlasLkmRoqrO3eb/Y3OkMPOnPUrtxrLWRwsPIfX7vYGudO2sXgd5fH4urZFI/YkrGP8cyWbmusM6TN0EYuzZK23+Eqv8IFif0Hvl1IbZUxrK5xKuutRJIQKBazCqafhzI1MraumOnPxQXZVvDdwdSIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbkg0O+7McdqCFHiWQjx8oJSOoJnb/x08OrJ4vnkTM4=;
 b=WYNik/6ZoOt60/1PQcM6cfv/7rrfjFfj/f4AS833a2WJd1h8fDZ56cP+fdK3bQQTxO2KRfw0rMcn6UrEhv4jI1rSMTKZ7Uu88AiyVg4wsIoRJIhgUJ7DulQV+ossK8yIxE6K2CsNDdN8+EnYdIid4yzNGyzksnaOzQ3gRt4SW7ofktJYNCWInhyVR36NLZBLHTP+fNX0+N6/dgKkFR3MJOFGABcwGYmbBwnrIegOzaE23iC/uFqpPLpdIZLtVEJEfKLKIMDMY4bgQoLNw+Yk8Qw87GtQT0Sgas+gimOR3OktpLYlTO6o/YmntcaoZKwcOLiBPB/BfA8oW6DR0dboEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbkg0O+7McdqCFHiWQjx8oJSOoJnb/x08OrJ4vnkTM4=;
 b=ORnMePTaPrPYgI5M9rQb8wlW8CvUoeUv+VZFFm6P9+YSyzU5tiVYXRuNzlXXbeV01LvAL/r9iKi9KYEfx4n5aZRrkRiqC5I40xo6LDP43jixvu+GDofKJ59vTxWk0avdouEdT0WnOZQz4gDjCUMrwzJ3R7bX7j5i7TNw3UPJ2Ig=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Mon, 23 Jan
 2023 14:48:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%6]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 14:48:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Fix sysfs path for the NFSv4 client
 identifier
Thread-Topic: [PATCH] Documentation: Fix sysfs path for the NFSv4 client
 identifier
Thread-Index: AQHY9D/UHAS9TN3bW0a4ulUjeWuAMa42mHuAgHXi6ACAAA+yAA==
Date:   Mon, 23 Jan 2023 14:48:45 +0000
Message-ID: <2817011C-299D-46B4-A8E2-D5EDA9FE1D08@oracle.com>
References: <20221109133306.167037-1-dwysocha@redhat.com>
 <CC98B38C-2E79-40CE-BD9B-6E336BBD6552@oracle.com>
 <CALF+zO=u2p3BuH1nGt7DMekbRiJZGUuZZRF-D7pGULw5VoMo_A@mail.gmail.com>
In-Reply-To: <CALF+zO=u2p3BuH1nGt7DMekbRiJZGUuZZRF-D7pGULw5VoMo_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4392:EE_
x-ms-office365-filtering-correlation-id: 80307fc5-3cab-4d77-2da0-08dafd50edab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G8efTAwvLp//FEQTwzBaFEY162fLOv8OsROSN1tDvYoUQnCSoc3dulB42J9d4/ZAJzVMiRIMUo8OTGLzmcsfi8/P+SvKM+hzC32IR5FzcUPt8QDm2yVhEBH32etLrZ28NIcl9Dzi4/pSWto5zpXdqrcB+uZDcMB6ZPNc2d4DsHSfTysd2LeW5eobnskBzmcWA3rLFLHDIA1Rb4yJzJ30CO4KqROpoFvjoZrClQY5dQh/pCns9n3FjjiJbYX0YwczfFHe9l9z1QW3g0ooVfdhzbG8OeHomR/YnLCRgrA6CjagYEYqzICrkwA9BmkenjKNitZuWCSKvzcWJIU4psuDvEK581n9GDGICLt8YVQbKoFhYqYJPB27RXS8MOTD30sikOgjvLGlQZtoXfm0qAn2888Rv9TWEgDB4AlkZNnU70V80D18hOtR5xX172d/ekzyHLwAivVneC1g44+Vj0BO0lUJlVtwlWcuQRw+VOPN6HRT6GGXlnjgk7wInlVcGTglyaG8KakGw5Iaq+TNtpMVrklrDcMmURPdDCyw2b9iABR4lR7CApshtXOcBk8mZsCdI4UUznnI7ZijlwrSPlskbZqjMBuoaqGscmXOwNhz9VJZBW4aT4nNqq2Wa7o1+xvj7cMUCoJ0oCVln/zPCgOXvXhEVKEeUFMMpfCGTvynFGeJkQEatyXf0C8EFvs1wh6w46HlroT0Hw4x2/UvweccLnLA7RBIJg7wc2vIskBBpFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(8936002)(54906003)(5660300002)(6486002)(86362001)(478600001)(316002)(66476007)(2616005)(8676002)(4326008)(186003)(53546011)(122000001)(71200400001)(66946007)(41300700001)(38100700002)(6506007)(76116006)(26005)(6512007)(66556008)(6916009)(66446008)(36756003)(33656002)(91956017)(38070700005)(83380400001)(64756008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pDCiOimkHrNFO+FBOvUiBZIKq5nqN/+BMxv+hN9nFsG5O97RBQ67kw9laocP?=
 =?us-ascii?Q?y1r4A7zvN9l6A3SdFRoyKCroQIE+Dhs+RY8TXHRSgQCFqpA9D0GLzNU73+T5?=
 =?us-ascii?Q?hzy9taj/sYDKYWERUb4zIZS6VYhIXqdw04+s4liibwC7YFgRAxJItWebFRf6?=
 =?us-ascii?Q?UiorI3SVH4PvdkYlvdQfdYOvmhvxoR6SiBz/V4J/G+68MWjdQxXNeknNTr2f?=
 =?us-ascii?Q?hDpH4UCyIF8hkzpNE5Vt4mcMFnh26kMuXClyjBXSgWelkSOYxaD0ofUDoNTT?=
 =?us-ascii?Q?qaJKfAd7Msh2LWHhne8dvBgw0jeB2ZdJkJgw/hlVWtxrQR7THNGfmBP2f7+P?=
 =?us-ascii?Q?R4383yEV3lLY9VAjtNyTeLYWrHHiIQWvE2faXGTHB8LdSwlBhqjp+v8M/kOq?=
 =?us-ascii?Q?N7etRXU3msxMzqoEHM2KA22epQkg+BrZXIjwN6+B2u1bz/Vm7xFLSrttwF4w?=
 =?us-ascii?Q?KAxc8/2ixiEdtMKNWA08vVmieclGuPQsozifUjuLlmcODmT69wVbDpmgdG0x?=
 =?us-ascii?Q?vO8XuycqsBrGVUiLjARXQorSCQzY2ReISrtB5WOCIfWva2hPYLpiZ2W8cozt?=
 =?us-ascii?Q?oN/4j5B5YCeCSg1rj4oqDYrZ5xiL0V/BEfOL9JzyYCOY/7XnzqZWFlGt31pF?=
 =?us-ascii?Q?M4cG7PjhiUFFcja5G/VSWttpwwUGFywTpX+ZjFggvxCfUADFlt5o0zqgTYID?=
 =?us-ascii?Q?0R76zNzvc5EvP1w0bksg+q0vA+xf638D8h6LG/Cgocd2/iZ26nVFuqtdFr89?=
 =?us-ascii?Q?uxQ0fr7iBEp9ieliMA5Rk+nfd2F4UYxSkio7+LZKJqpZct3VXq4OU5aEiTyI?=
 =?us-ascii?Q?HUpZoPUbjmjJem4vQk+rQA+Qbvn0lCVjA2gk8+TOKQEuSYDSyTO7VFaVtClP?=
 =?us-ascii?Q?kpz+R6VJ9XBksIs1ZiruEH3qeJldMh+YhBdk3lkwlYGbnWZ3gQPmDX59vfZg?=
 =?us-ascii?Q?LTCvBdvgksivdcIQ/pDi7++2stNVEFQM86dixrBVxXyP6bg/X5Nxu3A0F022?=
 =?us-ascii?Q?1DTE5Vs8Sj010JvoinU+JhAwsUQGknEQMjBZKNNeBcWKzV9R8wGW9x1/jRDu?=
 =?us-ascii?Q?VE/EdE+JylvceJMmD+tvUSJEu3Y9ts4I9OgM2Rl58WBVvETjdD5FgmVF1J1/?=
 =?us-ascii?Q?/gewWipJMcbV+JV2v1HTuCqyQMPTLHQhVbaPOgpPfQNJwOE+S7Oi/jfT8HGl?=
 =?us-ascii?Q?/gL5ec6xp9mPt+B7r2K/QN3EhJPgoHPlRMiFiHd2J6TmYD+yvB7mwFH2Mlos?=
 =?us-ascii?Q?mvLvjXcUUkkROKt67do63xbhqIKS+CqNwo/Bp1NaydSgnxcnLNN1E5sAcaMa?=
 =?us-ascii?Q?nPmCOQbGSPoc+fmvoLtsaKv3jSEJByDu5UeL7KNyzELHM8YHoGHfoYKTHNtk?=
 =?us-ascii?Q?qvStCPjJ0QZIr7sS3PfOKheYfKv1kDaKKtKjK9Xx/z05AMq+zjhQtt8l7L+Z?=
 =?us-ascii?Q?hUR7gb2U/7fUpUAajZy5JaH8R+Q8yiqr9TFoy0ZoRRp+Vn1pQQHsDgjDUUZL?=
 =?us-ascii?Q?zQ9Y5g6nAPzcowW97A+vPKSK0FjJhli6VvWSsIsPuLAWYd9ObnB1IPuwN3+w?=
 =?us-ascii?Q?VMr8FHWJ321Ew1+63lmOiv7iWibkGCajqSxpcMFgAQ1TU89mOTnO3jHtAsuy?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E27578D5BC19094891FF44655D4CA4CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3NKQ/3cnSMJ/o81iYk8glehB+kxHKoiIS+LGIOTYmcRN7qhMbnGzReeGXnuCrs0xj/hOG1HQRMBSFdDYiJVgRvaaAeCDDYeuwG3780XKMtNJo7m/uiU3HtoX+kSJewdB4pO/G5Sz8lhK7JFAIOUn/BC4mMbbqeedOsylnVuHh4YZuv2E7MoRvq8JKasKnzog4k6vVo209Sa1Lua0oSasL77q03kMQfrc3RJoT4vx0PS4Y/FKOmoUm+XbIZylOZS2HbPoDNkckCnQwl3TfTB5YlPAvOQepF/c88QIQg8Qt0oYQQAkWMpEImC7NOXi4xzqH89kgSeavAcgEhLTuOz+zPIS+AV4JgccFSZSNE2+utAkG2C3epRT6b0R7FbREOPShgNT92LeqJoUJc9xf/P1TNbDMihuuBwgcEjx+BEP88Xi0EmaA9Os7D0Ft0ipD6zABYX4BjV7eOeZFEGiLvIjOpbiChc94AX1KB/1RDdGg7Gmw3X5GXq5pw8tH19sDIOBzXXC59knTZU9SbltZplv+xTylWBB18N7cpUJoKyJpjaLIDDPF67/9RF/qwL+5WZgyTLlZ/cY0Jd1Arj2bEyHcrgxppbPeFPPD13TjQVcUSYuCtnw5dr6xo67iDRvsFQrn4gNrXw+iA4bq8dCZYdb5ZtbIV16ZaVm2MciGtsbmeOM0VM/rTC1GfbwnWKVLa5MmwepbB6LkwljbADyRpNvZf7IS1qbQPVpaswc2D6g760zM8Xp9eI79ILzOvrROZaizGJnIFLSteWUoc82gf5f9vYurqpXhS3+o0OfkPohQg6JzJ286VrKXB+D7caZBzGt
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80307fc5-3cab-4d77-2da0-08dafd50edab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 14:48:45.2351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h07P1jjef3ECF3XwgFk504Slm6FErPpoxFoHfowiHFffm4nkvH+cb3b1mjN4WQbt8tgKGDpqNE9CdmvD5vNAuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_10,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230141
X-Proofpoint-GUID: yZIK8z20BtwCWsPXVgtoawftGfgesnfL
X-Proofpoint-ORIG-GUID: yZIK8z20BtwCWsPXVgtoawftGfgesnfL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi DW -

> On Jan 23, 2023, at 8:52 AM, David Wysochanski <dwysocha@redhat.com> wrot=
e:
>=20
> On Wed, Nov 9, 2022 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>=20
>>=20
>>=20
>>> On Nov 9, 2022, at 8:33 AM, Dave Wysochanski <dwysocha@redhat.com> wrot=
e:
>>>=20
>>> The sysfs path for the NFS4 client identfier should start with
>>> the path component of 'nfs' for the kset, and then the 'net'
>>> path component for the netns object, followed by the
>>> 'nfs_client' path component for the NFS client kobject,
>>> and ending with 'identifier' for the netns_client_id
>>> kobj_attribute.
>>=20
>> Seems like the redundancy has some purpose and is baked-in to
>> the path. I'd rather leave the sleeping dog as it is, enjoying
>> the morning sun.
>>=20
>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>>=20
> Hey Chuck,
>=20
> I just realized the patch is still outstanding.  Now when I re-read
> your comment, I'm not sure what it means.  Your comment sounds
> like you feel the patch may not be necessary, but then you have
> a "Reviewed-by".

I was responding to Ben's suggestion elsewhere that the pathname
had redundant components and should be simplified. After reviewing
the code (and your patch) it appears that all the components are
necessary to have, so the document change you proposed is
appropriate.


> I am not sure if you mean this should be applied or not.

Reviewed-by: means "OK to apply". The documentation is incorrect.


> To be clear, the existing sysfs path does not exist, and we got a
> complaint about this documentation inaccuracy, hence my patch.

Can you dig up the complaint bug and suggest a Link: tag to add?


>>> Fixes: a28faaddb2be ("Documentation: Add an explanation of NFSv4 client=
 identifiers")
>>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>>> ---
>>> Documentation/filesystems/nfs/client-identifier.rst | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/Documentation/filesystems/nfs/client-identifier.rst b/Docu=
mentation/filesystems/nfs/client-identifier.rst
>>> index 5147e15815a1..a94c7a9748d7 100644
>>> --- a/Documentation/filesystems/nfs/client-identifier.rst
>>> +++ b/Documentation/filesystems/nfs/client-identifier.rst
>>> @@ -152,7 +152,7 @@ string:
>>>      via the kernel command line, or when the "nfs" module is
>>>      loaded.
>>>=20
>>> -    /sys/fs/nfs/client/net/identifier
>>> +    /sys/fs/nfs/net/nfs_client/identifier
>>>      This virtual file, available since Linux 5.3, is local to the
>>>      network namespace in which it is accessed and so can provide
>>>      distinction between network namespaces (containers) when the
>>> @@ -164,7 +164,7 @@ then that uniquifier can be used. For example, a un=
iquifier might
>>> be formed at boot using the container's internal identifier:
>>>=20
>>>    sha256sum /etc/machine-id | awk '{print $1}' \\
>>> -        > /sys/fs/nfs/client/net/identifier
>>> +        > /sys/fs/nfs/net/nfs_client/identifier
>>>=20
>>> Security considerations
>>> -----------------------
>>> --
>>> 2.31.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



