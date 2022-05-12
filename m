Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C76524F5F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352053AbiELOD6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 May 2022 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354959AbiELOD5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 May 2022 10:03:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5A5711F
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 07:03:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CCiuRB024581;
        Thu, 12 May 2022 14:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CpesQZlSG7C4NSnVQEOVId3tPlvKwc7CA7wo1RJPHKo=;
 b=r/uCrQz/lvqCKzTFAk6PMUeL7gslL0k4bxZlTA9+ueDGFqYoqMMsUOIsUe8y9+3aXpIS
 hMPzFNr2aKqSdMw/cvDZ7fuxcsnQuL6oxdjMx0rwISU91op1LlbkZ8SW/wlJBf96sM5+
 cAqsvWDas6iVGim78Go6hZj7Tp9MWvWPoL+PUrFp9yF+V3aWiyQoPapLxcMjfz4Ga5xZ
 PeVnj0FFA8j3xg+KLd128PoDiyrs0S4mnH+TYhSPg3wWfIAIdfaBu3bcSyts5wEKmWTw
 s7GtkSZB+hD7B5d+dQSU32WxonIPiZZg79qKKDPVYTKWnxpHbJ4tCcY5QXz+6iszGTBU 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0vtxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 14:03:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CDtjB5002050;
        Thu, 12 May 2022 14:03:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7bu67t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 14:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXZqa7Gxx2Ey2o06gKZs3haMkTQmdjN6MgsNzJEwBaL9YgBdUUKrcGG1A8VhtEAVyi8glMy4vl9qN6ZbP1k+GU4pGQ/mp1wRIg0H16g77GxEeHq1BWJH63fYEDFLmlewXdx6Cy3NjX0LtClY1j6rh2IfbcBHvke0lLXHNCgISRCoWTbuLCGRmndXHA9VxWr8qPxm2/K1qiybZ4KxcBndXpToEt/1B9t3OIinUHOvYg5kiP/poNcoNNV5H1f3A3en3oWzRvZZgOdx98I0za8e7dt6ey+JFxjcOu55LzoPjQ66VteScGWquvwCa1oIrlEfmq7plDFCuNIQo4m9XrM2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpesQZlSG7C4NSnVQEOVId3tPlvKwc7CA7wo1RJPHKo=;
 b=CDVZlro0+HWZwaSa4623biGJZj9xdKLMVsCwvTGjfavz46STP14apzfRqUl9fA/OXgutihAZ4A4hVr/TUmzikg3B8deS1LdsHOjbe6gF9xtKS1piJiTT6/i7JDYy0u2WW2sYcOxlhhSx4Gccf3AlvH5f1CjYb6T3vNJURCF8550ko2Gunts7Ppn/EaSzjmYIQnjNyrHeRItyfyM8NsGdjP1Ogl4+QKC9HEgcYZFoQGMzLFhGKNw029mhSR4wzKfUjc6F0WokMOjbblWlKrifzU5/spFLZG4rdCmgrDhciP4f5+krtXUDIXqBYVe+Wu1F7LtTFl/rMOhD5fZoNfJW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpesQZlSG7C4NSnVQEOVId3tPlvKwc7CA7wo1RJPHKo=;
 b=HycuR+qk5GifxqfQBN7Hvkdvcycc+M9tD2asqxtn7oiJ9kvugbrhrp5XQi5zSkj+KF324YDLTQoWXIKz7h3nL805hWstDe0MlT86GFrc9O5AU17b0HfUZV663IeMC0Nwj81bM3jUcWGDqZru5mWY0ItC9ctvtsxFONTarkK0EJQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1281.namprd10.prod.outlook.com (2603:10b6:404:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 14:03:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 14:03:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>, Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
Thread-Topic: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
Thread-Index: AQHYZYGBzMCqcO/9ck6D4En09EhhVq0aOyIAgAEMDYA=
Date:   Thu, 12 May 2022 14:03:48 +0000
Message-ID: <1AC6F575-35C2-4FD6-B0D0-71876732A1DB@oracle.com>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
 <165230597191.5906.5961060184718742042.stgit@klimt.1015granger.net>
 <3092c3fc34621e72d39c54f03f5a6753ceeed216.camel@hammerspace.com>
In-Reply-To: <3092c3fc34621e72d39c54f03f5a6753ceeed216.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 051b1aca-101e-4be6-45de-08da34203c40
x-ms-traffictypediagnostic: BN6PR10MB1281:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1281991D2FFF7A479E2CC21593CB9@BN6PR10MB1281.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLBenC2genvXvLiuQb4zsmMoo/6bttG+oxVH6gHWvqK83DGcfPZTeaIX1OeOs/Gc8yhf9GZ4gybEWVp77euZ9Opsgphja8IiBdN2RO+DHHy8bXGpWlszRSvq663n/fNoLO3yYN2y2Ua9ta12lgEnEwWNKkkk68aXTkEWglGgahoUJU2+D/5XBUsIw2WlIuqB8nfUoLXIxGmTVC9cTPgPTl0/IP9ut7N66t1K56iWdScQyzjza/eGy9v1/w0KfF1zlnv3UnaXjhA3aTlqcAKHNBdfJ0LfiHcCBzUxRRozJCr6XdnspxI6Hvbph09quRRy2FMxVlg3nn95TiEdOFv9ij/9UKB9+3/YQsB8GRGheRRN69Oygv8Yvzh80fBJzLcEJsckgpw6TMcOGHwVKblC6MqR5X+TiyoV/zVyFUQ5eekcwvj25bbu3uysH+gkj0h/QL4NTyfAczI4DKgA7bpmokb6GbdDAbxhzkRu6jsaE5V4ZmwA4hPCjhM0AdsWV7vqvGF1I3402eDMVjo3dO/zIQPBMdfJ/V3TwmFydKnbqNhevrleVhb24x26I23c2Y5ElCgioK/wE05zUHy8XHybBDTM7BpmufKfXubaDP4FAvGAfS9f/NZcCcdMZ6QliXcrDL/3BV+PGguz027VVZQa9kccTy7qTsuqhieX5zzwdGDROX80kBEv17MoVFEyViaIva7+hbXp/3GHFmmykQWUO1bLxTg0ITch2ENXAf8IU0jNm/HdV9xcW9AUDozrk5Aj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38070700005)(6512007)(86362001)(107886003)(4326008)(36756003)(508600001)(186003)(26005)(2906002)(5660300002)(8936002)(6486002)(33656002)(83380400001)(66946007)(66556008)(76116006)(53546011)(6916009)(8676002)(66476007)(91956017)(66446008)(2616005)(64756008)(54906003)(71200400001)(6506007)(316002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QmZUJ3oYJR+hIqIe72gopERT+1NjL9Tz4WiCILXSDvxBFw9EDjhyCofQZx7R?=
 =?us-ascii?Q?WltVEhNN1EtZH/ZNnwkxPJzCqVOH9dsou9Sz9Nr3jQmuVHIgBQlE4yhzjoVt?=
 =?us-ascii?Q?jKocdcjMTMjhLzh/gIpcq7hC3F+/aCAvhCdyOLVVLAd7dDNKIBHxKfgmrkp1?=
 =?us-ascii?Q?QgMm2+EzKBEmOxPhN6yxbmkHHBDRyTOwh+oAqRNDmo8cPnhBj1pNXvx0A5wu?=
 =?us-ascii?Q?JV2z3/4ItXsa4S+F4SPLAQxLroWcLOmBCdx6/kong6MyhvoJCXISR/rfa2oK?=
 =?us-ascii?Q?WquxsJH7IOvdnok9mB17P7Scuid9CEClgSrvHjt/E07c4WeFtAbO48sncz/d?=
 =?us-ascii?Q?aJVDZfYL2L1kaoj5212ZmrgRjvDDLpX9oOWtS+U56STAmGn0KNOECma04iLD?=
 =?us-ascii?Q?mE3KM10mNKY9wSHuQaC1rIT6/4TteKr/cIEHTT/qOW5YzoYv6c3aXS6R8dwE?=
 =?us-ascii?Q?lGDcwdOEgBW4gTBbOMOTjVSq/uQdEGc92frPQu6eN9neckdpSHruEsgQenWq?=
 =?us-ascii?Q?1wsGm17FY6JfP1xK6FSioEP4LAaAzILLFswmp07goevLrqSqSPQTQirkY7iK?=
 =?us-ascii?Q?aWa9tJKlRfRHtWt/caw5VJxQOSTo0lU3h0ZaQ/A4AqyReXCNfIalHyFDXHOF?=
 =?us-ascii?Q?4vL53srr6OS9ac1C/HNVNzOZRc4cfc9uSj2AdoBFIkQSH86kwufggQvNog/3?=
 =?us-ascii?Q?SLm94EycmGOIyeJg+f//abDN+EDD0Qrosf2JoWZLmt730/vDWvuLGaQuMpQQ?=
 =?us-ascii?Q?tJCdoe88CInMHjQED1yqJwYCXtZcue9tJUS3aq6uaWy4ZT0eiiHDwL8it01C?=
 =?us-ascii?Q?n2o6WNhiFqvIAhR8uamJFPuB/aiAiFZmuld+uaGaeubiCWNGeePFTpOagrLN?=
 =?us-ascii?Q?65T/w+lzIUllZAw+CXFQeESHmF3YpMmlBYlmFVOlK/XsUocj+/yzSBFDEmzQ?=
 =?us-ascii?Q?lhACm0oxDRnahjVPBFCsFycnemPvYsMAxzLfzhtXsrwrhVLxOerx/gfJuVQz?=
 =?us-ascii?Q?AUA1NGe+zv4+JDGa8runm580EwOc+9GPqh4PpyIuTwGcsdBWAtjYqmYgDhZV?=
 =?us-ascii?Q?rCyPnCVjUo1XpKISW5CUYFj92wUqZxRkM79xpP9WlnT/v8sM4qMpM2F1GTPV?=
 =?us-ascii?Q?wAhOInpmyHYbLbcOlOBckUyONy9jlxvz9skBhllhEqHuoZknybC9qrTd8elE?=
 =?us-ascii?Q?C+WeTIwn8q/LlTkntWYs5Fks12O7hjHYCHUKarBTExnAavI73RFSRlArg97t?=
 =?us-ascii?Q?BqpiQ8kKsgqcBKotmI4nT4iKfJcTluXKDDuNy8o5ufGUqPKIj/ZtAoG2JCGb?=
 =?us-ascii?Q?iQXZn9BEPAQZOrNOiuMWxNFWqI7t5a61UBhDibdLy424S+aN9u1zepWQ3lp5?=
 =?us-ascii?Q?WzSeezu2wJLWojpveIAjIYXsIgC+8pLO2nbSvVD/3TC3doCH2gJoaAPIbOcJ?=
 =?us-ascii?Q?cNBQsI2YP+a7vDAsxe8cRBe3N+DSPL0B3GBkhpDni3xdB562VdJcppBSd2He?=
 =?us-ascii?Q?mWEYHoU/fMGa2gqEmgMEpbbOPp645wDvJn4/6fGhguikGQo/f+tjtMy749q6?=
 =?us-ascii?Q?iIwYJ+BaXkCpDHmlVftuDAP5KtpbqCI8Csfj+4bM63PIyUeqV3UjUkD9/9j/?=
 =?us-ascii?Q?lT+tSFt1Ff6n1bP3OS9znGw6wdtWtK2R/enkCZ8qfygllKFQMa2V6ixyvM3c?=
 =?us-ascii?Q?PLnYxm4u0HMgpbth5cs2RxOSgZzArDD48ol5zarovz/c1maf7ce7WHD0gl7Y?=
 =?us-ascii?Q?KnzHBARzP+zMpKqerxTavJvLvhQQ9y8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <854C90A166BE5F41A27F48AB30800B7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051b1aca-101e-4be6-45de-08da34203c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 14:03:48.0308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utJNezjM7N9tdfQqFLN2+sEpWpsBiMYyr7Kwmgp13RQIPITcOz3yDwBN9rTYMLI0jhgKEbsnbxhREuTC3QgO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1281
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_06:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120067
X-Proofpoint-ORIG-GUID: f8uLB2QeYhcVU5hgIlIpR2nRxEq7TvX-
X-Proofpoint-GUID: f8uLB2QeYhcVU5hgIlIpR2nRxEq7TvX-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 11, 2022, at 6:04 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Wed, 2022-05-11 at 17:52 -0400, Chuck Lever wrote:
>> nfsd4_release_lockowner() mustn't hold clp->cl_lock when
>> check_for_locks() invokes nfsd_file_put(), which can sleep.
>>=20
>> Reported-by: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  fs/nfsd/nfs4state.c |   56 +++++++++++++++++++++++------------------
>> ----------
>>  1 file changed, 25 insertions(+), 31 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 234e852fcdfa..e2eb6d031643 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -6611,8 +6611,8 @@ nfs4_set_lock_denied(struct file_lock *fl,
>> struct nfsd4_lock_denied *deny)
>>                 deny->ld_type =3D NFS4_WRITE_LT;
>>  }
>> =20
>> -static struct nfs4_lockowner *
>> -find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj
>> *owner)
>> +static struct nfs4_stateowner *
>> +find_stateowner_str_locked(struct nfs4_client *clp, struct
>> xdr_netobj *owner)
>>  {
>>         unsigned int strhashval =3D ownerstr_hashval(owner);
>>         struct nfs4_stateowner *so;
>> @@ -6624,11 +6624,22 @@ find_lockowner_str_locked(struct nfs4_client
>> *clp, struct xdr_netobj *owner)
>>                 if (so->so_is_open_owner)
>>                         continue;
>>                 if (same_owner_str(so, owner))
>> -                       return lockowner(nfs4_get_stateowner(so));
>> +                       return nfs4_get_stateowner(so);
>=20
> Hmm... If nfs4_get_stateowner() can fail here, don't you want to
> continue searching the list when it does?

You've lost me on this.

 494 static inline struct nfs4_stateowner *
 495 nfs4_get_stateowner(struct nfs4_stateowner *sop)
 496 {
 497         atomic_inc(&sop->so_count);
 498         return sop;
 499 }
 500=20

How would nfs4_get_stateowner() fail?


>>         }
>>         return NULL;
>>  }
>> =20
>> +static struct nfs4_lockowner *
>> +find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj
>> *owner)
>> +{
>> +       struct nfs4_stateowner *so;
>> +
>> +       so =3D find_stateowner_str_locked(clp, owner);
>> +       if (!so)
>> +               return NULL;
>> +       return lockowner(so);
>> +}
>> +
>>  static struct nfs4_lockowner *
>>  find_lockowner_str(struct nfs4_client *clp, struct xdr_netobj
>> *owner)
>>  {
>> @@ -7305,10 +7316,8 @@ nfsd4_release_lockowner(struct svc_rqst
>> *rqstp,
>>         struct nfsd4_release_lockowner *rlockowner =3D &u-
>>> release_lockowner;
>>         clientid_t *clid =3D &rlockowner->rl_clientid;
>>         struct nfs4_stateowner *sop;
>> -       struct nfs4_lockowner *lo =3D NULL;
>> +       struct nfs4_lockowner *lo;
>>         struct nfs4_ol_stateid *stp;
>> -       struct xdr_netobj *owner =3D &rlockowner->rl_owner;
>> -       unsigned int hashval =3D ownerstr_hashval(owner);
>>         __be32 status;
>>         struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp),
>> nfsd_net_id);
>>         struct nfs4_client *clp;
>> @@ -7322,32 +7331,18 @@ nfsd4_release_lockowner(struct svc_rqst
>> *rqstp,
>>                 return status;
>> =20
>>         clp =3D cstate->clp;
>> -       /* Find the matching lock stateowner */
>>         spin_lock(&clp->cl_lock);
>> -       list_for_each_entry(sop, &clp->cl_ownerstr_hashtbl[hashval],
>> -                           so_strhash) {
>> -
>> -               if (sop->so_is_open_owner || !same_owner_str(sop,
>> owner))
>> -                       continue;
>> -
>> -               /* see if there are still any locks associated with
>> it */
>> -               lo =3D lockowner(sop);
>> -               list_for_each_entry(stp, &sop->so_stateids,
>> st_perstateowner) {
>> -                       if (check_for_locks(stp->st_stid.sc_file,
>> lo)) {
>> -                               status =3D nfserr_locks_held;
>> -                               spin_unlock(&clp->cl_lock);
>> -                               return status;
>> -                       }
>> -               }
>> +       sop =3D find_stateowner_str_locked(clp, &rlockowner->rl_owner);
>> +       spin_unlock(&clp->cl_lock);
>> +       if (!sop)
>> +               return nfs_ok;
>> =20
>> -               nfs4_get_stateowner(sop);
>> -               break;
>> -       }
>> -       if (!lo) {
>> -               spin_unlock(&clp->cl_lock);
>> -               return status;
>> -       }
>> +       lo =3D lockowner(sop);
>> +       list_for_each_entry(stp, &sop->so_stateids, st_perstateowner)
>> +               if (check_for_locks(stp->st_stid.sc_file, lo))
>> +                       return nfserr_locks_held;
>=20
> Isn't this line now leaking the reference to sop?

Indeed. Fixed.


>> =20
>> +       spin_lock(&clp->cl_lock);
>>         unhash_lockowner_locked(lo);
>>         while (!list_empty(&lo->lo_owner.so_stateids)) {
>>                 stp =3D list_first_entry(&lo->lo_owner.so_stateids,
>> @@ -7360,8 +7355,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
>>         free_ol_stateid_reaplist(&reaplist);
>>         remove_blocked_locks(lo);
>>         nfs4_put_stateowner(&lo->lo_owner);
>> -
>> -       return status;
>> +       return nfs_ok;
>>  }
>> =20
>>  static inline struct nfs4_client_reclaim *
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20

--
Chuck Lever



