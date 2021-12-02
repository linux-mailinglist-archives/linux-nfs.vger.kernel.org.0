Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79FB46684D
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Dec 2021 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhLBQcw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Dec 2021 11:32:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49626 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242046AbhLBQcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Dec 2021 11:32:50 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2GP00L015782;
        Thu, 2 Dec 2021 16:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Asa5vGLrOb3FpDeM/A+Zh+oQJ2Cx8J7kZ0ImlKMqRI0=;
 b=y7qTvCXVrnKpDNGH95LzrCqTczXHD0n3p5OFoq0GwtUQZJqz5dZY+FLGy4ent6R7Koiy
 WJKXx0OHuMc78PtfANHsKmKzl2E7pTmNGPxfkZBgpasj39Xcx30FUXfuFi9wagKU8B0U
 TqLxAAqfFiy5JMssWTZQrbTALgMYh+B3ksXGAXgvgmYIHwJhj50GLnf9g/V/TSHUfJbC
 5l486a5L7TRbVOZWoO3MonDsN+bEybfVO+QkgzB8uR79agSA+GY4dRbYpXb143IXmNcA
 VZwKQ7EjURoinKrOum3kMC6E0cdxWeLJQq51cl7jOlXSi4Dku1FWGtB9r3Hd/QlofTIt vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1rtv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 16:29:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B2G1arQ008148;
        Thu, 2 Dec 2021 16:29:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3030.oracle.com with ESMTP id 3ckaqjsnf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 16:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQH4T2M4Q0IXKJKAAqPbtI8Wmpv14NCAtL5sIiiHENLf8QbrbOFhC6tlaEjz7WOGXor77IfYRhuFiDbK31OKh6kZtnTfhTkCtyPnDEnqhDUyHpE4/VQpYpjyJYlHOwGHX+kPbDIu6NgspWK6Wr4VrSL4Kjojr+Q8JrM3JZSzc0PqiZ9hjJjcH2z34OQErAbRvWvYjny6LpcbIL2sRU5YwJHgnfKyU0RbTsBlP62I8a0QctXfU5ZHyVxUGtmH1SC/5GKgAaOwRKYVMKiGn4tVElFmUms60yy4b6vucW8YEULAO7FTUQwUStCCJlpEEv2Qd0t0uw9NOuNG8UjnHWt4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Asa5vGLrOb3FpDeM/A+Zh+oQJ2Cx8J7kZ0ImlKMqRI0=;
 b=eXA6w+wFJ6Bb0SBNiCu/RY0tAiC8Mhjcxlz2BkRY/oTeDSpYL/DxLmLNt3TlgBzdxOLF4xgCmAmAIvGCvLJQUD46kJONQOp5fWPvny6901GNlf3pYGsHl963fDwifY9IBJYlaEApsIY8iA1LQj1smBUKXh1VuAJFmo/CQNNp/KTY9+gK1L5Ci8fCz4LkTsAO/Rsjds0C0gcnGLfVDTfdMiw8L4JMx9uHQBAeXzCuqGH+FaFWL2QqKy84e7zw+plA4JsIBNPnYjTGmIy8S92r7KC0hYxEeHWWcYqk1Jo1yW1VjzYiKHHXPc3eziJLHbOASp5WOilDOCANtUWQlJFojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asa5vGLrOb3FpDeM/A+Zh+oQJ2Cx8J7kZ0ImlKMqRI0=;
 b=JjtxB6sAitoetpHd3aruRMxZ2F+j+PpT+czRwM+XN+6vrhbaJF9XK9142ujfNCosR8j9AXJ/GPzgsbe3/yuZXsY+N5Nn5b4gEsYFepLjfbpaL2tsN6iZzGfMeTK4rvwXNbOe7OMVQu84MEP29JNveI4b/8Gw+xEFnUxpJquWvW8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3270.namprd10.prod.outlook.com (2603:10b6:a03:159::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 2 Dec
 2021 16:29:15 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%9]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 16:29:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Fix inconsistent indenting
