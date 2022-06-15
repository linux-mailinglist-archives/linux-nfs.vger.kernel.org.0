Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798554CD2D
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbiFOPjL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiFOPjL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 11:39:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375113DC6
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 08:39:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FE3BP4000856;
        Wed, 15 Jun 2022 15:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uJd0wWafugj/jY96RjB6MXdHkU1J+RbnIByBM+ZLipU=;
 b=Jy0AMbO+TZeAok8kU35qgBSJoHrMOtcqFJJOpIUw+Yz3932Hv28t+qphy+RWD7C6htMa
 NCCTCKRCs4LtK1iq+3KM8hRtTPoaAuEexe+qF6ze8hvbZ55A7aQTuibnQRcc6lTlx+Tx
 qiuozhahSJkyR5hXY7YfJXLFVseI8Uh5a0GLYSZorFIpHXVrvP0mRpCRR/hCbrzgtDt8
 MLLp5Dstc6VVBiijgbUZHHSEixYKbsQIW+uqRdP/cU+IcO342qRM6bL70AE7Polc/wKh
 SZ0xvY0UlVkqY+IVay6LpkffFgLUebR7OGoWtUnOMms4VQTXkEVowuHxHtmagHA/nJhC Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9gsbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 15:39:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FFaQAn030166;
        Wed, 15 Jun 2022 15:39:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2abvv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 15:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sqcxba3qmlHCIDxf6OwjvI/2efakxFHTDOfJnisjJhi3wk5R0TSFNoh6lWdS1jMDst939XsOaAgXXlvKmJpkmhnpANO9KgQAKp8l5CX9Lqf/4C4drnTEV3huKRCqJB0LzPVIj152hLGARpR4ThWX2Kl601RAlSqLeTny/sYWdgzXG0BVlX7Ryvoe07Y/QcwO0h68WvPJNks7HssrjxTM0FC9Sw21lmpA4arZSR050MOo3XV0067Y5T9NQczc1TJf5iF5kfa8Gc1qdYlDx5FIBCY/2Ov8lONdAZX5Yl0C22/W5l4gSRsngJY0gGM6DnDPNlFGoZXFbv0zgyyYv7a5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJd0wWafugj/jY96RjB6MXdHkU1J+RbnIByBM+ZLipU=;
 b=TTEep9aKuZlsV8sBWjAnJmR7iMpXvV1l3sBnKe9yD2IBo0OLWBHgxsPwvzIz3Wvg/wj110Alwjo5doHvPeDgGsWltRVVnAho0IFPSEi/hxjg/aBkPB1mmMfNfTdVQFa5Q+1/5Mejft8F67Ao/G+AY5LcHZbTh/3quh1/aNI3ccpf+O5iRmkeOCupNLM3fBENjIwckA4+GAtqrgxYquk8ism2aA1zccyUYeXMlbDu9QCsT3ol0pc7mjUMcOfiwLG48sIj15o/PHqt1GrPZ7Uj8o1p/hpGJKM4Chw+CvuhFgi7RHq9EUwSEj5NQVGqObGfKNCV9ucNhUQoyjSSUhDIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJd0wWafugj/jY96RjB6MXdHkU1J+RbnIByBM+ZLipU=;
 b=wggJ2OI0pZJZXYHGbaCY4AvmWpEixzvcUYjSgysq4SHEHpysp0cOluEpUHKDEMEjsp+RhvUpViQvDKWz0mdnQyvORY5mow32GfcoFLjUQwLYihSgCaffH6NDVmANGWn/1l4yKLrSaUy1ldR4S3MurYLSX88QgMIVMISguJwsn4w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3434.namprd10.prod.outlook.com (2603:10b6:5:6a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Wed, 15 Jun
 2022 15:39:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 15:39:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RPC] nfsd: NFSv4 close a file completely
Thread-Topic: [RPC] nfsd: NFSv4 close a file completely
Thread-Index: AQHYfi1IwwfFdSiA302AZfT/YMJLJq1MFpUAgASGG4CAAAMIAA==
Date:   Wed, 15 Jun 2022 15:39:02 +0000
Message-ID: <06C68349-C174-402B-A902-31A65BEFFB0B@oracle.com>
References: <20220612072253.66354-1-wangyugui@e16-tech.com>
 <0CBF71FB-7754-4992-BE16-A3CFD404DECC@oracle.com>
 <20220615232810.95CE.409509F4@e16-tech.com>
