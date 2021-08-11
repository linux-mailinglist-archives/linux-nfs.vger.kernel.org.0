Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028543E9923
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhHKTn7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 15:43:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50464 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231416AbhHKTn6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 15:43:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BJbOsO011839;
        Wed, 11 Aug 2021 19:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Y4OGvhTfB7kY+qOteBmroYjhDoZ90s3+uUJhODkGBZI=;
 b=bou70YVZwJexsf6RlQhqxvWpnu91nIqukGcex8+EUGlOwFnJTC5eICDO9IECzjbN2WEY
 t+/pAb+Ea0tVMAiLDCyMpRHlaUorvrNg++X6h27xhUYVJGxwDTMSOVZ7f18227hHagSX
 kodF0U3NeVhh7Q7wB3rI+7FdiILmqya+OXCbYPR+tDpAkmRLgkJhniuAR8hI6wvGX671
 Ef58NQrlflZZXlRs2fkhjTNSheOYYPfApHyWTtxyxqBNOAmnDx7EAVj+mAKT0iMXqzGw
 199hAw86EzrTNTtI2nZ5kpxJZgrM5O1jdQzDHerxspXwm4/o1jMFRTowuOebWjyHPR89 rA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Y4OGvhTfB7kY+qOteBmroYjhDoZ90s3+uUJhODkGBZI=;
 b=zkxjx7Tt7e28QED7CGB7EFxNYJjAXO48tOmZcxviMVLzMN8HjH7Tx+lm8Mwc6JTtYWgD
 dKZW35cS3oLp1lEeQ49nCeJs13Ol2j5OFX1gDDaNIMkB52aaoh4fOK6euOXzALXiv+Qo
 ItOIiS77DmCYJ6l9o7qKB19qs+qcA+40NZ6OjoMTtlK8ToEYKzBSQom7p0L4qNA2zRHR
 gyVRFAY+comkG1Su1A3hpoOWOvAt8ORO9mSHJutchKpbAMxNqWmgV12h2yQ+x8euwR9x
 44jVZgUVHoskgZ6B1r6DWi2gzVCZa1pDpcUjc60wlBNrB3ku6F+hSM4AMBhx1lpMmK8k 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acb7a1hu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 19:43:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17BJeDpx096268;
        Wed, 11 Aug 2021 19:43:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 3abjw6ysmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 19:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUVtnM/sfDSzTQW2VvuvyyRT08ZhBCmMiBJZ50iUUNYu3q9vofB1N5/VYA51Sg/cBPMwPDvMpilgG8LvYT5hxskVOrPwu2g1cT5LlRPMsUuxSQW3sD4IqDtpgz9EnOU6rMnZ8BzJhLAxRcoI9wF9xcjhHzMj9psoAZxMqM2N3G6es0CKCWLACbGNZr0N887fO/6UZ85zdKpbdOXrK2jlYeTxzA+oUBB5bE0kNj5wg40yQ8yHBVjF7GjlcuGJaQZsYQcpHoKU11sBk7gYym+3UTMijXSqH8/rROpq6S0uww+oOQpYm11twlwY5ZmCAko6kvmWnaJmjOZLC9V+oL4udA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4OGvhTfB7kY+qOteBmroYjhDoZ90s3+uUJhODkGBZI=;
 b=oPF0lmJvmAj6lAziHMXxm77dN+vX6C9PjhPslmISAHDb5qtS8RIRUOwocfRE3RkXfty+4Y8YRC1XxmrD6m0FJByFrruZbbwkkat/JUoP8YXO5TTPI2D+e80v98TsYb0jiPUHvizlNYM4hltFCv35fwyljfUirPMnN0kOARfMN1tHOIcjPy7k2d9W0fmfqLFfnQnhhm3vry8UbblHKRLv22pLWTQWdN8Uc4AbhsgxApKowHuCpU+oV2neFECRL/bs/GHYDS+jL6RPVcvdV7wv/tT7WBXcpUyz6kdWf5mBvKApAA0yky7z+XHxUCPUiJ6N5uJX4c/YB9Vp+Z8i3xb9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4OGvhTfB7kY+qOteBmroYjhDoZ90s3+uUJhODkGBZI=;
 b=G0JzLH6V00PZHlVfexoK3hy8jkbSIvC7CkE1ivHQQOJQ9QmxvDGBmNPMf5mqAQG9zLIMDCbwgekrYLmb7AIYP7F+Tya/0VqyQMoFG16449bZimJ98FE+KH3chF3e5prluAUJhKZcbjOqbE6Z+8Ls4VvX6uN0Jz1uuNgimTMDlTo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 19:43:11 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 19:43:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        "kukuk@thkukuk.de" <kukuk@thkukuk.de>