Thread-Topic: [PATCH] NFSD: Fix inconsistent indenting
Thread-Index: AQHX51ehHYBuc7lZqUm9kIyOl/x8NqwfZM0A
Date:   Thu, 2 Dec 2021 16:29:14 +0000
Message-ID: <6609E132-FDDA-490B-B1F5-C6823EB85834@oracle.com>
References: <1638434142-44998-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1638434142-44998-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bd83116-7cdc-4965-c6a7-08d9b5b0e17b
x-ms-traffictypediagnostic: BYAPR10MB3270:
x-microsoft-antispam-prvs: <BYAPR10MB32709CDDDAEF74945137F1CC93699@BYAPR10MB3270.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXQQVxWgAHX6QfkBQ9dkxbL3YpALytV6Ar9H1xDrD5EJjLGARPyLpPXLuDReG47ZTAiTc3BuW8EhOIluaEwMnP3duTGv8N4f8F3CAL1MYK8xMMWLXFS0qftD8zOdZSxJjUlYUatILVM4oGUZ7x328scoE/7kjRMOXQtDUilKh5XV1SxcYMH1sFCOjCF/Yg88gwQ1Tw8T6eyDlp/Em0llLXz50soGmIWkECE6DXx/tIq7fQ5IvgstES/yiB/SIVgLwVZE4zbA+5dEnVPo0Y6y2lje9yj6jzTJLSYHtPXRbKrG1GN4u9dUaGnI4lnZLPVoaLbf1j5pkZNQOJaJlne5gYERDK+a45U5x7t+cRiVnYAmXyfANE1ElOQemBmlwYNBY7Dj7XJv/ApIcUTO6OiWfUblc2Pw3B9o+wSEzh0f5p6Scp8nCuA+fvV8lZn8WSy5jPTxTLBJCxNTPzcLVTGz2Qe/sw2RzQLb1A/pEZmAi8D29LW50wUfu+JoHtcl/4lRbUOjUnWyWHqjqp8DZcXcDsmIi/MdlvV0s/qY5HdjCuka01YgqJYX5PAWxjFN0z/lIQKG3qEpsy4Xuhh/0GlcmwuY3jXUf/3gzY+mAFbEYeqTc3Ek4u8IMqbR/h974LD6r7ESsoNu05yj8u2P/Q5M3YkQpo1hP0jiAgT7y2l2XdJOYyVV4bupegAId4U2SGTeC0J5xTQEcRTpYhIdd8mIMLj5lHqB5UvfaKe2P8BLPfB0MfP6sa7Oc6LSjuV25hyA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(8936002)(316002)(4326008)(36756003)(6506007)(2906002)(5660300002)(71200400001)(86362001)(53546011)(122000001)(38100700002)(91956017)(76116006)(64756008)(4744005)(66946007)(33656002)(66556008)(66446008)(26005)(54906003)(83380400001)(38070700005)(2616005)(8676002)(508600001)(66476007)(6512007)(186003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KEYXIPxA2ibVTWVtpR27ri0p84kCaTWupzSK2i2nUCQx9Uxa29ZuBlH/TdTb?=
 =?us-ascii?Q?+qzbtxBctEtH/ikejtT4isO0FuOD85ARrvckSBKBkgcVLB9q28jTu586OjM5?=
 =?us-ascii?Q?zL6PZutexI6nGlGEqaA1wQG6rYnzLQ6PlFp00ZiO6J/hrSD8JPcz4D0xzBOp?=
 =?us-ascii?Q?wgfz5ESD9IruyAxKreDb1AKqpPW7Qd5QdOdZqk6o9qQACCBKoDnJrWmwMZRe?=
 =?us-ascii?Q?trCbIJrh+hUGbpXsS9E6PPjMrXtz2UB4tWvRUIcpbnlNXesegY5+S3alNU4Y?=
 =?us-ascii?Q?gNuWfzf1J5FWsjqzwPw+HwqlELkf28RTM1rT0f+xAf4pGy3M01HulZ8ZtNeS?=
 =?us-ascii?Q?3uVm/h6P1zVYuYrh465qgIqJLm1VzwMlhZGrNJqcF4oks05+BG4/nTm38eMB?=
 =?us-ascii?Q?m0pNG+yk4Fm+o5cG8O7SPXLyyH0blTti5ICMPpR3tYiF7RlzrE3lF2LSwLpi?=
 =?us-ascii?Q?9j8x94lM0+uMzLSVIqWPbIERFs0UCBKSm4tLAcjiXpfyclhV9KrUZV2AZYqz?=
 =?us-ascii?Q?6ViQ6CT3e1G4CPSgMWPQWzYFVjM4biTbs70gp3kyv5nHJSEfSET+vl9d3yzg?=
 =?us-ascii?Q?EhX+VMaU6rTgGAoMYPVq5DFNx8Bjcdy0DGQX0OCZL3pcGdkeaZzx1DyCfrA5?=
 =?us-ascii?Q?sfPg94QqiN4YrMiDpAvJBUV03MZRWiPR2ZXFPWncN/CtvsoZwpgP91KTz4LZ?=
 =?us-ascii?Q?Lo5maqvlhfbOeIQzm4e8HzMaM/YLROXjz6950iVK5TEAErRVvPSW8GxqJ9Zc?=
 =?us-ascii?Q?qhIuExTBnpKnE9zsOP+TrzLbekrW1h4hB+1RBNVsn5PppbsUiD5wWPy9V+3f?=
 =?us-ascii?Q?T6777cgshiDjOQc5FoyR50o0XQ1Ny9azYtJuZt37l5nSJJLrSXJpkKcihhfW?=
 =?us-ascii?Q?aGNC/P9HCHq58e3D8GUVYVteEAWhXWqNHz9EFJDdpsyyaRLxS7NqelYvAG9V?=
 =?us-ascii?Q?f6OMlxy+KYG2oPstpnC13QmqSt9ZEmop/EvxKQTGaReqNPPzwcZ2OHbI+n7E?=
 =?us-ascii?Q?ZaTS3xHqlMxpb9e5LILvraggRJvXCmn+ergwacTWlMXM4aMUzetKdWPL80jg?=
 =?us-ascii?Q?zXC2dk91AnFqY8c02Td4j1oEJXENudiGk4LeBurCnoK52JuTXACwMtXqYdT/?=
 =?us-ascii?Q?12uPz9wPaDT1oXd9TcrN2XlF8qVcNBrElD9J3flYMT6+2RW06DX/nO8Dl0DS?=
 =?us-ascii?Q?XoKRBpZcKNiEuabd98hxFXgGamom/wZ+bbdCGQBfGeZdcHovtIoTDIJuYKhM?=
 =?us-ascii?Q?S61yOxeTKSP3j+JlSsL8VKw2z4YyqGalVkj5Fwq9P7Jl7SvMf/OkCamKIBo/?=
 =?us-ascii?Q?YX7M2Wamo7Kel+URH4/l1kexPeVn0Ax27cue4NQf6UU7M5IzgAECd1BoOWuz?=
 =?us-ascii?Q?ZgsjXpsw2cRoCxFNeVSu1UFsymUAEWMmuREZcs8/3Q3iP6WTics6H0zk0WIB?=
 =?us-ascii?Q?01WEpFhj0dM88x+Sr2R8GWw5+BqgC1OMieYdPvFWWuEoz77OA2U6Vjx15gzb?=
 =?us-ascii?Q?AoMgdf9+dFgC6NY0VW8aJXYumbE8z4ChlB43pCNsZ8zuvonZfHlQpY+zxpsU?=
 =?us-ascii?Q?fPGORFFyOVSnadDhawntX7c6GcB3/VLNHuki02aCGhYaAkd5vymQ8wFZZpuV?=
 =?us-ascii?Q?6xfFFJPbM12HWA45SK26fxY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F279E983ADA88488AF5242011E2FF4B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd83116-7cdc-4965-c6a7-08d9b5b0e17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 16:29:15.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwNwid0c5xHd16vzVZ0dG2jhlfCPd7HbuH3smTEF63/+wpeWwjwprwgdiIgICedtf14jqJVE0qVFa4gIgC83GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3270
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020106
X-Proofpoint-ORIG-GUID: 0oH2HqytffykMatX-nnuCHB_JFwO-bwP
X-Proofpoint-GUID: 0oH2HqytffykMatX-nnuCHB_JFwO-bwP
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 2, 2021, at 3:35 AM, Jiapeng Chong <jiapeng.chong@linux.alibaba.co=
m> wrote:
>=20
> Eliminate the follow smatch warning:
>=20
> fs/nfsd/nfs4xdr.c:4766 nfsd4_encode_read_plus_hole() warn: inconsistent
> indenting.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> fs/nfsd/nfs4xdr.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c286690..3031126 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4763,8 +4763,8 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compo=
undres *resp,
> 		return nfserr_resource;
>=20
> 	*p++ =3D htonl(NFS4_CONTENT_HOLE);
> -	 p   =3D xdr_encode_hyper(p, read->rd_offset);
> -	 p   =3D xdr_encode_hyper(p, count);
> +	p =3D xdr_encode_hyper(p, read->rd_offset);
> +	p =3D xdr_encode_hyper(p, count);
>=20
> 	*eof =3D (read->rd_offset + count) >=3D f_size;
> 	*maxcount =3D min_t(unsigned long, count, *maxcount);
> --=20
> 1.8.3.1
>=20

Thanks! I've included this patch in my for-next topic branch.

--
Chuck Lever



