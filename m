Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C6779CFE
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Aug 2023 05:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjHLDaD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 23:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLDaC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 23:30:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D25C5
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 20:30:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37C2uACg024880;
        Sat, 12 Aug 2023 03:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=r4qOFnTM5AqLrM+ox+ABGko9X0gZa7r630YW0VmZRFM=;
 b=FnIbhZRGD+D0ROR2ee4jReEOKifdW2TnOfFYq27QBZYxUqTsPTG4zydeFyBquJiSZ4E9
 CTG4gl1ZMEXfyEcBSaklOmTQMszw1BTRApOtwdRmH78hG2ng3U9E2wsbqOrLH/qNd2km
 7LlMlZWJLX4G6kLML4TvC2AKhRRkDTISdxI7nntpbBEFkFVxpusGa5BBIlBluevA3Ate
 BAbWvZewVmdTpAqG5sryln4YNVrty1DqhSFJb3H2cgsaDeLoUattixKS2p854iZHcLoc
 ZLh240XgcfuxgIv09VLnL3v1JT1YV8LaHJPJLudGyP1CO29qienNasMzhV/MnOqWzBHg Yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se0v3029c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Aug 2023 03:29:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37C1Ws3n006860;
        Sat, 12 Aug 2023 03:29:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3se0h19u3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Aug 2023 03:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAk9I+diSPimuU8GE+AE5m2XFqQNbBXK1Rcms1hx0oDU6YVjERBzw3i2mAawHQJqCWSuislvtJPG/Qu4tBuqKsGwQt/uqrtISlftnh0UynPf8yfXpAWDAe9X+FO6nX9UWlgsFaFaxRjFnYtW52yUk6Knsz58+senskRx4CNCJklIfg5Tndjl5kyWEjTNXNOleGw+MMS3v9lGI8a382wvYjYtFTicX0XDEHNIFoCCgGjN1DBvn+SdOg5VplDYZPCwFQ3QmD0dY+OlmwVqA/aFktWHukcA5LwGbMLTpZ23ufW5M1qEdB0CYzgVpY7HjHaL9lieGnq+oQs2QcfoEhO9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4qOFnTM5AqLrM+ox+ABGko9X0gZa7r630YW0VmZRFM=;
 b=PD67XG8fPvFpt9wLeGsA754d6chpF8BRkrayrcIkPvkhiwLGklQXRdHasEt8mRiDGvhNhhBieQ5GOGi38hICJ1jLLR7K+J9z6mk8tP4Ey59bqZMni68z1kH2JZCxWMhn/ZHY/v4lGXwJ7Rq7gQsDNucaDeCmTlPrP5zZpUsDrkFq0ddYg6y1wP9LL8npIJtUrzVDD4kky/1UGv8ktKzYcPjDwN+izO81hCahF9XU+X7eQd/OtA7UFYZZIshQ0Z+g+z/QCM4I88PKkmv2VRVllT5zHQG+wnjkq4PToPFGg9ChN9iXLlChH+Ql/cggifo5LzxU+WYkWsG8Zd8k0tLe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4qOFnTM5AqLrM+ox+ABGko9X0gZa7r630YW0VmZRFM=;
 b=BMyebtjuVtHem7pm/M8lAWHvzvwKGDjvVrNWixY+bnv9GuVksEDxRm4kZO7btXIhERutWBJ40cgqpqJZpXka8pYnv+oSPO/zLTAopR3IHyTxRMrJPnaG9Re+0d7sI/93wfwYCnVamxHEByHBwguuhgArmf9KZP1VIqYtaoow4PI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7709.namprd10.prod.outlook.com (2603:10b6:806:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Sat, 12 Aug
 2023 03:29:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.022; Sat, 12 Aug 2023
 03:29:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] NFSD: allow client to use write delegation stateid
 for READ
Thread-Topic: [PATCH v7 2/4] NFSD: allow client to use write delegation
 stateid for READ
