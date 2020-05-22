Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57E11DDC2F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2020 02:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgEVAdQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 20:33:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38352 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgEVAdQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 20:33:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M0MvUa071359;
        Fri, 22 May 2020 00:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 content-transfer-encoding : from : mime-version : subject : date :
 message-id : references : cc : in-reply-to : to; s=corp-2020-01-29;
 bh=fxu9hA6Oy4Q5rA5J9PjmR7a/vaqosA2qaPlbxk7T6n8=;
 b=RU3tZeZxsKv44uVziWiVougQUgkidlby5S0Y1HkrjOhv8PXi/sSNpoKiHUTQFoH3jFq/
 Cl9Wb3KjJnjX5cj9tzLayO7tXe0bnKIcx5qNO78YS5tuHXERAnrbFhjr1LcosCNTR0fK
 B0PLpeR+WiDLomEqW7FRLaF/6gLteRP4JWVToh1OZ1ZArcoTzn6DovtFTnpXb96Xoh0V
 E9DvxYzj21Ywueownz4k4bztjPv+8qOpuNsKdi0jX/sgMln3e4afCO28Y+VgQVe4VZVL
 +WgNHGSqeFoUSBQqWUtdvhLkliUEYVcLUZUBVjMUTnUdCDNFVJ6NlG0U1ZvUIlkJfNNq Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31284mb9h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 00:33:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04M0NHYu100190;
        Fri, 22 May 2020 00:33:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 315023bs0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 00:33:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04M0X7jD005960;
        Fri, 22 May 2020 00:33:07 GMT
Received: from [192.168.1.184] (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 17:33:07 -0700
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Chuck Lever <chuck.lever@oracle.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] sunrpc: check that domain table is empty at module unload.
Date:   Thu, 21 May 2020 20:33:05 -0400
Message-Id: <91AD6EF0-21DD-4FF2-B193-2DABE84D7F75@oracle.com>
References: <878shkam4t.fsf@notabene.neil.brown.name>
Cc:     Bruce Fields <bfields@fieldses.org>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <878shkam4t.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.de>
X-Mailer: iPad Mail (17F75)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220001
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On May 21, 2020, at 7:45 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> =EF=BB=BFOn Thu, May 21 2020, Chuck Lever wrote:
>=20
>> Hi Neil!
>>=20
>> Thanks for the patches. Seems to me like a good fix overall.
>>=20
>> Judging by the syzbot e-mail, you might be posting a refresh of this
>> patch series, so I proffer a few minor review comments below.
>>=20
>>=20
>>>> On May 20, 2020, at 11:21 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> The domain table should be empty at module unload.  If it isn't there is=

>>> a bug somewhere.  So check and report.
>>>=20
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206651
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>> net/sunrpc/sunrpc.h      |    1 +
>>> net/sunrpc/sunrpc_syms.c |    2 ++
>>> net/sunrpc/svcauth.c     |   18 ++++++++++++++++++
>>> 3 files changed, 21 insertions(+)
>>>=20
>>> diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
>>> index 47a756503d11..f6fe2e6cd65a 100644
>>> --- a/net/sunrpc/sunrpc.h
>>> +++ b/net/sunrpc/sunrpc.h
>>> @@ -52,4 +52,5 @@ static inline int sock_is_loopback(struct sock *sk)
>>>=20
>>> int rpc_clients_notifier_register(void);
>>> void rpc_clients_notifier_unregister(void);
>>> +void auth_domain_cleanup(void);
>>> #endif /* _NET_SUNRPC_SUNRPC_H */
>>> diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
>>> index f9edaa9174a4..236fadc4a439 100644
>>> --- a/net/sunrpc/sunrpc_syms.c
>>> +++ b/net/sunrpc/sunrpc_syms.c
>>> @@ -23,6 +23,7 @@
>>> #include <linux/sunrpc/rpc_pipe_fs.h>
>>> #include <linux/sunrpc/xprtsock.h>
>>>=20
>>> +#include "sunrpc.h"
>>> #include "netns.h"
>>>=20
>>> unsigned int sunrpc_net_id;
>>> @@ -131,6 +132,7 @@ cleanup_sunrpc(void)
>>>    unregister_rpc_pipefs();
>>>    rpc_destroy_mempool();
>>>    unregister_pernet_subsys(&sunrpc_net_ops);
>>> +    auth_domain_cleanup();
>>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>>>    rpc_unregister_sysctl();
>>> #endif
>>> diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
>>> index 552617e3467b..477890e8b9d8 100644
>>> --- a/net/sunrpc/svcauth.c
>>> +++ b/net/sunrpc/svcauth.c
>>> @@ -205,3 +205,21 @@ struct auth_domain *auth_domain_find(char *name)
>>>    return NULL;
>>> }
>>> EXPORT_SYMBOL_GPL(auth_domain_find);
>>> +
>>> +void auth_domain_cleanup(void)
>>> +{
>>> +    /* There should be no auth_domains left at module unload */
>>=20
>> Since this is a globally-visible function, could you move this comment
>> into a Doxy documenting comment before the function? It should make clear=

>> that the purpose of this function is only for debugging.
>=20
> I wouldn't call it "globally-visible" as it isn't exported, and isn't
> even declared in linux/include/...
> But a Doxy comment is probably justified.
>=20
>>=20
>>=20
>>> +    int h;
>>> +    bool found =3D false;
>>> +
>>> +    for (h =3D 0; h < DN_HASHMAX; h++) {
>>> +        struct auth_domain *hp;
>>> +
>>> +        hlist_for_each_entry(hp, auth_domain_table+h, hash) {
>>> +            found =3D true;
>>> +            printk(KERN_WARNING "sunrpc: domain %s still present at mod=
ule unload.\n",
>>> +                   hp->name);
>>=20
>> Nit: Documentation/process/coding-style.rst recommends using the pr_warn(=
)
>> macro here (and equivalents in other patches)... And note that "svc:" is
>> the conventional prefix for server-side warnings.
>=20
> I'll fix that, thanks.
>=20
>>=20
>> I'm wondering... is it safe to release an auth_domain here if one is foun=
d,
>> so that it is not actually orphaned? The warning is information for
>> developers; there's nothing, say, an administrator can do about this
>> situation.
>=20
> I don't think it is safe to release the domain.  The ->release()
> function could be in a module that has already been unloaded.

A comment to that effect would be good. Up to you!


>>> +        }
>>> +    }
>>> +    WARN(found, "sunrpc: auth_domain_table not clean -> memory leak\n")=
;
>>=20
>> Not sure a stack trace in addition to the above warning messages adds
>> relevant information. Can you provide a little justification for that?
>=20
> I guess so.  I wanted a nice loud warning - and people tend to notice
> stack traces more than they notice printks - it was an attempt at human
> engineering :-)
>=20
> Maybe I'll just leave it as pr_warn...
>=20
> Thanks for the review.
>=20
> NeilBrown
>=20
>=20
>>=20
>> Thanks!
>>=20
>>=20
>>> +}
>>>=20
>>>=20
>>=20
>> --
>> Chuck Lever

