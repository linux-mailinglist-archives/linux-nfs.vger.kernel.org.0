Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E41344D1A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCVRR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 13:17:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36166 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhCVRRl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 13:17:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHE9Ge109116;
        Mon, 22 Mar 2021 17:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XSw7qx7EJB+ds//TyOm9hvMG+oyV2FhseeXOcpjWNmM=;
 b=vyzqJ6XXnnJQBVs43fgGw380pmo2hMYt4mZNXTmWs0mauBsn7iBy9omjwgq3tQuv9/w1
 PmNeKdWy4Hwzy07pttWr0wx2l/2lzJTXCY9jrBfGFBlLLVKdKcaNh9kCNqFi8tREUdbE
 Hqx4jlKgOaJNsFpLk6ld0htnxTcyUqMeVpHYRSVo8cAVyihjzGdaJ9TROF9WgVCXZjao
 liGTGHuPNBojhEy2Xv7weBlG5dHEaSb2hb5+kcZpxbl1wPe4VwevaMvQQ+ohvIcBeJpU
 iObkgZ3hh94+CLAk6Y3wnnM1OWD/7Uu0XRXNK49oazloknrSFOEq/oPUqYsngY9JPM7w kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbcbvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:17:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MHEcdw055524;
        Mon, 22 Mar 2021 17:17:37 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by userp3030.oracle.com with ESMTP id 37dtywbxr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 17:17:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8IaUE1hEcVKmTvwHaG/oFJkMBWytFhSS8gBcDwmj6mY3i/1iM0GgNGngLp+HLIqYCGHwzk3eVFKgq1mMBsAy+3ivnjaxij+5ePJKvKGReZhPCOfbCfB2xe4gJQikzLTET9oCcr7wRkdASQeRhmJxKu7NO55lJujmOAkUf4sjJw38xgDn1pfNhfrNiHszww8ZmRn+xDvLe4y6SEKXhXaUDPSOvX0DqEanhquc8ep3ssHIUqb0/FLKGCyWu/tCQkcGpw6YoG2JwirHv+piJERFAXEI/HXNgDYGAAhC+9iwGcK+6zebY/YdvDgAFlTpWdgfqkcBJAZutXyQCKl/4sbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSw7qx7EJB+ds//TyOm9hvMG+oyV2FhseeXOcpjWNmM=;
 b=H7SrR0O2aBFUmpc5AA8Ory29Gfg8gqXp4VYXpN4GpJEC+9fs3lYCEVt8dR6jtjYyC3Qdr81MyeedGsGL5ucnP3NKVuP9uYLk/iIZW/U+wLRNBPfiKg0dLj5G3PIPz3OJRzbWk0Ortef7hJvyGa1N/SGNQZ/2wlrNzYwfd3BH3tfW2J6nAY/uQ7Q2UxX0zjcfSKo9RkXlRNwU0dpH0c+v93Qbps4HYKha3IMXNxjT6XOh3FnirP4rAIE44fIBOBzZi2oimQI+NJomqjafDlKNmO8U29tyiiS/wBq5UzaO+b15KKLpEVJ1R92xAtDv7P7yWeDf/CeOtb/VAkrkJGRYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSw7qx7EJB+ds//TyOm9hvMG+oyV2FhseeXOcpjWNmM=;
 b=ChVJvBCybioHmkb0FPj0pgQmtIK0tVryzCiSIex5r/EklmR3OsKQsiO9TPo7+fHiAvy49Hz0FtrzPVK/Bojd6EHqscn0X/wBqURGImNoEUWbLgnetiLzGQ4k3LdmuvP+YrPjNkacbHVFun7NswxhiyLYRKBCdQ7nL379ErIlaiM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3826.namprd10.prod.outlook.com (2603:10b6:a03:1ff::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 17:17:35 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 17:17:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 4/6] svcrdma: Add a batch Receive posting mechanism
Thread-Topic: [PATCH v1 4/6] svcrdma: Add a batch Receive posting mechanism
Thread-Index: AQHXHMy5/M1iAGH6sEyybGTKPV1KDKqQRIYAgAAAXwA=
Date:   Mon, 22 Mar 2021 17:17:35 +0000
Message-ID: <756ACA71-4AFC-441C-BD5C-4D95EF713C9C@oracle.com>
References: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
 <161616429593.173092.14052996014785354959.stgit@klimt.1015granger.net>
 <20210322171614.GB24580@fieldses.org>
In-Reply-To: <20210322171614.GB24580@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8b3e642-ffc4-4957-b6dd-08d8ed5662ef
x-ms-traffictypediagnostic: BY5PR10MB3826:
x-microsoft-antispam-prvs: <BY5PR10MB382693D2C7B839411F2F69AA93659@BY5PR10MB3826.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:238;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJwDVJ4Zj+2lk2UpSntCb72JiIrk8gm9HBWKRlxzf3LqCY3trcJS8Zj/bPrVYB2VbxnabTB7jShJy9Ib4XevBBJEFZDD5MkTazA8Clp5h47ZaL36O/jFzTrGysgPWC+qYYD+/UfCvnkcawBuJs1iMRTIYyoxE+F3PKPZEbQ0EeKEAnZnpBXSDtCcE6edhKXLqtrEgLTyAi2hoh1VbOmS1kVaBTNoAjJAa3W1N6CeUdQ54OUWjdRcALeGvqG9KYSkCCq08kMnOlYknRGj6C9cqKqZSZu6XoFvyi8hH0sHYm4hlTg/9WkujbyompGiN1J4Exl1GmtLkVFYUNiS7260txXwMUD+Y2P2S/qIdI0P0Q55c8QIwjHRsecC9fg12UdDF7ymu/MoWcEIHE8GR5XlUNXa5Br+k40yuqLT+747sRRSluw7AU8BQbm376GOlBlH7qO0VOpvQSFccM9JULUCAZwsNJ1V/szKUst+P+Jn/oYywukyfP+3mzYHY93q1QcV3uTYWlb8OFc7u93MVPj6SXU1aYkN/uva+45M5vPDMyw3xbz2BgaGT6bkxYXx2/Fi5gjpM9GSnfuJUH2hawPy+o7fnM0Gq2eFVI3uw+2fUCCW3JRbEVfFGPkrDI61wjO8z+ikX+TjllMftK6f0NyUAvsekXwDIQ13mCqZCDtY0qtZUL68KFxkXl1B0gzmSWIk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(6512007)(2616005)(38100700001)(33656002)(71200400001)(6486002)(8676002)(4326008)(2906002)(86362001)(36756003)(316002)(54906003)(6916009)(66446008)(8936002)(64756008)(26005)(478600001)(91956017)(5660300002)(66946007)(76116006)(66556008)(6506007)(66476007)(83380400001)(186003)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8kwXWiajPds7peWVJ1y/DpJ3dVEzkZIlCxJRikNCkwydgqk0qSQ+vpxMApV/?=
 =?us-ascii?Q?t3mggLT1KkVH+BMLl5PxO8p2QN9ragBM3tB7uOBunorR/vabv+SdVLIzv90w?=
 =?us-ascii?Q?IVM8lIKNSOO1NM2rInG5xII5Kb6qhRCy59XXgKoJgTWe1UULCPmxIngfHDlQ?=
 =?us-ascii?Q?5OQOeteaztAMtsYMqYhMokGm3Y9Py8Z5QUE7FsdoQ9I/iYUAzetnMDoY4dQ/?=
 =?us-ascii?Q?EBH/xocv4Rc7r/KcLaaoux9xt7aBgZQfgsGdLx12huR76o29PjBseSw+nZNO?=
 =?us-ascii?Q?XYoO4bWC7G9rTYgVY9n0VbKekir7JJkrVPwaz4R9mEKE5QmqK6Ur9HEh9l/H?=
 =?us-ascii?Q?AbjHshoT+0yeGtiQSXDVJIdZMmReNZK6Bl2AQipUwIzgG2rW7TcZpa2f7gJC?=
 =?us-ascii?Q?VY5A6hUTuQmhs0A5K8kN4eCeV+cAfYvNxDyerP0XhzJnpQxolcz67PYK4+FD?=
 =?us-ascii?Q?ht2icDTydxrDVOJh/3xZq5QukZROncFvpSLQtZ7rvexW5Tcq/c2c1S7zRgX/?=
 =?us-ascii?Q?4K2OsS+EWd0ZgDEy5wwcG9CnmsrL8MUBIjjkBTnbY6HgHgesYb9yFrMr/sWa?=
 =?us-ascii?Q?hvClCktAttZq4RZL2iiuTD4Ji75e6asWvThJivMmFYjEWo2vjwgazbPw5t9B?=
 =?us-ascii?Q?lAsujRJOTG4QVtx27GhaUw4SA810zL/ZiCnSbJNcpGC4s0kMssQMobqOnzX9?=
 =?us-ascii?Q?puHVkSZOD1eArASfH92dCmdUervWfmEG1fT9jBVMv7VuICWn9b47EsAa2Hh0?=
 =?us-ascii?Q?a0xb8OAyg3ANUk2jkF6m8v6I52ojfsw5b7j0fqCSNkRN/AV0jm+cteTLQBJ9?=
 =?us-ascii?Q?7w74IIz2MDpY7gSYokCSgk8nGNiX6viWsNS/9RvwITqbId4lRJj/vR13Pp1t?=
 =?us-ascii?Q?CNjGix4G5+zK9AZeBtxwty80KRsv84B0VvvOZp8LpKSDaKDnDwN2K9hCvrDb?=
 =?us-ascii?Q?oeK/uC76zeUW2SVXtNXC0Is9anQeNNOB20UpU3Tj/WUII3Dt0Iv3yTMyOo6o?=
 =?us-ascii?Q?TxbI7PE1eJmbQ28e3/1Q10FPKq6+ICxJWDaPia2zgHKr+GuhNh+Q5aCK1Qy+?=
 =?us-ascii?Q?yPOneijJNXp1GlnBfKFUPj1sXNHmJlz9vAwzX/2rypMZzM+CByuyG1umAEpX?=
 =?us-ascii?Q?LWxuh6ookXh03ZHHxqEPXjZMMKG9gTdCXvYuTWqUujuJqMM7AYQvl8GrTeFh?=
 =?us-ascii?Q?q+2twGnZQ2O43ef2MPS2Y4lmOKWOjF2LmVmHI72V5fVQxLVigFgweulVNr1V?=
 =?us-ascii?Q?GKGuTEgS6wXFTKhM5UJNcJ+Kiz87EweczqZorBeHw2xsVUK6OPMVG1z35V2Q?=
 =?us-ascii?Q?Khxs6SkBEpTZTljCiZJi3i4r?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FFE3899AF91A04C9F3A6F802B7AC939@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b3e642-ffc4-4957-b6dd-08d8ed5662ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 17:17:35.4577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaLQ28DZGPpHcr05Up/HlN9F5NdYHlkBafK25xykuUasQlVXaEF7Pe6JaF/SQGMRMH1gextyALibsyMxNVTb5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3826
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220124
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 22, 2021, at 1:16 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Fri, Mar 19, 2021 at 10:31:35AM -0400, Chuck Lever wrote:
>> Introduce a server-side mechanism similar to commit e340c2d6ef2a
>> ("xprtrdma: Reduce the doorbell rate (Receive)") to post Receive
>> WRs in batch. It's first consumer is svc_rdma_post_recvs().
>=20
> s/It's/Its'/.

D'oh!


> Patches look OK to me.--b.

Thanks for the review!


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   56 +++++++++++++++++++++++--=
------
>> 1 file changed, 42 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrd=
ma/svc_rdma_recvfrom.c
>> index 04148a656b2a..0c6aa8693f20 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -264,6 +264,47 @@ void svc_rdma_release_rqst(struct svc_rqst *rqstp)
>> 		svc_rdma_recv_ctxt_put(rdma, ctxt);
>> }
>>=20
>> +static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
>> +				   unsigned int wanted, bool temp)
>> +{
>> +	const struct ib_recv_wr *bad_wr =3D NULL;
>> +	struct svc_rdma_recv_ctxt *ctxt;
>> +	struct ib_recv_wr *recv_chain;
>> +	int ret;
>> +
>> +	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
>> +		return false;
>> +
>> +	recv_chain =3D NULL;
>> +	while (wanted--) {
>> +		ctxt =3D svc_rdma_recv_ctxt_get(rdma);
>> +		if (!ctxt)
>> +			break;
>> +
>> +		trace_svcrdma_post_recv(ctxt);
>> +		ctxt->rc_temp =3D temp;
>> +		ctxt->rc_recv_wr.next =3D recv_chain;
>> +		recv_chain =3D &ctxt->rc_recv_wr;
>> +	}
>> +	if (!recv_chain)
>> +		return false;
>> +
>> +	ret =3D ib_post_recv(rdma->sc_qp, recv_chain, &bad_wr);
>> +	if (ret)
>> +		goto err_free;
>> +	return true;
>> +
>> +err_free:
>> +	trace_svcrdma_rq_post_err(rdma, ret);
>> +	while (bad_wr) {
>> +		ctxt =3D container_of(bad_wr, struct svc_rdma_recv_ctxt,
>> +				    rc_recv_wr);
>> +		bad_wr =3D bad_wr->next;
>> +		svc_rdma_recv_ctxt_put(rdma, ctxt);
>> +	}
>> +	return false;
>> +}
>> +
>> static int __svc_rdma_post_recv(struct svcxprt_rdma *rdma,
>> 				struct svc_rdma_recv_ctxt *ctxt)
>> {
>> @@ -301,20 +342,7 @@ static int svc_rdma_post_recv(struct svcxprt_rdma *=
rdma)
>>  */
>> bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
>> {
>> -	struct svc_rdma_recv_ctxt *ctxt;
>> -	unsigned int i;
>> -	int ret;
>> -
>> -	for (i =3D 0; i < rdma->sc_max_requests; i++) {
>> -		ctxt =3D svc_rdma_recv_ctxt_get(rdma);
>> -		if (!ctxt)
>> -			return false;
>> -		ctxt->rc_temp =3D true;
>> -		ret =3D __svc_rdma_post_recv(rdma, ctxt);
>> -		if (ret)
>> -			return false;
>> -	}
>> -	return true;
>> +	return svc_rdma_refresh_recvs(rdma, rdma->sc_max_requests, true);
>> }
>>=20
>> /**
>>=20

--
Chuck Lever



