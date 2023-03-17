Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA86BEAE2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCQORJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 10:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjCQORI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 10:17:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E562B60AA9
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 07:16:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HDYZNp028878;
        Fri, 17 Mar 2023 14:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wiyhatBdLXMqFF6wFIG06g1f7zJC2qCGL0L2jI5qnT8=;
 b=iaFdGCJlXjV6O7BGenahn1fEV/Tm7JTl99x0zY0WujFJItMFeWGpq4pfB22MdKt3BNFX
 CNMkHyj4VaQyVCLHYX3YkrRbDg+5BDSExIPZ0gwfE1muL2EV/AGdavovruyy2ivCUcnj
 vyfs0W+nZjRBHAEZj2iinbiRyU1JNJ54qA0os9PXUEjNmr+9w2i8WzddZINZsgJNgwI2
 cRFzevUujZfIjVbECzqbGe25BzSCQvUBkCBcmbSrMrmAaiiqzk2sy0l4iIHGo/i/Bv+p
 9K6TBKLdwlzUL6aELVtUVLtVWU88NdZ15+SU7R7lPIGH0znuPlj55ErJezYK/2mWEiKt Jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29byq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 14:16:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HDgP0Y002602;
        Fri, 17 Mar 2023 14:16:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pch082q8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 14:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avBvAdIabjdu6y3l5nG3981zBoCbyN9us20jN6KBg7pqx5M5fOnNcMhnTq0M/tIpsKBRoKPlFuYNaYgJ5ls8EgwaAbnXRH2wpsvPIhlfpW2O1fb8v2SKz25ue/zP77oXcoRwhylNGIX9PcxsnefSkhV0OwmlyMEuTZFMTV5n9nHKDHGoy/shO4E/We6LB75/76AkqncPC4Oh3EJutr1UPwIH/5BclZeEkb7DSxAw1AYjFCEIR2qQIHZeuydrPR+tm15kH0ULLmPYI4f+zbeAOv4+EtrxGwgcwWyJXE7UH7sSeUtGhMmxC7O7C6ltesAICW3z4xFb+2cTTTxBInup/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiyhatBdLXMqFF6wFIG06g1f7zJC2qCGL0L2jI5qnT8=;
 b=d9EmeA+MKwTQOHlLPWHnxMwdq2pPNBX83yrSTSX6U+5eiTRlg5G3RthV2VTU75W4PSVCh9WxDHnO+vLLdL4Rc6UqPUvwnyoiP3Ws7pyRo33LIFTDF0D+Zw/wJaRpGjCch5bA4NSMo9rGzOb12pyAwAnvYnfxc2Ljst5ye9gAJ9uQTaZRqgWAbo3O31pHrWQgiHwyIHyezwwFf0u4LDPW+hNklCH5plF8uN55DXZ8XfgmfRi27jfMqrziWC2WKpeojXNZtQVKfWIOCjjAaqI9Euk5F3D/Rclf1RVdmTh/bLIQEQuauJnpZ2u8IHV+WPoPLnNqVGJkX0Qy8e9Leecy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiyhatBdLXMqFF6wFIG06g1f7zJC2qCGL0L2jI5qnT8=;
 b=X2OryTSfElxyDs19u2ayAJj/uUFAFQiYGmxgAk6dFn7AefFpihMUcJ7P5veegXWfeAkBA/QB9+/68MtsmbifapvKSKj2ZTA8SdHIpdd6ERSOXlNIht84OzcK+YA6DXEjsFPdGyOQaEfBkhFRAV2nuF33NNJ55N0zTXSg5x2WjIA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 14:16:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 14:16:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Subject: Re: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
Thread-Topic: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
Thread-Index: AQHZWL8bpLhVrwRqqEan4MoWlxHuRa7+8Q2AgAATp4A=
Date:   Fri, 17 Mar 2023 14:16:44 +0000
Message-ID: <65C84563-6BCD-41CE-AF68-80E1869D217F@oracle.com>
References: <20230317105608.19393-1-jlayton@kernel.org>
 <c57b48f500b859a3daf6f95ccefdfbec72e1c9de.camel@kernel.org>