In-Reply-To: <20220615232810.95CE.409509F4@e16-tech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9179a3d-2610-45ef-ae0d-08da4ee52c55
x-ms-traffictypediagnostic: DM6PR10MB3434:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3434190407B39DD52DE7DC8F93AD9@DM6PR10MB3434.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9B9LbiTrG93DNEUIGT0imxgBDXCeEFMWHlAUgimMh/DtgQoaP4jb0LyyYPD0iR3TkqVXgTA23Yj+XFfivsADNQLyh4BZ8AqG2hd0YuSIFsKgbmO3wofyfZPYDocHJG/L4wX5YkIs3jgyIsEgXxsdRmxEcM+y+YFf7xRi7cqr11k9nxScC8QuttHQ7xmxavLiy3JTBVL6AzSxSO3+d56xDK9af3D5V+cqIKXHSOFNgyD31++wxZ4HPXq34XwmH6LGunowJ8fgvr4D5Z0UaZQSOTlVokt53isiSFECpe5exJsc5aoCX9pzyW84X2992H4yk9s8JxTyryhdD0YAAF9naNPmn72V7xQ+DvlKbwmLMjMzxVQyav58xLgS/bKYiIfToacU1CVBWcNVwXwrlBrr1QNYeJWkY/c5kVVSz0S0+SGwb425oT9DDY7ihDrbS4Ni3kcBfnU6KxmnS76GVgAfJRjRCEQ4kHTPJhnjC2yN3/3bEeu4Wd+fxA99LUCfQpj3u/gote1fXhm656TQ0OUom7Sax92qltgNrtM55QWbQpCKn0ZCY+fzZMtlIm4c/4Oqiy34IbZxVrcc7CQhWj02d4sq9TJ1RYVmI1QePBRH4jpEgCpQFtZKQ/muz6T+QLw1ndSivyauCmG6uLfhwFhj9Ttayl/1I39AHX+B+xhDmbqBRB9/bp994EthTcfH7YQpcEYxpiaOY9kykgeiEmWNZHMqvk3Yc9Xyi5/ZFvwHCXKmH66+7YJjunSLfBDmKMgblruXj0e9GZ3SwWrmoitCG5ev55j0vdP9VJtgkRwRqELfemaIenYIt8gXyfDKeVIeBX7UXSlWffZvNXd/0Y/Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(2906002)(508600001)(6486002)(6512007)(966005)(36756003)(8676002)(66476007)(71200400001)(66446008)(53546011)(91956017)(6916009)(8936002)(5660300002)(26005)(33656002)(2616005)(66556008)(64756008)(66946007)(76116006)(4326008)(122000001)(186003)(6506007)(38070700005)(316002)(86362001)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mdqX1oeacK//SfUGR1crotbs6aY1StAniK+xxcOL1ladvDz+EZ4sY701I5EV?=
 =?us-ascii?Q?fH3mSUFSiYyFvxOUiJ7K49SkO7dq0eMzfIIfUF6whjnWQXdeHLAD4uUVuZuJ?=
 =?us-ascii?Q?Syd9YCrcLbnL4pBMZosuO/86rrwwELOc+VKKDJfXbFx0JzOiWsd4OyAXpArk?=
 =?us-ascii?Q?zZlr9R3wPMBOAZJ7Tm+fKw71Wc5oNG4tySCRe6q2iHzH9Q6YT0E//z5UXyIm?=
 =?us-ascii?Q?14zeluGoS5+1i0CyFaubt5IcAPW0y6QbrjK1mmkTcXlDFUWMdv+cByCZH7w8?=
 =?us-ascii?Q?NgFJrRR45pz2lAFKDqOeWGIe+OOXBYMFPIPcuTf0RGxC+CXyGDhLag/+PDKo?=
 =?us-ascii?Q?NbEcHYO52B3O2zDcFS5Tb6iCl/d02rxVINi9vrNkIOoCjJcVKeklGp2oj2Vu?=
 =?us-ascii?Q?cDiVqrNheSjd+HC/4Tg6CMY5ZNHu1YPLesuzRhPQK98CVGfHmR/3JTnt8Pjf?=
 =?us-ascii?Q?f58FPJZFldzbHuWkKO9rOqLVmXoE8R6gGsEoZ/qPbsNZ3GW1TJPVY4FvaJsA?=
 =?us-ascii?Q?iXeGBSiAVegXnDgxDbjITz8zfAL359+V98FUbU1YJh3dZMafAABA4+bOFeSZ?=
 =?us-ascii?Q?13C+nJoJEzrkHxgSv34UOiaJIX0dRWIv4TKGDHTDo+12vxKfSO0RvqzbepHj?=
 =?us-ascii?Q?soEi6O21NfFVBquR20jYTWLZlTgy8C5mFS6egzxj+HXhhimHmxq2up+uU3lq?=
 =?us-ascii?Q?6dhwV2Efkq28C7Hf5TClaLBM5R9kLy8fRL9BkRkgfRXYTXqw1KXwvw2K1tJu?=
 =?us-ascii?Q?zbz1fWnxM9aC9FyiwL+nksYtSpx0mxJRB5qGxiaXrqUgXdu5pfgs7YzmsMpS?=
 =?us-ascii?Q?kXEDcnC3jBKH07afaO0vCH7albhGoOtsiRODi1hVYH1TWTEdWNaaflXQbUPa?=
 =?us-ascii?Q?uc3i+2003S+MVooLJVO40HeM+OFIfPSh0VOhkE9gOIWZ0n0eo8FWCIto4or8?=
 =?us-ascii?Q?f/IWgdwFklXvqN2wBsX4/61QsUgS40I15MWTm3BkTJGdHHVHi9VtWh8NvYiX?=
 =?us-ascii?Q?cNYyldOM/CPaGFb9gshyaD7b1154Q3MO5RuPe2Zhwaopj2r77WyJaP5HPKqs?=
 =?us-ascii?Q?dDZa8+PaP0tN7BnLqFyX3GQllP356Tdq1W5ZP97VuBKO7Wt5dse4+9IgU+pZ?=
 =?us-ascii?Q?AZPdfYcdHUvqib8G6B5qVnoONYmpMhTu63S3H5BuQyKnpfMh37RR/BOkybOy?=
 =?us-ascii?Q?BWxxX3Rua0H2mwIhIQb1dXO/pmrqWIPLfINIvauSlSCIpZQlWLZrq6/iaiKF?=
 =?us-ascii?Q?SsHE7EFk33HQDjnuowxXZZrigDBCxXvxyrrQZlA/gecl5QLDHVVc3qbvWwa2?=
 =?us-ascii?Q?XjsbXH7nk/VxuSFvSJosQBT4XONSuoVAJpN+wUWS2SKUiK4qc272PkhbEqLm?=
 =?us-ascii?Q?D0fzYdEr14z4zUg3Y4S8rPs/Ai+JeRtCWzBoPDy2ZAO3lm3ILew9LQ+tJ6qQ?=
 =?us-ascii?Q?ZW6i8wYl0Xf76BjEavMvfyw8Kf+8IylmD3f8/rOKInQpFPjMk9njVQG36rvB?=
 =?us-ascii?Q?zjywyHdHCaem1pUiiYva+bbCAWQDfzXBfePuh+sd9Dle6gRPnBfHwTIWQeen?=
 =?us-ascii?Q?ay04fxw0dEkiHNf+bIviGxAxwDqOacI8MPJqbumWzu+cmrN43KhbK2q1/ii+?=
 =?us-ascii?Q?Z7ZSAM5iM/49WWIha1uLccwa0pYRn7bx9ukoea7amY308Vvv8Mx0oQ+KPxrA?=
 =?us-ascii?Q?WlCQZ1jnQOAUWPN8B8D48WbzISDRcGyLDPrDGfPcmNfpPAOOpviWBf8jtt7f?=
 =?us-ascii?Q?fj9KuwtSDlidKbVkaIYan5G5O/jSp2g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB65DDC700E2F64CA28CF6ABF8CC1ED7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9179a3d-2610-45ef-ae0d-08da4ee52c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 15:39:02.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfzOXNfASC7C5yngZc2z19eq0TP0z0o+R+d/R1A8X/aNnb8gMp/rJmwyJReNofekukCaA1nXwlo85Pvtf13yqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_05:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150060
