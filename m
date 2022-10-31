Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE561379C
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 14:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJaNPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiJaNO7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 09:14:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC7B60C7
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 06:14:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VCVxoT032281;
        Mon, 31 Oct 2022 13:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bm4YeMrVpmDggugwYUp3xZcO6wBllr1mPm+dl8Z768I=;
 b=mtsS9nuLIv0L1Irzk66h+yp40ZNPn6fLrBDGNFV/4H8HulFbybao4rAdxB6eN3niLSVb
 0Oj9XvW35lwTr6usrzPbq99Z/9XITARQRIH44HcVPcDJ3T9kZg2+dDXsTVBz+tSdCBQw
 RGMP2zTeRcdNVzU5oiuswvIScKQrk7KN63DZFTZR2Nqfg44jciJAn1TqcpC87QrLO0e4
 Q2+GmkPYo4KQl9IqlSjjJ2CpQ0BjcibcP6DxDwhmXqE3LczrcryTvGt8OY2kCr215nxN
 BymumsSMuzy6PFrB+PGlMqqYm7JdAtqKmsBEJE1mVenSxOVLsVDiyRNkYUkaVN2C/rcn og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtbfsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 13:14:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VD5ewR030969;
        Mon, 31 Oct 2022 13:14:50 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9abnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 13:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM80KgHmzTEio0pl5K/esySBs7BasU6Vyz73FBHF42N0aw6zKs55zs0yKUy+fYtMd2iZlEYm/DaG3Cw2zsjaWVAMtEp7tN+QBFIw9rIExPk2X35aBojmOgTos/sYiWPWzEIrO3Rx0yXPm8Cj4l/E4NpYzWLRJ/2R0bwL9jWuq+14OX0S1Mwmcaa0NSANuF2nH29wxScWUKpakkcOIV35yAjxYVVzyEdZd0CcFhuMJOQO6MWrzrFnUgTufh7Z0yqZIbIminyu/OGurKzYDL35Q0FAe7ZsgBwFqvFHBD94tjs0lCD/VyQV0+DGxlTvV9lWGpvGbU48eRHHJP7kDg5z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm4YeMrVpmDggugwYUp3xZcO6wBllr1mPm+dl8Z768I=;
 b=QK2YnjV8AK5fu3zrK5q9ZqglWXPp31tTzDgtqYkUmkN2Hj0ghqkaB6WE7/XBCf9IRh3hlniHtp2UmdWfhkzoc7qfH09ocQHDOuY/GAlZtuMF+Uuxm5GzCWVk3P4QJw/4vUDUYpDTbsyDp9onmGLsvTvrtriHQ0Cybq7lBmclWQQsj52is1zBCYDQoxtvzxTYwE3DetyzpWZNy2Y14c4+LVivG6mPSqFrJodAcktcWm7MzBfNO1wfVzN7YUwAoEjvPjO6M5tdm74ADsw78cnVuTTwbS2bGOAqMCBVyCqnmNX7QEaLPZiBRWVRhVZkBntmRo1MRkcii5IVeBfcc4Yv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm4YeMrVpmDggugwYUp3xZcO6wBllr1mPm+dl8Z768I=;
 b=ciFpgc53zpwLDWKlFGHwCtuYpRZZ6P1kY1wfSKZ/Y/oxQ3OjtLlTc4X4OxvFVF2X6Gn+CRD4zH/LkGHcjVuS/VurybMafWfwSgFS9hbrTbylOQKi8+s8h4DYhv/JeJWv4BO64JjrQC4Malh+oO/UlUgTt8aHZj4Q/K3htnOBcME=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5734.namprd10.prod.outlook.com (2603:10b6:806:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 13:14:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 13:14:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
Thread-Topic: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
Thread-Index: AQHY6v8bPfwg35VNl0uAHle+vjwISq4kNwiAgANEvICAAFV8AIAAejiAgAA0CAA=
Date:   Mon, 31 Oct 2022 13:14:47 +0000
Message-ID: <202AD086-4F1F-41D6-ABDC-BA6C91DA5BBF@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-4-jlayton@kernel.org>
 <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
 <166716630911.13915.14442550645061536898@noble.neil.brown.name>
 <1737B8C1-5B93-4887-A673-F9AFA6ED32C0@oracle.com>
 <fb57d2cb6769dbc123e15e76ec2c23b1fa9f32be.camel@kernel.org>
In-Reply-To: <fb57d2cb6769dbc123e15e76ec2c23b1fa9f32be.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5734:EE_
x-ms-office365-filtering-correlation-id: 6c805572-5daa-47d1-54be-08dabb41e263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZ/6KG3/hAjx5zF704BdERkIYSz0xIeCxrHsvhYCRnf0G6ccCgLgCLYkWSCjulKnZHV2zhDfcMZapIPaw0hC2I0sz8WFXbLrhNfkIK0kMdWSxzZNtGv/dT3TpwRX5guZhAZqnxpDaCJ/Tlym//e2ze1qhOeCE9HTxtwSHdDEV76j6nm3K8v7sYNBRTtnueg1LTVNnY5ceFZ7JZpXVXnBLUQwpMTkFU4ZJ/FsKJGQNF3QpUnOzUrAYoxpQXTGEhOwUOBYBC/bYxQOC6kKGkz+L8KY18UcClYdYQPHzKeGrEhWSf+U/TAKf4Z03pUWyW4pMdIO5S9udEaD5GqXcA3kZ64iRVWMjtcGiQd5kZAe6EIxooIVkLO3XJHwfd7EUTWXOE9ckVp9JY3cwA55HR4QK8QH5Y6y/zqeoJc8R+TU/qCxKpCTtJmvkinX3GqgMLgjriwEcZnNa8Qhr43zk7g1UMz/uF5x2Y4TWxWdld0UBglaTfbLvNmBSTlUpmIUnMejLu1oVW74JhXDdT8mrQfwAlgldoLdyGB09ZKmmIDHTpHW3v1Ld4mhG+ltmHhbbsnixpGiu+HC92Dnbvi21U/GipCvc7ycp1reAYid/elb84bbScRNwqjLtEyn5R9HX3S9hvpP+RbwvLKgyQo1l1lqHOValjs5a7tno6Y5ggq6agyJUtY6qEw2E2lSmMECeHebbHImTLOoGb/W95AYBiMAR8FeLDzZq0HNQ1w2Petd73UkTI8mWNgh/bsBerPuqQ2FbGnNpD1QECPR3junRE5EZFpMw+Oq2uzruXpps8/MlRY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(64756008)(66556008)(6506007)(66446008)(4326008)(91956017)(54906003)(36756003)(6512007)(26005)(316002)(53546011)(6916009)(186003)(8676002)(33656002)(66946007)(76116006)(66476007)(2616005)(2906002)(4001150100001)(8936002)(41300700001)(5660300002)(38070700005)(122000001)(38100700002)(6486002)(86362001)(71200400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9vxWqJy8EuwOLjPMWOx7qJgt1vLYD9UDALcZ2utR0Z0vHscA72nTS5l32oiz?=
 =?us-ascii?Q?jvtWwEkLRvtj3nuHRw08ntuqNRuraiXd/ca5nsfa2GmjguRI2PB2E1z3IePx?=
 =?us-ascii?Q?d8MHEs0I3/N85kCPZgoLWekeD9MOonsium6Eq1ueQk+EFh6a3HXXrqgUjqdZ?=
 =?us-ascii?Q?gNwXGdJ5xfZF/IhKpYygxZQcIB9T3aD5WLTcWSeEQHpQXuTIN3n0O/o6yf+d?=
 =?us-ascii?Q?xDlzyRZwqJWvY14cD11EE+ZouUijOZkTcOJeUQslQJk+IHZVAE7mR7/r8y+m?=
 =?us-ascii?Q?cOxD9WP8+b6Kal+u65SQbqW6A9goOLtVVF5/YcOCuT33p9ujUPeD29r/fYtI?=
 =?us-ascii?Q?UfbCnlpGkE5w4B7macM+sMZXHYuATL+hk75gDjZRl06iBanvZIRay+eeSCOQ?=
 =?us-ascii?Q?rC3VX0960+782z+c0yTit6pT60KX5KwduQJQNuWcXY9Rt9sRbGW3WC9EfpDY?=
 =?us-ascii?Q?n8zvjuN1pc8pJBKaK50II1NgsljJV+ADUMWFLSS5CaZ69uo7uM8Dj35DND/D?=
 =?us-ascii?Q?VlEt7ghR8Lf1kZMuQod/p/8EG9K53dbk39NCRZr0slWnr7/CKyw6nHxgV4Vr?=
 =?us-ascii?Q?9tMtfFsUaMvTisQS2xYjiZqAffZbNJGm7U/HJXCldrAPurEquJ2oD7N+S55c?=
 =?us-ascii?Q?QfYeEJvRaGTqrQEA49XeAnrqoCGrqH9RzpLQ02AJsnRfIXHGQiJTRoEhDyvB?=
 =?us-ascii?Q?MhnTeUfqy+mabxcnIUMuK94ytnbdF63yQUVs4XCvnZDR+5pYYwyOPXEPh/B3?=
 =?us-ascii?Q?NTGLBdwNgCeuEKtRK1gEGg7jhq4iHwi1Ommk3q4qCkcm2sGhEBcjtq2P64H4?=
 =?us-ascii?Q?pE6OcAFtuCP/oU868bLb50uvRd7G/jvT4Q35ySRbz8vh0ouJ4f/9H+xWgphF?=
 =?us-ascii?Q?b8AzLf1tr6jxxK/jsiUI2wbkhGKvCsOrYM3BfenBvctVSTgSllaTo3RcAdBx?=
 =?us-ascii?Q?jgmwUeYFC+5aQbHA6+wBrlx7oQw7nsdBgyHWxKh+e8NPnK7y5phO0O+9fVwj?=
 =?us-ascii?Q?57vlaK9M5HIY0RV9Z6cHpgyVb1Eog0ylTtB0ktit30aFOZrs7ykF+Tgmi2GS?=
 =?us-ascii?Q?yYaUjggEPkcQ1XGQYjPDOxm58eXCiL7Uu+IjxLVWJvPeloQSnpshSo2FAehs?=
 =?us-ascii?Q?TKzR/2lfDkSr2VO/+/IR2Q8YFTvxGDWDQ5PvxNFmYjUd+fiqQ3oD4gUgCVU2?=
 =?us-ascii?Q?WsV1Ho2A2bWWLld+rabXI2UPYRf/xNBrG9hqd92B2GZ9OIBDyiqRMH7WUysg?=
 =?us-ascii?Q?7p7NgHWEIRTFy7Hal9z8WaSTz7RQHg64aDDqRMmFDw6tFtl046MZwWazNJJL?=
 =?us-ascii?Q?/WH+Mp2hUqNz9LNCDsxz0sZSL2nWEJDaFrKZ00wyx72+aeiI1pvmGAmzRjU5?=
 =?us-ascii?Q?+La8mD/OzpzLk1aUqrFu8iQE57VlC70qfmOgQxVTeDf6dcyT+blvc1RcKaKX?=
 =?us-ascii?Q?+7CWdQVqL1L0n1O6+a+OOcZubw5uTBoVHr+x/HL+uzRMag1con5CkMo/zbSu?=
 =?us-ascii?Q?Ehegqqq6tNf8mhj3Y7WjsH0dSFV/Wr88TIfM1dUr4Bdym6o4xXVsxb8l5Jiv?=
 =?us-ascii?Q?e76qvYyEHYCqoD335d8ptbYjf4mCXJp0E/+P03fCkJq4ryMH9h09oHOmPpce?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5257F269C9F8145B55BBD4403509B65@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c805572-5daa-47d1-54be-08dabb41e263
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 13:14:47.1462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGVF/DvnA94nt8y7ZTozCcBWsvzWOc4vpYjAbu8wRP8F9YFDzI8bcjsnyGAm4QFABXWnAd+mzlj2nH6LSwrQnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_15,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=988 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310084
X-Proofpoint-GUID: 46gHBwbEleixM4VwNisce5a2CPIXkEcN
X-Proofpoint-ORIG-GUID: 46gHBwbEleixM4VwNisce5a2CPIXkEcN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 31, 2022, at 6:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-10-31 at 02:51 +0000, Chuck Lever III wrote:
>>=20
>>> On Oct 30, 2022, at 5:45 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Sat, 29 Oct 2022, Chuck Lever III wrote:
>>>>=20
>>>>> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> The list_lru_add and list_lru_del functions use list_empty checks to =
see
>>>>> whether the object is already on the LRU. That's fine in most cases, =
but
>>>>> we occasionally repurpose nf_lru after unhashing. It's possible for a=
n
>>>>> LRU removal to remove it from a different list altogether if we lose =
a
>>>>> race.
>>=20
>> Can that issue be resolved by simply adding a "struct list_head nf_dispo=
se"
>> field? That might be more straightforward than adding conditional logic.
>>=20
>=20
> Yes, though that would take more memory.

Not really. pahole says struct nfsd_file is currently 40 bytes short
of two cache lines. So adding a list_head field should not push the
size of nfsd_file to the point where kmalloc would have to allocate
more memory per object.

I'm wondering if a separate list_head field would help simplify
nfsd_file_put() ?


--
Chuck Lever



