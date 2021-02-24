Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF832440B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 19:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhBXStC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 13:49:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35954 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbhBXSsf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 13:48:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OITER8076721;
        Wed, 24 Feb 2021 18:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kTt2ozMeGtEuLDAoHsI4rYkF8CST8Lcs4Q+wS+6ZJbU=;
 b=BMJAkoTZyCoSPysheaXBP3vIv2pAlfQaZmXvW3hbn5BmTdQAdefpJl7ySwUxtBkEDl8a
 jQ6iowhY5nBeSzkXGi6Y228ZS5LWIBcgbFB4pLss5QNZXh0S6wJ9+dGVboqZdkikk0s4
 TeBc6ksPMNRY85KvtPLECGVxIHqXTAnopJ1SXWZvtCAj2ih97rGpKoFmgfoUnohjNvh5
 8jVS91/nl13nEeexZMjYuQqR8YtPUjTh9z5tWGq39IOd9h7bF5jXCsxPvXWdbpfNDA0i
 xDY2lYWguKGrUOZLLBJDgl29wwkS2CWjyCjT5VnuBV/2xzSHCOfI5JVqYZl9ufnUfYJX iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36vr626bjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 18:47:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OIYoFC163991;
        Wed, 24 Feb 2021 18:47:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 36ucb13h2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 18:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwNHQZoQv4qK8z/2/fIIvQWcQtNsRhE2u9EZRqNzbRD5Rt2YEVd4XU04TIbWDoKqsbOSCrNsXU6OBWPxLMu4vUd6PD1NQm3oJMelyYfQXUpkrKfnt8sc2A3qGkt0aZK7EvXzyeAg+I0Bbytl4jHUmZaBMcB4VQafpUZR6CwKYhVe62si3uIFnELefp4DjE8TfGybqCQUqp281f05hNDUuHSaTTPlRsXBwIPOsU1wmmIRLMSSnuCxkn/uVIYRkefxzeYlRmMkgL+wp8owhwlW4AMXeOrgsagd9CTuTaasSbEwNUwIMpKtZkgmhk+IrBDq4h75erQgtz4/vx9YHy57Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTt2ozMeGtEuLDAoHsI4rYkF8CST8Lcs4Q+wS+6ZJbU=;
 b=jq1my0qkTGmlXadSBZBibh4ZZ4AwphAzLA01/aL//2+nr0jHCiXEIinowxqCiehP0HQuLvas6qmcZOpSMpPvCf5Y5TQi2O6m+sulWB8eWRieUBr4SOv+Bx7vYhmiNzEGivtXqV0XYupnQH/bA95DSUGraMWo+fmgCeWSoYOG0BV1PwJ1VjDeTsg6O7mc4pKDEQfyCmgYzCb0lzAG3kgpdCgmi625lNVO2/LqTHv4UQf2iF6ODp5w/RsgoVsFb45aLry6ZEpTlDNKblk54TJNqRrEBV5q9iQILrG6lb7bKaB7JHFQK7pu/w2sB5+dkkcFwKMNdHIiioQ5ghNGxaV4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTt2ozMeGtEuLDAoHsI4rYkF8CST8Lcs4Q+wS+6ZJbU=;
 b=T4qreeNj4a+rqfo503Zi+55ynX16u99RH1+Smarrxwh89R9tZrKMLdS0yKBrpuj44/AtzDBK54e9uOXUBP2jzToWnbh3nat3cvzOWoE3Z3Dcj0k3hurkxpNRMcDZTRHsQy1BeKn6nbfjIE2U1Yv/s/U4m6D/IcUr7GEzzN+4Gog=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 18:47:48 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 18:47:48 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH] nfsd: don't abort copies early