X-Proofpoint-ORIG-GUID: U9yKenGd7iRhBsrUZHGKlWWp1WGqnMaI
X-Proofpoint-GUID: U9yKenGd7iRhBsrUZHGKlWWp1WGqnMaI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 15, 2022, at 11:28 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> Hi,
>=20
>>> On Jun 12, 2022, at 3:22 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>>>=20
>>> NFSv4 need to close a file completely (no lingering open) when it does
>>> a CLOSE or DELEGRETURN.
>>>=20
>>> When multiple NFSv4/OPEN from different clients, we need to check the
>>> reference count. The flowing reference-count-check change the behavior
>>> of NFSv3 nfsd_rename()/nfsd_unlink() too.
>>>=20
>>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D387
>>> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
>>> ---
>>> TO-CHECK:
>>> 1) NFSv3 nfsd_rename()/nfsd_unlink() feature change is OK?
>>> 2) Can we do better performance than nfsd_file_close_inode_sync()?
>>> 3) nfsd_file_close_inode_sync()->nfsd_file_close_inode() in nfsd4_deleg=
return()
>>> 	=3D> 'Text file busy' about 4s
>>> 4) reference-count-check : refcount_read(&nf->nf_ref) <=3D 1 or =3D=3D0=
?
>>> 	nfsd_file_alloc()	refcount_set(&nf->nf_ref, 1);
>>>=20
>>> fs/nfsd/filecache.c | 2 +-
>>> fs/nfsd/nfs4state.c | 4 ++++
>>> 2 files changed, 5 insertions(+), 1 deletion(-)
>>=20
>> I suppose I owe you (and Frank) a progress report on #386. I've fixed
>> the LRU algorithm and added some observability features to measure
>> how the fix impacts the cache's efficiency for NFSv3 workloads.
>>=20
>> These new features show that the hit rate and average age of cache
>> items goes down after the fix is applied. I'm trying to understand
>> if I've done something wrong or if the fix is supposed to do that.
>>=20
>> To handle the case of hundreds of thousands of open files more
>> efficiently, I'd like to convert the filecache to use rhashtable.
>=20
> A question about the comming rhashtable.
>=20
> Now multiple nfsd export share a cache pool.
>=20
> In the coming rhashtable, a nfsd export could use a private cache pool
> to improve scale out?

That seems like a premature optimization. We don't know that the hashtable,
under normal (ie, non-generic/531) workloads, is a scaling problem.

However, I am considering (in the future) creating separate filecaches
for each nfsd_net.


--
Chuck Lever



