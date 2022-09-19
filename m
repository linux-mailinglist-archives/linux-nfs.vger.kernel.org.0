Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1995BD591
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Sep 2022 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiISUPf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 16:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiISUPa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 16:15:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F24363F
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 13:15:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JIjm2a015093;
        Mon, 19 Sep 2022 20:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Hlv69yJ291Fp+uaftCu4jx5OMSkdL/kwSb3cH2esFxk=;
 b=oFjpy3XKNtBl+5rP0sRwIcffDkfssPmNXjrkCM0nAU5ooLAbZHuwu0xcF9eE1amx6KD0
 t9zJwJC+jmIkvfjhab9N2PFykVUjamzBNM1+cve0zd/SAUjSZrjBl7C3KMZuL7aW/9CV
 ip/J8ntZt8pzYAXi2X2X8GTBM/IS/Tzkk4GmvarQ3vnYQxiPg1nb+47pNFOTvWO3rDtN
 2pIVJj49I4mP4SSkGOQ7pwqOgjRd7N1UPCMIv/EB0onXfRBSFFlp4856uSRt/nbrHjBX
 t38MbCdrAJhmCncOrS/Nvbk1KXn5i+M0Hqj2T7mKM6yczcskiFDeyGT6byDVoShHfuKR 1A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m4vwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 20:15:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JIBrgC035858;
        Mon, 19 Sep 2022 20:15:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39jg8kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 20:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdijHzoRvKiWC7s13xR5+5B+4RqmnACBvUFpdUsG4nXelOZdXn09/jF756ZsUqqIBWSt/VuKxr9az2Ez3DRRMrvFpN9auKEhQxHec+UXsLI6wYAMV4Vum5uzD/lMM86KM1uh6EvnTGqhmjtUMf05nLd26lPVNA0S5GU/HsLy/xO9UgPRme4hYjMIA2Y56QrDLFZsMm9vHh9WOgmKbPbU9D43/KeSbsADNXULTJTTNeMDk9U6WHY9si93LQpAS18tkcDMkMVy9yku1dzv/JxclWrcaAHJ0lANOm385NUGFPYQeA12gOjOKZvJjwxqoekpITAODSgQVKEk9Q6jI+IdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlv69yJ291Fp+uaftCu4jx5OMSkdL/kwSb3cH2esFxk=;
 b=h+AKcqWr2/Uvybxxq1f8/GP8IQWCBAXTaVJnloODwDWkwcA54wyGGxCdK/thGdQrI1UQwGwi35oZxA0fCeSFWD7E0PpymPwvYe5u6vqgDdS9VO896jp+4fCASSJX2l9n0w8zMo9IZQu6rVWhCD9PDgwIx4sNZcjtYvBdDcUuEwz08wLgpnN7p4rLZ57fM1ZW5kafuyKy3Y0L1rxQk9gCnZU6MvWpkqPdHvhccMz+wuTcpvJ3qhbBqU9cyxhoBrKEu7ETCpVgCAavOC7wlnO5/rsA68mdnNfTgqpJpqBvVe8BrAsP5ZKn7wsqY5rjT41vvuzrGcqliuEmuvXe/ygSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hlv69yJ291Fp+uaftCu4jx5OMSkdL/kwSb3cH2esFxk=;
 b=Kz45Z7UZ75NCj//N23e3acIS+Sujij6Q7wVp/tcGGimo/7Oz42Z7Ia/KgSnSx9Ut7i97BK65TVmFrQCZ6GWX+5L1BFZVG0FS8nL7Dco3PATXiq02kcLe6OYaLnw27/nQkjaUJi3Uv2xB+0utMeLjpO61z9E4FRqMR9UhyjzRyv8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 20:15:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 20:15:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Subject: Re: NFSv4.0 callback with Kerberos not working
Thread-Topic: NFSv4.0 callback with Kerberos not working
Thread-Index: AQHYzDztMjvFTe1YQk+Xo2ZaIaryZK3nCq2AgAAEdwCAABVygIAAC/sA
Date:   Mon, 19 Sep 2022 20:15:13 +0000
Message-ID: <35488F16-CE9C-4633-9E15-AB73633499E7@oracle.com>
References: <BE5B3B9F-53EF-49E4-9734-CF89936D5F2C@oracle.com>
 <4e79b32842427aa92bf62c5c645430bd23b413e4.camel@hammerspace.com>
 <1BEBDDFF-EB65-47E4-83F4-DA2F680B940E@oracle.com>
 <CAN-5tyF+-1k0d941zpMMFiXxsTVAbX3d0qv6X38bO49ReOqMdQ@mail.gmail.com>
