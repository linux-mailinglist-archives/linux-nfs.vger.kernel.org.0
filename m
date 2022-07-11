Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B23570654
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiGKO4y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiGKO4x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 10:56:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FEB71BD2;
        Mon, 11 Jul 2022 07:56:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BDoaLi000744;
        Mon, 11 Jul 2022 14:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T1KerORybLOuivr8+rRbsXSS9iRZTdxpHhVE2NRCCGw=;
 b=EMVU1ak2YQX0I96O4P2Pnf6Q95j/zFR71AW7e+3bZSEFygXDGfKU5xYyrKtsMmyM7Ulb
 pFuItkp3NWf52KrEcVI1s3Jm2AHO1C7T2hxU+EIB0aFvMd+eqUXKNT9tq9unWoiSXb1n
 vJ3aiCs+aagHXl/WihEw2Qi+Y/uWum/FEavt+suzWVut8s1O2dVl3YAJJNtef05v6BUV
 T08VApBOz1J/WRIH0SAASK6DiYhdXy9Wir5gzrAVlAWN5fgP5sbFUp+7V/mNtPAIGhhu
 XAboRskKIdbO3EKayak7L5RvKcZ/3IAax+Z/p4fb1JeGmUTAuQ6cB3O75jC5WQv0+KIW Qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgknaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 14:56:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BEpG5X014091;
        Mon, 11 Jul 2022 14:56:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042kyjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 14:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/chJod2Yt1SVAU6ypAnln2zUFpspfEzKVWuAgB0oNSpcZvA+Z4H6y4WlZso+N/sZq2rIhr90LO1zSpzXe145jH/w1BWKv7lXEgEO1m9pntZfEZABQ8rQ1nO0AxxS/FnkdxVb3NJ1dtL8rQF4CIs4iH0+aBipHIcBbI62XHXZSIiQSYljV0QevszJHG9jnrrhURHu7y3vIoaKA3mScFIa0/6HpVMLnIyj4WDhmZNYTkEQhix7kMpXxR7PZJfltkduvVzAI1AxQZIiUOkDbzb1zKj/OmvCaghA0zFud/4Po4PnjDftI6ouDUFPuiX0FfWz1KeylXa8bN3OdykQnbvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1KerORybLOuivr8+rRbsXSS9iRZTdxpHhVE2NRCCGw=;
 b=YzyMi8fBhhNDn8XuBN9z/IjAD7Y8dU6naVTSlcd0Y0xSxe4B78Sa7KZ5EHqGZ9UrrfezAoHrfWFpFMCr9ik5GGWyexK8BsnGF4st+dioPA+eCs6pqY/TyLqXn4/hGcxQJlw24MMzFYj2omUJ59mse1iCi0+71wB7WnCmz6pq21pWqUc86hG2tMbMmf9N7e7hb/JpL/4QGcq5CnhGh5ldAOCT//J037ePv8YdFoQdS6DSXh7OJttfuRGcggMAYL5W7mgCunBdBhdBR+fBZx4xJwPNnVMh3CaMuRdWUqYgz7fbRoOKgk87AhMcuNjZowTTCm6f0mM+rnDAKN7IF08RRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1KerORybLOuivr8+rRbsXSS9iRZTdxpHhVE2NRCCGw=;
 b=DQ1eOMhZ7jZVW0ct4rfnDnjvMAZDISNYbFbJmx3XuGPTugbRyl3FuBrEZ4z3ME/wB3/q/0eMHHWf72MeMCsKLC0ZuWafxZsB8r1Chpz+aAsY1d769ra+Ju85ingVDI5YT09M+Nutl7Qy4y1X2D3uidNFTRXWXLDLq4A2Z6RiwRs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3719.namprd10.prod.outlook.com (2603:10b6:a03:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 14:56:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 14:56:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Igor Mammedov <imammedo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Topic: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
Thread-Index: AQHYlI1Yu1IMkeKgwEG1/w/Jb2AUD615C+wAgAAwWQCAAASvAIAAAsyA
Date:   Mon, 11 Jul 2022 14:56:42 +0000
Message-ID: <17D3289B-4148-4EBB-9371-E10FCD796339@oracle.com>
References: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
 <531053e36e291fc5d99bb766e76d52b0333ecc94.camel@kernel.org>
 <26FF2E45-1463-4923-8B17-CEB4441D774A@oracle.com>
 <cc71fab34310e40df01022bfce78e5ac501fb53d.camel@kernel.org>
In-Reply-To: <cc71fab34310e40df01022bfce78e5ac501fb53d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 744d3859-efda-4059-590e-08da634d9110
x-ms-traffictypediagnostic: BYAPR10MB3719:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scZfUieVeDc4J8NICSDJjsJOOJZkQs+ER8fs0/KnWtgj7kTrCZ3DxJwKO2cRip1srAsYCHWo0yliq9OHIuIQAsTQR1Il5U0BFle68Tkn34zcbayAzjs6Y1amIi+E5/aXZNgEzV9QrIT8Sud5UPtGo4IQFi3U5wB1F6Eglxw9vI3JnXL3eyB3LxluZb6+NoeXI37qTao/oEGiEnhlR8PMF0uvMUJ9C2rh1ZhKKh7+3GjeGAsap4pZf9YnA4i3ojMzGKp+ZJD1fGqCZ0zfwgBXCowVKdUn3MvYfZG9kdl7ywnAHWGmRes9pY1BHIdzbPmvKJG5VwmwmeX5Z7vxaGQJ/rQ1kNXUzdJZKh+1u4wAO5OtJCjPOCXjzvH1aEEwoIrPkx1nQDD0N3JIUfugWn288ycKNTCuWibJdkdPy4xtKJOzGeBK5GVq4Xink9BxZmTt/uOMBqF4fNbRFpZ7CqVJGrSkJnQpvA8d+mOk/pnDXk01XBUn981tQeQwY/jk1/BV6wZR+gbjxaRK1808++iiyIRhmGipIE/EY1YMVLEoWQEWXUtFAUJhq8VXq/hccB75hBhC09neEPc1XcpyqgfeW+cifhUEUa9xfzmRUKY0uNXhG4/w1hzh8llNKd/NJjCGEZAXT9ifcbug6w42jGZdXy6gNcls3WBLNn+28PlvM6dWcVFJKV1A9lbFsm5kVH0uhk+qGifJhdxHyo383lu9tCJgK5JBIrmGk0Ejye1vVjYb66poxE24a51Dzj7eP8c1i8LmaxW75t4qsvQUNAhM2bFJVwv3G78maT41SrpQwMd3bPWoVmtZVOn3rpVjSiSpnIaBH/dQCQEPUk9XLbRQhAVZqxj5+A1focZJkTC7/Fg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(376002)(136003)(39860400002)(186003)(316002)(83380400001)(54906003)(478600001)(6916009)(38070700005)(2616005)(53546011)(66476007)(2906002)(6506007)(8676002)(64756008)(66946007)(4326008)(41300700001)(66556008)(76116006)(66446008)(5660300002)(33656002)(8936002)(71200400001)(86362001)(91956017)(6512007)(26005)(36756003)(122000001)(38100700002)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rNgQwaDrDWhRQb6lOWcTYy0NCl55H0JTBta8/oqRQx+tEBRwfybP+jkLrS+L?=
 =?us-ascii?Q?+MVoxdJr/wwzyAJ86cwEboDfWemrgBvdHMHdXAqLWOrymWTBXsk7Rb5uY5Pj?=
 =?us-ascii?Q?RG65TYpEGFNV0mZH51KouLD8FlhaLGazBL9cvOQaXhiyPjrrxTm79I8q99DT?=
 =?us-ascii?Q?WX0azW3/S8SfOKPIhFXXDZeXqfNUxUmpd3iaORaGwjqPY0mGGcZWTxOJtJh6?=
 =?us-ascii?Q?45gvrqJxpdZqsA1XfqCH/H1h+4CNVCJ5E0egRjHF5hTDP0vaJsplFSO/iy1D?=
 =?us-ascii?Q?dCv0R2CCMDDArd0oNm8C1vnfa1xh2N1/rkfwpngaEeqTFlLxEa16rP55wIsZ?=
 =?us-ascii?Q?Zc609tH9W2XjrKR8GUdPN5tHMF8EpcBF4uoShHFt0xnha6GK36+mQtp652qt?=
 =?us-ascii?Q?xmCWBydG8P29WUTrSUcUgPu1m3l8/ATHPTD3wwjQxaQL+/HQZCjbhScv4pB3?=
 =?us-ascii?Q?wqvWe8HDR1QuBCrLoUzqtxHznOyeW4uDm//4duEblyoyHiaNfstjG0pPegTQ?=
 =?us-ascii?Q?qttRUJYjY4awsGmu0PZlm1m9TPoJasp/Xa7cN8EVTO5SIZ5Pifm0L7iMwxFj?=
 =?us-ascii?Q?rECnJePCDmDvpuaTmp1rtyt/2L8j7Bxj/FM2nwE3/8xzARF7B6SzQmN30vz+?=
 =?us-ascii?Q?kAMsKU0x6WRjpJ9kE7tjU0UYB2Y+m7pycHxwtDiUgYeWBqBWEG+8pQRll7pj?=
 =?us-ascii?Q?vukNe8ZH6cqf0SeaRbLzsWaYneqRrZGZczJ4qqFWHhgi4QG7rv0T5iVyfUv5?=
 =?us-ascii?Q?JNd7J1EKJhZZp4ofIxnh62rvQuSaOBL1sF22YRLJijMvh9oOwZzSf0kh9fwE?=
 =?us-ascii?Q?09LN2da5HU6yTkRVY7dKb5GH0C+4yPsCtpSHoIj8AWbYMy3/mRZ5LpEnd/V1?=
 =?us-ascii?Q?m00N/BXOUzcCqBO0Pl5SxHd3kS/WE7EbmNQMD5wjRY7lfI+INSPc7aZz8xkd?=
 =?us-ascii?Q?538mJIWfZl87fr5wwUZMZ0j1JlfXYjekRB59aOHFz8Fr7y093xhuTYLWuukV?=
 =?us-ascii?Q?WBvC/BAInRgB1gobiuwQoLCqIbq/UQ0M833Tt16I3lJ4FlGvuKdjX3QKUGxD?=
 =?us-ascii?Q?4Ta9kEnIjo4Ecrn/OG5w8OHVHzuM35OhqPVjrKaCLeTE+4FiXKNcs5LkegQ5?=
 =?us-ascii?Q?M9FMNNiLEwoZPqHIweMSHB3MFdQfAUnxzd1lyuG3K5HhhOuWvNgxQdN5Q9hh?=
 =?us-ascii?Q?Xk9gO9GLEofboRYr9MAFSeieU6P+SDR2gZoBqGYX348+O5ZCUpV2mQJMrdKM?=
 =?us-ascii?Q?xtvNIJQEYJ3Jbi1Ah/WH7bL3NNt6V8ePH3yWJe0gm/tHmVX4abO22vwlJ0C+?=
 =?us-ascii?Q?XWptK+kL1pU1k6FT0mMbLRv2gC06kpjyG2jDt9rVh28teDqiMM2eY2wFCNiq?=
 =?us-ascii?Q?bqTgJ4Cj+uYuqoFsQDpl8cpRXZzlCkKuDc85g9/whDkDWmT5HaUYpihVjus+?=
 =?us-ascii?Q?zIZ9+qagegkSnfOlIXHc4+VZ2tv2eE1BJk2XWbRWUBSUMYXWrHiUhGPJ/FA6?=
 =?us-ascii?Q?nnCvnEbj/Ic5Y4EzFuFoGpzO5fup6pkurU4IpBfWC6Nf66S0zyG00BZNnp/y?=
 =?us-ascii?Q?p4LwR5WvpkHeSWtAlbJ/0ogrfXvq4bRfDHzTF/3L7mjN3S4jVQ+hPILCeF5X?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0587375D7EDF0C46AC67476A25B3E10B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744d3859-efda-4059-590e-08da634d9110
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 14:56:42.3433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmt1KMZUcHhJdNYBL2S1RfyDJC2fUWPCx7KkhjTLikEfcaKOgShYmqJ6Cxfh3lNnyX2VhRO/pn4nfbhpK91iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3719
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_19:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110063
X-Proofpoint-GUID: k27r0OC5_8DwaYjQEY5o6i2j5XEhG6xe
X-Proofpoint-ORIG-GUID: k27r0OC5_8DwaYjQEY5o6i2j5XEhG6xe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 10:46 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-07-11 at 14:29 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 11, 2022, at 7:36 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Sun, 2022-07-10 at 14:46 -0400, Chuck Lever wrote:
>>>> NFSD has advertised support for the NFSv4 time_create attribute
>>>> since commit e377a3e698fb ("nfsd: Add support for the birth time
>>>> attribute").
>>>>=20
>>>> Igor Mammedov reports that Mac OS clients attempt to set the NFSv4
>>>> birth time attribute via OPEN(CREATE) and SETATTR if the server
>>>> indicates that it supports it, but since the above commit was
>>>> merged, those attempts now fail.
>>>>=20
>>>> Table 5 in RFC 8881 lists the time_create attribute as one that can
>>>> be both set and retrieved, but the above commit did not add server
>>>> support for clients to provide a time_create attribute. IMO that's
>>>> a bug in our implementation of the NFSv4 protocol, which this commit
>>>> addresses.
>>>>=20
>>>> Whether NFSD silently ignores the new birth time or actually sets it
>>>> is another matter. I haven't found another filesystem service in the
>>>> Linux kernel that enables users or clients to modify a file's birth
>>>> time attribute.
>>>>=20
>>>> This commit reflects my (perhaps incorrect) understanding of whether
>>>> Linux users can set a file's birth time. NFSD will now recognize a
>>>> time_create attribute but it ignores its value. It clears the
>>>> time_create bit in the returned attribute bitmask to indicate that
>>>> the value was not used.
>>>>=20
>>>> Reported-by: Igor Mammedov <imammedo@redhat.com>
>>>> Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> fs/nfsd/nfs4xdr.c | 9 +++++++++
>>>> fs/nfsd/nfsd.h | 3 ++-
>>>> 2 files changed, 11 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>>> index 61b2aae81abb..2acea7792bb2 100644
>>>> --- a/fs/nfsd/nfs4xdr.c
>>>> +++ b/fs/nfsd/nfs4xdr.c
>>>> @@ -470,6 +470,15 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *ar=
gp, u32 *bmval, u32 bmlen,
>>>> 			return nfserr_bad_xdr;
>>>> 		}
>>>> 	}
>>>> +	if (bmval[1] & FATTR4_WORD1_TIME_CREATE) {
>>>> +		struct timespec64 ts;
>>>> +
>>>> +		/* No Linux filesystem supports setting this attribute. */
>>>> +		bmval[1] &=3D ~FATTR4_WORD1_TIME_CREATE;
>>>> +		status =3D nfsd4_decode_nfstime4(argp, &ts);
>>>> +		if (status)
>>>> +			return status;
>>>> +	}
>>>> 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
>>>> 		u32 set_it;
>>>>=20
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index 847b482155ae..9a8b09afc173 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -465,7 +465,8 @@ static inline bool nfsd_attrs_supported(u32 minorv=
ersion, const u32 *bmval)
>>>> 	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
>>>> #define NFSD_WRITEABLE_ATTRS_WORD1 \
>>>> 	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
>>>> -	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET)
>>>> +	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
>>>> +	| FATTR4_WORD1_TIME_MODIFY_SET)
>>>> #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>>>> #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
>>>> 	FATTR4_WORD2_SECURITY_LABEL
>>>>=20
>>>>=20
>>>=20
>>> RFC5661 lists time_create as being writeable, so silently ignoring it
>>> seems wrong.
>>=20
>> Open for debate. The protocol does allow a SETATTR. But the
>> specification doesn't have much else to say about the semantics
>> of time_create; contrast that with mtime or ctime.
>>=20
>>=20
>>> It seems like we ought to have nfsd attempt to set the
>>> btime and then just return an error if it doesn't work...
>>=20
>> The usual way the NFSv4 protocol handles this is that the
>> attribute's bit in the returned bitmask is cleared, so that
>> the rest of the COMPOUND is able to succeed. There's no
>> NFS4ERR status code in this case.
>>=20
>>=20
>>> but, I don't
>>> see a mechanism in the kernel for setting it. ATTR_BTIME doesn't exist,
>>> for instance.
>>=20
>> That's what I observed: there doesn't seem to be a mechanism in
>> Linux for setting it. Perhaps I should have copied fsdevel.
>>=20
>>=20
>>> Still, since we can't set it, returning an error there seems more
>>> correct. NFS4ERR_INVAL is probably the wrong one -- maybe
>>> NFS4ERR_NOTSUPP ? It's a bit weird since we do support querying it, but
>>> not setting it. Maybe we need to propose a new NFS4ERR_ATTR_RO ?
>>=20
>> As I said above, the protocol's way of dealing with it is to
>> clear the attribute's bit in the returned attribute bitmask.
>> "You asked me to set this attribute, but I didn't". Clients,
>> IMO, will be more prepared to deal with that than having
>> all of their OPENs fail with NFS4ERR_NOTSUPP.
>>=20
>> IMO explicitly setting a file's birth time doesn't seem quite
>> kosher, and it's not a POSIX attribute anyway, so we don't
>> have a standard to cleave to here (at least one that I'm aware
>> of). I'm fine with the patch as it stands, but I'm open to
>> hear more opinions about this.
>>=20
>>=20
>=20
> Ok, now that I looked over the SETATTR part of the spec, I agree. Just
> clearing the bit in the "attrsset" mask should do the right thing, and
> that's probably better than returning an error.

> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for your review!

Just because I'm not 100% certain of this choice, I will hang
onto it for a few more days. Also, Igor, please feel free to try
this out and reply with Tested-by. I do have Monterey here to
do some simple testing, but the more the merrier.

--
Chuck Lever



