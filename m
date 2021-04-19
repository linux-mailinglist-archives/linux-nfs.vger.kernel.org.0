Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1724A364B4B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbhDSUnD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 16:43:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhDSUnC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Apr 2021 16:43:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JKe7ff109413;
        Mon, 19 Apr 2021 20:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9ogwunuigslzOJUtLgPQ1g65F3D61vd0CyCZxRLpd7M=;
 b=haujMx3ALzH0hzgiXLLLMNoay9mbw+J7naMF1kB8xsQnPQdp9cAjbb/jVN09HG5fSeTM
 zSR1RWR2BYUn97/2zs1vAhsK5YeNqkjiF3QFiV3GtCYEMW6lJOIGv09oUjB7c7gQK4HI
 rqVKe2BSh3BvsgsavPqEc/57eKIP6/jFKVGii7srKMrHfWiI/PpHgZAFfqBC5GUgs6dz
 nmq4RWLK7mUGbTimWxdo4kE7wE8AHh3JKUAnqaHsQmB5GehBm/4e1Uww45wBO4oU1EJs
 4QFd11TCR9MTQ08c/f9fT0eC+T4JVgnqBqWqV9i30HFldj384sZbUjUfmP6BXOeMYfCj Aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37yveacr86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 20:42:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JKdqrb190684;
        Mon, 19 Apr 2021 20:42:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 3809erk2e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 20:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYnzrjLm3uPlVm0CV9DR+RNNEYl9ApOegLPwAsytZGaCk+sPKa2o8GDfVobKfsuKtQKafvRnCDK1xR2m/mcfJg7zxJhsK9ma2LFw31YYKKvADBRpZ+Sx54cCCJEH+tmO1x2qnkGQhDxNsRsJpBslGm7CZ4LIhyIvbTvOhSr+MHFxPSHb6yuElqKkCMVuiuXf6rmvRLqBOJO7QpWYAKJGFqQ31b30zNwb4MWcpq8zRxxWRph2nn+gjRg/whscyTqXFn2UJ/dX9KykN4wdZf+J+DVxT9S/60g7iWxv2cpn+lxz0PEGnfpLZ0/E3ZCGEZ5G6yPRMrgtqmmEfSYYWThpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ogwunuigslzOJUtLgPQ1g65F3D61vd0CyCZxRLpd7M=;
 b=S0piIbM16FAaw3W5kqd+jyCPLhP5rqFVZKyfdI6FcdncCcT460uDV4ZrFXFoEc/kNvp7qzpEQr9zLFB7/v6R/xD914KFX5mSPRBuDmAAFtouXj29VpZkwNSoxiEQcLxbuqPeFEm2GLD3+kqnhz+p0rI6tq8PLabZzRX0FkuqgWcP0pmOtPc3Ikb3GxSg1dyMdhbU1+KEIx8GA+sHPS6eOD3T9kL9VDR6iTfvv86xqbOkuCUu4w12aw4S6w7DXW8n2Iw0z4DXCXuFBypwQpujdYq4v0QHYA141p0SEU3eN90ARS/fr7XSEg+kbGsdryKiw8dzPhBxZjcwcs+6xL24Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ogwunuigslzOJUtLgPQ1g65F3D61vd0CyCZxRLpd7M=;
 b=o1SV5yzedpNxoNfqN9gKEOFoocbDFxSRoN0fLEH3Q89nJHIfECQO8xGWjBDPOm6JWgsyoeFPukJCjnBq/nuW1D/QyOSv7oRBQt9URtfaardu+xAi8uTp/iLZg2FGnSZgUZ5DTTO/LlA0/oDmMHDpYDT98UCHZHKZEoXiYZmsHCA=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 20:42:22 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 20:42:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] nfsd: hash nfs4_files by inode number
Thread-Topic: [PATCH 2/5] nfsd: hash nfs4_files by inode number
Thread-Index: AQHXMupixIvrGePep02kzvU78UvPJ6q3hYIAgAS/7oCAAA24gA==
Date:   Mon, 19 Apr 2021 20:42:21 +0000
Message-ID: <0788B2C4-B2A5-4430-AE63-0E9DA82A7118@oracle.com>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
 <1618596018-9899-2-git-send-email-bfields@redhat.com>
 <7342A4CD-0B93-4C13-AD32-4DADC26CD8ED@oracle.com>
 <20210419195315.GA17661@fieldses.org>