Subject: Re: [PATCH v2 1/1] Fix DoS vulnerability  in libtirpc
Thread-Topic: [PATCH v2 1/1] Fix DoS vulnerability  in libtirpc
Thread-Index: AQHXjkUEtTN5sHaOM0q/p0rLUJf4N6tutbAA
Date:   Wed, 11 Aug 2021 19:43:11 +0000
Message-ID: <FB734534-39C5-4C07-9E06-65E052D04BB0@oracle.com>
References: <20210811000818.95985-1-dai.ngo@oracle.com>
In-Reply-To: <20210811000818.95985-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1820b6c5-fcb0-4a56-0b08-08d95d0040a2
x-ms-traffictypediagnostic: BY5PR10MB4162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB4162DBEBBF90F8455A4F763393F89@BY5PR10MB4162.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ay58cBsv5fgBnU/3H33YL8WP1rNzmaupx3ZyNgu0RT04zRMp58fNlc2dFlOCMLVnQRaR839aU/bXYu6OssBZeQmcSxBUVnBTyltCs4q8KKrrRtg0ypPjG0dvxqkzgfWM4vL517iVr8Ou0Qv86Xllf4x/7Fd5jy5Fb5h9glEAzzXvpaTaC9w0Vivrvwep9rcqNpNPrMBe68WWm2mxQt9Y/irB4kTloFUuo/Gb03hMA2avlcHrD4l8gltdKbYOBAGWZrofIIhkObh4smENmcDu0mknd87FqaMOA04mFGegN8XPRfI6jQe8AaXMRC9lo7NwW8s8a5mSmJxzmsGT9n9ppRNTnPCbQS08LtKtlOH0z4R9iSl3DJ9RAU7DGa9LfVi9xQMT+R0YwL3cxw7AdWcOSgrRXscZs+MnmMh5IhCBrntggCPfxsF8TkdD9jNBL+zUGH6OszHI/Qc7WcQb1T0OM6BnFf84n4EmD2rcUxjUYmFzzKFG61X9fRiDW4JxCg5PC+iMBPfG4yhJQdKhbkeHyF8miGDysqcy36F1UrtEJeWI0u/T4O3bxvt9zLBc2oRTYBCL6qfqrmrrW0jro9AHX7EA+fZ1Yud2hv7Xom9TP7R02lb7C/eU2mE9/c5Qbmt/leahmHtfLmHwPc3jBI28ijc4QahDAyHynGatn5ETqyhmKOYEWm9lMM7eSj931qUAxVJY+tXhbptb4Ezpe0II+QXfNV04D4IJGNAy/1r4v7SPBrOHjlt2MHQI8osJCw9B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(86362001)(478600001)(38100700002)(2906002)(53546011)(6506007)(4326008)(6636002)(33656002)(5660300002)(122000001)(71200400001)(26005)(8936002)(8676002)(36756003)(64756008)(186003)(83380400001)(66476007)(66446008)(66556008)(6862004)(91956017)(54906003)(66946007)(6486002)(38070700005)(2616005)(37006003)(76116006)(316002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qa6XatsybzN9A95edc9gZjdIMgItwaoepjSmNmi4YoZ4xSEy/8U8lvYkvP2A?=
 =?us-ascii?Q?sdiQSLNdy8rFJCh+YxaTjZWxyO6wvJdtm1CeT1I3HthEFPJnE/Ir5Xz+RZX8?=
 =?us-ascii?Q?wjjXtSMjHrmJLvjgWL5qg5D6b0gkRZ2yyHBRPpTnmZikTixnoBhVEIqR0EWi?=
 =?us-ascii?Q?jfTeigzeLHDBFYYyMyEAkqw/aoj6rmRYVmrVS5I/ULAdUeUCcI1l+26544Bk?=
 =?us-ascii?Q?9Kd3Hd4XiQ95pioxb7MBmiCRDOktY/kzA6dAdqgl/R6YWc4uf6HVtvuuFe6+?=
 =?us-ascii?Q?Jwzu6uPogAKnIJhnQmMtMoL3jrcHyN4yX6dhPTI7UKLqEvIsYk0/NdWF/UIe?=
 =?us-ascii?Q?/DTx+F0MZ9oisZunWo8ZxJIx+tIgXT8Ir/P5zsxE+vweICbgPGHWYsT818B6?=
 =?us-ascii?Q?VWjJJ8sFIC7p6Gd3UO2HqMrOcvEvbJaqqRYyE2VlMxRDVc9bFwg+9+0qVGjH?=
 =?us-ascii?Q?VA/+/VSY87VJRQUbqgYYzQx/a446CygyNVBBO18oBrigl/wp42ThCBS757cU?=
 =?us-ascii?Q?p+qTQAKajFKA4VuYSVxLLR77+zOtbuufjNz+4oGj7zNfnIsB3L0AXU2JIGHS?=
 =?us-ascii?Q?tRzogF2CZfdphYtwsO4uQiMgyqX6YZ7MmNi2b/rvtmPjIZ3JOkPvZf1rEgEa?=
 =?us-ascii?Q?T8Ir4VWTpU0CnxVA0rtr1JzW1mXFCIeKRQRmzDeRmLAtDC50R2JyuYo5IljS?=
 =?us-ascii?Q?r1rkGR2nf79Frsuj22YeoZXw4NZaIizHi5b1ifzXzyMX5FQZEad55E/kHFDH?=
 =?us-ascii?Q?KwBeiciVeLqwzPFdHIV7hic4A7zN19lDzZjvMZ1n9HpsG8CICkJA+EI+Qx3c?=
 =?us-ascii?Q?BePmgmmkelo2vJqhiHdMxa4JkUArUR7jBKueMOaxnBgarF3YgzqtpL06GCu3?=
 =?us-ascii?Q?IcwW5FqxcsChY+QumQqWxAvTW5OPexpozYq3ZA/d8s6T/hi02CEdfwzFceYl?=
 =?us-ascii?Q?+kblhKJVzZyHsrUvJUBTyLIzbGOPFc2nn2CJJpgx1UHei+oRgh6D6o07H0dw?=
 =?us-ascii?Q?h8tgITOLc/1EpsBMaArvctHq0jCzR0wFnyN7aTr/iP6klGih+2nSUFIau5XA?=
 =?us-ascii?Q?5miv1PxTeZp2/JXf9UleanIhoGXZp+qzY10iXZgG9rhuNsenbDmaqzz5QDyc?=
 =?us-ascii?Q?/9fyGs0yp5Rx40crMf+JZfaMmPXh/hTJM4uCsObD+cFAmW6ct04DF07CHtRt?=
 =?us-ascii?Q?pdTqqSBAQwux4pw7PxB/GxXPgJ/god17OV67rG+ux9wDKwcTbf17+Gkyw7xp?=
 =?us-ascii?Q?t08wIrl45MPf91Zc8WxEaUw7S9szipZ4fe429zM95jAtoJ/beLny8uE9BBqG?=
 =?us-ascii?Q?2qRsdcO7atZ49k4uPU2Une8iMYUlJcyray0dbvfmwx2Obw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16CE751E7104F34EA6C82DD84292F9B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1820b6c5-fcb0-4a56-0b08-08d95d0040a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 19:43:11.3687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KM7bhqfrAWil1S7ODtm+gZnddUfMToV46FLlmc64atgN5Fm0LqGE3kb3mqgmCEajED0xsz1I8JdGKDdpXM5eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110134
X-Proofpoint-GUID: 8fTY94ys42dwiowbWVSS7NvnYkhVtYDc
X-Proofpoint-ORIG-GUID: 8fTY94ys42dwiowbWVSS7NvnYkhVtYDc
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 10, 2021, at 8:08 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Currently svc_run does not handle poll timeout and rendezvous_request
> does not handle EMFILE error returned from accept(2 as it used to.
> These two missing functionality were removed by commit b2c9430f46c4.
>=20
> The effect of not handling poll timeout allows idle TCP conections
> to remain ESTABLISHED indefinitely. When the number of connections
> reaches the limit of the open file descriptors (ulimit -n) then
> accept(2) fails with EMFILE. Since there is no handling of EMFILE
> error this causes svc_run() to get in a tight loop calling accept(2).
> This resulting in the RPC service of svc_run is being down, it's
> no longer able to service any requests.
>=20
> if [ $# -ne 3 ]; then
>        echo "$0: server dst_port conn_cnt"
>        exit
> fi
> server=3D$1
> dport=3D$2
> conn_cnt=3D$3
> echo "dport[$dport] server[$server] conn_cnt[$conn_cnt]"
>=20
> pcnt=3D0
> while [ $pcnt -lt $conn_cnt ]
> do
>        nc -v --recv-only $server $dport &
>        pcnt=3D`expr $pcnt + 1`
> done
>=20
> RPC service rpcbind, statd and mountd are effected by this
> problem.
>=20
> Fix by enhancing rendezvous_request to keep the number of
> SVCXPRT conections to 4/5 of the size of the file descriptor
> table. When this thresold is reached, it destroys the idle
> TCP connections or destroys the least active connection if
> no idle connnction was found.
>=20
> Fixes: 44bf15b8 rpcbind: don't use obsolete svc_fdset interface of libtir=
pc
> Signed-off-by: dai.ngo@oracle.com

Thanks, Dai, this version makes me feel a lot better.

I didn't look too closely at the new __svc_destroy_idle()
function. I know you based it on __svc_clean_idle(), but
I wonder if we have any regression tests in this area.


> ---
> src/svc.c    | 17 +++++++++++++-
> src/svc_vc.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 77 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/svc.c b/src/svc.c
> index 6db164bbd76b..3a8709fe375c 100644
> --- a/src/svc.c
> +++ b/src/svc.c
> @@ -57,7 +57,7 @@
>=20
> #define max(a, b) (a > b ? a : b)
>=20
> -static SVCXPRT **__svc_xports;
> +SVCXPRT **__svc_xports;
> int __svc_maxrec;
>=20
> /*
> @@ -194,6 +194,21 @@ __xprt_do_unregister (xprt, dolock)
>     rwlock_unlock (&svc_fd_lock);
> }
>=20
> +int
> +svc_open_fds()
> +{
> +	int ix;
> +	int nfds =3D 0;
> +
> +	rwlock_rdlock (&svc_fd_lock);
> +	for (ix =3D 0; ix < svc_max_pollfd; ++ix) {
> +		if (svc_pollfd[ix].fd !=3D -1)
> +			nfds++;
> +	}
> +	rwlock_unlock (&svc_fd_lock);
> +	return (nfds);
> +}
> +
> /*
>  * Add a service program to the callout list.
>  * The dispatch routine will be called when a rpc request for this
> diff --git a/src/svc_vc.c b/src/svc_vc.c
> index f1d9f001fcdc..3dc8a75787e1 100644
> --- a/src/svc_vc.c
> +++ b/src/svc_vc.c
> @@ -64,6 +64,8 @@
>=20
>=20
> extern rwlock_t svc_fd_lock;
> +extern SVCXPRT **__svc_xports;
> +extern int svc_open_fds();
>=20
> static SVCXPRT *makefd_xprt(int, u_int, u_int);
> static bool_t rendezvous_request(SVCXPRT *, struct rpc_msg *);
> @@ -82,6 +84,7 @@ static void svc_vc_ops(SVCXPRT *);
> static bool_t svc_vc_control(SVCXPRT *xprt, const u_int rq, void *in);
> static bool_t svc_vc_rendezvous_control (SVCXPRT *xprt, const u_int rq,
> 				   	     void *in);
> +static int __svc_destroy_idle(int timeout);
>=20
> struct cf_rendezvous { /* kept in xprt->xp_p1 for rendezvouser */
> 	u_int sendsize;
> @@ -313,13 +316,14 @@ done:
> 	return (xprt);
> }
>=20
> +
> /*ARGSUSED*/
> static bool_t
> rendezvous_request(xprt, msg)
> 	SVCXPRT *xprt;
> 	struct rpc_msg *msg;
> {
> -	int sock, flags;
> +	int sock, flags, nfds, cnt;
> 	struct cf_rendezvous *r;
> 	struct cf_conn *cd;
> 	struct sockaddr_storage addr;
> @@ -379,6 +383,16 @@ again:
>=20
> 	gettimeofday(&cd->last_recv_time, NULL);
>=20
> +	nfds =3D svc_open_fds();
> +	if (nfds >=3D (_rpc_dtablesize() / 5) * 4) {
> +		/* destroy idle connections */
> +		cnt =3D __svc_destroy_idle(15);
> +		if (cnt =3D=3D 0) {
> +			/* destroy least active */
> +			__svc_destroy_idle(0);
> +		}
> +	}
> +
> 	return (FALSE); /* there is never an rpc msg to be processed */
> }
>=20
> @@ -820,3 +834,49 @@ __svc_clean_idle(fd_set *fds, int timeout, bool_t cl=
eanblock)
> {
> 	return FALSE;
> }
> +
> +static int
> +__svc_destroy_idle(int timeout)
> +{
> +	int i, ncleaned =3D 0;
> +	SVCXPRT *xprt, *least_active;
> +	struct timeval tv, tdiff, tmax;
> +	struct cf_conn *cd;
> +
> +	gettimeofday(&tv, NULL);
> +	tmax.tv_sec =3D tmax.tv_usec =3D 0;
> +	least_active =3D NULL;
> +	rwlock_wrlock(&svc_fd_lock);
> +
> +	for (i =3D 0; i <=3D svc_max_pollfd; i++) {
> +		if (svc_pollfd[i].fd =3D=3D -1)
> +			continue;
> +		xprt =3D __svc_xports[i];
> +		if (xprt =3D=3D NULL || xprt->xp_ops =3D=3D NULL ||
> +			xprt->xp_ops->xp_recv !=3D svc_vc_recv)
> +			continue;
> +		cd =3D (struct cf_conn *)xprt->xp_p1;
> +		if (!cd->nonblock)
> +			continue;
> +		if (timeout =3D=3D 0) {
> +			timersub(&tv, &cd->last_recv_time, &tdiff);
> +			if (timercmp(&tdiff, &tmax, >)) {
> +				tmax =3D tdiff;
> +				least_active =3D xprt;
> +			}
> +			continue;
> +		}
> +		if (tv.tv_sec - cd->last_recv_time.tv_sec > timeout) {
> +			__xprt_unregister_unlocked(xprt);
> +			__svc_vc_dodestroy(xprt);
> +			ncleaned++;
> +		}
> +	}
> +	if (timeout =3D=3D 0 && least_active !=3D NULL) {
> +		__xprt_unregister_unlocked(least_active);
> +		__svc_vc_dodestroy(least_active);
> +		ncleaned++;
> +	}
> +	rwlock_unlock(&svc_fd_lock);
> +	return (ncleaned);
> +}
> --=20
> 2.26.2
>=20

--
Chuck Lever



