Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82406F1C78
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 18:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjD1QTD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346100AbjD1QS6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 12:18:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883655B94;
        Fri, 28 Apr 2023 09:18:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SF3vRW001601;
        Fri, 28 Apr 2023 16:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=G/TNcI3kP6jZAMrP+wjvnY1ZPKISoImxJZe0RZy8n7M=;
 b=VbcgB/XGliKY3H0Qboo+CvrIBSZ4IT3SZnu1hv+YBf59I4HJ1xm/jUM4AqIrMXpFzUEj
 T245dsuqBJm94crXtbgTSosThBP8uhoxujvLUtb/gz7pCScjwjZGLvvcwr5R2Nt4yuRi
 pjq8cnE5bKIeYLUOeRsKNCxNj3T2PbfnTeJ8/GoVSQ0dJIXsRJa8oZP43NWPZqI7Sd0n
 8kije1Fc2aQUtmgGh7W93U/7ZYjBslQeBiKkGR5Gr8zREsMD3f44jXNCyfeqWQe0IgW1
 /FSQ2MUBUYZUjJsQ3uXA28+lkErjjcqwTc8XcxXljL5dlBvMY/lpw6xnsPIupf2CAuW6 aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47md6v05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 16:18:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SFp5St014246;
        Fri, 28 Apr 2023 16:18:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461ay3f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 16:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSdMbIEFYL7bAWz+C0FezZIBRYndEp3ozWEq6nUxL/wusmWnsbM8jAO8E+xW35nogdI/dwVc1sHe8SKTBosHLOkCBP5Fpw3gWsJbBMmOacQUCuqpjafiYElPAX195B/w0w1o5nLexrewxBXGCs8hM0FzIu0/RLGg0PWwJuDjckQJYDXEM9serH0ec+qogYTEvCgTgLuYf3X+gUa3ZJD+Z0gjLiTzoBGyy9eBecB9/pl+Cr9uCw/SmlXTkKZx31e07/7IVmO2Q5CRxuFrQFTZhXNOsIHhO+8bXdszYoZz8/cFCaf20zZnLUt1/ZuESQ0zjPu+pi4LaDXV5VVcs4exTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/TNcI3kP6jZAMrP+wjvnY1ZPKISoImxJZe0RZy8n7M=;
 b=FBgbWqhELcOU/4CMu0odt3txQTW6HDAIxGoR9zPKR+bovpZdFxmTTVdqeeb/kLPI4Zw6sTHZ0Gc25ew5GzmAlSZ6Z7ByuVGzP6ovObKqKA9CeWq/S1b097gVcsrS60mH5Mqpmv9JDCuktmwOcYVPfTCcmoTHnYAuhc49a0lCZYvZI+NMRqafOw0kpocyz7lSnsQD/d0hZ6ymGb+Zb3fbQAiiXHeYgnHfSl392deA7817L/I+eUP5hQspZqh2lXb33V0oNO3JZE4J+dc6Y9FVBpWg93ygG+osulA6mrMQZUcSNmYYkE2/2q6OEAEWME5JT1qmL1iseyH+OwfO6iMxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/TNcI3kP6jZAMrP+wjvnY1ZPKISoImxJZe0RZy8n7M=;
 b=eOv9Q1VE+XYktiBfX0pq8VAsR1srrgqLfcXAFLdm8gHx6O/1pE2M+mUjI6baPFbkiVmIQ/TOwsEA4BuBbrlesXdI9aOr5QdafFWGxXdZxtQLZaamlJrW6XbxTI4TKgYWvVtFXRNB01M9vl2uV3i37tnUqOl3tvU2TZLT1dwZeT0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 16:18:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 16:18:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        David Howells <dhowells@redhat.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Mayhew <smayhew@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
Thread-Topic: RPCSEC GSS krb5 KUnit test fails on arm64 with h/w accelerated
 ciphers enabled
Thread-Index: AQHZcwlyVC5Tj4/bTUCg0bPZoyBbT69Ahe0AgAADmoCAADLHAIAANVOAgAACVIA=
Date:   Fri, 28 Apr 2023 16:18:17 +0000
Message-ID: <870429E7-8202-405B-96F7-46A11B41EF05@oracle.com>
References: <ZEBi8ReG9LKLcmW3@aion.usersys.redhat.com>
 <ZEuVcizjPtG96/ST@gondor.apana.org.au>
 <CAMj1kXGOxw2mm8dVNHBg3HfJ7==JVV+vdXaW3iGGKamb4ZAg-g@mail.gmail.com>
 <F46EA3E0-1338-4E92-8CCF-DD869BD573BE@oracle.com>
 <CAMj1kXE29dMSgjkDPUXf0LFnxyrMeSO5NxG8fjYCuG=HJJ7wiA@mail.gmail.com>