In-Reply-To: <20210419195315.GA17661@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214fd875-f005-40c2-7d87-08d90373a1c3
x-ms-traffictypediagnostic: SJ0PR10MB4494:
x-microsoft-antispam-prvs: <SJ0PR10MB449475C0A25596BD4B0476EF93499@SJ0PR10MB4494.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjFDjttln/tCsRcpyV8uDhQRIwosQ3Tlm0dwh+mYclh4h4EzEjyV2B+xHMfty2BPPJsdQhNmPkhziwDY6lE+NFSMB63gMZ7bKF+iUqkg1HjkqA3QrL9RJUTrpJQnFwYvhH1rLSoIDfScSeOT2GAy1YXrN70/X5zJJR4u4vh6WAsPCP3xvVRPdlI4Vnzlxqndfx7IkDkyWRibP1BiU77Y8Y+VJXLqLKbzED94HlVbhRCbOWN2OFKJrJoIe2MvKBF3E1M/qYgcHI0AgCCVEbjqTu6R1LueTezdSpfZy0Jsgm18aNs6dXDjI942S3Xpb++LKfHysl0WNEJnUxYx3O4Dy2evEtc7GDF1Jl6srWX4lNdfIxee87Q7dG7Ca3+9dHGGY1F1fMjR3V+a9IJwbyKHFJ2GHKKBI9BIROQfBpnd+9seSrpM7BQ2820tga3oG8DVf8yiqKh3sYj6fWT35MTfi7+bHuLO9hB9csrQnW7A39bGvBMvJVdyLSayKXyE6lyt5KG06R7hFYWSPKxak8nWZtccHAc54QtafisSWs0RRFNb0/2Ic9WG8rqXTe56K3Y6NctSseJyCs4f6C2l/9EiWKKA3IAFbGyrl6oHISEAO//Eps7wVim7wxFV0dVYHC3Joo2ZmZXtT0U2Eu5bkN6PpvIXKvaX/sTWGAMgOJxfR51c+qRSwJxB1vIQ5YQoumer
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39860400002)(64756008)(66476007)(54906003)(66946007)(66556008)(83380400001)(38100700002)(6486002)(186003)(36756003)(91956017)(122000001)(6512007)(2616005)(33656002)(316002)(66446008)(76116006)(2906002)(8676002)(8936002)(4326008)(6916009)(71200400001)(6506007)(26005)(53546011)(478600001)(86362001)(5660300002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KtKXMSqT3wkIbCf3HaIvXczSyPZF12DtojTauYw0oI0tCarzd0tyTJCFaCuU?=
 =?us-ascii?Q?2YEOvGir5lTBY1/CGcfjQnkVVkw/WOQCcAw0ZdhjDBPy+IAereTaSKrr0xwu?=
 =?us-ascii?Q?5y8M5bDBHJgQUJNGVp9TSOOfKcl6da4EQ2tiaCxEnDqn2kX9jrsjeCE59scE?=
 =?us-ascii?Q?NaO7FDG7PI+13zE/q+VluVdQoEJJ/8pJ1TeMTlcrUmjgvCjabMYpknq2yief?=
 =?us-ascii?Q?IRdpNFhAJ0drYS/HU6J+1mAkufl8M8bS+AIffQ77MQ5YYuzr6EY0CC9u9vdI?=
 =?us-ascii?Q?2uJN4fsebON+s7wl91JO+aO+pAtR2U4XeA3fm+ucyvf1NqxnaZi+7xAZ/kee?=
 =?us-ascii?Q?a7V43qp6CD3etI+Sdw/k780Shw/aeFUxjnXcaqoNI0N93Mih4ie6Y2n9z6d0?=
 =?us-ascii?Q?CiSHQxMTiNCBdOq/BH/B45rshujEH50DQy8ajDQsdglOwwm12CFk/6d5Lt93?=
 =?us-ascii?Q?m18mwCNvptWnQx9A9f6LW5ORM1rTwWTybFdjlWLwMDUNKh3l2jWX8Vc/45Wc?=
 =?us-ascii?Q?Cdjowtj8mVBJo7Xb+bsHNC7+qugOMBS6LuIaCdkU65BASX9tTpMqLAcWDuiP?=
 =?us-ascii?Q?zmqTQShFKPzixOVpnRuWwAaRbsQCbDbrdZNdYi0+MGc4NxgZQY7wrqqumvYd?=
 =?us-ascii?Q?UGBknh0MNMAklhk+W4isSKjbuaaZiT8fLiikY9PM6sOcHvK6yyJIgkwVVlT1?=
 =?us-ascii?Q?uMxnq6exnDnYf54zG+Mn5E2+5xlVUng3l3l645ZCBBz8x8JC1PswuUdI5sQ3?=
 =?us-ascii?Q?DK7VVrVM8DQpqa8wX4adp9qKQi5l42iHMoTsOaKRzKaWNLAEYCgdRhBAo9OA?=
 =?us-ascii?Q?s4eM25BUUdbuKvr6NEkjTTAyTZHrVKDWCHWO5wzaiAeacFwt3sMHTo33jKUx?=
 =?us-ascii?Q?rMNv7GPS9fVAhRLq+vGNM8mb6Qmx9ZTD24Lm0C6NRb64Wpaqj9A/J6ZiBSpG?=
 =?us-ascii?Q?usSzC55Sp1c+DRC1YqiqC9mWYqJDAoDbYKTCmk/YLL1bcPqdfBmZizwrMOhX?=
 =?us-ascii?Q?TbrVENFDTfXmlhZON0HbCuW9AT38ueGUQnYt/2U0yEVNJBMl1jdiLrpGOugK?=
 =?us-ascii?Q?zXuxX7DzuBvdOMnDgnm1QUmec/JSc0bHzXaa3ybGe12sLy3aKwSZLAPRA5zo?=
 =?us-ascii?Q?St83GAL6IFYtu145cvP8So+ev+oZLWp2ZWCuzsN5U/Sh/75zwiexbalvJLyK?=
 =?us-ascii?Q?m74ZIzQnKhCuwUdr7NJO+a3UFLa2XC9qK4AxewXl3djO+/1fUkKXkM1bWvH7?=
 =?us-ascii?Q?OUxHwM6l1bjew3MvoAj24YDfVZcUL9Z92BfglfLcTsBGHnopjcezaDeDTkAP?=
 =?us-ascii?Q?jnDU25NND4EwW/o+eAKGsFiy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07D95CD1D670AF4085682E42CAC22B2D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214fd875-f005-40c2-7d87-08d90373a1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 20:42:21.8875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dhq0V8MGiwXKajE4JQDNBB66G6fXG3jiRe43Lm/sVgQwjJWN07+sGokcryQxj0ItyEyzd0GRzTOrtj58W0N4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4494
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190142
X-Proofpoint-GUID: 5D_gIr7Bx19PGcmBAUf1KIXSrQALJj-X
X-Proofpoint-ORIG-GUID: 5D_gIr7Bx19PGcmBAUf1KIXSrQALJj-X
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190142
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 19, 2021, at 3:53 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Fri, Apr 16, 2021 at 07:21:16PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Apr 16, 2021, at 2:00 PM, J. Bruce Fields <bfields@redhat.com> wrote=
:
>>>=20
>>> From: "J. Bruce Fields" <bfields@redhat.com>
>>>=20
>>> The nfs4_file structure is per-filehandle, not per-inode, because the
>>> spec requires open and other state to be per filehandle.
>>>=20
>>> But it will turn out to be convenient for nfs4_files associated with th=
e
>>> same inode to be hashed to the same bucket, so let's hash on the inode
>>> instead of the filehandle.
>>>=20
>>> Filehandle aliasing is rare, so that shouldn't have much performance
>>> impact.
>>>=20
>>> (If you have a ton of exported filesystems, though, and all of them hav=
e
>>> a root with inode number 2, could that get you an overlong has chain?
>>=20
>> ^has ^hash
>>=20
>> Also, I'm getting this new warning:
>>=20
>> /home/cel/src/linux/linux/include/linux/hash.h:81:38: warning: shift too=
 big (4294967104) for type unsigned long long
>=20
> Whoops; it needs this: would you like me to resend?--b.

No, thanks. I'll squash this in.


> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b0c74dbde07b..47a76284b47c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -547,7 +547,7 @@ static unsigned int file_hashval(struct svc_fh *fh)
> 	struct inode *inode =3D d_inode(fh->fh_dentry);
>=20
> 	/* XXX: why not (here & in file cache) use inode? */
> -	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_SIZE);
> +	return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
> }
>=20
> static struct hlist_head file_hashtbl[FILE_HASH_SIZE];

--
Chuck Lever



