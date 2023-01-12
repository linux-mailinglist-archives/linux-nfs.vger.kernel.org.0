Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983506668A4
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 03:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjALCEj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 21:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjALCEh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 21:04:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B371C110
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 18:04:36 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BLE7I9017432;
        Thu, 12 Jan 2023 02:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RqXkV8TXq4euhf7NFaExQsLHcp92U4JcYh5TpDXqHQk=;
 b=Gc+21EKhEOfxCueWbQD+yOVGtCTOpQr6TFLkfcCqKnWXM9rVU8iSIWE7Vj0VZyQ7Rraj
 dduOcXlQo4Dzu9zGO3jc+tNQmEqARLSDbxIO9MprcyMZf1f1IfthYEYBAcWKYbU1jwSE
 ayS3dZn1mSouyofA1BJQAuDQ21q6oizPV0xhKrq+6EiYJLkuKqT2ALEL4ISrpdYH83E7
 YtNMFzCSo4v7utbe8gP3QfvqxPz5nF1jSIW4Bn9MELl5jZU4ywD1UKS6t2XPodfo2Ar0
 1RhI0N+OdfAdoRVLJsXb0mPtewLbytf5L/UYfjUvdrVUAac4fkAO2bigOkBPNywfPWOl pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n22x00spb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:04:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C0KSCk005185;
        Thu, 12 Jan 2023 02:04:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4ajguj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 02:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rs/FxKig8deS+cCevwKF15A/ilMk6095JMA2YQ0VmgA62KRePxOyxLMSvBY6E/pWXNmmdJphFqHS+GlyuOVT2y/d2fqCrFxttD0kcy76CPlFD7S7CaLSKD1Bb1oDvFgETt4WXkmesuL3Hj/JJqYZw+OzbphUsYu01HCUGhHjvjUGB/+lFACoF0xHDtVIoiAt1o9lNPSV172MygBVtjU9jtxV37Kjmyi3x/W/EHGuljlDuM0FywCZvIdsv18Z12NMHBXiCKv4rWtplzbpcuBquhTsFNgUbO4tBk44Z7KfqHCemqkqpRe9st45BpQF3PN+skcPbPbFLV1l9BdPxeKZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqXkV8TXq4euhf7NFaExQsLHcp92U4JcYh5TpDXqHQk=;
 b=m0S9DjC5ma0om8SAChJ2Y9x4H9KFtQrbmVKbrAlrYG1fiT78xHUfTdbLeIUPWNMaT3nQIhzwEL1MoDJcmkjWVGmSdRjpQt81vb6KQxp/V+gGRGDUXGpZ2MnjEipYx/w4maO/yVPPq/byn5Av+zkpjs+xuPtNwk/BeXWUmMHfQIFwbX6yovv1it14ief5JjEjyvgCrSrIIxmdNjTa6Ryaad8/nB4LSiB9xvFKFyH9S08KtqQlqQ9H0KMRdYs+Zi78BuKR7fA36KjrSBcwKUj7koR+cAaej21/qaIATfXx1AVssKrJBWakoYUG/BRAI8kseOm1w202svXdcRsFbA2Pmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqXkV8TXq4euhf7NFaExQsLHcp92U4JcYh5TpDXqHQk=;
 b=D6hCg7ElYQZH2/eaumt3GZcT8yRz3W+rayf8NpCLKVF/QiseYiOHamUgJ2j7XXaB+HnKHWJd8zLlXRnzGeNfE+Is40fwjIzZK+6qqAwXSVZh2Z9WCDjhHzUBmD84gFLqJ9x0RA1RAMl1kd8ej5qOsHqZBqpEAR2YC5rrEFhdJDI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6134.namprd10.prod.outlook.com (2603:10b6:8:b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 02:04:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 02:04:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Jorge Mora <jmora1300@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v1] NFSD: add IO_ADVISE operation
