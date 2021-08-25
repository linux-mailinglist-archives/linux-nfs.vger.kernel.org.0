Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35263F7CDB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Aug 2021 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhHYTwj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Aug 2021 15:52:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15578 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235554AbhHYTwj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Aug 2021 15:52:39 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17PIGLYj001298;
        Wed, 25 Aug 2021 19:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UMdqrjVbE3Z6DoXFWO9doVk8WxUup2vcpgVnQnJ21mE=;
 b=WvbLxuzUtp3RjtWcIgeFML6vZSmuTxMMWWWXQ7eJp/wCVGtDFtr0ZQKLjixpD/xhN6qQ
 LdI8FQfIPRRhXHJ+rVoBLuIq6mPbONUWDmQMrXQrJQlqJEbnGEYw0jiUcYk5j7ubaSJK
 2LrqymPcvUjf2vmq8zwlP0GtRqLNOKGlEAtmKxp9OT/Hy3hFeputgcyw49HinL3fi5yd
 V6u/baB1HVNWyP0QfPtefJcgGxrPvkA0O+LrJ0XXjw9nJqJfLtqlXU9QiFl8SfdX0Sgy
 2EZGGcWtujUtu8NljtnGGXZyAa7SoXBQVYHNxQWvhw/za2KVAbhLEjxxzhk5lux1qtaD MA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UMdqrjVbE3Z6DoXFWO9doVk8WxUup2vcpgVnQnJ21mE=;
 b=Mupi253qZFIhVaKfsPUOkIKYlxHmSdopNQ7ZOYUwG9xWclOFvDtSs5975PK0DWuxxH3J
 vGd47OTUQBs8gX1I0dS4FLt8IdiHUZFJ4HaAuuEoTbPNV+OPcxrQ0j18vsQ3ots6EgUl
 BNhbZ+IdXb9BQpQFvedzpi6mrXmDianNAdCI0vhByHLoriPmzzjpIgn+w4XY6pIiwLE/
 xhbpM7LdzCsBAbwW1NcURjS81f0/ADuAxkOvGqBc4YFCV6KTpk637MnxbNrV+k3aB7oe
 b4C6WLbyaHzpSuDZ6OwXNwx4YFBNNKbMtB6/lVZgD/BEES0FBUClDSQvKAeriWuTh/oE 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amvtvvn57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 19:51:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PJpbmX026112;
        Wed, 25 Aug 2021 19:51:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by userp3030.oracle.com with ESMTP id 3ajpm15279-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 19:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh4yrtoZi5lMYlbhEoatlAW+i7nwv4amgCQNgzQj7hxYDHK+aJwac5D8ht5w3kxXLAMEvh/4BxA5NQvaST84QW1WvdkE3kVCLMuYMT738lOz9g1ItviGfG6Uy2MSd4pz6d9baktYFgJsZ/idpDNwridolbnpeedFfwgvxOtubv5n/0A7e0jHp+juy8l4GUf0RCGMP+U3PAOsz0QE7KuXfN/Lo7TIBmeaylbc+xFwlRwhyIP695zv1a8QT5tdpMgRIpQEXiDvBignrV/onTPDQ6yWjn4JyIiygzeHX486bS/SVzWIeur7Ycug9EEpQCXGnykftoC1IC4xpD0QRCKtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMdqrjVbE3Z6DoXFWO9doVk8WxUup2vcpgVnQnJ21mE=;
 b=G7fAcC5HZOksta1RWEVoktTXrG7qEOYfs2gKvRnWnVR1XWCFLcRZEYdaCazGUDuunfYAS+zN7a62ibDV8pB7fsv0zR1jd8bo9iBpGmlmQpmChIMbz7sjzwJjaGdhqryOSbIM3f+IuULtMN39IC4JDFcA8pyhoiYLL/PT11kIAth1CJCPqgP+ySR1aXrk2kV17kst3V8/VNXZ59Z0D00HEnv7jwouU2PxqltiU8mOdvIZyMal/1yI6m+wBWAy2o6D/pvSbpJ1MBFSSKqINSZrBMJt73ihoO901wkB9npRR6lt1fanlt72oeQK+tsUKjD46KXEWNI/E5fTTCPiaHlIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMdqrjVbE3Z6DoXFWO9doVk8WxUup2vcpgVnQnJ21mE=;
 b=ltUmVYfX7dvfXAroBiMsjv+tTXM+Sdcif68z6hHPbs5ADQFzlKn49V431QoxLKpYHvS66TVGP1HolIlZyXrpC4ORW1r3/6tanYxHKKSgNr57GMiUkPI/xYyZIHPChDCl0MWdbcCHAPQxGCWPs82oc6hhRc7PsfJRX0+7/v2J8jU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4558.namprd10.prod.outlook.com (2603:10b6:a03:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 19:51:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.027; Wed, 25 Aug 2021
 19:51:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix XPT_BUSY flag leakage in svc_handle_xprt()...
Thread-Topic: [PATCH] SUNRPC: Fix XPT_BUSY flag leakage in
 svc_handle_xprt()...
Thread-Index: AQHXmegQU6r+dlXomU6Gdriqyx89rauEoXUA
Date:   Wed, 25 Aug 2021 19:51:47 +0000
Message-ID: <86716FAD-E791-4F89-BED3-9AC934A281E7@oracle.com>
References: <20210825193314.354079-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20210825193314.354079-1-trond.myklebust@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2630e649-c713-4169-ade6-08d96801c5ba
x-ms-traffictypediagnostic: SJ0PR10MB4558:
x-microsoft-antispam-prvs: <SJ0PR10MB4558291CB377BE34D943A80993C69@SJ0PR10MB4558.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vbTqkvT1PFzwlPYrrGMTlIHJTf25nRJMtsNUzHcYVsAhdIZHUtkp3f95JSx4i6q7wwkm4slhPnJr15i2+sfV4a0ZP6pAy28TW2sxz1i0Jls/Pp9rs2F36rfTN9SH09ZS8TFLMrv2ESaWI9TVT3MbVSterr70OH0ZdG+uXbl8pSLR/iKy/nNPDOna7FyMpN24X8T2UOQopJmX0cIRbC7ImZh54fjHxAzD6UvCEZ0BDAMYOuuQzJNQjZjpZVmo/wfKNAC+gMESSqr3wJPo5MrNGy9mNFT9RqO/tStIa8FSydKrUAn4IhUWpr0TbUN1VWln0NNo+YKsQbDvYJ8PDJ2nkEkC5zTAbnjobKjgfyuo0zAds7oyed5Oc3pn7Qbjhbjl8WaPX6ID4vWINjlrNC1fRuVY9z6l4l8N1tzYeU0MqalObkhSPS4BgzjnOGQtjm7nX7WyplFQ/oyE9YEd6sdfs8iiVX8wm/v+VK8uW2sGqxrljYBOOndl2FfIVI857IvgASXVY00b2IVG5W2UvwKoJjeLb7THBm+cN0qxLt+cm/Rz4TnnrajjGlJZk3slpJgKR3z/kd2qTpx5xrShXZtWdDo12122WkjCWXrYPXPpigwgq2bRO2htvxmgpct+Aynwf8+ucn1VvO73gfQJ2Fly4+J+32cNMslNG4iUilzi8Ju3g/OQMjUSllM15ibVTVy59BEy4o0/Z76l6w7VVzAoNzjF632XVx+WrvxkdqypT86BYfiPwHZeb9M9BYIxivFO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(5660300002)(4326008)(316002)(53546011)(38070700005)(2616005)(86362001)(2906002)(83380400001)(6506007)(26005)(8936002)(38100700002)(508600001)(186003)(6512007)(36756003)(71200400001)(64756008)(66446008)(66476007)(66556008)(8676002)(66946007)(91956017)(122000001)(33656002)(6486002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IUwePii/emuxy/tuKhfD+iET8EiF9EUsOLvv6lzQjeNTEJgYz6gznLmc0iU2?=
 =?us-ascii?Q?Ib60j7DPxqfmPHDAOwrfIvPEzUuDcZJY93t6HyrbyV5/Ch8vOUP4eW84Sl8G?=
 =?us-ascii?Q?PFs8oY69kknhrEVgeTxff42LOYKMHRymM5onte32IIOQAHrtW9EPBs1rx1UN?=
 =?us-ascii?Q?FwoiHW6wGx4qmh+8wz9eNvMKFzibVoMwVKux2H+wa0ceZlR9r3vfqSrxlkTr?=
 =?us-ascii?Q?Q6Cl+9UrZ2VNTDkO/EoNtkM6Q3Ju7YPaj8ON3u3yUgERjg8vLmiguCV8BMie?=
 =?us-ascii?Q?FOLjizHSlimbJ0vzp7NkIaqJq/kLIjCF2DMlC011ZCLTwl1X6BLy0QNqvFns?=
 =?us-ascii?Q?1+RxlFF6UL3OrlilZEyo9SE22HGJ7RJHCMJpqH5E7biBUdK01yk8vggy08iI?=
 =?us-ascii?Q?hkbVMLvZuHyWDrZ0HmFhrwZp1ZwOhP1rkTXhMTvABb9M7P/aqZW30989rZ5/?=
 =?us-ascii?Q?zIX9ntZsNiDkUR06pN1ruMXc0m0wPhoCk2gGp2gOzKw6kdmD6MkEmFQoWNvB?=
 =?us-ascii?Q?p741LxRoxRQOc/7RyyF1u2dHtq78gaL/7tpw5n9v5+eVbmGalQ5XOCSJM1vp?=
 =?us-ascii?Q?oc21CHA3J5WTqze4hI1yOXp1pUKHpThLFc5msKFQygBGqjqOd+MFwfxCQLwe?=
 =?us-ascii?Q?tPnP6l7DOVszQMaWQA2Mzissh1u9KhYIeMBTHIC87K+sYEuH7BkYnYEsgr2y?=
 =?us-ascii?Q?ORXr6rBVJ41hBPh+xN5UxkKwAtr72A8h2nWtEEFqsE4HV6HcrVYD8helcOzp?=
 =?us-ascii?Q?2jm58eFUsl5BPdX1oqWSgkgOlaqvuWZD3FeqH0xmplAIabmbfYXpGmry8gNk?=
 =?us-ascii?Q?nyCTTe6PUJFQxmeJTnaFVhODk6p/p5uERrh52VlaHol8xyt6iO//VVvw0raR?=
 =?us-ascii?Q?mhbL+l9MX44ZIuZh30fvnQ1cfpm3//upznWlV1bN4BYnbvEP+xY5Apv8aSsj?=
 =?us-ascii?Q?o7t9xVTDFDMPrAR7FxkpzSSmOdHqkQ2K4Bxe49oINXm3ktG4zVhav+6ATIDI?=
 =?us-ascii?Q?E7Bj2hcP1ZvH4nkXZOzK4ik+JeDmDCuFuCCxNtra9qq0M7skSd3XnlS6gHxs?=
 =?us-ascii?Q?HOXWupBackTlCgzaGAZhnvDo015W4C7XvVMZqGYOP2dynGYhwNCWjUg7WGlq?=
 =?us-ascii?Q?G+rqUCYl+BBwOo2IF39dQZfQIavKlhg3TY27Y8NtZ3lz2D+n/lSnQZS3kgio?=
 =?us-ascii?Q?3eNFR6pJeu5Aw95sV/h2QDBjV2X3GnQZAfEuNqC0RbCQxOidD1GxdIKRKEhh?=
 =?us-ascii?Q?2UH5NU8TMiz2KX35gk/K8hObMknzSLLch6mkilWKKmK5UGrATzOAa2uhE/Ic?=
 =?us-ascii?Q?cacrRucKX/91NbspgMxBu2dB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7120C8DF53B17A41BB1E2B429B2B94E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2630e649-c713-4169-ade6-08d96801c5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 19:51:47.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXBLLU6tygRlYcY4kdwSeejRbHHH8pwapgwhV9R7wD8eHfm+qL2Qr004bGpnFaFNc3kQHN7r97s0PtW6dk52cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4558
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10087 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250117
X-Proofpoint-ORIG-GUID: po2Bh1fsXNqbf8CQ8A0c8EDB1hHi7Qkp
X-Proofpoint-GUID: po2Bh1fsXNqbf8CQ8A0c8EDB1hHi7Qkp
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 25, 2021, at 3:33 PM, trondmy@gmail.com wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> If the attempt to reserve a slot fails, we currently leak the XPT_BUSY
> flag on the socket. Among other things, this make it impossible to close
> the socket.
>=20
> Fixes: 82011c80b3ec ("SUNRPC: Move svc_xprt_received() call sites")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/svc_xprt.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 5f0d33ca4bdb..b3cff4077899 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -975,7 +975,8 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, st=
ruct svc_xprt *xprt)
> 		rqstp->rq_stime =3D ktime_get();
> 		rqstp->rq_reserved =3D serv->sv_max_mesg;
> 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
> -	}
> +	} else
> +		svc_xprt_received(xprt);
> out:
> 	trace_svc_handle_xprt(xprt, len);
> 	return len;
> --=20
> 2.31.1

Looks correct. Bruce, perhaps you should pull this for 5.14-rc.
Linus says he expects to release 5.14-final this Sunday, fyi.

--
Chuck Lever



