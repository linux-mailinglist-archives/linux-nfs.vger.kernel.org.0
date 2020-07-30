Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84B233762
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jul 2020 19:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgG3RI2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jul 2020 13:08:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41530 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727072AbgG3RI1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jul 2020 13:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596128906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MGEzicAzXavysp6/7D78XD1tx51cZs0/1DybV1XqkE=;
        b=isneLqXKwso0lMsEHhnFEqhghsYtqNO0ZTeDgrrnbJRKjeSSKUKzf74vBmnwF7i8vTbG+k
        ZG6HWA9VaJmHr4Qkxbm+FopDz+xn5vCe0/reDP2lxnNqywIQD6pR9v/PScw0ii5/NKSi8H
        c+bBWBJy7kfqZhhiCQsI7OmMJdLW+B8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-tM9LNzTXNU-VZvebvyMPeg-1; Thu, 30 Jul 2020 13:08:21 -0400
X-MC-Unique: tM9LNzTXNU-VZvebvyMPeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85024800477;
        Thu, 30 Jul 2020 17:08:18 +0000 (UTC)
Received: from localhost (unknown [10.10.110.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3820C71906;
        Thu, 30 Jul 2020 17:08:18 +0000 (UTC)
From:   Robbie Harwood <rharwood@redhat.com>
To:     Simo Sorce <simo@redhat.com>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Fedora 32 rpc.gssd misbehavior
In-Reply-To: <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
References: <83856C49-309A-4AD6-9B27-9F93FDDE00DF@oracle.com> <48B9E144-41CA-4DF0-A88D-2F6652A0EBF1@oracle.com> <5ae72c7b0afa65d509db23686d72a1055f7cc6b4.camel@redhat.com>
Date:   Thu, 30 Jul 2020 13:08:17 -0400
Message-ID: <jlg7dulylq6.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Simo Sorce <simo@redhat.com> writes:

> On Wed, 2020-07-29 at 14:27 -0400, Chuck Lever wrote:
>> > On Jul 29, 2020, at 1:19 PM, Chuck Lever <chuck.lever@oracle.com> wrot=
e:
>> >=20
>> > Hi!
>> >=20
>> > I recently updated my test systems from EL7 to Fedora 32, and
>> > NFSv4.0 with Kerberos has stopped working.
>> >=20
>> > I mount with "klimt.ib" as before. The client workload stops
>> > dead when the server tries to perform its first CB_RECALL.
>> >=20
>> > I added some client instrumentation:
>> >=20
>> >   kernel: NFSv4: Callback principal (nfs@klimt.ib.1015granger.net) doe=
s not match acceptor (nfs@klimt.ib).
>> >   kernel: NFS: NFSv4 callback contains invalid cred
>> >=20
>> > I boosted gssd verbosity, and it says:
>> >=20
>> >   rpc.gssd[986]: doing downcall: lifetime_rec=3D72226 acceptor=3Dnfs@k=
limt.ib
>> >=20
>> > But it knows the full hostname for the server:
>> >=20
>> >   rpc.gssd[986]: Full hostname for 'klimt.ib' is 'klimt.ib.1015granger=
.net'
>> >=20
>> >=20
>> > The acceptor appears to come from the Kerberos library. Shouldn't
>> > it be canonicalized? If so, should the Kerberos library do it, or
>> > should gssd? Since this behavior appeared after an upgrade, I
>> > suspect a Kerberos library regression. But it could be config-
>> > related, since both systems were re-imaged from the ground up.
>> >=20
>> > Also noticing some other problems on the server (missing hostname
>> > strings in debug messages, sssd_kcm infinite loops, and gssd
>> > sending garbage to the client after the NULL request that
>> > establishes the callback context).
>> >=20
>> > But let's look at the client acceptor problem first.
>>=20
>> I believe I found the problem.
>>=20
>> 8bffe8c5ec1a ("gssd: add /etc/nfs.conf support") added a number of gssd =
config
>> options to /etc/nfs.conf, including "avoid-dns". The default setting of =
avoid-
>> dns is 1. When I set this option on my client system explicitly to 0, NF=
Sv4.0
>> with Kerberos works again.
>>=20
>> Is there a reason the default setting is 1?
>>=20
>
> Now that you mention DNS, this may be an interaction between a new
> default in Fedora 32 and how your environment is setup re DNS.
>
> In F32 we changed the option dns_canonicalize_hostname from 'true' to
> 'fallback'.
> This is a transitional state to eventually move it to 'false' at some
> point in the future.
>
> What it changes in practice is that it will first try the name passed
> in *as is* and only as a fallback try a CNAME if the name passed is not
> resolved as an A name. If you have principals in the KDC for both
> names, but you do not have keys in the keytab for both, you can have
> transitional issues.
>
> Additionally we discovered a bug that causes non qualified names to
> fail resolution with the 'fallback' option.
> If your name in the principal is really not qualified it will try to
> qualify it anyway, so if your principal is literally nfs/foo@FOO
> libgssapi may try to use nfs/foo.my.domdain@FOO, where "my.domain" is
> what is defined in resolv.conf search path.
>
> We are trying to address this regression.
>
> So try to set dns_canonicalize_hostname to true to see if that may
> influence your issue. If so, please let me know, as we still need to
> address this where possible.

Also, please try setting `qualify_shortname =3D ""`.  (I did update the
config file we ship with Fedora, but upstream's default turns that on.
This is a temporary workaround while we merge something better
upstream.)

Thanks,
--Robbie

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEA5qc6hnelQjDaHWqJTL5F2qVpEIFAl8i/oEACgkQJTL5F2qV
pEIV2Q/9GnnyB4+rFlCDpw0HnphM8vXiMf/flBH2oeSvKcbKpHLYZgWx3YtJqYa1
W5oajBwiVCiPmSgTkNtR2SU4OSgJw80+kowol6l6H++OGPrcWL4aiPaKY2zFpGLQ
vsywsmntquFXfWId79xI0vi6iBLwG5dAYtyHZOJAWIhnOZ0jwe9NcI631QZvKWot
MYmmj0oLxqRJtEEousnZ0FMyejk1wwB6SqtzWUPzGtXyh30/eMgww098bEFFgcF/
8p/jmoeeUi8Y5rF4LGG2q5URIYNlIZQW4nrzB9O205zV3njFOGjCMCf9p5a3zO8P
1nLFAcmqnIxi+GpYzgZ2oQDLQyXqxi5wHNUkLphS4m2GsZmjKrKBGQCUjmNnX37K
D5JSFgplnuv1ehgkdBTjLBKNcRTBOQLP/UXWBKVZSyB1WxqxRN5Vgpnr1BfcHa6U
6LHIAI0T3ZMy2bLlWG9Yi61ngJbS28HZCNiNs75W4/rjZm5dVZpSfUO1B6j75lyn
0YUq8Nz9luH9slSo0zNzMKH3bF9fZ8QHu6Hmxkt+RDBdIzXgsLPHdB2DAGM9tGA5
cHkK4n38BT7kt2za7XD/OHfNYxnCKnbPZdkUcnTkmN+XQuFu1APLiJ+hlXLLG+Ui
Q1f8jVvr7JqjMLm1EuGDUctzTNA3X7sOeFkjMDLxNpeUdtlC4zs=
=nEvX
-----END PGP SIGNATURE-----
--=-=-=--