Thread-Topic: [PATCH v1] NFSD: add IO_ADVISE operation
Thread-Index: AQHZJSQBUzdcYqCpSkGTK0NFqr66B66YAUIAgAFC2YCAAMX+gA==
Date:   Thu, 12 Jan 2023 02:04:23 +0000
Message-ID: <8DA0EF87-CD06-4169-9269-B29839BACD64@oracle.com>
References: <20230110184726.13380-1-mora@netapp.com>
 <525FDD70-D00A-40DD-9C2A-71048F4D612E@oracle.com>
 <CAN-5tyG_aefN8x1bzif7CTnv3_b3qf2V2mWk3c-Uu7MamFR2oA@mail.gmail.com>
In-Reply-To: <CAN-5tyG_aefN8x1bzif7CTnv3_b3qf2V2mWk3c-Uu7MamFR2oA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6134:EE_
x-ms-office365-filtering-correlation-id: f235c1df-7af6-4e38-a1c8-08daf4415397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awav/BqMxsc4Xk4sFKyfm3lHRpsQqrHQRLG13VbNC9X3TNonsga0c4T5hvpJSssEWSUTC7Z2rbYtLsFxuFzFCdJ2fy2KGXwkIvVm2zRacqgABnB+uyyCJ2xs2I5DdIo1+ZPSPmoV9NqiM2wY/+kr9ZRz7wyRS1+jnxeU8eU9NO1w+V24mBLv7jspYfcWqKpaNyyLrHJWT5wUGZn9ICZkNqVJCtBDBUuOfKiMMtI/j8Rjs1kh4Ro0insLnxg+3HQLSoMot3eRFTZqCxmNAjffInboV93PpjKGpR0jfZavJl1U1CwZa0KpvaEV5m9da1DZoOblghgcTfFP+AheXWgaPTFvozQJUPGndelInO6lyX/Qv/Sy3qWObBLh63e+Cm3V1wKYNA/EseetFdeQOUlcB1/haAFLgwWNfqcFFZwbB1DmWZBGPjO8ZlCPQsR2rYWzeaEQU3DWo1fW0eBenFA0lIlkqIKg1jQwDUvkFjNEMchwrax0WFQNAWCuHQIMrGEiqRpuU1NTHxWfDrezWUugAP5hpis1ROsK8/7pOagyWuZiLPaQkdsCfN8sYFlXzbizpjT/DwCjhb8rd9eIWwBAiRWPBqs0+JE8pt3OwbEyzmmMVlf3uYbCgSsCS3e5IEGEQBjGPorxcA/eCt1tIq7Bf7RVfXyqndF36+Cq+lLnxVFRlE2+LeosCqW9bbiUjnm56F9vuE9xinccUYzZD7RiZI5V7o87bvHVBs9N9ro+FSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(6506007)(2906002)(64756008)(4326008)(36756003)(5660300002)(53546011)(83380400001)(8936002)(122000001)(8676002)(6916009)(66446008)(38100700002)(6512007)(41300700001)(33656002)(6486002)(478600001)(38070700005)(91956017)(66946007)(26005)(66556008)(76116006)(66476007)(186003)(71200400001)(86362001)(2616005)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kOx7KT/q1GmxlWAo14W6AYpLbOuj1auKJ+N/roOedym19LqBSFY+RR5fCHXa?=
 =?us-ascii?Q?6T5AfuftnqmJhfWLcT9mgFmxMtmp9ixQA7Kf0ZdhRqJHTkPM2d5+6R98fwxz?=
 =?us-ascii?Q?iFYxuek6zW0Db7n2mRcLP7xhBkwbY0S2fcMpkfmvEJDepQaEySPfWzEhgUnA?=
 =?us-ascii?Q?FO86h/Yy7Qmd+0H5/7znWkrnZpbiwOX/8yQ2ltfAOALnGwir5jRdtl3M9D/u?=
 =?us-ascii?Q?agmAXQe+cC/S+MYARUki1pNdZI1eVo8Z2HLC8bicbE0LKWg21bmL+WQCCW98?=
 =?us-ascii?Q?4f04gp4q8Purr+GuCm0oxaX1BrSZq+rQayVBR6Rvw8gRiTLaoEQ7PPZiNzln?=
 =?us-ascii?Q?jrk02cmMjlv1sJBQbXDZuPW3fRN9zQOVbEWPFT7Fi96Uve0Rf3LhTM4Js392?=
 =?us-ascii?Q?is01Kv0Ot7nu6oU3RsPeyNK/rfLD9Gy0UOOmI7m6PCuQ87nElp/1Dao22+8b?=
 =?us-ascii?Q?X2xLbebZjb5OHLdJ1MJZuZn1ipKao/2fg9i6xpUcP54MGqzhzN8HyY9qOz9T?=
 =?us-ascii?Q?dw98MOUJFMpw6DD+K0hRQMglF454+NGj1foF82AELtvs/1aEFcofKYhnY/Qi?=
 =?us-ascii?Q?4qMW8GMa3eHx6AU5Is+0rFKeLfIII32FeAypSncHh/PiL0ov+MUaEA3hpZCf?=
 =?us-ascii?Q?MvHbJ9/+xa3Xx8ReBXSwT4KfNo+UGY+/IK3a81ubq6xfiuVsDeAfl+QSNgT4?=
 =?us-ascii?Q?BdofE5P8uKWm3D4n6g7vDwQluVJW8qm6FGiMWCVeXpvk9nn/YntLU3yOm6Rb?=
 =?us-ascii?Q?N6IRI6wBBplqlYMB8yZpYCZfsDvAm/w82jnK3Z0RZ3hAsaceF/Ql7AZkDeq2?=
 =?us-ascii?Q?b1mnvwzMhucT8m+/j9wuvJbOyMneQqQXBa7a0dzZdI1xsiFeRbkMEJNXCHCH?=
 =?us-ascii?Q?fHnoUWvwy/8C8mTEa89xKkb7dyt/4U8Gn0WafbHtHop9zEUU/7aEsJ/YuRTq?=
 =?us-ascii?Q?5jN9ztV5GjjtnHyI64JTnicVvlcHmJ7je0cgMjYJxq7EG5KMz0VuPHDlQ7y/?=
 =?us-ascii?Q?2krxhEosiguit8raw2EuOFL2y3D/lhETO4n7LjGx54xlWSVhPtRLES/d9CGT?=
 =?us-ascii?Q?Qm+B8LP9mNGk3fappylnhiZM31cbzPx+RmH5OTyErlaSQese1RRvVkLUJtK2?=
 =?us-ascii?Q?a5MD2fbOJA7YjS99madj3oM5eicU4xQ/8G4tgY8Kn06PU3NtqlbIPVqqg3wT?=
 =?us-ascii?Q?6znL/gRF9hPPLeHJtTWESvmQOYxG1LuRZdaOR1XGtqBcIo1jqEDkTj+QSCLi?=
 =?us-ascii?Q?fCMD5+R77Er+WT0xj28jTsoQcNB34L3LruiKWbcdv3bgg5cbmBJcmbQoKtOM?=
 =?us-ascii?Q?srivKD8/SQ8mPxmuB+BYqNvz5IS2Z5be134/Q9Aw6YOAtmpFtrMTJiiS02tc?=
 =?us-ascii?Q?ktFC5hymSA04mH4xGEUacLES9PAZ/fd4QxL+1Xq9a2D/awawTwCo8d7Ok6jE?=
 =?us-ascii?Q?CiSmLlnjKjiw9zSfsZVPUEfilgOnjd78ctn4EW6v8zYAb/UZ38EOEDM1IkHP?=
 =?us-ascii?Q?7DKpdY4uB3A4gUp4kHUwsqS3AiqxJuwETmVnmkiMvTjZawdh82uHVtWQaNB/?=
 =?us-ascii?Q?fuqkDo97Df32N/0I1gJYfoZB7lZQBGzl1RxTxQbwL28cyAXqnvP9rrtdKIYr?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69A027E099645947AEBF962F5513A2D6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zccEKtAbFIyUJvCsyzS14lFOJUGLxyR0zY4jSjT9PXVUeDKsVlxwZY7S4J9VbQKc4A5F1ZXmi56ag4ue8+Y5SiVO4IldKdMLqGetEuvyrX6cFUGSTz7EEYomLgvY9HBfF+l+G03ixFxzE/C07IEq+mdWQB1XvIC/JGvoioc0ESyZ3Z4PYOiUj/Id/PbsRGq50EqgGprtMOt4m8R1b/oIIw9g6NUf//5r57uckH2qGJgR++0UaOBa68y57+ahQrTPUgQsEetFwE+aXv20HiNYlcuILs/Qx8dN/m95o7aggQGyFzcL0aEKrXuSiKiK14uyzHJ9PthHBr1yoQlnTLSIBe7GYJdHRQfVUMsxIpyG1gU2X9fd7SwUGPV3ekS3MMik5usHwTWtFbVj2NtYfA906Ws3RPGgjUYaNyXtFMYd1Yd4aWuaeL2M2ix4VOG88NRbiuTzQ5Tlw730GJ/v+hEVo0Rp3rM+yJOXnWiudg1cO/dxsHAE9zfMEuEGSlUYa9XOczxzqvwrWl1d6PfngggsSOEvmnG7x+t8bO6e0Ja3XUCk750bFe+aTDMVAanCqOWN4Q+kFO8pBJrSzMMly3H4c6n5MzsG5BhYQR6keZgh/YHw4qJbCLyEml2FKkCVqCDK9n1XBMLMixthOEVWbOwubpivFVHWIKhocdtGXhczEYR7qvM3tXBM5Yihrk0qS269VB28ogpNYfhAxcOsqTiqBNeI2wHVL9tLdgMHq7FyRZ8amn+FQHYlwomwFfIDqc7lWNjRTi2IIDobm6TBG7Y/baBF8l+19VuhJHqlcl5M7tcXAPtaySJXkdDlAJUccuPW852XzI/Zb6wt63R5u0IXbw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f235c1df-7af6-4e38-a1c8-08daf4415397
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 02:04:23.8687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMDeyEmC8aBVnHbPnhmfZTbEjP3qByvuyiia60qY9NQKv7KMXeoJRS8Q5EaprZSBcH02Q9/TEe5Wbg3bzdbOAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120012
X-Proofpoint-ORIG-GUID: E_awOuldSuxI9krXvajY7M00cjjXEBQB
X-Proofpoint-GUID: E_awOuldSuxI9krXvajY7M00cjjXEBQB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jan 11, 2023, at 9:15 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Jan 10, 2023 at 2:04 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>> On Jan 10, 2023, at 1:47 PM, Jorge Mora <jmora1300@gmail.com> wrote:
>>>=20
>>> If multiple bits are set, select just one using a predetermined
>>> order of precedence. If there are no bits which correspond to
>>> any of the advice values (POSIX_FADV_*), the server simply
>>> replies with NFS4ERR_UNION_NOTSUPP.
>>>=20
>>> If a client sends a bitmap mask with multiple words, ignore all
>>> but the first word in the bitmap. The response is always the
>>> same first word of the bitmap mask given in the request.

>> Does it provide some
>> kind of performance benefit, for instance? The patch description
>> really does need to provide this kind of rationale, and hopefully
>> some performance measurements.
>>=20
>> Do the POSIX_FADV_* settings map to behavior that a client can
>> expect in other server implementations?
>=20
> I thought the purpose of IO_ADVISE is to advise but not expect. If the
> server wants to do something with the knowledge it can.

Fair enough: what should the Linux server do with these hints?
Show some data that demonstrates a specific benefit to application
workloads for the server implementation choices that Jorge proposed.

I'm not saying NAK, more like "not yet." This work doesn't look ready
to be merged without a way to evaluate whether the proposed design
choices are reasonable and will do little or no harm. There's no
discussion of that in either a cover letter or the patch descriptions,
so it's really hard for me to tell whether this has been thought
through.

In the meantime, the client side is supposed to work correctly
whether the server implements IO_ADVISE or not... so I don't see
a pressing need to merge a server IO_ADVISE implementation until we
have a sensible architectural direction and one or more use cases
that can actually benefit.


--
Chuck Lever



