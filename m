Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F951DDB47
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2020 01:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgEUXo7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 19:44:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgEUXo7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 May 2020 19:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2F15ACF9;
        Thu, 21 May 2020 23:45:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 22 May 2020 09:44:50 +1000
Cc:     Bruce Fields <bfields@fieldses.org>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] sunrpc: check that domain table is empty at module unload.
In-Reply-To: <AC992FCD-FB50-494D-ACDA-A021428D7F90@oracle.com>
References: <159003086409.24897.4659128962844846611.stgit@noble> <159003130168.24897.13206733830315341548.stgit@noble> <AC992FCD-FB50-494D-ACDA-A021428D7F90@oracle.com>
Message-ID: <878shkam4t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 21 2020, Chuck Lever wrote:

> Hi Neil!
>
> Thanks for the patches. Seems to me like a good fix overall.
>
> Judging by the syzbot e-mail, you might be posting a refresh of this
> patch series, so I proffer a few minor review comments below.
>
>
>> On May 20, 2020, at 11:21 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>> The domain table should be empty at module unload.  If it isn't there is
>> a bug somewhere.  So check and report.
>>=20
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206651
>> Cc: stable@vger.kernel.org
>> Signed-off-by: NeilBrown <neilb@suse.de>
>> ---
>> net/sunrpc/sunrpc.h      |    1 +
>> net/sunrpc/sunrpc_syms.c |    2 ++
>> net/sunrpc/svcauth.c     |   18 ++++++++++++++++++
>> 3 files changed, 21 insertions(+)
>>=20
>> diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
>> index 47a756503d11..f6fe2e6cd65a 100644
>> --- a/net/sunrpc/sunrpc.h
>> +++ b/net/sunrpc/sunrpc.h
>> @@ -52,4 +52,5 @@ static inline int sock_is_loopback(struct sock *sk)
>>=20
>> int rpc_clients_notifier_register(void);
>> void rpc_clients_notifier_unregister(void);
>> +void auth_domain_cleanup(void);
>> #endif /* _NET_SUNRPC_SUNRPC_H */
>> diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
>> index f9edaa9174a4..236fadc4a439 100644
>> --- a/net/sunrpc/sunrpc_syms.c
>> +++ b/net/sunrpc/sunrpc_syms.c
>> @@ -23,6 +23,7 @@
>> #include <linux/sunrpc/rpc_pipe_fs.h>
>> #include <linux/sunrpc/xprtsock.h>
>>=20
>> +#include "sunrpc.h"
>> #include "netns.h"
>>=20
>> unsigned int sunrpc_net_id;
>> @@ -131,6 +132,7 @@ cleanup_sunrpc(void)
>> 	unregister_rpc_pipefs();
>> 	rpc_destroy_mempool();
>> 	unregister_pernet_subsys(&sunrpc_net_ops);
>> +	auth_domain_cleanup();
>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>> 	rpc_unregister_sysctl();
>> #endif
>> diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
>> index 552617e3467b..477890e8b9d8 100644
>> --- a/net/sunrpc/svcauth.c
>> +++ b/net/sunrpc/svcauth.c
>> @@ -205,3 +205,21 @@ struct auth_domain *auth_domain_find(char *name)
>> 	return NULL;
>> }
>> EXPORT_SYMBOL_GPL(auth_domain_find);
>> +
>> +void auth_domain_cleanup(void)
>> +{
>> +	/* There should be no auth_domains left at module unload */
>
> Since this is a globally-visible function, could you move this comment
> into a Doxy documenting comment before the function? It should make clear
> that the purpose of this function is only for debugging.

I wouldn't call it "globally-visible" as it isn't exported, and isn't
even declared in linux/include/...
But a Doxy comment is probably justified.

>
>
>> +	int h;
>> +	bool found =3D false;
>> +
>> +	for (h =3D 0; h < DN_HASHMAX; h++) {
>> +		struct auth_domain *hp;
>> +
>> +		hlist_for_each_entry(hp, auth_domain_table+h, hash) {
>> +			found =3D true;
>> +			printk(KERN_WARNING "sunrpc: domain %s still present at module unloa=
d.\n",
>> +			       hp->name);
>
> Nit: Documentation/process/coding-style.rst recommends using the pr_warn()
> macro here (and equivalents in other patches)... And note that "svc:" is
> the conventional prefix for server-side warnings.

I'll fix that, thanks.

>
> I'm wondering... is it safe to release an auth_domain here if one is foun=
d,
> so that it is not actually orphaned? The warning is information for
> developers; there's nothing, say, an administrator can do about this
> situation.

I don't think it is safe to release the domain.  The ->release()
function could be in a module that has already been unloaded.

>
>
>> +		}
>> +	}
>> +	WARN(found, "sunrpc: auth_domain_table not clean -> memory leak\n");
>
> Not sure a stack trace in addition to the above warning messages adds
> relevant information. Can you provide a little justification for that?

I guess so.  I wanted a nice loud warning - and people tend to notice
stack traces more than they notice printks - it was an attempt at human
engineering :-)

Maybe I'll just leave it as pr_warn...

Thanks for the review.

NeilBrown


>
> Thanks!
>
>
>> +}
>>=20
>>=20
>
> --
> Chuck Lever

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7HEnIACgkQOeye3VZi
gbl77Q/9Fu63mMsGLJQSFzgMq2KmCAhFM9xBTJN0pxxt3f/IX/vB/aOIcT8KWcCI
Kep93KGsuWhQRbJCztcTg9vXIWLeNfNsP7yCNe6B4LfrHh8M6XvkNXarYyYhsq8p
1ttZHTx/8tgMK+S2CO6lZjR1rWKbQ2uRMM7PfLvalYInMqRuGYXb+8d7iQuXUp8o
UR8CXwoChuKQSdcHy6FTf9FOOzyN4N0PpKv/MVTbPT2i1/CDyur2bxOTWBMqhrzw
G3YwYlKf6yRH1P4BuhY25+Fq9rtsMbfa/ysPdxuZ4QtcTtCWL/yFwPcK2gfwNxFC
uGKb+4zfaUHz0T2EH41INJUrIMA0aN7pL+3O2iFGQOBjd2ohHPdvhEC75I6LxyOR
MGShuKEVEmPtEU4rOtz0dMbY9P8UvQVl+fWXzr/RCKYQcTyN90d4JtSyjomhjyl0
m6/RD+FhG/IoKhwDwEHhHq6SOxlw7G6a0fwhFf1bJgj/5O9x8O9ZzpzTMrFnb9Ux
SQLqlD+LXWTgC9I/AFdqhtae2F72eNbW7iXaTLATMUHnFlhs/U0pj5ub0ymUspek
FmbJUoPxtvfhYBYYo0y9o+Jbo/oSUnOECHTvkIX6T/Iyj+oZ4v9sueXeKJJDGTw7
O2Db3JQ5AFRQqkoFqSuE30miDIsgTg090JmfH2rf7PsXrbSMAIA=
=NKCI
-----END PGP SIGNATURE-----
--=-=-=--