In-Reply-To: <CAMj1kXE29dMSgjkDPUXf0LFnxyrMeSO5NxG8fjYCuG=HJJ7wiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7241:EE_
x-ms-office365-filtering-correlation-id: 646adbc5-3baa-444b-d53f-08db48042cf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlrLhDyTjaUannF8pyhgLONp/CWSWMg9We+K9FWSIDIKSW+1lGSGh9nzqPTyGlzDYMozAu5sZGuesaytggq13dUhnekUUw8aAM+/jbzrY/uKCkvm5trlyxK7tNTgkTyCyYc9eNo3+molPjTx0pALFhhzlV8XO0E2/C7+/aCSBh3MLNIvsGAENl3DY9JO0qA934ACafg+A2gmdKofRSVUHcTRoC2ZJYdRpA5Hei6g8uLLerEIhClc0ZsoXz+tdDfOQ6nMNYeki1ngb67/f79ZltYGdX1QbQ7/60WeaDVaWNn0siv8RBzrFCisUv1yp7PiYVHUQlM7vmndc4inJNr5Vzgo79AXBnJMpjCDySn+VfM3TQcCwGcz1tk/5gEd71SyMV8RLXtL5ubCQ00aaa08mfnp/CONvBGVbEG3U1AiMvknM4U1+/b3yA3rTgu/WTjMDB0EcPymILeBRD46PMkbFWtyZ1aJ1BNhoXDdfLIf0Bj1qzl0sjDtR1UyPLe9L/e7yUuqe4hUQal2jkKY9mAXzyO8F6JR50lIRxboB57T51+QZNMkTEFbRl6C+8Jhh2vAm5NReVLkReDake+gffPPigp/PQptQbDZBdkl6qxB7PWyt667t/lmckb6JdO5fT0hf1UBgT7t8ytEk2nTgsGN/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(66476007)(66556008)(66946007)(76116006)(91956017)(66446008)(64756008)(71200400001)(6486002)(33656002)(2906002)(26005)(6506007)(53546011)(6512007)(41300700001)(186003)(4326008)(36756003)(122000001)(5660300002)(38070700005)(8676002)(8936002)(86362001)(38100700002)(2616005)(54906003)(83380400001)(478600001)(316002)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?onyvRNudZaVJCYVCRicPb6zbhFIRsD7KpFRKNGKOzqHjKQ+tUNClNRt2ctY/?=
 =?us-ascii?Q?+giIWrk4D2tDU6Ck6mplFOjcZXeJrKNCq8W5eLs5CzWuFKfpOrlFqpEbl2cu?=
 =?us-ascii?Q?9xDreiC/fIQrGapM8nR6VMl1OOf95S+acn3gMayO0emc4+504VimS4UNSbnW?=
 =?us-ascii?Q?s5ZjbhNCzj5snBkPbMRVg16/a+LSZL9mHlbwCmX4K+h9j3cuaJ2gt1IRBdN5?=
 =?us-ascii?Q?lJjHmVTldOZmJ198WN85SnJIAI+SewivoZONJEZgMBAk6HnIlSG7ymndhMHe?=
 =?us-ascii?Q?LML6pqTRItIC0COioHNskoytvj0bJD6t0DkVBLk8FSM0F+BSAsvFMFeeNZk5?=
 =?us-ascii?Q?1fZdPE3qVYbj+5CKYB100wp5V6avA0ODu8LW2bqcafWDwDBy38rPZaeTTU8h?=
 =?us-ascii?Q?Aw4Ujbz7sGJXusY7iUakBBIWjv+PRRkibJX2K+4MADM6PEi8tfIOJPsG2ASk?=
 =?us-ascii?Q?U/fxT1sI8KMiQ5R4RYRez/wFNpWb+CGuftsrkonzFQU83WHp6aiqocm1pste?=
 =?us-ascii?Q?ZMk6ktLUk0TTUQCWjM+kC7gaucwitGDUsqAGGfuG3Kqt8OT4v07VKZVGDMJs?=
 =?us-ascii?Q?q9H7eAkSmaIFOtzkcX4KkQedAzKlYHT3J3bgzM/Z4B/W1JQ2N07yYo2cSuKA?=
 =?us-ascii?Q?l6ObLKdxWKr3omP5u9l5v5MhSqOs/x8oN7nKPsruvO5BoV1BhcqQxbXKOZM1?=
 =?us-ascii?Q?UxmVT7iSPsc5i+dYcf95V/TDvUChl7ndyEcDRcURrdEpgPc/Ot6vKp5nWbbH?=
 =?us-ascii?Q?vOW5ByuI3qJXq53HaHXCFtlz9xKX1GGSMqc18brhC+UeXtAZmVY5lR1jilYg?=
 =?us-ascii?Q?g4WJ3br/GTcI/Fh+SJBvZxlZXAFNpZLwBxSxY9dr+S60VlAEdTf/4d2zbnF6?=
 =?us-ascii?Q?1ITl0982Ydg8QglWfYk/ZzoA6bD0GhSB2ZPmoIozi7egdSfg2Muu16aIQD0L?=
 =?us-ascii?Q?A7bSoiJsXW+HYnHUui0j9SzdtA5msM2yvH36YJ+ZghhEtjAXjOADxyKYe0WD?=
 =?us-ascii?Q?rrU/8arv7v2+S5Gfe3GeMp9xrtOQ3C9fe/uwV0FiHlspSmFNYEPMqIT25HuH?=
 =?us-ascii?Q?A/JvuomCO9O+XgtGxDE0QEZmQIRvlCRxFHsrekMXg0Ly20iO01pYmcMpVNlf?=
 =?us-ascii?Q?dEc3jO7qYG1U7LqFUY27rCHmIX3jBB8kw+F9sFo8hQZXvmzL9F7/ZOw2Zqsz?=
 =?us-ascii?Q?4GX2gBnHnKBc6H6FQNOMXi4YxBnZUxLnbc9rnNFDXCAeFkdITteYGM1Tb8hJ?=
 =?us-ascii?Q?DwrCIMucYZdokPIggdNWQ/hiU+3sX81KB9/jK8i5T/gSVyDsUWN+0ioqpqer?=
 =?us-ascii?Q?6++2/LeUUdDgkZ+fF24tZFhbPqFHwrspweB5dshvtITBeiZwZZccy+Em6t0r?=
 =?us-ascii?Q?TJXP1JXx6boxpoqLM+AXWSL8K6x4levENWgBuws2xmZ/fjxYRxI0r1s9PJfs?=
 =?us-ascii?Q?V6dOf5BoY0xx0Hs8YOH76w0A1oNcfy0eo69AItWoa+0glBELxInbwncJDbwt?=
 =?us-ascii?Q?F36i9VPy58tq7/w5nZqYYw+pRb0GqaTKyZMwe2eyJBzALrg3ZTpLnAcvM1ip?=
 =?us-ascii?Q?LZeRXQoR+NkmUPY01/LMb67qPpmQmEcTw9PCGgCTBUk9lyW8CjH5GGg0fbzZ?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0728A39148C738499920AE5F2225C44F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1lukRPXP3BGkp7cMIp5aAbn8dggJEwSQhvQnt52sIt5ksskHwS8DGzw1M8/D+xvhIkThWHYgEp/a8vM52o5WIOvgIUgpu+MhgL4TlNtst9hOBiUDHMHQyvX1cMtkEDz8pHSjY7ilqYvgrtujOUCCO8eqom7D33RKR0xT93lXTqqOMKVwjrgYEsJsULZ70uBRMFjpMiarxzjiMSoVIcx1tKnIvLv3oTQR3DGOepebUFFxQgkvwxur216C4BWHdNyeVj/EL/b/llx66huMeh7exNSjV197KxgE4i/cBIhK7jPuzv0VDJxE+s4scXuewlwAS2JQmZlze1k4YWl18hBHumFIOsPJ5aPk/Xhd0xTz59xs3o5piTFriFZ8oSZbxqAGhAkB7iymDhuqf+pQS5zjywR8L8vKmMirgotq4ULb4NHvyBMzOvzDyERC0SZxEvaYBT8PL99k9hUVuHumLZYGNHvYG1nNxjnEDeBdiiKnp2HAJuP1g+JEHdOlZlGRiRagwqmiJFmi7T9K0Gapmtw79mssMjDvYZRGZvr+E4sx8CSe8Y+5Pv1UhL8jjohuFH//r6cyokjxo+u4OW5jaM3cqpSI9oWNm4ziiNLOnEq5kvNhBWMjpy1jgUbqDYF5FcQQHHniPrR36eSOuHKo/cH9sScjYyGu/ixxT5oRwH5AvOacq0AFZH99NOTcsnozkxj59dFvsEGgyqvWNmEDN2St7VBL9Wv97fGals28F0WgeiecRj/+1BBaVMyHODlU/qh0SW/7ClYhwecO+RBnINTHMP/D2rYdkZ9nEW9yit0SZ79smJduIe97u2Xmpp8Xj2j5GAflcrHqNrhzQ1CfUH4kqsrdibDrLzhrQyfxAcvyHWUYIer2gWzmCJ+eC8Q7eQYR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646adbc5-3baa-444b-d53f-08db48042cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 16:18:17.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoJjOhPZx+PeJUIDJqKWmcXWqRCqgnXy7jVMFKDjkke9JUaEo1Y9Iy3xxQG4/t/r6CZHbMmF0kBHF44G1OMO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280132
