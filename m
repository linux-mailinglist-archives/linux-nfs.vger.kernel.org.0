Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07EB2C6A6F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgK0RL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Nov 2020 12:11:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45092 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbgK0RL3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 12:11:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARH8ibT042901;
        Fri, 27 Nov 2020 17:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ZfKiD8hj316X+uqEuUeh7ror6gRFQ5hP+0atihoxG2w=;
 b=T4ex8Zq4/ZxGFiG/shFZ51jZBy4YppEllmGar62y6NeGr5O4RHDb+iKa7MFN6vooM8ZZ
 tyXWjYMVA08HgjWG+E0K9WvZAk9slMXhgiRDjVmzbQJHFhGEc1gcuJl+SotjzZEqxik1
 71Vf2ZDy7JoiNrKeAZ1+JPr7IVasufSN70QbT6dRXleobW3p3iEJVMXW07M2ma72X4UK
 ufLhi4Wd0BrqLpGNQS11PKxeXib2yg54peCmXj8WecgBqUvgwjMQno5yZ+nkUSGPc4Sd
 U2i6wfRNDLcEkVjdnOILYn78rqYDv89UT0p8ieuaV7eUD2yzt693Wqr4Z33SGklBFUeF zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 351kwhj4ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 17:11:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ARH9pMa151816;
        Fri, 27 Nov 2020 17:11:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 351kwgq5j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 17:11:24 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ARHBOYl002657;
        Fri, 27 Nov 2020 17:11:24 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Nov 2020 09:11:23 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nfsd: Fix message level for normal termination
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201127062659.605229-1-kzpn200@gmail.com>
Date:   Fri, 27 Nov 2020 12:11:23 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A40B092-0C28-48C7-A2CB-61C84C2C4282@oracle.com>
References: <7BA358F0-01C3-4530-B5EE-1CBBCE3843C2@oracle.com>
 <20201127062659.605229-1-kzpn200@gmail.com>
To:     kazuo ito <kzpn200@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011270100
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 27, 2020, at 1:26 AM, kazuo ito <kzpn200@gmail.com> wrote:
>=20
> The warning message from nfsd terminating normally
> can confuse system adminstrators or monitoring software.
>=20
> Though it's not exactly fair to pin-point a commit where it
> originated, the current form in the current place started
> to appear in:
>=20
> Fixes: e096bbc6488d ("knfsd: remove special handling for SIGHUP")
> Signed-off-by: kazuo ito <kzpn200@gmail.com>
> ---
> fs/nfsd/nfssvc.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 27b1ad136150..9323e30a7eaf 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -527,8 +527,7 @@ static void nfsd_last_thread(struct svc_serv =
*serv, struct net *net)
> 		return;
>=20
> 	nfsd_shutdown_net(net);
> -	printk(KERN_WARNING "nfsd: last server has exited, flushing =
export "
> -			    "cache\n");
> +	pr_info("nfsd: last server has exited, flushing export =
cache\n");
> 	nfsd_export_flush(net);
> }

Thanks.

Applied internally for the next full merge window. It should
appear soon in the cel-next topic branch at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git

or

  https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dsummary

--
Chuck Lever



