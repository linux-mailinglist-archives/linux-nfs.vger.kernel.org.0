Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACC3FBA94
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 19:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhH3RFX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 13:05:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9066 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237892AbhH3RFW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 13:05:22 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UGkmjU032698;
        Mon, 30 Aug 2021 17:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=duucYRE0IgtsvqKWQoomOAIMfq/Nx7QeZgusUFXwfPk=;
 b=woJK2+W8eow3Li76h/SrRwYvqf3/NJSLZRJ4LXnLFN74trbvHPkYXaU8INgMeajOTpAl
 R0PjxzOrIcNd9qjGsqB/xviBPFfHxriN6ipIilzGqc1OFon8wmr2QZyATge5IrMwXRlL
 CafCIsxUMaYSVCYdxjxhWSk/BGKk2SUB7RpwMR8B5ExrvcadQfxSljmMBV/Szkr3/POs
 BQQjDhH7KEygLpbrjmO6yXMKr0tRt74IXRsH8uFRxryKiWWB5bRuhBMeTIe5H3ZGzFO6
 lz3Ll697b8OLN1HvgOJthS//vKR/EJsPfZuSwJmCQ44MjiVAYbzckaPoWW/dbL/U0vco Jw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=duucYRE0IgtsvqKWQoomOAIMfq/Nx7QeZgusUFXwfPk=;
 b=FBkaZOBxxR4IqPodTe7WsIwzRgHOUvKTs4hBba9EWmo8+jCkBzfsjFG4p6FgDPj8VGyH
 98h8WPyn5F+SO1ni50NOOEWF+/J151G1XYJs+bnHz2dTM4nTJlSyt2785Z7cExUFgW0z
 8LWuvT2okyAz2/uMh6v7sEnVfgjuObZ/yW5OBcyEHBmU69YZN0qRXeWCEF4u39/RRPj/
 Zone1U+dp/KcdVfjfmBk80lNRPXRejqsPXSGPeN1YxX3TTw1inbiqVd4Qi6Exhw2/rAU
 hBbEXi13biP7myb1/Bm4hI8N2HsHd08LiQRcxBnTd8cDN5wm/PKnZEiTaQrdl+DGiksr Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsj4vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 17:04:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UGu9e2174120;
        Mon, 30 Aug 2021 17:04:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3arpf2p1r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 17:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPb0Qv3Xi7j9OE+j5Xwke/1Ru+ldUvS4EhLAHBgO9mX9AdmS/s3/zX8cxRTKNkRl39WhgtZC8TygdGAJiMYdlOj9qXUtWt1CIL89NeAeINR3w4WMBo7yhR7mGePRGjmVowqQk5KMDrRG/31n1NB+hS6NLL8Z9fes5mF8EekbsdBw2wWKGgij8WPqEy1i7SB3JG5adDmaJFTM3IL7r0WOsWVd95iXbyVjMX8wc2ClbfLs5YY3fzDdT3DpXJ5rWe464naw+MAz0Wo2Jp36dHUPCnOnmUtv4kT5cnnaLa3NWJaurbAW9so8NDJFkZiRrgO7ms7dGQj5FnID0aZ/Ed0MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duucYRE0IgtsvqKWQoomOAIMfq/Nx7QeZgusUFXwfPk=;
 b=Az080Yo7N1ccYQhtb8sU77vk8ZehXEyyGBYS/jU3bn65oBvk3eEjJYmAh0Hfe7KD52v8EFPV2oJxrg8PQ4uHNgfT/hY67OA+VsRuAskPlF5m+qwHmLTmnhYFk9LEZ1xlaelRP29QqgdVIDhoekiaObuK7vdIcUYIPeYq1kB9FtVj+9+67x0Squ2uNhAeeEIWVBuhCR8l1ZQgA7BVQK3kuN9H/tHDadZx14MXK3nwIJ2u1or3id/mnvQV+571MOA6SB6cBKSEejjjmCJq1ME4Nfv4sOZaCi6LdazHX5QzySDJr+BcJU1nQF901Z/2eKUiArAXkU8ghZkS+hLnTX07fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duucYRE0IgtsvqKWQoomOAIMfq/Nx7QeZgusUFXwfPk=;
 b=chUGLtxSsOASGMg1y6zFWezu+jCUb4LWCC6Xv5ZTUz6sRCdkfZa+LpSxMeQhVueybm3k+vBA7VdnsZCsXPRe9UcsCOAtKcQV7rxTSYZVShVxDmK0LxKh8M+brXB+goW2n1xDsDq46odyF6SwVixkybf4mRWIZ7b/mUHlklz2fMk=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3462.namprd10.prod.outlook.com (2603:10b6:a03:121::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 17:04:18 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 17:04:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Topic: [RFC 1/2] xprtrdma: xdr pad optimization revisted again
Thread-Index: AQHXnb+EPQ6bfsCh/km34j6ENph6pKuMRqKA
Date:   Mon, 30 Aug 2021 17:04:18 +0000
Message-ID: <F7F9A947-B282-416F-BC65-796BF325054F@oracle.com>
References: <20210830165302.60225-1-olga.kornievskaia@gmail.com>
 <20210830165302.60225-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20210830165302.60225-2-olga.kornievskaia@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290e6e86-a555-4eb7-fac8-08d96bd83463
x-ms-traffictypediagnostic: BYAPR10MB3462:
x-microsoft-antispam-prvs: <BYAPR10MB34621A9E79D041A2E6751FE393CB9@BYAPR10MB3462.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPrs9m8qqrSxKrzPSoVjqduSr9s3v1A3mjZUXfsz2xgKyG7cPCH7Ny9XQXJuaiel9LwZHnRUW6NhiBAvERyrKkBLhZ94aGDOKDsvXx78IWaaklt1NAEQKjtPAMR9PVhzJnfGDcAFpgDxlr88wVq7huO/4V8uImTqgM6psi5b13jOaOkFku9TU8t63S6EAkJYAgqCpKR7a6LV4/wIpsprnNEzW78FNRTJNRKW341nHZVTxwJ4VtWPaDRY9opus4xrsQGxmiE6xslEHpNFx8cfmvrx7iS7Q//qjXD7i4MyOzo10Bsglgop01KSWtvRDVyCGau0vFiT5JRwkWz1XL0hcglFlvXW12IIUttU4yjIMvzBnT9o+rgH+f+ZIIx7sd7MZBR/GIpOcomkFOu0OttPLMG7Q3pKteeQOd/WfBv+vLGE9EsNOye37jj49TXuzMF6rx9HtL9PJa7cuKr2K8yf0WJIMZQK2nspg1JDhnHHRcMGqU3mQ/0apJXkbSBAyMfRhCnRdXAkUHlapKGpZgmnxE+NX6X+WAMNCVpphg4Ckhj30OtKQUHxw+d/iDG6GGU26ncgPH2Zuq2uXBfv2lZC4byrpgDNlVqw7p8kGldKQrrpBIaDT/kIMfN+SDOa8zGb12LpJB+MdOtAu+w4VTsk6KiAx7Jb47HAELDziqTVO5ofi6OD4k06iTETCuys4+UnD7KamaAbyfsBVwkfNm6cvDMt9yRd/LGif7ZJiXHOzss0D6cYTpituPJcHUmJ7N7a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(8676002)(316002)(71200400001)(8936002)(36756003)(186003)(6916009)(66946007)(83380400001)(6486002)(26005)(66476007)(64756008)(66556008)(66446008)(33656002)(38100700002)(4326008)(54906003)(91956017)(6506007)(2616005)(76116006)(5660300002)(2906002)(53546011)(38070700005)(122000001)(478600001)(86362001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KuXrioKRZsbvckwRG7YROQnlom0gvr410E1E9TF6Il6fvu3z0Q72FYS5aile?=
 =?us-ascii?Q?WilD67z0FESsURzqNFk9ucFilqGr8fRnjj3VF8jXlJj3czq2hnQc/f0YrjTp?=
 =?us-ascii?Q?7HsVudnxcqzPTvn8qwBKMEtlqcmqeosMflGtsLAwg6VQVpcjpsZ+hQVUFCOW?=
 =?us-ascii?Q?+gxC5vVyWtagcsqdwPimSsKhYzySYJE2ErUKhvyXEBnqpExENL3rUou4qlCv?=
 =?us-ascii?Q?AsQJMyMDMIlqWrE7C90PWPhGyoVKxAzacm9yLVGi+YWyhjRuaD+9dWge0eAc?=
 =?us-ascii?Q?cEoBJlHttXJ/O34/PsIBA0/48AvUupc1iEsF0yOHSYjwsPsg/KWy8d6KWwS9?=
 =?us-ascii?Q?Hz1hfrlrAmMHKMrr/P3MW92cehBbXaluDYcM3JaH1qrj7BlCFy8uKHo0oSeh?=
 =?us-ascii?Q?UzAiEpnEdQiHfqLweFg4MrxvM2sT4Y78RitlXp9BJTmASNBHcLiBsx1TFGKX?=
 =?us-ascii?Q?WyQqzf99Ya8WPtlM5SMeYFdvFbcdjDSf+rLe2LyKnvdybpTuAxgL5V0NlmgD?=
 =?us-ascii?Q?J4/qGmNhbdZ1IEk8AKYlznkAAElUSBpAi3RiiQJa1Xxktmu/WjGZJgPNaJRR?=
 =?us-ascii?Q?3lOKHnFTWKvM1HrlJZ9pcad9+Oi9q+TJxYwfxZ4Fis1Gmh3ZVcM1YzSWOVXC?=
 =?us-ascii?Q?s9qZPk4HspoRgvChvo23U0tvFRH0xjd5hm390AiCNS1NYY7ieeo5amQxhkLN?=
 =?us-ascii?Q?MrTHp4OC+e8TX8Tcc+YeLpxryW8Bxl2bkVV+0Rl5Az68XbnmNFcsj8conqte?=
 =?us-ascii?Q?5nYrgEVRgqEajlSVnR7tBYCH7NtpgdHomOEvWfK5NCLHGtSvB/d5URJR+dn4?=
 =?us-ascii?Q?42mQtJ1LY2D3MpFMS3HnRPhsc4BwA0T7DLZwmzJs1WjtbCCwOIgffwVPaX+5?=
 =?us-ascii?Q?oDp8X2UIq6Q5hYszamkOIu+AaxYWqLINx0nIQp/xlm0Lk6PXCKBbnhXAHDb4?=
 =?us-ascii?Q?0bxnXq1090rByGBraXMbIprLEsSu8QZhPXOFioMESbDC1pm3X/0o8qE5AVCR?=
 =?us-ascii?Q?qsgGpTS4R8oNM84JJRGMquL5VKi+LU6iQyEKYk2YNGsKI+o1fl2vYPwEwLQr?=
 =?us-ascii?Q?lyV4T79FDsJClXG9y3ECOwM8MkSRlDaasF76oenGDtLVGpAk9tj1aUJki4+b?=
 =?us-ascii?Q?++2vdcLrtuY9dg54J+EYH2EP/dwNTpj1bsDZUKdEqBQnAs0T29jo8qO8UU0C?=
 =?us-ascii?Q?odvWfiUMNtRxxNzVL8HXhPB9z4gj5YS6CtbkUEVnBLoJwZAXNv9ZgKmAkMJe?=
 =?us-ascii?Q?SMNRgAGKVWuW1oeD3Oh4bq3nIoE0ahuVGt5TSXqkrItjFXctJ3CKi5Vp+uBP?=
 =?us-ascii?Q?3Jk6uriUplgKtmHNypij4rNv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D0BEA26C05AE34B9D6F3968105BA062@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290e6e86-a555-4eb7-fac8-08d96bd83463
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 17:04:18.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcHGjoedG4x24yjVIs7evpC9p8EK15cersexCArAF4IyMbYXiilXIjsxBQRV5do+fWikcpjnuRmQnRnKo8ApjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3462
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300116
X-Proofpoint-GUID: mgo3B-uJ82NCv3JFRRvmeMzvsCn8NeHk
X-Proofpoint-ORIG-GUID: mgo3B-uJ82NCv3JFRRvmeMzvsCn8NeHk
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga-

> On Aug 30, 2021, at 12:53 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> Given the patch "Always provide aligned buffers to the RPC read layers",
> RPC over RDMA doesn't need to look at the tail page and add that space
> to the write chunk.
>=20
> For the RFC 8166 compliant server, it must not write an XDR padding
> into the write chunk (even if space was provided). Historically
> (before RFC 8166) Solaris RDMA server has been requiring the client
> to provide space for the XDR padding and thus this client code has
> existed.

I don't understand this change.

So, the upper layer doesn't provide XDR padding any more. That doesn't
mean Solaris servers still aren't going to want to write into it. The
client still has to provide this padding from somewhere.

This suggests that "Always provide aligned buffers to the RPC read
layers" breaks our interop with Solaris servers. Does it?


> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
> net/sunrpc/xprtrdma/rpc_rdma.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdm=
a.c
> index c335c1361564..2c4146bcf2a8 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -255,21 +255,6 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, st=
ruct xdr_buf *xdrbuf,
> 		page_base =3D 0;
> 	}
>=20
> -	if (type =3D=3D rpcrdma_readch)
> -		goto out;
> -
> -	/* When encoding a Write chunk, some servers need to see an
> -	 * extra segment for non-XDR-aligned Write chunks. The upper
> -	 * layer provides space in the tail iovec that may be used
> -	 * for this purpose.
> -	 */
> -	if (type =3D=3D rpcrdma_writech && r_xprt->rx_ep->re_implicit_roundup)
> -		goto out;
> -
> -	if (xdrbuf->tail[0].iov_len)

Instead of checking for a tail, we could check

	if (xdr_pad_size(xdrbuf->page_len))

and provide some tail space in that case.

> -		rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);
> -
> -out:
> 	if (unlikely(n > RPCRDMA_MAX_SEGS))
> 		return -EIO;
> 	return n;
> --=20
> 2.27.0
>=20

--
Chuck Lever



