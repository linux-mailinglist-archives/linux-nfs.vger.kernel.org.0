Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB95AC005
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiICR3Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Sep 2022 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICR3P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Sep 2022 13:29:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FD756BB9
        for <linux-nfs@vger.kernel.org>; Sat,  3 Sep 2022 10:29:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2839D1D2017559;
        Sat, 3 Sep 2022 17:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fMlcj6rVA/hXEbWHpGCqe+d69Dw5niWvzX/IqPs1sRg=;
 b=b/kRKBAefmKsRTy/8BNFkB0fayYlEaCBqgm2lUuYn4CtTYdZykp915A3yDXCUGnO9mb7
 4RO7oLrY8KXnmg51vRtBYLiOOtCmcl2Y387H66gEMAdThN247qd23Z9Oa422Wf9ayg4B
 Y8E93V0/iMZemxL0LJYajL20wsJlQ/yPm3FTgyf4Bg1/p627FvZ6gEc5zFX8b/nx9ade
 HveYhwea3rOXvbAW7GJRaLYXG+IW4R9TflnyeJk4JZzUz+pQI6P0L2ZmzYEALi/cFYVh
 1SzELuW4AYjILBnrYSeFsn4xBMsOn/EzW7c5DU4gLz7ikTRavkcCSONY1Jwp1HWpxql7 sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq28vnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:29:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2839LlcC028661;
        Sat, 3 Sep 2022 17:29:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6u2ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Sep 2022 17:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWyOWShOUvTU87B5y8R9uE92AZC/zUwmZKpI7ZCfCxDEGPSUpdu/+bQUAemtqEtGsIokE591HiTGjk97hiZzTR4RPtTb8vg6bJzvEC7pyYUVSCRv+tVvt00jySmV+EtE2TKt9FNdtpBlCKnUOS7UzyeDOkwT7CYms+wvG5c4bwkthskTnw/GCOi3QZrbM5CCGj5sPApkfHnGoDFqVx+VUZrnqLmPrUCzOiPWNtu9Cg3bDvfwyyNVo2g8XH21LYyH+sG3X5E/v0xTUfWci8lEN81eizOHA6+YAqVCSLF1l36QN5pdE+ZHx0+Y9cEygeEFYyGJETgrt6t6SbBA0j62wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMlcj6rVA/hXEbWHpGCqe+d69Dw5niWvzX/IqPs1sRg=;
 b=aFGjI3zXfMEqVFRbqV5OGvNFFfSD6XAhpj4dlwrfJmgebacGidcOpSbMcrRRNZfTSHJd88tGx6hI4r+mPuFp3bGBupu1IcAVz6BtDUCGWt8DXH/jjxD4Ecs09+6zMQ47KHvh1DU0b18R5TbCNd52wckUlKPrgGUqvfeXpaqJIK1G7ahO9nM484KYeeqtH1jG7fBnI8EOEQVCUhQqqItK3xko8S3qwMGkAxUwbMU+CG21RqXY/KX6Z079gek61v4k6bp/xfI6GTSrj5cw5s/70i45LAWD2mCOx9sWfPUtxv9hWUljeViBIJdnyGzLWgPavCIQWhE0oZuoKOl4nbUOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMlcj6rVA/hXEbWHpGCqe+d69Dw5niWvzX/IqPs1sRg=;
 b=SyvAnRQUEzvlrHIEzjbf6m8X395P8/SB9HwoQ7wqhPLshA8k46zSAQvoVZ81J/xcidcO/Sicr4pJIrQwwSftF11mNE5DZMGbhi3gPN0wLo6pLWSt78MNjY0OaNcP/qVZma9P+V8Mhq/QWpIdyyxJDicia3IbxkxWqt6RYOqYZYU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4881.namprd10.prod.outlook.com (2603:10b6:208:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Sat, 3 Sep
 2022 17:29:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Sat, 3 Sep 2022
 17:29:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on low
 memory condition
Thread-Topic: [PATCH v4 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
Thread-Index: AQHYvLpF3IXRGSf70UK3afu6RNBIZ63JEv+AgAJR5wCAACuHAIAAzI6AgAAUu4CAABrwAIAAYjKAgAEFzwCAAAc0gA==
Date:   Sat, 3 Sep 2022 17:29:01 +0000
Message-ID: <5B4E5FAA-5D46-4E43-962D-64AFDC035C41@oracle.com>
References: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
 <1661896113-8013-3-git-send-email-dai.ngo@oracle.com>
 <FA83E721-C874-4A47-87BA-54B13E0B12A3@oracle.com>
 <2df6f1fe-c8eb-d5a1-0a11-2fd965555a33@oracle.com>
 <7041D47D-ECB3-497E-9174-96E9E36FFBDE@oracle.com>
 <eb197dde-8758-7ef4-8a7b-989273e09abc@oracle.com>
 <3CD64E7F-8E81-4B37-AAF3-499B47B25D19@oracle.com>
 <fc5a3aa7-af8e-656d-a16e-c07c201ec62a@oracle.com>
 <44A716C4-3904-424D-A5D6-CE46FC9145F0@oracle.com>
 <2b9549f8-58ec-be8a-1b15-3a6d7751a04f@oracle.com>
In-Reply-To: <2b9549f8-58ec-be8a-1b15-3a6d7751a04f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea563496-f337-45b6-a4eb-08da8dd1cac4
x-ms-traffictypediagnostic: BLAPR10MB4881:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndNr4GFSbzIOsfDbF7q42mu2DYxKLVm2yvxWtsfH3kXWjlcivuaccRSnIrHcMGrtU6YRDtvpXqZXAK01upMlVHaYBEsnx8a4Y+FrD9xJT+dAVKGmquheq4qhGCyEOmAN6ygOjfRWgSZoJs62fRrVZeAGV4d1EGqEkDuAuyOAhDtPwVnhbjN/btjQRYhKUM0t9a93Wkv++rA4m4h4m/0a4fqfTMoKNYdhPZhj4JPfEGjIZjupPSW1tniLICZjLiEFyRzmqBl4uZko7S2vYaobNzfhfnDBrZvD3zgHgtMCWV/sEm2iTnLUJaqWiq8yjzBzlul4XbhKbaXCGH5IlCXZCb9Ihk4JSe+g+4mbAJXZfkO1+5rXx0qHQKOPmQicOTXmjWHILAUSJ0kxvpjq28oioa6wa6k7W2jGHUXZEDWww1n/+gXqA3wBVUHAHQRi5zah+V6FQ8+mRJMiDyV7s8Qu63IPKrrHIs4I5rIHoIqNJ2k9SaSPxWjRzqxqdduBGehhysUkcRdfiqkJFM8iIoBl3GUvNT+MBoQqTCNUzROArjn6xRkaXjy5J2TzPCiaud1iPmPyLMXt0+Eou/ckVOfCoAdf8zoZIzIeULBTIVCZZcNZvsndyFp8qdutKH+TBlty350Y7MuE+euRghme4zJsKu4qTfzv+Pid7ut+4zDS2bFTW0552aakrXNAmI5YpbGroxqBgu5MvwLsoObvtPGR056iEBPfGV7i1qY+6rQQpOFUMcM0a6HNI7MxnI3uY3g41SvDuD1/32+y5o+AIoTSncn69/ZQz5CGwhbu9W2QxsM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(136003)(346002)(396003)(5660300002)(6862004)(2906002)(8936002)(38070700005)(66476007)(66946007)(4326008)(76116006)(91956017)(66446008)(66556008)(8676002)(64756008)(30864003)(86362001)(122000001)(38100700002)(83380400001)(186003)(54906003)(478600001)(6486002)(316002)(6636002)(45080400002)(37006003)(41300700001)(33656002)(71200400001)(36756003)(26005)(53546011)(6512007)(6506007)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UaaNNDCuWkDgKIPP08F0oYmD6phojEBw+N+uDGTVzDYp/EManhVb4TLb9L1v?=
 =?us-ascii?Q?mrM5ona5kofdbD39ifuUxA/iwOecDSviBEjFDQCOxnYHlpnfo4yV7Tg5YVSy?=
 =?us-ascii?Q?kk8VbY177NDyC4sprBXo9Y3e9XWR3F/t0I4ruWu0pPQz+hTv9fKnrXEbxdDG?=
 =?us-ascii?Q?Blth6EYKG7Ry8No0k7bmHb9vfzfu4fk3BKVW+UfEpaT+ZlHoDqrAC+Hos/Sg?=
 =?us-ascii?Q?iVQ7FvAxdWqdnSgT6CHDGBLDoa6hyq9pWbBPxzIeXM00y0MkEa2BzBN4CO0x?=
 =?us-ascii?Q?TzU78hwoW+gdVf63kCnImiXYLD/3mVtr8QDkXNm/LcsPraV33VYYIEB4dzet?=
 =?us-ascii?Q?/tCv3HoyeicQXW8DSD6kjAB4rQCIMkEq+lQ9EdDHUbfKVNeCYEPBzLTf5UUu?=
 =?us-ascii?Q?naUZqXk10CucuXe7VfR99bXxOTX1KOl3RxFDma+TNg1FvNEcCvzR16lHqQay?=
 =?us-ascii?Q?dB9ubzdtw3VzoQ7i9oDFuYwG4kkT9jG07v4G1hGB7lwk0hCdy32t26aJ+4cm?=
 =?us-ascii?Q?CcIkfICkv+57uGP+nKKTyAEAe6nlGHivcTnRf1LDBlE592R/uTDu5HZZOXp+?=
 =?us-ascii?Q?v+SL+ceB2D8pYJ+t08bewMoq7mRMeBskeMUYndQEkn2rCNe4hY/c33/lg4U8?=
 =?us-ascii?Q?gDYms75+rHXWE6MsqYLUGtFnM38l8dTty+nUtDSeqMq3U5q00s5eAPFUKHXw?=
 =?us-ascii?Q?/mSGn2mo8zZZuY8Nd9V8NBAxbWDNT7cIQk+kvMIbyKd6Vebvz5Y7ldOKKjC1?=
 =?us-ascii?Q?d6IAcpIoZK7GnyrkNW6wYlmpWNjZIIGMXFxZlexkhR7at3fxJJ1XPKBcgUyx?=
 =?us-ascii?Q?w8DmqLMFDjCw8Szu3Dk4SfaD1zvxG6yplOONG7/aAeM+RxdDlb+UD0fKYFsA?=
 =?us-ascii?Q?O/bZqDXdzzjAwkxW76Cj/ABvjk24Yh3OHeIbYsEF3Kn55ZgmR0urzG21ncuj?=
 =?us-ascii?Q?t0Mjl+pUSHbPg0XlcQkV1BSkyTpz0OktWpnugv1vthHU3GPgcGACc7/wxUlF?=
 =?us-ascii?Q?0r5bJUd+cLl+ry4vCmSsRid2eu7vDv/8pKTmj63uT3SUssEwBlKyOo8Q7shT?=
 =?us-ascii?Q?IMChtPhCGNpEAtNU/XxSQCRUXpJBo88medL8DSqHabyUvKmM3m14MQMz0OaV?=
 =?us-ascii?Q?lqgrKezkYkyF6GPJ7lFNUI5Ty5DJ55gC6aSZ9iG1bsyz+XF+MJDQTWAM2jgR?=
 =?us-ascii?Q?34tJVRGDZG4EdrNADKh90yEVyM5qQ5UWOAZLWOw7b1nm/+Db60aA/iqR4sOz?=
 =?us-ascii?Q?AAlAs9xmh2JpYwZkg4NsXkh6glqnwEzkpE5BuBkVGRs6ZFt4N9sjqSL5E+VZ?=
 =?us-ascii?Q?i8dvXyQoeTbK1sFMz/NuKs0Hz1p+Fr4wUVay2Fe3fCVXxSaGxrhWte5x+5vE?=
 =?us-ascii?Q?v5fEnVqG+tp0u3sxTnYiBHs4MChePm37/SL6PGaYtbGuk8KdrVu+UBhiOECx?=
 =?us-ascii?Q?vAp3kuufgGFjXVlU6DUAcCnCZk3CVFwIYv735Rttuhtir0xSFeExnK9YLpry?=
 =?us-ascii?Q?sI2KqBRK7i/eGT7bIM0rM81jlSS8DgoXAUyOlU62NXanP+LOkbt8GmGNjCWN?=
 =?us-ascii?Q?xX6SZ+95nH1ak8HR9efUylelrkM5OSHre8CqCcnqkGRR9wC8hgfNzDNYXJf2?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <090B7AF173FD6E468059FBC22537A5EA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea563496-f337-45b6-a4eb-08da8dd1cac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2022 17:29:01.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfCaeWRSuxlkpl9m0bgUugd7Wt3iK+WjdnBW1Y7tc9MDRtTlfVueqj+Z+qk7AzyiPIlyuHaVS75Xn1a/YBjunA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209030090
X-Proofpoint-GUID: irV4AQ105acAukN2yQWQe5bGOGFGrzKh
X-Proofpoint-ORIG-GUID: irV4AQ105acAukN2yQWQe5bGOGFGrzKh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 3, 2022, at 1:03 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 9/2/22 6:26 PM, Chuck Lever III wrote:
>>> On Sep 2, 2022, at 3:34 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>> On 9/2/22 10:58 AM, Chuck Lever III wrote:
>>>>>> Or, nfsd_courtesy_client_count() could return
>>>>>> nfsd_couresy_client_count. nfsd_courtesy_client_scan() could
>>>>>> then look something like this:
>>>>>>=20
>>>>>> 	if ((sc->gfp_mask & GFP_KERNEL) !=3D GFP_KERNEL)
>>>>>> 		return SHRINK_STOP;
>>>>>>=20
>>>>>> 	nfsd_get_client_reaplist(nn, reaplist, lt);
>>>>>> 	list_for_each_safe(pos, next, &reaplist) {
>>>>>> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
>>>>>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>>>>>> 		list_del_init(&clp->cl_lru);
>>>>>> 		expire_client(clp);
>>>>>> 		count++;
>>>>>> 	}
>>>>>> 	return count;
>>>>> This does not work, we cannot expire clients on the context of
>>>>> scan callback due to deadlock problem.
>>>> Correct, we don't want to start shrinker laundromat activity if
>>>> the allocation request specified that it cannot wait. But are
>>>> you sure it doesn't work if sc_gfp_flags is set to GFP_KERNEL?
>>> It can be deadlock due to lock ordering problem:
>>>=20
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>> WARNING: possible circular locking dependency detected
>>> 5.19.0-rc2_sk+ #1 Not tainted
>>> ------------------------------------------------------
>>> lck/31847 is trying to acquire lock:
>>> ffff88811d268850 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: btrfs_i=
node_lock+0x38/0x70
>>> #012but task is already holding lock:
>>> ffffffffb41848c0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.c=
onstprop.0+0x506/0x1db0
>>> #012which lock already depends on the new lock.
>>> #012the existing dependency chain (in reverse order) is:
>>>=20
>>> #012-> #1 (fs_reclaim){+.+.}-{0:0}:
>>>       fs_reclaim_acquire+0xc0/0x100
>>>       __kmalloc+0x51/0x320
>>>       btrfs_buffered_write+0x2eb/0xd90
>>>       btrfs_do_write_iter+0x6bf/0x11c0
>>>       do_iter_readv_writev+0x2bb/0x5a0
>>>       do_iter_write+0x131/0x630
>>>       nfsd_vfs_write+0x4da/0x1900 [nfsd]
>>>       nfsd4_write+0x2ac/0x760 [nfsd]
>>>       nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
>>>       nfsd_dispatch+0x4ed/0xc10 [nfsd]
>>>       svc_process_common+0xd3f/0x1b00 [sunrpc]
>>>       svc_process+0x361/0x4f0 [sunrpc]
>>>       nfsd+0x2d6/0x570 [nfsd]
>>>       kthread+0x2a1/0x340
>>>       ret_from_fork+0x22/0x30
>>>=20
>>> #012-> #0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}:
>>>       __lock_acquire+0x318d/0x7830
>>>       lock_acquire+0x1bb/0x500
>>>       down_write+0x82/0x130
>>>       btrfs_inode_lock+0x38/0x70
>>>       btrfs_sync_file+0x280/0x1010
>>>       nfsd_file_flush.isra.0+0x1b/0x220 [nfsd]
>>>       nfsd_file_put+0xd4/0x110 [nfsd]
>>>       release_all_access+0x13a/0x220 [nfsd]
>>>       nfs4_free_ol_stateid+0x40/0x90 [nfsd]
>>>       free_ol_stateid_reaplist+0x131/0x210 [nfsd]
>>>       release_openowner+0xf7/0x160 [nfsd]
>>>       __destroy_client+0x3cc/0x740 [nfsd]
>>>       nfsd_cc_lru_scan+0x271/0x410 [nfsd]
>>>       shrink_slab.constprop.0+0x31e/0x7d0
>>>       shrink_node+0x54b/0xe50
>>>       try_to_free_pages+0x394/0xba0
>>>       __alloc_pages_slowpath.constprop.0+0x5d2/0x1db0
>>>       __alloc_pages+0x4d6/0x580
>>>       __handle_mm_fault+0xc25/0x2810
>>>       handle_mm_fault+0x136/0x480
>>>       do_user_addr_fault+0x3d8/0xec0
>>>       exc_page_fault+0x5d/0xc0
>>>       asm_exc_page_fault+0x27/0x30
>> Is this deadlock possible only via the filecache close
>> paths?
>=20
> I'm not sure, but there is another back trace below that shows
> another problem.
>=20
>>  I can't think of a reason the laundromat has to
>> wait for each file to be flushed and closed -- the
>> laundromat should be able to "put" these files and allow
>> the filecache LRU to flush and close in the background.
>=20
> ok, what should we do here, enhancing the laundromat to behave
> as you describe?

What I was suggesting was a longer term strategy for improving the
laundromat. In order to scale well in the number of clients, it
needs to schedule client expiry and deletion without serializing.

(ie, the laundromat itself can identify a set of clients to clean,
but then it should pass that list to other workers so it can run
again as soon as it needs to -- and that also means it can use more
than just one CPU at a time to do its work).

In the meantime, it is still valuable to consider a shrinker built
around using ->nfsd_courtesy_client_count only. That was one of
the two alternatives I suggested before, so I feel we have some
consensus there. Please continue to look into that, and we can
continue poking at laundromat improvements later.


> Here is another stack trace of problem with calling expire_client
> from 'scan' callback:
> Sep  3 09:07:35 nfsvmf24 kernel: ------------[ cut here ]------------
> Sep  3 09:07:35 nfsvmf24 kernel: workqueue: PF_MEMALLOC task 3525(gmain) =
is flushing !WQ_MEM_RECLAIM nfsd4_callbacks:0x0
> Sep  3 09:07:35 nfsvmf24 kernel: WARNING: CPU: 0 PID: 3525 at kernel/work=
queue.c:2625 check_flush_dependency+0x17a/0x350
> Sep  3 09:07:35 nfsvmf24 kernel: Modules linked in: rpcsec_gss_krb5 nfsd =
nfs_acl lockd grace auth_rpcgss sunrpc
> Sep  3 09:07:35 nfsvmf24 kernel: CPU: 0 PID: 3525 Comm: gmain Kdump: load=
ed Not tainted 6.0.0-rc3+ #1
> Sep  3 09:07:35 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/V=
irtualBox, BIOS VirtualBox 12/01/2006
> Sep  3 09:07:35 nfsvmf24 kernel: RIP: 0010:check_flush_dependency+0x17a/0=
x350
> Sep  3 09:07:35 nfsvmf24 kernel: Code: 48 c1 ee 03 0f b6 04 06 84 c0 74 0=
8 3c 03 0f 8e b8 01 00 00 41 8b b5 90 05 00 00 49 89 e8 48 c7 c7 c0 4d 06 9=
a e8 c6 a4 7f 02 <0f> 0b eb 4d 65 4c 8b 2c 25 c0 6e 02 00 4c 89 ef e8 71 65=
 01 00 49
> Sep  3 09:07:35 nfsvmf24 kernel: RSP: 0018:ffff88810c73f4e8 EFLAGS: 00010=
282
> Sep  3 09:07:35 nfsvmf24 kernel: RAX: 0000000000000000 RBX: ffff88811129a=
800 RCX: 0000000000000000
> Sep  3 09:07:35 nfsvmf24 kernel: RDX: 0000000000000001 RSI: 0000000000000=
004 RDI: ffffed10218e7e93
> Sep  3 09:07:35 nfsvmf24 kernel: RBP: 0000000000000000 R08: 0000000000000=
001 R09: ffffed103afc6ed2
> Sep  3 09:07:35 nfsvmf24 kernel: R10: ffff8881d7e3768b R11: ffffed103afc6=
ed1 R12: 0000000000000000
> Sep  3 09:07:35 nfsvmf24 kernel: R13: ffff88810d14cac0 R14: 0000000000000=
00d R15: 000000000000000c
> Sep  3 09:07:35 nfsvmf24 kernel: FS:  00007fa9a696c700(0000) GS:ffff8881d=
7e00000(0000) knlGS:0000000000000000
> Sep  3 09:07:35 nfsvmf24 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
> Sep  3 09:07:35 nfsvmf24 kernel: CR2: 00007fe922689c50 CR3: 000000010bdd8=
000 CR4: 00000000000406f0
> Sep  3 09:07:35 nfsvmf24 kernel: Call Trace:
> Sep  3 09:07:35 nfsvmf24 kernel: <TASK>
> Sep  3 09:07:35 nfsvmf24 kernel: __flush_workqueue+0x32c/0x1350
> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
> Sep  3 09:07:35 nfsvmf24 kernel: ? rcu_read_lock_held_common+0xe/0xa0
> Sep  3 09:07:35 nfsvmf24 kernel: ? check_flush_dependency+0x350/0x350
> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_release+0x485/0x720
> Sep  3 09:07:35 nfsvmf24 kernel: ? __queue_work+0x3cc/0xe10
> Sep  3 09:07:35 nfsvmf24 kernel: ? trace_hardirqs_on+0x2d/0x110
> Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_shutdown_callback+0xc5/0x3d0 [nf=
sd]
> Sep  3 09:07:35 nfsvmf24 kernel: nfsd4_shutdown_callback+0xc5/0x3d0 [nfsd=
]
> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_release+0x485/0x720
> Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_probe_callback_sync+0x20/0x20 [n=
fsd]
> Sep  3 09:07:35 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
> Sep  3 09:07:35 nfsvmf24 kernel: __destroy_client+0x5ec/0xa60 [nfsd]
> Sep  3 09:07:35 nfsvmf24 kernel: ? nfsd4_cb_recall_release+0x20/0x20 [nfs=
d]
> Sep  3 09:07:35 nfsvmf24 kernel: nfsd_courtesy_client_scan+0x39f/0x850 [n=
fsd]
> Sep  3 09:07:35 nfsvmf24 kernel: ? preempt_schedule_notrace+0x74/0xe0
> Sep  3 09:07:35 nfsvmf24 kernel: ? client_ctl_write+0x7c0/0x7c0 [nfsd]
> Sep  3 09:07:35 nfsvmf24 kernel: ? preempt_schedule_notrace_thunk+0x16/0x=
18
> Sep  3 09:07:35 nfsvmf24 kernel: shrink_slab.constprop.0+0x30b/0x7b0
> Sep  3 09:07:35 nfsvmf24 kernel: ? unregister_shrinker+0x270/0x270
> Sep  3 09:07:35 nfsvmf24 kernel: shrink_node+0x54b/0xe50
> Sep  3 09:07:35 nfsvmf24 kernel: try_to_free_pages+0x394/0xba0
> Sep  3 09:07:35 nfsvmf24 kernel: ? reclaim_pages+0x3b0/0x3b0
> Sep  3 09:07:35 nfsvmf24 kernel: __alloc_pages_slowpath.constprop.0+0x636=
/0x1f30
> Sep  3 09:07:35 nfsvmf24 kernel: ? warn_alloc+0x120/0x120
> Sep  3 09:07:35 nfsvmf24 kernel: ? __zone_watermark_ok+0x2d0/0x2d0
> Sep  3 09:07:35 nfsvmf24 kernel: __alloc_pages+0x4d6/0x580
> Sep  3 09:07:35 nfsvmf24 kernel: ? __alloc_pages_slowpath.constprop.0+0x1=
f30/0x1f30
> Sep  3 09:07:35 nfsvmf24 kernel: ? find_held_lock+0x2c/0x110
> Sep  3 09:07:35 nfsvmf24 kernel: ? lockdep_hardirqs_on_prepare+0x17b/0x41=
0
> Sep  3 09:07:35 nfsvmf24 kernel: ____cache_alloc.part.0+0x586/0x760
> Sep  3 09:07:35 nfsvmf24 kernel: ? kmem_cache_alloc+0x193/0x290
> Sep  3 09:07:35 nfsvmf24 kernel: kmem_cache_alloc+0x22f/0x290
> Sep  3 09:07:35 nfsvmf24 kernel: getname_flags+0xbe/0x4e0
> Sep  3 09:07:35 nfsvmf24 kernel: user_path_at_empty+0x23/0x50
> Sep  3 09:07:35 nfsvmf24 kernel: inotify_find_inode+0x28/0x120
> Sep  3 09:07:35 nfsvmf24 kernel: ? __fget_light+0x19b/0x210
> Sep  3 09:07:35 nfsvmf24 kernel: __x64_sys_inotify_add_watch+0x160/0x290
> Sep  3 09:07:35 nfsvmf24 kernel: ? __ia32_sys_inotify_rm_watch+0x170/0x17=
0
> Sep  3 09:07:35 nfsvmf24 kernel: do_syscall_64+0x3d/0x90
> Sep  3 09:07:35 nfsvmf24 kernel: entry_SYSCALL_64_after_hwframe+0x46/0xb0
> Sep  3 09:07:35 nfsvmf24 kernel: RIP: 0033:0x7fa9b1a77f37
> Sep  3 09:07:35 nfsvmf24 kernel: Code: f0 ff ff 73 01 c3 48 8b 0d 36 7f 2=
c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 f=
e 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 09 7f 2c 00 f7 d8 64=
 89 01 48
> Sep  3 09:07:35 nfsvmf24 kernel: RSP: 002b:00007fa9a696bb28 EFLAGS: 00000=
202 ORIG_RAX: 00000000000000fe
> Sep  3 09:07:35 nfsvmf24 kernel: RAX: ffffffffffffffda RBX: 00005638abf5a=
dc0 RCX: 00007fa9b1a77f37
> Sep  3 09:07:35 nfsvmf24 kernel: RDX: 0000000001002fce RSI: 00005638abf58=
080 RDI: 000000000000000d
> Sep  3 09:07:35 nfsvmf24 kernel: RBP: 00007fa9a696bb54 R08: 00007ffe7f7f1=
080 R09: 0000000000000000
> Sep  3 09:07:35 nfsvmf24 kernel: R10: 00000000002cf948 R11: 0000000000000=
202 R12: 0000000000000000
> Sep  3 09:07:35 nfsvmf24 kernel: R13: 00007fa9b39710e0 R14: 00005638abf5a=
df0 R15: 00007fa9b317c940
>=20
> Another behavior about the shrinker is that the 'count' and 'scan'
> callbacks are not 1-to-1, meaning the 'scan' is not called after
> every 'count' callback. Not sure what criteria the shrinker use to
> do the 'scan' callback but it's very late, sometimes after dozens
> of 'count' callback then there is a 'scan' callback. If we rely on
> the 'scan' callback then I don't think we react in time to release
> the courtesy clients.
>=20
> -Dai
>=20
>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



