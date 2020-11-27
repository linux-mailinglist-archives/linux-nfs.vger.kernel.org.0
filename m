Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89EF2C5F1E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 04:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgK0D4d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 22:56:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52746 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgK0D4d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Nov 2020 22:56:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AR3u71G095523;
        Fri, 27 Nov 2020 03:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 content-transfer-encoding : from : mime-version : subject : date :
 message-id : references : cc : in-reply-to : to; s=corp-2020-01-29;
 bh=shIF0852mD2gkJEMz4JSU3dGyCeDiAT5zx1qk3b589E=;
 b=VgkIWp0raO9yAkcy3+xIbUABmRDJOKo8PtSvl3KeM9GhOum5JkWRdZb1/Sw2i+TBS68U
 j4xrQjQqVjCzmvHgWnAYuFP4DfBMVoTD6gs5lLVcPxsworMZlGl6QXG57GSdZ1sEeL0X
 fHwIDkTu+1aGzS6aa3aMbN68QCRggGYmqIEaTqAIq0iPhJVumC8Yr/AQnlF+sjLcTXjo
 HqbxCvhyE9Z0oFfJHe1AORvenrsQ8JjA6KGTcly4Ne6IOxEjmIIxjCPu9/Hw5Ti+Nto9
 7UiLDkSoMJkZbSN5ph/dutbuTK56tdXnT3LYVWo8XbJ2wFrCTOjMBkONDcp5ajLbi07v Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 351kwhqrn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 03:56:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AR3u0dw142503;
        Fri, 27 Nov 2020 03:56:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 351kwhevkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 03:56:24 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AR3uMcm016810;
        Fri, 27 Nov 2020 03:56:22 GMT
Received: from [192.168.1.115] (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Nov 2020 19:56:22 -0800
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Chuck Lever <chuck.lever@oracle.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nfsd: Fix message level for normal termination
Date:   Thu, 26 Nov 2020 22:56:21 -0500
Message-Id: <7BA358F0-01C3-4530-B5EE-1CBBCE3843C2@oracle.com>
References: <20201127024439.32297-1-kzpn200@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
In-Reply-To: <20201127024439.32297-1-kzpn200@gmail.com>
To:     kazuo ito <kzpn200@gmail.com>
X-Mailer: iPad Mail (18B92)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9817 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270020
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 26, 2020, at 9:46 PM, kazuo ito <kzpn200@gmail.com> wrote:
>=20
> =EF=BB=BFA warning message from nfsd terminating normally
> can confuse system adminstrators or monitoring software.
>=20
> Though it's not exactly fair to pin-point a commit where it
> originated, the current form in the current place started
> to appear in:
>=20
> Fixes: e096bbc6488d ("knfsd: remove special handling for SIGHUP")
> Signed-off-by: kazuo ito <kzpn200@gmail.com>
> ---
> fs/nfsd/nfssvc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index f7f6473578af..b08cccb71787 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -527,8 +527,8 @@ static void nfsd_last_thread(struct svc_serv *serv, st=
ruct net *net)
>        return;
>=20
>    nfsd_shutdown_net(net);
> -    printk(KERN_WARNING "nfsd: last server has exited, flushing export "
> -                "cache\n");
> +    printk(KERN_INFO "nfsd: last server has exited, flushing export "
> +             "cache\n");

pr_info(), please! And see if it will fit on one line.


>    nfsd_export_flush(net);
> }
>=20
> --=20
> 2.20.1
>=20

