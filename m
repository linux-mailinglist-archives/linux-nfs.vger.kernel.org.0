Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577064F6F48
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 02:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiDGAjm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiDGAjl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 20:39:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533BBCEE1F
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 17:37:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LH05m004957;
        Thu, 7 Apr 2022 00:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z8QMy6p0+CcZLXNfc8+BmXHf7X1dCUlR/OHR89cCTZY=;
 b=qex0tYSawLM+l8bEZuG39HVcva99aWYFx7TFo5/aVGnwva6NyWhN8U/mluHZm2IMDDnO
 olxSZHN3qi+RHaThjrfOa84kwAuDzECs8/mX+d7uBd9l3RAIkWsrE75FoGAZlq8ZKR6X
 hgFQ69+K8dwvdp9mCoEqJw2rvxDV4o4GscnjUVw/Y/mevV5SKy1vo73iajRMhvN9WzFC
 +NXHWNywLot2XzPV3l3kxP0hoLxDHbYdYgIHmdxZw5avay5uQSoxn8TpV0nyR0l8G5PB
 G/GxBN10wXrFL+f5Q2FEz0MUhCPUC/zyWS1dx9jQEsxKwhZjh+t6yb3m/2LvOXjaXvuH Cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932feu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 00:37:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2370ZaSf001790;
        Thu, 7 Apr 2022 00:37:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tsredg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 00:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iolWQIhqLL7xytAk0eb8C8+efkUtW6XGSuhDnEPMCYDHmiwzdB64MmyWVAMDbuClkFOSpo3xlDr8SYf4T//dyz7qjvllQlgekzTQmeZqs3pZPwCv00jbln6JAfmUzIGFWHdQ/5AJcbMKVXbxIJViLDKf2W0azPGE2znYd968UGxyON6DOx9BHzcaposnLQV0+8RE31Bf1OUxeKrDkdtxumeaTe5XX4E8xLmrZT8S3hNrcCSysKbErnYYKXYG/dAFxPDDmgwTEH6Oc3NNZKYyZb+ZxsFB7PasHGaIv2C9PUwsHLPz8JF4DSrZD+MhismNwG7ggFRGfVeISHaxVVo08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8QMy6p0+CcZLXNfc8+BmXHf7X1dCUlR/OHR89cCTZY=;
 b=VzgY28GR/yNckdCZbvviHvdtiU8XtjSTs0etqK4uOMykfOVGn+UrFPTcFR1+SBaXK5llQJH0ZJVuARkHmtngJLFLQdX6VI9o+2zneFC0J8KFBl5WVbPc2TrZq8WkHqXbCbR15ibkAichXcgTGSoUroat4GaeZlkWa0rKSUrwWrHK6PiiNQGYP2+Wfxv+OX8MWjPi67ANvz13M0XuoNUoynrw79Kwd7VnlhMYIQwjIGV+DKpSntVdMxtE5FEmRGCIzRH7uZxm3dFz9NaHKSQbguDNwibQjMgheEF2qx40f+yGxjyiO/w+9hqsu0tvhzOwxsKIpvDFgW6xdf2wtK8XbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8QMy6p0+CcZLXNfc8+BmXHf7X1dCUlR/OHR89cCTZY=;
 b=ChvpK5DnSvYcZRFNwlQIomNLNtKMC90fsYMESakCvZllqqBEeZOPcqkgLi5VQR1A87PtVNrKZTUkOGou4l60VyATJlE99+PTLYzpg1ZpvgHStktlNOSL6MngDvMVUs3G7FsKWXX4ef5K7Zrq//V567GfLTmegF6kE1XO4mX/+AI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4631.namprd10.prod.outlook.com (2603:10b6:510:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 00:37:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%7]) with mapi id 15.20.5144.021; Thu, 7 Apr 2022
 00:37:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Topic: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
Thread-Index: AQHYSe/bEHUctVBe9E2g94N5iR8qkazjV7AAgAAFsoCAAAYegIAAN/ss
Date:   Thu, 7 Apr 2022 00:37:36 +0000
Message-ID: <CF55C9CB-539D-4A65-913E-E339A05CD6F0@oracle.com>
References: <164926821551.12216.9112595778893638551.stgit@klimt.1015granger.net>
         <164926848846.12216.6872977249610829189.stgit@klimt.1015granger.net>
         <7976abc7a7ea7bbc445256884d0164a1b3ac5bb6.camel@hammerspace.com>
         <0942D638-0F40-4811-9820-AECAA65D529B@oracle.com>
 <c4bea3892c7d219138c3a9ee961bab40e3d1c246.camel@hammerspace.com>