Thread-Topic: [PATCH] nfsd: don't abort copies early
Thread-Index: AQHXCtx0cs5d9peX+k+/c+JLDyWeq6pnpV2A
Date:   Wed, 24 Feb 2021 18:47:48 +0000
Message-ID: <38673092-7DE6-437B-8D6F-1EFD1673BDE5@oracle.com>
References: <20210224183950.GB11591@fieldses.org>
In-Reply-To: <20210224183950.GB11591@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf64388d-371c-41f9-e232-08d8d8f4ae66
x-ms-traffictypediagnostic: SJ0PR10MB4591:
x-microsoft-antispam-prvs: <SJ0PR10MB45914FFB0795CFA572E9A7C5939F9@SJ0PR10MB4591.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvCEqCNpd8aB+ibFBJAJEL9LG2iAMaPxrgpnBO75TZa4puPUnCy3p7QIo3oQybHmFT7l3rgJW5ZyJMdmR7HynYcHj2mDMWdcH4PqrYxwfBMUF/pS9iHZtxYPdtMDeNMeTJDOjxTAsb8Xi3xgGIHue0tjX3mifcf1XpZCiqCxmK/iMf/brViz4V72eAUq+cUPvzbqsq86dxGvTT+C3PFaGT73POGhX/D7XArkinJHRFfbGhHuHaCMyoYPJJPiJl06uvc1ykuaN/5d2V55kecszvqssYK8If9K94jVXvRdu/mJ5pcEz6+BtaUVY7K32+4yG4Myy7f4zOZM9oeHX7SY7nEJ4lq7NpZAhj5Ipox7EuDgLB6FyMpngezyjbsawyu7AA1JsvuiJ6UBMDoa0J6F77Oa6R7ZpomFB61i6yBW/dmhlx4lRnrCF4TRZvIGr/v9w/fAmN76HB+dsj8PnS1+iVN5kW6CcHGXaMRYsXv6/sDedDQkeg857w+tt6JKyZaP/WrwVD50Ga0j/3JQ+ccGlZ63z70O6IegYREVMxAs4M6NsTIYLKZGuJuYQq4VzfDobEgCM5P2UaCkjMI8fTSM3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(346002)(136003)(54906003)(33656002)(316002)(83380400001)(5660300002)(6916009)(6512007)(4326008)(36756003)(8936002)(478600001)(8676002)(66946007)(76116006)(44832011)(26005)(2616005)(6486002)(86362001)(2906002)(71200400001)(66476007)(53546011)(66556008)(91956017)(6506007)(66446008)(186003)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aM7XfNGwUqjRxLYSEkPZ/WRcvtImugk0+BxINpIOXs+mpdUnQ6o26w/j1kVx?=
 =?us-ascii?Q?G3w/G8/ta9L7kswMPj2zgaUZSKfS5KQu4kaUWwGu18+OC5J+oPOfq6v4PMJ8?=
 =?us-ascii?Q?rz/SS3E5pp853wmawdhXiO6yEDXB+3dtPbjv7VNkesIAI073LnqQbQ68P5Ge?=
 =?us-ascii?Q?qscbQA//zXOmyXaR/BFAa5Xj9F4R1jzY+WXQp623TBdTu/KSIsabPOwlwKJN?=
 =?us-ascii?Q?SAmHb9TNxa+G3nmBT7mZ69ISOHrqxMyOl7fmsI0TNiDBbmzLxN0x9SYGLSI/?=
 =?us-ascii?Q?e5Fg727ncfM3SmmoaB5wCcjfuZl7jYB7sSBwBQ4BroIMo/eBLfCfdMkUPm+Z?=
 =?us-ascii?Q?REHCG3VmngrNR1MERwMUxZyBoqnKpY6JZt2Ia4GgTyG6pVgLnRYF4Zw5jStD?=
 =?us-ascii?Q?jmsM8E2S0DvhJGDChXIleoD1tTbvaJb9BY9VwiGe348yq7pm+lu9sdGgAwAH?=
 =?us-ascii?Q?4dP1+J206ANPS2O1V62DMWSJwRiZ5iEtQoda5Wy9/7hVdDWWaCW5DWvKz6u/?=
 =?us-ascii?Q?e/+NOBT2kNJyAFJ/4F7TKiOnKvCLREz7w8v04JHFCm8i6tUN0GFCl+NGDmAU?=
 =?us-ascii?Q?4OAFhONx5hgZ2w0lQHwTuJtYmUKx8zi4Cv7/ApeCpvd9P8E/+L+8WPbSury7?=
 =?us-ascii?Q?DulXE3xY5sYsVZGxaAzT12Rhm51aUS5vLAZGpDd+nAqp54d2BKKTz4cX9rR9?=
 =?us-ascii?Q?RQJ57L7syoNc6IkP1lTfswdsjzeeTHE7/KHVODyYd2IVjsRFLAf3+LE2yPOV?=
 =?us-ascii?Q?Fd7sdNKwsOxZjKnOkR+BIVsqkCBtQCO7TNB8HcwQTsAF/+qWNH26JSg3FwZT?=
 =?us-ascii?Q?KyZ9hNZbmLfkkAZn9evKyoOh2iwxiL5RtkTRIueOa5wWTfcESfxyVteQa3ej?=
 =?us-ascii?Q?NngQKu2Y5q0v8gj4qLJdVW7OkNdc/lHsWklZXAzcDHwE9xQ7klXOUWR0Fzuc?=
 =?us-ascii?Q?Lqlr9rlDyrWIdGVy+0hHzFlxNH1aZ2oVAZhMqX+SQmd5j+GLTJY1Wfur+8Lm?=
 =?us-ascii?Q?rIHiM2FSv6Wbx/Iq3f3PTlhNsqLT28eUQPGwzjjpVaSix0ktUCBUv55hIAAf?=
 =?us-ascii?Q?MxUDgPcfaCXftJO4CiwGeqWteAycOfQaRB6hRzVdxDDzpcZmpDrEGWWZzqEr?=
 =?us-ascii?Q?DDSdNZuZzl5+XhA4QUHZP2jRvQCtw+zZLcKFepbcOzRlw0OGkxMtQcIkoTyv?=
 =?us-ascii?Q?/GbNbJdp3I5knDKUvH6x8r/LHlKq+G22Z7Fd8UAIGUXhcku1aWyU+jcWwdNm?=
 =?us-ascii?Q?Qb8HuBZeJ7w/kyK45z6lgJO8vBHCxTghsTDp6My5GwoYCikmTURQ5kYzBhGx?=
 =?us-ascii?Q?8wmHAaFDyn8/eEJchluPj4RqaRDeK1Ew3E2ja9zfBY9VKA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8954D1040A40BD42A3EBA05AF4FEDBA8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf64388d-371c-41f9-e232-08d8d8f4ae66
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 18:47:48.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXwQ630AKZb3KHD7MjqjUWjOgRlWR5fl+JkrjBXNYh/G4+6vCdPQvDbaiTj0hWcri6j1PJNu5/eVjLXitiauig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240142
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2021, at 1:39 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> The typical result of the backwards comparison here is that the source
> server in a server-to-server copy will return BAD_STATEID within a few
> seconds of the copy starting, instead of giving the copy a full lease
> period, so the copy_file_range() call will end up unnecessarily
> returning a short read.
>=20
> Fixes: 624322f1adc5 "NFSD add COPY_NOTIFY operation"
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Thanks for your patch. I've pushed it to the for-rc branch of

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfs4state.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 423fd6683f3a..61552e89bd89 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5389,7 +5389,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> 		cps =3D container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
> 		if (cps->cp_stateid.sc_type =3D=3D NFS4_COPYNOTIFY_STID &&
> -				cps->cpntf_time > cutoff)
> +				cps->cpntf_time < cutoff)
> 			_free_cpntf_state_locked(nn, cps);
> 	}
> 	spin_unlock(&nn->s2s_cp_lock);
> --=20
> 2.29.2
>=20

--
Chuck Lever



