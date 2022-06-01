Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41BF53AF01
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jun 2022 00:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiFAViK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiFAViJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 17:38:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245DE2750
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 14:38:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251KEVW5020279;
        Wed, 1 Jun 2022 21:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TZ7BCEpxL9YXr0F3oMhb4fv1GAw1iKPEjAmD64u6N5c=;
 b=F2A0dLKc9J7YyogG+hTtKT7n5NbfTKK4cZVdyxO8EYgwV6idTG8ZDKPsyi0yRRynw135
 WUuQcZEslVDGnkbj/HPyc8uqBZLje2U21q28QXGHgVqE3i55lp0eIARckUprbaHdMryY
 UNIpi5I4BrJNZ9pdvqqeP6yQnDEZjM25YQtAWDtnyAdgAyNFqR1YE/dTi8s0ht0zFUPJ
 nrdvZ8SXxavY38Pn9NNz3fKXrYpKk+kA+jIcY4Jwcc3NX4nd+lZadzPHvFAwXOXrNrPs
 1kxdQWjFu/M4EiuJn4WX3tJDO10qIA4qawzSIz6DlJmV0c7zZK07ZPtRoPfD4ECq1w+I Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcaus0a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 21:38:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251LLeWa036210;
        Wed, 1 Jun 2022 21:38:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8kheupk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 21:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiFcnNs1YlayJAY63rq2573qekSnmXBygcX9jw2JX1qiA3FHDQcrbAZnf579ulkTEzsOUW7VWbfBxgXCVOI0RuR+dAfQkbQxXGO4fdkJ6k3Bsh+hAowmvlqMDE5gO8ITsNqup3lBvURvm0kd6c1BXMOe5Zu6keiY7yK8w7JSxIoq82g2DWNSjqRdTbpo4S4excd7yqJN6IfpU2+GL0r/mjE+43hvOIkkjGfsdWAhTdaOd8Ac7PyAZXJVs76lklwkU3XPPL+AXdA6ViTf4mUKXRnfBHb6KLoyNISPl9Hg8n0cyiBapeHfzupI7hA2lNBmBY/X99G9LSKsCzdPKa65Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ7BCEpxL9YXr0F3oMhb4fv1GAw1iKPEjAmD64u6N5c=;
 b=VjtaAzqS6xvcCPWdpjMOVqP0jQT4C1vQHSHTgbnzVT/ppzww+WGQSV0trZxAhLpN/SY5dcNPqaf/gB3G2Z/0YEVzK+c4C+BGd0wuHRK2ACKVthd71daQO9zLM/bKX5jdis1xo8B/UoLXQVthnYTn3mUr4GPfg+pvImM+ahLpCnyUMiCswqv+1Z//dit8YMO7gx4PH2St/DPHhByWXurYdb5xz6i7jVhcL6mqvhc9Ph8qXGfH2lMVIwp2snVwl4kZq7YNwEZRQGL0bEYpMMUDVmF4CYltFMHjh/hTp1f2RYoPuJ22DSJMm7F5s9MLXJMRhTqZYtu4CGtoURiEfSYB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ7BCEpxL9YXr0F3oMhb4fv1GAw1iKPEjAmD64u6N5c=;
 b=fd5Yo+QqPZED4EpYiKj8vlyV4Jo6cu7i/uVyzNPwJe0BnoxbbrIYrm2eARJuUOcnshnPDMEzQOw38beboGfYJ1FsOP9s+a+x1I6n6iNnlwcKpwuB8/EMO/vcpwaBUe6LBbJUAH9ToRPejQWAlrVKrid1WehTGSCeTZjNR4WtmKA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3947.namprd10.prod.outlook.com (2603:10b6:5:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 21:37:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 21:37:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Frank van der Linden <fllinden@amazon.com>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: filecache LRU performance regression
Thread-Topic: filecache LRU performance regression
Thread-Index: AQHYcfvwqM9TwnG0lkutiJn4EA8Bxq0zLyiAgAAP6gCABnuxAIABBV+AgAAHvgCAAE5sgIAABXOA
Date:   Wed, 1 Jun 2022 21:37:58 +0000
Message-ID: <276D7504-1019-4912-822C-320E6E6180A3@oracle.com>
References: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
 <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
 <BED36887-054D-4DC9-A5F1-CB6DD1F0DC16@oracle.com>
 <20220601161003.GA20483@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <4C14DB3A-A5C1-41A9-8293-DF4FC2459600@oracle.com>
 <20220601211827.GA11605@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
In-Reply-To: <20220601211827.GA11605@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9d09ac7-0e5a-4371-2623-08da4416fef7
x-ms-traffictypediagnostic: DM6PR10MB3947:EE_
x-microsoft-antispam-prvs: <DM6PR10MB394743FF7A310E23C670567393DF9@DM6PR10MB3947.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E4i2s1lwzsHFXAcaxz4tnH8RCdpyW1MvCX72mzNlxST9Anix1zAZJx93OKLezJJl4toUKCdYH4hwbOqpUFAZ2BoNOTW7LQL8ndx5agZgdhY18UjpC+fdL4XEwKktxwLTzzz4Y6O7Y/JRtI/IvCxEaBk9AL4MWaLoZCs552KORamCqzemmah0FDnX+WspRUMEkOiUMtsx0PWh4uLADvIM1c+2WwWcRBJ/3b0Oif5CefSgQeVx/n0u+GxW5Vcqtb002+z/3iZnYiSkTIhRcYNjQCel0CN4rJX8rd9CiA7pF5vVmmfuDDx0Yl7mglsk3W7hkYsizNblO8kWqwX+sJLFygQ5oDFBMnBYLbHWyIGj1PvJpzhlnMjy4B2t54bhpGabJzULwOD6pfxi51+nIDH5mGxtfBBz2j2XlIC9ynwklCeo0QjG0kU7c5z5gmYv7kZQ7e3CIyrL7a6Qwu3QSjq/HJzB7es0WNywB5lZzXVafkYiMEh2F7cLtbd3uA121zB5zf3e1fYQL6InOzarF7TK5nGtlVrWGka0Dzovw2Uf/dDM1yRL13j5/d7ZaoY+xTk8NCrUwbDvHGQqEGWtA9nX+X8A4C7LBEgRlhZntOdEGaXXBh6FxW7M6x17izbGbBEpJiaeDh8qbTXKev34Wz/yWyfXtP7PVRS0fPdnMT3z2bo7as2uEVmwlwxGozeTH2Mk3MUeyEgo3Tjo2enCeOT5e/RPvEHvvy3vxnABAgMRFAzeZA33cjxjrM+i3R7rNW76jO8hCaUoSxtphynqmXaCUVWujw7PjzHYIkRQwnfmYqJGWlwLIFCNZ99m+8tKG9lAy/4pVb2sh3JXrkzOKl/UG/PglFGwWrpYevq8825jkM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(966005)(6916009)(86362001)(76116006)(53546011)(5660300002)(26005)(6512007)(33656002)(2906002)(186003)(38100700002)(83380400001)(66946007)(2616005)(107886003)(508600001)(122000001)(66476007)(66556008)(64756008)(316002)(66446008)(38070700005)(6506007)(3480700007)(91956017)(36756003)(71200400001)(54906003)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ju7ej69E5oDQ9nPIClQrti+GpViBXZFczAjFylNB9i+Rb/bovcnz6xBppSYh?=
 =?us-ascii?Q?fTfczXuS/KYHqtrmsO5zjTHVcW8TRCGRtMrU+EqiIZpVZhdsdru09zoXevV7?=
 =?us-ascii?Q?sZsI3oUjnv9iu1h8Zc0CiHMf0VtG7osvPE/oP/J3g5gKEFi2cv5ufBvMRfr8?=
 =?us-ascii?Q?DvJ64rzDD8Mas5nGvTP33QmqTFxjkHGGvQl6vVDCms5qLpsaA1yJZxKw5aD3?=
 =?us-ascii?Q?4vp/HQcjWqpu4XOF/FOIGx9IFF4dDrXP1eH84nSuDJCXDEfO8OtHmQNvqgrL?=
 =?us-ascii?Q?UFUrQaytqqf7D6PFW/n6OvSUyj2Mpaq3XLjaF6EsDJdfFIitKonIRuPKhsgO?=
 =?us-ascii?Q?8AtNpymafrU433FbKE/PEfyFUiracGG7pCMlUzjZITLgG3t/FokREVCfpJBV?=
 =?us-ascii?Q?WdMFmM5uGTA/1O9WpFA3gdCerbXCfoqY4i2bamh9YmMbylrYcCO6kUcRAB3H?=
 =?us-ascii?Q?UDCQ8W3ql86dIJWte/MtCw/beU/kYLhve2lyUqYqFyIO5z8M3wJ/LE57hnBu?=
 =?us-ascii?Q?Jjj7a46K5RvgOqY35ioDhA3DVsCzfeg20MF9m3K8owCGfxbIyWTCPtuO7Z2I?=
 =?us-ascii?Q?LhP0VKzfQTwet1x3/9FA3Hre6/DmCjvmiNXmgH+xzb72yLy8JW1VZJpG2Qoe?=
 =?us-ascii?Q?OqZnl3WJeqK+6Y9O8i5Y2R43c0qXu3kDKYBZXgB0hX7mMqCRs4yBeYhGxPUS?=
 =?us-ascii?Q?kXQrtFvwtRMMXEEOjG/VY9zFDe2LGNNsjWvzrnlhy3Rpzfm+nYHyYntbxVgN?=
 =?us-ascii?Q?BFaKrII6Ex42KwjkXa5QT/5DN31DcOYMURNlzjSnucebXTLLqeSOJ3pSUG8p?=
 =?us-ascii?Q?2uoNCxlDEzUyQhLP+/hKtCG0Nts3rhrl33HMp4mYu6wj8O6CZMeShLbgASZG?=
 =?us-ascii?Q?UIgNX/Bziva9vQGDJn7XyZLL8jp2wt6ajvFIhWD8pMMHoNLwdPo309iJ9Ub4?=
 =?us-ascii?Q?7BfRodpCum8QugsNx03ObyQMqUGDJ1ESheoQ0xaUMRNtTYB8h5cv2mYhrIrW?=
 =?us-ascii?Q?AZeZTRVWQ+f/xE/ce5RIZJvvQ24uKxvl/E9HT+7NtNHEqqO98mc+lFAeODrY?=
 =?us-ascii?Q?5YzaSigDr+7PEGv9ze9xtMo/4+OrQkpiTt89Oxx7DUqW3zKyZNbn3IljNEvC?=
 =?us-ascii?Q?bDv5G7+jE3jxsOPp7F42ZP4zykQ+U0n5sbPxuS++nzKRHnFMIBQqTH8vmgIr?=
 =?us-ascii?Q?ngBFrPvS7/Vg2wg06PUYHfZnJchUDfbYVdQeUo12lechWz6BvQwjFuNgOr4B?=
 =?us-ascii?Q?MzDnpPueZbgAtGJW+F3uoK3Twaf1e9joh3db/XkgrvlC4HYaGIPCS2usHhjX?=
 =?us-ascii?Q?8Dt9i2vehSqNnftYDv1+T7/X+AnGeEAkwyHzjhIHweuisHLIrZG4ACWIRG/r?=
 =?us-ascii?Q?dRlKRNaV/sxjCmzxlcNUe1TkOl3C02VAB77DgP9VtKo07VL65EvNrln2NNQ6?=
 =?us-ascii?Q?12HfiEYK0bzMPq0Vfg4GvV2dilWe3GWCp/gSYroA1FHCrXMS1GelkR28BFdK?=
 =?us-ascii?Q?w9+bGO0YfKgJ7IZvp5SURKGzw2XX5PFZAII1m3Qa1zhQJq8UYgRa8GBx+ly9?=
 =?us-ascii?Q?FxX/HCfIeEFV+FilNMboAoT0cWgEbSmbjfRtZp0/kcEDmfW4rrpkQ2KgHXAh?=
 =?us-ascii?Q?UUE5mnOekRPFTonv149xD2vKDxlULSGS+T2+xY6pzvCxw/wTIqCFysamlcu6?=
 =?us-ascii?Q?y0hY0KJ3ayn0GGr4V7Y+UArsPAWwSQnEe1u/64U7O+Vit/OLaBAjkJZwUSGu?=
 =?us-ascii?Q?z/tdM8xUYIWCf0NhryR27eNLGErUQMQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4BB8099338F5E4783845E8893BD32A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d09ac7-0e5a-4371-2623-08da4416fef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 21:37:58.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXPGMbLf6Kj/RJFfT1/ZupMrjhuFeM5I0+RB+bjc5kjB+rrsLyom1PN6WfDpRWKAQrP+DmaNgkFi8fSyXqda9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3947
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_08:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206010085
X-Proofpoint-ORIG-GUID: fJSacMrrqL3ngIoi4SNKVm4MrkME1QMH
X-Proofpoint-GUID: fJSacMrrqL3ngIoi4SNKVm4MrkME1QMH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 1, 2022, at 5:18 PM, Frank van der Linden <fllinden@amazon.com> wr=
ote:
>=20
> On Wed, Jun 01, 2022 at 04:37:47PM +0000, Chuck Lever III wrote:
>>=20
>>> On Jun 1, 2022, at 12:10 PM, Frank van der Linden <fllinden@amazon.com>=
 wrote:
>>>=20
>>> On Wed, Jun 01, 2022 at 12:34:34AM +0000, Chuck Lever III wrote:
>>>>> On May 27, 2022, at 5:34 PM, Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.c=
om> wrote:
>>>>>>=20
>>>>>> On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>> Hi Frank-
>>>>>>>=20
>>>>>>> Bruce recently reminded me about this issue. Is there a bugzilla so=
mewhere?
>>>>>>> Do you have a reproducer I can try?
>>>>>>=20
>>>>>> Hi Chuck,
>>>>>>=20
>>>>>> The easiest way to reproduce the issue is to run generic/531 over an
>>>>>> NFSv4 mount, using a system with a larger number of CPUs on the clie=
nt
>>>>>> side (or just scaling the test up manually - it has a calculation ba=
sed
>>>>>> on the number of CPUs).
>>>>>>=20
>>>>>> The test will take a long time to finish. I initially described the
>>>>>> details here:
>>>>>>=20
>>>>>> https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fll=
inden-2c-c1893d73.us-west-2.amazon.com/
>>>>>>=20
>>>>>> Since then, it was also reported here:
>>>>>>=20
>>>>>> https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.co=
m/T/#m8c3e4173696e17a9d5903d2a619550f352314d20
>>>>>=20
>>>>> Thanks for the summary. So, there isn't a bugzilla tracking this
>>>>> issue? If not, please create one here:
>>>>>=20
>>>>> https://bugzilla.linux-nfs.org/
>>>>>=20
>>>>> Then we don't have to keep asking for a repeat summary ;-)
>>>>=20
>>>> I can easily reproduce this scenario in my lab. I've opened:
>>>>=20
>>>> https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D386
>>>>=20
>>>=20
>>> Thanks for taking care of that. I'm switching jobs, so I won't have muc=
h
>>> time to look at it or test for a few weeks.
>>=20
>> No problem. I can reproduce the failure, and I have some ideas
>> of how to address the issue, so I've assigned the bug to myself.
>>=20
>>=20
>>> I think the basic problem is that the filecache is a clear win for
>>> v3, since that's stateless and it avoids a lookup for each operation.
>>>=20
>>> For v4, it's not clear to me that it's much of a win, and in this case
>>> it definitely gets in the way.
>>>=20
>>> Maybe the best thing is to not bother at all with the caching for v4,
>>=20
>> At this point I don't think we can go that way. The NFSv4 code
>> uses a lot of the same infrastructural helpers as NFSv3, and
>> all of those now depend on the use of nfsd_file objects.
>>=20
>> Certainly, though, the filecache plays somewhat different roles
>> for legacy NFS and NFSv4. I've been toying with the idea of
>> maintaining separate filecaches for NFSv3 and NFSv4, since
>> the garbage collection and shrinker rules are fundamentally
>> different for the two, and NFSv4 wants a file closed completely
>> (no lingering open) when it does a CLOSE or DELEGRETURN.
>>=20
>> In the meantime, the obvious culprit is the LRU walk during
>> garbage collection is broken. I've talked with Dave Chinner,
>> co-author of list_lru, about a way to straighten this out so
>> that the LRU walk is very nicely bounded and at the same time
>> deals properly with NFSv4 OPEN and CLOSE. Trond also had an
>> idea or two here, and it seems the three of us are on nearly
>> the same page.
>>=20
>> Once that is addressed, we can revisit Wang's suggestion of
>> serializing garbage collection, as a nice optimization.
>=20
> Sounds good, thanks!
>=20
> A related issue: there is currently no upper limit that I can see
> on the number of active OPENs for a client. So essentially, a
> client can run a server out of resources by doing a very large
> number of OPENs.
>=20
> Should there be an upper limit, above which requests are either
> denied, or old state is invalidated?

We need to explore the server's behavior in low resource
situations. I prefer graceful degradation of service rather
than adding admin knobs, plus adding maybe some mechanism that
can report unruly clients so the server admin can deal with them.

The VFS will stop giving out struct file's after a certain point.
NFSv4 OPEN operations will return an error.

Some of the server's resource pools have shrinker callbacks.
Those pools will be reaped when there is memory pressure. We
could do better there.

I don't believe there's any mechanism yet to get rid of state
that is still active. I consider that as a "heroic measure"
that adds complexity for perhaps little benefit. And doing so
is potentially catastrophic for clients that trust the server
won't rip the rug out from under them. I would rather prevent
the creation of new state at that point rather than invalidating
existing state.

There are ways that server administrators can clean out known
defunct clients. That would be perhaps a little safer, and might
go along with the idea that server admins should deal mindfully
with malfunctioning or malicious clients that are causing a
denial of service.

In the end we have to address problems like CPU soft lock-up
to be certain server administrative interfaces will remain
available when the server is under a significant workload.


--
Chuck Lever