In-Reply-To: <c4bea3892c7d219138c3a9ee961bab40e3d1c246.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6477890f-0bc9-4d85-6a7b-08da182ed030
x-ms-traffictypediagnostic: PH0PR10MB4631:EE_
x-microsoft-antispam-prvs: <PH0PR10MB463116B27B4842381C1C9C3F93E69@PH0PR10MB4631.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4SrntxhqkHNeKXaOgjf2Bhvv0Mq0QRBuOip2beJRi4hp8VM1Gf7GiwMZ5RCRo83177Lf6uF+9X+663fo7+rVhxWmXmPJeEFVPFob9YV8gS42jT1rsTd/oPWvJBHjHO52iZJ7FbchGP6w9Hb+CEMrNk5QJeqFcltDBVrv3KSfm1AJHN+nUaZKQQmunkAAwAwpzIX+wwvhHCQP1iMI+Bv12b28wDJdpUopNTigjRNvACbvQGi9xC82cwKVWogCNici0TG4oIiUA99oNm+nxq8RuSjnqUJF5JtC0ckAWdohpjiig8diDOaHpdHt6s43nlJUM31vDGfwDRhk9SV4buZZvpmcH/GoYyncqpcYEujhftCnVxBSccoU1Zo2PIQCclNh3Xe7aL04PbIPHT3m/g318yjK5lX9ef3d16mZUXFwhSF1l3UI+4/IPTH94h4SjJqIk8mQNOjDnQm5lnxgMO8wuACoeFlTmddZdj3xHBceu4wTsZyjiXa5rlM9spIUYDK/ewCoHnyf8nM3bGHghbR9AyvCpkaEztorPNYN8e5hISUqIyZqZoznwCxbv35qIMlQLAUODGTcGcKD0qj5AHeBBXI7jTMx61Eyy4+yrTfB5R4GUiGTqz1lJ4g+UZ59pa31svyGpNMij5yuU9YgBFSZlc9bD88j9P44NMHfHZUGauT3PH6Kgd4F8WGm385Ow8M2zQFOGgHHXBs08XK2qbKVXpV7MjlPgbmQa8Y3vTV8p3SfDaOGcksiz2b8AyMOXnCw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(6506007)(53546011)(6512007)(122000001)(36756003)(316002)(6916009)(2906002)(4326008)(508600001)(76116006)(2616005)(66946007)(66476007)(8936002)(5660300002)(26005)(186003)(6486002)(38100700002)(91956017)(83380400001)(86362001)(66446008)(71200400001)(8676002)(64756008)(38070700005)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djJoVGFobXFHbjYxZm5NVE1oUzRScEc5bzE0SHo3S21qS1FzTU5qSm1iYnlu?=
 =?utf-8?B?dVN0aWRLc1lvNFB2dmFsNzNFMm5iZXRCWHJNK1ErbXN4c0hRR205aVNBdHZm?=
 =?utf-8?B?QmY0TEM3KzJyVnQyb2hYZ3hOSUsra3pOYm5PSUlvZFU3bnVvK0s4c29QZlE3?=
 =?utf-8?B?Z2pCdEN1T1dUSGl5M0VMTzFaS1FhdGJwNGpMYmNqRHVjSkxFZ1Y0Wjk4OTRo?=
 =?utf-8?B?Zm9senBpUndLUHpVWllWR2VDcUpoNkgzcUpWRjRMTERaN1N3RHV4cjJuWEMr?=
 =?utf-8?B?Qy9nYXdJOTlHeVVVb2hXSGJqck5IUkV0c2MwUDJkQ25Ubi82ck5jWEVaSmY4?=
 =?utf-8?B?Y3dxMHllL24vdUJQUitoaENCWnF3bnVQZXAxSVFYTTA1V3EydjRaazVzaVox?=
 =?utf-8?B?S1RCaHNFbWhsVVUxMzV1K1lvc3cyVVNRQzlaSzV4NE1PN21EZmRTR2VBOW5Y?=
 =?utf-8?B?T1RQUDN5NFJ4S2Y5aHRKOFY3MWxlUGM5K2JOWGZEZ1I0c2hnZFdnWnFKWXI1?=
 =?utf-8?B?UzFGZ09UM1lCUVBUa0x6RUZIdDlzeVZFcjNTSm54UUpvU1JOd2h0d1Nmc1Ux?=
 =?utf-8?B?NVA2QnBieGdETlVWK2xDUXB6TkVhSHZIUjJxaktuOUlJaENkVVdEUnk0V3JD?=
 =?utf-8?B?WHVSMVVlYmRqRDl0cGRsSGlIRmVmWGptVTdBTE53V0pWZkRmeTBOM2lvLzAw?=
 =?utf-8?B?WFNhRXZKSktQbzhGN1RGckFXeUpjMENRbWNaWWZzQ1FxUjYvcDlBekNpRmFR?=
 =?utf-8?B?eDVYSmYxa01LcGlwVDZ0Y0x1YVNRV2prNlhsOTVDTHJVZi9HRXYzQnYwNjRZ?=
 =?utf-8?B?cUtOWjZJRDREQWRjdENwaGxuUUFiMnpQQ1RxZU4wR09GUlI4dkVKTjJjZ1ZL?=
 =?utf-8?B?REJwU1pCWno5UGxoMDE1VWVhQnh4MkdjR0FrMUt5dUY5NlNLd29RTWwxRWll?=
 =?utf-8?B?OW83bTZYbU9aYm9WZGg0cThxV2pJUGcwL1Q2M0hEWVFJampiTm9pWnhjZ2h4?=
 =?utf-8?B?eVNIVjBPMG5kREZuelNQKzZ6dEI4L1hwSzNDWEV2aHU2Z01SazZjTXFqaVo2?=
 =?utf-8?B?d1FxNW9YK01laW9zOWU5blNsczk4Ry9xcDd2M3p5UFBJS2ZlRU13UGQ3eXls?=
 =?utf-8?B?L3NRMStWTmtNZnA4bHA2SnBUQ0VOV1FkZlExQyt2U3A4Y1d6b0lsYmJIZXpT?=
 =?utf-8?B?b2Y3OUUrWFFXNGFaeUJXM3N2TWRub0xDSTRyTFNvN0w0TGlUSEJ4QTZNR1hy?=
 =?utf-8?B?WVJsNGZpR2FraWU0V0JFWFM2ckRqMng0NmFxN3I1cS9UMkFyMjFxUjR5MmdP?=
 =?utf-8?B?YnlDOHBSRnJBWFEwNmR2YWhpWEhMY0cyU003dVh5RE5IVDFXNUJFanI1b0FQ?=
 =?utf-8?B?Ni9IclgwMWt5KzQ5NmhESlhFUU5KVXc0L2xyMUErQlpQKzVIOUhMSWRvZU92?=
 =?utf-8?B?VDMzdVU0TWI1YVFvUXloaDN2bnBnSDV2VnUyeHlTWmNKWlRYeVhQcTIxWEdr?=
 =?utf-8?B?WVB1UW1raXREdXNTWk5sdnRsQVM3ODg3Vlhhell5YVVsT0VRMVU5czlLeFJU?=
 =?utf-8?B?Lzc5TGFrT2U1MVdsRzhCVllCelhhdmcyWmJIRWdoUHJoYTRkd1h4MU9YOEpi?=
 =?utf-8?B?ME9nYnY4bTZDbXdJL0JCSmFNOFVXWldzcXdGRnlBRFhVM0lkMmFwd2NjekZU?=
 =?utf-8?B?cXNNbVlBYUpBSWdFS29vZ0M4VmtJdGRjYkUvTURnMWM2NjBSckdFR01tbmpx?=
 =?utf-8?B?SGl0Tk9FMXV6ekhYMjR4UXdOakFrelVjZjdRdUorNkJKdU9Sd1BxMVJRS09S?=
 =?utf-8?B?L09BaWNIbTh2ZlNDYWd6bW5uQVFuSWdTYTRJYVM1UVltdlU1ZmpYamZ6WUdV?=
 =?utf-8?B?L0VmSVRFQ2tTMTZjSjNWKy8vdlJ2am50ZGx3QVZsakZMTElKbXVoaE5Ld3F6?=
 =?utf-8?B?NDZhK2pna3hudkYzQ2JKSURYSElOOWtoa2RscEdmcWx0ajhOUk41alF6VmZB?=
 =?utf-8?B?K1MrTzRBcHgzMitmK2tCbWNxZzg5VW01enNYR1k4TlFvRHlDVVlyb1VpY0d5?=
 =?utf-8?B?RExSckM1QnUrREhWNTdIWGJ1L2pKVUphN2JIUzR5ZjRUdGdoZ01IL1ZIbkNi?=
 =?utf-8?B?VHg4MkxZZlE0a3loZllnR3k5L2I3ZHpSQmZJaTNjOUpsWW1LSE0vSzVVR3c1?=
 =?utf-8?B?NXFhRjJablc3L1JSTXBBRUNwV1Rla1JndWxoc1M2OFdGSTFUN0lRZy9kVmtM?=
 =?utf-8?B?Y3VHZVlMc0V0RktRZEkwTk9XZ3lEVnlhRkY4VCs5STBucHdpV0RBNllDcGw1?=
 =?utf-8?B?eU8vQ3UxMjE2M2dKT1VpSUtPTmtYUnhMZElFUG5tQ2Fzc2FKVThoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6477890f-0bc9-4d85-6a7b-08da182ed030
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 00:37:36.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0JdsSmizJ8owcZ1MenhknJdpTfGWQO06AtHihbUsw0fc989xiYM3xHIXfMyf5Xdqlf91jYTA9AwqFpsPas5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4631
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070001
X-Proofpoint-ORIG-GUID: tqvrBa1HWt6hSnfSooeMl2yPQYrhRNhU
X-Proofpoint-GUID: tqvrBa1HWt6hSnfSooeMl2yPQYrhRNhU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIEFwciA2LCAyMDIyLCBhdCA1OjE3IFBNLCBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIFdlZCwgMjAyMi0wNC0wNiBhdCAy
MDo1NSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBBcHIg
NiwgMjAyMiwgYXQgNDozNCBQTSwgVHJvbmQgTXlrbGVidXN0DQo+Pj4gPHRyb25kbXlAaGFtbWVy
c3BhY2UuY29tPiB3cm90ZToNCj4+PiANCj4+Pj4gT24gV2VkLCAyMDIyLTA0LTA2IGF0IDE0OjA4
IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+Pj4+IEZpeCBhIE5VTEwgZGVyZWYgY3Jhc2gg
dGhhdCBvY2N1cnMgd2hlbiBhbiBzdmNfcnFzdCBpcyBkZWZlcnJlZA0KPj4+Pj4gd2hpbGUgdGhl
IHN1bnJwYyB0cmFjaW5nIHN1YnN5c3RlbSBpcyBlbmFibGVkLiBzdmNfcmV2aXNpdCgpIHNldHMN
Cj4+Pj4+IGRyLT54cHJ0IHRvIE5VTEwsIHNvIGl0IGNhbid0IGJlIHJlbGllZCB1cG9uIGluIHRo
ZSB0cmFjZXBvaW50IHRvDQo+Pj4+PiBwcm92aWRlIHRoZSByZW1vdGUncyBhZGRyZXNzLg0KPj4+
Pj4gDQo+Pj4+PiBTaW5jZSBfX3NvY2thZGRyKCkgYW5kIGZyaWVuZHMgYXJlIG5vdCBhdmFpbGFi
bGUgYmVmb3JlIHY1LjE4LA0KPj4+Pj4gdGhpcw0KPj4+Pj4gaXMganVzdCBhIHBhcnRpYWwgcmV2
ZXJ0IG9mIGNvbW1pdCBlY2UyMDBkZGQ1NGIgKCJzdW5ycGM6IFNhdmUNCj4+Pj4+IHJlbW90ZSBw
cmVzZW50YXRpb24gYWRkcmVzcyBpbiBzdmNfeHBydCBmb3IgdHJhY2UgZXZlbnRzIikgaW4NCj4+
Pj4+IG9yZGVyDQo+Pj4+PiB0byBlbmFibGUgYmFja3BvcnRzIG9mIHRoZSBmaXguIEl0IGNhbiBi
ZSBjbGVhbmVkIHVwIGR1cmluZyBhDQo+Pj4+PiBmdXR1cmUgbWVyZ2Ugd2luZG93Lg0KPj4+Pj4g
DQo+Pj4+PiBGaXhlczogZWNlMjAwZGRkNTRiICgic3VucnBjOiBTYXZlIHJlbW90ZSBwcmVzZW50
YXRpb24gYWRkcmVzcyBpbg0KPj4+Pj4gc3ZjX3hwcnQgZm9yIHRyYWNlIGV2ZW50cyIpDQo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+
Pj4+IC0tLQ0KPj4+Pj4gIGluY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oIHwgICAgOSArKysr
Ky0tLS0NCj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPj4+Pj4gDQo+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvc3Vu
cnBjLmgNCj4+Pj4+IGIvaW5jbHVkZS90cmFjZS9ldmVudHMvc3VucnBjLmgNCj4+Pj4+IGluZGV4
IGFiOGFlMWY2YmE4NC4uNGFiYzJmZGRkM2I4IDEwMDY0NA0KPj4+Pj4gLS0tIGEvaW5jbHVkZS90
cmFjZS9ldmVudHMvc3VucnBjLmgNCj4+Pj4+ICsrKyBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3N1
bnJwYy5oDQo+Pj4+PiBAQCAtMjAxNywxOCArMjAxNywxOSBAQCBERUNMQVJFX0VWRU5UX0NMQVNT
KHN2Y19kZWZlcnJlZF9ldmVudCwNCj4+Pj4+ICAgICAgICAgVFBfU1RSVUNUX19lbnRyeSgNCj4+
Pj4+ICAgICAgICAgICAgICAgICBfX2ZpZWxkKGNvbnN0IHZvaWQgKiwgZHIpDQo+Pj4+PiAgICAg
ICAgICAgICAgICAgX19maWVsZCh1MzIsIHhpZCkNCj4+Pj4+IC0gICAgICAgICAgICAgICBfX3N0
cmluZyhhZGRyLCBkci0+eHBydC0+eHB0X3JlbW90ZWJ1ZikNCj4+Pj4+ICsgICAgICAgICAgICAg
ICBfX2R5bmFtaWNfYXJyYXkodTgsIGFkZHIsIGRyLT5hZGRybGVuKQ0KPj4+Pj4gICAgICAgICAp
LA0KPj4+Pj4gIA0KPj4+Pj4gICAgICAgICBUUF9mYXN0X2Fzc2lnbigNCj4+Pj4+ICAgICAgICAg
ICAgICAgICBfX2VudHJ5LT5kciA9IGRyOw0KPj4+Pj4gICAgICAgICAgICAgICAgIF9fZW50cnkt
PnhpZCA9IGJlMzJfdG9fY3B1KCooX19iZTMyICopKGRyLT5hcmdzICsNCj4+Pj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZHItDQo+Pj4+
Pj4geHBydF9obGVuPj4yKSkpOw0KPj4+Pj4gLSAgICAgICAgICAgICAgIF9fYXNzaWduX3N0cihh
ZGRyLCBkci0+eHBydC0+eHB0X3JlbW90ZWJ1Zik7DQo+Pj4+PiArICAgICAgICAgICAgICAgbWVt
Y3B5KF9fZ2V0X2R5bmFtaWNfYXJyYXkoYWRkciksICZkci0+YWRkciwgZHItDQo+Pj4+Pj4gYWRk
cmxlbik7DQo+Pj4+PiAgICAgICAgICksDQo+Pj4+PiAgDQo+Pj4+PiAtICAgICAgIFRQX3ByaW50
aygiYWRkcj0lcyBkcj0lcCB4aWQ9MHglMDh4IiwgX19nZXRfc3RyKGFkZHIpLA0KPj4+Pj4gX19l
bnRyeS0+ZHIsDQo+Pj4+PiAtICAgICAgICAgICAgICAgX19lbnRyeS0+eGlkKQ0KPj4+Pj4gKyAg
ICAgICBUUF9wcmludGsoImFkZHI9JXBJU3BjIGRyPSVwIHhpZD0weCUwOHgiLA0KPj4+Pj4gKyAg
ICAgICAgICAgICAgIChzdHJ1Y3Qgc29ja2FkZHIgKilfX2dldF9keW5hbWljX2FycmF5KGFkZHIp
LA0KPj4+Pj4gKyAgICAgICAgICAgICAgIF9fZW50cnktPmRyLCBfX2VudHJ5LT54aWQpDQo+Pj4+
PiAgKTsNCj4+Pj4+IA0KPj4+IA0KPj4+IEhhdmUgeW91IHRlc3RlZCB0aGlzPyBJIGZvdW5kIG15
c2VsZiBoaXR0aW5nIHRoZSB3YXJuaW5nDQo+Pj4gDQo+Pj4gImV2ZW50ICVzIGhhcyB1bnNhZmUg
ZGVyZWZlcmVuY2Ugb2YgYXJndW1lbnQgJWQiDQo+Pj4gDQo+Pj4gaW4gdGVzdF9ldmVudF9wcmlu
dGsoKSB3aGVuIEkgdHJpZWQgdG8gdXNlIHNvbWV0aGluZyBzaW1pbGFyIGZvcg0KPj4+IHRoZQ0K
Pj4+IE5GUyBjb2RlLg0KPj4gDQo+PiBUaGUgd2FybmluZyBpcyBmaXhlZCBieSBjNmNlZDIyOTk3
YWQgKCJ0cmFjaW5nOiBVcGRhdGUgcHJpbnQNCj4+IGZtdCBjaGVjayB0byBoYW5kbGUgbmV3IF9f
Z2V0X3NvY2thZGRyKCkgbWFjcm8iKS4gSSB0aGluaw0KPj4gdGhpcyBtZWFucyB0aGF0IGFsb25n
IHdpdGggdGhlIGFib3ZlIHBhdGNoLCBjNmNlZDIyOTk3YWQgd2lsbA0KPj4gbmVlZCB0byBiZSBi
YWNrcG9ydGVkIHRvIHNvbWUgcmVjZW50IHN0YWJsZSBrZXJuZWxzLg0KPj4gDQo+PiBJZiB5b3Un
cmUgYWRkaW5nIGR5bmFtaWNhbGx5LXNpemVkIHNvY2thZGRyIGZpZWxkcyBpbiB0cmFjZQ0KPj4g
cmVjb3JkcywgSSBpbnZpdGUgeW91IHRvIGNvbnNpZGVyIF9fc29ja2FkZHIvX19nZXRfc29ja2Fk
ZHIoKSwNCj4+IGFkZGVkIGluIHY1LjE4Lg0KPj4gDQo+IA0KPiBJbnRlcmVzdGluZy4uLiBJIGhh
ZG4ndCBzZWVuIHRoYXQgY2hhbmdlLiBJdCBsb29rcyBob3dldmVyIGFzIGlmIHRoYXQNCj4gaXMg
ZXhwbGljaXRseSBjaGVja2luZyBmb3IgdGhlIF9fZ2V0X3NvY2thZGRyKCkgc3RyaW5nLCBzbyB5
b3UnZCBoYXZlDQo+IHRvIGNvbnZlcnQgdGhpcyBwYXRjaC4NCg0KV2VsbOKApiB2MSBvZiB0aGlz
IHBhdGNoIC9kaWQvIHVzZSBfX2dldF9zb2NrYWRkcigpLiBJIHRob3VnaHQgSSBjb3VsZCBjb25z
dHJ1Y3QgYSBiYWNrLXBvcnRhYmxlIHZlcnNpb24gb2YgdGhlIHBhdGNoIHRoYXQgd291bGQgbm90
IG5lZWQgX19nZXRfc29ja2FkZHIoKSBiZWNhdXNlIGl04oCZcyBub3QgYXZhaWxhYmxlIGluIC1z
dGFibGUga2VybmVscy4NCg0KSXQgc291bmRzIGxpa2UgdGhlIG9ubHkgY2hvaWNlIGZvciBmaXhp
bmcgdGhpcyBpc3N1ZSBpbiAtc3RhYmxlIGtlcm5lbHMgaXMgdG8gcmVtb3ZlIHRoZSBhZGRyIGZp
ZWxkIGZyb20gdGhlc2UgdHJhY2Vwb2ludHMgZW50aXJlbHk/
