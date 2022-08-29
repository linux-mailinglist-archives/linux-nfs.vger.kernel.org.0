Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD155A4E86
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiH2Ntk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiH2Nsp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 09:48:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA295E61
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 06:48:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TAWOJ0020679;
        Mon, 29 Aug 2022 13:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hRv+kDwPXVOQZ2PsW2Q8sZMaWRTCttUrHOH2w7LiTkQ=;
 b=sGbcF52tOovFU0LdNUGfC7iKqK/keBL31bEBpdusL1R6j/XcrPUbzAQKM1/1R8Qy1H2u
 jiD+JEcX3eA36N5eyAM4s+XMMUNLMTz0kZLc9K3Yi4twWbsvFQfFcsVCyaJfyHZXxzNz
 zC4JtqN8FzMObHOqbcsXlABN2sSqkEltGC3UjSrearVXnIePs14jcig3fnxx3ze1w2kB
 1UZWRadJkeMxUPp2RkXTs58oiXfn2PbeS1S11rvMmreVxBqFLXbRxRxBFZK5qJfyKrG9
 v4X0AYfq/74LZ2eYHo/ppagKUAbANS0OwxR1lnODqrpeU7+cAyqBeYHKbBw1I8EkSsJ9 Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79pbuebu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 13:48:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TCQVf7005220;
        Mon, 29 Aug 2022 13:48:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q2cej2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 13:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa2pM7lxHukxWssnuH+iM8AHzmHdfwzI7n4qcC0ZCo+QKjkeobih4TGBQWTqa3Oa+jgDLuRymB4Gtzq2uebEJHbvcvKQR+A5XmUObkAGZAVOb/qxqOY97xC5oux8qqkeVggllRvsTclekflV/5k0H08EfCd6eKejgs5Nz+0bexFbNx0S4AOOI53pQ21t3vR34pyOYRdox5/x8jEVilOfcZELMD1rdE6xVg163cgdM2o6YeE1M4OgqukbeXrt5vpnLvUPBKWJGGgR9OP5/QxZRmEZdWscpXDolukgtqUsxvtmvCKD4yZMzCkxyO1rckYonq1Qf9vLAtN7I0bHr0LzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRv+kDwPXVOQZ2PsW2Q8sZMaWRTCttUrHOH2w7LiTkQ=;
 b=m2A8U9S+V+igoYi7TZ9jwH37kGqFJfvNHpUM4qkMkstTTqNpahhZqw08H/r087HxJLYJRa99O5Dkd761hyen7CkcPLiA158cV6Rl+58IfuxzT1TkkVacpDSFfEdpOsxAhgnp6WmhpWXhNM7HEP7U2JsNfY8CltlpTU4qV2dhfko4X/z+Gu7BxMHj5moDo2egtWMDz7RC/r5OL2sTDH9yNRKG8a8T1eXnjeqGnhq7uYYlf8v3Pshs3xaQPDBhSuXf4QE5ySzYDjIv50KuPczN3jeGavaEtH02/P669XSnXxdKO9Sx22nsbk4mAPDJlKIYtRBO0vqjqb6gnmj5GO+Bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRv+kDwPXVOQZ2PsW2Q8sZMaWRTCttUrHOH2w7LiTkQ=;
 b=umizx8vAi0nQqK1bg8pWPthbkx3HWp7kwcM5Ye9oo79ZcZQNF5r133PeCUYmIglDg1yIHDGToyMtKa8uvf+s7mhx6bQFfXkahs8GdJWwKEze1JJIpOzlIr1XE2d35XXZhrENnT/nldY8oEV/CRWaoYCFQR+tOj68HWAuec4SShY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6148.namprd10.prod.outlook.com (2603:10b6:208:3a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 13:48:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 13:48:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] SUNRPC: Fix svcxdr_init_decode's end-of-buffer
 calculation
Thread-Topic: [PATCH v2 1/7] SUNRPC: Fix svcxdr_init_decode's end-of-buffer
 calculation
