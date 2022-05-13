Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1F526999
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 20:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383413AbiEMSxd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbiEMSxc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 14:53:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8796B7D5
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 11:53:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFdGsX032594;
        Fri, 13 May 2022 18:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dX+Pcpr91MTwRephc1dqO1uOH3Jrxaj/6HWglsNNAdc=;
 b=e8ixEEv+Y2XLGVpL75c+kashD7TI3OOYH0GfgS9tUJU5GHf7G2d/+Kl2/rSTo2aRk+GI
 MdwU794HIOYGOvgTJ3Dwn9LUzRSYOFK7xUfTlvuzdYEqcOvGcD7HVPgu2Mg8zugKmESX
 5E9ism10hjpT1RZ7taTg76QH5KFIfD0hxk4aDWN+gHaurZGI0B95+gVAw7rRSxALiy9S
 XXWEJnyDsfUkm3fpxgaMB060z3Fad9qLUtCWhDzNl4ZLpZSS+dkXLsmSlt8kP2i07+2D
 +mXz9Q4PKprRVM3cm/b+4gAGfGVZ65KdbG2PgaAFqrXdc9BVKLuYBoO/c5jUzIGEZzF+ pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgct0byj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 18:53:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DIlSM7010518;
        Fri, 13 May 2022 18:53:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6hd3hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 18:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojh76Pza1U2ZJjWlqgfV0q/ZDAdcc0oV1jWEfS/SUU3Kx8d93Odma1M/aaWhd/6E3HsQZbVy09lpiy7gMABdbcqsGCvMYCdaBGMDo5U9LVHqy6Zh0gvHIDdJIHdjcORlbFH7pvBeyO/Q3cu4gzWiy0MnXhw6r3ytofWvgQvFJbJ5rWHKwhxdBB/1X6709ESHYG4X2lij8Ou2OjYq73D3dpZR7X84ABW4QiI3cvVh52kK7qXvCEokYi4aYR+jCMcYGCY9ImZ+Kc25HpAY2VMSdcf942VbnDqRCaj2JhMVgaeu3DJk/uooQqYi+D91JnG/utiEIM7sgE54Arj+rvxpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX+Pcpr91MTwRephc1dqO1uOH3Jrxaj/6HWglsNNAdc=;
 b=lMuUeEhueqzkh+ROipp1lEQLDAaaiAwWTADRwvhzkeZy5qBxUjrBpk13MPUuTvBQOQ1rZTSPt1O4zbblvUyxz5Y/AF23bWVXA6eEKSujssQDEz8lWyqkDN9eVuWEFX/Jzs+wMhzaFsOWDEKplQj9ax1B+RhDofEBlvfuHLtapX1Ey6sxrQtjh2YuwPtk1aGiCioFDSf2C96uEdUnAhTSIHr0j2yRztnS15oYZxsW+6TApjRBmjwihTumkbUOR1up/EkBJtpWj4baSmyYpPC0KJktDYLmhOO8z/Rqn+DEsWd2veOzhjuT8vl20yYFb+ewrELybmGC8TsVQawbFF9GSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX+Pcpr91MTwRephc1dqO1uOH3Jrxaj/6HWglsNNAdc=;
 b=VsSKfYy8WdRgaEng9NArDA0xQNOdaVUDlE0OYwKo0Vfa+jYTiy8yX1gDgti2blVF/l/f7Rc1TI0FbOQ/SaovkBq77bjKwGJ5/J4LDNHOjJdQARokYgAwiOJYWk6vH4JPYJfRJWVWqpW1LN6XuDCA+98KSxgZ7Beo4w/PaHmq2KQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4898.namprd10.prod.outlook.com (2603:10b6:208:327::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 18:53:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 18:53:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        "dennis.dalessandro@cornelisnetworks.com" 
        <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4AgAAMfoCAAERPAIAAApwAgAEchwCAAAwEAIAK/HiAgAroagCAABmggIAAGOOAgAAFwwCAADuXgA==
Date:   Fri, 13 May 2022 18:53:12 +0000
Message-ID: <5068AA55-2F63-4D83-82E0-748B6C47BCBB@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
 <86caa842c44374cab7fc63b2ef1a373063418831.camel@hammerspace.com>
In-Reply-To: <86caa842c44374cab7fc63b2ef1a373063418831.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 058936d9-9f30-463b-3d79-08da3511d470
x-ms-traffictypediagnostic: BLAPR10MB4898:EE_
x-microsoft-antispam-prvs: <BLAPR10MB4898126F219936E4574FB2AF93CA9@BLAPR10MB4898.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbVdHrlSr5sHFpRkAcQRVRCms+i0FXNIjgXOka5MN5ODwmfGEAD//RuGEcxeBxETA6yCYEp5IZgKk3TQjMPAC1heIGK0xLYLP0LWN1IvVjLkEr5gqYwlQNtdBJ9uWYV30WX+LuABnoxxsEajHXrypFa7tHu6uVD0+sdDLxgvKuLr9U6nQkbEmdpPccFAsTrZ1bLbdW3PLqW/vku3BwjvllMFN1812b2gfIpTdbYizfbrHyNZ5vvsC/5dApuvSnshc8qN8QFK7eHVOwk5i5G4jdHF9mukM5f7C8Ts8rVJtiPLlXn//ToWYSIHRAQqjb34NpxLByDxHCobImw0XugTxMReEUBuZLMk/Us8/wGB6RrmtIimg+Gp7BDBBAzz1ZOXc13uyV2KIPV2X4wO7TUeI5z+hrHniMKOkrIk33WMNvskjIJ7Fhug8IjjT78MX+c5bmJlvK+lD9ghqfTS6ObU57/gIE2ust+Cf7hk51pFESCVtgeSlbG+GNGKQALbKIS6jbPBSnXzd7c4l+c5/C6uMZI2HgnKpbLRvyJRqgk5JpvXR6Gdp4WvuB5QERAAeDwJrHxUG4tlT+sIqMrQBMCGdYp/e77RC84SAdzWYmXtMtgSR4/roBPrcABE8IdW5D8m74ujrWg+FwK1TddFb0qL6ZB3pXXh6lEB7slC1AqAZh4Mh9hedKZShUgk0lZXp7U1IU+SpePgoXkeUKfhTTYmGSzPdOAKUIomqA4rz9VryzVtiW+85g8l6NVryKK3Y3h2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(8676002)(66946007)(66556008)(66446008)(66476007)(122000001)(4326008)(76116006)(64756008)(71200400001)(54906003)(6916009)(38070700005)(38100700002)(91956017)(316002)(186003)(83380400001)(53546011)(6506007)(26005)(6512007)(2616005)(5660300002)(2906002)(36756003)(33656002)(30864003)(8936002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KBYXJ87CXOkCq7rZl0V8485JdGq5PN117W47VT7mnZJp556ESi7NExqubAKY?=
 =?us-ascii?Q?1O5KeChYAAkZi5nQw0NO7CDQdbM/X4gbkCc2h1IFJTSLshtpOnKhJqNc/EdF?=
 =?us-ascii?Q?pr+AbNiFehV905bLaVcXXcW4HrRw43krO370U4UadpimR5G/jnOCSbM6GuR3?=
 =?us-ascii?Q?ckmyiWaNkoRjw9WC0hU+HnbRwIhn5L8lVi5NYEyCdxNgvf6Zr7fsjRN/OIAB?=
 =?us-ascii?Q?7obKg9b1PbVa5M5HeFktJlg8VTar0LC/NuDCXtTlYTssbZf8mwlGinFeKhPP?=
 =?us-ascii?Q?a08uYWhnmf/WHlOawqFUb8jPICAxPuc5yUR8cT3DRCTvypZpQR5SlgUQZWhx?=
 =?us-ascii?Q?dPGZxVcbR2pKrKGa+sg26Sa8nL+wlP3h1IloY+iVWQia/mNgFnRusApQO7VR?=
 =?us-ascii?Q?pA1niYHHbZ+5m3ov2sUvXZwzCYWK/dBjB13u365vZcej7qpS6LWbVmwa8IXd?=
 =?us-ascii?Q?mzKA1Rd76WajAoKx1LdcHJidnQcFJpoROMCvefOP2Zp+nvu1qpvTdk/Byzjv?=
 =?us-ascii?Q?5DsjCwMij2OkqyiO4cl8duiGu0kj9SVB5AxjNNPixCXS2SAuctAsZ7R/oHk3?=
 =?us-ascii?Q?Qs7og1pTcIcXSZxnXj/3FDthkeu9CnaxBWpYtHhPO10su4q2P0REv4YhAUlv?=
 =?us-ascii?Q?elenSyxlpjUBsPlYB/14s3xsndSiOH9OmqWx1e83W3feDOP0O2cbhDCxaJ0o?=
 =?us-ascii?Q?MH5oX4cRhdJfqzG6i1gEXnjdKb28g1QkvKjxh46Y0uhoUemUImtcSFgq1Ut0?=
 =?us-ascii?Q?gerWnd9YFjJdveM3ccdQYfojSHCGx7ngxjuWTOWO23+G4NVNrHsTqtQ1H29f?=
 =?us-ascii?Q?bLc9d4DYW6xZ0t7w9XgCTc26V6via9F45/nudRwaHIQy21u3HQvtF4HPPM2L?=
 =?us-ascii?Q?RyRA3FR7Y07Eb81gE8WFf1rC745rzxFUTdZ2ycZ8CPnqazLvryT2UTt0FM2H?=
 =?us-ascii?Q?/SRX2v49EgOHGVwfzWE3G4gxfTMM3Bur5bRgBtTf2C55sC7LT9Fbhw6f71I9?=
 =?us-ascii?Q?6+i3IUuuMm1MSVIkGZzYL6VsPxNKMDmTp/yBZwcREKwaYZy3JAyouXfLZ9hl?=
 =?us-ascii?Q?5sskHP2at8kBgDGrjrzg7HHHR4uEu5zk7uRpNyR7XpnmPWApui/4BEJpIiwk?=
 =?us-ascii?Q?rkFAMLfaf1vgZm9p1B748UUcDiYs8wycTh+KLY6yZ+zHva248vQa+csOCk+c?=
 =?us-ascii?Q?g0hWHliFyFgS+U5ScUonaOJnxMv9vBpKsAxWEPUHX8cu5PpWKHJ7PhUJ6Pm9?=
 =?us-ascii?Q?OaiZA4uykC9/tRwL3y2PHEYQnvCa42hAyJMlwOIy5EpWnJVBMc4+Lci3gnIk?=
 =?us-ascii?Q?4jkj9G2LfQV6hGKYa70VaD1z+6M6YwwW+ZZ/fex65NEwiLfL5zDK5qiP7Y6C?=
 =?us-ascii?Q?KYpVnYkXlILLyMD8Kc+i4+0whzRhz/u4c8k39/fLD82LVtwGkKJsD2AtK8dB?=
 =?us-ascii?Q?6Gt3kHJOzAqJbzMQ8oU+mLF1ftmIplEg34iZ+6Ygc1eD/d0KPUT+bJiVKg2J?=
 =?us-ascii?Q?CObIgpy3i8Y8x02UBGjDojzAZ8ygZUIvdF7hXlmFvjgRvaZj42XuEpt2zCfi?=
 =?us-ascii?Q?o7WL3ccsB93MaksRRB3S0ZKtgHNvFbW11NZ3NVi5pK/AodE5N/yACRonNQia?=
 =?us-ascii?Q?RZwyaL+E65kb/zWaiy+wVvFi38G0zplJMg4O9ArScr7GHHD9tXvIEYLUow0D?=
 =?us-ascii?Q?qy/zzklUBrOms+kU7UvhAij1ZqFViokkY05Hz9EfOwSNfpgo+Yg81EO/kH/z?=
 =?us-ascii?Q?At2PUqM87kFI8kclR8HzmYYL/nUnaYo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3B35BB909D15F48BBA9AA6BE30079AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058936d9-9f30-463b-3d79-08da3511d470
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 18:53:12.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQNVAAWGRP6aufrOrkAFyHWGanJbbI9auzSpzaBSgmvnAfW+xloMQCzJmOX2Aj471JAI8Xf/T2y0UoPglxOotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4898
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_08:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130077
X-Proofpoint-GUID: TvVYnPnuoPujwcPAFO1IP_fajcJUjrG3
X-Proofpoint-ORIG-GUID: TvVYnPnuoPujwcPAFO1IP_fajcJUjrG3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2022, at 11:19 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Fri, 2022-05-13 at 14:59 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On May 13, 2022, at 9:30 AM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Fri, 2022-05-13 at 07:58 -0400, Dennis Dalessandro wrote:
>>>> On 5/6/22 9:24 AM, Dennis Dalessandro wrote:
>>>>> On 4/29/22 9:37 AM, Chuck Lever III wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Apr 29, 2022, at 8:54 AM, Dennis Dalessandro
>>>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>>>=20
>>>>>>> On 4/28/22 3:56 PM, Trond Myklebust wrote:
>>>>>>>> On Thu, 2022-04-28 at 15:47 -0400, Dennis Dalessandro
>>>>>>>> wrote:
>>>>>>>>> On 4/28/22 11:42 AM, Dennis Dalessandro wrote:
>>>>>>>>>> On 4/28/22 10:57 AM, Chuck Lever III wrote:
>>>>>>>>>>>> On Apr 28, 2022, at 9:05 AM, Dennis Dalessandro
>>>>>>>>>>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>>>>>>>>>>=20
>>>>>>>>>>>> Hi NFS folks,
>>>>>>>>>>>>=20
>>>>>>>>>>>> I've noticed a pretty nasty regression in our NFS
>>>>>>>>>>>> capability
>>>>>>>>>>>> between 5.17 and
>>>>>>>>>>>> 5.18-rc1. I've tried to bisect but not having any
>>>>>>>>>>>> luck. The
>>>>>>>>>>>> problem I'm seeing
>>>>>>>>>>>> is it takes 3 minutes to copy a file from NFS to
>>>>>>>>>>>> the
>>>>>>>>>>>> local
>>>>>>>>>>>> disk. When it should
>>>>>>>>>>>> take less than half a second, which it did up
>>>>>>>>>>>> through
>>>>>>>>>>>> 5.17.
>>>>>>>>>>>>=20
>>>>>>>>>>>> It doesn't seem to be network related, but can't
>>>>>>>>>>>> rule
>>>>>>>>>>>> that out
>>>>>>>>>>>> completely.
>>>>>>>>>>>>=20
>>>>>>>>>>>> I tried to bisect but the problem can be
>>>>>>>>>>>> intermittent. Some
>>>>>>>>>>>> runs I'll see a
>>>>>>>>>>>> problem in 3 out of 100 cycles, sometimes 0 out
>>>>>>>>>>>> of
>>>>>>>>>>>> 100.
>>>>>>>>>>>> Sometimes I'll see it
>>>>>>>>>>>> 100 out of 100.
>>>>>>>>>>>=20
>>>>>>>>>>> It's not clear from your problem report whether the
>>>>>>>>>>> problem
>>>>>>>>>>> appears
>>>>>>>>>>> when it's the server running v5.18-rc or the
>>>>>>>>>>> client.
>>>>>>>>>>=20
>>>>>>>>>> That's because I don't know which it is. I'll do a
>>>>>>>>>> quick
>>>>>>>>>> test and
>>>>>>>>>> find out. I
>>>>>>>>>> was testing the same kernel across both nodes.
>>>>>>>>>=20
>>>>>>>>> Looks like it is the client.
>>>>>>>>>=20
>>>>>>>>> server  client  result
>>>>>>>>> ------  ------  ------
>>>>>>>>> 5.17    5.17    Pass
>>>>>>>>> 5.17    5.18    Fail
>>>>>>>>> 5.18    5.18    Fail
>>>>>>>>> 5.18    5.17    Pass
>>>>>>>>>=20
>>>>>>>>> Is there a patch for the client issue you mentioned
>>>>>>>>> that I
>>>>>>>>> could try?
>>>>>>>>>=20
>>>>>>>>> -Denny
>>>>>>>>=20
>>>>>>>> Try this one
>>>>>>>=20
>>>>>>> Thanks for the patch. Unfortunately it doesn't seem to
>>>>>>> solve
>>>>>>> the issue, still
>>>>>>> see intermittent hangs. I applied it on top of -rc4:
>>>>>>>=20
>>>>>>> copy /mnt/nfs_test/run_nfs_test.junk to
>>>>>>> /dev/shm/run_nfs_test.tmp...
>>>>>>>=20
>>>>>>> real    2m6.072s
>>>>>>> user    0m0.002s
>>>>>>> sys     0m0.263s
>>>>>>> Done
>>>>>>>=20
>>>>>>> While it was hung I checked the mem usage on the machine:
>>>>>>>=20
>>>>>>> # free -h
>>>>>>>              total        used        free      shared=20
>>>>>>> buff/cache   available
>>>>>>> Mem:           62Gi       871Mi        61Gi     =20
>>>>>>> 342Mi     =20
>>>>>>> 889Mi        61Gi
>>>>>>> Swap:         4.0Gi          0B       4.0Gi
>>>>>>>=20
>>>>>>> Doesn't appear to be under memory pressure.
>>>>>>=20
>>>>>> Hi, since you know now that it is the client, perhaps a
>>>>>> bisect
>>>>>> would be more successful?
>>>>>=20
>>>>> I've been testing all week. I pulled the nfs-rdma tree that was
>>>>> sent to Linus
>>>>> for 5.18 and tested. I see the problem on pretty much all the
>>>>> patches. However
>>>>> it's the frequency that it hits which changes.
>>>>>=20
>>>>> I'll see 1-5 cycles out of 2500 where the copy takes minutes up
>>>>> to:
>>>>> "NFS: Convert readdir page cache to use a cookie based index"
>>>>>=20
>>>>> After this I start seeing it around 10 times in 500 and by the
>>>>> last
>>>>> patch 10
>>>>> times in less than 100.
>>>>>=20
>>>>> Is there any kind of tracing/debugging I could turn on to get
>>>>> more
>>>>> insight on
>>>>> what is taking so long when it does go bad?
>>>>>=20
>>>>=20
>>>> Ran a test with -rc6 and this time see a hung task trace on the
>>>> console as well
>>>> as an NFS RPC error.
>>>>=20
>>>> [32719.991175] nfs: RPC call returned error 512
>>>> .
>>>> .
>>>> .
>>>> [32933.285126] INFO: task kworker/u145:23:886141 blocked for more
>>>> than 122 seconds.
>>>> [32933.293543]       Tainted: G S                5.18.0-rc6 #1
>>>> [32933.299869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>>> disables this
>>>> message.
>>>> [32933.308740] task:kworker/u145:23 state:D stack:    0
>>>> pid:886141
>>>> ppid:     2
>>>> flags:0x00004000
>>>> [32933.318321] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>> [32933.324524] Call Trace:
>>>> [32933.327347]  <TASK>
>>>> [32933.329785]  __schedule+0x3dd/0x970
>>>> [32933.333783]  schedule+0x41/0xa0
>>>> [32933.337388]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
>>>> [32933.343639]  ? prepare_to_wait+0xd0/0xd0
>>>> [32933.348123]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>> [32933.354183]  xprt_release+0x26/0x140 [sunrpc]
>>>> [32933.359168]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>> [32933.365225]  rpc_release_resources_task+0xe/0x50 [sunrpc]
>>>> [32933.371381]  __rpc_execute+0x2c5/0x4e0 [sunrpc]
>>>> [32933.376564]  ? __switch_to_asm+0x42/0x70
>>>> [32933.381046]  ? finish_task_switch+0xb2/0x2c0
>>>> [32933.385918]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>> [32933.391391]  process_one_work+0x1c8/0x390
>>>> [32933.395975]  worker_thread+0x30/0x360
>>>> [32933.400162]  ? process_one_work+0x390/0x390
>>>> [32933.404931]  kthread+0xd9/0x100
>>>> [32933.408536]  ? kthread_complete_and_exit+0x20/0x20
>>>> [32933.413984]  ret_from_fork+0x22/0x30
>>>> [32933.418074]  </TASK>
>>>>=20
>>>> The call trace shows up again at 245, 368, and 491 seconds. Same
>>>> task, same trace.
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> That's very helpful. The above trace suggests that the RDMA code is
>>> leaking a call to xprt_unpin_rqst().
>>=20
>> IMHO this is unlikely to be related to the performance
>> regression -- none of this code has changed in the past 5
>> kernel releases. Could be a different issue, though.
>>=20
>> As is often the case in these situations, the INFO trace
>> above happens long after the issue that caused the missing
>> unpin. So... unless Dennis has a reproducer that can trigger
>> the issue frequently, I don't think there's much that can
>> be extracted from that.
>>=20
>> Also "nfs: RPC call returned error 512" suggests someone
>> hit ^C at some point. It's always possible that the
>> xprt_rdma_free() path is missing an unpin. But again,
>> that's not likely to be related to performance.
>>=20
>>=20
>>> From what I can see, rpcrdma_reply_handler() will always call
>>> xprt_pin_rqst(), and that call is required to be matched by a call
>>> to
>>> xprt_unpin_rqst() before the handler exits. However those calls to
>>> xprt_unpin_rqst() appear to be scattered around the code, and it is
>>> not
>>> at all obvious that the requirement is being fulfilled.
>>=20
>> I don't think unpin is required before rpcrdma_reply_handler()
>> exits. It /is/ required after xprt_complete_rqst(), and
>> sometimes that call has to be deferred until the NIC is
>> fully done with the RPC's buffers. The NIC is often not
>> finished with the buffers in the Receive completion handler.
>>=20
>>=20
>>> Chuck, why does that code need to be so complex?
>>=20
>> The overall goal is that the upper layer cannot be awoken
>> until the NIC has finished with the RPC's header and
>> payload buffers. These buffers are treated differently
>> depending on how the send path chose to marshal the RPC.
>>=20
>> And, all of these are hot paths, so it's important to
>> ensure that we are waiting/context-switching as
>> infrequently as possible. We wake the upper layer waiter
>> during an RDMA completion to reduce context switching.
>> The first completion does not always mean there's nothing
>> left for the NIC to do.
>>=20
>> Ignoring the server backchannel, there is a single unpin
>> in the "complete without error" case in
>> rpcrdma_complete_rqst().
>>=20
>> There are three call sites for rpcrdma_complete_rqst:
>>=20
>> 1. rpcrdma_reply_done - called when no explicit invalidation
>> is needed and the Receive completion fired after the Send
>> completion.
>>=20
>> 2. rpcrdma_sendctx_done - called when no explicit invalidation
>> is needed and the Send completion fired after the Receive
>> completion.
>>=20
>> 3. frwr_wc_localinv_done - called when explicit invalidation
>> was needed and that invalidation has completed. SQ ordering
>> guarantees that the Send has also completed at this point,
>> so a separate wait for Send completion is not needed.
>>=20
>> These are the points when the NIC has finished with all of
>> the memory resources associated with an RPC, so that's
>> when it is safe to wake the waiter and unpin the RPC.
>>=20
>=20
> From what I can see, what's important in the case of RDMA is to ensure
> that we call exactly 1 of either frwr_unmap_async(), frwr_unmap_sync()
> or rpcrdma_complete_rqst(),

No, all of these mechanisms are supposed to end up at
rpcrdma_complete_rqst(). That's where the RPC/RDMA transport
header is parsed.

Reply completion processing is kicked off by a Receive completion.
If local invalidation is unneeded, then we have to wait explicitly
for the Send completion too. Otherwise, a LOCAL_INV is posted and
we wait for that to complete; that completion means the previous
Send is complete, so waiting for Send completion in that case is
unnecessary.

When all of that dust settles, rpcrdma_complete_rqst() is called
to wake up the upper layer. That's basically how xprtsock did it
when I wrote all this years ago.

(The Send completion is needed because the NIC is free to continue
to read from sndbuf until then. We can't release that buffer until
completion because otherwise a NIC retransmission could expose
the different contents on the wire, or worse, the receiving end
would see garbage. Works a bit like TCP retransmission).


> and that whichever operation we select must
> complete before we call xprt->ops->free_slot().

The NIC has to tell xprtrdma that its memory operations are
complete before RPC can XDR decode either the RPC header or
the NFS request itself. That's well before ->free_slot(), IIRC.


> xprt_pin_rqst()/xprt_unpin_rqst() can help to ensure exclusion between
> those 3 operations, but it is not required if there are other ways to
> do so.
> In fact since xprt_wait_on_pinned_rqst() forces a synchronous sleep in
> xprt_release(), it would be much preferable to find a better solution
> than to pin the request if you concern is performance.

In particular, my performance concern is to avoid waits and
context switches, because those add latency, sometimes quite a
bit. I've tried to build the completion process on only the
unavoidable context switches. I don't immediately see how to
do this by adding wait_on_pinned to the fray.

frwr_unmap_sync() is used only to deal with ^C, so it can be
ugly and/or slow.

I am open to discussion about the structure of this code. The
simpler the better, but there are lots of moving parts. So
feedback is always welcome.


--
Chuck Lever



