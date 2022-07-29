Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ABE5854F2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiG2SNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiG2SNr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 14:13:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1566B8B
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 11:13:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THx1nP008328;
        Fri, 29 Jul 2022 18:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NkRnEw2xsqxBSrgyy/6f1U5iIigZ4ipZQf7R3897dt8=;
 b=baxnNX1KOfUkJHD4iwCCYPoFVrAHwuNs37hqOklplGlNbT3rkhrkZI/NEfwf3eszjA5e
 +eOcQfi6bEnB7g/K3Dfq+rzw5mFYPK5Zo8sdMWBfmWWO64wxPsTYct0XFrewHCthy/15
 eklZyB6g+XJuBjPccYkAF2rsZzPjIi9d4e4yjGRdss6mzg37ubkdk5Dy2vn/t0HgoZ0I
 JfDNDiExxNMQDensgLIm5x3yCePej5R8HZBAXdNz42BZ359Q4e0uHZegHwjHlGiYX9g5
 OZTCMIxRfXX+AXpYbUacJHyfLk7LaQi5EThJHq89CeMJZbU6HLFPG6X/Vrl5hVx7+qhB ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940ykg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 18:13:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26TI3EHl016643;
        Fri, 29 Jul 2022 18:13:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh654g9gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 18:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo/u/15lKEBD9jga7Xm21iT/ltpuEvphq0NJQwNOrKYnk+sbQEOBw5GUQFaQx1JW6Mey7+7u3H8Q/wSmZeeH9T0p76TZnY6efwMQ8OXaNCK/Mn4OtMj9Lwm4rtbfxp5KZ6NJXhJb6NZBNWD9AXA5+TWwG18bhv200jWBjQlEuFE+Hpzn/Tflolyf16yeGjJbaQ8+92oYAlv6GSvgxFw1CBTTa/Lv0IcIeEy5tbJlwYgMzrVzCzHdDCO0QsGEXaF6u+IuXpeSwCVeLrLDb1S3koTnGG5y8lMRbzORK2cfyIgAbGZiUb5h6gBUwFWDbyvD50wOAG1aHs1+llMA6FSTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkRnEw2xsqxBSrgyy/6f1U5iIigZ4ipZQf7R3897dt8=;
 b=Avi+nMt4ozs6F197enDlI+ArqtG3aiZfwIwp+e+XnVZN+hxNKTrXzgga9sd1IrFy+h/G8i8krJdKXBJvIp5euDRIWirdVNDfVYJY+mP65+bMvrlbGG3RJ8LAECFiCFHJTKdqO2YDV9tBr0FQCzWdo5dcMRDADFWBE9M3XWmL64fa5kIHYhlTXgmfSc3CtO6972DTLJuYQuMn/8Gy6SciLf6P7fEmgM0c9t3gX2KG3Pj6v7/G0WlbyxgTXzqD18vyMZd0w1bJBy6fomx0VRN+W90XbieVHUiKDRpBYumsn8xVesLxsbE8kYDFD9szyv2HWYhxtAxSRlyk2buVQpQNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkRnEw2xsqxBSrgyy/6f1U5iIigZ4ipZQf7R3897dt8=;
 b=imPABIEajnW6Bz4rjeh1UyTwoZyfDzXFChQzyrMIPm5Wg7owgaMZUYVH9nAAiTKXjzf+DmJjDFTrGDmUc1Tl1vJ8HHh4Q1OH4nv8ycA5A99VFQRLVYRl7yhupq45WlGu/bAc5vDYO6Jj893kUt+O9pJZuAvMPEV+9WywJxwBOGs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM8PR10MB5479.namprd10.prod.outlook.com (2603:10b6:8:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 18:13:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 18:13:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Topic: [PATCH 3/3] nfsd: eliminate the NFSD_FILE_BREAK_* flags
Thread-Index: AQHYo2rgY8a6WWViM0iW0L8RSDO/l62VmE8AgAAD4gCAAANOAIAAB38A
Date:   Fri, 29 Jul 2022 18:13:35 +0000
Message-ID: <79C3E2F0-E5A6-411E-ACB6-D24BCFFCEE41@oracle.com>
References: <20220729164715.75702-1-jlayton@kernel.org>
 <20220729164715.75702-3-jlayton@kernel.org>
 <5B5182C2-2B5D-4863-A6A4-8F3A6098A9AC@oracle.com>
 <de316707b0bb7e73d16acf717253367578e7f05d.camel@kernel.org>
 <84AC7FA4-9DED-4435-8504-310F6F41C130@oracle.com>
In-Reply-To: <84AC7FA4-9DED-4435-8504-310F6F41C130@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28687751-7547-4155-a997-08da718e0ded
x-ms-traffictypediagnostic: DM8PR10MB5479:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vzb3Ofi18I35dZnZ2Mfg3BhDIWSn3kEceTXBglEFpIXxvDokWhVL+wXGhSnl5SSxY2tfhrfusq2NuawNj2qSp1Tit22GM9WArVmGeA39pQoFF99+Y7jjJ/G6X7RW+q84mshwWTV6UntfgkTVmAyQIh/F/B75n9piRbPalvi6+Pi0sUps3q6blyIHegQmGLmxwFZUuaaFcavUu4ZHwNYMEAJceMAlzx/xXslh5/p6cAysOl1YfgmvLTY1JpuuYHOh2tajfoysh1H0vYbLcjf5Ku/8IDTS81fkobS/RBhO6KCj/qSQ1APwsWiVGrLxPmUXdTZ7DGz32TkXUIm11HJAWx3MUgqSw5PihR39i+CdLEwMfPysoDcwZBj7ySrg7RgRF2qj/SUj8kI0eWzPLgWHYbqxdrwVM6u+QtTzgsI2NqLQq8YKVptPhOpPeOCgz1B+AK+NXDFxsZrtaOZwyRuJ2bX8OwoAQXTaFBqvAZNS4Gf6xaHtOuUYBUReoGuU2TlYy7rBB6Gd8dE0Z8AHDgAgKKEF+hj5yd3RPmoKojBd+YtqgziRYe4XU+EOPNrf16iHtH2jgFUTHnXsA+7DzgSjT9dmJSwbLcyt8SFEEK2qRVIqaMU1ahZmIPdTtTqMWr4r3j2E/D0PaSxxo3n7nKimi00+00AywCr+POKOkItrON5eGPdTr2zIe6f4IHaW4y3tWeTLzbHnDU6xR0pZihGiBUOWTZVZIQeEVXoHikzG8PkeGmBUagsQVi8fz8ydN0cx34vv3PFseLeaAqP6mVTwhLzVD6rE1ufVtugtcLSgwMLMUrNtRZVeVLWf+XQiVGrwD+qcbN5tRZv8C9kuRvkS9sjF5PpaUfTEFVwVWjV0AkAQNMoJffzlfzT6yYF/9crx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(478600001)(83380400001)(6506007)(41300700001)(966005)(71200400001)(2616005)(53546011)(6486002)(186003)(26005)(6512007)(5660300002)(8936002)(316002)(54906003)(2906002)(6916009)(66556008)(76116006)(91956017)(66946007)(66446008)(64756008)(66476007)(4326008)(8676002)(122000001)(33656002)(38100700002)(86362001)(36756003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EgJYwERnTjYWqYZ6DKErfNpffnhIfTHjUwoOEtUwr3xAJ3uHFIiwe84M3dgJ?=
 =?us-ascii?Q?oOcgznnQRK2/VnzQi15UcafwReXRxkZCqCGWZgrK8q4vdOu/QOuFeyZTgvMp?=
 =?us-ascii?Q?jf37Zpx+Qey3As1klcmipC0eEmNMFp23l13cxXlFGi0D7OGCbSzr7Im9YcjB?=
 =?us-ascii?Q?Uu8dA/phNKbmvvNMgmGqPImBEtjwsEdUWHPhGpDIpHr4WeuldbCFcqOryssU?=
 =?us-ascii?Q?alLz+eK27kpyUYlp4NaUNlXxVk7n7KqbH0C9uReO6TIiv4MzLXabyYxjSnZn?=
 =?us-ascii?Q?j1V1Yu4Y2OEl2zw2hCc6L+vfcmFNLQRDVDns+cQ8fB6t4YRsp6qTFxDj3euD?=
 =?us-ascii?Q?eEpmhTdv0KSyjsjN5N1wsnfEvV7REWZD3ZfXjNwVAEqPLVI8zfL6wmxW27iU?=
 =?us-ascii?Q?g0KcAJsufev6pdmQd9Y2ohZ5uMsSBlLx/6bUlYOnkBhprn+slwhuB8CbRCxC?=
 =?us-ascii?Q?gaVgObS2G5XqhFRDTxtnV75+EqCFZ1UQ9SvsfceBdiVS3NT0kVIsaEXucmoX?=
 =?us-ascii?Q?tpVxgtWWeEvRDArVK/zrngUrUThRXatFM1Uup1ae5RufVbzf5BnGTzC+b/kh?=
 =?us-ascii?Q?Ap+gMTE0dyDCIsMrWmDmsz7xkU4Bb64hRvVIsIuM3bfczrrcZHUZg/3CkpCt?=
 =?us-ascii?Q?x/gOOEW/QLOpfA7cyf5hkVr9s9U/NxXUqujTogqyvI1x0iKpbs5C57LL+YDI?=
 =?us-ascii?Q?+lNsPE78cX8fkJ41Ry1aUsdSB1UBIubRI/M7/Q+TJkPdW591B5L1sKtPgfDQ?=
 =?us-ascii?Q?IHWXShIZOejRJPL6SGSE0iXOQIV07r6gEz79bf2HrdqVMfGN5QvTTtOOT0we?=
 =?us-ascii?Q?fX+LCk6CJ8fJuqZt4aHokjTSoNWjPtqnnwdODjPAFfI76Dmkb2jfZ5uLomGy?=
 =?us-ascii?Q?RVc8oV7yJGumv2yhZD3rv7lALx92fYDuz7ibj66x12ZJrdGM+b6L5AMuyVlC?=
 =?us-ascii?Q?CpY9QxBi0Ax8AhzTd8+dXkKhcRHL3W9pCIkU/W76hKgb1OLzbVv3GBg+g1CX?=
 =?us-ascii?Q?wbLBTDg6CX67Mg66cbHTBwSpE7f0rbSPddrQgbMv5MRwd8R+S0l0Lc2QxHVU?=
 =?us-ascii?Q?I1NawKlqkUD2kjsfzbGaCiQKKLKIboDvdlcCpk6dqq195ikE8UH2eiUw8MzC?=
 =?us-ascii?Q?STWdT5yPk+Tu0y7VNMo0/hkHjaiRgrzjZEn/1PzB8bk/wXAV5gWwvEXpM3JT?=
 =?us-ascii?Q?zWXvFhrGZq8LcT34yP1g1xWMRanynmEiGP3C/i2SUoxHk8p69PLeTaLUTvp1?=
 =?us-ascii?Q?aQn7JyZOcV18hMGn1BNJeMAJRS18T/x+g9RXM9Wo2sE6il6jpaiyYaeCw8G/?=
 =?us-ascii?Q?znn7x0bDpVNDuw3E2f6KGu0xt1wXfon38wbxWFg/iW6eVlO1V2lXK3UcP46o?=
 =?us-ascii?Q?Mypu9BZBftnTrY7GqYnzr8rZ4zSkvc/QmKL8peR1heu5zSn8AtdNJtWd3kfe?=
 =?us-ascii?Q?vWdfIcJUAjEOZ/WbXfN7Far6FhlHO3WXIIMT5EG9e7LOgJ+hnea/QmQyfLQl?=
 =?us-ascii?Q?aBwDF7Yakey3MCh4uhcb/ereOccuKby07ftDWiq8c8/lLmi3XGrZGaqBKFFz?=
 =?us-ascii?Q?ioA1xFq+4e8LW9A62ZyS15kCruzQpEFWcgNuitt4+yumxK/uScFUOAezWd1i?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D8F0AF915CFD14293DC10F55C9E45E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28687751-7547-4155-a997-08da718e0ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 18:13:35.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vC4SpkABg51y4ML5620c53tVEWgtScxTzQKX9touDJsJefKn+VtuyqjXge8fTiuLL0mXyQwH/+fjulq+g68Iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290076
X-Proofpoint-GUID: Vc4NpI8rpb9b-A0oeX3QlxQG5kYl2mWk
X-Proofpoint-ORIG-GUID: Vc4NpI8rpb9b-A0oeX3QlxQG5kYl2mWk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 29, 2022, at 1:46 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jul 29, 2022, at 1:34 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>=20
>> On Fri, 2022-07-29 at 17:21 +0000, Chuck Lever III wrote:
>>>=20
>>>> On Jul 29, 2022, at 12:47 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> We had a report from the spring Bake-a-thon of data corruption in some
>>>> nfstest_interop tests. Looking at the traces showed the NFS server
>>>> allowing a v3 WRITE to proceed while a read delegation was still
>>>> outstanding.
>>>>=20
>>>> Currently, we only set NFSD_FILE_BREAK_* flags if
>>>> NFSD_MAY_NOT_BREAK_LEASE was set when we call nfsd_file_alloc.
>>>> NFSD_MAY_NOT_BREAK_LEASE was intended to be set when finding files for
>>>> COMMIT ops, where we need a writeable filehandle but don't need to
>>>> break read leases.
>>>>=20
>>>> It doesn't make any sense to consult that flag when allocating a file
>>>> since the file may be used on subsequent calls where we do want to bre=
ak
>>>> the lease (and the usage of it here seems to be reverse from what it
>>>> should be anyway).
>>>>=20
>>>> Also, after calling nfsd_open_break_lease, we don't want to clear the
>>>> BREAK_* bits. A lease could end up being set on it later (more than
>>>> once) and we need to be able to break those leases as well.
>>>>=20
>>>> This means that the NFSD_FILE_BREAK_* flags now just mirror
>>>> NFSD_MAY_{READ,WRITE} flags, so there's no need for them at all. Just
>>>> drop those flags and unconditionally call nfsd_open_break_lease every
>>>> time.
>>>>=20
>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2107360
>>>> Fixes: 65294c1f2c5e (nfsd: add a new struct file caching facility to n=
fsd)
>>>> Reported-by: Olga Kornieskaia <kolga@netapp.com>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>=20
>>> I'm going to go out on a limb and predict this will conflict
>>> heavily with the filecache overhaul patches I have queued for
>>> next. :-)
>>>=20
>>> Do you believe this is something that urgently needs to be
>>> backported to stable kernels, or can it be rebased on top of
>>> the filecache overhaul work?
>>>=20
>>>=20
>>=20
>> I based this on top of your for-next branch and I think the filecache is
>> already in there.
>>=20
>> It's a pretty nasty bug that we probably will want backported, so it
>> might make sense to respin this on top of mainline and put it in ahead
>> of the filecache overhaul.
>=20
> I am a generally a proponent of enabling fix backports.
>=20
> I encourage you to test the respin on 5.19 and 5.18 at least
> because the moment that patch hits upstream, Sasha and Greg
> will pull it into stable. I don't relish the idea of having
> to fix the fix, if you catch my drift.
>=20
> And perhaps when you repost, the fix should be reordered
> before the patches that add the tracepoints.

Well... let's rebase the fix, but the tracepoint patches can
go in after the filecache overhaul, I think. That should make
it a little easier.


--
Chuck Lever