Thread-Index: AQHYuw8NLpINjVD8BESjnrwXDQGVx63F1TaAgAAQuwA=
Date:   Mon, 29 Aug 2022 13:48:35 +0000
Message-ID: <848BD172-74D4-4E2B-9CA8-C795F9DEC35D@oracle.com>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
 <166171262197.21449.2261873517844800915.stgit@manet.1015granger.net>
 <3d6242195f2ea33fc10d8e7dafadb9e5ad65b1be.camel@kernel.org>
In-Reply-To: <3d6242195f2ea33fc10d8e7dafadb9e5ad65b1be.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f2bb455-b67c-4663-3b44-08da89c52b27
x-ms-traffictypediagnostic: IA1PR10MB6148:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxAv+YqLs76eLD3JkGG859Vxst5//wwK5P0W0xTQCqYorzDiwJqSUykbPfwIhKYjKpjMaqksfAg7iSh6OHZKiHOGoGJPPU8hBRDoFheOMt2NARkCmLYJ/fSPiRRzd2fiR3Zjj/P2UyGLm29ZlSWNkNQNex5ut1NozXgi23Oc4F+vFN0ON1Q+Lj3zwKqAnQR31IMwzEEYcgoH/xotlTXVZfLrN99v/Jb/LMoHF1s3Bvn3YbF/iEo3BxchASy8fbt4IWLHzLo9Rr2IMeUmTlyk50MvNPp52oa8od/8j3nxfzDJqfuGiXlXQppKC4/soXxYPsoAuBZeIr5yyDDGq4ZaQmWIKL930L917ErtxFoDYcN/01wWu2lI+wbphmMl2+dsNFjMCjqfSRODCLkVu2t+ajhzGI65+kEbTxZJa6YhxBRwChUx2u1Nzq2iJdIRUKc/5SmJ9+tw642e8uFkux+FbtKDpodeOR8xc5LrBC7V7TUz+5QGWKmWtdyDgOTmHrFVjgw/D/0hfCBX/EN1WYOQBqFxw0bbkRKmwGeGvU2GUr7h7ETP1C3RQuWwlzTm4SeCQgTnEuzSgaTOQ8SFGKPXJvgaqfkjN0S1F6W+Ma4qrJdo8bQG0U/k/lFy0lCX+e4MHq3xA+xDrDJS+VCzW4F6pI3W3bBcbo6znB3Y0n2AzFMBuH5AJsFwxV8YMpPJWNPM9uh5lBUk7S/zJxG5kylU5GOGo6HakAPUqIP+m4tCOMi63UQPFXi+cIffsHRT1z5Nk0WMEu8itDZUMm1ndy69MUy/nGupLFdyuAD3CUOss0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(366004)(396003)(136003)(316002)(38100700002)(6916009)(86362001)(122000001)(6486002)(38070700005)(36756003)(33656002)(6512007)(6506007)(71200400001)(41300700001)(83380400001)(26005)(53546011)(186003)(478600001)(5660300002)(2906002)(8936002)(91956017)(2616005)(66476007)(66946007)(76116006)(8676002)(64756008)(66556008)(66446008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eL2XCE+ymakiGji54v59zXBxZCVeekX2UzQLoOX3iAg6wlHb6AUEYzeqZn4X?=
 =?us-ascii?Q?3pgc4QBgfhChj8pTUdHA0hrgiZAca0TQQtWS2PKNDCxpaGl70q/adm9gvp4m?=
 =?us-ascii?Q?3NlWNXKif4RD8Zl/fABMpLd8i1TCgKAf9OyRSVvpg5xzSwsCkezUbD+abkhF?=
 =?us-ascii?Q?25RD3vkBt9RvsWS/s63YK1+QVglsuvcqkI3UEKVi0AbofwJZVzx8DWt9j65m?=
 =?us-ascii?Q?OlwoJKHc01ORGwBqFNpuklVdE1TSjRr3pptTdZVmjOvP/V/IonMu/swSDbSw?=
 =?us-ascii?Q?qZntuNpauMAh9DMPqZOD3zQAF/Bd5bPcgFwytrKX18Ek/eto1ycCBOAr6Ntl?=
 =?us-ascii?Q?z6HVsgmCL4BsAySsBe8Fvr39GFkNaqlKo0uHU69FgmpkIpWR/EO/pd/EiJRn?=
 =?us-ascii?Q?OzniIrZjqhVmlTvt1/uir/zujNrWnuBBShOyTC2QdN1aCIpjhi4a+Bh+694i?=
 =?us-ascii?Q?zbhDSULWiDabOVIBiokVdwZAP2V4mCTtgLInT1u2EzPks2WQ2OHlRfBYPrO+?=
 =?us-ascii?Q?MNZoy0uvx/lJP2MA5IAOz54cs0Doob2XGCDNCxDxmgz5rp/oUxIQpkqu62pt?=
 =?us-ascii?Q?dn/2kWnGqPzkV1NAOUS6UmVIP3Z8w++DAvm5Oy6jUFt+fSv/uvpZZkg6p7L4?=
 =?us-ascii?Q?n3T0stQ6Ho3hLbzaF6p8fP8vSJI2kkuTKBs3mqJCqDyNvGIPJKdZB/TWBCNN?=
 =?us-ascii?Q?sKjJXKCVNj3FSwRi7gIhme6ODKU1cdzDZsFp6UdDKDMN8HPNoCWuYMFr/itc?=
 =?us-ascii?Q?Z/4ZsOsr4Ny+MVD0qV+0CPv0iNZp8NX9jbplJGIf4O19CkjNT+0RKkCG2OD6?=
 =?us-ascii?Q?wthg4BH8qXLnEsRF/M3dYBLRBNVfF6Lrbi+7BIlV1KCXXDW00wLqfUwemE+B?=
 =?us-ascii?Q?/BgzQRqTgrbwqxYFpSIATVYHLmiOkn89MSRzLbMBvVcj/YPnxNUFARUts5WL?=
 =?us-ascii?Q?cYyUJqjVubyY84104Z8I3rbyvMMjBmfrVZ+nWyohx8PVJImyk95MERHawwgO?=
 =?us-ascii?Q?l6DTIfmQz8WX1b8s4Z3SJJJwY/7ofT9LUKoef/r6zxV/tmW5ou2yTYeTh15I?=
 =?us-ascii?Q?zSwc9k+aVRsmx0GYFe3zwOVWrv8zK7NHLfI5WSkB5d5/M77+EXgfje+T/c/J?=
 =?us-ascii?Q?3MxpRD/feckIlPtrNjN/7IRumFHc47B9Etcv34AtKQFC6s2AWsWrs+OP5Ll3?=
 =?us-ascii?Q?6rHcL44fzNxsEyaJLKrwd2985aEhpRdYpuImoHtxZWOxEtJRZiJX/TiCFgXz?=
 =?us-ascii?Q?5hSlUcXtmoSR3LT2PBMwIouSTRL7EJbxHtEhgRz+q4ovO2xi8nl1oIGSb6ZY?=
 =?us-ascii?Q?wp2TB2cnxeqYDwaE/2+b1KDWKZgOGKjBIVre/Fn4z/hKIQYaqLB8idhzbIOY?=
 =?us-ascii?Q?c87q1XiZEXthxFd+iUMSiIHoBNtnHUgmyLI7zGcNf2Br/mPcsnTm52o/aJoB?=
 =?us-ascii?Q?YS0Bxpkb4GNkJ5RkigVBHKzpWj2L0zCXN9ZKoTq+/q4UN58HUJ5os507panv?=
 =?us-ascii?Q?iir+WHN5UdJnz6H0eiVZJSUN6Q4ONWRsput+UorVFDG1VsiWJUbXsU2m0nd7?=
 =?us-ascii?Q?zS5tq/FW74H5LISHgzD55iEmDZE5I8RcRVul8YesZTu5whxoNAqOTqWWXTva?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9934F7B5C8526B43946FD12313EC0289@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2bb455-b67c-4663-3b44-08da89c52b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 13:48:35.1275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKA6DQ8sbfCpiR66KBLH5ecBIFqUenIKVt7sZ6/mIvXgO/cR7tikmrU+O/NiATsXHeCnsb+bEZZjbQknLtIlTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290064