X-Proofpoint-GUID: Oi8BAL7yGozj4ASAR11bjHwXLFV4NDic
X-Proofpoint-ORIG-GUID: Oi8BAL7yGozj4ASAR11bjHwXLFV4NDic
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 28, 2023, at 12:09 PM, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Fri, 28 Apr 2023 at 13:59, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>=20
>>=20
>>=20
>>> On Apr 28, 2023, at 5:57 AM, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>=20
>>> On Fri, 28 Apr 2023 at 10:44, Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>>>>=20
>>>> Scott Mayhew <smayhew@redhat.com> wrote:
>>>>>=20
>>>>> diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-mo=
des.S
>>>>> index 0e834a2c062c..477605fad76b 100644
>>>>> --- a/arch/arm64/crypto/aes-modes.S
>>>>> +++ b/arch/arm64/crypto/aes-modes.S
>>>>> @@ -268,6 +268,7 @@ AES_FUNC_START(aes_cbc_cts_encrypt)
>>>>>      add             x4, x0, x4
>>>>>      st1             {v0.16b}, [x4]                  /* overlapping s=
tores */
>>>>>      st1             {v1.16b}, [x0]
>>>>> +       st1             {v1.16b}, [x5]
>>>>>      ret
>>>>> AES_FUNC_END(aes_cbc_cts_encrypt)
>>>>>=20
>>>>> But I don't know if that change is at all correct! (I've never even
>>>>> looked at arm64 asm before).  If someone who's knowledgeable about th=
is
>>>>> code could chime in, I'd appreciate it.
>>>>=20
>>>> Ard, could you please take a look at this?
>>>>=20
>>>=20
>>> The issue seems to be that the caller expects iv_out to have been
>>> populated even when doing ciphertext stealing.
>>>=20
>>> This is meaningless, because the output IV can only be used to chain
>>> additional encrypted data if the split is at a block boundary. The
>>> ciphertext stealing fundamentally terminates the encryption, and
>>> produces a block of ciphertext that is shorter than the block size, so
>>> what the output IV should be is actually unspecified.
>>>=20
>>> IOW, test cases having plain/ciphertext vectors whose size is not a
>>> multiple of the cipher block size should not specify an expected value
>>> for the output IV.
>>=20
>> The test cases are extracted from RFC 3962 Appendix B. The
>> standard clearly expects there to be a non-zero next IV for
>> plaintext sizes that are not block-aligned.
>>=20
>=20
> OK, so this is the Kerberos V specific spec on how to use AES in CBC
> mode, which appears to describe how to chain multiple CBC encryptions
> together.
>=20
> CBC-CTS itself does not define this: the IV is an input only, and the
> reason we happen to return the IV is because a single CBC operation
> may be broken up into several ones, which can only be done on block
> boundaries. This is why CBC-CTS itself passes all its tests: a single
> CBC-CTS encryption only performs ciphertext stealing at the very end,
> and the next IV is never used in that case. (This is why the CTS mode
> tests in crypto/testmgr.h don't have iv_out vectors)
>=20
> Note that RFC3962 defines that the penultimate block of CBC-CTS
> ciphertext is used as the next IV. CBC returns the last ciphertext
> block as the output IV. It is a happy coincidence that the generic CTS
> template encapsulates CBC in a way where its output IV ends up in the
> right place.
>=20
>> Also, these test cases pass on other hardware platforms.
>>=20
>=20
> Fair enough.
>=20
> I am not opposed to fixing this, but given that it is the RFC3962 spec
> that defines that the next IV is the penultimate full block of the
> previous CBC-CTS ciphertext, we might consider doing the memcpy() in
> the Kerberos code not in the CBC-CTS implementations.

Interesting thought. I'm all about proper layering, so I think this
is worth considering. Can you send an RFC patch?

David, any opinion about this for crypto/krb5?


> (The 32-bit ARM
> code will be broken in the same way, and potentially other
> implementations as well)


--
Chuck Lever


