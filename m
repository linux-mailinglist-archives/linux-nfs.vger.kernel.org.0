Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07667E8260
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 20:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbjKJTSe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 14:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjKJTSX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 14:18:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CD147C6
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 11:02:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHjLaA020957;
        Fri, 10 Nov 2023 19:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fqbzpqcL5qTHhaOK3KQx1fb+rFNOzkLD38wp9LxjhJ4=;
 b=c7zz+9ccAi/1fE/F8SeotYKW2nQINXVcKPWU7y0V5O634680lAj5YoNJdya5NzXAnlhm
 SxwUae28ZmYwteORpZ8jnTYQzNztk9H2x7S9MBd32Kn0bTuzua6iJp8Sg106ASOXLsho
 eAWL3vARlcA+V3VIZtk03q498HO3LQiS80l5c18vhVloCXRiMWJHC93H4njzpNWtX+Md
 AKIp5DoLRGREOfGtGZQGnSsNbhxl2E4FrkHQ3symyuEBkp9nyzXFbDKzbDUQWYv3jq93
 ezqPRCOratkf15xLBMl7fy7nfbdHiqcXhLJQgx7DKWGbgxV6kxoxpi3aYD2UTmhabQjC Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w236sp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:02:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAI2vwM010967;
        Fri, 10 Nov 2023 19:02:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1y7c1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:02:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVjaQpmjU+sgeOvVAYYAAzmFWHs6Obll3HtH228DiWwrkA92kYTU1gwN7HWcJ0J5JetjnAvtgOh/Djoh/skDXpZhOLI1Jg6WjaTI+mW+wfO8QepHB3JnBzHD8fHv0Pop5xx0sZeSRUneWPEOvvGivF0LY4As22GU5uZyO4O1gJgjj/c44qF+Fq5uruaQuDBLLwE3IUVxZQySHNKnJmeuBXarpNFEkC+6A+wu4rNCz4CrLfW8wCeEBMpsWO1QTO2GRYj3O+c7j/QdAelbU1HSxtbKL9wu/OSj1olxXJXSYsiHrHcmWN9Oe4QrhmH33QgWxSpv4cX8i1Int4Nyq/3Z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqbzpqcL5qTHhaOK3KQx1fb+rFNOzkLD38wp9LxjhJ4=;
 b=nghTWYe9ZNWyKtExDyd+/+MDPmk7xwVKvBH1LqtEz4Gdnao8GWuqQDmu/I92IJNlT6TCHxBWNjV3yliXKPEIng6g6CDVxrXJGzadKavVGgwge8tNkgwlccLM1XXhKRHUyVqIj/8Heo52q7fKbozJ1q8EDf9I+mOb54DoSHWTRJL1GMPpBpUlyunJffIckDk/KIHzLLE7Aj4L1EgXfqpu1TbtbuYdCL1cUIg5AojxSO3n1CzVdMBsqgTQMNE0ez4AbWEGEgz2x52KTS0gRhFii1isI7zgRRYl2XvDqSf7I+/VgkTfIaVHB2kBI+qszjfsmMB2GbpnkjBf4u7jSoHGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqbzpqcL5qTHhaOK3KQx1fb+rFNOzkLD38wp9LxjhJ4=;
 b=A+nFnOMM4OFoL/8Zq9oGdgVojoOSNpjZrn7GN8Wh6A8uBh3ZEw/wPDMkUatTgFaJtj3fhhlLPoQYvtQJn74I31s/bYeLIgTUJ1kbJ0WUY1qfnnnNAa/mwgYqXokiCCXBG2qb33Fw0DeSzdmL0TLRJoRkRSmrWJ3AoQJBMYiB11g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 19:02:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 19:02:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Martin Wege <martin.l.wege@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Topic: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
