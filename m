Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6681DCEE6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgEUOGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:06:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55908 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgEUOGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:06:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LE26ur005732;
        Thu, 21 May 2020 14:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=2EDmhkZ2PCF7fLJHgXEioY9O5Yvho0Dt3NXpsdyupTE=;
 b=fuv49zrHVIX0WwHYV9t7bA8HpSQSY5jCKjYviSvnmJb64GAKmTu5b0acQD2Y3rvU79Bo
 QQ7pyMj95aMV43FwT3RWFf+c6IdRab1ATXIC2fqKP6q/iOByrhg930CW5l2mmmakMpe1
 7GYq8BC88D9hqXGNUsiZOq276IIh8h6rGXrmSW2ZW/vml2Dik7GKigt5Y5izrfJ4m9f7
 GjCM6etzUuPAxzQROZwgfxCG1E9TIts4zL9z5XwOW9qmeUn5Iok82QR+124MviO8AIon
 cCDBCwWpxvMl1NVNqVAvOhBWssrT0JNGNjDaOiIqgTpuXxphwRm8tNKzpo3XEEP2M6rB JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31284m8pj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 14:06:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LE3FRb136340;
        Thu, 21 May 2020 14:06:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 312t3b8f24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 14:06:03 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04LE61eo015992;
        Thu, 21 May 2020 14:06:02 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 07:06:01 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/3] sunrpc: check that domain table is empty at module
 unload.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <159003130168.24897.13206733830315341548.stgit@noble>
Date:   Thu, 21 May 2020 10:06:00 -0400
Cc:     Bruce Fields <bfields@fieldses.org>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC992FCD-FB50-494D-ACDA-A021428D7F90@oracle.com>
References: <159003086409.24897.4659128962844846611.stgit@noble>
 <159003130168.24897.13206733830315341548.stgit@noble>
To:     Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210105
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil!

Thanks for the patches. Seems to me like a good fix overall.

Judging by the syzbot e-mail, you might be posting a refresh of this
patch series, so I proffer a few minor review comments below.


> On May 20, 2020, at 11:21 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> The domain table should be empty at module unload.  If it isn't there =
is
> a bug somewhere.  So check and report.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206651
> Cc: stable@vger.kernel.org
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> net/sunrpc/sunrpc.h      |    1 +
> net/sunrpc/sunrpc_syms.c |    2 ++
> net/sunrpc/svcauth.c     |   18 ++++++++++++++++++
> 3 files changed, 21 insertions(+)
>=20
> diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
> index 47a756503d11..f6fe2e6cd65a 100644
> --- a/net/sunrpc/sunrpc.h
> +++ b/net/sunrpc/sunrpc.h
> @@ -52,4 +52,5 @@ static inline int sock_is_loopback(struct sock *sk)
>=20
> int rpc_clients_notifier_register(void);
> void rpc_clients_notifier_unregister(void);
> +void auth_domain_cleanup(void);
> #endif /* _NET_SUNRPC_SUNRPC_H */
> diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
> index f9edaa9174a4..236fadc4a439 100644
> --- a/net/sunrpc/sunrpc_syms.c
> +++ b/net/sunrpc/sunrpc_syms.c
> @@ -23,6 +23,7 @@
> #include <linux/sunrpc/rpc_pipe_fs.h>
> #include <linux/sunrpc/xprtsock.h>
>=20
> +#include "sunrpc.h"
> #include "netns.h"
>=20
> unsigned int sunrpc_net_id;
> @@ -131,6 +132,7 @@ cleanup_sunrpc(void)
> 	unregister_rpc_pipefs();
> 	rpc_destroy_mempool();
> 	unregister_pernet_subsys(&sunrpc_net_ops);
> +	auth_domain_cleanup();
> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> 	rpc_unregister_sysctl();
> #endif
> diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
> index 552617e3467b..477890e8b9d8 100644
> --- a/net/sunrpc/svcauth.c
> +++ b/net/sunrpc/svcauth.c
> @@ -205,3 +205,21 @@ struct auth_domain *auth_domain_find(char *name)
> 	return NULL;
> }
> EXPORT_SYMBOL_GPL(auth_domain_find);
> +
> +void auth_domain_cleanup(void)
> +{
> +	/* There should be no auth_domains left at module unload */

Since this is a globally-visible function, could you move this comment
into a Doxy documenting comment before the function? It should make =
clear
that the purpose of this function is only for debugging.


> +	int h;
> +	bool found =3D false;
> +
> +	for (h =3D 0; h < DN_HASHMAX; h++) {
> +		struct auth_domain *hp;
> +
> +		hlist_for_each_entry(hp, auth_domain_table+h, hash) {
> +			found =3D true;
> +			printk(KERN_WARNING "sunrpc: domain %s still =
present at module unload.\n",
> +			       hp->name);

Nit: Documentation/process/coding-style.rst recommends using the =
pr_warn()
macro here (and equivalents in other patches)... And note that "svc:" is
the conventional prefix for server-side warnings.

I'm wondering... is it safe to release an auth_domain here if one is =
found,
so that it is not actually orphaned? The warning is information for
developers; there's nothing, say, an administrator can do about this
situation.


> +		}
> +	}
> +	WARN(found, "sunrpc: auth_domain_table not clean -> memory =
leak\n");

Not sure a stack trace in addition to the above warning messages adds
relevant information. Can you provide a little justification for that?

Thanks!


> +}
>=20
>=20

--
Chuck Lever



