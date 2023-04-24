Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5F6ED0E3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Apr 2023 17:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjDXPCw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Apr 2023 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjDXPCv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Apr 2023 11:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FADC35AC
        for <linux-nfs@vger.kernel.org>; Mon, 24 Apr 2023 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682348524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfycNSg2OO9YE3Ar4LJuepycODmDq88QYTPvO2esTww=;
        b=UAvvHPRW/ED7oiOv6fPrXY8GEwgc/woZuh68R5OnC7LieBXIsGLkMMA8xgT5GDJHih257G
        /4uEx1StVcvTPlk07ZQS1GwayiTxtFlzz+OtLRZo3/21RLcXjFupJZh7N0DET3yNlc9Dig
        4qVCbDiGDdQ13OsoJeqprQOBUpCbv5c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-gPBtcgKWOrm7nqTx4xUaCw-1; Mon, 24 Apr 2023 11:02:00 -0400
X-MC-Unique: gPBtcgKWOrm7nqTx4xUaCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69C483C10ECC;
        Mon, 24 Apr 2023 15:01:59 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55E852027046;
        Mon, 24 Apr 2023 15:01:59 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id D592B1A27F5; Mon, 24 Apr 2023 11:01:58 -0400 (EDT)
Date:   Mon, 24 Apr 2023 11:01:58 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] SUNRPC: store GSS creds in keyrings
Message-ID: <ZEaZ5sLo2nBXUjl/@aion.usersys.redhat.com>
References: <20230420202004.239116-1-smayhew@redhat.com>
 <20230420202004.239116-6-smayhew@redhat.com>
 <20230422212710.GA813856@farprobe>
 <ZEaL8Wueo5/vOGTg@aion.usersys.redhat.com>
 <20230424142309.GB1072182@farprobe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230424142309.GB1072182@farprobe>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 24 Apr 2023, Ben Boeckel wrote:

> On Mon, Apr 24, 2023 at 10:02:25 -0400, Scott Mayhew wrote:
> > On Sat, 22 Apr 2023, Ben Boeckel wrote:
> > > What is the format of this within the bytes?
> >=20
> > The format is "clid: <client-id> id: <fsuid> princ:<princ>", where
> > client-id and fsuid are unsigned ints and princ is either "(none)" or
> > "*" if it's a machine cred:
> >=20
> > crash> p ((struct key *) 0xffff8b4410197900)->description
> > $1 =3D 0xffff8b4446cbd740 "clid:1 id:1000 princ:(none)"
>=20
> Thanks. A bit annoying to parse, but doable.
>=20
> > > > - The key payload contains the address of the gss_cred.
> > >=20
> > > What is the format of this within the bytes?
> >=20
> > The payload is just a pointer:
> >=20
> > crash> p ((struct key *) 0xffff8b4410197900)->payload.data[0]
> > $2 =3D (void *) 0xffff8b44381cd480
>=20
> This looks less useful to userspace (beyond some kind of unique
> ID=E2=80=A6though can it be used to extract information about ASLR or any=
 other
> security mechanism?). Can userspace somehow write to this payload to
> confuse things at all?
>=20
> I'm no security expert so this is just a "random idea" to at least
> hopefully trigger Cunningham's Law, but storing it `xor`'d with some
> per-boot secret could help muddle any information
> leak/extraction/targeting usefulness.

Just to be clear, this isn't meant to be written or read by userspace.
The user isn't explicitly requesting the creation of a key with the
gss_cred key type.  It happens automatically when they access an NFS
filesystem mounted with "sec=3Dkrb5{,i,p}", using the existing upcall
mechanism to rpc.gssd.  The only difference is that instead of sticking
the resulting gss_cred in the rpc_auth.au_credcache hash table, we're
now creating a key with the address of the gss_cred and storing it in
keyrings.

Note that I didn't even provide a 'read' method for this key type
because the payload isn't intended to be read by users.  However, in the
past some users have requested a 'whoami' type function so they could see
what kerberos principal was used to establish the GSS context.  I was
thinking that would be useful information to output in a 'read' method,
however that information is not currently in the kernel - rpc.gssd would
need to add the initiator principal to the information it writes in the
downcall to the kernel, and I haven't really looked yet to see if it's
feasible to do that without breaking the existing upcall mechanism.

Also, while I'm currently printing some raw addresses in the tracepoints
as well is in the /proc/keys output for this new key type, that is
strictly for my own debugging purposes and that stuff will ultimately be
removed in the final patches.

>=20
> > > > - The key is linked to the user's user keyring (KEY_SPEC_USER_KEYRI=
NG)
> > > >   as well as to the keyring on the gss_auth struct.
> > >=20
> > > Where is this documented? Can the key be moved later?
> >=20
> > It's not - I can add that to the documentation for the new key type.
> > The key should not be moved.  I haven't tested if it's possible to move
> > it, but it's something that we'd want to disallow.
>=20
> If it shouldn't be unlinked that's one thing, there's still the
> possibility of also linking it from another keyring (I don't see why
> that should be a problem at least).
>=20
> Also, to be clear I was talking about the `KEY_SPEC_USER_KEYRING`
> keyring. Keeping it in the `gss_auth`'s keyring makes 100% sense (though
> if there's no way to keep it there, that seems like a corner case that
> would need considered).

We definitely allow unlinking - that's sort of the whole point because
it allows users to establish a new GSS credential (most likely with a
different initiator principal that the old one).

It doesn't really make sense for the key to be on any other keyring besides
the user keyring.  If it were on the session keyring, and if you were
logged into multiple sessions, then those sessions would be constantly
whacking each others GSS creds and they be constantly
creating/destroying new GSS creds with the NFS server.

Having them on the session keyring also presents another problem because
the NFS client caches NFSv4 open owners, which take a reference on a
struct cred.  When you log out, pam_keyinit revokes the session keying.
If you log back in and try to resume NFS access (generating a new key),
the current request key code will find the cred with the revoked session
keyring, and it will try to link the new key to that revoked session
keyring, which will then fail with -EKEYREVOKED.  That's the reason
for patches 3/5 and 4/5, to allow request_key_with_auxdata() to link the
key directly to the user keyring.

-Scott
>=20
> Thanks,
>=20
> --Ben
>=20