Thread-Index: AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gCAAG3rAIAAxrOA
Date:   Fri, 10 Nov 2023 19:02:22 +0000
Message-ID: <90A9F855-A6E9-4459-81BF-AAC17ED9835D@oracle.com>
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CANH4o6M9jvVsq1jtGcfVd+BN=Mb9yZ+SxqGeb0wzkFVu+8U9bw@mail.gmail.com>
In-Reply-To: <CANH4o6M9jvVsq1jtGcfVd+BN=Mb9yZ+SxqGeb0wzkFVu+8U9bw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6371:EE_
x-ms-office365-filtering-correlation-id: ea7deeb4-e1ba-4de0-3979-08dbe21f9200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUv/jsvsr5phXsF/Enc2wbPMVBFvO12HKKzcPZ8QgIGLbyQILFHyD+43mM6X7749d8XtFr9rmDgn4d1JMOOa77jREhYTEN0puFOvFP7XhkBsKXycLpA69TL2ZlbClqWkQbA5EZqyZsnUVP2GZk/f31jUh7zgPlGfeqbNGk2WQvRlWVHyM74KaUz9Yw5jEz4QQ0r1cdEIEZ7Z0dseuf8Zlptzc7p/aCjl+oBhggiJ1qG97rY5Gx9r6xlCxqw8z65VOABtynY9ZAnCEa9V7kP7W7AeJ2aSpKXU2rcbkCjbxNblnmZhHMKnpKf5h/GRR/7T0TFzo6IIObm2PFJZJ2GVpxggqSR0i8mdYx2xYRr0c1/Nv1qUNANHuv+iq1hRjW+1dE7gY7le0gsQN8yokJxXp1P1JbFoNlJcC5rBvdbZLTi0Isk/Jm0/xeQPTCRAnsaT13jLxz3gvh4WycRJ9Tk//9HHQhbWSaznZEAZ2Sodcd6sSo2iqS2FEl8d4q8quPtk/OuemDRX6vMxVoBq+jnPegK8uyw/G28aGJjaGdJ0xtUheSJ4/U/U9yR6CmOwJWxUHaN5RvOGMjeCrw7DqYVvKLW+kEwwhh+B/vihaztmfghUga4mbX9VUM00Wik9DzglGtkRjRitS9FCi2LEFq7PEy7CylZZded9bnOxNfyTTV97rbvF7sHlC/En6riVzuIRLBQeA2ZXq0Zc3+3M5gbgRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(66946007)(478600001)(6486002)(36756003)(6916009)(91956017)(64756008)(26005)(6512007)(66556008)(6506007)(2616005)(8936002)(76116006)(41300700001)(66446008)(5660300002)(66476007)(8676002)(2906002)(4326008)(71200400001)(53546011)(33656002)(38100700002)(86362001)(38070700009)(122000001)(83380400001)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHBPdVRMRWRYaktwWm51bVlhbnN6R004RjBVSjNJNzRQc2dMVlhyTFp2Zi81?=
 =?utf-8?B?VFlCaVN0TENiRjlzeDZKVEhPaWRhaWtmcTlpVDlHemxlZU9zMUZValFHdGNN?=
 =?utf-8?B?VUdpUG45amJtd3BCd2Y5TVJpenl6TlZ3M2JVNTMvWFh3SXhtbVNoMkpSd3ZB?=
 =?utf-8?B?K0VNM3lmZ1dQZTdlajFBbTBnd0V0cS9kaVJrVUF2UDlsREt3S2lQVnEyaEg5?=
 =?utf-8?B?ZTNzZUVielhmMFdQWnRaMy9KeEw5cXZXZFhISVdaL084ZjIyd24yWGl1QzBx?=
 =?utf-8?B?eWhqZjU2U281WTVkOXRScWtUZEVBV2JSZnp0aTkrVUZ3bERKMmZZTlUzOERO?=
 =?utf-8?B?aGNCT3ZaaGhXbGVhaGNqd0FaQ2g4R2twcm0yTi85ekRNSnVoUGh5ZVdUWkMy?=
 =?utf-8?B?bk1aM25sbGlhNVdxNjF3ejBtV1NqOHFmRjl0MklwUlUwVHl3b2RqR2JOQ0dD?=
 =?utf-8?B?a1F3M3pMMXBjbDFweTN0UGdHbUdUVWxJNTMyemRhRWZCUUcrTTY1eGlISXFB?=
 =?utf-8?B?Sndlb2VmZjR5TzBTU3FxT24rTWVhWFBoOTVOUURRWUxtTnEyY1ZoQ0ttSlJ6?=
 =?utf-8?B?dGpCQ1ovWlJLS2lhOC9IenZHekh3S3RSTmhVeEEvMlVUVS9nVXhWYS92TUFt?=
 =?utf-8?B?QlBST29KSFZKeW1WWGRwbE16eUtwQmRNdUVocDFOMGt1eGJ4YTV0R3hSTXU1?=
 =?utf-8?B?akE4UTJTL21WVFJwbEU4Ni9hZHNKNDNMVnp0bW90OXNZNTFaQm9YbmVDbjB2?=
 =?utf-8?B?TDZ6TkgwdFZnTG9icEphUWRremgxbStJR3c5ZElFT0p1anVEbGJyVndsQ1Br?=
 =?utf-8?B?T3NHRkRhVnQxdmhidGp4WjJhd2EwQS9lV2tOR3NoeDhSSDNkZDg4Z2Q0clJP?=
 =?utf-8?B?SlhoYjM0ZW9Ka1IyYXJLQnB2cnBEanFKK3p0aTdtaVFBRHVKaFhQMHlUdnJo?=
 =?utf-8?B?cktHeTBZaWxVK3hYaEJhWVg1RGpBWHFmSStwK0tTTXpzQkZZRkdwdDhnTmVa?=
 =?utf-8?B?cFhabjlNekEyN2x4MXl6bGNQZDFXakRoK0xwV2MyRVBCaDh0cnRVYTlvSjhs?=
 =?utf-8?B?djdSS2FtZy9LTHB6bUpzZ1l4aGdhbjBqa0dPdlFDN2ttUnpSYkdSV1NqYjJr?=
 =?utf-8?B?a2VEOVp5eTZtWW03d2thNVR1UDlsekNBd3grNStuK1dpYkRUeWV0a2RoRXNs?=
 =?utf-8?B?V00yT2dCOE5kWG5WN3N5UENyaHdabGJOL2RsSkkySUt4MzBtSGVtNFpYU0NZ?=
 =?utf-8?B?S0lJcUxIMWZaRGpWbUZOa1A2LzFYcVU2VkZLMDliMTVWZEtsWWY0NWUvbDEw?=
 =?utf-8?B?cFBuNmtqVkk5OXIyZno4RlNnWVljckZyYTg3eVpabHVEbzF1akV0Y2NhcXBh?=
 =?utf-8?B?K3FjTC9JaXc2dTFwaXU5bk1GZGpIOGQ4Y0JZUGhoOVJTeHNzWXc2UmlZUG92?=
 =?utf-8?B?ZTk0NUFCTWRLZUh6U3IwWjZscWkvSFRNUDJSYlVsek1rYmdBakk5L3p0dkNo?=
 =?utf-8?B?K2RzQ2pLdnVOSGxUT0ZzbDFTOUloQkZBZUVyRDJRZEZLUk5jOWJubG4xRzNu?=
 =?utf-8?B?WFk5blRRQ2lHRFBTUGNHb2txejFhV0dIVHJ1WUFCNmFnWmpYUFNyUDBQREli?=
 =?utf-8?B?RGlXYk1GWHMzY2NpUTh6bnM3cjBFa0hCU3VIaTlSYXo3Mm5jZTR4MGJxMzla?=
 =?utf-8?B?czQxcVltY09henZlUmsxK1pDSi9sYWlzdlVKaWl4a2x4QmRHY21xaW4xTDBq?=
 =?utf-8?B?YUpFcTQrOVUydWZNUzRHUGV5aWlMTDlBTkw2Q3VyTm90UjlJZDhaaTgxbVNl?=
 =?utf-8?B?WXJTRmtGRnlPRzNrSVFTVU5MWjNSdElwWlhmTnJCQXNwVjByTHhoOHNLTERB?=
 =?utf-8?B?Ty8rWHBNc0hIQW5HRm9mTTlVUjRZcklucjlEZW9ra3I0VWJQTjhDUkMrcmRQ?=
 =?utf-8?B?cFNuNWh0UkU4bVBzclE2dm1XWU1Hell6dDhwdFh3dmdTQnU3M3ZCZytZQnM3?=
 =?utf-8?B?OW9Ob21NdktMWXJ2aXRDekdVZTAzM0ZLZlhnQU1Bb2JnQ1ExNHZRU29CL3Fu?=
 =?utf-8?B?bnJSbnZNUnNMdTU4bm9DQzVZK2I4MTZJNDh5WjJlQkFMb1R2ZVF4U3NJWWFZ?=
 =?utf-8?B?YmN2ZWkveGIzQlU5Z1JMSklQbEVhaDZEaEtxbXdTY3F5dC9Taml3OHhqWmJC?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B306AB3413922E4594F80C65E016408B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YP3oiHu/1peYg++/7rUIb0JL7pOZzlY+UbF3E/zz+OeaOCgwz4ThGeNNGdlrY5ML/5BqQkGsLCenrgNnpY0e8Aa+oPNGrCdg/zYqAX/9B6rZ1UiNeCrwMKEum4tcNnFACM3d5DdDfQUe3u1dVSfdzOChk9ZjyoIUx8FF3yrLPxwJ43gC7RSDw9YZD6QZBUrkWLV6YCroC7SBPbxtLIn4Gh/FLBQEwTVPn7tfC3cn6sl8FCURUAghPS4ChtRa+qA0VYVBexvwkhMe/zCIUGxQO6eGhPFOaK/GpdaHawFvIto+jqfl1EkPfhC1w/CYc7HxdMV8g+VRAHAT9bpXAQaceB1VJXem/n3bMUMn4guh1okEmTYg7aNc06s311jsWxND0LFuy6L0tlC/BhRqoWIflIHXplGOwaa1N/9bJrqGrq8tN7b2za/3eSCqoPyoyNKh5xGqdV5WJ8TYSQ5CY/iwShTjYqHqMu8Xfq0EbjlUjNUpVrjrljUEiQQ/rO8ZsGxLCBOGeR4ublyvWeXjYyOuR5r9DTA0ywAljkrr5DoXpV6gPbhi1OIeEts++lG9HM2csKVrCwvtTM9RmyMaDSimwSoRuz2taSRDXIhZXaoGUTvjAmYIa5WcMX0tvc8fxz3VdmndcYyhqEbblvpOthFGGwU+tpMQ4mibwnE5u4HCwxwT3b+pmEeypx7ELSYuV41ZLtrKhe12YkNnFjFxq/IVNLhSCkiEcjXaRwl3l6hI/ThvjcSN+e5gWaXor+tx89VKdss0iRKUrM9pI1psrZqIKjbtdZ3GL5ADGzDPeL8IFqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7deeb4-e1ba-4de0-3979-08dbe21f9200
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:02:22.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQMadFVIoZHB2dmp68E4tKjKFjPBahxGiblcf/y9PzD9vy7PxyVfS3xFEnF3kNpSK/8rMVdD/v5Kkh9+bygyYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_16,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100159
X-Proofpoint-GUID: p6r4WU39ZKHibA966ZDA6rvZlTWcbkdJ
X-Proofpoint-ORIG-GUID: p6r4WU39ZKHibA966ZDA6rvZlTWcbkdJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDEwLCAyMDIzLCBhdCAyOjExIEFNLCBNYXJ0aW4gV2VnZSA8bWFydGluLmwu
d2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBOb3YgMTAsIDIwMjMgYXQgMToz
N+KAr0FNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+
PiANCj4+PiBPbiBOb3YgOSwgMjAyMywgYXQgNzowNSBQTSwgQ2VkcmljIEJsYW5jaGVyIDxjZWRy
aWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUaHUsIDIgTm92IDIw
MjMgYXQgMTA6NTEsIENlZHJpYyBCbGFuY2hlciA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4g
d3JvdGU6DQo+Pj4+IA0KPj4+PiBHb29kIG1vcm5pbmchDQo+Pj4+IA0KPj4+PiBEb2VzIGFueW9u
ZSBoYXZlIGV4YW1wbGVzIG9mIGhvdyB0byB1c2UgdGhlIHJlZmVyPSBvcHRpb24gaW4gL2V0Yy9l
eHBvcnRzPw0KPj4+IA0KPj4+IFNob3J0IGFuc3dlcjoNCj4+PiBUbyByZWRpcmVjdCBhbiBORlMg
bW91bnQgZnJvbSBsb2NhbCBtYWNoaW5lIC9yZWYvYmFndWV0dGUgdG8NCj4+PiAvZXhwb3J0L2hv
bWUvYmFndWV0dGUgb24gaG9zdCAxMzQuNDkuMjIuMTExIGFkZCB0aGlzIHRvIExpbnV4DQo+Pj4g
L2V0Yy9leHBvcnRzOg0KPj4+IA0KPj4+IC9yZWYgKihub19yb290X3NxdWFzaCxyZWZlcj0vZXhw
b3J0L2hvbWVAMTM0LjQ5LjIyLjExMSkNCj4+PiANCj4+PiBUaGlzIGlzIGJhc2ljYWxseSBhbiBl
eHBvcnRzKDUpIG1hbnBhZ2UgYnVnLCB3aGljaCBkb2VzIG5vdCBwcm92aWRlDQo+Pj4gQU5ZIGV4
YW1wbGVzLg0KPj4gDQo+PiBUaGF0J3MgYmVjYXVzZSBzZXR0aW5nIHVwIGEgcmVmZXJyYWwgdGhp
cyB3YXkgaXMgZGVwcmVjYXRlZC4NCj4gDQo+IFRoZW4gaXRzIHRpbWUgdG8gdW4tZGVwcmVjaWF0
ZSBpdC4NCg0KTm90ICJkZXByZWNpYXRlIi4gVGhlIHRlcm0gaXMgZGVwcmVjYXRlLg0KDQoNCj4g
V2UncmUgYWN0aXZlbHkgdXNpbmcgaXQsIGZvciBmb3VyDQo+IHNpdGVzIHdpdGggMjAwMCsgYWN0
aXZlIGFjY291bnRzIGVhY2guDQoNCllvdXIgYWRtaW5zIGFyZSB1c2luZyB0aGUgcmVmZXJyYWwg
Y2FwYWJpbGl0eSBpbiB0aGUga2VybmVsLiBUaGUNCiJyZWZlcj0iIGV4cG9ydCBvcHRpb24gaXMg
aXRzIGN1cnJlbnQgYWRtaW5pc3RyYXRpdmUgaW50ZXJmYWNlLg0KV2UgYXJlIHJlcGxhY2luZyB0
aGF0IGludGVyZmFjZSwgbm90IHRoZSByZWZlcnJhbCBjYXBhYmlsaXR5DQppdHNlbGYuDQoNCg0K
Pj4gVGhlIHByZWZlcnJlZCB3YXkgdG8gZG8gaXQgaXMgdG8gdXNlIG5mc3JlZig4KS4NCj4gDQo+
IHdoaWNoIC1hIG5mc3JlZg0KPiBGaWxlIG5vdCBmb3VuZC4NCj4gDQo+IFRoaXMgaXMgb24gRGVi
aWFuIFNJRC4gU2FtZSBvbiBTdXNlLiBTYW1lIG9uIE1hbmRyaXZhLg0KDQpUaGVuIHRoZSByaWdo
dCB3YXkgZm9yd2FyZCBpcyB0byBnZXQgdGhlbSB0byBwYWNrYWdlIGl0Lg0KDQpJZiB0aGV5IGhh
dmUgY29uY2VybnMgYWJvdXQgaXQsIHBsZWFzZSBmb3J3YXJkIHRoZW0gdG8gdXMuDQoNCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K
