Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A263B189
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Nov 2022 19:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiK1Sn3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Nov 2022 13:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiK1SnZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Nov 2022 13:43:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12CCE35
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 10:43:23 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASGiEmD031115;
        Mon, 28 Nov 2022 17:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SDRfpjG9wVpaDZhUcCgb8t73ZM/+s+/wJ3lZiw+/hOk=;
 b=Nh8mggJWlzX82wYiJ54i5loCj/lewTU4saBmV0VPeJpukGu7+/h+ALwD73uZLVsYM+tA
 XSs4YD3zw/HFrBB/vHbhgiT22HDxoKbHX0b4r31P89N/b4D16naxyyvirb/+jR371a8V
 pEp63mk+gGxkHH/kRd0GwFSC1BU3TAxE+Hd3Uk6cynxjL/nnA3uoRWs8LFSdz9mNJDcC
 lcclVjYcWJqSQfmjrLEhTDJNajt8H3FrXPDkAlk0LWcDkrlqL4Lsb/2W7uhhrRqLZT0v
 MwD1v0ouxBw8sPSNb9Y8ec3iDvKm/RV3Brb0BwhTwR/FDLmJnDMy5Nv06IinWvJDyph6 fA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemam2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 17:54:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASGlf0Z027955;
        Mon, 28 Nov 2022 17:53:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3985mfkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 17:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuq51eca9Q7IhhqEArzM81VwEN+TfKPgou6FXjXo8tfQs24MMZgLrJCf7bwd7qzhwiepu8abkyb89XiGkgyaQ1CeYX8ryQWIltycvJJGCHC+X0zkr80fEy0cAbNEf+4kSy+Ry0hU3LjJ46AKOQ46TUfxLgkoV30M+Mf/xgqW9sKUNX1n2ksNDacp0ubNjukD0+ekrCjfDZEKiD0HZlwx8LyMW+Daf1BujoBZkQt+Dy+0BzV99X8GsDpFM9wLF+b01+zU8nogGDiJHZ8hC1G6n9BId2TLM+volXdp11HD3UT7q8rE5IlvzpIX4Qim0BdPTKeqG/LlHH8i3rpogr3Uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDRfpjG9wVpaDZhUcCgb8t73ZM/+s+/wJ3lZiw+/hOk=;
 b=QqUMzuF6EW1zF6upbZ7v/O5pjjs/JdUjs6VUzFTtZZsDG+yv8FxDIR8c1/B9RaI7SylBeSuc9gnvPq48WmOMiGSpPKEe+EcAvr2N7pAI/8FL8iTOHy0XB3Q48nNShKMDUZEfC2YIqJIANLYTWA+qqphU7hgYF+baEydDTY9IPMLtxfGjExq9c8qx9B6OqbujgAa0XfF/0h0/k6MMuWz/J33O/oxLC2hCs1FFBzRdeZCbTlBZWwTdMzmwHP838lQsyRpV2Ic8VPM/TO3YfJgc6StjNV1oltX5yUDQox4pqdMnNM3tRL5NnShiRobsxRQ8IOp59NpnSA8Fgk7tseeM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDRfpjG9wVpaDZhUcCgb8t73ZM/+s+/wJ3lZiw+/hOk=;
 b=g2nzabqYnUSGR0GupLZvhfpGsSr/g0g0U5b8AZn+yHr2J5h9yLIyUubDk3cOi3i6mngnBrGE4ZDRVpQXIq6wpbXo0wfM9PqQsK/GA8gMKRNA8ZwjyP+eNnrwaQY2L843cDim9KM1JP6mkFPVjb4U4+2sgKQ3B4BITfa507shTgc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6484.namprd10.prod.outlook.com (2603:10b6:510:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 17:53:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 17:53:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix crasher in unwrap_integ_data()
Thread-Topic: [PATCH] SUNRPC: Fix crasher in unwrap_integ_data()
Thread-Index: AQHZAoQmzavTBIzL1kiUAKK/+ro4Ma5UlBMAgAAAegCAAAstAA==
Date:   Mon, 28 Nov 2022 17:53:55 +0000
Message-ID: <4A7EAC52-1B7E-481B-83A3-53494BD904EB@oracle.com>
References: <166956944745.113279.2771726273440100988.stgit@klimt.1015granger.net>
 <c7ba9e84577d4d1ba917f6f47d1b227e292894ec.camel@kernel.org>
 <c9c934220eadaecea5892ab1e058680ad1369af4.camel@kernel.org>
In-Reply-To: <c9c934220eadaecea5892ab1e058680ad1369af4.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6484:EE_
x-ms-office365-filtering-correlation-id: a38b2b2c-eeb7-421e-14ba-08dad16984c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/KddkbZaceAwiQLupd/j46MW26ALQFo60vDB32obrpO/9j/02E2DTLwjGKsR6N9Bmm+RxLd/FShUe/BybFxQoCuH46msw7qbfnvfLIYBOX4aZx5RqhZgrfPG44tHuBcb4Hrq0wPq50OfAzp1aYJtzSQZxQ/4mDtjniPtB+IgqE2bp6mqLvG1e9hCIB9+B5gJvP1nsefRWhw1FWMXKwYJjaFBkiJwx3aTw9MHxhzpePb3iTsQcSOPgWogw09pkGjMHk16odD3DKxuS+Yc22X3UV8i4ZEhLoIuXGb6Y/ijc7uYOqCFobA/8JXJeuzL1EymMiiW/AaK722A0BOnBSBOgytmPxsRVQJL4EPzg1MNgaSXfCZsK3LtIPau0QIEPtf7KJEdXfc0jCPMn4IF13ti2tIT3SLsGxSbX438dWRBu9HqADjcSqCJwTlbuuMLBJYiooOsMUEhtecrKAuS3tKaRhTg4EnMsOixknSDfwqAS/gEgYxt+3tOz06sWEkU+RMalc1ut0SOLZV8zElD5gvFy93gNNf6Icvhu+zBfjSTK2y4QHfEHhouinAiqn2FI+ofsqZ7QHMfL2wkFNwHj3Mnr7J2S8bmblAfZUR3+WxCq12K4NV/woKAkyY8UeyuEdzmMUWW+dl3Re62hA8Cg6tEtoQUTbtxDASqTekbprxyrk76c9rtu92SkCZZvebUtT+Xsjqbtb5WA9UMzymug9zw4OHrXU4di0zHHegEIERemo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(478600001)(6486002)(4001150100001)(53546011)(83380400001)(2906002)(71200400001)(66946007)(6916009)(38100700002)(5660300002)(38070700005)(122000001)(36756003)(8936002)(2616005)(6506007)(4326008)(41300700001)(66476007)(66556008)(86362001)(64756008)(66446008)(8676002)(26005)(91956017)(6512007)(76116006)(316002)(33656002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?05gO5S65Q3A9Au/FA0+v/Ps5Pk91XMEWkJAhyyH2cNq7J4rXTKhgJcxijFz1?=
 =?us-ascii?Q?e8L0LueEPfHcaYvJHZ+PymqSTHWxhXsSsogR+8UGfBXVu8YdICfh5bVbuTVB?=
 =?us-ascii?Q?eE2EOv+fzWxMVYLpqob4xez1RuEa1/BP0k8T+tshBktYVSbAu912wwpd8qfo?=
 =?us-ascii?Q?qObvP61Yr66jwCeIVEGnkhbh5FIwX6cPvC5HZSHAjvBNk5li+ujXMR5Yh8qk?=
 =?us-ascii?Q?Cq+gjhvNyRdnShKpExMDj2f8hklBR3kP3kaQMRbKMZl40MtubuoZNG3JAQPq?=
 =?us-ascii?Q?suzdFcKwI84rv/rzW0r9jnRgt+4OXNOTZkSvl6jttYGSAGZ0eQxkue1fhuCX?=
 =?us-ascii?Q?/3jhAkD+pf0A7+BJn1AR7eZXzCop1O1JZ9+TxCEV4aRWdsYH26GOFNrZaxYM?=
 =?us-ascii?Q?cvTVTgeHRQxcmuMJel876znMwFW4CibxjcQ9XreckQLLzx4pfRcm3AGM+iPD?=
 =?us-ascii?Q?9VQ/NJhYtn5/mFVaFbiOwHyPn69s8BLUCe9Xnk8x0Op678lQElb3LIpCcXoj?=
 =?us-ascii?Q?WdB2wrGwAtyNNNm6AYgiVNp7YFFGUozRzwJe/kV8PGkef0EfrtVJmoetdZmE?=
 =?us-ascii?Q?s9XnHax4MfBZRJUWmdB0fymoPV3Yq6ULtrbH+uSxetX1VJujSZE+DDqapeQc?=
 =?us-ascii?Q?dHgxU7QTj3G6FG6VlzvWX1ZbPux6ggLIWTR41PutvsjK7HfBDm3n9OlreQch?=
 =?us-ascii?Q?Ny/E1+2wmgputRBSFnGThhDV522J5bTCk/O+Sed5enBd4zpTc2liOVkGZOxI?=
 =?us-ascii?Q?dLgWFRJhtDwclBSa1F4/BIw9ukf6nZZgMqVbkBjlURExuCJS4DByrIFYFNiO?=
 =?us-ascii?Q?RnIEzeRU+zSY52wxf5f5KwGFn68hhyl0HuS0OpGn+23+mAEJoXUyyDPT4jw6?=
 =?us-ascii?Q?r9XiVHYe718z+VoxSpcfTdo8mqezT38EOwWRT6y5x1NWPyV2mJBua3ine4I4?=
 =?us-ascii?Q?mV9h3gcnP18Psu38ESV+/TMe1mnnrTPumrvW0zbQArCRSuFcLfBUFH4pBSGS?=
 =?us-ascii?Q?F6BN2EW66BbQZfHsXET9JzlBW6x9tVvH8iy7DUU+FsaUJOykl7q7hXvhvcJq?=
 =?us-ascii?Q?RH6zSceokuASILXKqlTd42GTpcaPrK1YkJafQCy5xrPFrkeU1K5lclnxg1MO?=
 =?us-ascii?Q?Y3mVhcn7p9Px4KldNcB5y2EapZNMvV+x3DOjQPkFmMVKglSq1DUhXIdgXUkA?=
 =?us-ascii?Q?ogN19PrgosjRerDrnGF9pXNmpFjaPyMpaRQfHmfLnQc4ZSsrORq00wwrTx0P?=
 =?us-ascii?Q?N6sImXrD54OVQl4rve5D+NdsPV5bZoO+/ICHfQaFw+fhHDd7+GmaErEMg1Pr?=
 =?us-ascii?Q?UcCFKYACOK4+GxBIF/UQ5z/mJ2aPS/peN6mGtOLIj25YxGTYaNmkcKolVu1i?=
 =?us-ascii?Q?YKxt66lzIQ+oZljKEqQuMRmEdMpdOFgtkAqBJXyGKpkk1e7hcDHqZl5xHjdT?=
 =?us-ascii?Q?fJNfdc3Hx8bfRS5HkQYCB1u3ydLQoj8ie48kl1j+ujy6VLOrfm+UhB8IVFDq?=
 =?us-ascii?Q?HEMTgdvg8cgfj7984LMdZ3B2Pr7a3JRr/eApbpMWDVHmUuXUA25tTEsfmgjd?=
 =?us-ascii?Q?cSoxe7vZS/6lw6QJOyu8m/FlPa2IcIA1RneOCPDT0PvfpVhSpUdThFN1t6Jc?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDB7692712827B4EB7E511E2D93D058E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CNm2tm/8WHNeDgyCP9uJdiXIsr7khntfJxNPpAiJzoW1g8/HVsAVp5vn9q5iRsjapvUcD47+huAhPpIOV28UQSeb3UtOnA0vNjgvfnNbYgDEnZsqLzHhhy51JuOV9I4ebuyEkJuPtstmONMceLcc+3cqNRDp2TbjqmWf8InTswFxY6BM55bEQWMKX2GXhtgUSMFHVlv5ToZiDotddl3IMfPxyTBzC9HRE5LcvPrMm7ug299HtJwcuBVyS7QI8e0pT8cJw75bdrOB1miougp6JTxyq5RSaGeBWTZH831K8Zg3fSLNJeRM59prgxx6/08z4sTuDLzVo4tR3O5XArav5zCfDXUtuoi2KfwcqCY4gKZrF0lhDuwNKxZSmQthCyU3rzOvgsrIfiHSG53t4xAhciYfCipfrSToZnTipmj/qwAE11p5t54xE75nj3YABBmg6nYwWC/EMDNlpFRT1pRF+WM6FaeOSPtFsVlWdsOyvNbm+RFEa6EOYjCT7iHwrx54IPdNfHDVgvokRskHBjx/3oZkuZzWkC5gcyXR1i7gMAOLMFYW88z2WW8oqah98e/ruPDq26JMTb+smgI9PxOhAFnve1zSFnrT/5xxe58YCHgvSkkwcGL4G1ESEB0LzFCWhKI0Pxz9wtbk1PU9ZQnZL8F56pYC4Z8z+docxHpHQDRAtT5T5cW74BB2rpZYBN0W6FyduWxno2C5ZGU8PkGz9A+Hm53CkO3AjlnDOjFM9QnvBNMzjOJui8F9EDQotc7L0Q+WdNtkuRozxyM4Fy9dcJAT3EZBXMSFo/JgU4/90N4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38b2b2c-eeb7-421e-14ba-08dad16984c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 17:53:55.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBfiQI6dsYqDWGr03JMrYGFBL68JL6Pb39I8rPo262tl8k8iBLu4r2avf96GOZ2XA77ttlRzBpOY0+ykbMtOGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_15,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280131
X-Proofpoint-ORIG-GUID: 8ydj6woXM-HN_QgvXeWV8rNY-2gG6e13
X-Proofpoint-GUID: 8ydj6woXM-HN_QgvXeWV8rNY-2gG6e13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 28, 2022, at 12:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-11-28 at 12:12 -0500, Jeff Layton wrote:
>> On Sun, 2022-11-27 at 12:17 -0500, Chuck Lever wrote:
>>> If a zero length is passed to kmalloc() it returns 0x10, which is
>>> not a valid address. gss_verify_mic() subsequently crashes when it
>>> attempts to dereference that pointer.
>>>=20
>>> Instead of allocating this memory on every call based on an
>>> untrusted size value, use a piece of dynamically-allocated scratch
>>> memory that is always available.
>>>=20
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> net/sunrpc/auth_gss/svcauth_gss.c |   55 ++++++++++++++++++++++--------=
-------
>>> 1 file changed, 32 insertions(+), 23 deletions(-)
>>>=20
>>> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/sv=
cauth_gss.c
>>> index 9a5db285d4ae..148bb0a7fa5b 100644
>>> --- a/net/sunrpc/auth_gss/svcauth_gss.c
>>> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
>>> @@ -49,11 +49,36 @@
>>> #include <linux/sunrpc/svcauth.h>
>>> #include <linux/sunrpc/svcauth_gss.h>
>>> #include <linux/sunrpc/cache.h>
>>> +#include <linux/sunrpc/gss_krb5.h>
>>>=20
>>> #include <trace/events/rpcgss.h>
>>>=20
>>> #include "gss_rpc_upcall.h"
>>>=20
>>> +/*
>>> + * Unfortunately there isn't a maximum checksum size exported via the
>>> + * GSS API. Manufacture one based on GSS mechanisms supported by this
>>> + * implementation.
>>> + */
>>> +#define GSS_MAX_CKSUMSIZE (GSS_KRB5_TOK_HDR_LEN + GSS_KRB5_MAX_CKSUM_L=
EN)
>>> +
>>> +/*
>>> + * This value may be increased in the future to accommodate other
>>> + * usage of the scratch buffer.
>>> + */
>>> +#define GSS_SCRATCH_SIZE GSS_MAX_CKSUMSIZE
>>> +
>>> +struct gss_svc_data {
>>> +	/* decoded gss client cred: */
>>> +	struct rpc_gss_wire_cred	clcred;
>>> +	/* save a pointer to the beginning of the encoded verifier,
>>> +	 * for use in encryption/checksumming in svcauth_gss_release: */
>>> +	__be32				*verf_start;
>>> +	struct rsc			*rsci;
>>> +
>>> +	/* for temporary results */
>>> +	u8				gsd_scratch[GSS_SCRATCH_SIZE];
>>> +};
>>>=20
>>> /* The rpcsec_init cache is used for mapping RPCSEC_GSS_{,CONT_}INIT re=
quests
>>>  * into replies.
>>> @@ -887,13 +912,11 @@ read_u32_from_xdr_buf(struct xdr_buf *buf, int ba=
se, u32 *obj)
>>> static int
>>> unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,=
 struct gss_ctx *ctx)
>>> {
>>> +	struct gss_svc_data *gsd =3D rqstp->rq_auth_data;
>>> 	u32 integ_len, rseqno, maj_stat;
>>> -	int stat =3D -EINVAL;
>>> 	struct xdr_netobj mic;
>>> 	struct xdr_buf integ_buf;
>>>=20
>>> -	mic.data =3D NULL;
>>> -
>>> 	/* NFS READ normally uses splice to send data in-place. However
>>> 	 * the data in cache can change after the reply's MIC is computed
>>> 	 * but before the RPC reply is sent. To prevent the client from
>>> @@ -917,11 +940,9 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct x=
dr_buf *buf, u32 seq, struct g
>>> 	/* copy out mic... */
>>> 	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
>>> 		goto unwrap_failed;
>>> -	if (mic.len > RPC_MAX_AUTH_SIZE)
>>> -		goto unwrap_failed;
>>> -	mic.data =3D kmalloc(mic.len, GFP_KERNEL);
>>> -	if (!mic.data)
>>> +	if (mic.len > sizeof(gsd->gsd_scratch))
>>> 		goto unwrap_failed;
>>> +	mic.data =3D gsd->gsd_scratch;
>>> 	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
>>> 		goto unwrap_failed;
>>> 	maj_stat =3D gss_verify_mic(ctx, &integ_buf, &mic);
>>> @@ -932,20 +953,17 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct =
xdr_buf *buf, u32 seq, struct g
>>> 		goto bad_seqno;
>>> 	/* trim off the mic and padding at the end before returning */
>>> 	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
>>> -	stat =3D 0;
>>> -out:
>>> -	kfree(mic.data);
>>> -	return stat;
>>> +	return 0;
>>>=20
>>> unwrap_failed:
>>> 	trace_rpcgss_svc_unwrap_failed(rqstp);
>>> -	goto out;
>>> +	return -EINVAL;
>>> bad_seqno:
>>> 	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
>>> -	goto out;
>>> +	return -EINVAL;
>>> bad_mic:
>>> 	trace_rpcgss_svc_mic(rqstp, maj_stat);
>>> -	goto out;
>>> +	return -EINVAL;
>>> }
>>>=20
>>> static inline int
>>> @@ -1023,15 +1041,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct =
xdr_buf *buf, u32 seq, struct gs
>>> 	return -EINVAL;
>>> }
>>>=20
>>> -struct gss_svc_data {
>>> -	/* decoded gss client cred: */
>>> -	struct rpc_gss_wire_cred	clcred;
>>> -	/* save a pointer to the beginning of the encoded verifier,
>>> -	 * for use in encryption/checksumming in svcauth_gss_release: */
>>> -	__be32				*verf_start;
>>> -	struct rsc			*rsci;
>>> -};
>>> -
>>> static int
>>> svcauth_gss_set_client(struct svc_rqst *rqstp)
>>> {
>>>=20
>>>=20
>>=20
>> That makes a lot more sense!
>>=20
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> How did you find this, btw? Is there a bug report or something?

I recently fixed the same problem on the client-side. I managed
to trigger the client-side problem while working on the server
GSS overhaul.


--
Chuck Lever



