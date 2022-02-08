Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78284ADE44
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 17:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383050AbiBHQVx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 11:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383035AbiBHQVu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 11:21:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6180C061578
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 08:21:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218GJggZ011806;
        Tue, 8 Feb 2022 16:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=svlhCsr86OPucCmZftFbqnFfwWyYMiP0GT7JMoTiprE=;
 b=BrpZqHfXlUNHWZ7StS15V2nOPwb1gKng2icMbX7kr8/p5FhUntaeTMmyAUdfqpzomwbh
 /Z9rlM3omGJyc0FEH4StKDxsf1/60Vb4RlRzFyODnNGugh8AmJjRS49n8rsW2MgcF3bD
 V0dT1AegOE2NpzpC08fEtDENlIjjGeGBCTCMjFO6oMHjTM418hr6/rRQztGIteFGNnDa
 oKkPgzTobtvMEC7RtDgY2eEupvw36jceVhv+h3LVGtYpo/Q2t1wlAXsstruGEiKyWGho
 SR8O1lxpGfXed3icvgCL7wnozdSfuKn4ScnjW8uakoMCUB7DgobPbInvc5nRdnLdCvIl nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345skswq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 16:21:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218GBYQK109973;
        Tue, 8 Feb 2022 16:21:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3020.oracle.com with ESMTP id 3e1h26hgv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 16:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbRwoNmWZZymw89PlQamrWQ+D9LjlUPM55ThArXZlaL++NU59YQKDPeCc1ldFJKsiXTpE0v75MteCr0oiSXAzu35WW4+ou6ENIn+VGMBbsDvhozmnAOD7cECMR2H9+mylCPvZB/evFiQqbCqgl31PBXakeqUYVoLHUKYy4c4GZ1+sG7MUD+N1DHfZIK5fN8L0ffvI1jAubYZ+6NFv/bOm+1Pq860FJEf2uNQEkDPeC+mO/MzTHzF+450tCtTQ9bNavYdln0+bVCXJXif1STIRRp9WgjuoMrXAsTCIJm7btGGKn4paVGKQUp4+qSS6mjXqmdYX07QaGmrRN6WAgJU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svlhCsr86OPucCmZftFbqnFfwWyYMiP0GT7JMoTiprE=;
 b=k3hLeyUKaK1zJ6B9H6otKEf2BY2AZhVi6BVCYzBjkWGcXyMWxn5duZkhvUiLuvwEPd4n+VTe3WU3TAT8GtD6jiLPPy+b+O6DhbA90OKCjSOdj/SJrrEoo/3BMCSdkLowR3lnQ1zh2JXKw1suf5W+8oGq3KzXv5haX81feipVBHv5Lwp/s5mXQbXSf4TSafv6ft7O1IJUJGGMhPND2I35jdCIK/XutwKmhM0wq6SocKL6b0WGMg8oSiCJ7WCfNe3eUZHCk2ttaAmOntbuekCIxPidF5mHDybQb/e9ZX7y3UgNbGkQ/SGUgRF0UePeB9BVR6UmcPMrguSFXAgHaaEBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svlhCsr86OPucCmZftFbqnFfwWyYMiP0GT7JMoTiprE=;
 b=EmZMrww6oRPVg6f9GBNTo+TmVmAY1pQQSt6hMmBSIxa3qr/Xx1FUsO2aOMMx4zDhDZtR4C5UqEjgPFKbauZNqFJ14PzF3jzIf2kgPlz7DZQQ2f/Rztol8FOven2N81UhZxIilXvqZsHyYNwtRpPHdgEXdl2OjcNPj4W2GWSOG2M=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by MN2PR10MB3200.namprd10.prod.outlook.com (2603:10b6:208:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 8 Feb
 2022 16:21:41 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 16:21:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve Dickson <steved@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Topic: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Thread-Index: AQHYGca9ZpW/pPf5rEWUIwyc/qfEDKyJ14OAgAAE1wA=
Date:   Tue, 8 Feb 2022 16:21:41 +0000
Message-ID: <33B10EBB-3DD1-45FE-B7D2-D5EA21DFB172@oracle.com>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
In-Reply-To: <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7909f899-517a-4462-2eac-08d9eb1f170d
x-ms-traffictypediagnostic: MN2PR10MB3200:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3200E686C5FDA1EBBAC4FB0A932D9@MN2PR10MB3200.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmwNf1qUNXqMQdLyGctVCQvtVI3X4QBr2jNpT7rTyY2KSmdSuktlVfPXaRGqR6CIYdxruK9b6Gqon92uqnYJNwM4yFOZpXEpLBBNniJig1YVM63pCFy5EB7CzxUbGGIf5c9oSi1cyVfTBj8gTmJl1uBkQyqkpn/qccrR1uGChhc7i/jBMip7ej/2Q59m+jaPG37qoT5BLHJfx7updkVKzy9kYIUaSXsHrp3La7gweQhsaEhysZv32z24XSWSDfkV/gLMlxnrZ2B1v3Fg8KQAN9+RisOYPmOHxp7BOiplKuyu/3P9XG6Mkt0hzYOTPq7mxVGb0KB6beJ2DNwReB5qrQryQ3wQISxvqWQkWXbeuZlUxlIuOuOfLqaC+lWWzRHNghgWov073u3VSrBYW4l8RMCqvNaLcTaxKoT6WcBMaIbNL8OoiHIs70WH6zSV3j/an4SV4Gclsg8cCNkW+x08/9OSrktMxA8/sGnK2lIpH8SJLl6o7FHM46z/SSk27uXaVzwUV3bs/PuUTyoI6WS/aUy6wmyN+YobOrPOXuAt2m8wAMn1N6ry1Fa9Q4nH6d0cuDXRa8SuCBWXL6UdC2pQTAAuaxNDo6FCMbXtN/aLMz+zrcweC0FQXRnUsGTFf4wjwWIOy7L+io2szyCwfYrwvzCiK1oW+QGatnlsR3Uhd9vakFtZxeNtKVZF8GavLmxitqRFlmhqMGCw8jGE+93AcBU9E3V63fQd/z4jIJmO89ZFa5PvgK96iH8KhznL3aU7GEWarQ0gtW4ggukM9nM6OltFI1DPqYAipx1APwmTQGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(122000001)(6486002)(33656002)(71200400001)(508600001)(2616005)(186003)(26005)(38100700002)(2906002)(36756003)(6506007)(6512007)(38070700005)(53546011)(66446008)(66476007)(64756008)(4326008)(76116006)(66946007)(86362001)(110136005)(5660300002)(8936002)(8676002)(316002)(66556008)(32563001)(2004002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DzSwrJMZcz+wuADVlz4w3UqacjJKS4Nh7LxAen2TPT2PT68Zh6vUBuB3TAlR?=
 =?us-ascii?Q?T3zqUP1zSfrjlBVvFVNWSrSoPsvXPyvJ8zcraOdiCpTF/ragCgM147oxHTrs?=
 =?us-ascii?Q?ZZLtX9E487Psr/Yy7dkJHGmxCMavjM8YyJOiLErOm8HJ0yylkR3epJY//di7?=
 =?us-ascii?Q?Z8RDvBAZE8vgGsJZOn5cSd3MYvJEyc8P8OqEv2sg+CFj3LtDYYzU5dvOG92q?=
 =?us-ascii?Q?0ZSAtoeLYEVy8fuQGIxu4vbG+s1TjSWsM7q1u6bM9iK7y6L1lN/cEh8OTUBy?=
 =?us-ascii?Q?0s9YY60lBpCeXVjdGnWMMJF/0HRJB3EH5CScS80TEtAuVU0+GsEsYsklULXh?=
 =?us-ascii?Q?PjsBTFwqTFORdwdr4K3cSs9o8SEDcttQ9ISkiBXEWgQ1YR+/wcHfqxFfOm+I?=
 =?us-ascii?Q?qakpuMrYZ6jCI83P9DxTxiMx5gwMquhBaxlO53WpGDskjBfsnCh0KlqnhXHV?=
 =?us-ascii?Q?x5FC31dI23H054HLCo9E0zOaWIhjEBoKcWLDmjVvOcOMFvHdcZwXDr9zplb6?=
 =?us-ascii?Q?wFaI8BSnR7CuqjeDeNcf7Q/COILPmghCENhCLW6tV34oqY4krP/A8mrn9Ghz?=
 =?us-ascii?Q?zmo+xKprXQ8UXb+oz+Z7FZ8umDv6YrywTVfLL/lfPsbTDVGrG/dEYEHBUDow?=
 =?us-ascii?Q?XfjaWJLA6/TvWnG4Ff9QPDby/b2po4nj3aYE5K4p5IOQlaWd7kmZ/XLuPYAS?=
 =?us-ascii?Q?rPWsdQUQf6JnL4EJzhP/XBCSgaXI6vk4ITU/Ouj1OpwGf1l8yUIjFhluA6D6?=
 =?us-ascii?Q?4Okb9s/b+0C0/zfLGupPU2M+9TD5SG9arb3ExWEaq5tEFBgttSMaJ8BCmknC?=
 =?us-ascii?Q?PMhHxyrAR15/9DSD8He79lnXoWDQ/tJBxYzzdNmYnhRUjOPD1Wlsf30HhVYn?=
 =?us-ascii?Q?qeGupJYKFB/i03h0jNPp+zoX05+04QfAImwyGZNvBn/aW6nZn+oemFICSsin?=
 =?us-ascii?Q?oz4QuyGreyu/wU1qyrElaAeHut2X8dI9kQam1hbZWU1fgzInrB4HX1pTbKlq?=
 =?us-ascii?Q?iJNvNhRSlxcl2eZ8/uwF32odeokqrmS2hS0yI0/lIE/4wY/SGzJeocTAPNc3?=
 =?us-ascii?Q?JvwG0iqqCmS/xLZ7c+umsEeZFT53iJ9T0MLiAlC32uoKB3klv7TgyTRauLib?=
 =?us-ascii?Q?k3dP8lORtRK1MRFWtcuy6UK8E1bae9gv5qBcBr38ql1nNji0WvG8HGVKQn0Q?=
 =?us-ascii?Q?3QPlqkzN9l0m3eymD+Eregx0lataxU+N+iUUT9OdX5NqWubo/lU0WD/AlsKr?=
 =?us-ascii?Q?DdX0BBGU5unEHvEkOk2iQluXZfnbBCwGmh0GpUeJr806WMV1AQ2Es5IpLyFD?=
 =?us-ascii?Q?1klDLlPiBx+J3ar1p8vM4sevwDq1TtriVYY95uw24scSBxQHGALgnDzFu7Hu?=
 =?us-ascii?Q?IR8FmkGL8INQ0N01n05/9Pg6QN13CDfpJb/1pNXGvSvS39okl8gq3H4quT7j?=
 =?us-ascii?Q?j5oxwXZnWgUEQZb8cVbAaD9MpXfH667479uKSu+HXw3iiU1j/Zy+EyavG0BZ?=
 =?us-ascii?Q?Zb3N4xck4LQ5hCJ1EpeTcrGASoFi3Z6Nsv3cv7CoB9Bh2voY5UwyXfakDDkq?=
 =?us-ascii?Q?PjssXPk89jpkVUOA9AU9e5gs7dixKJ2wvlA/2GCi1qP5ecLr2E6y8bPPmzjj?=
 =?us-ascii?Q?fPKoOjpuQhAhBEle0HAQeC4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67365C310A2A81418F08816DB4518692@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7909f899-517a-4462-2eac-08d9eb1f170d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 16:21:41.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQeZkj+9AO7LYxyCG7m07rvrVo+PbLrosf55JoHSlRVNsJ8EmllXZO9ikWglJ567dF4VscTfB5+oMp8YNdcQPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080100
X-Proofpoint-GUID: MV6juN6g3oYJIp1O0XRdtP066sZQDDuf
X-Proofpoint-ORIG-GUID: MV6juN6g3oYJIp1O0XRdtP066sZQDDuf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 8, 2022, at 11:04 AM, Steve Dickson <steved@redhat.com> wrote:
>=20
> Hello,
>=20
> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>> The nfs4id program will either create a new UUID from a random source or
>> derive it from /etc/machine-id, else it returns a UUID that has already
>> been written to /etc/nfs4-id.  This small, lightweight tool is suitable =
for
>> execution by systemd-udev in rules to populate the nfs4 client uniquifie=
r.
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  .gitignore               |   1 +
>>  configure.ac             |   4 +
>>  tools/Makefile.am        |   1 +
>>  tools/nfs4id/Makefile.am |   8 ++
>>  tools/nfs4id/nfs4id.c    | 184 +++++++++++++++++++++++++++++++++++++++
>>  tools/nfs4id/nfs4id.man  |  29 ++++++
>>  6 files changed, 227 insertions(+)
>>  create mode 100644 tools/nfs4id/Makefile.am
>>  create mode 100644 tools/nfs4id/nfs4id.c
>>  create mode 100644 tools/nfs4id/nfs4id.man
> Just a nit... naming convention... In the past
> we never put the protocol version in the name.
> Do a ls tools and utils directory and you
> see what I mean....
>=20
> Would it be a problem to change the name from
> nfs4id to nfsid?

nfs4id is pretty generic, too.

Can we go with nfs-client-id ?


> steved.
>=20
>> diff --git a/.gitignore b/.gitignore
>> index c89d1cd2583d..a37964148dd8 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -61,6 +61,7 @@ utils/statd/statd
>>  tools/locktest/testlk
>>  tools/getiversion/getiversion
>>  tools/nfsconf/nfsconf
>> +tools/nfs4id/nfs4id
>>  support/export/mount.h
>>  support/export/mount_clnt.c
>>  support/export/mount_xdr.c
>> diff --git a/configure.ac b/configure.ac
>> index 50e9b321dcf3..93d0a902cfd8 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -355,6 +355,9 @@ if test "$enable_nfsv4" =3D yes; then
>>    dnl check for the keyutils libraries and headers
>>    AC_KEYUTILS
>>  +  dnl check for the libuuid library and headers
>> +  AC_LIBUUID
>> +
>>    dnl Check for sqlite3
>>    AC_SQLITE3_VERS
>>  @@ -740,6 +743,7 @@ AC_CONFIG_FILES([
>>  	tools/nfsdclnts/Makefile
>>  	tools/nfsconf/Makefile
>>  	tools/nfsdclddb/Makefile
>> +	tools/nfs4id/Makefile
>>  	utils/Makefile
>>  	utils/blkmapd/Makefile
>>  	utils/nfsdcld/Makefile
>> diff --git a/tools/Makefile.am b/tools/Makefile.am
>> index 9b4b0803db39..cc658f69bb32 100644
>> --- a/tools/Makefile.am
>> +++ b/tools/Makefile.am
>> @@ -7,6 +7,7 @@ OPTDIRS +=3D rpcgen
>>  endif
>>    OPTDIRS +=3D nfsconf
>> +OPTDIRS +=3D nfs4id
>>    if CONFIG_NFSDCLD
>>  OPTDIRS +=3D nfsdclddb
>> diff --git a/tools/nfs4id/Makefile.am b/tools/nfs4id/Makefile.am
>> new file mode 100644
>> index 000000000000..d1e60a35a510
>> --- /dev/null
>> +++ b/tools/nfs4id/Makefile.am
>> @@ -0,0 +1,8 @@
>> +## Process this file with automake to produce Makefile.in
>> +
>> +man8_MANS	=3D nfs4id.man
>> +
>> +bin_PROGRAMS =3D nfs4id
>> +
>> +nfs4id_SOURCES =3D nfs4id.c
>> +nfs4id_LDADD =3D $(LIBUUID)
>> diff --git a/tools/nfs4id/nfs4id.c b/tools/nfs4id/nfs4id.c
>> new file mode 100644
>> index 000000000000..dbb807ae21f3
>> --- /dev/null
>> +++ b/tools/nfs4id/nfs4id.c
>> @@ -0,0 +1,184 @@
>> +/*
>> + * nfs4id.c -- create and persist uniquifiers for nfs4 clients
>> + *
>> + * Copyright (C) 2022  Red Hat, Benjamin Coddington <bcodding@redhat.co=
m>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor,
>> + * Boston, MA 02110-1301, USA.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdarg.h>
>> +#include <getopt.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <stdlib.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <uuid/uuid.h>
>> +
>> +#define NFS4IDFILE "/etc/nfs4-id"
>> +
>> +UUID_DEFINE(nfs4_clientid_uuid_template,
>> +	0xa2, 0x25, 0x68, 0xb2, 0x7a, 0x5f, 0x49, 0x90,
>> +	0x8f, 0x98, 0xc5, 0xf0, 0x67, 0x78, 0xcc, 0xf1);
>> +
>> +static char *prog;
>> +static char *source =3D NULL;
>> +static char nfs4_id[64];
>> +static int force =3D 0;
>> +
>> +static void usage(void)
>> +{
>> +	fprintf(stderr, "usage: %s [-f|--force] [machine]\n", prog);
>> +}
>> +
>> +static void fatal(const char *fmt, ...)
>> +{
>> +	int err =3D errno;
>> +	va_list args;
>> +	char fatal_msg[256] =3D "fatal: ";
>> +
>> +	va_start(args, fmt);
>> +	vsnprintf(&fatal_msg[7], 255, fmt, args);
>> +	if (err)
>> +		fprintf(stderr, "%s: %s\n", fatal_msg, strerror(err));
>> +	else
>> +		fprintf(stderr, "%s\n", fatal_msg);
>> +	exit(-1);
>> +}
>> +
>> +static int read_nfs4_id(void)
>> +{
>> +	int fd;
>> +
>> +	fd =3D open(NFS4IDFILE, O_RDONLY);
>> +	if (fd < 0)
>> +		return fd;
>> +	read(fd, nfs4_id, 64);
>> +	close(fd);
>> +	return 0;
>> +}
>> +
>> +static void write_nfs4_id(void)
>> +{
>> +	int fd;
>> +
>> +	fd =3D open(NFS4IDFILE, O_RDWR|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IRGR=
P|S_IROTH);
>> +	if (fd < 0)
>> +		fatal("could not write id to " NFS4IDFILE);
>> +	write(fd, nfs4_id, 37);
>> +}
>> +
>> +static void print_nfs4_id(void)
>> +{
>> +	fprintf(stdout, "%s", nfs4_id);
>> +}
>> +=09
>> +static void check_or_make_id(void)
>> +{
>> +	int ret;
>> +	uuid_t nfs4id_uuid;
>> +
>> +	ret =3D read_nfs4_id();
>> +	if (ret !=3D 0) {
>> +		if (errno !=3D ENOENT )
>> +			fatal("reading file " NFS4IDFILE);
>> +		uuid_generate_random(nfs4id_uuid);
>> +		uuid_unparse(nfs4id_uuid, nfs4_id);
>> +		nfs4_id[36] =3D '\n';
>> +		nfs4_id[37] =3D '\0';
>> +		write_nfs4_id();
>> +	}
>> +	print_nfs4_id();=09
>> +}
>> +
>> +static void check_or_make_id_from_machine(void)
>> +{
>> +	int fd, ret;
>> +	char machineid[32];
>> +	uuid_t nfs4id_uuid;
>> +
>> +	ret =3D read_nfs4_id();
>> +	if (ret !=3D 0) {
>> +		if (errno !=3D ENOENT )
>> +			fatal("reading file " NFS4IDFILE);
>> +
>> +		fd =3D open("/etc/machine-id", O_RDONLY);
>> +		if (fd < 0)
>> +			fatal("unable to read /etc/machine-id");
>> +
>> +		read(fd, machineid, 32);
>> +		close(fd);
>> +
>> +		uuid_generate_sha1(nfs4id_uuid, nfs4_clientid_uuid_template, machinei=
d, 32);
>> +		uuid_unparse(nfs4id_uuid, nfs4_id);
>> +		nfs4_id[36] =3D '\n';
>> +		nfs4_id[37] =3D '\0';
>> +		write_nfs4_id();
>> +	}
>> +	print_nfs4_id();
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	prog =3D argv[0];
>> +
>> +	while (1) {
>> +		int opt;
>> +		int option_index =3D 0;
>> +		static struct option long_options[] =3D {
>> +			{"force",	no_argument,	0, 'f' },
>> +			{0,			0,				0, 0 }
>> +		};
>> +
>> +		errno =3D 0;
>> +		opt =3D getopt_long(argc, argv, ":f", long_options, &option_index);
>> +		if (opt =3D=3D -1)
>> +			break;
>> +
>> +		switch (opt) {
>> +		case 'f':
>> +			force =3D 1;
>> +			break;
>> +		case '?':
>> +			usage();
>> +			fatal("unexpected arg \"%s\"", argv[optind - 1]);
>> +			break;
>> +		}
>> +	}
>> +
>> +	argc -=3D optind;
>> +
>> +	if (argc > 1) {
>> +		usage();
>> +		fatal("Too many arguments");
>> +	}
>> +
>> +	if (argc)
>> +		source =3D argv[optind++];
>> +
>> +	if (force)
>> +		unlink(NFS4IDFILE);
>> +
>> +	if (!source)
>> +		check_or_make_id();
>> +	else if (strcmp(source, "machine") =3D=3D 0)
>> +		check_or_make_id_from_machine();
>> +	else {
>> +		usage();
>> +		fatal("unrecognized source %s\n", source);
>> +	}
>> +}
>> diff --git a/tools/nfs4id/nfs4id.man b/tools/nfs4id/nfs4id.man
>> new file mode 100644
>> index 000000000000..358f836468a2
>> --- /dev/null
>> +++ b/tools/nfs4id/nfs4id.man
>> @@ -0,0 +1,29 @@
>> +.\"
>> +.\" nfs4id(8)
>> +.\"
>> +.TH nfs4id 8 "3 Feb 2022"
>> +.SH NAME
>> +nfs4id \- Generate or return nfs4 client id uniqueifiers
>> +.SH SYNOPSIS
>> +.B nfs4id [ -f | --force ] [<source>]
>> +
>> +.SH DESCRIPTION
>> +The
>> +.B nfs4id
>> +command provides a simple utility to help NFS Version 4 clients use uni=
que
>> +and persistent client id values.  The command checks for the existence =
of a
>> +file /etc/nfs4-id and returns the first 64 chars read from that file.  =
If
>> +the file is not found, a UUID is generated from the specified source an=
d
>> +written to the file and returned.
>> +.SH OPTIONS
>> +.TP
>> +.BR \-f, \-\-force
>> +Overwrite the existing /etc/nfs4-id with a UUID generated from <source>=
.
>> +.SH Sources
>> +If <source> is not specified, nfs4id will generate a new random UUID.
>> +
>> +If <source> is "machine", nfs4id will generate a deterministic UUID val=
ue
>> +derived from a sha1 hash of the contents of /etc/machine-id and a stati=
c
>> +key.
>> +.SH SEE ALSO
>> +.BR machine-id (5)

--
Chuck Lever