Thread-Index: AQHZqvWWVa87zTcsc0+PkdjTnu1klq/lmuUAgAAHBICAABYBAIAAAH4AgAAXvQCAAHRoAA==
Date:   Sat, 12 Aug 2023 03:29:54 +0000
Message-ID: <9CF31D79-D696-43A2-8156-3ADD8335F271@oracle.com>
References: <1688089960-24568-1-git-send-email-dai.ngo@oracle.com>
 <1688089960-24568-3-git-send-email-dai.ngo@oracle.com>
 <6756f84c4ff92845298ce4d7e3c4f0fb20671d3d.camel@kernel.org>
 <83cd1107-2efe-f16c-2015-3da15aec12a5@oracle.com>
 <41b59c4a1359c5b0224fbe95e9fec062b6d8bdbf.camel@kernel.org>
 <524E999E-2988-473E-A18B-9617ECD30E12@oracle.com>
 <aa182ccb2c879cee94a89a11c85f6aa15978452c.camel@kernel.org>
In-Reply-To: <aa182ccb2c879cee94a89a11c85f6aa15978452c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7709:EE_
x-ms-office365-filtering-correlation-id: a9b3b212-e2df-4787-93a4-08db9ae4657f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dL6n1jCFiDiYg6fci6s5yq8wZw6ZcLWvs23lh5Z3QJxJ1yLOwtYQy32awIcNoH+3CEPAd65FzZFrsIEymsJHhrAndXreyX3JTC7PeRQMEpEacQSu51DZKunmw063fmGsAAAWrsOI9V70GCwN+jnn/sHWyCDPsoG1SB8pdAFEyPy1mHjVSHgDvm7bL/ntdV9kQYhZeLFYrSeyNxUH7lo3b63pdcMcdShNV/4zlH6Hb4fuadz2iqKXrZ9cRtVLBvaHKKSN/CjIx1vLDIeQzUN2U1Wy3v3dqSVYPxTslBLA9cpZkpk0rutqBOwLQSd5LrRLgN5PjmMkpZgM8/NWYS4ah01xBlR5oTFDghdW7mLiMiBxzQdFX703Os1lHIKlUGDA2zAYmdhhN8ZJnpPzyzGkQvwYcKgh09ZMkU0mS4l5nO/i4VwHvcwwoMR+75ya62i0jYTeoqYKGDalvvntJjypJ0n4WAiCJuvkFuwxugaNHGsJWb2vKDBFv/Uyy28UNEKGWaCrk0hgAZlB3NCj5Qpd5gTaNT9AvV3QOnhr5YAQFG7ak5tCdOKQhQIapUs0Q/lPMoMwU2JnvoLQ+bhQHp3wMG7FWdEvk1Yy1FJrZlbCXUwCJ6DqNX/5g09wxQehFWoIBsc8b/khR4quRfpHdVJl1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(39860400002)(376002)(186006)(1800799006)(451199021)(316002)(5660300002)(91956017)(41300700001)(33656002)(2616005)(36756003)(26005)(53546011)(6506007)(66446008)(66476007)(4744005)(6916009)(38100700002)(86362001)(64756008)(71200400001)(122000001)(38070700005)(4326008)(6486002)(54906003)(478600001)(76116006)(6512007)(2906002)(66556008)(66946007)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dxIyNpaSGLsoNW0hjTBCsljlIy7uxVJFvFDz8/u+FUhH0nADHDJUPIns+hjs?=
 =?us-ascii?Q?z3twG1FzVkzZH9Jx4d1H8bOwyrNyL5/dmLm1aCiHERqSiFCry0BPLN60QThd?=
 =?us-ascii?Q?TIhkLhREOnJy24J6HjLCjN1B+bDDL/G8sGXE3v08fT5qKIup3rtmZ//W3J0d?=
 =?us-ascii?Q?bL3d7SPnrS2F+LHdp3yJjWx0noe5Uy7HV9oBE4SbD+TSXI2HeNCiO6xUQdte?=
 =?us-ascii?Q?LLDLueM18H6LrrncpRfLHqjgNSGuo5LMdZQnb+LstZuOGVrJkhjAGku+q9RZ?=
 =?us-ascii?Q?osRiwCh6XSSuXHMWAcM/XxW3D8XGLDBS9KCi8G4Psn4BIfZbPi2ajgSsdZs9?=
 =?us-ascii?Q?gkHCwL0vW9xOFk2bFqkmhT/O9fnmN6HKzpPsEuCNLe5W5zGo9KdFv6GjU4vo?=
 =?us-ascii?Q?lkmg2FOAJgKw6WdaLYQEeao5sD1ngmeMNikVc6fLSnvmNBm052Cc786MU8A/?=
 =?us-ascii?Q?mGWRMuC8KH39OcaZBfawCIMWRglSo3UVk4Kw39qTVehTd4qWNMx7gL7BKaMR?=
 =?us-ascii?Q?o6LKSO6/VtP+kHF/EzNrfqaXGeO1nIZePYAC5wAR4xdoUU5Zcvhk0oM0fw1J?=
 =?us-ascii?Q?kR1RnHKcyvpqFfD5gaEAUBlWlyAjgum7Zm5N8YG0b0wqix57MFbuKWmVrOKS?=
 =?us-ascii?Q?7gDKIZdBFwY21cCyFy0oWsWS3ZHkQh10qsN24vUHe4Wrpo2pB/06emLsoRkv?=
 =?us-ascii?Q?3X1VvGMuwyp4d2W++dQu4fe3C1+RCsQt8W5dvwPSe0v67w6U0SsGvpjfikO6?=
 =?us-ascii?Q?Wapxch76hgFyUMj9JzxbVuMABLhAvcPz1gDkgTBiQHfJzhUUCks+SKo6dLB0?=
 =?us-ascii?Q?JbudJK8l0qEB6f4k5/p1b6HedWJSleJ5KOtunanlDtoMQghotOW3uatJaBC7?=
 =?us-ascii?Q?K/dkyIBrma8p0GSrwZDrLVrwxT55qI4TDj1RzdNX5u6gCQalyMwtwHuq8wdj?=
 =?us-ascii?Q?+emso6KY2XGFM+fu+SuLq1P7D+f5g09cKPugKK+jHESNHiqlTIXNSrC5fXTi?=
 =?us-ascii?Q?/krB5Q6ywv5nVrAEZfa4i1LJlRIAjlV42bqofEPlUeX5D744V3ZPzWl19CsV?=
 =?us-ascii?Q?M+ucvokMQ7ia22SdSTEDiwdY3AKA8YU+OmQqMdiyNs3ZIlgJyrGhKacv+BLh?=
 =?us-ascii?Q?T993Dyx/VPzteY9+XmjW56E05sATx3xxAOtltdLX5Sd64bzNba8VXqpbdMM3?=
 =?us-ascii?Q?cwHHMNp6Ug5PFjJGCRKHlFk+XF9JbKE66kyv00EY2BJyheSAz+Zzt7U5bHPU?=
 =?us-ascii?Q?4rHIPnuwxcR3oTeW/Kfg2EHlqcIR3S0IC6FNwYCVaMBPprALo/vwou0uRcOO?=
 =?us-ascii?Q?sQpE7rUypktvLL0CzJcXwgpmLkrf7Te3FT+A6Z4qdmj5mGvjbXxLmgUUw1JO?=
 =?us-ascii?Q?kjAs73fIEj9WLlewA4zv5ti3QIiKipNzpvKBUdNcm38Et4tYkBFJj1DqHSVW?=
 =?us-ascii?Q?n4Ab1Rs/fR5ehRc/pxEZNKjTyGwaDlc54ulELCGE/R7Im3wkTUwn1LXr/82F?=
 =?us-ascii?Q?Q+4yQycuTSOOWGO/bqRexboUa/N8b1id9E3qyGz71DM04OMcmVp6PpWHmNgT?=
 =?us-ascii?Q?7Q+biXNEq/09Oj259kNwO0pvoZdO8+wknVpPOLdyZ219oac54rtpNMy9lcKU?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB0392D204BE8A459BDCA32E399AFEB3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5gsNbfjUdLRGLMa6xpD5NtKwwhGb9AKf58YFRYFdMo0Qy0w2sO+0hsFTTybKt8k+V5lImwX5dJ4s5HGxK0UZKW9OpQW0OkVMbGzRrtjPfycRxxWCsCs7P3z165tcCcBm5+ZbaafoWH/3u6F9pCRNVHWs+5klrkTNIhqIZhbKZ8MGkJdYuU7zMNTE7B2Ud0kqwx7fxukfCVQh/AYcsC5TaCRgiWHVKJ/XnZRdnQ/89B0j2fWq2Yo6dV7hWRskEVh4ODBzmarTr1yKYEOdbsOlTaaV0D/uVNQEXoTu6rx4Uc4LsNkO+4SMREJ6Koza2sc1Kl/gDumGyL+tCV43KRcxW1un401Bvjccq3zp9zYGplsn8kcBkFClINFHgOxRXOyktTL8tBe+irDzF+Kx+Cny0rlwMKVxuQ4CWZ/aq3WDtLwmQ4X/J1iQKExZsoErsVvPicpKmgUv1LnEO5OeB87qIbcYIAw4PdqCnrIx5Ki+iEcnUfNSGMrNNgUhmBsd9Gb749q9XtIt5nq62Zji9W0tkGFIDEYngyd8apHc6xfLFkSkqrNJjM07tdzCHkRi4UiXlVmJvDU4XuEQqSWFgTxcnPVUHaCvCEyLl01Y1TIHJNv3S8vIQ74+2PhqcBe3dwNTh+GdtRpH9+8SZjfUYnx+wRsNKt+Vza3cVqAkERYN3fmvXiBD9L+XaoqywhzxNj+zuKi+EZ91pi3no/Xr1P56P6G1ASK8BlQZ0W6B+en2VPzYhIgyekV2o72f0i+sfp8ydPmJwbCFe8byH/BUYO4OvxDz9qYZp3o0+dasK7EKsLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b3b212-e2df-4787-93a4-08db9ae4657f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 03:29:54.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDnh0vok7XiMEKjPjR15jUYRidC4AGRQ2KfHG5N5xdjXMUWr1VCfMShNWH29BywPnH29+NP9ExNEvbV9USevZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=765
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308120031
X-Proofpoint-ORIG-GUID: u4-8K4LIk5djP9VKV3hdl-Q_Osg9pJUL
X-Proofpoint-GUID: u4-8K4LIk5djP9VKV3hdl-Q_Osg9pJUL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 11, 2023, at 4:33 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-08-11 at 19:08 +0000, Chuck Lever III wrote:
>>=20
>>> On Aug 11, 2023, at 3:06 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> Yep. Reverting that patch seemed to fix the problem. Chuck, mind just
>>> dropping this patch from nfsd-next?
>>=20
>> I can, but let's make sure that doesn't break anything else first.
>> Send me any test results, and I'll run some tests here too.
>=20
> Sure, results attached from several runs. These are running "all" tests
> in pynfs for both v4.0 and v4.1. The kernels are:
>=20
> 6.5.0-rc5-00050-gb1e667caad15: your nfsd-next branch as of today
> 6.5.0-rc5+: gb1e667caad15, but with this patch reverted

I haven't found any problems either, so I've dropped the patch
and refreshed nfsd-next and topic-sunrpc-thread-scheduling.


--
Chuck Lever