In-Reply-To: <c57b48f500b859a3daf6f95ccefdfbec72e1c9de.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6365:EE_
x-ms-office365-filtering-correlation-id: 579f30ef-72d6-4821-62d2-08db26f23c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JiAe28GpUiylOcRhcrHb7NKlK0jCAj+1syZIk1QY/0EeckXL0R2e7/LRGbtZyq7MEWhoPUbYghbbEJOSuf30G86hQVh3n0SAWhJqMePctbaNPuBkLF8YB+MBmRwJolBxzG6e8PLEOS3YdqSBbN8KQdoE7ZBYMUvmm7gOdd85D/LTOTjZUSskj8dyxGKTgCg0AAAghXVq9o8YKnfflZ7EnpQ7BM+RN5ZjjO6/nZOgaLrOlGwsKxDlc6XovXJcpwlkfzSVo07ZaX+n2TCuxsHyB+UGkM7h20n69w+zThCrlk+LuyKPaLtjpi3OcHTJKaodeI8iab6A/G8ldZwcYrN5wd6k8dHLipvrDExivS9Dd0iddY/GK63vlvOgvNKxhT35gc5R8p9xJ5LBu1HDDSooZ30cxfY/etxWJ/39A1bFrlcLyKyxJWU/1JNJ4okVMqeOAv2qMLSfMpFoCbcXRbQvfamevQSv83lfl1GFiZrZ7wE9/05cidR8QT8ixrdwb/JG45oE1G/kst3gGul7T9x9SZaFMcjUeyhTp+FJev6tYhfqmmK2Jcm2LXH29xr40zwWkHXwkwF503XQqSQmD4CUm/UJvVJyHr8Yn4EuX6Jj8iRYNIV1FiwIUXSGgmG2/7T3W2ApD7WSi4hizNKDfivn8bZaDdn4pAVY0MMGEdkuoHlH1Y0jaUlq7XXrP3shzbaE3XrDSwzjWyaLU1c+5/GvcJ9mlDfhTCwZ/CBQlTCczQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199018)(8936002)(5660300002)(4326008)(41300700001)(6916009)(36756003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(2906002)(966005)(6486002)(83380400001)(478600001)(71200400001)(2616005)(186003)(66899018)(26005)(6512007)(6506007)(53546011)(54906003)(76116006)(91956017)(316002)(66946007)(8676002)(64756008)(66446008)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bGu31qs+vgiHfqCoN8IVVQxfjMVvZmGzDtUUV61mMg6D8UxlHZe9CROs+atw?=
 =?us-ascii?Q?OXpK9Tn0DYCO+hgpeT67MIoSCi7TCFaV43Gai8SS3rNb8X5y6LwVS1Ctu2Mz?=
 =?us-ascii?Q?XmdF5uWgtMn0Tj6ulWfTJ1X+tH3WLT6yGR71MQR3mgjVsosLM7KLzzb5cjfw?=
 =?us-ascii?Q?WhR3cQv5y+OcM0dyzAtKoQg3Ma8fKe+jFkS1BtKfHwz77yglzVipK80jbx36?=
 =?us-ascii?Q?vQxs+9/UKL888ztcDQwXq47c99sjVNy9g9R00s7iWbV/zDSLTg2+Fud65UbX?=
 =?us-ascii?Q?NtVoIP0QXW27MZzWYm/FxRK0mEqWakz89T1iH8kbS4vPWRvNBhwjEj/oFojY?=
 =?us-ascii?Q?rM/+6GdzLIzGRtCUvX/sFssUnL2i4XnrWxktqIHi6h+6Ef3prKFwziwGRc5K?=
 =?us-ascii?Q?I1VEjSyy9bSoeokjx9Ydw6Bo/9r0I5Oznbs0z3HDPK580jpfCxu/AmBm4tnF?=
 =?us-ascii?Q?vKs/QHeTZyB59lK2n5LLWHRPxLToiIeclh67lSp5K4HzVX6FR2RFpadUCuAI?=
 =?us-ascii?Q?4P6hgNaB+6dk5hggOR9BAJjWA5T8Sg4wSUxyVZu7bvL1BxLEM7z2IVEWuXgu?=
 =?us-ascii?Q?f0fM3kDwIRmTK6VSlQULjERK11a+Ns76xXRduwQqaEeqcfpajtVOvEu8nWjJ?=
 =?us-ascii?Q?MXb5pjnTMEHlu0+DBSY/JYR4WqClaLI5EALoWwaUxbhXdpYNcSGlhLpm2XZW?=
 =?us-ascii?Q?dX9b46StGZwYjWMouisIKnk5137n5as8VRtj1LN61bn1zYU6iBk+Uh8QQSDu?=
 =?us-ascii?Q?AEskkuSzt5c6gqPEj7GmfREqEwhoxZKfv9G7xZ3yksUDsEy9sZIczE40rpK6?=
 =?us-ascii?Q?LKGTI2B7S7MGoJv5abOVM5MVXKz+g2AJ4aNikGx53JgWrNnXltp6D626pjlA?=
 =?us-ascii?Q?Cw8CSLewuni0kNsmcI8RcUJ4x4HzLxrgDqOTrp95A8hZ23lByDGFNxwST65b?=
 =?us-ascii?Q?zSfG2wjEeVC5Wwhz32/DIfiQKanV1tG1aiTUaCW5/NQwl1G1dEF1XZR0ITdh?=
 =?us-ascii?Q?iJF10JaCTJgp5Fg9JFd1uMFFdZvvgWHKiJr2dEBNWU+fs8DkwuCM2pKun9Jw?=
 =?us-ascii?Q?+0eoYpcwYNtYo4/pUtRSNoXdHpBYQn/HeF0RPVK/tpMC0yh73mX8j2MFaFwO?=
 =?us-ascii?Q?xyl3fPYJxQmNSOzzp4HAudloszeTYP2ZQYlPBqoj371wFqWuaJDWILHgtl1M?=
 =?us-ascii?Q?eysqPZW6AeN2aPPh3pAdT3ezmS6YUJvieHiOiUcRlc1d++DEo+p8ShsY4arp?=
 =?us-ascii?Q?ZD+Lpj2tNyAw7buQOVbs7ptqPBBsQ1GyxJdiy93Ko2IAhDbnT6nmbaNJU2oU?=
 =?us-ascii?Q?BmPgYkE1DF6AhCPWonaFXnm6WOxeaKo2lehop/vO0d5FI9JucGHfaUrJ7c0g?=
 =?us-ascii?Q?j6jWKYFFR47RDU2aQuILeh4QYSY38Du7mVu6sHJ7OgBHUau5N4G3PIGawP7l?=
 =?us-ascii?Q?LB8hok1J3/Q/FwTgKiN7p6xItr5otveYFGYYe+uVmi1cYILFqoWTHWxzWofU?=
 =?us-ascii?Q?Lwwwp9rjvbirTlqa5tYy68goKmNd2aFHtC+w+lnX67dfjE4yxaDzTGd0gSdf?=
 =?us-ascii?Q?UcoXLvQBSdP3TwUFLemNxrqbovrj4DsTQleIwAIfMtP7gDRF9/DuzfQhzeby?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A56B78F8F130345B7ED1E0915F4A39B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NnNM9bQgT70xb6iU0dZhUyXYlHW73RVYGXv5Kia2L39qGuYkF0demU1wV44Hjj8QeM4JiuHVk6E2mIHX2hXKz+HaE2HrECvZJGzAae4H2chOq3xUsZs4p4uR18InBalGa5uyvFHeuV3DVu9RWeVgeHr1QKS+piVoD4g3q5SS91O2kJn+UvWrBMRc58KWDCGPsi7BXlcP+5pbI2BD+ugNQLD7Q4F+0kPA6YbEjqEpE/4Mm9ijZ1d+q4Xw/xxkH0V94s9XTYshn6RnyIdY2W8kC6ZT6q5bnQwjCPPMe7U9aDeAB9oDh+RvtePMVcV9URSaKAb0JZuNE9QOjGs/arjG1Jy9U0VjdEyYjO+2Bk7nQ2oLcpBIYw+WuYY0MoJnNhOsPSJ8kRv/8+jrMgL9wc73cwiub7RYtPBNJW+umRknlll1hMDOpSJO2W40rUZjpYh66myT6Q7jXDzCzi+KjyvyUlTZiL/UfntVVHp3/GWgFZ/pvRMYrAhpMDaUu4tU6a7+nrxuzXdoJFJUjjfgUO4dU62FROzGHHdnZB9lOzvATcTVEJMsUnhoELLLRv0I8ApCNBEYMJm7SBvC0trxv6h0n7fa7iBprFMIopAbI5BZ89BKuyZ/ZSXJ7zm0Mb/xQMF0X6C0pqabeYKkme+xd2AQjKRir+Ta2D7aY6jTlo1bxtZTgepNcxtw0QFFYilbitiXQX30Nt88Cu3ckjA+iQWomfcx+7+d/NspcNToawZJhkofXOq0AsbF/CwBxn3QSDASjeWLMB71GyXcxbSxhBuw1tg3cCQDjt1CUg1ymC/ULxQ1lXWDquX2ai7UNnXjOyXt/67IA+d4kjYLo9tA4biAH7vm2HyGzLjX9TQw+3RECIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579f30ef-72d6-4821-62d2-08db26f23c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 14:16:44.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8OYyf8kZuIoscpm08WqSEVwma4xmwulPFwSnq3Ltwph4YHuAVtE9OLdoMoVI+/ZbnJ9UwmcaG8dX23sDzdlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_08,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170098
X-Proofpoint-GUID: BZHWjlN03QJ5gf2I6kaXnhhxL0cgbaWi
X-Proofpoint-ORIG-GUID: BZHWjlN03QJ5gf2I6kaXnhhxL0cgbaWi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 9:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-03-17 at 06:56 -0400, Jeff Layton wrote:
>> The splice read calls nfsd_splice_actor to put the pages containing file
>> data into the svc_rqst->rq_pages array. It's possible however to get a
>> splice result that only has a partial page at the end, if (e.g.) the
>> filesystem hands back a short read that doesn't cover the whole page.
>>=20
>> nfsd_splice_actor will plop the partial page into its rq_pages array and
>> return. Then later, when nfsd_splice_actor is called again, the
>> remainder of the page may end up being filled out. At this point,
>> nfsd_splice_actor will put the page into the array _again_ corrupting
>> the reply. If this is done enough times, rq_next_page will overrun the
>> array and corrupt the trailing fields -- the rq_respages and
>> rq_next_page pointers themselves.
>>=20
>> If we've already added the page to the array in the last pass, don't add
>> it to the array a second time when dealing with a splice continuation.
>> This was originally handled properly in nfsd_splice_actor, but commit
>> 91e23b1c3982 removed the check for it, and started universally replacing
>> pages.
>>=20
>> Fixes: 91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()")
>> Reported-by: Dario Lesca <d.lesca@solinos.it>
>> Tested-by: David Critch <dcritch@redhat.com>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2150630
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/vfs.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 502e1b7742db..3709ef57d96e 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -941,8 +941,11 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
>> 	struct page *last_page;
>>=20
>> 	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
>> -	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++)
>> -		svc_rqst_replace_page(rqstp, page);
>> +	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
>> +		/* Only replace page if we haven't already done so */
>=20
> Note that I think that this was probably the real rationale for the pp[-
> 1] check that 91e23b1c3982 removed. Given that, maybe we should flesh
> this comment out a bit more for posterity?
>=20
> 		/*
> 		 * When we're splicing from a pipe, it's possible that
> 		 * we'll get an incomplete page that may be updated on
> 		 * a later call. Only splice it into rq_pages once.
> 		 */

The "real" bug here is that the API contract for pipe splicing
isn't well defined, so I agree that it's very likely the pp[-1]
check was because a splice can call the actor repeatedly for the
same page. No one could remember why that check was there.

To be clear, if the passed-in page matches the current page in
the rqst, we're "extending the current page" rather than avoiding
replacement... maybe:

	/*
	 * Skip page replacement when extending the contents
	 * of the current page.
	 */

In the patch description, would you mention that this case
arises if the READ request is not page-aligned?

If you resend this patch, please Cc: viro@ . Thanks for chasing
this down!


>> +		if (page !=3D *(rqstp->rq_next_page - 1))
>> +			svc_rqst_replace_page(rqstp, page);
>> +	}
>> 	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
>> 		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
>> 	rqstp->rq_res.page_len +=3D sd->len;
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever


