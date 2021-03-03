Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C9F32C692
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355473AbhCDA3S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58066 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448075AbhCCPR1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 10:17:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FEr8U085461;
        Wed, 3 Mar 2021 15:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=e8MvjY2bCwvuJqe3/qez+ukQHO4tzKli5awx80Bb59M=;
 b=TX6UOeqwC8fwL5VfrDfY9rS6qbDBIXmIAM/V90mGMpH+tbY39xgZMYdoD94/IWt0o7Zw
 J28G+2w6FwjWc45d99ZWk62rdXsdrPeETbw36mXQWvpuGbGxbzoALiwR88hywKAIlsd+
 CkGl7ecpZCDb5A4hxiyLEXjTpDZe1q+sUjr51jkPPWiEICkoOHkW8K/X/k7pvZcXTLkX
 tkNOrsZ3D6lsM/rISIMQiaK5DklwRYKfrisx+fiif9JfOz/p0VDfaC2m1RzumITqnGUv
 RH4E8msnlXnvAFZMCl0d+41YP8tTfxJSQe6cF7E+eqcQrd3kfPfZy+EWV2PmhTBMt1w3 eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36yeqn3q5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:16:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FF1E0067695;
        Wed, 3 Mar 2021 15:16:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 37000yjmep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laRHPHKufsIdUpA7P+GUE6nEddhAShc/JpqZ8Vz4FYcZM06oxPSK1A6Jo/XfM3vQ4Ri8UPgZiYfdCtQ9f5gzbMt1HUFPdb6/deriiw+kp9Yj+CuWkJ0MMyYEtIphVFIBwyh9qY9CuyxfRAavnwzt4LoiGfxD6clduaEEZyne6TWs6KMWQWf8LYws7rbe8qLOxAf+8Ml98OxZWFtm8lubmRevx5BpDLYgrly/oZzr6OQ+pPjQGwkvz7L9ap5qqpwKLcUwXEl9N7UOUuCtyvNNJiSEzGeODPTWXA3PEnGqU9TGebLQRAZvwYaANdsM/VMEcucv8XSzbkE+l7pGqTojng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8MvjY2bCwvuJqe3/qez+ukQHO4tzKli5awx80Bb59M=;
 b=dlxgRf4J8gk4DtqE0Ji9lClciP+CEqud1feMkmuhEg/8ahQmgvO+C7PpYtc2emsZMNxsuw9VMZVHhppQexCFuoW3bfZMw3Ivxc9mCzr5+4LaBx5k3UdT8YTwzZ/g815Oy22Y2gmNJrrF4UZr6fbvYRvLsGPdeFLBHQbJlFAKRukrMF4g/21fx10aCmKjIifMSaX3OJwYyptlfsSNICJyIwlLNzDNLm/yKyH7zfHLRRl45jpvXRDIVl8bNRM9TgB01H4BGUlUpS2nwyWVDNf4zfYQZRqk6o3fsplt4cPr4MJdab8uzPqFtBQXd/sAcJKXZjw6JNxMiyIkVXuoAnisDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8MvjY2bCwvuJqe3/qez+ukQHO4tzKli5awx80Bb59M=;
 b=ZwVm1YC4yMK3OVhy46KpvBSDXNzHUtohGV+FAQ1o2Ozdgj7IOND3m20gkGaVvnV0FkCOF9p5TNOKWNe7TLJniBU/+6JA3jfgLIuBmEDr0ypc0/usEdO6JbkHQ+fNv3pTPnx9tQAuo8xV/V5SgREDacYuw4Sn7J7gjzsWLF2EkFA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 15:16:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 15:16:38 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Daniel Kobras <kobras@puzzle-itc.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] rpc: fix NULL dereference on kmalloc failure
Thread-Topic: [PATCH] rpc: fix NULL dereference on kmalloc failure
Thread-Index: AQHXD3uGhYxnELw7z0+r35pAs8NkU6pyYXGA
Date:   Wed, 3 Mar 2021 15:16:38 +0000
Message-ID: <598D1A69-B5BF-4F77-91EE-C9C0344530D3@oracle.com>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
 <20210301162820.GB11772@fieldses.org> <20210302154838.GB2263@fieldses.org>
In-Reply-To: <20210302154838.GB2263@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09743c99-75f6-4264-5a34-08d8de57578e
x-ms-traffictypediagnostic: SJ0PR10MB4429:
x-microsoft-antispam-prvs: <SJ0PR10MB4429AB292CB1F35FD750BD8C93989@SJ0PR10MB4429.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fFPF0FnyGnNd8cUP5Ho+K2taly5eoVAshOKhfcsEwezyj99Z5vvtfoBMXbQU4lndwtFFYuSjGgw+u66eFfpaUrN3f2iTx9M/7KQD8z01buZ9xWF70YhSnLEGr+soGFqrAfVNJqJffacVl+qpkBNxYbrv++8B3HBLnmwz5Svb5mLlAEzv1M/Z6xTHnDCoifUI/XrG3RH/Xg+LAJyONBpY7fEfe+Zh6/35AGJaLEsQIedZ+vA1TuEGyOv9TsbvNQwJiuAW3MhB0syWqwoama5xcsqIkIY1pV4G33B/etFoHmBf9pXbKS+SHp4RxXNBXhRMZaR1ESuC2ESq0mW+quqwWiwOZph+qm4K63KeXxvreBPDiJ9pjc71muT4hdg3QXC6UjtzU/szVltYTskxpwSGiprGod0p2gHZxa6u7cXD/Qkla08vVWjlqU8JGcDwFuZC5D2ePZE4uXLPNWSl7iL5Vu2YZxYPk2maybg5jQxonLMWV992NF3mEuogegO7e9wSH/h8jVWLexcz9aBoE7cZI4RWhJJUuqy4grqrZV7vkvZQxnBkuKh1u5URdEfrPaS26h5Pl7/4NiOYYgQrht10bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(316002)(86362001)(53546011)(8676002)(6916009)(6512007)(8936002)(26005)(6506007)(4326008)(36756003)(54906003)(71200400001)(76116006)(91956017)(5660300002)(64756008)(66946007)(66446008)(66476007)(66556008)(6486002)(2906002)(33656002)(186003)(2616005)(44832011)(83380400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8UalXIxnotGUsTsL5HZ5cvglwVNH/UmRiTQwgE/xx3r3DZT5irDa8Wgj5Oy9?=
 =?us-ascii?Q?OcugbZ1rQKjHTAxPjsVlPZV7tp9WAh0E7tjE14cEgGam6Oaua4iKiJQBS3V6?=
 =?us-ascii?Q?UquPNCjyN9Mv8ZX4pS06cHg0D+3gIes4PaCnSEDV3PQ0KJOq2+UEY2bwrQOY?=
 =?us-ascii?Q?PlUIkIJDc03Y5GxgV1hZNBphmVHt39qqvIfrUJWKLD0SruqmQMb/hIccXBkU?=
 =?us-ascii?Q?daKUfliFJgfCV6Jrv+Jk6sEqv+XbN3vrl2uEluKrH9nHBnZ4fdjHdgzDoQA3?=
 =?us-ascii?Q?gk01FvpjWszhK8jFKetnFO8GAONxkvtXcp19kBUQTcOwtL1ZD6zKFi+xveTr?=
 =?us-ascii?Q?qs8meA8ycIYHNmq5s44NGA5IBkJ6hYmDnZRQ/w9klOFaQWseaYNEiTWfOXLY?=
 =?us-ascii?Q?VnBix6IVMx5TTZmE3n2Ym7wdO5pnDSEAOoI6TOO3VqigU8u51O5gADq6Wdn+?=
 =?us-ascii?Q?hSSJKcGbK3wYmnTTaq0WtEYHryZr5n1cKtCvAatmtN+PPEv/5GkWskRe+5c8?=
 =?us-ascii?Q?rCKwNPbEZmqk2k7/KryhioO3QvZEemaCP9MKcV97QsEopx0OLhl5YaFha2UN?=
 =?us-ascii?Q?+utP50WPNVhFW9Ll9t1cWuocJMOBKksBD9w7j99pqf+hNeEgbnCokZb7zm0G?=
 =?us-ascii?Q?LB1iwX/av4v98a9YT0DYka4iaUJPZw1q8p4cBVfXpQl637xUBvq2dBZHSDBS?=
 =?us-ascii?Q?KPHpTANscY3c9S2FlnbICTeykWdSvMDDhAONvXCxBPN2ziBb0u93//B6DEQS?=
 =?us-ascii?Q?qs4AHfnxVtJ/LQ8clbrjcPKDalLvfKowAeKwzoAXm+BEJN3cG5ys85PaaMIr?=
 =?us-ascii?Q?MLEDxAiocuwnbbBHfPw+TR42rwm1v4Lnxt24wrQ0BwLvbjzn5WwGjMFlNM0F?=
 =?us-ascii?Q?qEQrXAdIwZ+gcfqv29lWubnbaDy3bXeXAoBXxPg0OY3h8Yq1Upw76TO9XWZv?=
 =?us-ascii?Q?P2iNqspEYzQgphpDLUQU7cJYInydZMNshD7qKbjhWCoJQbJ/cG1oeHRPqTZY?=
 =?us-ascii?Q?f/iWewOTD+4nPaqr9rg56+S3mUVSKlRQHZD6uBOvelzy9VfwCZHEV4kEVZFs?=
 =?us-ascii?Q?HtFFfRlnpLD4gNQ3BzcNZQ80fQ22YVcX9xj1nrdoqebt2vSNOpgMfU7viAkd?=
 =?us-ascii?Q?zXLNwqwYEaJx7k8rQcvOV7wZUh9hYg4IfZiLGGvkiViVnxTFuaP/pn5ZUyh3?=
 =?us-ascii?Q?gemGB2PVbUpqSDk6zT8A0ot6uZpvxr7SalUJOa6NSKvpOcHQX5e4YQNhYMoF?=
 =?us-ascii?Q?9MNciuROg4XjsGXxa0noKWnMny9d737M0Lr6VoflbEoxei4fOrnult5hJve7?=
 =?us-ascii?Q?oDTq12wbGGC4CuqC83bT+s3MXHQB/pZRdcoJtEQ/EEc1cg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3BDF1001F2A3E4BBAD409A3037EF279@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09743c99-75f6-4264-5a34-08d8de57578e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 15:16:38.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tPNGqFhH1PenzhpQh7JGbHvzX1D+kSylCDviZuHsthYQpZUrqMSYGc4WibCk9nl132hwMGncvM551zDn1nSaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=952 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Mar 2, 2021, at 10:48 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> I think this is unlikely but possible:
>=20
> svc_authenticate sets rq_authop and calls svcauth_gss_accept.  The
> kmalloc(sizeof(*svcdata), GFP_KERNEL) fails, leaving rq_auth_data NULL,
> and returning SVC_DENIED.
>=20
> This causes svc_process_common to go to err_bad_auth, and eventually
> call svc_authorise.  That calls ->release =3D=3D svcauth_gss_release, whi=
ch
> tries to dereference rq_auth_data.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Thanks, now included in the for-rc topic branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

with the addition of a Link: tag to reference the extra text below.


> ---
> net/sunrpc/auth_gss/svcauth_gss.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> On Mon, Mar 01, 2021 at 11:28:20AM -0500, Bruce Fields wrote:
>> Possibly orthogonal to this problem, but: svcauth_gss_release
>> unconditionally dereferences rqstp->rq_auth_data.  Isn't that a NULL
>> dereference if the kmalloc at the start of svcauth_gss_accept() fails?
>=20
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index bd4678db9d76..6dff64374bfe 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -1825,11 +1825,14 @@ static int
> svcauth_gss_release(struct svc_rqst *rqstp)
> {
> 	struct gss_svc_data *gsd =3D (struct gss_svc_data *)rqstp->rq_auth_data;
> -	struct rpc_gss_wire_cred *gc =3D &gsd->clcred;
> +	struct rpc_gss_wire_cred *gc;
> 	struct xdr_buf *resbuf =3D &rqstp->rq_res;
> 	int stat =3D -EINVAL;
> 	struct sunrpc_net *sn =3D net_generic(SVC_NET(rqstp), sunrpc_net_id);
>=20
> +	if (!gsd)
> +		goto out;
> +	gc =3D &gsd->clcred;
> 	if (gc->gc_proc !=3D RPC_GSS_PROC_DATA)
> 		goto out;
> 	/* Release can be called twice, but we only wrap once. */
> @@ -1870,10 +1873,10 @@ svcauth_gss_release(struct svc_rqst *rqstp)
> 	if (rqstp->rq_cred.cr_group_info)
> 		put_group_info(rqstp->rq_cred.cr_group_info);
> 	rqstp->rq_cred.cr_group_info =3D NULL;
> -	if (gsd->rsci)
> +	if (gsd && gsd->rsci) {
> 		cache_put(&gsd->rsci->h, sn->rsc_cache);
> -	gsd->rsci =3D NULL;
> -
> +		gsd->rsci =3D NULL;
> +	}
> 	return stat;
> }
>=20
> --=20
> 2.29.2
>=20

--
Chuck Lever