In-Reply-To: <CAN-5tyF+-1k0d941zpMMFiXxsTVAbX3d0qv6X38bO49ReOqMdQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4683:EE_
x-ms-office365-filtering-correlation-id: 7d196ce6-6944-483e-34a6-08da9a7ba961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N05RxbfoLi1okyzN3mYn7UpyMltXjtpTTPzblikN9O8ZwjnYNV7yfJrXzLCK0sKdXARhDiSLj6pMQ5AIih418puaaCMHdt3cnTZU8JU1ggVGtH8rb/G0t/pKNGKlDKtJ8Lxh9PlybvqhXJ6IQlaTRSdL54Mb0m5dKBsQQzGd/3yy4jS4rtLKdoLPqlPZ7B/G2gAxrGvRJqHKiawGBkxhadPl22oJUkno7fXhLATRkA4nb8rIgjeXSKd2fRs3vztr8wj7/52Qd/QtDwInhIyklD0ABJTrH3cEOzHMZACaqTDMLTEW8SlInw6oTZ0eVy32daihzr47hf2LFiW/bLR1pvPojlw9VvsUXWoVdlzSU2TLFrmRuTo6/iHdzQuzFL4TAG1wS9WXTVHw+aGvlKC5vlIr/EK+wzpc4HrFuXfpmCsexQfFxlo8dTrA2KBGQ8ySrFZqv6aXwBQ4koZpOwD3QmBTxx7f+4Oy53JSkdEzZxbll3S3aCHBAXlC0/DCDPQ5YrjGRfA0wL7VsJSHt/3AcC1S12dHvaM2UzWfgAOTEa8oAF/V1aRrlxb9MQOMPprPV5L+bVimcrRyCsUpxT+yfpx/X6z63m9ILEzZXZG02NAZiLxoZAlz32BTCjyrjJj+cu5dHJwF4Fb/NMd7UYfQuIfSisX5TWV2n8LP6SswVV38KB0aamxPoVw4Nf/OWYB9DeRSjokybGfVNqsFIzBxDWPz8lsO4AWf2i/bLr/USVJEc37GPH8d5pFamBf5hodSaziFd4n6gUhkWsW8RLt6xTnmtt56AuP75Zsx0bDOfDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(83380400001)(186003)(2616005)(38100700002)(86362001)(38070700005)(5660300002)(41300700001)(122000001)(8936002)(66556008)(71200400001)(66946007)(76116006)(91956017)(66446008)(64756008)(4326008)(8676002)(66476007)(2906002)(26005)(6512007)(6506007)(53546011)(54906003)(6916009)(316002)(6486002)(478600001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qHhfzpMJTQDnd2Ej5JhfOl1l/g7fpVNd3UWyuOMQ3+hZnC6snibvsz+Xugap?=
 =?us-ascii?Q?GfmwNXB7QP/UK9mEexNH3drVhCOxumZv347gfHNfFxFsporf6ClXtL0I2F7U?=
 =?us-ascii?Q?uVPk3IwJlOB6ZUbppp4Feffrjs7c83q24TMv0Ee3XlRyARM09d152pnoOiFz?=
 =?us-ascii?Q?JaZ1w3/cSqvMFsFLciI9m2O1pUrSmE/xaJQsdJnxfRfJmyUFu+3ZvR+1W+E5?=
 =?us-ascii?Q?RM/X/hvB9yYnjP4rQT5MTrkNrMSGWcODoWz30MuAoruioX+hlI8s2mDpy8cr?=
 =?us-ascii?Q?kK/75zjhj5LDOjz+ygobnh8f1JYZc1Vf1/5xBRyrbB/zRBsuq2lwzQIwMdeF?=
 =?us-ascii?Q?CLz2Dw2UE2KgIDXKZei+OTMXP+VvQiNo0W9N+CPl9xuW2d1JGJAvfWtmNNRm?=
 =?us-ascii?Q?KbDbJjpIA5UAnn+uq9hS2/8yJwtVtosGNo/9o13Wk8Tg3nwbVFd7AEqcZSUu?=
 =?us-ascii?Q?BuRyheuNY7pCfPNEZbhvuh80Xc/BqIgaD5HdzgjdJ8seiJwDJK77H9cQq4QM?=
 =?us-ascii?Q?lvmHQakat+ghkBQpJ2sYQxnSTmiXYM5crmyM4BFu8Wp8LLaqBQj7ltfFmvSn?=
 =?us-ascii?Q?7l2lpM8oxk6QE+tFrutTWiU4cZHGwc8gEtg/1391gek8zInNFFuhHXTMX0iA?=
 =?us-ascii?Q?gFleQgrssaMj/HLfpcMmUNwnvEQjEzfuau3t7pYXyD9id60vaQIr1oZHTJUk?=
 =?us-ascii?Q?o9QdjkJl5SEOtzI5YmGm53XMmRgqWq2G207nzgcZn78DwJ3kVAL4Fyp8GgEa?=
 =?us-ascii?Q?3tn3rUVegtcav6iSicGugsnlTiGESGSPttqizMzktYKa8k3gU49B/SGw065W?=
 =?us-ascii?Q?WZvF1i9BHb0sYBxCr8t7t0axGJQFH/cCO9zFptM+CrxH5gSJt3LNWcfNPKNy?=
 =?us-ascii?Q?TGKNrCxkwLyHUdgBBqyKYQgzzoA8/u/zdwjhXb8oSURnpHB/46m+jxKA6SaE?=
 =?us-ascii?Q?L3qklzOmXzR/Q+pp2VBXQaNEAL/PZJ/ORpLq8LcCFeTws1g8gin6N2y/MUoM?=
 =?us-ascii?Q?LLp/exrJQePuOvXweE9Lx91WiXMjkhxzFN7eEhjLCkS8+/0P2YvPk9zlBR5s?=
 =?us-ascii?Q?a0OjT1vN4QVj7zdmxh+yvU/4O2n2E0iGGPOACY3M31eWxUTDL/jJX8VdIrMM?=
 =?us-ascii?Q?t61H3R7yE+yJmHp0ojae4Vzk2awv85sRMn/DR+RYRJbm8GjDANvjFAffTrWc?=
 =?us-ascii?Q?Tk71QJgawlHcMwZ2cg9JUTkwMy4k9oPix+du+rqS3U/EmZ1wRNR6wSSKWYKR?=
 =?us-ascii?Q?P7eBt8PHwDYPcQCCx0Z1+hn+2m9kFsRCw0K0LVrREY5XhjDvN93Nrk1IOAyC?=
 =?us-ascii?Q?c1/s7yauz9gbmh9H0EmE5cNfNXVfBlPuBah7mJB0bXAa852eyAPV13pRFoS0?=
 =?us-ascii?Q?1dJymEcLX1ddx/uPuUrSBNqVs2E0CzdSvQxUC1x/l1Qcg8Tm2bNeDMP6ZuHy?=
 =?us-ascii?Q?DfwEs6ks+xZpxhGgC286+T6oj5HJ7O2vaY0oDm3iLw1/lalmspUEGD6RGT+1?=
 =?us-ascii?Q?OHIJ8VfJP8q8327Xl4pqTDyTvB+ykEffjj96kv+JUOQZ4kebUhkCe6hJRhP1?=
 =?us-ascii?Q?AcvX8f/MI+SrdTYoC3+jVYm4XlYgWERm2SyYa6gin2dqTzaLyb1078T/Jqck?=
 =?us-ascii?Q?7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15ED2ED96B5AFE4FA4B7E5C72A9D21D5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d196ce6-6944-483e-34a6-08da9a7ba961
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 20:15:13.9408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guP4EfTjblhWOSGEaE6X2S1xqBU553Hnwkfmk4igkZqCWKsa7x1Gtan65G8vD4foTvKdlk7BRhC/ITFqiRtouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190136
X-Proofpoint-ORIG-GUID: npzYFJZkEd5A_k4bJhBtwalFxHO__mwi
X-Proofpoint-GUID: npzYFJZkEd5A_k4bJhBtwalFxHO__mwi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 19, 2022, at 3:32 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Mon, Sep 19, 2022 at 2:16 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Sep 19, 2022, at 1:59 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>>>=20
>>> On Mon, 2022-09-19 at 15:31 +0000, Chuck Lever III wrote:
>>>> Hi-
>>>>=20
>>>> I rediscovered recently that NFSv4.0 with Kerberos does not work on
>>>> multi-homed hosts. This is true even with sec=3Dsys because the client
>>>> attempts to establish a GSS context when there is a keytab present.
>>>>=20
>>>> Basically my test environment has to work for sec=3Dsys and sec=3Dkrb*
>>>> and for all NFS versions and minor versions. Thus I keep a keytab
>>>> on it.
>>>>=20
>>>> Now, I have three network interfaces on my client: one RoCE, one
>>>> IB, and one GbE. They are each on their own subnet and each has
>>>> a unique hostname (that varies in the domain part).
>>>>=20
>>>> But mounting one of my IB or RoCE test servers with NFSv4.0 results
>>>> in the infamous "NFSv4: Invalid callback credential" message. The
>>>> client always uses the principal for GbE interface.
>>>>=20
>>>> This was working at one point, but seems to have devolved over time.
>>>>=20
>>>>=20
>>>> Here are some of the problems I found:
>>>>=20
>>>> 1. The kernel always asks for service=3D* .
>>>>=20
>>>> If your system's keytab has only "nfs" service principals in it,
>>>> that should be OK. If it has a "host" principal in it, that's
>>>> going to be the first one that gssd picks up.
>>>>=20
>>>> NFSv4.0 callback does not work with a host@ acceptor -- it wants
>>>> nfs@.
>>>>=20
>>>> There are two possible workarounds:
>>>>=20
>>>> a. Remove all but the nfs@ keys from your system's keytab.
>>>>=20
>>>> b. Modify the kernel to use "service=3Dnfs" in the upcall.
>>>>=20
>>>=20
>>> There's also
>>>=20
>>> c. Put the nfs service principal in its own keytab and use the '-k'
>>> option to tell rpc.gssd where to find it.
>>>=20
>>> However note that 'host/<hostname@REALM>' is normally the expected
>>> principal name for authenticating as a specific hostname. So I'd expect
>>> clients to want to authenticate using that credential so that it is
>>> matched to the hostname entry in /etc/exports on the server.
>>>=20
>>> The 'nfs/<hostname@REALM>' would normally be considered a NFS service
>>> principal name, so should really be used by the NFSv4 server to
>>> identify its service (see RFC5661 Section 2.2.1.1.1.3.) rather than
>>> being used by the NFS client.
>>=20
>> Fair enough, we can leave the client's service name alone.
>>=20
>>=20
>>> The same principal is also used by the NFSv4 server to identify itself
>>> when acting as a client to the NFS callback service according to
>>> RFC7530 section 3.3.3.
>>> So what I'm saying is that for the standard NFS client, then '*' is
>>> probably the right thing to use (with a slight preference for 'host/'),
>>> but for the NFS server use case of connecting to the callback service,
>>> it should specify the 'nfs/' prefix. It can do that right now by
>>> setting the clnt->cl_principal. As far as I can tell, the current
>>> behaviour in knfsd is to set it to the same prefix as the server
>>> svc_cred, and to default to 'nfs/' if the server svc_cred doesn't have
>>> such a prefix.
>>=20
>> The server uses the client-provided service name in this case.
>> If the client authenticates as "host@" then the server will
>> authenticate to the "host@" service on the backchannel.
>>=20
>> Maybe the only mismatch is that my server is using
>> "host@client.ib.example.net" on the backchannel, and it should
>> be using "host@client.example.net" instead?
>=20
> Given that the spec says: "therefore, the realm name for the server
>   principal must be the same for the callback as it was for the
>   SETCLIENTID." Doesn't it mean that the server needs to use the same
> domain/realm name as what the client authenticated to in the
> forechannel (ie server should be using @client.ib.example.net realm
> for the callback channel)?

Yes.

If the server is using the client's acceptor, then it should
authenticate to whatever the client sent it. The server should
use @client.ib.example.net only if that's what the client sent.

The service name component was a red herring.

I'm looking into the Linux server's behavior now, but I have to
revert all my debugging crap to get a clear picture.


--
Chuck Lever