X-Proofpoint-ORIG-GUID: gRjZYiQV2L5gpxQOkeZZnN8lr29GISKH
X-Proofpoint-GUID: gRjZYiQV2L5gpxQOkeZZnN8lr29GISKH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 29, 2022, at 8:48 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2022-08-28 at 14:50 -0400, Chuck Lever wrote:
>> Ensure that stream-based argument decoding can't go past the actual
>> end of the receive buffer. xdr_init_decode's calculation of the
>> value of xdr->end over-estimates the end of the buffer because the
>> Linux kernel RPC server code does not remove the size of the RPC
>> header from rqstp->rq_arg before calling the upper layer's
>> dispatcher.
>>=20
>> The server-side still uses the svc_getnl() macros to decode the
>> RPC call header. These macros reduce the length of the head iov
>> but do not update the total length of the message in the buffer
>> (buf->len).
>>=20
>> A proper fix for this would be to replace the use of svc_getnl() and
>> friends in the RPC header decoder, but that would be a large and
>> invasive change that would be difficult to backport.
>>=20
>> Fixes: 5191955d6fc6 ("SUNRPC: Prepare for xdr_stream-style decoding on t=
he server-side")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/svc.h |   17 ++++++++++++++---
>> 1 file changed, 14 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index daecb009c05b..5a830b66f059 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -544,16 +544,27 @@ static inline void svc_reserve_auth(struct svc_rqs=
t *rqstp, int space)
>> }
>>=20
>> /**
>> - * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
>> + * svcxdr_init_decode - Prepare an xdr_stream for Call decoding
>>  * @rqstp: controlling server RPC transaction context
>>  *
>> + * This function currently assumes the RPC header in rq_arg has
>> + * already been decoded. Upon return, xdr->p points to the
>> + * location of the upper layer header.
>=20
> nit: "upper layer header" is a bit nebulous here. Maybe "points to the
> start of the RPC program header" ?

Hm. I thought "upper layer header" is the exact terminology
that means "NFS or whatever". I understand what you mean by
"RPC program header" but I've never heard that term before.

But I'm open to other suggestions for clarity.


>>  */
>> static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
>> {
>> 	struct xdr_stream *xdr =3D &rqstp->rq_arg_stream;
>> -	struct kvec *argv =3D rqstp->rq_arg.head;
>> +	struct xdr_buf *buf =3D &rqstp->rq_arg;
>> +	struct kvec *argv =3D buf->head;
>>=20
>> -	xdr_init_decode(xdr, &rqstp->rq_arg, argv->iov_base, NULL);
>> +	/*
>> +	 * svc_getnl() and friends do not keep the xdr_buf's ::len
>> +	 * field up to date. Refresh that field before initializing
>> +	 * the argument decoding stream.
>> +	 */
>> +	buf->len =3D buf->head->iov_len + buf->page_len + buf->tail->iov_len;
>> +
>> +	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
>> 	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
>> }
>>=20
>>=20
>>=20
>=20
> Patch looks fine. I do wish this code were less confusing with length
> handing though I'm not sure how to approach cleaning that up.

The plan is to move the call to svcxdr_init_decode() into
svc_process(), eventually, so that svc_getnl() and friends
can be replaced with xdr_stream helpers which intrinsically
manage the xdr_buf message and buffer length fields.

But that means XDR-related code in server-side RPCSEC GSS has
to be converted to xdr_stream too. That's not a weekend project.


> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!


--
Chuck Lever



